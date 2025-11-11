Return-Path: <linux-efi+bounces-5478-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABEAC4FAE6
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 21:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181AF188C740
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C072BF017;
	Tue, 11 Nov 2025 20:17:07 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F911E492A;
	Tue, 11 Nov 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892227; cv=none; b=KmVQFXc2CabS4IxE68GKEAxZ2e254m/u14AWlcoyOY42BD+p+8BWxgac+Le+iD36Oqiylnuqo3gJUpf0CkO8as4zZnJGFVqnmPcNo7GP3fkeRgRZWeYd1o+hHmE5ibpHiYfOLoaDEf5LWfHfLp5ukA6zi76vYxkWx/fPOtI5u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892227; c=relaxed/simple;
	bh=/pEnMODYwJLAK/s/r3ZpdpiU+H3mO3vUFV7X/QhRFp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrmz+2auyPkHb6xIzBX7HpByj9FIBLamhUEPGpkLr6S15gC6zjBvjwKlxHUUeHqGHpaXhnopT/2cvGm1Df6Mh5bG1M7OfGaC/BN2TI6pZQyhtj4p8dO2Wuml0JgnJ5dMefc1CaFbjO5JMF8l9a6xWLW/Za45GxgD145dcg2OoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DE3C116D0;
	Tue, 11 Nov 2025 20:17:04 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Sami Mujawar <Sami.Mujawar@arm.com>
Subject: Re: [PATCH v4 resend 0/7] arm64: Make EFI calls preemptible
Date: Tue, 11 Nov 2025 20:16:57 +0000
Message-ID: <176289221699.1642210.3941806984449479719.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
References: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 22:56:35 +0200, Ard Biesheuvel wrote:
> The arm64 port permits the use of the baseline FP/SIMD register file in
> kernel mode, and no longer requires preemption to be disabled. Now that
> the EFI spec is being clarified to state that EFI runtime services may
> only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
> registers (while executing at the same privilege level as the kernel) is
> no longer a reason to disable preemption when invoking them.
> 
> [...]

Applied to arm64 (for-next/efi-preempt), thanks!

[1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
      https://git.kernel.org/arm64/c/40374d308e4e
[2/7] efi/runtime-wrappers: Keep track of the efi_runtime_lock owner
      https://git.kernel.org/arm64/c/a2860501203c
[3/7] arm64/fpsimd: Don't warn when EFI execution context is preemptible
      https://git.kernel.org/arm64/c/1d038e801833
[4/7] arm64/fpsimd: Permit kernel mode NEON with IRQs off
      https://git.kernel.org/arm64/c/7137a203b251
[5/7] arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
      https://git.kernel.org/arm64/c/1068cb52e8ef
[6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
      https://git.kernel.org/arm64/c/6b9c98e65755
[7/7] arm64/efi: Call EFI runtime services without disabling preemption
      https://git.kernel.org/arm64/c/a5baf582f4c0

-- 
Catalin


