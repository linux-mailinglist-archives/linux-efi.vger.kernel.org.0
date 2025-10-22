Return-Path: <linux-efi+bounces-5085-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BABBFB797
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FA9189F49C
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C832549A;
	Wed, 22 Oct 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YYjqdxr0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4582D5A0C;
	Wed, 22 Oct 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130406; cv=none; b=rF/bNsEWEO1BUDRzN3oBsonghq78fvg4idqzmPwdGFA5Y178sr9J1Oi1t2TYAt2M0jkQSqn0kdgvgLpf8i7OAD32e87Q4aI1U6EX4DG8c9x9p9T+GB8nR5pPDfa8bTS4mN+mssN2EdpUf8kDaNFCAsFk9VD4GNCPbDW30Isu4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130406; c=relaxed/simple;
	bh=wa9y6VC6nk+UaFLQfO+kcz1XNqHz+k0Uix1DKdIowCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgWmpOXFZHhe1yy/gDWcVAvW0J3hhBJfzGEa+DGucDtLsI0ZNXU5kbDNEHRG/koYi6yah/rwwdwbA+4JuWEJwCOcKDZ0mNzxMU0sQMQ2DFjVnNN9ZPaPg8+qrOKJUXCyGKnrlRizMMuaIUKgiYDvXjdMBK8cvfAkEikiA5evBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YYjqdxr0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8093B40E021B;
	Wed, 22 Oct 2025 10:53:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UucJL8v8e33A; Wed, 22 Oct 2025 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761130396; bh=tCEcUCjHKCWYK1KKFqmFTHqeTyI6CWgRfbOF0mFOCRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYjqdxr0iJWnmBGWsR289Yr46Ha/4xxosopgB1DtB+anVpBZmGJpo0+LwXYMN5IxJ
	 AryrzlrJjYuK27UEMFJmd8/WrEvrm0h3DEPNBpq4y8rsVvdzYP+Yw08rqgczR7CEuz
	 ncnU0Xt/3QVtBXCJZzMNju1a/CW3izjiHbpGNTj3dfRpyrehVACrvkK0RVsbjdvmhi
	 jmrX//NTjBB8AjJdYesDYcbFwbVSiHxZ1jbnKI2j5X/pDDYt7kl0eNmjQAiOZAbIKr
	 5fo8/wtfyvxSE4f8s5+6iXDprREY+3BtSUt594uNddfuk3n0cCVsip1pVKyNvcAG5X
	 WEsTX67vOTcbDEwS0G5Ck3UTL4Bo3lPiWohPgq6SPVRLlN2MkDZnCaC+biVWPsxyK2
	 CfZ2TTuNhnaTTmmnOBKIHRTulYZ85cDjezkv2fyWOr1lmjztW4qnxt85l7wROADKAf
	 sjpErQjdLwZJ+fF7p3ziO2G+iTrs3CTT+DlLk8ictJe78x+dTdhhkrXHY+Y5cwbkZN
	 ko4VEZEISFW8U+8ExZyH4ECjiOH/nulbCZ/AYSynBAia6PcQGm4dwb4MqW2+vLEXjP
	 4BB3tA3dOZ+aK0nmaTzBAYteBQCo+yQnjdUQYnclNQtbHyjkapMuvuaSeXR9AgvA9/
	 P9TkY7gWgcJT/b0wzE7ZBPc8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C26E240E0200;
	Wed, 22 Oct 2025 10:52:48 +0000 (UTC)
Date: Wed, 22 Oct 2025 12:52:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20251022105242.GCaPi3eps1PdAWEXOh@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
 <20251022082541.GL4067720@noisy.programming.kicks-ass.net>
 <20251022094019.GAaPimg3VCgRu6eELd@fat_crate.local>
 <20251022102253.GW3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022102253.GW3419281@noisy.programming.kicks-ass.net>

On Wed, Oct 22, 2025 at 12:22:53PM +0200, Peter Zijlstra wrote:
> I'm thinking that machines without LASS don't need the clac/stac in
> these places. And when reading the asm, the FEATURE_LASS is a clue.

Yeah, makes sense. The second alternative with LASS sounds like the optimal
thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

