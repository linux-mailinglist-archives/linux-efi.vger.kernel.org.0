Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85445633792
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 09:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKVIzC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 03:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKVIzA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 03:55:00 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E6C27FF4
        for <linux-efi@vger.kernel.org>; Tue, 22 Nov 2022 00:55:00 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id i2so13805649vsc.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Nov 2022 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RrMdEjR9PuoPL1f65E/LRwRLMAkjVdgbOUDXvYazWFU=;
        b=LJUev07An3NNdKCBOFHeCbJiP7pQToVmFdX9LB4Y1C6wc0FAcbAqzHDSAAMsF3URy9
         YhBB3AVtqS0aHcIZnnJBYjIXYONPd3RTYlFBlGuchc0G3nMARFPHTbkYbz8hj3x4xBv9
         nSCWtaLx7n4vqDZz6HM0Lk1iTzqPeogGvuAaH37I4QU61eGbszg2Ocesn17EBXVIDAPT
         DwXXlv/QBwj6dUGYxxT3nqWSRsxH6ThLTQrNPcjjftxCaplJTb3rIcdureubEebwAQDh
         JqlKPC8ZCTC9Q+2joEkLCUGGjNLHfdgnLqjzEdi458BRfpmpDP2e8C8AafnmCbpEvfYq
         G06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrMdEjR9PuoPL1f65E/LRwRLMAkjVdgbOUDXvYazWFU=;
        b=A5nDL4XcfjZPO/nSBJZ+pRsHyudTMeFK9QDRTlVV9T5e49huFOISEaabtihV+YEcnn
         +ptidh0PK0j8lbBszYX+v8BDR1mpXLahbDRzob0fFixV5FHQY5aVrtqnrWUdloQxEyTc
         fa7FoaLcSKr7ToOVK9WP7XXXOxFLENYXZ/MAng0igGFapYcY6UFKq8Xyiz96/jXvg3dE
         x5V9eO3lOV0XItioQEeKGwoG6PD+yXgyT+Nbo3BrsVZlsPaunflKzHGJHE5zaGBZIDDq
         snd3BowZH3XoSvJIVWPKHNakRhg3KNdshtg9sPoORj7+XpqD/3aVW6h6G8y3mCtb7lFR
         hGeg==
X-Gm-Message-State: ANoB5pmO9QrDs41lTUjWugo6g9BT8R+ky+IfOJDl7Jf8aF7hzEFveENw
        nC38L0tpfj0fr5sABgB8JED790Spzjve2wupIO6RJg==
X-Google-Smtp-Source: AA0mqf6hG1QbTutyVtAH0K149RQVtMPeyYn++70pRRD8lY/OdujrS+TCmK2O6oLBwWyJZ5xkVEJn5RhRcYfK1KV5tdU=
X-Received: by 2002:a67:fc83:0:b0:3b0:5e50:44ff with SMTP id
 x3-20020a67fc83000000b003b05e5044ffmr1485975vsp.4.1669107299311; Tue, 22 Nov
 2022 00:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20221121133303.1782246-1-alexghiti@rivosinc.com> <Y3yMp6R1swSq06WR@wendy>
In-Reply-To: <Y3yMp6R1swSq06WR@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 22 Nov 2022 09:54:48 +0100
Message-ID: <CAHVXubgk2zTGNjtcJP_CvopT36T4cX36W1a8NqDT7=8Wh6L=NA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Sync efi page table's kernel mappings before switching
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Conor,

On Tue, Nov 22, 2022 at 9:48 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Mon, Nov 21, 2022 at 02:33:03PM +0100, Alexandre Ghiti wrote:
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
> Hey Alex,
> What commit does this fix?

You're right, I should have added this and +cc Atish:

Fixes: b91540d52a08 ("RISC-V: Add EFI runtime services")

Thanks,

Alex

>
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
> > +#define arch_efi_call_virt_setup()      ({           \
> > +             sync_kernel_mappings(efi_mm.pgd);       \
> > +             efi_virtmap_load();                     \
> > +     })
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
> > +     memcpy(pgd + USER_PTRS_PER_PGD,
> > +            init_mm.pgd + USER_PTRS_PER_PGD,
> > +            (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> > +}
> > +
> >  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> >  {
> >       pgd_t *pgd;
> > @@ -135,9 +142,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> >       if (likely(pgd != NULL)) {
> >               memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
> >               /* Copy kernel mappings */
> > -             memcpy(pgd + USER_PTRS_PER_PGD,
> > -                     init_mm.pgd + USER_PTRS_PER_PGD,
> > -                     (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> > +             sync_kernel_mappings(pgd);
> >       }
> >       return pgd;
> >  }
> > --
> > 2.37.2
> >
