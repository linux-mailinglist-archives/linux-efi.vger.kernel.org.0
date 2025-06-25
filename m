Return-Path: <linux-efi+bounces-3995-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DAAE8D09
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 20:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2514A1409
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DE2D6609;
	Wed, 25 Jun 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="T4uM1rib"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338901CAA7B;
	Wed, 25 Jun 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877562; cv=none; b=Ow3LrPGL7PDsiKLeECCw7P7XLD+I6O/bzUU1FxxlGXA7RcostDhTv5/ax/onVH9f2YQNxl9G80nDZHrNQaDL/CE9y5WVe26spRUyHHjklmbyLYRbg1gXdmiXvhQnicspTP5wJQwevss5quvGxQCA0hpB0C+6joHfgt8nifyq77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877562; c=relaxed/simple;
	bh=2nvC8O6b/AQv/t5IaxRmHCt0KR1zV8JbPK258zgApyo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NAzPBP+qWSqZ9aV+SznAfBA8HtgKmYqjOCgfoSzToKZmLJQ72ihdkX991xzxRdC5TcPn0wSYY10el53SyIdv7uYLRNdaTZJ/bE3IFGTb0WBl8Xbp1RshVbyXO3GbtLUPlRoaHB/8GqeYzq6Xq4cgi8sEgHsQuylozQCXitA907E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=T4uM1rib; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55PIpReE1893008
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 25 Jun 2025 11:51:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55PIpReE1893008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750877492;
	bh=N2YGqiZBGlO6E2pCvNxokF1iVnO9tprfKl6nqK15f7Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=T4uM1ribSNJKs3WHN1pHdyHhSope6PhIW4wyzfSNMx2tpP1w2IBhSFlFMiaHsho/m
	 7Wz/UJGtehR+fUj4tSpmUubhuu+k47y9Yz+imDe03hW32zObTCMViWML+TQybmWkF4
	 7sTE5spXJx1bKzdDxKLjkBVvZOfzIgax3hg98CCfNFroUV56fnJQ12QTDpfipSYmq6
	 XBrmJ4G1G1naZF09+cdJDMJI+ZWRR01dL64c4gcEy6p5RulFiQJJGe92XnAUpZ4mSB
	 QsTa1c5PNASclR2hntJQ2dT9nJ+AT7KZa2JgOVoicw0rP7V3jfWNyw0yWfmnhmGHGA
	 KEAYnAkOGVr0Q==
Date: Wed, 25 Jun 2025 11:51:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com> <20250620135325.3300848-2-kirill.shutemov@linux.intel.com> <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
Message-ID: <91ACE1D6-851A-413E-9F1F-F015A36FE49C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 20, 2025 11:14:56 AM PDT, Sohil Mehta <sohil=2Emehta@intel=2Ecom> w=
rote:
>On 6/20/2025 6:53 AM, Kirill A=2E Shutemov wrote:
>> =20
>> +/*
>> + * The CLAC/STAC instructions toggle enforcement of X86_FEATURE_SMAP=
=2E
>> + *
>> + * X86_FEATURE_LASS requires flipping the AC flag when accessing the l=
ower half
>> + * of the virtual address space, regardless of the _PAGE_BIT_USER bit =
in the
>> + * page tables=2E lass_clac/stac() should be used for these cases=2E
>> + *
>
>Is this supposed to be "regardless" or only when the _PAGE_BIT_USER bit
>it set? The way the sentence is worded it would seem that the kernel
>could always use lass_clac()/stac() since the value in _PAGE_BIT_USER
>doesn't matter=2E
>
>Please correct me if I am wrong, but here is my understanding:
>
>X86_FEATURE_SMAP and X86_FEATURE_LASS both complain when the kernel
>tries to access the lower half of the virtual addresses=2E
>
>SMAP flags an issue if _PAGE_BIT_USER is not set=2E LASS would #GP in bot=
h
>cases with or without the _PAGE_BIT_USER being set=2E
>
>However, in terms of usage, we want to use LASS specific stac()/clac()
>only when _PAGE_BIT_USER is set=2E Since this won't be flagged by SMAP=2E
>
>@Dave Hansen, you had suggested separating out the SMAP/LASS AC toggle
>functions=2E But, the difference in usage between both of them seems very
>subtle=2E Could this be easily misused?
>
>For example, there is no failure that would happen if someone
>incorrectly uses the SMAP specific clac()/stac() calls instead of the
>LASS ones=2E
>
>> + * Note: a barrier is implicit in alternative()=2E
>> + */
>> +
>>  static __always_inline void clac(void)
>>  {
>> -	/* Note: a barrier is implicit in alternative() */
>>  	alternative("", "clac", X86_FEATURE_SMAP);
>>  }
>> =20
>>  static __always_inline void stac(void)
>>  {
>> -	/* Note: a barrier is implicit in alternative() */
>>  	alternative("", "stac", X86_FEATURE_SMAP);
>>  }
>> =20
>> +static __always_inline void lass_clac(void)
>> +{
>> +	alternative("", "clac", X86_FEATURE_LASS);
>> +}
>> +
>> +static __always_inline void lass_stac(void)
>> +{
>> +	alternative("", "stac", X86_FEATURE_LASS);
>> +}
>> +

"Regardless" is correct=2E LASS only considers which hemisphere the virtua=
l address is located in, because it is explicitly designed to prevent walki=
ng the page tables in the "wrong" hemisphere and therefore speculative acce=
sses that happen to form pointers into user space addresses will not cause =
TLB or cache fills that might be possible to probe=2E

The obvious exception is when the kernel is intentionally performing acces=
ses on behalf of user space, which is exactly what SMAP tells the hardware =
already=2E

