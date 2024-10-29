Return-Path: <linux-efi+bounces-2056-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C29B567F
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 00:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AACF1F23DFC
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0E420C02F;
	Tue, 29 Oct 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JNg0BgvT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC920C010;
	Tue, 29 Oct 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243222; cv=none; b=hhrrITLKFfNrvWL0RvAZ5p+Fw6tJNFmj/trs2DFfcRUWYXPcncMlujW1/kQNiiYCqOY2CAZw3LTzRG6lpx4ETO9T377XiT1emWuXGvGmJECw8K+jFO6ydZz9oKUtqKC4Slh1iFt9V7cVWIJEY1W7TbLKS4oIrmgm7O1WEeDgZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243222; c=relaxed/simple;
	bh=SZfWRojPKRj/QMHbVbiZftAEiOO0Fj7sz5Cu5qZPY9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfXavvd1RNB1ew2ZGQ6kMV8sT9yHE7Gk2b3eL+5E0pqWdYOSub+d+nek6205pSaFy66iaC8mRtN/Q/tIS1KNGm83KGkwEff21tZCM+Uqm8l9/0ZjzFkm14f1KJgsTtoRK/ENJtxWRbnLa1JZevBelSpQmYcs/K+94IghGPflifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JNg0BgvT; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49TN5w1H579040
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 29 Oct 2024 16:05:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49TN5w1H579040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730243162;
	bh=JhctH8JV5OEarLmfDsY60GKnKpJkPqEFlwdBmGsg578=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JNg0BgvTe5Iy1C4piQZT+QrNk7KVzqcucI2N5oTTMhPIwvuTxVXIGi8FFnuE9dkmf
	 NtSdgtbWZNIKaAcfLeE/9sPVwXw56lu0bhlJqEqvzwmIlIQ9Zn9ND74+o5877R+npw
	 qR/mYaooYZBsbPXHyeHTP0n3h4To82so9Ueq4T7dj8cnjtqJGk9fA+evqhMBrd6Q9H
	 rXekf6omKcdgijjksg+KF/z8+o+o11kYVTSnecROknQKzI4+pqtDNZPJqUuMcaqcN9
	 rsIGwMtEhaww1qs8bFm8nNaca/UBhltEWatrsVY0TaYdwlNdvYdCjCKVu7SGe9xmvG
	 LTbU0JTQB1hAw==
Message-ID: <aa3dc7dd-8939-4042-9e02-96dd29e45095@zytor.com>
Date: Tue, 29 Oct 2024 16:05:58 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
To: Dave Hansen <dave.hansen@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
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
 <869c1545-8c94-4820-a861-fbc563056597@intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <869c1545-8c94-4820-a861-fbc563056597@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 16:03, Dave Hansen wrote:
> On 10/29/24 15:59, Luck, Tony wrote:
>>> *IF* we switched things to do text poking in the upper half of the
>>> address space, we'd probably want to find a completely unused PGD entry.
>>>   I'm not sure off the top of my head if we have a good one for that or
>>> if it's worth the trouble.
>> I expect that would be easy on 64-bit (no way the kernel needs all the
>> PGD entries from 256..511) but hard for 32-bit (where kernel address
>> space is in critically short supply on any machine with >1GB RAM).
> 
> Yeah, I was talking about 64-bit only.  On 32-bit PAE a PGD maps 1/4 of
> the address space which is totally unworkable for stealing.

But it is also not necessary.

	-hpa


