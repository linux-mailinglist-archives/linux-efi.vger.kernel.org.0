Return-Path: <linux-efi+bounces-4121-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F9AF9447
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956ED18849F9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC92FCE00;
	Fri,  4 Jul 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHxzUfPa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFC302CD3;
	Fri,  4 Jul 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636021; cv=none; b=OMUR0geVAQz7M1eBi+VpRX+WO5Pd7i33y/LFoB6rxIYg6NzXrm1/gv4dSKMefS0m81a/tKNIDzVT6mZ+MG1yzZdgoBKItxkWsOPg6qc4wifpPx6pD9baLzPN5FophB5SgD54jWKlT0e1hXFBUaebkrAVz97lHuy2x74jYkicOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636021; c=relaxed/simple;
	bh=EtiXfEKSjZZE/8/wPMmve0WLVrmAKdqLK+/3mXSBmUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUJ7xBO1sK1H9/ZF65UvkrGeQtayfQ3cLUYZ7axQhErT0dDE/B+pUKTUK/6DEoF5N92hMiTsvqsOxc8MsOn6wb2gkdKcr0/v4fpyzBaFK5PW1nAaEH+Adpo7ftp+fMJM9/ziuyVPWBoBVNLbj6TRLtIucTeKglt3XM2cERoQ+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHxzUfPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6DFC4CEEE;
	Fri,  4 Jul 2025 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751636020;
	bh=EtiXfEKSjZZE/8/wPMmve0WLVrmAKdqLK+/3mXSBmUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHxzUfPal/RIBhfUkLePrBxqx6oTeqJAlzbFVduGtQPwX0rR881ITBr83pybvvjnU
	 daKVy+8l94zMIxS/aqhtXwWsFdT9Lu1VTLuvj9OHv+1dQshXSMXoziwkMcS5NF3ON1
	 28LXVHfPjiHl/RBJ988hayW0rqn2m0qd3N76sDyKk8LU97y5HhfG5C/lyhM5Pzwpiq
	 oUHatjtdPk+iqIMs8kQ0uAJB16D1DIOUU9wZmLmnNHuNOZTEIeeuSlqR1rkbMSM6zI
	 pOhAHPE4xb4vpzXEmc3L1o4t6I8ZihShlcjHDY8s3fnBTewDkQ/XNREvk1XvVR1HE3
	 cJYhisXGPgDfQ==
Date: Fri, 4 Jul 2025 14:33:35 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, usamaarif642@gmail.com,
	rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Message-ID: <aGfYL8eXjTA9puQr@willie-the-truck>
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
 <aGaxZHLnDQc_kSur@arm.com>
 <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
 <aGfK2N6po39zyVIp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGfK2N6po39zyVIp@gmail.com>

On Fri, Jul 04, 2025 at 01:36:40PM +0100, Breno Leitao wrote:
> On Fri, Jul 04, 2025 at 10:26:37AM +0200, Ard Biesheuvel wrote:
> > On Thu, 3 Jul 2025 at 18:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Tue, Jun 24, 2025 at 05:55:53AM -0700, Breno Leitao wrote:
> ...
> > > >  arch/arm64/kernel/efi.c | 9 ++++++---
> ...
> > > >  static bool region_is_misaligned(const efi_memory_desc_t *md)
> > > >  {
> > > > @@ -214,9 +215,11 @@ static int __init arm64_efi_rt_init(void)
> > > >       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> > > >               return 0;
> > > >
> > > > -     p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
> > > > -                        NUMA_NO_NODE, &&l);
> > > > -l:   if (!p) {
> > > > +     if (!IS_ENABLED(CONFIG_VMAP_STACK))
> > > > +             return -ENOMEM;
> > >
> > > Mark Rutland pointed out in a private chat that this should probably
> > > clear the EFI_RUNTIME_SERVICES flag as well.
> > >
> > 
> > If VMAP_STACK is a hard requirement, should we make CONFIG_EFI depend
> > on it for arm64?
> 
> What about if we make CONFIG_EFI select VMAP_STACK? I think it is more
> straight forward from a configuration perspective.
> 
> I thought about the following. What do you think?
> 
> 	arm64: EFI selects VMAP_STACK
> 
> 	Modify the ARM64 Kconfig to make the CONFIG_EFI configuration option
> 	automatically select CONFIG_VMAP_STACK.
> 
> 	The motivation is that arm64_efi_rt_init() will fail at runtime if
> 	CONFIG_VMAP_STACK is not set, so the patch ensures that enabling EFI
> 	will always enable VMAP_STACK as well, and avoid having EFI disabled in
> 	case the user didn't set VMAP_STACK.
> 
> 	Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> 	Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> 	diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> 	index 55fc331af3371..cc2585143f511 100644
> 	--- a/arch/arm64/Kconfig
> 	+++ b/arch/arm64/Kconfig
> 	@@ -2437,6 +2437,7 @@ config EFI
> 		select EFI_RUNTIME_WRAPPERS
> 		select EFI_STUB
> 		select EFI_GENERIC_STUB
> 	+	select VMAP_STACK
> 		imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> 		default y
> 		help

I would actually like to select VMAP_STACK unconditionally for arm64.
Historically, we were held back waiting for all the various KASAN modes
to support vmalloc properly, but I _think_ that's fixed now...

The VMAP_STACK dependency is:

	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC

and in arm64 we have:

	select KASAN_VMALLOC if KASAN

so it should be fine to select it afaict.

Any reason not to do that?

Will

