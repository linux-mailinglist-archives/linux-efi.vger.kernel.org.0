Return-Path: <linux-efi+bounces-4824-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74720B573A7
	for <lists+linux-efi@lfdr.de>; Mon, 15 Sep 2025 10:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345233BFA82
	for <lists+linux-efi@lfdr.de>; Mon, 15 Sep 2025 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E02F49EE;
	Mon, 15 Sep 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mi6ywzPP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/8h1CSO8"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875012F3C36;
	Mon, 15 Sep 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926371; cv=none; b=kN9W8M4zgSKMB7hTCGhSTwOXmpquutWkc4fziFzLMB1LxPFCmVhQrbMkex35MAHUszhHVL2Vaa0DMQTqA08bThiGGytEJZ+pECL3Mdxwt02McDtoFMsdIFo7mGD+SgOP/V0HeeweLQ8cCheVnv0qEqCcnV6Oe3GQ4x6rbk7caf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926371; c=relaxed/simple;
	bh=DzTfZ6OkL6obc9RRZlXoM/ipHMTfVXpFSNM7FHA1pyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz8k55wqClyfuIsySlS25MWwgwTKlAfBobJ6g8axMXFpwWHHpDbnCjYPhi+42mfjdzNr8ieawcn/4YPv39EkY2feppfd2KTZ1VNMl2GmaK9YUu24MNfi+yAsrlANOHaWhs+/FSePnykhBjGYg4aB0VlHRkM3ICyo0oG038UZspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mi6ywzPP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/8h1CSO8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 10:52:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757926366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzTfZ6OkL6obc9RRZlXoM/ipHMTfVXpFSNM7FHA1pyY=;
	b=Mi6ywzPPfRmBkAmPmmB94PBsG5oAxNjMQaRNxHmpFFRQte/ejEj+iFvVnSU059WrUIJWPZ
	We53G9QOrAp0d3hHq9hkC+xDGZvWtoQmIyeRcHLWiAHtW5rwfmj8hzj0BBor/WXWLljKHr
	sb7mlc6wfgkb8y6RwFyC/ePJ+r7gwciLWdGro1KISwtBDOtnW5sFSBcASghzouJssqAZFl
	6P72GjWYOQxrnm1zDq/kraIMBZZd+OjeyjWSpWaMoEO4TLYN1Q2++Fi76HJoLGeAx5xsai
	74/lbH+OPgC4Agtx3TebC1R7gcr6b6upBqDqTUNkSLqWyJknMgoVvEGDzUMgiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757926366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzTfZ6OkL6obc9RRZlXoM/ipHMTfVXpFSNM7FHA1pyY=;
	b=/8h1CSO8vFJcz/ZTIkGrrYdbGZzg3Kci40oMB631Wj5xPFCVqiizAdgJR29SEmSbNeFaaq
	WYGQ/mjmGmv/g1Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/7] arm64: Make EFI calls preemptible
Message-ID: <20250915085244.JLUfpdSP@linutronix.de>
References: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>

On 2025-09-05 15:30:36 [+0200], Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>=20
=E2=80=A6
> Note that this is only a partial solution in terms of RT guarantees,
> given that the runtime services execute at the same privilege level as
> the kernel, and can therefore disable interrupts (and therefore
> preemption) directly. But it should prevent scheduling latency spikes
> for EFI calls that simply take a long time to run to completion.

That sounds nice. There is no feature flag that could tell if a specific
EFI-call (or any) will disable interrupts, right? But if the source code
is available, you could check.

Sebastian

