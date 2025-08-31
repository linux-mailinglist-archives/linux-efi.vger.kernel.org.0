Return-Path: <linux-efi+bounces-4657-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B859BB3D23A
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 12:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EBC7A9365
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD77155C82;
	Sun, 31 Aug 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kQAMXCC5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011B1BC58;
	Sun, 31 Aug 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637412; cv=none; b=EqYJzLlDUpipb0AcGiaDMWUrAu4xcuMz3gFXQs4hcfFHliTUlvTHQ8sIIeYl15UMmmTg8EscNpWjDxFYFyywukSNsFu8XdCK+1OzxlXmgRRWlzex11Kix+jrwwJi0S1JDhzUL+xDgr8iHvef0e+Y9oBJncOTTdFSLfyIzCM5SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637412; c=relaxed/simple;
	bh=0tnMQdnydsRh2e7UmCcIPnDhSpaZMeywFf0meF4Ub14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piuEOzEL15S8Y/niN06UwhzVFEuva66sfQnc4w09ivTyJtl2yu+m4jJFXqfvawSi6otc+PqMUTrlEYW1CjTmTJIzG5hA8CcWO6Ws0Oq6h2uiNvMjF+a6V9tKNAwbHvB0apx17DGM8K0eQaWJlUaZAjPnwJY60gqMVe7dylYYHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kQAMXCC5 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CBCD540E00DA;
	Sun, 31 Aug 2025 10:50:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VtnZj6S-w4W9; Sun, 31 Aug 2025 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756637402; bh=0QQ3TbSlRXbP0x7nwCFn1ZEAWBcDKBLpsPtGx1W0vLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQAMXCC5OzyqAOcheEExmQQLF1pH52QApdXtLLzj4OKJ6tBuRR+B9Oham7DjBLN5Z
	 T6wPR9J2OvK++dvKdSkKOdqwJ5OUBT8IEAm+acqVb1imYwJilAZ4HYxPcFfTiVVctB
	 4dijEOq1t8oszW4XwAwpOsquVsm/fOXYG+AytqjuzYckkID7/dGn3keR/DOCFTw2wZ
	 N4ym54Kx7F0fvyxi+klgY7le9EvV9bGalp9CVLoBKwIQyLcJtyrA5dsO+zDfM162CK
	 FIednVJ4nJlHgaj1YTohtNOOj1MdLGnH0tcRaQ4xgZPVUFmt1AGbr1/oTsTjeICTfq
	 /RpAvZmxDFAgACYXHvZSqmblG3HGLRoo0VP4TbxRgpQu27REcfi9ZHC2paLncvurv4
	 Oy/GX7EcMu2XSIAuZG+4HpJ+49LHZBbETphZ3WyuxIZlDoRhAtyU5Fi5c5+X7/wSPr
	 PTTUyROSsa65vEKiFNJ/qr4M980guXeRzIkp+OqonLt3auL/K8l9QAukVeAMJibAik
	 h13Jx4O9qbaUrvFZ4K3QUV91RshQvYb2K2gGv/ySov1mgTf5p0sv3GCvL0ivw2qceE
	 iUrQgkDV2pOzdt875U2kwoM+k0GqS/f2EIXD5ohtQkcXo8Yo5mfp89N13zOzttSTZS
	 mpKgXqXS3GxtaFTfVeD4O0Z4=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9686B40E0192;
	Sun, 31 Aug 2025 10:49:51 +0000 (UTC)
Date: Sun, 31 Aug 2025 12:49:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
Message-ID: <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828102202.1849035-29-ardb+git@google.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 12:22:08PM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup=
/sev-shared.c
> index 83c222a4f1fa..24cbeaf7ff4f 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -13,12 +13,9 @@
> =20
>  #ifndef __BOOT_COMPRESSED
>  #define error(v)			pr_err(v)
> -#define has_cpuflag(f)			boot_cpu_has(f)

In file included from arch/x86/boot/startup/sev-startup.c:106:
arch/x86/boot/startup/sev-shared.c: In function =E2=80=98pvalidate_4k_pag=
e=E2=80=99:
arch/x86/boot/startup/sev-shared.c:661:26: error: implicit declaration of=
 function =E2=80=98has_cpuflag=E2=80=99 [-Wimplicit-function-declaration]
  661 |         if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO=
))
      |                          ^~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:287: arch/x86/boot/startup/sev-start=
up.o] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/x86/boot/startup] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:2011: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

We probably will have to use the CPUID MSR protocol thing here or so...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

