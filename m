Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D621798E8
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 20:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgCDTWt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 14:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbgCDTWt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 14:22:49 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E2124658
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583349768;
        bh=K6IbC9m66srtNpCpNfvPpNHw795EKm+SM6PSXFNj8WI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i4w9yaJNTvVe7/vVFfRjvAicNR9coBRGeOvnAA2okMleX1mkcWOYCx5dq88RP72/P
         ME68tu5GBXvGjy4YgjPssHTeAc0oXeGQ8IFV/X6ur4U/KHXo+saZp4wsChOZAjZFxU
         Ra2qSRbYSqsGc4qw4zJiS/c93Fl1Oycnouektkkk=
Received: by mail-wr1-f43.google.com with SMTP id x7so3914233wrr.0
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 11:22:48 -0800 (PST)
X-Gm-Message-State: ANhLgQ2EqNFp/QXqe3jwkRc6etWs/dSnpZK4bhTOtX8dqboc1gnsl46i
        O3T95KfgApAzHQc7FL40mLOivAjpCpCi9HYTFcXTsg==
X-Google-Smtp-Source: ADFU+vshraEqFOfvTVethdLBrCv1Xc0e8G94b+FblBW5+NtTxR2LmDOZG0ArtmIJr3SJCRB7RLlvGYF5f5sOFLAi2Wc=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr5648007wrq.208.1583349766740;
 Wed, 04 Mar 2020 11:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu> <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan> <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan> <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
 <20200304191053.GA291311@rani.riverdale.lan>
In-Reply-To: <20200304191053.GA291311@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 20:22:36 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu84Bj4tBz=+FhG6cqpYUjc5czaqiNAVDdKgqGoXbnHKbQ@mail.gmail.com>
Message-ID: <CAKv+Gu84Bj4tBz=+FhG6cqpYUjc5czaqiNAVDdKgqGoXbnHKbQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in populate_pud
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 20:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 08:04:04PM +0100, Ard Biesheuvel wrote:
> > On Wed, 4 Mar 2020 at 19:50, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Wed, Mar 04, 2020 at 07:44:50PM +0100, Ard Biesheuvel wrote:
> > > >
> > > > I've tried a couple of different ways, but I can't seem to get my
> > > > memory map organized in the way that will trigger the error.
> > >
> > > What does yours look like? efi_merge_regions doesn't merge everything
> > > that will eventually be mapped the same way, so if there are some
> > > non-conventional memory regions scattered over the address space, it
> > > might be breaking up the mappings to the point where this doesn't
> > > trigger.
> >
> > I have a region
> >
> > [    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |  |  |  |
> >  |   |WB|WT|WC|UC] range=[0x0000000001400000-0x00000000b9855fff]
> > (2948MB)
> >
> > which gets covered correctly
> >
> > [    0.401766] 0x0000000000a00000-0x0000000040000000        1014M
> > RW         PSE         NX pmd
> > [    0.403436] 0x0000000040000000-0x0000000080000000           1G
> > RW         PSE         NX pud
> > [    0.404645] 0x0000000080000000-0x00000000b9800000         920M
> > RW         PSE         NX pmd
> > [    0.405844] 0x00000000b9800000-0x00000000b9a00000           2M
> > RW                     NX pte
> > [    0.407436] 0x00000000b9a00000-0x00000000baa00000          16M
> > ro         PSE         x  pmd
> > [    0.408591] 0x00000000baa00000-0x00000000bbe00000          20M
> > RW         PSE         NX pmd
> > [    0.409751] 0x00000000bbe00000-0x00000000bc000000           2M
> > RW                     NX pte
> > [    0.410821] 0x00000000bc000000-0x00000000be600000          38M
> > RW         PSE         NX pmd
> >
> > However, the fact that you can provide a case where it does fail
> > should be sufficient justification for taking this patch. I was just
> > trying to give more than a regression-tested-by
>
> No, this case is exactly one that should break. But I think you're
> running on a processor model that _does_ support GB pages, as shown by
> the "pud" mapping there for the 1G-2G range.
>
> At least for my version of qemu, -cpu Haswell does not enable the
> pdpe1gb feature. Which cpu did you specify?
>

The wrong one, obviously :-)

With Haswell, I get [before]

[    0.368541] 0x0000000000900000-0x0000000000a00000           1M
RW                     NX pte
[    0.369118] 0x0000000000a00000-0x0000000080000000        2038M
RW         PSE         NX pmd
[    0.369592] 0x0000000080000000-0x00000000b9800000         920M
                         pmd
[    0.370177] 0x00000000b9800000-0x00000000b9856000         344K
                         pte
[    0.370649] 0x00000000b9856000-0x00000000b9a00000        1704K
RW                     NX pte
[    0.371066] 0x00000000b9a00000-0x00000000baa00000          16M
ro         PSE         x  pmd

and after

[    0.349577] 0x0000000000a00000-0x0000000080000000        2038M
RW         PSE         NX pmd
[    0.350049] 0x0000000080000000-0x00000000b9800000         920M
                         pmd
[    0.350514] 0x00000000b9800000-0x00000000b9856000         344K
                         pte
[    0.351013] 0x00000000b9856000-0x00000000b9a00000        1704K
RW                     NX pte

so i'm still doing something wrong, I think?
