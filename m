Return-Path: <linux-efi+bounces-4529-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B4B1FC11
	for <lists+linux-efi@lfdr.de>; Sun, 10 Aug 2025 22:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2190B1897ADB
	for <lists+linux-efi@lfdr.de>; Sun, 10 Aug 2025 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749C1D63E6;
	Sun, 10 Aug 2025 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fXvNsaDk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B1219E8;
	Sun, 10 Aug 2025 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754858774; cv=none; b=TyEAeUj1TMXCatMW1rZzTXIfDpd+lhRZY+u0qrfJOrYzKWBcEevxoSOFUijzqgJohSB7DKnpIGNA0F+W2YyIkQsglz80beCmiP73wcSa2/sCWsE99fcbQwPsutc3Nwop583xtCUe7UGGPT+6ZtMA5GENNOOZNLA0XqJlI4kToME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754858774; c=relaxed/simple;
	bh=X6u2f9fO9neZj9s6w+y5uN4zh9MdsPoxai4OlaDcAbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3AndUTeMw9WBzeg0r7m/W3Kdchqds35UlGHOsagk7+o55qWAsJWcfNcT+hxT5R6ne6At0Os9hqwD/Wng2K6imtvP6p4YaUsT+qW0Qb70p5RDCtfpRxGuHohqgp43sbrgTPSWGYaZspOLWBrsKThivlJKbcItlBPvBc1jBxImnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fXvNsaDk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A77FA40E0232;
	Sun, 10 Aug 2025 20:37:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z5318P-2Ttr6; Sun, 10 Aug 2025 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754858222; bh=jPuah6eZJsKx0Tn4u3wz+pvNuujj0ltLpFFE0DRYR+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXvNsaDkf/mITzivh/QNweou4KTleJgtzJ/0LAOU+UOTVC7hGdo2p5SReEH1DGoTj
	 IYl0oWH+EVK5sSrk56H0xO2kq/EkyOdfSP/ezNF1mMJuwDmaF6I2ujWejIP6vuoeJI
	 3Pp+WseZxIgPYLLJgvKjcq87m5owWsxYFnq/oP03v3ie8jzqGLZxyKqS2FJiC9dwYO
	 umIK6ww0vJBUXiqd0up7ihR8cLoRY5wYi0yVlC4LjpZ2KwxOy9OizEyGWZMc0NIhPY
	 EqpGMr258Yccf98tvi+xBz4DZNVCj/nOYE797XtQUzeDe2bV9jctxNB8A78RtN7Cu7
	 Vt2ePa29wN6SwwcjveObo5FqCRHQY5hUkFiW0V+pCAYPq5QB03l1b5RywJHmgPq3HD
	 LU0WX3hoZuIoGDz7CvL4keD6zMEbzsxXY/Hh5jWX6Zn3Z9ScXKdOfPUvncBKTIv9VF
	 ybtMo7vhcCZ2uFpGFX/P2fnc5GfaJ8fLC19Ny3HAmeaMBeoGoHjNl9MQoLifqKpUPl
	 5GE6dArkl3QmxQ4Sig4DW19DErcYXxFqGZAYJsT5bxsigDhyF1/MpSVg1EUxH7slAA
	 WVVeoe7t7+uzjGl5rLGHhtn0JRauaOWfdc+jW8AWLGDMEYHUh2AfxnZdcoq9OSGlfW
	 TJbEJmjErDiFvNW+/q0ihQ3w=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8ECE40E0217;
	Sun, 10 Aug 2025 20:36:50 +0000 (UTC)
Date: Sun, 10 Aug 2025 22:36:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v6 08/22] x86/sev: Pass SVSM calling area down to early
 page state change API
Message-ID: <20250810203643.GLaJkC2wtmxtvrPbeT@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-32-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722072708.2079165-32-ardb+git@google.com>

On Tue, Jul 22, 2025 at 09:27:17AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The early page state change API is mostly only used very early, when
> only the boot time SVSM calling area is in use. However, this API is
> also called by the kexec finishing code, which runs very late, and
> potentially from a different CPU (which uses a different calling area).
> 
> To avoid pulling the per-CPU SVSM calling area pointers and related SEV
> state into the startup code, refactor the page state change API so the
> SVSM calling area virtual and physical addresses can be provided by the
> caller.
> 
> No functional change intended.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/sev.c      | 12 +++++++++---
>  arch/x86/boot/startup/sev-shared.c  | 17 +++++++++--------
>  arch/x86/boot/startup/sev-startup.c | 11 +++++++----
>  arch/x86/coco/sev/core.c            |  3 ++-
>  arch/x86/include/asm/sev-internal.h |  3 ++-
>  5 files changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index f714235d3222..18b0ccf517eb 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -65,7 +65,9 @@ void snp_set_page_private(unsigned long paddr)
>  	if (!sev_snp_enabled())
>  		return;
>  
> -	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
> +	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE,
> +			    (struct svsm_ca *)boot_svsm_caa_pa,
> +			    boot_svsm_caa_pa);

All those functions should probably get a

struct psc_desc *d;

where all those members are set to the current arguments so that we don't
marshall so many arguments back'n'forth.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

