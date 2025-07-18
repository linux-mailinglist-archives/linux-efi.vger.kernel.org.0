Return-Path: <linux-efi+bounces-4417-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BC7B0A03C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jul 2025 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25FE3BCFF8
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jul 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FA1F0992;
	Fri, 18 Jul 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb5x9nPg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5979CD;
	Fri, 18 Jul 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832867; cv=none; b=tVz3859qFWt3TZG9xQDoKGSf4lTMQSVVB03EL4wFEy5E3SGbivHq20G6JapWg4QrG6tk1xkczYJsXl0TQw79MPBFg5ij5IRP+9gMBZAIJfypnGxHA0L2yEwSOt4zAeoTlbWik1OFeMuT4p9E2ThoDVsJENceJGqAkVvoPqtoOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832867; c=relaxed/simple;
	bh=Tuozthw9ZWbinUst0+W0nWgiSMxjatMcwMmEzhFln5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmk1CgAtpsL0HRUX/weHY2zh5d31K5SINPsyWL2/lfAS5UPxdqmniYgIU9UnDXN/MeWg0G70HeiCb8TAlQO/Fl3E5V3sjfGidnhtDKdlE6PsWWDrU6O/asqIbdk9MJYpMkikxzppMxxTyVRxxJOKaCBj4ePORlFwxM/Ujcq8zbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb5x9nPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AD7C4CEF5;
	Fri, 18 Jul 2025 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752832867;
	bh=Tuozthw9ZWbinUst0+W0nWgiSMxjatMcwMmEzhFln5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gb5x9nPgu10FGWRqoi3cYuNPfLlL4YvTg1GtAKsR4yovmNJ/DXkg6iUNp2VBs1eAG
	 AoyJqtTbxq0NyXyMZwRd/DWchb4kpYTfF4pJv5WQm7jiCP3X2drP61hHxc6pcn7Sad
	 fA8psSt9EGMX49daeRH5qhiAjl+UWgtgHA4iYkvjaecBpxx20IfLR/yTQ9qfUA+cAD
	 0ppwN0vBs4b3DX9tkNTf5XXDKSGnIQuoCowo65VMdnEfQ05LXRxipPWV/lvvl7iCYX
	 GLZ56tnW5jmIYnoscROTXhNQyMU93OEuAgtWU6C4k5W07x2Mx1kLn9+bkqir5wW7YI
	 K6IjImtoi0ScQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32f1763673cso22245681fa.3;
        Fri, 18 Jul 2025 03:01:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs/z7jIlGpmazhLuQ0ge6wpbLhOJIorKkgic/QdMm1xXFZ+rEDjLSqnHvxL0+j8hlufg1V7NDWBnV/B3SW@vger.kernel.org, AJvYcCXxRhr8vxbIT4TeH4DTvfCBjtJeI7ZmDm120YJtR87/j6/lInraSrDrevhSdDl/Y5g6uzoT/doKY3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqhWovvelzNofgVYud2KNssb9ypitV1kxCMYxKyfCBgY0bI5Dd
	L2oB2BLm9bAr0AngsJcbm1lQhxIdVwZEuh2q529dgZw3Y9i/axeVZoTQp2/B0llbcndja3xyOku
	vT7leTTMxO9uk6d7/VQ0BqjDvSnkN9qQ=
X-Google-Smtp-Source: AGHT+IE0JCjejMM8BHSWUFcEITfm3S50lNi329nj7HudyvgVJDd7HBWaJvX53xeYPxLhkNJuVFSXo5kd/764/FTiu6s=
X-Received: by 2002:a2e:b8c2:0:b0:32a:8ac3:93f7 with SMTP id
 38308e7fff4ca-3308f4e4c22mr28117531fa.14.1752832865643; Fri, 18 Jul 2025
 03:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-kmemleak_efi-v2-1-871878b767f5@debian.org>
In-Reply-To: <20250716-kmemleak_efi-v2-1-871878b767f5@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Jul 2025 20:00:51 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFLE+9OsYJepxm0seHREvFB52VvjcQrRnQoSAT9Aoe1Mw@mail.gmail.com>
X-Gm-Features: Ac12FXxUGFgRcSJwNYt8mbvnKAC1vrmToitVmFr_ofEm1l7fW_1PEYNQzsF1AOM
Message-ID: <CAMj1kXFLE+9OsYJepxm0seHREvFB52VvjcQrRnQoSAT9Aoe1Mw@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Fix memory leak of efivarfs_fs_info in
 fs_context error paths
To: Breno Leitao <leitao@debian.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mgarrett@aurora.tech>, Jiao Zhou <jiaozhou@google.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 01:23, Breno Leitao <leitao@debian.org> wrote:
>
> When processing mount options, efivarfs allocates efivarfs_fs_info (sfi)
> early in fs_context initialization. However, sfi is associated with the
> superblock and typically freed when the superblock is destroyed. If the
> fs_context is released (final put) before fill_super is called=E2=80=94su=
ch as
> on error paths or during reconfiguration=E2=80=94the sfi structure would =
leak,
> as ownership never transfers to the superblock.
>
> Implement the .free callback in efivarfs_context_ops to ensure any
> allocated sfi is properly freed if the fs_context is torn down before
> fill_super, preventing this memory leak.
>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: 5329aa5101f73c ("efivarfs: Add uid/gid mount options")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - instead of silenting the warning, just fix the problem.
> - Link to v1: https://lore.kernel.org/r/20250715-kmemleak_efi-v1-1-c07e68=
c76ae8@debian.org
> ---
>  fs/efivarfs/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Queued as a fix - thanks.



> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index c900d98bf4945..284d6dbba2ece 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -390,10 +390,16 @@ static int efivarfs_reconfigure(struct fs_context *=
fc)
>         return 0;
>  }
>
> +static void efivarfs_free(struct fs_context *fc)
> +{
> +       kfree(fc->s_fs_info);
> +}
> +
>  static const struct fs_context_operations efivarfs_context_ops =3D {
>         .get_tree       =3D efivarfs_get_tree,
>         .parse_param    =3D efivarfs_parse_param,
>         .reconfigure    =3D efivarfs_reconfigure,
> +       .free           =3D efivarfs_free,
>  };
>
>  static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendo=
r,
>
> ---
> base-commit: 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
> change-id: 20250714-kmemleak_efi-bedfe48a304d
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

