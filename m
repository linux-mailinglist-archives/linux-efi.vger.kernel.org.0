Return-Path: <linux-efi+bounces-4080-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98260AF083C
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 04:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B47A9654
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC144C77;
	Wed,  2 Jul 2025 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="E9tdaCIl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFEFA933;
	Wed,  2 Jul 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421741; cv=none; b=f5hLCheFoicNcxRhOpD7/MOepNiCYPnzpVV0D8gtaicSELF+HT94v5bmI51XiXzzC5z9NrXyzmQ5e9G7zUUZdqefXigCfcKrfUzhYYqGXZjubtLf8rwAVkSBmNWEvHINLc+wgUvKkZx+gSQ6ti/HWC0SBDk49uu2BOFdIcq604k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421741; c=relaxed/simple;
	bh=hzNyt4OsXsTplu2/gsTkh57eENzJE8o2yhf0YMOWyxY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Si7Ngaa35qUe0+F0IpZMIEyMAlRAXfi/sANby6W5UTUD/lWX/o3EZZlCHGMboze0aAR7XI0EKwLFTxHQyShVtQfCseDF7c8s9sbEeFG1XX8ebSCnO7e8XBWGw7CqpUkiytMZXpiniHiyfDfR6+1HKDGOohbuVAIoE0xRirDH9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=E9tdaCIl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56220cdX457483
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 1 Jul 2025 19:00:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56220cdX457483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1751421644;
	bh=xsBLzF3UyZbaFPKi2ZS9R/n92G41U6FG3scZwTR38ro=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=E9tdaCIlWT+jCmX/+CfRzVCcIpysnoePPDS0qBRG+lh62cVFQRL0dxVWZRJ3LnScw
	 Tsashqy1y3xJZSpEXwiZ9Qu00tOwNawGjNZE+YNOgxYveInrBPbuugBo1Uc6hSKIdh
	 dwii7pNyjYiH65+CHzJw7yze/mhjXafHpTqB1NLmmTuwBJDMuR6TQqD8gMkGdYg2Fe
	 Hd1DsC8LD9MtNVn6u2hbb1tv6engmhSynp0QaC9W2InnY4Bs1dgNMJeSh8bBEGujaz
	 l7TIiwlZdLySQWzRmZ31mFWxuqtlh4bJvgcXrWFWKSzjO5tly2wZIJOrQ7zynooele
	 fPnwxEZaa89/w==
Date: Tue, 01 Jul 2025 19:00:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
        linux-mm@kvack.org
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
User-Agent: K-9 Mail for Android
In-Reply-To: <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com> <20250701095849.2360685-15-kirill.shutemov@linux.intel.com> <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
Message-ID: <3D770C94-8BB8-4D71-BF48-6FA78C1DA967@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 1, 2025 6:35:40 PM PDT, Sohil Mehta <sohil=2Emehta@intel=2Ecom> wro=
te:
>On 7/1/2025 2:58 AM, Kirill A=2E Shutemov wrote:
>> LASS throws a #GP for any violations except for stack register accesses=
,
>> in which case it throws a #SS instead=2E Handle this similarly to how o=
ther
>> LASS violations are handled=2E
>>=20
>
>Maybe I've misunderstood something:
>
>Is the underlying assumption here that #SS were previously only
>generated by userspace, but now they can also be generated by the
>kernel? And we want the kernel generated #SS to behave the same as the #G=
P?
>
>> In case of FRED, before handling #SS as LASS violation, kernel has to
>> check if there's a fixup for the exception=2E It can address #SS due to
>> invalid user context on ERETU=2E See 5105e7687ad3 ("x86/fred: Fixup
>> fault on ERETU by jumping to fred_entrypoint_user") for more details=2E
>>=20
>> Co-developed-by: Alexander Shishkin <alexander=2Eshishkin@linux=2Eintel=
=2Ecom>
>> Signed-off-by: Alexander Shishkin <alexander=2Eshishkin@linux=2Eintel=
=2Ecom>
>> Signed-off-by: Kirill A=2E Shutemov <kirill=2Eshutemov@linux=2Eintel=2E=
com>
>> ---
>>  arch/x86/kernel/traps=2Ec | 39 +++++++++++++++++++++++++++++++++------
>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/traps=2Ec b/arch/x86/kernel/traps=2Ec
>> index ceb091f17a5b=2E=2Ef9ca5b911141 100644
>> --- a/arch/x86/kernel/traps=2Ec
>> +++ b/arch/x86/kernel/traps=2Ec
>> @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
>>  		      SIGBUS, 0, NULL);
>>  }
>> =20
>> -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
>> -{
>> -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
>> -		      0, NULL);
>> -}
>> -
>>  DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
>>  {
>>  	char *str =3D "alignment check";
>> @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>>  	cond_local_irq_disable(regs);
>>  }
>> =20
>> +#define SSFSTR "stack segment fault"
>> +
>> +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
>> +{
>> +	if (user_mode(regs))
>> +		goto error_trap;
>> +
>> +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
>> +	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
>> +		return;
>> +
>> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>> +		enum kernel_exc_hint hint;
>> +		unsigned long exc_addr;
>> +
>> +		hint =3D get_kernel_exc_address(regs, &exc_addr);
>> +		if (hint !=3D EXC_NO_HINT) {
>
>The brackets are not needed for singular statements=2E Also the max line
>length is longer now=2E You can fit this all in a single line=2E
>
>> +			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
>> +			       exc_addr);
>> +		}
>> +
>
>> +		if (hint !=3D EXC_NON_CANONICAL)
>> +			exc_addr =3D 0;
>> +
>> +		die_addr(SSFSTR, regs, error_code, exc_addr);
>
>The variable names in die_addr() should be generalized as well=2E They
>seem to assume the caller to be a #GP handler=2E
>
>> +		return;
>> +	}
>> +
>> +error_trap:
>> +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
>> +		      0, NULL);
>> +}
>> +
>>  static bool do_int3(struct pt_regs *regs)
>>  {
>>  	int res;
>

An #SS can be generated by the kernel if RSP is corrupted=2E This is fatal=
, but as always we want to get a message out=2E

