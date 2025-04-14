Return-Path: <linux-efi+bounces-3330-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E635A8851F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D2E17145A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212F279794;
	Mon, 14 Apr 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtu++a6c"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17990279792;
	Mon, 14 Apr 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639706; cv=none; b=feIEm3+TDaqTmfS0dT9TJ+y3X8ECA2YoQgl8I53qA5iVN8Wxk+xoq5aOeKgfOVZGTgRYbFokgueD0gyZQuG/Q6npfE71xqnn/OBMJrI2p4hNPVNQIajA7YWCNvnuuhJhj5k1tyYEHJu/sJFAUze7FINnDpcwEb3C0C5tU3JmTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639706; c=relaxed/simple;
	bh=ADFeH5tjt1W9hhHOoguOiCVcN/udHzOW/9LpN4Ta6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv2qgHtu347c4CBKUpWti6H3J562S/SfzHXTsAHXBrChYkOsLPjVceVGKxKQ+dAlpceaT+A8rv0dC/RhAlAqyYYRhQVKc3e7IwW/w3v70LzKPgGqWuNgXDYHUrKALYfPUqRE7P9sYqSIln+/fXSuYa459RlaAJBjsw32RKo4Nb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gtu++a6c; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O/jdKSlHgdd5W08mEbl7mUAGiGWimlSatVW/4OfjF3M=; b=gtu++a6c8AnOoqOwrZBfc4C5fA
	eFF3Rz7+mKUFP3eiF9TWOgBi5+stFHU9nLz7d4pUc0T6dYUxwFUnpRPkZsevOmigZVuwjZJIjUEKT
	xC8RMMjQeKekaOA1JzHOPK/e9jvtMyAjuL3Qgq8apMPyxc+WS/+ZjHV5QyCOPmXM32X4l7/QeHxu9
	lZpfDncoMK6OyLd5jfGUaBS5aH0Plh9LSxU2wO48/LskZbLgjDbCqGODEXy57hGGU0ku98LDmEis1
	WCwGCfRt+q6zsL6EUE0gz8JuQuBvwTaqnqO0dXZVLEV0szX1OmAfYRw5tg/GNCvYLRAz0IkEVmkkT
	HjOnaaYg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4KTs-00000009i5p-2WUX;
	Mon, 14 Apr 2025 14:08:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30FCE3003FF; Mon, 14 Apr 2025 16:08:12 +0200 (CEST)
Date: Mon, 14 Apr 2025 16:08:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com, seanjc@google.com,
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 4/6] x86,hyperv: Clean up hv_do_hypercall()
Message-ID: <20250414140812.GH5600@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.285564821@infradead.org>
 <01c65464-8535-28d8-a9b5-eb4f90114e2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c65464-8535-28d8-a9b5-eb4f90114e2d@gmail.com>

On Mon, Apr 14, 2025 at 04:06:41PM +0200, Uros Bizjak wrote:
> 
> 
> On 14. 04. 25 13:11, Peter Zijlstra wrote:
> > What used to be a simple few instructions has turned into a giant mess
> > (for x86_64). Not only does it use static_branch wrong, it mixes it
> > with dynamic branches for no apparent reason.
> > 
> > Notably it uses static_branch through an out-of-line function call,
> > which completely defeats the purpose, since instead of a simple
> > JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
> > absolutely idiotic.
> > 
> > Add to that a dynamic test of hyperv_paravisor_present, something
> > which is set once and never changed.
> > 
> > Replace all this idiocy with a single direct function call to the
> > right hypercall variant.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   arch/x86/hyperv/hv_init.c       |   21 ++++++
> >   arch/x86/hyperv/ivm.c           |   14 ++++
> >   arch/x86/include/asm/mshyperv.h |  137 +++++++++++-----------------------------
> >   arch/x86/kernel/cpu/mshyperv.c  |   18 +++--
> >   4 files changed, 88 insertions(+), 102 deletions(-)
> > 
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -35,7 +35,28 @@
> >   #include <linux/highmem.h>
> >   void *hv_hypercall_pg;
> > +
> > +#ifdef CONFIG_X86_64
> > +u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> > +{
> > +	u64 hv_status;
> > +
> > +	if (!hv_hypercall_pg)
> > +		return U64_MAX;
> > +
> > +	register u64 __r8 asm("r8") = param2;
> > +	asm volatile (CALL_NOSPEC
> > +		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> > +		        "+c" (control), "+d" (param1)
> > +		      : "r" (__r8),
> 
> r8 is call-clobbered register, so you should use "+r" (__r8) to properly
> clobber it:

Ah, okay. 

