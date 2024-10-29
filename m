Return-Path: <linux-efi+bounces-2052-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87E9B5613
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7421C222B5
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC220A5EB;
	Tue, 29 Oct 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3k0eHt4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4918FDC5;
	Tue, 29 Oct 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242384; cv=none; b=DZkP3/BJIa2s1DhAnx8o2c4QmdJD7rPdxc5GjKHyBH29XKxq3unAjphdQAG4dd94xEL3kFOCKXSYLxzBFbq8QjBEr0ERXw0Ls2K3CDVOl7ncIHp0uyvyU2o0n4uT2J4olN0trfoS5dVmctwYgO5jEUO0USEZgODR3o7yw9OfpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242384; c=relaxed/simple;
	bh=oqY3C94ohRqnHtW/e8Iz2bXR2pL5Okjtu2Hpx5KAY7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0tagAQbNrlJhvIXThmOZcqWm8d+bOHqA6cWyvM8NoaUCxdAlKyq2v4d6rRICbjaCKhHtZ2xRADj97cW8AZtQgijWSYBJRDWkQ2+WEoov8vml8iHeAtlBs5Fpca60cLWtY2SxCLhUKb7YBKnzBv/pAhtdnN95ugTRldMAWMKumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3k0eHt4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730242382; x=1761778382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oqY3C94ohRqnHtW/e8Iz2bXR2pL5Okjtu2Hpx5KAY7g=;
  b=Z3k0eHt4m1lTui2OosRhJehx8FcJ5cgAFstVPXs+lMvYKqPgsaJbk8Yk
   nY7OLtK3cHqHIRDyBqGRkelw9qszL++J3cvR1jGe1CT5EhjY0uiyP/yn1
   AqmSbxXzon56viuUhFY4ZHAghBnZWbLVjQydbM6MWb7v7ny3fcSqr47X4
   isk5zLchdsC5tkQDSfDbFvhf80SGgH7hHpVOMMobs0ZegxyVQAejh5Oe3
   sD5Ie7XU8nA0O1JzxhWRVpquHyaBcK5Rl8S4AvaC22Tn4A2CK/ziFyimC
   ukGFLoGa8PTJ7/s8zVFCbSm+ZujoKvY7dYjg0kuTrvlArIxn4RdpHjiVc
   w==;
X-CSE-ConnectionGUID: IIZl23VDTW6D0HQkxj0T3g==
X-CSE-MsgGUID: ibTIcoADToCKVfzqIItRdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40446610"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40446610"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:53:01 -0700
X-CSE-ConnectionGUID: FRfLDNTbT5Gspda/qNXMbA==
X-CSE-MsgGUID: x/D1vjGHS2i/pItwhwIIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="119597143"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.223.38]) ([10.124.223.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:52:58 -0700
Message-ID: <34dd023d-3ed5-4655-88be-14a7a300b91e@intel.com>
Date: Tue, 29 Oct 2024 15:52:56 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
To: "Luck, Tony" <tony.luck@intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>,
 "Li, Xin3" <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Alexey Kardashevskiy <aik@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 "Huang, Kai" <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
 Breno Leitao <leitao@debian.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
 Juergen Gross <jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>,
 Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
 Changbin Du <changbin.du@huawei.com>,
 Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
 <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
 <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 15:26, Luck, Tony wrote:
>>  	/*
>>  	 * This needs to follow the FPU initializtion, since EFI depends on it.
>> +	 * It also needs to precede the CR pinning setup, because we need to be
>> +	 * able to temporarily clear the CR4.LASS bit in order to execute the
>> +	 * set_virtual_address_map call, which resides in lower addresses and
>> +	 * would trip LASS if enabled.
>>  	 */
> 
> Why are the temporary mappings used to patch kernel code in the lower half
> of the virtual address space? 

I was just asking myself the same thing.  The upper half is always
mapped uniformly.  When you create an MM you copy the 256->511th pgd
entries verbatim from the init_mm's pgd.

If you map something the <=255th pgd entry, it isn't (by default)
visible to other mm's.  That's why a new mm also tends to get you a new
process.

> But couldn't we map into upper half and do some/all of:
> 
> 1) Trust that there aren't stupid bugs that dereference random pointers into the
> temporary mapping?
> 2) Make a "this CPU only" mapping
> 3) Avoid preemption while patching so there is no need for TLB shootdown
> by other CPUs when the temporary mapping is torn down, just flush local TLB.

It's about enforcing R^X semantics.  We should limit the time and scope
where mappings have some data both writeable and executable.

If we poke text in the upper half of the address space, any kernel
thread might be exploited to write to what will soon be executable.

If we do it in the lower half in its own mm, you have to compromise the
thread doing the text poking after the mapping is created but before it
is invalidated.  With LASS you *ALSO* need to do it in the STAC/CLAC
window which is smaller than the window when the TLB is valid.

*IF* we switched things to do text poking in the upper half of the
address space, we'd probably want to find a completely unused PGD entry.
 I'm not sure off the top of my head if we have a good one for that or
if it's worth the trouble.

