Return-Path: <linux-efi+bounces-4714-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F2B4FA7C
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FF51C265F3
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8B224247;
	Tue,  9 Sep 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFg7XF5C"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1860156230;
	Tue,  9 Sep 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420259; cv=none; b=i8OTzpLEpkV+sFFQA8alM5OweDrkVIZEiL0Ue9OZ3/JaRHiux0omXQJM6XE+/FwMnp3D4hb2xCIsbk1p9LS8JeIQFdgiVHxDkrxyGVLoAWEo8j43CqqJCHPXj2IhCkJdlOxRMviPYXgCV04TXDMv0wjAMIpEFZoCSXegou4GqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420259; c=relaxed/simple;
	bh=CINqC1yuoC6EN3JTqav2e34BO45tJWHN4hfmBhvxPS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YuP7a6fxOOdB72l6xKEDaRJzrT1Koh/9bZRds8RhvoZXEX3pFeHIg4sU2/PmtqrHKkRR2BYi0Y+60zfG4Nwf8tRAPxf7DvVkX3W/uXVj7/TFAL0KL0kjXCAOPFk39iIplUh4LY6bCsbXH/V7RlwhCZpTVyg/FpxS3QZG+ONQLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFg7XF5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F2BC4CEF4;
	Tue,  9 Sep 2025 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757420258;
	bh=CINqC1yuoC6EN3JTqav2e34BO45tJWHN4hfmBhvxPS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IFg7XF5CNMe84ZyievChiP1ILlqSCeMTZctwDIz45qv4ppTlVwgySeVsyMhey4TIZ
	 HPJB087o01tclncA+qQFNTwJ+5slt7Neo2Ybi2YKxfpNMdUjskKBEt70norm4UjrH8
	 6xmeU6/C2nzTUxrOhKxG3ByoMFqgvx952HpSIbGXXfTmFgJso6E0a1/lVzLCYMWtTI
	 ME4x1Cd0o187Z3d/Zf38O/NHoGJcQdNd/hyaop6xvqBnIM9TF9AK/XGFJ4kMoWPo/h
	 J2N8U1CU5gqWbDwUKKQ/p8B40uXxaPCKMaK1kHMk7QJ/CmfhaVq1oq2tTWLKRBm3hw
	 9A3L+M93ZW1dA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  <kexec@lists.infradead.org>,  <linux-mm@kvack.org>,
  <linux-efi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <nh-open-source@amazon.com>
Subject: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
In-Reply-To: <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
	<b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
Date: Tue, 09 Sep 2025 14:17:35 +0200
Message-ID: <mafs0segvlt0g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 21 2025, Evangelos Petrongonas wrote:

> When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> early during device tree scanning. After kexec, the new kernel
> exclusively uses this region for memory allocations during boot up to
> the initialization of the page allocator
>
> However, when booting with EFI, EFI's reserve_regions() uses
> memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> rebuilding them from EFI data. This destroys KHO scratch regions and
> their flags, thus causing a kernel panic, as there are no scratch
> memory regions.
>
> Instead of wholesale removal, iterate through memory regions and only
> remove non-KHO ones. This preserves KHO scratch regions, which are
> good known memory, while still allowing EFI to rebuild its memory map.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> Changes in v3:
> 	- Improve the code comments, by stating that the scratch regions are
> 	good known memory
>
> Changes in v2:
> 	- Replace the for loop with for_each_mem_region
> 	- Fix comment indentation
> 	- Amend commit message to specify that scratch regions
> 	are known good regions
>
>  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..a65c2d5b9e7b 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -12,6 +12,7 @@
>  #include <linux/efi.h>
>  #include <linux/fwnode.h>
>  #include <linux/init.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> @@ -164,12 +165,32 @@ static __init void reserve_regions(void)
>  		pr_info("Processing EFI memory map:\n");
>  
>  	/*
> -	 * Discard memblocks discovered so far: if there are any at this
> -	 * point, they originate from memory nodes in the DT, and UEFI
> -	 * uses its own memory map instead.
> +	 * Discard memblocks discovered so far except for KHO scratch
> +	 * regions. Most memblocks at this point originate from memory nodes
> +	 * in the DT and UEFI uses its own memory map instead. However, if
> +	 * KHO is enabled, scratch regions, which are good known memory
> +	 * must be preserved.
>  	 */
>  	memblock_dump_all();
> -	memblock_remove(0, PHYS_ADDR_MAX);
> +
> +	if (is_kho_boot()) {
> +		struct memblock_region *r;
> +
> +		/* Remove all non-KHO regions */
> +		for_each_mem_region(r) {
> +			if (!memblock_is_kho_scratch(r)) {
> +				memblock_remove(r->base, r->size);
> +				r--;

Hmm, this caught me off-guard. I had to do a double take to realize that
memblock_remove() would decrease memblock.memory.cnt and move the whole
regions array back. A comment would have been nice here.

But then, I wouldn't want you to do a full resend of the series for this
minor nitpick. So perhaps whoever is taking this patch can add one when
applying? Either way is fine though...

Acked-by: Pratyush Yadav <pratyush@kernel.org>

> +			}
> +		}
> +	} else {
> +		/*
> +		 * KHO is disabled. Discard memblocks discovered so far:
> +		 * if there are any at this point, they originate from memory
> +		 * nodes in the DT, and UEFI uses its own memory map instead.
> +		 */
> +		memblock_remove(0, PHYS_ADDR_MAX);
> +	}
>  
>  	for_each_efi_memory_desc(md) {
>  		paddr = md->phys_addr;

-- 
Regards,
Pratyush Yadav

