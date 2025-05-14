Return-Path: <linux-efi+bounces-3708-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD9AB74CC
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 20:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA004C5CFE
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C55289811;
	Wed, 14 May 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KEq4lG6l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F21F4CB7;
	Wed, 14 May 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248815; cv=none; b=E27VCWcgNoAgdZ2dk3xysN8ZE3Z4JxpWSKqbLAs/i+USisN/ghTcQ7KmbifyKvexJtXA0gKGXZYPSmM6Qvc6sZkYlgqU1VTsgGXuTbdbn5stND4JEsGYLr7zYlVYas5y4xvTg+8WOoZrGRJo7ZtWWXWMsp+dzDevUB0e1h2WomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248815; c=relaxed/simple;
	bh=YSTjlKLYnT97FPs44P2jpPLaU/lb/Bpao4PKukaWgLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNHxOb5yYnMcyr0ONyQWxkYkI1NI0MXZYOZRgK6/I/t7FsA4S1TyST1fxZ+qLyFexv768gUEgXZblb5W910i2NsIgRDJxXWUG9lr/Hs8EqlsBMKb0qeE1Pe79F6B7Q/uEKgQbI5L19sFUch7vozNlAj9sBfWjHznS/VIpqD2t1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KEq4lG6l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C44FC40E01ED;
	Wed, 14 May 2025 18:53:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 81vlMqCq15_R; Wed, 14 May 2025 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747248806; bh=0vOGV0XILyspb43g1V9dqHl1wEdSi7Jd2w2s+KezepE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEq4lG6lhO260DYBtkqrYSrmiOzw3jD5ZJdJH9KTTxHaGq03netrVBk2YRlvBYU6a
	 9tkFi2RIM8KZHjmofzrBrxfiSl0NVtUq0raip+3xvjBS6tPyZEN6CY/KaASpV6XzxV
	 KXfMSX/JH8Z5SmD5jcILXBz0aSLUwRLj6cfahloYVHfo02fYZp0NeQpjX60hXzCpGV
	 tTXCIKcC2Ikdxa35Succ9EEzq/Bdme48FWNZ33DApCgmKwkKI00N2zJKFvVa2AnOgD
	 6PhVebNH0FgBPj62ljtl6Npu9mpV1sMneFD2cofUtNAgi1YYXsons7uPg9O//3aoMx
	 KrJ13LhTWB7u8LgqaSxER82Wx0xI9qv1B6KEFm1gVqb5/JLtXgq/b3sp7THnIE4PQ0
	 aN6wW+hE2T0oOriofo0Paue8bXyNe59OkjqLovpuSgyE3ZxXpKCkdXt5h4Nbv0yAbU
	 bHd2Qtdq5kvIjxxRrqoRKt43HU8mNjI+aYblRxZZHdpPpnURMh3acWnrCd1qvWHH29
	 zd1nrdPnD4sbBcbyyAuoFfB+ARagNc99cnuwSFvgi6+0yRdqrnsspdJsPOJXjaq/Nb
	 IA2w+SPrUFUqz+e4WrDRBkQUSXWkBd3bgpugow/jQhPcs0dd/G2J5DsiARB5GJDGul
	 Am9MCXnV3UDcl87K75jKlV3A=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BBDE40E01CF;
	Wed, 14 May 2025 18:53:17 +0000 (UTC)
Date: Wed, 14 May 2025 20:53:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250514185316.GJaCTmnPdcK9goOFWc@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250514172130.GAaCTRGoRL3nYieIE7@fat_crate.local>
 <CAMj1kXHnt25JoTLdsPWB2C0xqzs+21PBGC_NXNhmsHdL0yLFnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnt25JoTLdsPWB2C0xqzs+21PBGC_NXNhmsHdL0yLFnQ@mail.gmail.com>

On Wed, May 14, 2025 at 06:37:14PM +0100, Ard Biesheuvel wrote:
> The rule is really that you can no longer randomly call other code
> without being forced to consider carefully what else gets pulled in,
> and whether or not that code is guaranteed to behave correctly when
> being called via the 1:1 mapping.

I like "consider carefully". Right now, the decompressor is a mess and
untangling it is a losing game.

> Basically, the first order of business when calling the kernel via the
> 1:1 mapping is to create the kernel virtual mapping in the page
> tables. It is just really unfortunate that SEV-SNP requires so much
> prep work before we can even map the kernel.
> 
> I don't anticipate that this code will grow a lot after I'm done with it.

Right, ok.

Lemme keep looking.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

