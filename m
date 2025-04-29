Return-Path: <linux-efi+bounces-3486-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831AAA0F73
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E0C4A19AA
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25E218AC4;
	Tue, 29 Apr 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="it0iWgin"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367813B1A4;
	Tue, 29 Apr 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938011; cv=none; b=LaQShacy5NDlH5OxM0sA8nslJhT0tecLPUXxT736ro86ec2K6Sb1E4cAgmUacX9vwB+FYKEaYcZ1QRhv5WT1aCbi1hqw1nbIeyvq5lzqw3Pcognt8GPR/C/2csafrfE6NrOIZJb8UxjVbs5um2yOFMMxAhstmnUZFgbW2UIgIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938011; c=relaxed/simple;
	bh=vg3hLhxa0BT1lWtJ0wGlClMnOrlCg2NBvt6huItHUVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSkqekv8j08pmtzkkBs+zOt5NETHYeRO9mt0pQj4dcPkqUEGoEKC8PL8+Z7KaGWceCOE6IiDU1KU13SubvTJCXvF/osGQ/rv8ax0PY69XFUntTGF0t0mB9xNHLQOYWwcZwzu+87gDf7GC54ohuV3OqrKZtvTbP285l2ZClTidrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=it0iWgin; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wb8yKBSDCNd+wK+Tsc/EBbJclD6fbaVvRfrOmBDAvfg=; b=it0iWgingi7xBwddoimoLQmsC8
	P1qAwKNqpnUT+k+Oq1/EnY2+drj48W4KhIqm0UtjfhuV4TC75P9XnisekHhjPnMUrqDraqOqH5e75
	fr7NrtYVqMB8/NY/ibTmdfc69swXp3Lm7ZYNhQ6jGzXnYHk1u320d7RMzOhOv269gP4h+b9IsFGGx
	K2aG4+fnJIFiD6DHGh6t1Pgal1j8P/KDpUeXf4uVwKFBHzlQQ+NnnZkYjGpym44+aeON7V/Usrsff
	0paTYLzK+CMmamTcDvI5K2R9l28N0VW+2HmOu6MjWnJtgSPhqxGypqTFyY8IqgtRJph5lDNViPhLJ
	qtNfYOVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9mED-0000000HWLz-0Zv5;
	Tue, 29 Apr 2025 14:46:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9315300777; Tue, 29 Apr 2025 16:46:31 +0200 (CEST)
Date: Tue, 29 Apr 2025 16:46:31 +0200
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
	ojeda@kernel.org, shuah@kernel.org
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20250429144631.GI4198@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net>
 <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
 <20250416083859.GH4031@noisy.programming.kicks-ass.net>
 <20250426100134.GB4198@noisy.programming.kicks-ass.net>
 <aA-3OwNum9gzHLH1@google.com>
 <20250429100919.GH4198@noisy.programming.kicks-ass.net>
 <aBDcr49ez9B8u9qa@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBDcr49ez9B8u9qa@google.com>

On Tue, Apr 29, 2025 at 07:05:35AM -0700, Sean Christopherson wrote:
> On Tue, Apr 29, 2025, Peter Zijlstra wrote:
> > On Mon, Apr 28, 2025 at 10:13:31AM -0700, Sean Christopherson wrote:
> > > On Sat, Apr 26, 2025, Peter Zijlstra wrote:
> > > > On Wed, Apr 16, 2025 at 10:38:59AM +0200, Peter Zijlstra wrote:
> > > > 
> > > > > Yeah, I finally got there. I'll go cook up something else.
> > > > 
> > > > Sean, Paolo, can I once again ask how best to test this fastop crud?
> > > 
> > > Apply the below, build KVM selftests, 
> > 
> > Patch applied, my own hackery applied, host kernel built and booted,
> > foce_emulation_prefix set, but now I'm stuck at this seemingly simple
> > step..
> > 
> > $ cd tools/testing/selftests/kvm/
> > $ make
> > ... metric ton of fail ...
> > 
> > Clearly I'm doing something wrong :/
> 
> Did you install headers in the top level directory?  I.e. make headers_install.

No, of course not :-) I don't use the top directory to build anything,
ever.

All my builds are into build directories, using make O=foo. This allows
me to do parallel builds for multiple architectures etc. Also, much
easier to wipe a complete build directory than it is to clean out the
top level dir.

> The selftests build system was change a while back to require users to manually
> install headers (I forget why, but it is indeed annoying).

Bah, I remember NAK-ing that. Clearly the selftest people don't want
selftests to be usable :-(

Anyway, mingo build me a copy of the fastop selftest, and aside from a
few stupid mistakes, I seem to now pass it \o/

I'll attempt a Changelog and update the hyper-v patches and then post
the lot.

