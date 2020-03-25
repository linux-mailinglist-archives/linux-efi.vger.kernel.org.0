Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1963F1934AF
	for <lists+linux-efi@lfdr.de>; Thu, 26 Mar 2020 00:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYXgh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 19:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgCYXgh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Mar 2020 19:36:37 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD8D2073E;
        Wed, 25 Mar 2020 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585179396;
        bh=ukXAg6nYJ1E268DR5bTQMqn2OedkLGJ7YazVsubImkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jWDzNsH6Tk+blCQ8Em7ZZvBdcbpw1zDwZ6XgEQSajuLvr6mSMsBblvlaKcTqhNqs+
         +q9VwwfGKIERVzPW9hEQvcR/X2L1YaR9TK1a+B9nrrIA0usmLKNU45NhxXvJSpsbYN
         MQ9zBTb//9FmRJvFn8vtNHFvUUNLU1Tan8XKFqcE=
Received: by mail-io1-f52.google.com with SMTP id o127so4236630iof.0;
        Wed, 25 Mar 2020 16:36:36 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0Xn5if8iNxiI61TtFQXcjwLzos5eQD9Gt/Lv8q8AGv3e3Z4Z+b
        5/i1Au/RMLnwBgVjX2Eq+Al4xm2xypXTtcdvKYA=
X-Google-Smtp-Source: ADFU+vt7JfYewC9XJVSMC7wWqtWpaf5vW35mzoPxpsZefDzyM9nlC1FlxzDmuShI3Sp3HeUAF2XUO6LnlRNygsoiOaY=
X-Received: by 2002:a5d:980f:: with SMTP id a15mr5262315iol.203.1585179395943;
 Wed, 25 Mar 2020 16:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200319192855.29876-1-nivedita@alum.mit.edu> <20200320020028.1936003-1-nivedita@alum.mit.edu>
 <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com> <20200325221007.GA290267@rani.riverdale.lan>
In-Reply-To: <20200325221007.GA290267@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Mar 2020 00:36:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
Message-ID: <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Mar 2020 at 23:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 25, 2020 at 05:41:43PM +0100, Ard Biesheuvel wrote:
> > On Fri, 20 Mar 2020 at 03:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > This series is against tip:efi/core.
> > >
> > > Patches 1-9 are small cleanups and refactoring of the code in
> > > libstub/gop.c.
> > >
> > > The rest of the patches add the ability to use a command-line option to
> > > switch the gop's display mode.
> > >
> > > The options supported are:
> > > video=efifb:mode=n
> > >         Choose a specific mode number
> > > video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
> > >         Specify mode by resolution and optionally color depth
> > > video=efifb:auto
> > >         Let the EFI stub choose the highest resolution mode available.
> > >
> > > The mode-setting additions increase code size of gop.o by about 3k on
> > > x86-64 with EFI_MIXED enabled.
> > >
> > > Changes in v2 (HT lkp@intel.com):
> > > - Fix __efistub_global attribute to be after the variable.
> > >   (NB: bunch of other places should ideally be fixed, those I guess
> > >   don't matter as they are scalars?)
> > > - Silence -Wmaybe-uninitialized warning in set_mode function.
> > >
> >
> > These look good to me. The only question I have is whether it would be
> > possible to use the existing next_arg() and parse_option_str()
> > functions to replace some of the open code parsing that goes on in
> > patches 11 - 14.
> >
>
> I don't think so -- next_arg is for parsing space-separated param=value
> pairs, so efi_parse_options can use it, but it doesn't work for the
> comma-separated options we'll have within the value.
>
> parse_option_str would only work for the "auto" option, but it scans the
> entire option string and just returns whether it was there or not, so it
> wouldn't be too useful either, since we have to check for the other
> possibilities anyway.
>
> It would be nice to have a more generic library for cmdline parsing,
> there are a lot of places that have to open-code option parsing like
> this.
>
> There's one thing I noticed while working at this, btw. The Makefile
> specifies -ffreestanding, but at least x86 builds without having to
> specify that. With -ffreestanding, the compiler doesn't optimize string
> functions -- strlen(string literal) into a compile-time constant, for
> eg. A couple hundred bytes or so can be saved by removing that option,
> if it also works for ARM.

Yes, -ffreestanding implies -fno-builtin, which means that the
compiler cannot assume it knows (and can optimize away) the behavior
of strlen(), memset(), etc.
