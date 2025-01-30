Return-Path: <linux-efi+bounces-2732-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009AA231AD
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2025 17:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D2F162F4C
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2025 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D41E7C23;
	Thu, 30 Jan 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBOquXda"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D525139B;
	Thu, 30 Jan 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254017; cv=none; b=PWJsPuKY4FFcf0acX75BqOzjWb9Ixl2oepxEh+LbKNQ3RPmmtk+dVj31TidhBMZqZDo/oNINduk3Ywhfbww+ZxKs5kbg4rVXC0VQBFG6eiyj6S43gILmemPuwY6a57xc4oqkVTKA7zBTWQxpuSvsZ/oMVuH4IXka0hQwNhp/5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254017; c=relaxed/simple;
	bh=FYEXyEAib+ybKB4YBQDIvAkC2oKSQt7aP7l4qin8tv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTYd+EUEslsQUdL2cMfDFUUSbanLtKSJ5wfXf1Jp1ZEsKZIrHskykJc/4Fzp13tcPghNWrOw/olNa1jcpj3IBPmkTPQC1quIMqrV1nQ3dUrDT7sUZxE6+k/LfJlV0dA0KkzoaUPUb6okzB0X11QbqS6FU/vSHCw1IJRFCW0PinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBOquXda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB15C4AF09;
	Thu, 30 Jan 2025 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738254016;
	bh=FYEXyEAib+ybKB4YBQDIvAkC2oKSQt7aP7l4qin8tv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mBOquXdacEo5mkOV5G8iKJ1cuHEC7axtYUMoGv9elW7G/5XcFFAxJeajyBiY7fJGr
	 Dhj8QudOUZwSadqthnR8h9o+w71mCF2KWABUY5JrSokf8HkqDf8nl8XwMyO2DNqhHg
	 lRQg4HIKFX7GyMGPx22mxxVz7QKlGrFT+YkvjZOcBrOlWXPCF2hp2gJAG91mzo2ujV
	 yYZi5jvqSUpofuQDSReQCpKbQsmTI1Ovlt95gUgXXkGY6PvjHEnb81KD6hXnFD+C6o
	 7ADB0I9dzvNHpTsAiN7JNuXDKyhM+Vo2CyyslMGG2uwTAiRW3PZXgv2ybAa2itx9BM
	 ytXxuiGIr8fRA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543d8badc30so1105250e87.0;
        Thu, 30 Jan 2025 08:20:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtPrTENVnNL+bSPXhWi9iQ/GfvPKwtuR+0viRQ1NAvLEyqRf/14k0652KkCSMgzhG71xzwg/r00FZZIhle@vger.kernel.org, AJvYcCWS6saNH6odKgj6oZltg2bRFOcIp3W8mng4bTC0F1/IpBk2Brn6NG/d1nynz69ORQn8YnoYR+lwx3A=@vger.kernel.org, AJvYcCXdy+K1EiLnBvgqdPL3Iak3uy1exPfjtSldPHkQGXNynUS/wpY4BBoueZhRc/lgVabxjJlcaN3x@vger.kernel.org
X-Gm-Message-State: AOJu0YypzTBe9riWBCPDPKNPGyZfJHsgVNJs6c0pjH/Y6EXxYGGO2DG8
	joQN327dxuZSGga62UpZ4IWI1snvCotOgDsYBy8CjeWYTeILcerQ2pdaFzOx1SxdnyQ4YfpCWRM
	HUM8FH6M01WglHemiJes+1s7QFD8=
X-Google-Smtp-Source: AGHT+IE1C8s1VteGDGRQ35A6NwlNvkftxbcxG3ORQcL/+819zw8iJPqJkpUleI0FcgMO+muHiYGV2FURQ1bQvolF4AE=
X-Received: by 2002:a05:6512:3a8e:b0:542:213f:78fd with SMTP id
 2adb3069b0e04-543e4c373e2mr2566854e87.40.1738254014946; Thu, 30 Jan 2025
 08:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
 <202501300804.20D8CC2@keescook>
In-Reply-To: <202501300804.20D8CC2@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Jan 2025 17:20:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH0T5XJGMyC72DQjp0zjTAC5JbtDjY=rDGPeMs6cVDXug@mail.gmail.com>
X-Gm-Features: AWEUYZnwsfsYJJdne2_iTicN1qLSgaMkQiOjaWjhQMNVqVd5tyGM7exSGwdd-h8
Message-ID: <CAMj1kXH0T5XJGMyC72DQjp0zjTAC5JbtDjY=rDGPeMs6cVDXug@mail.gmail.com>
Subject: Re: [PATCH 0/2] A couple of build fixes for x86 when using GCC 15
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Sam James <sam@gentoo.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, Jakub Jelinek <jakub@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 17:07, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jan 21, 2025 at 06:11:32PM -0700, Nathan Chancellor wrote:
> > GCC 15 changed the default C standard version from gnu17 to gnu23, which
> > reveals a few places in the kernel where a C standard version was not
> > set, resulting in build failures because bool, true, and false are
> > reserved keywords in C23 [1][2]. Update these places to use the same C
> > standard version as the rest of the kernel, gnu11.
>
> Hello x86 maintainers!
>
> I think this would be valuable to get into -rc1 since we're getting very
> close to a GCC 15 release. Can someone get this into -tip urgent,
> please? If everyone is busy I can take it via the hardening tree, as we
> appear to be the ones tripping over it the most currently. :)
>

+1

Note that I already took the EFI one.

