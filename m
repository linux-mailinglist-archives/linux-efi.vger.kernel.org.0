Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB637C14E
	for <lists+linux-efi@lfdr.de>; Wed, 12 May 2021 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhELO6e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 10:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232400AbhELO46 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 10:56:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB0B461462;
        Wed, 12 May 2021 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831330;
        bh=DvKCo+D/uNmFT6p2+ZAdmHSuFl+XPHUCcdtAgp8SinQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s5UJXp5A1ehWLquNUtUygQzPoAeGL5vtitKRKqK7MMfGQM/4qJn2NWXsr8zyxrZ/f
         HVOO6bUKiOk+O0GZJb/rcyUJjbSOy1I8xiww4X3IxU1yGTogCaAilw0MakKjs1PRcH
         frdF8sGqgOtHULizm4fHwXMlYKr5RomnwES0YNA163ZT3kWYtzIK0Pch44oBAiyN4W
         SAf4wOMGM42IYPgwOPYpC3CH+FQehusJtnW72j8gB6j7jjFTgkK74L6VQdmFjbTaj0
         CBwWNOzBK1NzWOzItpfXq91+yiTuujcXFW4lojWbqTqx3KlX2F4pKS5OPUzK6XPSif
         Yzjrm2O71TopA==
Received: by mail-ot1-f52.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso20019145ots.10;
        Wed, 12 May 2021 07:55:30 -0700 (PDT)
X-Gm-Message-State: AOAM532/qr4HFQUQb4Fzkox8mMJ0HYtGWjH9aDehaCVmkMzjg9zydB+1
        WMGsoyACcQn+DU/Y7jDM7AD9nUOuu7xiGt2wxZw=
X-Google-Smtp-Source: ABdhPJzYb9Oaloykf1CG+pTRbJVzjiXnCPWHMEzD/y4/q2A9ig0gIcqKYlTWZovopNvMJ5IO7bPdtjymQwkgeuAUOVI=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr30866699otd.77.1620831329825;
 Wed, 12 May 2021 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210511185057.3815777-1-jim.cromie@gmail.com> <20210511185057.3815777-18-jim.cromie@gmail.com>
In-Reply-To: <20210511185057.3815777-18-jim.cromie@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 May 2021 16:55:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLKJ19oThbXPhboHzCHfX_oZscxRHn6M7s4jt9Gk8SEA@mail.gmail.com>
Message-ID: <CAMj1kXGLKJ19oThbXPhboHzCHfX_oZscxRHn6M7s4jt9Gk8SEA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 17/28] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>, Nick Terrell <terrelln@fb.com>,
        Dave Young <dyoung@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 11 May 2021 at 20:51, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> The next patch adds DEFINE_DYNAMIC_DEBUG_TABLE(), which broke several
> subtrees, including efi, vdso, and some of arch/*/boot/compressed,
> with various relocation errors, iirc.
>
> Avoid those problems by adding a define to suppress the "transparent"
> DEFINE_DYNAMIC_DEBUG_TABLE() invocation.  I found the x86 problems
> myself, lkp@intel.com found arm & sparc problems, and may yet find
> others.
>

Given that I was only cc'ed on this patch in isolation, would you mind
adding more clarification here? What is DEFINE_DYNAMIC_DEBUG_TABLE()
supposed to do, and why is it breaking standalone binaries?


> Reported-by: <lkp@intel.com> # on [jimc:lkp-test/dyndbg-diet] recently
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  arch/arm/boot/compressed/Makefile     | 2 ++
>  arch/sparc/vdso/Makefile              | 2 ++
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/entry/vdso/Makefile          | 3 +++
>  arch/x86/purgatory/Makefile           | 1 +
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  6 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index fd94e27ba4fa..72f056a00ad4 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -82,6 +82,8 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
>  compress-$(CONFIG_KERNEL_XZ)   = xzkern
>  compress-$(CONFIG_KERNEL_LZ4)  = lz4
>
> +KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
> +
>  libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
>
>  ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index c5e1545bc5cf..960ed0fb6804 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -30,6 +30,8 @@ obj-y += $(vdso_img_objs)
>  targets += $(vdso_img_cfiles)
>  targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
>
> +KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
> +
>  CPPFLAGS_vdso.lds += -P -C
>
>  VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index e0bc3988c3fa..ada4eb960d95 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -31,6 +31,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  KBUILD_CFLAGS := -m$(BITS) -O2
>  KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> +KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
>  KBUILD_CFLAGS += $(cflags-y)
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 05c4abc2fdfd..619878f2c427 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -29,6 +29,9 @@ vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
>  vobjs32-y += vdso32/vclock_gettime.o
>  vobjs-$(CONFIG_X86_SGX)        += vsgx.o
>
> +# avoid a x86_64_RELATIVE error
> +KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
> +
>  # files to link into kernel
>  obj-y                          += vma.o extable.o
>  KASAN_SANITIZE_vma.o           := y
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..95ba7b18410f 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -35,6 +35,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
>  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += -fno-stack-protector
> +PURGATORY_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
>
>  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
>  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index c23466e05e60..def8febefbd3 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ \
>                                    -Wno-pointer-sign \
>                                    $(call cc-disable-warning, address-of-packed-member) \
>                                    $(call cc-disable-warning, gnu) \
> -                                  -fno-asynchronous-unwind-tables
> +                                  -fno-asynchronous-unwind-tables \
> +                                  -DNO_DYNAMIC_DEBUG_TABLE
>
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> --
> 2.31.1
>
