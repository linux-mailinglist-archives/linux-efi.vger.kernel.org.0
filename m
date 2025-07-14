Return-Path: <linux-efi+bounces-4302-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5552B03470
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 04:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BF53B9DF5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC51A5BA3;
	Mon, 14 Jul 2025 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad3CmMEJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F739184;
	Mon, 14 Jul 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752459761; cv=none; b=KyCrIj4oLU4PfoP2bMRh1v5mlV95V9HcCmnLKwZ+QJQlm1dQ6czrf/1MAguG/KjTh4MdTx3dNdr9JmNEvWSi1w6j+An9mmbq4yNSf3XrfPHooQC28Yz7ov3O6fD1Gxn/XZjMWl911bpogax7o3/MheeW2Kgwzvwx47ktCuvROEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752459761; c=relaxed/simple;
	bh=zix9ri6vfTswvmpA/jCkVghWpzfujrWr8l27YzRLFZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sb8LRx6c1dnPhJaRaIWRAqP39kXJTc1Wyx/xmfA5MCL1kWF8VXFifqCbq+saMe+ReO9G1tGOdppF+j64RP1DjRQuP4kJ3C98cykPsXoaZjOYYpdn2BuGIRQ9vQKRSzpS26MxxiDjjD6m2jLy035k1/Y8LcOuIZLIZIrENolNGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad3CmMEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8780BC4CEF7;
	Mon, 14 Jul 2025 02:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752459760;
	bh=zix9ri6vfTswvmpA/jCkVghWpzfujrWr8l27YzRLFZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ad3CmMEJUjZx6ln8A23SIatIJIl1k/kQBv2jle24TqsxgCeBdgRySqXj8Wh5v0nTJ
	 LV5OCH4ZEVJwDTZbo9+zIWB/vZ91jZc7rlvZWAS/UMkRwKOw+WFvquVRZ1nU+wBqfw
	 cYef3l4rPlQUbXWR7D85fLJKl81oRbpl/zExX3VI3wPXJJ29L1UxBFhY5muNwlNuBr
	 tKQpQcKhp/I2KFKymubbSAr4RJ545hPeAxokSDhkF3NueRh6DL3cQHKEI3328R0bva
	 YJ8s7Mtp552Zr9jDLaU+gKmhxjX0OaAPEtRUc6vde0aiHbYufjpSViBBldKrQxVSKW
	 NsEe6LaD0npzQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b561a861fso32970151fa.0;
        Sun, 13 Jul 2025 19:22:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbJ1nhJHfeQz0Lha1HeXgo0Ak4Rd8NrU1T+D9kZsvHncU8lKgo+jGiXryBEbj4FjoPLqk6Q76o8Q3Ie8rS@vger.kernel.org, AJvYcCXhTzYgYOnyxDe6g796IQhM3vFbCTEY55BP7jMh1KknQMg+slRnyQocZ+HyOasfpepSd54UbVcBXpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwazjZHn61hpEAxNXkCh8iBwNc6D0eQmv42U627zBAZrW7Q9L8g
	3D1MZ7tw4YBiHyoV+vaJQ9P4Sf3PPTiSoboB1WoTn/x/RdZd4joLq67XC8ITFpReuKHzOgqiFbv
	CO5cCbDuLLtOXpWwWTgFUHJvBIxqRpAI=
X-Google-Smtp-Source: AGHT+IEn91j/73d1i/bAP+/uNV+DKkD1Gnv2YyhYH9rtQ+TBzQd5HefPzO//qx9sbRsJzcxnV0AbP0KnOImK77KCkdg=
X-Received: by 2002:a2e:b88e:0:b0:32b:2fba:8b90 with SMTP id
 38308e7fff4ca-3306ce94ad2mr7854221fa.14.1752459758912; Sun, 13 Jul 2025
 19:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711054446.1537700-1-kraxel@redhat.com>
In-Reply-To: <20250711054446.1537700-1-kraxel@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 12:22:26 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEsERVQgm2PF4npmeKg_tM2-ivFXwFObQzddxMaU5HMyg@mail.gmail.com>
X-Gm-Features: Ac12FXyY6r9URRzQ90qQCOY-4pySoh-E8L_P9Pr_ZLgTl0X5ko6UYOxRdt7PlVg
Message-ID: <CAMj1kXEsERVQgm2PF4npmeKg_tM2-ivFXwFObQzddxMaU5HMyg@mail.gmail.com>
Subject: Re: [PATCH] efi: add API doc entry for ovmf_debug_log
To: Gerd Hoffmann <kraxel@redhat.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-efi@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

(cc Jon and linux-doc)

On Fri, 11 Jul 2025 at 17:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks. I'll queue this up in the EFI tree unless Jon prefers to take it.


> ---
>  Documentation/ABI/testing/sysfs-firmware-efi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> index 5e4d0b27cdfe..927e362d4974 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-efi
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -36,3 +36,10 @@ Description: Displays the content of the Runtime Configuration Interface
>                 Table version 2 on Dell EMC PowerEdge systems in binary format
>  Users:         It is used by Dell EMC OpenManage Server Administrator tool to
>                 populate BIOS setup page.
> +
> +What:          /sys/firmware/efi/ovmf_debug_log
> +Date:          July 2025
> +Contact:       Gerd Hoffmann <kraxel@redhat.com>, linux-efi@vger.kernel.org
> +Description:   Displays the content of the OVMF debug log buffer.  The file is
> +               only present in case the firmware supports logging to a memory
> +               buffer.
> --
> 2.50.1
>

