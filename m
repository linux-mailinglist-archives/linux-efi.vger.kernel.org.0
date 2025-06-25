Return-Path: <linux-efi+bounces-3990-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4AAE8369
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0193616EB25
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97202627F5;
	Wed, 25 Jun 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiYFioox"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBF26158D;
	Wed, 25 Jun 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856148; cv=none; b=fpPxRb1rkw8LEMkDlMYwXfkeGdInon+x/e2t3bGaLL2HaPa2o+AOcnQf8guWTX+qW8HmsOK9BNJWN49SIY4Cro+ZiTKAjCb0EkLtirGxVsB5fNBgy0pn+mAVY0WwD1wRwXYeC/5veos0MfHpQZdG7pHx3sySh8ew1+e5aCOgpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856148; c=relaxed/simple;
	bh=JXLoTAc7ALhyjeGRQiJU1KcXwfT2CND0hfmI1qetiYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/xDDPaXKUCpZHtoFWOOTC69Q9yykM9qVMJJ9ZS2MxqZemt+WmmJihaHYh6hofr0DCciNQmdkFWTbN0Hz3v5x/11uq8UjzvkQLaw9fvwqEC2CCyktIrhYLSon9FXMCaWpP8xW4E1BLRFDGBFp788QG1VLR7BN1ElsoXQ141x98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiYFioox; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750856147; x=1782392147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXLoTAc7ALhyjeGRQiJU1KcXwfT2CND0hfmI1qetiYE=;
  b=EiYFiooxWZGeIy55qCQV5QVqdjnK7pYIECFV75kU3asp1ZVbLchsXjdC
   dnHIRimyDQN3O/bRqqJiCsE+8/NNxjJUMABsDHwyVJ83+dqVjcJHZUEZ/
   0pTVAG61o/dhjcZpMQvk1tUP/ME2Jofs7jjiYn0y00wN5KVO9+j9c6fdd
   xVSaoXKGfQjyXZ9XndEiBN5Z8DIVP9UvMQKwt1dJrKUSOjrbCl2Ovrvm9
   8xldtyD0yA5abEAGQ6hkv+32c5cM14ySZ7dyknIEGjsYRdlyhSaW85pH5
   RkE0bq+2qdMnoACnMG4NxTC8L4fJyiT87Bnxmw1aB0RJjNKTN6iLwFUDV
   Q==;
X-CSE-ConnectionGUID: ZFurLcwGQoiTa8B4AArYkQ==
X-CSE-MsgGUID: sLo93ohzT4y8U4r1vaDpuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="55752963"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="55752963"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:55:46 -0700
X-CSE-ConnectionGUID: 18evZZsoR4Kd5vv5zfMgmw==
X-CSE-MsgGUID: i2Sdz5NYT8qFlryDPXfl1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="157708959"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 05:55:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B7C9A207; Wed, 25 Jun 2025 15:55:33 +0300 (EEST)
Date: Wed, 25 Jun 2025 15:55:33 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
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
Subject: Re: [PATCH] x86/vsyscall: Do not require X86_PF_INSTR to emulate
 vsyscall
Message-ID: <tlls63g3pslsdnegrahl7ayha6um6skpve5k2gotcqrnw4mub4@fkas3h7nd4gc>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625125112.3943745-3-kirill.shutemov@linux.intel.com>

Please ignore this patch. It was sent by mistake. The same patch included
in the patchset in the right spot.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

