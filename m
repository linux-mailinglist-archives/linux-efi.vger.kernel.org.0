Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05766193D1B
	for <lists+linux-efi@lfdr.de>; Thu, 26 Mar 2020 11:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCZKlN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Mar 2020 06:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbgCZKlN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Mar 2020 06:41:13 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D4F20748;
        Thu, 26 Mar 2020 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585219272;
        bh=TGhiOgIo8mu4ICaKE4XoCYAUUeJUBx2f8IkX5r2oMkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=APt9412EG6wRy1czJx85YKYi/77Br/aABhgUQO3nGf/vDkRVqLIfDl6jLQYSfyfNW
         O3OwE4IhxLrPPw/wzFm4tBsxa9Xu22sqiP82eg7UYJKv58fRVJZRR2sPdUmca75qIN
         8eBTaKdVyC4UxFO9HZG/3NMoURPoMbPHQKBUU+PQ=
Received: by mail-io1-f49.google.com with SMTP id q128so5479441iof.9;
        Thu, 26 Mar 2020 03:41:12 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2+jvHKyLeipfsbWUaqDG8pYBccKf9OFjxW/WSB/HbR7mWXSHmp
        e5+ertWdW1G+09W+Td1g5Y1ZmkA0fnjS3kaSN5Q=
X-Google-Smtp-Source: ADFU+vtXWAa8jEzHaRrDYuVCckhd0577w1oqJr9NSevD47d3S/fZkMCLTNr83zkkYPdG023H5yPt0TxIk3pZEp2hC9U=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr449328iot.161.1585219271544;
 Thu, 26 Mar 2020 03:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200319192855.29876-1-nivedita@alum.mit.edu> <20200320020028.1936003-1-nivedita@alum.mit.edu>
 <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
 <20200325221007.GA290267@rani.riverdale.lan> <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Mar 2020 11:41:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFBB4RmokpM7nqm3jPQofDhfC89QuEurz6OwNPureVK8g@mail.gmail.com>
Message-ID: <CAMj1kXFBB4RmokpM7nqm3jPQofDhfC89QuEurz6OwNPureVK8g@mail.gmail.com>
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

On Thu, 26 Mar 2020 at 00:36, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 25 Mar 2020 at 23:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Mar 25, 2020 at 05:41:43PM +0100, Ard Biesheuvel wrote:
> > > On Fri, 20 Mar 2020 at 03:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > This series is against tip:efi/core.
> > > >
> > > > Patches 1-9 are small cleanups and refactoring of the code in
> > > > libstub/gop.c.
> > > >
> > > > The rest of the patches add the ability to use a command-line option to
> > > > switch the gop's display mode.
> > > >
> > > > The options supported are:
> > > > video=efifb:mode=n
> > > >         Choose a specific mode number
> > > > video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
> > > >         Specify mode by resolution and optionally color depth
> > > > video=efifb:auto
> > > >         Let the EFI stub choose the highest resolution mode available.
> > > >
> > > > The mode-setting additions increase code size of gop.o by about 3k on
> > > > x86-64 with EFI_MIXED enabled.
> > > >
> > > > Changes in v2 (HT lkp@intel.com):
> > > > - Fix __efistub_global attribute to be after the variable.
> > > >   (NB: bunch of other places should ideally be fixed, those I guess
> > > >   don't matter as they are scalars?)
> > > > - Silence -Wmaybe-uninitialized warning in set_mode function.
> > > >
> > >
> > > These look good to me. The only question I have is whether it would be
> > > possible to use the existing next_arg() and parse_option_str()
> > > functions to replace some of the open code parsing that goes on in
> > > patches 11 - 14.
> > >
> >
> > I don't think so -- next_arg is for parsing space-separated param=value
> > pairs, so efi_parse_options can use it, but it doesn't work for the
> > comma-separated options we'll have within the value.
> >
> > parse_option_str would only work for the "auto" option, but it scans the
> > entire option string and just returns whether it was there or not, so it
> > wouldn't be too useful either, since we have to check for the other
> > possibilities anyway.
> >
> > It would be nice to have a more generic library for cmdline parsing,
> > there are a lot of places that have to open-code option parsing like
> > this.
> >

OK, I have queued these up now in the EFI next branch, but this will
obviously have to wait for v5.8

Thanks
