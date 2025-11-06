Return-Path: <linux-efi+bounces-5370-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333FC3CF5A
	for <lists+linux-efi@lfdr.de>; Thu, 06 Nov 2025 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB144244EE
	for <lists+linux-efi@lfdr.de>; Thu,  6 Nov 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE65302CB9;
	Thu,  6 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9FnDBrL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187E2BDC00;
	Thu,  6 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451281; cv=none; b=cIuYrpJ6V7DF4klTPvS6nNtXPg37ClSoqLRyEosaKOtvImkmaRq8pFPF3XhcV9k1rBEF7dnfTeHo+M+3UpL3m7qIblQGE2sL7gQzTjKK62paL5XFvpu44XXI94+h4HyN4M5RLa32weK0baR/+LVOQq2mH1dQ3nwKzr/+CYCJ1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451281; c=relaxed/simple;
	bh=13WsgUGoeK4bC41loapHpdur+Ccm2Mdg30VVAbVHLjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHFUOeI6jbaFkxwF2R+T5pOHUnQ2VfIyqK3KVXXE0dS+fpFCIWgGxnKirXPoDWQlSQhGFHbt6B8J4zvCGLNeD8ppRdTuk+p5qfuVPpuf4IluDYgFsfNi7gevcsHVzUACEBYcN+a0J+HHChB/USHqhnZOrSgRNU5Al+RTbWPRRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9FnDBrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD86C116C6;
	Thu,  6 Nov 2025 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451281;
	bh=13WsgUGoeK4bC41loapHpdur+Ccm2Mdg30VVAbVHLjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9FnDBrLQxnVZ8j0S6dXWmgDdhzRapTlDLeZphuGquMG48Y0ehHhp+zTZ1t5KXHbE
	 txcGrmgh0jjFrb2R7Z4I4+T/u5lzxWz5dX1+SmKtEgYTcAlIG9Z7mJs448ffRsunb/
	 NKjfdgOv8bmEebgrBMp3h9vh4pR0Pq8RkV/w1GvjFyMBhyadJ/0oXUr1y1nJ50U0ub
	 aJnzIoOLRuwk0h/lQKZix1kH9a4jtd/PFlGQeCzBFejhXmzM34PXGVkA6w+0UTpxmg
	 kZW7+JyfWA+DtE0VoLbWXC2bDxthopkWbymWnjEda4G9uauXq3ZbYJQm9H/atPuoWh
	 K90fOO5tmdSWQ==
Date: Thu, 6 Nov 2025 10:47:52 -0700
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
Message-ID: <20251106174752.GA2440428@ax162>
References: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
 <20251105-amnesie-eisig-277559b69bae@brauner>
 <20251105193931.GA2480016@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105193931.GA2480016@ax162>

On Wed, Nov 05, 2025 at 12:39:31PM -0700, Nathan Chancellor wrote:
> I was planning to make it stable tomorrow to give folks time to chime in
> at the beginning of the week. I have your tag and Ard's to add. After
> that, we will just have to rely on the link to this submission for
> follow ups.

Alright, this should be the final result. If there are any other Acks
that come in later, they will just have to be recorded here. If there
are any follow up fixes needed, I will apply them on top and update the
tag but the branch will not be rebased.

Cheers,
Nathan

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-ms-extensions-6.19

for you to fetch changes up to 5ff8ad3909524ad55297a434f87c238224825bf4:

  kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS (2025-10-30 21:26:28 -0400)

----------------------------------------------------------------
Shared branch between Kbuild and other trees for enabling '-fms-extensions' for 6.19

Signed-off-by: Nathan Chancellor <nathan@kernel.org>

----------------------------------------------------------------
Nathan Chancellor (2):
      jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'
      kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS

Rasmus Villemoes (1):
      Kbuild: enable -fms-extensions

 Makefile                              | 3 +++
 arch/arm64/kernel/vdso32/Makefile     | 3 ++-
 arch/loongarch/vdso/Makefile          | 2 +-
 arch/parisc/boot/compressed/Makefile  | 2 +-
 arch/powerpc/boot/Makefile            | 3 ++-
 arch/s390/Makefile                    | 3 ++-
 arch/s390/purgatory/Makefile          | 3 ++-
 arch/x86/Makefile                     | 4 +++-
 arch/x86/boot/compressed/Makefile     | 7 +++++--
 drivers/firmware/efi/libstub/Makefile | 4 ++--
 fs/jfs/jfs_incore.h                   | 6 +++---
 scripts/Makefile.extrawarn            | 4 +++-
 12 files changed, 29 insertions(+), 15 deletions(-)

