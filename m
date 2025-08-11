Return-Path: <linux-efi+bounces-4537-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8072B21386
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 19:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ABB1A20E98
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190C12D47F9;
	Mon, 11 Aug 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dzGv4nZJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C829BDB8;
	Mon, 11 Aug 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934070; cv=none; b=ARZfnYDKS8jYnOuSKsi6RkyrEIQ3KB5AVw94fvXivYx7VV+CQgXKpZRJNH8OYrDXkyIXAYQl5uHm0oDrBDpp2Y9mrNPb5EjvXl2mDaFhjQFN05gQZAT/XZE8Bf+QF1u91bR1oPso2dYWsMnZ9zqWaQa0UX1iZZ8Pq0Z1B8c8OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934070; c=relaxed/simple;
	bh=PNyZIdImmrds073f5nB1fB3oII1aVT3NsL27tbZppTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5zNyJ8EpmqFf9S7LeXu6YKGNMvRoGFOyQFREhSdpXJX/FR6yVJENeq+AYMh7KYH+YGwbnPlV9Dlkf2Uk5Jg+4y2bkemXFUBwNp+Zrc9PqtIVUKxVFx9ta+rk0lc+v2AhsnwBNionaoHCO4ECwIJgeTDyZHHWvF034nzD/PaxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dzGv4nZJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A025B40E0265;
	Mon, 11 Aug 2025 17:41:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9Rk2tVDAzDoP; Mon, 11 Aug 2025 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754934054; bh=vzqZZp4GUIsU8G18PqUEspYBU/y65Fim9IDqH6lG4GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzGv4nZJob76BP5SVOWCilfK/GOhDtwkxMm+jukWn9ePbM4snhygW/tIXVZNaGpEV
	 ReJwsiRUYOyfPh3CpMuenUZITPnN73z5ojcQaPyDzeSt90foWwKvkEmJQOCQMituJ3
	 2XKPhdc6b0XOUuxQLJ/rdpJaFfY77UkELTpu/ddxosRBIipUNOdcio4fBMqbNUIhAu
	 xARd8wHQZuRtAANFTyt5Fbb485mW8XxCOFYuTyO5wrHPIfTncRoDMVNUAVM9zOLoCo
	 BzoRPOVy7iVbYev5YPsZRdKmuqzHQpLF9nmPRnSojcI5aK42wKNtG5k4lmM7JmwzJ8
	 VR3VNaWqb8DPA+jjDJBTkndHR18n0Be4YpYyedtV2aK8355XnjXCTywrRfs0h2rxXc
	 lfzjlyvXkrw0SaU2PHvWbzlGOqcXzQP7Ts0BfrN0BFdu/0FxG9jcKyKz9UFbVYsGHw
	 4g/7BFmAnU5dfHsx/TirK+Ktmd/39Lup5bOE+O20ooVnzJQWaL74+Ciqe11kVhC/hm
	 GOrOaYWG9+gdBB9qpweVGhNa9jQ890Fy5p+2aMzJ0fSaDHskOYZrEodwXK216LtJ0n
	 9RsMQfDcWJ0IRYqf2YFEOE4U3/H0cn/CxWYX8+D0VGeaB1+r6GSA8Nepv9fSizc8Fl
	 z3wMReaviJTvDXjHrL9nnP/U=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DDEA40E0217;
	Mon, 11 Aug 2025 17:40:42 +0000 (UTC)
Date: Mon, 11 Aug 2025 19:40:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 21/22] x86/boot: Move startup code out of __head
 section
Message-ID: <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-45-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722072708.2079165-45-ardb+git@google.com>

On Tue, Jul 22, 2025 at 09:27:30AM +0200, Ard Biesheuvel wrote:
> @@ -210,7 +210,7 @@ bool __head snp_init(struct boot_params *bp)
>  	return true;
>  }
>  
> -void __head __noreturn snp_abort(void)
> +void __init __noreturn snp_abort(void)
>  {
>  	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>  }

So this thing already conflicts with the SAVIC stuff:

ld: vmlinux.o: in function `savic_probe':
/home/boris/kernel/2nd/linux/arch/x86/kernel/apic/x2apic_savic.c:29:(.text+0x6601f): undefined reference to `snp_abort'
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1244: vmlinux] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:248: __sub-make] Error 2

because it calls snp_abort().

I'm thinking since it is a one-liner, we can simply turn it into a macro which
evaluates to

	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);

and problem solved.

Or you folks have a better idea?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

