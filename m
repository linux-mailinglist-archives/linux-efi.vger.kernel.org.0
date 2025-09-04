Return-Path: <linux-efi+bounces-4689-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86969B43ACD
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476603A8B71
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A5E2FD7B1;
	Thu,  4 Sep 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTJP35JU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F542D5412;
	Thu,  4 Sep 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986873; cv=none; b=niYnyqqVDUsG4q7H53xnUTblqVeFn/qOsXLj4MulDHc6FnwQfZJ8LK4qh5PtdNPq05okc/xpYPZ+w8MkSfIL1leDxTmLfh4t0qdW6GQaUbhIGqef2gmKqL/+l1Dk2l1A/wsR+F4F8N4qNmUFa8VeMYACm/6ZuufHfYTdDzWwVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986873; c=relaxed/simple;
	bh=XNw4rOgmiaWNTpi2TJxzNFfkmGLCRGvr1utyFAJh0o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7zLMlWdSWdkJ4its0+KfVBbmFh4uvsMLLficlyKHTwbnq41kOemkRYTLw5em2NsuAJ646BIDL8ogdUuMDCq1zCFO8ib2Umk8Xj3pVdQR4ednspINfUx9e1rG0kbnH0z8VEuwcPhy+b0aZKKULdB3ukgSc+PCcHGsKPQBazOeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTJP35JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDABC4CEF0;
	Thu,  4 Sep 2025 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756986872;
	bh=XNw4rOgmiaWNTpi2TJxzNFfkmGLCRGvr1utyFAJh0o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTJP35JUbDeQc+Ux8kuW6NTKeHZlYtCpvd5Y8hwmpXzhYILW8ENPq6hqSReA5g5/6
	 hOGPCxSKn2qv5RUsEt5nNpjBiltFo/1MRjz68DyYzmcbGjr5igdtoLfs5ouTlPr4Ee
	 3yDV37FRzkBEVcqKKTjw4tgWqJgRTwgLMYbPrk0/OXslt07SIo25uSg/GlGwm0iAhF
	 pGn8i6YHMAWNn5ahy/gQXK67j3TEuBgFMnVlMDIkSZ2wMzzU19AdJHnrvY5CVqAFpe
	 kdWJ/VlmVVSdDdbkfxzS3KlHP63+mdVglkhuJwMdFlFFV6c6uz6NkFHArciCBPeJX8
	 R5uzN9QaWbXIw==
Date: Thu, 4 Sep 2025 14:54:24 +0300
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
Message-ID: <aLl98MQs-FlHo6bW@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-4-vishal.moola@gmail.com>
 <aLl9KneqOYTujcCh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLl9KneqOYTujcCh@kernel.org>

On Thu, Sep 04, 2025 at 02:51:14PM +0300, Mike Rapoport wrote:
> On Wed, Sep 03, 2025 at 11:59:17AM -0700, Vishal Moola (Oracle) wrote:
> > free_pages() should be used when we only have a virtual address. We
> > should call __free_pages() directly on our page instead.
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > ---
> >  arch/x86/mm/init_64.c          | 2 +-
> >  arch/x86/platform/efi/memmap.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index b9426fce5f3e..0e4270e20fad 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
> >  		free_reserved_pages(page, nr_pages);
> >  #endif
> >  	} else {
> > -		free_pages((unsigned long)page_address(page), order);
> > +		__free_pages(page, order);
> >  	}
> >  }
> >  
> > diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> > index 061b8ecc71a1..023697c88910 100644
> > --- a/arch/x86/platform/efi/memmap.c
> > +++ b/arch/x86/platform/efi/memmap.c
> > @@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> >  		struct page *p = pfn_to_page(PHYS_PFN(phys));
> >  		unsigned int order = get_order(size);
> >  
> > -		free_pages((unsigned long) page_address(p), order);
> 
> Could be just free_pages((unsigned long)phys_to_virt(phys), order), then
> the page is not needed at all.

Or even __free_pages(phys_to_page(phys), order);
 
> > +		__free_pages(p, order);
> >  	}
> >  }
> >  
> > -- 
> > 2.51.0
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Sincerely yours,
Mike.

