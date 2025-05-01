Return-Path: <linux-efi+bounces-3519-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954CAA5D3D
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA369C4324
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAD1D61BB;
	Thu,  1 May 2025 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="crvnWNJn"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C219F12D;
	Thu,  1 May 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095452; cv=none; b=YatIm8qL2hVfqlbKPZozFlPvKoxnth9c0UOtVMdgOLQK0ha0TrkXNtnwCIqXCwnzJo8AwsJTciNsoS4Bl7KskbYp4i8E425uWglHDUpQwP/kP7rV3PFg/JEmm+s6Uo967SNaJgTf1zASyIVFgkIJOa3KwTxn1sWelikuPNRaSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095452; c=relaxed/simple;
	bh=XpbBawKWzBBuqs88Kn7OkQDVDvLjqX6HXmxzkGJ0WRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzqVKVD96cuZrkrae9UFCXuoXd0pF+eU6NzhrX0eyKbOr69fHDm54f6tbNKEYjoW3jSs+Omz1xkvprGsQyX87QfindU8SA/e1KI3iHj3jiHVvZogfPpfqmWFm/LMDHcHiFlPkzeqE8sdOLwcfrAI0spu7iIWt5Q1s8f2i/8mGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=crvnWNJn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EhR7ZzIBi89ApjQaqgEu2V5WiXEmzHjGGhYf5bYe5UA=; b=crvnWNJnqfvrBzvDW0OoZAttgL
	rD1X7HYMrlHz8S5qoPuWFzKNpqaUuIZUJ6s+fBt0OM0oip0dfeFvCLJpXZFIetf5pdi7tqYsUJeaR
	sDsixYqsc5ADh1iMmr2TnxHStJxyQKW5zOi8RsaxERbmiWv7FD1Vy7Y1FcY+aSXEy5hzJ1CY+aMjG
	pHOUiJbmB68i9atReeyLxaOIKywhUuzSUG5r4In77D9U7iaV7FBhSn6NXGOuFzYk1d5kKRsedgxSc
	ITBB+y/zeCiIiMd5bCUGRUBSQMZ/lz1RLTPNswYdF+J/ulovCBqWBexm66xmvYGgrDwHyYqSQp8l2
	0kolHYEQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uARBf-0000000Dy9Q-04Yc;
	Thu, 01 May 2025 10:30:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 56531300642; Thu,  1 May 2025 12:30:38 +0200 (CEST)
Date: Thu, 1 May 2025 12:30:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250501103038.GB4356@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190600.GQ4439@noisy.programming.kicks-ass.net>

On Wed, Apr 30, 2025 at 09:06:00PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 30, 2025 at 07:24:15AM -0700, H. Peter Anvin wrote:
> 
> > >KVM has another; the VMX interrupt injection stuff calls the IDT handler
> > >directly.  Is there an alternative? Can we keep a table of Linux functions
> > >slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
> 
> > We do have a table of handlers higher up in the stack in the form of
> > the dispatch tables for FRED. They don't in general even need the
> > assembly entry stubs, either.
> 
> Oh, right. I'll go have a look at those.

Right, so perhaps the easiest way around this is to setup the FRED entry
tables unconditionally, have VMX mandate CONFIG_FRED and then have it
always use the FRED entry points.

Let me see how ugly that gets.

