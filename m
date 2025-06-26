Return-Path: <linux-efi+bounces-4023-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711CAEA4CE
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D748D188E895
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584F1BD01D;
	Thu, 26 Jun 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AOTYz6Mf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32513A86C;
	Thu, 26 Jun 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960743; cv=none; b=CO9GYnFEaW9kyn1OU542NOoyZ7yv4ixBuzT5t0xvWXJA+IsBTykPw5o+ow/OhPDUwFobHSzlQlNJWo9snxedu8UK4UkHSRY/4IojtoEoAxgZymYEhklIblmeeQ03JU7WhbEA+U65FD3L4+i30Gq5HEl39vLVAfJREullWLLjyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960743; c=relaxed/simple;
	bh=fCZz9Gt4SX1+H+Ie5jTqf8LW9SqmaBzQSsdnhByCvlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYX3UYNhrMN+IHo2tIUTHqtGRqLEoszvQP4UfYTNRWIG9HRGn/RxDh4Zk+2ZfndHa5/la8DUQkOD0OCodbLBSAYMtvXZ1vesMnC6rXMPKUOdoBlcbYUyBGFttGciY7YZNOV+7ixLQ7VEoD1py5IFiIpptxxiR0EzCIdNc/bMblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AOTYz6Mf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55QHvmvU2307866
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 26 Jun 2025 10:57:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55QHvmvU2307866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750960675;
	bh=BMeNFTdjV+yNnMcij/TqO/5U2NmxhXLfNUC6LvsGyIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AOTYz6MfWghBzEoibmGfI7laRAlY7menpK8b7jO9lWYFXBby2etwb289pFF7tim7h
	 3LqeGLIL9v49XFI5vok9c5IgkoDwAFSouUThYZwimemKnrGLlC5OeISJV7kJUHwpR3
	 nX52rDXhaBlpxT7lCF283gGvA2cSJxr0cjnBmV6Ozo+iLCYkWH6Bj6iHGHmowvk6WN
	 yVCipOn7tepFsUc9/2v0Qr7EC8Wa9sQzOavAUqXMCKvi0APWm4y6LeimQPUOYC+bE/
	 x2NdCGle2s14Uyfmxn8sjvyYYRIGO3oVryMa/oP0nF9q0fHHDOLqNmGwN3NNw7OuNR
	 Wo5k6NyEjVuHA==
Message-ID: <c704ea9a-8c73-46c2-80d1-f7b93a221908@zytor.com>
Date: Thu, 26 Jun 2025 10:57:47 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 13/16] x86/traps: Handle LASS thrown #SS
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
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
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-15-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <20250625125112.3943745-15-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/2025 5:51 AM, Kirill A. Shutemov wrote:
> LASS throws a #GP for any violations except for stack register accesses,
> in which case it throws a #SS instead. Handle this similarly to how other
> LASS violations are handled.
> 
> In case of FRED, before handling #SS as LASS violation, kernel has to
> check if there's a fixup for the exception. It can address #SS due to
> invalid user context on ERETU[1]. See 5105e7687ad3 ("x86/fred: Fixup

Forgot to put the link to [1]?  Maybe just remove "[1]"?

> fault on ERETU by jumping to fred_entrypoint_user") for more details.
> 
> Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index e2ad760b17ea..f1f92e1ba524 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
>   		      SIGBUS, 0, NULL);
>   }
>   
> -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> -{
> -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> -		      0, NULL);
> -}
> -
>   DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
>   {
>   	char *str = "alignment check";
> @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>   	cond_local_irq_disable(regs);
>   }
>   
> +#define SSFSTR "stack segment fault"
> +
> +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> +{
> +	if (user_mode(regs))
> +		goto error_trap;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
> +		return;
> +

Thanks for making the change for FRED.

> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		enum kernel_gp_hint hint;
> +		unsigned long gp_addr;
> +
> +		hint = get_kernel_gp_address(regs, &gp_addr);
> +		if (hint != GP_NO_HINT) {
> +			printk(SSFSTR ", %s 0x%lx", kernel_gp_hint_help[hint],
> +			       gp_addr);
> +		}
> +
> +		if (hint != GP_NON_CANONICAL)
> +			gp_addr = 0;

Nit: GP/gp don't seem fit here, maybe we need a more generic name?

Sorry I don't have a recommendation.

> +
> +		die_addr(SSFSTR, regs, error_code, gp_addr);
> +		return;
> +	}
> +
> +error_trap:
> +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> +		0, NULL);

The indentation has changed; I believe the original formatting is
preferable.

> +}
> +
>   static bool do_int3(struct pt_regs *regs)
>   {
>   	int res;

Just minor comments, so

Reviewed-by: Xin Li (Intel) <xin@zytor.com>

