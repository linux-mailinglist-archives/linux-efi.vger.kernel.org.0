Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1A132EF2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 20:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgAGTDc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 14:03:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38939 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTDc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 14:03:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so670589wrt.6
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u860bbezjEfmsnbgv1nQTSpRYGJFxU5gF19JvIsqKlI=;
        b=G6RmUI0hEwPyo4KsTTBWWby5p26vvamrZXOh25qXHK4l3xfndvC4/SHcs5tX2OjDCX
         I4uWZwG1EpfWOF0WSqikDttR77Bj+wl7/JAfKuX/S6MU6FgbTkUUL0rrPNjBVyurg+0i
         W9EU5/h5wtv6D2I7157teg7tsMsqtTEtJqK3ffd8hO2ihtLfkv0M8nceJdAWJ/AE7X0n
         psnTEf9cte5RJXb2/49TCmjyM1RZVemF9NuRqIKDd+3A67DE8/lBTMFks1OSmCSuAgoW
         chtnDoPL7t32dvntsQVO7DsZvbdoVX0QlGa2FQdROBKgaqTdb7QBgYwynjv4CjiNj+1g
         mTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u860bbezjEfmsnbgv1nQTSpRYGJFxU5gF19JvIsqKlI=;
        b=Dws3R419FaEIrMOczmGLE3RzBiHOCASEFg1qlAKlupnPqKE1Vi/wa+G6UzxHbm/caH
         GRq3bQiUcLwjXrEtWUkxVLUmhuExiVuQCAwdQHkPFIhtolXoAL3iHMdeGVefrj6krOoG
         l1MA6yYClnp+M7EBdeNLYHpX0GYP1jmgoZl2LA73h464wke/WHAde/fI2MxA+7JQrHtT
         XUR4BUuqZdNDhhl5eFGUylihvvQSvjtmljuLHhcH0TZNO0ObTg5zcL4lmVkzUpIGzlyN
         BkH7vqsE0UkYelfpQxc7zCcDFySE1qug1uBfxovHeJ+3fmRV8ffFLMSzegw8D0oacA9S
         YLwQ==
X-Gm-Message-State: APjAAAX9HsDF6HXbSwogKWl2aqW7BQ5Qi23Le6FM3YC5ZFaH6JMYW8Mp
        G6njEhasDiSfUEs+KhXqmNW7PVZpeclCy4en+WHusw==
X-Google-Smtp-Source: APXvYqwSgOr9r5kayWNQUQi8kZeNbP2YeJjM+wNlHJCzQ8YwOT3QQRi/21GRvZfaxtqFTGlf/H8We9qidPXDNJjhM1w=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr592271wrw.246.1578423810129;
 Tue, 07 Jan 2020 11:03:30 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan> <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan> <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan> <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan> <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
 <20200107183224.GB1642410@rani.riverdale.lan>
In-Reply-To: <20200107183224.GB1642410@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 20:03:18 +0100
Message-ID: <CAKv+Gu_+8-vFFg6V06cxK4McbqOeqkAFYGB_MHDU3jcFyM1yHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 19:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jan 07, 2020 at 07:10:34PM +0100, Ard Biesheuvel wrote:
> > On Tue, 7 Jan 2020 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > > > > >
> > > > > > Unfortunately, the command line option implements a weaker form of
> > > > > > visibility than the pragma, so it probably comes down to setting the
> > > > > > pragma in a .h file that gets -include'd via the command line so it is
> > > > > > guaranteed to be seen first.
> > > > >
> > > > > Tried hacking that in and it works, tested with gcc 4.6.4.
> > > >
> > > > Excellent. But in my testing locally, I don't get any GOT entries in
> > > > the first place, strangely enough. So what changes in the output for
> > > > you with visibility hidden compared to before?
> > >
> > > Works with 32-bit as well.
> > >
> > > Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
> > > latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
> > > in pgtable_64.
> > >
> >
> > I am looking at the size of the .got section in
> > boot/compressed/vmlinux, and it is 0x0 on 64-bit, and 0xc (i.e., only
> > the .got.plt fixup code) on 32-bit.
> >
> > Could you please check whether passing -Bsymbolic to the linker gives
> > the same result btw?
> >
>
> With new ld all those GOTPCRELX's get eliminated. If you add --no-relax
> you'll get them in the .got. I don't have an old version of binutils so
> I can't check, but I think they will be assembled as GOTPCREL and remain
> in the .got section after linking.
>

Right, unless you use hidden visibility, no?

> A linker option can't help I'd think, because once these relocations are
> there in the object files, you need the new binutils to get rid of them.
> I didn't get any difference with -Bsymbolic -- also that seems to be for
> shared libraries, with executables the references should already be
> bound within the executable, shared libraries can't override them.

PIE and .so support share a *lot* of code in binutils. In the arm64
kernel, we use Bsymbolic to get rid of a few absolute symbol
references, even though the -pie linker option should take care of
that, but it doesn't in all cases.
