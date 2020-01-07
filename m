Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF0132F52
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgAGTXr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 14:23:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41330 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTXr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 14:23:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so715910wrw.8
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 11:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHKNtBQCmsrVHjK1OcmuuHgwEPzOfzvahRavECy/Dso=;
        b=lNfJJkRtdiQR/rY94j/qryvp9o0fLngdZndq6qguklE75PZWFHzMfwkaTNXmHHfJT1
         OCi9lWb/eYP2zUwCr627PjhTwlp4KFJZUuW+yr0osmcuHM4Z7KB2d8CgqCxLMm3lpY6r
         pf8tmAq+9j8r0qzykeHipA8Z7RBzHcLJqW3VUWH2XW49MOwE6VMvYwKGKNR3M5dxEh+0
         yIkRfs4vKd1qSawvTAzOUGCWOn27sPmBx0ODPNFJfz3u8Jfreqw4v861x0/2tMfS7ml3
         Nqhilg8vP8/jomlXpxsTIa8N+t1HVTQlDhMhet1FCPnGjqqYsDV007UH46R5CYi9amnS
         GmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHKNtBQCmsrVHjK1OcmuuHgwEPzOfzvahRavECy/Dso=;
        b=bnWdD6m9yauhg06KWurHNZKyYFDJ3Vd3Z5mfIESYGYkbyCVxD6D4TN6/FrYBJeemjA
         F3ehfqWN4F41BydhSD0QiBFbltnvtZpwhI+n+lEUperQTzj2vVDt5BnkG3XDH5UKWh7l
         td0yUIjM3Qfn0F0g8boEMFIR2p86XCGUnUBzWtviPyWAiGcuhVak0Rs31Mr8PsjpoIle
         uC5A+BaIzI9/cHxhA8D1cZ0L5xiOrs4Oscbr5E9lWuh+vQqt3GgmAfu2RWCyhajAp6eF
         PFMxQLn2Y4Jd6dzn/4I/MuTH96SmcBSp4D/HsD8AezeHyLctnvOufsAsRK9nMO0+QZYG
         +Vug==
X-Gm-Message-State: APjAAAUsNZtfVdDcq8OeH9HodYvOaUxYsHo5ohIe22NzEoVANFrniSWS
        ungxPKaxKd2SuOuv7eihMOu4u9RS03vdlugmEyjMQNOdiZ0=
X-Google-Smtp-Source: APXvYqwHNusyu4dbYQEYYRONd6bfsbQ+9X3g6wYFZAfIXQPk8+7AJrp4Naz/ewIJ7Gq+R6fkZquExai8r8zyw0b1URQ=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr651265wrr.32.1578425025312;
 Tue, 07 Jan 2020 11:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20200107142125.GA652888@rani.riverdale.lan> <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan> <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan> <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan> <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
 <20200107183224.GB1642410@rani.riverdale.lan> <CAKv+Gu_+8-vFFg6V06cxK4McbqOeqkAFYGB_MHDU3jcFyM1yHA@mail.gmail.com>
 <20200107191412.GA1685286@rani.riverdale.lan>
In-Reply-To: <20200107191412.GA1685286@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 20:23:34 +0100
Message-ID: <CAKv+Gu8CsQOZJErDOjCtMB-6yr92CmLiCFpOTeoqdZWBOLh1oQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 20:14, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jan 07, 2020 at 08:03:18PM +0100, Ard Biesheuvel wrote:
> > On Tue, 7 Jan 2020 at 19:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 07:10:34PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 7 Jan 2020 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> > > > > > On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > > > > > > >
> > > > > > > > Unfortunately, the command line option implements a weaker form of
> > > > > > > > visibility than the pragma, so it probably comes down to setting the
> > > > > > > > pragma in a .h file that gets -include'd via the command line so it is
> > > > > > > > guaranteed to be seen first.
> > > > > > >
> > > > > > > Tried hacking that in and it works, tested with gcc 4.6.4.
> > > > > >
> > > > > > Excellent. But in my testing locally, I don't get any GOT entries in
> > > > > > the first place, strangely enough. So what changes in the output for
> > > > > > you with visibility hidden compared to before?
> > > > >
> > > > > Works with 32-bit as well.
> > > > >
> > > > > Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
> > > > > latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
> > > > > in pgtable_64.
> > > > >
> > > >
> > > > I am looking at the size of the .got section in
> > > > boot/compressed/vmlinux, and it is 0x0 on 64-bit, and 0xc (i.e., only
> > > > the .got.plt fixup code) on 32-bit.
> > > >
> > > > Could you please check whether passing -Bsymbolic to the linker gives
> > > > the same result btw?
> > > >
> > >
> > > With new ld all those GOTPCRELX's get eliminated. If you add --no-relax
> > > you'll get them in the .got. I don't have an old version of binutils so
> > > I can't check, but I think they will be assembled as GOTPCREL and remain
> > > in the .got section after linking.
> > >
> >
> > Right, unless you use hidden visibility, no?
> >
>
> Right, that's what I said works before -- with hidden visibility the
> compiler (even an old one) does not generate any GOT-using relocations.
> We're trying to debug why you don't see any .got entries even before
> turning on hidden visibility, while I do, no?
>

Yeah. I have just reinstalled Ubuntu Trusty in a VM, which has
binutils 2.4 and has a GCC 4.6 package available, but I haven't tried
building the 64-bit kernel yet.


> > > A linker option can't help I'd think, because once these relocations are
> > > there in the object files, you need the new binutils to get rid of them.
> > > I didn't get any difference with -Bsymbolic -- also that seems to be for
> > > shared libraries, with executables the references should already be
> > > bound within the executable, shared libraries can't override them.
> >
> > PIE and .so support share a *lot* of code in binutils. In the arm64
> > kernel, we use Bsymbolic to get rid of a few absolute symbol
> > references, even though the -pie linker option should take care of
> > that, but it doesn't in all cases.
