Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70892142612
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 09:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgATIqG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 03:46:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52562 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgATIqG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 03:46:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so13560331wmc.2
        for <linux-efi@vger.kernel.org>; Mon, 20 Jan 2020 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3VBXgudGBX+1YhJkjYRn+aVzCHBPKXBFKoHfjPT3kQ=;
        b=NLr8JbjZHjgx7BE0A831UWAgNffFK3Q+0xkPXxLjHt+Y3vaomowWx4yKaa9dDVbrMV
         IxADRn4G2HRnC6znUJY7LDNmgNQq/ZxkSqPre9WgMmXIjGmzjCHoD+vb3/NwgNQVH9Yo
         uN/viqlBQ7pePiF7oafLkVZllt2aVbh2AzYAScTcR7hTMg5mYA8/1/4OYwswwpGbzeRg
         L7usEcRcKmrsV14SnSk3vVEyZovjaZcEZh/9o3W2JSoM93cdRk1CjC432OLQtj/7znTC
         Mn/0qd0nQwbfLVyHouRD0Iu/I/+3+WMhEjOYBEoODf/g5JnJf2NOQ+GMFp3qIm3Cc+ho
         mRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3VBXgudGBX+1YhJkjYRn+aVzCHBPKXBFKoHfjPT3kQ=;
        b=e0+RqvSwGIrCxFHq9nuSKSvnCw0IJav8COpJKiB84UCMAd3FU/byO6LM0NVLGlDdDu
         cWYszvuLN6a6/WxSBe5u9JRrAgRkid9Ma0T6x6UlK03JLLSZRFaMZLuSssXwYCEckJnH
         oK+/Zl4rFtv3ZZ5pr2w2kxx6qeHgHP+xR41TV9XJuy9T8sekN0tPoqnBOWDVe3lUZzb4
         /zRJv8a3CIV76VQqnwxRcdr12Rekwrjnhf0/6/bE8cT6tJPUu6au1h7fIEOgHbE9/Tt/
         uCQo/nv98gWFR1qImvx3hgoFdclE3MSyR9Nq1GuXwcvoBCGJmi9oUNJPwbHtcC5Bo3QO
         aRJw==
X-Gm-Message-State: APjAAAXwiM2UN8L26UWo6rp1JY9eNnBmP2HvDpxvwx8i1TH7YRkHcIyz
        Q3j1vAYn9oIBFeJ3r4j2exTJ6zPDeVKVGU96+FW8wg==
X-Google-Smtp-Source: APXvYqxrSPvENhaZHLOAVOoIfa5+ts5MeaWJLrsPSiaRWiEEZVRlp0QccMh3hl3R6/a08Pj6dDy9D0KO2q8a4xCUcAk=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr18845651wmk.68.1579509964293;
 Mon, 20 Jan 2020 00:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200120082501.GC26606@gmail.com>
In-Reply-To: <20200120082501.GC26606@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 20 Jan 2020 09:45:53 +0100
Message-ID: <CAKv+Gu_wZsFwWtM85uuHEZAk7SEWyfFCss4DQYOn+J2vuzGC2g@mail.gmail.com>
Subject: Re: [GIT PULL 00/13] More EFI updates for v5.6
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Jan 2020 at 09:25, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > The following changes since commit 4444f8541dad16fefd9b8807ad1451e806ef1d94:
> >
> >   efi: Allow disabling PCI busmastering on bridges during boot (2020-01-10 18:55:04 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> >
> > for you to fetch changes up to 743c5dd59f7e4b9e7a28be6a8f0e8d03271a98ab:
> >
> >   efi: Fix handling of multiple efi_fake_mem= entries (2020-01-13 10:41:53 +0100)
> >
> > ----------------------------------------------------------------
> > Third and final batch of EFI updates for v5.6:
> > - A few touchups for the x86 libstub changes that have already been queued
> >   up.
> > - Fix memory leaks and crash bugs in the EFI fake_mem driver, which may be
> >   used more heavily in the future for device-dax soft reservation (Dan)
> > - Avoid RWX mappings in the EFI page tables when possible.
> > - Avoid PCIe probing failures if the EFI framebuffer is probed first when
> >   the new of_devlink feature is active.
> > - Move the support code for the old EFI memory mapping style into its only
> >   user, the SGI UV1+ support code.
> >
> > ----------------------------------------------------------------
> > Anshuman Khandual (1):
> >       efi: Fix comment for efi_mem_type() wrt absent physical addresses
> >
> > Ard Biesheuvel (7):
> >       efi/libstub/x86: use const attribute for efi_is_64bit()
> >       efi/libstub/x86: use mandatory 16-byte stack alignment in mixed mode
> >       x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
> >       efi/x86: don't map the entire kernel text RW for mixed mode
> >       efi/x86: avoid RWX mappings for all of DRAM
> >       efi/x86: limit EFI old memory map to SGI UV machines
> >       efi/arm: defer probe of PCIe backed efifb on DT systems
> >
> > Arnd Bergmann (1):
> >       efi/libstub/x86: fix unused-variable warning
> >
> > Dan Williams (4):
> >       efi: Add a flags parameter to efi_memory_map
> >       efi: Add tracking for dynamically allocated memmaps
> >       efi: Fix efi_memmap_alloc() leaks
> >       efi: Fix handling of multiple efi_fake_mem= entries
> >
> >  Documentation/admin-guide/kernel-parameters.txt |   3 +-
> >  arch/x86/boot/compressed/eboot.c                |  16 +-
> >  arch/x86/boot/compressed/efi_thunk_64.S         |  46 ++----
> >  arch/x86/boot/compressed/head_64.S              |   7 +-
> >  arch/x86/include/asm/efi.h                      |  28 ++--
> >  arch/x86/kernel/kexec-bzimage64.c               |   2 +-
> >  arch/x86/mm/pat/set_memory.c                    |   8 +-
> >  arch/x86/platform/efi/efi.c                     |  40 +++--
> >  arch/x86/platform/efi/efi_64.c                  | 190 ++++--------------------
> >  arch/x86/platform/efi/quirks.c                  |  44 +++---
> >  arch/x86/platform/uv/bios_uv.c                  | 164 +++++++++++++++++++-
> >  drivers/firmware/efi/arm-init.c                 | 107 ++++++++++++-
> >  drivers/firmware/efi/efi.c                      |   2 +-
> >  drivers/firmware/efi/fake_mem.c                 |  43 +++---
> >  drivers/firmware/efi/memmap.c                   |  95 ++++++++----
> >  include/linux/efi.h                             |  17 ++-
> >  16 files changed, 471 insertions(+), 341 deletions(-)
>
> Thanks Ard, I've applied these and the 3 fixes in the second series to
> tip:efi/core. It all merged nicely and looks good here. Let me know if
> there's anything amiss.
>

Thanks Ingo,

Apart from the mismatched parens in the commit log of the top commit,
everything looks fine.

It does appear that the KASAN fix is not 100% sufficient for mixed
mode, so I'll need to apply another fix on top there, but we may have
other things to fix during the cycle so I'll leave that for later.
