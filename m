Return-Path: <linux-efi+bounces-3680-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F8AB52AE
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A0B985198
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914F2512EB;
	Tue, 13 May 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZicVdULd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C41E5B68;
	Tue, 13 May 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131196; cv=none; b=sRaipq4GX3DtQ2T4WbMjn48NgaWry+jKhl3AwMngBDOt76c+Tcfj767FAltZ4iVUmn4DOg8gO+CFrE7GCtg5Cc3myh5jdUaW1HZMysKMqilhBG2ZapjMyhTyMFBL/vk1VPWbZMdpfP6Q3NUiVpjUHE25o6CaaErNEiBzBJGZ/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131196; c=relaxed/simple;
	bh=kYkTufQiPM7Mtatuj5DfCpXt+i3k4zHtBsVPJmjrEbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrzx3VZGJFAWZqpEIxaHbSfNfXSBkT+LWUOnXoJtivnjzyC59eodRetJS70jtUOjX+TWYmB/uFhbdCdZtrL9zknDqCklu3MagaBiY9mWP5HVQ6nDO4XsSs4P3PCZ3PNbKf8N4UcR1Zl1TCAlwFj297r6kTZ2TePAJpku58kiI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZicVdULd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A5D740E0239;
	Tue, 13 May 2025 10:13:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UspFaoVZok95; Tue, 13 May 2025 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747131186; bh=3jaTLwyVJAd7kpaIBag1pZe8FQx/fJxMxqj3xXgOETM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZicVdULdDzYCxvYZv6myjOO/wNmi+puzeJtm6kLJVp9Gym3mzmLGJtI590lpPTNoE
	 plb5BpYilqPXwtJvuzVpTUEmSmfC/HmHDkQnGl0TY+Y4G9NZep69nI798gDFX6MTsQ
	 Nf8rf73ms7AztdpEyFX1lrk+Df9EHDpbRTiUOdFJUqBI+CPFG+WYuNpheO8c5qnBuO
	 /DqofQoX5WU1CiTNRXfTFGEEACSwQ596lzgbiMm5/6M/6Q7xcKc+WV3l4pHt21c5gT
	 DUF/cl10Vv573J8eIkqnAhaIift1IOw+8Uyvac7uhHt9qV933FEextUixXwljSFa27
	 D+K8uT6yDdqbFVsBk8QgjP8leqhPu2MStfhOmGb9dqO+Tvyum1xR0IZusrPumP0Ipm
	 DtLMMdxAMTvwn07dCIXOlotVNFlw9fxJQo8V363F6ZsRWN9TiQ5MWWG3e7Ed8I3R6M
	 r/DU9s8chDlrfy02Jt5m48YCF/j4ubg9rwF0goncZChH32q9W36kZ0743gvt1NOB7w
	 kBHWDctkLC3fOsit4I4Hm68WmNewAa6ibRbbChEBsCLuQtg5MvaQQXcGz40QgeHvSQ
	 sQr55Dzn3Jm0kg3D1kZgUEqXuD2DvfRF7fzi6fKA+ezFJy7gE7gBRTST+WYa5qt4kR
	 hN0n9JBZDbV/ian+SlR4FtK4=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDA6240E0264;
	Tue, 13 May 2025 10:12:55 +0000 (UTC)
Date: Tue, 13 May 2025 12:12:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCMYrgd9DDQl7G1W@gmail.com>

On Tue, May 13, 2025 at 12:02:22PM +0200, Ingo Molnar wrote:
> I don't intend to rush it,

Thanks.

> That request for testing was ignored AFAICS. It's May 13 and still 
> crickets.

Not ignored - Tom and I are testing but we're busy as hell too.

> We also had SEV-SNP boot bugs pending since August 2024, that nobody 
> but (eventually) AMD triggered.

Where?

> Ie. very few people outside of the vendor are testing SEV-SNP AFAICS, and
> even vendor testing is sporadic ...

Not true - SEV* testing happens on a daily basis.

> Please ask AMD internally to get SEV-SNP tested more reliably. Testing 
> this -v3 series would be a good start. Hint, hint. ;-)

We test everything that goes into linux-next. We haven't started testing
unreviewed patchsets yet because we don't do that - that stuff is moving.

So if you want to merge something, just ping me or Tom and we'll test it. But
you have to give us ample time to do so - you can't merge something which Ard
sent *on the same day*.

If you can't test it, you don't merge it but ask people to test it. You know
that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

