Return-Path: <linux-efi+bounces-4875-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9383B894A9
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750EB1C847B5
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B293093C9;
	Fri, 19 Sep 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r19G0a9g"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22592E3AE6;
	Fri, 19 Sep 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281802; cv=none; b=TNlt1XQ3UsoWfUQ6qbUx2MLR9FSyOrLg3QZNakB5HSOJtfRmppSgISH3Es1tDmjON7rAChRBsSZ1LOq3q6PF5HIj+I4GwgahSHnezrYDQ8fL5BoSB51HJ+fdXpj51tWdBpcNAKKxC3bVqkOAj4nOhUyzwx9Qt3UMTi2h7IQj6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281802; c=relaxed/simple;
	bh=aiHRSi2sgT1TTHPVybbacLprkapoa6VCAYD5hiEonZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qduyY0STGQX5QiiCAIOygw5hoNSOcLmqrWb7wXe1njhe9plIoeN3seEMU0o2Axu7k92MrNMADQ0bceSMv+iH2fLt54L9XFoZHREOrjdiFHOvwLaQEzEACvnH9neHzA7yGWQjSxcgi+6Q4w1r/rSXSeE+x3hQUvp6t6OXh5WKqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r19G0a9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E50C4CEF0;
	Fri, 19 Sep 2025 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758281801;
	bh=aiHRSi2sgT1TTHPVybbacLprkapoa6VCAYD5hiEonZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r19G0a9gkhqmOXeB7G+TiC/trwpAeYCdCIZ58xHavoqn1eHY7YLc1he4hvrVa+fud
	 KHyFLc+EVAJeWx+7q6qdEH9+LNRmM+MeR6j3uZHzRFMm6SGoQg6a0J0ba0QZfuiOcY
	 kipkXakw5JR0FloaSSQPEjosJsPmkMfwE31rgfnQ2P47H/RWKB9DcLKiqv8EGxhblY
	 05XsbNqDEu2Qx5zK8CzBRBJ96vt0lkw/Ort6RR30wOCghcrYkG8haDfpgVkwY7/ctC
	 7L+K/R9pf+JsHIbnEbtDd3FaG2dNbISxHAHXt0M15TogP5pPHd6K89/zTeluLt/sNT
	 ugZ9Bo1udErqg==
Date: Fri, 19 Sep 2025 12:36:36 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 8/8] arm64/efi: Call EFI runtime services without
 disabling preemption
Message-ID: <aM1ARCYGhVvts_p7@willie-the-truck>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918103010.2973462-18-ardb+git@google.com>

On Thu, Sep 18, 2025 at 12:30:19PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The only remaining reason why EFI runtime services are invoked with
> preemption disabled is the fact that the mm is swapped out behind the
> back of the context switching code.
> 
> The kernel no longer disables preemption in kernel_neon_begin().
> Furthermore, the EFI spec is being clarified to explicitly state that
> only baseline FP/SIMD is permitted in EFI runtime service
> implementations, and so the existing kernel mode NEON context switching
> code is sufficient to preserve and restore the execution context of an
> in-progress EFI runtime service call.
> 
> Most EFI calls are made from the efi_rts_wq, which is serviced by a
> kthread. As kthreads never return to user space, they usually don't have
> an mm, and so we can use the existing infrastructure to swap in the
> efi_mm while the EFI call is in progress. This is visible to the
> scheduler, which will therefore reactivate the selected mm when
> switching out the kthread and back in again.
> 
> Given that the EFI spec explicitly permits runtime services to be called
> with interrupts enabled, firmware code is already required to tolerate
> interruptions. So rather than disable preemption, disable only migration
> so that EFI runtime services are less likely to cause scheduling delays.
> To avoid potential issues where runtime services are interrupted while
> polling the secure firmware for async completions, keep migration
> disabled so that a runtime service invocation does not resume on a
> different CPU from the one it was started on.
> 
> Note, though, that the firmware executes at the same privilege level as
> the kernel, and is therefore able to disable interrupts altogether.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi.c | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

