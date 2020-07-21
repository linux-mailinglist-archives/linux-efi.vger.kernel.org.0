Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DCA227817
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jul 2020 07:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGUF2b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jul 2020 01:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUF2b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Jul 2020 01:28:31 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1484B20B1F;
        Tue, 21 Jul 2020 05:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595309310;
        bh=OOa3gDhGlr5LEqyQO/1fxeRDq6ypG03X4DPKVsFZGLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eLF1iiH6VXFqfdv457zBAn8Z83pLpwt9RzEXGJOheqPxphFwVKOJpVXhl9Vnp1HDc
         kWjRbX4hmOe75XhDe65tEAqJQiRzuUw5gwgb0OWh/ht4pPIgGLYT1+92QsB88sW1di
         A/37xh4K2Os0L3dEs/UjNF2HfBvWlB8DqRhUcuZ8=
Received: by mail-ot1-f48.google.com with SMTP id h13so14162219otr.0;
        Mon, 20 Jul 2020 22:28:30 -0700 (PDT)
X-Gm-Message-State: AOAM532h0m2y2kiOPWOIZTbl5LaxSKdlsFzbh1VrQ/bt2Zn6ooqQuTON
        2AKAhE8m+UUVNmXn6XAQV0zlUQUlUuEJJdu6/Ig=
X-Google-Smtp-Source: ABdhPJzhfvA9m2iJIfFzS6aEiaVO0wWdbG2Og6PpBP9rQYeSPodxi+BEAfbSwWoESC6ebqTyx8KAaXbScFsnYS7B0yk=
X-Received: by 2002:a9d:7553:: with SMTP id b19mr24390495otl.77.1595309309149;
 Mon, 20 Jul 2020 22:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132807.32232-1-ardb@kernel.org> <CAMj1kXGHDS7PnuPsCnHWGDFdtcaJUuXboZUZQwowzw0LfrQ+pw@mail.gmail.com>
In-Reply-To: <CAMj1kXGHDS7PnuPsCnHWGDFdtcaJUuXboZUZQwowzw0LfrQ+pw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Jul 2020 08:28:17 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFQt4f0XT6C_4_xAuDALv_jVsc+z0zkSnxh6MU-zHxj2g@mail.gmail.com>
Message-ID: <CAMj1kXFQt4f0XT6C_4_xAuDALv_jVsc+z0zkSnxh6MU-zHxj2g@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes for v5.8-rc
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 18 Jul 2020 at 08:54, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 9 Jul 2020 at 16:28, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The following changes since commit 2a55280a3675203496d302463b941834228b9875:
> >
> >   efi/libstub: arm: Print CPU boot mode and MMU state at boot (2020-06-17 15:29:11 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.8-rc4
> >
> > for you to fetch changes up to 769e0fe1171e95d90ea5a2d6d0b2bdc7d5d2e7b2:
> >
> >   efi: Revert "efi/x86: Fix build with gcc 4" (2020-07-09 10:14:29 +0300)
> >
> > ----------------------------------------------------------------
> > EFI fixes for v5.8-rc4:
> > - Fix the layering violation in the use of the EFI runtime services
> >   availability mask in users of the 'efivars' abstraction
> > - Revert build fix for GCC v4.8 which is no longer supported
> > - Some fixes for build issues found by Atish while working on RISC-V support
> > - Avoid --whole-archive when linking the stub on arm64
> > - Some x86 EFI stub cleanups from Arvind
> >
> > ----------------------------------------------------------------
> > Ard Biesheuvel (2):
> >       efi/efivars: Expose RT service availability via efivars abstraction
> >       efi: Revert "efi/x86: Fix build with gcc 4"
> >
> > Arvind Sankar (2):
> >       efi/x86: Remove unused variables
> >       efi/x86: Only copy upto the end of setup_header
> >
> > Atish Patra (2):
> >       efi/libstub: Fix gcc error around __umoddi3 for 32 bit builds
> >       efi/libstub: Move the function prototypes to header file
> >
> > Masahiro Yamada (1):
> >       efi/libstub/arm64: link stub lib.a conditionally
> >
> >  arch/arm64/Makefile                       |  2 +-
> >  drivers/firmware/efi/efi-pstore.c         |  5 +----
> >  drivers/firmware/efi/efi.c                | 12 ++++++++----
> >  drivers/firmware/efi/efivars.c            |  5 +----
> >  drivers/firmware/efi/libstub/Makefile     |  3 +--
> >  drivers/firmware/efi/libstub/alignedmem.c |  2 +-
> >  drivers/firmware/efi/libstub/efi-stub.c   | 17 -----------------
> >  drivers/firmware/efi/libstub/efistub.h    | 16 ++++++++++++++++
> >  drivers/firmware/efi/libstub/x86-stub.c   |  8 ++++----
> >  drivers/firmware/efi/vars.c               |  6 ++++++
> >  fs/efivarfs/super.c                       |  6 +++---
> >  include/linux/efi.h                       |  1 +
> >  12 files changed, 43 insertions(+), 40 deletions(-)
>
> Ping?

Ping again?
