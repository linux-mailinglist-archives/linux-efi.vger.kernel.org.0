Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B156C17983E
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgCDSpE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgCDSpE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:45:04 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D22224658
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 18:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583347503;
        bh=Xrw/0ZXS8o5llP7/hWRgBB1gg32aOCivmOH4N2PPq28=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=evFc4Gy2bN812x4sk2r8Pn9zAtdOD5nizsdGRFGnPPQJjIT3Giw+WApSBY2sg4RQj
         iTqf7tJ5u5IGF0EXEAMZNb1VAIz5xMM6HzAydQcZPNoCREgPFvBNUAcWYJTqD+wqzD
         sux5tvloTufAOp3GDV77PXiGSd4cbGPBEygtj4qA=
Received: by mail-wr1-f52.google.com with SMTP id n7so3720512wrt.11
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 10:45:03 -0800 (PST)
X-Gm-Message-State: ANhLgQ2nbZVnEq/+cFt7CZtoIl83gHqgTwf//H2nJZ3+USy/k2Q3luT2
        Sa18s9X0e3oZBknLkVx7n3hrLmoWhPf6qUp4qzQR3A==
X-Google-Smtp-Source: ADFU+vtlsxwoHrm1OQRutaVl5g00tzjaOFt5JVahFb3l/ibOgX3f8Wh4bQByjMpAPzr6IyStGc/YxKeZy0zjhVlBpC0=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr5480355wrw.252.1583347501553;
 Wed, 04 Mar 2020 10:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu> <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan>
In-Reply-To: <20200304154908.GB998825@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 19:44:50 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
Message-ID: <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
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

On Wed, 4 Mar 2020 at 16:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 09:17:44AM +0100, Ard Biesheuvel wrote:
> > On Tue, 3 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > Commit d367cef0a7f0 ("x86/mm/pat: Fix boot crash when 1GB pages are not
> > > supported by the CPU") added checking for CPU support for 1G pages
> > > before using them.
> > >
> > > However, when support is not present, nothing is done to map the
> > > intermediate 1G regions and we go directly to the code that normally
> > > maps the remainder after 1G mappings have been done. This code can only
> > > handle mappings that fit inside a single PUD entry, but there is no
> > > check, and it instead silently produces a corrupted mapping to the end
> > > of the PUD entry, and no mapping beyond it, but still returns success.
> > >
> > > This bug is encountered on EFI machines in mixed mode (32-bit firmware
> > > with 64-bit kernel), with RAM beyond 2G. The EFI support code
> > > direct-maps all the RAM, so a memory range from below 1G to above 2G
> > > triggers the bug and results in no mapping above 2G, and an incorrect
> > > mapping in the 1G-2G range. If the kernel resides in the 1G-2G range, a
> > > firmware call does not return correctly, and if it resides above 2G, we
> > > end up passing addresses that are not mapped in the EFI pagetable.
> > >
> > > Fix this by mapping the 1G regions using 2M pages when 1G page support
> > > is not available.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > I was trying to test these patches, and while they seem fine from a
> > regression point of view, I can't seem to reproduce this issue and
> > make it go away again by applying this patch.
> >
> > Do you have any detailed instructions how to reproduce this?
> >
>
> The steps I'm following are
> - build x86_64 defconfig + enable EFI_PGT_DUMP (to show the incorrect
>   pagetable)
> - run (QEMU is 4.2.0)
> $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_32.fd -m 3072 -nographic \
>   -kernel kernel64/arch/x86/boot/bzImage -append "earlyprintk=ttyS0,keep efi=debug nokaslr"
>
> The EFI memory map I get is (abbreviated to regions of interest):
> ...
> [    0.253991] efi: mem10: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000053e7000-0x000000003fffbfff] (940MB)
> [    0.254424] efi: mem11: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000003fffc000-0x000000003fffffff] (0MB)
> [    0.254991] efi: mem12: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000040000000-0x00000000bbf77fff] (1983MB)
> ...
>
> The pagetable this produces is (abbreviated again):
> ...
> [    0.272980] 0x0000000003400000-0x0000000004800000          20M     ro         PSE         x  pmd
> [    0.273327] 0x0000000004800000-0x0000000005200000          10M     RW         PSE         NX pmd
> [    0.273987] 0x0000000005200000-0x0000000005400000           2M     RW                     NX pte
> [    0.274343] 0x0000000005400000-0x000000003fe00000         938M     RW         PSE         NX pmd
> [    0.274725] 0x000000003fe00000-0x0000000040000000           2M     RW                     NX pte
> [    0.275066] 0x0000000040000000-0x0000000080000000           1G     RW         PSE         NX pmd
> [    0.275437] 0x0000000080000000-0x00000000bbe00000         958M                               pmd
> ...
>
> Note how 0x80000000-0xbbe00000 range is unmapped in the resulting
> pagetable. The dump doesn't show physical addresses, but the
> 0x40000000-0x80000000 range is incorrectly mapped as well, as the loop
> in populate_pmd would just go over that virtual address range twice.
>
>         while (end - start >= PMD_SIZE) {
>                 ...
>                 pmd = pmd_offset(pud, start);
>
>                 set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
>                                         canon_pgprot(pmd_pgprot))));
>
>                 start     += PMD_SIZE;
>                 cpa->pfn  += PMD_SIZE >> PAGE_SHIFT;
>                 cur_pages += PMD_SIZE >> PAGE_SHIFT;
>         }

I've tried a couple of different ways, but I can't seem to get my
memory map organized in the way that will trigger the error.
