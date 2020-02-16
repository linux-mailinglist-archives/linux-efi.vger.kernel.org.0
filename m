Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA2160587
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgBPScM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPScM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:32:12 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554A022B48
        for <linux-efi@vger.kernel.org>; Sun, 16 Feb 2020 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877931;
        bh=EDzR1SWoeTP3PS53iYm+v8llO5Y8uiP2GNaxmMQ4++U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KzopiJlktkgo2BlJO3vgl9MaBGiKPsegU24YVDwiGiNOx04Jx3efc0f1wclBd3Bhn
         qNwAuE/6o4lvolmI2A1RjPmwU2me/Dpa28WarONn07FACnuW/Dh868BsbeNOBMXQaO
         T+iKtMs189lciumH3sR2ZYGPWH+hzmUcib4g5lr0=
Received: by mail-wm1-f53.google.com with SMTP id m10so5809341wmc.0
        for <linux-efi@vger.kernel.org>; Sun, 16 Feb 2020 10:32:11 -0800 (PST)
X-Gm-Message-State: APjAAAXzT5r8V+LlDC3ChVuT//PGWn9AKlvvLSXCZloVWcNgYeG1AE/G
        9nQqhBtfshYgx7kZyLrJ4CcewPcm/QBYaUVg7TlChA==
X-Google-Smtp-Source: APXvYqw49cvCSIJYQeUyUb39Yo8eW5vIIraLjTmETS76Q9vf74bEtQkragmJ5CnqaAMS9OSHHTRcJG9ASHNzdzoQm8Y=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr18463603wmk.68.1581877929530;
 Sun, 16 Feb 2020 10:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20200216182334.8121-1-ardb@kernel.org>
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 16 Feb 2020 19:31:58 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-4N6B0LPL1fn5C2EAh9y3ECZ=mSi92p0AyJf67mJoWmw@mail.gmail.com>
Message-ID: <CAKv+Gu-4N6B0LPL1fn5C2EAh9y3ECZ=mSi92p0AyJf67mJoWmw@mail.gmail.com>
Subject: Re: [PATCH 00/18] efi: clean up contents of struct efi
To:     linux-efi <linux-efi@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Tony and Fenghua)

On Sun, 16 Feb 2020 at 19:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The generic r/w singleton object 'struct efi efi' is currently being used
> as a dumping ground for memory addresses of firmware tables that only have
> significance for a single architecture, or only at boot time [whereas
> struct efi is an object with indefinite lifetime, and which is exported
> to modules]
>
> Since we're expecting a new arrival that does affect all architectures,
> which will need to be added to struct efi as well, let's do a cleanup
> pass, and move out all the per-arch pieces and other stuff that does not
> need to live in a global r/w struct.
>
> As a side effect, I ran into some other things that can be refactored
> so that more code is shared between architectures, or made x86 specific
> if it is something that should maybe not have existed in the first place,
> and x86 is the only architecture where we cannot remove it for compatibility
> reasons.
>
> Finally, we get rid of the struct efi::systab member, which we only need
> at runtime to get at the 'runtime' pointer, so let's store that instead.
> This allows us to drop some ugly handling of the remapped systab address,
> which we cannot discover as easily as the remapped 'runtime' pointer.
>
> Cc: nivedita@alum.mit.edu
> Cc: x86@kernel.org
>

Apologies to the IA64 maintainers for forgetting to cc you.

The whole series can be found at
https://lore.kernel.org/linux-efi/20200216182334.8121-1-ardb@kernel.org/

Please let me know if you need me to resend with the missing cc's added.




> Ard Biesheuvel (18):
>   efi: drop handling of 'boot_info' configuration table
>   efi/ia64: move HCDP and MPS table handling into IA64 arch code
>   efi: move UGA and PROP table handling to x86 code
>   efi: make rng_seed table handling local to efi.c
>   efi: move mem_attr_table out of struct efi
>   efi: make memreserve table handling local to efi.c
>   efi: merge EFI system table revision and vendor checks
>   efi/ia64: use existing helpers to locate ESI table
>   efi/ia64: use local variable for EFI system table address
>   efi/ia64: switch to efi_config_parse_tables()
>   efi: make efi_config_init() x86 only
>   efi: clean up config_parse_tables()
>   efi/x86: remove runtime table address from kexec EFI setup data
>   efi/x86: make fw_vendor, config_table and runtime sysfs nodes x86
>     specific
>   efi/x86: merge assignments of efi.runtime_version
>   efi: add 'runtime' pointer to struct efi
>   efi/arm: drop unnecessary references to efi.systab
>   efi/x86: drop 'systab' member from struct efi
>
>  arch/ia64/kernel/efi.c                  |  55 ++--
>  arch/ia64/kernel/esi.c                  |  21 +-
>  arch/x86/include/asm/efi.h              |   6 +-
>  arch/x86/kernel/asm-offsets_32.c        |   5 +
>  arch/x86/kernel/kexec-bzimage64.c       |   5 +-
>  arch/x86/platform/efi/efi.c             | 262 ++++++++++----------
>  arch/x86/platform/efi/efi_32.c          |  13 +-
>  arch/x86/platform/efi/efi_64.c          |  14 +-
>  arch/x86/platform/efi/efi_stub_32.S     |  21 +-
>  arch/x86/platform/efi/quirks.c          |   2 +-
>  drivers/firmware/efi/arm-init.c         |  68 ++---
>  drivers/firmware/efi/arm-runtime.c      |  18 --
>  drivers/firmware/efi/efi.c              | 237 ++++++++----------
>  drivers/firmware/efi/memattr.c          |  13 +-
>  drivers/firmware/efi/runtime-wrappers.c |   4 +-
>  drivers/firmware/pcdp.c                 |   8 +-
>  include/linux/efi.h                     |  76 +++---
>  17 files changed, 379 insertions(+), 449 deletions(-)
>
> --
> 2.17.1
>
