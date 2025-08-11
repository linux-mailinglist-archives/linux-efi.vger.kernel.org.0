Return-Path: <linux-efi+bounces-4532-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C58B1FF72
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 08:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D590D7A85DB
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE072853E2;
	Mon, 11 Aug 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyf4/hMm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A011F5820;
	Mon, 11 Aug 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894397; cv=none; b=GIfXWBU/vl8Cg7/OiJKGRcRQp0YrA9tUulmxNOfq0Na9K8J+eoWlafPq8VvqNdq3qu58eZ4bDOTUGmtdKCDSpZkZBGdrFCtPpLsQrqYctRaHhnEdLhQ7fTR6kWGhxXdNJjuGp4MI8wslHMEbdGqPo8uHEus94gOSLgvIEwxjrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894397; c=relaxed/simple;
	bh=TuyYgNyOFUQ5s68HmKErQ2s++npfUFsEhM9wvY0n9Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knBrpBMsUe6F0bD5jfRk9sIemdKDD5WWFZmy4HH8YVM1ZPKPtOmQqf3wZ/3DL38MFKxn7vdnAk9tNfWeFcnzM2QsXhx/+1MYrGwsj9UrgqhQli1xHy1cxwT6rVYlqTp7EGGVrjWW63PyZHE/c8XtR6r9aFrsrX1Ws038Js9eQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyf4/hMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B643C4CEED;
	Mon, 11 Aug 2025 06:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754894397;
	bh=TuyYgNyOFUQ5s68HmKErQ2s++npfUFsEhM9wvY0n9Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cyf4/hMmSdOnLKJigF5NZtnZSF/Fw0RAsAGtpjWE72dB6BfPMTv+ywv4DDXv0mqpS
	 cKtUcoDboJ3Nh+c2ZobIJP56Aq2+YjuFmmUPHYzKkNBVu/S3EbdyJImdW3H4i3sFrB
	 jWI+FVy+YGxg+tKO4BZJlw6Otuw36YqvtHBkcjxOl2ZlzSWOtJD90/jPGrrFuGvXCm
	 pQyUJP/50lT3ci5oo6alyUDquv/GOGb5t3MY8lmXAejInj5nvcz/eqhZu+tLXtuQcN
	 qGuBusXcNp+7egjj9lWZoO7zGSwI4d0gbU/LTjc73kaRighiXpTlGvF0SeIZZtYDbN
	 G2cFf/pt/pURA==
Date: Mon, 11 Aug 2025 09:39:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: ardb@kernel.org, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	nh-open-source@amazon.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Support booting with kexec handover (KHO)
Message-ID: <aJmQNuQxLLtXjq2r@kernel.org>
References: <20250808163651.25279-1-epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808163651.25279-1-epetron@amazon.de>

On Fri, Aug 08, 2025 at 04:36:51PM +0000, Evangelos Petrongonas wrote:
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
> remove non-KHO ones. This preserves KHO scratch regions while still
> allowing EFI to rebuild its memory map.

It's worth mentioning that scratch areas are "good known memory" :)
 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> 
> Reproduction/Verification Steps
> The issue and the fix can be reproduced/verified by booting a VM with
> EFI and attempting to perform a KHO enabled kexec. The fix
> was developed/tested on arm64.
> 
>  drivers/firmware/efi/efi-init.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f22..2f08b1ab764f6 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -164,12 +164,35 @@ static __init void reserve_regions(void)
>  		pr_info("Processing EFI memory map:\n");
>  
>  	/*
> -	 * Discard memblocks discovered so far: if there are any at this
> -	 * point, they originate from memory nodes in the DT, and UEFI
> -	 * uses its own memory map instead.
> +	 * Discard memblocks discovered so far except for KHO scratch regions.
> +	 * Most memblocks at this point originate from memory nodes in the DT,
> +	 * and UEFI uses its own memory map instead. However, if KHO is enabled,
> +	 * scratch regions must be preserved.
>  	 */
>  	memblock_dump_all();
> -	memblock_remove(0, PHYS_ADDR_MAX);
> +
> +	if (IS_ENABLED(CONFIG_MEMBLOCK_KHO_SCRATCH)) {

It's better to condition this on kho_get_fdt() that means that we are
actually doing a handover.

> +		struct memblock_region *reg;
> +		phys_addr_t start, size;
> +		int i;
> +
> +		/* Remove all non-KHO regions */
> +		for (i = memblock.memory.cnt - 1; i >= 0; i--) {

Please use for_each_mem_region() 

> +			reg = &memblock.memory.regions[i];
> +			if (!memblock_is_kho_scratch(reg)) {
> +				start = reg->base;
> +				size = reg->size;
> +				memblock_remove(start, size);
> +			}
> +		}
> +	} else {
> +	/*
> +	 * KHO is disabled. Discard memblocks discovered so far: if there
> +	 * are any at this point, they originate from memory nodes in the
> +	 * DT, and UEFI uses its own memory map instead.
> +	 */
> +		memblock_remove(0, PHYS_ADDR_MAX);
> +	}
>  
>  	for_each_efi_memory_desc(md) {
>  		paddr = md->phys_addr;
> -- 
> 2.43.0

-- 
Sincerely yours,
Mike.

