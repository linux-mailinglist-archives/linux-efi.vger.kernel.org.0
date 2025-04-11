Return-Path: <linux-efi+bounces-3296-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7BA865EC
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD87C4405A7
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE627701A;
	Fri, 11 Apr 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QdD8jIZ+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D0202C50;
	Fri, 11 Apr 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398660; cv=none; b=abj4N8Z5YEW+KW/lIdoh2nCIrgkw4iuCOGuWdqG8OpRogg4Alp0gkVHAXwewDMYv77H9e89WYLSv7dSKYb30Xis6zifp+iYH0UMBp10to/A6kInLnQxwaBrLsKfrq8yxyMZxci9CfLeZcyBm4E8rtY3bz2GEqMK0zDyTtXIXeC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398660; c=relaxed/simple;
	bh=PQfgCeltfLfqxCgPkBUBSiI0euQ23e9EyF9ihZ858WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABWFn29pFjM8r4/5N/e9E04bOYj3+/ksObrYz4v4PU8OOmudoxImTzlTfiLFkz0e8y4tvRazi/DaCYTAm2iJvvFWkVsgeo6ZCRJtsXxq1M8TD50ARMg7bT6wl+MG32Vj6ly7rpSGlScQg5oWBB+TtOo0AJfc0FnjjIgPcHWdnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QdD8jIZ+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 425AF40E023A;
	Fri, 11 Apr 2025 19:10:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 641Kw7W2EULd; Fri, 11 Apr 2025 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744398652; bh=ly4z34N2KjiLu1eGundqdgzUw+XXcydOdDhrGGvC7CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdD8jIZ+HCquASk+1fuMRToAyQVml4Nl7vJEPAXrFwWOx7MtfoS2/aD1UNsWa3Td7
	 klomHFps5UAB+UrVV6MncHibprjZgSVWiOmQHmYZlPY4M+gSJaLP4lIJTXLa+XjYJ6
	 v3M9yIe3YbNMG+6lzz2EOH8tgjT+aL+r77iClGNowMpJECwJ1UUIvA7KaEOVhwMZoF
	 VL3AexmyBofJSXjS7Y1cvk9lHT7HYagFbsr845I6s6yuenAUQLUw3vgbrIOz0rRAWz
	 p/xtv7oD5JbEmJGWEObgGypnraUqP0iU6nvRJBsOCuYHBFOopD6TKo/PRONTTZZ0BH
	 MiocLaq10220M+wH3icLe8kAknHjo+VFMZymESgKIrZQWJ+Q49q9z+qBGOQ8dvX6YH
	 kFtV++5Su3X2q2OEQmBpTZ78Ny//eRKTgW2//Vkg6EI63LlsfjzeoG9E4cK5KNg56f
	 Kylo/PqZwgfe0ylRVzNGd0gzXJA2OK4PxFUan/ZrmYb5xUqs+EC/R9X8cdDZl/3ZOT
	 J4lHGp058+DMg1xrBgNTsMX93ql8LCWJnbmhEyCYQgkGCGN7h//W1icY/5B5G/D6B4
	 ewdRz18JxvNxl2prtge1ogjrjRueDzN4tMX70NDRdTAszm+IYb5KOMnRWQNDfcCwQj
	 id7pHLlAV5wIehifO9WzIKhc=
Received: from rn.tnic (ip-185-104-138-50.ptr.icomera.net [185.104.138.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F35FD40E0242;
	Fri, 11 Apr 2025 19:10:41 +0000 (UTC)
Date: Fri, 11 Apr 2025 21:11:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
Message-ID: <20250411191135.GCZ_lpZ-kgr88WNw8e@renoirsky.local>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>

On Fri, Apr 11, 2025 at 09:00:51PM +0200, Ard Biesheuvel wrote:
> ---%<---
> The GHCB shared page method never worked for accepting memory from the
> EFI stub, but this is rarely needed in practice: when using the higher
> level page allocation APIs, the firmware will make sure that memory is
> accepted before it is returned. The only use case for explicit memory
> acceptance by the EFI stub is when populating the 'unaccepted memory'
> bitmap, which tracks unaccepted memory at a 2MB granularity, and so
> chunks of unaccepted memory that are misaligned wrt that are accepted
> without being allocated or used.
> ---%<---
> 
> > I'm somehow missing that aspect of why that change is warranted...
> >
> 
> This never worked correctly for SEV-SNP, we're just lucky the firmware
> appears to accept memory in 2+ MB batches and so these misaligned
> chunks are rare in practice. Tom did manage to trigger it IIUC by
> giving a VM an amount of memory that is not a multiple of 2M.

Can you pls put that lenghty explanation in the commit message?

It is useful and we might go back to it in the future.

Thx.

