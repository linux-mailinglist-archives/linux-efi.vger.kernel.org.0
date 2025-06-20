Return-Path: <linux-efi+bounces-3871-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0ADAE1FC4
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D213A3AECA6
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AE294A19;
	Fri, 20 Jun 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oul+Os6R"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537428AAFB;
	Fri, 20 Jun 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435427; cv=none; b=FdeKWexUs2jAIEFnpKz55RL1Uz1ACRt6iR/cuRVwqoWa/ZVLjOUYP6vV0Z8xYZV8VhcwbPpa0IPs1AeML57AJtmL2DKtU4gp7lpFrbW8liNc8dpQl3udaBuyQ5Ru4Ol6BWIxoRrf5ZQSrD7McaBxyBt6PV0ZC6n+TZwCgBCPwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435427; c=relaxed/simple;
	bh=RPu9f+z5OQTx9H3vYantc1ws4bexPTpjNnpUtSDR93g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+c+4zSVVNaHl3Evtb8CvggmWM10GnLyRrl9budZYEB6BFd4LWa32W5Uiq3KyfYAZCavOA1nvFwI1y3tzX9xDrUByPeGkgH5gbT7tRwqqFmEUUPHK+zYqEJW7bzSQGkDvxKEsfr1jCIw3bAkjNsfDYOJgbXFKhtyrqVnGw2reC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oul+Os6R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=NSB4A1BN+oe8vo2+YMkOtMxoCw9tNHrThUhqnK3l+LM=; b=oul+Os6RDpifkRz0yqsu6U/NTb
	+MnDf6Z3FjzrS9577VAuSwTL3/JJ6AacGXPkkHJAABXhvoPk9uWSw/UgVn42a1y6Ic4LOIlnB02IE
	aNXG9dfdiyQCZDlCy/KQjBaf1tjG9kpiYhJzaepD9HxeItlz3bvMp61cXcc/DdwRXE1R28kFSZEFu
	yd8LjCeBCwVQp68r5cuJoQE3CQloAX6vQuhgWZlzwijzXmzasWiEwBiRhalxYaKZSOEp3iCNDXfbt
	vipLI+60L7CYwMkMU06GTIhV/+S4a6q8QAdbRmZR/W9pMU5RSRDSWi8vmy+uRvnzv5xq8OSnTlxo1
	OqSBoqPQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSeCd-0000000D1ab-2WJI;
	Fri, 20 Jun 2025 16:02:55 +0000
Message-ID: <25600557-9cd5-406c-9acf-abc163afde2d@infradead.org>
Date: Fri, 20 Jun 2025 09:02:42 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
 Breno Leitao <leitao@debian.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
 Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
 Changbin Du <changbin.du@huawei.com>,
 Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org,
 Yian Chen <yian.chen@intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 6/20/25 6:53 AM, Kirill A. Shutemov wrote:
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
> Co-developed-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig.cpufeatures                |  4 ++++
>  arch/x86/include/asm/cpufeatures.h          |  1 +
>  arch/x86/include/asm/smap.h                 | 22 +++++++++++++++++++--
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/cpu/cpuid-deps.c            |  1 +
>  tools/arch/x86/include/asm/cpufeatures.h    |  1 +
>  6 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
> index 250c10627ab3..9574c198fc08 100644
> --- a/arch/x86/Kconfig.cpufeatures
> +++ b/arch/x86/Kconfig.cpufeatures
> @@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
>  	def_bool y
>  	depends on !X86_64
>  
> +config X86_DISABLED_FEATURE_LASS
> +	def_bool y
> +	depends on !X86_64

Please explain why this is   !X86_64.
Thanks.

> +
>  config X86_DISABLED_FEATURE_PKU
>  	def_bool y
>  	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS


-- 
~Randy


