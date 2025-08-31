Return-Path: <linux-efi+bounces-4660-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C5B3D272
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDB3179F09
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2A1E1A05;
	Sun, 31 Aug 2025 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZvefeHXr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373934C79;
	Sun, 31 Aug 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756638946; cv=none; b=S9zieGya28Lm39Ob9lJArvsZiQc4MF309diCGJw+Aq6ZfYsvLkfbjTvSaRK+R2UvwXl85QYXGVtZO8aNmwSTMJ0/HafBeEYFPrutxrXH6FOkaluWR7CKCcBzyZn/iA/Rtd71yhIm6h2NPbBKOCoMwksQmr5Yaq77uUDIswDii6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756638946; c=relaxed/simple;
	bh=5k7duF0ipNWH58QwXJqWAvQlF99m3HqZgPHkyGCxGAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0UwRReJO8lCOMJ6pQQqTCZ86GHnecCyj8fRDRWwc6z9PKL7dIUsFFcHEG2PTaTr+7lOTYxMhSLiMGeTlZBbGw+1eSm9BO5uOwW+ibDgShHUbJeeSxtwWTPqhH+/uWP18/DaNVmCZyhQBFq59/bdfNZ9k3ySI6nEoydhuJLAIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZvefeHXr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04A3340E0192;
	Sun, 31 Aug 2025 11:15:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5TZlxoM4-iDv; Sun, 31 Aug 2025 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756638938; bh=I3TfxcrABdz1PMPHtVDNi3kfyLlfci6abeAcftBPJ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvefeHXrMdSXG4VAl582u3/MiR7zm4zD+RgKkLRdx7jGRMV9+N2WFZu1BMHv3nO8f
	 JtfuXVhhvq8yk6opJgg/PhPCSd7Ww8UNPj8DO7hkXXmyyvLqpD5+iL1Iv78saLIFtN
	 LnEz4xsl1SPLonMMQ1u5vB0iO+9rvASrJLb5XIAC0hWG9Szveit1WCaRytdkbdgdfM
	 doYuoBihF/88scEpzSdR/fMMIQl618Ak1RECBj56BkvEcpIyjLp48qLslN73w3lyrw
	 9ccAr6Tlek+rvQe0EuWhj97Cih/BivQtYHOuiAGBYCsfHg2fje87BODavfTJ+JCtTe
	 KD4/nHsfnlK9HCjeRnCTfdQ2HESAAPNW2A8ix6C9aKOzVUSgplAwuyTGklIypAxfyK
	 k6Sx4kFCxWXkGf1YqwHpIeW6Muq8dHDrz/Czwj6YVN0sspWKzzCo76/wUbmmejAfti
	 vYlfTu9sX00oQVplrqlp5o4J/dzMXzmN+K1177IAatliuScocT/Ls4MA/dEQSxAuEy
	 dwP8nisKoLJylIBUkdI4DKvbBefK4+7rD2yShpAiiv4HpqFOSSs0rp7ZNjl6sLUmFq
	 hXPJbk6Re2Sg4a2GSlM5tCnoDqpBfmmTqE5KYbYhgJMjggr1+V5Afmloc7SBMa52tF
	 klVAw/jJ2skXa2k//iojo2LA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8574C40E0174;
	Sun, 31 Aug 2025 11:15:27 +0000 (UTC)
Date: Sun, 31 Aug 2025 13:15:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
Message-ID: <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com>
 <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
 <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>

On Sun, Aug 31, 2025 at 12:56:41PM +0200, Ard Biesheuvel wrote:
> OK it appears I've fixed it in the wrong place: the next patch adds
> back the definition of has_cpuflag() so I squashed that hunk into the
> wrong patch, it seems.

The real question is - and I'm sceptical - whether the startup code runs too
early for boot_cpu_has(). And how is the startup code going to call
boot_cpu_has().

/me builds .s

Aha, so it gets converted into a boot_cpu_data access:

# arch/x86/boot/startup/sev-shared.c:662:       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
        testb   %r13b, %r13b    # validate
        je      .L46    #,
# ./arch/x86/include/asm/bitops.h:206:          (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
        movq    80+boot_cpu_data(%rip), %rax    # MEM[(const volatile long unsigned int *)&boot_cpu_data + 80B], _15
# arch/x86/boot/startup/sev-shared.c:662:       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))

But former question remains: AFAIK, you want to run the startup code waaay
earlier, before we do identify_boot_cpu() which prepares boot_cpu_data, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

