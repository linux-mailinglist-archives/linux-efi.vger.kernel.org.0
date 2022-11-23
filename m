Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144F6369A9
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 20:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiKWTMx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 14:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbiKWTMt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 14:12:49 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260909FCE
        for <linux-efi@vger.kernel.org>; Wed, 23 Nov 2022 11:12:46 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-142b72a728fso14159905fac.9
        for <linux-efi@vger.kernel.org>; Wed, 23 Nov 2022 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYNUdKeKDvT8mT9/ZHcNVoishfiUIhq0BFNbiLz19yA=;
        b=GkcQ4aDShxTS/4JJ20x52W1asLWeep8pqcGzmv6Dc8t7/RytG/dgK1GAiBGHIoG7Jx
         tczb1a1x73VjicRSW1kWfAi31UZ5tUgBU0ZUXf248ak/5xaTu+LFg6f8dW57NDqJBuJh
         1wIhteLDo9cI+ZCcHbud0ARTw2Hdq39z3Dw1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYNUdKeKDvT8mT9/ZHcNVoishfiUIhq0BFNbiLz19yA=;
        b=jm1cfujqOUnKTyjULJTiWtwNbe4G/Nm+fkEONOUP+JpVpg+WkLpgph942mlM0wGrJW
         xU+bhsIoMmULmeUhxTdz58z7g331+AW/uO/r2z/V42Mm0bZxSQNjr2tsQHgVcihDd1Xs
         URQxY7+F64GRWdmYM3ij9s9m2+nvsYu7PcwJ3IThvW5NuzLB/XBxfC1IICmYsMkn5Lzt
         f9IMdXeEClf/+ey5dnvZvcs+HsGkShyoRy5Cz0IuxpbstJQWuCJsnHg04tRiPoBeXDwP
         QZddE4ZnPnX+yrNjQS3RLqSy7C3Blzq7aUiCrOrP1GCmHzBNHGjNP6CnLPYWkzLFH48r
         QYEg==
X-Gm-Message-State: ANoB5plr+B+ZwVVLsBA4f4epwoBTKjzMDg6CLIH0FOXTYoZy/KIqC56S
        bLD7L+ySPAZQwcAm/iAES3IASUa4ct6xncWOeJc9
X-Google-Smtp-Source: AA0mqf6d8vQn5ev/ye6UXLq4CqtVLPskx6ulLg13YkrxhwLoJns2WzFhIK+fFbFPYH268AZACOKu9GGMmCXIwqcrxa4=
X-Received: by 2002:a05:6870:60a4:b0:132:79b1:f85 with SMTP id
 t36-20020a05687060a400b0013279b10f85mr8030534oae.274.1669230765966; Wed, 23
 Nov 2022 11:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20221121133303.1782246-1-alexghiti@rivosinc.com> <CAJM55Z8+QyYKEwnMia2wjg+uYYnB=J40oSU8yDxoKm8Se+TnVA@mail.gmail.com>
In-Reply-To: <CAJM55Z8+QyYKEwnMia2wjg+uYYnB=J40oSU8yDxoKm8Se+TnVA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 23 Nov 2022 11:12:35 -0800
Message-ID: <CAOnJCUKd+aUDc8a8xQO6sxViWwEp6-fDhJqAjt+ZfsipPFSJ0g@mail.gmail.com>
Subject: Re: [PATCH] riscv: Sync efi page table's kernel mappings before switching
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 23, 2022 at 9:19 AM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Hi Alexandre,
>
> On Mon, 21 Nov 2022 at 14:33, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > The EFI page table is initially created as a copy of the kernel page table.
> > With VMAP_STACK enabled, kernel stacks are allocated in the vmalloc area:
> > if the stack is allocated in a new PGD (one that was not present at the
> > moment of the efi page table creation or not synced in a previous vmalloc
> > fault), the kernel will take a trap when switching to the efi page table
> > when the vmalloc kernel stack is accessed, resulting in a kernel panic.
> >
> > Fix that by updating the efi kernel mappings before switching to the efi
> > page table.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks for the patch! With this applied on the Ubuntu 5.19 kernel I
> can enable CONFIG_VMAP_STACK and cat /sys/firmware/efi/efivars/* on
> the Unmatched without locking up. So
>
> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> > ---
> >  arch/riscv/include/asm/efi.h     |  6 +++++-
> >  arch/riscv/include/asm/pgalloc.h | 11 ++++++++---
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> > index f74879a8f1ea..e229d7be4b66 100644
> > --- a/arch/riscv/include/asm/efi.h
> > +++ b/arch/riscv/include/asm/efi.h
> > @@ -10,6 +10,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/ptrace.h>
> >  #include <asm/tlbflush.h>
> > +#include <asm/pgalloc.h>
> >
> >  #ifdef CONFIG_EFI
> >  extern void efi_init(void);
> > @@ -20,7 +21,10 @@ extern void efi_init(void);
> >  int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
> >  int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
> >
> > -#define arch_efi_call_virt_setup()      efi_virtmap_load()
> > +#define arch_efi_call_virt_setup()      ({             \
> > +               sync_kernel_mappings(efi_mm.pgd);       \
> > +               efi_virtmap_load();                     \
> > +       })
> >  #define arch_efi_call_virt_teardown()   efi_virtmap_unload()
> >
> >  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
> > diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> > index 947f23d7b6af..59dc12b5b7e8 100644
> > --- a/arch/riscv/include/asm/pgalloc.h
> > +++ b/arch/riscv/include/asm/pgalloc.h
> > @@ -127,6 +127,13 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
> >  #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
> >  #endif /* __PAGETABLE_PMD_FOLDED */
> >
> > +static inline void sync_kernel_mappings(pgd_t *pgd)
> > +{
> > +       memcpy(pgd + USER_PTRS_PER_PGD,
> > +              init_mm.pgd + USER_PTRS_PER_PGD,
> > +              (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> > +}
> > +
> >  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> >  {
> >         pgd_t *pgd;
> > @@ -135,9 +142,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> >         if (likely(pgd != NULL)) {
> >                 memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
> >                 /* Copy kernel mappings */
> > -               memcpy(pgd + USER_PTRS_PER_PGD,
> > -                       init_mm.pgd + USER_PTRS_PER_PGD,
> > -                       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> > +               sync_kernel_mappings(pgd);
> >         }
> >         return pgd;
> >  }
> > --
> > 2.37.2
> >

Thanks for the fix. With the correct Fixes tag in commit description:A

Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
