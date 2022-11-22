Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F7633768
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKVIsI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 03:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiKVIsF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 03:48:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A21A3A3;
        Tue, 22 Nov 2022 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669106881; x=1700642881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6WN6vBmnV9wxc3pONX37n6CbLHY7E8185tWSh1ZT4o=;
  b=qCBZRhtZ5StXbUHBY9E1kiO/38WEjaNlqpv9mkD0RkgWckI261XOvPi4
   TshLoiXzCGtpzaPI0J0dlF8v+une7TuZYeKOEpKA+kPl9Ou8eY1aoqxLT
   Sijj705cYl8aruX5VKKmdySGOTWmkvRO6OWlT1LoRFvblYvZYYIAiwKi1
   8KixL5zWgVx64vJOXEaIx5jI8pTim4GoFjA7IzXjVJkAXsLAJqa1Ez9xt
   NLYIFJRLtipyCz6HV0ESKR0u1Aeyclh10atwRZccLKk89Cnd9xEntoDJ7
   RVKfXIXsxE9tSt7cF9QneUnIG2bgDliS2sOLvl2KaQAiAYKqZr5hiBQXx
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="188107432"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 01:47:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 01:47:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 01:47:52 -0700
Date:   Tue, 22 Nov 2022 08:47:35 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-efi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Sync efi page table's kernel mappings before
 switching
Message-ID: <Y3yMp6R1swSq06WR@wendy>
References: <20221121133303.1782246-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221121133303.1782246-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 21, 2022 at 02:33:03PM +0100, Alexandre Ghiti wrote:
> The EFI page table is initially created as a copy of the kernel page table.
> With VMAP_STACK enabled, kernel stacks are allocated in the vmalloc area:
> if the stack is allocated in a new PGD (one that was not present at the
> moment of the efi page table creation or not synced in a previous vmalloc
> fault), the kernel will take a trap when switching to the efi page table
> when the vmalloc kernel stack is accessed, resulting in a kernel panic.
> 
> Fix that by updating the efi kernel mappings before switching to the efi
> page table.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Hey Alex,
What commit does this fix?

> ---
>  arch/riscv/include/asm/efi.h     |  6 +++++-
>  arch/riscv/include/asm/pgalloc.h | 11 ++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index f74879a8f1ea..e229d7be4b66 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -10,6 +10,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/ptrace.h>
>  #include <asm/tlbflush.h>
> +#include <asm/pgalloc.h>
>  
>  #ifdef CONFIG_EFI
>  extern void efi_init(void);
> @@ -20,7 +21,10 @@ extern void efi_init(void);
>  int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
>  int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>  
> -#define arch_efi_call_virt_setup()      efi_virtmap_load()
> +#define arch_efi_call_virt_setup()      ({		\
> +		sync_kernel_mappings(efi_mm.pgd);	\
> +		efi_virtmap_load();			\
> +	})
>  #define arch_efi_call_virt_teardown()   efi_virtmap_unload()
>  
>  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 947f23d7b6af..59dc12b5b7e8 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -127,6 +127,13 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
>  #endif /* __PAGETABLE_PMD_FOLDED */
>  
> +static inline void sync_kernel_mappings(pgd_t *pgd)
> +{
> +	memcpy(pgd + USER_PTRS_PER_PGD,
> +	       init_mm.pgd + USER_PTRS_PER_PGD,
> +	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +}
> +
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
>  	pgd_t *pgd;
> @@ -135,9 +142,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  	if (likely(pgd != NULL)) {
>  		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
>  		/* Copy kernel mappings */
> -		memcpy(pgd + USER_PTRS_PER_PGD,
> -			init_mm.pgd + USER_PTRS_PER_PGD,
> -			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +		sync_kernel_mappings(pgd);
>  	}
>  	return pgd;
>  }
> -- 
> 2.37.2
> 
