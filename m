Return-Path: <linux-efi+bounces-4705-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A09B461A2
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107EBA6449A
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9337C0E1;
	Fri,  5 Sep 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loP7ejro"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAA37C0F7;
	Fri,  5 Sep 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095361; cv=none; b=Js070gH2gvh7Lk8kWvkW1LqBAbgoTcP/wRltEFzgm6QNZFKS2lL/Y4WYHjzcM9uuwz6a/RQr3l9aoPaHgw4zCpUGq5HaSP0ME5kbkDhoyQmIkzUYIVvlxCsWnL3rb6HWbo6dbUNszuoYMpCeyggyRqKsgJUyd1x405caoNO7U98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095361; c=relaxed/simple;
	bh=Qb+QuJSkObqX+fj1w4dRqT/e/kifWjnwMbO8oipHUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3LOt5YXVnXqxA4lDMt1BPReH5E+uNSHnojnfc3gPPF2Xbv2wy+O9FHuKqEk7DFH0woBA+kFzYc5eK0/c9C8+xSYZeHzPAhNAAv2NsBEsNXS1Naw6kS40U0ya8z9TXr/6PihyuiD57IBWuuxsj3Kix4uh2Z8i9XrDhrEMPDClZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loP7ejro; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso1945058a12.0;
        Fri, 05 Sep 2025 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095360; x=1757700160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyvqbUDXebspKl35FIPJk0lFngkuMldmVpFc1O8R/zI=;
        b=loP7ejro2ueaShJvpKXm7Kqz428oRmCHruexot5tWdCmqCjAXd/J3eC2oa/j31g7oe
         Y2dDia/VdYEQI5d/rD5pPCB6jOAmErY/Fs0MILF0u5lQkShCgf+xD0p+dhWhPBff6p+c
         nXWRDWJknQRO7JgOhMfrLYCu1gS1WoOs3aZXrEdeyrHbGzntuXQlPoIVIlGxVnEIZQU3
         vlW62c/B76rG4YbbmvbO6LV8nPbz/mi5nJppHFMA8euOEWiylcq/FJua4nACqg7yahGc
         duKn/GdBB22467PJfx++oFM/l97UdjBwc/vF7ZE9i5OHgjX7ru0R57cv5bavjENEdyTt
         6KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095360; x=1757700160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyvqbUDXebspKl35FIPJk0lFngkuMldmVpFc1O8R/zI=;
        b=XjGKs7a4G/DNpuVyXgCu4lmgkhoqmAkKrwOV2PO5pF8XbMfowvRsMqJ7qa4SEp/lTG
         E7y/kL73DSvnF1/NGDu4YWfyXqZBibNgmF85F9sQantUe+SJ4k2p/bk6RHq2a5YdrVpN
         LJpEo09Ad4XrcP1/bBjAcvmO90SLsFE9S2d0J1auaRoljxGud2W/F74UhZvIFPt0RtDM
         HY8C9Blztj32aw2M+9jyQhQRKkD9oF8aYb6A/1j1lQvGszilxJdWxbtrJ986HEKcqahI
         AeSPGjO/zARr5UeY0o+d8AHOWcXD8gc2EZjlv0WF4JYPf1A7NVOVUkqL3k/ncaUORk5W
         2MkA==
X-Forwarded-Encrypted: i=1; AJvYcCUgrxiS4HuDVuZt4MTrXbts4rm87GsFtA4Hha1PLSsqrMd74B1FZ0YTfRDWXMVvYQwCnCeYF0uiudGAFQ==@vger.kernel.org, AJvYcCVOYzEjPgNV1Cvug8bYOsY8i4iIihAJ6gylqPPzpi1ly2yt0PE5eo5xSXq0uxYT6LpTnYLu3kqhz3aQ@vger.kernel.org, AJvYcCX6PA8eETTxMvE3039wxezpdLjxzIX9aeJQDpa5TQo7VIeKs96sgPhWXP4dJvsezQsiaH21E5aE7W6XNWcj@vger.kernel.org
X-Gm-Message-State: AOJu0YwClwg22I8uhweB89VTr6SqvD1W4BNye42MZ/FDa+OGfw7tJDbG
	PylLh/4aofCGyFvz1IbKhqXkbXFr+OcKZb7yn9U1RMvCHaiDbWdCpWSJ
X-Gm-Gg: ASbGncsu9wUIKF416vopkyguoQZDI5D2JAJGWFnyE2yAl7IgUoUTjrlhUDOl6rhKTr6
	yqxTFwvUruKFm/feJBiJm03TLq9qVzLCH5AeIGS+qDvnry1e5RnNxZnDW1NsHvViEwkYWkXcpMS
	PHEhZe2Xhvpl6NW7OKUlXiN+FoidDX5P87wKTKH6KuM08RNAunRA3OA+E4M8q9jlBH8Gx2ovPZd
	NV2PPvOXrCMcI0hZhoBdIdhs2UVtFjH8A0L9I6B/OLA9etHBiG8qeoeosXROKyfCuVHHiOEIP9W
	aCty6LxVW7n+qTK+ehGQ5RnrxiCKE6abowJJpYqWiNvc92wApIfbycwv6DdCVkHKQWbOElhbyjQ
	scdLfmqvrDQ/uF9MDOM3WQ9d1uQlyNhKAUyZMuPvxExeE2YMiSmR+kwIb+T3RuMXUsf4/PqLVQR
	A=
X-Google-Smtp-Source: AGHT+IH4BIuCOkufR5zpdXWK9alIlYMnPti5eXH+01WmcFERf5EmF47R3LvTkLS7gssMCY0/Uh9xug==
X-Received: by 2002:a17:90a:d64e:b0:32b:5c13:868d with SMTP id 98e67ed59e1d1-32b5c138af9mr13139268a91.1.1757095358574;
        Fri, 05 Sep 2025 11:02:38 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b95d31976sm5409595a91.22.2025.09.05.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:02:37 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:02:35 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/7] x86: Stop calling page_address() in free_pages()
Message-ID: <aLslu1yKPNgoz1OU@fedora>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-4-vishal.moola@gmail.com>
 <aLl9KneqOYTujcCh@kernel.org>
 <aLl98MQs-FlHo6bW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLl98MQs-FlHo6bW@kernel.org>

On Thu, Sep 04, 2025 at 02:54:24PM +0300, Mike Rapoport wrote:
> On Thu, Sep 04, 2025 at 02:51:14PM +0300, Mike Rapoport wrote:
> > On Wed, Sep 03, 2025 at 11:59:17AM -0700, Vishal Moola (Oracle) wrote:
> > > free_pages() should be used when we only have a virtual address. We
> > > should call __free_pages() directly on our page instead.
> > > 
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > ---
> > >  arch/x86/mm/init_64.c          | 2 +-
> > >  arch/x86/platform/efi/memmap.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > > index b9426fce5f3e..0e4270e20fad 100644
> > > --- a/arch/x86/mm/init_64.c
> > > +++ b/arch/x86/mm/init_64.c
> > > @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
> > >  		free_reserved_pages(page, nr_pages);
> > >  #endif
> > >  	} else {
> > > -		free_pages((unsigned long)page_address(page), order);
> > > +		__free_pages(page, order);
> > >  	}
> > >  }
> > >  
> > > diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> > > index 061b8ecc71a1..023697c88910 100644
> > > --- a/arch/x86/platform/efi/memmap.c
> > > +++ b/arch/x86/platform/efi/memmap.c
> > > @@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> > >  		struct page *p = pfn_to_page(PHYS_PFN(phys));
> > >  		unsigned int order = get_order(size);
> > >  
> > > -		free_pages((unsigned long) page_address(p), order);
> > 
> > Could be just free_pages((unsigned long)phys_to_virt(phys), order), then
> > the page is not needed at all.
> 
> Or even __free_pages(phys_to_page(phys), order);

Right. It actually looks like we could inline this whole block if we
really wanted to...

__free_pages(phys_to_page(phys), get_order(size));

Should I send a fixup (or v4) with this change?

