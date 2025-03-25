Return-Path: <linux-efi+bounces-3076-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64243A7004B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF1819A1B7F
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832D25B67C;
	Tue, 25 Mar 2025 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1STrdND"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D325B673
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905967; cv=none; b=f/JvyyoomNTfCKoXtFobaohuKrhX1EKnTa2vMt2YTiQndThDWEm7Ws9LTUq9YeOhuukGjbT0giDQKUAJgb4CSVuIvRraDgfVTQ2bBvK3BpaBeRRp+7/BSzFjBq9WzQbk/5IgXmvgGBIRBgPPrmGNd8F2lOlTPMoi6a8rwGovsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905967; c=relaxed/simple;
	bh=CJ2JgB4X/7bBjAdlWsI3U4EG5eE2L4NLvVyyTJik6bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csK7k3oaGPPzoKCv9jNEzSUGCVYYK3DEOI+h5bC6xFuPD6uJE5fIMs7k8TCeH1a5xVLxdR9L6alF26OyfgJKaR4FUtvddtVKZ+TIWHSH71KLG1IITL9/a08aFcElvyf+EieWcNFoQrXkllVCSTDxjoekYCdbbt+A58jwDwpz05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1STrdND; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742905966; x=1774441966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJ2JgB4X/7bBjAdlWsI3U4EG5eE2L4NLvVyyTJik6bc=;
  b=i1STrdND2/fz0/pahjqeSurLuw74DmMX6scgmb3ajdrSkFfCf6pUfPLT
   h1Fi/eGo09j0Ay8sN9jd6ISCbpoy/5js9idrbQ67AgHquEnMSruK3pT2e
   Ph3KpYnOUoDD/6F7zDrBu1/UpWmOflf9N+qpYvazu5rVMMXD+rKtvbAO6
   shRKpUhBi9BoXt7fTKOWDPwDtGlVF+cpktOoS2OSHR5HFL2tqtRxZ6dYW
   G5NU2fxu5ThjxbBMH0XwjTI6eS3+W5kAp2Icpfu1ZKpR6ntuTbwQ7L6Ih
   JoLt7cfeeDNWgXP+2AxmqrX3rrVzmT+++2kBW0KjO6P3nupU71vDpSbmk
   g==;
X-CSE-ConnectionGUID: A3WIsHLNScGcV9ucdD+utA==
X-CSE-MsgGUID: qSwA2soqQ5Ce0l7j8PVa+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="69507680"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="69507680"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 05:32:46 -0700
X-CSE-ConnectionGUID: 2LHCIRU1RhCZG3XSZaYBBA==
X-CSE-MsgGUID: XZf5VGwSTMWt/atvkGUdlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="129408237"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 25 Mar 2025 05:32:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 13790367; Tue, 25 Mar 2025 14:32:42 +0200 (EET)
Date: Tue, 25 Mar 2025 14:32:42 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	linux-efi <linux-efi@vger.kernel.org>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: query regarding SEV logic in early boot
Message-ID: <zuz27i7ffrsa3hksveuroxpwxos5qx65py23gvupaadizwrsss@uhb6ye4j2eqn>
References: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
 <874299e9-eb4f-7775-4ea4-69d449ca1e05@amd.com>
 <CAMj1kXGu-2KNKLwYvRYRv7sd3d2XR8Q0wDOdRK84FYXOirO54g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGu-2KNKLwYvRYRv7sd3d2XR8Q0wDOdRK84FYXOirO54g@mail.gmail.com>

On Tue, Mar 25, 2025 at 08:22:50AM +0100, Ard Biesheuvel wrote:
> (cc Kirill)
> 
> On Mon, 24 Mar 2025 at 20:14, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 3/24/25 12:28, Ard Biesheuvel wrote:
> > > L.S.,
> > >
> > > As I am trying to disentangle the Linux early SEV boot code, the
> > > legacy decompressor and the EFI stub, I noticed something that looks
> > > broken to me, but I'm not quite sure how to fix it.
> > >
> > > When booting via the EFI stub, the following call chain may occur:
> > >
> > > setup_e820()
> > >  process_unaccepted_memory()
> > >   arch_accept_memory()
> > >    snp_accept_memory()
> > >     early_setup_ghcb()
> > >      set_page_decrypted()
> > >       set_clr_page_flags()
> > >
> > > where the latter function relies on mapping_info to remap the GHCB
> > > page as unencrypted. However, when entering via the EFI stub, this
> > > struct is never initialized, and so I am struggling to see why this
> > > works at all.
> >
> ...
> > So, yes, this does appear broken.
> >
> 
> OK, thanks for the analysis.
> 
> > The latter function reads from the target page so that the page gets
> > faulted in via do_boot_page_fault(). do_boot_page_fault() calls
> > kernel_add_identity_map(), which calls kernel_ident_mapping_init() and
> > initializes the mapping_info struct.
> >
> > At least that is how it is supposed to happen coming through the
> > decompressor. I couldn't recreate the path you sited until I tried an odd
> > size memory argument that was not 2M aligned (using 4097M on the qemu
> > command line fixed that). However, even that causes issues, because the
> > SEV_STATUS MSR doesn't get read until sev_enable() is called, which is
> > called after setup_e820(), so we actually can't even take the
> > snp_accept_memory() path.
> >
> 
> So we should never hit the page fault that triggers
> kernel_ident_mapping_init() because all memory is already mapped (and
> boot_ghcb_page is part of the image so it will definitely be mapped
> even when not booting via EFI)
> 
> (For future reference, could you share the QEMU command line that you used?)
> 
> > But faking the SEV_STATUS MSR value does cause the code to get down to the
> > set_clr_page_flags() function and reading the input address contents
> > doesn't trigger do_boot_page_fault() to run because load_stage2_idt()
> > hasn't been called, which probably wouldn't matter anyway since the code
> > is running under the EFI page tables.
> >
> 
> Exactly, and that was the whole point of separating those code paths,
> i.e., to get rid of all the demand paging logic and execute under the
> EFI page tables (which use strict permissions for code and data, which
> is a Microsoft requirement for secure boot signing)
> 
> So in a nutshell, the problem is that snp_accept_memory() calls into
> the SEV code before sev_enable() has been called. But I wonder why
> accepting memory is needed in the EFI stub at all?
> (asking Kirill) Is it just to ensure that all unaccepted memory is at
> the granularity provided by the bitmap? That could explain why nobody
> ever noticed this.
> 
> Is there a problem with being conservative in the bitmap, and marking
> misaligned chunks of accepted memory as unaccepted? AIUI, that would
> remove the need entirely to accept any memory in the EFI stub - only
> the decompressor code path would have a need for it.

Yes, it is a problem.

It allows for double-accept (accept memory that is already accepted) which
opens us to manipulation from VMM. Malicious VMM can zero memory these
margins:

1. VMM remove memory in the margins.
2. VMM re-add the memory there.
3. Guest blindly accepts the memory.

And now previously accepted memory is zeroed by VMM.

Information in the bitmap must be precise.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

