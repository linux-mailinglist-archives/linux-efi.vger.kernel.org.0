Return-Path: <linux-efi+bounces-1413-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367692DDF5
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 03:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A4E281FA6
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 01:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F0523D;
	Thu, 11 Jul 2024 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUx4xrVf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031423CE;
	Thu, 11 Jul 2024 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661084; cv=none; b=tLiu9PRhzkWD3JY2PyiNg/mlFmg2goudIBLpYkDasv/jucKSPNsyMDdX+vKcxYPBstSqKUGZy6Liw5DUSwHKSXXlV7QAhWa10uZ/16slEWfaVh7gSVCe7hv/B1w7+KgZ8N5GTZS37IlsTzVn2VipbZzJaGej2OKv2scZdtAcZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661084; c=relaxed/simple;
	bh=WqUc+50yatqec/bDZPWg223qG82aa7ffR9EbPqWYqiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcpihtUB1xp/nUrmopkys0xrhpOSGuVpKac/gMXJ9CrhZ8AD2cIW48rqelNEgFv/pJiaE1kqLMuOVXK97yyJz3LzH0Z+dK/mSRMVs+7y8jt30DpvBITyp2xR3lz2etUIPTxZXccQB6Dl2ZMnX5ynVaNAfEGDc7jAGe0cHNK3OX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iUx4xrVf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DF3E40E0206;
	Thu, 11 Jul 2024 01:24:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bZpwJXXJsqwJ; Thu, 11 Jul 2024 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720661072; bh=0ivUAjF+gH7cy3ad9SGegCyTH8sP11rPRTgqRJ5uBdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUx4xrVfYT6hRqeHWPrTHUQNQvN7/SsR9BrcwyDOxS/pZGAbDkbTQSPBY4U9khXoO
	 L/yMcukpwPEli97wKwnyxu41q3pK+cFpMz/gOGFcoh5PleAvuqE+7ceaFmh0eHRfC9
	 RBgtlSII3GbPGP5551p5hzWHej9gFKKu/U8YbV96OZavc9f2+Wi3tHLa2XZ45srCDM
	 grXPnXvmUROV+0T3xSGubGq2ntBWtBsC5MabrFeiqe9rH0N0q+7+e8MXHWwBB9SFuf
	 KGDbGS10RvPfuLZnAb8vk1Slr6AVN7URb109PSBB83bjL8kAVI1LonY3n3J8Ix+MYr
	 BJftN1Z+8hTAKdoGjm/nwmg0xdCpCLOl7Wjt+XZeS29CppenSs/6m4H7t6Tp6PXf5E
	 E/C20NPCHLlh/VFT880vmxXy5lbDR8bfO8vTUqz8dJH7/zDbgxL6GPBjOWuiB267uS
	 8cknKtl/8/BSSa87DA7RBzo3cm1wwMplZBDaCb2zqxT96Yo0/v1I45/PtjmUfYhvJ7
	 a64aSB8Eeodbb71qBWwZuAkcBvKtZzTEDW5VXkGS/MRSq3VnLQyRTcI2mQe3XG3BR2
	 ANH70NwERMx05P8cVwb2TD9Q17KTUiHD8Y3SXEFf66iRef2/C7/8NMOuXq1vWdyUHC
	 VuGxSkmTcQ5A4ULzpwd9eSjE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D09D440E0194;
	Thu, 11 Jul 2024 01:23:40 +0000 (UTC)
Date: Thu, 11 Jul 2024 03:23:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20240711012333.GAZo80FU30_x77otP4@fat_crate.local>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cqacx3crogegwyslm25kwcdcezgg2n44lhy3mg5qkka3vgn4xa@lhqsoseyduus>

On Thu, Jul 11, 2024 at 01:33:23AM +0300, Kirill A. Shutemov wrote:
> Hm. Do we have text_poke() in hot path?
> 
> Even if we do, I doubt flipping AC flag would make any performance
> difference in context of all locking and TLB flushing we do in this
> codepath.

$ dmesg | grep text_poke | wc -l
237

In a silly guest.

And regardless, we don't do unnecessary toggling of rFLAGS.AC.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

