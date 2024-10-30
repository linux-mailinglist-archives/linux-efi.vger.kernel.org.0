Return-Path: <linux-efi+bounces-2063-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B49B5D12
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 08:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA75D1C20DFA
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6A1DF987;
	Wed, 30 Oct 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRJfcRzT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7C54BD4;
	Wed, 30 Oct 2024 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274056; cv=none; b=JGM9RGitHvUI9PkCiD+FxnYKJBqj0RdE9jDXySVcnIRNb2IxTrzVFXbMO1mQhYdBJWYJY0livWzzS+v7//Ai5Pmg6adDX/48SD9s6GvIdIMUN14E91X8aYByGBC/ehElv4UCkyBZP0dL+BMowf5x29R/3Q2V6C6qlsGBD/o3Vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274056; c=relaxed/simple;
	bh=eSqWFRIQnRvRRjhGGysN8HKp4eg/vPUz0KXMyPn7OE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pB+Z7CKxWQ+yPUpiFVTR8N2aknBCu5E+EigPQmQbX3B16wbnCuY5yAvRnFTRsFUOmTLxT6taXVjZVOnWN+Nu8EX47/aHD0Dc+muUNCZS8BOriu/JKguXzT20tBhISDGkvyrWFxUmiPVrj+0eN+Sux3NxrjOK5mQlOE4Abva/978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRJfcRzT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730274055; x=1761810055;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eSqWFRIQnRvRRjhGGysN8HKp4eg/vPUz0KXMyPn7OE8=;
  b=mRJfcRzTkV4C9hTOk1jaAMEkz9aFgPWIIJhKd+yqkZiooSgvDgiOtsNm
   u+42PYjSzXUBE7wwndpliLzYVj1Q/RGBCjc7hZ4kgqtyqYHX7pBQbV0tJ
   PHX5FAx+AZNEuJ/A2FHf/Xz47CWK7xMuFwVbziz77VlotYwOsYgqM0Z+v
   MwTaqvO5gc61hQCD811aIvamF+ExdRSgj7/ADspNm9VNrHmDGFw2OR7RU
   07yoR1Cv29x5/zAfjM1Ui6cpj2oUHbmkSl2aCsVc9Al26vbQGn/sdWMdh
   kOdajEOxbTG26Xy5gPzpxhrqguiX6IZzQn7HCo2DUKFwZ/pOILhnqKIB0
   Q==;
X-CSE-ConnectionGUID: XjLH+7WqS5uqp1Z2lNqYEA==
X-CSE-MsgGUID: Dq7vwrG8QMy1Ws0TAtUUtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30106526"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30106526"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 00:40:54 -0700
X-CSE-ConnectionGUID: gjNB63zcTO+mIRhaK2mr5w==
X-CSE-MsgGUID: 1/hes1Q6QZGqBhXSTnOFHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82644102"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orviesa007.jf.intel.com with ESMTP; 30 Oct 2024 00:40:41 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song
 <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Michael
 Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Jonathan Corbet <corbet@lwn.net>, Sohil Mehta
 <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
 <jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
 <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
 <changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Namhyung Kim
 <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v5 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
In-Reply-To: <20241029184840.GJ14555@noisy.programming.kicks-ass.net>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-4-alexander.shishkin@linux.intel.com>
 <7897bc3e-2d68-4aef-8668-f6eb9f8efd7f@intel.com>
 <20241029113611.GS14555@noisy.programming.kicks-ass.net>
 <20241029184840.GJ14555@noisy.programming.kicks-ass.net>
Date: Wed, 30 Oct 2024 09:40:41 +0200
Message-ID: <87jzdqt4w6.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Oct 29, 2024 at 12:36:11PM +0100, Peter Zijlstra wrote:
>  static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
>  {
>  	void *ret = to;
>  
> -	asm volatile("rep movsb"
> -		     : "+D" (to), "+S" (from), "+c" (len)
> -		     : : "memory");
> -	return ret;
> +	asm volatile("1:\n\t"
> +		     ALT_64("rep movsb",
> +			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))

I don't know if it matters, but this basically brings in a whole memcpy
to a text_poke situation, which should only be a handful of bytes, and
creates a new stack frame in the !FSRM case, which the __always_inline
was intending to avoid. But given what text_poke is, maybe micro
optimizations don't really matter. And fewer memcpy() implementations
seems like a good idea.

Thanks,
--
Alex

