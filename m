Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB320BFD2
	for <lists+linux-efi@lfdr.de>; Sat, 27 Jun 2020 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgF0HjQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Jun 2020 03:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgF0HjQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 27 Jun 2020 03:39:16 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C4520706;
        Sat, 27 Jun 2020 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593243555;
        bh=r4RD6Yj/wh2sz/DvMIH7PYJ2ZmuZh6S/3C/0plRZHQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WG3304fCrTrmJmQRNYNog6nBl+KU0DNsUIiKj8/w7U3rhj+ofgs7Y8SU9wSHpV8MO
         BzWjh8ivi3P/Jxq+voVMcawJPpk/m0JdlwbDwoxcyhMjG3Br8J+9ReZG+pYec2eTXu
         y+c0ZgpdA2pEvnfuoAThP5H5WqWcjENLfz9hX7ig=
Received: by mail-ot1-f49.google.com with SMTP id n6so10792474otl.0;
        Sat, 27 Jun 2020 00:39:15 -0700 (PDT)
X-Gm-Message-State: AOAM531zf0cL8luvRStNUyqDR0HTqKnaE0LATXeHJfX47T8MWk7Sv0iA
        wJa3qZl2wZWDd6MzD1V87eZjEph2if8RYgMdwpg=
X-Google-Smtp-Source: ABdhPJzeBH5EvyZjQDcTyVYTObiSzPCIBclsABXsIUoqdBDzUWJ3e34H/Xvj4eW1+AEASg5Hn1rBFpCLMASWNOqaXs8=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr5881966otf.77.1593243555117;
 Sat, 27 Jun 2020 00:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <20200626185913.92890-2-masahiroy@kernel.org>
In-Reply-To: <20200626185913.92890-2-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Jun 2020 09:39:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGsJsU-zbsuWi4O46XqE71DRdKOX1MeC5ndnE+j9Nw7Cw@mail.gmail.com>
Message-ID: <CAMj1kXGsJsU-zbsuWi4O46XqE71DRdKOX1MeC5ndnE+j9Nw7Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: remove cc-option test of -ffreestanding
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 26 Jun 2020 at 21:00, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Some Makefiles already pass -ffreestanding unconditionally.
> For example, arch/arm64/lib/Makefile, arch/x86/purgatory/Makefile.
> No problem report so far about hard-coding this option. So, we can
> assume all supported compilers know -ffreestanding.
>
> I confirmed GCC 4.8 and Clang manuals document this option.
>
> Get rid of cc-option from -ffreestanding.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/s390/Makefile                    | 2 +-
>  arch/x86/Makefile                     | 2 +-
>  arch/x86/boot/compressed/Makefile     | 2 +-
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 8dfa2cf1f05c..ba94b03c8b2f 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -27,7 +27,7 @@ KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
>  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
> -KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
> +KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
>  KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 89c3cdfba753..edc68538a04e 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -36,7 +36,7 @@ REALMODE_CFLAGS       := $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
>                    -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
>                    -mno-mmx -mno-sse
>
> -REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
> +REALMODE_CFLAGS += -ffreestanding
>  REALMODE_CFLAGS += -fno-stack-protector
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index c88a31569a5e..b7beabecef8a 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -35,7 +35,7 @@ cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small
>  KBUILD_CFLAGS += $(cflags-y)
>  KBUILD_CFLAGS += -mno-mmx -mno-sse
> -KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
> +KBUILD_CFLAGS += -ffreestanding
>  KBUILD_CFLAGS += -fno-stack-protector
>  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index f8418763cd79..296b18fbd7a2 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>  KBUILD_CFLAGS                  := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
>                                    -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
>                                    -D__NO_FORTIFY \
> -                                  $(call cc-option,-ffreestanding) \
> +                                  -ffreestanding \
>                                    -fno-stack-protector \
>                                    $(call cc-option,-fno-addrsig) \
>                                    -D__DISABLE_EXPORTS
> --
> 2.25.1
>
