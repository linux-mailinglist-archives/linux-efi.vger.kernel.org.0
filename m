Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E328224921
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jul 2020 07:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgGRFyd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jul 2020 01:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgGRFyd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jul 2020 01:54:33 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58AC208E4;
        Sat, 18 Jul 2020 05:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595051672;
        bh=bPNSxVMfse13AvxGlLLZIw7R+pi4nVlMn0Jl7sLXFpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BzPhhErGy2FBuNLHaD1AgUbWThJJkAreGMkQSuRHrnNiDKdDBd5Qmm48rf3w0fMKa
         8GsCQV3sFR0g8wedaR1rVs+8UQ1fYeC1NPCpap+i5alVmWykSAeZ07N2lEvlOgA0lc
         67g7KUgwvKQuN2NLYI53l1bwKdZ3Xv8bHry+4hZo=
Received: by mail-oi1-f182.google.com with SMTP id w17so9870260oie.6;
        Fri, 17 Jul 2020 22:54:32 -0700 (PDT)
X-Gm-Message-State: AOAM533g1RvbBEBT7ojOkhNfFGoOqX4LWdV1rHijAUUjUaG23rM+6rZp
        vF4I7ue+NWZAoWu+1FR+Mgu2G/xUEFi/1++vTnk=
X-Google-Smtp-Source: ABdhPJzZ4NEtZfmmbnS+DfeLeAQt/womAFEBD7627IvgU9OJ3LHDBrAHbhh/sf/h/5YmTI3PYH2HhZbTKN3cyX0ygYM=
X-Received: by 2002:aca:d643:: with SMTP id n64mr10242000oig.33.1595051671965;
 Fri, 17 Jul 2020 22:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132807.32232-1-ardb@kernel.org>
In-Reply-To: <20200709132807.32232-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 18 Jul 2020 08:54:20 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGHDS7PnuPsCnHWGDFdtcaJUuXboZUZQwowzw0LfrQ+pw@mail.gmail.com>
Message-ID: <CAMj1kXGHDS7PnuPsCnHWGDFdtcaJUuXboZUZQwowzw0LfrQ+pw@mail.gmail.com>
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

On Thu, 9 Jul 2020 at 16:28, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The following changes since commit 2a55280a3675203496d302463b941834228b9875:
>
>   efi/libstub: arm: Print CPU boot mode and MMU state at boot (2020-06-17 15:29:11 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.8-rc4
>
> for you to fetch changes up to 769e0fe1171e95d90ea5a2d6d0b2bdc7d5d2e7b2:
>
>   efi: Revert "efi/x86: Fix build with gcc 4" (2020-07-09 10:14:29 +0300)
>
> ----------------------------------------------------------------
> EFI fixes for v5.8-rc4:
> - Fix the layering violation in the use of the EFI runtime services
>   availability mask in users of the 'efivars' abstraction
> - Revert build fix for GCC v4.8 which is no longer supported
> - Some fixes for build issues found by Atish while working on RISC-V support
> - Avoid --whole-archive when linking the stub on arm64
> - Some x86 EFI stub cleanups from Arvind
>
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       efi/efivars: Expose RT service availability via efivars abstraction
>       efi: Revert "efi/x86: Fix build with gcc 4"
>
> Arvind Sankar (2):
>       efi/x86: Remove unused variables
>       efi/x86: Only copy upto the end of setup_header
>
> Atish Patra (2):
>       efi/libstub: Fix gcc error around __umoddi3 for 32 bit builds
>       efi/libstub: Move the function prototypes to header file
>
> Masahiro Yamada (1):
>       efi/libstub/arm64: link stub lib.a conditionally
>
>  arch/arm64/Makefile                       |  2 +-
>  drivers/firmware/efi/efi-pstore.c         |  5 +----
>  drivers/firmware/efi/efi.c                | 12 ++++++++----
>  drivers/firmware/efi/efivars.c            |  5 +----
>  drivers/firmware/efi/libstub/Makefile     |  3 +--
>  drivers/firmware/efi/libstub/alignedmem.c |  2 +-
>  drivers/firmware/efi/libstub/efi-stub.c   | 17 -----------------
>  drivers/firmware/efi/libstub/efistub.h    | 16 ++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c   |  8 ++++----
>  drivers/firmware/efi/vars.c               |  6 ++++++
>  fs/efivarfs/super.c                       |  6 +++---
>  include/linux/efi.h                       |  1 +
>  12 files changed, 43 insertions(+), 40 deletions(-)

Ping?
