Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B92D9A7C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408340AbgLNO72 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 09:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407990AbgLNO6u (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Dec 2020 09:58:50 -0500
X-Gm-Message-State: AOAM533TnVtO8N2SfYpQlPy8paQ28hAvvVDztg6bsc6m2UbuW3Ivnlps
        Tqe7ezTIKff/vP4/CJF1YUXV46uD8CaV6o0zc50=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607957890;
        bh=46fDlY4awhRgVG0Lk2ZJFiwLszyC823svKzWIQBHFgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SWf1qfarHZy7ODMnvmIx5WyoL3QtumW5sNWdSUzLmx1KHQPnFzhv1b+5e9HVW7ekb
         /IFi5z/T6R9gH3BousOh5ohRCaLVdHfJZTrr8oBOV1K8LmYFi0N8A9G6wz5Y6h606h
         WhvGWxZhmMpoxZ2/LrmsClPErnj325XXSNOBExnvKEOEbGWWhICZnMeUnhj7BSpaYA
         eE0LozubZ4QKMKO69eli7c3pE05C71inyL/D2DDnRXYYwSdviIxvinuFdQDlrQ8p7T
         h4tm7i3nfRJ2WstBGcJr90upRzp7SCjqIflGWc2nhpl/gD9UQ+1c2+A2HjMMSCx/fG
         eU2dUXAtloIHw==
X-Google-Smtp-Source: ABdhPJzjffaiI261G/9GLc+4oJ/6ZwBwfqIGDCBzSoKE9F6wsylgVTRAx8H86X2pqEkvfFhF6Z5O7isdw0BTPUeAayI=
X-Received: by 2002:aca:5ec2:: with SMTP id s185mr18559318oib.33.1607957889259;
 Mon, 14 Dec 2020 06:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20201214081200.29720-1-ardb@kernel.org>
In-Reply-To: <20201214081200.29720-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Dec 2020 15:57:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGO0mZ7RCM5UzEWi05rAAsvjhBfS59UqeZNzC1f7pLQuQ@mail.gmail.com>
Message-ID: <CAMj1kXGO0mZ7RCM5UzEWi05rAAsvjhBfS59UqeZNzC1f7pLQuQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v5.11 (followup fixes)
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Dec 2020 at 09:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The following changes since commit 54649911f31b6e7c2a79a1426ca98259139e4c35:
>
>   efi: stub: get rid of efi_get_max_fdt_addr() (2020-12-09 08:37:27 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.11-3
>
> for you to fetch changes up to f232134eddf6f61fc0912fcaa73c4baaf7a4c2e4:
>
>   efi: arm: force use of unsigned type for EFI_PHYS_ALIGN (2020-12-14 09:03:18 +0100)
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
>

Please disregard for now - I am chasing a kbuild robot error report
related to one of these patches.


> ----------------------------------------------------------------
> Followup fixes for EFI:
> - fix the build breakage on IA64 caused by recent capsule loader changes
> - suppress a type mismatch build warning in the expansion of
>   EFI_PHYS_ALIGN on ARM
>
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       efi: ia64: disable the capsule loader
>       efi: arm: force use of unsigned type for EFI_PHYS_ALIGN
>
>  arch/arm/include/asm/efi.h    | 2 +-
>  drivers/firmware/efi/Kconfig  | 2 +-
>  drivers/firmware/efi/Makefile | 5 ++++-
>  include/linux/efi.h           | 4 ++++
>  4 files changed, 10 insertions(+), 3 deletions(-)
