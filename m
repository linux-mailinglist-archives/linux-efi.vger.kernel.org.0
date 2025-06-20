Return-Path: <linux-efi+bounces-3894-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9CDAE2689
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 01:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56D04A5E07
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05123956A;
	Fri, 20 Jun 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S3NWUDY5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22E4C79;
	Fri, 20 Jun 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750463255; cv=none; b=sRB+3Umuxj+P9sH8n8Tag20HSILKM+U/cCNfhtT9Pn/19oZPNNFuYvmp1T93B88R4LNcJ149KuoqEaYDYGU/+X5hid8LbOhz4CK4Nw9nwCs3/l5JeWDkAjoO5L+5uhwTqkwAJA05M5cl5n1MHUolxGHuehXhsj18SVPywP5GOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750463255; c=relaxed/simple;
	bh=RxVi5nwXmp8M6jjP9e2EJacMPDYGns5DJZuGulFvfvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuQj9KmESKKLJ6i3/0xzOh3GpvMJiLQM4mnYHMLbSLOJv97UFtdNqTs1fM7TOVNbWZx1mZ5rkTz6RyTQPSvJ1z7WzxjmbVfjtNnSBnI1zuSwa4ZMlzyiA747tLQ6IEql5C8+zVycrQJxNt+yZH94paXozazZ5fqoDgbX6nJaYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=S3NWUDY5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55KNkMRm2688788
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 20 Jun 2025 16:46:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55KNkMRm2688788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1750463190;
	bh=40gKYnXltXyrwG1wEPpVQm7rYUrKhq5AMYqi5C6BXhc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3NWUDY5Fuh1GZtV4hRZIIADubXtAr1Tfd5R6g7Zr6H9nHlLuUNbaCuSGm/QBecI5
	 UbShea4fpDCqp2g6aMgDiT/Xcl+2R0S5Hpg5UdvvTnfHdOBXRXQSKgeo5PZ50SFQYB
	 iQ7ChGWDiBW1q8/xKznNtJ0XhBJX6N3wzYZ70BG8v7NWLdRljzs7ilqQMihPO3TYqA
	 aqhoLBKNDKT4/fcMFctM26xPcK9osLdgNADOOrO4KIxN9SaWQgCS34NfpOYozVAgDn
	 HpILOwHflqk7wpirq+gjg8C65LYTN/+5pbl/xnk9RQ9PnnEsb8YGcABR2QPyLpNmwt
	 Q9Rk+ke8vRlew==
Message-ID: <aa91aadb-758e-42db-86ab-451384e466ed@zytor.com>
Date: Fri, 20 Jun 2025 16:46:21 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com>
 <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/2025 10:31 AM, Kirill A. Shutemov wrote:
> On Fri, Jun 20, 2025 at 08:36:30AM -0700, Xin Li wrote:
>> On 6/20/2025 6:53 AM, Kirill A. Shutemov wrote:
>>> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
>>> index 250c10627ab3..9574c198fc08 100644
>>> --- a/arch/x86/Kconfig.cpufeatures
>>> +++ b/arch/x86/Kconfig.cpufeatures
>>> @@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
>>>    	def_bool y
>>>    	depends on !X86_64
>>> +config X86_DISABLED_FEATURE_LASS
>>> +	def_bool y
>>> +	depends on !X86_64
>>> +
>>>    config X86_DISABLED_FEATURE_PKU
>>>    	def_bool y
>>>    	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
>>
>> You don't need to add X86_DISABLED_FEATURE_LASS, because the LASS code
>> is NOT optional at build time, i.e., you now don't have CONFIG_X86_LASS.
> 
> Hmm. But it is optional. It depends on CONFIG_X86_64. I don't think we
> want it to be advertised on 32-bit kernels.
> 

I kind of ignore 32-bit...

But I simply hate adding a disabled feature that depends on !X86_64;
x86_64 has a broad scope, and new CPU features are often intentionally
not enabled for 32-bit.

(X86_DISABLED_FEATURE_PCID is the only one before LASS)



