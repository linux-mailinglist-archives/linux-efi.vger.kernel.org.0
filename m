Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3D606D55
	for <lists+linux-efi@lfdr.de>; Fri, 21 Oct 2022 04:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJUCAz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJUCAv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 22:00:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E90696CA
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 18:59:58 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtndJ5bhkzpVjC;
        Fri, 21 Oct 2022 09:56:36 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:59:56 +0800
CC:     <yangyicong@hisilicon.com>, <linux-efi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <probinson@gmail.com>, <andersson@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] efi/libstub: arm64: avoid SetVirtualAddressMap() when
 possible
To:     Ard Biesheuvel <ardb@kernel.org>
References: <20220916101843.495879-1-ardb@kernel.org>
 <56877644-8173-d2ed-ed00-7973734a3698@huawei.com>
 <9c06c75d-5079-dd27-6533-c053c986083e@leemhuis.info>
 <CAMj1kXG=aE4yn-OvQdzRLE17BS=tGBySZ9DV0pHj9LN8onaerA@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <66232ab0-d097-f7fd-4834-42a29a8f0cd8@huawei.com>
Date:   Fri, 21 Oct 2022 09:59:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXG=aE4yn-OvQdzRLE17BS=tGBySZ9DV0pHj9LN8onaerA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/10/20 21:04, Ard Biesheuvel wrote:
>> On 19.10.22 05:24, Yicong Yang wrote:
>>>
>>> After entering 6.1-rc1 the efi runtime services is not working on my platform:
>>>
>>> [    0.054039] Remapping and enabling EFI services.
>>> [    0.054043] UEFI virtual mapping missing or invalid -- runtime services will not be available
>>>
>>> Not sure this patch is the root cause since I see some refactor of efi codes in 6.1-rc1,
>>> but simply reverting this make EFI runtime services works again. Tested on HiSilicon's
>>> Kunpeng 920 arm64 server using 48 bit VA address:
>>>
>>> CONFIG_ARM64_VA_BITS_48=y
>>> CONFIG_ARM64_VA_BITS=48
>>>
>>> Thanks.
> 
> Hi,
> 
> Can you try the change below please?
> 
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -63,7 +63,7 @@ static bool __init efi_virtmap_init(void)
> 
>                 if (!(md->attribute & EFI_MEMORY_RUNTIME))
>                         continue;
> -               if (md->virt_addr == 0)
> +               if (md->virt_addr == 0 && md->phys_addr != 0)
>                         return false;
> 
>                 ret = efi_create_mapping(&efi_mm, md);
> .
> 

Thanks for fixing this. This change works on my machine. I see you've already post a patch including
this [1]. Tested for both this change and that patch, the efi runtime services works again:

[root@localhost ~]# dmesg | grep -i efi
[...]
[    0.015321] Remapping and enabling EFI services.
[    3.821339] Registered efivars operations
[   16.347372] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 6.1.0-rc1-efi-fix-test+ #18
[   16.674766] rtc-efi rtc-efi.0: registered as rtc0
[   16.687659] rtc-efi rtc-efi.0: setting system clock to 2022-10-21T01:53:35 UTC (1666317215)
[   16.733137] pstore: ignoring unexpected backend 'efi'
[   18.411800]     BOOT_IMAGE=/vmlinuz-6.1.0-rc1-efi-fix-test+

For arm64 part:

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

[1] https://lore.kernel.org/linux-efi/20221020185416.1953242-1-ardb@kernel.org/T/#u

Thanks


