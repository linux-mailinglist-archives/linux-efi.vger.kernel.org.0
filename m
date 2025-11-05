Return-Path: <linux-efi+bounces-5364-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15C5C37849
	for <lists+linux-efi@lfdr.de>; Wed, 05 Nov 2025 20:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E13B3B9BDA
	for <lists+linux-efi@lfdr.de>; Wed,  5 Nov 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1A334C0C;
	Wed,  5 Nov 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCo8aa7t"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6230F81F;
	Wed,  5 Nov 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371580; cv=none; b=f9kY/wG4g7dFUnunIP/tWtSM/qk+JooLmKubyXVzJv22ENSHY4sRSSxpXbQPgyvQfTrq6H3RB048lRP7Aq+oZoEqmZ5JfWEhVBXGwhW2QE4Yu8WSH2riH14KBgm+nr7hUGY6t+inZrh/jsO4n5DDcSwi/qPDlkLa45N152avtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371580; c=relaxed/simple;
	bh=msHJOFVV1OB3Fpzsq8IVbuj9UIdZOpLQ1nNFvVBvM9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aebIiUNqRPOy5gO5W6oS2XNf8X3Ef65H+jYBFnbFWgcIFJZZSYlCl9c35y/ar9n/wPcfwsBqE5DY1STTE4iPpM95A+Prx1YooQJKhT6NYcagBVM/UzRya6B7ziD/TEJ7Fcz/Q/XpTcTnZmJXb7/hP9gsRwZJEkkTnlOUUNiTnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCo8aa7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F408C4CEF5;
	Wed,  5 Nov 2025 19:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762371580;
	bh=msHJOFVV1OB3Fpzsq8IVbuj9UIdZOpLQ1nNFvVBvM9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCo8aa7tr6qCXCAwbmbfBQHe6+J1XQ92v/dEdS0D1RmsTXvTBe2y4QWq3i4ntmkp4
	 hCwptFye8pcPGdiXeKcVMxkeZBrhHluCYl/vU6sn2vu9+WiYI0AQa71hlYpPJp+uwk
	 nLmGphbfV4NSrG1Ku28gkrTDNfaJG1ZzoKebd314vXufpylTRn3P6E0nSQVUMFx+/G
	 nEygicNERiduVcddaetu2bZdLTIFFi4RDC/xSKeOjPk8imNyFUelcn9MA6scQFhpbq
	 naUiHjcZXZDebrmf1ZMmCKbSsI1gDu42pHY/3/s/yeqOxXjPKqA78jz/c32pbgcTEw
	 rVKRvBK26YgJQ==
Date: Wed, 5 Nov 2025 12:39:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: Add '-fms-extensions' to areas with dedicated
 CFLAGS
Message-ID: <20251105193931.GA2480016@ax162>
References: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
 <20251105-amnesie-eisig-277559b69bae@brauner>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-amnesie-eisig-277559b69bae@brauner>

On Wed, Nov 05, 2025 at 01:56:02PM +0100, Christian Brauner wrote:
> On Sat, Nov 01, 2025 at 12:35:47PM -0400, Nathan Chancellor wrote:
> > This is a follow up to commit c4781dc3d1cf ("Kbuild: enable
> > -fms-extensions") but in a separate change due to being substantially
> > different from the initial submission.
> > 
> > There are many places within the kernel that use their own CFLAGS
> > instead of the main KBUILD_CFLAGS, meaning code written with the main
> > kernel's use of '-fms-extensions' in mind that may be tangentially
> > included in these areas will result in "error: declaration does not
> > declare anything" messages from the compiler.
> > 
> > Add '-fms-extensions' to all these areas to ensure consistency, along
> > with -Wno-microsoft-anon-tag to silence clang's warning about use of the
> > extension that the kernel cares about using. parisc does not build with
> > clang so it does not need this warning flag. LoongArch does not need it
> > either because -W flags from KBUILD_FLAGS are pulled into cflags-vdso.
> > 
> > Reported-by: Christian Brauner <brauner@kernel.org>
> > Closes: https://lore.kernel.org/20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > I am taking the original '-fms-extensions' change [1] via a shared
> > branch in kbuild [2] so I would appreciate acks. I plan to finalize that
> > branch so that other maintainers can safely pull it on Thursday.
> > 
> > [1]: https://git.kernel.org/kbuild/c/c4781dc3d1cf0e017e1f290607ddc56cfe187afc
> > [2]: https://git.kernel.org/kbuild/l/kbuild-ms-extensions
> > ---
> 
> I'll give my ack:
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> but don't invalidate the branch just to add my RvB if you've already had
> it stable.

I was planning to make it stable tomorrow to give folks time to chime in
at the beginning of the week. I have your tag and Ard's to add. After
that, we will just have to rely on the link to this submission for
follow ups.

Cheers,
Nathan

