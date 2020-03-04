Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B997B178C73
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 09:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgCDIR6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 03:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgCDIR6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 03:17:58 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C20F22522
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583309877;
        bh=VvP9M7K7X5tlAWb9QFz2KtHF0kHJfukxQs5jv7ivTU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eW4zwJEdSJY5I0QoJh7Odniwh1Sg0fHbL4TFjN6HFW9JJjGksk7sGD5guX6KFkFnf
         LTQDCRccwxj2cXUqN3Ti00co9S1ukRyEB5Vhbp3HNYd8fRq0sFi6t9LR4wUePIjQCl
         X51cq/z0Xud+9r5EBzGIA/P9Oi4d2GtFSCuxqR7s=
Received: by mail-wm1-f47.google.com with SMTP id a132so871735wme.1
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 00:17:57 -0800 (PST)
X-Gm-Message-State: ANhLgQ1TmaZfwoprrygBobBCVuHoftlVJ5FrUrzPjBVrjeHRuANiknCk
        jNysoQoUKDuZ+pCF0BlXidg68JDRGlTa5Onuuio4Jg==
X-Google-Smtp-Source: ADFU+vvkIynVQGoDgk8Ik887VFnxoULfRgVGoR02xmEIWUYBpdzt+my/y+YM0vPHVmy3OcyPNE5HGabbGtrtwarQek8=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr2449069wmi.133.1583309875696;
 Wed, 04 Mar 2020 00:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu> <20200303205445.3965393-2-nivedita@alum.mit.edu>
In-Reply-To: <20200303205445.3965393-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 09:17:44 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
Message-ID: <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
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

On Tue, 3 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit d367cef0a7f0 ("x86/mm/pat: Fix boot crash when 1GB pages are not
> supported by the CPU") added checking for CPU support for 1G pages
> before using them.
>
> However, when support is not present, nothing is done to map the
> intermediate 1G regions and we go directly to the code that normally
> maps the remainder after 1G mappings have been done. This code can only
> handle mappings that fit inside a single PUD entry, but there is no
> check, and it instead silently produces a corrupted mapping to the end
> of the PUD entry, and no mapping beyond it, but still returns success.
>
> This bug is encountered on EFI machines in mixed mode (32-bit firmware
> with 64-bit kernel), with RAM beyond 2G. The EFI support code
> direct-maps all the RAM, so a memory range from below 1G to above 2G
> triggers the bug and results in no mapping above 2G, and an incorrect
> mapping in the 1G-2G range. If the kernel resides in the 1G-2G range, a
> firmware call does not return correctly, and if it resides above 2G, we
> end up passing addresses that are not mapped in the EFI pagetable.
>
> Fix this by mapping the 1G regions using 2M pages when 1G page support
> is not available.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

I was trying to test these patches, and while they seem fine from a
regression point of view, I can't seem to reproduce this issue and
make it go away again by applying this patch.

Do you have any detailed instructions how to reproduce this?

> ---
>  arch/x86/mm/pat/set_memory.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index c4aedd00c1ba..d0b7b06253a5 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1370,12 +1370,22 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
>         /*
>          * Map everything starting from the Gb boundary, possibly with 1G pages
>          */
> -       while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
> -               set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> -                                  canon_pgprot(pud_pgprot))));
> +       while (end - start >= PUD_SIZE) {
> +               if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
> +                       set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> +                                          canon_pgprot(pud_pgprot))));
> +                       cpa->pfn += PUD_SIZE >> PAGE_SHIFT;
> +               } else {
> +                       if (pud_none(*pud))
> +                               if (alloc_pmd_page(pud))
> +                                       return -1;
> +                       if (populate_pmd(cpa, start, start + PUD_SIZE,
> +                                        PUD_SIZE >> PAGE_SHIFT,
> +                                        pud, pgprot) < 0)
> +                               return cur_pages;
> +               }
>
>                 start     += PUD_SIZE;
> -               cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;
>                 cur_pages += PUD_SIZE >> PAGE_SHIFT;
>                 pud++;
>         }
> --
> 2.24.1
>
