Return-Path: <linux-efi+bounces-5271-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA361C2261C
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 22:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4171A27427
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805EF33555E;
	Thu, 30 Oct 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh4CdJL9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AF32C939
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858804; cv=none; b=DGOVoLp31anXEQorGyOCSqJT7Yh52an/qexkQezE8V/QQJL4m1W5PVay/Jq0nFuYsQAll4WOoBpZ0dcevHexBb2ng5RmQudJziUNYAm0zejyuxUz4c7qvKrNZmTi1wyvqVlPZsvROq5tSRUjHB3h1cOVVd/LHqYk6B5tdMT1tnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858804; c=relaxed/simple;
	bh=Ds10LqyCnxdrh0ZjTOtUC48GJJV0wJwcpwKLPS3durE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrDbl+CA+MP8mmuQKjRL8bvIsWvzauyd2LNt7X8fa/I/yI0qxPbUMPSH7ExGVqLgI5CMk1IGT5Gw4UpoOGRQhy861HNxSAPSTxPL+clFP/kofaSsI0r+v9s0PDKccHN5zQbaXutlMBLxZ+S7Wa7+AYEl5Isg1iIbHdrb4EmXTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh4CdJL9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475d9de970eso10739105e9.1
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761858801; x=1762463601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTFjyfM924ecEs5Bh5eIoT2AnXmgRLbADTYF0WurRYE=;
        b=Zh4CdJL9Ye4tgOk2PdxNL4xixD0FkiLDlyZWIud5Hia8Zs2K6t2cuCJrS6pPLz1NPt
         6i2LYEcnuOFXWX7xG2PgAhB9WUCChNRAK0Pq44uF+wXfWyFj2DLG6m+SWwOllx1pXDeZ
         hb61cTMaqZffAFwcQjZPG4GEhC/NAx+yyKDlgmvCZndxsJ41LsBp+JPuHO6/6S0G8GUR
         d0FPpP2CKwk7L8m9kEoq9n+oF6IIlcisCYDMbPaCxzehDfjmm9ijl7kOgVUekYjpZUTd
         JZiVs6mwnGbr7MOQru1cX5FpfOIHNxo0FQjh9HOma1Oomvc8kSs7qR6/zSZpxtRxpwEM
         FopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858801; x=1762463601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTFjyfM924ecEs5Bh5eIoT2AnXmgRLbADTYF0WurRYE=;
        b=qURWtFCyMTgaDHSs9XnjZc7YHL97RTGEyXqknxzXgFKI7xoRjQQm7uGejCjuXhX1/k
         vDG4mah3hOEsFM6PYATBfQDUj5BU+jWR85OgwDe8Z9E04dO8mOK/dx3i6jjFQaSleobJ
         uPHfSw9SZfEvj0Jk9gR00jUXozFvhZQQ5ZE4jDz9DPm8HGvWQc04vXiqu04LWSKLitaQ
         WHE3aatxNPCdVfNr2c98KiV/QR8blli85z3ZNWUiDxzjUF3kB0p+x+9bDm9RvaED2h4z
         bVjW0LK4yHm1bUgfo6cD/eIp7tLYjGkT/ZOLk4N7eI1P8YZi/Ln+IzUVP+nIVxdkwwh5
         9shg==
X-Forwarded-Encrypted: i=1; AJvYcCWq+ILEMvr7rRz3WXQDluFTGrklLiWjkKB00lqlKgS8/DmRPKj91Y6Z67MrA8elR7I0q5zrjsa7kF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWArV5cC3H4wGPsznSKFVgwyEXgoXjIMiDrTHMxpw952h33Mqx
	YYRd8l71syelwCE76Rzp8DKjDyUxU0fZo+qczrBWpBVgNnAQDzdCaeS8
X-Gm-Gg: ASbGnct/mJSmXaMAbaPShqU72bjy6+P+3IJEM7pl52UFl+skd2v49WQxJ6HFZrMU1uM
	ZftnBkUPLT/w+BvSy592csbUpjMtpTDyeI2nt1U0pjXyneZhDgbQ1gwlQcvM/w1+SM/TbgTdD1x
	2n9SfRR3r0LEBittKnisNam+DlTYgNdTSujpX0bVf/GLeG/AotNGI5f6u/sQk4Y55l26Jyf/w+L
	0PacC30wBB7F7wTSX80Q9dYtoDnuUyM1PpTBZYFHL44dl0OtKzbWLvPs32YmT8w5/g2jbCZl4LM
	HX/MfnT1hYmwdSMXgFmbCAVfOJsOkpn1HUgxHbvdnGSUy5aYWJg2+sb6wh9TwkoJimuwgXmZSyQ
	E7zwp4VqWXchpu44Nt1YY8psAaoR9gSgiRiILlZAYTgfUKO95czDdeZbmJc0CsPsQajxmJ6vpP2
	GjKmo2qx+HQHDQt/+A/wDT3L/OKaYpIDunnPA8e2MseHpkB7TOSJYJn/R03NLxXp4=
X-Google-Smtp-Source: AGHT+IGHccmEm3OTVvfv1cl8GaVw3qg7Fan/QOWhxWwvh6yuV+lD+Cr5FA7Q1nAV3Zqiw6cVkBYCFw==
X-Received: by 2002:a05:600c:630e:b0:471:11a3:a6a9 with SMTP id 5b1f17b1804b1-477308acfe4mr10073295e9.37.1761858800991;
        Thu, 30 Oct 2025 14:13:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5773sm36299466f8f.27.2025.10.30.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:13:20 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:13:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "the arch/x86 maintainers" <x86@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet
 <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill
 A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick P
 Edgecombe <rick.p.edgecombe@intel.com>, "Vegard Nossum"
 <vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
Message-ID: <20251030211318.74d90c3f@pumpkin>
In-Reply-To: <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
	<20251029210310.1155449-10-sohil.mehta@intel.com>
	<789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
	<13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
	<d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 09:44:02 -0700
Sohil Mehta <sohil.mehta@intel.com> wrote:

> On 10/30/2025 8:45 AM, Andy Lutomirski wrote:
> > On Thu, Oct 30, 2025, at 1:40 AM, H. Peter Anvin wrote: =20
> >> Legacy vsyscalls have been obsolete for how long now? =20
> >=20
> > A looooong time.
> >=20
> > I would suggest defaulting LASS to on and *maybe* decoding just enough =
to log, once per boot, that a legacy vsyscall may have been attempted. It=
=E2=80=99s too bad that #GP doesn=E2=80=99t report the faulting address.
> >  =20
>=20
> Unfortunately, CONFIG_X86_VSYSCALL_EMULATION defaults to y. Also, the
> default Vsyscall mode is XONLY. So even if vsyscalls are deprecated,
> there is a non-zero possibility someone would complain about it.

Presumably a command line parameter could be used to disable LASS
in order to enable vsyscall emulation?

That might let LASS be enabled by default.

	David

