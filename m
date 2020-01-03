Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127F012F924
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 15:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgACOXY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 09:23:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44134 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgACOXY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jan 2020 09:23:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so3636661wrm.11
        for <linux-efi@vger.kernel.org>; Fri, 03 Jan 2020 06:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gi0DZpr0qeDTj1+4L+h14X28Rm9afD0mtH0nuAUrYlo=;
        b=WZq+1oT9yXalbweiNNuMnloSBL282Mo+1m+HQ81CUtFHEx1FsmR6IFsOkhxmbiE3xI
         57sKCe7w6xtqwE5O1XKVNjuMViFl4TWyaOB3k8SnW3aEDwRNbkNGEK8zF/eNQyZLEBot
         YPFSFCMF8Z1eWKWUdnRofE1GuMnOSF5dHwO758NsCIbJ78Vl9vP7Jqje7et4xkKqotOn
         xHPQ1QIhiUpMNe9EHlbLETMe0xl6Mu9TncYGqtghtzp7NvzWio+QUvT91L1mVfUTbQd9
         1Pj/OXQa7m7q2gy3gnrASfh67SWRX7Osk6ewrm+74KVIqcrN5Y1cgYz716Di5QVCm6S9
         bDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gi0DZpr0qeDTj1+4L+h14X28Rm9afD0mtH0nuAUrYlo=;
        b=CTuYN0HcjZTX13TYPfOeNU25Vfwu1Q+rPm1VaqICfNaQc2b2axsyvWd8CAu4e+wCC5
         gbAuTPlyeTNw/tn4MBmDCxTW5cKkiQjUfvMlEpOI9miUug9nBJuwwm9J7f1+ru2r9o99
         mGY1OUdpPGUpDxoJA5IhACjTrhw55GbunwtQmharDXcKXO9iBz9bH3LeMXTi4mYwfloW
         BAIC5zXn9Ae/XOiHh1+mhxS7c6N1ZGkuqA3UQ/Owbu8Squdo6FETyt6AauVxFYG2lB2m
         pqM+9lAp8xDi6kZ6ehL6DelqGfxwmOa2HljwNiInMXh7jf7zVgn6lmHTdUy+Y5E4Y7CB
         Pyow==
X-Gm-Message-State: APjAAAUR+0ByG7rp7L//XM78EPLBeeont6dsMrKyjD47PbKh8doKowZ8
        vNJs+U02Q/gk4kQJQBo6LBkw3LmLewouU0k1Xa/wmQ==
X-Google-Smtp-Source: APXvYqxmZZbf7P8f353NuB9NPdNXzP7RUjOgAEPIo2elscT33RLr3oCG2+ZazS4u9endCJCk5nlXPFrBt5Xzdfrmgec=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr86451416wrs.200.1578061401967;
 Fri, 03 Jan 2020 06:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan> <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
 <20200102174142.GA713602@rani.riverdale.lan> <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
 <20200102181015.GA720259@rani.riverdale.lan> <CAKv+Gu8stpJ2YZ6sJb5WvwftNy9SDsQpxoS1uH0FV5vXQKvihA@mail.gmail.com>
 <20200103141658.GA1204556@rani.riverdale.lan>
In-Reply-To: <20200103141658.GA1204556@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 Jan 2020 15:23:10 +0100
Message-ID: <CAKv+Gu8NcdQ915cRnMCPtMRh+EGSjm0e+Uv6j48qraxzXS7dEA@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Jan 2020 at 15:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Jan 02, 2020 at 07:38:06PM +0100, Ard Biesheuvel wrote:
> > On Thu, 2 Jan 2020 at 19:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Thu, Jan 02, 2020 at 06:48:52PM +0100, Ard Biesheuvel wrote:
> > > > Currently, I am not managing to get the 64-bit compiler to emit any
> > > > GOT based references for efi_is64, though, even without the attribute,
> > > > so I am not sure what's going on there.
> > >
> > > With gcc 9, I do get R_X86_64_REX_GOTPCRELX relocations in libstub,
> > > which are then eliminated by the linker -- if they weren't they would be
> > > using addresses from the GOT. They turn into R_X86_64_PC32 with the
> > > hidden visibility.
> >
> > Indeed. I was looking at eboot.o but that gets built with -fPIE not
> > -fPIC [if available].
> >
> > libstub objects indeed have the R_X86_64_REX_GOTPCRELX relocations, so
> > I'll add the hidden visibility to the extern declaration of efi_is64
>
> Is there any reason not to compile the stub with -fPIE btw? Also fPIE
> seems to be there even in gcc 4.1.2, the check for availability can
> probably be dropped.

No we should switch to -fPIE for the stub as well
