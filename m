Return-Path: <linux-efi+bounces-3944-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0881AE5BC8
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 07:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851844327A
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1822D4DE;
	Tue, 24 Jun 2025 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f6kUcw3d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAE2253E9;
	Tue, 24 Jun 2025 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750741938; cv=none; b=QfoSk5K72JsPq9eajE5mX4xIiUAimvSh5h1RJIvsEyoZ9SRFKZxmU2TqNpTlXnaakQBAfSCo5xNT+bjuoNp+QKiNlx7ftGcgczZjacrlFzubPoksGdwxXNMbMSFOP+iN1H+jCVwNPBsa9pyT/XqkHG15O9pwbgE/14IqwY2RA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750741938; c=relaxed/simple;
	bh=R9jolyBeToWMbGoUct/gN1lHCvix5RrQdEKK1lIPCbU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XdnGDUC0UhgLCggSLYhmYbR5eLIXWcG/MDYcJ5rhfQh6my28pavNCVZiy3tGM/W0Uz0qsRAIc7DCOVXNCdIgpRihw6HwpvL+LITtTa6D9vvrJmB91q9l6selmnO4g+0vqAEZ7a5xYym36ju36vifWjtYbHAo8nWgZDblIytQrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=f6kUcw3d; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55O5B9EQ1214832
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 22:11:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55O5B9EQ1214832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750741873;
	bh=hyBq9kZTajfYMQM3o1zuSl07WmRWLe3Uj8KJJs7+GtI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=f6kUcw3dSL+EV9uGfmbKUBMJgwgWc6UN73DVS6weHEHIb0jsrrDw9NrtKF6AFJvCw
	 JnoJ3nFKC04S9WVqdfOZtnvgnrHnj14GFYF7w3m7WUNICB3MYX+oquhZgnLJZ84smm
	 uotpg9ZpzzrGlwPnbcPZRZZsqcKrc2gC+kExlQx4EzuSZ0almAaMM05OIMxosP3nBz
	 bDQXKCgLUVij5bsKji1WRwegftu0ZhWSan+nwMKg3Xadf77LkyLX/T9LKI0PxQu7x3
	 PU6Fag4XBwD82PGoElGA4yGDKbYYsksS5xgVj6A1pF7+czgVchdaAw89AzXNm2/85C
	 vSVZpF1aVJwqw==
Message-ID: <f3dbf693-8c88-4736-9ec9-83bedc097c2b@zytor.com>
Date: Mon, 23 Jun 2025 22:11:08 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
From: Xin Li <xin@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
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
        linux-mm@kvack.org
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com>
 <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn>
 <aa91aadb-758e-42db-86ab-451384e466ed@zytor.com>
 <D8783A84-119A-4981-9EB1-12C21BB34714@zytor.com>
 <f04936b7-e1e1-4a63-a907-33315af0dd8f@zytor.com>
 <73796800-819b-4433-b0ef-db852336d7a4@zytor.com>
 <0A71C898-B587-4292-AB05-6CA46BBD6F88@zytor.com>
 <5529aa92-191d-4120-a005-28fe5c209a4f@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <5529aa92-191d-4120-a005-28fe5c209a4f@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/2025 9:57 PM, Xin Li wrote:
> On 6/23/2025 7:04 PM, H. Peter Anvin wrote:
>> On June 23, 2025 10:40:59 AM PDT, Xin Li <xin@zytor.com> wrote:
>>> On 6/20/2025 5:50 PM, H. Peter Anvin wrote:
>>>> On 2025-06-20 17:45, H. Peter Anvin wrote:
>>>>>>
>>>>>> But I simply hate adding a disabled feature that depends on !X86_64;
>>>>>> x86_64 has a broad scope, and new CPU features are often 
>>>>>> intentionally
>>>>>> not enabled for 32-bit.
>>>>>>
>>>>>> (X86_DISABLED_FEATURE_PCID is the only one before LASS)
>>>>>
>>>>> More importantly, it is wrong.
>>>>>
>>>>> The 32-bit build can depend on this feature not existing, therefore 
>>>>> it SHOULD be listed as a disabled feature.
>>>>>
>>>>
>>>> Ok, that was word salad. What I meant was that the original patch is 
>>>> correct, and we SHOULD have this as a disabled feature.
>>>
>>> Agreed!
>>>
>>>> The reason is that it reduces the need to explicitly test for 32/64 
>>>> bits for features that don't exist on 32 bits. When they are flagged 
>>>> as disabled, they get filtered out *at compile time*.
>>>
>>> It's better to make it depend on X86_32 directly rather than !X86_64:
>>>
>>> config X86_DISABLED_FEATURE_LASS
>>>     def_bool y
>>>     depends on X86_32
>>>
>>>
>>> But the disabled feature list due to lack of 32-bit enabling will keep
>>> growing until we remove 32-bit kernel code.
>>>
>>> Wondering should we bother enforcing cpuid_deps[] on 32-bit?
>>>
>>> IOW, turn off the feature when its dependency isn’t satisfied on 32b-it;
>>> don’t just throw a warning and hope for the best.
>>>
>>> Thanks!
>>>     Xin
>>>
>>
>> We should have the dependencies enforced; in fact, preferably we would 
>> enforce them at build time as well.
>>
>>
> 
> Yeah, sounds something we can do later :)
> 

We could introduce a new Kconfig file at

     arch/x86/Kconfig.cpufeatures.disabled_on_32bit

to track all features disabled due to lack of 32-bit support.

