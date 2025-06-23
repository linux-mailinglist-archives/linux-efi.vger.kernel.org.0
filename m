Return-Path: <linux-efi+bounces-3905-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2CCAE382F
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308D43A7AD9
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DDE1F1306;
	Mon, 23 Jun 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ks/h/Npi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660A4409;
	Mon, 23 Jun 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666640; cv=none; b=Q7yZ04clbAgOXvRp0tPYv+wiKlygoWY/xdab4JhkYkM43yf1TnNF/s7yeTtWFRC7KX4zBoF/HzPlGPqb3TDwDdm6b+2/n3aVJHvG2uyYOiQ09lFTc3OGjYRjOEHPN3eC0a45BMKey14mfDp8/SrEu6TAGCyRwFFPYKe5QRnZeHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666640; c=relaxed/simple;
	bh=3C1C5syECeHn+sxB4B/MNopaQHu7zY8lfXLdxTcq1ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJU/9abDXQQn1R0Rjnq9Cj/bRUrHGqAMyEiYVogGmSWjtskmEQxjPsFBZIub/G6Jl9PFU8xFddFc8MT/orZKPTkDK8ktvC3nYErte+8kYoOqg75Otiby1YHEa4pmQ1gkclO3rYX6unmvq0IqnVXE/+EXQTMsf/ApZv73fd85pbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ks/h/Npi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750666638; x=1782202638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3C1C5syECeHn+sxB4B/MNopaQHu7zY8lfXLdxTcq1ks=;
  b=Ks/h/Npi2/5zOyXe6eTCe6EUpzGoRxtKfN+vqWCUL+/elCbPRP+hCYtx
   6pv+AhcL+m+OTWk2hvP9kWRe+DByHMSjSPg1mVOi018xVQaIO5jZGqBEO
   P7tiEPCWFyE50eFX+KRMboE1HeOQaVieX0N9UTiVrpiPkyepvDZkDgjT2
   QWDXQ5Ic5HM0RIbEthNPd78//YrBhpwVd149tzBgU+lCxdYZvb3zrC8g0
   HPT+khGIJYkZP4yM9+nF9m91D68eHkoozsZgleP3+Q8RcUqIOP8GsHt35
   odbb71qZaincMdLNixl5F+42duQVaNzV4uLnvO273vyrwt42JLIXNR4IJ
   Q==;
X-CSE-ConnectionGUID: CbKVdD19ToiYt3SSMLnweg==
X-CSE-MsgGUID: 3lhFvzK+T+6tqpRXOp5Emw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52732704"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52732704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:17:17 -0700
X-CSE-ConnectionGUID: 8g6RJxTKTPCtjzq50ZA/yw==
X-CSE-MsgGUID: vpuqvzhrQi6SNRUSArfXVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="156074558"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 23 Jun 2025 01:17:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6F573108; Mon, 23 Jun 2025 11:17:02 +0300 (EEST)
Date: Mon, 23 Jun 2025 11:17:02 +0300
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
Message-ID: <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>

On Fri, Jun 20, 2025 at 08:29:43PM +0200, Borislav Petkov wrote:
> On Fri, Jun 20, 2025 at 08:33:36PM +0300, Kirill A. Shutemov wrote:
> > What is current policy around it ?
> 
> Documentation/arch/x86/cpuinfo.rst
> 
> > I think it is useful to advertise security features in cpuinfo.
> 
> Because who's going to consume them?
> 
> Don't get me wrong - I am trying to see whether the whole use case for this is
> well thought out. Because it becomes an ABI.
> 
> But if no one is going to use it, why bother?
> 
> Arguably, for this thing the argument would be - as it is put in that file
> above:
> 
> "So, the current use of /proc/cpuinfo is to show features which the
> kernel has *enabled* and *supports*."
> 
> as it has been enabled by machinery.
> 
> So that's ok. I'm just making sure we're on the same page and you're not
> aiming at something completely different with this.

What about this:

LASS provides protection against a class of speculative attacks, such as
SLAM[1]. Add the "lass" flag to /proc/cpuinfo to indicate that the feature
is supported by hardware and enabled by the kernel. This allows userspace
to determine if the setup is secure against such attacks.

[1] https://download.vusec.net/papers/slam_sp24.pdf

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

