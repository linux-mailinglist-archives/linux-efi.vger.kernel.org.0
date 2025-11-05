Return-Path: <linux-efi+bounces-5354-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE7C35B88
	for <lists+linux-efi@lfdr.de>; Wed, 05 Nov 2025 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5AA566BD7
	for <lists+linux-efi@lfdr.de>; Wed,  5 Nov 2025 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784093161B2;
	Wed,  5 Nov 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvflcplc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF2316187;
	Wed,  5 Nov 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347372; cv=none; b=ijN87GqA/SEDUWBt7AWfD4pjXuN+/2xL8R2bNJukGYkbXKv7nEsmUg6iwgET+muxqA566Wly+WlpEITKOqWO/LuVzit6ce0B/5S+Ft9K+fdtcuxvNTKvEMFP8FU0RqtatwQC2J9fYiCRJ9bLdbU0whaftZRxkaSwcWVw3fgs7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347372; c=relaxed/simple;
	bh=/8YIJ/IkaELHTBMMbQStDRua58EN3fZrFED65ddxxfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoX+L41R5LzvEIBXC1ONTNSw8AACq0nM/9aKFLwa1hYMiop5BGTJY334NCmQ+NoNi7+lMADoydao+9WY3FfLIBEOF28L0By9aeWV2HKNAuLHtRNzNwlHYxNpO4nXF+Z534y2ip6ZkXUKh1Uc4D2ebSnFgF4yRXOpchNfhUpbBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvflcplc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E408C4CEFB;
	Wed,  5 Nov 2025 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347371;
	bh=/8YIJ/IkaELHTBMMbQStDRua58EN3fZrFED65ddxxfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvflcplcUhWkJ2R5yUdEfOV14GOSJI1qYLRskRrXY6+YlGQtU6WAL9dBEJQSIOCgS
	 SBA0Geu4mEjZ3pzr3SUXhUWkAZkJqYZeEJunjGOel6gLcX1D93hLyZVB+oL/5Mpgg+
	 4StU+OVzJpR3qdc0Igqi0KZCrTOhcErDOPCdPO58yadioNazHWvPuR8oeDBMe2EwQi
	 cfdIuD4LR5NZ9Rj5U1BRa2r1H/CPvA3H5Y3JgiS8VXyzleSNHWS0An+h80XOTz9i0i
	 +yjVbmYtY9B8+ntPBhb6kdfqZ96VHiMDCh+1okcWT0YHUnoS5evcpNcpWG3oSbFKCs
	 rL6FTo2ATZ5LA==
Date: Wed, 5 Nov 2025 13:56:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: Add '-fms-extensions' to areas with dedicated
 CFLAGS
Message-ID: <20251105-amnesie-eisig-277559b69bae@brauner>
References: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>

On Sat, Nov 01, 2025 at 12:35:47PM -0400, Nathan Chancellor wrote:
> This is a follow up to commit c4781dc3d1cf ("Kbuild: enable
> -fms-extensions") but in a separate change due to being substantially
> different from the initial submission.
> 
> There are many places within the kernel that use their own CFLAGS
> instead of the main KBUILD_CFLAGS, meaning code written with the main
> kernel's use of '-fms-extensions' in mind that may be tangentially
> included in these areas will result in "error: declaration does not
> declare anything" messages from the compiler.
> 
> Add '-fms-extensions' to all these areas to ensure consistency, along
> with -Wno-microsoft-anon-tag to silence clang's warning about use of the
> extension that the kernel cares about using. parisc does not build with
> clang so it does not need this warning flag. LoongArch does not need it
> either because -W flags from KBUILD_FLAGS are pulled into cflags-vdso.
> 
> Reported-by: Christian Brauner <brauner@kernel.org>
> Closes: https://lore.kernel.org/20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I am taking the original '-fms-extensions' change [1] via a shared
> branch in kbuild [2] so I would appreciate acks. I plan to finalize that
> branch so that other maintainers can safely pull it on Thursday.
> 
> [1]: https://git.kernel.org/kbuild/c/c4781dc3d1cf0e017e1f290607ddc56cfe187afc
> [2]: https://git.kernel.org/kbuild/l/kbuild-ms-extensions
> ---

I'll give my ack:

Reviewed-by: Christian Brauner <brauner@kernel.org>

but don't invalidate the branch just to add my RvB if you've already had
it stable.

