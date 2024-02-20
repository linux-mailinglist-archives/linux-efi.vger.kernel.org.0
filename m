Return-Path: <linux-efi+bounces-595-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CBF85BC65
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 13:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967161F23C09
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B067C49;
	Tue, 20 Feb 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeqOh7qG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23698F4A;
	Tue, 20 Feb 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432935; cv=none; b=jKNqBeErOrBmppkQEcoJcV8vUDIKgu8h65FDwqL9NFlmOkBllBO4RH3aNdDDcAV/pfJpLLQqDuGG7Rl+Py21jDIKcY/bwx3/Vk56DDy4ho5fT04XtiCLfhtQeYLeHL8Y56WVzUx2mRmcYxWzqcy/gQaIERLccjzZnUZr1k2XgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432935; c=relaxed/simple;
	bh=WQEMa0Zg8JWL+HJp+aoQ8wXzZKQIdgVqIXMBI4Y1QIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHYrytN0pRhPVgbFt+egIekIkXMg9XcpDn4w8741GRya120EILy0BcKZJQVbAHtQ0GR5bKBVWzVGm+x/rvBoQMw0GQQ+XtkyBEgi2K6l8noDnGNnNkGgyyc4l6EhllKSZnMfZRMaGzZ3NIZQED0aW13NDL92IRM7Fb3oCYiWve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeqOh7qG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708432934; x=1739968934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WQEMa0Zg8JWL+HJp+aoQ8wXzZKQIdgVqIXMBI4Y1QIA=;
  b=DeqOh7qGM+W5RKsDjGWHxkdBRLR39fgqRCnl9VPPtJeCvSM7CrlAhxBW
   2YXcKlblAMAsQ2h8Lp+5j+atWx2owECcSq2sWFdqSCr8yPOeynSx+3vEW
   l+LyTYnSmGPfMkJC2sYg24Lpu39534yrTwQ/XkkRCIWskFBBAaHcQaz6f
   iG/3TRoQe+KOWT4yxn42vVIdxaluqognxcWtSPVK9qUIut2vYxR52mSHI
   na9LpVgtyAJpSmZKtkZ3coiS//8voty58Eu6w1ay33kLdsof1QW6aJls+
   UMGDE3wa2iDBJ3S6OFi/Kk1A1MTi2Zz1/Lu9GsTRDv+ZCAgsw4sLTE6T5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2436851"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2436851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936448498"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="936448498"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 04:42:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 20702305; Tue, 20 Feb 2024 14:42:05 +0200 (EET)
Date: Tue, 20 Feb 2024 14:42:05 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, luto@kernel.org, x86@kernel.org, ardb@kernel.org, hpa@zytor.com, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, seanjc@google.com, kai.huang@intel.com, 
	bhe@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	anisinha@redhat.com, michael.roth@amd.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, jroedel@suse.de, ashwin.kamat@broadcom.com
Subject: Re: [PATCH 1/2] x86/mm: Do not zap PMD entry mapping unaccepted
 memory table during kdump.
Message-ID: <ictdanmnsdn4qnzg42ett6om4r6qzypmxdc5spjwa2g5gz2s7p@drh7hoqdj4sc>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>

On Tue, Feb 20, 2024 at 01:18:29AM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During crashkernel boot only pre-allocated crash memory is presented as
> E820_TYPE_RAM. This can cause PMD entry mapping unaccepted memory table
> to be zapped during phys_pmd_init() as SNP/TDX guest use E820_TYPE_ACPI
> to store the unaccepted memory table and pass it between the kernels on
> kexec/kdump.
> 
> E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
> be required by kernel to function properly.
> 
> The problem was discovered during debugging kdump for SNP guest. The
> unaccepted memory table stored with E820_TYPE_ACPI and passed between
> the kernels on kdump was getting zapped as the PMD entry mapping this
> is above the E820_TYPE_RAM range for the reserved crashkernel memory.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/mm/init_64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index a0dffaca6d2b..207c6dddde0c 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -524,7 +524,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
>  			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
>  					     E820_TYPE_RAM) &&
>  			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
> -					     E820_TYPE_RESERVED_KERN))
> +					     E820_TYPE_RESERVED_KERN) &&
> +			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
> +					     E820_TYPE_ACPI))
>  				set_pmd_init(pmd, __pmd(0), init);
>  			continue;

Why do you single out phys_pmd_init()? I think it has to be addressed for
all page table levels as we do for E820_TYPE_RAM and E820_TYPE_RESERVED_KERN.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

