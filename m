Return-Path: <linux-efi+bounces-1523-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0CC9429FF
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 11:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4681F25551
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0675E1A8C00;
	Wed, 31 Jul 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JoYvkrUK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZubrFjMK"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639871A4B47;
	Wed, 31 Jul 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417309; cv=none; b=oEHMOmJRI2FhQrkPUfYzvgYhb1kV2xWfSRxjBl4xtbgljZwrK3rxd7i5SqRtPUFwT5Ml3HSptN98Cy8CxbUmsdsHBXNOtfWUMXfzvjK0MEo4B7TAEbYUet+v1DVqjhqO8hNJGL5oHaLmly8W1fzBpZ31J6IMHbZ6nsbxEG9mA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417309; c=relaxed/simple;
	bh=gFTnTwR+J8LI8I4tt5wK4A63nLdZhz9S4T6KkipPYX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zno9x8z3LpC9hCiarlGxTtI6cY0nXiYHHgSCKzULtu3BzViK8Q1LJvrXmtOCaPfGfObehkMfrsQ0Dt3RS6YESOTfPhaYVWRMqd8e7+hweax3WSfB3AYgtl4+jKLHmRvQSe0x6HePnbBlJ0PaKs7q+N/S7U/Kq2bqwD97cLva3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JoYvkrUK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZubrFjMK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722417306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNGWZZ5ZQKrAynm2JoLziPZQiNLOegDYK5Oz85U3bzA=;
	b=JoYvkrUK9bl9Xry93jw39ahjcIcjSiolR/z+Ozgo8290m1rW2k0RCFDbe96k8y2Zwq5bNR
	gCYXVNk5odCTEoj6xoo7u43vvrIm6UsPOOk0BKBO7owCgnCYowKVhiYIkwLR00RSOxQsy8
	2OCy7IkrBKne7NDoFrGWE3jZCgzn7xc9AZQ85Sj4lDBsN/v8hcRgR4ogw/9XjYSq23sD3y
	KOwsJ9kjc9wDFKpW0PEPcB0QWP7/paC1wFUCC95sgriKRFh68IpQsUHKnHfOphyYboNNS6
	RtrhDpJ7sp/K20t95xH6K0zrmxnpOCAkfJ5EfLWMLgbsz0HUzYEDUmHLh0vYJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722417306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNGWZZ5ZQKrAynm2JoLziPZQiNLOegDYK5Oz85U3bzA=;
	b=ZubrFjMKtjGonD/DvEWn82TfhmSaYYOKHVTimUeiK5D34/6+X0iIX1mYj2P+hSTUHWi9fk
	uhRUIC+l5vrr5/BQ==
To: 20240621164406.256314-1-kirill.shutemov@linux.intel.com,
 kirill.shutemov@linux.intel.com
Cc: ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, hpa@zytor.com, jan.kiszka@siemens.com,
 jgross@suse.com, kbingham@kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, michael.roth@amd.com,
 mingo@redhat.com, peterz@infradead.org, rick.p.edgecombe@intel.com,
 sandipan.das@amd.com, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH 0/3] x86: Make 5-level paging support unconditional for
 x86-64
In-Reply-To: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
References: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
Date: Wed, 31 Jul 2024 11:15:05 +0200
Message-ID: <87wml16hye.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 14:27, Shivank Garg wrote:
> lmbench:lat_pagefault: Metric- page-fault time (us) - Lower is better
>                 4-Level PT              5-Level PT		% Change
> THP-never       Mean:0.4068             Mean:0.4294		5.56
>                 95% CI:0.4057-0.4078    95% CI:0.4287-0.4302
>
> THP-Always      Mean: 0.4061            Mean: 0.4288		% Change
>                 95% CI: 0.4051-0.4071   95% CI: 0.4281-0.4295	5.59
>
> Inference:
> 5-level page table shows increase in page-fault latency but it does
> not significantly impact other benchmarks.

5% regression on lmbench is a NONO.

5-level page tables add a cost in every hardware page table walk. That's
a matter of fact and there is absolutely no reason to inflict this cost
on everyone.

The solution to this to make the 5-level mechanics smarter by evaluating
whether the machine has enough memory to require 5-level tables and
select the depth at boot time.

Thanks,

        tglx

