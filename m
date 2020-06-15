Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB071FA3B0
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFOWr1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 18:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOWr0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 18:47:26 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4422074D;
        Mon, 15 Jun 2020 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592261246;
        bh=l5xn3hWywwIUsxSCziYZTq4fCCeouIWl+TiloSypP/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AejPNz379cU++IQTBkk3TbQkvqyjYky444eu1gkRa6iYpYT0+MSJZ+rL/hl70gCgx
         6tNd2uKxyG2UQ+/8w3/DphuFQz/n+9bHqh0cHKGpr6Fw/1yBDfnG/XL8tEJPh+DmL4
         c1q5z71VjBZ0VMWR6odyTniQRfKWPKi8AFh4ueA8=
Received: by mail-oi1-f177.google.com with SMTP id a21so17472906oic.8;
        Mon, 15 Jun 2020 15:47:26 -0700 (PDT)
X-Gm-Message-State: AOAM532lqwCoOxrFhUMMOL+gl9m6CyzmOyptbf4zlvpLsVqHmcM8wTrf
        Op64wSxoIM17n/BI1VDXjCpdFPwMe5EzbPkFkX4=
X-Google-Smtp-Source: ABdhPJzRbkunQxe3nsRx8sUCh0OWfnBBdryw9lHnqELep7robV2hSr4WG1AQyvT4eDlEvyFBC98Kfsdo6SSc4YF9X1s=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr1281295oif.33.1592261245700;
 Mon, 15 Jun 2020 15:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200615202408.2242614-1-pjones@redhat.com>
In-Reply-To: <20200615202408.2242614-1-pjones@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Jun 2020 00:47:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLwyk9ibSDXBfeu06HV4x4VtbWbKv20KNzkXpbTxBSXg@mail.gmail.com>
Message-ID: <CAMj1kXGLwyk9ibSDXBfeu06HV4x4VtbWbKv20KNzkXpbTxBSXg@mail.gmail.com>
Subject: Re: [PATCH] Make it possible to disable efivar_ssdt entirely
To:     Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Jun 2020 at 22:24, Peter Jones <pjones@redhat.com> wrote:
>
> In most cases, such as CONFIG_ACPI_CUSTOM_DSDT and
> CONFIG_ACPI_TABLE_UPGRADE, boot-time modifications to firmware tables
> are tied to specific Kconfig options.  Currently this is not the case
> for modifying the ACPI SSDT via the efivar_ssdt kernel command line
> option and associated EFI variable.
>
> This patch adds CONFIG_EFI_CUSTOM_SSDT_OVERLAYS, which defaults
> disabled, in order to allow enabling or disabling that feature during
> the build.
>
> Signed-off-by: Peter Jones <pjones@redhat.com>

Thanks Peter.

> ---
>  drivers/firmware/efi/efi.c   |  2 +-
>  drivers/firmware/efi/Kconfig | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 48d0188936c..4b12a598ccf 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -192,7 +192,7 @@ static void generic_ops_unregister(void)
>         efivars_unregister(&generic_efivars);
>  }
>
> -#if IS_ENABLED(CONFIG_ACPI)
> +#if IS_ENABLED(CONFIG_EFI_CUSTOM_SSDT_OVERLAYS)
>  #define EFIVAR_SSDT_NAME_MAX   16
>  static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
>  static int __init efivar_ssdt_setup(char *str)
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 6b38f9e5d20..fe433f76b03 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -278,3 +278,14 @@ config EFI_EARLYCON
>         depends on SERIAL_EARLYCON && !ARM && !IA64
>         select FONT_SUPPORT
>         select ARCH_USE_MEMREMAP_PROT
> +
> +config EFI_CUSTOM_SSDT_OVERLAYS
> +       bool "Load custom ACPI SSDT overlay from an EFI variable"
> +       depends on EFI_VARS

Shouldn't this depend on ACPI too?

> +       default ACPI_TABLE_UPGRADE
> +       help
> +         Allow loading of an ACPI SSDT overlay from an EFI variable specified
> +         by a kernel command line option.
> +
> +         See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
> +         information.
> --
> 2.26.2
>
