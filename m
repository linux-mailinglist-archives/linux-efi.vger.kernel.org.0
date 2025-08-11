Return-Path: <linux-efi+bounces-4536-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F986B20BAE
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613283B2355
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9119202969;
	Mon, 11 Aug 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PiK+5nvm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D093202C3E;
	Mon, 11 Aug 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921887; cv=none; b=AedQszheuH6njLzirKRsLqklYFopnmQny8zou+M4WEOXJeMITxW5hZJhkgOMfnYwBRg80s9s0WvMFQdqvPrHJATBnxV2zek/T0u5bZ7ZA2jO8IPqAdoMsbysQVQJK0WuYd4iI9Ig5HwZqxoSR/bkj1dXclbI/wbAKz2MLlkXuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921887; c=relaxed/simple;
	bh=FxIeR+XRO+LteQtbn4Y3Z8oxhVBMnjv6foxqAQrwRI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayzhpFjTlexK4ogmW8wpcBqDcHHP473oqs2aENSNjqTwQ4V7NggQdMivaA8gcGHieDQmvXTIy/x1utPjLq7lbQUx0yNoykV3Z7FEDWxZ8rKHMCS2H5B6glF4pzSQEP/rJuNFvQdIv8AGDz3fdfZX4IYeobqK8wPgs/SzxpTU718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PiK+5nvm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4AA1D40E01FD;
	Mon, 11 Aug 2025 14:18:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lacXSiAVNQhH; Mon, 11 Aug 2025 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754921877; bh=qEuNmBwP/sHgYnIfLRgH3+RiF/31tgRFq4tjlmnbQ7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiK+5nvm7fPXFSGgXGg1YZ5Mdi/swYYeSb/HsRzYqE+3ATfme78wESSO5MN0f8KLI
	 an9dC2s2es3RocXq2me5yVxW+Lxr5pLFQS99+WkdeZnB92dNU9yAWXwM2/iICN1pnj
	 J4k6CthtwUWLSHPcBrcEqK5tvgqkSPG2KeakwCDEXdzKaS+P1JecGwvm/05SHlBTEd
	 Z+Y8URn+IRI3Zez9LvTDVpn1CmLGsvuXvjupYRC965MyXHZDjtLT2hTDqNcEOlNK8J
	 gGJMoq4FQe5Qf1gno3nqeQJ7ir4B2/LZBZFQ61pawSUPTiY/A1dqTolsaXjIAKAgQi
	 hwvEic8QGX9NSuISaf5SM685gjGFaVR2kkGpXFfVUT9HJRh97f0ajxjxf3sxitY2m9
	 384aI3BBTJUODSTWagv6L906RSaCAitKpzLa2Y6+KaLweZC555TcAQtkSUwt5vQsO/
	 HCPNn4DXFlR6/5vT2e6QDCVourl7LtkbXgxg1ZvSLFFJ87V+rNliWr4CzZP/y0sBbw
	 9pmx+uLnn067175W+pk0s3fJ00LxBoH6fVu4aeq2y1WTZIZS3IMwP/blwaIJ+9g5fE
	 5TncsG9BwVSIwq+3fxi7Z10FsqpxEmzWLPeciLn16fn1mYQ4xgTlEUbOSkD9YsfhrP
	 IDXr4s5JQ8hn7Z0kiuZEYSOI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4758340E0265;
	Mon, 11 Aug 2025 14:17:46 +0000 (UTC)
Date: Mon, 11 Aug 2025 16:17:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v6 00/22] x86: strict separation of startup code
Message-ID: <20250811141740.GPaJn7hKNmLGV24WTZ@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>

On Tue, Jul 22, 2025 at 09:27:09AM +0200, Ard Biesheuvel wrote:
> Changes since v5:
> - Some cosmetic touchups to patch #1
> - Fix error spotted by Tom in patch #2
> - Rejig objtool 'noabs' feature using an arch hook to check for
>   relocations that should be considered absolute, which includes all of
>   R_X86_64_32, R_X86_64_32S and R_X86_64_64 on x86_64

Ok, seems to work here.

You could send a final version with the minor issues addressed so that I can
queue it and test it more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

