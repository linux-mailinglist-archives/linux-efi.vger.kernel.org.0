Return-Path: <linux-efi+bounces-3202-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C03A7CFCD
	for <lists+linux-efi@lfdr.de>; Sun,  6 Apr 2025 20:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23193A9B8F
	for <lists+linux-efi@lfdr.de>; Sun,  6 Apr 2025 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34CD158535;
	Sun,  6 Apr 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXiFq8Nn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D525634;
	Sun,  6 Apr 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965486; cv=none; b=krZtM/lZx80xr0ifk2hc6ASeJt2SE5527Q/EutDZecRj6nAPNIEJx8+s3gCBy9F+hV8jqdUV+HmGfWcxlL8XCXSIovQvO8j81IQlm9bhU5tRPNZoFGRTzl41RbtfPwXzMyb1LLlMB3SxoqymotceXDq0DTW/uLBRIFcZpbmKSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965486; c=relaxed/simple;
	bh=CT7VH8lT/JzXbkz7oy9ZRmE+XEGESB2lfJrCxuVOh6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCActv8hE1rdVN60fjSeDf24PTV9zyDAPaKKPF8OrEo2D02iXEPRlHACSjRnuBKY05CX9pZT7DPGzj1BzpSZs/D1HkgXNZrEp/SQ7Y5W6RYpL5Fj/jZxxWUWIsRF3v+GVJrUhVAkRgTP5lG3HahGeRDG3gtJuv+PdVhZcYJQis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXiFq8Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DABC4CEE3;
	Sun,  6 Apr 2025 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965486;
	bh=CT7VH8lT/JzXbkz7oy9ZRmE+XEGESB2lfJrCxuVOh6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXiFq8NnzeA070oRtEG2Z/cTdtC/0gjblZCoCil5hLwLjarkC+th9ZwRfIsOx00tv
	 bomEnkNK/nppLFCyJ0YDy9qftR7KKd4iqoXlneHX6dkYYyDAElBGKYyChNya1ZzyOA
	 HYpstoEOvjrit7dQZL8WEofWSUkn7gsYiqisudkka+doKtYl+DVcZdbYD+R4HjXxJ/
	 RWmMdAp/H6NctaQG9FWot/rdzaq5yXDkYO6e6opUds08PPxVT2otV0d0i6JnCvPmWJ
	 yWlb33+Ruat+eHm1v+HrUmOVbhrrq2IfwV85OBhuHQGfXf5fldMn7HeAYMfK69ErNw
	 DhhECKeQoIKog==
Date: Sun, 6 Apr 2025 20:51:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [RFC PATCH 5/6] x86/boot: Move early kernel mapping code into
 startup/
Message-ID: <Z_LNJO3q5QN82LN0@gmail.com>
References: <20250401133416.1436741-8-ardb+git@google.com>
 <20250401133416.1436741-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401133416.1436741-13-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The startup code that constructs the kernel virtual mapping runs from
> the 1:1 mapping of memory itself, and therefore, cannot use absolute
> symbol references. Move this code into a separate source file under
> arch/x86/boot/startup/ where all such code will be kept from now on.
> 
> Since all code here is constructed in a manner that ensures that it
> tolerates running from the 1:1 mapping of memory, any uses of the
> RIP_REL_REF() macro can be dropped, along with __head annotations for
> placing this code in a dedicated startup section.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/startup/Makefile     |   2 +-
>  arch/x86/boot/startup/map_kernel.c | 232 ++++++++++++++++++++
>  arch/x86/kernel/head64.c           | 228 +------------------
>  3 files changed, 234 insertions(+), 228 deletions(-)

So this patch breaks the x86-64 allmodconfig build:

 ERROR: modpost: "page_offset_base" [arch/x86/crypto/aegis128-aesni.ko] undefined!
 ERROR: modpost: "vmemmap_base" [arch/x86/crypto/aegis128-aesni.ko] undefined!
 ERROR: modpost: "page_offset_base" [arch/x86/crypto/aesni-intel.ko] undefined!
 ERROR: modpost: "vmemmap_base" [arch/x86/crypto/aesni-intel.ko] undefined!

I suppose EXPORT_SYMBOL() in the new startup code isn't properly 
extracted?

Thanks,

	Ingo

