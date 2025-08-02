Return-Path: <linux-efi+bounces-4505-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5852B18FAF
	for <lists+linux-efi@lfdr.de>; Sat,  2 Aug 2025 20:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F1C3B8793
	for <lists+linux-efi@lfdr.de>; Sat,  2 Aug 2025 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21571C862F;
	Sat,  2 Aug 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyi1tKQE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF415853B;
	Sat,  2 Aug 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160689; cv=none; b=WhjTs18lmN05cfBpEXqIMdJv3R1bkfNo9WnwxYbntNPn7Uc4wfTbykZ34SJ2HQifOok0vXJ4FuE5pD2HlbNf/ww6c0DGaqDmoiYn8zPm4h/Jt8IXhvwRMe8DIF+4m+gpqlE55ibKWuNjqmbCUC9i/tQnhSAffI6VdGHn01hl0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160689; c=relaxed/simple;
	bh=RiGNiHqduvbyMJazTqCXPOWEO6VyqZFkOlYS73wNtV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxANFU1HyGv79ps74ebKGarfnGxGG2NkRebmv7usFRV+4yMIyzn8M0ELq0B+RiezD9YBkymWfxD6z0bFwaSnAx7AIGJmK58LiFhp50q3cdRSuLr6hPCFav5MAv2r3Zuxb1IVJaQ9Nou/CfbaLJzZY5f4x6v3GGvK19SmISPlGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyi1tKQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF55C4CEEF;
	Sat,  2 Aug 2025 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754160689;
	bh=RiGNiHqduvbyMJazTqCXPOWEO6VyqZFkOlYS73wNtV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oyi1tKQEVLy7nKAugvnwDQJY873SOMOmCWXgj1+OMxC1ktxOj29Txp12eod6mIKhJ
	 hGjvqBszSSmM8HSOSCBRxpptYW8hquo6CbEHFq4KKfZBP9WCsPbIqhNYVD1i1W1HWM
	 uf5zMixtyBlO+bB8qDrrzvZpbD5R9P9Wckkqoazai3TI3/tgwfhBW1nSriXqvEA2C6
	 W0XR0PTQzwQN/VZN2SFu+W3qHihc1UqIy4z+KKy+F7lDLY4qx/MB4QeYVaVFgT1rlc
	 bxRM/LYyUg5su5Uq1E7EToDT93T1PrS90jkf/jksSASUybVE3fXimvpCLXXNcPkMiP
	 bUJmMtQ48VNaA==
Date: Sat, 2 Aug 2025 11:51:28 -0700
From: Kees Cook <kees@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	"Kirill A. Shutemov" <kas@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
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
	X86-kernel <x86@kernel.org>
Subject: Re: [PATCHv9 04/16] x86/cpu: Defer CR pinning setup until core
 initcall
Message-ID: <202508021149.B4BFF8D1@keescook>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-5-kirill.shutemov@linux.intel.com>
 <6075af69-299f-43d2-a3c8-353a2a3b7ee7@intel.com>
 <98a7a91b-3b46-4407-82a7-5f80443b7e00@intel.com>
 <6e768f25-3a1c-48b9-bc53-56877a556a83@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e768f25-3a1c-48b9-bc53-56877a556a83@intel.com>

On Thu, Jul 31, 2025 at 05:01:37PM -0700, Dave Hansen wrote:
> On 7/31/25 16:45, Sohil Mehta wrote:
> > On 7/9/2025 10:00 AM, Dave Hansen wrote:
> >> On 7/7/25 01:03, Kirill A. Shutemov wrote:
> >>> Instead of moving setup_cr_pinning() below efi_enter_virtual_mode() in
> >>> arch_cpu_finalize_init(), defer it until core initcall.
> >> What are the side effects of this move? Are there other benefits? What
> >> are the risks?
> >>
> > Picking this up from Kirill.. Reevaluating this, core_initcall() seems
> > too late for setup_cr_pinning().
> > 
> > We need to have CR pinning completed, and the associated static key
> > enabled before AP bring up. start_secondary()->cr4_init() depends on the
> > cr_pinning static key to initialize CR4 for APs.
> 
> Sure, if you leave cr4_init() completely as-is.
> 
> 'cr4_pinned_bits' should be set by the boot CPU. Secondary CPUs should
> also read 'cr4_pinned_bits' when setting up their own cr4's,
> unconditionally, independent of 'cr_pinning'.
> 
> The thing I think we should change is the pinning _enforcement_. The
> easiest way to do that is to remove the static_branch_likely() in
> cr4_init() and then delay flipping the static branch until just before
> userspace starts.

Yeah, this is fine from my perspective. The goal with the pinning was
about keeping things safe in the face of an attack from userspace that
managed to get at MSR values and keeping them from being trivially
changed.

-- 
Kees Cook

