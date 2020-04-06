Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EC19FD32
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDFSaL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 14:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDFSaK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 14:30:10 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF642078C;
        Mon,  6 Apr 2020 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586197809;
        bh=HBvFCeSJpqyDca6uPYo//uUcwNS1HPsmDmAlbZua63w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQu/KdqJDMcqZ+Bn5MhryrSIlGUHMSCxoQrTySfWGm1ktwzBg6k747lsrw+hZMziC
         y5Nf10brDLchUsRgeYPnGZGa24JPBacfZ9l4FK7znrXsllWpNbStplA7N6K+xnag/o
         Ryltx4sNIduVtvaQRx22htBLO7ONSwi9FeB4uwqw=
Received: by mail-io1-f43.google.com with SMTP id y14so473769iol.12;
        Mon, 06 Apr 2020 11:30:09 -0700 (PDT)
X-Gm-Message-State: AGi0PubxFqFEwI5fPWqNYrlBSehLjkE/qvvonBGr7ezCPQayBGiTGcw5
        8/s5fP6ECNPrWdIermal4xZ2ESqPPcfhWj4x9To=
X-Google-Smtp-Source: APiQypId4Gl802lHnEOrV9sQstKR9OAkyvaTpSgpJG5BIvk42Cjxi15zB2C1hlXWt9hJyyflowd/BdxiWcIZ1/rOigw=
X-Received: by 2002:a5e:8b47:: with SMTP id z7mr1222858iom.16.1586197808726;
 Mon, 06 Apr 2020 11:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
In-Reply-To: <20200406180614.429454-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Apr 2020 20:29:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEpaKxoOBP9suDR1CJ7gTnKEQJcA1nPa3BWh1sN5piZoA@mail.gmail.com>
Message-ID: <CAMj1kXEpaKxoOBP9suDR1CJ7gTnKEQJcA1nPa3BWh1sN5piZoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 6 Apr 2020 at 20:06, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>
>   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
>   bzImage")
>
> removed the .bss section from the bzImage.
>
> However, while a PE loader is required to zero-initialize the .bss
> section before calling the PE entry point, the EFI handover protocol
> does not currently document any requirement that .bss be initialized by
> the bootloader prior to calling the handover entry.
>
> When systemd-boot is used to boot a unified kernel image [1], the image
> is constructed by embedding the bzImage as a .linux section in a PE
> executable that contains a small stub loader from systemd together with
> additional sections and potentially an initrd. As the .bss section
> within the bzImage is no longer explicitly present as part of the file,
> it is not initialized before calling the EFI handover entry.
> Furthermore, as the size of the embedded .linux section is only the size
> of the bzImage file itself, the .bss section's memory may not even have
> been allocated.
>
> In particular, this can result in efi_disable_pci_dma being true even
> when it was not specified via the command line or configuration option,
> which in turn causes crashes while booting on some systems.
>
> To avoid issues, place all EFI stub global variables into the .data
> section instead of .bss. As of this writing, only boolean flags for a
> few command line arguments and the sys_table pointer were in .bss and
> will now move into the .data section.
>
> [1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reported-by: Sergey Shatunov <me@prok.pw>
> Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")

Thanks Arvind.

This should be fine for the time being, but going forward, it would
indeed be better [as you suggested] to consolidate the section
tweaking logic that exists on different architectures for entirely
different reasons, but with similar results. That will also ensure
that BSS gets pulled into .data (or .init.data for arm64)
automatically, rather than requiring these manual annotations.

I'll queue these up in efi/urgent, and send them on later this week.


> ---
>  drivers/firmware/efi/libstub/efistub.h  | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cc90a748bcf0..67d26949fd26 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,7 +25,7 @@
>  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>  #endif
>
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_X86)
>  #define __efistub_global       __section(.data)
>  #else
>  #define __efistub_global
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 8d3a707789de..e7af6d2eddbf 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -20,7 +20,7 @@
>  /* Maximum physical address for 64-bit kernel with 4-level paging */
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>
> -static efi_system_table_t *sys_table;
> +static efi_system_table_t *sys_table __efistub_global;
>  extern const bool efi_is64;
>  extern u32 image_offset;
>
> --
> 2.24.1
>
