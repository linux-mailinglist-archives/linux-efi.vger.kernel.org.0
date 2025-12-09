Return-Path: <linux-efi+bounces-5825-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B1CAEB0F
	for <lists+linux-efi@lfdr.de>; Tue, 09 Dec 2025 03:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7523006F4A
	for <lists+linux-efi@lfdr.de>; Tue,  9 Dec 2025 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009823C4FD;
	Tue,  9 Dec 2025 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5+9n0nB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6623BF9F
	for <linux-efi@vger.kernel.org>; Tue,  9 Dec 2025 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245942; cv=none; b=O/LBcY4WXv3SK6z8prLSu9aTa8BS3Z0pILosntQt/QZWxfbQybjYy0xM4GNsPQpcAgXcwMFExABBlK5R7IHzfKjH/Y9cUEbIsDTFfmn+uL0ay30cE4S/mh8Ocxyg0/wUstQocXKaP2eH46OBJZfHkMbHNmt399FgQoNfygDvr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245942; c=relaxed/simple;
	bh=r2TLrXMNY6tdqpLXobOdQ7VcPmjJoeY/D/NczUBVb9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORSds1iMU5cXeqXMyu5i+cehFh0RuWgp+49m80zRV7xrze05DoTFwF5LjaKGBQ6sC93vLVllwrz9erPLbCT5WQyhA5wT/nctJizmONBo8kAvQucNVezXIelnq7/HWrnCQA0I2rDfdsRBWE1RzfgizYYwazMwXW3vKyBTQc8fgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5+9n0nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E83C19421
	for <linux-efi@vger.kernel.org>; Tue,  9 Dec 2025 02:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765245941;
	bh=r2TLrXMNY6tdqpLXobOdQ7VcPmjJoeY/D/NczUBVb9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S5+9n0nB615ZurPWCj75TPQeOQKLEF+PlUy/ICSaZbX9qlckBR/2apQcE+3WeY+ZK
	 fJDJrD+wykBa4ib1qatmEFlI+MMGBL5ML8D0wxtpSffHhMFVoVq4wPOWIZaVJew6UC
	 ZJNYk6ewGhwfo6fucMNX4YYMNqRtVTP2/QXtZdixUoFFGO1+2O2BDqxhZmDjqK4hBc
	 Ir/DeQf877PAnDiIOVblz1QDpsGZrNEUalbuyiK6sGC9QqEz63Yzq8gYsoaUL6ds2L
	 O4wCY5+cOGF4Sy5nXVRjM/2FSmEh8Yl4DVvn0ZvZUEPz19NL62eIc30FgLpai+Z7Sy
	 /5AMXGopU1GQw==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso4360374a91.2
        for <linux-efi@vger.kernel.org>; Mon, 08 Dec 2025 18:05:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXsSkH7mLD3dhEfQggggglGw6UtMP+M2/mVlPv2XVVMTDd0IKXuoAEC7ILOyZbDlnsBil+enwLaFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08rLP282UVSRAoEnZ7Ca/C0X3WwfNgmkFGkuBcWfwqPGZmuaJ
	iQtgN+N5ll8rAG5bupqW6CznQLJ6/NZjme9U6MMRH1rY6Euea2d3CmG1ALZIOIcUZrsaE85vFB8
	0Te3LuFw5ak+5PDElCNl1nE/zeBhID+g=
X-Google-Smtp-Source: AGHT+IHyKmMSYrVYsbJSKtDPABE9Jn39tYyzOnWg1/bGf+V3ApboC/uhg8RcVjfRBg5ctgchARRcyQuWCs7J6IUWjpY=
X-Received: by 2002:a17:90a:d450:b0:340:ec3b:b587 with SMTP id
 98e67ed59e1d1-349a24dd160mr7546009a91.1.1765245941305; Mon, 08 Dec 2025
 18:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208193925.7449-1-tursulin@igalia.com>
In-Reply-To: <20251208193925.7449-1-tursulin@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 9 Dec 2025 11:05:26 +0900
X-Gmail-Original-Message-ID: <CAMj1kXFZD+No6C4MEpmSY5Ha0DtJH+kHfTiO02By4ejUekLaRA@mail.gmail.com>
X-Gm-Features: AQt7F2pxwyMp3jupjJdnRCACLrDOSnZB2DzSsDgxxn7yVjvGaE4-ePdhmDRIjco
Message-ID: <CAMj1kXFZD+No6C4MEpmSY5Ha0DtJH+kHfTiO02By4ejUekLaRA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] EFI fbcon fixes etc
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 04:39, Tvrtko Ursulin <tursulin@igalia.com> wrote:
>
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Two generic fixes split out for easy review, one refactoring as requested, and
> then the last patch is the panel/mode quirk to allow for corruption free fbcon
> with simpledrmfb and efidrmfb on the Valve Steam Deck.
>
> v2:
>  * s/unsigned/unsigned int/
>  * s/pitch/linelength/
>  * Removed comment explaining the Steam Deck quirk.
>  * Added patch to refactor quirk application via callbacks.
>
> v3:
>  * Added forgotten __initconst.
>  * Use separate callback for the fixup quirk.
>
> v4:
>  * Use __screen_info_lfb_bits_per_pixel() instead of accessing lfb_depth directly.
>
> v5:
>  * s/lfb_width/bpp/.
>  * Grammar and typo tidy in the last patch.
>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: linux-efi@vger.kernel.org
>
> Tvrtko Ursulin (4):
>   efi: sysfb_efi: Replace open coded swap with the macro
>   efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
>   efi: sysfb_efi: Convert swap width and height quirk to a callback
>   efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck
>
>  drivers/firmware/efi/sysfb_efi.c | 73 ++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 8 deletions(-)
>

This looks fine to me now. Unless there are more comments, I intend to
get this queued up as soon as -rc1 comes around.

Thanks

