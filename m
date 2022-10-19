Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC810603893
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJSDYI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSDYH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 23:24:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9063609E
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 20:24:05 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MsbYh5JFQz1P786;
        Wed, 19 Oct 2022 11:19:20 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:24:03 +0800
CC:     <yangyicong@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        <mark.rutland@arm.com>, <probinson@gmail.com>,
        <andersson@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] efi/libstub: arm64: avoid SetVirtualAddressMap() when
 possible
To:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>
References: <20220916101843.495879-1-ardb@kernel.org>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <56877644-8173-d2ed-ed00-7973734a3698@huawei.com>
Date:   Wed, 19 Oct 2022 11:24:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220916101843.495879-1-ardb@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

After entering 6.1-rc1 the efi runtime services is not working on my platform:

[    0.054039] Remapping and enabling EFI services.
[    0.054043] UEFI virtual mapping missing or invalid -- runtime services will not be available

Not sure this patch is the root cause since I see some refactor of efi codes in 6.1-rc1,
but simply reverting this make EFI runtime services works again. Tested on HiSilicon's
Kunpeng 920 arm64 server using 48 bit VA address:

CONFIG_ARM64_VA_BITS_48=y
CONFIG_ARM64_VA_BITS=48

Thanks.

On 2022/9/16 18:18, Ard Biesheuvel wrote:
> EFI's SetVirtualAddressMap() runtime service is a horrid hack that we'd
> like to avoid using, if possible. For 64-bit architectures such as
> arm64, the user and kernel mappings are entirely disjoint, and given
> that we use the user region for mapping the UEFI runtime regions when
> running under the OS, we don't rely on SetVirtualAddressMap() in the
> conventional way, i.e., to permit kernel mappings of the OS to coexist
> with kernel region mappings of the firmware regions. This means that, in
> principle, we should be able to avoid SetVirtualAddressMap() altogether,
> and simply use the 1:1 mapping that UEFI uses at boot time. (Note that
> omitting SetVirtualAddressMap() is explicitly permitted by the UEFI
> spec).
> 
> However, there is a corner case on arm64, which, if configured for
> 3-level paging (or 2-level paging when using 64k pages), may not be able
> to cover the entire range of firmware mappings (which might contain both
> memory and MMIO peripheral mappings).
> 
> So let's avoid SetVirtualAddressMap() on arm64, but only if the VA space
> is guaranteed to be of sufficient size.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index cd3bea25c762..4fff6c32899e 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -31,6 +31,15 @@ efi_status_t check_platform_features(void)
>  			efi_err("This 16 KB granular kernel is not supported by your CPU\n");
>  		return EFI_UNSUPPORTED;
>  	}
> +
> +	/*
> +	 * If we have 48 bits of VA space for TTBR0 mappings, we can map the
> +	 * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
> +	 * unnecessary.
> +	 */
> +	if (VA_BITS_MIN >= 48)
> +		efi_novamap = true;
> +
>  	return EFI_SUCCESS;
>  }
>  
> 
