Return-Path: <linux-efi+bounces-1424-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF092E1D3
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02810B23EB3
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7A14F9FD;
	Thu, 11 Jul 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bDIS618x"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F57C086;
	Thu, 11 Jul 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685727; cv=none; b=TFBEE6OSSVWokYeFF7b6kAq+KqQiAdrt5YblUReh+rk1E9xq4vfg+64dEaBQoWbx6NfwVu+XVKOwC+lzYhC8ja+5l55DrzygTr+0fat5gjtfAgVp15wVRO67cntIUn1iTDSHe3DB/F8k3348pw2Tpyto1zxdnTX7sXKbF7jxg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685727; c=relaxed/simple;
	bh=x1Jcj6NeCHQN+40mLrILfGkWZv5ImKM4gWH+YNibv8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4YNYg+9L/7dWNMMGs4pjDrw5L7q7/lMzHxK9XO8rFHbNCMTtZEjlo/xp4pF9hl3xnldEpCvsTUK+UX7T8b8wBf/NYTvo/+1MrGVNq3b4RyOp66fa6tBhmQTCkBrIFLPegmAPtnAJTuVrD53X1103CWJmzxW14IeKslqpziGS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bDIS618x; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6wtDOfAx6qXoOFW0qLJr9ozkAFTcFE7m6rFzVFkQzO0=; b=bDIS618xw2CxgiOtsh/B1dnK1c
	5JxPG3AbH1eB2KbyzbpFIS68eMDIWBBCocACVVe0B0ks1BIusZuYjKgOxgUn5YaUaSuDLiX7savkg
	qv+Ib+kmFId0ueTeEQsoI+aPpbo3dN1DGWQeGZ/laUcxWPDhYdj0dDwXR/knUfxWq2vYVNbV3vXCZ
	hXAftDHoT3WLufeo50lSqDsPIPI9pPrXbHOscPRD57CGGM4MbercD0nOAs/1WOJRLbY0kD1PbeGps
	/CeRzudxg3FpfW/wEJ1NfH/LEGC9fRLCIt+d0P8Hy7udIGJzm2pdYWzps+bx5H/BRQeoha+vqYmMV
	9poUU9Bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRoxA-000000013Yy-0kHs;
	Thu, 11 Jul 2024 08:15:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CCDF730050D; Thu, 11 Jul 2024 10:14:59 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:14:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20240711081459.GE4587@noisy.programming.kicks-ass.net>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>
 <20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local>
 <cqacx3crogegwyslm25kwcdcezgg2n44lhy3mg5qkka3vgn4xa@lhqsoseyduus>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cqacx3crogegwyslm25kwcdcezgg2n44lhy3mg5qkka3vgn4xa@lhqsoseyduus>

On Thu, Jul 11, 2024 at 01:33:23AM +0300, Kirill A. Shutemov wrote:
> On Wed, Jul 10, 2024 at 07:18:36PM +0200, Borislav Petkov wrote:
> > On Wed, Jul 10, 2024 at 07:06:39PM +0300, Alexander Shishkin wrote:
> > >  static void text_poke_memcpy(void *dst, const void *src, size_t len)
> > >  {
> > > -	memcpy(dst, src, len);
> > > +	stac();
> > > +	__inline_memcpy(dst, src, len);
> > > +	clac();
> > 
> > I think you need LASS-specific stac()/clac() or an alternative_2 or so. You
> > can't cause that perf penalty on !LASS machines.
> 
> Hm. Do we have text_poke() in hot path?
> 
> Even if we do, I doubt flipping AC flag would make any performance
> difference in context of all locking and TLB flushing we do in this
> codepath.

The one where performance might matter is text_poke_early(), the full
fat one is comically slow as you point out.

