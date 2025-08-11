Return-Path: <linux-efi+bounces-4531-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C670B1FF61
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 08:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA2818947F1
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CEE2472B5;
	Mon, 11 Aug 2025 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rb568vA0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61D4414;
	Mon, 11 Aug 2025 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893855; cv=none; b=V8zCUz+rp8S8/SBtiDs8fSRaESMoPMa849AymIVVYAZOLN28OIpyQrIwXfeEN4Yq/DxIeR/8l3B4PaEw8UieO6jaktJWliRuU0RJFm0FLorhD2BKqx2ZUlF3W1e0swUe9+/DEKHPIAYSY1C2/GsMCmhaupL2Qe0Ljjn086HCdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893855; c=relaxed/simple;
	bh=FvH0qacdyBwnKpPXSyjzRbVQA9k8xfFUDAHDJF5JS4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2pwWHDx9lp8FWHlNPRnbAwxoEiuegpMybJ5nfKrd1mY7MmveSNHeHN7tm7Pp/VACPYm/ujcN2htE+yho2glnhzKPsydIEzl9vCU75ZYlqzb00GVHCuayD5fHReWpKDBnAzDpQ5BrEwK8s1uyUP89O05r5k5P6Vf0cawNfSVgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rb568vA0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 090BE40E01FD;
	Mon, 11 Aug 2025 06:30:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C8Eb5m8F1-tY; Mon, 11 Aug 2025 06:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754893845; bh=kc55h+avHH/3omfVpRIdLMfsqJ2PwrVn16E0dPvENJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb568vA0MLib9ScMpGDReEyH5/3laR4SdcaWTVKIHqXD5IHDVAQiV/3JjtSG6wNfd
	 HhhmnvCZCgRrCyyuUwzgs59nrX/nZVe/3zrIIArOBI4ZF1Cp7LjF/OXzNwrt2/URaj
	 QcTpaJMDGpYlrWWzc0pTevdEUFZpeEutJS9JJZ2Qk+yLTT8IfE8XvLfJcFizcjv6gE
	 vh9WM4Qctmck1bRNnkFAZ/x+gwjl41d7z0ROo68mjM5dQkjipiOFnYatjZC67vn2+Q
	 8RArQC552XauWzv+fPwkTuVpqkkJJLGn0w+bMxYOm2NxpRn5z6fqT3bgCEnvosUkOU
	 KQ8MgLi7S1l4Y04ZC8783YhHnXbZ41/WLvczohibuTxJHRTsTn7p+6RI4H0Xd1cjX1
	 w2J7dT9dz8GCwxdxz04d5Huuo5IxVyedi2FzLQjjxNRx7Th/dqRrir+HD5nWuBIKJB
	 GpOV/Qe6XsFnOR7unWnw5PE7wtpgNl4QbxzfRA8TtdfggSiFaAqLB+FdUFmro93QM6
	 Q/c6IdGQVKfxZFJY4pX0K1D6tLeoE4NXnXLb2zirGWDqrnZ0dOzMn46oZhh91UE+gv
	 B8iqeptTJUbPuUb8kCwCFzwPwD9Xgaf0Jmi8UOlzpSg/kxowxrjxFnaJmqzwGIoT++
	 Mr4IrRig/sH+CABuGGsfpL+s=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2821C40E023B;
	Mon, 11 Aug 2025 06:30:34 +0000 (UTC)
Date: Mon, 11 Aug 2025 08:30:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v6 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
Message-ID: <20250811063026.GMaJmOAoo-PhdXcLZX@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-34-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722072708.2079165-34-ardb+git@google.com>

On Tue, Jul 22, 2025 at 09:27:19AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> snp_vmpl will be assigned a non-zero value when executing at a VMPL
> other than 0, and this is inferred from a call to RMPADJUST, which only
> works when running at VMPL0.
> 
> This means that testing snp_vmpl is sufficient, and there is no need to
> perform the same check again.

Remind me again pls: the startup code is going to be executed unconditionally,
even by the decompressor, right?

Because if it is an alternative path, we can't do the below.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

