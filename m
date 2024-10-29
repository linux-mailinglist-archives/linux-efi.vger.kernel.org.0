Return-Path: <linux-efi+bounces-2055-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CE9B5654
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 00:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6DD1C21947
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF420B219;
	Tue, 29 Oct 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aJTIJb8M"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285E20B1E1;
	Tue, 29 Oct 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243027; cv=none; b=mcVL+s4dXxOr2MB8fRvDl0qvmN5+93qU4RnhvAhK9mBDAdGDp9KFExCMQrjPz1XqwBDaAPfyeAwIDKmseS6X45mooo9RMkMj55Irdzt8qQTqnD4NF0FxJQKhuJaXYEpdrUZo+aJIvSmjZwRbjltdyf6FuvsuEnHMeHR01o9gxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243027; c=relaxed/simple;
	bh=f50WIGB6k8MKzfsAMf7r8sByA9LZjnrApaTM0Y6lrmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDaa1Npn89i7nbLca1575pMoXzNunJGfAFoic55Znu1ObrXJhkceKksn1NlVppAKOZjp/xbR3TJ1FMrVtMtWjeZ0Lg8AbAnhedoc54aX2rMcybga39VTnjs0jc3WXn7x+F8/KgjTUdL3SzziApjk9qMMMLRz5UvDBhCehCCZMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aJTIJb8M; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49TN2P7E576167
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 29 Oct 2024 16:02:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49TN2P7E576167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730242949;
	bh=QkS6mIcMvK7AV9IhJUXopZimVR3qjiZ+/eJ25ztftAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aJTIJb8MolXNM4Ur8fRnW/NKuzEbzfOjeSmli0QgYXf0nbD3QCkLFuq9iBg9Fty98
	 6n7BfcdA9ff8F60jIm356PeSOum9AuRok/6gFZQxNLess6Z6tU7jH5uZIw/xmh0RC4
	 vAYzZzj5/EdpbzeojU35mljKRWRksi2cGhFd5/4TLF6aVqsYFmvyHH9vJihvwcMpGE
	 0VnsDZkViUbUeh+QJiHYpZt/4h0eAT+mThHezR6lLhuKS93RBXSobLVfEyfv+UOFiv
	 5mykH7paFCgrebLadQ2iNXYFa8+n+ywyYTzxqqdocVqk9P3xSO5eKzXtY2f/UBr1IT
	 yAGpxHwvnrPIw==
Message-ID: <ae1ce014-cf09-4e92-8d93-282042975aee@zytor.com>
Date: Tue, 29 Oct 2024 16:02:24 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
To: "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave"
 <dave.hansen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org"
 <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexey Kardashevskiy <aik@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
 <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
 <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34dd023d-3ed5-4655-88be-14a7a300b91e@intel.com>
 <SJ1PR11MB6083CA923D92CD70AE6C5FB9FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <SJ1PR11MB6083CA923D92CD70AE6C5FB9FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 15:59, Luck, Tony wrote:
>> *IF* we switched things to do text poking in the upper half of the
>> address space, we'd probably want to find a completely unused PGD entry.
>>   I'm not sure off the top of my head if we have a good one for that or
>> if it's worth the trouble.
> 
> I expect that would be easy on 64-bit (no way the kernel needs all the
> PGD entries from 256..511) but hard for 32-bit (where kernel address
> space is in critically short supply on any machine with >1GB RAM).

No LASS on 32 bits...

	-hpa


