Return-Path: <linux-efi+bounces-4688-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3AB43ABB
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EB1B20D8F
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB42F49E7;
	Thu,  4 Sep 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONZrZBBC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831A2BDC09;
	Thu,  4 Sep 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986675; cv=none; b=jq3w04Aat1HULlVuITqe44spg7jaQArPqqZ3y1SuncNT3TkJW8O6NLxl2oIVxRF8iPVCQv2JYWp+05p6rpi9j4LGzJRHlIxKdV/sLJIxqmds65TPh0ZwOYiMqM4LUUwa8R1OvlcgYB+Uu/u9wHpy2gxjhcdCgY4LUWN2iIuswBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986675; c=relaxed/simple;
	bh=ayu+VFEFtlDXiKEZkYUc99UQyXAFV18iajSKbdBa3uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM5uto/DcFdlhDIIBl9D3bzdwS0wqMz713JJ/18u3tpM/O1MCl8kAmjsu5YY3RRzjTvUhL9arz3xsbkTFxJ8yfo47fDhBUZUvIiATcMhMdTmsLcOWo5LUtqM9ODXtBJ4Cr+Q27eI9IeXLVW6FqOApDgYERIMkRzwYaWYFwv6gkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONZrZBBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620D2C4CEF0;
	Thu,  4 Sep 2025 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756986674;
	bh=ayu+VFEFtlDXiKEZkYUc99UQyXAFV18iajSKbdBa3uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONZrZBBCpuGwxh7arUAFmUebG80sJLxBC4MYYjuLVToYlzCW6RgNeQ07liMrV5F0N
	 s/GiABu8diRs9Wt/8jy4v4GdTRk7UaVeB2bU3bZzobOKQryEy6GqMFzq3t2S1nPhmy
	 MYYXXmjZa+R/jKyVAYEHCunJx2vEG8gVEeWMRqTlPy2r3VPODqu98SYt3INH8q6udv
	 shoDQchLJ25xZPDhxEmUrOQCrsuE8Ft+HRhKOkDAURhrzQw8cQ9kMaWmoI2beur7nq
	 TLvA7seUnmO3BltYWiXoiXISFP+iXNO3ejHGJ8SKbLXn7BVURmvpmM9/uaf0fTxflh
	 /lCPuv3tqRbcA==
Date: Thu, 4 Sep 2025 14:51:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/7] x86: Stop calling page_address() in free_pages()
Message-ID: <aLl9KneqOYTujcCh@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903185921.1785167-4-vishal.moola@gmail.com>

On Wed, Sep 03, 2025 at 11:59:17AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/mm/init_64.c          | 2 +-
>  arch/x86/platform/efi/memmap.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b9426fce5f3e..0e4270e20fad 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>  		free_reserved_pages(page, nr_pages);
>  #endif
>  	} else {
> -		free_pages((unsigned long)page_address(page), order);
> +		__free_pages(page, order);
>  	}
>  }
>  
> diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> index 061b8ecc71a1..023697c88910 100644
> --- a/arch/x86/platform/efi/memmap.c
> +++ b/arch/x86/platform/efi/memmap.c
> @@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
>  		struct page *p = pfn_to_page(PHYS_PFN(phys));
>  		unsigned int order = get_order(size);
>  
> -		free_pages((unsigned long) page_address(p), order);

Could be just free_pages((unsigned long)phys_to_virt(phys), order), then
the page is not needed at all.

> +		__free_pages(p, order);
>  	}
>  }
>  
> -- 
> 2.51.0
> 
> 

-- 
Sincerely yours,
Mike.

