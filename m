Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABB5F83DB
	for <lists+linux-efi@lfdr.de>; Sat,  8 Oct 2022 08:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJHGhh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Oct 2022 02:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJHGhg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Oct 2022 02:37:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C786F8D;
        Fri,  7 Oct 2022 23:37:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MkwQd0X1gzkXvX;
        Sat,  8 Oct 2022 14:35:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 14:37:32 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 14:37:32 +0800
Message-ID: <28b5713f-6379-ef36-5139-6c3f0cbf27e8@huawei.com>
Date:   Sat, 8 Oct 2022 14:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] efi/arm: dump UEFI runtime page tables for ARM
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220930101024.118394-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220930101024.118394-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sorry, forget to Cc Ard and efi maillist, do it now.

On 2022/9/30 18:10, Kefeng Wang wrote:
> UEFI runtime page tables dump only for ARM64 at present,
> but ARM support EFI and ARM_PTDUMP_DEBUGFS now. Since
> ARM could potentially execute with a 1G/3G user/kernel
> split, choosing 1G as the upper limit for UEFI runtime
> end, with this, we could enable UEFI runtime page tables.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: update upper limit for ARM, only build test due to
>      my qemu without UEFI boot support.
>   arch/arm/include/asm/ptdump.h      | 1 +
>   arch/arm64/include/asm/ptdump.h    | 1 +
>   drivers/firmware/efi/arm-runtime.c | 4 ++--
>   3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
> index 0c2d3d0d4cc6..aad1d034136c 100644
> --- a/arch/arm/include/asm/ptdump.h
> +++ b/arch/arm/include/asm/ptdump.h
> @@ -21,6 +21,7 @@ struct ptdump_info {
>   
>   void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
>   #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
> +#define EFI_RUNTIME_MAP_END	SZ_1G
>   void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>   #else
>   static inline void ptdump_debugfs_register(struct ptdump_info *info,
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index b1dd7ecff7ef..581caac525b0 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -23,6 +23,7 @@ struct ptdump_info {
>   
>   void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
>   #ifdef CONFIG_PTDUMP_DEBUGFS
> +#define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
>   void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>   #else
>   static inline void ptdump_debugfs_register(struct ptdump_info *info,
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 3359ae2adf24..8f8ae479061b 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -25,14 +25,14 @@
>   #include <asm/mmu.h>
>   #include <asm/pgalloc.h>
>   
> -#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
> +#if defined(CONFIG_PTDUMP_DEBUGFS) || defined(CONFIG_ARM_PTDUMP_DEBUGFS)
>   #include <asm/ptdump.h>
>   
>   static struct ptdump_info efi_ptdump_info = {
>   	.mm		= &efi_mm,
>   	.markers	= (struct addr_marker[]){
>   		{ 0,				"UEFI runtime start" },
> -		{ DEFAULT_MAP_WINDOW_64,	"UEFI runtime end" },
> +		{ EFI_RUNTIME_MAP_END,		"UEFI runtime end" },
>   		{ -1,				NULL }
>   	},
>   	.base_addr	= 0,
