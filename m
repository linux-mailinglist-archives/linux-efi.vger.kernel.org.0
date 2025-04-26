Return-Path: <linux-efi+bounces-3469-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE56A9D9FA
	for <lists+linux-efi@lfdr.de>; Sat, 26 Apr 2025 12:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CF81BC056F
	for <lists+linux-efi@lfdr.de>; Sat, 26 Apr 2025 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC721E0BD;
	Sat, 26 Apr 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gHgjDCY6"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21685134A8;
	Sat, 26 Apr 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745661737; cv=none; b=jQ2mXp+4GlVuM3u2qZlfGkjWfamCYLYzgnh5M9An/fRnoZCVMUD4qb9bt9650A4WQB2ZX6uJSjJR/WP3gkoDWmFGmX59LSOpEwsMQFKZ8tOm+h1xZB4uGfDEUBej7znDf7jZQSe79HNPQzVafHZB6nCSj4ndR5gqz/k383pZxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745661737; c=relaxed/simple;
	bh=wYHPVCkX7MaZ2Hq9KQkLjKX+zqp6AH2eWz8cN+OxOo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKNhCg/oYgBIbyBNIEAFkNgov3cOe9bF44SuPNL7KEYOaR523r2q7IdyylNidYJ1ybJKKaEkRQMvugC9nAk9wZLkA0s7xTLKAQ4zJUBQCN709bNBhqH2WTYIIpScdVirtLiroWHl8HU74mf0LgqLalhClXS7opoJv0lzU7ZDa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gHgjDCY6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wYHPVCkX7MaZ2Hq9KQkLjKX+zqp6AH2eWz8cN+OxOo0=; b=gHgjDCY6KKznuUtl9/gyzewjW1
	czrJKP0C+w9em+magoSJBsnbwnmB1FxAZclmVbGGGbwOtIh531oIzs4UZJOlanLTURQRMseXxXiFu
	piLjrkW3kQWgeQ4woZoP6j+Rx0c4mcXHryT4Ps9dGJ5bpBdoHTVP9rdChmQ7/MAyCEnxBUgPQOLXY
	OBZWxtbBb8ikuy/7Kxi9KXuvTZiNLyanvp0y+cAtdw9bxQjTujvVSliTASYz9pqeE6vzSfVh5akpa
	MUcXcxDRKM8jzdmqjTkfMNEsmBe0rHkJLHcW99+vYAx6mSXAr+F43uOk74W9Aa0U56quY5TCll6Li
	jzuQiggQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8cLn-0000000CFRA-2LoI;
	Sat, 26 Apr 2025 10:01:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EEC2E30035E; Sat, 26 Apr 2025 12:01:34 +0200 (CEST)
Date: Sat, 26 Apr 2025 12:01:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, seanjc@google.com,
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20250426100134.GB4198@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net>
 <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
 <20250416083859.GH4031@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416083859.GH4031@noisy.programming.kicks-ass.net>

On Wed, Apr 16, 2025 at 10:38:59AM +0200, Peter Zijlstra wrote:

> Yeah, I finally got there. I'll go cook up something else.

Sean, Paolo, can I once again ask how best to test this fastop crud?

