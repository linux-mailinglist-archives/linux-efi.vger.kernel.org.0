Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45D20558E
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jun 2020 17:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgFWPKs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 11:10:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43135 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPKs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Jun 2020 11:10:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id j189so19073897oih.10
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 08:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3hP5oHCaXN75NyHCf5KFlr6OfUoup3sO+AZV8gc4Ew=;
        b=fI2n0AA6+HH7o/9Q1kpHdRgZTVGJ2HcDOkV//uV2tS7uPscZa4NkLAaW+XR7f7fZIb
         VPFoopHT3ECK0LulQAs8yogAHg8ZyowdHxPGmkPjNibebw/1Gi1m55aX8DV+3We74zFe
         JMmjRhRlvZfeVW7jqLTRk13UJcp0i1PXVCM3bCkmZb365nql5y+MC7XZr+Dapm5PVhcK
         EwHgsF1mCu/znMW6pC64KN6AQmW6Q5F/zVJIYmHRLERW0eaBmT4fAMCFsINyMYn+sxUu
         njyZJYcyyXmdz7lnAzTK5DTkVQ5boRXbbqlv0xl3orktORCSTWgmpmxpkXDqCYqTanGP
         uyCA==
X-Gm-Message-State: AOAM532CaEBfu2UQ8Hdum6e4aZf7zXSdcYEoB7R/ztQdWmGqECFftNLV
        wxXd/jKU5dke5S+s5KKzjgTekKyLUH0UKKVIRdE=
X-Google-Smtp-Source: ABdhPJyMkETqC0ecO+nYMKp/yAnXV+zZmpZB18C1F0vSusrvzuvB6gCWdi/H0Rr7FMuveFd3rDJZddXRbL/a30K67so=
X-Received: by 2002:a54:4006:: with SMTP id x6mr16000968oie.148.1592925047111;
 Tue, 23 Jun 2020 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org> <20200422172414.6662-3-ardb@kernel.org>
 <CAMuHMdXZM7XYBt=2dJFJi+xxe2HOh43KzSkxGoMqaaC_kc_P-g@mail.gmail.com> <CAMj1kXH3HgmqrEct1ANNNZqb3R+YNpvp+TDkjF7b=1MYFtNa3g@mail.gmail.com>
In-Reply-To: <CAMj1kXH3HgmqrEct1ANNNZqb3R+YNpvp+TDkjF7b=1MYFtNa3g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Jun 2020 17:10:34 +0200
Message-ID: <CAMuHMdVjKQdZ=mMds_h+=ZOZTUZyf34Lu99xjyavtEG_mgRwUQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] efi/libstub: Make initrd file loader configurable
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hoi Ard,

On Tue, Jun 16, 2020 at 10:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 16 Jun 2020 at 09:55, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Apr 22, 2020 at 7:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > Loading an initrd passed via the kernel command line is deprecated: it
> > > is limited to files that reside in the same volume as the one the kernel
> > > itself was loaded from, and we have more flexible ways to achieve the
> > > same. So make it configurable so new architectures can decide not to
> > > enable it.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Thanks for your patch, which is now commit cf6b83664895a5c7
> > ("efi/libstub: Make initrd file loader configurable")!
> >
> > > --- a/drivers/firmware/efi/Kconfig
> > > +++ b/drivers/firmware/efi/Kconfig
> > > @@ -124,6 +124,17 @@ config EFI_ARMSTUB_DTB_LOADER
> > >           functionality for bootloaders that do not have such support
> > >           this option is necessary.
> > >
> > > +config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> > > +       bool "Enable the command line initrd loader"
> > > +       depends on EFI_GENERIC_STUB
> > > +       default y
> > > +       help
> > > +         Select this config option to add support for the initrd= command
> > > +         line parameter, allowing an initrd that resides on the same volume
> > > +         as the kernel image to be loaded into memory.
> > > +
> > > +         This method is deprecated.
> >
> > So why the default y?
>
> Every time I try to disable something like this, someone pops out of
> the woodwork to explain how the feature is so vitally important for
> their highly bespoke and vertically integrated boot flow that it has
> to be enabled by default for absolutely everybody.
>
> But patches welcome :-)

Done
https://lore.kernel.org/linux-efi/20200623150935.32181-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
