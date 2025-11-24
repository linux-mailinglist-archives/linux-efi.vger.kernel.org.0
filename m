Return-Path: <linux-efi+bounces-5674-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10635C81C67
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7D53A8273
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291E3168F2;
	Mon, 24 Nov 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzmEM6WS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B23168E0
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003717; cv=none; b=D2Ly9zRlGFKyXGZnxcTStX1B/D3WW7OLSusPDuqiaahXFLDHSq5eE0/rzOhHAsshiakSQRkde6I2X7eFfYh20HhP9OJPuPAyTkwa+ScvjVuPwjN0bNYlV94SIYt1YFOWnI3XiMyelZu74vQqJPyZ5eOGp0CyigNnrIcF++bIEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003717; c=relaxed/simple;
	bh=XDhGPvCTlOtAm8SqKxFXp1SKGN8a8Hpm3y1hfKtziVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrXqs49U2+6J7MpibcyL2CPQYyQ1NRKxOwcOPK4KC8BSemTZRoORPLWD+L2mvajTI25VyQ0IcFE15kk7Qu2Ohm4JkBeaWt58OMdvjcClBMEe31065NYiDmf1WaaNmg9IAbqKZrU2SMJDtlbCLUL7J/UQoNdoIBaug4mCH1YctW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzmEM6WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5B4C2BC87
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003717;
	bh=XDhGPvCTlOtAm8SqKxFXp1SKGN8a8Hpm3y1hfKtziVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gzmEM6WSKPQMGV5/A+ZcpP0TC88Ynd4koWonDEvt7Tpu5I51pHMgJIYTEr9jpnw+i
	 XBVd2o1IKp+nbVw/XW0Fz2p2kpUD04wvWOg+53hh0k5b5CAFKzQw8bi3TDmErKyfQk
	 Uo+pwx7yRnMVsbw0Tk5sIlBKGsNaWmZQQxRuDZwJQweSJFQzCfGRavSpXxzzlXcth0
	 nRq1Ix6B90O561UkGPaLq2gzbzgUoNVuWEBhLFi05cZPlq2/Tc9sDD4Gl9nJxcK2Nu
	 ensstYX4cw6lGt/0ds24M15GZt88AZ/RSoOPObnbKz1uoVpcvwIZ4xV1zfSiShc6X6
	 30izJ8Wk3kmCA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b935df7bfso40607781fa.2
        for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 09:01:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHlbSnG0i6bz6kAgBzJeAUuPxDv2MgNZE6/DJsUm+92SO8X1BODBVwd44/gxqn7uD9oUHn6biIFEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxblWxeDAnzlJ8xoBCunSGSr+Itoo6ZmBjJq5DT1GjK8ApNHN6j
	1M1pb4h45TaBsEVEKbmaTKkLZy5xd4UYPlI7XfFLm35JV7E8Th8E9/ARyYLyszC4NCzq00ZJ6a+
	ncysg3Ty+XMa45eNyPi/oEWzswNW5cxM=
X-Google-Smtp-Source: AGHT+IEkrNgd288Aqd1i1HDm93x0vAhowPn36mtRKqLj65b7gv3inzfOeHOQeeyCnEde8qAor/6mFb9m0iGrYzU8Hgo=
X-Received: by 2002:a05:6512:3096:b0:57c:2474:371f with SMTP id
 2adb3069b0e04-596a3ee5d4amr4443842e87.45.1764003715146; Mon, 24 Nov 2025
 09:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124165116.502813-1-tzimmermann@suse.de> <20251124165116.502813-9-tzimmermann@suse.de>
In-Reply-To: <20251124165116.502813-9-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 24 Nov 2025 18:01:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
X-Gm-Features: AWmQ_bnUH2gOYPeFmtZhOt2fEadNyKSus8BJC5fWuG0lZCUM3RmsKIXfaGHDqcM
Message-ID: <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] efi: Support EDID information
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 17:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Add LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID to the list of config-table
> UUIDs. Read sysfb_primary_display from the entry. The UUID has been
> generated with uuidgen.
>
> Still support LINUX_EFI_SCREEN_INFO_TABLE_GUID as fallback in case an
> older boot loader invokes the kernel.
>
> If CONFIG_FIRMWARE_EDID=n, EDID information is disabled.
>
> Make the Kconfig symbol CONFIG_FIRMWARE_EDID available with EFI. Setting
> the value to 'n' disables EDID support.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Why are we adding a new config table again?


> ---
>  arch/loongarch/kernel/efi.c     | 14 +++++++++++++-
>  drivers/firmware/efi/efi-init.c | 14 +++++++++++++-
>  drivers/firmware/efi/efi.c      |  2 ++
>  drivers/video/Kconfig           |  8 +++++---
>  include/linux/efi.h             |  8 +++++---
>  5 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index 1ef38036e8ae..2d90758e5037 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -72,6 +72,7 @@ bool efi_poweroff_required(void)
>                 (acpi_gbl_reduced_hardware || acpi_no_s5);
>  }
>
> +unsigned long __initdata primary_display_table = EFI_INVALID_TABLE_ADDR;
>  unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
>
>  #if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
> @@ -81,7 +82,18 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
>
>  static void __init init_primary_display(void)
>  {
> -       if (screen_info_table == EFI_INVALID_TABLE_ADDR) {
> +       if (primary_display_table != EFI_INVALID_TABLE_ADDR) {
> +               struct sysfb_display_info *dpy =
> +                       early_memremap(primary_display_table, sizeof(*dpy));
> +
> +               if (!dpy) {
> +                       pr_err("Could not map primary_display config table\n");
> +                       return;
> +               }
> +               sysfb_primary_display = *dpy;
> +               memset(dpy, 0, sizeof(*dpy));
> +               early_memunmap(dpy, sizeof(*dpy));
> +       } else if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
>                 struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
>
>                 if (!si) {
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index ca697d485116..0f167c0e058e 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -23,6 +23,7 @@
>
>  #include <asm/efi.h>
>
> +unsigned long __initdata primary_display_table = EFI_INVALID_TABLE_ADDR;
>  unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
>
>  static int __init is_memory(efi_memory_desc_t *md)
> @@ -67,7 +68,18 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
>
>  static void __init init_primary_display(void)
>  {
> -       if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
> +       if (primary_display_table != EFI_INVALID_TABLE_ADDR) {
> +               struct sysfb_display_info *dpy =
> +                       early_memremap(primary_display_table, sizeof(*dpy));
> +
> +               if (!dpy) {
> +                       pr_err("Could not map primary_display config table\n");
> +                       return;
> +               }
> +               sysfb_primary_display = *dpy;
> +               memset(dpy, 0, sizeof(*dpy));
> +               early_memunmap(dpy, sizeof(*dpy));
> +       } else if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
>                 struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
>
>                 if (!si) {
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index a9070d00b833..c07f0878a4d6 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -63,6 +63,7 @@ static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
>  static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
>  static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
>
> +extern unsigned long primary_display_table;
>  extern unsigned long screen_info_table;
>
>  struct mm_struct efi_mm = {
> @@ -641,6 +642,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>         {LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,   &efi.unaccepted,        "Unaccepted"    },
>  #endif
>  #ifdef CONFIG_EFI_GENERIC_STUB
> +       {LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID,  &primary_display_table                  },
>         {LINUX_EFI_SCREEN_INFO_TABLE_GUID,      &screen_info_table                      },
>  #endif
>         {},
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d51777df12d1..f452fac90a9f 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -63,11 +63,13 @@ endif # HAS_IOMEM
>
>  config FIRMWARE_EDID
>         bool "Enable firmware EDID"
> -       depends on X86
> +       depends on EFI || X86
>         help
>           This enables access to the EDID transferred from the firmware.
> -         On x86, this is from the VESA BIOS. DRM display drivers will
> -         be able to export the information to userspace.
> +         On EFI systems, the EDID comes from the same device as the
> +         primary GOP. On x86 with BIOS, it comes from the VESA BIOS.
> +         DRM display drivers will be able to export the information
> +         to userspace.
>
>           Also enable this if DDC/I2C transfers do not work for your driver
>           and if you are using nvidiafb, i810fb or savagefb.
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 2a43094e23f7..f645bcc66ee2 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -406,11 +406,13 @@ void efi_native_runtime_setup(void);
>  #define EFI_CC_FINAL_EVENTS_TABLE_GUID         EFI_GUID(0xdd4a4648, 0x2de7, 0x4665, 0x96, 0x4d, 0x21, 0xd9, 0xef, 0x5f, 0xb4, 0x46)
>
>  /*
> - * This GUID is used to pass to the kernel proper the struct screen_info
> - * structure that was populated by the stub based on the GOP protocol instance
> - * associated with ConOut
> + * These GUIDs are used to pass to the kernel proper the info
> + * structures that were populated by the stub based on the GOP
> + * instance associated with ConOut.
>   */
> +#define LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID   EFI_GUID(0x8700a405, 0xcda4, 0x46d4,  0xb8, 0xc3, 0x04, 0xe5, 0xcd, 0xb4, 0x30, 0x21)
>  #define LINUX_EFI_SCREEN_INFO_TABLE_GUID       EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
> +
>  #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID     EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
>  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
>  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
> --
> 2.51.1
>

