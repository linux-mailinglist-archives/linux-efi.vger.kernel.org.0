Return-Path: <linux-efi+bounces-4117-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F8AF8E7D
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 11:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F290C164AFD
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF1289828;
	Fri,  4 Jul 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7+mBL2d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65E1F2BA4;
	Fri,  4 Jul 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621049; cv=none; b=n17SAyY2AOxTQXUlQMnn1/KVWtwbgDZaFKFkeMw5/MFSNSnebR34R2pkcRMgyH4g83MuxrCLv1ZNkx8j6zMhhHUWz6ntQEd3oIV67gP8DDs5Bwg/dh9nXFXhT8REsfJWzW2xYmdodX36o4QxFH+duZftFyyCpsQigfCdipzF4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621049; c=relaxed/simple;
	bh=CAqYLtdjvCzS9pihXAkHd+/aykZa8jPPRAeXeeh9fJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt5FS67VpfE0fv2Y6iDV0Gdp+zUO7DBNtDsA3nZ10QemrgMGEsqy2b/ZV8UueqIOMBvjotLcVQdqPTwaDpn7tWbjWPFFgbaOajuTpoVPJu3BVG0Zc5K+C/Sp8qgL2f3z/uxvpbHTnyJTaeYFVYu7cijlb/xilhWzxC73ljBdRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7+mBL2d; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751621047; x=1783157047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAqYLtdjvCzS9pihXAkHd+/aykZa8jPPRAeXeeh9fJQ=;
  b=C7+mBL2dgKsmGSeXlBChG/ZrswocJ0j/dHqBoNxZ0al7c2ptLBuq7wNu
   G/fClhXNmH31Lvt/ElHmqBjV5n54o6j9xZF5aYiirO42319DAF54So2mO
   gCAwq0DUbb1+H0WbFKjej6t3iIfVTUr6VMZiwsPCwbqVvsPeejRcnFZ5H
   GO4a75Z50yBwFdBONavpHVffuCZKC0MffN0ZzyubWkDiys//hK20REPhJ
   bgjFwRTj1BETPUu/7WYZ8wb53qJYiRvBPHRLGlW+dvk1Vo6VIuSAgPgHf
   KX4uozzslBtiUeqZjH3af3etlM3FZ7IC/hjetb8nR67zaOz9blAnLcEB1
   w==;
X-CSE-ConnectionGUID: EYlvuBQzQ3+yy6ODwHDKJw==
X-CSE-MsgGUID: ZmduPVauQi2jmHRIEcc1Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="56581515"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="56581515"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 02:24:07 -0700
X-CSE-ConnectionGUID: LyisODgvRIW/2N5nRbyHag==
X-CSE-MsgGUID: ojPCqBPvRFCQGv2adGWDCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="155092551"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 04 Jul 2025 02:23:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0333915D; Fri, 04 Jul 2025 12:23:53 +0300 (EEST)
Date: Fri, 4 Jul 2025 12:23:53 +0300
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
Message-ID: <s7g5bw6qb2kmxfyynjx25elt2bh6s4cy7r5hjl3cwbkunxf4cx@nmbuuwzga2ws>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
 <bbe9dfb6-88c7-4724-bafd-0524599c9369@intel.com>
 <h7pjqco4nngern4ucj2krt4uuau5v522ni6w5vjup3qlkvn2yb@oskfps5mlzbc>
 <e0c0a8f8-7ec6-4f54-801d-86f7ca1cbf7c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c0a8f8-7ec6-4f54-801d-86f7ca1cbf7c@intel.com>

On Thu, Jul 03, 2025 at 01:12:11PM -0700, Sohil Mehta wrote:
> I believe we should include a #SS specific notify before calling
> die_addr(). Similar to exc_alignment_check() which dies on kernel
> exceptions.

You are right. Will update this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

