Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7A12E96D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgABRbA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:31:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45422 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABRbA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 12:31:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so39931752wrj.12
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 09:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAMzzYUEz+xh9XHCCtcU/YJcU8PZjARUpDeeSZ5nfLc=;
        b=BuYWpk0yY43dBacywpAlbZQTxWGEAbExul3zFMzywZU5rVzfDo+5nyjM+oQqnVHyzr
         Dk0+O2iFQUvtVoJzIxNhu0PmCYc9YRwPCOtbfKjn++UTCNV361qillB1BtEKMtkJSWNr
         6tlIjCLbCpsCZDQ3EVTupKDuNPw49D9oJ1aNjqKV+r/G0I3RI3N0LjHRaeI7FOl+/YQj
         botF8IOl2g+MGEGX+UmzBJxi4p4r+xQTDt04apjDgwt5NnOVfw86n8IR39QmoxXVnkPa
         BKzZpviT0tQcRcAUJ51q2JcP1I6mt3+P3wN6D3twCVU7wG0Ymrgb0zYYDgNJR+ihlTb/
         l1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAMzzYUEz+xh9XHCCtcU/YJcU8PZjARUpDeeSZ5nfLc=;
        b=BuB4lMpmodcfSqC5+OVQtf+nm6xdIXTWSGNapUiyd8GZBJj36QiHPKR3Orj1PV7BsD
         9IUaj/1ByBd7ap3/gy+EWQBp751PSQjjXPokyNtOR1Q71cv8G2iMK3xy+GocaeOujJSx
         3pjatoveh6QmDORDPVJ98FEwN4IyQrsskpbGM4i38qeu2qXeOfgPfUWneae2Iz/rgBui
         UQefK5NX63lqJCZG+RI/XClRCVsABj+cYCt3X9zLtt6BgjF0FcYstY0i/Xta6bQJatHB
         MsyEsm3OLsAuRWdOmu+Alal8nZnG8mQq2CYfznxs8vUMTAJg/INoM0YfshkzUdmGOpdH
         wXng==
X-Gm-Message-State: APjAAAUR3gISsIVJ5Ytk8qKPtGmO+o+h/xtAy86SeTM4tVNELqT3sNs4
        Tkd/KqSeaYKpJyVT07YyEqzDT4n1ejuHgzakb9JufQ+b
X-Google-Smtp-Source: APXvYqzwtgyKYR1BWsJIscy3FsFrbsFWbtca0vBVbs8j9vg3R4EhbOKoyMCaNRSTx8K/yb/LzfW6y8CnVlCZHNdtAd0=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr78294957wrr.32.1577986257950;
 Thu, 02 Jan 2020 09:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20191231230436.GA78532@rani.riverdale.lan> <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan> <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com> <20200102172637.GB701372@rani.riverdale.lan>
In-Reply-To: <20200102172637.GB701372@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 18:30:46 +0100
Message-ID: <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
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

On Thu, 2 Jan 2020 at 18:26, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Jan 02, 2020 at 05:59:27PM +0100, Ard Biesheuvel wrote:
> > On Thu, 2 Jan 2020 at 17:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > > > >
> > > > > > Yeah, good point.
> > > > > >
> > > > > > I pushed as branch here;
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > > > >
> > > > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > > > >
> > > > > Haven't built it yet -- but how does this handle the GOT issues you
> > > > > mentioned?
> > > >
> > > > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > > > to the extern declaration of efi_is64, but I am having trouble to
> > > > reproduce the original issue.
> > >
> > > Some background:
> > >
> > > https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> > > https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
> >
> > OK, I have done a bit more digging, and it seems like recent
> > toolchains can optimize away GOT indirections using R_386_GOT32X
> > relocations, which can be converted into R_386_GOTOFF relocations by
> > the linker if it is building a fully linked binary, making the actual
> > contents of the GOT entries irrelevant.
> >
> > Note that even if the GOT entries are not fixed up, assigning a global
> > variable and then using it again may work by accident if the memory it
> > points to is writable, which is why it is not easy to reproduce
> > reliably.
> >
> > efi_is64 only exists on 64-bit, so annotating that as 'hidden' should
> > work. But efi_system_table() is also used on 32-bit, so I'll leave
> > that one alone for now.
>
> With hidden visibility, 32-bit compiler seems to generate GOTOFF
> relocations directly so it shouldn't depend on recent toolchain?
>
> https://godbolt.org/z/79iA_3

Yes, that was my assumption at the time as well, but we still ended up
with /some/ absolute GOT dereferences for some reason in the 32-bit
kernel.
