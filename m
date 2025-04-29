Return-Path: <linux-efi+bounces-3483-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A66AA0824
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA05D1890A04
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC172BCF4E;
	Tue, 29 Apr 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="goXW2lO0"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090C24E4AF;
	Tue, 29 Apr 2025 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921373; cv=none; b=Jn6hLRPUk1JMYLTHEVX3DXDpycdWydT/PSP4E+9Z99XVGTdawgfcipBdbm8AZGPCsCqI7OVGCJaUKquyRQzc10OaR5TZ9jOGjYP+KT+MkzAPqW2OcitdLcMHAagwSsKpinebG47rdqdBDswqLAT7pu3oFDPAlTi4DrdB3L4PTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921373; c=relaxed/simple;
	bh=eLO1sBN9es+KqiA7uBtT5eAFv9XGUNJi4oXi0j72MFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYy2+rS80bXMNR7MLA1MKEB3ICvCwAwm6wF+4CDf1DWSP3xOJKTc9cMlgyaQTOCsgIhpJugJrSunW05toXdOftcGn3HSzXmB1JGWhYs/bMlOCEXPfd1dTCYNVINmzK84N+2AMXg8DAfhrpBebrGbFNWeewM0PoSf1skY6Da26T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=goXW2lO0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QPf4zQBm/p7IMNLfzi1aXzU7z6Pf+a2T6bBJiFnTgTU=; b=goXW2lO0v//rdTPZWHL5bTHk74
	vKr2MCEHHJNqamsPuS6+XZhMIXimx5tPKDtawbcI5TKayI06gkDwJKT1X7Em7p2VujfifDD3K/oZS
	PBY6OXGTGkYSf5b9T/mmNUuRtaIVD6fQG+loW3Cc/kY7RLAB3h9Tgg1BbkEig7AdMtBIEoiSFPrMX
	35l476LLz+JQXtKHw7ipQRTpc3w1HbCXPUPEzVb12mqBUPcg8E767Fpd02RGoohjr1Ti0dQY961ta
	+Rf3ukL4gUN5eHD/uPS/ENpFKaL0xJ1NC+Rfk9Ns2gslk2ZkPQAQqsVfazlU/pap4sYMX8pwYJwyR
	ACWAnLmA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9htw-0000000DGN9-1Rjn;
	Tue, 29 Apr 2025 10:09:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D2F8830057C; Tue, 29 Apr 2025 12:09:19 +0200 (CEST)
Date: Tue, 29 Apr 2025 12:09:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20250429100919.GH4198@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net>
 <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
 <20250416083859.GH4031@noisy.programming.kicks-ass.net>
 <20250426100134.GB4198@noisy.programming.kicks-ass.net>
 <aA-3OwNum9gzHLH1@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA-3OwNum9gzHLH1@google.com>

On Mon, Apr 28, 2025 at 10:13:31AM -0700, Sean Christopherson wrote:
> On Sat, Apr 26, 2025, Peter Zijlstra wrote:
> > On Wed, Apr 16, 2025 at 10:38:59AM +0200, Peter Zijlstra wrote:
> > 
> > > Yeah, I finally got there. I'll go cook up something else.
> > 
> > Sean, Paolo, can I once again ask how best to test this fastop crud?
> 
> Apply the below, build KVM selftests, 

Patch applied, my own hackery applied, host kernel built and booted,
foce_emulation_prefix set, but now I'm stuck at this seemingly simple
step..

$ cd tools/testing/selftests/kvm/
$ make
... metric ton of fail ...

Clearly I'm doing something wrong :/

