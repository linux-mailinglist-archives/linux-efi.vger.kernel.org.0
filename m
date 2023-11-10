Return-Path: <linux-efi+bounces-24-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC567E7AC0
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C57D1C20E55
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ACD125CE;
	Fri, 10 Nov 2023 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EC125AF
	for <linux-efi@vger.kernel.org>; Fri, 10 Nov 2023 09:25:00 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20AF2B7CC;
	Fri, 10 Nov 2023 01:24:59 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5bf5d6eaf60so17754297b3.2;
        Fri, 10 Nov 2023 01:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608298; x=1700213098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmyygXGlWqHLIcYJDnrqzZMuJVEgqUclqA12kn4gnFE=;
        b=NiQu3GsbIMv6LSvCp8jhSgx+jRxZsbNu9V+EdBYoAEBxjHwGJzk7pJ71BfDX/UH7Wz
         ECHr3lABQC+1VZ10KOQzAZMPB8Bz5dNPcfMo1/0DVmltRYF8eUt6YUizB/FZaKCFENeQ
         TxF8D7whdKLkSABdJuZbfso8bUdVG9auUJwLIe7zW6zpA8tbd4ivo/e8U2/8/rHkcfnM
         hXx/BytyoA1ZZkKLCep3bXHW5EvrIN61PPgo69rKyn4wicbYC3w7l9C/JKfYt5V8zHUs
         B9U/G6g0+cc+lHlX9EvzVb7ekJ9NN4klXdY78jToGhtM6/yk5xM7NvIBU4bnXAM7s8cm
         EbQg==
X-Gm-Message-State: AOJu0YzIGX77uXdW2SL8+LwpzYWu+SupiR+qujqjNw3a5kjx48AIDHtl
	TLMJxfiPGuIKQTLf2z6Bxv+y6GskDiXDig==
X-Google-Smtp-Source: AGHT+IFoXrgCJRz7afFo0PwLPyK/4l+eLOmgJ+1kz5XbwTzyyUuxMlnex9ZLprOuCx2YEjtbrcBq7A==
X-Received: by 2002:a81:8305:0:b0:5a7:b973:db3c with SMTP id t5-20020a818305000000b005a7b973db3cmr8225093ywf.34.1699608298636;
        Fri, 10 Nov 2023 01:24:58 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id h83-20020a816c56000000b005af9da2225bsm8481335ywc.20.2023.11.10.01.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 01:24:58 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so2038406276.1;
        Fri, 10 Nov 2023 01:24:57 -0800 (PST)
X-Received: by 2002:a25:bc90:0:b0:d9b:4a28:f66 with SMTP id
 e16-20020a25bc90000000b00d9b4a280f66mr7552303ybk.53.1699608297683; Fri, 10
 Nov 2023 01:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031064553.2319688-1-xiao.w.wang@intel.com> <20231031064553.2319688-3-xiao.w.wang@intel.com>
In-Reply-To: <20231031064553.2319688-3-xiao.w.wang@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Nov 2023 10:24:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQGtenM=_sNntW4mQ0K-7G=5_OhxG-AgQffMbR276W1w@mail.gmail.com>
Message-ID: <CAMuHMdUQGtenM=_sNntW4mQ0K-7G=5_OhxG-AgQffMbR276W1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] riscv: Optimize bitops with Zbb extension
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, anup@brainfault.org, haicheng.li@intel.com, 
	ajones@ventanamicro.com, yujie.liu@intel.com, charlie@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Tue, Oct 31, 2023 at 7:37=E2=80=AFAM Xiao Wang <xiao.w.wang@intel.com> w=
rote:
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
> used there, this patch introduces a macro NO_ALTERNATIVE for this purpose=
.
>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Thanks for your patch, which is now commit 457926b253200bd9 ("riscv:
Optimize bitops with Zbb extension") in riscv/for-next.

> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -15,13 +15,261 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>
> +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
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
> +       asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +                                     RISCV_ISA_EXT_ZBB, 1)
> +                         : : : : legacy);
> +
> +       asm volatile (".option push\n"
> +                     ".option arch,+zbb\n"
> +                     "ctz %0, %1\n"
> +                     ".option pop\n"
> +                     : "=3Dr" (word) : "r" (word) :);
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

Surely we can do better than duplicating include/asm-generic/bitops/__ffs.h=
?

E.g. rename the generic implementation to generic___ffs():

    -static __always_inline unsigned long __ffs(unsigned long word)
    +static __always_inline unsigned long generic__ffs(unsigned long word)
     {
             ...
     }

    +#ifndef __ffs
    +#define __ffs(x) generic__ffs(x)
    +#endif

and explicitly calling the generic one here?

Same comment for the other functions.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

