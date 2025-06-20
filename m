Return-Path: <linux-efi+bounces-3878-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2FAE212D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E750B7A885A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60D2E3B14;
	Fri, 20 Jun 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAyEZ8Je"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8251EB5F8;
	Fri, 20 Jun 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441335; cv=none; b=YVfKsT9Y0ZHCdlD3udpZsw6agoMBG+vLA91PW336d7owpXK4U7O0Z9ryZtp3zecMZYEOlcHcD4VutNub4UoapexBAm9jG/V1Z7Wh72tHk0oK7f5JPqD5pCtFY4ILkXKmMsTI82cBO0NwpThlitHlatwMHzMlQF/YfBMTekN43TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441335; c=relaxed/simple;
	bh=+d8rWtAZJO4o7jYg3VVESTCyMRK/oKsbIChLqwzbf0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i205fpFMgF3/EBZ2p4ZujxJ/rP880dgzp9Kg0lofYdWGWHPn7hmSYJhbXd3ynBmXboP+YgpKPetjJZq0Sa8k3cscRAkRlxBxzlWHUMgCPrn6+uIBTu6uRihKXptzRKfODdXBpvV6UQM1pvntUHeDuyPLJmR8RZxrXhGhiUx7uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAyEZ8Je; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750441334; x=1781977334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+d8rWtAZJO4o7jYg3VVESTCyMRK/oKsbIChLqwzbf0k=;
  b=lAyEZ8JeIWaxE/7CIH0xhLVGxj87APxxhZHoTc82l5QlIHs+EZ5A9qKf
   Jn5UezPw5xkScEy40xjJaAL0WITqXnplEdna+Y9B4IRFQYCpN0XAGGuzq
   uqoqWzHMHPHwDGMhD25/5ElF4dtWWLwuyaJ7Wn2TzWc3TZzJPyTSn8NUW
   gJsglbJpQ9mx+eElPgXBY++mXKsR6azW+VpF4CCn6Qw6FYl52JX+ZuqOT
   MRl8/dN+Klbn0CPn54vepZYjTKBuN2a6mWJMVQcaNxAYE8gomyP8fPk5p
   KZva+ZvwTDCpODAAoC30c0yvneXHIWaqZFf/2n3Kdl1GsnSOh/0LQQ+kS
   g==;
X-CSE-ConnectionGUID: hRsgTmLiR1y9jNeBY9lgsw==
X-CSE-MsgGUID: cUbm9elmSqyZy5xjS2gYzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63396414"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="63396414"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:42:13 -0700
X-CSE-ConnectionGUID: Jz2GhDOiQICSKlR67fCgag==
X-CSE-MsgGUID: K38Nbuk0TT+ExDsKqRqDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151514115"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 20 Jun 2025 10:42:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4B1EE109; Fri, 20 Jun 2025 20:42:00 +0300 (EEST)
Date: Fri, 20 Jun 2025 20:42:00 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv6 04/16] x86/efi: Move runtime service initialization to
 arch/x86
Message-ID: <aqkhzspx6bh7u6gkxkgp7ih3onk27rot7ojwvwvsk6c7zv4ror@ilbd7wt56jxi>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-5-kirill.shutemov@linux.intel.com>
 <ba766193-e344-4def-84fd-f366872a2ee0@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba766193-e344-4def-84fd-f366872a2ee0@intel.com>

On Fri, Jun 20, 2025 at 08:35:14AM -0700, Dave Hansen wrote:
> On 6/20/25 06:53, Kirill A. Shutemov wrote:
> > From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > 
> > The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
> > the thing to the arch_cpu_finalize_init() path on x86 and get rid of
> > the #ifdef in start_kernel().
> 
> What does this have to do with LASS?

It is required to move CR pinning below it and allow to disable CR4.LASS
temporarily during EFI initialization.

> Is there any reason not to just pull this in to tip now as a cleanup? It
> looks good regardless of what it does to LASS.

I am totally fine with applying it right away.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

