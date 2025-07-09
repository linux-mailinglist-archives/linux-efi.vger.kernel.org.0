Return-Path: <linux-efi+bounces-4233-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA68AFE435
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605AE7B9A7F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377BA28642A;
	Wed,  9 Jul 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcyDWdmk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5C286405;
	Wed,  9 Jul 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053773; cv=none; b=nDwsMFA57Wab/8cut7EnjNfnngwkT6Z/6ZF4B7mxgf0O+4sHhjJUqS50Oe1iYJ3dbsjH7OCgJY1mqT9wq8mv5c0E5AzwRJxW9+ipEJw8opLS3RNOGPyo/ygoomInO+ttBEBCk25GzQzp17q+m6RQF1Qa/9LXH3Z0dICgqJLpyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053773; c=relaxed/simple;
	bh=57HpAVIBYUev31ZQjRb5VYE7UT3RT7/5h4EqYhfyAyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvaJSL7m2RtpiGTYE5UWHa8+A6ICm5Qfkb77nRo9zU+Rok7oiTVxQ8u3UkP0C6sRoiLgtoBksNbBd6zC1wTnSYkyopAsTpd8Jg6rKDCnVbvLIwGX+k1zcB71TdIda7k+YyLs3PeQ/oQQY0YU02/gkYcKuI7iqOaG3XmlPV8Odb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcyDWdmk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752053771; x=1783589771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=57HpAVIBYUev31ZQjRb5VYE7UT3RT7/5h4EqYhfyAyM=;
  b=ZcyDWdmkmG0BQ+R7kBobL5wjvqk4wgKxnsuqIascgYvfMl3SuiueW0rB
   etFjPimesTmP65SpGJusu3tvt/8Khr2YGA6MSsaE43937d1AhL+YbPwVh
   IDKwdacK1Cps8wbaNVLUcihQaXavTv9j8r8aSoqp0DYoAQ9mbU24784ti
   ajC6b6pPxYMwj6dz6IEARI5VPqurDl8u6AuHhFOyaJM1ySvo1Sa9DapES
   xqSqfsXn8s/G59UMgvbTE18FuqMnAQ4z1m17tB+QFP5ginTZZt3YfGA6I
   jTrAyAkOTbp5bGKTkf406rYvMuzWdztUCWXDhs12R6PURSHRW3v1sDYAS
   A==;
X-CSE-ConnectionGUID: NGf3LoUXRDa9MGivH/7W1g==
X-CSE-MsgGUID: AFD8xtq9SgmnVfZ5Bi6Pig==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56913868"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="56913868"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:35:56 -0700
X-CSE-ConnectionGUID: XOJPCdnTS0u1auLG4BTfSg==
X-CSE-MsgGUID: GwG8U9/ITr+FQool+KFrhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155464607"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 09 Jul 2025 02:35:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0CF1F1B7; Wed, 09 Jul 2025 12:35:42 +0300 (EEST)
Date: Wed, 9 Jul 2025 12:35:42 +0300
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
Subject: Re: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <iebitnv533feb5axuf4jtgetajwmwgvaocmanw6swejv5cfxrd@numffxr7uj4p>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
 <53b8d516-5d19-4b3b-b7fa-99f1066f79fe@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b8d516-5d19-4b3b-b7fa-99f1066f79fe@intel.com>

On Tue, Jul 08, 2025 at 06:08:18PM -0700, Sohil Mehta wrote:
> On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> > From: Sohil Mehta <sohil.mehta@intel.com>
> > 
> > For patching, the kernel initializes a temporary mm area in the lower
> > half of the address range. See commit 4fc19708b165 ("x86/alternatives:
> > Initialize temporary mm for patching").
> > 
> > Disable LASS enforcement during patching to avoid triggering a #GP
> > fault.
> > 
> > The objtool warns due to a call to a non-allowed function that exists
> > outside of the stac/clac guard, or references to any function with a
> > dynamic function pointer inside the guard. See the Objtool warnings
> > section #9 in the document tools/objtool/Documentation/objtool.txt.
> > 
> > Considering that patching is usually small, replace the memcpy() and
> > memset() functions in the text poking functions with their open coded
> > versions.
> > 
> > Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Kirill, it might be worth adding your co-developed-by tag. The patch has
> more changes than I can claim credit for.

Okay. Will do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

