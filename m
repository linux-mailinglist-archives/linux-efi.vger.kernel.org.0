Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D040546243
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 11:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348937AbiFJJ3v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348962AbiFJJ31 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 05:29:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88A2E698;
        Fri, 10 Jun 2022 02:27:35 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKFsH4cZSzRhQJ;
        Fri, 10 Jun 2022 17:24:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:27:33 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:27:32 +0800
Message-ID: <bfa0b919-fbc1-056c-4ed9-e940edfb6125@huawei.com>
Date:   Fri, 10 Jun 2022 17:27:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/6] arm64/mirror: arm64 enabling - find mirrored
 memory ranges
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, <corbet@lwn.net>,
        <will@kernel.org>, <ardb@kernel.org>, <catalin.marinas@arm.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <dvhart@infradead.org>, <andy@infradead.org>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <paulmck@kernel.org>, <keescook@chromium.org>,
        <songmuchun@bytedance.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <swboyd@chromium.org>,
        <wei.liu@kernel.org>, <robin.murphy@arm.com>, <david@redhat.com>,
        <anshuman.khandual@arm.com>, <thunder.leizhen@huawei.com>,
        <gpiccoli@igalia.com>, <chenhuacai@kernel.org>,
        <geert@linux-m68k.org>, <vijayb@linux.microsoft.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-3-mawupeng1@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220607093805.1354256-3-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2022/6/7 17:38, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> introduced mirrored memory support for x86 and this could be used on arm64.
>
> Since we only support this feature on arm64, efi_find_mirror() won't be placed
> into efi_init(), which is used by riscv/arm/arm64, it is added in setup_arch()
> to scan the memory map and mark mirrored memory in memblock.

Move into efi_init() looks better, it won't bring negative effects on 
arm/riscv.

but let's maintainer to make a decision.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>   arch/arm64/kernel/setup.c                       | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 8090130b544b..e3537646b6f7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2301,7 +2301,7 @@
>   
>   	keepinitrd	[HW,ARM]
>   
> -	kernelcore=	[KNL,X86,IA-64,PPC]
> +	kernelcore=	[KNL,X86,IA-64,PPC,ARM64]
>   			Format: nn[KMGTPE] | nn% | "mirror"
>   			This parameter specifies the amount of memory usable by
>   			the kernel for non-movable allocations.  The requested
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index cf3a759f10d4..6e9acd7ecf0f 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -328,6 +328,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>   
>   	xen_early_init();
>   	efi_init();
> +	efi_find_mirror();
>   
>   	if (!efi_enabled(EFI_BOOT) && ((u64)_text % MIN_KIMG_ALIGN) != 0)
>   	     pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
