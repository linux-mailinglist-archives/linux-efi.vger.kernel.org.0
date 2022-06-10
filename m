Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC71F5461EE
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiFJJYf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349675AbiFJJYL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 05:24:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F80142A8C;
        Fri, 10 Jun 2022 02:22:32 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKFlS4W3FzRhtr;
        Fri, 10 Jun 2022 17:19:16 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:22:30 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:22:28 +0800
Message-ID: <93222719-fcee-2a78-8822-b49944bf1b8b@huawei.com>
Date:   Fri, 10 Jun 2022 17:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/6] efi: Make efi_find_mirror() public
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
        <geert@linux-m68k.org>, <chenzhou10@huawei.com>,
        <vijayb@linux.microsoft.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-2-mawupeng1@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220607093805.1354256-2-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory
> ranges") introduce the efi_find_mirror function on x86. In order to reuse
> the API we make it public in preparation for arm64 to support mirrord
> memory.
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>   arch/x86/include/asm/efi.h  |  4 ----
>   arch/x86/platform/efi/efi.c | 23 -----------------------
>   drivers/firmware/efi/efi.c  | 23 +++++++++++++++++++++++
>   include/linux/efi.h         |  3 +++
>   4 files changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 71943dce691e..eb90206eae80 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -383,7 +383,6 @@ static inline bool efi_is_64bit(void)
>   extern bool efi_reboot_required(void);
>   extern bool efi_is_table_address(unsigned long phys_addr);
>   
> -extern void efi_find_mirror(void);
>   extern void efi_reserve_boot_services(void);
>   #else
>   static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
> @@ -395,9 +394,6 @@ static inline  bool efi_is_table_address(unsigned long phys_addr)
>   {
>   	return false;
>   }
> -static inline void efi_find_mirror(void)
> -{
> -}
>   static inline void efi_reserve_boot_services(void)
>   {
>   }
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 1591d67e0bcd..6e598bd78eef 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -108,29 +108,6 @@ static int __init setup_add_efi_memmap(char *arg)
>   }
>   early_param("add_efi_memmap", setup_add_efi_memmap);
>   
> -void __init efi_find_mirror(void)
> -{
> -	efi_memory_desc_t *md;
> -	u64 mirror_size = 0, total_size = 0;
> -
> -	if (!efi_enabled(EFI_MEMMAP))
> -		return;
> -
> -	for_each_efi_memory_desc(md) {
> -		unsigned long long start = md->phys_addr;
> -		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> -
> -		total_size += size;
> -		if (md->attribute & EFI_MEMORY_MORE_RELIABLE) {
> -			memblock_mark_mirror(start, size);
> -			mirror_size += size;
> -		}
> -	}
> -	if (mirror_size)
> -		pr_info("Memory: %lldM/%lldM mirrored memory\n",
> -			mirror_size>>20, total_size>>20);
> -}
> -
>   /*
>    * Tell the kernel about the EFI memory map.  This might include
>    * more than the max 128 entries that can fit in the passed in e820
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 860534bcfdac..79c232e07de7 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -446,6 +446,29 @@ static int __init efisubsys_init(void)
>   
>   subsys_initcall(efisubsys_init);
>   
> +void __init efi_find_mirror(void)
> +{
> +	efi_memory_desc_t *md;
> +	u64 mirror_size = 0, total_size = 0;
> +
> +	if (!efi_enabled(EFI_MEMMAP))
> +		return;
> +
> +	for_each_efi_memory_desc(md) {
> +		unsigned long long start = md->phys_addr;
> +		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> +
> +		total_size += size;
> +		if (md->attribute & EFI_MEMORY_MORE_RELIABLE) {
> +			memblock_mark_mirror(start, size);
> +			mirror_size += size;
> +		}
> +	}
> +	if (mirror_size)
> +		pr_info("Memory: %lldM/%lldM mirrored memory\n",
> +			mirror_size>>20, total_size>>20);
> +}
> +
>   /*
>    * Find the efi memory descriptor for a given physical address.  Given a
>    * physical address, determine if it exists within an EFI Memory Map entry,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7d9b0bb47eb3..53f64c14a525 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -872,6 +872,7 @@ static inline bool efi_rt_services_supported(unsigned int mask)
>   {
>   	return (efi.runtime_supported_mask & mask) == mask;
>   }
> +extern void efi_find_mirror(void);
>   #else
>   static inline bool efi_enabled(int feature)
>   {
> @@ -889,6 +890,8 @@ static inline bool efi_rt_services_supported(unsigned int mask)
>   {
>   	return false;
>   }
> +
> +static inline void efi_find_mirror(void) {}
>   #endif
>   
>   extern int efi_status_to_err(efi_status_t status);
