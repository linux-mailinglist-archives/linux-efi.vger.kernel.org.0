Return-Path: <linux-efi+bounces-5083-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F9BFB401
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D213A356A75
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951B31690E;
	Wed, 22 Oct 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YdfSi+B2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6513176E7;
	Wed, 22 Oct 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127062; cv=none; b=FzD6xKGnE2nC/UECq/taTwiKWXYDHJrPJDqmGWvPwi/X+i5MOhRksVO5EQZU3zxLF1DvxJtg9xj62Ew4eQ0tjsXxlbh75M6wZ+byOicWCUpNGAsmerkAOVQYxHn77NqfZ/sX7+L3IchpHyRrGwJyXW9K+TC5faQX/rEeCB+aYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127062; c=relaxed/simple;
	bh=12nBu83/hcrrA3IfuoG1+VpxOxa+6gKvxzVWo9bQz5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIw5wizXYfBBfniTZ8o5ZM/SfnsTk1AU8M5wjOsEU2mlAfKBJ/IjA5v6DXmYjVvZjmVEu3UlF7uaB9N9cZuIR2Q4CXjM1r4y5z8opsFTBMEANk82gyOLG3/jC+OXETzciOn3fZ6UC/llkMnJ6NIlweYXAchCnQm1Ke5mvD3s/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YdfSi+B2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A849840E016E;
	Wed, 22 Oct 2025 09:57:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1oRRCaHbFJxx; Wed, 22 Oct 2025 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761127051; bh=nv5PZVnhgm8mINL4pcw8nhwEQ/HfogSKAt+4CiULJV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdfSi+B2PlfMIL9tmW0EbtaGJtqmdTm+5+ShHq62l/lMgn+LzQtUoEftbvP9K52EJ
	 zX48IfoqZLrbqMMj0+LBu5fiFEbGISZam7FaAU/mkWf86V8vT8iEV0Y0fiqyv6W+bl
	 DU9tWOhg4ej2ffX9nAw28J4xkCVTnGzHhGM/qOpvznJHvlYgvzqfaOSCCQ0Nw7HpV+
	 C7/O/EPu8FlBZUIMo7F0gj3ap2FUi/MIhf7x3xgfnsw6+ZvC7r4pVw+l2mZDtamtYM
	 0X/gxtYGHzS6i3Rz6/t0FUzUR5p2GchxY4TT9yUMuM+lH/N+OXN0J/X47Qw4+vUKoO
	 WIDfQXD1Xa65QMgMX17d9jB33nPQ/4wT4MUoaG2JZ10OdYUpOSuFlrA3wRSASNEx3G
	 lVQrFJvQupLM7fjF1UX8D01DK6+ygPWrCK8MsbK3Ixht2aunktbzhyR/1MBuMPHUKK
	 FEQsai6tPoDe2EuzwS8yWTdvyn3itzEH+5iiji435ZJxGTDhHJ2rtCHm1EOJG6unBI
	 iRa+i25coUezE+oG10qM6g5KIFEFvKU7zHf0iivF0uSqFaxaboN57Kdh21uTTZWcQ8
	 5FaeYBVazWNSKA0L4M9WDiBEjEjbQBglF1/vXVglAT5PNeBjkLJfo+VQE+mWUGSAug
	 IwmpsVpMaOK0gVKkdzoGqkgg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CE39D40E01CD;
	Wed, 22 Oct 2025 09:57:03 +0000 (UTC)
Date: Wed, 22 Oct 2025 11:56:57 +0200
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
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20251022095657.GBaPiqaYxPMonQWLtw@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
 <144029e3-30ea-4e94-9afd-4da53ce4a657@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <144029e3-30ea-4e94-9afd-4da53ce4a657@intel.com>

On Tue, Oct 21, 2025 at 01:55:51PM -0700, Sohil Mehta wrote:
> In the series, we directly write to the CR4 bits, so they don't have any
> wrappers. But in the future, lass_enable()/lass_disable() could be
> confusing if wrappers were added for the CR4 toggling.

Are you envisioning to export the CR4.LASS toggling to users like those two or
is former going to be done only at those two places?

Because CR4 toggling is expensive so you probably don't want to do that very
often.

> There is an issue here which you had originally objected to.
> https://lore.kernel.org/lkml/20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local/
> https://lore.kernel.org/lkml/20240711012333.GAZo80FU30_x77otP4@fat_crate.local/
> 
> These new versions of lass_disable()/lass_enable() will toggle the AC
> flag on older platforms without X86_FEATURE_LASS. It definitely makes
> the code easier to read and maintain if we are okay with the minor
> performance penalty.

Hmm, we probably should measure that. The text poking should be a relatively
seldom operation but we should at least do a quick measurement to see whether
something registers on the radar...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

