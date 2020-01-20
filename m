Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7871A14256D
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 09:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATIZG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 03:25:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46779 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgATIZF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 03:25:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so28434054wrl.13;
        Mon, 20 Jan 2020 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+thMwA6jLTLSxrfLNKSFf8jQ7Al6Gbw/7L12YLWstcc=;
        b=OYdpqWZClZZDhNfytrARrKW+ppxJ+RapVi6xY0loKaEmPatmxMfYndf+Ev0/mS/smi
         qgMZQSx4WqLiUsVBLXDwVbA/lM21GX1wOJ1C2Qee2PYrbTBOP60p4Zn4aJM7PtfnTimp
         xsKvioeARPyUTV+fSeUoZqJlrXpKKbpZnalXu26gyouPi8VG/bd1P8rVnJYXkLNAH45L
         E6uPwSYgmUerw9HKDnoaH+Hhu5J6/gMoV0OxnPZK44kSjumYQt+bOq+lk3ycf5+V1s+f
         WDm426gykCQ/WLZ2D4jAh7fPrqv0/iGWcWaJJng4dNDfJeM8KMP8yoeJ8WeTKsriESzC
         7UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+thMwA6jLTLSxrfLNKSFf8jQ7Al6Gbw/7L12YLWstcc=;
        b=unslKZ8j37dIahG4goiQ/JPT2V3+5bLj0vPYPrOBENrjm1H+MIojuhgAVCMWKDPoCC
         +nq1kasNIYP/qY1m2yFhcrro73YYGIlX3nhPIxu7d6ZOYyNFUlUvaktuW8fIzxl8eZKm
         inS4BajBZupzQ2YU/X/XyTWgm4Es00FatblbKaDODbu17CN4LTAkGJ3QG32ZKWMsoo7d
         toJggGtF6dPLW3oZNSFwTpv1qfEGDtBtxMgo5cHPBYU56LQY+XU3XfNQz33funpMmIKO
         37trmCgsbRt2P1y/o1LJfKEJylNz81OeEBtIZl0hqj0SY5lGJuKClK6OHfiQNSeVblM7
         cukg==
X-Gm-Message-State: APjAAAWmo6m/2zIMUsZze1eK9dQ0Z1/AQiLZUfW7UYbx6qF7dePsSkwC
        nPM5HA8qj+3bpkSBdcHqnxU=
X-Google-Smtp-Source: APXvYqzzQG4VymzJRuAliMgzv2SLwHcbgmlgIfVSQdau3R/o7qgKux8EiIjVRHwe7ELZXjjzEag7pg==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr17139512wrv.308.1579508703624;
        Mon, 20 Jan 2020 00:25:03 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 5sm47074032wrh.5.2020.01.20.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:25:03 -0800 (PST)
Date:   Mon, 20 Jan 2020 09:25:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL 00/13] More EFI updates for v5.6
Message-ID: <20200120082501.GC26606@gmail.com>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit 4444f8541dad16fefd9b8807ad1451e806ef1d94:
> 
>   efi: Allow disabling PCI busmastering on bridges during boot (2020-01-10 18:55:04 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to 743c5dd59f7e4b9e7a28be6a8f0e8d03271a98ab:
> 
>   efi: Fix handling of multiple efi_fake_mem= entries (2020-01-13 10:41:53 +0100)
> 
> ----------------------------------------------------------------
> Third and final batch of EFI updates for v5.6:
> - A few touchups for the x86 libstub changes that have already been queued
>   up.
> - Fix memory leaks and crash bugs in the EFI fake_mem driver, which may be
>   used more heavily in the future for device-dax soft reservation (Dan)
> - Avoid RWX mappings in the EFI page tables when possible.
> - Avoid PCIe probing failures if the EFI framebuffer is probed first when
>   the new of_devlink feature is active.
> - Move the support code for the old EFI memory mapping style into its only
>   user, the SGI UV1+ support code.
> 
> ----------------------------------------------------------------
> Anshuman Khandual (1):
>       efi: Fix comment for efi_mem_type() wrt absent physical addresses
> 
> Ard Biesheuvel (7):
>       efi/libstub/x86: use const attribute for efi_is_64bit()
>       efi/libstub/x86: use mandatory 16-byte stack alignment in mixed mode
>       x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
>       efi/x86: don't map the entire kernel text RW for mixed mode
>       efi/x86: avoid RWX mappings for all of DRAM
>       efi/x86: limit EFI old memory map to SGI UV machines
>       efi/arm: defer probe of PCIe backed efifb on DT systems
> 
> Arnd Bergmann (1):
>       efi/libstub/x86: fix unused-variable warning
> 
> Dan Williams (4):
>       efi: Add a flags parameter to efi_memory_map
>       efi: Add tracking for dynamically allocated memmaps
>       efi: Fix efi_memmap_alloc() leaks
>       efi: Fix handling of multiple efi_fake_mem= entries
> 
>  Documentation/admin-guide/kernel-parameters.txt |   3 +-
>  arch/x86/boot/compressed/eboot.c                |  16 +-
>  arch/x86/boot/compressed/efi_thunk_64.S         |  46 ++----
>  arch/x86/boot/compressed/head_64.S              |   7 +-
>  arch/x86/include/asm/efi.h                      |  28 ++--
>  arch/x86/kernel/kexec-bzimage64.c               |   2 +-
>  arch/x86/mm/pat/set_memory.c                    |   8 +-
>  arch/x86/platform/efi/efi.c                     |  40 +++--
>  arch/x86/platform/efi/efi_64.c                  | 190 ++++--------------------
>  arch/x86/platform/efi/quirks.c                  |  44 +++---
>  arch/x86/platform/uv/bios_uv.c                  | 164 +++++++++++++++++++-
>  drivers/firmware/efi/arm-init.c                 | 107 ++++++++++++-
>  drivers/firmware/efi/efi.c                      |   2 +-
>  drivers/firmware/efi/fake_mem.c                 |  43 +++---
>  drivers/firmware/efi/memmap.c                   |  95 ++++++++----
>  include/linux/efi.h                             |  17 ++-
>  16 files changed, 471 insertions(+), 341 deletions(-)

Thanks Ard, I've applied these and the 3 fixes in the second series to 
tip:efi/core. It all merged nicely and looks good here. Let me know if 
there's anything amiss.

Thanks,

	Ingo
