Return-Path: <linux-efi+bounces-1295-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A3918064
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D98D1C232C0
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AC17F370;
	Wed, 26 Jun 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfG8dPzv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10415A856;
	Wed, 26 Jun 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403223; cv=none; b=OW9hrySRsMOtToapuy4xPQQ2WPVCCAPmhM8sKB2GYn9taP3nEhYcZzT17/kLCKp/JTkuEBfgAqWD5DpS3jlMXD9VtxhhjRnbhBGW6eJjihVQtQEU2wqe8bMmRVaVrT7bhxzeuhunans9NQZoglUihwPUKzNex9EkXxwg2zeSf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403223; c=relaxed/simple;
	bh=bh8hvuIU3n7Loy6VcuHzcyvnUCKJUlEQfz4UfRFVk60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpgKLeZ8lgqwCVyjYf253fg3/Anldb1m4K9/z6cpApHq1zZsG7CwzRiaAqdVs+lT9fseOndlzZbueJ2htZME+5gUTSZg8X3v1aCr31V7Shhyazm6MYka/8CgmdQDpA3gDKs8XFEN6jVMc+H6W0GCWz+jhnCpuAe6uih9SKXrPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfG8dPzv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719403222; x=1750939222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bh8hvuIU3n7Loy6VcuHzcyvnUCKJUlEQfz4UfRFVk60=;
  b=jfG8dPzvShX2yiW0d0w69EQQAKKvuv6BhpxtfeGirN1XbhIXYVDX9TMg
   q8SY7vRnLfXlFi5nJWRQ6MSZNxQfIMZoBp4+/xthb4jsKzpC5MpXdnZps
   3ppMBs4YbfYAEPd1NvnmuX1AEJxGv9uiowMht+SUE0t5/9dxXo1qDki1o
   CE1xCYMAOJG/hAfldStXxu2Ij7urGxNkstJ0aDw9Km2TUfvaT18yhu5Bh
   SgvWVrBWuV6G1PHd2s2rIJgDYXyxx3qXRq8hveXG9as2TOUwdmuWvYwhd
   EEP2GEk1wA3Gm30A+NAOJRLC/hChq9ovZ93lVgcp9gRfySkehnIgU2eVO
   A==;
X-CSE-ConnectionGUID: hGSeMfF3TYKQiQWGbb2fXw==
X-CSE-MsgGUID: TFU5XZ4VQnegFoG5KC5H/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16611059"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16611059"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:00:21 -0700
X-CSE-ConnectionGUID: /5RfIHYsQJuxso8TuXglDw==
X-CSE-MsgGUID: suY9nTNCTvay+c8SqTBfig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48347414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 26 Jun 2024 05:00:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9FF3D346; Wed, 26 Jun 2024 15:00:14 +0300 (EEST)
Date: Wed, 26 Jun 2024 15:00:14 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: lkp@intel.com, ardb@kernel.org, brijesh.singh@amd.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jan.kiszka@siemens.com, jgross@suse.com, 
	kbingham@kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, oe-kbuild-all@lists.linux.dev, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, sandipan.das@amd.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH] x86/64/mm: Make 5-level paging support unconditional
Message-ID: <dtou7hqnrhof73giyz22crs6s7krj2ky54ipkx45ibiwijeo5o@6xv2syr2baw4>
References: <202406260735.rkb4c8N7-lkp@intel.com>
 <20240626102624.1059275-1-kirill.shutemov@linux.intel.com>
 <20240626104648.GBZnvxmMXCZbEhoqls@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104648.GBZnvxmMXCZbEhoqls@fat_crate.local>

On Wed, Jun 26, 2024 at 12:46:48PM +0200, Borislav Petkov wrote:
> On Wed, Jun 26, 2024 at 01:26:23PM +0300, Kirill A. Shutemov wrote:
> > Both Intel and AMD CPUs support 5-level paging, which is expected to
> > become more widely adopted in the future.
> > 
> > Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > ---
> > 
> >  v2:
> >   - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
> >     #if CONFIG_PGTABLE_LEVELS > 4
> 
> Is the 0day bot smart enough to detect separate v2 fixups like that and
> re-test using them?
> 
> If not, you can push your tree to your repo so that it can chew on it again
> and report any other potential breakages...

Pushed:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git x86/no5lvl-config

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

