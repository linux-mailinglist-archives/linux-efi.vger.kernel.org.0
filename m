Return-Path: <linux-efi+bounces-3681-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125ACAB53B7
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 13:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E23819E2EBB
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36A28D840;
	Tue, 13 May 2025 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBo53dpn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E128D841;
	Tue, 13 May 2025 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135341; cv=none; b=ehcgzklrdRLTVxoXYDRMMx5W262KjtBbnHP4depgJKLInFCPnx/YJ0w0t/PXwC8+GS3DuIPpwKSCdWSkH4rqejHU/kQ1hhGe60IjYVlrbIN76MAwORpEW9kJIHgtzRJx7DSdfy0ZxaRDj3Ly54hjCmMJjGw9qfitynOsuRCgXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135341; c=relaxed/simple;
	bh=YvBZA2ODgPMq4RkBEfvD4jmjANv1xA+U3XIuUuBhbZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7RnsM+jANfGzixs2kTFJxReOW1r5zagGRGlXk/8znbltNLMles5p9a9MvG1S/zYRHosWLUbYo1Aa1j1W9kuPoL3wmYmMkSskCzvz/yS7pRODdPcYhJh2C7FZQsanKJphXY5hooE4/Qd4nxTJIruwLqPS8QaFw0i/9+z68/yn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBo53dpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95ECC4CEE4;
	Tue, 13 May 2025 11:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747135341;
	bh=YvBZA2ODgPMq4RkBEfvD4jmjANv1xA+U3XIuUuBhbZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBo53dpnGwWp40QAtiKDe0dWhYGg0nJ5eVk0YUhUOWmu2pvwYyCElBIwbQUkTjqXt
	 bAJdEyWEnN6k1OlzFwihodK40pm7msjUp38aFDMf4cmj6uj0aHsKvD5A+ek4x0Y4hf
	 Rc/w75xaKjGpfCKCJutJwog6T1AA+09WPpsNfLlYwAWj5C6IZ5zAUD32wgw5GopbHZ
	 sS7OSvVixhn3W7/lnTw0NcIwsoYyaL/UQSmuyCa+9vJ+t+M2j/3u6tflx6B8+Dggvw
	 k1GC2FwZ2HXJPFcSTumZ4cKBDY+FsHxqO2lBVQIQ64r0PMM3r7ymbygOVDcwTgRHoQ
	 E3idDtZ91srRw==
Date: Tue, 13 May 2025 13:22:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <aCMraFZ2yJQNyHf3@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, May 13, 2025 at 12:02:22PM +0200, Ingo Molnar wrote:
> > I don't intend to rush it,
> 
> Thanks.
> 
> > That request for testing was ignored AFAICS. It's May 13 and still 
> > crickets.
> 
> Not ignored - Tom and I are testing but we're busy as hell too.

Yeah, so the problem is that SEV* is hardware that basically no active 
tester outside of the vendor (AMD) owns and is testing against 
development trees AFAICS.

> > We also had SEV-SNP boot bugs pending since August 2024, that 
> > nobody but (eventually) AMD triggered.
> 
> Where?

I did a quick Git search, and here are a few examples:

For example, this commit from last summer:

  6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")

... was only fixed recently:

  d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")

Or this commit from June 2024:

  34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")

... was only fixed a few days ago:

  f7387eff4bad ("x86/sev: Fix operator precedence in GHCB_MSR_VMPL_REQ_LEVEL macro")

Or this commit from June 2024:

  fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")

... was fixed a few weeks ago:

  8ed12ab1319b ("x86/boot/sev: Support memory acceptance in the EFI stub under SVSM")

Ie. bugfix latencies here were 10+ months.

Note that two of those fixes were from Ard who is working on further 
robustifying the startup code - a much needed change.

Ie. when Ard is asking for SEV-SNP testing for WIP series, which he did 
10+ days ago, you should not ignore it ... or if you do ignore his 
request for testing, you should not complain about the changes being 
merged eventually, once they pass review & testing on non-SEV 
platforms.

> > Ie. very few people outside of the vendor are testing SEV-SNP 
> > AFAICS, and even vendor testing is sporadic ...
> 
> Not true - SEV* testing happens on a daily basis.

If you didn't have time to personally test Ard's -v2 series since May 
2, that's OK: I can merge these proposed changes in an RFT branch so 
that it gets tested in the daily testing flow. [see further below for 
the Git link]

In other words: please no "gatekeeping". Please don't force Ard into a 
catch-22 situation where he cannot test the patches on SEV-SNP, but you 
are blocking these x86 startup code changes on the grounds that they 
weren't tested on SEV-SNP ...

> > Please ask AMD internally to get SEV-SNP tested more reliably. 
> > Testing this -v3 series would be a good start. Hint, hint. ;-)
> 
> We test everything that goes into linux-next. We haven't started 
> testing unreviewed patchsets yet because we don't do that - that 
> stuff is moving.
>
> So if you want to merge something, just ping me or Tom and we'll test 
> it.

Here's Ard's request from May 2:

    https://lore.kernel.org/r/20250504095230.2932860-25-ardb+git@google.com

    "Again, I will need to lean on Tom to determine whether this breaks 
     SEV-SNP guest boot. As I mentioned before, I am still waiting for 
     SEV-SNP capable hardware to be delivered."

This request for testing was ignored AFAICS.

> But you have to give us ample time to do so - you can't merge 
> something which Ard sent *on the same day*.

Sure: -v2 was sent more than 10 days ago, and the testing request was 
ignored AFAICS. Do 10 days count as 'ample time'?

Anyway, to make it even lower-overhead to test these changes, I've put 
the -v3 series into the WIP.x86/boot tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git WIP.x86/boot

Only lightly tested. Just a "boots/doesn't boot" kind of quick feedback 
would be much appreciated.

Note that naturally this tree is still subject to rebasing, as review 
feedback is incorporated.

Thanks!

	Ingo

