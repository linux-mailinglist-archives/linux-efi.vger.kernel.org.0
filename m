Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC142205DD
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jul 2020 09:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgGOHIs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jul 2020 03:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgGOHIr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Jul 2020 03:08:47 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A0D20663
        for <linux-efi@vger.kernel.org>; Wed, 15 Jul 2020 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594796926;
        bh=o38AHONRvbSZa/7vyWi8nGWKAAstX2kcCW0/oYxo7vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xkQqfQDKPRapjh+LeXKfsWfv44dY7cQ0eoHdxiqQhipc10JwtuQb2EsXipECiIa51
         WZdmWU4OTOtpE2cGu8heby2G3riC17YPQp1p5lSLCJVwgtqVZVcjKgDGspNOLZPZHW
         g0/fEA47kkR5Dr0ZaJ7LaxJ4rAWLKQt5NmRGkmyo=
Received: by mail-ot1-f45.google.com with SMTP id 95so687470otw.10
        for <linux-efi@vger.kernel.org>; Wed, 15 Jul 2020 00:08:46 -0700 (PDT)
X-Gm-Message-State: AOAM533ASAVJNnKaN5JEbS5qkZJ/tn7K0qnt8WzJ3O/b35Wtizfg7MZc
        DsMpHdnX9LjJjGXrFLiJtAyavdjOTxfVNDVrZqs=
X-Google-Smtp-Source: ABdhPJzEWmz/ajlWxXsvTJuPoRAwJDQ1Yl2dafhNgIyRsn0VBymMc/9p7ljJyNqVglnLBWgvIM2E4fHNooczHrv/Mp8=
X-Received: by 2002:a9d:7553:: with SMTP id b19mr8009227otl.77.1594796926087;
 Wed, 15 Jul 2020 00:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200623165936.1545211-1-ardb@kernel.org> <20200624060538.GA2935909@linux.ibm.com>
In-Reply-To: <20200624060538.GA2935909@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jul 2020 10:08:35 +0300
X-Gmail-Original-Message-ID: <CAMj1kXG-Ku7LdHJpCvgO9DSM11kpbTpLWExJOswCvpbpMa294Q@mail.gmail.com>
Message-ID: <CAMj1kXG-Ku7LdHJpCvgO9DSM11kpbTpLWExJOswCvpbpMa294Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmu: fix crash in EFI calls due to p4d typo in create_mapping_late()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 24 Jun 2020 at 09:05, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Jun 23, 2020 at 06:59:36PM +0200, Ard Biesheuvel wrote:
> > Commit
> >
> >   84e6ffb2c49c7901 ("arm: add support for folded p4d page tables")
> >
> > updated create_mapping_late() to take folded P4Ds into account when
> > creating mappings, but inverted the p4d_alloc() failure test, resulting
> > in no mapping to be created at all.
> >
> > When the EFI rtc driver subsequently tries to invoke the EFI GetTime()
> > service, the memory regions covering the EFI data structures are missing
> > from the page tables, resulting in a crash like
> >
> >   Unable to handle kernel paging request at virtual address 5ae0cf28
> >   pgd = (ptrval)
> >   [5ae0cf28] *pgd=80000040205003, *pmd=00000000
> >   Internal error: Oops: 207 [#1] SMP THUMB2
> >   Modules linked in:
> >   CPU: 0 PID: 7 Comm: kworker/u32:0 Not tainted 5.7.0+ #92
> >   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> >   Workqueue: efi_rts_wq efi_call_rts
> >   PC is at efi_call_rts+0x94/0x294
> >   LR is at efi_call_rts+0x83/0x294
> >   pc : [<c0b4f098>]    lr : [<c0b4f087>]    psr: 30000033
> >   sp : e6219ef0  ip : 00000000  fp : ffffe000
> >   r10: 00000000  r9 : 00000000  r8 : 30000013
> >   r7 : e6201dd0  r6 : e6201ddc  r5 : 00000000  r4 : c181f264
> >   r3 : 5ae0cf10  r2 : 00000001  r1 : e6201dd0  r0 : e6201ddc
> >   Flags: nzCV  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> >   Control: 70c5383d  Table: 661cc840  DAC: 00000001
> >   Process kworker/u32:0 (pid: 7, stack limit = 0x(ptrval))
> >   ...
> >   [<c0b4f098>] (efi_call_rts) from [<c0448219>] (process_one_work+0x16d/0x3d8)
> >   [<c0448219>] (process_one_work) from [<c0448581>] (worker_thread+0xfd/0x408)
> >   [<c0448581>] (worker_thread) from [<c044ca7b>] (kthread+0x103/0x104)
> >   ...
> >
> > Fixes: 84e6ffb2c49c7901 ("arm: add support for folded p4d page tables")
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm/mm/mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 628028bfbb92..bcd82614c25d 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -966,7 +966,7 @@ void __init create_mapping_late(struct mm_struct *mm, struct map_desc *md,
> >       pud_t *pud;
> >
> >       p4d = p4d_alloc(mm, pgd_offset(mm, md->virtual), md->virtual);
> > -     if (!WARN_ON(!p4d))
> > +     if (WARN_ON(!p4d))
>
> It must have been cosmic radiation :)
>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
>

Russell,

I have put this patch into the patch system on the 24th of June, and
it fixes a guaranteed boot crash on LPAE kernels booting via EFI.
Could you please merge it as a fix?


> >               return;
> >       pud = pud_alloc(mm, p4d, md->virtual);
> >       if (WARN_ON(!pud))
> > --
> > 2.27.0
> >
>
> --
> Sincerely yours,
> Mike.
