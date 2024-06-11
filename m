Return-Path: <linux-efi+bounces-1197-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0D903CEE
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9503B286B75
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720EC24211;
	Tue, 11 Jun 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSgI+9t7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320217B420
	for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111872; cv=none; b=D9nHLpXphNO7DVUeDEz0UhDn3npzUQnC/k0182JO6A7/JYosSQ89LoXrqP9g4FTxnSbLMZ57d/jTux/53B8RgirRC8+NYpH+KrjAVaAcLt+1AaIsFHw5zJ650PUzBZ+XKnz/8sUVkX7BlRJqP2WTEgOZktdRxKA3ndp0XmMPvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111872; c=relaxed/simple;
	bh=MFDmvWsIzOeRGbFD0eytBhHdmLAAbCNtCLGpL93AJdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx9TkJmfdX3JZLiGrlp5PGmOX8Hqs+LJjqDJHTcs/FsifxllPm7AWLW93mrwPV11S6M1/QMtJz0OOSrbD6EuSUv9565ST+wht2EEl91w07p4MHfCFso8s3UD8sy6+hpceofA0Gkfpzb8qWua838vWV7bzKgKxiqXVDPB9qR4I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSgI+9t7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295e488248so6292929e87.2
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2024 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718111869; x=1718716669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFDmvWsIzOeRGbFD0eytBhHdmLAAbCNtCLGpL93AJdw=;
        b=NSgI+9t7WxVO65NX2gkRYbAKhI7O1HrvblooyFUZn5qNxtirg+ABfCvb17fwwFiFzB
         A55MkC3Lbb+kM0+ZfpiKzhtyZbnt5oRLOtyKG9NuIKE2GhhouL5JWwZDS0g1tx7W3ndg
         MCX0tUuISbBVyufR+AIO+2DfnQRYMIyRRxYT4C3TtQDNJ9eM2LlMEvGC76H4vbSGtzt0
         MoLACBkmz3Nc/tsxundiGz5nc5wIVvivYcBq/FgrMRgwE6AhkwbOpf43Pj7EYJfpIlmo
         dB9rBQUtACn6VIopLo4Wp8HZiLRFEFXIfeY9oq4gdLz9+sEuxcDGRLQArCGsP3P3SO9q
         smrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111869; x=1718716669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFDmvWsIzOeRGbFD0eytBhHdmLAAbCNtCLGpL93AJdw=;
        b=hmNwtE5aRUmEb8kkWg/GfU7vEsGN9iMhGHZshK92N5hfGD/fftMxud9/dDcwgijw67
         HfuEuszWnley4u8rxoyFixStbEavlERvY2peA+5hstBQodt7Gg6KHvWImrz4QVeqVsXP
         aMxnhjQI44haq/MyFVjjiOY+v3V1uispxPakyzw59XMAP1cYSUEYlxFiipYr16wmme0X
         7Mo5Fpz9GyQQcUQWa/X1J+4IVzgaUn/KKBtSm0TcKw+3oJDx3n+6IO60jc/bYJ7tweIB
         k62Fj3WY6F/ybThBJKXHuC/ra8vBSYDRzJbe0IxAiY0M5O3zuzu6MqPNpjYwLOkMA5qk
         d9MA==
X-Gm-Message-State: AOJu0YxKabI5SkAg3cuo2qIcR0wXV++TAtT1fZN6DD/D4kQnsPTvX7Bd
	qDYrLtBwOPvo8v84pxGU6jyHBbJhMK1pJcm61R9nkuHs+nBRcO3++xjJiw4T9kjtnSbHSTH4WYt
	Rb3ES8yh6F8FhzjAjWUlu5pqM4top7Q0//zefSg==
X-Google-Smtp-Source: AGHT+IGidS3jUKq4SAXgvG4b89Xam6soDKisP9vDD9ywQtjC/4Fmr4D4HAQj4mRYAlhJcHcbALDytdl/MuGhm1gzuM4=
X-Received: by 2002:ac2:4e0b:0:b0:52c:896c:c10f with SMTP id
 2adb3069b0e04-52c896cc334mr4080518e87.53.1718111868946; Tue, 11 Jun 2024
 06:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610122437.2358778-2-ardb+git@google.com>
In-Reply-To: <20240610122437.2358778-2-ardb+git@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Jun 2024 15:17:37 +0200
Message-ID: <CACRpkdbmQ6Foq_Rey5_etoNDoLmEh7v+q=sEzrcYt1tcrDaAoQ@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: Disable LPAE PAN when calling EFI runtime services
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux@armlinux.org.uk, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 2:24=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> EFI runtime services are remapped into the lower 1 GiB of virtual
> address space at boot, so they are guaranteed to be able to co-exist
> with the kernel virtual mappings without the need to allocate space for
> them in the kernel's vmalloc region, which is rather small.
>
> This means those mappings are covered by TTBR0 when LPAE PAN is enabled,
> and so 'user' access must be enabled while such calls are in progress.
>
> To avoid the need to refactor the code that is shared between ARM, arm64
> and other EFI architectures, fold this into efi_set_pgd(). Given that
> EFI runtime services are serialized and not pre-emptible, storing the
> flags into a global variable is reasonable here - efi_set_pgd() calls
> will always occur in pairs on a single CPU.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Makes sense to me! Thanks for looking into this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

