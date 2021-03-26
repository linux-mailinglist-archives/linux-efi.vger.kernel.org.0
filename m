Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85134A354
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 09:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCZImn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Mar 2021 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZImh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Mar 2021 04:42:37 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F5C0613AA;
        Fri, 26 Mar 2021 01:42:37 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w2so3947891ilj.12;
        Fri, 26 Mar 2021 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CkY4A20RVJeXci+R5FXU3k0PYcW30JfQNZigwa1FYbw=;
        b=R60U+wzx3jnsVA26KTij3dZvj6RFdb3iNSWfSRKj3lAb/a41KP9l44trthMGoKTwAM
         C5kxLHKLoNmGBnhCPtbPwr7zWaiTUUft5PR4K2Vx3Mj+Ibtmg8yflreD4whGYRvrmGQc
         YPQGT3D7jCpDnT40iIKuFA95vtDzK0gg/r5Et9BJPSzwrRr6q3Y42a8CyjIaCHmnbZo0
         gBDuDjv6KCGzHMr6UP5VD8bdNsIIF4VJ1H6SCm/7trNKMalMwfSuVLTx+tLuSP5VUvBi
         EQvdYM/ak4FNBaVfIlxfMJ/V0euWudFRmLfCloJ1cLk6oBo1oFFPwcyohXTS5AhE2Qwp
         Ho2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CkY4A20RVJeXci+R5FXU3k0PYcW30JfQNZigwa1FYbw=;
        b=QW8PIb3lzwsn5FXES9WFidhkS1mcdxDM6szvjLQEChaXcV2XZtThz9wsP6oUHm6+eP
         3qjzK+qX0Aw7FcRusEJ3zLDoAKULbBqKg1Sooq7E35/nEM7fkAa6vlACa1/ce+ZqBY5J
         SpPJLqBqwJF3glX2n6HqJd+d3Sbw58bNLP0WGngToYnsDV8DEvn9S2lNEXQnQ9XJwDB+
         D73lIe35y0N315pYvJUoavj3aXQVqYzwtsr3FVZMqAZTRKO+VGp8okKtn94Qm9/OgwcC
         qwEHkGqNVouwj6R+uFrjtP7pzlbP2r+NVbTDKcG5ToP8YiAEmOTFqpRzYUbNCdalKIi7
         aYPw==
X-Gm-Message-State: AOAM531JWn8kxl2DHSOsSNmSxp10dofGpfWiPd9EKGfeJK7lzKjCDZ/f
        54M1TEzcxvfOgNBkIf4KUE+sM3qzv+LQVSQ11uI=
X-Google-Smtp-Source: ABdhPJy7lA9QVsB35vSlO6zb1NcLlhJMXp7tNACv7/U3JBE7/g8c4G+FDuZK8eeH9L9hnlhR7Sx7w7PVlX0pBd+8p2k=
X-Received: by 2002:a92:c5c6:: with SMTP id s6mr120887ilt.186.1616748157005;
 Fri, 26 Mar 2021 01:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210326000435.4785-1-nathan@kernel.org> <20210326000435.4785-2-nathan@kernel.org>
In-Reply-To: <20210326000435.4785-2-nathan@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 26 Mar 2021 09:42:01 +0100
Message-ID: <CA+icZUV2ieaw-YGRzpFM033aDcPFYa4ZNcBNdh2XWbVwqUp2Lg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        John Millikin <john@john-millikin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 26, 2021 at 1:04 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> From: John Millikin <john@john-millikin.com>
>
> When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
> contains additional flags needed to build C and assembly sources
> for the target platform. Normally this variable is automatically
> included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.
>
> The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
> plain assignment and therefore drops the Clang flags. This causes
> Clang to not recognize x86-specific assembler directives:
>
>   arch/x86/realmode/rm/header.S:36:1: error: unknown directive
>   .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
>   ^
>
> Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
> which is inherited by real-mode make rules, fixes cross-compilation
> with Clang for x86 targets.
>
> Relevant flags:
>
> * `--target' sets the target architecture when cross-compiling. This
>   flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
>   to support architecture-specific assembler directives.
>
> * `-no-integrated-as' tells clang to assemble with GNU Assembler
>   instead of its built-in LLVM assembler. This flag is set by default
>   unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
>   parse certain GNU extensions.
>
> Signed-off-by: John Millikin <john@john-millikin.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I had John's v2 of this patch in my custom 5.11 patchset.
Thanks for bringing this up again, Nathan.

Later, I will test the triple patchset series.

Feel free to add for this one:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  arch/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 2d6d5a28c3bf..9a73e0cea19c 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
>  REALMODE_CFLAGS += -fno-stack-protector
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
> +REALMODE_CFLAGS += $(CLANG_FLAGS)
>  export REALMODE_CFLAGS
>
>  # BITS is used as extension for files which are available in a 32 bit
> --
> 2.31.0
>
