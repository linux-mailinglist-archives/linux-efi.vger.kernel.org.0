Return-Path: <linux-efi+bounces-5477-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A511C4F865
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6230C189866C
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D82D6621;
	Tue, 11 Nov 2025 18:59:58 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6A2D63EF;
	Tue, 11 Nov 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887598; cv=none; b=KusHrpKi7Z3jQDyDb6CWSGZu+9j3bpzjg463Ao8K4DgogQnyMGhpyPs+Vf81k566YHmii0KUuB1R9zPQ/TzcA7N21JBxPhWklsWzEQqGDHwU8oSFzB8S7CU9zbWPMHMDK/o2WABlWae24eRDpLBmMiJU/s6VLoPLo7fdWAFuXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887598; c=relaxed/simple;
	bh=RM0X21HNpS9jnQBGcL9zW14IKiqylzRbIBhUof0T9ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSRWwYZ4v0C8opr8Jrp8EM8SM2wEuyiDLRL/MUrk97gP/46jK5CqfPEAu7uWJZu69KA43xE44tcbHGEPnzmd+2nWeJW90aUxqIwaDmJgZl1YAlF2cYSSUq/2+wSSCU/KBWanIsGXZP1NKpSjL7JJ7d7gNO0veU2vL9yCIg/w320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8BC19422;
	Tue, 11 Nov 2025 18:59:55 +0000 (UTC)
Date: Tue, 11 Nov 2025 18:59:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Sami Mujawar <Sami.Mujawar@arm.com>
Subject: Re: [PATCH v4 resend 0/7] arm64: Make EFI calls preemptible
Message-ID: <aROHqYH_apXByNn0@arm.com>
References: <20251015205634.3820870-9-ardb+git@google.com>
 <aROEXadFWdJoQEzx@arm.com>
 <CAMj1kXGYGSrhUbJ8jboSbch6tp00zfpnGdfJEQcbq=RmLFy5CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGYGSrhUbJ8jboSbch6tp00zfpnGdfJEQcbq=RmLFy5CA@mail.gmail.com>

On Tue, Nov 11, 2025 at 07:50:49PM +0100, Ard Biesheuvel wrote:
> On Tue, 11 Nov 2025 at 19:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 10:56:35PM +0200, Ard Biesheuvel wrote:
> > > Ard Biesheuvel (7):
> > >   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
> > >   efi/runtime-wrappers: Keep track of the efi_runtime_lock owner
> > >   arm64/fpsimd: Don't warn when EFI execution context is preemptible
> > >   arm64/fpsimd: Permit kernel mode NEON with IRQs off
> > >   arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
> > >   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
> > >   arm64/efi: Call EFI runtime services without disabling preemption
> >
> > The series looks fine to me:
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > What do you plan to do with this, merge via the EFI tree? Are there any
> > dependencies?
> 
> As you prefer - I can take it via the EFI tree, or you can take it.
> There are no conflicts with the other kernel mode FP/SIMD related
> changes that we are taking via libcrypto, and there are no other
> dependencies that I am aware of.

OK, I'll queue them via arm64 shortly.

-- 
Catalin

