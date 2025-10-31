Return-Path: <linux-efi+bounces-5300-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AEC25A2B
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD0334F4ED5
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719734C9BA;
	Fri, 31 Oct 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GGATE9wn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476534C982;
	Fri, 31 Oct 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921629; cv=none; b=gORyOwwLJMg4xuR7WHSArXojXsprJEGUYLVfFJK0Yixi9cEcLqhsjKohncz2nLJ3i7syKSs03jcaJguPKKKZuIryw3muqrT57BAndPw1gP2jujVL7yfgQcwBRyTC+npKUNhH0bY+9FFdVArjyJh+oBhYB2B2HppVK241/Op9Ko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921629; c=relaxed/simple;
	bh=0M96qmmyGoLwHojt9tChAbAU0XSTBukdyVXTQb6itBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1vBwJp4HqGROjJRnVuyQvKnt4Rw9VPJC/ypFsr7hDABA7uaNcqjYLwyfZLQ/lcoVs8duO5vdvWjjY/dPKKX7xnJi3DisVC+zSS8QvpdS4q0F2Ai6+wDAoYUQ3YrEI4yC1ukfUPsoDAcvdhDRztGL3ZccYCt4IMxarO18+2lgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GGATE9wn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACFCE40E016D;
	Fri, 31 Oct 2025 14:40:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BldU0NcZGFY6; Fri, 31 Oct 2025 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761921620; bh=v3FbwAmSMB2xLLwV/I0FdO1ylxms2ed5Ozm9s2g0aUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGATE9wnbBsMZRTA1AIch6lK8ly65+M6A5Q90F8kGJ3xI77jAJZ/MdRz3vYOFuQyB
	 gIVpCydEu3iXZyi5ZobhN58lQHqb+r5tyjjCUZwv/YHmeA0T/pbmFF8wJFel4Ivg+s
	 3EzUSLsfKb0sY/2TIAFPOhgW7MjIABR2OAUj+TnUvG7T4dM8ZQrRZxc3YLlD7ktypS
	 AiCW9Z//9qIbXkcVeEQ5EwnbxfTuQ7+uiIPbpW+3yQKQgi2GleOGDYGVLrhfJu1xJt
	 xm7aYbqY/dQGVWwa7AlBMfkRxi2sUWPVG2dkYPOYbZQLwZICAYEQCQGnHVvEsoyJmK
	 2oRdZi3Qqz2cfbtTZ6aYzMWFQiPjunlSu2CNXXLDyBTe3sIuGY5cRyKmhv7rq2XMgc
	 DP757akIIukfDLKqDveSzUt4hdNquj/RnvHzs2kaGbfLSk5B+dA6/bccGE+eXkY9tS
	 xotAiwmqgTovFwKi2KWTXY+xIItHlnKrKBLChNyDsOMJg4y5wIGzyZi+sodljRGl3Z
	 uwx8wC0ht3VTGsoID3DsnBxlMzU6+3PH+ENr7q9QU5EkDTKFhpL8YqoEYkXhEqlzEq
	 Fip6Qx4wk84pi9Nh1mE6H9yF2OI6KD8BTriikUYEl9It+2V+hbhcbiojMqOodTX1XX
	 DDN/hSvibRydnah43QcminOU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2875B40E0225;
	Fri, 31 Oct 2025 14:40:03 +0000 (UTC)
Date: Fri, 31 Oct 2025 15:40:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Usama Arif <usamaarif642@gmail.com>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com,
	x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
	nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, kernel-team@meta.com,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Fix page table access in 5-level to
 4-level paging transition
Message-ID: <20251031144002.GMaQTKQnpp2u493ZZS@fat_crate.local>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
 <20251028105637.769470-3-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028105637.769470-3-usamaarif642@gmail.com>

On Tue, Oct 28, 2025 at 10:55:57AM +0000, Usama Arif wrote:
> When transitioning from 5-level to 4-level paging, the existing code
> incorrectly accesses page table entries by directly dereferencing CR3
> and applying PAGE_MASK. This approach has several issues:
> 
> - __native_read_cr3() returns the raw CR3 register value, which on
>   x86_64 includes not just the physical address but also flags Bits
>   above the physical address width of the system (i.e. above
>   __PHYSICAL_MASK_SHIFT) are also not masked.
> - The pgd value is masked by PAGE_SIZE which doesn't take into account
>   the higher bits such as _PAGE_BIT_NOPTISHADOW.
> 
> Replace this with proper accessor functions:
> - native_read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption
>   bit and extracting only the physical address portion.
> - mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
>   flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).
> 
> Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reported-by: Michael van der Westhuizen <rmikey@meta.com>
> Reported-by: Tobias Fleig <tfleig@meta.com>
> ---
>  drivers/firmware/efi/libstub/x86-5lvl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

allmodconfig build:

ld: error: unplaced orphan section `__bug_table' from `drivers/firmware/efi/libstub/x86-5lvl.stub.o'
ld: error: unplaced orphan section `.altinstructions' from `drivers/firmware/efi/libstub/x86-5lvl.stub.o'
ld: error: unplaced orphan section `.altinstr_replacement' from `drivers/firmware/efi/libstub/x86-5lvl.stub.o'
ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!
ld: Unexpected run-time relocations (.rela) detected!
ld: drivers/firmware/efi/libstub/x86-5lvl.stub.o: in function `efi_5level_switch':
x86-5lvl.c:(.text+0x13e): undefined reference to `pv_ops'
ld: x86-5lvl.c:(.text+0x14d): undefined reference to `pv_ops'
ld: drivers/firmware/efi/libstub/x86-5lvl.stub.o:(.altinstr_replacement+0x1): undefined reference to `BUG_func'
ld: arch/x86/boot/compressed/vmlinux: hidden symbol `pv_ops' isn't defined
ld: final link failed: bad value
make[3]: *** [arch/x86/boot/compressed/Makefile:116: arch/x86/boot/compressed/vmlinux] Error 1
make[2]: *** [arch/x86/boot/Makefile:96: arch/x86/boot/compressed/vmlinux] Error 2
make[1]: *** [arch/x86/Makefile:308: bzImage] Error 2
make: *** [Makefile:248: __sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

