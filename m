Return-Path: <linux-efi+bounces-3688-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3219AB56D7
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C21895504
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024C70814;
	Tue, 13 May 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DsCZC0cn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7252A1AA;
	Tue, 13 May 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145826; cv=none; b=VCJZ6qeubMfCeVE4k+fw90zJIxrnmlHxeqU+bqrXvvlVo001uOtIjmyVx2GT4iJEm2Yob3nMjzsRN95eekziSfFSvpyKLbse/PpGG9s8IPFfrGLcz4DYTUudQ4J3MpsFngljFKB/9O3kGOvXwEiKarFpnOeiNwLJw3sJQI8pLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145826; c=relaxed/simple;
	bh=dUt5Yoj/CuRSCNF7k5sM6Y1Mw1AHK9WYieBsxERQSA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6W/SaiC/elrLIzcSIqijpF24Bd/gth8pp1oLlnZ7ll4pPUfTkeqe5FsI1rjEiAmbyJs4aF74b+t8P79IDEn0UCR/x+VvJ3atFJZoYIHazNRJHI0FRt/iuXfjM9EKek+O5lz33FVwFLBAfmDK2NQq9LYP6edhhRHWoHxkdePUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DsCZC0cn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 26CC840E0239;
	Tue, 13 May 2025 14:16:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qgClZEYW3rL2; Tue, 13 May 2025 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747145809; bh=DWv6vIb3P8azTiTE58CA2Zo51utZhYiUCVuJc8sWrd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsCZC0cnYAG35oPdywNSk1aAiDwh5rkFcjjgNqTrQ8DZB7yE6+J+m8SUpfJi7iHtt
	 RjFSM6xCyW/CZNwjNOzJ0Y6dvAb2qyE6WKtkujTjFi2rqv1yUcNX1ivlYh0FYdIDTP
	 7nSAGlQPfkyZV4MSD1+dIAUoudiMEMS3YpEWPs5fScrGtp1Q06m52owO2AezwWmnn+
	 sdGfE8eO2cJQ41s3aP+yheR5kVDmUbq6WgLHpLT/ClVxPrVwDg9pvQ8cUPDtDN1AF8
	 CWha9MSj33vOyHLqtbMXw8RfaxQ6enOqQZsvGi+5fiQdLTw7DVnIlwTvVGVcaN6BfE
	 D4TZKMF90lMUavNz0G6pBEN78Vptv2GatpjPn8E873rQokgZ9PAm5kk7IwMC4Mfe/K
	 8CPsuofQSMCLeP3MmljevpNJozyKDbjSZWSZxoJvTOcFpT3t+Z0r8d8uDscKk5FB2M
	 r8fOgqdLTvu1MBUzlNwRpo9lUvB4QfC5U907+uurru9CKWcRqlQtDfPG7JE93Mxm//
	 DacRaXofDHCD/7lJbgJh3WSIHfT7VZI6vCFyUiafuKJ2uwRAlXuBhslMUgl2WTYwlU
	 Cj3GQQXk4ZaKyeSvyAxQ7H+5hajy35mchZWqJQO8oKGBlmkzkJGpjlMFV78upJRgvy
	 VMvKIwhuZf3omzjXZ4rqyEFM=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D000D40E01ED;
	Tue, 13 May 2025 14:16:38 +0000 (UTC)
Date: Tue, 13 May 2025 16:16:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCMraFZ2yJQNyHf3@gmail.com>

On Tue, May 13, 2025 at 01:22:16PM +0200, Ingo Molnar wrote:
> Yeah, so the problem is that SEV* is hardware that basically no active 
> tester outside of the vendor (AMD) owns and is testing against 
> development trees AFAICS.

I don't think you even know what you're talking about. Hell, I only recently
gave you the 101 on SEV because you asked me on IRC.

So no, not even close. If you had bothered to ask a search engine of your
choosing, you would've known better.

All the cloud vendors have it and we are getting bug reports and fixes from
them and everyone else that's using it. You could've seen that by doing a git
log on the SEV files in the kernel even.

> I did a quick Git search, and here are a few examples:
> 
> For example, this commit from last summer:
> 
>   6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
> 
> ... was only fixed recently:
> 
>   d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")

Because we pretty much test with huge-page aligned memory sizes...  memory
acceptance tracks pages at the 2mb level. It will accept memory if there is an
unaccepted memory EFI entry that isn't 2mb aligned at the start or end.

So when you have a 4G guest or 16G guest you don't have that. If you specify
4095M for the guest memory, then it will trigger. And since that was done
before SEV was initialized (at least in the EFI stub path, not the
decompressor path) things just didn't work.
 
> Or this commit from June 2024:
> 
>   34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
> 
> ... was only fixed a few days ago:
> 
>   f7387eff4bad ("x86/sev: Fix operator precedence in GHCB_MSR_VMPL_REQ_LEVEL
>   macro")

That was "fixed" because we never had to run a multi-VMPL level setup in Linux
yet as we run Linux guests differently with that respect. So we couldn't have
hit it even if we wanted to.

And even in the SVSM testing, Linux never requests a non-zero VMPL, and so it
wasn't caught during testing. Linux will always request VMPL0.

There is a lot of testing of the guest code with Coconut-SVSM and it is
a scenario that doesn't exist.

> Or this commit from June 2024:
> 
>   fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
> 
> ... was fixed a few weeks ago:
> 
>   8ed12ab1319b ("x86/boot/sev: Support memory acceptance in the EFI stub under SVSM")

That's a fix for the above fix d54d610243a4 which relates to the multiple VMPL
thing which we don't do (yet) in Linux.

> Ie. bugfix latencies here were 10+ months.

While doing your git search, did you check my reaction time when fixes are
sent too?

Or you decided to find some random patches with Fixes: tags pointing to SEV
code?

Or are you saying our crystal ball of what's broken is not working fast
enough?

Lemme see:

https://lore.kernel.org/r/c0af2efa-aea4-43aa-b1da-46ac4c50314b@amd.com

This is only the latest test report I requested.

So no, we test the hell of it and as much as possible. What you claim here is
dumbfounded and completely false.

> Note that two of those fixes were from Ard who is working on further 
> robustifying the startup code - a much needed change.

Really? Much needed huh?

Please do explain why is it much needed?

Because the reason Ard is doing it is a different one but maybe
I misunderstood him...

> Ie. when Ard is asking for SEV-SNP testing for WIP series, which he did 
> 10+ days ago, you should not ignore it

More unfounded claims. Here's Tom and me ignoring it:

https://lore.kernel.org/r/836eb6be-926b-dfb4-2c67-f55cba4a072b@amd.com
https://lore.kernel.org/r/20250507095801.GNaBsuqd7m15z0kHji@fat_crate.local
https://lore.kernel.org/r/20250508110800.GBaByQkJwmZlihk6Xp@fat_crate.local
https://lore.kernel.org/r/f4750413-a2e6-15c4-7fa5-2595b509500b@amd.com
https://lore.kernel.org/r/20250505160346.GJaBjhYp09sLZ5AyyJ@fat_crate.local
https://lore.kernel.org/r/20250505164759.GKaBjrv5SI4MX_NiX-@fat_crate.local

Nah, this is not ignoring - this is Tom and me rushing to see whether
something broke because *you* applied stuff on the same day without waiting
for any review!

This is basically you doing whatever the hell you like and not even asking
people working on that code.

And you completely ignored my requests on IRC to wait with that code a bit so
that we can take a look.

> ... or if you do ignore his request for testing, you should not complain
> about the changes being merged eventually, once they pass review & testing
> on non-SEV platforms.

What review?

Show me.

Commit-ID:     bd4a58beaaf1f4aff025282c6e8b130bdb4a29e4
Gitweb:        https://git.kernel.org/tip/bd4a58beaaf1f4aff025282c6e8b130bdb4a29e4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:27:23 +02:00

What review do you expect to see in 3 hours on a Sunday?!?!

> If you didn't have time to personally test Ard's -v2 series since May 
> 2, that's OK

It was May 4th, it was a Sunday. And you can see my replies on the next
days.

> I can merge these proposed changes in an RFT branch so that it gets tested

How about you wait first for those patches to be reviewed like every other
patchset on lkml and then take them?

I mean, normal review process. Remember?

The thing we all are supposed to do...

> In other words: please no "gatekeeping".

Sorry, zero gatekeeping here.

> Please don't force Ard into a catch-22 situation where he cannot test the
> patches on SEV-SNP, but you are blocking these x86 startup code changes on
> the grounds that they weren't tested on SEV-SNP ...

I'm helping Ard to get and setup a SEV machine. And I'm testing too.

If you had asked, you would've learned all that but you haven't.

> This request for testing was ignored AFAICS.

Review, then test. As always. You know that.

I keep telling you that but I don't think you're hearing me - you just do
whatever the hell you like.

> Sure: -v2 was sent more than 10 days ago, and the testing request was 
> ignored AFAICS. Do 10 days count as 'ample time'?

I am reviewing. I can't just drop everything and concentrate only on this.

Hell, that set is not even ready yet:

https://lore.kernel.org/r/CAMj1kXH5C6FzMyrki_23TTk_Yma5NJdHTo-nv4DmZoz_qaGbVQ@mail.gmail.com

Now you tell me: why are *YOU* in such a hurry with that set?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

