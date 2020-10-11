Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8985328A97D
	for <lists+linux-efi@lfdr.de>; Sun, 11 Oct 2020 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgJKSwx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 11 Oct 2020 14:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgJKSwx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 11 Oct 2020 14:52:53 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EBE22251
        for <linux-efi@vger.kernel.org>; Sun, 11 Oct 2020 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602442373;
        bh=tRIq1TBsb9XtqTEBac1D0dLSa2St4HZX45tcrJ3NB2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I6paUIOKPeMuJ0MBPgc5KLBZLk1FE0QzjrkT18IXc6JLMAFXuhIsd8P+ycpKRcZgK
         3n6EgA84apOjq98oD7kQKxYOlQkTZZdle0ZcWjLnlJBf5sCAnYRRcXSJRhU4mztw0N
         zAkYxoarJ8r9fT6j594ZMGxfBWklRTQuSE9iMwaw=
Received: by mail-ot1-f42.google.com with SMTP id q21so13821809ota.8
        for <linux-efi@vger.kernel.org>; Sun, 11 Oct 2020 11:52:53 -0700 (PDT)
X-Gm-Message-State: AOAM530zpS9pMejOaNnJG8c8a8CzEH+DQbsyOCcoDdBAA6WU528WC4M/
        cnhFrNBXk140tIylU5nGczsQOTNiJABr535qON4=
X-Google-Smtp-Source: ABdhPJwgqxGW/GtVPWrqw5Q4dQICMppCw3b2LnJ6K7tp1EiGAsTeeIaeT+W61NxzGv812A16ADWw/KZVkVw1Rw62LJI=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr16900814otq.77.1602442372432;
 Sun, 11 Oct 2020 11:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200929182412.31858-1-ardb@kernel.org>
In-Reply-To: <20200929182412.31858-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 11 Oct 2020 20:52:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHuSThL1aYUC3E7uAGhOJ3g5=5O9Qmw9p6XqXq0UsyHhA@mail.gmail.com>
Message-ID: <CAMj1kXHuSThL1aYUC3E7uAGhOJ3g5=5O9Qmw9p6XqXq0UsyHhA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes for v5.9
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 29 Sep 2020 at 20:24, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The following changes since commit 46908326c6b801201f1e46f5ed0db6e85bef74ae:
>
>   efi: efibc: check for efivars write capability (2020-09-15 18:22:47 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.9-rc7
>
> for you to fetch changes up to d32de9130f6c79533508e2c7879f18997bfbe2a0:
>
>   efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure (2020-09-29 15:41:52 +0200)
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
>
> ----------------------------------------------------------------
> EFI fixes for v5.9:
> - add definition of the EFI_MEMORY_CPU_CRYPTO memory attribute so we can
>   identify it in the memory map listings
> - don't abort the boot on arm64 if the EFI RNG protocol is available but
>   returns with an error
> - replace slashes with exclamation marks in efivarfs file names
> - a couple of cosmetic fixups
>
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       efi: Add definition of EFI_MEMORY_CPU_CRYPTO and ability to report it
>       efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure
>
> Michael Schaller (1):
>       efivarfs: Replace invalid slashes with exclamation marks in dentries.
>
> Tian Tao (2):
>       efi/libstub: Fix missing-prototypes in string.c
>       efi: Delete deprecated parameter comments
>

What is the status of this PR? It went into tip afaict but it appears
to be stuck there.


>  drivers/firmware/efi/efi.c                | 47 ++++++++++++++++---------------
>  drivers/firmware/efi/libstub/arm64-stub.c |  8 ++++--
>  drivers/firmware/efi/libstub/fdt.c        |  4 +--
>  drivers/firmware/efi/libstub/string.c     |  1 +
>  drivers/firmware/efi/vars.c               |  1 -
>  fs/efivarfs/super.c                       |  3 ++
>  include/linux/efi.h                       |  1 +
>  7 files changed, 35 insertions(+), 30 deletions(-)
