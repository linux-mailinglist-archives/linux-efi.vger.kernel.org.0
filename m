Return-Path: <linux-efi+bounces-2059-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4689B571C
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 00:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E3B1F24018
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14020B216;
	Tue, 29 Oct 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aMMZ79vO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B820ADFC;
	Tue, 29 Oct 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245355; cv=none; b=GZHC4KZgnidN6HBF3JsjLc1euaWkr7gqVGtSawM3P4THQnC7xQ1SoalA1BLe9cEg712Ww94fjQq0RndkmKlLbMw6ICdUTqsQ9VeVBAhjMwGFZBIEgH+VZ6sxlejpyeDqA0yTAEnT4O882+7H/rCTLAs2+F1iaCA0AXAjxisaSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245355; c=relaxed/simple;
	bh=s11/RSSNd5eLw5Fbc7WixTPocGJ75zsFhB1GD96i6gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1+3ijbV9YTb/6d+rSsulk34AayLW21tgPRtF/5wDChkFo+2zH+JJslSl03GFjv1tT7QtTYRcY2nAhFfZOGtIfiyzKYctD8IpPr1G6yWsGap6Oh1m6wF2306crctVFMtgTpSAeJ4BYiitSMTqncbNFPzDygITWNmXp5k3ScMA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aMMZ79vO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49TNfXGb592027
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 29 Oct 2024 16:41:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49TNfXGb592027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730245297;
	bh=s8jD91ycoelRAi31peFqxGDoUYOmCn36Gpqbgv/Oxb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aMMZ79vO/9CZL/+2Slxl7Uhe1SXLMkFhDSfSsStEsgaMp8Gw7t9Xj1QmkgNDQJkbK
	 GRiop4Z2vAd3TZN51McsRNtKYCH4QO2rWitK7UlrERy3Es3Eq1JOzR1lBadKkGVI2C
	 kNdo2+/4xiSiJoB8LqZTUb+Fau+LVAxt+/JgqAHfSF5oMysVhf81ha+bOInT11kzoW
	 D1vj+IDEtjWBMJubKqo5Cg9Dc9eMlz+iFx3NYNFxIeBt3YUmuoa2Lax9ZApIrL6hde
	 /4Aw4t8cndU3ktlpF3aRf4ezFRtme4aIKiRva8hGBH5CD9nc9one1XIhBQQi2uDVZ/
	 gXm8yAd+oR5jQ==
Message-ID: <2e1c3685-6e6b-488d-ad8e-268193b13739@zytor.com>
Date: Tue, 29 Oct 2024 16:41:33 -0700
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
 <869c1545-8c94-4820-a861-fbc563056597@intel.com>
 <aa3dc7dd-8939-4042-9e02-96dd29e45095@zytor.com>
 <SJ1PR11MB6083BB83EE16AEAD6D3F7C1BFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <SJ1PR11MB6083BB83EE16AEAD6D3F7C1BFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 16:18, Luck, Tony wrote:
>>> Yeah, I was talking about 64-bit only.  On 32-bit PAE a PGD maps 1/4 of
>>> the address space which is totally unworkable for stealing.
>>
>> But it is also not necessary.
> 
> So maybe we could make the 64-bit version of use_temporary_mm()
> use some reserved address mapping to a reserved PGD in the upper
> half of address space, and the 32-bit version continue to use "user"
> addresses. It's unclear to me whether adding complexity here would be
> worth it to remove the 64-bit STAC/CLAC text patching issues.
> 

For 32 bits we can also simply use something further down in the 
hierarchy. It's not like we can afford to have the PGD be anything other 
than RWX on 32 bits.

	-hpa


