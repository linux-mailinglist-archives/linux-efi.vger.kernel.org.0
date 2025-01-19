Return-Path: <linux-efi+bounces-2685-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56522A1632C
	for <lists+linux-efi@lfdr.de>; Sun, 19 Jan 2025 18:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317FA7A1C69
	for <lists+linux-efi@lfdr.de>; Sun, 19 Jan 2025 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463321DE8BD;
	Sun, 19 Jan 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qErCJXIh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15530184;
	Sun, 19 Jan 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737306693; cv=none; b=IauvcaVI1FNjZOw3wyYSYI3mI8R/LNsY9FvjllyNg1+375Yk72HnYih+PVUuTwo0E4KrjtsrIYPTjZiqcCHQ/WRkrsYmNzqaQYv2OrzdwxOhxTKpcRj21oTaycxU1GJawX0CNcTHqxPbKCIe5s6yD34s2MVodQOEZfdsS/dt7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737306693; c=relaxed/simple;
	bh=2KdIgeLzRQqc/qr8dNXMLRa99hB5pwAg/GwCUdOTvK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP+cXY/siPkOk9RORzwnszPyaXW+xBOnq98Krhix5gGt2As0intsbEf63lNZndrbAN5Oyn6r9Zp+wi7ubXV8hveyKf/BtTzxp4SUFdqcFKuYe5zEsFFs9dzdoOWaGenz+ykF6RJGOCOQGr503dSEI2yKBhwEXvGk5U02Wt1kd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qErCJXIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B551C4CED6;
	Sun, 19 Jan 2025 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737306692;
	bh=2KdIgeLzRQqc/qr8dNXMLRa99hB5pwAg/GwCUdOTvK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qErCJXIhj/DU8y59SrxVFL8tZP5Pa1p0p1tHrLH0lxYAYprQJ1aumnH4fe8jvRUhO
	 7fIKM2zKfao75t/Rkrf5sGQkwHYtillTl6DODclJqTj4mzVjimScAAARqOXeaUwDik
	 Dvj8y9jABtUyhP+aP1Nt4dT7ezx28fs4asMDU3LFpmXCtIeJsGcn8LT2naFiCIGCgk
	 8tThrCUzDTwtDX3r/Nw30QKC0TPxVczdjFWUkloLe0eMwgHD/xdx7Zk/XaVNRPoMbx
	 pt7FjFE55w0ElnxyPM8XQb1751TJKgO+GQ75Lg7ZcESnqGvo4xIbcPJfmePAsIJs1w
	 xcyJGKXjHLbbg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-304d760f12aso33884451fa.2;
        Sun, 19 Jan 2025 09:11:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrbFDdBSf+iFMF2+0o9srxCVuT0elhsjf2AhRPPARKotvV3LESjxqDl9cF6rmpaBdVIsjE1N7RnGkLNCIQ@vger.kernel.org, AJvYcCWyUadZDpqUFDYuN48PLDDf8+5+QKedcQmcQUYMA5WVL3aGac8e/PbUemCN4LAFYCMhauc+Y/+LPW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSz3z/SuyalgC0PV8iQqEub6S3T5coMGX7rdQCxaA6ZXATu0Ed
	kBaMWkTLqcNLZNO7XwByictmp2atXe1jN3V7D3QjwopwwAkUOXlcwvC2VdDwqsrMP0xLSGB2GiN
	GeQ34L/HOhMJhZBvDj8OdVO8YJJY=
X-Google-Smtp-Source: AGHT+IHaFS/2ql4oe4qNDGFHVGy0NHrDx/ThywVeydYIXUlGAn3mZuQ/7FQX+g2Tc7Hq4ivgdywtX+9SfZOu1dPnxNY=
X-Received: by 2002:a05:651c:b0e:b0:2ff:df01:2b43 with SMTP id
 38308e7fff4ca-3072ca9abd3mr44177951fa.18.1737306690802; Sun, 19 Jan 2025
 09:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117024452.2691546-1-linux@t4c.dev>
In-Reply-To: <20250117024452.2691546-1-linux@t4c.dev>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 19 Jan 2025 18:11:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGLGmKU1Nvz8oo-aui1AtWo_8YDdT9cGtVweV9d6K6D3A@mail.gmail.com>
X-Gm-Features: AbW1kvaIpeJ69NSCuf4e1mE7Y5fMvk7JdISWnR05cB6dU9c04GbMHzJ70zNRaEU
Message-ID: <CAMj1kXGLGmKU1Nvz8oo-aui1AtWo_8YDdT9cGtVweV9d6K6D3A@mail.gmail.com>
Subject: Re: [PATCH] efistub: add efi=quiet parameter to selectively silence
 efistub alone
To: linux@t4c.dev
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 03:46, Hendrik 'T4cC0re' Meyer <linux@t4c.dev> wrote:
>
> While the general `quiet` kernel parameter is available to silence
> output from the efistub, setting this comes with side-effects.
> This patch adds a parameter efi=quiet to selectively set the loglevel
> for the stub alone to quiet, as the polar oppoosite to efi=debug.
>
> Signed-off-by: Hendrik 'T4cC0re' Meyer <linux@t4c.dev>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  drivers/firmware/efi/libstub/efi-stub-helper.c  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3872bc6ec..94a2f6ae7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1454,7 +1454,7 @@
>         efi=            [EFI,EARLY]
>                         Format: { "debug", "disable_early_pci_dma",
>                                   "nochunk", "noruntime", "nosoftreserve",
> -                                 "novamap", "no_disable_early_pci_dma" }
> +                                 "novamap", "no_disable_early_pci_dma", "quiet" }
>                         debug: enable misc debug output.
>                         disable_early_pci_dma: disable the busmaster bit on all
>                         PCI bridges while in the EFI boot stub.
> @@ -1471,6 +1471,7 @@
>                         novamap: do not call SetVirtualAddressMap().
>                         no_disable_early_pci_dma: Leave the busmaster bit set
>                         on all PCI bridges while in the EFI boot stub
> +                       quiet: disable most log messages.
>
>         efi_no_storage_paranoia [EFI,X86,EARLY]
>                         Using this parameter you can use more than 50% of
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index c0c81ca42..b8ad629cc 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -97,6 +97,8 @@ efi_status_t efi_parse_options(char const *cmdline)
>                                 efi_disable_pci_dma = false;
>                         if (parse_option_str(val, "debug"))
>                                 efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
> +                       if (parse_option_str(val, "quiet"))
> +                               efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
>                 } else if (!strcmp(param, "video") &&
>                            val && strstarts(val, "efifb:")) {
>                         efi_parse_option_graphics(val + strlen("efifb:"));

Hello Hendrik,

Could you explain the use case please? Your concern is that removing
'quiet' from the command line is producing a few additional lines of
output from the EFI stub at boot? How is that a problem compared to
the fact that you get the entire kernel log printed to the console? Is
every single line printed there relevant to you, and only the ones
emitted by the EFI stub are not?

