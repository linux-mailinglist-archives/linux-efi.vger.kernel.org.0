Return-Path: <linux-efi+bounces-3739-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B40DAB9E1E
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7557B7E3A
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAA249EB;
	Fri, 16 May 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JllxqA74"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA64FC1D;
	Fri, 16 May 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404177; cv=none; b=aysilkJnywP08va3KnY5kTgM+aNzUrbf6Eze9rFt9F5XuyC9OVBLqRg2hYH1rBsASeaz0nxRvWxQOf9l0zZk/s+tPxyfOjKaHrCkGbjgz0DGFvgbfR+PxAHlQvGkmivpI75rQh6NRTd5m9JQwbm59RHWsFi3iIhEFMigNVqlRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404177; c=relaxed/simple;
	bh=XD5LW1X8Za8qYgmHHCMJojUWKp2P7yuhRCd7itD26lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/OqElIWENcUZyQC95gNZJLFCrpys2EEYyRt2SZiTgD7z6Jf32egtPnLoAIQBxxB8/cvNCqVCKl0oQhizaHatAybsrGFsRUG8V2ebz8ZHb5UXftL0EOYW5sdv36ZdMtgrrroE6kV/KoevSXbaYaArpVVf1XsM/s0tnI9dxUARQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JllxqA74; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747404177; x=1778940177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XD5LW1X8Za8qYgmHHCMJojUWKp2P7yuhRCd7itD26lo=;
  b=JllxqA74mq/yQjzpbNgf3FK+rzg9hWY+7kjMFUXOPOHQT8CPQyB/GbQr
   jr2Od9NDw31cOjb+x8t0nQm23S5AqIvXpXZTWrZrvrJisgZJ0QaCy+64D
   fYIPOs1W/Y1+raWqx/uZcy2DVBEebj3jUJ3sH3gOzoOIvKb2cw2XiKKUh
   LvIvX7b9AGfwc12eIOxb9oJDdp20YaCQTDicw8rPZq2fxa3auRdQT2kha
   ljeH8Yky5wlLNK0gB0F3KWM7O/5RHj1PKwTMido0153kAadtJTLnCDEBM
   p0I6QGmkNNaRITYbMWGo6ukpBErXWh3ZvViGKPfiJQ7WDwML0yTEsa8yQ
   Q==;
X-CSE-ConnectionGUID: EdcAXMIaRiWVWSI5ewwPcw==
X-CSE-MsgGUID: JtsSB7aGQmClbsmOW+U43A==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53049001"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53049001"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:01:48 -0700
X-CSE-ConnectionGUID: ZTRg3ApCQOeOOdReIf9O4g==
X-CSE-MsgGUID: OLEkQDUZR2y+jHsqHAwl6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139101238"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 16 May 2025 07:01:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0FE981BC; Fri, 16 May 2025 17:01:20 +0300 (EEST)
Date: Fri, 16 May 2025 17:01:20 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Juergen Gross <jgross@suse.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 2/4] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory
 model
Message-ID: <rqkfqkkli57fbd5zkj3bwko44kmqqwnfdm766snm26y2so52ss@6it24qxv356q>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
 <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
 <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com>

On Fri, May 16, 2025 at 06:42:03AM -0700, Dave Hansen wrote:
> On 5/16/25 05:33, Kirill A. Shutemov wrote:
> > 5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
> > being phased out, making 5-level paging support mandatory.
> > 
> > Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
> > any associated conditional statements.
> I think we have ourselves a catch-22 here.
> 
> SPARSEMEM_VMEMMAP was selected because the other sparsemem modes
> couldn't handle a dynamic MAX_PHYS{MEM,ADDR}_BITS introduced by 5-level
> paging. Now you're proposing making it static again, but keeping the
> SPARSEMEM_VMEMMAP dependency.
> 
> If you remove the dynamic MAX_PHYS{MEM,ADDR}_BITS, you should also
> remove the dependency on SPARSEMEM_VMEMMAP. No?

I guess. But how?

And is there any value to support !SPARSEMEM_VMEMMAP?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

