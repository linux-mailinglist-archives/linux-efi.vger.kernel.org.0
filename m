Return-Path: <linux-efi+bounces-4175-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A680AFB9D8
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BE3424D0F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F0293C48;
	Mon,  7 Jul 2025 17:26:04 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81422127A;
	Mon,  7 Jul 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909164; cv=none; b=Pw6t/1wXNSRawxon+sxlZHL9b/y+1w3M+v/I7LkTIy4q01XYSBOiJj2lfv2Raoph2kEbkZJ2dgqxTaBa2ZI0TvIzSfwteNzNppsEwYDhkx65hLAqlEW35fJs3BWJUA5x7ujL+YdslM8DfqBaS9n63lulTi/HuLY0Ru9CoLXdc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909164; c=relaxed/simple;
	bh=uTGGSkDiwNf2+d48FdgJ5vLX6nsin8g7naCfFupDseE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G67hDd81VSkMIIzGtOYNXBA9SsX73V5UlKKgsLWSEfCLtTne8qlVQ9ISO5Vewvg5HBZZZ/OfwR5WdruItMNJRXqsuS8ozX6pS3GtPeDQAKAz8k2KTI4qBRb3qfx5xDvwiXknLC3+G/2F7PRlun1tYcP5Vo/PFI/NGXNjqiW3Yo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A7C168F;
	Mon,  7 Jul 2025 10:25:49 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652A03F66E;
	Mon,  7 Jul 2025 10:26:00 -0700 (PDT)
Date: Mon, 7 Jul 2025 18:25:57 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, leo.yan@arm.com, kernel-team@meta.com
Subject: Re: [PATCH 0/8] arm64: set VMAP_STACK by default
Message-ID: <aGwDJXTGAdV_VqY2@J2N7QTR9R3>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>

On Mon, Jul 07, 2025 at 09:01:00AM -0700, Breno Leitao wrote:
> Hi all,
> 
> This patchset select VMAP_STACK on arm64 by default, and cleans up the
> code by removing all associated CONFIG_VMAP_STACK conditionals.
> 
> This is a suggestion from Will Deacon from another discussion[1].
> 
> With VMAP_STACK now always enabled on arm64, the code can be
> significantly simplified, reducing complexity and potential for
> misconfiguration.
> 
> Overview of Changes
> 
>     * Remove all #ifdef CONFIG_VMAP_STACK and related runtime checks
>       throughout the architecture codebase.
>     * Replace runtime checks with build-time assertions where
>       appropriate.
> 
> Link: https://lore.kernel.org/all/aGfYL8eXjTA9puQr@willie-the-truck/ [1]
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Nice!

Aside from a minor comment on the first patch, this all looks good to
me. For the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Breno Leitao (8):
>       arm64: Enable VMAP_STACK support
>       arm64: efi: Remove CONFIG_VMAP_STACK check
>       arm64: Remove CONFIG_VMAP_STACK conditionals from THREAD_SHIFT and THREAD_ALIGN
>       arm64: remove CONFIG_VMAP_STACK conditionals from irq stack setup
>       arm64: remove CONFIG_VMAP_STACK conditionals from traps overflow stack
>       arm64: remove CONFIG_VMAP_STACK checks from stacktrace overflow logic
>       arm64: remove CONFIG_VMAP_STACK checks from SDEI stack handling
>       arm64: remove CONFIG_VMAP_STACK checks from entry code
> 
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/memory.h     |  6 +-----
>  arch/arm64/include/asm/stacktrace.h |  6 +-----
>  arch/arm64/kernel/efi.c             |  5 -----
>  arch/arm64/kernel/entry-common.c    |  2 --
>  arch/arm64/kernel/entry.S           |  6 ------
>  arch/arm64/kernel/irq.c             | 13 -------------
>  arch/arm64/kernel/sdei.c            |  8 ++------
>  arch/arm64/kernel/stacktrace.c      |  4 +---
>  arch/arm64/kernel/traps.c           |  3 ---
>  10 files changed, 6 insertions(+), 48 deletions(-)
> ---
> base-commit: 9dd1757493416310a5e71146a08bc228869f8dae
> change-id: 20250707-arm64_vmap-fa70ba3c9cfb
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 

