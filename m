Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8B176DF0
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 05:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCCET3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 23:19:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35132 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCCET3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 23:19:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id 145so2170795qkl.2
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 20:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0SkiHTi2BoIsKWJSTUhA0TNxL0wWT/mUqedpijJpNg=;
        b=bRGigkI9AHNftCPEpZ+SumNIB7Hy9ZtSoQckB1xEiZxNVixUNIF28IicekmiggJz7S
         D7bvQ8f5CjXhMz+wbXh23m9W3akmSYmx5k23/MNgMpL+PSH9UMd8DpCA6ZlyZkxMBCMO
         W1niY5z+eBBVGiLWW0Kt6rJzFIESRN1uX+PStCrH8ebAZKjmvg6/uBf2puP68UXXNIUv
         g0P/OqzOuHCQjSX1mFOms5rhSnM0iFFUX+HKqROuY87gToLFgzRH2yQvsO9TIRUNMLiz
         1BFpok7GYWXapkd0xS7QGZ/mYsMaNk4BD8Mq78GY5JdEDRXpVVf8uikF5BSrU4LWR5Ux
         x/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0SkiHTi2BoIsKWJSTUhA0TNxL0wWT/mUqedpijJpNg=;
        b=SiRx9FGJ83FGUJtIwqHaOr/OvuJpeY7VZVAtdWIbCuqJNvJozjWQmoieeZU9nKKIRb
         KpI2TAmZhvDK3M9H61NLmwNYszBljCN4JZvcJCjIlE9F/mCaHYuHjpMB0FY+M7TsaLku
         aq1D6vAeN4xyN7GR08eA75zf4GEtSj02gJG8zJGMDKfYBrqUNOwI7l3OielBpUWVkcGj
         YpEhRVJ/O794St4DFCCa27eUyKLwWVhBC3n42/o+OOtscVNj5wFKXO4h2TpViUMvlJps
         2Cq2jrbujK0po/bqDctfvrgLGyw1V5ZUMdftuF7Pn9Xa+INGpjlBYzgaHuRM8tMBgh54
         a2WA==
X-Gm-Message-State: ANhLgQ0M3oykmXfYBEPDyTOYM2PfwNyMB/y3V83rVuU+UCSXjc17rrEG
        963M9KQFVeSfZSlGZnnULmI=
X-Google-Smtp-Source: ADFU+vvw6YYxq7ioZ7gjuwe3ShZ0cE2DBhNApKY0ACdcUGqxzLEJNPj8avlgQkXoGv+GYRSgmm49TA==
X-Received: by 2002:a37:a750:: with SMTP id q77mr2187196qke.119.1583209168312;
        Mon, 02 Mar 2020 20:19:28 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t3sm9677630qkt.114.2020.03.02.20.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:19:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 2 Mar 2020 23:19:26 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200303041925.GB3518342@rani.riverdale.lan>
References: <20200301200035.GA2031375@rani.riverdale.lan>
 <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
 <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
 <20200301205419.GA2116204@rani.riverdale.lan>
 <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
 <20200301220126.GA2204298@rani.riverdale.lan>
 <CAKv+Gu-zqrPSwgFAsamPQzwB_uVv8UaLZyqhOsBPb_m=FccnKg@mail.gmail.com>
 <20200301230345.GA2227739@rani.riverdale.lan>
 <CAKv+Gu-ufV7xhptpEpNvEhvmLywQgRndFMsm6FJUko+z2Ob5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-ufV7xhptpEpNvEhvmLywQgRndFMsm6FJUko+z2Ob5vA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 02, 2020 at 01:14:50PM +0100, Ard Biesheuvel wrote:
> On Mon, 2 Mar 2020 at 00:03, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sun, Mar 01, 2020 at 11:56:44PM +0100, Ard Biesheuvel wrote:
> > > On Sun, 1 Mar 2020 at 23:01, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Sun, Mar 01, 2020 at 10:36:05PM +0100, Ard Biesheuvel wrote:
> > > > > On Sun, 1 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > > I see this in the memory map
> > > > > > >
> > > > > > > [    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
> > > > > > >  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
> > > > > > > (1024MB)
> > > > > > >
> > > > > > > so it looks like qemu-system-x86_64 puts the memory in a weird place?
> > > > > > > Or is this expected?
> > > > > >
> > > > > > Mine ended here:
> > > > > > [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> > > > > > are you running with -m 3072 or more?
> > > > > >
> > > > >
> > > > > That is not memory, it's some mmio region
> > > > >
> > > >
> > > > Right, but it's the last (highest) range in my memory map. It was just
> > > > to illustrate that I have no addresses above 4Gb, unlike the mapping you
> > > > got, although I now see that the MMIO range is the last one printed
> > > > regardless of where RAM ends, so that wasn't quite enough. I only get
> > > > the 4g-5g mapping range if I run it with -m 4096.
> > > >
> > > > This is the tail end of the mapping I got.
> > > >
> > > > [    0.000000] efi: mem38: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe00000-0x00000000bfe89fff] (0MB)
> > > > [    0.000000] efi: mem39: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe8a000-0x00000000bfea9fff] (0MB)
> > > > [    0.000000] efi: mem40: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfeaa000-0x00000000bfeccfff] (0MB)
> > > > [    0.000000] efi: mem41: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfecd000-0x00000000bfed5fff] (0MB)
> > > > [    0.000000] efi: mem42: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfed6000-0x00000000bfef3fff] (0MB)
> > > > [    0.000000] efi: mem43: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfef4000-0x00000000bff77fff] (0MB)
> > > > [    0.000000] efi: mem44: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bff78000-0x00000000bfffffff] (0MB)
> > > > [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> > >
> > > Looks like it's the difference in machine type - I was using q35, and
> > > when I switch to the default, I can reproduce the early boot crash you
> > > sent the patch for. I don't see the other issue though.
> >
> > So you can boot successfully without hanging in SetVirtualAddressMap?
> > Weird. I'm using QEMU 4.2.0 in case that matters.
> 
> Mine is 2.11, as shipped with my Ubuntu Bionic installation (company laptop)

I think I've located the problem. kernel_map_pages_in_pgd has a bug,
when gb pages are not enabled, it can sometimes not actually map the
pages it claims to have mapped. The below fixes it, I'll post some
patches tomorrow to clean it up.

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c4aedd00c1ba..a249260e71e7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1370,12 +1370,21 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 	/*
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
-	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
-		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
-				   canon_pgprot(pud_pgprot))));
+	while (end - start >= PUD_SIZE) {
+		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
+			set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+					   canon_pgprot(pud_pgprot))));
+			cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;
+		} else {
+			if (pud_none(*pud))
+				if (alloc_pmd_page(pud))
+					return -1;
+			if (populate_pmd(cpa, start, start + PUD_SIZE,
+					 PUD_SIZE >> PAGE_SHIFT, pud, pgprot) < 0)
+				return cur_pages;
+		}
 
 		start	  += PUD_SIZE;
-		cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;
 		cur_pages += PUD_SIZE >> PAGE_SHIFT;
 		pud++;
 	}
