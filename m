Return-Path: <linux-efi+bounces-4690-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087AB43AD5
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2B3178FA1
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C42F39A6;
	Thu,  4 Sep 2025 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6mjvK+4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A31E7C08;
	Thu,  4 Sep 2025 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986933; cv=none; b=OJJuBAVqQVnHtCUb+ZAWHK++o+xOzgW6fSJ7xTiWIY4V+gYEQyGBCvRPMB3GyGMyS0pfITvwZkl/WKR940yumql119235jqPkUaOsDQo73toRobuzq26xWT5MsGw3piGXP7ob4n0RunLPASO1p0+Tx7cL/WefQ5Zm6wwkvtMUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986933; c=relaxed/simple;
	bh=L9cH6bNwYJRlk6FzxhgqsLMYSpGTEmwCEBwi3x9KT/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4dJPBCBYFAKaPVCGQe4YQf/R6l3VdLITSTeWcr8n1hUWRBXiyEvYFofZykpAZwN0dDF5TkGESSwgZw3BtLasjdOocS4KlwxGvhz4Ga/4WT5hWK0K4Gfp14VUK4/o92sOqpe0cbRVWOxdYeJtzGtkz4u6JjGk+ivPEPkDkGInuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6mjvK+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A6DC4CEF0;
	Thu,  4 Sep 2025 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756986932;
	bh=L9cH6bNwYJRlk6FzxhgqsLMYSpGTEmwCEBwi3x9KT/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6mjvK+469qhzIL3ZY7OLkZG43jt44zcrcpC0SLg+x90jVrWCN4wHiXo7MpMy7adT
	 rFtCuOtKzPv3SCl+1a8iA9VpOzMBrPDZJJ1d9Vgu/n0MZO+y/Z28JeLMsddhB0cWea
	 RleDBDLnf3OLJlwClV84wBgTsGkZkS81LNVCy38Ye4/7nOnd4gE/t0eSwIeO5ttp3B
	 H+owTOKY2NwyL6jQxgmnOxrwFpmn6Ou6pQwbhAXkR9KUmS6EjJSZ5jPtIfC8BuANMa
	 8R3iX32k2EwaEj3QR0QO5ZPrGtPX/z8LW7tiqgfBgjIhl4xmzLimlzEm30SP6ANOKo
	 kaDVgda/8+bIA==
Date: Thu, 4 Sep 2025 14:55:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/7] Cleanup free_pages() misuse
Message-ID: <aLl-Kd4nmgSEr8WV@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>

On Wed, Sep 03, 2025 at 11:59:14AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() is supposed to be called when we only have a virtual address.
> __free_pages() is supposed to be called when we have a page.
> 
> There are a number of callers that use page_address() to get a page's
> virtual address then call free_pages() on it when they should just call
> __free_pages() directly.
> 
> Add kernel-docs for free_pages() to help callers better understand which
> function they should be calling, and replace the obvious cases of
> misuse.
> 
> Vishal Moola (Oracle) (7):
>   mm/page_alloc: Add kernel-docs for free_pages()
>   aoe: Stop calling page_address() in free_page()
>   x86: Stop calling page_address() in free_pages()
>   riscv: Stop calling page_address() in free_pages()
>   powerpc: Stop calling page_address() in free_pages()
>   arm64: Stop calling page_address() in free_pages()
>   virtio_balloon: Stop calling page_address() in free_pages()

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/arm64/mm/mmu.c                      | 2 +-
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
>  arch/riscv/mm/init.c                     | 4 ++--
>  arch/x86/mm/init_64.c                    | 2 +-
>  arch/x86/platform/efi/memmap.c           | 2 +-
>  drivers/block/aoe/aoecmd.c               | 2 +-
>  drivers/virtio/virtio_balloon.c          | 8 +++-----
>  mm/page_alloc.c                          | 9 +++++++++
>  8 files changed, 19 insertions(+), 12 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

-- 
Sincerely yours,
Mike.

