Return-Path: <linux-efi+bounces-4837-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A23B581B2
	for <lists+linux-efi@lfdr.de>; Mon, 15 Sep 2025 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198B51AA4150
	for <lists+linux-efi@lfdr.de>; Mon, 15 Sep 2025 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB927510B;
	Mon, 15 Sep 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YwNJnbHA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1826D4E5;
	Mon, 15 Sep 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952560; cv=none; b=nT8xKCXAkFJlf/TlruDdRlx/CuJj2RgfxrPhS9glnOHcX0wSf6GDY5Hhq9sYMaesA8RcW7PO0BZrmvUBuqhGoFPVgtgtxAF1zIUBaWo55xKX1/QvpnU2QrTFz6hCXnVK1cSD5SI6Jj4XL8Y96tB1FIOKuFHVwmhLmVCZGSMDO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952560; c=relaxed/simple;
	bh=QpD90IrR2CiyrocBcfezpDiEQwymmyZz2CkDHjbqPH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGT6fqiirbW4Vq0sVykRWkaILzQFfAuow9SVqzqzj75WdN0gW2KcBhH2nmok41uKSPQiJ/wE9nrNFKgiCbXGFcaT9GI8hmAcXlu5UalPaKEu1z5DnP641QJXk+JoT40OAccikOTVr4CbOpW8DSq8jzsj/kuvfKfV5vwyOg+6hFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YwNJnbHA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6E2240E01A3;
	Mon, 15 Sep 2025 16:09:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YZECDy072NWx; Mon, 15 Sep 2025 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757952545; bh=jMLDus0Bkvhe1MGT2FJLXQkD0t6byxoI3ECcJ/Hjol0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwNJnbHArESMXbcrTm+dWxe9IyJdlJtZieOgVZo3Uuu9t+VBVOQ3Gw/aEvJYx1OG6
	 GxANLBT8m8qaTHzsCPu8Im5ntc6iMFacMJNKI6W4uh8c8W1KJwjqUflL4hmKZ3cmtY
	 2X38FmpPjGCtHDJjNPKuUpYF0hadzvoWlWoSKihOOdk92+5oS236+4L2aW3XwdDqv4
	 cWZlN5PsXBT5riJo6BuqL/PQh1if0Xu8jQChPZxFHx4T9P8QPxGxn28uqTjXMD473I
	 bH1zO1PfI1+rhtJF8dpF+3KDZRxIuO9DHhjGaZp/24FlRTCA6T+NdzT/Q5xbWTpx/h
	 WenlCFdMO8hp2EkCXl8t/P2jsbULWdC9nL0qkNPEULzPDY38BbmU+D45TlFmu8xiQa
	 OXx0ZULptahUeywHcOQatvRbLs4BtBcQuDOYOAn3weeNSM13LjxpRzQQpSfG4Ufr5t
	 zqBK71cbWJ7UooLpmNKsBuPojKmlaOGIIHfG1lhNrKp1aOvxk3vr3FUjfvAMAda0ax
	 fXxCDwuFnnEplRExTUCwactWoJRUah820oVfdcQgAZf6jRaKJSlyJrvBRJA4Hk3u3f
	 QK1ls6j4zKp4JzLAwYSuZN1gaD5xewtyWNM7TqBvkS0LyfYT72F3LofBaVpJwUCn8m
	 57SmVQbY6aNJixa2WJdlJvmc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 93CCE40E0176;
	Mon, 15 Sep 2025 16:08:59 +0000 (UTC)
Date: Mon, 15 Sep 2025 18:08:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI
 stub
Message-ID: <20250915160853.GBaMg6FX9DfeTUzHFq@fat_crate.local>
References: <20250909080631.2867579-5-ardb+git@google.com>
 <20250909080631.2867579-8-ardb+git@google.com>
 <802166ae-9420-41f6-95ed-6570ef660369@amd.com>
 <CAMj1kXGmgXRA=hO5P1bcTU1ya-RypU_y3_kahO632U5iPT7vaQ@mail.gmail.com>
 <CAMj1kXHqhWpb2OZy+1N8-oPa2Kk0d56NS6tYH46Z92ui3h5wMQ@mail.gmail.com>
 <89b28d47-bc33-456d-9b8a-a8d4ec27da84@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89b28d47-bc33-456d-9b8a-a8d4ec27da84@amd.com>

On Fri, Sep 12, 2025 at 08:32:30AM -0500, Tom Lendacky wrote:
> @Boris, what do you think?

Right, as we just talked, this should be ok, but it needs a more fine-grained
review to check whether the code that goes away is present in kernel proper.
It should be but...

And then we probably should delay this until the next cycle so that it gets
a full cycle of testing instead of rushing it in now and then patching it out
again...

That's me being overly cautious ofc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

