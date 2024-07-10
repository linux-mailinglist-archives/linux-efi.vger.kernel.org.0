Return-Path: <linux-efi+bounces-1406-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD792D754
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 19:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79871C209A9
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78705194A6E;
	Wed, 10 Jul 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NCoX9DS0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719534545;
	Wed, 10 Jul 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631985; cv=none; b=ApmJsuqDJCJ/J7jBblA+3bu3ZCQvC7OsJrh5czf/rycNjR7ZoZfgJXWYIbRd4rmPuXnFlzxxtwy/dSt4zesJ+sMoErDTDPsIY8lVptX+13alo4p+ihFEvCxYbBoE9k8aI2RIlwxLYsEyky+liaC81voyZvewtyt2PUO5uhdyy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631985; c=relaxed/simple;
	bh=1WCxG06P7mAa9HcCvP5iXR0Vo/X3kjtL5preMakYO/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfPkgUMGsTn6vu4zEwOlx8dB92L3nNHVSxBfFQ84B4PvspD9RgWxGQuhUs6s1dZh44anuNeAQ+0a+mdOZoJSBWb/EPU33L64BeuDOk9oTXG0Ah2SBYwaoG9p/+4CtWOnlUtGatXPSQ8bXRbAci98wOtadtMhl2pGgHMCkVXvmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NCoX9DS0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 067A140E0206;
	Wed, 10 Jul 2024 17:19:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ewiBphV7D_KG; Wed, 10 Jul 2024 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720631974; bh=eCwsCaHH3nNUtEHLmttXrdCWSWB8LWlW1inXQHgFI2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCoX9DS0Ni66Z7QLBuk8BAgkpRB3a8dX0WXg52nC8Alpt048IoglDMnzFPmDykUDE
	 vrEMEEghVqlC4rBNAlavEojIR7BspEXgwcqhUg4QxK30YOOkw/qcn+H7agBtEnS/gP
	 GSqsFsem29H0Sr7bJnM5Y3gcoGtip61mlRSstEOoScOPINSMVh9g16slgqjYIPRjki
	 nkdroKhfUK4oK+cztBJa+6ln1C/plo4S9bx/qonmeLxWRYXyyTbh3ycJvRKSx4peeD
	 rpY6wnJ6YFHH4kmhMB09+6RKCkwf0RuU7Hj0cs+I35un8YJKydi8tBbkPxWyTxR0Xi
	 nq2TTyXOo0tUciciJqfoXj2kiIEDozBP7QAeAtnHrMVEuS3g9Bj+FdnI5QbQQMRtcR
	 z3c+42afC9o0KFKGW7PoLoldJy1DIrfXEu9zYQztsH1yBQA00bRqPpiEYBHpGSzdHe
	 eLwK7c2zolYIV7Yh6X2u35GvmoThRluK1+ULhK5txGl0p8i24yFINvw0Sqr0KETd/y
	 hRq4eFmWabSWSY61oCH8bie/wuTkpOvMKgBdmzqpZ7uQrdG9ycBIU/cH/uAk83uman
	 fNPbjtQUkShDarIUH5FL14Eqm1U6Agle73ym+89GSQejo10IZJ1bMTV5LH+SbJ9iD7
	 Azz0lvwfp9KVHAz0C/eRh7M0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E6EC40E0027;
	Wed, 10 Jul 2024 17:18:42 +0000 (UTC)
Date: Wed, 10 Jul 2024 19:18:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
Message-ID: <20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>

On Wed, Jul 10, 2024 at 07:06:39PM +0300, Alexander Shishkin wrote:
>  static void text_poke_memcpy(void *dst, const void *src, size_t len)
>  {
> -	memcpy(dst, src, len);
> +	stac();
> +	__inline_memcpy(dst, src, len);
> +	clac();

I think you need LASS-specific stac()/clac() or an alternative_2 or so. You
can't cause that perf penalty on !LASS machines.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

