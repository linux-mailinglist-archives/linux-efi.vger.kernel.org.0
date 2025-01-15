Return-Path: <linux-efi+bounces-2637-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC9A12673
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7282E3A9A76
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAA433CA;
	Wed, 15 Jan 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnjyuXHJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D724A7FF;
	Wed, 15 Jan 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952419; cv=none; b=scA7Pm6UAIPG5Sb0DNXPRBh6zFHoCDC2CV0ql4GnGEyGUffC6Nqgxm0xfH7fQ6hWMlYNCQJ/MqBJgxIjM/GiyXM6rQBNDoXHtJayhdLHWpoicLNHBCzvrnk9ywRmsVNW9nrItMJ63Ea92QmRvtCHL2VGIj78YNAdi17KYzmiu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952419; c=relaxed/simple;
	bh=FQXBwXon/Fhp3Ey/R4C8SnzqxvZDF13OmPZXeSZDqoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPyRfasCWn7pdhqJDhoveRa/JEvPi3Xo4K/gOb/9ykG41zb2xnDxl27OIXy6Da0On/0mQ54/IaR0GwaM78xM0v/GyzYrxCwCEM/fyAVxh/4AuN5czh8h2HP39OE8C1anBYqt8XGaOQFzUWRFe/5yVljPw3//Q3fzM7AnF6wTbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnjyuXHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF18C4CED1;
	Wed, 15 Jan 2025 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736952418;
	bh=FQXBwXon/Fhp3Ey/R4C8SnzqxvZDF13OmPZXeSZDqoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dnjyuXHJxx++z1giYHFq3VrdQel5acqA60le5wJ5zJrBF5mAJbTTJfRv7kNKC5YKG
	 KvBboeeEqueviIOA7UEuKbq6jVbBe/3hlXih1gFp+VeMxA+dqAxPMT488zKF/f4hJb
	 Tb8GqktgiUtPWWstmZqIK7USjw8zRgMxbVCl2UO+7dxDKucm3rMbRrF+9/nP5+kGrN
	 Rp7pdUm4N7y+B+XxniptpNPPrnw5D7kpoVTYv8Dbe+McL57cIL+zfAzyxh68z++MhR
	 ZwFHDZ7Z1s/z8Up5Df6l2xIlyvcHYSi905MD/GSEa0/JK0QZXYpabyPIflYlfUch1M
	 /eUemrA9R+kzg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3002c324e7eso64372701fa.3;
        Wed, 15 Jan 2025 06:46:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm4KMn55RbiTS+1mblDbq2FAZPWoZ+OuyC67oy6lNunq6LadzKp7Jkx//ICwo03kOkHCkeWWT5yKtI/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEapU1wZxvqrtjgS2RY6koUwFKvA++oNfox/YOy+TUdkOCaT9+
	vQbbgFlbSvD9muXUK7nbzo8vSSkyR8SzqbTGunjSfPSr7y9DV57H/c/cod2vNUPHB7we6EOeMzr
	NJCxGNwuQ4s7TtaXi1RiNmkC3JvA=
X-Google-Smtp-Source: AGHT+IE8+K7SCmFYjUu+coroLDvCFxXrAU2bFwyE1s0NKuPTYxe5T1II2jxPPIIUZXwxmtAaAx6N8Ykbc0W9N/Z5LHY=
X-Received: by 2002:a05:651c:a0a:b0:300:360b:bc3f with SMTP id
 38308e7fff4ca-305f4543372mr94751951fa.15.1736952417177; Wed, 15 Jan 2025
 06:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115141650.3658827-1-eleanor15x@gmail.com>
In-Reply-To: <20250115141650.3658827-1-eleanor15x@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 15 Jan 2025 15:46:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFGrTQHONPCJMvMJ5aaswh1YF9aCcufS_9YsS5F+uYJpQ@mail.gmail.com>
X-Gm-Features: AbW1kvbMiMel4vdzFQZGl7VMCiNI09UpPJ-RKUAF3Rme45lT6K6TgNcc1L4Gz68
Message-ID: <CAMj1kXFGrTQHONPCJMvMJ5aaswh1YF9aCcufS_9YsS5F+uYJpQ@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: guard EFI-specific code with CONFIG_EFI
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 15:17, Yu-Chun Lin <eleanor15x@gmail.com> wrote:
>
> As reported by the kernel test robot, the following warnings occur:
>
> >> drivers/firmware/efi/sysfb_efi.c:331:39: warning: 'efifb_fwnode_ops' defined but not used [-Wunused-const-variable=]
>      331 | static const struct fwnode_operations efifb_fwnode_ops = {
>          |                                       ^~~~~~~~~~~~~~~~
> >> drivers/firmware/efi/sysfb_efi.c:240:35: warning: 'efifb_dmi_swap_width_height' defined but not used [-Wunused-const-variable=]
>      240 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/firmware/efi/sysfb_efi.c:190:35: warning: 'efifb_dmi_system_table' defined but not used [-Wunused-const-variable=]
>      190 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~
>
> Unused variables, functions, and macro are conditionally compiled under
> CONFIG_EFI. This includes 'efifb_fwnode_ops',
> 'efifb_dmi_swap_width_height[]', 'efifb_dmi_system_table[]',
> 'efifb_add_links', 'find_pci_overlap_node','efifb_set_system',
> 'efifb_overlaps_pci_range', and the 'EFIFB_DMI_SYSTEM_ID' macro.
>
> Suppress unused symbol warnings and ensure inclusion only in relevant
> configurations.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501051626.SMkizYIE-lkp@intel.com/
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
>  drivers/firmware/efi/sysfb_efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Is your patch better than the one already in linux-next?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=19fdc68aa7b90b1

> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index cc807ed35aed..4efe383cc470 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -174,6 +174,7 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
>         return 1;
>  }
>
> +#ifdef CONFIG_EFI
>  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)              \
>         {                                                       \
>                 efifb_set_system,                               \
> @@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
>         .add_links = efifb_add_links,
>  };
>
> -#ifdef CONFIG_EFI
>  static struct fwnode_handle efifb_fwnode;
>
>  __init void sysfb_apply_efi_quirks(void)
> --
> 2.43.0
>

