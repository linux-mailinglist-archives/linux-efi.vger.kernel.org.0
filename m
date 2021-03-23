Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B320134670D
	for <lists+linux-efi@lfdr.de>; Tue, 23 Mar 2021 18:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhCWR6P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Mar 2021 13:58:15 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:44196 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhCWR6J (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Mar 2021 13:58:09 -0400
X-Greylist: delayed 70997 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2021 13:58:09 EDT
Received: by sf.home (Postfix, from userid 1000)
        id 160D75A22061; Tue, 23 Mar 2021 17:58:01 +0000 (GMT)
Date:   Tue, 23 Mar 2021 17:58:01 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, linux-ia64@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>
Subject: Re: [PATCH] ia64: fix EFI_DEBUG build
Message-ID: <YFosKXrTwfqBRLjf@sf>
References: <20210322221441.3555003-1-slyfox@gentoo.org>
 <CAMj1kXF5ufbDPLhBboYav0bU3C1tnn1ZrDesPGGnni=+1N8hjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF5ufbDPLhBboYav0bU3C1tnn1ZrDesPGGnni=+1N8hjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 23, 2021 at 09:35:13AM +0100, Ard Biesheuvel wrote:
> On Mon, 22 Mar 2021 at 23:16, Sergei Trofimovich <slyfox@gentoo.org> wrote:
> >
> > When enabled local debugging via `#define EFI_DEBUG 1` noticed
> > build failure:
> >
> >     ia64/kernel/efi.c:564:8: error: 'i' undeclared (first use in this function)
> >       564 |   for (i = 0, p = efi_map_start; p < efi_map_end;
> >           |        ^
> >
> > CC: Ard Biesheuvel <ardb@kernel.org>
> > CC: linux-efi@vger.kernel.org
> > CC: linux-ia64@vger.kernel.org
> > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> 
> What are the other changes for?

The rest are fixes for format string mismatch in %lx / unsigned long long.
Should I resend with updated comment or split it to another commit?

They all are hiding under EFI_DEBUG and are not visible by default.

> > ---
> >  arch/ia64/kernel/efi.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
> > index c5fe21de46a8..31149e41f9be 100644
> > --- a/arch/ia64/kernel/efi.c
> > +++ b/arch/ia64/kernel/efi.c
> > @@ -415,10 +415,10 @@ efi_get_pal_addr (void)
> >                 mask  = ~((1 << IA64_GRANULE_SHIFT) - 1);
> >
> >                 printk(KERN_INFO "CPU %d: mapping PAL code "
> > -                       "[0x%lx-0x%lx) into [0x%lx-0x%lx)\n",
> > -                       smp_processor_id(), md->phys_addr,
> > -                       md->phys_addr + efi_md_size(md),
> > -                       vaddr & mask, (vaddr & mask) + IA64_GRANULE_SIZE);
> > +                       "[0x%llx-0x%llx) into [0x%llx-0x%llx)\n",
> > +                       smp_processor_id(), md->phys_addr,
> > +                       md->phys_addr + efi_md_size(md),
> > +                       vaddr & mask, (vaddr & mask) + IA64_GRANULE_SIZE);
> >  #endif
> >                 return __va(md->phys_addr);
> >         }
> > @@ -560,6 +560,7 @@ efi_init (void)
> >         {
> >                 efi_memory_desc_t *md;
> >                 void *p;
> > +               unsigned int i;
> >
> >                 for (i = 0, p = efi_map_start; p < efi_map_end;
> >                      ++i, p += efi_desc_size)
> > @@ -586,7 +587,7 @@ efi_init (void)
> >                         }
> >
> >                         printk("mem%02d: %s "
> > -                              "range=[0x%016lx-0x%016lx) (%4lu%s)\n",
> > +                              "range=[0x%016llx-0x%016llx) (%4lu%s)\n",
> >                                i, efi_md_typeattr_format(buf, sizeof(buf), md),
> >                                md->phys_addr,
> >                                md->phys_addr + efi_md_size(md), size, unit);
> > --
> > 2.31.0
> >

-- 

  Sergei
