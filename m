Return-Path: <linux-efi+bounces-4105-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D99AF7DFD
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5054A285B
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F9255F56;
	Thu,  3 Jul 2025 16:35:53 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205022CBF1;
	Thu,  3 Jul 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560553; cv=none; b=FNceYzmzi7bNTshCzaRXAg9QksivF7aOhRc5choKZakIMyzWpXfhzT7N97I8bUBmjsKXv/p+7toXW/anABjzFYfj4+ypiznXuJhYMiQPxr4dxjdeCaGTnahMoZ+LPiu2SfHYuyh0A6MYPdTW2RlHPGnG2cAjB3sYwq9o2/qW8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560553; c=relaxed/simple;
	bh=eDxyHqr/H2pXzWjaCvMAY8ucHIFqwnhnbIY8SPE3mbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtyAaPyzDQPt+lob/giQzXTLiHDkgAJjIR5ylZTte6PHmEMrf8o8j3qrlLFppXKUfV+4MVjIKJq/ilYRthow9CwvCsbMH40XNmeQeFuOg6uateQh6FtnSJI0AfV9TobH3FxXoIMB0wNFU6KxGBd44ccEMUi91xsuQaXGxkGpU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BADC4CEE3;
	Thu,  3 Jul 2025 16:35:50 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:35:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Will Deacon <will@kernel.org>, usamaarif642@gmail.com,
	Ard Biesheuvel <ardb@kernel.org>, rmikey@meta.com,
	andreyknvl@gmail.com, kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Message-ID: <aGaxZHLnDQc_kSur@arm.com>
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>

On Tue, Jun 24, 2025 at 05:55:53AM -0700, Breno Leitao wrote:
> KASAN reports invalid accesses during arch_stack_walk() for EFI runtime
> services due to vmalloc tagging[1]. The EFI runtime stack must be allocated
> with KASAN tags reset to avoid false positives.
> 
> This patch uses arch_alloc_vmap_stack() instead of __vmalloc_node() for
> EFI stack allocation, which internally calls kasan_reset_tag()
> 
> The changes ensure EFI runtime stacks are properly sanitized for KASAN
> while maintaining functional consistency.
> 
> Link: https://lore.kernel.org/all/aFVVEgD0236LdrL6@gmail.com/ [1]
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/arm64/kernel/efi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 3857fd7ee8d46..d2af881a48290 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -15,6 +15,7 @@
>  
>  #include <asm/efi.h>
>  #include <asm/stacktrace.h>
> +#include <asm/vmap_stack.h>
>  
>  static bool region_is_misaligned(const efi_memory_desc_t *md)
>  {
> @@ -214,9 +215,11 @@ static int __init arm64_efi_rt_init(void)
>  	if (!efi_enabled(EFI_RUNTIME_SERVICES))
>  		return 0;
>  
> -	p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
> -			   NUMA_NO_NODE, &&l);
> -l:	if (!p) {
> +	if (!IS_ENABLED(CONFIG_VMAP_STACK))
> +		return -ENOMEM;

Mark Rutland pointed out in a private chat that this should probably
clear the EFI_RUNTIME_SERVICES flag as well.

> +
> +	p = arch_alloc_vmap_stack(THREAD_SIZE, NUMA_NO_NODE);
> +	if (!p) {
>  		pr_warn("Failed to allocate EFI runtime stack\n");
>  		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>  		return -ENOMEM;
> 

With that:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(but let's see if Ard has a different opinion on the approach)

