Return-Path: <linux-efi+bounces-4299-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2434BB02B95
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3713B9B29
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6981A255C;
	Sat, 12 Jul 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cN7mhTqz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD318CC13;
	Sat, 12 Jul 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332557; cv=none; b=mveinSvn4Sp0vv98w6xpDAd097ATyEGcggB6WHkrZxf9eV/f1qeNg14/IwK6ppl/hOVnW1gOA6nYepkRVYEI7AWs3A1XVP4UuP1DAoUp0mWS6EAl/bFqKCAmKJ0lrtLZJSn4ynKTeXgZeR60+4zwlxGxSPhe+5Q+NeeR9Eqi1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332557; c=relaxed/simple;
	bh=hJxUkDVC3k88IajIfF4c7vSE+VfStv0TTHK0mW5HdRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaXr5/QLfnDLc2IeJ0Y7laXkxcu1HJasBbkjMU/Q66tDcloqd81Gaq2RreyrEWFVEsugND/BaY/lM1ZlJyohv4MbTYZfI8nqOBga0J02UbgtvZfZKmlVCudmXOTa4A7wMwJiuHoQTEyAKuzXE8nXlOLGRd2C6BmAJ5MGeiQzfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cN7mhTqz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EED4740E0198;
	Sat, 12 Jul 2025 15:02:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m7sErQ6a9Xkj; Sat, 12 Jul 2025 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752332542; bh=eXZgR6oq0CZUE0IdlkJLvc6QMllzwYa3r2I3r45x8iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cN7mhTqzRHbTpvur/pbMlyNlEY6hiKVobKErHYown33xmVvIb9oq+t4kLUxPUb5kN
	 LIu+xjic8H9zCnucQSdPj7Nf1BADvHrADwnDvMBxohRyqGlfkdw2Hj9govXnLrAWtE
	 MAnBBwuNjXZwvX77TPIWZMZAYGGf/1VSoADsgxuPbTWa3KwPtyHu3bqRXCObGpiA26
	 EhB4WbVPw+k14hJ3FTsS2w1O7Z8Vt2MKlokkUFZH/rTQIW+e4Vb9LEZX9JQXgC3sD+
	 n1C1nfBIuPSZ4x6rcDHbHq2sDiY9mmp/HCFPQeLk1bSPU8oCx8N/lOX1DlhH7M7qk2
	 FPSdxPjHlQwIZhScgXXo4T2K5svp6j98yAZvgyB1maQmpZuWSDYJjCksFmrSQGH/rk
	 Vfk0uJZVMhrjQMZDN+SDm40jgzmu8bVGQKMQF3GBAyg6Z3gWZ1sGWqS7vZuXumGUYU
	 QRxd6wWIgUNMDRJRiNZ1nfvOlA8LYenLIjVO+eNUybeKDDgXzPgfeiFatYYQA7fOje
	 Dt1KLL7AILbNu53Z7UFhz07bpXZLWHeZBLbJy7j9ama8oRFEZ2P5aBLoiSrABpOI+F
	 37pWAMr/8CpxrNEJTVGxVQMsCTGulbpcCMGBPsLuxnrKx5OWpvzFfa5oB0KZMcjyCU
	 XPs48oHYySUfFUmh3l37V6lE=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91CFC40E00DC;
	Sat, 12 Jul 2025 15:02:11 +0000 (UTC)
Date: Sat, 12 Jul 2025 17:02:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 01/24] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <20250712150210.GDaHJ48gY0eqzT_zTI@fat_crate.local>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-27-ardb+git@google.com>
 <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>
 <20250711205944.GDaHF7QAvRhPZOWMX_@fat_crate.local>
 <88cb44b0-62bd-e753-9aba-82502d162749@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88cb44b0-62bd-e753-9aba-82502d162749@amd.com>

On Sat, Jul 12, 2025 at 09:54:20AM -0500, Tom Lendacky wrote:
> > So it really comes natural to split them into a msr_prot and a ghcb_prot
> > variant. If we added a separate patch ontop that does only the renaming, then
> > that would probably be more churn than necessary.
> 
> Right, they already are though:
> 
>   __sev_cpuid_hv_msr() and __sev_cpuid_hv_ghcb()
> 
> the first one meaning that the hypervisor is being called using the msr
> protocol and the second one meaning that the hypervisor is being called
> using the ghcb protocol.
> 
> That's why I made the comment. Just changing
> 
>   __sev_cpuid_hv_msr() to __sev_cpuid_msr_prot()
> 
> isn't saying anything more in my opinion.

Ok, then let's keep 'em that way. I was reacting to snp_cpuid_hv_no_ghcb()
which is snp_cpuid_hv_msr I guess.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

