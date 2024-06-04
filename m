Return-Path: <linux-efi+bounces-1151-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D308FBDBE
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974921C21F43
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C72142905;
	Tue,  4 Jun 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiljugNk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BF12D215
	for <linux-efi@vger.kernel.org>; Tue,  4 Jun 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535122; cv=none; b=kRocl8S2/dRZmPldoyfGiGxP77xcI4si5TIJ5ubYeZ9esiH7+GM9jW6JcCQqml1jy3q+QuNZqD5mxDlEjhjifzwxIwtJHKxFalq90swd5E2DThVIEd8X0/ebzAlh4asx78gcNIdSqaJPgaWAWF3PjlKpURL0gDvFOTE5DSRSTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535122; c=relaxed/simple;
	bh=hrxark6lWDsiQ3hJwv+VNerCBKdYNwdUcET58OPAHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjQgbrlldlzCbA+d315PPW6tDA08pbqhh9wruG6uNiG5PKFgXY+NRQ/GhJz+Np3rb9z9cLijrWmBuI/+RQEcfD60PwgQTl8DECxRmNWMbcNcmN4L9G7Qs29rQ4WzdQbjnU49Z6B/7aaPlA4jLi/EwVDmPh2NGUy1z11rB3NNbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IiljugNk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eab0bc74cdso32087781fa.3
        for <linux-efi@vger.kernel.org>; Tue, 04 Jun 2024 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717535119; x=1718139919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrxark6lWDsiQ3hJwv+VNerCBKdYNwdUcET58OPAHgM=;
        b=IiljugNkvXiA56X29j6CluWix8W6UUzXmQjNLPTg5MSXcBIAoLg+E4HsHeX+EfZKLg
         0PodFzLVDZWGbUvY5xsu9gp6ywvLrmcC5+ASXPKpHhCadLQcisA27u1Cl+3+nMPFW6xI
         WKcqbmugMaZKHk5+HQU1EZyprGDTPDtmoytHIGJmpMUaC+tluDOWIwDiXJmKXur4Y862
         1gMkn8ETKB7jwjOZcdk1heOAKa2Pk0UYj7iqciQnM6CgKD5dTqK5cokYz9Q6LVPSM/5b
         WHIttuiaZ+0tI2tW2mmPnUCM9EnWAa4hF4uvQKlr6XVmNuxCK4jzO5ibosey2AQZD7Jr
         gp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717535119; x=1718139919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrxark6lWDsiQ3hJwv+VNerCBKdYNwdUcET58OPAHgM=;
        b=IGuQMmw61BxYck3AjaS+qSqiQ58gh8jJYzxCAqSr/ImzYxYAW6XTYPMCeuHRgdLTzP
         JjRE4ocP13OiIWOIXY8v2RkJduEcEhx0+I3UWMycZC5o9BqxMXTpE9T6x9HTCfAoFU63
         0RpW93IC0gGnldkO8PpoFyLwv8STYLeS+lxGwcANGTuIfjq2dOuvRepGBkaA/HCN/50o
         xHOO8P/OCRWmpeZj/KLKeT1lc+y5liVn9U8MFwkhxZPflSuBWJejKxzfT5/DDOcLKmbE
         VhzDgge6P8dLpfoS2ssm4YsWW9+VDhji9ye4EgmD7fx6EJIqoSRoTmdIcuyCxc/Zpl7X
         92Rg==
X-Gm-Message-State: AOJu0YwQbUR9LmtYIm/MUEoMznaeF64ICxP5qCX50x8BRlW+/qyznXxD
	iFHXP2nemggATKOXtIT8FJb+sYJoX2NCnqJeLqdWy3QIfbuhjR25yh4sKu6/BH80yCPLmi6K5VI
	z5PPTmQM3v8USdhycbyBbJumB83H5IhBfgnhXlQ45Ak/V//qWfuL4Qg==
X-Google-Smtp-Source: AGHT+IHxE6lcj/CVGQPk0ZPn9Tk9oRFcDYfOzTaxUodeHIr4BV+VMcaNf66lRtn8i3AM+EQ6rvQS90REsiuFa26Pd3Q=
X-Received: by 2002:a05:6512:49c:b0:52b:3d6:67a1 with SMTP id
 2adb3069b0e04-52bab4fc718mr377666e87.43.1717535119220; Tue, 04 Jun 2024
 14:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604155625.2197275-2-ardb+git@google.com>
In-Reply-To: <20240604155625.2197275-2-ardb+git@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Jun 2024 23:05:08 +0200
Message-ID: <CACRpkdZ=-OMFD0d25m_YBjo+Wt-Ca7mjSNphgSA+2avxkcDYBA@mail.gmail.com>
Subject: Re: [PATCH] efi: Add missing __nocfi annotations to runtime wrappers
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 5:56=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com>=
 wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> The EFI runtime wrappers are a sandbox for calling into EFI runtime
> services, which are invoked using indirect calls. When running with kCFI
> enabled, the compiler will require the target of any indirect call to be
> type annotated.
>
> Given that the EFI runtime services prototypes and calling convention
> are governed by the EFI spec, not the Linux kernel, adding such type
> annotations for firmware routines is infeasible, and so the compiler
> must be informed that prototype validation should be omitted.
>
> Add the __nocfi annotation at the appropriate places in the EFI runtime
> wrapper code to achieve this.
>
> Note that this currently only affects 32-bit ARM, given that other
> architectures that support both kCFI and EFI use an asm wrapper to call
> EFI runtime services, and this hides the indirect call from the
> compiler.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for looking into this Ard!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Maybe tag on:
Fixes: 1a4fec49efe5 ("ARM: 9392/2: Support CLANG CFI")

So it goes into the v6.10-rc:s.

Yours,
Linus Walleij

