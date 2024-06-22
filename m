Return-Path: <linux-efi+bounces-1278-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7D913137
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2024 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A158B282C9E
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2024 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFB15CB;
	Sat, 22 Jun 2024 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6p6yNc+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABEEA5F;
	Sat, 22 Jun 2024 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719017957; cv=none; b=Q/HTJaJ5AmNp3AMNc03BhS4ahc0XBCnha7BPtBCkVzMT/lCY6t4Gu22Vch9Ze/IGdYhrto44h6fbspMIBMTui58HltXQLZ0oqwXhf/CsaAHt8MsxPTGyFlNyK7s1ethbgxCjVkFuR+wW51E0nOKKcHsTKvtbF3b88tsJDplLEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719017957; c=relaxed/simple;
	bh=FQ1S0HDz0vGglXBuV05rXrXWvmAMYzorAlIge6VS7nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enx6BJjFAUqP+EyfpmwpGkR925YuibQ5EwvmsJpJ06jSrwEPmPSFkZqUofdhZ0rVOnUXLfx7HwwVOOqMa7Jx2ls/gL8Xf5po7xSlYMff4FyD2raJndJ5/I5seb9UvrmlYyBwgLAmCKT/Eoj3jzJqnFyQIgyCiW2/Dt3auBAh4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6p6yNc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7ECC2BBFC;
	Sat, 22 Jun 2024 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719017956;
	bh=FQ1S0HDz0vGglXBuV05rXrXWvmAMYzorAlIge6VS7nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6p6yNc+6wYkOLheeXy5wx7XnlxNGY6XrTs3XFzZ11RSX/pOWaja5pXoi0pwvnqjl
	 UBZ8Mti2dRn44UvUN6IbKwjKVl1EcdcrZRIuJDmF2uNbEIuJDCX7F8fKxqlFULHNuZ
	 /VjBZb/gaKMZ2mANPL8NOLQXVIJ8Pxdz4s7jIez7FPVEvWfwUhpEFmkOQLqIYjRr0H
	 UnFYkPw7qd8nh52b6hpwuBKAK2yEfdipX9QQowu0nn7sdgcXaGiAY2NUF5POlnpZtA
	 aurDTD+pwSv7PEszXP8OVMbz+B7nPd1ZzGOCn62M4/B18FeivW2GqgNCg6l22lRy+i
	 xn0moK+0q3hmw==
Date: Sat, 22 Jun 2024 08:45:16 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <ZnYenFigMU4Lxa0K@xhacker>
References: <20240617123029.723-1-jszhang@kernel.org>
 <ZnX6YtFGfXd0ixwR@ghost>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnX6YtFGfXd0ixwR@ghost>

On Fri, Jun 21, 2024 at 03:10:42PM -0700, Charlie Jenkins wrote:
> On Mon, Jun 17, 2024 at 08:30:29PM +0800, Jisheng Zhang wrote:
> > Add support for the stackleak feature. Whenever the kernel returns to user
> > space the kernel stack is filled with a poison value.
> > 
> > At the same time, disables the plugin in EFI stub code because EFI stub
> > is out of scope for the protection.
> > 
> > Tested on qemu and milkv duo:
> > / # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> > [   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
> > [   38.678448] lkdtm: stackleak stack usage:
> > [   38.678448]   high offset: 288 bytes
> > [   38.678448]   current:     496 bytes
> > [   38.678448]   lowest:      1328 bytes
> > [   38.678448]   tracked:     1328 bytes
> > [   38.678448]   untracked:   448 bytes
> > [   38.678448]   poisoned:    14312 bytes
> > [   38.678448]   low offset:  8 bytes
> > [   38.689887] lkdtm: OK: the rest of the thread stack is properly erased
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/Kconfig                    | 1 +
> >  arch/riscv/kernel/entry.S             | 4 ++++
> >  drivers/firmware/efi/libstub/Makefile | 3 ++-
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0525ee2d63c7..9cbfdffec96c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -118,6 +118,7 @@ config RISCV
> >  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> >  	select HAVE_ARCH_SECCOMP_FILTER
> > +	select HAVE_ARCH_STACKLEAK
> 
> When this is selected, stackleak.h include
> arch/riscv/include/asm/thread_info.h without sizes.h and I hit:
> 
> ./arch/riscv/include/asm/thread_info.h:30:33: error: ‘SZ_4K’ undeclared here (not in a function)
>    30 | #define OVERFLOW_STACK_SIZE     SZ_4K
>       |                                 ^~~~~
> 
> Adding "#include <linux/sizes.h>" to thread_info.h resolves the issue.
> I am testing this based on 6.10-rc4. Did you encounter this?

I didn't meet this kind of compiler error when testing. Mind
to share your .config file? It looks strange.

> 
> - Charlie
> 
> >  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >  	select HAVE_ARCH_TRACEHOOK
> >  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 68a24cf9481a..80ff55a26d13 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -130,6 +130,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
> >  #endif
> >  	bnez s0, 1f
> >  
> > +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> > +	call	stackleak_erase_on_task_stack
> > +#endif
> > +
> >  	/* Save unwound kernel stack pointer in thread_info */
> >  	addi s0, sp, PT_SIZE_ON_STACK
> >  	REG_S s0, TASK_TI_KERNEL_SP(tp)
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 06f0428a723c..3a9521c57641 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -28,7 +28,8 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
> >  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
> >  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
> >  				   $(call cc-option,-mno-single-pic-base)
> > -cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
> > +cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
> > +				   $(DISABLE_STACKLEAK_PLUGIN)
> >  cflags-$(CONFIG_LOONGARCH)	+= -fpie
> >  
> >  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

