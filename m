Return-Path: <linux-efi+bounces-4702-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C850B45965
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D661BC1760
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57B352FE7;
	Fri,  5 Sep 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLqoNqLR"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BB25557;
	Fri,  5 Sep 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079859; cv=none; b=l/TQMLEtdP6qUUBa9Ss0Ku+mZSS10xcPQh5hg+0RT2q0THnUfjVJqfUDUxt6pg2jbiQyPTxg6d5VUMwooRHXfWJxuCbqAac26ik3lGk/M0kQ/gtNj/4Xgmu1mzpnP95UWlVM+0rqDvI4c2BSyt5U8K4OaJO7hKPVPL9HZzT9TuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079859; c=relaxed/simple;
	bh=7jO5M4dxRxab8w3goordHgPq1t2aDB/9tElwXjDmNRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6jXq1MpQqMEzEJprwBgfuPyifErPMelNA6IL0zZrD7dyRcjPhjuxKeRawyg3v15iw7Mc3ZgtHnkfM3b3pDcyUtxMxsIuFpeOqgtu52LZtVrPjCOhbj882PoyTXGsvIst5ewTb8yl2/XiN+LVz9kzX2ZXiZIFxv2joM4hi+I5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TLqoNqLR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1WKz+CUCVTpXCW4x1MmW4FRgp0BslUwCgj8AnFSebyM=; b=TLqoNqLRMQ/rFC1uxV/EPhacWn
	ysO0xj0Sc/1iHqPKULu1SojBXgNBQNSCXdxLBXQEzsUKJlW/VeTCEzaHh2SIjp4oKWZDj7cwGFCR1
	0VarXi5eP/sS7vaCJmEcTpkZJKiwSKNp3HTzmP+Rcgy7ZF7MCmEWt/XzfEWez3uy4dDOSTWrngBlS
	IVuafdZGVOmK4D5V35MZR8k/WaHBbffMV30fFfSeTE1wFUDJY3T5/8EoZ4W8j00+IK1cgBULjBvyP
	/Hqbz2gp8QeP9rbk5hT/KaKf9x9PjbupII1TpogirvXbWMLM9c7d9H8wv6Dg2jkRd7IQYuwh+Z3Pp
	G47XZQTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWja-00000004b29-2bpx;
	Fri, 05 Sep 2025 13:44:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FCAD3001D4; Fri, 05 Sep 2025 15:44:09 +0200 (CEST)
Date: Fri, 5 Sep 2025 15:44:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 5/7] arm64/efi: Use a semaphore to protect the EFI
 stack and FP/SIMD state
Message-ID: <20250905134409.GD4067720@noisy.programming.kicks-ass.net>
References: <20250905133035.275517-9-ardb+git@google.com>
 <20250905133035.275517-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905133035.275517-14-ardb+git@google.com>

On Fri, Sep 05, 2025 at 03:30:41PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Replace the spinlock in the arm64 glue code with a semaphore, so that
> the CPU can preempted while running the EFI runtime service.

Gotta ask, why a semaphore and not a mutex?

