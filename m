Return-Path: <linux-efi+bounces-5847-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16DCBF67D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 19:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B3F30334C3
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB730F55F;
	Mon, 15 Dec 2025 18:16:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071181F03D9
	for <linux-efi@vger.kernel.org>; Mon, 15 Dec 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822605; cv=none; b=rkGm+ZS/GTcndTQIjqpcnWgEgcYYel8eFMrLUAGDAN7FUIzP4HYZ8pZJnVDnUqlb7tt6BijBdfl5jMugPsVqyNPlHpzfc+8CYMKqM1Xj6Wugg1CuwcoYP+XDsS4EtWNNFhjzfwCSo3j0mfmSHcXXL13NB7vBD4BPGKXSILSITLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822605; c=relaxed/simple;
	bh=TsI9+joHAJBlKBmkhsvvJJdEMUsSrzsp7naQqzOKN2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srQk+0IpMVwmLnjNyXXsLQKSbNrlJEAtvWFfsoLlO3NmFT2F77rlQNCAWmpy5R3ejbj3R1gCVtWB17EYlCHhuR/nglR8p0ArJLDo/cC8l0Um9rZEErF0ej1F9noUlg/UM6tKJHOfzQOm73tLd273POtYLuNY+a96ybGl3exYGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00424FEC;
	Mon, 15 Dec 2025 10:16:35 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7CC13F694;
	Mon, 15 Dec 2025 10:16:40 -0800 (PST)
Date: Mon, 15 Dec 2025 18:16:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 0/2] efi/arm64: Simplify SVE/SME state preserve/restore
Message-ID: <176582226393.1756467.4367015850424872029.b4-ty@arm.com>
References: <20251206190114.892262-4-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206190114.892262-4-ardb@kernel.org>

On Sat, 06 Dec 2025 20:01:15 +0100, Ard Biesheuvel wrote:
> The EFI specific SVE/SME state preserve/restore logic is unneeded, and
> can be removed. Patch #1 adds some lkdtm test cases to emulate the
> condition under which this code might be called.
> 
> v2:
> - Document that BUG_IN_HARDIRQ and PANIC_IN_HARDIRQ will crash the
>   system.
> - Add Kees's R-b
> - Rebase onto torvalds's tree of today so it is expected to apply
>   cleanly to -rc1
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

(not really a fix but postponed applying it for -rc1 due to conflicts)

[1/2] lkdtm/bugs: Add cases for BUG and PANIC occurring in hardirq context
      https://git.kernel.org/arm64/c/eb972eab0794
[2/2] arm64/efi: Remove unneeded SVE/SME fallback preserve/store handling
      https://git.kernel.org/arm64/c/63de2b3859ba

-- 
Catalin

