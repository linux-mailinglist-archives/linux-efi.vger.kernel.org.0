Return-Path: <linux-efi+bounces-4193-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBBAFCE11
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB0567437
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E42E0916;
	Tue,  8 Jul 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9rx2/5t"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266F2DF3DA;
	Tue,  8 Jul 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985872; cv=none; b=mOdCTtZprVOuHCUk3g0KHDDZ/hC6G59A6Kpln6RoZcHr1kZCr8ig6Oobp7EsjUR8ikGF5LiBsXta+suCBit3s9mnBNxThKazsoVcUcq165ccIyPEMxv5/ZDcGqrMJobAqeYsflroOOlNKYtB+c1MZ4+0s6ypmAd9iqodjf3X6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985872; c=relaxed/simple;
	bh=xUN611eNoj7nUPC/lCktog0OhbWYrAFXP31VIxYfj+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT3cAonb78eWYeGqkZOGNPC2IKNt6FWsK22MpOytHPeZWKrZjnC+ofz4UJRXJyeW8RvGwRet9KBZhFQqdKwjERaskekit/94QHXMP7efvCU2b6w7/E2mXhJObiPe1DQZNUpFAN4IUuvIcZ8kYX/7y+VqSjmWzbeGoNpk4P648dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9rx2/5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6353C4CEF7;
	Tue,  8 Jul 2025 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985871;
	bh=xUN611eNoj7nUPC/lCktog0OhbWYrAFXP31VIxYfj+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9rx2/5teGXaMGn3tbGYbR7Q9FFiSHKatXEcnbsAgIchsDVRPKctSuLzrJYClyuBS
	 fJjKJmbFUTyjnF5Mdrq1999Zh0dINJxlJJX2o4/I9rwCpJexsNzbcByahGeC6KniKO
	 NS2ilc8AngakhAiJUWYcFBJmykJtqMzib3sURROdiLNjfHHIkph+JHSTdKv6HKRFmt
	 3Lem5Pkjr6QxsauOp340+Fv66nmLkgfhueFqmznIKYB4gQ3NLcC4L+tsWrHuynvOce
	 S3vwx30UmEzSDuOgTHxRZm4AGzPL30+T72m+ymcNfqr/IiAV1YL8j9xP3XwEuiTTI1
	 hMzzKOqNFeX/g==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Breno Leitao <leitao@debian.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	leo.yan@arm.com,
	kernel-team@meta.com,
	mark.rutland@arm.com
Subject: Re: [PATCH 0/8] arm64: set VMAP_STACK by default
Date: Tue,  8 Jul 2025 15:44:21 +0100
Message-Id: <175197847112.1372868.7723953963847724709.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Jul 2025 09:01:00 -0700, Breno Leitao wrote:
> This patchset select VMAP_STACK on arm64 by default, and cleans up the
> code by removing all associated CONFIG_VMAP_STACK conditionals.
> 
> This is a suggestion from Will Deacon from another discussion[1].
> 
> With VMAP_STACK now always enabled on arm64, the code can be
> significantly simplified, reducing complexity and potential for
> misconfiguration.
> 
> [...]

Applied to arm64 (for-next/vmap-stack), thanks!

[1/8] arm64: Enable VMAP_STACK support
      https://git.kernel.org/arm64/c/ef6861b8e6dd
[2/8] arm64: efi: Remove CONFIG_VMAP_STACK check
      https://git.kernel.org/arm64/c/63829521a8e8
[3/8] arm64: Remove CONFIG_VMAP_STACK conditionals from THREAD_SHIFT and THREAD_ALIGN
      https://git.kernel.org/arm64/c/0909c719c17b
[4/8] arm64: remove CONFIG_VMAP_STACK conditionals from irq stack setup
      https://git.kernel.org/arm64/c/c4a5699d5cef
[5/8] arm64: remove CONFIG_VMAP_STACK conditionals from traps overflow stack
      https://git.kernel.org/arm64/c/e5692bba1e66
[6/8] arm64: remove CONFIG_VMAP_STACK checks from stacktrace overflow logic
      https://git.kernel.org/arm64/c/907cb5cd8efd
[7/8] arm64: remove CONFIG_VMAP_STACK checks from SDEI stack handling
      https://git.kernel.org/arm64/c/3e72b9e9f01a
[8/8] arm64: remove CONFIG_VMAP_STACK checks from entry code
      https://git.kernel.org/arm64/c/9d1869f0f537

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

