Return-Path: <linux-efi+bounces-644-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D785F60A
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3AA1C2283E
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713C3F9E2;
	Thu, 22 Feb 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPWqyZAh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9D39859;
	Thu, 22 Feb 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599023; cv=none; b=qqOEHbJJvI6r7NB2reOxcz7nU3FV9myo23keZ9PfBQG0D5DT+PF5rsGUewlVJA4/iZwFDNXziikfwsHA+k+mHoxFKc34CySQIzfXwVFaBRux1RvJuyVdgowdyczd+Tgx5VSaLYskxBpsHa4EmZUWpIUxPnc0rAH89GZNuDEUHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599023; c=relaxed/simple;
	bh=MlCX4WJP2SCKY4u/hH+Za0aayaGTr+j+qDw+YgB04Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/yItcpCZ9Fl6v0fatmnccqmCMnp4OPRvT0Y7JMzjFk7y76t0dPq1yI32r8pVEu5ZdIci8fE24tTvU5Rtv5p4T/bqpVQzAJiUtRWdWwghDbS2JlECnxi+JQpISi3n5BwoJiWgMpM1YOjE3rV69N4qTKWCrEEGSDrQoCo6dtGyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPWqyZAh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708599021; x=1740135021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlCX4WJP2SCKY4u/hH+Za0aayaGTr+j+qDw+YgB04Vc=;
  b=SPWqyZAh5fwmniuFaxYiRDyTcApicoq1q44bFHOA4a79LOD5ttYIbkeC
   DR94rmCclp/ruRL8d7Il1DoXHRvFJw2sgwnza3vOy87iY2FwUoC77jPtU
   5wTRsQRkyrv76EdefRk6Y5ZVSUQm5GdAaPRfDec7KQnV6ZB9R+03+Cb0R
   oTb+1lds/2RSzm/mQrXXOG0iJuaKYgfexWvLWwZIkB+s7jYE/9b5VZkam
   8HCgLgAjleTC5n3KMgb85YVZqPmV5V45vePxmp1RXIBaMvrKbh+XWCVQc
   qPHyIYVklgxN8g0QyFzhXrQz3eW0v8R5tCMTv/F1cwk+p2aFwNhLPKCcK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14232498"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14232498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936832910"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936832910"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 02:50:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EB8B42AB; Thu, 22 Feb 2024 12:50:11 +0200 (EET)
Date: Thu, 22 Feb 2024 12:50:11 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org, 
	x86@kernel.org, ardb@kernel.org, hpa@zytor.com, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, anisinha@redhat.com, 
	michael.roth@amd.com, bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com, 
	jroedel@suse.de, ashwin.kamat@broadcom.com
Subject: Re: [PATCH 2/2] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <amk4ozai3l65d6ef3k2rsnapaislbvlwpfx7p35tqqhesmc4w7@5vmi52a3qv3o>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <aa633d7439885da7e54c41db07d65f8e177bcf51.1708390906.git.ashish.kalra@amd.com>
 <97a7d69f-03e1-4ecc-a0ce-10bfe148509c@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a7d69f-03e1-4ecc-a0ce-10bfe148509c@amd.com>

On Wed, Feb 21, 2024 at 02:35:13PM -0600, Tom Lendacky wrote:
> > @@ -906,6 +917,206 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
> >   	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
> >   }
> > +static inline bool pte_decrypted(pte_t pte)
> > +{
> > +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > +}
> > +
> 
> This is duplicated in TDX code, arch/x86/coco/tdx/tdx.c, looks like
> something that can go in a header file, maybe mem_encrypt.h.
> 

I think <asm/pgtable.h> is a better fit.

> > +void snp_kexec_stop_conversion(bool crash)
> > +{
> > +	/* Stop new private<->shared conversions */
> > +	conversion_allowed = false;
> > +	crash_requested = crash;
> > +
> > +	/*
> > +	 * Make sure conversion_allowed is cleared before checking
> > +	 * conversions_in_progress.
> > +	 */
> > +	barrier();
> 
> This should be smp_wmb().
> 

Why?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

