Return-Path: <linux-efi+bounces-1525-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B56942D55
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8252AB20C4D
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A51AD3E9;
	Wed, 31 Jul 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwDK/pds"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F01A8BEF;
	Wed, 31 Jul 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425817; cv=none; b=UXO5zBm2McbBmx0cT1coK2C1UzDkxldT/3A7tvdFndOpXudvJjzhR4OK5HO38TtPxwga7f69V0ypfk6SGwfpzCS++oVaQFFdPDVEqVg1z+0k6p4XlZo7lEGYB9D8IXkm7bwfIP5QLlWsSL9r7vyBgEDBySHVI3e6mfdwoXKEDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425817; c=relaxed/simple;
	bh=DvxRYb8t1EwWUAm27DIBnObbDa/lEizruMwpmgZsz2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnMK0GjCTrrg0a8ddG9qAwQsrx8QiMAdCbWRUCVWNkOIUqOuduCuVn19Wo4+JzwdE3/KptAZQ98Oa671xNkeZhdMRVvYrMNPE+xTcvpRwgm7v75XewrZIwIBH38CcuN/U5WXBT482fW5+pGuFFK8N7aN/xJwM+pTQEelIXnzils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwDK/pds; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722425816; x=1753961816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DvxRYb8t1EwWUAm27DIBnObbDa/lEizruMwpmgZsz2c=;
  b=CwDK/pdskefcQYijEjOrMSOShcnxg6P5CzvAu9EnHvBqN1G37o+QehDz
   ziEuGNRQJV5aI/XA3naR+LfBXznFG9xpAf3U+L4bVGb9L1/A69yeWQsiV
   8PBIehBRYUBbjkYX63XDG043VSotI1GwFmmH/83/pO4xsi9Cg98ReZqEK
   om1yjfpvSJQM1lbAlDTHSFKSUZYNM96v1g+MJlPkMDJW2ucoNVnEOrASb
   BLAdxp4ivv1zzRp6BJ0F6xP/wSgvWahzm9fkul/Fs35eYuu7onmZroCd6
   BTiGHJFQlh0yrdjELRWKoCWGQItQRF9G/5gJ2KfYjZ0Uiyn314SvoP8/z
   g==;
X-CSE-ConnectionGUID: oG+WMpGASje1sIhozbvZtQ==
X-CSE-MsgGUID: TWjuMWt0QOaVZoKP9qd3Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20454552"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20454552"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:36:55 -0700
X-CSE-ConnectionGUID: GOq9DN9kTZ+xvVgfLA40KA==
X-CSE-MsgGUID: RfkRdjaTSzehKNbqcHf2aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54651188"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2024 04:36:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 479C516B; Wed, 31 Jul 2024 14:36:47 +0300 (EEST)
Date: Wed, 31 Jul 2024 14:36:47 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Shivank Garg <shivankg@amd.com>
Cc: ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jan.kiszka@siemens.com, jgross@suse.com, 
	kbingham@kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, peterz@infradead.org, rick.p.edgecombe@intel.com, 
	sandipan.das@amd.com, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH 0/3] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <jczq52e6vrluqobqzejakdo3mdxqiqohdzbwmq64uikrm2h52n@l2bgf4ir7pj6>
References: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
 <87wml16hye.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wml16hye.ffs@tglx>

On Wed, Jul 31, 2024 at 11:15:05AM +0200, Thomas Gleixner wrote:
> On Wed, Jul 31 2024 at 14:27, Shivank Garg wrote:
> > lmbench:lat_pagefault: Metric- page-fault time (us) - Lower is better
> >                 4-Level PT              5-Level PT		% Change
> > THP-never       Mean:0.4068             Mean:0.4294		5.56
> >                 95% CI:0.4057-0.4078    95% CI:0.4287-0.4302
> >
> > THP-Always      Mean: 0.4061            Mean: 0.4288		% Change
> >                 95% CI: 0.4051-0.4071   95% CI: 0.4281-0.4295	5.59
> >
> > Inference:
> > 5-level page table shows increase in page-fault latency but it does
> > not significantly impact other benchmarks.
> 
> 5% regression on lmbench is a NONO.

Yeah, that's a biggy.

In our testing (on Intel HW) we didn't see any significant difference
between 4- and 5-level paging. But we were focused on TLB fill latency.
In both bare metal and in VMs. Maybe something wrong in the fault path?

It requires a closer look.

Shivank, could you share how you run lat_pagefault? What file size? How
parallel you run it?...

It would also be nice to get perf traces. Maybe it is purely SW issue.

> 5-level page tables add a cost in every hardware page table walk. That's
> a matter of fact and there is absolutely no reason to inflict this cost
> on everyone.
>
> The solution to this to make the 5-level mechanics smarter by evaluating
> whether the machine has enough memory to require 5-level tables and
> select the depth at boot time.

Let's understand the reason first.

The risk with your proposal is that 5-level paging will not get any
testing and rot over time.

I would like to keep it on, if possible.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

