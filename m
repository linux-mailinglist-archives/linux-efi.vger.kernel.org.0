Return-Path: <linux-efi+bounces-2813-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3AA40873
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2025 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8165B17F020
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FF20767E;
	Sat, 22 Feb 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob2mvSpE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BE20766E;
	Sat, 22 Feb 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228730; cv=none; b=iwQPtNgrTJXkhAhd3vVO/8iIUDhdFWn8UNnU7LP6Nd3hfEcxCEB46aWJa5TJ6HOpXDYKjMvt2VSWQXoo3Q+R9IkON4Eqig05ZjWAgiejfmg4CDYWuqIYKy1U0s3mzIMtHpOSUjrtejpFszMYJ+fBjp/8GzNAvXWStmWK/PgruqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228730; c=relaxed/simple;
	bh=AcH7rRnJqyV3m9vAmkcNvvMPMLHZWqAuVkoH6/mGW/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbGs/EKgTaQlG+g7UmnmGKd7+dI1wPTSi7vH7jBIb55lM9DJ8jiAJttQ3aTOHDr51WjFZLdcP+ZN//1PQIB4KdWdpfiib551fX89+QRzKEaTD93Vg0KdDVSyCZ0TjkdhURQwJf7IzdCvj98ZOM0N8wb6SpduDMUUVgbQ5tpHHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob2mvSpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7B2C4CED1;
	Sat, 22 Feb 2025 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740228730;
	bh=AcH7rRnJqyV3m9vAmkcNvvMPMLHZWqAuVkoH6/mGW/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ob2mvSpEi/X14XT1aFy64FEAHY4VipFwPx+gcrqac5d9vM33oc1zLSwHmT4ADivFv
	 A9V64jG2iBeNQd4rbjBspihwfs+U0Y3mV7BZItUl+ym5Gh4KXZADv22ShWj2LND/ZD
	 KH7LHISbB4wEAp1r9aj7hYxqouc4kxjeOGjcCMDXzqogAHTq4fxOKHWD3VYxjEOJ+L
	 VRFqh255zSyUjNxqG/YPE/QNJPzBiLURGaex5qSoCQWoB2Jt/sFWl31t8VRA/pkz/c
	 WDb0Gorm67qbertOet6F1RXxLUgY3c6+WsBXo0T9DBvtm8Yhd/M/EZq+H8UytAaBQu
	 GbDO1TbhC5xnw==
Date: Sat, 22 Feb 2025 13:51:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Sam James <sam@gentoo.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, stable@vger.kernel.org,
	Kostadin Shishmanov <kostadinshishmanov@protonmail.com>,
	Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 0/2] A couple of build fixes for x86 when using GCC 15
Message-ID: <Z7nIbng2JHSg9in_@gmail.com>
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
 <202501300804.20D8CC2@keescook>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501300804.20D8CC2@keescook>


* Kees Cook <kees@kernel.org> wrote:

> On Tue, Jan 21, 2025 at 06:11:32PM -0700, Nathan Chancellor wrote:
> > GCC 15 changed the default C standard version from gnu17 to gnu23, which
> > reveals a few places in the kernel where a C standard version was not
> > set, resulting in build failures because bool, true, and false are
> > reserved keywords in C23 [1][2]. Update these places to use the same C
> > standard version as the rest of the kernel, gnu11.
> 
> Hello x86 maintainers!
> 
> I think this would be valuable to get into -rc1 since we're getting very
> close to a GCC 15 release. Can someone get this into -tip urgent,
> please? If everyone is busy I can take it via the hardening tree, as we
> appear to be the ones tripping over it the most currently. :)

Just an update, the x86 fix is now upstream via:

  ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")

Thanks,

	Ingo


