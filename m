Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A723E2FE5F2
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 10:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhAUJKL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 04:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbhAUJEL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Jan 2021 04:04:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 626D12399A;
        Thu, 21 Jan 2021 09:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611219810;
        bh=Pdy06Z2hpT1dyEefsbhGANfwRczevC7+iQDG8URp9Kc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ca/KzHqPx0KckJ6PbtAz2eWzLbSZ+8xK8Z1dIwywO0LlMoOxAeh1sA+NVqwGHu9qR
         d8puTXtw8dACydL09oBZ9agWoCatXfcndvH28E7o0fA7UlP1YclMd6ar7I8PB5C9d0
         avw2VEaY9QB+VIL8fF7wde9iv1jy8ieN/VbrFaM6EKFxAZhx3WTmr96E718iLj+/ff
         uYpKYnojvKxB8ri/LFlvWoXUXgtqmh15pcvZdmndVM8uaDCZPp/Uu5rKR6HxH4xME5
         3XJt5AmbF800u3LSLS4M3308vu2K9EJI6mH/v9rBx8kJ9aRnkU1/92R7j8j9nUodNl
         rFJ3VvdXjyZ6Q==
Received: by mail-lf1-f50.google.com with SMTP id q8so1461709lfm.10;
        Thu, 21 Jan 2021 01:03:30 -0800 (PST)
X-Gm-Message-State: AOAM532SQHbID/dUbyBEigtkf64tfv1iQ9sRx/K6X6T0dHQsMQ7zhqz0
        olCZAgG0aGg1Aw0NLx6Toabx9aIfxUmka3Fe3rE=
X-Google-Smtp-Source: ABdhPJwdIEGu5iLdeIQ5VfteHyMYS8cEVq2IKcUypjswZuxN0cC+hohJd2R9apD3ach//tT5RjRtTctDXgbiGX00N1Y=
X-Received: by 2002:ac2:4a71:: with SMTP id q17mr5727887lfp.11.1611219808541;
 Thu, 21 Jan 2021 01:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-1-jthierry@redhat.com>
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Jan 2021 10:03:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
Message-ID: <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Julien,

On Wed, 20 Jan 2021 at 18:38, Julien Thierry <jthierry@redhat.com> wrote:
>
> Hi,
>
> This series enables objtool to start doing stack validation on arm64
> kernel builds.

Could we elaborate on this point, please? 'Stack validation' means
getting an accurate picture of all kernel code that will be executed
at some point in the future, due to the fact that there are stack
frames pointing to them. And this ability is essential in order to do
live patching safely?

If this is the goal, I wonder whether this is the right approach for
arm64 (or for any other architecture, for that matter)

Parsing/decoding the object code and even worse, relying on GCC
plugins to annotate some of the idioms as they are being generated, in
order to infer intent on the part of the compiler goes *way* beyond
what we should be comfortable with. The whole point of this exercise
is to guarantee that there are no false positives when it comes to
deciding whether the kernel is in a live patchable state, and I don't
see how we can ever provide such a guarantee when it is built on such
a fragile foundation.

If we want to ensure that the stack contents are always an accurate
reflection of the real call stack, we should work with the toolchain
folks to identify issues that may interfere with this, and implement
controls over these behaviors that we can decide to use in the build.
In the past, I have already proposed adding a 'kernel' code model to
the AArch64 compiler that guarantees certain things, such as adrp/add
for symbol references, and no GOT indirections for position
independent code. Inhibiting optimizations that may impact our ability
to infer the real call stack from the stack contents is something we
might add here as well.

Another thing that occurred to me is that inferring which kernel code
is actually live in terms of pending function returns could be
inferred much more easily from a shadow call stack, which is a thing
we already implement for Clang builds.

In summary, I would not be in favor of enabling objtool on arm64 at
all until we have exhausted other options for providing the
functionality that we need it for (given that objtool provides many
other things that only x86 cares about, IIUC)

-- 
Ard.



> It relies on the previous series I sent, refactoring
> the arm64 decoder [1].
>
> First, the aarch64 instruction decoder needed to be made available
> to code under tools/. This is done in a similar manner to x86
> instruction decoded. One limitation I encountered there is that most
> of aarch64 instruction decoder is __kprobe annotated. To bypass that
> it remove the kprobe include and had to add an empty __kprobe
> definition, but I'd welcome a proper solution to that.
>
> Then instruction semantics are progressively added so objtool can track
> the stack state through the execution flow.
> There are a few things that needed consideration:
> - Generation of constants within executable sections, these either
>   caused objtool to fail decoding or to wrongly decode constants
>   as jumps or other instructions affecting execution flow and
>   causing confusion. To solve this, tracking locations referenced
>   by instructions using literals was needed.
> - Jump tables from switch statements in aarch64 don't have enough
>   information to link branches with the branch instruction leading to
>   them. For this, we use a gcc plugin to add some information to establish
>   those missing links in a format that is already supported by objtool
>
> With this, there are still some errors when building with objtool. A
> number of cleanups/annotations are needed on the arm64, as well as
> handling SYM_DATA objects in objtool.
>
> Those changes can be found on top of this branch here:
> git clone https://github.com/julien-thierry/linux.git -b objtoolxarm64-latest
>
> But it would be nice to have some feedback on this before I start submitting everyting.
>
> [1] https://lkml.org/lkml/2021/1/20/791
>
> Thanks,
>
> Julien
>
> -->
>
> Julien Thierry (15):
>   tools: Add some generic functions and headers
>   tools: arm64: Make aarch64 instruction decoder available to tools
>   tools: bug: Remove duplicate definition
>   objtool: arm64: Add base definition for arm64 backend
>   objtool: arm64: Decode add/sub instructions
>   objtool: arm64: Decode jump and call related instructions
>   objtool: arm64: Decode other system instructions
>   objtool: arm64: Decode load/store instructions
>   objtool: arm64: Decode LDR instructions
>   objtool: arm64: Accept padding in code sections
>   efi: libstub: Ignore relocations for .discard sections
>   objtool: arm64: Implement functions to add switch tables alternatives
>   objtool: arm64: Cache section with switch table information
>   objtool: arm64: Handle supported relocations in alternatives
>   objtool: arm64: Ignore replacement section for alternative callback
>
> Raphael Gault (2):
>   gcc-plugins: objtool: Add plugin to detect switch table on arm64
>   objtool: arm64: Enable stack validation for arm64
>
>  arch/arm64/Kconfig                            |    2 +
>  drivers/firmware/efi/libstub/Makefile         |    2 +-
>  scripts/Makefile.gcc-plugins                  |    2 +
>  scripts/gcc-plugins/Kconfig                   |    4 +
>  .../arm64_switch_table_detection_plugin.c     |   85 +
>  tools/arch/arm64/include/asm/aarch64-insn.h   |  551 +++++++
>  tools/arch/arm64/lib/aarch64-insn.c           | 1425 +++++++++++++++++
>  tools/include/asm-generic/bitops/__ffs.h      |   11 +
>  tools/include/linux/bug.h                     |    6 +-
>  tools/include/linux/kernel.h                  |   21 +
>  tools/include/linux/printk.h                  |   40 +
>  tools/objtool/Makefile                        |    5 +
>  tools/objtool/arch/arm64/Build                |    8 +
>  tools/objtool/arch/arm64/decode.c             |  471 ++++++
>  .../arch/arm64/include/arch/cfi_regs.h        |   14 +
>  tools/objtool/arch/arm64/include/arch/elf.h   |    6 +
>  .../arch/arm64/include/arch/endianness.h      |    9 +
>  .../objtool/arch/arm64/include/arch/special.h |   23 +
>  tools/objtool/arch/arm64/special.c            |  134 ++
>  tools/objtool/arch/x86/decode.c               |    5 +
>  tools/objtool/check.c                         |    6 +
>  tools/objtool/include/objtool/arch.h          |    3 +
>  tools/objtool/sync-check.sh                   |    5 +
>  23 files changed, 2832 insertions(+), 6 deletions(-)
>  create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
>  create mode 100644 tools/arch/arm64/include/asm/aarch64-insn.h
>  create mode 100644 tools/arch/arm64/lib/aarch64-insn.c
>  create mode 100644 tools/include/linux/printk.h
>  create mode 100644 tools/objtool/arch/arm64/Build
>  create mode 100644 tools/objtool/arch/arm64/decode.c
>  create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
>  create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
>  create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
>  create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
>  create mode 100644 tools/objtool/arch/arm64/special.c
>
> --
> 2.25.4
>
