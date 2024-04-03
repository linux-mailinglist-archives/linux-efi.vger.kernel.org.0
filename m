Return-Path: <linux-efi+bounces-917-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240D896FCC
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ED01C27848
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06C1474C0;
	Wed,  3 Apr 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBI6VS8p"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CA1EEF9;
	Wed,  3 Apr 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149443; cv=none; b=XHwMfx8McNs1J775Py6VSd+HeNtyD+u+VIy0Cq20CCWGuHWqxNvRsT/CbkHar6BHgoPvUbPVd3od33+7efGMIzMtlBX1cjGbBg06iVnq23U/JQYWff67U0DZHSM/Nc23GlMa9h8wAXZ9dENNn4KS5sv4FE8GghNINO74KE24s1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149443; c=relaxed/simple;
	bh=jAxgzwRTkP59nxfnPjXp9rWsoyhM/O0bfjbLfKVZk40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRmojtEip+UKpKa7Kflmnor0sVhmCgwvnY847CzdV9y2GK21MzX57rSNK3w2TFFdWyVSjqkkzoQ7840e0sly//47aPnh2eOLi9NFVr1XU+2Mw4uvTJg4UqBp3pkeC90av3K3mgZiNccOTygx7Pa2rqdujNd2FzC03iqYaM8frWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBI6VS8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209DFC43394;
	Wed,  3 Apr 2024 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712149443;
	bh=jAxgzwRTkP59nxfnPjXp9rWsoyhM/O0bfjbLfKVZk40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vBI6VS8p+fMh7+vTQBD3ictGeDJNrYI5GGa45VGtNi9AL34NobyZc7NVn1S5u0EPo
	 a4+R2biB55W6W0JfY2NoRcmn2FPM65MLicK80szCGL8a1cuJd/B/O/ER6sY0fcS2Xc
	 /Npz/cjOs67O1ZDY4bIMUihMIgyoO1Tz/duLeTYiXSdL5OtOi0cNp8bmumKfFDyTrv
	 dUATXnTMMbg1E7xC6VWOCEWx5yvICP5PbZC2+JepRN15WuICfYWx07TcIiW0ZcIVwz
	 tcHhXZpyrVTvfvcUK1U61/Xo32GTra8BI/9KXOuua0+gPzCmGOrbVzIqcpicYcoqXm
	 B2Ejxu849hddw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d475b6609eso69724641fa.2;
        Wed, 03 Apr 2024 06:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq8HL1aICeSeBCXXoHFEYZRPsCQjVEUTVH+weQ8+uvzLnEBCDIeUIolsHG2GGlATbzzUHu2UaC9E4AWXXMYSoHhocjjPirY3Bg
X-Gm-Message-State: AOJu0YwRqgAuwdpswPpA7pkEVSVnDTTn7rCDVny/3pBWNRONza2geglO
	Fz1RnOa08hmDZp+ulIx5ejjBVO92Gpf4c2eISvQPAIJN8Ue9E/LrNMa1M4yhFlpS/bFulSib/mW
	d1tETqmcp/napFNUXBoNw2Uia2Mk=
X-Google-Smtp-Source: AGHT+IHXQaEMys++S96XiBNlaXjAU9VskPXxODEVcvovTePiNNMFtNxf+XvNMPhpxzmDBKgVEKo0kD0osOIbNzPyuP8=
X-Received: by 2002:a2e:b8d2:0:b0:2d2:42ff:483c with SMTP id
 s18-20020a2eb8d2000000b002d242ff483cmr12406161ljp.33.1712149441487; Wed, 03
 Apr 2024 06:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-11-arnd@kernel.org>
In-Reply-To: <20240403080702.3509288-11-arnd@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Apr 2024 16:03:48 +0300
X-Gmail-Original-Message-ID: <CAMj1kXG2kcAmmB5aQRv5VBJ8Ov2fcg5waGpD1r=aOR9rV=dSWg@mail.gmail.com>
Message-ID: <CAMj1kXG2kcAmmB5aQRv5VBJ8Ov2fcg5waGpD1r=aOR9rV=dSWg@mail.gmail.com>
Subject: Re: [PATCH 10/34] efi: sysfb: don't build when EFI is disabled
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 11:09, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> With 'make W=1', there is a warning when EFI is turned off but sysfb_efi
> still gets built:
>
> drivers/firmware/efi/sysfb_efi.c:188:35: error: unused variable 'efifb_dmi_system_table' [-Werror,-Wunused-const-variable]
> static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>                                   ^
> drivers/firmware/efi/sysfb_efi.c:238:35: error: unused variable 'efifb_dmi_swap_width_height' [-Werror,-Wunused-const-variable]
> static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>                                   ^
> drivers/firmware/efi/sysfb_efi.c:297:28: error: unused function 'find_pci_overlap_node' [-Werror,-Wunused-function]
> static struct device_node *find_pci_overlap_node(void)
>
> There was an earlier patch to address the duplicate function definitions, but
> that missed how we should not be building this file in the first place.
>
> Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

or I can take it via the EFI tree if you prefer.


> ---
>  drivers/firmware/efi/Makefile    | 3 ++-
>  drivers/firmware/efi/sysfb_efi.c | 2 --
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index a2d0009560d0..3baf80d8cf81 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -30,7 +30,8 @@ obj-$(CONFIG_EFI_RCI2_TABLE)          += rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)    += embedded-firmware.o
>  obj-$(CONFIG_LOAD_UEFI_KEYS)           += mokvar-table.o
>
> -obj-$(CONFIG_SYSFB)                    += sysfb_efi.o
> +sysfb-$(CONFIG_SYSFB)                  += sysfb_efi.o
> +obj-$(CONFIG_EFI)                      += $(sysfb-y)
>
>  arm-obj-$(CONFIG_EFI)                  := efi-init.o arm-runtime.o
>  obj-$(CONFIG_ARM)                      += $(arm-obj-y)
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index cc807ed35aed..a8c982475f6b 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -346,7 +346,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
>         .add_links = efifb_add_links,
>  };
>
> -#ifdef CONFIG_EFI
>  static struct fwnode_handle efifb_fwnode;
>
>  __init void sysfb_apply_efi_quirks(void)
> @@ -372,4 +371,3 @@ __init void sysfb_set_efifb_fwnode(struct platform_device *pd)
>                 pd->dev.fwnode = &efifb_fwnode;
>         }
>  }
> -#endif
> --
> 2.39.2
>

