Return-Path: <linux-efi+bounces-4582-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52223B2F417
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E529E164068
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19332D3EC5;
	Thu, 21 Aug 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1vKrktd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE21F3BAE;
	Thu, 21 Aug 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768940; cv=none; b=S0HRhBw+PkZYLcNQstyeGyY+pRKM9tjw+EeYC83+XWFSp0aDzJcA0hdM38WoIs2d0WTEzffnkTQcN6ckVZree1BxUY5LLgHqBfKVxvchEZd9cjAqs2Lzu07cJRoLd/JdojYY7W/sm9LvTa3xaVNzISnnld7JyN5sO8yEBAfrpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768940; c=relaxed/simple;
	bh=ZjiGxCZuZ5D/qhyN6SKndZUgyDFoMxTM7TM5ZGn3tGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7hUZwbISLLJXC5Wp/ScXPLKi0bHUNJ9AgQrol0AtqOUi7BqxX7bgrqEgZacuKZ811G0io2tAf2cPjW7QLU04sFyUu6FGAfl4zGPRTo/QZt9FnTgELXqaf7mtfcB7RcrP1HvuOmJ5bnsCqcFKk1IGhdcAnyvAP+/V0NwES+B/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1vKrktd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225BDC4CEEB;
	Thu, 21 Aug 2025 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755768938;
	bh=ZjiGxCZuZ5D/qhyN6SKndZUgyDFoMxTM7TM5ZGn3tGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1vKrktdHgmMgPy7XJfoy8Yjzp8I/GFL04O/tPQO+CDjUdKaudsxFNspO0eYTwhhi
	 kGFJ4wCPJiYSXAKVxXo6dwEEV7HfYsdFojp+pMenSzuth/quMKya9mn7yUQY929s+g
	 WvgS4FIY198yj7ycxsICtx5lrjxXOhTilij2ngYSODhrf9/Hw5+JaRewspEyCH50Up
	 UcKzkEzy71HJJdDPJ4ulHCLAUgET07RwXE/PoIIXN4SmmDptYyZjQ7qlcKi0z9pivW
	 T/DBo3Zs5fa+P/0OfLLIYlE2Sm/M2Ir/L0ztuOfPNs9uM7GdwVoXkwUTImBJa4rFsh
	 l07Ab9fnwkQrA==
Date: Thu, 21 Aug 2025 15:05:31 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH 1/3] efi: stmm: Fix incorrect buffer allocation method
Message-ID: <aKboY9oBmHJJb2Pc@sumit-X1>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
 <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjL84EFiKh0ETb7LwYjMRgLAZA8hFKy-YDS4=YQ1LRwg9A@mail.gmail.com>
 <75db5f5e-9e0c-4c48-a3c8-034414276036@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75db5f5e-9e0c-4c48-a3c8-034414276036@siemens.com>

Hi Jan,

On Wed, Aug 20, 2025 at 05:05:43PM +0200, Jan Kiszka wrote:
> On 20.08.25 09:29, Ilias Apalodimas wrote:
> > (++cc Sumit and Kojima-san on their updated emails)
> > 
> > On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> The communication buffer allocated by setup_mm_hdr is later on passed to
> >> tee_shm_register_kernel_buf. The latter expects those buffers to be
> >> contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
> >> various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
> >> was broken before as well.
> >>
> >> Fix this by using alloc_pages_exact instead of kmalloc.
> >>
> >> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> > 
> > [...]
> > 
> >>         const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
> >>         struct efi_mm_communicate_header *mm_hdr;
> >> @@ -173,9 +174,12 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
> >>                 return NULL;
> >>         }
> >>
> >> -       comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> >> -                                  MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> >> -                          GFP_KERNEL);
> >> +       *nr_pages = roundup(MM_COMMUNICATE_HEADER_SIZE +
> >> +                           MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> >> +                           PAGE_SIZE) / PAGE_SIZE;
> >> +
> >> +       comm_buf = alloc_pages_exact(*nr_pages * PAGE_SIZE,
> >> +                                    GFP_KERNEL | __GFP_ZERO);
> > 
> > Rename nr_pages to something else and skip division, multiplying.
> > Unless there's a reason I am missing?
> > Also doesn't alloc_pages_exact() already rounds things up?
> 
> I was looking at tee_dyn_shm_alloc_helper and the dance it does to
> calculate the pages from the size parameter.

The rework of tee_shm_register_kernel_buf() is directly accept kernel
pages instead of buffer pointers is already due. If you are willing to
fix existing TEE client drivers and the API then I will be happy to
review them.

-Sumit

