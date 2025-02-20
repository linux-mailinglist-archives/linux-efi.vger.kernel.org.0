Return-Path: <linux-efi+bounces-2806-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2AA3DA67
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 13:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8862F189E57F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E81F5420;
	Thu, 20 Feb 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rq714Wl1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577E2862BD;
	Thu, 20 Feb 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055737; cv=none; b=WILV++f2e03txe2K3Y0HFmkaxpBg+AhpZobA+4tq7SzRFKmyEH7k+cZibqVa23IUfPCHDqer34c0I6Pznv8FUCv46Ta9GASHvUL8ojxdgKFGfnjIgHfirNuI27CMZ+uQFmZLiSx1+xltG5+ACcXLWzP+K338BsbiGDjcBpeJasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055737; c=relaxed/simple;
	bh=xxdINzZfAzaXSiuNRu1KvJTQ3AsFYk/KvwybfN97h2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnM5OgKP++qufT3TmPqGI15TyQFzy6Qo2VtP2avxX8iVSx8U3xVLacRe60tTvEhD+llB3eo/KQOyv0LK20lqFNUOwScRx2NtY36LkHTp+vTM1kMP060LbEsGnqAMGhM9sP7U5lvPuP/UQagQpoG+DI/kNK/73wFBTJNr+AE48wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rq714Wl1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C14040E01AD;
	Thu, 20 Feb 2025 12:48:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AvkhVWAj6kkI; Thu, 20 Feb 2025 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740055723; bh=Q+yAMiezM9sEnhnd9V7j+SBAfK6VA0Gars4IHLAxi7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rq714Wl1t+EfUdXDT35hcLlnYVMAMyz2urh7DpBvAxwrrMjBmxxlFN3Vz6sdOupeh
	 d2kwodcwVP1OOMzW8iPvx8SMXsSzlkKylBMxOZJ0zUrQEgR4tehcHWhRs6qmdpG+Pt
	 I97lY7b1MuEczrCB1y7b91A/WVLXeKJtBZFlhbhp+sfZoqCeY8sbJzBNJ/mYyeweKX
	 /inMZ0pKyHArJ5X0wEy3eqQW5uIYt4NNmAAIFiGwFRnzfWnFj84BRNvv1vJ+MBEbc0
	 BIt+0CC3zPL3nVjuyu/xq6lD+zyVKC1zDD6MpjjA0jO6y2N/CSDySKQiKAoa0k6DXk
	 buHJelJf5tWZ+4oKrfVcCM/Mh+mDVpo9o/sO2xOfSF1tLaL5AeFdtcwszeqYpZKxMa
	 6D3YaK/i95mOpMkRbCiI1EYUlYL2ttz/jUUCtVp/7UuOCotytIvIok5qgNkLWMMrDR
	 2tHwH/kt1j1rohdCfuJGYsovCW63KSJ8RiAA2jNQ7GGCK9Cgg8jQJxscxdPP3nR9p+
	 IWgwG9JF+pdXzeFeYeV4ktJyu57qHvTe3jv7W8HsjDI5Zs3UCN4P2jiLtw0hnHM9pO
	 0qj0XpUkcEraY53aVa2fK3yyivXWxJOSkzeq9duI6rVjqcegTLnXQxCyR8ONcJb85L
	 o8oS0kk7lVk0Ul0vOnQQ2cPA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48C3E40E01A1;
	Thu, 20 Feb 2025 12:48:37 +0000 (UTC)
Date: Thu, 20 Feb 2025 13:48:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
Message-ID: <20250220124831.GFZ7cknypjWiZoZzK5@fat_crate.local>
References: <20250210174941.3251435-9-ardb+git@google.com>
 <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>

On Thu, Feb 20, 2025 at 12:29:30PM +0100, Ard Biesheuvel wrote:
> Unless anyone minds, I'd like to queue this up in the EFI tree.
> 
> Boris, Ingo?

FWIW, it looks like a nice cleanup to me and it boots in my 64-bit OVMF guest
but that doesn't mean a whole lot.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

