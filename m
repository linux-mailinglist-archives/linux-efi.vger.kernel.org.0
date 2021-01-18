Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC802FACEB
	for <lists+linux-efi@lfdr.de>; Mon, 18 Jan 2021 22:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbhARVni (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jan 2021 16:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbhARVnE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Jan 2021 16:43:04 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D8C061574;
        Mon, 18 Jan 2021 13:42:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d11so8207910qvo.11;
        Mon, 18 Jan 2021 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7WHZONqXFgXEk6ISoZzpiq15kU0W8eyDeH2IAM8jdzk=;
        b=hYi/lsRjquukXojQzQJwLZq7VF5OWZ5OAhY28p2GNWRDhpFvVWB5TsUx5s2KQBgq4y
         IJghQq7PPfKwSnoJi7rVpbbHAaK19Vrs6ARsjeMht6pgPvsPXnIiCt//x/enj2DxuR00
         4yV51OKn7ZijY9yYtgkmQO8sqbv+V5qt6Jy9dsIfwKCUBQBYCH+Dj7w8OJ9QDaUj6o10
         SZSOU9I6v3BqUOr1dM4kodBFCcRzQLcyrI7IkDFT0aHpQsEkdSLHnlML5NTccuqB/q7D
         OKMJaw9z5pesJeFPxcpxl2iilM5u9MOOa6S/UwyrQOjL77+gXog02WZVh4vTXB/k/Yam
         ATlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7WHZONqXFgXEk6ISoZzpiq15kU0W8eyDeH2IAM8jdzk=;
        b=JbzoBqksOE4iMbu17rBzzmAXGx3hSBDzyFuDRup/5GkyfOBw2At+/9NomldnQhx6P8
         zgQc4F7zxv4tJdk4YsMk9g1zhzOHv1ICddOZILZz5HyZcYnsLXPHA3akapcvOaUq8jgZ
         6wJ8BNpe0icNlRHg2YYuzErsTT7GlDykN52XTMySVg4Y8jkjqn5f4c9Ed7KZ+tuxxARI
         HOm4I+VbHs26s1LtNnF734kPBG99mBVUf+aWqi4MymGwaR0Xa1anYAtJVzDZOZElqD4Z
         I1Px/IdCslWe6upl2h3W5emAdG9Cd+B006QcO2K3Lsqh4bKWSgmJMtD3SbwoLiK2uaU1
         /H+g==
X-Gm-Message-State: AOAM532K8+UedWOGhwjW5jlH/Ycite4PMeIplE/1h+WI7+48fiCA9aJ+
        w6KAmh54He6hhOnYwVoFCQw=
X-Google-Smtp-Source: ABdhPJz8yYg54fLQaQgOsJbMnT4/t60m1mZqZ979bZmxy4q+LDKeOnK5XdZdJkqZzRGo/9/vqz9Yrg==
X-Received: by 2002:ad4:59d2:: with SMTP id el18mr1664166qvb.35.1611006143640;
        Mon, 18 Jan 2021 13:42:23 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h75sm11354276qke.130.2021.01.18.13.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 13:42:22 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 18 Jan 2021 16:42:20 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <YAYAvBARSRSg8z8G@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118202409.GG30090@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 18, 2021 at 09:24:09PM +0100, Borislav Petkov wrote:
> > > > As a matter of fact, it seems like the four assertions could be combined
> > > > into:
> > > >       BUILD_BUG_ON((EFI_VA_END & P4D_MASK) != (MODULES_END & P4D_MASK));
> > > >       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > > > instead of separately asserting they're the same PGD entry and the same
> > > > P4D entry.
> > > >
> > > > Thanks.
> > >
> > > I actually don't quite get the MODULES_END check -- Ard, do you know
> > > what that's for?
> > >
> > 
> > Maybe Boris remembers? He wrote the original code for the 'new' EFI
> > page table layout.
> 
> That was added by Kirill for 5-level pgtables:
> 
>   e981316f5604 ("x86/efi: Add 5-level paging support")

That just duplicates the existing pgd_index() check for the p4d_index()
as well. It looks like the original commit adding
efi_sync_low_kernel_mappings() used to copy upto the PGD entry including
MODULES_END:
  d2f7cbe7b26a7 ("x86/efi: Runtime services virtual mapping")
and then Matt changed that when creating efi_mm:
  67a9108ed4313 ("x86/efi: Build our own page table structures")
to use EFI_VA_END instead but have a check that EFI_VA_END is in the
same entry as MODULES_END.

AFAICT, MODULES_END is only relevant as being something that happens to
be in the top 512GiB, and -1ul would be clearer.

> 
>  Documentation/x86/x86_64/mm.rst should explain the pagetable layout:
> 
>    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
>    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
>    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
>    ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
>    ffffffff80000000 |-2048    MB |                  |         |
>    ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
>    ffffffffff000000 |  -16    MB |                  |         |
>       FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
> 
> That thing which starts at -512 GB above is the last PGD on the
> pagetable. In it, between -4G and -68G there are 64G which are the EFI
> region mapping space for runtime services.
> 
> Frankly I'm not sure what this thing is testing because the EFI VA range
> is hardcoded and I can't imagine it being somewhere else *except* in the
> last PGD.

It's just so that someone doesn't just change the #define's for
EFI_VA_END/START and think that it will work, I guess.

Another reasonable option, for example, would be to reserve an entire
PGD entry, allowing everything but the PGD level to be shared, and
adding the EFI PGD to the pgd_list and getting rid of
efi_sync_low_kernel_mappings() altogether. There aren't that many PGD
entries still unused though, so this is probably not worth it.

> 
> Lemme add Kirill for clarification.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
