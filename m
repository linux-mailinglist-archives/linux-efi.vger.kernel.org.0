Return-Path: <linux-efi+bounces-3576-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779CAA869F
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A623B95D5
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA419992D;
	Sun,  4 May 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL24r3MB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE475165F16;
	Sun,  4 May 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746367489; cv=none; b=cxCROKL7eDdKZXyhjHEc2EcwEg9SAUdQtW53YPrCtm1YLZnk9aYnABOuiAtU0YQKrUsbDZ9QbLt4G8hLh/tRjs8OJYxvKwLKgUAuf+EMw59FhLHBzRoEtUqARI2kkcK7iI1HNEMR/ZAf0IeFYPNSUpKBH5RZzCvpimCCCuiyV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746367489; c=relaxed/simple;
	bh=U7HkALJVFd5qrJotArGztzaJIf1V/yKVdcADU6klXv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuLtzQ6isfAeMffFsYbfUPe5NybI2gnjWOA9VUVTs2D9Yx+MsKw/SgxexzGVsadpGP/NRC9ucz1rGxvRKpMnZYqx1t9h5kHkAZfnhVxiAefdm4ba/TbdaIYNCf0Iwl6OMjwUiMbgyQHRgzT4JRu0CwGsXmWNcOke4QB3SVSeo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL24r3MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA118C4CEE7;
	Sun,  4 May 2025 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746367488;
	bh=U7HkALJVFd5qrJotArGztzaJIf1V/yKVdcADU6klXv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OL24r3MBtK1NbR7wdjvXgBJn8ihtQEnrPZqPN6PREX/rDSwF99mbd5qTFgm3wt58V
	 j4lin6ZYoeBkwHLfwalssM6/MViSPpclPpU4rvTYmXJiWY04xMe9qyqQowAIC9Z95r
	 uBTRSip+j0DgZfCBhiZN9fOJN4uDB2VgJp4k2V4kAlIzjpZ7M8hoQr+jribDtlYq67
	 y+NZftCGoqSqzsqRw39XvROUmxT3CR/NWvZna12AKoNbCdLL2RlUZC1rLk9iy5mHDb
	 PpmAQo6Ag/I8Rwu/ARhJxjEDLzjXGYDvm5KO5yutZzcMxT/uyQxMC1gdkkE7+Gwckc
	 qx4It9jtbgCTA==
Date: Sun, 4 May 2025 16:04:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 00/23] x86: strict separation of startup code
Message-ID: <aBdz-4hJu0zp40mC@gmail.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> Ard Biesheuvel (23):
>   x86/boot: Move early_setup_gdt() back into head64.c
>   x86/boot: Disregard __supported_pte_mask in __startup_64()
>   x86/boot: Drop global variables keeping track of LA57 state
>   x86/sev: Make sev_snp_enabled() a static function
>   x86/sev: Move instruction decoder into separate source file
>   x86/sev: Disentangle #VC handling code from startup code
>   x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback
>   x86/sev: Fall back to early page state change code only during boot
>   x86/sev: Move GHCB page based HV communication out of startup code
>   x86/sev: Use boot SVSM CA for all startup and init code
>   x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
>   x86/sev: Unify SEV-SNP hypervisor feature check
>   x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases
>   x86/boot: Add a bunch of PIC aliases
>   x86/boot: Provide __pti_set_user_pgtbl() to startup code
>   x86/sev: Provide PIC aliases for SEV related data objects
>   x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
>   x86/sev: Export startup routines for ordinary use
>   x86/boot: Created a confined code area for startup code
>   x86/boot: Move startup code out of __head section
>   x86/boot: Disallow absolute symbol references in startup code
>   x86/boot: Revert "Reject absolute references in .head.text"
>   x86/boot: Get rid of the .head.text section

>  42 files changed, 2367 insertions(+), 2325 deletions(-)

So to move this forward I applied the following 7 patches to 
tip:x86/boot:

	x86/boot: Move early_setup_gdt() back into head64.c
	x86/boot: Disregard __supported_pte_mask in __startup_64()
	x86/sev: Make sev_snp_enabled() a static function
	x86/sev: Move instruction decoder into separate source file
	x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases
	x86/boot: Add a bunch of PIC aliases
	x86/boot: Provide __pti_set_user_pgtbl() to startup code

Which are I believe independent of SEV testing.

I also merged in pending upstream fixes, including:

   8ed12ab1319b ("x86/boot/sev: Support memory acceptance in the EFI stub under SVSM")

Which should make tip:x86/boot a good base for your series going 
forward?

Thanks,

	Ingo

