Return-Path: <linux-efi+bounces-4951-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25848BA7144
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA2517656F
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCFB1DF75D;
	Sun, 28 Sep 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXr9uKyZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F951D130E
	for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067536; cv=none; b=gGgpi0a8UabkmBj2NAZOO/WEJ67n6UhTz6ir++CJc5rN2pxOTjshx/zzsmwwIqq+RxfTirq2sLIXNOPyETDsXlGmaNBW3fXKN4mOVjR2ddmzXyvZoNFGyIrpBfvw/wbzcMu/onZhEAApeTg0VbxQfSN8Jl48fDYpPxmbCXbK0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067536; c=relaxed/simple;
	bh=vkQ3DR6shjQ3t6MMcpywS4EvZ4ogezUqQVNZ4GC2D04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A24aoJYA7Yf6pnPxVa25CglCjwHW4Y+Bv+NtcO0hQ6t0jZOWGnamqiGt+1eD9646SBkZD8/t8t90iKG8RCnN8SSzzDiPPT8C2fD8bE9irWrE5IxffZaSuz8DeNgSguo4cJ25MYptJGiaF/aHQfiaVEjslFP7cLia9NtgOpgpVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXr9uKyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD3C4CEF0
	for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759067536;
	bh=vkQ3DR6shjQ3t6MMcpywS4EvZ4ogezUqQVNZ4GC2D04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mXr9uKyZS9M924m9O+0vEaRbTM2YgbHW2pDpmKClyuyuTvz2w0c2FfrNBYUBT+buf
	 ey2p4zw9VOVyZcBzBvcflPm3ECJ+EbiqEzhwovyFNAm3PNtPPWHFoU4CXJe+R0lH8l
	 QhMSc2eLl1+kCE7hR9kFsyJ1Om8IA8NuBO4rTfp8e/CAqX6GDtJKPv4PV+h6xywZRP
	 Ajsm8R498idztEdGNHPO9MdnAS2ggrYjgTJRvXcUihFO6duNBkLy9BTLUyCmEbI3LP
	 NqlJxtYzNZFdubalK+6/XZdoFKUSBWLv+tBvWMopRw+6f7Fon8GwEGfEbe/a1afT4+
	 5hOz88vnF7CSQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3c2db014easo136077766b.0
        for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 06:52:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzuiJQ9EpfWzIomRejJyg4ONJh9O3ONCi5Yu0qZAVNxvxyVhZXidM26iM78AqkNnyoGz9AkwRcFwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywts06cbv25OiepnjTFvgBBLPBRRSPGqvyRanHF83MhA4SrokbL
	pgOQi6SvHD7TM/vCSkvIIdvRX3zEJME7g0Cyd1UmTSVqeOz92xOxxQWYvLzbCYoelJZM328UrvE
	Y4Av8IA1QonIsokongpqbexOYWv+gCT8=
X-Google-Smtp-Source: AGHT+IHZy8MJ+ejdxNUSrUhifjle4FzCaWD2U0zXbL3dW+OQL+t2D3+N0MZXhQRGFwgwVsrAa1mwtimPwbh8/cUxOJQ=
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b34b6449b22mr1296630666b.5.1759067534547; Sun, 28 Sep 2025
 06:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
In-Reply-To: <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 28 Sep 2025 21:52:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
X-Gm-Features: AS18NWAQgrho2v1WBMze1SiIfjphByvTZGCUNAA2HMWHlRk0-R7aennr1EqafME
Message-ID: <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ard,

On Sun, Sep 28, 2025 at 9:42=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> wrote=
:
> >
> > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > the following objtool warning on LoongArch:
> >
> >   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> >   falls through to next function __efistub_exit_boot_func()
> >
> > This is because efi_boot_kernel() doesn't end with a return instruction
> > or an unconditional jump, then objtool has determined that the function
> > can fall through into the next function.
> >
> > At the beginning, try to do something to make efi_boot_kernel() ends wi=
th
> > an unconditional jump instruction, but this modification seems not prop=
er.
> >
> > Since the efistub functions are useless for stack unwinder, they can be
> > ignored by objtool. After many discussions, no need to link libstub to
> > the vmlinux.o, only link libstub to the final vmlinux.
> >
>
> Please try keeping these changes confined to arch/loongarch. This
> problem does not exist on other architectures, and changing the way
> vmlinux is constructed might create other issues down the road.
ARM, RISC-V and LoongArch do things exactly in the same way. Now
LoongArch is the first of the three to enable objtool, so we meet the
problem first.

But yes, I also don't want to change the way of constructing vmlinux.
So I prefer the earliest way to fix this problem.
https://lore.kernel.org/loongarch/CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSuV0Em=
eeUb9d5FNw@mail.gmail.com/T/#meef7411abd14f4c28c85e686614aa9211fccdca0

Huacai

>
> > Do the similar things for arm64 and riscv, otherwise there may be objto=
ol
> > warnings when arm64 and riscv support objtool, this is to make consiste=
nt
> > with the archs that use libstub.
> >
> > Link: https://lore.kernel.org/lkml/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcu=
f5rcxzxxanzetd@6rrlpjnjsmuy/
> > Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  Makefile                | 1 +
> >  arch/arm64/Makefile     | 5 ++++-
> >  arch/loongarch/Makefile | 5 ++++-
> >  arch/riscv/Makefile     | 5 ++++-
>
> >  scripts/link-vmlinux.sh | 5 ++---
> >  5 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 10355ecf32cb..8ba2e28ef3d1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1201,6 +1201,7 @@ KBUILD_VMLINUX_OBJS :=3D built-in.a $(patsubst %/=
, %/lib.a, $(filter %/, $(libs-y)
> >  KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
> >
> >  export KBUILD_VMLINUX_LIBS
> > +export KBUILD_VMLINUX_LIBS_PRELINK
> >  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
> >
> >  ifdef CONFIG_TRIM_UNUSED_KSYMS
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 73a10f65ce8b..038f37ef2143 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -156,7 +156,10 @@ KBUILD_CPPFLAGS +=3D -DKASAN_SHADOW_SCALE_SHIFT=3D=
$(KASAN_SHADOW_SCALE_SHIFT)
> >  KBUILD_AFLAGS +=3D -DKASAN_SHADOW_SCALE_SHIFT=3D$(KASAN_SHADOW_SCALE_S=
HIFT)
> >
> >  libs-y         :=3D arch/arm64/lib/ $(libs-y)
> > -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/l=
ib.a
> > +
> > +ifdef CONFIG_EFI_STUB
> > +KBUILD_VMLINUX_LIBS_PRELINK +=3D $(objtree)/drivers/firmware/efi/libst=
ub/lib.a
> > +endif
> >
> >  # Default target when executing plain make
> >  boot           :=3D arch/arm64/boot
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index ae419e32f22e..4eb904c20718 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -169,7 +169,10 @@ CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $=
(KBUILD_CFLAGS) -dM -E -x c /dev
> >  endif
> >
> >  libs-y +=3D arch/loongarch/lib/
> > -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/l=
ib.a
> > +
> > +ifdef CONFIG_EFI_STUB
> > +KBUILD_VMLINUX_LIBS_PRELINK +=3D $(objtree)/drivers/firmware/efi/libst=
ub/lib.a
> > +endif
> >
> >  drivers-y              +=3D arch/loongarch/crypto/
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index df57654a615e..cfd82b2c1bbf 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -173,7 +173,10 @@ boot-image-$(CONFIG_XIP_KERNEL)            :=3D xi=
pImage
> >  KBUILD_IMAGE                           :=3D $(boot)/$(boot-image-y)
> >
> >  libs-y +=3D arch/riscv/lib/
> > -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/l=
ib.a
> > +
> > +ifdef CONFIG_EFI_STUB
> > +KBUILD_VMLINUX_LIBS_PRELINK +=3D $(objtree)/drivers/firmware/efi/libst=
ub/lib.a
> > +endif
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> >  ifeq ($(CONFIG_MMU),y)
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 51367c2bfc21..b3cbff31d8a9 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -61,12 +61,11 @@ vmlinux_link()
> >         shift
> >
> >         if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_=
IBT; then
> > -               # Use vmlinux.o instead of performing the slow LTO link=
 again.
> >                 objs=3Dvmlinux.o
> > -               libs=3D
> > +               libs=3D"${KBUILD_VMLINUX_LIBS_PRELINK}"
> >         else
> >                 objs=3Dvmlinux.a
> > -               libs=3D"${KBUILD_VMLINUX_LIBS}"
> > +               libs=3D"${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PR=
ELINK}"
> >         fi
> >
> >         if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
> > --
> > 2.42.0
> >

