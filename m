Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718EB1427E7
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 11:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgATKK5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 05:10:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33929 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKK4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 05:10:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so14366056wmi.1
        for <linux-efi@vger.kernel.org>; Mon, 20 Jan 2020 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IC/QVeLGHsHP2XiECtl+m3cxPdzoKiYBn+WPuNb2MaU=;
        b=k/Jqx9NENZ6s0IMDJ4X50U/lEEBa+qlAS3gloyI2Airk7w0WC+8Hut0uufI/HLmhVd
         2x/jnU5uYkyWMcFgZEEBScS70/rJQUh3QKJ+fPhtw1s9KcPeRSlX0gvGlZucgO1oHyJv
         IZo4aY+X5DlarCZcxrJDe9b3JeBYqm2zTUug1xKwU6hAFK71sDDGJggqJNMhuWPRW3TG
         1c/HpqLmvtLN/dRlwKJ3UmI3RF16id/w8JVYAgZJBRhF4BORclL4jNzYqq/K4M/NRSqD
         MtS3pTI7V+rvg+qOAW6qxnzwbOuxKuw4emWzjr8fj/YtRuD+lY3WM6usbAPl9DPBkgL1
         vG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IC/QVeLGHsHP2XiECtl+m3cxPdzoKiYBn+WPuNb2MaU=;
        b=aRTNJdEpsr+SkSWc+xH5fNHcfUCSOZuronQ967JhgrBTz6pq/hJYPrBoYt+L5ptU3R
         95AIUjs0YBfimw1vYPAZFkLxjO37WCKMEWd0CtPbpBAnmoT0WVwpKi+0LgGSXEu408Zo
         FiElFxL+P4++lRqkVr7qOV07EUlJN7nKFmAnlvyDQifuf0bhIwzheX0xNJugRt966bB9
         dyDiWpVHidDMujqPSwqksdTCWbe770ef7TN2gj6symOgpexMeSiOmJV14dn8AGwEYflF
         Yt5b7wTy8Sgf7Njm+LHixly0tvxK9gJv4Qgc3murRw9PHfQN9BoLbUp3iXsTWVXHgzMq
         OOTw==
X-Gm-Message-State: APjAAAVKJkLzCylAQlQtZGGPUeFSckr1+DQvuwXeWenYxQNk/TliR/6G
        Y8exD+4mGLeXY+LyCUMUfSOQMoa71R+jkX0JDmQo/vzzk/iMSA==
X-Google-Smtp-Source: APXvYqyhCktpoKylKaWGhWzUI0/ECEttjja5XUdXc0UXM1n70kKsh8emc2si/n3dAdyKr+707IExW8RUfSLIH6gjTX0=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr18945377wmf.133.1579515053793;
 Mon, 20 Jan 2020 02:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20200118165705.16544-1-ardb@kernel.org> <20200120094856.GA102981@gmail.com>
 <CAKv+Gu8_gn8b1iUg9hjd+KddCoOtb4gsxQTQ_devWy8WUJDjyg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8_gn8b1iUg9hjd+KddCoOtb4gsxQTQ_devWy8WUJDjyg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 20 Jan 2020 11:10:42 +0100
Message-ID: <CAKv+Gu8HAbJexSvgSd5B_rPtGAWgGOMCue1RovA-izdHLbSpPw@mail.gmail.com>
Subject: Re: [PATCH 0/3] EFI fixes for -next
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Jan 2020 at 11:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 20 Jan 2020 at 10:49, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > A couple of fixes for more unusual configurations that weren't caught in
> > > my testing before. One for KASAN, one for the LLVM linker and one for the
> > > old EFI memory map when running on mixed mode systems.
> > >
> > > These apply onto the Git pull request [0[ that I sent out at the beginning
> > > of the week.
> > >
> > > [0] https://lore.kernel.org/linux-efi/20200113172245.27925-1-ardb@kernel.org/
> > >
> > > Ard Biesheuvel (3):
> > >   efi/x86: avoid KASAN false positives when accessing the 1:1 mapping
> > >   x86/boot/compressed: relax sed symbol type regex for LLVM ld.lld
> > >   efi/x86: disallow efi=old_map in mixed mode
> > >
> > >  arch/x86/boot/Makefile         |  2 +-
> > >  arch/x86/platform/efi/efi_64.c | 11 ++++++-----
> > >  arch/x86/platform/uv/bios_uv.c |  2 +-
> > >  3 files changed, 8 insertions(+), 7 deletions(-)
> >
> > Just a minor bugreport, in some (weird) config combinations we now get
> > this build failure:
> >
> >   ld: arch/x86/platform/efi/efi_64.o: in function `efi_set_virtual_address_map':
> >   efi_64.c:(.init.text+0x1419): undefined reference to `__efi64_thunk'
> >   ld: efi_64.c:(.init.text+0x1530): undefined reference to `efi_uv1_memmap_phys_prolog'
> >   ld: efi_64.c:(.init.text+0x1706): undefined reference to `efi_uv1_memmap_phys_epilog'
> >
> > Config attached.
> >
> > I believe the trigger condition is:
> >
> >   !CONFIG_X86_UV
> >   CONFIG_EFI=y
> >
>
> Strange.
>
> Those references to missing symbols are guarded by efi_is_mixed() and
> efi_have_uv1_memmap(), both of which are static inline bool()
> functions wrapping IS_ENABLED() checks against CONFIG_EFI_MIXED and
> CONFIG_X86_UV, respectively. IOW, it is unexpected that the compiler
> doesn't const-propagate those expressions and optimize away the
> references entirely.
>

I think we should simply add the following - this should also cover
the remaining mixed mode KASAN issue that I mentioned.

diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 7ec3a8b31f8b..84b09c230cbd 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
+KASAN_SANITIZE := n
+GCOV_PROFILE := n

 obj-$(CONFIG_EFI)              += quirks.o efi.o efi_$(BITS).o
efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)                += efi_thunk_$(BITS).o
