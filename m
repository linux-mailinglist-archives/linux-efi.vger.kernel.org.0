Return-Path: <linux-efi+bounces-4020-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9768AEA288
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F137F189427D
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815A2E718D;
	Thu, 26 Jun 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BKoLX4+/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B52EBDD9;
	Thu, 26 Jun 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951398; cv=none; b=fLdPk4PKv9ZRRhJL+5qHr00DjfZy+/1lSCC9CmMSYzwHfF7NRLiaYecPNEQERQXJm81fLLkh42EyVaOuMVA8bRUHhZsqU4VlBRULxOUZlqvz1sPUhXJ1JNf64b9DP3qvU6J1uVtQ0a3tvyxdQm91ePOB4uVyE2Tp7jTjzmQte80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951398; c=relaxed/simple;
	bh=1meFbmguIrrQcXTuIPMPgEl7aNZYw1TFw2buecn9sg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KssYi0NTKpS8NKs9lndWhW9ol+KwHCtbjKshwAqxk5ZKJm4RSEsE38oCTbCcQM0+18bD8u+HDCaU5UIjmZRltP3tRZCv7s8NEzMnHcD59UJYKTbG1cdaOGURKRo58K+k1tb3nGcxBUkslRihLdXlJDw9EjMHNlIM+D+QI8Hqjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BKoLX4+/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E637840E00CE;
	Thu, 26 Jun 2025 15:23:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3T_HP8Mpcpq7; Thu, 26 Jun 2025 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750951386; bh=A7hao13YYOHGpLHDV+xaJPrzcOSgKVbDGnSsEtxU0hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKoLX4+/fxMkEUVDSfj5OUUjdINqhyteEYa5Os8ve0ZB3p8J+l7hJ1Ws/zoLLJkiN
	 rYA/ARGVja21Kkv37IzLbx4h60cQaOUwbtJZyjMHSl87kyPhbvwKd03qQSFD4tois7
	 oqy4bRxbP3qpXNkFhC+ZepnFDZid0d2U9LS0DCiG2MvYqzq+i3ybzQ89WYNMd/sm7E
	 7Y5rJYgCm5rqLufKCfaNThotZWNbAzII+HZc1FeAUL/Ifc71h4kaTEYG8tKHeJMQ4o
	 Lce4z9I6lFNAquQWddl3pcX0nwc1L8oRUrs9L88LdaENKemne/ZCUY+6g43KBVWIE3
	 6XyIDj3ur19YNByGBUx4JjtLODwjdYybJZaNYNsbGCltX5yN5CEM8lgLnQx2svvkUx
	 cxCrxFY18jAXDX2UFUelN5gtWiH5+Rds8tR5boM1eaLIhx9aY82oF4ftwnq7Fc5eAQ
	 hlDlxwe7fMmuNOmSxU/Pt8ZV+poTMbeZGldBPB7NVenlXGSj5VyfqZ9+66V1gKwyfL
	 pKJKim6Cdu4x+47daJTsWMGhx19pqyfyDBpjVZCgOt1ULwde/7Czi+bnYR5AFrlrEy
	 PMxTIvt3zN/xrn8Uyp4r6CL/65ELuZWaHoq3pVb0967dC4Q2bINRoeZ1xCiffyzp2E
	 SxKNnDTGBGD5mkT9i9hpKQSw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95EA440E015E;
	Thu, 26 Jun 2025 15:22:14 +0000 (UTC)
Date: Thu, 26 Jun 2025 17:22:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv7 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <20250626152213.GCaF1lpfzIcrKsOwRr@fat_crate.local>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625125112.3943745-2-kirill.shutemov@linux.intel.com>

On Wed, Jun 25, 2025 at 03:50:53PM +0300, Kirill A. Shutemov wrote:
> From: Sohil Mehta <sohil.mehta@intel.com>
> 
> Linear Address Space Separation (LASS) is a security feature that
> intends to prevent malicious virtual address space accesses across
> user/kernel mode.
> 
> Such mode based access protection already exists today with paging and
> features such as SMEP and SMAP. However, to enforce these protections,
> the processor must traverse the paging structures in memory.  Malicious
> software can use timing information resulting from this traversal to
> determine details about the paging structures, and these details may
> also be used to determine the layout of the kernel memory.
> 
> The LASS mechanism provides the same mode-based protections as paging
> but without traversing the paging structures. Because the protections
> enforced by LASS are applied before paging, software will not be able to
> derive paging-based timing information from the various caching
> structures such as the TLBs, mid-level caches, page walker, data caches,
> etc.
> 
> LASS enforcement relies on the typical kernel implementation to divide
> the 64-bit virtual address space into two halves:
>   Addr[63]=0 -> User address space
>   Addr[63]=1 -> Kernel address space
> 
> Any data access or code execution across address spaces typically
> results in a #GP fault.
> 
> The LASS enforcement for kernel data access is dependent on CR4.SMAP
> being set. The enforcement can be disabled by toggling the RFLAGS.AC bit
> similar to SMAP.
> 
> Define the CPU feature bits to enumerate this feature and include
> feature dependencies to reflect the same.
> 
> LASS provides protection against a class of speculative attacks, such as
> SLAM[1]. Add the "lass" flag to /proc/cpuinfo to indicate that the feature
> is supported by hardware and enabled by the kernel. This allows userspace
> to determine if the setup is secure against such attacks.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Co-developed-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig.cpufeatures                | 4 ++++
>  arch/x86/include/asm/cpufeatures.h          | 1 +
>  arch/x86/include/uapi/asm/processor-flags.h | 2 ++
>  arch/x86/kernel/cpu/cpuid-deps.c            | 1 +
>  tools/arch/x86/include/asm/cpufeatures.h    | 1 +
>  5 files changed, 9 insertions(+)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

