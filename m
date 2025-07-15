Return-Path: <linux-efi+bounces-4344-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDACDB0508E
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 06:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144E14A2F14
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7A26A0EB;
	Tue, 15 Jul 2025 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LECdqNPS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE51A2398;
	Tue, 15 Jul 2025 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555512; cv=none; b=rfSbyZxXVUY9LiAeOu3jUOOQdGSAtJPvFkL+ULsSPNFGlXjgWZiBhOAuIQBPsWTgMgzPadn3TroBeIXvgREIFg0EniRfj1OZs4Cm5G3B2KfQ8C7rLwMc4xBboHN3s6KoJy30YAYcErr1xYKbSNZWlZ7h7aiNHjp9K4DGVees9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555512; c=relaxed/simple;
	bh=FHKGOBJTjZ8cy/P8/7A1PUYTFL1hiYO7R7bupkTGdOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/zzoo2VYBAUcDE5y9OBQU6lkL00YX9idiRP8NBC7RipF7iftWhHHg2cZ/P5RqH4QhcceLRcvuIP8e/nFPWF/LGVE0L12rqkxluOkLrf+GsbM8XgjLoAVq1U1hHjwy+sxCyj5uutfiD+hNyPpymjoR48Ed0Wgfmz9XZlbQdQ39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LECdqNPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC7AC4CEE3;
	Tue, 15 Jul 2025 04:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752555511;
	bh=FHKGOBJTjZ8cy/P8/7A1PUYTFL1hiYO7R7bupkTGdOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LECdqNPSRntZJBjAZem78ERpFtfSabtt0cVMPu18sV47S4IL/qkGuPGqb6jtATN1i
	 lYUnFE3KHK4O+RbXwu4VyAwxhmK0jn2QdeToYn9c8yBGR6yhe5LiWXa5bl9+JQRFZV
	 +srZkJCiCxFvASJQ/zvwjAEqloW3Edf0yL17fioggFc3iMmCrRiSms1yjwe7Cy0Dwu
	 3CAammIPpUVOJ0Ad3Y0JhxEfA1eR6rudsZUUU+Klqu8gG22xuDz3kfaZRGdmuUF/Ff
	 90ltU747m90qW+L6OfNIUdOo6xpgAd77StzD48tAPsndB7Ti1Fp9WH85oumMXY3oNl
	 VasnPmUHNEbrA==
Date: Tue, 15 Jul 2025 04:58:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3 12/16] x86_64,hyperv: Use direct call to hypercall-page
Message-ID: <aHXf9TZIAS2u5AP8@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.011387946@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714103441.011387946@infradead.org>

On Mon, Jul 14, 2025 at 12:20:23PM +0200, Peter Zijlstra wrote:
> Instead of using an indirect call to the hypercall page, use a direct
> call instead. This avoids all CFI problems, including the one where
> the hypercall page doesn't have IBT on.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

