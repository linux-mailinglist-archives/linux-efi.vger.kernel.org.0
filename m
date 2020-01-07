Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2757A132FDA
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 20:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgAGTv2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 14:51:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36041 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgAGTv2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 14:51:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so868257wru.3
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3vZbnaTkTQkpTOs5RyT3/aPplNkcOKw6w0UH9176lE=;
        b=cNJ9NuqoDe1y+n2Qyzs5y8kk9ZLbVRw4gabym3OmF5BK1ac9nGlzljXaE0JsGj5fkp
         QHECUVKarV3EyFpddyVsEBAAiAFYJPdj6R13li3g57ir3VaYkqJvreavoBieMHBBdt7i
         oLeFeo297PsAiiklbBOBc5WkCt7SySPyEHlPcBl1CU0SUYZcPRmkje4mkbE2bMjxK2vz
         8+EGpqDBKa5cKLGwF80iXx8pZZvWEuKv/q1cQTuSFdyjtl/Wkfgh89ASsHCu8hYeqiqh
         ZXZgV+WqEIx8PD4xg/ADyUsa/C81zTch9g3g/Oty4JD9mpMomMo5M8+7EVJe4a/X/Byw
         6dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3vZbnaTkTQkpTOs5RyT3/aPplNkcOKw6w0UH9176lE=;
        b=ntiih+dnexc/o+16Kropgrea5bgTqawbdtavCJqjch5uCUqriwxr5nXPSGIZNRDbwL
         abeEr1DNGV6Uz+7B7++17cKciYE4MGz33bi6Bfh27OG12IfIhas1hFZOZDC2ybRyq9d+
         aPAgQly83bP1iI+ir4Ci5kBKfSAkhFKs9UwBwXj5vICkwN3HcHqeW88p9Kkps6KBTXtg
         Vi0aXIrzVsvvbjTouGSmMWNdA5o4WqD7A0gmpFmMTCkbmsKWC9x7wKEIForAtw2QPtmE
         mL+5QlZWLSgUSYiJpoZsmS9j88X2jmkZRcwAVm/1wQo5tlqdFv5vOuV3hvjtTVctQDqd
         gW6Q==
X-Gm-Message-State: APjAAAWRc0kllpWsjUxMCUWiENu0mLIMMTuE2ZEJo0FDOfGg4mN3fLdv
        9NgDNEQfHNiMx6Jvsfhbiy/2Uz9Ex91fbFJZkFLI/g==
X-Google-Smtp-Source: APXvYqwhb8rNCqSEG4S0O8Z0IppA0vQcphTr8HzWC4stka4y6ztRY/QFEGhli+vnmvOlFKnptsXfRKum3nlKLv8yzbU=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr826747wrv.0.1578426685884;
 Tue, 07 Jan 2020 11:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20200107142125.GA652888@rani.riverdale.lan> <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan> <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan> <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan> <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
 <20200107183224.GB1642410@rani.riverdale.lan> <CAKv+Gu_+8-vFFg6V06cxK4McbqOeqkAFYGB_MHDU3jcFyM1yHA@mail.gmail.com>
 <20200107191412.GA1685286@rani.riverdale.lan> <CAKv+Gu8CsQOZJErDOjCtMB-6yr92CmLiCFpOTeoqdZWBOLh1oQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8CsQOZJErDOjCtMB-6yr92CmLiCFpOTeoqdZWBOLh1oQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 20:51:14 +0100
Message-ID: <CAKv+Gu97YJ5AiG0+38fGJWfr6DWsohLrpUxGfdqaRawEhqbhTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 20:23, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 7 Jan 2020 at 20:14, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jan 07, 2020 at 08:03:18PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 7 Jan 2020 at 19:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Jan 07, 2020 at 07:10:34PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 7 Jan 2020 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> > > > > > > On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > > > > > > > >
> > > > > > > > > Unfortunately, the command line option implements a weaker form of
> > > > > > > > > visibility than the pragma, so it probably comes down to setting the
> > > > > > > > > pragma in a .h file that gets -include'd via the command line so it is
> > > > > > > > > guaranteed to be seen first.
> > > > > > > >
> > > > > > > > Tried hacking that in and it works, tested with gcc 4.6.4.
> > > > > > >
> > > > > > > Excellent. But in my testing locally, I don't get any GOT entries in
> > > > > > > the first place, strangely enough. So what changes in the output for
> > > > > > > you with visibility hidden compared to before?
> > > > > >
> > > > > > Works with 32-bit as well.
> > > > > >
> > > > > > Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
> > > > > > latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
> > > > > > in pgtable_64.
> > > > > >
> > > > >
> > > > > I am looking at the size of the .got section in
> > > > > boot/compressed/vmlinux, and it is 0x0 on 64-bit, and 0xc (i.e., only
> > > > > the .got.plt fixup code) on 32-bit.
> > > > >
> > > > > Could you please check whether passing -Bsymbolic to the linker gives
> > > > > the same result btw?
> > > > >
> > > >
> > > > With new ld all those GOTPCRELX's get eliminated. If you add --no-relax
> > > > you'll get them in the .got. I don't have an old version of binutils so
> > > > I can't check, but I think they will be assembled as GOTPCREL and remain
> > > > in the .got section after linking.
> > > >
> > >
> > > Right, unless you use hidden visibility, no?
> > >
> >
> > Right, that's what I said works before -- with hidden visibility the
> > compiler (even an old one) does not generate any GOT-using relocations.
> > We're trying to debug why you don't see any .got entries even before
> > turning on hidden visibility, while I do, no?
> >
>
> Yeah. I have just reinstalled Ubuntu Trusty in a VM, which has
> binutils 2.4 and has a GCC 4.6 package available, but I haven't tried
> building the 64-bit kernel yet.
>

I see the same thing: all GOT entries are gone when using -include to
set the pragma, with the exception of the first 0x18 bytes of the
.got.plt section, which we can ignore.

So in summary, we should be able ASSERT() in the linker script that
(_egot - _got) <= 3 * word size, and get rid of all the GOT fixup code
entirely. Or perhaps it is better to add a section marker, and assert
that the *(.got) part is really empty.
