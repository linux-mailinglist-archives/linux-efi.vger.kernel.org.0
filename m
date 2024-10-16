Return-Path: <linux-efi+bounces-1977-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1499A0400
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 10:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939D1B25F0D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FE1D2793;
	Wed, 16 Oct 2024 08:17:25 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3391D0F6B;
	Wed, 16 Oct 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066645; cv=none; b=a+zuX0HjUfPKuldftzqcUk3nykri+cL98DsBw2QUBXgkM/BP6Mtcaium6I+liwHLWSMjPDLzbwUzfrsb8em5URuRMeQGVMNxTU0jja4yAtdNF2BnzRVdDpeRRKbaWFx4IB9gUSNzKJLvfa8PkRKFTlJ9ILymUgO7kO9qfh0WVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066645; c=relaxed/simple;
	bh=gCFeMuaZEaSzbn+r82vEe9C9uyPMyumM7btn/b9ZhKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ7naWLx6FDlY0n95lcx1OKpVcXbxq3P6KmZC81+0293OjW/rbcP/AKu4pUI+VSFeImygIz3lGevuIiT+fnrJhgytQrLb8OIi1yRCGtwnooq/BtwGQKU7sPFZMe6/rSa4c6BryYn3+0wtz5/eagT24EpYRi9/1ffYcW1UpQIKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79647FEC;
	Wed, 16 Oct 2024 01:17:51 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72AAA3F71E;
	Wed, 16 Oct 2024 01:17:18 -0700 (PDT)
Message-ID: <3dbb68bb-2aa6-477c-a903-188a26596fb1@arm.com>
Date: Wed, 16 Oct 2024 09:17:16 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Content-Language: en-GB
To: Michael Kelley <mhklinux@outlook.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Oliver Upton <oliver.upton@linux.dev>,
 Will Deacon <will@kernel.org>
Cc: "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-57-ryan.roberts@arm.com>
 <SN6PR02MB415789255D94336BCC9B1E0AD4452@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <SN6PR02MB415789255D94336BCC9B1E0AD4452@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 18:52, Michael Kelley wrote:
> From: Ryan Roberts <ryan.roberts@arm.com> Sent: Monday, October 14, 2024 3:59 AM
>>
>> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
>> selected instead of a page size. When selected, the resulting kernel's
>> page size can be configured at boot via the command line.
>>
>> For now, boot-time page size kernels are limited to 48-bit VA, since
>> more work is required to support LPA2. Additionally MMAP_RND_BITS and
>> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
>> work could be implemented to be able to configure these at boot time for
>> optimial page size-specific values.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  arch/arm64/Kconfig                         | 26 ++++++++++---
>>  arch/arm64/include/asm/kvm_hyp.h           | 11 ++++++
>>  arch/arm64/include/asm/pgtable-geometry.h  | 22 ++++++++++-
>>  arch/arm64/include/asm/pgtable-hwdef.h     |  6 +--
>>  arch/arm64/include/asm/pgtable.h           | 10 ++++-
>>  arch/arm64/include/asm/sparsemem.h         |  4 ++
>>  arch/arm64/kernel/image-vars.h             | 11 ++++++
>>  arch/arm64/kernel/image.h                  |  4 ++
>>  arch/arm64/kernel/pi/map_kernel.c          | 45 ++++++++++++++++++++++
>>  arch/arm64/kvm/arm.c                       | 10 +++++
>>  arch/arm64/kvm/hyp/nvhe/Makefile           |  1 +
>>  arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c | 16 ++++++++
>>  arch/arm64/mm/Makefile                     |  1 +
>>  arch/arm64/mm/pgd.c                        | 10 +++--
>>  arch/arm64/mm/pgtable-geometry.c           | 24 ++++++++++++
>>  drivers/firmware/efi/libstub/arm64.c       |  3 +-
>>  16 files changed, 187 insertions(+), 17 deletions(-)
>>  create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>>  create mode 100644 arch/arm64/mm/pgtable-geometry.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a2f8ff354ca67..573d308741169 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -121,6 +121,7 @@ config ARM64
>>  	select BUILDTIME_TABLE_SORT
>>  	select CLONE_BACKWARDS
>>  	select COMMON_CLK
>> +	select CONSTRUCTORS if ARM64_BOOT_TIME_PAGE_SIZE
>>  	select CPU_PM if (SUSPEND || CPU_IDLE)
>>  	select CPUMASK_OFFSTACK if NR_CPUS > 256
>>  	select CRC32
>> @@ -284,18 +285,20 @@ config MMU
>>
>>  config ARM64_CONT_PTE_SHIFT
>>  	int
>> +	depends on !ARM64_BOOT_TIME_PAGE_SIZE
>>  	default 5 if PAGE_SIZE_64KB
>>  	default 7 if PAGE_SIZE_16KB
>>  	default 4
>>
>>  config ARM64_CONT_PMD_SHIFT
>>  	int
>> +	depends on !ARM64_BOOT_TIME_PAGE_SIZE
>>  	default 5 if PAGE_SIZE_64KB
>>  	default 5 if PAGE_SIZE_16KB
>>  	default 4
>>
>>  config ARCH_MMAP_RND_BITS_MIN
>> -	default 14 if PAGE_SIZE_64KB
>> +	default 14 if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>  	default 16 if PAGE_SIZE_16KB
>>  	default 18
>>
>> @@ -306,15 +309,15 @@ config ARCH_MMAP_RND_BITS_MAX
>>  	default 24 if ARM64_VA_BITS=39
>>  	default 27 if ARM64_VA_BITS=42
>>  	default 30 if ARM64_VA_BITS=47
>> -	default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
>> +	default 29 if ARM64_VA_BITS=48 && (ARM64_64K_PAGES ||
>> ARM64_BOOT_TIME_PAGE_SIZE)
>>  	default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
>>  	default 33 if ARM64_VA_BITS=48
>> -	default 14 if ARM64_64K_PAGES
>> +	default 14 if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>  	default 16 if ARM64_16K_PAGES
>>  	default 18
>>
>>  config ARCH_MMAP_RND_COMPAT_BITS_MIN
>> -	default 7 if ARM64_64K_PAGES
>> +	default 7 if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>  	default 9 if ARM64_16K_PAGES
>>  	default 11
>>
>> @@ -362,6 +365,7 @@ config FIX_EARLYCON_MEM
>>
>>  config PGTABLE_LEVELS
>>  	int
>> +	default 4 if ARM64_BOOT_TIME_PAGE_SIZE # Advertise max supported levels
>>  	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
>>  	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
>>  	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 ||
>> ARM64_VA_BITS_52)
>> @@ -1316,6 +1320,14 @@ config ARM64_64K_PAGES
>>  	  look-up. AArch32 emulation requires applications compiled
>>  	  with 64K aligned segments.
>>
>> +config ARM64_BOOT_TIME_PAGE_SIZE
>> +	bool "Boot-time selection"
>> +	select HAVE_PAGE_SIZE_64KB # Advertise largest page size to core
>> +	help
>> +	  Select desired page size (4KB, 16KB or 64KB) at boot-time via the
>> +	  kernel command line option "arm64.pagesize=4k", "arm64.pagesize=16k"
>> +	  or "arm64.pagesize=64k".
>> +
>>  endchoice
>>
>>  choice
>> @@ -1348,6 +1360,7 @@ config ARM64_VA_BITS_48
>>  config ARM64_VA_BITS_52
>>  	bool "52-bit"
>>  	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
>> +	depends on !ARM64_BOOT_TIME_PAGE_SIZE
>>  	help
>>  	  Enable 52-bit virtual addressing for userspace when explicitly
>>  	  requested via a hint to mmap(). The kernel will also use 52-bit
>> @@ -1588,9 +1601,10 @@ config XEN
>>  # 4K  |       27          |      12      |       15             |         10              |
>>  # 16K |       27          |      14      |       13             |         11              |
>>  # 64K |       29          |      16      |       13             |         13              |
>> +# BOOT|       29          |    16 (max)  |       13             |         13              |
>>  config ARCH_FORCE_MAX_ORDER
>>  	int
>> -	default "13" if ARM64_64K_PAGES
>> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>  	default "11" if ARM64_16K_PAGES
>>  	default "10"
>>  	help
>> @@ -1663,7 +1677,7 @@ config ARM64_TAGGED_ADDR_ABI
>>
>>  menuconfig COMPAT
>>  	bool "Kernel support for 32-bit EL0"
>> -	depends on ARM64_4K_PAGES || EXPERT
>> +	depends on ARM64_4K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE || EXPERT
>>  	select HAVE_UID16
>>  	select OLD_SIGSUSPEND3
>>  	select COMPAT_OLD_SIGACTION
>> diff --git a/arch/arm64/include/asm/kvm_hyp.h
>> b/arch/arm64/include/asm/kvm_hyp.h
>> index c838309e4ec47..9397a14642afa 100644
>> --- a/arch/arm64/include/asm/kvm_hyp.h
>> +++ b/arch/arm64/include/asm/kvm_hyp.h
>> @@ -145,4 +145,15 @@ extern unsigned long kvm_nvhe_sym(__icache_flags);
>>  extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
>>  extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
>>
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +extern int kvm_nvhe_sym(ptg_page_shift);
>> +extern int kvm_nvhe_sym(ptg_pmd_shift);
>> +extern int kvm_nvhe_sym(ptg_pud_shift);
>> +extern int kvm_nvhe_sym(ptg_p4d_shift);
>> +extern int kvm_nvhe_sym(ptg_pgdir_shift);
>> +extern int kvm_nvhe_sym(ptg_cont_pte_shift);
>> +extern int kvm_nvhe_sym(ptg_cont_pmd_shift);
>> +extern int kvm_nvhe_sym(ptg_pgtable_levels);
>> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>> +
>>  #endif /* __ARM64_KVM_HYP_H__ */
>> diff --git a/arch/arm64/include/asm/pgtable-geometry.h
>> b/arch/arm64/include/asm/pgtable-geometry.h
>> index 62fe125909c08..18a8c8d499ecc 100644
>> --- a/arch/arm64/include/asm/pgtable-geometry.h
>> +++ b/arch/arm64/include/asm/pgtable-geometry.h
>> @@ -6,16 +6,33 @@
>>  #define ARM64_PAGE_SHIFT_16K	14
>>  #define ARM64_PAGE_SHIFT_64K	16
>>
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +#define PAGE_SHIFT_MIN		ARM64_PAGE_SHIFT_4K
>> +#define PAGE_SHIFT_MAX		ARM64_PAGE_SHIFT_64K
>> +#else /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>>  #define PAGE_SHIFT_MIN		CONFIG_PAGE_SHIFT
>> +#define PAGE_SHIFT_MAX		CONFIG_PAGE_SHIFT
>> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>> +
>>  #define PAGE_SIZE_MIN		(_AC(1, UL) << PAGE_SHIFT_MIN)
>>  #define PAGE_MASK_MIN		(~(PAGE_SIZE_MIN-1))
>> -
>> -#define PAGE_SHIFT_MAX		CONFIG_PAGE_SHIFT
>>  #define PAGE_SIZE_MAX		(_AC(1, UL) << PAGE_SHIFT_MAX)
>>  #define PAGE_MASK_MAX		(~(PAGE_SIZE_MAX-1))
>>
>>  #include <asm-generic/pgtable-geometry.h>
>>
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +#ifndef __ASSEMBLY__
>> +extern int ptg_page_shift;
>> +extern int ptg_pmd_shift;
>> +extern int ptg_pud_shift;
>> +extern int ptg_p4d_shift;
>> +extern int ptg_pgdir_shift;
>> +extern int ptg_cont_pte_shift;
>> +extern int ptg_cont_pmd_shift;
>> +extern int ptg_pgtable_levels;
>> +#endif /* __ASSEMBLY__ */
>> +#else /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>>  #define ptg_page_shift		CONFIG_PAGE_SHIFT
>>  #define ptg_pmd_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
>>  #define ptg_pud_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
>> @@ -24,5 +41,6 @@
>>  #define ptg_cont_pte_shift	(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
>>  #define ptg_cont_pmd_shift	(CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
>>  #define ptg_pgtable_levels	CONFIG_PGTABLE_LEVELS
>> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>>
>>  #endif /* ASM_PGTABLE_GEOMETRY_H */
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h
>> b/arch/arm64/include/asm/pgtable-hwdef.h
>> index ca8bcbc1fe220..da5404617acbf 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -52,7 +52,7 @@
>>  #define PMD_SHIFT		ptg_pmd_shift
>>  #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
>>  #define PMD_MASK		(~(PMD_SIZE-1))
>> -#define PTRS_PER_PMD		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_PMD		(ptg_pgtable_levels > 2 ? (1 << (PAGE_SHIFT -
>> 3)) : 1)
>>  #define MAX_PTRS_PER_PMD	(1 << (PAGE_SHIFT_MAX - 3))
>>  #endif
>>
>> @@ -63,7 +63,7 @@
>>  #define PUD_SHIFT		ptg_pud_shift
>>  #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
>>  #define PUD_MASK		(~(PUD_SIZE-1))
>> -#define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_PUD		(ptg_pgtable_levels > 3 ? (1 << (PAGE_SHIFT -
>> 3)) : 1)
>>  #define MAX_PTRS_PER_PUD	(1 << (PAGE_SHIFT_MAX - 3))
>>  #endif
>>
>> @@ -71,7 +71,7 @@
>>  #define P4D_SHIFT		ptg_p4d_shift
>>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>>  #define P4D_MASK		(~(P4D_SIZE-1))
>> -#define PTRS_PER_P4D		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_P4D		(ptg_pgtable_levels > 4 ? (1 << (PAGE_SHIFT -
>> 3)) : 1)
>>  #define MAX_PTRS_PER_P4D	(1 << (PAGE_SHIFT_MAX - 3))
>>  #endif
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 8ead41da715b0..ad9f75f5cc29a 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -755,7 +755,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>>
>>  static __always_inline bool pgtable_l3_enabled(void)
>>  {
>> -	return true;
>> +	return ptg_pgtable_levels > 2;
>>  }
>>
>>  static inline bool mm_pmd_folded(const struct mm_struct *mm)
>> @@ -888,6 +888,8 @@ static inline bool pgtable_l3_enabled(void) { return false; }
>>
>>  static __always_inline bool pgtable_l4_enabled(void)
>>  {
>> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
>> +		return ptg_pgtable_levels > 3;
>>  	if (CONFIG_PGTABLE_LEVELS > 4 || !IS_ENABLED(CONFIG_ARM64_LPA2))
>>  		return true;
>>  	if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>> @@ -935,6 +937,8 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
>>
>>  static inline pud_t *p4d_to_folded_pud(p4d_t *p4dp, unsigned long addr)
>>  {
>> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
>> +		return (pud_t *)p4dp;
>>  	return (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
>>  }
>>
>> @@ -1014,6 +1018,8 @@ static inline bool pgtable_l4_enabled(void) { return false; }
>>
>>  static __always_inline bool pgtable_l5_enabled(void)
>>  {
>> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
>> +		return ptg_pgtable_levels > 4;
>>  	if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>>  		return vabits_actual == VA_BITS;
>>  	return alternative_has_cap_unlikely(ARM64_HAS_VA52);
>> @@ -1059,6 +1065,8 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>>
>>  static inline p4d_t *pgd_to_folded_p4d(pgd_t *pgdp, unsigned long addr)
>>  {
>> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
>> +		return (p4d_t *)pgdp;
>>  	return (p4d_t *)PTR_ALIGN_DOWN(pgdp, PAGE_SIZE) + p4d_index(addr);
>>  }
>>
>> diff --git a/arch/arm64/include/asm/sparsemem.h
>> b/arch/arm64/include/asm/sparsemem.h
>> index a05fdd54014f7..2daf1263ba638 100644
>> --- a/arch/arm64/include/asm/sparsemem.h
>> +++ b/arch/arm64/include/asm/sparsemem.h
>> @@ -17,6 +17,10 @@
>>   * entries could not be created for vmemmap mappings.
>>   * 16K follows 4K for simplicity.
>>   */
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +#define SECTION_SIZE_BITS	29
>> +#else
>>  #define SECTION_SIZE_BITS	(PAGE_SIZE == SZ_64K ? 29 : 27)
>> +#endif
>>
>>  #endif
>> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
>> index a168f3337446f..9968320f83bc4 100644
>> --- a/arch/arm64/kernel/image-vars.h
>> +++ b/arch/arm64/kernel/image-vars.h
>> @@ -36,6 +36,17 @@ PROVIDE(__pi___memcpy			=
>> __pi_memcpy);
>>  PROVIDE(__pi___memmove			= __pi_memmove);
>>  PROVIDE(__pi___memset			= __pi_memset);
>>
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +PROVIDE(__pi_ptg_page_shift		= ptg_page_shift);
>> +PROVIDE(__pi_ptg_pmd_shift		= ptg_pmd_shift);
>> +PROVIDE(__pi_ptg_pud_shift		= ptg_pud_shift);
>> +PROVIDE(__pi_ptg_p4d_shift		= ptg_p4d_shift);
>> +PROVIDE(__pi_ptg_pgdir_shift		= ptg_pgdir_shift);
>> +PROVIDE(__pi_ptg_cont_pte_shift		= ptg_cont_pte_shift);
>> +PROVIDE(__pi_ptg_cont_pmd_shift		= ptg_cont_pmd_shift);
>> +PROVIDE(__pi_ptg_pgtable_levels		= ptg_pgtable_levels);
>> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>> +
>>  PROVIDE(__pi_id_aa64isar1_override	= id_aa64isar1_override);
>>  PROVIDE(__pi_id_aa64isar2_override	= id_aa64isar2_override);
>>  PROVIDE(__pi_id_aa64mmfr0_override	= id_aa64mmfr0_override);
>> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
>> index 7bc3ba8979019..01502fc3b891b 100644
>> --- a/arch/arm64/kernel/image.h
>> +++ b/arch/arm64/kernel/image.h
>> @@ -47,7 +47,11 @@
>>  #define __HEAD_FLAG_BE		ARM64_IMAGE_FLAG_LE
>>  #endif
>>
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +#define __HEAD_FLAG_PAGE_SIZE	0
>> +#else
>>  #define __HEAD_FLAG_PAGE_SIZE	((PAGE_SHIFT - 10) / 2)
>> +#endif
>>
>>  #define __HEAD_FLAG_PHYS_BASE	1
>>
>> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
>> index deb8cd50b0b0c..22b3c70e04f9c 100644
>> --- a/arch/arm64/kernel/pi/map_kernel.c
>> +++ b/arch/arm64/kernel/pi/map_kernel.c
>> @@ -221,6 +221,49 @@ static void __init map_fdt(u64 fdt, int page_shift)
>>  	dsb(ishst);
>>  }
>>
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +static void __init ptg_init(int page_shift)
>> +{
>> +	ptg_pgtable_levels =
>> +		__ARM64_HW_PGTABLE_LEVELS(page_shift,
>> CONFIG_ARM64_VA_BITS);
>> +
>> +	ptg_pgdir_shift = __ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift,
>> +				4 - ptg_pgtable_levels);
>> +
>> +	ptg_p4d_shift = ptg_pgtable_levels >= 5 ?
>> +				__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, 0) :
>> +				ptg_pgdir_shift;
>> +
>> +	ptg_pud_shift = ptg_pgtable_levels >= 4 ?
>> +				__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, 1) :
>> +				ptg_pgdir_shift;
>> +
>> +	ptg_pmd_shift = ptg_pgtable_levels >= 3 ?
>> +				__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, 2) :
>> +				ptg_pgdir_shift;
>> +
>> +	ptg_page_shift = page_shift;
>> +
>> +	switch (page_shift) {
>> +	case ARM64_PAGE_SHIFT_64K:
>> +		ptg_cont_pte_shift = ptg_page_shift + 5;
>> +		ptg_cont_pmd_shift = ptg_pmd_shift + 5;
>> +		break;
>> +	case ARM64_PAGE_SHIFT_16K:
>> +		ptg_cont_pte_shift = ptg_page_shift + 7;
>> +		ptg_cont_pmd_shift = ptg_pmd_shift + 5;
>> +		break;
>> +	default: /* ARM64_PAGE_SHIFT_4K */
>> +		ptg_cont_pte_shift = ptg_page_shift + 4;
>> +		ptg_cont_pmd_shift = ptg_pmd_shift + 4;
>> +	}
>> +}
>> +#else /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>> +static inline void ptg_init(int page_shift)
>> +{
>> +}
>> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>> +
>>  asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
>>  {
>>  	static char const chosen_str[] __initconst = "/chosen";
>> @@ -247,6 +290,8 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void
>> *fdt)
>>  	if (!page_shift)
>>  		page_shift = early_page_shift;
>>
>> +	ptg_init(page_shift);
>> +
>>  	if (va_bits > 48) {
>>  		u64 page_size = early_page_size(page_shift);
>>
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 9bef7638342ef..c835a50b8b768 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -2424,6 +2424,16 @@ static void kvm_hyp_init_symbols(void)
>>  	kvm_nvhe_sym(id_aa64smfr0_el1_sys_val) =
>> read_sanitised_ftr_reg(SYS_ID_AA64SMFR0_EL1);
>>  	kvm_nvhe_sym(__icache_flags) = __icache_flags;
>>  	kvm_nvhe_sym(kvm_arm_vmid_bits) = kvm_arm_vmid_bits;
>> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> +	kvm_nvhe_sym(ptg_page_shift) = ptg_page_shift;
>> +	kvm_nvhe_sym(ptg_pmd_shift) = ptg_pmd_shift;
>> +	kvm_nvhe_sym(ptg_pud_shift) = ptg_pud_shift;
>> +	kvm_nvhe_sym(ptg_p4d_shift) = ptg_p4d_shift;
>> +	kvm_nvhe_sym(ptg_pgdir_shift) = ptg_pgdir_shift;
>> +	kvm_nvhe_sym(ptg_cont_pte_shift) = ptg_cont_pte_shift;
>> +	kvm_nvhe_sym(ptg_cont_pmd_shift) = ptg_cont_pmd_shift;
>> +	kvm_nvhe_sym(ptg_pgtable_levels) = ptg_pgtable_levels;
>> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>>  }
>>
>>  static int __init kvm_hyp_init_protection(u32 hyp_va_bits)
>> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile
>> b/arch/arm64/kvm/hyp/nvhe/Makefile
>> index b43426a493df5..a8fcbb84c7996 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
>> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
>> @@ -27,6 +27,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-
>> init.o host.o
>>  	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
>>  hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>>  	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
>> +hyp-obj-$(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) += pgtable-geometry.o
>>  hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
>>  hyp-obj-y += $(lib-objs)
>>
>> diff --git a/arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>> b/arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>> new file mode 100644
>> index 0000000000000..17f807450a31a
>> --- /dev/null
>> +++ b/arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2024 ARM Ltd.
>> + */
>> +
>> +#include <linux/cache.h>
>> +#include <asm/pgtable-geometry.h>
>> +
>> +int ptg_page_shift __ro_after_init;
>> +int ptg_pmd_shift __ro_after_init;
>> +int ptg_pud_shift __ro_after_init;
>> +int ptg_p4d_shift __ro_after_init;
>> +int ptg_pgdir_shift __ro_after_init;
>> +int ptg_cont_pte_shift __ro_after_init;
>> +int ptg_cont_pmd_shift __ro_after_init;
>> +int ptg_pgtable_levels __ro_after_init;
>> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
>> index 60454256945b8..2ba30d06b35fe 100644
>> --- a/arch/arm64/mm/Makefile
>> +++ b/arch/arm64/mm/Makefile
>> @@ -3,6 +3,7 @@ obj-y				:= dma-mapping.o extable.o
>> fault.o init.o \
>>  				   cache.o copypage.o flush.o \
>>  				   ioremap.o mmap.o pgd.o mmu.o \
>>  				   context.o proc.o pageattr.o fixmap.o
>> +obj-$(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) += pgtable-geometry.o
>>  obj-$(CONFIG_ARM64_CONTPTE)	+= contpte.o
>>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>>  obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
>> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
>> index 4b106510358b1..c052d0dcb0c69 100644
>> --- a/arch/arm64/mm/pgd.c
>> +++ b/arch/arm64/mm/pgd.c
>> @@ -21,10 +21,12 @@ static bool pgdir_is_page_size(void)
>>  {
>>  	if (PGD_SIZE == PAGE_SIZE)
>>  		return true;
>> -	if (CONFIG_PGTABLE_LEVELS == 4)
>> -		return !pgtable_l4_enabled();
>> -	if (CONFIG_PGTABLE_LEVELS == 5)
>> -		return !pgtable_l5_enabled();
>> +	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE)) {
>> +		if (CONFIG_PGTABLE_LEVELS == 4)
>> +			return !pgtable_l4_enabled();
>> +		if (CONFIG_PGTABLE_LEVELS == 5)
>> +			return !pgtable_l5_enabled();
>> +	}
>>  	return false;
>>  }
>>
>> diff --git a/arch/arm64/mm/pgtable-geometry.c b/arch/arm64/mm/pgtable-
>> geometry.c
>> new file mode 100644
>> index 0000000000000..ba50637f1e9d0
>> --- /dev/null
>> +++ b/arch/arm64/mm/pgtable-geometry.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2024 ARM Ltd.
>> + */
>> +
>> +#include <linux/cache.h>
>> +#include <asm/pgtable-geometry.h>
>> +
>> +/*
>> + * TODO: These should be __ro_after_init, but we need to write to them from the
>> + * pi code where they are mapped in the early page table as read-only.
>> + * __ro_after_init doesn't become writable until later when the swapper pgtable
>> + * is fully set up. We should update the early page table to map __ro_after_init
>> + * as read-write.
>> + */
>> +
>> +int ptg_page_shift __read_mostly;
>> +int ptg_pmd_shift __read_mostly;
> 
> I found that ptg_page_shift and ptg_pmd_shift need
> EXPORT_SYMBOL_GPL for cases where code compiled
> as a module is using PAGE_SIZE/PAGE_SHIFT or
> PMD_SIZE/PMD_SHIFT. Some of the others below
> might also need EXPORT_SYMBOL_GPL.

Ahh good spot - thanks! I'll fix this in the next version.

I wonder if these should really be EXPORT_SYMBOL() and not limited to GPL? I
guess having access to PAGE_SIZE is a pretty fundamental thing? Anybody know the
policy here?

Thanks,
Ryan

> 
> Michael
> 
>> +int ptg_pud_shift __read_mostly;
>> +int ptg_p4d_shift __read_mostly;
>> +int ptg_pgdir_shift __read_mostly;
>> +int ptg_cont_pte_shift __read_mostly;
>> +int ptg_cont_pmd_shift __read_mostly;
>> +int ptg_pgtable_levels __read_mostly;
>> diff --git a/drivers/firmware/efi/libstub/arm64.c
>> b/drivers/firmware/efi/libstub/arm64.c
>> index e57cd3de0a00f..8db9dba7d5423 100644
>> --- a/drivers/firmware/efi/libstub/arm64.c
>> +++ b/drivers/firmware/efi/libstub/arm64.c
>> @@ -68,7 +68,8 @@ efi_status_t check_platform_features(void)
>>  		efi_novamap = true;
>>
>>  	/* UEFI mandates support for 4 KB granularity, no need to check */
>> -	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>> +	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
>> +	    IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
>>  		return EFI_SUCCESS;
>>
>>  	tg = (read_cpuid(ID_AA64MMFR0_EL1) >>
>> ID_AA64MMFR0_EL1_TGRAN_SHIFT) & 0xf;
>> --
>> 2.43.0
>>
> 


