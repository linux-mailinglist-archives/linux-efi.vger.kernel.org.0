Return-Path: <linux-efi+bounces-1426-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6B92E4CC
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 12:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C91F22150
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614115278E;
	Thu, 11 Jul 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIHGuiFy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5380142E98;
	Thu, 11 Jul 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693972; cv=none; b=gIDEKoLxuJVJWf30cIJ3exQeIkjRLPGFGPPhvITEST/MRZ93jGz+mH9ufiGKpAiS1iyD2R068Uwk5XANlyVxJ/AhtGXQ50NEA3hLC596BrCiojpxCZ2KiXCTtIUHta+lEcQ2CXyvYnqTtCbzfSWD3HBsboM9I9meLMm3cEjsBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693972; c=relaxed/simple;
	bh=qazQrluIbOt8HInhmxmkHHqI9m1noD/zJQoQvWenZHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJgl0Jae+34SkjBXnUzBEq1uh8X/Oef0MQK0igUaC4pN1nBmZAr9JXL39zkdGk5EFjTaSqIDcN5+g9/Fn4WLYCG+70MTBM0IvojeOIKkMsFxhTSXnOwsogOFWwpsU1wrKbuRvFs4iQKJXCHVZtgBAPWHIA/mayHCGQvJffYlpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIHGuiFy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720693971; x=1752229971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qazQrluIbOt8HInhmxmkHHqI9m1noD/zJQoQvWenZHw=;
  b=EIHGuiFyWdEDlk5OpkY8eqOX+8d5CCCX07yJ/cxHCuMW7VZjkJsf2krb
   AQL8YHodqJETb8fg0hO1RO0WGU4AaPEEGQ6vdKLHI/xKurN9qssYvlnYi
   b7dsC8O8HxEwSmhEmzc6+QumaIMXiaTk0AH9+gMd+tke1Lx14KHtc9wXo
   mTpT876QpFT1VhLESzqlvzZI3KdAckwYfVU8KjT3ZivLMm0b6cv281opb
   SKiWPVLhJIJLa5f/gxFG4HnxKW6R4clLR7JLPKF6cWt1sObbsHIrVpel9
   NtFSegnSkdE23xUMWV9jQbXpBAhiymw626QqeoCdj6107EWKF/cBc38eR
   g==;
X-CSE-ConnectionGUID: qjd2MoJnS1S681yIfNeGyA==
X-CSE-MsgGUID: MyzvsBJCRJSrePhRTBOkxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35604208"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="35604208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:32:50 -0700
X-CSE-ConnectionGUID: aoHBdD+GQfe/a4R3491UDw==
X-CSE-MsgGUID: t3WQfsyPRdmBT/KJj58UGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="53690801"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 11 Jul 2024 03:32:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DC87629E; Thu, 11 Jul 2024 13:32:36 +0300 (EEST)
Date: Thu, 11 Jul 2024 13:32:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, 
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Yian Chen <yian.chen@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <5o57m7zkgo52uufitexwfpcyces5susurgbnz4yf56htsunezm@uoq5lzpqyfrl>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>
 <20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local>
 <cqacx3crogegwyslm25kwcdcezgg2n44lhy3mg5qkka3vgn4xa@lhqsoseyduus>
 <7bbf9cae-6392-47a4-906c-7c27b1b1223d@intel.com>
 <20240711081628.GF4587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711081628.GF4587@noisy.programming.kicks-ass.net>

On Thu, Jul 11, 2024 at 10:16:28AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 10, 2024 at 04:05:31PM -0700, Dave Hansen wrote:
> 
> > But, I'm 100% sure that we want to distinguish a LASS-necessitated
> > stac()/clac() from a SMAP-necessitated one somehow.
> 
> Yeah, if only to make it easier to understand the code.

lass_disable()/lass_enable()?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

