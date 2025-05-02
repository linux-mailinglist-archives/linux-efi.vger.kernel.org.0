Return-Path: <linux-efi+bounces-3530-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A224AA6CB1
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4193F9A5E8A
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9D22B8B8;
	Fri,  2 May 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DIzoxIz0"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1C22ACD1;
	Fri,  2 May 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175326; cv=none; b=HL0VEFYErLGLknlwmMRlZwm0xUAUFzijwrDsJ3F9/knT8zCrA7GOdPiQDbIGpGe7Jj+QSQy+cR8Cbi30mzwZHlXyOYEDu+3oKNMLRtPevSGkVX+vNHQl6ibInadvEdbSe3hRarrnvVLPXleada3vommvdgDz8MoeaE7dF/+rZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175326; c=relaxed/simple;
	bh=JAkxRcMnCLTEaaF2Sx3Fm9Sem8/O4saWART4WZ6A1pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqzjmhb+CWUQxbLnzdWie/Lgk2+bEiJmi6tV94ye3Q2SPSuVknh3LThz4uKCKqaOrS8TFbY0SwXcFgUhm3W3EeMzkBZ3jIvaNYCeShXzRzkUlw7mFkFQvLUyhDVFZaB+vZi9GpYuIG44GgdbddW9NoyGEAUj3eBEhOvdHqYGbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DIzoxIz0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j6cbPjR+T0yzG1mLDzVIumfGnchJ8jrJp8SEOFZnJ0c=; b=DIzoxIz0Ehp+HLggJApwwus3VG
	7rYxbEyl0G5WKBNyh2ko6DrCZQ4m22+3PRjS5LpsFKXwZDC93qkLiI5/pSl9Vwju11TlWH28Wji0O
	3xCqPFuF+TFs4nOK3tU9tnjCQx/575+qsVxK2leGPxXJnNDK+3KuUcuZZQPq6oT9u2sCGOBRdPbY7
	lgl87qfSpNsoydPh2dRBaLEXE9dxXJT7yg0k+6KT9OiUJh3mj4O9SGoAW4StpZ0fDtNqZZiWi7J3Y
	4HFfdhDqgekQjYw9G7bjWSo5vt8rruRV3y3h/A1/v1SRKMYxHXrUxd0gu5dsATZQcjts0dGwLI/yl
	ZoIv90BA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAlwb-0000000At0F-2Hrl;
	Fri, 02 May 2025 08:40:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF3193001D4; Fri,  2 May 2025 10:40:07 +0200 (CEST)
Date: Fri, 2 May 2025 10:40:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250502084007.GS4198@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBO9uoLnxCSD0UwT@google.com>

On Thu, May 01, 2025 at 11:30:18AM -0700, Sean Christopherson wrote:

> Uh, aren't you making this way more complex than it needs to be? 

Possibly :-)

> IIUC, KVM never
> uses the FRED hardware entry points, i.e. the FRED entry tables don't need to be
> in place because they'll never be used.  The only bits of code KVM needs is the
> __fred_entry_from_kvm() glue.

But __fred_entry_from_kvm() calls into fred_extint(), which then
directly uses the fred sysvec_table[] for dispatch. How would we not
have to set up that table?

> Lightly tested, but this combo works for IRQs and NMIs on non-FRED hardware.

So the FRED NMI code is significantly different from the IDT NMI code
and I really didn't want to go mixing those.

If we get a nested NMI I don't think it'll behave well.

