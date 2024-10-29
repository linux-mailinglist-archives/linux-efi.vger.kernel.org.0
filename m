Return-Path: <linux-efi+bounces-2046-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED039B502F
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD71C22615
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52CB1DA31F;
	Tue, 29 Oct 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtaDdZ5z"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D317D355;
	Tue, 29 Oct 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222103; cv=none; b=awjg/v+DniR5yjSa/QjimRqEWlIjE0U4huiKWt5lJE4mISyY4NbcaABKpc64eUKF6H1Zk4RGsBIFguNGkhopVRwO7BjAwarOBYivCRFGtjOjtosKtAmuggRybozI9VmFf31fdA6BGvUkuRwvkpysMY7sQvQYebXYaTN9o1qcms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222103; c=relaxed/simple;
	bh=LqBQA0ivqqH8ZyZKx0n8JFFG1U13mopJfiR3HfDtNN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1+uIZ/xCowFLb8aloz5DEynaEnnvxKfHXNxxVNFrTBz/p5+AS3wBiqvumLyIpwseT523SpVYwc+DuIp5xFQT1bdXQ8VNukgUP15Wgx4Rvo+g1CSOQcIXoApcWUc5G8wmi/q93u3Up3rgCTAhOrgZaR/hVPo34D2ze9euE1XLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qtaDdZ5z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xq2/wRVUsy2jaJ29qDqN+mT7DMusIDqIZXNyENoMByg=; b=qtaDdZ5zpgOd3Fw3eXc6aoAx08
	7t8FDzzNCE0NIsKqBHdowmPclK+I/eJDA6qgV0AheD0UMouI0NmMmSWmTb5921yCpVk2vjYVoGv2/
	bpRTRLxm0o8Vh7eUQG78LVeUYniTIz7yHeGs5gdP8MIOxVkZdlF9Y2B6TZ4t+wcL8yrKJkOHPwShV
	scBms6uZyZ84HMIbFXBaiwD3uEAhFRzDhr1GQgdiJkAD4a66u7wwPFCvn1K4VR43CZHaYbn1j7SnH
	pK+WudxVw9mP218BIiDoYZUIgSIGRBdhsl+aXUvBXIkuMQSWQnh2kHC8V2BJkkCHqWqq7AAVNMM49
	/fjt8Eow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pnG-0000000A2WL-0jJ5;
	Tue, 29 Oct 2024 17:14:10 +0000
Date: Tue, 29 Oct 2024 17:14:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
	Tony Luck <tony.luck@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 00/16] Enable Linear Address Space Separation support
Message-ID: <ZyEX4cp-iiwiF_yX@casper.infradead.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>

On Mon, Oct 28, 2024 at 06:07:48PM +0200, Alexander Shishkin wrote:
> Linear Address Space Separation (LASS) is a security feature that intends to
> prevent malicious virtual address space accesses across user/kernel mode.
> 
> Such mode based access protection already exists today with paging and features
> such as SMEP and SMAP. However, to enforce these protections, the processor
> must traverse the paging structures in memory.  Malicious software can use
> timing information resulting from this traversal to determine details about the
> paging structures, and these details may also be used to determine the layout
> of the kernel memory.
> 
> The LASS mechanism provides the same mode-based protections as paging but
> without traversing the paging structures. Because the protections enforced by
> LASS are applied before paging, software will not be able to derive
> paging-based timing information from the various caching structures such as the
> TLBs, mid-level caches, page walker, data caches, etc. LASS can avoid probing
> using double page faults, TLB flush and reload, and SW prefetch instructions.
> See [2], [3] and [4] for some research on the related attack vectors.
> 
> In addition, LASS prevents an attack vector described in a Spectre LAM (SLAM)
> whitepaper [7].
> 
> LASS enforcement relies on the typical kernel implemetation to divide the
> 64-bit virtual address space into two halves:
>   Addr[63]=0 -> User address space
>   Addr[63]=1 -> Kernel address space
> Any data access or code execution across address spaces typically results in a
> #GP fault.
> 
> Kernel accesses usually only happen to the kernel address space. However, there
> are valid reasons for kernel to access memory in the user half. For these cases
> (such as text poking and EFI runtime accesses), the kernel can temporarily
> suspend the enforcement of LASS by toggling SMAP (Supervisor Mode Access
> Prevention) using the stac()/clac() instructions and in one instance a downright
> disabling LASS for an EFI runtime call.
> 
> User space cannot access any kernel address while LASS is enabled.
> Unfortunately, legacy vsyscall functions are located in the address range
> 0xffffffffff600000 - 0xffffffffff601000 and emulated in kernel.  To avoid
> breaking user applications when LASS is enabled, extend the vsyscall emulation
> in execute (XONLY) mode to the #GP fault handler.
> 
> In contrast, the vsyscall EMULATE mode is deprecated and not expected to be
> used by anyone.  Supporting EMULATE mode with LASS would need complex
> intruction decoding in the #GP fault handler and is probably not worth the
> hassle. Disable LASS in this rare case when someone absolutely needs and
> enables vsyscall=emulate via the command line.

I lack the wit to read & understand these patches to answer this
question, so I'll just ask it:

What happens when the kernel does a NULL pointer dereference (due to a
bug)?  It's not an attempt to access userspace, but it should result in
a good bug report.  Normally this would be outside a STAC/CLAC region,
but I suppose technically it could be within one.


