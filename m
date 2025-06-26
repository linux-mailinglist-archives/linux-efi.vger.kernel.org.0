Return-Path: <linux-efi+bounces-4011-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E3AE9DC4
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B035A02B5
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D521CA18;
	Thu, 26 Jun 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbRdv3bm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756521EB2F;
	Thu, 26 Jun 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942071; cv=none; b=aOj5W0QjLE9FJGLoafI8/7ifCZvpXhrVH0oWv2oa58HqErGxJ2MCsEytHC2S/jOOqtS9XY8sw8NpOw1iQetnBOruS5yPkweu+wcfqRqlrG3mL/J6WLeDnDHoOf2crNcCumrut8iFBVdP6VT1exSZtryAyuBV/Knk6t4taiAnvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942071; c=relaxed/simple;
	bh=yEVEVPCgQVDBf9e9XQZU0mmeebKCotKG0hlhjNKE7CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVKhniisPLMkd7/ea9T7sBcmHFNrLCV7pIEeTh/LFLH1/7Dkcg5poJggS4/sDOQjGT5alo2pN4QtVr+1v5iQNjKXHsnFUB/+WgR6674NesRRDUxg9a4VztS1OsNHDDgp4VlwmcQUv/jsRCk/uug8h2CdjAWtpsezI+xACtBHNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbRdv3bm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750942070; x=1782478070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yEVEVPCgQVDBf9e9XQZU0mmeebKCotKG0hlhjNKE7CQ=;
  b=nbRdv3bmk2t79kHnZthRtdispeoET0Dfg+MwF0fz4vvJiPRp78YFOAv7
   nTJHAojNydF+pi4/fCC+ngDzql8qF7a+HWeb9HtGm9gPw6e5f5tOLpUnx
   HT1wcXtGeHPjbVJHLHnL7PsOl4epheCm6ua/ihfffd5wzpua5qk7aNZ3e
   V1xQUC6WOOu/WrKPYoupPSx78Bc9tJSUIrTbv77oy9MyCTxNr2qWR+DN+
   7v51EST4lMlFBCPeo5RHHNoQzzkmb7yJcA1OcSJGdF+XZkW/nNGJRChJk
   tQoedlaJkqT0TBeQM9xU2C01zQWWgMchiM+A8nH5FPIUnoMkULpxrpcPH
   A==;
X-CSE-ConnectionGUID: V4ibBaoMRyOtiG42QNtcAA==
X-CSE-MsgGUID: maEd950FQ+OryJWoJRnvWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64671183"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="64671183"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 05:47:49 -0700
X-CSE-ConnectionGUID: eHSQK0fJQgOPUviOTHUIMw==
X-CSE-MsgGUID: 5nVvn7pvSaSl7xzcMHvB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152266048"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 26 Jun 2025 05:47:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2F23A2E2; Thu, 26 Jun 2025 15:47:36 +0300 (EEST)
Date: Thu, 26 Jun 2025 15:47:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv7 00/16] x86: Enable Linear Address Space Separation
 support
Message-ID: <ky4an2a4ks55phzuzdvb5py4psvgintt4u2rmthhx44zsx3gqn@uxw3sebzpbch>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <9b1c5e43-ff48-4af8-9ec8-1c1dc2b902ae@oracle.com>
 <1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com>

On Thu, Jun 26, 2025 at 11:35:21AM +0200, Vegard Nossum wrote:
> 
> On 26/06/2025 11:22, Vegard Nossum wrote:
> > 
> > On 25/06/2025 14:50, Kirill A. Shutemov wrote:
> > > Linear Address Space Separation (LASS) is a security feature that
> > > intends to
> > > prevent malicious virtual address space accesses across user/kernel mode.
> > 
> > I applied these patches on top of tip/master and when I try to boot it
> > fails with errno 12 (ENOMEM - Cannot allocate memory):
> > 
> > [    1.517526] Kernel panic - not syncing: Requested init /bin/bash
> > failed (error -12).

For some reason, I failed to reproduce it. What is your toolchain?

> > Just using standard defconfig and booting in qemu/KVM with 2G RAM.
> > 
> > Bisect lands on "x86/asm: Introduce inline memcpy and memset".
> 
> I think the newly added mulq to rep_stos_alternative clobbers %rdx,

Yes, it makes sense.

> at
> least this patch fixed it for me:
> 
> diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
> index 5cd0f18a431fe..bc096526432a1 100644
> --- a/arch/x86/include/asm/string.h
> +++ b/arch/x86/include/asm/string.h
> @@ -28,7 +28,7 @@ static __always_inline void *__inline_memcpy(void *to,
> const void *from, size_t
>                      "2:\n\t"
>                      _ASM_EXTABLE_UA(1b, 2b)
>                      :"+c" (len), "+D" (to), "+S" (from),
> ASM_CALL_CONSTRAINT
> -                    : : "memory", _ASM_AX);
> +                    : : "memory", _ASM_AX, _ASM_DX);
> 
>         return ret + len;
>  }

This part is not needed. rep_movs_alternative() doesn't touch RDX.

I will fold the patch below.

Or maybe some asm guru can suggest a better way to fix it without
clobbering RDX?

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index 5cd0f18a431f..b0a26a3f11e0 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -44,7 +44,7 @@ static __always_inline void *__inline_memset(void *addr, int v, size_t len)
 		     _ASM_EXTABLE_UA(1b, 2b)
 		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
 		     : "a" ((uint8_t)v)
-		     : "memory", _ASM_SI);
+		     : "memory", _ASM_SI, _ASM_DX);
 
 	return ret + len;
 }
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index ca94828def62..d904c781fa3f 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -64,12 +64,15 @@ EXPORT_SYMBOL_GPL(clear_page_erms)
  *
  * Output:
  * rcx: uncleared bytes or 0 if successful.
+ * rdx: clobbered
  */
 SYM_FUNC_START(rep_stos_alternative)
 	ANNOTATE_NOENDBR
 
 	movzbq %al, %rsi
 	movabs $0x0101010101010101, %rax
+
+	/* %rdx:%rax = %rax * %rsi */
 	mulq %rsi
 
 	cmpq $64,%rcx
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

