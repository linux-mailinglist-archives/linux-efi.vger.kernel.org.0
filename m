Return-Path: <linux-efi+bounces-4174-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167AAFB9C6
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00EB16E9F1
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F94F253B58;
	Mon,  7 Jul 2025 17:23:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486E2135CE;
	Mon,  7 Jul 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908996; cv=none; b=qNOZ5ZshUG2i3H835ZScpqZGkUc4AtxPUlCA7zbxlnwgwo1EEHEF6RaA82ooRbE0EJ4fGXTbMB/6UQRg9MpjeVIZPQpOiOBuzm3KJZ1tHt+sYRUnG9nEday1jLYyvLa7yvLOiGUuR+HvddhPUaRNJxYe33WddjgLfrcHu7s1Z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908996; c=relaxed/simple;
	bh=E/9hSv66ZXozxelMepIkbHWHsUtfG8SG8eHQKp9a5CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtje91tFAz6auxAvYtrofSTLvL6/gEsgyq+z3DXYyEDG9p+WtQ1103ma5K3EzkEk8pa+wYHdNRENaq5pvOrnQxOUtD6MDMZRj9a5tlMTv4kCE6c6btBNa6G9XGHS1u+IhUUZM5ZP7OV6Birci8+2XD57HE0g2zAllLKAEfmvFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F9A168F;
	Mon,  7 Jul 2025 10:23:02 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950673F66E;
	Mon,  7 Jul 2025 10:23:12 -0700 (PDT)
Date: Mon, 7 Jul 2025 18:23:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, leo.yan@arm.com, kernel-team@meta.com
Subject: Re: [PATCH 1/8] arm64: Enable VMAP_STACK support
Message-ID: <aGwCfRkYqcYBvxZK@J2N7QTR9R3>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
 <20250707-arm64_vmap-v1-1-8de98ca0f91c@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-arm64_vmap-v1-1-8de98ca0f91c@debian.org>

Hi Breno,

On Mon, Jul 07, 2025 at 09:01:01AM -0700, Breno Leitao wrote:
> Enable virtually mapped kernel stacks for ARM64. This provides better
> stack overflow detection and improved security by mapping kernel stacks
> in vmalloc space rather than using direct mapping.
> 
> VMAP_STACK helps catch stack overflows early by placing guard pages
> around kernel stacks, and also provides better isolation between
> kernel stacks and other kernel data structures.
> 
> All dependencies are satisfied for arm64: HAVE_ARCH_VMAP_STACK is
> already selected above, and KASAN_VMALLOC is selected when KASAN is
> enabled, meeting the KASAN dependency requirements.

I reckon it might be better to say something like:

| arm64: Mandate VMAP_STACK
|
| On arm64, VMAP_STACK has been enabled by default for a while now, and
| the only reason to disable it was a historical lack of support for
| KASAN_VMALLOC. Today there's no good reason to disable VMAP_STACK.
|
| Mandate VMAP_STACK, which will allow code to be simplified in
| subsequent patches.

... to make it clear that we're not changing the default, and we are
removing the ability to deselect VMAP_STACK.

Either way, the patch itself looks good to me.

Mark.

> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 393d71124f5d..179b302f43c2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -280,6 +280,7 @@ config ARM64
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	select USER_STACKTRACE_SUPPORT
>  	select VDSO_GETRANDOM
> +	select VMAP_STACK
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> 
> -- 
> 2.47.1
> 

