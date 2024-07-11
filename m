Return-Path: <linux-efi+bounces-1425-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF192E1DB
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 10:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF871F25EAF
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABC1514E3;
	Thu, 11 Jul 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtsbYuzi"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429274416;
	Thu, 11 Jul 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685808; cv=none; b=ZxX2Z1VKaVJqxXZM4jrnn5lrmncYEv9A1uRJ1u+COX+6AtY5CPFEt/9EyKDwz1i2ka0KAWjT1sE2C2NLw3GtxwvNgR6rbVihmCj4TT2ef+ngWJ7Px54Nzfyr5R0gq0XNtUZQazquinxh2iZznFzJonPNSbTSrtwTz2SEhTcF3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685808; c=relaxed/simple;
	bh=QgeL2GqOGBjF1DLizKD6yRiZVHfq/LMsmIek5y8EN78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e78/wjfPUsM2BZgAS6G6gKNmHUCXPCldysCMWGoWcfSAwNoU7q9PUsAcQ02nUnHnLRpLu9hgiV+pMl41ovuyuEw4+7fLfTUmC+Oq7HkLsWBMIZvhYMYhcvEylRIe12wotBwVRAOlFhRmr4lcPBRnqs3h+NKLa79ltDqvVX4IEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TtsbYuzi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QgeL2GqOGBjF1DLizKD6yRiZVHfq/LMsmIek5y8EN78=; b=TtsbYuziPKcH1tdpn2eTwcTjtU
	n8A4XZ7GqNLHvESSPfJUll7xTTbgAAYN6N11zqioYiG6A5lameU28MOTp4rKr6AN9MiZO7W3nux2v
	RNzgqOru1J9b8ebLF0GIR/tlkBmPuhycRtPGScgAEF1o7fgAV+8s/NZWvwblJxXTz8T7L3ntsfCKN
	p/btlCalKJ8kKNxCm0WvkppjIOnoMAoEBqdlCH5gcQz/J93dt7o6KgSn1CIjeauEzvOSIOHpIPwpk
	odoRBLHMH7CYhFTCgf5b4eESGzFBA8ym1lZDeOGl4vyj9aa8VTsR6/C6+OkalqOL4DZqNnA3/VQ+A
	5vlW/4hA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRoya-0000000Akum-45Ao;
	Thu, 11 Jul 2024 08:16:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 92D8830050D; Thu, 11 Jul 2024 10:16:28 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:16:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yian Chen <yian.chen@intel.com>,
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
Subject: Re: [PATCH v4 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20240711081628.GF4587@noisy.programming.kicks-ass.net>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>
 <20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local>
 <cqacx3crogegwyslm25kwcdcezgg2n44lhy3mg5qkka3vgn4xa@lhqsoseyduus>
 <7bbf9cae-6392-47a4-906c-7c27b1b1223d@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbf9cae-6392-47a4-906c-7c27b1b1223d@intel.com>

On Wed, Jul 10, 2024 at 04:05:31PM -0700, Dave Hansen wrote:

> But, I'm 100% sure that we want to distinguish a LASS-necessitated
> stac()/clac() from a SMAP-necessitated one somehow.

Yeah, if only to make it easier to understand the code.

