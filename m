Return-Path: <linux-efi+bounces-3690-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A7AB5A78
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BE918826BE
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595622BE7D6;
	Tue, 13 May 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lopay3iE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4E1C9B9B;
	Tue, 13 May 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154698; cv=none; b=IEF8iMRcOCVHojuCmsB1SWyBbIKS7YnszUFNVm5kT3es/haVebHOGAeZ8HNi88yRSxt03kjdnzUQTte2ZW2lS1990/XsjLsP3FdZ1M3ER105MuM+HaPhcatPkaXdaRKLY+TLb/aP58VfciRPhl6U9fOpOIGSPeljQ63sxJUSt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154698; c=relaxed/simple;
	bh=CmIVMloMg9DUwpv1XOOVsZ3AdiRucnxQ2mSeHeosuto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUZ3S/dzGxV8WWdw6frOzuY/K1F480lrefxB7bezh589F/c7C/Cnd1y+CyqmxNLSh3ehRwivjbglIx8hS+awjYY7wCdVIOHXJPKoWTlMlnGhkOsM/4jnc9UCuvTCbml6U1qMjeqU38qOGvD02Cmh+FTBaPP1u2iNHfFB6g5JGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lopay3iE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1634440E01ED;
	Tue, 13 May 2025 16:44:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xey5_3d-TR9M; Tue, 13 May 2025 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747154687; bh=JdKUnHBlBuayFtE2nrH1tA+TT74nZGhvt6agRbLgIrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lopay3iEnUjTDRV4fdLKEmsyaI69B7UuSzxZvcTFHteDM8HkOvpH22CKENeCcmHuA
	 c/pBAfn+nXdEF7FCEmVSAiwCgt3YfhbVuv+6PGR8Vn5Uf6O3FCljdid3HPknG1U/Wo
	 R4r8MAUQ5GjB8huPUWdw8AFac/mcs3/i3693J6lMMKU11HtvNf9LTbUsRe0NS6uLxO
	 ZyK2m4deTek6QhLkk9o8/Re53HgfFlgBLIh7kVW71fRLLQtNp7wnXA0dUCamBUbWXN
	 AAomtN+fiX34n6g157BdZXMRBG2iG/Rq5FP3hYBQOIAV2BURn0clTjr9UVKhShMbTG
	 MMaBrWQHSOdjLiOhN11yN8hFhshtpoiBZsFZaXXevjIa121KtwCBWBpsWLj3vuyLvM
	 6NO6kWP3psLXvhUF8cF444t7tYbum6Fwpck7J5CJ/qQJp8sjghKHtCBUtBsSK6EVwa
	 5ur9r3hEW3gcYEFjQwsgpFn7IFS6/HGYA/Z8AZPos56L3z6nY45mezrv//3Se1KlOO
	 FlSuBniUiWpVB6QHNoVjG10MLqok4iOtlphwoo0EasC32qFRNYxKZz9ikvFCAkPHxX
	 h2h306G75CTxccYkhgYcoDj5Mh+QJMKKoovF7ZREowlERcQeeAndkPjhgS3bPGvaVe
	 8u+AqdS+WzSabUzTHee7WbDM=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8821440E0264;
	Tue, 13 May 2025 16:44:37 +0000 (UTC)
Date: Tue, 13 May 2025 18:44:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	x86@kernel.org, Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250513164432.GFaCN28I_GmSvzXeRJ@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
 <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>

On Tue, May 13, 2025 at 04:01:08PM +0100, Ard Biesheuvel wrote:
> I will refrain from inserting myself into the intra-tip review and
> testing policy debate, but let me at least provide a quick recap of
> what I am doing here and why.

Thanks for taking the time - much appreciated!

> Since commit
> 
>    c88d71508e36 x86/boot/64: Rewrite startup_64() in C
> 
> dated Jun 6 2017, we have been using C code on the boot path in a way
> that is not supported by the toolchain, i.e., to execute non-PIC C
> code from a mapping of memory that is different from the one provided
> to the linker. It should have been obvious at the time that this was a
> bad idea, given the need to sprinkle fixup_pointer() calls left and
> right to manipulate global variables (including non-pointer variables)
> without crashing.
> 
> This C startup code has been expanding, and in particular, the SEV-SNP
> startup code has been expanding over the past couple of years, and
> grown many of these warts, where the C code needs to use special
> annotations or helpers to access global objects.
> 
> Google uses Clang internally, and as expected, it does not behave
> quite like GCC in this regard either. The result is that the SEV-SNP
> boot tended to break in cryptic ways with Clang built kernels, due to
> absolute references in the startup code that runs before those
> absolute references are mapped.

Oh look, Google is using SEV-SNP too. Non! Si! Oh!

https://www.youtube.com/watch?v=pFjSDM6D500

> I've done a preliminary pass upstream with RIP_REL_REF() and
> rip_rel_ptr() and the use of the .head.text section for startup code
> to ensure that we detect such issues at build time, and it has already
> resulted in a number of true positives where the code in question
> would have failed at boot time. At this point, I'm not aware of any
> issues caused by absolute references going undetected.
> 
> However, Linus kindly indicated that the resulting diagnostics
> produced by the relocs tool do not meet his high standards, and so I
> proposed another approach, which I am implementing now (see cover
> letter for details). Note that this approach is also much more robust,
> as annotating things as __head by hand to get it emitted into the
> section to which the diagnostics are applied is obviously not
> foolproof.

AFAIR, this is what you've done for arm64 too, right?

> Fixing the existing 5-level paging and kernel mapping code was rather
> straight-forward. However, splitting up the SEV-SNP code has been
> rather challenging due to the way it was put together, i.e., as a
> single source file used everywhere, and to which additional
> functionality has been added piecemeal (i.e., the SVSM support).
> 
> It is obvious that these changes should be tested before being merged,

Preach!

> hence the RFT in the subject. And I have been struggling a bit to get
> access to usable hardware. (I do have access to internal development
> systems, but those do not fit the 'usable' description by any measure,
> given that I have to go through the cloud VM orchestration APIs to
> test boot a simple kernel image).
> 
> What Boris might allude to is the fact that some of these changes also
> form a prerequisite for being able to construct a generic EFI zboot
> image for x86, which is a long-term objective that I am working on in
> the background. But this is not the main reason.
> 
> In any case, there is no urgency wrt these changes as far as I am

THANK YOU!

So basically we can all slow down and do normal review and testing. Without
any of that hurried patching back'n'forth. And we didn't need any of that
grief!

Basically something which I've been trying to say from the very beginning but
no one listens to me!

Geez.

> concerned, and given that I already found an issue myself with v3,
> perhaps it is better if we disregard it for the time being, and we can
> come back to it for the next cycle. In the mean time, I can compare
> notes with Boris and Tom directly to ensure that this is in the right
> shape, and perhaps we could at least fix the pgtable_l5_enabled() mess
> as well (for which I sent out a RFC/v3 today).

Thanks man, let's also sync on IRC.

We have enough time to run the set through all our testing pile and shake out
any outstanding issues.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

