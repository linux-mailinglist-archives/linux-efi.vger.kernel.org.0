Return-Path: <linux-efi+bounces-4088-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2419AF5B86
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1281C43189
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7553093DA;
	Wed,  2 Jul 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+eVHH2A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D628468C;
	Wed,  2 Jul 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467665; cv=none; b=QyxA+hK/EXkMJ3XCsXjcrnFUk6EMcmbV6Ueh/QZkFFra8dXLrH0We7zL4yhF3H5qzmS5nslaQWjW7AMA/3yFk7fBZ5OXL91RCyMGt/S4fVESNwGbommg/4ry5o/JUsXwTNtaqxFdBKtJaA+UJ9ZMFaeKoOtm7/FBVQHXPY/edNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467665; c=relaxed/simple;
	bh=Mp0evPB7WFJwTnK3WQTNV5HRsXFh08Qp2Kyd16xCUJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk+zc7QJC440ZnJQtx+djoYa4DSIbfIK9LSHGLpXFilw4QXBSn5rXURh7IhcZ35vAhOkhbajEQwCy5kcMsjBrgn+ZImU20xGKnFfNHQBZPVtWclZinM2piyfUuKstApx2Ld98JXpnI1dSdoXwHfVf4jvlmHuoFHHGbxiShps2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+eVHH2A; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751467665; x=1783003665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mp0evPB7WFJwTnK3WQTNV5HRsXFh08Qp2Kyd16xCUJo=;
  b=I+eVHH2ARyKUyMHhKOHzMc67L/eusOAzR/O2tZLmglOiuUK4BlgHBmd7
   2fC7Nr3WylhpQXedyCnjW0QiGX0RHKaBzmtpgC8dnyYmMknaECVukwy0x
   Nq9jTk0BqCgxnREAGr0wAIcvuCxDeviAGICy5T8BfDMKAsPfljmJoCCXS
   o8BQ3Ky1Npwp2cZfjwAMpetOrWzrKgK34UjTrjx0DiFyfgTtHWb3GvVVZ
   gRxvzFVB+NdaTn8AXMUNLgbRmxitr+vf0MXHkZoVRV7MYT/3YOseZQzgK
   Hjg6xwr6OowfmNigw1773ASaI4tuF8YJ2p5w9BueUfwHqxHMIg9Mbvzak
   Q==;
X-CSE-ConnectionGUID: Wh8A882lTByPgD6GHzpI1Q==
X-CSE-MsgGUID: i2dabJcsSOuNXWsxE24u9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53632172"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53632172"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:47:44 -0700
X-CSE-ConnectionGUID: xxUdef3KRTuj/C+rFkHWQA==
X-CSE-MsgGUID: w/pjUIgCSYq2rdNW/mYlAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158365268"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jul 2025 07:47:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E8CB21E0; Wed, 02 Jul 2025 17:47:30 +0300 (EEST)
Date: Wed, 2 Jul 2025 17:47:30 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, 
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
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
Message-ID: <6vihhfk5z33nrpy53ck2c6tkscjas4fhi6hqorenknbnjo4k3j@ywybd4obx76m>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com>
 <5q2zbkzyjknusd3feqolycqialetqfe52yfyzasnr6zp24pmej@4cg2r2hi4pf2>
 <DF2E7B41-46C9-4DAC-A671-EC8D6F53F496@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF2E7B41-46C9-4DAC-A671-EC8D6F53F496@zytor.com>

On Wed, Jul 02, 2025 at 07:37:12AM -0700, H. Peter Anvin wrote:
> A LASS violation of any kind in the kernel (unless handled by fixup,
> including user access fixup) ought to be fatal, correct?

Yes, LASS violation is fatal for !user_mode(regs), unless addressed by
fixups.

For user_mode(regs), emulate_vsyscall_gp() is the notable exception.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

