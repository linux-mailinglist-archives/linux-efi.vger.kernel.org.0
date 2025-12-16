Return-Path: <linux-efi+bounces-5884-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE1CC3705
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D5E30640F4
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69825228D;
	Tue, 16 Dec 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGre6Dbv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F493BB48
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891420; cv=none; b=Pb97RHGUxwDYOCDlYwgNhotCi6Z3ct1cGUtj/Vn2LmWcWoo3NuRrbfUfUolV8iHAsb9EHH+mKqlxlDzMjHl1A1+BsrDf8beOoC2jaeqY3NLsXYyXoXCuNcXXrDutQ4SMIdb0yZV43WYF5DNA9xJKMr0V9WZ8ZxvTfDxggoRuT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891420; c=relaxed/simple;
	bh=DPq1jAGc1D2O/ZyUazla2tvm5eNJUgScceBv0fDtLkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd5/rVUJduoySTK8AsSeAWCls4etQsBFXJApLnZNgALJWVUh8w0IaTLFUxCE9tvmUaYkD959HhN4PX+IaxF7AePJL2b1hIeIbqmbNtUZpRDLURuA6Td7HESbUTAAoG+m0aB7dPZDZA3U7ebhWruQw4lnbH+zvtSRw6kdqx50Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGre6Dbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DDCC4AF09
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765891419;
	bh=DPq1jAGc1D2O/ZyUazla2tvm5eNJUgScceBv0fDtLkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nGre6DbvGUgnZ+ESxttsrnECY5lWVvqQ1gRq4R08/NWMM6Rb5ayGTuV9K9W/HqR3Q
	 YGAGrMdKjxCZnF9RFyzdK69F1AQUANMKOGzht2N/FoW3JIeHZRdnF2XsY2K6sgW70V
	 U+HDhuzRiG/Lo6imIWRSAqVyL/NRr0FvFO4gOUpyGp6IDnfl/qh3D/gj1x5B8ycpG2
	 gAzN/+9lxsa+fl1T+WbVyRxI/k88S3LHjZRCLCWuBXE6N3osXAj09ZGHK4TAGCckwT
	 gZZIYQP8g382SyQr6jZi16qKdej6YlbWsF/u8WCmfc+fxrtTHYs0PrlqLhepsiLRQ3
	 PMZCjx7IxWsOg==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c902f6845so2807315a91.2
        for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 05:23:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw5Xx56Q1KK63XG8mnXq0ELDXvtZ1uBrmYn2P96MnX4PmZKIU+b9yZdUQd/vMavZURQcgxynVl/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGUjv7OzneIM+GqcEWuh9s+nyHYUmFVhnP9ecVCe6BIqKw0d4
	E3IDQjj4SeVJeal7ApcxHK1mVrmhUansl1GiiWVdlip9DelSrZw1bJbPu1dShR5jWQt0EWkxmVC
	4n39XBUplkJAlwccW+aH/BqFKRzXzrEQ=
X-Google-Smtp-Source: AGHT+IHUnDpKNHYUuXbGrQN2jg3vGOrZPyoOq5q+Rmr8AbIh7IbWBUkMTVkTTrw2Wag6CLrhtskPUlwtBJIXFO06Kbc=
X-Received: by 2002:a17:90b:4cce:b0:34a:b1ea:664e with SMTP id
 98e67ed59e1d1-34abd734361mr11835652a91.15.1765891419204; Tue, 16 Dec 2025
 05:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126160854.553077-1-tzimmermann@suse.de> <20251126160854.553077-10-tzimmermann@suse.de>
In-Reply-To: <20251126160854.553077-10-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Dec 2025 14:23:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFeBS7O5A-CPds3UfFnjegGTpVsuF7VznBc-zZ+gjygtw@mail.gmail.com>
X-Gm-Features: AQt7F2oAVMGGFI57G40bXQNZ0WT8L2VZYIDSVOafxb5SZLs3ZzjQIedL6et7Yfs
Message-ID: <CAMj1kXFeBS7O5A-CPds3UfFnjegGTpVsuF7VznBc-zZ+gjygtw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] efi: libstub: Simplify interfaces for primary_display
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com, 
	helgaas@kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas

On Wed, 26 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Rename alloc_primary_display() and __alloc_primary_display(), clarify
> free semantics to make interfaces easier to understand.
>
> Rename alloc_primary_display() to lookup_primary_display() as it
> does not necessarily allocate. Then rename __alloc_primary_display()
> to the new alloc_primary_display(). The helper belongs to
> free_primary_display), so it should be named without underscores.
>
> The lookup helper does not necessarily allocate, so the output
> parameter needs_free to indicate when free should be called.

I don't understand why we need this. Whether or not the helper
allocates is a compile time decision, and in builds where it doesn't,
the free helper doesn't do anything.

I'm all for making things simpler, but I don't think this patch
achieves that tbh.

I've queued up this series now up until this patch - once we converge
on the simplification, I'm happy to apply it on top.

Thanks,



> Pass
> an argument through the calls to track this state. Put the free
> handling into release_primary_display() for simplificy.
>
> Also move the comment fro primary_display.c to efi-stub-entry.c,
> where it now describes lookup_primary_display().
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 23 +++++++++++++++++--
>  drivers/firmware/efi/libstub/efi-stub.c       | 22 ++++++++++++------
>  drivers/firmware/efi/libstub/efistub.h        |  2 +-
>  .../firmware/efi/libstub/primary_display.c    | 17 +-------------
>  drivers/firmware/efi/libstub/zboot.c          |  6 +++--
>  5 files changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index aa85e910fe59..3077b51fe0b2 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -14,10 +14,29 @@ static void *kernel_image_addr(void *addr)
>         return addr + kernel_image_offset;
>  }
>
> -struct sysfb_display_info *alloc_primary_display(void)
> +/*
> + * There are two ways of populating the core kernel's sysfb_primary_display
> + * via the stub:
> + *
> + *   - using a configuration table, which relies on the EFI init code to
> + *     locate the table and copy the contents; or
> + *
> + *   - by linking directly to the core kernel's copy of the global symbol.
> + *
> + * The latter is preferred because it makes the EFIFB earlycon available very
> + * early, but it only works if the EFI stub is part of the core kernel image
> + * itself. The zboot decompressor can only use the configuration table
> + * approach.
> + */
> +
> +struct sysfb_display_info *lookup_primary_display(bool *needs_free)
>  {
> +       *needs_free = true;
> +
>         if (IS_ENABLED(CONFIG_ARM))
> -               return __alloc_primary_display();
> +               return alloc_primary_display();
> +
> +       *needs_free = false;
>
>         if (IS_ENABLED(CONFIG_X86) ||
>             IS_ENABLED(CONFIG_EFI_EARLYCON) ||
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 42d6073bcd06..dc545f62c62b 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -51,14 +51,14 @@ static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
>  void __weak free_primary_display(struct sysfb_display_info *dpy)
>  { }
>
> -static struct sysfb_display_info *setup_primary_display(void)
> +static struct sysfb_display_info *setup_primary_display(bool *dpy_needs_free)
>  {
>         struct sysfb_display_info *dpy;
>         struct screen_info *screen = NULL;
>         struct edid_info *edid = NULL;
>         efi_status_t status;
>
> -       dpy = alloc_primary_display();
> +       dpy = lookup_primary_display(dpy_needs_free);
>         if (!dpy)
>                 return NULL;
>         screen = &dpy->screen;
> @@ -68,15 +68,22 @@ static struct sysfb_display_info *setup_primary_display(void)
>
>         status = efi_setup_graphics(screen, edid);
>         if (status != EFI_SUCCESS)
> -               goto err_free_primary_display;
> +               goto err___free_primary_display;
>
>         return dpy;
>
> -err_free_primary_display:
> -       free_primary_display(dpy);
> +err___free_primary_display:
> +       if (*dpy_needs_free)
> +               free_primary_display(dpy);
>         return NULL;
>  }
>
> +static void release_primary_display(struct sysfb_display_info *dpy, bool dpy_needs_free)
> +{
> +       if (dpy && dpy_needs_free)
> +               free_primary_display(dpy);
> +}
> +
>  static void install_memreserve_table(void)
>  {
>         struct linux_efi_memreserve *rsv;
> @@ -156,13 +163,14 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>                              char *cmdline_ptr)
>  {
>         struct sysfb_display_info *dpy;
> +       bool dpy_needs_free;
>         efi_status_t status;
>
>         status = check_platform_features();
>         if (status != EFI_SUCCESS)
>                 return status;
>
> -       dpy = setup_primary_display();
> +       dpy = setup_primary_display(&dpy_needs_free);
>
>         efi_retrieve_eventlog();
>
> @@ -182,7 +190,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>
>         status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
>
> -       free_primary_display(dpy);
> +       release_primary_display(dpy, dpy_needs_free);
>
>         return status;
>  }
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 979a21818cc1..1503ffb82903 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1176,8 +1176,8 @@ efi_enable_reset_attack_mitigation(void) { }
>
>  void efi_retrieve_eventlog(void);
>
> +struct sysfb_display_info *lookup_primary_display(bool *needs_free);
>  struct sysfb_display_info *alloc_primary_display(void);
> -struct sysfb_display_info *__alloc_primary_display(void);
>  void free_primary_display(struct sysfb_display_info *dpy);
>
>  void efi_cache_sync_image(unsigned long image_base,
> diff --git a/drivers/firmware/efi/libstub/primary_display.c b/drivers/firmware/efi/libstub/primary_display.c
> index cdaebab26514..34c54ac1e02a 100644
> --- a/drivers/firmware/efi/libstub/primary_display.c
> +++ b/drivers/firmware/efi/libstub/primary_display.c
> @@ -7,24 +7,9 @@
>
>  #include "efistub.h"
>
> -/*
> - * There are two ways of populating the core kernel's sysfb_primary_display
> - * via the stub:
> - *
> - *   - using a configuration table, which relies on the EFI init code to
> - *     locate the table and copy the contents; or
> - *
> - *   - by linking directly to the core kernel's copy of the global symbol.
> - *
> - * The latter is preferred because it makes the EFIFB earlycon available very
> - * early, but it only works if the EFI stub is part of the core kernel image
> - * itself. The zboot decompressor can only use the configuration table
> - * approach.
> - */
> -
>  static efi_guid_t primary_display_guid = LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID;
>
> -struct sysfb_display_info *__alloc_primary_display(void)
> +struct sysfb_display_info *alloc_primary_display(void)
>  {
>         struct sysfb_display_info *dpy;
>         efi_status_t status;
> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> index 4b76f74c56da..c1fd1fdbcb08 100644
> --- a/drivers/firmware/efi/libstub/zboot.c
> +++ b/drivers/firmware/efi/libstub/zboot.c
> @@ -26,9 +26,11 @@ void __weak efi_cache_sync_image(unsigned long image_base,
>         // executable code loaded into memory to be safe for execution.
>  }
>
> -struct sysfb_display_info *alloc_primary_display(void)
> +struct sysfb_display_info *lookup_primary_display(bool *needs_free)
>  {
> -       return __alloc_primary_display();
> +       *needs_free = true;
> +
> +       return alloc_primary_display();
>  }
>
>  asmlinkage efi_status_t __efiapi
> --
> 2.51.1
>

