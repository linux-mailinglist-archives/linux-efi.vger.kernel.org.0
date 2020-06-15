Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A21F94C1
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 12:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgFOKlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 06:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbgFOKlb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 06:41:31 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7F620739;
        Mon, 15 Jun 2020 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592217690;
        bh=lXL7rej+TefHWIFaMbpYGDc3wQKLdDlDqma+LFXrdjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OGOq9Im6cBsPVdtab/7Bgg7k4nhtsakjRiFqAJH/nIHTR+S760HE3LzNcXvix+VVR
         d4OnimzP05MbT5sl0bcWSXL6vVce5Tm49RPajy7+7rE4NuB+3mvV4I/NU//PfBp1JQ
         KNKlDBfAYXmukmFvmA7JqjMKni9JUpl7+MrfoJro=
Received: by mail-ot1-f44.google.com with SMTP id g7so12702248oti.13;
        Mon, 15 Jun 2020 03:41:30 -0700 (PDT)
X-Gm-Message-State: AOAM530zqM/RyOQNQrwOu4IQ4nkajsV9173DqD2JMhzHoKZV7WOwrSiQ
        VauMBIw11A6AbJDwNHv5BxgQkzAOvAZACcgbBxM=
X-Google-Smtp-Source: ABdhPJxtAfnS7BRUD3aYiVQIBX9PUBhev5wuEg2dXY9GecvgeYwoq047fbdU9i5Ndvc9V3w28MipNmxK5kaJ1dHIZ+E=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr2978751oth.90.1592217690079;
 Mon, 15 Jun 2020 03:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200604022031.164207-1-masahiroy@kernel.org> <20200604022031.164207-2-masahiroy@kernel.org>
 <CAMj1kXEHDFnhgsz4w+6DuwPxcSZ5P8o0rMzQ504Nt4i31MXwJQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEHDFnhgsz4w+6DuwPxcSZ5P8o0rMzQ504Nt4i31MXwJQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 12:41:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFhULbche0kbGr+mHofOYBU2WT8i7Bgx-qgz6Cp6AE8ow@mail.gmail.com>
Message-ID: <CAMj1kXFhULbche0kbGr+mHofOYBU2WT8i7Bgx-qgz6Cp6AE8ow@mail.gmail.com>
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

On Mon, 15 Jun 2020 at 12:26, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 4 Jun 2020 at 04:20, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Documentation/kbuild/makefiles.rst says:
> >
> >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> >
> > This is because lib-y is inteded to be hooked to KBUILD_VMLINUX_LIBS,
> > which is passed down to scripts/link-vmlinux.sh.
> >
> > Besides, lib-y is not so interesting because objects from lib-y are
> > mostly linked in normal usecases. For example, lib-y only saves 364
> > bytes for x86_64_defconfig. You can see the details in commit
> > 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when
> > CONFIG_MODULES=y").
> >
> > I think we should consider to deprecate lib-y syntax at some point
> > because we should aim for better solution like dead code elimination
> > or LTO.
> >
> > Other than lib/ and arch/*/lib, this Makefile is the only user of
> > lib-y. Replace lib-y with a custom rule.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Series queued in efi/urgent.
>

Actually, I am seeing this now

/home/ard/linux/scripts/Makefile.build:421: warning: overriding recipe
for target 'drivers/firmware/efi/libstub/lib.a'
/home/ard/linux/drivers/firmware/efi/libstub/Makefile:131: warning:
ignoring old recipe for target 'drivers/firmware/efi/libstub/lib.a'
