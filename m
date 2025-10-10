Return-Path: <linux-efi+bounces-5018-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B3BCDF50
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F51189A9F6
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715EE2FC01E;
	Fri, 10 Oct 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edzm6Syy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5672FC00F
	for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113571; cv=none; b=ovQnWniK6YkLIVGRyP/fc6SOrgfSduYOlL+gvUzkyqHPNI2kw7hQaJBzETJ8Mb98o+XiWBuT5lZRuxt8UMeUn2PrVzhrzokkXoNAa0HGtH5RrB+AiDaskPDx3u0LwNr23umgzcfPPp6YnwvAXSG1c3zR/fKch49JQruKjUe00jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113571; c=relaxed/simple;
	bh=utKCZjeHw3iqnFfYB1ZfxGnO3UrPmvILiol4TqfBHR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUw1+k1Xy8geR7KUrZgdXEdA+qoHSl/iuiFkb5zwa2pfWcemIUZuq4aUq/UMwdXVleMyKnjdtNKfUd9fmOPe68ISuQguRvuwDXIMQoZHJHEA9X8uA6UXOFM6ct0BFUnAdTOi0r05fv8KKcLZICABUSDoL6tZRNYLSU/4Pp939Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edzm6Syy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC57C4CEF1
	for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760113570;
	bh=utKCZjeHw3iqnFfYB1ZfxGnO3UrPmvILiol4TqfBHR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Edzm6SyycKKkFWiTk3912LPCjJ42xcjg9u99+ZCWUuoxk24NyxIEoUV0xYtQ1hUhS
	 ZusMQJfHtM2t/nyvK+d3GH5aIGZgyQMn4OfO9/mKwlFqZQ0BGVVR8/K61WyGw1Gnfx
	 hCR7R6B0dRDHMtGQAjYSQjR0oJR/xhkoXFo+ZeIAl5w8rQWa1PkKYdMaE+FlyXYU27
	 QSIioFAwgaRXm3nXRFlpzxgYTy194pXYy1LgUWUVcXFadZGIW8i9ZlapyZYIRg/5Mh
	 rxA3StEnbj9gQGcrOzzgEgWNXP8PcnpnB16a1kGiOhggvJ4zKo4zGppCUZdhrF7luz
	 r771GJdkNs/2w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-58d29830058so2800696e87.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 09:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWayKxXbJbGGNqkpNTsZRLYNrmEt2XB4Jm7dYldVRyq/fHcSbvlErVpaAa6qPY7cSHSKBdAZ7MSes0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojGwoDMud9DYh+pI/ixlgTMfLO3DUdPtFm1QQq4nNuUvoXj8D
	hgtof2lfXvnPgj/EgSCoJx3K05lV8IPa1b+eI6esxdRZOVp0Ok61ITc7LXlqniHz0D9679EUgTa
	rfzEQ6eouk8+bcxzPSKclfequHeUAoZE=
X-Google-Smtp-Source: AGHT+IFlrMsUvrC/ZHyp7C1tmfy80lEWySBj/07SSrfUI6v7Q7I01eOrR8aE8CO2xnNLYI6LpFea10RRzC+bIaZdgH8=
X-Received: by 2002:a05:6512:1152:b0:57b:5794:ccd9 with SMTP id
 2adb3069b0e04-5906d77e26bmr3537150e87.9.1760113569266; Fri, 10 Oct 2025
 09:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
 <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
 <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com> <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn>
In-Reply-To: <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Oct 2025 09:25:57 -0700
X-Gmail-Original-Message-ID: <CAMj1kXFLyBbRL+pAAQ6be6dxqFPiyw_Ug8qNQWaicZQ235HE=A@mail.gmail.com>
X-Gm-Features: AS18NWAp30BvVY9ZXh0_0XY6OhGFXDo-CTjUdGdhBNHw2LQ_EFhIlBfBfuAUJuI
Message-ID: <CAMj1kXFLyBbRL+pAAQ6be6dxqFPiyw_Ug8qNQWaicZQ235HE=A@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Oct 2025 at 00:27, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> On 2025/9/28 =E4=B8=8B=E5=8D=8810:41, Ard Biesheuvel wrote:
> > On Sun, 28 Sept 2025 at 16:39, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Sun, 28 Sept 2025 at 15:52, Huacai Chen <chenhuacai@kernel.org> wro=
te:
> >>>
> >>> Hi, Ard,
> >>>
> >>> On Sun, Sep 28, 2025 at 9:42=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> >>>>
> >>>> On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> =
wrote:
> >>>>>
> >>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> >>>>> the following objtool warning on LoongArch:
> >>>>>
> >>>>>    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> >>>>>    falls through to next function __efistub_exit_boot_func()
> >>>>>
> >>>>> This is because efi_boot_kernel() doesn't end with a return instruc=
tion
> >>>>> or an unconditional jump, then objtool has determined that the func=
tion
> >>>>> can fall through into the next function.
> >>>>>
> >>>>> At the beginning, try to do something to make efi_boot_kernel() end=
s with
> >>>>> an unconditional jump instruction, but this modification seems not =
proper.
> >>>>>
> >>>>> Since the efistub functions are useless for stack unwinder, they ca=
n be
> >>>>> ignored by objtool. After many discussions, no need to link libstub=
 to
> >>>>> the vmlinux.o, only link libstub to the final vmlinux.
> >>>>>
> >>>>
...
> Are you OK with the following changes?
>
> (1) libstub doesn't link to vmlinux.o, only link libstub with vmlinux.o
> during the final vmlinux link, keep the changes confined to LoongArch,
> no need to be something more generic.
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index dc5bd3f1b8d2..f34b416f5ca2 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -169,7 +169,6 @@ CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS)
> $(KBUILD_CFLAGS) -dM -E -x c /dev
>   endif
>
>   libs-y +=3D arch/loongarch/lib/
> -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
.a
>
>   drivers-y              +=3D arch/loongarch/crypto/
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 433849ff7529..ed94871c3606 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -69,6 +69,12 @@ vmlinux_link()
>                  libs=3D"${KBUILD_VMLINUX_LIBS}"
>          fi
>
> +       if [ "${SRCARCH}" =3D "loongarch" ]; then
> +               if is_enabled CONFIG_EFI_STUB; then
> +                       libs=3D"${libs} drivers/firmware/efi/libstub/lib.=
a"
> +               fi
> +       fi
> +
>          if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
>                  objs=3D"${objs} .builtin-dtbs.o"
>          fi
>
> (2) remove the attribute __noreturn for real_kernel_entry() and add
> "while (1);" at the end of efi_boot_kernel().
>
> diff --git a/drivers/firmware/efi/libstub/loongarch.c
> b/drivers/firmware/efi/libstub/loongarch.c
> index 3782d0a187d1..e309fd78fca7 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -10,7 +10,7 @@
>   #include "efistub.h"
>   #include "loongarch-stub.h"
>
> -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdlin=
e,
> +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
>                                           unsigned long systab);
>
>   efi_status_t check_platform_features(void)
> @@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle,
> efi_loaded_image_t *image,
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> +
> +       /* We should never get here */
> +       while (1);
>   }
>

Why do we need both (1) and (2)?

