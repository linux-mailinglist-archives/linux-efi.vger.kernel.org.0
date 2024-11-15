Return-Path: <linux-efi+bounces-2154-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4E9CDBAC
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901E3283838
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9118DF89;
	Fri, 15 Nov 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj5jP3Cm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29886161328;
	Fri, 15 Nov 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663277; cv=none; b=rNhYc8uQ2EZFWF2tdaBda2AomuPPv5fp1F14KpDayqvVX2VV5hdDUI6oXwR/jW+l3g9OPV1T8GMFqNZHa8fuhhSe6E7U4I27tdT64KpHcVODyl6AEqUp+C6nLZgckwSDVxEsqfTPYmdKkGjPjRVgIh7XR069iAMUhrak10/5s84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663277; c=relaxed/simple;
	bh=JQlPKqTpFyA0j2thumzbxP70BwmQdn+q21TxSdA55Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ccwe8+WETFsnelMiMdgcRBRwi6K5yFQx+7QJ3YUeGB7YOAS3CN8xV0qkc+/9BwNnD5qCwrLxOFfX5F9QvqAFnnwdmJYbLJYseD4NCwEyahH0ZS+d7RpPMuq6U64Nc7ALgFRbZSey/MjnSj11Bl4wmcMpKh6vauFe90rzMlAUHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj5jP3Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E6EC4CED6;
	Fri, 15 Nov 2024 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731663276;
	bh=JQlPKqTpFyA0j2thumzbxP70BwmQdn+q21TxSdA55Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lj5jP3CmUlDRlrVBOLX7TGO2SKqkmRA230KTRUPbG5DYl/r0PRUhTg5pgevx4GBb/
	 I3zxGppJodNo9iZdqcCkwYmnZHYasg8GA8UYNzBxZzbHijme+hh86tVLKem31WPPdp
	 4ybxWlwwhrTc2rseuURFZnriMrWNYcHuPkhN3MOekdOVx9quqXC4vbwiwepgiWR916
	 NM5cMM1IG+s3NUC97aFoEt9rBZPgLUcbGH5wQhB7o/82iXnon1qzZs3jLoZtb48Am4
	 emZmBqd7NdZ9MuQmqhdfHCOVu8vNG62+6/m2eJ6oZ31VABaiKNqJwM3W7sOSqPskk7
	 px/yW0C4JB9Zg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53c779ef19cso531535e87.3;
        Fri, 15 Nov 2024 01:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtqWBK+radAfIIP0VhltZAyvNPOXrY+SisbrNqGhx7ELK1v9g8O5NHoo6+yFeMrfYx6RXaRPlNHts=@vger.kernel.org, AJvYcCW7s3FzcNt6IdFEinuofQKYBjC+LQ9yIewqsQssdP0GtEe7uFBimnnrtORLZb/Nawb7fP859xB4y5CO4Qve@vger.kernel.org
X-Gm-Message-State: AOJu0YwFL2QV5nKzzI2dVQYkaHcoZ6MKMIaK0pVZDjJj6JS5yNtywIGK
	+vungim6q3M1SVmJsZfxXTK/SiWqzv8wa4BrTiQtqm9xKy/6G53O+dyJFXIhEwIKRWZISbI1xMo
	brqBoAXMDpVhvj4GbcoFMkLCkLSo=
X-Google-Smtp-Source: AGHT+IHpyqw2Jkp7a3n7b6aXQH6kbbyi+avVgVFVLmvDxKCUf6uJ6IogfuMUe0NMe5QbqJH3axf02kJIjxgrXsFSU4M=
X-Received: by 2002:a05:6512:3c87:b0:53d:a2cb:349e with SMTP id
 2adb3069b0e04-53dab291a9amr840915e87.4.1731663275009; Fri, 15 Nov 2024
 01:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026070228.3240177-1-zengheng4@huawei.com>
In-Reply-To: <20241026070228.3240177-1-zengheng4@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 10:34:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXETHkWvHEs9TuRxB61KvFr11SrLnQGuQTiVtupeAvFCMA@mail.gmail.com>
Message-ID: <CAMj1kXETHkWvHEs9TuRxB61KvFr11SrLnQGuQTiVtupeAvFCMA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: sysfb_efi: Fix unused const variable 'efifb_fwnode_ops'
To: Zeng Heng <zengheng4@huawei.com>
Cc: tzimmermann@suse.de, javierm@redhat.com, andriy.shevchenko@intel.com, 
	bp@suse.de, simona.vetter@ffwll.ch, bobo.shaobowang@huawei.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Oct 2024 at 08:48, Zeng Heng <zengheng4@huawei.com> wrote:
>
> Fix the following compilation warning:
>
> drivers/firmware/efi/sysfb_efi.c:345:39: warning:
> =E2=80=98efifb_fwnode_ops=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>   345 | static const struct fwnode_operations efifb_fwnode_ops =3D {
>
> drivers/firmware/efi/sysfb_efi.c:238:35: warning:
> =E2=80=98efifb_dmi_swap_width_height=E2=80=99 defined but not used
> [-Wunused-const-variable=3D]
>   238 | static const struct dmi_system_id
>         efifb_dmi_swap_width_height[] __initconst =3D {
>
> drivers/firmware/efi/sysfb_efi.c:188:35: warning:
> =E2=80=98efifb_dmi_system_table=E2=80=99 defined but not used
> [-Wunused-const-variable=3D]
>   188 | static const struct dmi_system_id
>         efifb_dmi_system_table[] __initconst =3D {
>
> In addition to the above warning messages, a series of unused warnings
> because of cascading dependencies were found. The variables and functions
> related to warnings are only used after CONFIG_EFI enabled. Therefore,
> these warnings are addressed and fixed in this commit.
>
> Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup=
 for all arches")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/firmware/efi/sysfb_efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Is there any reason to build this file in the first place if
CONFIG_EFI is disabled? Should we fix this in the Makefile instead?


> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysf=
b_efi.c
> index cc807ed35aed..0cfc11ecc98b 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -82,6 +82,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const=
 char *opt)
>         }
>  }
>
> +#ifdef CONFIG_EFI
>  #define choose_value(dmivalue, fwvalue, field, flags) ({       \
>                 typeof(fwvalue) _ret_ =3D fwvalue;                \
>                 if ((flags) & (field))                          \
> @@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_op=
s =3D {
>         .add_links =3D efifb_add_links,
>  };
>
> -#ifdef CONFIG_EFI
>  static struct fwnode_handle efifb_fwnode;
>
>  __init void sysfb_apply_efi_quirks(void)
> --
> 2.25.1
>

