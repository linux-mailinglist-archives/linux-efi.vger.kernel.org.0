Return-Path: <linux-efi+bounces-4287-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF825B01E1B
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CFD168106
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5D2D46C4;
	Fri, 11 Jul 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9+YTxJ0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5854A24;
	Fri, 11 Jul 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241504; cv=none; b=sipPDbuC2KXbTdJ3CAe4ocezKmHw26CiSmII91z6xhPjeErgdtcaVSooIPDfQLNsitFiwvpt/YwuzeiQD5VrILNP/3Z1H30RqaEsMarkwRDSWiv5UGwdTgEBwzIqTyiJv8FpGeuEu1GddL4kRQQYA+88J4yqSoqQa3LjysYJLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241504; c=relaxed/simple;
	bh=f3rQynSOZUFNU+NuqbfPpRtj0evYLsR/NIIH6sWBbgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArGJ3ZoRr7u3qwxN8xSkPFbVp/D5mpe7t5bzPLYCHjr1HpttRLEX71QRy1cjI7ZHhXRLUHsZQc1cefhRS2zPvQEygT/I7/PfH4DOjjeZq+zUj9gXWwIvBsUAoB6f/koDK82rHqviYbHwRe60GYfwuD5cQAcWQIahs5UMoTqKWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9+YTxJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DBAC4CEED;
	Fri, 11 Jul 2025 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241503;
	bh=f3rQynSOZUFNU+NuqbfPpRtj0evYLsR/NIIH6sWBbgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9+YTxJ0nh8uwNC6GfWTky0LFWXlJ7YGo4Qj+iur4hP29L9AX1sFUobfUynxxNJr9
	 4NP4lpWB8lic8on6GHkoXvkjbIXnu55ompKxO/dekRVwARa6RTZLu5GA+BKSAXe6KP
	 a6v2BUfIZIa6A/k4Fdd0iGUSnyCyUe981csB8LtGzpO0mxtRjd90F/F88v2NWFPjJD
	 99Pbc0jWgsjZMg3lASe+do4/pEv8HibrfkCSCuEqW+HcimS1o0xSAgBGE91jqW7Gcy
	 CjCoWltugp/Ts0NksjqKWIOHPN7KF1035HYdnvA0B1QBWn51p4g7/BXwZWmv1HUfog
	 HaipDb0yXeWDg==
Date: Fri, 11 Jul 2025 14:44:58 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/7] arm64: Make EFI calls preemptible
Message-ID: <aHEVWjyr7fxA3v93@willie-the-truck>
References: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>

Hey Ard,

On Wed, May 14, 2025 at 07:43:40PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The arm64 port permits the use of the baseline FP/SIMD register file in
> kernel mode, and no longer requires preemption to be disabled. Now that
> the EFI spec is being clarified to state that EFI runtime services may
> only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
> registers (while executing at the same privilege level as the kernel) is
> no longer a reason to disable preemption when invoking them.
> 
> This means that the only remaining reason for disabling preemption is
> the fact that the active mm is swapped out and replaced with efi_mm in a
> way that is hidden from the scheduler, and so scheduling is not
> supported currently. However, given that virtually all (*) EFI runtime
> calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
> loaded into the workqueue worker kthread while the call is in progress,
> and this does not require preemption to be disabled.
> 
> Note that this is only a partial solution in terms of RT guarantees,
> given that the runtime services execute at the same privilege level as
> the kernel, and can therefore disable interrupts (and therefore
> preemption) directly. But it should prevent scheduling latency spikes
> for EFI calls that simply take a long time to run to completion.
> 
> (*) only efi_reset_system() and EFI pstore invoke EFI runtime services
>     without going through the workqueue, and the latter only when saving
>     a kernel oops log to the EFI varstore
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> Ard Biesheuvel (7):
>   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
>   efi/runtime: Return success/failure from arch_efi_call_virt_setup()
>   efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
>   arm64/fpsimd: Don't warn when EFI execution context is preemptible
>   arm64/efi: Use a semaphore to protect the EFI stack and FP/SIMD state
>   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
>   arm64/efi: Call EFI runtime services without disabling preemption

I quite like the idea of this from the arm64 side (modulo a small comment
I've left on one of the later patches), however it would be great to hear
from one of the -rt folk to confirm that this actually solves a problem
for them.

Will

