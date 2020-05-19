Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B01D9178
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgESHyA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 03:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgESHx7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 03:53:59 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C718E20809
        for <linux-efi@vger.kernel.org>; Tue, 19 May 2020 07:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589874838;
        bh=2VlPM6RucrsMUnEzFWs3GSk1rXcPz0hOBTxUeZ3NOLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dKamxf7kFI69FWHhZvYTUZ2uvNRBizZsvlgGFLQ+dRMhSJidV8kdbFsrMsVBTWzEk
         5A9ACfdxQTpwYYMLYhDoosJhpBFzhQIjvOwhH99S0rAejitJRpgKzd2Tzry+ZYDlV2
         Ftkkmw8aKHTGUnZ0d0QLC6k566CuZHXfmCK11B2A=
Received: by mail-il1-f179.google.com with SMTP id n11so12522414ilj.4
        for <linux-efi@vger.kernel.org>; Tue, 19 May 2020 00:53:58 -0700 (PDT)
X-Gm-Message-State: AOAM531Yi9UFR8SXomaBc0aEZ0vbihFnpj+aWyT9Z3gGsqpqArfajWjr
        0VKKHYxknkVmVDBMaLm1DW9B7qCRoPeWcCY61Ms=
X-Google-Smtp-Source: ABdhPJxilMKod+P/czTOJYzYtYuTYJNEyh3epKGoH4YQQztshNW8AC/2T3XG7we+BmY4bvW/EkMJdLw2b/T31wngjPk=
X-Received: by 2002:a92:c948:: with SMTP id i8mr20638534ilq.258.1589874838177;
 Tue, 19 May 2020 00:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 May 2020 09:53:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE7EasnCLW0LrWP7f8A9dpTThSHJUP+iM-i0Tqrm=FoOA@mail.gmail.com>
Message-ID: <CAMj1kXE7EasnCLW0LrWP7f8A9dpTThSHJUP+iM-i0Tqrm=FoOA@mail.gmail.com>
Subject: Re: [PATCH 00/24] efi/libstub: Add printf implementation
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 18 May 2020 at 21:07, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series (on top of efi/next) adds a basic printf implementation for
> the EFI stub to use.
>
> Patches 1-2 are minor cleanup.
>
> Patch 3 adds an on-stack buffer for efi_puts to do the char to UTF-16
> conversion, to avoid calling into the firmware for each character.
>
> Patches 4-16 copy the simple printf implementation from
> arch/x86/boot/printf.c and spruce it up. The main enhancements are
> support for 64-bit integers and conversion to vsnprintf. There are small
> fixes to correct the behavior for edge cases (detailed in the individual
> patches).
>
> Patch 17 changes efi_info/efi_err to actually use efi_printk, and
> introduces a loglevel into the EFI stub instead of just quiet/non-quiet.
> The loglevels are reused from the main kernel. An efi_debug macro is
> also added, but is currently unused. As an aside, we chose efi_info over
> efi_pr_info, but I'm wondering whether we should make it efi_pr_info
> after all: there is already an efi_info symbol (structure type and field
> name) so it might lead to some confusion.
>
> Patch 18-19 add an option to list the available modes from the GOP,
> which should make using the new video=efifb parameters easier.
>
> Patches 20-24 incorporate UTF-16 support into the new printf function
> and use it in a couple of places.
>
> Arvind Sankar (24):
>   efi/libstub: Include dependencies of efistub.h
>   efi/libstub: Rename efi_[char16_]printk to efi_[char16_]puts
>   efi/libstub: Buffer output of efi_puts
>   efi/libstub: Add a basic printf implementation
>   efi/libstub: Optimize for size instead of speed
>   efi/printf: Drop %n format and L qualifier
>   efi/printf: Add 64-bit and 8-bit integer support
>   efi/printf: Factor out flags parsing and handle '%' earlier
>   efi/printf: Fix minor bug in precision handling
>   efi/printf: Merge 'p' with the integer formats
>   efi/printf: Factor out width/precision parsing
>   efi/printf: Factor out integer argument retrieval
>   efi/printf: Handle null string input
>   efi/printf: Refactor code to consolidate padding and output
>   efi/printf: Abort on invalid format
>   efi/printf: Turn vsprintf into vsnprintf
>   efi/libstub: Implement printk-style logging
>   efi/libstub: Add definitions for console input and events
>   efi/gop: Add an option to list out the available GOP modes
>   efi/printf: Add support for wchar_t (UTF-16)
>   efi/libstub: Add UTF-8 decoding to efi_puts
>   efi/libstub: Use %ls for filename
>   efi/libstub: Get the exact UTF-8 length
>   efi/libstub: Use snprintf with %ls to convert the command line
>

Thanks Arvind, this is looking really good!

Did you use any test code for the printf() parsing? Given that the
kernel command line is not covered by secure boot signing (or the
initrd, come to think of it), I'd hate to open up a security hole
here.



>  Documentation/fb/efifb.rst                    |   5 +
>  arch/x86/include/asm/efi.h                    |  10 +
>  arch/x86/xen/efi.c                            |   2 +-
>  drivers/firmware/efi/libstub/Makefile         |   6 +-
>  .../firmware/efi/libstub/efi-stub-helper.c    | 275 ++++++---
>  drivers/firmware/efi/libstub/efistub.h        | 107 +++-
>  drivers/firmware/efi/libstub/file.c           |   4 +-
>  drivers/firmware/efi/libstub/gop.c            |  97 ++-
>  drivers/firmware/efi/libstub/vsprintf.c       | 563 ++++++++++++++++++
>  include/linux/efi.h                           |   4 +-
>  10 files changed, 968 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/vsprintf.c
>
> --
> 2.26.2
>
