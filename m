Return-Path: <linux-efi+bounces-3679-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1FAB50F4
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD263A9F0A
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 10:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3423C50A;
	Tue, 13 May 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B93nRF2F"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81571B4159;
	Tue, 13 May 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130548; cv=none; b=khWlYfoAtZvy2Z66tidn7oz+r2H+2ow7rKBFjtMU+VYtaNO/IeJnUo/YdqUQAHmn3WB5mPaAzGKvSOeP04UB0yZg4qKhUPyohQVuY505XXCoCJ5LBhCaOdNZEDzipHFY4aqGnT5oM8XeKW3pVVNEAGmHgiMNeUgNoZ2PbYYaWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130548; c=relaxed/simple;
	bh=M7yC5gonucPh1l67fzVqttNOeD8QRYITN3RB/I7G3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eut6L7rBitDsFvJe5yfxvarFDab1FkGjTrlMnXG2XsoQM5U3X69LkHJ7AeMbD+uuGEFT+cmmt5w3eHxPXXZDeWJC5heoLAm4awdy2GUoUiR8r4397sA2MrzNulji/GJI2IWukHwj3If3m17x8YsSaz8GIyJeAz+OzOWRrKh2LLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B93nRF2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167DCC4CEED;
	Tue, 13 May 2025 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747130547;
	bh=M7yC5gonucPh1l67fzVqttNOeD8QRYITN3RB/I7G3XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B93nRF2FEnevVm2OKxuN5M7Jwdgraa4JcjF78RgQvzVgQNPreorB9HgYh5Heoly+N
	 lxVijv1t0n36BmQJg5Ez5OcERJ0B4aGllkRoesUkoN3kbsA1grVTBRIFoTV3G48UBb
	 npuVCDrlqV6o1liJALhxMnw7rQosbKe7tIhTUsBl8/xihBDSzHvxj8OVzmFNq7uzDK
	 XzVHo0hGKH9P770YqfQ0Sgn0EItEpMFDReClb9Lhaj6AofCrfaHTTUZo7+yryon6uD
	 lqV6LjFLoiX9A1YuvIOCTllYlJ67HwagBqnywS5YxPznuQ9POhlBG+DlVClXJF8R1x
	 T55NLATh6kzLw==
Date: Tue, 13 May 2025 12:02:22 +0200
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
Message-ID: <aCMYrgd9DDQl7G1W@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, May 12, 2025 at 09:08:35PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > !!! Boot tested on non-SEV guest ONLY !!!!
> 
> ...
> 
> > !!! Boot tested on non-SEV guest ONLY !!!!
> > 
> > Again, I will need to lean on Tom to determine whether this breaks
> > SEV-SNP guest boot. As I mentioned before, I am still waiting for
> > SEV-SNP capable hardware to be delivered.
> 
> Ingo, please do not rush this stuff in before Tom and I have tested it
> successfully with SEV* guests.
> 
> Thanks!

I don't intend to rush it, but note that AMD's SEV-SNP testing is 
lagging a *lot* at the moment: Ard asked for testing the -v2 series on 
May 4:

    https://lore.kernel.org/r/20250504095230.2932860-25-ardb+git@google.com

That request for testing was ignored AFAICS. It's May 13 and still 
crickets.

We also had SEV-SNP boot bugs pending since August 2024, that nobody 
but (eventually) AMD triggered. Ie. very few people outside of the 
vendor are testing SEV-SNP AFAICS, and even vendor testing is sporadic 
...

Please ask AMD internally to get SEV-SNP tested more reliably. Testing 
this -v3 series would be a good start. Hint, hint. ;-)

Thanks!

	Ingo

