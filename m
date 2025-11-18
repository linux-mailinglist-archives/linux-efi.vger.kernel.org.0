Return-Path: <linux-efi+bounces-5596-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA4FC690D5
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 799324E473B
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590502F1FD2;
	Tue, 18 Nov 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cF1KwkMX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6B3254AB;
	Tue, 18 Nov 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465057; cv=none; b=cIKERNbIS+uDlo9asxms8E4BWwvx/D3uIDdnGLtdgabV2S+SxWECGsQwPQwxBdr5WaaV4+BxURWuJ/IEgu6bD69h5K9xLrO3M7FEtnEJxHVisztBKNJ2kcgeMWQyny0kqWAoKcPD0IYx6+Rn3qfl1VRTZEJ5VMvPBfNwjl2/+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465057; c=relaxed/simple;
	bh=95RGFT/dhcOn0/N6C6fU5jw+MwuagCZufD9NT8Bkv5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIGM7+li9T3z1BVf0vdXc3HmQkEAvGPZntVMqdwi8oQEBd/i/SJkXKUOuTK9nAn6wscD0dtD0jmXkrauGJj/6mv1XZ09Ht0qu9o27a5BAkFmhKySEilJzX4lSgrHlkICFMmZYuYHO6wwYTlAM7GySewz+XhyMQj+fIwQofhiux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cF1KwkMX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2FA9040E0258;
	Tue, 18 Nov 2025 11:24:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fKhnvmpBsDvn; Tue, 18 Nov 2025 11:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763465045; bh=1kLZ5cyCs9UDKm0LBbgOUZyb5nF3nDZlDxQEsPSnVdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cF1KwkMXQazRUOyIwJVFysULhOSIcknlBbylO3ziLKe6W99FKcAfkWr1s+eBQcKss
	 V9WjpT4ROnyIkbou8nlFHV4cnu/sNvdxvFtmvxAurcCnSOVZFw67Jn4HsB5f1/9Z0i
	 jKuf0/jmGIzi9jYSSH+ourYIwo01OboG8Tau2mEivci5tSXB3bHjXyzOZKiVTADIbC
	 3G7XF8fBs5Q8Cw2ReXKBEO9LsD8qwfOlBH+XRY94dnGyW7hzGVEgtlbMbWl3zE7FMI
	 ippz1GZYbJVcX8J5by38wKPjdQ1qZR7aFkU+PEL2v4B1qYomooNGn4EOqPbSp90sDX
	 Ken3zf0j7TcO6BAN/1HqBneWM+BSBiYAkkL9K67CR4k0ZUiNbrrwyMbHPOEkcdMESL
	 GWEqNIN3ZiS30oxKu+9MLylEpkQpKg1H2ZjoiacQWZrRcmzmXJLIkgROObHwTjnFkO
	 x7qUWLPJPi0aptq47baslnNGIps4K26aikHIyXJS16bW02Td1+04dUJpkoDWHkG+fR
	 SbRUyCy5YNTNFOa41zlVURKra0MAJjnn1kG81Wkbxiuya+b6fT0vc0hN0rHsQg77cn
	 F9qD3WK1DqogexehP1t+0mur95Na4dmJTsZ84Mbk7AqlliMa15AOnZGxlMx8lWNi60
	 rTptPugGiquJ7YtRAQyvA/V4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 81B4740E0216;
	Tue, 18 Nov 2025 11:23:39 +0000 (UTC)
Date: Tue, 18 Nov 2025 12:23:38 +0100
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
Message-ID: <20251118112338.GDaRxXOqONunUHGgV6@fat_crate.local>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
 <20251113224204.50391-7-sohil.mehta@intel.com>
 <20251117144840.GIaRs1yNEYjdNF0SHu@fat_crate.local>
 <bfce23cc-bf7f-494e-a443-baea41f33381@intel.com>
 <20251117182958.GBaRtppoY2uANW2JI8@fat_crate.local>
 <ff8564b5-8b64-4228-84cc-7e3c0156a886@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff8564b5-8b64-4228-84cc-7e3c0156a886@intel.com>

On Mon, Nov 17, 2025 at 11:45:38AM -0800, Sohil Mehta wrote:
> Would this update to the comment help clarify?

Yap, that LGTM.

> 	/*
> 	 * A NULL pointer dereference usually causes a #PF. However, it
> 	 * can result in a #GP when LASS is active. Provide the same
> 	 * hint in the rare case that the condition is hit without LASS.
> 	 */
> 	if (*addr < PAGE_SIZE)
> 		return GP_NULL_POINTER;
> 
> 	/*
> 	 * Assume that LASS caused the exception, because the address is
> 	 * canonical and in the user half.
> 	 */
> 	if (cpu_feature_enabled(X86_FEATURE_LASS))
> 		return GP_LASS_VIOLATION;

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

