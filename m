Return-Path: <linux-efi+bounces-3726-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A105EAB9B6E
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 13:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F383A01FAF
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1FE231A51;
	Fri, 16 May 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4nRl3qj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823E22F743;
	Fri, 16 May 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396075; cv=none; b=QuSrleOpTDelgNa4DuEkOcCEbRTeuiVuOpB0wIPhDFJVipXxyOQ8GpM2TwSgeD+ZwIsQPm86lrHwA9dLrGb8vVoinE7CT9aFRI2KJtbfibeqBqY/lJXltouQzvY0YOu4vFjNA/Nt/KMiL1KYVXjNjCRqCdbZ+Thciw+16kbzB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396075; c=relaxed/simple;
	bh=ZfFxY5oT1+GiPdEDCb43Vlgf8axV3EHMnD0lvoZH1zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5ARznPe+lAiNwCLOKtl41smMqUzQFBDEl/967l/vvWXf59Glm2UUxHsDLHpykpCYOgOSd7r+4kJKHAScxgEZO/m4InE8T8qz5ZsITiX9WfpbBRoX8Rf59jhneNeJSyQL5cVY0hXD12uNT1zxqC08HvmcakRwRjzirnemR7V/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4nRl3qj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747396073; x=1778932073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZfFxY5oT1+GiPdEDCb43Vlgf8axV3EHMnD0lvoZH1zY=;
  b=P4nRl3qj9I8ZsQy+Jz/a7kM6SvJL3GtlP+adtavBX9xKD53YzNRxfU5V
   k5a/YB4kDfwIRw4T3DUmThkkAv60JuFv8b4yhpIQH612U3KQ/78mWCZDH
   8rlzQIFGBPYEbQeHgZRIbDOqTK6Bqap9DgAEInT7CeehkQw8PqIAC63Io
   DMJkojtaBKDS+TUTsrpeJ7CTMq2ixmu/fmo1Mqe67dWbtfbUGm1EKdWYR
   9om+W2BlK1Pc0khXeEmStDojj6HKQ2R8xPl0qmiHFphbxOFJD2Nls/qqn
   UdT9dCCv4hRC5QR+a3Z4c56qVBNJ6aI5qQTjOBYS/gYwoRcCu53SuD/Nx
   g==;
X-CSE-ConnectionGUID: q6dthDWGRdiwcU4wepDnaA==
X-CSE-MsgGUID: G721PXtiTbq0IcxZgvsi3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59596494"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="59596494"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 04:47:52 -0700
X-CSE-ConnectionGUID: IiCRcDEsR/2tYxgtdk89hw==
X-CSE-MsgGUID: 9YI8a5wTTya0g92baVMvYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138416540"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 16 May 2025 04:47:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1CF961BC; Fri, 16 May 2025 14:47:46 +0300 (EEST)
Date: Fri, 16 May 2025 14:47:46 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
Message-ID: <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
 <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
 <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>

On Fri, May 16, 2025 at 01:29:27PM +0200, Jürgen Groß wrote:
> On 16.05.25 13:09, Kirill A. Shutemov wrote:
> > On Fri, May 16, 2025 at 12:42:21PM +0200, Jürgen Groß wrote:
> > > On 16.05.25 11:15, Kirill A. Shutemov wrote:
> > > > Both Intel and AMD CPUs support 5-level paging, which is expected to
> > > > become more widely adopted in the future.
> > > > 
> > > > Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Suggested-by: Borislav Petkov <bp@alien8.de>
> > > > ---
> > > >    Documentation/arch/x86/cpuinfo.rst            |  8 +++----
> > > >    .../arch/x86/x86_64/5level-paging.rst         |  9 --------
> > > >    arch/x86/Kconfig                              | 22 +------------------
> > > >    arch/x86/Kconfig.cpufeatures                  |  4 ----
> > > >    arch/x86/boot/compressed/pgtable_64.c         | 11 ++--------
> > > >    arch/x86/boot/header.S                        |  4 ----
> > > >    arch/x86/boot/startup/map_kernel.c            |  5 +----
> > > >    arch/x86/include/asm/page_64.h                |  2 --
> > > >    arch/x86/include/asm/page_64_types.h          |  7 ------
> > > >    arch/x86/include/asm/pgtable_64_types.h       | 18 ---------------
> > > >    arch/x86/kernel/alternative.c                 |  2 +-
> > > >    arch/x86/kernel/head64.c                      |  2 --
> > > >    arch/x86/kernel/head_64.S                     |  2 --
> > > >    arch/x86/mm/init.c                            |  4 ----
> > > >    arch/x86/mm/pgtable.c                         |  2 +-
> > > >    drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
> > > >    16 files changed, 10 insertions(+), 94 deletions(-)
> > > 
> > > There are some instances of:
> > > 
> > > #if CONFIG_PGTABLE_LEVELS >= 5
> > > 
> > > in 64-bit-only code under arch/x86, which could be simplified, too.
> > > 
> > > They are still correct, but I wanted to hint at further code removals
> > > being possible.
> > 
> > Okay, fair enough. Fixup is below.
> > 
> > Did I miss anything else?
> 
> Yes.
> 
> One more instance in arch/x86/xen/mmu_pv.c,

Ah. Right.

> one in arch/x86/include/asm/paravirt.h,
> one in arch/x86/include/asm/paravirt_types.h,
> one in arch/x86/kernel/paravirt.c

Hm. Is paravirt 64-bit only?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

