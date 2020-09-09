Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1141B2636AF
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIIThV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIIThU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 15:37:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF2C061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 12:37:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q8so2244142lfb.6
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPGUAuIBFZcqoF/v+sYHcnNejitzVZu2snfNU6ewbYU=;
        b=ZOt7VoI9EsfIlKceGpmM+SLcYp1NM5WdyxiQAimQQS96y8Jfez4MXLF+2Ff4pVyj7Q
         KAXrTcO/bOjTmikpfgFn8NqTIBN33B9+G25znyAyvUoWZ18ggony7DtjYDLUCCSWdKZV
         FzzWu6wQjabjqfOFyaHt2fZd1lGUkjP0bVYmHR3B7M0v9273dKVqtzQq9yuQTm/m+qbt
         9xczSB2/CN73F+jHjvIvniL5FN6w/GXMBBMBiE6KkWHPll63Ec+Yi2SSaY+7s6x6/Opp
         r58leTmA5lX4NzCNsNBx5IPQPMPJBOTJK4yOGz7v6OvO1xA8JKeMfojnVfOY6IMdrKx1
         NwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPGUAuIBFZcqoF/v+sYHcnNejitzVZu2snfNU6ewbYU=;
        b=duD66o2jPVPkgp7eWs8VYCXcu+f0b82h9Xy5P6NGLUS4FqI1ccOWMf3FA0YAxlGHK9
         wmRE3qooMdoJ7AOmCjCD+unXBbqiJR5Lgw1Ea6wLqkPsJp+H0RoyTtRC9U4EvNF/RTz9
         Z3IKd6jH12iKTeN1iZed5bF2KkjMcpfauc5yldNnHCwR1HeLOJUmu5vpxI6ereShWeCl
         mnkNFThWhdoAjLkAbuTqNOuGv+bu7OpL61NHEj8DXSz9bIJrzCtTKVcCoENOP4aMFofv
         mbUyCAyc2iGm0Xbk42BBJ9URTSnqhBr8eNIs8JWPkLRQZckp8wYDezfCBPoyebgmOm5s
         QwHg==
X-Gm-Message-State: AOAM5317DZ0NFr+h6lCjHTQesWLE81wWu74sM1S4IUR1HforzEjjx0es
        cvjJoLnT0zlSHlOc+dtdgS1S01MtKS/ZR006/n8=
X-Google-Smtp-Source: ABdhPJydee+EIk26mpA7CRWp34NtVqVe9d34wxaME9FlR2mgcSjnjqjNsDiuaibsebf32551gsrk5Rfr+TfiD779WtM=
X-Received: by 2002:a05:6512:2102:: with SMTP id q2mr2565846lfr.14.1599680233768;
 Wed, 09 Sep 2020 12:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan> <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan> <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan>
In-Reply-To: <20200909190038.GA474185@rani.riverdale.lan>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Wed, 9 Sep 2020 21:37:02 +0200
Message-ID: <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
Subject: Re: EFISTUB arguments in Dell BIOS
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 21:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Sep 09, 2020 at 07:34:59PM +0200, Jacobo Pantoja wrote:
> > On Wed, 9 Sep 2020 at 00:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Wed, Sep 09, 2020 at 12:12:35AM +0200, Jacobo Pantoja wrote:
> > > > >
> > > > > Just to check, are you directly booting from firmware into the EFI stub,
> > > > > or do you have something (grub2/systemd-boot/refind etc) in between?
> > > > > Which kernel version are you using, and are you able to compile your own
> > > > > kernel with patches for testing? If so, we should be able to add in some
> > > > > debug statements in the EFI stub itself to see what the firmware passed
> > > > > it as the command line, and if it's getting truncated or something.
> > > > >
> > > > Yes I'm booting directly from firmware into EFI stub, no
> > > > grub2/systemd-boot/refind
> > > > involved. My current kernel is 5.8.5.
> > > > I'm able to compile kernel with patches, no problem.
> > > > As a side note, the exact same kernel with the exact same efibootmgr command
> > > > is booting in other machines (different models).
> > >
> > > Great. Can you test the patch below? It should dump the options passed
> > > to the EFI stub, before/after converting from UTF-16 to UTF-8, and then
> > > wait for a key. If you can take a picture of the screen it should show
> > > what's going on, hopefully.
> >
> > Result saved as image:
> > https://ibb.co/vcz48vC
> >
>
> Thanks.
>
> It looks like the firmware is passing the entire contents of the
> Boot0000 variable, rather than just the load options part: I think that
> dump will be identical to the output of
>
>         od -t x2z /sys/firmware/efi/efivars/Boot0000*
>

It is almost identical. The efivar you mentioned starts with 0x0007 0x0000,
and after that, the dump is identical to the one displayed in the debug text

Attached below:
$ od -t x2z /sys/firmware/efi/efivars/Boot0000*
0000000 0007 0000 0001 0000 0050 0041 0072 0063  >........P.A.r.c.<
0000020 0068 004c 0069 006e 0075 0078 0000 0104  >h.L.i.n.u.x.....<
0000040 002a 0001 0000 0800 0000 0000 0000 a000  >*...............<
0000060 000f 0000 0000 4cf1 b0fd 1566 4c71 14b2  >.......L..f.qL..<
0000100 c0c3 92c5 ea4f 0202 0404 0022 005c 0076  >....O.....".\.v.<
0000120 006d 006c 0069 006e 0075 007a 002d 006c  >m.l.i.n.u.z.-.l.<
0000140 0069 006e 0075 0078 0000 ff7f 0004 0072  >i.n.u.x.......r.<
0000160 006f 006f 0074 003d 004c 0041 0042 0045  >o.o.t.=.L.A.B.E.<
0000200 004c 003d 0041 0072 0063 0068 0052 006f  >L.=.A.r.c.h.R.o.<
0000220 006f 0074 0020 0072 0077 0020 0071 0075  >o.t. .r.w. .q.u.<
0000240 0069 0065 0074 0020 0069 006e 0069 0074  >i.e.t. .i.n.i.t.<
0000260 0072 0064 003d 005c 0069 006e 0074 0065  >r.d.=.\.i.n.t.e.<
0000300 006c 002d 0075 0063 006f 0064 0065 002e  >l.-.u.c.o.d.e...<
0000320 0069 006d 0067 0020 0069 006e 0069 0074  >i.m.g. .i.n.i.t.<
0000340 0072 0064 003d 005c 0069 006e 0069 0074  >r.d.=.\.i.n.i.t.<
0000360 0072 0061 006d 0066 0073 002d 006c 0069  >r.a.m.f.s.-.l.i.<
0000400 006e 0075 0078 002e 0069 006d 0067 0020  >n.u.x...i.m.g. .<
0000420 0069 006e 0074 0065 006c 005f 0069 006f  >i.n.t.e.l._.i.o.<
0000440 006d 006d 0075 003d 006f 006e 0020 0061  >m.m.u.=.o.n. .a.<
0000460 0075 0064 0069 0074 003d 0030            >u.d.i.t.=.0.<
0000474


> The start of it is structured data with some attributes, the label, and
> the path to the linux image, and all this is then followed by the actual
> load options. The EFI stub conversion routine assumes only the load
> options will get passed to it (that's what the UEFI spec states), and so
> treats the first two words (0x0001 0x0000) as forming a complete string
> for the command line when converting. The initrd= processing on the
> other hand is pretty rudimentary and just scans the entire load options
> for initrd=, and so happens to work.
>
> Ard, do you think we could quirk the conversion to check if the passed
> in size was bigger than the parsed command line, and if so check to see
> if the bytes 0x7f 0xff 0x0004 (End Device Path) occur somewhere, and
> treat the stuff after that as the actual command line?

To be honest, if this is an incompliance with UEFI, Dell should fix this.
Independently of whether we setup a quirk or not, I'll contact them, in the
past I've already got some BIOS bugs fixed (although the process is slow).
Obviously I can continue doing whatever testing you may wish.

Thank you very much
