Return-Path: <linux-efi+bounces-1336-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285F91D7BF
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47AA1C2274E
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 05:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229943687;
	Mon,  1 Jul 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAWyzDg8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601842056;
	Mon,  1 Jul 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813377; cv=none; b=pVja2hweg1gxPW2SB3WnyI4ltP2g49ZbXfEZriXEnpQUrrE6/PA0WYLnhHfJE5I52QfyZ/YtNH8oBMkolrTI7RauPRB6WONt3MKpxorHI/7Y11sjCX6NPSzxZBXo9SvUkHvV/uzM2EmUynkPNK7TWAf607RXbFRlvzf6YZL1Zh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813377; c=relaxed/simple;
	bh=n23wtrwm8NZfNsYbcGValEvYtuaepP9EGBapwyStQYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEOJ000CIH6fi2Ynf7vQnhW/oY8HARaK7iHSBGQi58X/3w9QC1/cklTGBlTYe9rN8cJr+TpaxJ9zIf9aA8O0eIj0FrpEjH9Bw+pbaLQ0ZfiA5dAlUIvP0IDJgOeYSR0NMG57N4jhT9PuOIDBNX147QVF4D7MZoOX9Dsz05lzd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAWyzDg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB209C32781;
	Mon,  1 Jul 2024 05:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719813376;
	bh=n23wtrwm8NZfNsYbcGValEvYtuaepP9EGBapwyStQYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LAWyzDg8GmO7hC28BK1mVNApnN6LZwlijF0K6vST6rq2Z0VJCtX/RMIC5gHXgX7Vo
	 Vs0Ly83jzR2U2OUZKajdgFTVkM8rRCF5CTyFNPQURP8jPYBVPzjm3nW0CawrkZpqQB
	 v3OJ19Ndwtw/2r2VLriFRmVVMVFZnU/jcXPjfSf/rvWj3ilKu/4U9/e0GQCKvw8pma
	 WFKFqqvHTD3yIhqf0HnjZuiNgUwElAbl1P4RlHC5q+Pfr+FqzzJjZuvAyPtRBtyz0c
	 2+I+O8gZzyk2bpK6allu9hlaAVHRjCNqI6YHYNIcFJdsjeOaAO3HdxvhGywk16zdwg
	 A/Z/j9pNvrjKg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so30047381fa.3;
        Sun, 30 Jun 2024 22:56:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3fX9sN08RecWz+paOC8qzNFKpLZsxC4aEqka0KxSlyeKU/SdaZOmzaK73g4FYmr/CBwsN7jhAAOe5NZnODkiUg8fZYBb1n1KQLkGe7aTGFQm6vpGxkolfj8v1li9WtzIpp9oP0LJc
X-Gm-Message-State: AOJu0Yyi32yVBT4uqDwlGPh0kfcG2AQmDlKG0VZWfn+c50JB9YQhSg9z
	KdhSlbKaDqLm3yJIW1XdzZ1yOqX16ImfHavy3HFpjmxbFHvt3NriNBcM1wXHAan1tcoc4xAeBlS
	tF3g2fqHhgMBOOdfzAUDr5rud1JQ=
X-Google-Smtp-Source: AGHT+IH94jxkz8Pj/w6GgPayrHNJslk0NFwY62b4m10q/j1suEH0tE9VkHNy1f+wefisdCrPSdxQTY32nK/+Ui9IDMc=
X-Received: by 2002:a2e:b52f:0:b0:2ec:5a85:66ec with SMTP id
 38308e7fff4ca-2ee5e6f53e0mr27361211fa.48.1719813375199; Sun, 30 Jun 2024
 22:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de> <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
In-Reply-To: <ZoJDuunseVIDua-m@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Jul 2024 07:56:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
Message-ID: <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 07:50, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Jul 01, 2024 at 07:38:38AM +0200, Ard Biesheuvel wrote:
> > Any thoughts on whether this should depend on CONFIG_APPLE_GMUX or not?
>
> I tend towards *not* making it depend on CONFIG_APPLE_GMUX:
>
> * The gpu-switch utility Orlando linked to doesn't use the apple-gmux
>   driver.  (It changes EFI variables that influence to which GPU the
>   EFI driver will switch on next reboot.)
>
> * apple_set_os() has side effects beyond exposing the iGPU (such as
>   switching the keyboard+trackpad access method to SPI instead of USB).
>   If there are issues, they will be harder to debug if their occurrence
>   depends on a Kconfig option.

Understood. I agree that having fewer possible combinations is
strongly preferred.

However, this change affects all Intel Macs. Is the latter side effect
likely to cause any regressions on Intel Mac users that don't have two
GPUs to begin with?

