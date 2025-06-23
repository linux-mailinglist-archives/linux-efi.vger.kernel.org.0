Return-Path: <linux-efi+bounces-3913-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D9AE451D
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2446189C75C
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C225392C;
	Mon, 23 Jun 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/Efor4r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DFB242D90;
	Mon, 23 Jun 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686176; cv=none; b=SVOwdbpsczAl53jBOmi/ohjHo1cR/XC+0ZTuHjX+6OCUyWK2eJtfG3gyVmCSwgQnk9o79Ie1OcJ07fUwxm1ra7IudPE6bItw4WkFBVzONY3e0irG2Z0ZsjrLiYZ6GkbSPve1oeSv+bgLQsjQwpFtFMg53KQa6svFFyww1psRONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686176; c=relaxed/simple;
	bh=N/wybOTy4smjB16l7nsGvyZZFI/vEE7f4zQ+AuUb+fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLD2CmAXURN7uMSUIxMErQHR8uz6T6z1zxjmFwbwkE5GyaZQzqqbGerJ+YVWJxk8qsixivP7mIY9/DNJggEsOhplQ3dtw6wsZqHKTFmWYg7ioQjmr1wp/upGyFnQ+Qy7guP56fTny5sabY298iTNMB2E4KFoZFTTqBFbEh4VcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/Efor4r; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750686174; x=1782222174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/wybOTy4smjB16l7nsGvyZZFI/vEE7f4zQ+AuUb+fM=;
  b=a/Efor4rYKHK2VelsL64z8peMtoPrwYbBp2awiNmg+/leuE9D6W0R81A
   nyD5P1C38gsaaLV3ZLr06hpbrLfdXjjBFshcV8OC2sJSFbH7FwjkOnO2j
   SZ3ImvEhF9Hdx9fnZJVRV0qx2tIRohrFtICTbuAuz3WrJ1WBAi5pSe7tW
   tF3NUNiG7oaeRV3MRbxMAsAI6Z0Vv+lbkFiGzYvmsoZlsc1pTAZwFObvj
   5wLZKDv0CU6f3BUKxajNjRxSq1U/1RwMSdrB6AmC4x3FuRAjM5iLJ9M5X
   R9l3tEGMXcNNE4+I62QBnPgE2P/EPUCQnK9/aLNsp6HdP882Tf3uFzP2a
   g==;
X-CSE-ConnectionGUID: oMDy6UmdS0a6IzGsLHNfMg==
X-CSE-MsgGUID: UjkdAvNIRoKLEJOEIj59HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64325177"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="64325177"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 06:42:54 -0700
X-CSE-ConnectionGUID: sWHx9E82TwqF7r/zmduUmw==
X-CSE-MsgGUID: A5WspalTSpmZe+o8bh522g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="152286392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jun 2025 06:42:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2FACC108; Mon, 23 Jun 2025 16:42:41 +0300 (EEST)
Date: Mon, 23 Jun 2025 16:42:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
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
	linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <ztkgdk72p2z3q6z4hslfg4gj6pejirh7cnssxhd7u72mo4enn4@viqrwrycderf>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
 <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
 <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>

On Mon, Jun 23, 2025 at 12:21:05PM +0200, Borislav Petkov wrote:
> On Mon, Jun 23, 2025 at 11:17:02AM +0300, Kirill A. Shutemov wrote:
> > What about this:
> > 
> > LASS provides protection against a class of speculative attacks, such as
> > SLAM[1]. Add the "lass" flag to /proc/cpuinfo to indicate that the feature
> > is supported by hardware and enabled by the kernel. This allows userspace
> > to determine if the setup is secure against such attacks.
> 
> Yeah, thanks.
> 
> I'm still not fully on board with userspace determining whether they're
> mitigated or not but that's a general problem with our mitigations.
> 
> Also, I haven't looked at the patchset yet but I think it should be also
> adding code to bugs.c to make all those vulns which it addresses, report that
> they're mitigated by LASS now in
> 
> grep -r . /sys/devices/system/cpu/vulnerabilities/
> 
> output.
> 
> Which makes your cpuinfo flag not really needed as we already have a special
> method for the mitigations reporting.
> 
> But ok, it has gotten kernel enablement so stating so in cpuinfo is ok.

Due to SLAM, we decided to postpone LAM enabling, until LASS is landed.

I am not sure if we want to add static
/sys/devices/system/cpu/vulnerabilities/slam with "Mitigation: LASS".

There might be other yet-to-be-discovered speculative attacks that LASS
mitigates. Security features have to visible to userspace independently of
known vulnerabilities.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

