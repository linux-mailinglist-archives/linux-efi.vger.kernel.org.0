Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4477E2D1A9F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 21:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLGUgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 15:36:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGUgy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 15:36:54 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1kmNEx-0004FG-HF
        for linux-efi@vger.kernel.org; Mon, 07 Dec 2020 20:36:11 +0000
Received: by mail-wm1-f72.google.com with SMTP id k128so164159wme.7
        for <linux-efi@vger.kernel.org>; Mon, 07 Dec 2020 12:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iay94n4vbXtVqh1Izy3qyGaxyyIzLgFJf2vEF0h7crw=;
        b=rshjFE9E/oQN7UhtxjpaPcbofo8Ejljt9msu+RrfDKPJ5phJ5rxtLMe9Uy1AtSY4Ld
         VY8cOB7Z2wwm75sZQJZF7EhbMxhaPz9eaxgaGJL2GxvmLmWGHv6pulEOOmpQMLFIDWZP
         5q6k2ocqlL+dD01P0RMnt3nW5RdwFKFVQKd4xTSxnUp+OI5zCDhAflv80J9R1/unRlVr
         9zlmsp75l5YoJwyieXP8T+Urx5KOuIiE+vhBt9esJmw04bJl8+/POgbH2rcN00Xkcz13
         gWDNhhBLD7LgUyXmZgZtdwIUohWA0IbI97A55NBo0PluZjSBveKTCyvOlXGmOAIXNL8j
         ScBw==
X-Gm-Message-State: AOAM530Qak45S61qL0fgCz9kNNS7TA0rSq3vgxupmH7PeL15LaX/83fg
        rCsg1c1cAvN50utNXmSqx2GatU4pCiLBCzzaeai7kSgircuL60jkXiZ2N9ulE2J9l4M104m0hlA
        D6OFbo1oyUSndWJkWQam3LZtBYMyzKY15qz6LYXqhFxf06NdhIKF0kw==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr585929wmm.103.1607373371130;
        Mon, 07 Dec 2020 12:36:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3Y5Tlb8k4fV/2cmGn8FoKYCkGlPyJr06XedKUC0hTDrXtYmdsTR5c7SAw1bAcRzJyrTiqxmsm4sfYY4hN4ZM=
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr585909wmm.103.1607373370869;
 Mon, 07 Dec 2020 12:36:10 -0800 (PST)
MIME-Version: 1.0
References: <X8yoWHNzfl7vHVRA@kroah.com> <20201207172625.2888810-1-dann.frazier@canonical.com>
 <CAMj1kXHdqaso9Vkm3KeKFntMBQeRTkY-fU1GW8K8rcxBbQbKBA@mail.gmail.com>
 <CALdTtnv6VCBjvS-rtUTdhmLHkiJJrY+m4CLW4F8F89NEpZYF7A@mail.gmail.com> <CAMj1kXFAn2bJgwpN+SkGQSzXVdssaZ0Sjpspn8n0QQn4MDk5CA@mail.gmail.com>
In-Reply-To: <CAMj1kXFAn2bJgwpN+SkGQSzXVdssaZ0Sjpspn8n0QQn4MDk5CA@mail.gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Mon, 7 Dec 2020 13:35:59 -0700
Message-ID: <CALdTtnuT7fVJ17C2nq8kks_rFRGtDySx61tWpt8b+roajyi7vg@mail.gmail.com>
Subject: Re: [PATCH 4.4] Revert "crypto: arm64/sha - avoid non-standard inline
 asm tricks"
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Michael Schaller <misch@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 7, 2020 at 11:29 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 7 Dec 2020 at 19:08, dann frazier <dann.frazier@canonical.com> wrote:
> >
> > On Mon, Dec 7, 2020 at 10:50 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 7 Dec 2020 at 18:26, dann frazier <dann.frazier@canonical.com> wrote:
> > > >
> > > > This reverts commit c042dd600f4e89b6e7bdffa00aea4d1d3c1e9686.
> > > >
> > > > This caused the build to emit ADR_PREL_PG_HI21 relocations in the sha{1,2}_ce
> > > > modules. This relocation type is not supported by the linux-4.4.y kernel
> > > > module loader when CONFIG_ARM64_ERRATUM_843419=y, which we have enabled, so
> > > > these modules now fail to load:
> > > >
> > > >   [   37.866250] module sha1_ce: unsupported RELA relocation: 275
> > > >
> > > > This issue does not exist with the backport to 4.9+. Bisection shows that
> > > > this is due to those kernels also having a backport of
> > > > commit 41c066f ("arm64: assembler: make adr_l work in modules under KASLR")
> > >
> > > Hi Dann,
> > >
> > > Would it be an option to backport 41c066f as well?
> >
> > Hi Ard,
> >
> > That was attempted before, but caused a build failure which would
> > still happen today:
> >   https://www.spinics.net/lists/stable/msg179709.html
> > Specifically, head.S still has a 3 argument usage of adr_l. I'm not
> > sure how to safely fix that up myself.
> >
>
> Given that the original reason for reverting the backport of 41c066f
> no longer holds (as there are other users of adr_l in v4.4 now), I
> think the best solution is to backport it again, but with the hunk
> below folded in. (This just replaces the macro invocation with its
> output when called with the 3 arguments in question, so the generated
> code is identical)
>
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -424,7 +424,8 @@ __mmap_switched:
>         str     xzr, [x6], #8                   // Clear BSS
>         b       1b
>  2:
> -       adr_l   sp, initial_sp, x4
> +       adrp    x4, initial_sp
> +       add     sp, x4, :lo12:initial_sp
>         str_l   x21, __fdt_pointer, x5          // Save FDT pointer
>         str_l   x24, memstart_addr, x6          // Save PHYS_OFFSET
>         mov     x29, #0

Thanks Ard - that works. I'll follow-up with a backport patch.

  -dann
