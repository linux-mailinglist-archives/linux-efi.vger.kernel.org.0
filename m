Return-Path: <linux-efi+bounces-5886-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3CCC4576
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 17:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB0A8300671E
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE1347BD1;
	Tue, 16 Dec 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeZdgjmo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53333347BA9
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892454; cv=none; b=pJWsLCBeDWfYX1aC9FwnTTchgNUxtKjyxn0jr0AJXHANtsQEPkQR2JHjOZUec/GDT58XXVBLNh3alafzSBgQU0EC7UT2raPjMvG9v8YEAk2qwi0/iC5sz/eNNAVHRo4fY+k607+X2LLghAWSYumAdYp+5PpbSlR/RFJFWcPKWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892454; c=relaxed/simple;
	bh=bpE6mSMhtsJNcViEHUKqxdpK/zXIk25nSDmiikJg7Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDnLu/QJChokIYPRgkQFjsaNufPaXEesJ6367LT9Ft31+9NSksxGOcFGvnl1ez33jd64WZ6f0Q08Jqjc74/iJMKTY+K6DIQ5u2wlPl/F+AF4N/5Zy1ut+VyUHrY4d0QtXKsBieo2qqOX+JhCDNl/Bzbf18G1igOuKV5Qw5Nz22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeZdgjmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2737C4CEF1
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765892454;
	bh=bpE6mSMhtsJNcViEHUKqxdpK/zXIk25nSDmiikJg7Jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NeZdgjmofb5XyxZ/9WvmQDRKMMTSL7UvRP7wXhCM0Sn1k0OBFCu7ph/Ju5GY0XNL7
	 aqoPVZqK6Uf82+24gaphNn/PeUkv1uFk6jNXl84kPZwk63Ov+FFGyxxW3JfHP6gQ7K
	 hiEX4jmVRRQ4gXRa8TTiN7k2GFggH0g4IrXrHv/svzQ67VjOTSouguE4IL4rEqYkRu
	 1fCwDjUzmIhKIHieXY7Djjg+l3hHsd53Fuu1izTymS6+7mURvOZSjrfDGXv1E1njvR
	 VE6jFsByaR6RC69K1SiOW4Utea7uiGZbxTDnZaJaogGFKZ85nLoQzcQrm6ab4btr3s
	 ikpOL4/rzbaVQ==
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d6f647e2so36677965ad.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 05:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXo5hDo2EMQm+nXEFaC+HNExD7M5XFYYjusHpEp7ChR17Qmiw1X/BBFNF+k3jIlBXxpMiUWMVlU0fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWl0EBYyOyDnPokDOoKIHKuwGeAK/CBX8L8pIiHqoj29rYHoR
	LpjphHEZz3STlIpogCaWctNP42FXkjebla5oiHsN/pQAd1pcA+W1uq82Jv2TOTY+WCTYnBBHJpL
	OB3cVbNEyYMgaOZK9KrN2hTscTQRK9wU=
X-Google-Smtp-Source: AGHT+IHcmZJ38d94bL4vjoP1Iao4l30Ahx8lP9aMcBlBTOZ7Gso5/FdhsFfK6P+oxGrsyN3M1S7cHEzzA6Roze4LOiE=
X-Received: by 2002:a17:902:cf0d:b0:2a0:d59e:9848 with SMTP id
 d9443c01a7336-2a0d59e9a43mr99280585ad.53.1765892453645; Tue, 16 Dec 2025
 05:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126160854.553077-1-tzimmermann@suse.de> <20251126160854.553077-8-tzimmermann@suse.de>
In-Reply-To: <20251126160854.553077-8-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Dec 2025 14:40:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG6cFsKwZk3a+xRrOYNz73efxjo=6Jnnr8HCKRO0X-zCQ@mail.gmail.com>
X-Gm-Features: AQt7F2qIXhwz3lKtiowhJ6LkUm-qxxF02G3Bdlrhhj6FcFVAi1NXBSE5o0PIhTQ
Message-ID: <CAMj1kXG6cFsKwZk3a+xRrOYNz73efxjo=6Jnnr8HCKRO0X-zCQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] efi: Refactor init_primary_display() helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com, 
	helgaas@kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Rework the kernel's init_primary_display() helpers to allow for later
> support of additional config-table entries and EDID information. No
> functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/loongarch/kernel/efi.c     | 22 +++++++++++-----------
>  drivers/firmware/efi/efi-init.c | 19 ++++++++++---------
>  2 files changed, 21 insertions(+), 20 deletions(-)
>

This patch seems unnecessary now that we've replace one table with another.

I've dropped it for now - let me know if you really want to keep it.


> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index 638a392d2cd2..1ef38036e8ae 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -81,19 +81,19 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
>
>  static void __init init_primary_display(void)
>  {
> -       struct screen_info *si;
> -
> -       if (screen_info_table == EFI_INVALID_TABLE_ADDR)
> -               return;
> -
> -       si = early_memremap(screen_info_table, sizeof(*si));
> -       if (!si) {
> -               pr_err("Could not map screen_info config table\n");
> +       if (screen_info_table == EFI_INVALID_TABLE_ADDR) {
> +               struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
> +
> +               if (!si) {
> +                       pr_err("Could not map screen_info config table\n");
> +                       return;
> +               }
> +               sysfb_primary_display.screen = *si;
> +               memset(si, 0, sizeof(*si));
> +               early_memunmap(si, sizeof(*si));
> +       } else {
>                 return;
>         }
> -       sysfb_primary_display.screen = *si;
> -       memset(si, 0, sizeof(*si));
> -       early_memunmap(si, sizeof(*si));
>
>         memblock_reserve(__screen_info_lfb_base(&sysfb_primary_display.screen),
>                          sysfb_primary_display.screen.lfb_size);
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index d1d418a34407..ca697d485116 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -67,10 +67,9 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
>
>  static void __init init_primary_display(void)
>  {
> -       struct screen_info *si;
> -
>         if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
> -               si = early_memremap(screen_info_table, sizeof(*si));
> +               struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
> +
>                 if (!si) {
>                         pr_err("Could not map screen_info config table\n");
>                         return;
> @@ -78,14 +77,16 @@ static void __init init_primary_display(void)
>                 sysfb_primary_display.screen = *si;
>                 memset(si, 0, sizeof(*si));
>                 early_memunmap(si, sizeof(*si));
> +       } else {
> +               return;
> +       }
>
> -               if (memblock_is_map_memory(sysfb_primary_display.screen.lfb_base))
> -                       memblock_mark_nomap(sysfb_primary_display.screen.lfb_base,
> -                                           sysfb_primary_display.screen.lfb_size);
> +       if (memblock_is_map_memory(sysfb_primary_display.screen.lfb_base))
> +               memblock_mark_nomap(sysfb_primary_display.screen.lfb_base,
> +                                   sysfb_primary_display.screen.lfb_size);
>
> -               if (IS_ENABLED(CONFIG_EFI_EARLYCON))
> -                       efi_earlycon_reprobe();
> -       }
> +       if (IS_ENABLED(CONFIG_EFI_EARLYCON))
> +               efi_earlycon_reprobe();
>  }
>
>  static int __init uefi_init(u64 efi_system_table)
> --
> 2.51.1
>

