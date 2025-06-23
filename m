Return-Path: <linux-efi+bounces-3910-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C60AE407C
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 14:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F251A18844E9
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242E24678F;
	Mon, 23 Jun 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCy1Brtd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1342242927;
	Mon, 23 Jun 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682001; cv=none; b=ULE6hEkfcqppABm+4epE49gSmlyk24KB5dvF0SRZ+vGk5uwCZwAwS7u+2HgUOVlG2wHAjX+FVmGfzBmxnoUyN0F2BWMN1Aqoe13eWiS8EA0Dbbdg3S2yAovxX7Ggmv3a+HZYkxwBVKogjwXfuef6q++KPsoDoVmOHM+/h9C5h/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682001; c=relaxed/simple;
	bh=1DPd1rG0FiAZN/l3XVHAIpg9e7oYvTgCp4KsTGp3seY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnaYS+OKBGLvr1I69w8aSAJQpnre2OtzC1cjz/ywFJ//vCmcSZIIFgtFxWV4AWmY++aA/ki4bJIUfnw41XHdpFc0bC64ddryUgNEHzLjnDFj1TGJY/MnaxAZ6+D64JtQk+4KR7FUI9vpZgz5cj1PIy02SdgPHYeikgysyvbqJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCy1Brtd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b910593edso31649511fa.1;
        Mon, 23 Jun 2025 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750681998; x=1751286798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+IuXF9DlMlGH+Aiu+nfFVoQv16+hkfTLv/4sosn5sM=;
        b=gCy1BrtdANqufabnNcofKf7Upwc+MZwGaH4Gy6Ue/cuTcuPcFmbMfje75l3ceq6M3Q
         HQGj3pCLaUqcc//K6GA14Fc2XSBSqeUFCLNgaVMolA5Z7Ck7jZaBi1+W7VF/BrUSvLUQ
         hiSeyQ0ijoj2BiTTH6rq6iQx2gBO56ylVIo2OS6rtgUW9fRvZ7CJt61yPaz6rHuc5zAC
         uuDn+eXb3nwsZcUD2lkxoUjoUVnOiuVdRXYZeJPmgPxRzRU58lSnx4Vf7Rit3sEFI8v/
         GaXHKLnoSsEEY0iLcjWefTYSBFJpU2nLGXIc3ebs9Ll2j70k+cd2jradn4904K32m9SY
         Ffxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750681998; x=1751286798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+IuXF9DlMlGH+Aiu+nfFVoQv16+hkfTLv/4sosn5sM=;
        b=bYX+I4rGFrENb4ePWHVzJYGJcHB0jr/CeWsjjzb6wcKyol3WyS+wPzG/XAy/Uo0+aS
         5WDag9hYoFOGBvH6fMd1NjesG0LYP0Qgb08AwybTek0yGSDvNoTxOfFIgBnEC977e0hI
         IRXgusyLY3m/SzkfXlCf3ZjmT793THRyWHhrxvCi2uetV7Bz/46COJd4CKnVKOscbAic
         zHlVajjPfzkXjb7ed7hTyZtXL5mHaXRLsgZ4znptRJjFyv++Wx5yGUvx9YYUAkMDhncg
         bxTl+Ce0XrEijUpcYA2qkg5sMVAl1oHb2NO9Qq3GMXE69CiUXTP+rwITfJW+JLJIjh0i
         Y0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU25qC4dbmxDqrrT1qudGnI7KAPn/36Dnbkrq7YhACG5fs1z2dL16JePeJALb1OYXCyWyxqLYMMHK2Y7Myz@vger.kernel.org, AJvYcCUVnaylTXZnYNieayC0KQfyhoE0/1L4UwWLDtQ8FuXYKHFfhc19HgkquKDJqrFFlrbm5lMy96Kw7bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIV8vWgJiH3EL3UiqgfwChCjiw+LIu9Wv15h91XxOhNaV8BtvA
	KwIfL6UsKZXatyDfchEzs02T4v7KQnIxOjWd3OGq+6Lr8q52mDEwexeH/I0XU6Onlix8EybtGeT
	Y4h74LdNMqRSj41dna4uUiBo/N9k4d0l2
X-Gm-Gg: ASbGnctWZMVRY1s9xoPN4a0KWgUcri6YsDguW43JJzftrviXPJcYD7glFFjwm0WvfCB
	yqGdF9eaHhJjo3ErPb0ImQ6GdYyg572/Tfoi3gkNu6Ovw4F/g4IA8p1tf46clsoa22hixQt03BK
	KI4Wh43lqUfi/1UZiACoqngQZ+5MH2Atbbe3hS/6expkFkmkld/hnBpz/3xg==
X-Google-Smtp-Source: AGHT+IHbs/NqSnxFpIyynnriPXXe9sNxDaDSvw4MGJ1GuCNbeLiHRsPivmYWpuvMLVUKajdSiZkR1th4FuUfmOqTrZE=
X-Received: by 2002:a05:6512:b05:b0:553:3532:5b30 with SMTP id
 2adb3069b0e04-553e3be86ccmr3217582e87.27.1750681997445; Mon, 23 Jun 2025
 05:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623081458.1243-1-khaliidcaliy@gmail.com>
In-Reply-To: <20250623081458.1243-1-khaliidcaliy@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 23 Jun 2025 08:33:05 -0400
X-Gm-Features: AX0GCFuAWptiRw2maE0BWmiixwuVE1WmhRCAOu-kPZL92eirSB8J4cZ_QQmrR7U
Message-ID: <CAMzpN2jBOW3PVJQLvua=knQNu_1mZ6RZYi8JvNenFd5t30UC1Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] x86/boot: Supply boot_param in rdi instead of rsi
 from startup_64()
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, ubizjak@gmail.com, x86@kernel.org, hpa@zytor.com, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 4:16=E2=80=AFAM Khalid Ali <khaliidcaliy@gmail.com>=
 wrote:
>
> From: Khalid Ali <khaliidcaliy@gmail.com>
>
> The current kernel entry point takes one argument which is boot_param
> from RSI. The only argument entry point recieves is pointer to
> boot_param.
>
> In order to comply with the ABI calling convension the entry point must
> recieve the boot_param from RDI instead of RSI. There were no specific
> use case used for RDI, so the kernel can safely recieve argument from
> that register to better comply with ABI.
>
> This patch makes the kernel to recieve boot_param which is the only
> argument it recieves, from RDI instead of RSI. All changes needed for
> stability and clarity have being changed.
>
> Changelog:
>  * Kernel uncompressed entry point expects boot_param from RDI instead
>    of RSI.
>  * The decompressor has being adjusted to supply argument from RDI
>    instead RSI.
>  * libstub has being adjusted to supply argument from RDI instead of RSI.
>
> After throughly tested there were no regression and UDs has being
> observed. Looking forward for feedback.
>
>  arch/x86/boot/compressed/head_64.S      | 2 +-
>  arch/x86/kernel/head_64.S               | 4 ++--
>  drivers/firmware/efi/libstub/x86-stub.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

This was never intended to conform to the C ABI, why is it necessary
to change it?

Also, you cannot break this up into three patches.  Every patch must
be fully functional so that git bisect will work.


Brian Gerst

