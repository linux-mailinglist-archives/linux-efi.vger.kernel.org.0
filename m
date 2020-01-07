Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61D8132F1B
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 20:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgAGTOQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 14:14:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34604 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgAGTOP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 14:14:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so442257qkk.1
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 11:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTogVah4wc8+FEX3HbDHengISx/0SlzZo52eH6H9ULA=;
        b=QxBFjQue3xBX3wHy9gJz6wMalSO742VfrMvsz1MrrqzhO8RcUbGQg116m9BNIsOfGv
         NWd4pbSHfQcqHNz5wX5JBYiTI7FIOyIHqx1QIEdZstyw0ja9GSwDLjUjvb2/3g9R2ibD
         I46mcb90Pb3nm4JIApwmR0k7CnnLgGJTsOhnLWu5afW0468b+EUM+PpCqjuhnJKjP0da
         dwZQDPqXVOHpPrPXFzyylSfm+YyO/RVF0qMq2zXfYJRPIOM4tbrMtFl+4bIhmSezCZqe
         ErPb/uFyGPtrmT7MoLz63iTgNK3l0V0lx0F9Ztzset5+Zi+qzlxbDbkKBDZ5cSTYn1qG
         M9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTogVah4wc8+FEX3HbDHengISx/0SlzZo52eH6H9ULA=;
        b=FBVJkhJhRGH1iiCf9ABlBxAD4KWFRoT+PoR4R5fsnMtJxZqaFxE2CwOgMTUONX3BoA
         Cq2HN+JJ5JBLcluX/IKqxPuW6q73d7v4uIe1cQn7xg5PadPEdHx5kOoBMBBmUmYFUPGs
         9vIudZ8dtZcKEERAtNlkSCPzoy7EB2LjkrmH+2rS+agf3XDQDsGryNjJu6cpSmwE3kxg
         epamUn2Iuj1twg5dHV8tbyyjasjgAtaNvzv91Xuniot8wuI40Rid8JfaWgI5dhCCmsng
         k9WSwbgcZq7xoKVA6sM3IM0gESKP22ntng7mgSWv1+qbPjJ2NeWfsvVrF5zWD4v7/xs7
         /QdQ==
X-Gm-Message-State: APjAAAX8QFHzo2gJNZX6cXlVWf8bvysXyZ/9kqpQ2FNvKHGMGV1yezDe
        CpUyxmzpSakN3gHBGphkQlA=
X-Google-Smtp-Source: APXvYqwKnyN8uYIQg3q+M64icPeWO54GmzsPp7V1G0iV+xh/hMzVp0jvi7USzKIFnLnnOf+pBUW7wQ==
X-Received: by 2002:a37:582:: with SMTP id 124mr825443qkf.257.1578424454636;
        Tue, 07 Jan 2020 11:14:14 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 201sm258357qkf.10.2020.01.07.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:14:14 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 14:14:12 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107191412.GA1685286@rani.riverdale.lan>
References: <20200107142125.GA652888@rani.riverdale.lan>
 <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan>
 <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan>
 <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan>
 <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
 <20200107183224.GB1642410@rani.riverdale.lan>
 <CAKv+Gu_+8-vFFg6V06cxK4McbqOeqkAFYGB_MHDU3jcFyM1yHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_+8-vFFg6V06cxK4McbqOeqkAFYGB_MHDU3jcFyM1yHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 08:03:18PM +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2020 at 19:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jan 07, 2020 at 07:10:34PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 7 Jan 2020 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > > > > > >
> > > > > > > Unfortunately, the command line option implements a weaker form of
> > > > > > > visibility than the pragma, so it probably comes down to setting the
> > > > > > > pragma in a .h file that gets -include'd via the command line so it is
> > > > > > > guaranteed to be seen first.
> > > > > >
> > > > > > Tried hacking that in and it works, tested with gcc 4.6.4.
> > > > >
> > > > > Excellent. But in my testing locally, I don't get any GOT entries in
> > > > > the first place, strangely enough. So what changes in the output for
> > > > > you with visibility hidden compared to before?
> > > >
> > > > Works with 32-bit as well.
> > > >
> > > > Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
> > > > latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
> > > > in pgtable_64.
> > > >
> > >
> > > I am looking at the size of the .got section in
> > > boot/compressed/vmlinux, and it is 0x0 on 64-bit, and 0xc (i.e., only
> > > the .got.plt fixup code) on 32-bit.
> > >
> > > Could you please check whether passing -Bsymbolic to the linker gives
> > > the same result btw?
> > >
> >
> > With new ld all those GOTPCRELX's get eliminated. If you add --no-relax
> > you'll get them in the .got. I don't have an old version of binutils so
> > I can't check, but I think they will be assembled as GOTPCREL and remain
> > in the .got section after linking.
> >
> 
> Right, unless you use hidden visibility, no?
> 

Right, that's what I said works before -- with hidden visibility the
compiler (even an old one) does not generate any GOT-using relocations.
We're trying to debug why you don't see any .got entries even before
turning on hidden visibility, while I do, no?

> > A linker option can't help I'd think, because once these relocations are
> > there in the object files, you need the new binutils to get rid of them.
> > I didn't get any difference with -Bsymbolic -- also that seems to be for
> > shared libraries, with executables the references should already be
> > bound within the executable, shared libraries can't override them.
> 
> PIE and .so support share a *lot* of code in binutils. In the arm64
> kernel, we use Bsymbolic to get rid of a few absolute symbol
> references, even though the -pie linker option should take care of
> that, but it doesn't in all cases.
