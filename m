Return-Path: <linux-efi+bounces-4534-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC41B20521
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1634E2EC2
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383EA21D5AF;
	Mon, 11 Aug 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eNEBIfAa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE71DF982;
	Mon, 11 Aug 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907622; cv=none; b=A1rbZg9VIf6bKo0JfN/LHjnDhAQ605pFDKMu4WrghIRbw5FECdS2VRjVY8aL129ZwckPtFApxzPv668MW/Z/7QEGpHJrlSZ24W1A1Nn7fhBoTj8vJwAEcEosFKDWbCQUic5hwkc/WvjhuEoHIsO1dahnXwyKSSYO981b6v4S5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907622; c=relaxed/simple;
	bh=rGfHVF0qCtGUZ9N72iqTD5w7HVHytP5/3tPYzQMtPkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFg7shazdCVMMt3sr7DuUHVBZpTWRHwWebD6X6JYTGT5VgB8calGYPOjQwg9EbA+weN4/GZvNr0ReWd+u1Afs5Qgq/mEZy3tr20WiClcH73Sr0AnW/gL6YjoY2vRG0qFwppOPBY2bNBrd1jbjEeJx1zGTJYXblw4p8WfyN0zmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eNEBIfAa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4991A40E023D;
	Mon, 11 Aug 2025 10:20:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KSW4jXq4gEYY; Mon, 11 Aug 2025 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754907612; bh=GcJUIrAdErTxmKVEiP9qWgdBljgYH1PC8ql9PSEuReM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNEBIfAaKIlAiqZ7j/hcRYBQx5uIdnO4p47djMAe/fwmKZ4oUye7Icwuc1p9+n3wc
	 wPjAytEjYZ4fvKrAAgDGzaOBTrRcbrvSjBa6nUrpA9eM9rWl2ApLXlLS3uop86SV6N
	 aucdhtAk70NpbYyAhhY4r9fKLaFpi8wvgAM6S+TOHmIggYfVtlGDKhDh4HW3cgz7nq
	 Kh3NRuGQWTKEm7a0uH33XUld/sV/4yS/T22kzqnRIukd8jgdkdkOPY8aGE3Srv2CS4
	 t+HSI7v1YEd5CFKb3zrd+IGviNXrhQn/y4Dc3UaAhJZu6boJFefRTDkhD6AXyxe0FA
	 Ep6iKWuX6Njx1XMWussKpyTn0CQHds14MWNsSUWlXcy9ZXQJU9BSFtsYoMU/9p13DP
	 WL0dp5SmRM27b2HoKhC/oZoessXo2WVdRh+UJIvVnmq5b85dFhthrMYK+oaXvaxAse
	 onpdndKU5fvthJ5jDSLi/8LADp9xrHMS2O4DPLBefAs2xHYp21UuP3kwf6b+jDShQe
	 zXKzRxlQ9OhVNz6KOZtBnV3vexyV3UUakr1eXvjO+Eruwcf/eVJ50RPY6637PmHei0
	 SZKfDG9580WaGruYMtc7YIqlmPanEPqEn3PyLsjjY6Xf+TDeOtoygDH42Xl9yoSJ/u
	 3BiJTIv1O/NZZsEwNNaHFdZI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A346740E023B;
	Mon, 11 Aug 2025 10:20:01 +0000 (UTC)
Date: Mon, 11 Aug 2025 12:19:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v6 19/22] x86/boot: Create a confined code area for
 startup code
Message-ID: <20250811101955.GOaJnDy0-uy0quuouD@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-43-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722072708.2079165-43-ardb+git@google.com>

On Tue, Jul 22, 2025 at 09:27:28AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> In order to be able to have tight control over which code may execute
> from the early 1:1 mapping of memory, but still link vmlinux as a single
> executable, prefix all symbol references in startup code with __pi_, and
> invoke it from outside using the __pi_ prefix.
> 
> Use objtool to check that no absolute symbol references are present in
> the startup code, as these cannot be used from code running from the 1:1
> mapping.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/startup/Makefile     | 14 ++++++++++++++
>  arch/x86/boot/startup/sev-shared.c |  4 +---
>  arch/x86/boot/startup/sme.c        |  1 -
>  arch/x86/coco/sev/core.c           |  2 +-
>  arch/x86/include/asm/setup.h       |  1 +
>  arch/x86/include/asm/sev.h         |  1 +
>  arch/x86/kernel/head64.c           |  2 +-
>  arch/x86/kernel/head_64.S          |  8 ++++----
>  arch/x86/mm/mem_encrypt_boot.S     |  6 +++---
>  tools/objtool/check.c              |  3 ++-
>  10 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
> index 32737f4ab5a8..e8fdf020b422 100644
> --- a/arch/x86/boot/startup/Makefile
> +++ b/arch/x86/boot/startup/Makefile
> @@ -4,6 +4,7 @@ KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
>  KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
>  			   -Os -DDISABLE_BRANCH_PROFILING \
>  			   $(DISABLE_STACKLEAK_PLUGIN) \
> +			   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
>  			   -fno-stack-protector -D__NO_FORTIFY \
>  			   -fno-jump-tables \
>  			   -include $(srctree)/include/linux/hidden.h

Commit message should say something about that hunk I guess. It looks like it
disables the instrumentation that this plugin adds but I dunno.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

