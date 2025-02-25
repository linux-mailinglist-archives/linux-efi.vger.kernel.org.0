Return-Path: <linux-efi+bounces-2825-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24039A44E15
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2025 21:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8781778C0
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2025 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00020C46B;
	Tue, 25 Feb 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPmboZq5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3C20C488
	for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517016; cv=none; b=e/HERPb2xUweS8GJ7F2E7wEHSm65yyVOoJRJ3FjTVUbpHTGEbot6pPgPbYaHjEmcE5hHW6xLXETBdgfLQvEcwNj7GOI+OhyGZvyiJ6d2XiK/2TYDz0dWXC0/1FzIkezEsVN4jgHfdQNR8ylS3iCNu+q2yMtBWLIttxsG9XjAQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517016; c=relaxed/simple;
	bh=Hdow3MB1glcwk/0AsSrStIWbZ/5dx23HGmTCIBB9Y0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2IJ7aLOS10vg7wu0YgFWnu/d2r4p9pHqp8GhqxW12+JnLbivynrg934OYuzbT0USfZEdVgV2aGSFiJY70QVRies3hjaD7lQcNj503ORsyiuu4BxG8YiqNrAdFjnem5jV847IG8st8XAF5hAIITCXj9LzXuhWp8k20/P88H6nR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPmboZq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F44CC4CEE7;
	Tue, 25 Feb 2025 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740517015;
	bh=Hdow3MB1glcwk/0AsSrStIWbZ/5dx23HGmTCIBB9Y0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPmboZq54Bp+98L2YItFocmVYIxmwB3eErzeF3Yulwylf8sGznRq7k5D8bKTJGEZO
	 RLKhZjzovHRAQEH78m+z/3aXuxGUCqD+GCh2t6022d17WeBgcccT+yse4nJTC41LzB
	 dD/zJJzhpx3Y5i4ZYg5z4rrEqP38ER8XphnL9NqO26prwRnRM2+v423qfPoQ/7lTYE
	 QhcX0XAj8I4YkFXnB5JCingoj5/F55L82SWMDa7rutI4qjRyMuZEc2WpZjP34uWRzB
	 KT8ZuGBfdwcV+wD097J3ghDg9lKYYnmcM5o9KT5zmyDim/DprJX6j4k1xe9kW7kziF
	 vONqv7h4b4bEg==
Date: Tue, 25 Feb 2025 21:56:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, kees@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/6] x86/efi/mixed: Decouple from legacy decompressor
Message-ID: <Z74ujXM9sTQ9esDb@gmail.com>
References: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Since commit
> 
>   a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> 
> booting via the EFI stub no longer relies on the legacy decompressor,
> and instead, the kernel proper is decompressed by code executing in the
> context of the EFI boot services, and subsequently invoked directly.
> 
> The only remaining dependency is the EFI mixed mode startup code, which
> makes a detour via the legacy decompressor's 32-bit entrypoint, in order
> to obtain a 1:1 mapping of memory, which is a prerequisite for 64-bit
> execution on x86.
> 
> This detour requires some fiddly setup on the part of the mixed mode
> startup code, which has to stash the firmware stack pointer and boot
> arguments in memory, and create a fake struct boot_params to trick the
> code in startup_32 to behave as intended.
> 
> This dependency also impedes reuse of the EFI stub code in other
> contexts, such as generic EFI zboot, which will reuse the EFI stub but
> not the legacy decompressor.
> 
> So remove this dependency, by replacing this detour with a minimal
> reimplementation of the 1:1 mapping code. With some further cleanup
> applied on top, the line count barely changes, but the resulting code
> can operate independently from the legacy decompressor, and is therefore
> moved out of arch/x86/boot/compressed and into the EFI libstub/
> directory.
> 
> Ard Biesheuvel (6):
>   x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
>   x86/efi/mixed: Remove dependency on legacy startup_32 code
>   x86/efi/mixed: Don't bother preserving 64-bit mode segment selectors
>   x86/efi/mixed: Simplify and document thunking logic
>   x86/efi/mixed: Reduce padding by moving some code around
>   x86/efi/mixed: Move mixed mode startup code into libstub
> 
>  arch/x86/boot/compressed/Makefile                                                |   1 -
>  arch/x86/boot/compressed/head_64.S                                               |   7 -
>  drivers/firmware/efi/libstub/Makefile                                            |   3 +
>  arch/x86/boot/compressed/efi_mixed.S => drivers/firmware/efi/libstub/x86-mixed.S | 320 ++++++++++----------
>  4 files changed, 169 insertions(+), 162 deletions(-)
>  rename arch/x86/boot/compressed/efi_mixed.S => drivers/firmware/efi/libstub/x86-mixed.S (54%)

A belated:

    Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

