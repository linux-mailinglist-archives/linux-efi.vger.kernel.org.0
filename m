Return-Path: <linux-efi+bounces-3698-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E404AB72A1
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7F3AFF07
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFEF27F72C;
	Wed, 14 May 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B+60nnov"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75227A442;
	Wed, 14 May 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243321; cv=none; b=FVqpSyMHf2nEcgI/Oj3d+rYVNj1xhdLveZyHMZ7NkIFVYhhAbn8EXVAqIDRA0L+9PDxl/nO/iDhKReICQYSfjL2VakVYb6DvoGIHM7CtwS2gPt6KA4Llvgk7y1c1aafe+d7iY14o7JuidmrPzEoOumOwUL7wXkmuvq5gEcB3c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243321; c=relaxed/simple;
	bh=8Y9W9EkHp0OgfQElHMfELzV6tfQK0+t1W9DfZ3iYUMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNTqHr37YA+utaUbhfXxeiAtSa17f6+RHPAax4OUOgRFe5p3UMa8kbz5JVsGI3RQQdznBVzf1z5xErakQTqv7+L1biWKoB4A0Sh4Yk+f+RSzsOg9fx8T2Caok+XY3cQKI22QZwIfHjgA7tPedve11yiNKpm5593T1WuWsM271rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B+60nnov; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DA0F40E0239;
	Wed, 14 May 2025 17:21:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jZNuwh63kGqM; Wed, 14 May 2025 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747243306; bh=wYhpoOFARMdfnUYYy0x+ezUoiYCtxlRLDwSjosU3JwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+60nnovfgJQkcpIoxYA2aBG6C4C/NzhlKUq/kc56fNhonAnqpuOiPP1g2aikOoVV
	 jqJUX8UZJ2sCTnidzJNprvwbUgRHA0HnnQStfAe5JRgWYOZ19DWMj4DKaO6Bt6Njbv
	 ECoxQ+NckU3vpKUtAtk1qjOXsT4L3EuBoWbaHEMQJLLIZiTidRS/aC8Yz9c31n/vMI
	 ToUK4fZ29HIyYBy6wpcELPf8iUa7ltOYbEgO9NERvSXjQb0j3J8PNetVACQJFhY5Gh
	 fh/csdjJ2+yZ60G/tzxrahCddG5EWYUYbarRmm8AeS0qtfw0SpCAdhzkXfph/72Lpi
	 woJ90JgVOdDywXJom5+kNkSKZG6n+BXW9TQ1UNPSKx/hAJHadwZXGP5sea3hiEs0Bj
	 Hj+Vpwe46EfrE8jlAnLd75K5fiSgdisMVAP8DgJ94wT7EpJJvHC2I9RPXBHETM0BKD
	 KgoxJSj1OWurhdjorXq9Mvu0rE8I55qRBXUKe0PKaBQzCc7Fp9hwrc0Vv+Hq1iP/2B
	 OBSXG3GLaGkDeoixerScmNhofIGdLWbraIjHkkl/mneC7aHVRYbNS8iFheh4QQckdv
	 bixLH9qOCCpKfLpikgaY1YjwHcowswJWppqy5Fjuztqhem9seM6Gh3w6SQ6hr8hN8H
	 76xDZBSd5o3wFdnCmhcD5N1Y=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C613940E0163;
	Wed, 14 May 2025 17:21:36 +0000 (UTC)
Date: Wed, 14 May 2025 19:21:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250514172130.GAaCTRGoRL3nYieIE7@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:35PM +0200, Ard Biesheuvel wrote:
> This is somewhat intrusive, as there are many data objects that are
> referenced both by startup code and by ordinary code, and an alias needs
> to be emitted for each of those. If startup code references anything
> that has not been made available to it explicitly, a build time link
> error will occur.

Makes me wonder: what will be our rule for what should be made available to
startup code, what should be moved to startup code etc....

I guess as less as possible but past experience teaches us differently.
I guess applying the usual skeptical approach should be sane enough...

We'll see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

