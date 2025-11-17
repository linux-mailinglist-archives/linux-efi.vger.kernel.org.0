Return-Path: <linux-efi+bounces-5532-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3627C65B9E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 97E342915A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E331A55E;
	Mon, 17 Nov 2025 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZSDQbRBI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27A265CA7;
	Mon, 17 Nov 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404245; cv=none; b=kJPQDcFgZib1rvS0+BDxD9IKJX2THy8hKxb5HoFIEI0OLTEX3pW2AyX0MSn9QF1CxGgdQA+Q/pp2OhoOmRCAUtXLf9AGCMIa0v2QA2vTQdv4sMsQ0+kPzF8xGDX8qXHBawrSRpixP67MkfU8P3n22JsimBuQ9Y7Sm58yr3ZDL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404245; c=relaxed/simple;
	bh=BB+auAPSaWW0qREZgyoFhp/O9F7pIgaZ5weQweXGPXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJkUdAJUmgduhzNaVv3A1q5prO+GiSjsq12OwhU5hNM4DFsJy6rVw2+vGVIL8rgoLxU7Y6q5yXlLUMji1RUPdOi1P9duXZKnzYjGM3ZPDlXLQ/ZRG/vsXuvNkIzdeFm9UHSN/RSyB8PdKnybGLWT5CWvg6eLPJGdFL0SDPeWkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZSDQbRBI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 138D940E024F;
	Mon, 17 Nov 2025 18:30:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nawrX4O69IBu; Mon, 17 Nov 2025 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763404233; bh=+eneKW8K7UrutKZOwotXHXcUfrqGSpDfjTLnElI6pBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSDQbRBI6qy/coLOxGdlQb94N0/5AK1FpgtunhUMwYttskOp7Un+5PERvHaNCDXIA
	 VTb647+fsEIXhNnHMX8IeNM0XxMu8dzGDbx1lSxeZ82jLJxLKAhK4ShAMRPzsEGuOv
	 n6rh8blIyEmUVx9al2f5QhHh7Znwq846c6gREJmrXHHN1w/TxTk4q7szMVeJHpDzK/
	 c/XPLjWPV1O5SmvRLqDdmogtMfIjt9vYZNpPkdbirlKmNLjhvzlZ/dh31Fyh/FeUnF
	 pi5TVwMLKIPgvaRE0TgQ4wPlrQjAPx6DsSbYPmAwv84783xBoOtgsdiGa4kb7zsfQp
	 HoJCPkrUWXlZ7wxKZ1hFtrbWTTzmOAbsaYoimEAFc8nfGydYzTYzCWBME0XMPQbUag
	 utV2G+kjf+Mx18a0OQj/N6xvSFB/TNxDLyJfaEYeno9zble40lTE4BP8jJTl5GEHJs
	 DtC5GqfQE/+Dh7vLyn91hww2yQV5hqM2ouChFwWjonv+8ZGTKaPV63IZu1IRUq2L9b
	 a1H+qZTXX5ofe3LzzSKhJGP0tTrcX6V/foG1YodxvAhgaGDTIFvy17WU4Xule12KwO
	 6T/lKy2jzVVilA9JsNA52CMZ9dTmQWUsFseFsjLVDvQ3CYcRsK7Dp96CR9BcDWrVnC
	 VgtKVoMFkEiV2Yn8iOX2E4ME=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C27BA40E016D;
	Mon, 17 Nov 2025 18:30:06 +0000 (UTC)
Date: Mon, 17 Nov 2025 19:29:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v12 6/8] x86/traps: Communicate a LASS violation in #GP
 message
Message-ID: <20251117182958.GBaRtppoY2uANW2JI8@fat_crate.local>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
 <20251113224204.50391-7-sohil.mehta@intel.com>
 <20251117144840.GIaRs1yNEYjdNF0SHu@fat_crate.local>
 <bfce23cc-bf7f-494e-a443-baea41f33381@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfce23cc-bf7f-494e-a443-baea41f33381@intel.com>

On Mon, Nov 17, 2025 at 09:24:20AM -0800, Sohil Mehta wrote:
> The page fault error messages have similar logic:
> 
> if (address < PAGE_SIZE && !user_mode(regs))
> 	pr_alert("BUG: kernel NULL pointer dereference, address: %px\n",
> 		(void *)address);
> 
> I believe the check is to account for arithmetic or other operations
> that may have happened on the "NULL" pointer before it is dereferenced.

Ah ok, that makes sense. That comment still reads weird:

+       /*
+        * If LASS is active, a NULL pointer dereference generates a #GP
+        * instead of a #PF.
+        */
+       if (*addr < PAGE_SIZE)

It says "if LASS is active" but the check if
(cpu_feature_enabled(X86_FEATURE_LASS)) is below it.

I guess you want to have

	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
		if (*addr < PAGE_SIZE)
			return GP_NULL_POINTER;
		else
			return GP_LASS_VIOLATION;
	}

so that it is perfectly clear.

Then the catch-all GP_CANONICAL will take care of the absurd cases, if we ever
hit them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

