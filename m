Return-Path: <linux-efi+bounces-4087-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612ECAF5B45
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C57E16F600
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE27307AFD;
	Wed,  2 Jul 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DXZ89xVF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7729CB2D;
	Wed,  2 Jul 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467163; cv=none; b=uEk+tYF/VOxINGQjdTwKMXAK87PYco1BSv8UjGEb1NzNvb9y4BLR8PAvb15XYJm64GREoNbjcdvqAw66Y3S+2Q7iVnGGmxYWfKPCnuCpMKfW/NiAxPxRkxrNbePSUIdqFubO5uMWI9AsGoaG/eaSnE5zfSpeQ20PmjIqFwjlkys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467163; c=relaxed/simple;
	bh=6pewEc5UG+XE1jh83JWAjxYS1jsdTJ0WsEn5Uctlnc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=C8DN0vH4adnJCLIN9lUG/sHgTVvKuQfYjGA93VQ6l5xoG/XCz+oM5Z6edCC9iQlsHVG8OdQEET8kQpMUKCAeaokETm5vJu4UcUa+LC0QV48b1q+WEQTrrmPjCV2fklzW9TXMk+fm8CbyLUrQZ5GdskZQno2tflrLJYEked7PiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DXZ89xVF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 562EbC76696595
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 2 Jul 2025 07:37:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 562EbC76696595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1751467037;
	bh=vedweYDuCMOClUg69BFkxDuS10njABpMhtr+ugtmIEs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DXZ89xVFv179csAkJagaK7K6kHQFaO1KDExUYRflFnbk1CKN98H2A3X0BW/Xn7CWK
	 p/lSdhUSOX3MLxFsLtQObgctvrt5fYTdx2cNChx0sxRkawi5k300cXWd33YvjZZXaX
	 ptnAP5XKgtfJAwKM2gbk0WhT1PWBFWHOjUhOzoS+4Tnc0JrzdAkcCLu+z/sbmt+ZuE
	 muZxbXuKzz/7sHrPRDIs6FwQyK7HKdhEmUXraWviKzczKfmEgA4gOl7SkARtW5uD2q
	 AdnNdI4UkMYSWpFMLcq7+Ekbou+vpcFC6tLJhkFkxx1i5Bfk2w8mGaXVqiBnr6r2hj
	 USlw9Y9IQLIZA==
Date: Wed, 02 Jul 2025 07:37:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
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
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
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
In-Reply-To: <5q2zbkzyjknusd3feqolycqialetqfe52yfyzasnr6zp24pmej@4cg2r2hi4pf2>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com> <20250701095849.2360685-15-kirill.shutemov@linux.intel.com> <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com> <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com> <5q2zbkzyjknusd3feqolycqialetqfe52yfyzasnr6zp24pmej@4cg2r2hi4pf2>
Message-ID: <DF2E7B41-46C9-4DAC-A671-EC8D6F53F496@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 2, 2025 3:17:10 AM PDT, "Kirill A=2E Shutemov" <kirill=2Eshutemov@l=
inux=2Eintel=2Ecom> wrote:
>On Tue, Jul 01, 2025 at 07:06:10PM -0700, H=2E Peter Anvin wrote:
>> On July 1, 2025 6:35:40 PM PDT, Sohil Mehta <sohil=2Emehta@intel=2Ecom>=
 wrote:
>> >On 7/1/2025 2:58 AM, Kirill A=2E Shutemov wrote:
>> >> LASS throws a #GP for any violations except for stack register acces=
ses,
>> >> in which case it throws a #SS instead=2E Handle this similarly to ho=
w other
>> >> LASS violations are handled=2E
>> >>=20
>> >
>> >Maybe I've misunderstood something:
>> >
>> >Is the underlying assumption here that #SS were previously only
>> >generated by userspace, but now they can also be generated by the
>> >kernel? And we want the kernel generated #SS to behave the same as the=
 #GP?
>> >
>> >> In case of FRED, before handling #SS as LASS violation, kernel has t=
o
>> >> check if there's a fixup for the exception=2E It can address #SS due=
 to
>> >> invalid user context on ERETU=2E See 5105e7687ad3 ("x86/fred: Fixup
>> >> fault on ERETU by jumping to fred_entrypoint_user") for more details=
=2E
>> >>=20
>> >> Co-developed-by: Alexander Shishkin <alexander=2Eshishkin@linux=2Ein=
tel=2Ecom>
>> >> Signed-off-by: Alexander Shishkin <alexander=2Eshishkin@linux=2Einte=
l=2Ecom>
>> >> Signed-off-by: Kirill A=2E Shutemov <kirill=2Eshutemov@linux=2Eintel=
=2Ecom>
>> >> ---
>> >>  arch/x86/kernel/traps=2Ec | 39 +++++++++++++++++++++++++++++++++---=
---
>> >>  1 file changed, 33 insertions(+), 6 deletions(-)
>> >>=20
>> >> diff --git a/arch/x86/kernel/traps=2Ec b/arch/x86/kernel/traps=2Ec
>> >> index ceb091f17a5b=2E=2Ef9ca5b911141 100644
>> >> --- a/arch/x86/kernel/traps=2Ec
>> >> +++ b/arch/x86/kernel/traps=2Ec
>> >> @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_prese=
nt)
>> >>  		      SIGBUS, 0, NULL);
>> >>  }
>> >> =20
>> >> -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
>> >> -{
>> >> -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGB=
US,
>> >> -		      0, NULL);
>> >> -}
>> >> -
>> >>  DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
>> >>  {
>> >>  	char *str =3D "alignment check";
>> >> @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protectio=
n)
>> >>  	cond_local_irq_disable(regs);
>> >>  }
>> >> =20
>> >> +#define SSFSTR "stack segment fault"
>> >> +
>> >> +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
>> >> +{
>> >> +	if (user_mode(regs))
>> >> +		goto error_trap;
>> >> +
>> >> +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
>> >> +	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
>> >> +		return;
>> >> +
>> >> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>> >> +		enum kernel_exc_hint hint;
>> >> +		unsigned long exc_addr;
>> >> +
>> >> +		hint =3D get_kernel_exc_address(regs, &exc_addr);
>> >> +		if (hint !=3D EXC_NO_HINT) {
>> >
>> >The brackets are not needed for singular statements=2E Also the max li=
ne
>> >length is longer now=2E You can fit this all in a single line=2E
>> >
>> >> +			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
>> >> +			       exc_addr);
>> >> +		}
>> >> +
>> >
>> >> +		if (hint !=3D EXC_NON_CANONICAL)
>> >> +			exc_addr =3D 0;
>> >> +
>> >> +		die_addr(SSFSTR, regs, error_code, exc_addr);
>> >
>> >The variable names in die_addr() should be generalized as well=2E They
>> >seem to assume the caller to be a #GP handler=2E
>> >
>> >> +		return;
>> >> +	}
>> >> +
>> >> +error_trap:
>> >> +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGB=
US,
>> >> +		      0, NULL);
>> >> +}
>> >> +
>> >>  static bool do_int3(struct pt_regs *regs)
>> >>  {
>> >>  	int res;
>> >
>>=20
>> Note: for a FRED system, ERETU can generate #SS for a non-canonical use=
r space RSP even in the absence of LASS, so if that is not currently handle=
d that is an active bug=2E
>
>It is handled by fixup code inside do_error_trap()=2E We need to add
>explicit fixup before LASS handling to avoid treating bad userspace RSP a=
s
>kernel LASS violation=2E
>

Great=2E I was pretty sure, but I wanted to address Sohil's question direc=
tly=2E Thanks for verifying=2E

A LASS violation of any kind in the kernel (unless handled by fixup, inclu=
ding user access fixup) ought to be fatal, correct?

