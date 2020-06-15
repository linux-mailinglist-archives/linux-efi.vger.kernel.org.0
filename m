Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4B1F99F9
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgFOOUO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 10:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbgFOOUN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 10:20:13 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3316D2074D;
        Mon, 15 Jun 2020 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592230813;
        bh=HUOCydLumSxottDevVSLTHdpEfx02efaglSNcqOyA1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rxrDTinJAYv67vU3pv3GEGSXu0O0GeIxA/gLRFYKN9K8aTIslE5/sL+ikA+jvg1ux
         GnFsxHtvt1ZUS1ALBJBPVMd6UNCJBBmR4R/dLq/DUHREEr13PyFULm4FJB9p2lS2eU
         gHEFHYUDOR64bxN0dtNHR5XTrtcOZnQoKHnz9imo=
Received: by mail-ot1-f54.google.com with SMTP id g5so13219472otg.6;
        Mon, 15 Jun 2020 07:20:13 -0700 (PDT)
X-Gm-Message-State: AOAM530Iug82uYHhdbXmsUFZXm3CNMhfXfowu6B8uEYvLrIw86LXWvTJ
        vlserVx5eBv3yrT3M1/QBwdjy/q4oMs9p6jfYYk=
X-Google-Smtp-Source: ABdhPJy+z0D9ri9ngrVRxC0r0rgXl8LVweQQsGIwSrtgoyTVkc/8FuWCV9DKYpp5RO1CEDgKCleL16FZzI+PH3YLDeI=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr21620560otc.108.1592230812567;
 Mon, 15 Jun 2020 07:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200604022031.164207-1-masahiroy@kernel.org> <20200604022031.164207-2-masahiroy@kernel.org>
 <CAMj1kXEHDFnhgsz4w+6DuwPxcSZ5P8o0rMzQ504Nt4i31MXwJQ@mail.gmail.com>
 <CAMj1kXFhULbche0kbGr+mHofOYBU2WT8i7Bgx-qgz6Cp6AE8ow@mail.gmail.com> <CAK7LNARcq2O5redrnBnLuRXGs7HxyRxn_VSs2oRtDwOLkxLMdA@mail.gmail.com>
In-Reply-To: <CAK7LNARcq2O5redrnBnLuRXGs7HxyRxn_VSs2oRtDwOLkxLMdA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 16:20:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGg-w6N7jyG0pBJmeRctAhG2wWGoU=ryWj+Qi2UH-_m9Q@mail.gmail.com>
Message-ID: <CAMj1kXGg-w6N7jyG0pBJmeRctAhG2wWGoU=ryWj+Qi2UH-_m9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Jun 2020 at 16:15, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Jun 15, 2020 at 7:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 15 Jun 2020 at 12:26, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 4 Jun 2020 at 04:20, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > Documentation/kbuild/makefiles.rst says:
> > > >
> > > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > > >
> > > > This is because lib-y is inteded to be hooked to KBUILD_VMLINUX_LIBS,
> > > > which is passed down to scripts/link-vmlinux.sh.
> > > >
> > > > Besides, lib-y is not so interesting because objects from lib-y are
> > > > mostly linked in normal usecases. For example, lib-y only saves 364
> > > > bytes for x86_64_defconfig. You can see the details in commit
> > > > 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when
> > > > CONFIG_MODULES=y").
> > > >
> > > > I think we should consider to deprecate lib-y syntax at some point
> > > > because we should aim for better solution like dead code elimination
> > > > or LTO.
> > > >
> > > > Other than lib/ and arch/*/lib, this Makefile is the only user of
> > > > lib-y. Replace lib-y with a custom rule.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > Series queued in efi/urgent.
> > >
> >
> > Actually, I am seeing this now
> >
> > /home/ard/linux/scripts/Makefile.build:421: warning: overriding recipe
> > for target 'drivers/firmware/efi/libstub/lib.a'
> > /home/ard/linux/drivers/firmware/efi/libstub/Makefile:131: warning:
> > ignoring old recipe for target 'drivers/firmware/efi/libstub/lib.a'
>
>
>
> Sorry, please drop this patch for now.
>
> (Actually, it was working when I submitted it,
> but is broken after e578edc72276280b8fae57f6bf79cb443ceee7a2)
>

OK.
