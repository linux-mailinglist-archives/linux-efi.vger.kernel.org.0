Return-Path: <linux-efi+bounces-1350-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3591DFD1
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BE21C221FC
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32B15A4AE;
	Mon,  1 Jul 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fod4zyXD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D115A489;
	Mon,  1 Jul 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838070; cv=none; b=FW/8x8wJP3N+CZ9NVN26Dnf4z/a4NCEDm+NRngKEcaLRn2gLJsVGCqOdsr8N5fsXoveoXot2vF3L0l9Nv5V+0T/G3k6yCiwM+tbRU6f7+mfzqlqte468ie9YR8lFiKIuob4W5Bbh6nP0+It84PowjtKSuqXs0XvA7mDtDqKHC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838070; c=relaxed/simple;
	bh=VDrvM1mNNycSLr46cotV0IGqDY07uV4e6N5txQwbR+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCIU5dkscQAvJz81nnZ+uzS7WDWHjTbT5u3Sk7Ydb/F0y06v8GGS7tp3izTNUbIlpunrVPpLqZbyUNgoisugwHjupPmZeB2gJQ6xGoRpw2lzlVF4uSx5zECz6XOmlaKTyiHUn9n0lqnWz6oPz+Q9CAzA4/PU6+Oo9vQEg2Kvs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fod4zyXD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 35A6540E0192;
	Mon,  1 Jul 2024 12:47:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zPJQToXUX2ik; Mon,  1 Jul 2024 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719838062; bh=TbAxV9gGDbBoe763AZSPI527n1RmfQjcPq5QtNxDKQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fod4zyXDDkA3k3eJcc7YbeYoEa+OUrZxXZgqVIOuXY5ehzu4Yg4oeJK4cuhodo3p5
	 FChPndcRTW7QJDHU8mzQVHzGBOTaHnbk1Tq/jlFQyubqtielfyf7VUpyc0k/QdLUeC
	 SaPh+disv2PTLh1D3YK/nETRoNPi+4y5j3It8jSfq0Xvm8R+YLbHiDZO5XzkVPt5/6
	 B7u6HskvIYIoG06/Wt64buvSp1SqkNedOfektMnwYsBzfiYWvwCqf4fsVy8yTR8puD
	 p8Ms3OQcMey0ORinGnYP3wyFYgtokFFt0lXgDfwWt6TL3R+eBE313KkEWRj/hH99RI
	 NWdM/qlQu5U7LMGnkiN3tNV+Pc7EiS2OpZziWQQ0mwtQD2tH3MFcyebHqYctWsushB
	 8H+7h+CUt7EzwPmOPSMmv4+63HfGAGrlE+PYJFESh1x1J3zD0AuCoKRJ7xDtJ/dy8h
	 gINPgeO7pIGpEjimtnpv6gZDvinJiiYDsJ3Bt5foqeWoCfrN0d+0m/RuzZvE2h9rT5
	 pgEihNlEUs2/Yck6w5GKb/05H1sdHk0Mce436JcgBwMMxex0biYg3fQSsy83wwahFR
	 jkaUCFizHPgq/UduvaIJ7ogJnmzNjbrqGseIzX5OtZq0cqm/i9rxZ5tc1uK6oL1Fxd
	 9AXal1l43mtmGkworNZrc4Ls=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFEF240E019D;
	Mon,  1 Jul 2024 12:47:34 +0000 (UTC)
Date: Mon, 1 Jul 2024 14:47:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
Message-ID: <20240701124734.GFZoKlZhqnWJlz7LKb@fat_crate.local>
References: <20240620073205.1543145-1-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620073205.1543145-1-ardb+git@google.com>

On Thu, Jun 20, 2024 at 09:32:05AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Between kexec and confidential VM support, handling the EFI memory maps
> correctly on x86 is already proving to be rather difficult (as opposed
> to other EFI architectures which manage to never modify the EFI memory
> map to begin with)
> 
> EFI fake memory map support is essentially a development hack (for
> testing new support for the 'special purpose' and 'more reliable' EFI
> memory attributes) that leaked into production code. The regions marked
> in this manner are not actually recognized as such by the firmware
> itself or the EFI stub (and never have), and marking memory as 'more
> reliable' seems rather futile if the underlying memory is just ordinary
> RAM.
> 
> Marking memory as 'special purpose' in this way is also dubious, but may
> be in use in production code nonetheless. However, the same should be
> achievable by using the memmap= command line option with the ! operator.
> 
> EFI fake memmap support is not enabled by any of the major distros
> (Debian, Fedora, SUSE, Ubuntu) and does not exist on other
> architectures, so let's drop support for it.
> 
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  21 ---
>  arch/x86/Kconfig                                |  20 --
>  arch/x86/boot/compressed/kaslr.c                |  43 +----
>  arch/x86/include/asm/efi.h                      |  15 --
>  arch/x86/kernel/setup.c                         |   1 -
>  arch/x86/platform/efi/efi.c                     |   2 -
>  arch/x86/platform/efi/fake_mem.c                | 197 --------------------
>  arch/x86/platform/efi/memmap.c                  |   1 +
>  drivers/firmware/efi/libstub/x86-stub.c         |   2 +-
>  9 files changed, 11 insertions(+), 291 deletions(-)

I obviously like this:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

I don't see the author or anyone else objecting, I guess queue it?

Or if you feel like you wanna give folks a full cycle, you could queue it for
the next MW...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

