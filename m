Return-Path: <linux-efi+bounces-3895-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8BAE26B3
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 02:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261BA3BAE67
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD75695;
	Sat, 21 Jun 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y75q0L7H"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E76136;
	Sat, 21 Jun 2025 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750466822; cv=none; b=NM8jzVXl9max6yXDcwld8GhpbQabHaaI61uq7zW6IC4Dj3j6zuIDfmrOFGdC2hSwVDZKQWuPf72952dxMVZQVR5Gu/7uBhNA69X45p6Z6U5aBir5wDLl2H6sLFU26unUkGvUA+oYbofbY0FpQzGbuH0kJx1be/M81exkaEo612E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750466822; c=relaxed/simple;
	bh=i/YXw29fFmHQpzSs5Fl6EM8Oy29peb0zYlxMPflx9s8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z94XS0Oou+95H9ktY1VnlLVFOxeTCxk435vQNXagOLYl21o5HYaSggT7jFX3gpFSyHxqGyYHY2CUnozIF61ELF9VyXHUSoJBNQlKDHc9/r5fsXQiRLOWHV16M6Jp6qFjpKHipR0+94BJqWiDPpdSB4hGt/kUeY4cIyrnJy2jEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Y75q0L7H; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55L0jkwd005127
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 20 Jun 2025 17:45:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55L0jkwd005127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1750466754;
	bh=SozjncbjIgbRZKFKMsBb5zTkiUYeneB0+jkJcg4j6s4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Y75q0L7HtfSeWqBkKbDOfuH9lSjkL34QWktpd4ex6AP/CBySW6NdTYZEUdVnTESx4
	 neNn/2g/zEnLNRRb0LID7jnyYFmbIDucsXWk/r9fmZdW/xqt1UKeTACF77RfNUcPR5
	 IDJfNYVHFswnY+/ziZEvPwL1NOcqHrNzkOmRPigLHm51n9BOetoF9a/FnhVLX5kzh+
	 ceqXED9/YAtIQzMBxHkzPV/KJfxDUIPKk8i1YGXE0B8eEGMrRhUVreNBQ4CBuma8Yc
	 l/PFAkfe2Iv+7xiT4zPRljgG9XsHRzjVyDbC5Er8Kb8rapy8AAVqZO46GVEHTTgrEl
	 bJTn5MZgQE5GQ==
Date: Fri, 20 Jun 2025 17:45:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
        linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <aa91aadb-758e-42db-86ab-451384e466ed@zytor.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com> <20250620135325.3300848-2-kirill.shutemov@linux.intel.com> <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com> <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn> <aa91aadb-758e-42db-86ab-451384e466ed@zytor.com>
Message-ID: <D8783A84-119A-4981-9EB1-12C21BB34714@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 20, 2025 4:46:21 PM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 6/20/2025 10:31 AM, Kirill A=2E Shutemov wrote:
>> On Fri, Jun 20, 2025 at 08:36:30AM -0700, Xin Li wrote:
>>> On 6/20/2025 6:53 AM, Kirill A=2E Shutemov wrote:
>>>> diff --git a/arch/x86/Kconfig=2Ecpufeatures b/arch/x86/Kconfig=2Ecpuf=
eatures
>>>> index 250c10627ab3=2E=2E9574c198fc08 100644
>>>> --- a/arch/x86/Kconfig=2Ecpufeatures
>>>> +++ b/arch/x86/Kconfig=2Ecpufeatures
>>>> @@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
>>>>    	def_bool y
>>>>    	depends on !X86_64
>>>> +config X86_DISABLED_FEATURE_LASS
>>>> +	def_bool y
>>>> +	depends on !X86_64
>>>> +
>>>>    config X86_DISABLED_FEATURE_PKU
>>>>    	def_bool y
>>>>    	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
>>>=20
>>> You don't need to add X86_DISABLED_FEATURE_LASS, because the LASS code
>>> is NOT optional at build time, i=2Ee=2E, you now don't have CONFIG_X86=
_LASS=2E
>>=20
>> Hmm=2E But it is optional=2E It depends on CONFIG_X86_64=2E I don't thi=
nk we
>> want it to be advertised on 32-bit kernels=2E
>>=20
>
>I kind of ignore 32-bit=2E=2E=2E
>
>But I simply hate adding a disabled feature that depends on !X86_64;
>x86_64 has a broad scope, and new CPU features are often intentionally
>not enabled for 32-bit=2E
>
>(X86_DISABLED_FEATURE_PCID is the only one before LASS)
>
>

More importantly, it is wrong=2E=20

The 32-bit build can depend on this feature not existing, therefore it SHO=
ULD be listed as a disabled feature=2E

