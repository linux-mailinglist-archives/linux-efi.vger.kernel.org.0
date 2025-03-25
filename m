Return-Path: <linux-efi+bounces-3081-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB87A702AC
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C672F1888A24
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194813C8E8;
	Tue, 25 Mar 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnWhG4D3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB19199EAF
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910262; cv=none; b=JUSB19SWL8LlfWMAIA25+2jEuMrjEfPgCbItJsCIsnvJ9aPfRsrlnJon7kE5+F9NZTnuaZ02kcWbwdL5jlpVa8PpR8TvqdGNVWkf2HmjEN9LuzzHV8yLvfPpT0Npn84fgpqzLdYW2DdlBy0i2ZzKLqVhXns7xfp1A1SqZGia3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910262; c=relaxed/simple;
	bh=9BNwhrkS3CvLGgTxQLcaMPtk76MTyrgpq7zyowknY6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdA4/sZGJRL97lgNoy7WeX7yNoGY+p7lfrh+7Dx5R9kTlUZi79+J2Lq1LzglG2Sxr4LycMd9vVJfAt2lSxIOFrKETanLwKTJes0uwGmEKda4bIaK8t8Qw4R7sA24hZdTEO77mCTT+F0nfEmJnyxLIs3VOeuDGjxlXhrT/Vs4rRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnWhG4D3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742910261; x=1774446261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BNwhrkS3CvLGgTxQLcaMPtk76MTyrgpq7zyowknY6U=;
  b=JnWhG4D3AkaueEiAyRknnXYGznVnHE8RvmP5vf/S+2w5THxPE0qYbx5D
   +4rCNjUybVBospRigPS72V2XFPTdmK/lF4IhhevAgxl7u93uGOgLyoaWT
   WNVICD5E8jgy0pmuvp+qDNsmAzBgwKpI+77FwgmYqHKAvmS130iwc0HEh
   gQfFdYQi2xIhlOmi43p9QzWrvCIvnzfH06Ik6FtUIlY7vtONpmsHNr0g4
   LY2a8m0fg35bMADGkc5f8Wjfpd5kiBh6kEHyQpXpC1+Xt7ISRSgfJcHhk
   MNgRpL6H+Q40wQwdwKzxLaev5W5WasjUrkX3Lusk1oP3oY6QTlAHbGzDO
   w==;
X-CSE-ConnectionGUID: u7cNOmXQQTiywCpkZMlcdw==
X-CSE-MsgGUID: BszleeY6SeSTFREWCRTQ9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="66612111"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="66612111"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 06:44:21 -0700
X-CSE-ConnectionGUID: /H9npDgbRheQxO5ErKcV5A==
X-CSE-MsgGUID: iDtJXDAGQNKYBWst3+aMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="129425431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 25 Mar 2025 06:44:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5AE9B367; Tue, 25 Mar 2025 15:44:17 +0200 (EET)
Date: Tue, 25 Mar 2025 15:44:17 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-coco@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before
 ExitBootServices()
Message-ID: <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
References: <20250325091614.1203411-2-ardb+git@google.com>
 <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>

On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
> > Since the problem happens before ExitBootServices(), can we allocate this
> > memory range with EFI API and free it back?
> >
> 
> In principle, yes - we could allocate these misaligned chunks as
> EfiLoaderData, and it wouldn't even be necessary to free them, as they
> would become available to the OS automatically.
> 
> But doing this in setup_e820() is tricky, because every page
> allocation modifies the EFI memory map, and we may have to restart
> from the beginning. And there is no guarantee that some asynchronous
> event in the firmware context does not attempt to allocate some pages,
> in a way that might result in another misaligned unaccepted region.

Looking again at the code, setup_e820() (and therefore
process_unaccepted_memory()) called after efi_exit_boot_services() in
exit_boot(), so we can't use EFI API to allocate memory.

And it bring us back to the issue being platform-specific. It should be
able to accept memory in principle.

I remember testing TDX boot with ridiculously large unit_size, like 256M.
And accept logic worked fine for me.

> So ideally, firmware would adopt the same granularity when accepting
> memory, and we wouldn't have this problem. (Or maybe this is why
> nobody noticed until I found it by inspection?)

It would be nice, yes, but we need to deal with requirements in current
spec.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

