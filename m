Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1697D4048B1
	for <lists+linux-efi@lfdr.de>; Thu,  9 Sep 2021 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhIIKtZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Sep 2021 06:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234473AbhIIKtV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Sep 2021 06:49:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8265860F4A;
        Thu,  9 Sep 2021 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631184492;
        bh=YP6JEFf8tb5qau/oInbN0Na3QT6+ETb0P24PaLLXNVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOga4lDDPK8Ne4ReZzZgIygwhWyepIGGQfsHwxHpWC1ir06Bi2gZRpOXuuNLPlbPv
         9jAIoEciEK1egcJlw4W8HHEmEgpT4QQUO68q9RoqheYNxf37eMIvdFUVMztv0c5H0R
         8igGcyNgx3w1UM0KvoiyU/jmLg/y73uowkK6XrvUF0ZvHMajlIa7MPIKwEZP2yt94q
         2UKBx4VIbHsSUqYT0nUtJVXFkB6KlSVpIqKbLHEuxVka9lLbrKl/AmRaM4XP2h5H97
         J2TmGn7To8o/4jpcw9l6AZdk9xRzwASC/DG12CGIEp98pRgx0CNQnypN+EPb49ZFTm
         cRHmU0+yrLsJQ==
Received: by mail-oi1-f170.google.com with SMTP id c79so1909811oib.11;
        Thu, 09 Sep 2021 03:48:12 -0700 (PDT)
X-Gm-Message-State: AOAM532WQNZT25VvFW+Q4w31D0cF1jcr2TaouQ49qGoK9sPCFW9Fb1sq
        arV/afZs6R2D7El82iRLPs0IUO2qHRU5VsL70j8=
X-Google-Smtp-Source: ABdhPJwsEovDSctU6v/tY7SGA7LnUBloQ95GnvdzAB8vZ2/uBR3e4mcCKbHcHzDIh2vR2YM4jIIcfys1ie9pyRm2crE=
X-Received: by 2002:a05:6808:15a2:: with SMTP id t34mr1459667oiw.47.1631184491895;
 Thu, 09 Sep 2021 03:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210908162617.104962-1-andre.przywara@arm.com>
In-Reply-To: <20210908162617.104962-1-andre.przywara@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Sep 2021 12:48:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWtNuE1P2O7=EMg8-RkAn_XYZOxQr5J3iN1fohzyqW4A@mail.gmail.com>
Message-ID: <CAMj1kXGWtNuE1P2O7=EMg8-RkAn_XYZOxQr5J3iN1fohzyqW4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: Avoid UNPREDICTABLE NOP encoding
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adam Lackorzynski <adam@l4re.org>,
        Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Sept 2021 at 18:26, Andre Przywara <andre.przywara@arm.com> wrote:
>
> In the decompressor's head.S we need to start with an instruction that
> is some kind of NOP, but also mimics as the PE/COFF header, when the
> kernel is linked as an UEFI application. The clever solution here is
> "tstne r0, #0x4d000", which in the worst case just clobbers the
> condition flags, and bears the magic "MZ" signature in the lowest 16 bits.
>
> However the encoding used (0x13105a4d) is actually not valid, since bits
> [15:12] are supposed to be 0 (written as "(0)" in the ARM ARM).
> Violating this is UNPREDICTABLE, and *can* trigger an UNDEFINED
> exception. Common Cortex cores seem to ignore those bits, but QEMU
> chooses to trap, so the code goes fishing because of a missing exception
> handler at this point. We are just saved by the fact that commonly (with
> -kernel or when running from U-Boot) the "Z" bit is set, so the
> instruction is never executed. See [0] for more details.
>
> To make things more robust and avoid UNPREDICTABLE behaviour in the
> kernel code, lets replace this with a "two-instruction NOP":
> The first instruction is an exclusive OR, the effect of which the second
> instruction reverts. This does not leave any trace, neither in a
> register nor in the condition flags. Also it's a perfectly valid
> encoding. Kudos to Peter Maydell for coming up with this gem.
>
> [0] https://lore.kernel.org/qemu-devel/YTPIdbUCmwagL5%2FD@os.inf.tu-dresden.de/T/
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Adam Lackorzynski <adam@l4re.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Thanks a lot for fixing this! I had no idea the encoding was invalid.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/boot/compressed/efi-header.S | 22 ++++++++++++++--------
>  arch/arm/boot/compressed/head.S       |  3 ++-
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
> index c0e7a745103e..230030c13085 100644
> --- a/arch/arm/boot/compressed/efi-header.S
> +++ b/arch/arm/boot/compressed/efi-header.S
> @@ -9,16 +9,22 @@
>  #include <linux/sizes.h>
>
>                 .macro  __nop
> -#ifdef CONFIG_EFI_STUB
> -               @ This is almost but not quite a NOP, since it does clobber the
> -               @ condition flags. But it is the best we can do for EFI, since
> -               @ PE/COFF expects the magic string "MZ" at offset 0, while the
> -               @ ARM/Linux boot protocol expects an executable instruction
> -               @ there.
> -               .inst   MZ_MAGIC | (0x1310 << 16)       @ tstne r0, #0x4d000
> -#else
>   AR_CLASS(     mov     r0, r0          )
>    M_CLASS(     nop.w                   )
> +               .endm
> +
> +               .macro __initial_nops
> +#ifdef CONFIG_EFI_STUB
> +               @ This is a two-instruction NOP, which happens to bear the
> +               @ PE/COFF signature "MZ" in the first two bytes, so the kernel
> +               @ is accepted as an EFI binary. Booting via the UEFI stub
> +               @ will not execute those instructions, but the ARM/Linux
> +               @ boot protocol does, so we need some NOPs here.
> +               .inst   MZ_MAGIC | (0xe225 << 16)       @ eor r5, r5, 0x4d000
> +               eor     r5, r5, 0x4d000                 @ undo previous insn
> +#else
> +               __nop
> +               __nop
>  #endif
>                 .endm
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index b1cb1972361b..bf79f2f78d23 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -203,7 +203,8 @@ start:
>                  * were patching the initial instructions of the kernel, i.e
>                  * had started to exploit this "patch area".
>                  */
> -               .rept   7
> +               __initial_nops
> +               .rept   5
>                 __nop
>                 .endr
>  #ifndef CONFIG_THUMB2_KERNEL
> --
> 2.17.1
>
