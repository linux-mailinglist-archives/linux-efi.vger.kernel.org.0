Return-Path: <linux-efi+bounces-3758-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFDABDAAF
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0801641B1
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6C245019;
	Tue, 20 May 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XD0hY/0x"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9D1922ED;
	Tue, 20 May 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749542; cv=none; b=Vx0EBHPm7XaHK6lcBhqhia3KhBnqDphR6JtmBaOebcy//T1tNmQoJdSiLn1JQ9M4ETTKOLpe2O2ne3gULjVcJ21Ko+j26mCAi20QPkdXRuDLJ8U5nydrGe4MxO1upmRiuiKWo7kgu2dP/rARUeziiTfiH1Lm6pvPDWlsTNKSEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749542; c=relaxed/simple;
	bh=uaL3tXekQSCiZAEamoaB96XYGC12T39WNSFkxf278EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeV0feXlxPjsEP/Nb/OOwNtiECj5CQmQdhSDbA2o7rw9JvOq7nYtca0buWjbrRBnoAw0T8vu2KpuHcRPbo/9zX4jIKzeNx6TvxMR2vgQbSwU9DhWo4zIQdhkKNZRzw+4gEIvaYfV0BmtgoG6k9zZzSWm4HnfJz5wMJjoUKFE7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XD0hY/0x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 694C240E01CF;
	Tue, 20 May 2025 13:58:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gmyly0Mbye-Y; Tue, 20 May 2025 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747749534; bh=Fr+ncuQTrtwHZ5KRy8blcvlPV5o2RWHJd88R0Jibixk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XD0hY/0xSbFlhr4I/QecaGoa8U9qxwI8vAIqiQQ2JhLiTwgKIw1cxx49Q7B/NJzIC
	 aDBgTDkRPFvrSl0fA0Zh68V8dzCEnZrmUn5kaC5sEui5Tn4e48dMEaucDD83qVY4RU
	 dAcL2lO2tGUMd32WxRyl2rVywQGz/SPjqcC0EFWQHamsXCu/a2pyeHzMbpEERz/glT
	 qeyf7o/KFdOyAQF7KomNTlSF+sYggBzQ0H+yT0yUJdm5nuA/XP4SQKbDsTtAg4Gqo6
	 zFVKEpLxpyAm9jnq77+SqjJzjdaKVs1quT5LJReQ63hbrnYPxeeGFT36558FIwqvBb
	 DaZVjxTRwBpk0iKnRSzSspJqg3cgraRc6QTptU+jXiRrBcUaJryu31525Oz0KLO3gG
	 elLYT7czqaMDpk8qdXTXGdxsVdvXH4Sos6fgkjK7BZIPr6R2ymPAY0dtQFaty+dgxS
	 2DxqZksmngEB2WIqoz5fjRLq6nDYgnQKJcWfO9v1D5Ojr9q4pW57qV/lm5UB2z59ZE
	 AJ9KB2Glq7ToYVIfbuZ+vf3ks3deem+qGlj3Xo1ERy6Br1sZ8IdXIyuhB3SJTXSvdn
	 cVYluyfuIuOhotBu2wSbOgJNpHV859xdGGEVgWhXLi+UHrCnTxGuRjtCMe/fDRfbIm
	 7rawHYdQVFnUegOXipEuts3o=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9CDE40E0192;
	Tue, 20 May 2025 13:58:44 +0000 (UTC)
Date: Tue, 20 May 2025 15:58:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 05/21] x86/sev: Move GHCB page based HV
 communication out of startup code
Message-ID: <20250520135836.GLaCyKjLdd12W4YXcn@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-28-ardb+git@google.com>
 <20250520113849.GKaCxpyVy-7N6bih-r@fat_crate.local>
 <CAMj1kXEikRCP4TyNWWQh7wKErr9YKAe3cCbPw8XMuXLVkr2S_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEikRCP4TyNWWQh7wKErr9YKAe3cCbPw8XMuXLVkr2S_g@mail.gmail.com>

On Tue, May 20, 2025 at 01:49:35PM +0200, Ard Biesheuvel wrote:
> OK. In that case, it will be implemented in the startup code then, and
> exported to the rest of the core kernel via a PIC alias.

Right, let's try that for now - we'll see how it all settles with time and
whether we have to stick it into a internal header eventually.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

