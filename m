Return-Path: <linux-efi+bounces-4119-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3DAF92D3
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E823ADD76
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF038FA3;
	Fri,  4 Jul 2025 12:36:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35B246798;
	Fri,  4 Jul 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632606; cv=none; b=R+rAhN4Hn/WZYhnbXMvtPvIC6z+YxY58Lk8vCBmX00+UT2Dks5GAhr7Fo7HtyXMDtA3VyR0ch+ebJMG8kJbObdf/dwvKhUmqgot7dUTP5M8Awk8TW8Wnri34+riwV11IMmgZaRLYwWxABWTPf3PFo14Y3EembSIUqjgqwgmleCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632606; c=relaxed/simple;
	bh=KH3pnrVrQndUZYHEOWZYE12+XPrFlJ0oajDEPDLogkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJO717Zn2yvhkrX3yaGa+YtzXnOzDMinLaCcGQeAme/vceH/CpL0tkUv2sr8zjQO7OQXQSEJIg17sKzKMED4zzBBx+VZGx6T/3lkyP5589EXk15eyEgKUN+jmpZKU8tsTBX5q8MO1QB532BZUijaI/eWWwIaMg9A8aNPo5KmSzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so1489436a12.3;
        Fri, 04 Jul 2025 05:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632603; x=1752237403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW8Mdm8VBfi1qlOCL6Pf2QZ+6mI2RYO5Q+XtAXUgQJ4=;
        b=sZEAHW+8RtZBeg0iCOJzgr4XJuMx2EIUtKmeT3M/4N1zK0wMJUJIFNjttT39Me6LvG
         K87ELKKcAW6YDxnIB88VGuix8Y80nRL4pCrVbjXA9NeuY6z83wGjXOL6OjPWkvsv0F7A
         d6eJHMvzd0hmNrJQtFbawo/gLGx1//80zoWGI0f/GOH/3va20r58SlTjAv1x3jWFZaXN
         d7IUy996J1086eq3EdvIOMqvyF3Vprb3gf6JJkIJHqZyr7Aeod82laTDfTJmCLftK+YW
         rYBxo6UdK0kbPFTktfkevXal8q4tvuEdrid637SNR3584g185xOYj9hOCHM77/YQwYd/
         GNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3eihK7aGEtBfBnSEHmNEBSYoR5YfHE6cykTfMoOmaj30X32hSlE0jGGtOEF0fnMwQDsQ3vvd3CQ3AVBI@vger.kernel.org, AJvYcCXlit4kVcJEsG3OBMTKuyn7WnxG5rh/XVh/nZDVA31ddbYwpJpxwymyJZHmoCuMRA8gUX96M5Pj2AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzypqCwk6NFgVt9p88luDPF0tBfabfXAiRyEmnTCWtPZcNtx8ii
	0pX2aP230nxhh3iQk/uEs5jzHzbSW+W2BIevVNlOzc7OykahWOdfzf8C
X-Gm-Gg: ASbGncsGuZA6i4GNFAmXCmLgyboD/38S/GOjlSdcHYOy9inT04ussWcZNKwYykLF2I4
	+F5jDSqEUH4in1yjcLgRsqcZMXtf48RLdJqUYWmYQu4Qd9E0F4zet2xiLiK4zqnXW7OidbHW4sj
	wQYtl6RD6gG1JGuS64jpk1tPlFYCAYM481LFUgqAbZxU2XdWs3mEKB+RdXbUWd+x1Wo5eVFh+2p
	DsEZV4NC/Mt1El5U0WpHIUCTuj7qGyISLuoRLRFA4QS4P5XRe4bjY+qn/MbKgljNzihCp70GW7R
	HRY4mcdII8dbIVJQwhUluKoQza+Wm8mwPn66a/sxjqMevyo/AtHszrZNH30=
X-Google-Smtp-Source: AGHT+IHU3ATpNL/cr0I7xRhbdLV8cgkTlj0aQw3gWc/YSeGekUiyN9FhxtUD4X0JFLW+UcEhQI6LSA==
X-Received: by 2002:a05:6402:2103:b0:5ff:ef06:1c52 with SMTP id 4fb4d7f45d1cf-60fd2f84f16mr2179344a12.3.1751632602449;
        Fri, 04 Jul 2025 05:36:42 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:400::5:c915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fc81a70e4sm1285566a12.0.2025.07.04.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:36:42 -0700 (PDT)
Date: Fri, 4 Jul 2025 13:36:40 +0100
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, usamaarif642@gmail.com,
	rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Message-ID: <aGfK2N6po39zyVIp@gmail.com>
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
 <aGaxZHLnDQc_kSur@arm.com>
 <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>

Hello Ard,

On Fri, Jul 04, 2025 at 10:26:37AM +0200, Ard Biesheuvel wrote:
> On Thu, 3 Jul 2025 at 18:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Jun 24, 2025 at 05:55:53AM -0700, Breno Leitao wrote:
...
> > >  arch/arm64/kernel/efi.c | 9 ++++++---
...
> > >  static bool region_is_misaligned(const efi_memory_desc_t *md)
> > >  {
> > > @@ -214,9 +215,11 @@ static int __init arm64_efi_rt_init(void)
> > >       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> > >               return 0;
> > >
> > > -     p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
> > > -                        NUMA_NO_NODE, &&l);
> > > -l:   if (!p) {
> > > +     if (!IS_ENABLED(CONFIG_VMAP_STACK))
> > > +             return -ENOMEM;
> >
> > Mark Rutland pointed out in a private chat that this should probably
> > clear the EFI_RUNTIME_SERVICES flag as well.
> >
> 
> If VMAP_STACK is a hard requirement, should we make CONFIG_EFI depend
> on it for arm64?

What about if we make CONFIG_EFI select VMAP_STACK? I think it is more
straight forward from a configuration perspective.

I thought about the following. What do you think?

	arm64: EFI selects VMAP_STACK

	Modify the ARM64 Kconfig to make the CONFIG_EFI configuration option
	automatically select CONFIG_VMAP_STACK.

	The motivation is that arm64_efi_rt_init() will fail at runtime if
	CONFIG_VMAP_STACK is not set, so the patch ensures that enabling EFI
	will always enable VMAP_STACK as well, and avoid having EFI disabled in
	case the user didn't set VMAP_STACK.

	Suggested-by: Ard Biesheuvel <ardb@kernel.org>
	Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
	index 55fc331af3371..cc2585143f511 100644
	--- a/arch/arm64/Kconfig
	+++ b/arch/arm64/Kconfig
	@@ -2437,6 +2437,7 @@ config EFI
		select EFI_RUNTIME_WRAPPERS
		select EFI_STUB
		select EFI_GENERIC_STUB
	+	select VMAP_STACK
		imply IMA_SECURE_AND_OR_TRUSTED_BOOT
		default y
		help

> > (but let's see if Ard has a different opinion on the approach)

> I think this is fine - the stack just needs to be disjoint from the
> ordinary kernel mode task stack so that buggy firmware is less likely
> to corrupt it, and so that we can recover from an unexpected
> synchronous exception more reliably.
> 
> In that sense, the old and the new code are equivalent, so no
> objections from me.

Thanks. I will send an update with the update that Catalin and Mark
suggested.

Thanks!
--breno

