Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87C3193396
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYWKM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 18:10:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45324 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWKL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Mar 2020 18:10:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so4395021qke.12;
        Wed, 25 Mar 2020 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6hkME+S0PYlYZxwSs9MYKKNvRnw6v/XJQKR6sVxwEw=;
        b=NndamQJL8xsQ6uhwtkCYDRuQpXDOJ61VOPSE/mnQTcqcRMHCdrEMgXig0rhIZ04NeD
         XqXMEQGHAn16Go0UZU7TAL4feTgCN+AgnCTEiL+bVBezZPcdTxTMOo6xJsgf3jGfxLoM
         is5SFSPdmVapLiQkVJWtg4IaJGSnQMU/rpxg4sIx5xhyoz7B9GCnXl2F+O7aiMeBRKJp
         ADYIevtqYMB0dHRjXmhU2WobEYQrjRMqdxw36Q5323e54uS1CgQ8PvIMWrvHme305SgL
         vJeikm9awhu/kIVzjwnP8WkhKC1XMtMSlEIb5bRfH2mgKAR1y56IcnmTmtto0l1hQOiD
         9QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6hkME+S0PYlYZxwSs9MYKKNvRnw6v/XJQKR6sVxwEw=;
        b=hNZqxRFLvHpkHOxowd52gSi0jbD2JLYjYQjvQW33d1dVn3NAAhqqA3rRMYruqm4u5/
         9aEfbKFwdEhPAzXuujrltNky/rQQiAvDov59JxtghTcKFvEGykDdCZIPDhoLahy0mnqR
         HapRMxMotSgyK/qsj/qHjNsfb8f8oe4QBKfTa9ONyWDc32uAgbr74ZBe6M34A6zGZeCh
         Tivid/EWCvZ7evJmUk11jfNWmFuDjDM2pyQz4iSbhnTbvK8uORAtSWfRKQPUA4zZcZBf
         DwKYtCjy2Plwjj5mvcoYEqqHZSgDAeWar26Cnwe8hU9WDqwP2CUdizLMT58gngbEgcQQ
         WZoA==
X-Gm-Message-State: ANhLgQ1ScYbkcq/99dGJu0cNLNPjhyyPYdeBfgPT3aAUw5E6bIqbBMwh
        jn4imnzi6bHIxm6C9JEV9dA=
X-Google-Smtp-Source: ADFU+vvnVZKet6TW1bmTmL4LFrJX2tvJ/po9HvmuayBQalnCFpULIuWafVvKkcssta2fYIRc3IH+GA==
X-Received: by 2002:a37:6606:: with SMTP id a6mr5051094qkc.364.1585174210448;
        Wed, 25 Mar 2020 15:10:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d201sm129006qke.59.2020.03.25.15.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:10:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 25 Mar 2020 18:10:08 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
Message-ID: <20200325221007.GA290267@rani.riverdale.lan>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
 <20200320020028.1936003-1-nivedita@alum.mit.edu>
 <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 25, 2020 at 05:41:43PM +0100, Ard Biesheuvel wrote:
> On Fri, 20 Mar 2020 at 03:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > This series is against tip:efi/core.
> >
> > Patches 1-9 are small cleanups and refactoring of the code in
> > libstub/gop.c.
> >
> > The rest of the patches add the ability to use a command-line option to
> > switch the gop's display mode.
> >
> > The options supported are:
> > video=efifb:mode=n
> >         Choose a specific mode number
> > video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
> >         Specify mode by resolution and optionally color depth
> > video=efifb:auto
> >         Let the EFI stub choose the highest resolution mode available.
> >
> > The mode-setting additions increase code size of gop.o by about 3k on
> > x86-64 with EFI_MIXED enabled.
> >
> > Changes in v2 (HT lkp@intel.com):
> > - Fix __efistub_global attribute to be after the variable.
> >   (NB: bunch of other places should ideally be fixed, those I guess
> >   don't matter as they are scalars?)
> > - Silence -Wmaybe-uninitialized warning in set_mode function.
> >
> 
> These look good to me. The only question I have is whether it would be
> possible to use the existing next_arg() and parse_option_str()
> functions to replace some of the open code parsing that goes on in
> patches 11 - 14.
> 

I don't think so -- next_arg is for parsing space-separated param=value
pairs, so efi_parse_options can use it, but it doesn't work for the
comma-separated options we'll have within the value.

parse_option_str would only work for the "auto" option, but it scans the
entire option string and just returns whether it was there or not, so it
wouldn't be too useful either, since we have to check for the other
possibilities anyway.

It would be nice to have a more generic library for cmdline parsing,
there are a lot of places that have to open-code option parsing like
this.

There's one thing I noticed while working at this, btw. The Makefile
specifies -ffreestanding, but at least x86 builds without having to
specify that. With -ffreestanding, the compiler doesn't optimize string
functions -- strlen(string literal) into a compile-time constant, for
eg. A couple hundred bytes or so can be saved by removing that option,
if it also works for ARM.
