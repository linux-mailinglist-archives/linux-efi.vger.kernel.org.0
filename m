Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339EE12E905
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 17:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgABQ7k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 11:59:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgABQ7k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 11:59:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so6272247wmb.0
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWDwwabhRykEDCu4IoDL2Og/kggCgOeRE8YaN1aWEYU=;
        b=ozH5w3E+2NgHN5mfjcKtcPMwoHRL+X/0g5XwFRiK7QXDPeUSLHeVcj3clUcdONJh9O
         YFOoRL+HpaLWYPW0owTmK6RVdIfI2kxim8KsdY4wFDBSeOqM7EV3hbl9vd04sp7U3AZY
         Ba/xUhKOWJhbiW5dHEFo9x9FnFTNNH+sht5VSR+fqRBSZuASGhatqQT/2kjQi2VI01a/
         ImyUoaOvmoP541IPMXd0GCPY2ibRk86/7FImEd+LldcfoabURbOb4tE7mC3YJk2PmDu2
         ZlIMdwgjO2Km90qcJ0Eiaq2h94GyM4wau9rZ4AOZ9u/60wuv2BYtGbil4EGOb0nnJjqr
         MbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWDwwabhRykEDCu4IoDL2Og/kggCgOeRE8YaN1aWEYU=;
        b=NnoyfMo5AcXxP/oGsKUa2bqt0vWrK3JAERzndIt6TYrooTqF6Dk6ocz5OLVxdd8FXk
         suNvMaSCaaG+DqbBOdOuH+/oN09faByUFzjfucy7IrpAwJyzgP3Xw/Gb+nYVGwMPxiQt
         52bpUS09ZwgMSX7R5E/hskrydlwtaZXrV418PmthmVi/P4zqHixtuYVWO5KcRsZ4a2v1
         Qw1nCzEQBlZpJvaiH2U7y2AV33L23y55hVMKSXVuduKQRXozaoJxI8M/Ed0b1QsBAz9v
         NOoJBMXApmO29Lcx3Wfz+XftQRHVEkXDmxBx831pBa/ewHzHKYPJzyo5ibeXFvcoB538
         Zf+A==
X-Gm-Message-State: APjAAAU3JbeUXLuDZT5ys/xy8/5qklpx3ajnc7hmg6oah2izbtyyIRCa
        xqb/I2Kd5jTwFW+AuNt9//yM+oxG7G+93s6FMohDoA==
X-Google-Smtp-Source: APXvYqzJXxl8DnjaE+P1JDyx1JuVSKzGV/ak8ugO+/KxK5PkfnyQEEYanoQpfwW7cOY61onRS//UJ6xz+62h72c5e6c=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr14466901wme.52.1577984378591;
 Thu, 02 Jan 2020 08:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan> <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan> <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 17:59:27 +0100
Message-ID: <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
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

On Thu, 2 Jan 2020 at 17:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > >
> > > > Yeah, good point.
> > > >
> > > > I pushed as branch here;
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > >
> > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > >
> > > Haven't built it yet -- but how does this handle the GOT issues you
> > > mentioned?
> >
> > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > to the extern declaration of efi_is64, but I am having trouble to
> > reproduce the original issue.
>
> Some background:
>
> https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/

OK, I have done a bit more digging, and it seems like recent
toolchains can optimize away GOT indirections using R_386_GOT32X
relocations, which can be converted into R_386_GOTOFF relocations by
the linker if it is building a fully linked binary, making the actual
contents of the GOT entries irrelevant.

Note that even if the GOT entries are not fixed up, assigning a global
variable and then using it again may work by accident if the memory it
points to is writable, which is why it is not easy to reproduce
reliably.

efi_is64 only exists on 64-bit, so annotating that as 'hidden' should
work. But efi_system_table() is also used on 32-bit, so I'll leave
that one alone for now.
