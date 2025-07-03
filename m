Return-Path: <linux-efi+bounces-4100-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8805AF70C1
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F187F1C8012B
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3AF2E2EF8;
	Thu,  3 Jul 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E06vlraX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE462E174A;
	Thu,  3 Jul 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539260; cv=none; b=BAoPMROYtSc05/AomKt/kReVG8q6kFMFwaZEyybPYrm42ATbtt2Sk2IUmdnz/xXa+02uauT0OVLufnAJJv1IUu2y0k8PWYUagkOKj7jOMolLCOcWUn+omQq49GoWVS5mrnyUT5Cevf8VREQpWij2VRDtT+Uqf0+WCR6Z/3llkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539260; c=relaxed/simple;
	bh=3hiYT/iGDiCcUZwUQoir5vPfs6nuIGwpzTssOMbN8k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgi7I6ON2HkhoWvP4CsSv83fNE2LYpy0bDpjq2JGDAhMTv1+E9iScEwbPdv/g8/GMUniX7z3Sm0SWf9xaw7LUr1vrPF5HGqvQbKQaakcgqWnzijzF4zLVzJTA0R9PnLDCbH+DDc+kwAXb/EiX50Gcvd7UmB2sECchhwYfusqJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E06vlraX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751539259; x=1783075259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3hiYT/iGDiCcUZwUQoir5vPfs6nuIGwpzTssOMbN8k8=;
  b=E06vlraXqV10TzltLoPWdGKhM5oiXuGVXOtl+y8OqPJtPM+Y8GpnqdjA
   gJ6JofulAX8Oh0NZENV3aiKmMs/ZX3OGSICk3LyF0ujH3ImJtGLVTSawA
   5QA3B9m6RM7IZdT5H3CNSbMsG6v7o4T64rUxL9nUOn8Vu3TeIHkvuxygi
   vMTxMDdVawvlU1eYgITyVdvtg9p1ATwPr6kNJWSdxeHruKtmcDfcSi8ms
   jQaYAo2RT9KmjUflELaXU2lr81HiS7MLp/yrtVqMX3CG0NGO6f+O1+bEZ
   IYSOHeMS2tuNzs19nJym133H1jQCTuhKqnRk6/8bIvIiBPsAnGQRZZkDn
   w==;
X-CSE-ConnectionGUID: 4PA4c7v5Qbu946GBG/JN4Q==
X-CSE-MsgGUID: /dl5Z27ZTqykMqwSBbnQ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65314767"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="65314767"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 03:40:54 -0700
X-CSE-ConnectionGUID: ptx9byJbQgyveCXUOqKc1g==
X-CSE-MsgGUID: QETQ3Pt4RLCmHymkubPTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154106791"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 03 Jul 2025 03:40:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0CCEE1FE; Thu, 03 Jul 2025 13:40:39 +0300 (EEST)
Date: Thu, 3 Jul 2025 13:40:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Breno Leitao <leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
Message-ID: <o5q5d3bttzrmlpuzk2ce6vh5mb2xvkvdnzmudsyg2pazo3lz6e@ogovp35gdpk4>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
 <19868e42-5f00-4127-a48c-ed48c0297a87@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19868e42-5f00-4127-a48c-ed48c0297a87@intel.com>

On Wed, Jul 02, 2025 at 10:56:25AM -0700, Sohil Mehta wrote:
> To reduce indentation, you could also do:
> 
> 	if (!cpu_feature_enabled(X86_FEATURE_LASS))
> 		goto error_trap;

Okay, will do this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

