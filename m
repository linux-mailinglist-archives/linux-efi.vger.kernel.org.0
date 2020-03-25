Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD9192E6E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCYQl7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 12:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgCYQl5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Mar 2020 12:41:57 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353BE20740
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585154516;
        bh=yRf3oNqMwM2iTG7pyGx5Rsiqc2MPxpMsUz50QFD55ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wNQncXlQb/kPiwpu/mNOFphhaZSdu97fZPMktrBI7ULMMXkPdoyM8nhLcnyLdX/rF
         0K7Ar8NSbvT49k4sqi0+3CcxQyMV26BwaVwShTFQHaevvIOen/kfKLhTT5Dd5x0x8l
         xzefK26AVtCdsvDcHKGeToClSagQaDx2iO16yAcw=
Received: by mail-wm1-f42.google.com with SMTP id 26so5361788wmk.1
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 09:41:56 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2Ea35kxZy0wQZXQvvib8mqzNnfwonmojNtL29dKlkR+fYaJ/Zb
        QivW+16/0/ua7UwHNgA5vxqvfT5o8JIQxiHDUUXH4g==
X-Google-Smtp-Source: ADFU+vta9fWvKi78EiQgK6NXqyVsyEPSz4RCJCiGEaOzJ6l59KxD8f76QU5aW9FhDm0K613szx7H2SBu9jYqH3AMzTA=
X-Received: by 2002:a7b:c050:: with SMTP id u16mr4608096wmc.68.1585154514613;
 Wed, 25 Mar 2020 09:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200319192855.29876-1-nivedita@alum.mit.edu> <20200320020028.1936003-1-nivedita@alum.mit.edu>
In-Reply-To: <20200320020028.1936003-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Mar 2020 17:41:43 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
Message-ID: <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Mar 2020 at 03:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series is against tip:efi/core.
>
> Patches 1-9 are small cleanups and refactoring of the code in
> libstub/gop.c.
>
> The rest of the patches add the ability to use a command-line option to
> switch the gop's display mode.
>
> The options supported are:
> video=efifb:mode=n
>         Choose a specific mode number
> video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
>         Specify mode by resolution and optionally color depth
> video=efifb:auto
>         Let the EFI stub choose the highest resolution mode available.
>
> The mode-setting additions increase code size of gop.o by about 3k on
> x86-64 with EFI_MIXED enabled.
>
> Changes in v2 (HT lkp@intel.com):
> - Fix __efistub_global attribute to be after the variable.
>   (NB: bunch of other places should ideally be fixed, those I guess
>   don't matter as they are scalars?)
> - Silence -Wmaybe-uninitialized warning in set_mode function.
>

These look good to me. The only question I have is whether it would be
possible to use the existing next_arg() and parse_option_str()
functions to replace some of the open code parsing that goes on in
patches 11 - 14.


> Arvind Sankar (14):
>   efi/gop: Remove redundant current_fb_base
>   efi/gop: Move check for framebuffer before con_out
>   efi/gop: Get mode information outside the loop
>   efi/gop: Factor out locating the gop into a function
>   efi/gop: Slightly re-arrange logic of find_gop
>   efi/gop: Move variable declarations into loop block
>   efi/gop: Use helper macros for populating lfb_base
>   efi/gop: Use helper macros for find_bits
>   efi/gop: Remove unreachable code from setup_pixel_info
>   efi/gop: Add prototypes for query_mode and set_mode
>   efi/gop: Allow specifying mode number on command line
>   efi/gop: Allow specifying mode by <xres>x<yres>
>   efi/gop: Allow specifying depth as well as resolution
>   efi/gop: Allow automatically choosing the best mode
>
>  Documentation/fb/efifb.rst                    |  33 +-
>  arch/x86/include/asm/efi.h                    |   4 +
>  .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
>  drivers/firmware/efi/libstub/efistub.h        |   8 +-
>  drivers/firmware/efi/libstub/gop.c            | 489 ++++++++++++++----
>  5 files changed, 428 insertions(+), 109 deletions(-)
>
>
> base-commit: d5528d5e91041e68e8eab9792ce627705a0ed273
> --
> 2.24.1
>
