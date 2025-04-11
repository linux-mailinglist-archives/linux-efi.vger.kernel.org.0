Return-Path: <linux-efi+bounces-3294-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA8A8659D
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 20:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC821B82A57
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E02690F8;
	Fri, 11 Apr 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YYDbvHMo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95992268FFF;
	Fri, 11 Apr 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396841; cv=none; b=mSW0aa58EYXeqYn8PjPyhCI+5cZMhW3MmJmydEPFmwfNHqKpK7cc7MI53U4/e13u2xlRN0eipcD6pay9S654eKFSzj3OO+jPD+Wt9UTyCV8SXE6zYSvojR5ViYB9b2sKgUIcO0hsautOmxFA7wuxyJZZnpf3/ybBBtZ9sehA8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396841; c=relaxed/simple;
	bh=uCi7Cw6cRuwL+GUDfSFnc1QgujAPnWif8DZgZjFPiLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+z5617VisLSAGNdYwmzeOTg8NTG7eBeQuiEsDodzbvgKevOchCLng3eHdC5KsOenrwfikKbOzbeAC3PYE9A+Tv9h82YL5xvG11ssBHt4Y8gWKYJ+ElSsp0aK7SUq2f8ZCEyCJ/G9Ujqxiil45FBlYhBUx68LT/uujL/ZAyXnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YYDbvHMo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE38740E0243;
	Fri, 11 Apr 2025 18:40:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xif3J5nx-pxD; Fri, 11 Apr 2025 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744396830; bh=Ndru/ORccWVfIDs1icfmIjMSWYUzaPV8OT7QLbHEP5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYDbvHMox+3r0plBCyYS90UCyvp7JakFYPWFCrOe+q8d4UHz8zHYeYDv9pZFkmYgr
	 i5Or68spDP64AGJI6Ie128bhCToVQG28Z9MzTxx89vECNhTjoowWquS3D/uBj17Bad
	 XS2Hk6wob7HghP14Wxl7l92y76q1fdsXqRbYk8SVe1zKEf2ms+70s0L/zYhNKZh7vM
	 VHgpfNYYU9Sz0dknpShxSiHD7tibWGeGY3SUXyPA9y3pbWo0qaLCe60IHXSLNHAJko
	 mW6RbOVvFMsJT3WQXyNDEptvDg1l0FUmFl1d8V68wCF0ULVBZcQmGqYAeZJ56fAmiE
	 nL2UveMz3ipSpTmViv32c2YMJEVeE7dqEdqSPxcnM/B0xQaYWMB4UDptFQfBOXMeCQ
	 y1/j8TQ8u7otLYw5ehGxMC2SXMs8a3gpUPBCs7uPrZSjk0B8AVFsbQ2+EAFZ9ekbZ4
	 M1n2mztudR6siFm2sOu3AS+++SH7SVVmCcsjCjDYZKr6f7MxshffYvU8/BNJT1JRny
	 8M9G9t/9X4vR7y6w3RVaIrBSLFypTPUUj5Mc0n56MmFsAUZ38EL87wrygfAj4UoPVS
	 xDRcpmxUKsMexvu1G7cZsgAlzsNDk7/P9AVJVZ4Iv2+1BNFXKut42V95uqosu8A0gf
	 LN1mtZu8i36LCBgxurOcP43M=
Received: from rn.tnic (ip-185-104-138-50.ptr.icomera.net [185.104.138.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A22540E01FF;
	Fri, 11 Apr 2025 18:40:19 +0000 (UTC)
Date: Fri, 11 Apr 2025 20:41:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
Message-ID: <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
References: <20250410132850.3708703-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410132850.3708703-2-ardb+git@google.com>

On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Communicating with the hypervisor using the shared GHCB page requires
> clearing the C bit in the mapping of that page. When executing in the
> context of the EFI boot services, the page tables are owned by the
> firmware, and this manipulation is not possible.
> 
> So switch to a different API for accepting memory in SEV-SNP guests, one

That being the GHCB MSR protocol, it seems.

And since Tom co-developed, I guess we wanna do that.

But then how much slower do we become?

And nothing in here talks about why that GHCB method worked or didn't
work before and that it is ok or not ok why we're axing that off.

I'm somehow missing that aspect of why that change is warranted...

Thx.

