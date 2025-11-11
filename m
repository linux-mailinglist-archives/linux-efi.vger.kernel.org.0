Return-Path: <linux-efi+bounces-5475-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D6C4F7D1
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D52A3B915C
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADE2BE7DF;
	Tue, 11 Nov 2025 18:45:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32129BDB3;
	Tue, 11 Nov 2025 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886754; cv=none; b=n7vcvnnvpmGJ5Z1bWieoNWavJICA/PK93DSSlyyMCqg9ftHv+yCVIxsVMJIPhRv2EuSU7sOxZmOTBONNo7T1/V5GGx/hbRbJt3FrulHnDyWLJrBJT5QYDV78oU+TJNRS5ETEaP8oYwn/ef5pOYLSw/UP3P5Xm6TQcrmVXBS93wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886754; c=relaxed/simple;
	bh=75BL9llpxbG8PJsMo37W0Q0HO48F+Z6rpq24s/xf+/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXFwhPDiiGWG75hMAzC5prReCz7fC59OiF/dL+2K40+/QrlLQvtDdIJcA5yskR23v9GWw+5kJXuTFpSKe1u23XdWP60l2I8LJ0QbFuAcXzuNpr685O0HfLM95y6p2wmsycY1grcYOIWcUnM4bZjFVvMXIHdhWe4SwtpSd1hMX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB170C4CEFB;
	Tue, 11 Nov 2025 18:45:51 +0000 (UTC)
Date: Tue, 11 Nov 2025 18:45:49 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Sami Mujawar <Sami.Mujawar@arm.com>
Subject: Re: [PATCH v4 resend 0/7] arm64: Make EFI calls preemptible
Message-ID: <aROEXadFWdJoQEzx@arm.com>
References: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>

On Wed, Oct 15, 2025 at 10:56:35PM +0200, Ard Biesheuvel wrote:
> Ard Biesheuvel (7):
>   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
>   efi/runtime-wrappers: Keep track of the efi_runtime_lock owner
>   arm64/fpsimd: Don't warn when EFI execution context is preemptible
>   arm64/fpsimd: Permit kernel mode NEON with IRQs off
>   arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
>   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
>   arm64/efi: Call EFI runtime services without disabling preemption

The series looks fine to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

What do you plan to do with this, merge via the EFI tree? Are there any
dependencies?

-- 
Catalin

