Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B888269FDF
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIOHfS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 03:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgIOHfP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 03:35:15 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3928021D7B
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600155314;
        bh=TjOS6OiP5c20g6eAxWWjr3mrs1f5TYNMHlqPF4W+kfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sLwuWs3xtCmKEXKvCWiB3JXb4JQ8602yFgvYjcpEqKFYRl065BXezHh4YC3iv+EBF
         6NyPw0zPAy8t8i7fGjC+Vig/iMB20oM0anzu2XFp3XQXRamVVmi5HSwoCXpOkn6FTB
         fYmZlIo0BI9MnYadlonNQtDpft8Pqqp3WPaqCdd0=
Received: by mail-oi1-f171.google.com with SMTP id u126so2753565oif.13
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 00:35:14 -0700 (PDT)
X-Gm-Message-State: AOAM530vKxUxxOYQJA/UvShBX9b1uaQL1A6pVKyCl9R5Dvs72hHRVtHF
        i/3um2V3KwH5JpS5GHq0tmaDtTtEDJmT4RbIODk=
X-Google-Smtp-Source: ABdhPJxC70N0w0BCV9Fhjnec7iLKBAMWlXwE+SV8K+MiUr34cy+PLvKwITdbACefS/5z+GG1ZSoFjAWsoRvFl60YhL0=
X-Received: by 2002:aca:d845:: with SMTP id p66mr2252080oig.47.1600155313473;
 Tue, 15 Sep 2020 00:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <20200914095706.3985-2-ardb@kernel.org>
In-Reply-To: <20200914095706.3985-2-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Sep 2020 10:35:02 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFmF_24d-7W8AWTJR-PCcja7bUdHhYKptGQmsV4vNp=sA@mail.gmail.com>
Message-ID: <CAMj1kXFmF_24d-7W8AWTJR-PCcja7bUdHhYKptGQmsV4vNp=sA@mail.gmail.com>
Subject: Re: [PATCH 01/12] ARM: assembler: introduce adr_l, ldr_l and str_l macros
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Sep 2020 at 12:57, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Like arm64, ARM supports position independent code sequences that
> produce symbol references with a greater reach than the ordinary
> adr/ldr instructions. Since on ARM, the adrl pseudo-instruction is
> only supported in ARM mode (and not at all when using Clang), having
> a adr_l macro like we do on arm64 is useful, and increases symmetry
> as well.
>
> Currently, we use open coded instruction sequences involving literals
> and arithmetic operations. Instead, we can use movw/movt pairs on v7
> CPUs, circumventing the D-cache entirely.
>
> E.g., on v7+ CPUs, we can emit a PC-relative reference as follows:
>
>        movw         <reg>, #:lower16:<sym> - (1f + 8)
>        movt         <reg>, #:upper16:<sym> - (1f + 8)
>   1:   add          <reg>, <reg>, pc
>
> For older CPUs, we can emit the literal into a subsection, allowing it
> to be emitted out of line while retaining the ability to perform
> arithmetic on label offsets.
>
> E.g., on pre-v7 CPUs, we can emit a PC-relative reference as follows:
>
>        ldr          <reg>, 2f
>   1:   add          <reg>, <reg>, pc
>        .subsection  1
>   2:   .long        <sym> - (1b + 8)
>        .previous
>
> This is allowed by the assembler because, unlike ordinary sections,
> subsections are combined into a single section in the object file, and
> so the label references are not true cross-section references that are
> visible as relocations. (Subsections have been available in binutils
> since 2004 at least, so they should not cause any issues with older
> toolchains.)
>
> So use the above to implement the macros mov_l, adr_l, ldr_l and str_l,
> all of which will use movw/movt pairs on v7 and later CPUs, and use
> PC-relative literals otherwise.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/include/asm/assembler.h | 84 ++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index feac2c8b86f2..39e972eaaa3f 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -494,4 +494,88 @@ THUMB(     orr     \reg , \reg , #PSR_T_BIT        )
>  #define _ASM_NOKPROBE(entry)
>  #endif
>
> +       .macro          __adldst_l, op, reg, sym, tmp, c
> +       .if             __LINUX_ARM_ARCH__ < 7
> +       ldr\c           \tmp, .La\@
> +       .subsection     1
> +       .align          2
> +.La\@: .long           \sym - .Lpc\@
> +       .previous
> +       .else
> +       .ifnb           \c
> + THUMB(        ittt            \c                      )
> +       .endif
> +       movw\c          \tmp, #:lower16:\sym - .Lpc\@
> +       movt\c          \tmp, #:upper16:\sym - .Lpc\@
> +       .endif
> +
> +#ifndef CONFIG_THUMB2_KERNEL
> +       .set            .Lpc\@, . + 8                   // PC bias
> +       .ifc            \op, add
> +       add\c           \reg, \tmp, pc
> +       .else
> +       \op\c           \reg, [\tmp, pc]

This should be

       \op\c           \reg, [pc, \tmp]

> +       .endif
> +#else
> +.Lb\@: add\c           \tmp, \tmp, pc
> +       /*
> +        * In Thumb-2 builds, the PC bias depends on whether we are currently
> +        * emitting into a .arm or a .thumb section. The size of the add opcode
> +        * above will be 2 bytes when emitting in Thumb mode and 4 bytes when
> +        * emitting in ARM mode, so let's use this to account for the bias.
> +        */
> +       .set            .Lpc\@, . + (. - .Lb\@)
> +
> +       .ifnc           \op, add
> +       \op\c           \reg, [\tmp]
> +       .endif
> +#endif
> +       .endm
> +
> +       /*
> +        * mov_l - move a constant value or [relocated] address into a register
> +        */
> +       .macro          mov_l, dst:req, imm:req
> +       .if             __LINUX_ARM_ARCH__ < 7
> +       ldr             \dst, =\imm
> +       .else
> +       movw            \dst, #:lower16:\imm
> +       movt            \dst, #:upper16:\imm
> +       .endif
> +       .endm
> +
> +       /*
> +        * adr_l - adr pseudo-op with unlimited range
> +        *
> +        * @dst: destination register
> +        * @sym: name of the symbol
> +        * @cond: conditional opcode suffix
> +        */
> +       .macro          adr_l, dst:req, sym:req, cond
> +       __adldst_l      add, \dst, \sym, \dst, \cond
> +       .endm
> +
> +       /*
> +        * ldr_l - ldr <literal> pseudo-op with unlimited range
> +        *
> +        * @dst: destination register
> +        * @sym: name of the symbol
> +        * @cond: conditional opcode suffix
> +        */
> +       .macro          ldr_l, dst:req, sym:req, cond
> +       __adldst_l      ldr, \dst, \sym, \dst, \cond
> +       .endm
> +
> +       /*
> +        * str_l - str <literal> pseudo-op with unlimited range
> +        *
> +        * @src: source register
> +        * @sym: name of the symbol
> +        * @tmp: mandatory scratch register
> +        * @cond: conditional opcode suffix
> +        */
> +       .macro          str_l, src:req, sym:req, tmp:req, cond
> +       __adldst_l      str, \src, \sym, \tmp, \cond
> +       .endm
> +
>  #endif /* __ASM_ASSEMBLER_H__ */
> --
> 2.17.1
>
