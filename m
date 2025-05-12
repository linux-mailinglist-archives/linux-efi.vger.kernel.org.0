Return-Path: <linux-efi+bounces-3677-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D9AB44C7
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2D019E41B1
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB5297B90;
	Mon, 12 May 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ecWfwWi8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F42561BD;
	Mon, 12 May 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077478; cv=none; b=PjFS/oqqJVYFThuW+peAOJ9auBjYKDfe8LmlSQ6cO8sZ/X82TbeMY/fTV3+778SqBhhKPi3Eve1uzJJJ2B9lMnqv41xsNYIeBxaAswgV+3OOoa1o9cgUHXbuWfiz269bNaZWnN7EudjizvsgjHhRIrbHFlTTmWeaj5YknUEcT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077478; c=relaxed/simple;
	bh=gow85DnX8qkBC7BDNTGHZHQHD8EpPHE1yCYQe+JhPzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKJZ94sUBO3ZH15l2QGw3yoZtAQJqwsDOgJVBWjGu0JpvqpoTP1aBCwdXeNs/7MC/Nxi+L/pgcKRIypF5vBYIHj1ZHr8pKTQ/h1b9hm1MOXAyvNY0LXpYvQoUpC9+dgPB+t2c+5c2NppoBsrJ7uB+9huSFH+pdINBXrcVyy7jxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ecWfwWi8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F4B940E0258;
	Mon, 12 May 2025 19:17:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HPiofi35CC_E; Mon, 12 May 2025 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747077441; bh=fnrOGTlwK6DB8DonrOYNYpF4Xlpq1tNa6YtxGoahYJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecWfwWi8/xVhQmk8VfJ+vQLQ9kEaAdSuX4lLzvN0ny/w3m0DKO3J5IpFYoDgtEnRz
	 ui9JJYT1zSV6WwtETlWU51MoBq6uvrTVZI9oU9kuqKphmS616VbIzuGyASse8L5Tfp
	 tRA0LCqI60Iky46GqkTTx+GwA9Y9LX1tqiRBpToW306WhTt98lsjy9dq8c+oLHuCZg
	 AM5lfp5g549PqML/akOabuBX6BVhaLixNB2COEo+g/440y5c9QyzREvFJbTEV2+Ukh
	 kfhzSBvHw5NsFy/7S8cI081lcDng0TItFwKchTYDj3hLtNYvyouxPDtZCxv2vZ+510
	 8OgwilUYr2NidJyU3cRBo3/b9b54Fl+ST9g2qfv9GL1B/8dia/shaSc9J6mVV+UKDU
	 LRiDLyAKlMT90Xx49HHW6qrAEFuiIp64q1ZTaGe29KSu+1ft0ReZCSCMgfBm0oTEdQ
	 XHHaXnjeMiEvPAcoaXtH5yvfcdjn2p3yyIr1vaenx14LdElSkJEXTvfUIs1UHR0ZhU
	 5l0YqST7DJH98mo0ukUlK25a9SPPQEeyBFCtCSK7QHYFg25FJZydeCB8ybr+WXGd3p
	 gb4j3PhAYvPDAIKw+FZDADtNsVJVniwwrqvt2TCLznmsMilFNTyxjdyI5V3nFNbc30
	 0K34cMhIFELRtGFA0m8FZsHo=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2ECE840E01ED;
	Mon, 12 May 2025 19:17:12 +0000 (UTC)
Date: Mon, 12 May 2025 21:17:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
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
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> !!! Boot tested on non-SEV guest ONLY !!!!

...

> !!! Boot tested on non-SEV guest ONLY !!!!
> 
> Again, I will need to lean on Tom to determine whether this breaks
> SEV-SNP guest boot. As I mentioned before, I am still waiting for
> SEV-SNP capable hardware to be delivered.

Ingo, please do not rush this stuff in before Tom and I have tested it
successfully with SEV* guests.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

