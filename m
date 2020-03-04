Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6A179407
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgCDPtN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:49:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43845 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCDPtN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 10:49:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id q18so2037757qki.10;
        Wed, 04 Mar 2020 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TsTKXhrbnw/QAlugyUyOjWQ0P4Lr6lXfLnd3ahgcNlQ=;
        b=LmHHN+/yzZIXHZsAT4mPjlLhLhDwRzyHrf4mOtnXBsZHhyIBerM7ivcQPYfmN0zu6M
         MCpqRZ0853FsImWkM8jJqsAAWmYEoyzkUielgjLay4Whb47ZdwgVV/VzoHfmSlnXlNo3
         vt8KFlhUaOdOYWZq9BPIH3Ak+dzsUQs5cqzn/6cHlOj5RkPT6A0EvUvIKG8+IupQa8wa
         nHuSVnBnQyFqzFVhr3EUmcXmVdW5VdLx7na6S8dSRUpiMSgUI8B6So0y5dusrau4YXIf
         gRfJVVqcF0GcwaB+H3QjzSY6fzYJBksg2CAJjjpSFPH+WXaLKAWGoZEqYV4AbysBmG7S
         KxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TsTKXhrbnw/QAlugyUyOjWQ0P4Lr6lXfLnd3ahgcNlQ=;
        b=YWOxTE5rd/xZDD6NTHh03SqWsgHNrw6YPwj2IQ31lmwkfeu5C5DgvByztKZV3dsGMe
         2Lt9X1kdEHvRxeKUDAGdibwlWx7c354R3b4XA9PQ3PC79MQIZ/xhdtu6evpbyxrLgyAi
         G/xKn7u6geSiD7TMrmPRUJQX4kBi5aCcmZWChl684XsdZiP9M+pnS8OH6qK35xNd7uGI
         C5N/99aft2O9dMZ+Vr0zg+sp7gPdclJdpSqvrdJ90zWosITnLyOj+pWP6zVd1fya1810
         y0i8JNn3m0IoEOd11F3P3IJ3o+NMXDpEw5WQCiAsdhBhTOOKZvHu1DXyOoxk5Wl94eyH
         flUA==
X-Gm-Message-State: ANhLgQ0b28NxaGJ5aZUWcXgR8qjTg9oSWMwmnboJT4Whh25BG4PNYbfH
        tf5HB/0eae34vv4CtW2kWRXGMOvly7g=
X-Google-Smtp-Source: ADFU+vu6MjrfeMJUkM08i6nKGwC401gXeN93yXmVhriRbMKWEwypOR4JepxmDbYtCZB/O4uXmPxkbw==
X-Received: by 2002:a05:620a:21c9:: with SMTP id h9mr3527412qka.29.1583336951756;
        Wed, 04 Mar 2020 07:49:11 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 89sm14195261qth.3.2020.03.04.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:49:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 10:49:09 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in
 populate_pud
Message-ID: <20200304154908.GB998825@rani.riverdale.lan>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu>
 <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 09:17:44AM +0100, Ard Biesheuvel wrote:
> On Tue, 3 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Commit d367cef0a7f0 ("x86/mm/pat: Fix boot crash when 1GB pages are not
> > supported by the CPU") added checking for CPU support for 1G pages
> > before using them.
> >
> > However, when support is not present, nothing is done to map the
> > intermediate 1G regions and we go directly to the code that normally
> > maps the remainder after 1G mappings have been done. This code can only
> > handle mappings that fit inside a single PUD entry, but there is no
> > check, and it instead silently produces a corrupted mapping to the end
> > of the PUD entry, and no mapping beyond it, but still returns success.
> >
> > This bug is encountered on EFI machines in mixed mode (32-bit firmware
> > with 64-bit kernel), with RAM beyond 2G. The EFI support code
> > direct-maps all the RAM, so a memory range from below 1G to above 2G
> > triggers the bug and results in no mapping above 2G, and an incorrect
> > mapping in the 1G-2G range. If the kernel resides in the 1G-2G range, a
> > firmware call does not return correctly, and if it resides above 2G, we
> > end up passing addresses that are not mapped in the EFI pagetable.
> >
> > Fix this by mapping the 1G regions using 2M pages when 1G page support
> > is not available.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> I was trying to test these patches, and while they seem fine from a
> regression point of view, I can't seem to reproduce this issue and
> make it go away again by applying this patch.
> 
> Do you have any detailed instructions how to reproduce this?
> 

The steps I'm following are
- build x86_64 defconfig + enable EFI_PGT_DUMP (to show the incorrect
  pagetable)
- run (QEMU is 4.2.0)
$ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_32.fd -m 3072 -nographic \
  -kernel kernel64/arch/x86/boot/bzImage -append "earlyprintk=ttyS0,keep efi=debug nokaslr"

The EFI memory map I get is (abbreviated to regions of interest):
...
[    0.253991] efi: mem10: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000053e7000-0x000000003fffbfff] (940MB)
[    0.254424] efi: mem11: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000003fffc000-0x000000003fffffff] (0MB)
[    0.254991] efi: mem12: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000040000000-0x00000000bbf77fff] (1983MB)
...

The pagetable this produces is (abbreviated again):
...
[    0.272980] 0x0000000003400000-0x0000000004800000          20M     ro         PSE         x  pmd
[    0.273327] 0x0000000004800000-0x0000000005200000          10M     RW         PSE         NX pmd
[    0.273987] 0x0000000005200000-0x0000000005400000           2M     RW                     NX pte
[    0.274343] 0x0000000005400000-0x000000003fe00000         938M     RW         PSE         NX pmd
[    0.274725] 0x000000003fe00000-0x0000000040000000           2M     RW                     NX pte
[    0.275066] 0x0000000040000000-0x0000000080000000           1G     RW         PSE         NX pmd
[    0.275437] 0x0000000080000000-0x00000000bbe00000         958M                               pmd
...

Note how 0x80000000-0xbbe00000 range is unmapped in the resulting
pagetable. The dump doesn't show physical addresses, but the
0x40000000-0x80000000 range is incorrectly mapped as well, as the loop
in populate_pmd would just go over that virtual address range twice.

	while (end - start >= PMD_SIZE) {
		...
		pmd = pmd_offset(pud, start);

		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
					canon_pgprot(pmd_pgprot))));

		start	  += PMD_SIZE;
		cpa->pfn  += PMD_SIZE >> PAGE_SHIFT;
		cur_pages += PMD_SIZE >> PAGE_SHIFT;
	}
