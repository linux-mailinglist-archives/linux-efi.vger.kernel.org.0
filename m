Return-Path: <linux-efi+bounces-5747-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC7C99039
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B303D4E1FA9
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9625C804;
	Mon,  1 Dec 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WTvztY8M"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EF258EC3;
	Mon,  1 Dec 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620740; cv=none; b=LBQruQz1RvgQUHSUUkocpksCFL39cjxGNmSCJknTTg+CAZbaeetS+OqTy3eaDp0UYz1ooetogv8hs6THv4DgO9jKLTmYeJayoN0DUxphbd27kUAw8TZwNhAWvfXZ0mpeBTnDR7MpR8pywLDttsqeEHCwUgqG11pRnJEKHJ14EZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620740; c=relaxed/simple;
	bh=pDqO7VkMyZWfg0EfVsPG3fuxxRGbpZBT+P0y7schoBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa5dnD5Po9LLEwBNemfcxFguquuBNP5UAz93Ia6yGmTvFvW4uA5cV4d/8T/OlSxc+SqypdjAJbTKM3C/I7FwC49SfqukDBJaGaqn4zBWMk3LTUKnagVnF29+rD5ua97BPt8KTtgpaAzK8v9AvL95mFPmO8WABap7a0CXDaLk2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WTvztY8M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8FA9840E022E;
	Mon,  1 Dec 2025 20:25:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SbUUuFlYM96k; Mon,  1 Dec 2025 20:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764620729; bh=f8RYmMAyCBEl5ERgqHoDL1DaBIqwkQHFzgoqQfZgPew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTvztY8Ms6/lrhMjl9vjeD/SJr7//Vy0DAOs09aBOChza0WmFgoy+nkJKSi4XRjdY
	 qyZh5CKksusOx630nwoHTYRh0lnzBeN6L2Vw9O/cGC+R4LDb5whajhhQyKG3EFOjBE
	 zwoJ3dZr4Wi8YxCXMa234jv01RqvVJO9EoReVxCRU9WXgxCwKY2uULg1aQ0xqUuFHV
	 g4SNCQSme0dUvkCa7gtDV4IF8RuBokjTcxpxWExmm6647FccF9axFB6NUhneTjef5U
	 3Id/VpTWmFU7bCnytCJuPvxvy8gkE0ZJn5EsesmquA4h+l3JY4iGh9qYZYe+FFHw6q
	 HSrwwqO5MyccIoN/74kP1s4vxCkWItfvipRgoOnmQd58ycsWVBoCHTEi+8jyToyVAC
	 fH6uPazn5plfzQYxMY31g4otfTbqI/+2aLMqAn67kTPpJhHwr7DRHi+16nIqNAnsDv
	 jtpAlZIXB2lw/gn8tu5OK5Mab9oECGWsf41Ps1pd3lER9KsBRCqsM3Uo8QSi4noPSE
	 1KXVDw3R7L7tK5btyiVqaV9czP1QpwDwrJu4ls6mOG42bqYJChOh8gw6tND3VgOP6E
	 8VCfNp80ZIxIQ0Cr+3NKYmfAuyM+VwELu2SpKvCyju19aBqMdPYUGsFVNhZ75W/OhN
	 dGKHRZ5X25iW+EjT5D/lp2f4=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 72DAB40E0253;
	Mon,  1 Dec 2025 20:25:13 +0000 (UTC)
Date: Mon, 1 Dec 2025 21:25:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, "Pratik R. Sampat" <prsampat@amd.com>,
	linux-mm@kvack.org, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	akpm@linux-foundation.org, osalvador@suse.de,
	thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <20251201202507.GFaS35o7WtLJOM0_jh@fat_crate.local>
References: <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
 <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
 <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
 <dcccdc4b-b7d7-47c4-b1b1-a6c70edb20fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcccdc4b-b7d7-47c4-b1b1-a6c70edb20fa@kernel.org>

On Mon, Dec 01, 2025 at 09:10:26PM +0100, David Hildenbrand (Red Hat) wrote:
> Just to be clear, I don't think it exist and also I don't think that it
> should exist.

By that logic if it doesn't exist and someone sends a patch, I should simply
ignore a review comment about that patch breaking some non-existent ABI and
simply take it.

Well, it certainly works for me.

Unless you folks come-a-runnin' later screaming it broke some use case of
yours. And then we're back to what I've been preaching on this thread from the
very beginning: having a common agreement on what ABI Linux enforces.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

