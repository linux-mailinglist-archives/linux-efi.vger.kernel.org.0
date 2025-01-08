Return-Path: <linux-efi+bounces-2532-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BFA06236
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3C3166138
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967E1FFC65;
	Wed,  8 Jan 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmF6qMZ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B34F1CD0C;
	Wed,  8 Jan 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354318; cv=none; b=OhkR0suyA9KtYnoMgKkxgDl4SGk5R034EHtxZgxFfC241a8A6LXEa8Yr2SRWw9V5yTpKvG3jQKSFNrbwnWwdfs84+FgLF4Vdm9Iev1Jg/0KYpTk/++v/JLKVE0wiO1BL8Fis1KKb1eVuqf3igS/77wZ0sav52/sxtz9Vop4QpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354318; c=relaxed/simple;
	bh=54Ho3S2MpWfjsZSMjSbs5E77+mT4xdMcLLvC5IojQBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMxhgWAxpoMW5+9Pkeb0E2gXGUTDKe72OmNN014yl31tMWxxAHWZWbMsiQi/icyIntHOSEuXJTk7Ks+LxGhVe7pnkaJFLSEMhPop8DCi8ak0SBx+h12IfVqtY5GVxeSgolOvCQpk0Cu9V73uD3aIwLzhSaaTNPUJHgu10Zy5/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmF6qMZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1376C4CEDD;
	Wed,  8 Jan 2025 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354317;
	bh=54Ho3S2MpWfjsZSMjSbs5E77+mT4xdMcLLvC5IojQBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NmF6qMZ77jRi7x9FIq8X+HPpnmTKFT7fEEbsDCFbHwNWxav+KOqRjiZg5WYJBDmII
	 7fxEj4XXovKTA31EfeVF1fZm6cQ1V49zuHP9t8Klx6sWnyZ//nPCa+ggNACb6OVt1R
	 //IwsYptQ1Tm6jagcP4QVQh1mkiXyKf2YDJzNhSpbPK4Gl+73SL9jHvmfKaX5llKIN
	 Ek95oIhwyb7D0y5iIwJn9eY9QYYEjlkM+jPlyCC4cJ10dubL69+kD2V5DuHQOGxxiH
	 FU6B8llMHdpnULPJK5skEh+gaJPD58MkyyWyzVGOJJVi4evY4LyoOtN9jfUm7P8gqj
	 XYbSmKwsi/FFQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54252789365so10809717e87.0;
        Wed, 08 Jan 2025 08:38:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkabE07RLqEKzox6XNEGkbKh58g7ZwZDK5Y5q5ByavbQ5McjT6p3SWl10rbPFUa25fjZL8ofLDoiqOIdU6@vger.kernel.org, AJvYcCUkhe73dF/Yqvnm9I2jO53msxfkskxYFZn4Lg0WyW7Ez1OCPwKWdQbCutcoRhWI4zNAZEah0PXVvFo=@vger.kernel.org, AJvYcCVttZnKPcliyuHFN2tRGrlQyweNsCIoaWAEFkSiVfVw/3+Khb6VU+tRjl0sUaMiW9Yadd5Oy2IHf2t4RWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEUuoNMFft3w1sfeKwKUZnVfOvY2ODgwLgaZudBPoVNO0D3+3
	zm3Lc+G3b59icfRWwc6TY5btHKCwAqB1OLMN0cMSoGobF1w4qVJS9ARJmrleeaZ8JNVkWUGpEdt
	KAQzqPNT6REqqa0TVh11iJswepYw=
X-Google-Smtp-Source: AGHT+IHvmWZmxBUBQ/VGk1egiaD/PcQzkygpHoXXsanCSWzCic1Vwbkuh2BOhVv/e/xkTPrKAPUWxkIZ6FkGzXr2PEI=
X-Received: by 2002:a05:6512:ea0:b0:540:2a92:7da9 with SMTP id
 2adb3069b0e04-542845bf642mr935644e87.21.1736354316205; Wed, 08 Jan 2025
 08:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107235312.236247-1-rdunlap@infradead.org> <87zfk1iuk9.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87zfk1iuk9.fsf@minerva.mail-host-address-is-not-set>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 8 Jan 2025 17:38:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEzGnx8WivWuY5WqKqMxk3rYw1aR9-Gc80D=kWDyW3SZA@mail.gmail.com>
X-Gm-Features: AbW1kvbwcw_bWNjbkwek1dRsNPOBu4U_AR1-dw9pVD_hU0-oZZUOxO-y4lxAWi0
Message-ID: <CAMj1kXEzGnx8WivWuY5WqKqMxk3rYw1aR9-Gc80D=kWDyW3SZA@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: fix W=1 warnings when EFI is not set
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, David Rheinsberg <david@readahead.eu>, Hans de Goede <hdegoede@redhat.com>, 
	Peter Jones <pjones@redhat.com>, Simona Vetter <simona@ffwll.ch>, linux-fbdev@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 09:22, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Randy Dunlap <rdunlap@infradead.org> writes:
>
> Hello Randy,
>
> > A build with W=3D1 fails because there are code and data that are not
> > needed or used when CONFIG_EFI is not set. Move the "#ifdef CONFIG_EFI"
> > block to earlier in the source file so that the unused code/data are
> > not built.
> >
> > drivers/firmware/efi/sysfb_efi.c:345:39: warning: =E2=80=98efifb_fwnode=
_ops=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >   345 | static const struct fwnode_operations efifb_fwnode_ops =3D {
> >       |                                       ^~~~~~~~~~~~~~~~
> > drivers/firmware/efi/sysfb_efi.c:238:35: warning: =E2=80=98efifb_dmi_sw=
ap_width_height=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >   238 | static const struct dmi_system_id efifb_dmi_swap_width_height[]=
 __initconst =3D {
> >       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/firmware/efi/sysfb_efi.c:188:35: warning: =E2=80=98efifb_dmi_sy=
stem_table=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >   188 | static const struct dmi_system_id efifb_dmi_system_table[] __in=
itconst =3D {
> >       |                                   ^~~~~~~~~~~~~~~~~~~~~~
> >
> > Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501071933.20nlmJJt-lkp=
@intel.com/
> > Cc: David Rheinsberg <david@readahead.eu>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Cc: Peter Jones <pjones@redhat.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: linux-efi@vger.kernel.org
> > ---
> >  drivers/firmware/efi/sysfb_efi.c |    2 +-
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Thanks all. I'll queue this up.

