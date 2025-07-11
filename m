Return-Path: <linux-efi+bounces-4291-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77323B0260D
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157837A7571
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36E61DF25C;
	Fri, 11 Jul 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NWzil8Wv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E51CD1E1;
	Fri, 11 Jul 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267613; cv=none; b=iuW9FTfqwU6/kjpqnlK57iYuDeu5KpFbEtfr09p45c5ZIOJGWh+/KeEiu0BQDEYIERhetNEmGDX9VdizsPwZCvsOlPWt2s05Up5+DEvDPtGOfg4R8uSp41SCgKnj8+S07kprib7q0W7+f2GyLEezl2qA4FYD6QS+wQfOTXVTWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267613; c=relaxed/simple;
	bh=DIRg2BafSkVIAWigWqujt6qWehlaim95i3/AqLpoyLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdvfc4bkvPAPdUURGGTxkUGs5PCvrVK21QeQ45JKZ5iUafGHQw2ckfedOlLhig8GILLY03ev7rGE6adHntKiymv+dWwaVcTZmvry3NEKiQGtKsGsGxBfzz1oqOQTNXxBF4mFg+uX03n9kSrZstDAZOK/sXXvyfMyuaqXwqYbD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NWzil8Wv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 955A540E020E;
	Fri, 11 Jul 2025 21:00:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cUH0d5BrqvET; Fri, 11 Jul 2025 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752267603; bh=kkSqQ2zFL5EdclmacrA43LPTYZ2bb1EaCYl+FapfbpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWzil8WvDuSb7dpNDyPfXNff+m9T+3Ept5xFu5H2qosuQnGIzoUWJAfpju7znRAZN
	 9DKu2zUzRnMmNnRYItryiQ3yENZ1S2ZrVKSK9nasxQ7gfClcR/Ae5lol2juBip9mGt
	 m22+caPIwBku2qUVx5otV6Y+dfoMfNXoUomwE0Sw/aLWjnOiPjx/eYhRPf4gGg2iPA
	 xWY1I9c5z6koyOOaAVeS44/fifff+qOe6J3B/7F+JfTI0uVMaXDmeeoTZLo1RHixwY
	 AJx4XKvMOmP6O4VIHVTF7aqR8EhpOmMc/ZuNZ5y0N7w6KBvKrtoCQz6/MUnL2d2K/4
	 iVC83wglERWnpodOs6B7siGMmTcCTNiPbE9aQDhLno44uyke+GMhwIcgs/snxRWj5t
	 JmEXP4EzOvvQ4voHXp3kCmG6T31wsPZbdPIe5mIRpkB6kY9pPP8zVUhvcSY+EbEwIY
	 FchV6QmHBiddwHipLM0y3MalpykW30M4/6Wmjv7FoGGXHK7wGdB03hV8iHG1nkPIS4
	 6F2+4CIPH2bxFgcLgj9qTYX8QFQ5sEOuJNaIn4ql0f4RDP7UTqE/Pw6EHEShUhae3r
	 6V7I9gkrC89AHq9K4qZANrqynBGJhZz+yCRKbw48ayRpzag+GJY/COi0hxDUPfQ70o
	 E3ea929ZEez9THBxFWHQ3sdU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8013440E00CE;
	Fri, 11 Jul 2025 20:59:52 +0000 (UTC)
Date: Fri, 11 Jul 2025 22:59:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 01/24] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <20250711205944.GDaHF7QAvRhPZOWMX_@fat_crate.local>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-27-ardb+git@google.com>
 <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>

On Wed, Jul 09, 2025 at 10:12:48AM -0500, Tom Lendacky wrote:
> Not sure the renaming makes it read any easier or say anything more. It
> does add extra changes to the diff that have to be read through, though,
> so I don't think it is beneficial.

So it really comes natural to split them into a msr_prot and a ghcb_prot
variant. If we added a separate patch ontop that does only the renaming, then
that would probably be more churn than necessary.

> Maybe rename this parameter to snp_cpuid or snp_cpuid_fn or similar,
> because it can be very confusing to see "cpuid" on its own like this.a

Yeah, that's a good point - snp_cpuid_fn clearly states that it is a function
pointer and not *the* cpuid() function.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

