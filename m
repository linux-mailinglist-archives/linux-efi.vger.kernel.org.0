Return-Path: <linux-efi+bounces-4648-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7EB3A2A1
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B98D1C85559
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043C3148C0;
	Thu, 28 Aug 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HkXVYR0z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794063128B7;
	Thu, 28 Aug 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392466; cv=none; b=LoAeKGORHBrkfgC8c0+F5Qx0T7dwUdlzNcFtZL85+0P/iQCUxqYipYhgd2+a2IzRGb7lwNfKyB+rDeRm8Er96XHysQw9hLL2MNfGczfLKqPgeQdMd4Cz3aamHjeDpGvjer+ahwd4+vOHyL/1KXuA1QmLohiWv43ZG0BGddWZlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392466; c=relaxed/simple;
	bh=QWQB3X5FgY4ZUcKK9dSF6mpdtD2yoqc0/ezvi5nzEVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea9uJ8sIdAyfXp8OhcGfa3hZ65oFPUDGX+RMStGzabMOg1gaiKCau+Ow5LpcdFSt9M570DSLn5bZuXcQUJXCZSyP+xPKcYtk2o15M3p5fYwIu2C69ErtF5I8oL8m/8sb2PKf1Tj10jx3pYZcz3sRXGmv8x7XDactQE/8iOHcR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HkXVYR0z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E8E6440E0176;
	Thu, 28 Aug 2025 14:47:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HCMRkn6-c9y2; Thu, 28 Aug 2025 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756392449; bh=rs51TJPcgG9tAhbdjBByvGrbkNG9di6SwXxZQ2cXCvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkXVYR0zQQKDZqqyRDz0SePnj6pAbN6puUfsKHYiYYSdMlZ3NsM7LWQvZZeNVj8lK
	 VSCMUHi7n7qWShNLcoXYaijdlfyVt3ptdB1EDKX2FqqsSQ+uesBlvoJKhXIYIU1Ode
	 0oid/MFIkjFwLMAtmtT6nicLQmyJiLJ4g33ziHprpw4cWxoXZ35vccttZ7kAHZIXqu
	 vqDVww5NCnUh+yhm2N205rUp7qQf3zqof2kIiBgeYCQNG7lLH7ocZNqnxcTvL3Vyc+
	 ttREoHu5sUm/Ji4el7B0D2wKr3aKplPEPEC95zTA5xESAQtGYV+beTnXHMJr/+s8mp
	 DNcjji4xOfXcEW8CYZHVNLyVCS5fTg25rDPxJ79TaBx9xesfH0KYX8yFEb7NrZhUGA
	 ZiFwgX91+U0mHizxNVtWvxxyd7k7hAg75UQUQvq5LSRFIBMb2fv49sbVjfE6qv0cut
	 yYWkNXgQJRBoEEoNlVf4aykhSjykU2nImVULqaq8IaJVVQLB91dSCx/SqRV+daBPuL
	 klyPNA8OmWy8jxHGDPCzKVGzIJg2O0xRfiGqw9iXisyLGC5MTN4gomlj7k8Duzn9Vu
	 MeRVT7ZxzH+MUnX0mD44l0ciYSx66ab0Ib8e7YlN/SYdNwdmYh+3fxA7FLlz4Kp5W3
	 O6zbVlrHgzr72WbDE1QHHdH0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DA2140E00DD;
	Thu, 28 Aug 2025 14:47:18 +0000 (UTC)
Date: Thu, 28 Aug 2025 16:47:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v6 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
Message-ID: <20250828144712.GIaLBr8O9BTcj6sH-g@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-34-ardb+git@google.com>
 <20250811063026.GMaJmOAoo-PhdXcLZX@fat_crate.local>
 <CAMj1kXHr1tcV5SpkhENANUs1Y_nvC4Wh_7Q=UN+2RPVHFC4O_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHr1tcV5SpkhENANUs1Y_nvC4Wh_7Q=UN+2RPVHFC4O_Q@mail.gmail.com>

On Thu, Aug 28, 2025 at 09:36:15AM +0200, Ard Biesheuvel wrote:
> The decompressor is completely independent when it comes to
> initializing the SEV-SNP context, and the core kernel will redo
> everything from scratch.

Looking at the code, snp_vmpl gets set by svsm_setup_ca() which both the
decompressor and the startup code call. So I think this answers my question.

The core kernel won't rediscover the VMPL of the guest - sev-shared.c which
contains svsm_setup_ca() is only inserted here:

arch/x86/boot/compressed/sev.c:43:#include "../../boot/startup/sev-shared.c"
arch/x86/boot/startup/sev-startup.c:45:#include "sev-shared.c"

> This double initialization is no longer needed when booting via EFI,
> and so once these changes are in, I will go back and resubmit some of
> my previous work that removes the call to sev_enable() from the EFI
> stub entirely.

You'd need to keep the svsm_setup()->svsm_setup_ca() code path in
sev-startup.c so that the VMPL gets discovered properly.

> Non-EFI boot via the legacy decompressor (which includes kexec boot, which
> makes it relevant for SEV-SNP guests) will retain this redundant boot flow,
> unless we find a way to mandate a complete 1:1 mapping from the boot chain
> (which EFI already guarantees).

That's fine. I'd prefer if we slowly decommission the decompressor instead
once all machines start booting using EFI. We'll see how that ends up working
out in practice tho.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

