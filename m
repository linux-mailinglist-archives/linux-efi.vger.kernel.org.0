Return-Path: <linux-efi+bounces-3641-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E1AAF861
	for <lists+linux-efi@lfdr.de>; Thu,  8 May 2025 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7DA7A7168
	for <lists+linux-efi@lfdr.de>; Thu,  8 May 2025 10:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA120B80C;
	Thu,  8 May 2025 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LUMkxV7y"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8B72632;
	Thu,  8 May 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701735; cv=none; b=rDzSfgGOKo8e+tYSvRFNQs8x1hyDJkt72HxVfuDkmlnQP7n+NmaH8OjxN0gMJZhf6moF9sjHju8lhpcdUjAk6n/HHajsLcWZZ5XXxAv1P1G05sSxeEeJG+/nUE7wVSL4xTbNssNQFxZx3raXfU3+WJ+RZfGrzSa1VHRqRVlp37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701735; c=relaxed/simple;
	bh=j863nxwGzYzfIuGSW/w/08VR6akS2bkUtpHDZUuUAjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g00VV950OFo4+KhRUqe/Zz+t4OZo4Xw/Wb1ly29B4S3x/xtkAcF71MUo7GHilryOTvbo9PUEfVGCdGlgZp7jFBVW5cIcXvOgiSQI5QCnLb5WSCIY5bdj7tXhMluri2NwCzeGfG9MX9G4fQaPryFeB6C6VkdWQZsLTNybc/+Kr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LUMkxV7y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A0EB40E015E;
	Thu,  8 May 2025 10:55:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ksLRDIInAJOo; Thu,  8 May 2025 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746701718; bh=OF37/t9aaM7xkpNHEWQXA51YMPAw2sptXORu5APDjMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUMkxV7yLLWUcAxszCVe+XKGaAx6cg6CEdG0+NbXsi+hk3ZUuhFNGWsvxS+GYvm5z
	 VKp7UKcOBqFPuygOrjztVnDhrJEncu9sb4lbFk7cqfsZvS38NI1Qp7Tu+kqWUYSO0h
	 nh1/cKgXJFdZzulbIBqfW6BdsTwvzmhiYbEcIB3mB4c5BWH9cnUrm6qJmWVcYdipW3
	 VeAgLGEAKcP3EZPnMSRILE2Acwq2GCTHONMBJxkXOhCTM9nO1YfjPtZH+0e4MM24ni
	 xpJPjqF+9KJbhiojXqw5VeyGfERBEIicPGJcic9koIFZl9myJACryISGsYS+MYY6/n
	 wVXMmkPPY7IFsycSAKenQ5obVN9TXHWk9ajm7DFA6PkzKA14vQqerV0p8hPwt4HHtx
	 bqvdzzTC8jznF0WnircrjJwkY4xO1pBJLJx9RdleE6RuBWEPMizrDJwtha2B1mjirK
	 7dTuqAoZl2LBX/U2NoJLmoWGLBn1+sPNGeuZWWP+HDcNFnw6CH3A4bDX7xAJA38eaM
	 GPPMVS+RIHRPt0r5kio1nDQ+SS5vHEJ3SaNZNaW3hrOcU91cQsexCvi7SHcXKgVrBn
	 lzezb/w92quuTnMyz+WafqQ4EIQXd/NSEhRLAuiynt2DtUSAnAY1ALUxB5vnY7A4Ci
	 /yd5ngcN/FVpt0gTWvn9u5ZQ=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C65CE40E01FA;
	Thu,  8 May 2025 10:55:08 +0000 (UTC)
Date: Thu, 8 May 2025 12:55:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 00/23] x86: strict separation of startup code
Message-ID: <20250508105502.GAaByNhlpwwdK6_ZyL@fat_crate.local>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250507095255.GMaBstd1-nsMixe3Kn@fat_crate.local>
 <CAMj1kXGJk1JsehK3jtbR7yOKFV4UvySYbq10x8td1gM9ryHeBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGJk1JsehK3jtbR7yOKFV4UvySYbq10x8td1gM9ryHeBw@mail.gmail.com>

On Wed, May 07, 2025 at 02:05:37PM +0200, Ard Biesheuvel wrote:
> So I'd actually argue for splitting this up even more rather than
> bundling it all together,

Splitting it into logically separated bits? Yes. Just because: no.

The SEV stuff is still largely in motion so once it starts settling down,
splitting it would be the first thing that irks me and I'll go do it.

> although the sev vs sev-internal distinction is a bit dubious - it would be
> better to split this across functional lines.
> 
> I added sev-internal.h so that that single mother-of-all-source-files
> could be hacked up without exposing implementation details to external
> users that were hidden before. I.e., the high-level APIs that other
> callers need to use should be in sev.h, and the implementation of that
> API should be carved up meaningfully. For example, perhaps the #VC
> handling stuff (which now lives in a separate source file) could be
> exposed via sev-vc.h, and only included in places where that
> particular functionality is being used.

Right, please put those considerations in the commit messages - it helps a lot
with the review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

