Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA61B1A7496
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406551AbgDNHWl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 03:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406537AbgDNHWj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 14 Apr 2020 03:22:39 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871152076C
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 07:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586848958;
        bh=bWAiGhMnB+uz+Ggq1mfnljLnfrbDVBJTH8WUqa3lvg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/7nqShLX2L2unflS35pt6gLz2uzFR2R3bhLG84dpdEKh6uGDtM0IBN0l8+ef1GyT
         EVX/kPofCo5vv7WqVPKzci6o/HM4Mx9PJ+yK76Uc1HM7x/j1ZCs91Jwc0wTFEM0zUb
         IjEZ5EalPb8ryJB9krUz7InV5VCk9PvTbSBF1NyY=
Received: by mail-io1-f43.google.com with SMTP id s18so8821567ioe.10
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 00:22:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuaEr2daJOnHMv/f9rUQTBKx5Rktg1q82NiwXU+q/I/9Ae9ZQT1n
        /rlvMu2Quo15Xpc/Q7gKCdK1XCY9FxnP7WPzphs=
X-Google-Smtp-Source: APiQypIlD71s/PvYUu50eFlUWcgtTgdiIzd+GcnusuWySkJjSnM9gznRgTmuJA3WpIrhurnp4iDv4paPmj06HDgryI0=
X-Received: by 2002:a6b:7f48:: with SMTP id m8mr20408750ioq.142.1586848957898;
 Tue, 14 Apr 2020 00:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200413155521.24698-1-ardb@kernel.org> <CAOnJCULxNtk99sudMD5Rn5ao0orwcarOAwg7NPXMK6ZdXmwNOA@mail.gmail.com>
In-Reply-To: <CAOnJCULxNtk99sudMD5Rn5ao0orwcarOAwg7NPXMK6ZdXmwNOA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Apr 2020 09:22:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHyP1qHJVBLQ3LaiQWx2swofA+msRJQjp0aX_AcPgB-UQ@mail.gmail.com>
Message-ID: <CAMj1kXHyP1qHJVBLQ3LaiQWx2swofA+msRJQjp0aX_AcPgB-UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] efi/libstub: simplify arm64 kernel image loading
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020 at 23:54, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Apr 13, 2020 at 8:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On arm64, the kernel image used to be virtually mapped via the linear
> > region, making the two mappings correlated in a way that required the
> > kernel to be located at the start of the linear region, or the memory
> > below would not be accessible. For this reason, the EFI stub loader
> > code for arm64 has the notion of a 'preferred offset' for the physical
> > placement of the kernel image, and tries to put the kernel there, or
> > at least as low as possible in physical memory (unless KASLR is active,
> > in which case the placement is randomized)
> >
> > When KASLR was introduced, the virtual mapping of the kernel was moved
> > into the vmalloc region, and now, regardless of whether KASLR support
> > is built in or active, the kernel can be placed anywhere in physical
> > memory without any detrimental side effects on the linear region.
> >
> > This means that we can drop the notion of 'preferred offset' entirely,
> > and invoke the kernel in place if the PE/COFF loader loaded it at the
> > right offset. If not, we can invoke the ordinary UEFI top down page
> > allocator to reallocate it elsewhere in memory. By updating the PE/COFF
> > metadata, we can inform the PE/COFF loader about the desired alignment,
> > making it less likely that we need to move the kernel image in the first
> > place.
> >
> > Ard Biesheuvel (8):
> >   efi/libstub/random: align allocate size to EFI_ALLOC_ALIGN
> >   efi/libstub/random: increase random alloc granularity
> >   efi/libstub/arm64: replace 'preferred' offset with alignment check
> >   efi/libstub/arm64: simplify randomized loading of kernel image
> >   efi/libstub/arm64: align PE/COFF sections to segment alignment
> >   efi/libstub: add API function to allocate aligned memory
> >   efi/libstub/arm64: switch to ordinary page allocator for kernel image
> >   efi/libstub: move efi_relocate_kernel() into separate source file
> >
> >  arch/arm64/kernel/efi-header.S             |   2 +-
> >  arch/arm64/kernel/vmlinux.lds.S            |   3 +-
> >  drivers/firmware/efi/libstub/Makefile      |   3 +-
> >  drivers/firmware/efi/libstub/alignedmem.c  |  57 ++++++
> >  drivers/firmware/efi/libstub/arm64-stub.c  |  92 +++-------
> >  drivers/firmware/efi/libstub/efistub.h     |  18 +-
> >  drivers/firmware/efi/libstub/mem.c         | 191 +-------------------
> >  drivers/firmware/efi/libstub/randomalloc.c |   6 +-
> >  drivers/firmware/efi/libstub/relocate.c    | 174 ++++++++++++++++++
> >  9 files changed, 280 insertions(+), 266 deletions(-)
> >  create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
> >  create mode 100644 drivers/firmware/efi/libstub/relocate.c
> >
> > --
> > 2.17.1
> >
>
> Oops. I just noticed this series after I sent out a v2.
> I see that efi_low_alloc is removed now and the handle_kernel_image is
> simplified for arm64.
> I will update the risc-v uefi series accordingly. Sorry for the noise.
>

No worries. And apologies for making this a moving target :-)

I realised you will probably need to bring back efi_low_alloc() as a
global symbol, as I don't think you will be able to switch to
efi_relocate_kernel().

In any case, this series is just set of patches on the list, so feel
free to propose changes if they are making your life too difficult.
