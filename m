Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5178C317
	for <lists+linux-efi@lfdr.de>; Tue, 29 Aug 2023 13:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjH2LIW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Aug 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjH2LIU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Aug 2023 07:08:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449AFF
        for <linux-efi@vger.kernel.org>; Tue, 29 Aug 2023 04:08:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c4923195dso525672366b.2
        for <linux-efi@vger.kernel.org>; Tue, 29 Aug 2023 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1693307296; x=1693912096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrkTstjTEiNNJCQmVu1d/FovCHkCZm8dZOPspkYI3AQ=;
        b=aGPdKZuY5NEJf+wG7N0dW1CJh5Gf/hgW5VTsJ7WTzCKsDAC4/aGS5ZxZ74acnjuN3b
         P2wxkEvPv6U0jUxuBbv1WBGbhoGJGc0OaxgegbN4gz0DcMfefmllyA0FG1BztxcKTYC6
         FxSwweAagOMweDERcV7pVJsNi9VEfTEOYSZJAK6uUiF/v/55Y0z8e/awq38FLF51zMfk
         GcMG9OOSX4nxKn7NHOjrdkk+lLxMHqboYqu8jPT/to9vH7xBXiLpOUtBNBhN6B2qv5FE
         Gi2EYBffcP54J7JLd9sVhrukdMpBegU64aN+rMLeXUWJbCNzLgSp5fmlLOaYALK5/FcM
         CMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693307296; x=1693912096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrkTstjTEiNNJCQmVu1d/FovCHkCZm8dZOPspkYI3AQ=;
        b=Ebn2GYGHuUalkxqrvlrnnEW+ovuF2ejjw5buVnZtJknUBhvLrfbjysdHsb5ZiqEolQ
         t92xPPLg1J+fgSc/SlY6SvJT/zX3rkfxFggkCd0yuCiSID6/ys7q3pjIjpLTARYCm/+x
         Xq0Ce9qbS85E9fzdQlDGZlplDDVqc3KtgluzxnE+7r+5VZHnXUxz3aqz0w7sS/CD+HMy
         r0S5yYwRUm20sSw6mQsIcV2CsatjCbF1N/CxEBRvwu55M4kVuF+/X50hbWwAnxT0R/QJ
         V+RBD7MVh0V3w4M0aCCv04dXUQRS91SX8JnDbZ6wGwqN8r10wtEj+2fiExc30vPwuHX+
         bgGg==
X-Gm-Message-State: AOJu0Yxmju+AAyu7bgE1IoDr0S22QhdhLXHGxQGlJr7b2f/EHzfQNKpA
        ku84/bctugDXb8iIokKQle+lH2f5my2g6p/CkJYFmQ==
X-Google-Smtp-Source: AGHT+IG3A8cAB8JJ6IN+iWxSguNpowm0V0ics5K4fy5pDOF1Oup3H1x4LGxDiLXG0L4JABWAG2T/pMwv7Kd3RLs5qxs=
X-Received: by 2002:a17:907:2cc8:b0:9a5:c9a4:ba1a with SMTP id
 hg8-20020a1709072cc800b009a5c9a4ba1amr1224893ejc.59.1693307295498; Tue, 29
 Aug 2023 04:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
In-Reply-To: <20230806024715.3061589-1-xiao.w.wang@intel.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 29 Aug 2023 16:38:03 +0530
Message-ID: <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, haicheng.li@intel.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Aug 6, 2023 at 8:09=E2=80=AFAM Xiao Wang <xiao.w.wang@intel.com> wr=
ote:
>
> This patch leverages the alternative mechanism to dynamically optimize
> bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> Zbb ext is not supported by the runtime CPU, legacy implementation is
> used. If Zbb is supported, then the optimized variants will be selected
> via alternative patching.
>
> The legacy bitops support is taken from the generic C implementation as
> fallback.
>
> If the parameter is a build-time constant, we leverage compiler builtin t=
o
> calculate the result directly, this approach is inspired by x86 bitops
> implementation.
>
> EFI stub runs before the kernel, so alternative mechanism should not be
> used there, this patch introduces a macro EFI_NO_ALTERNATIVE for this
> purpose.

I am getting the following compile error with this patch:

  GEN     Makefile
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CC      kernel/bounds.s
In file included from /home/anup/Work/riscv-test/linux/include/linux/bitmap=
.h:9,
                 from
/home/anup/Work/riscv-test/linux/arch/riscv/include/asm/cpufeature.h:9,
                 from
/home/anup/Work/riscv-test/linux/arch/riscv/include/asm/hwcap.h:90,
                 from
/home/anup/Work/riscv-test/linux/arch/riscv/include/asm/bitops.h:26,
                 from
/home/anup/Work/riscv-test/linux/include/linux/bitops.h:68,
                 from /home/anup/Work/riscv-test/linux/include/linux/log2.h=
:12,
                 from /home/anup/Work/riscv-test/linux/kernel/bounds.c:13:
/home/anup/Work/riscv-test/linux/include/linux/find.h: In function
'find_next_bit':
/home/anup/Work/riscv-test/linux/include/linux/find.h:64:30: error:
implicit declaration of function '__ffs'
[-Werror=3Dimplicit-function-declaration]
   64 |                 return val ? __ffs(val) : size;

Regards,
Anup


>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/bitops.h       | 266 +++++++++++++++++++++++++-
>  drivers/firmware/efi/libstub/Makefile |   2 +-
>  2 files changed, 264 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bit=
ops.h
> index 3540b690944b..f727f6489cd5 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -15,13 +15,273 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>
> +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(EFI_NO_ALTERNATIVE)
>  #include <asm-generic/bitops/__ffs.h>
> -#include <asm-generic/bitops/ffz.h>
> -#include <asm-generic/bitops/fls.h>
>  #include <asm-generic/bitops/__fls.h>
> +#include <asm-generic/bitops/ffs.h>
> +#include <asm-generic/bitops/fls.h>
> +
> +#else
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
> +
> +#if (BITS_PER_LONG =3D=3D 64)
> +#define CTZW   "ctzw "
> +#define CLZW   "clzw "
> +#elif (BITS_PER_LONG =3D=3D 32)
> +#define CTZW   "ctz "
> +#define CLZW   "clz "
> +#else
> +#error "Unexpected BITS_PER_LONG"
> +#endif
> +
> +static __always_inline unsigned long variable__ffs(unsigned long word)
> +{
> +       int num;
> +
> +       asm_volatile_goto(
> +               ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, =
1)
> +               : : : : legacy);
> +
> +       asm volatile (
> +               ".option push\n"
> +               ".option arch,+zbb\n"
> +               "ctz %0, %1\n"
> +               ".option pop\n"
> +               : "=3Dr" (word) : "r" (word) :);
> +
> +       return word;
> +
> +legacy:
> +       num =3D 0;
> +#if BITS_PER_LONG =3D=3D 64
> +       if ((word & 0xffffffff) =3D=3D 0) {
> +               num +=3D 32;
> +               word >>=3D 32;
> +       }
> +#endif
> +       if ((word & 0xffff) =3D=3D 0) {
> +               num +=3D 16;
> +               word >>=3D 16;
> +       }
> +       if ((word & 0xff) =3D=3D 0) {
> +               num +=3D 8;
> +               word >>=3D 8;
> +       }
> +       if ((word & 0xf) =3D=3D 0) {
> +               num +=3D 4;
> +               word >>=3D 4;
> +       }
> +       if ((word & 0x3) =3D=3D 0) {
> +               num +=3D 2;
> +               word >>=3D 2;
> +       }
> +       if ((word & 0x1) =3D=3D 0)
> +               num +=3D 1;
> +       return num;
> +}
> +
> +/**
> + * __ffs - find first set bit in a long word
> + * @word: The word to search
> + *
> + * Undefined if no set bit exists, so code should check against 0 first.
> + */
> +#define __ffs(word)                            \
> +       (__builtin_constant_p(word) ?           \
> +        (unsigned long)__builtin_ctzl(word) :  \
> +        variable__ffs(word))
> +
> +static __always_inline unsigned long variable__fls(unsigned long word)
> +{
> +       int num;
> +
> +       asm_volatile_goto(
> +               ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, =
1)
> +               : : : : legacy);
> +
> +       asm volatile (
> +               ".option push\n"
> +               ".option arch,+zbb\n"
> +               "clz %0, %1\n"
> +               ".option pop\n"
> +               : "=3Dr" (word) : "r" (word) :);
> +
> +       return BITS_PER_LONG - 1 - word;
> +
> +legacy:
> +       num =3D BITS_PER_LONG - 1;
> +#if BITS_PER_LONG =3D=3D 64
> +       if (!(word & (~0ul << 32))) {
> +               num -=3D 32;
> +               word <<=3D 32;
> +       }
> +#endif
> +       if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
> +               num -=3D 16;
> +               word <<=3D 16;
> +       }
> +       if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
> +               num -=3D 8;
> +               word <<=3D 8;
> +       }
> +       if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
> +               num -=3D 4;
> +               word <<=3D 4;
> +       }
> +       if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
> +               num -=3D 2;
> +               word <<=3D 2;
> +       }
> +       if (!(word & (~0ul << (BITS_PER_LONG-1))))
> +               num -=3D 1;
> +       return num;
> +}
> +
> +/**
> + * __fls - find last set bit in a long word
> + * @word: the word to search
> + *
> + * Undefined if no set bit exists, so code should check against 0 first.
> + */
> +#define __fls(word)                                                    \
> +       (__builtin_constant_p(word) ?                                   \
> +        (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :    \
> +        variable__fls(word))
> +
> +static __always_inline int variable_ffs(int x)
> +{
> +       int r;
> +
> +       asm_volatile_goto(
> +               ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, =
1)
> +               : : : : legacy);
> +
> +       asm volatile (
> +               ".option push\n"
> +               ".option arch,+zbb\n"
> +               "bnez %1, 1f\n"
> +               "li %0, 0\n"
> +               "j 2f\n"
> +               "1:\n"
> +               CTZW "%0, %1\n"
> +               "addi %0, %0, 1\n"
> +               "2:\n"
> +               ".option pop\n"
> +               : "=3Dr" (r) : "r" (x) :);
> +
> +       return r;
> +
> +legacy:
> +       r =3D 1;
> +       if (!x)
> +               return 0;
> +       if (!(x & 0xffff)) {
> +               x >>=3D 16;
> +               r +=3D 16;
> +       }
> +       if (!(x & 0xff)) {
> +               x >>=3D 8;
> +               r +=3D 8;
> +       }
> +       if (!(x & 0xf)) {
> +               x >>=3D 4;
> +               r +=3D 4;
> +       }
> +       if (!(x & 3)) {
> +               x >>=3D 2;
> +               r +=3D 2;
> +       }
> +       if (!(x & 1)) {
> +               x >>=3D 1;
> +               r +=3D 1;
> +       }
> +       return r;
> +}
> +
> +/**
> + * ffs - find first set bit in a word
> + * @x: the word to search
> + *
> + * This is defined the same way as the libc and compiler builtin ffs rou=
tines.
> + *
> + * ffs(value) returns 0 if value is 0 or the position of the first set b=
it if
> + * value is nonzero. The first (least significant) bit is at position 1.
> + */
> +#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ff=
s(x))
> +
> +static __always_inline int variable_fls(unsigned int x)
> +{
> +       int r;
> +
> +       asm_volatile_goto(
> +               ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, =
1)
> +               : : : : legacy);
> +
> +       asm volatile (
> +               ".option push\n"
> +               ".option arch,+zbb\n"
> +               "bnez %1, 1f\n"
> +               "li %0, 0\n"
> +               "j 2f\n"
> +               "1:\n"
> +               CLZW "%0, %1\n"
> +               "neg %0, %0\n"
> +               "addi %0, %0, 32\n"
> +               "2:\n"
> +               ".option pop\n"
> +               : "=3Dr" (r) : "r" (x) :);
> +
> +       return r;
> +
> +legacy:
> +       r =3D 32;
> +       if (!x)
> +               return 0;
> +       if (!(x & 0xffff0000u)) {
> +               x <<=3D 16;
> +               r -=3D 16;
> +       }
> +       if (!(x & 0xff000000u)) {
> +               x <<=3D 8;
> +               r -=3D 8;
> +       }
> +       if (!(x & 0xf0000000u)) {
> +               x <<=3D 4;
> +               r -=3D 4;
> +       }
> +       if (!(x & 0xc0000000u)) {
> +               x <<=3D 2;
> +               r -=3D 2;
> +       }
> +       if (!(x & 0x80000000u)) {
> +               x <<=3D 1;
> +               r -=3D 1;
> +       }
> +       return r;
> +}
> +
> +/**
> + * fls - find last set bit in a word
> + * @x: the word to search
> + *
> + * This is defined in a similar way as ffs, but returns the position of =
the most
> + * significant set bit.
> + *
> + * fls(value) returns 0 if value is 0 or the position of the last set bi=
t if
> + * value is nonzero. The last (most significant) bit is at position 32.
> + */
> +#define fls(x)                                                         \
> +       (__builtin_constant_p(x) ?                                      \
> +        (int)(((x) !=3D 0) ?                                            =
 \
> +         (sizeof(unsigned int) * 8 - __builtin_clz(x)) : 0) :          \
> +        variable_fls(x))
> +
> +#endif
> +
> +#include <asm-generic/bitops/ffz.h>
>  #include <asm-generic/bitops/fls64.h>
>  #include <asm-generic/bitops/sched.h>
> -#include <asm-generic/bitops/ffs.h>
>
>  #include <asm-generic/bitops/hweight.h>
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index 16d64a34d1e1..b0f8c495c10f 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          +=3D -DEFI_HAVE_STRLEN -D=
EFI_HAVE_STRNLEN \
>                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)         +=3D -fpic
> +cflags-$(CONFIG_RISCV)         +=3D -fpic -DEFI_NO_ALTERNATIVE
>  cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
>
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   +=3D -I$(srctree)/scripts/dtc/lib=
fdt
> --
> 2.25.1
>
