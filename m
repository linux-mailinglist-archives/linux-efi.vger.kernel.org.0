Return-Path: <linux-efi+bounces-415-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2782EFF6
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 14:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14511F24124
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE81BDC8;
	Tue, 16 Jan 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEgYKe+c"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DC1BDC5;
	Tue, 16 Jan 2024 13:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402CFC433F1;
	Tue, 16 Jan 2024 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705412863;
	bh=04lWmWfIGbM9M33qOZ9QZN58A/a9pr1kfibw8ak8AQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mEgYKe+clDNxM0AehDdV6RmEWf06HYH/CgB7nPTGpTNmwYF1GmRsJTcySIklJHOGc
	 xFzU8IICQDvjHcrQb+H8N74un9pXXPmbXdn5n/QJClaayghpZ/O53WGiu/J2EGwkO5
	 XEa9sEzvmPEeQG2I0CZMLQqKZ3V0i1Hv3Ee1njLcT+eYNlnycShlU3SaKTr3Z8MAt+
	 ehbAByDPRxwNcFV1wI9PbSxxjsbNAKwcoScT+bTr+WcHYwogiD32H1ppHJgNZUFttI
	 cQIvSW1C1fHcXHxTgIV1M5Q4SZIqIuq3MnbyuzFPtorWUxzZZzwU7GT/+loxirYFIj
	 Rb1rN3xlLajMg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso11030476e87.2;
        Tue, 16 Jan 2024 05:47:43 -0800 (PST)
X-Gm-Message-State: AOJu0YxWn0nF6Vd+OmhJcWKSClCcdvCx1lqOrcJDh0DJsJys3CXxQX3y
	jBYp/QzeCWzhaBfB1MPA9gxzq/CzKJhxGGrlOJk=
X-Google-Smtp-Source: AGHT+IGU6Pd0PdM+jWHnGRZqCmtm6cevcSk4vCAbee+YbmPzkeLvFFVZVB8EBP7nDDoDUaQwZbvsYp8SBU9p8MwM90s=
X-Received: by 2002:a05:6512:31d0:b0:50e:5b95:948 with SMTP id
 j16-20020a05651231d000b0050e5b950948mr3888669lfe.103.1705412861423; Tue, 16
 Jan 2024 05:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9>
 <56b52d4e-9dc0-400c-a141-7e70f5c72afa@siemens.com> <CAMj1kXGR1aQdvej+0drfim-ZP27ZhO9UR_i_PT6F+hsV0UvbJw@mail.gmail.com>
 <578aae7c-4069-4071-ba4b-cc86d3b516c1@siemens.com> <CAMj1kXEC4=j5zcSyo91jnUkYMoqBG5M2raMXm4DNdD5ZbS3U7g@mail.gmail.com>
 <5c077064-bdab-4796-9ed6-8f884669b73f@siemens.com>
In-Reply-To: <5c077064-bdab-4796-9ed6-8f884669b73f@siemens.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Jan 2024 14:47:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGTmmNX0E4DOcJvYB2FYopudmOnPnY33OoT2RcYF0EG0g@mail.gmail.com>
Message-ID: <CAMj1kXGTmmNX0E4DOcJvYB2FYopudmOnPnY33OoT2RcYF0EG0g@mail.gmail.com>
Subject: Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 14:44, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 16.01.24 09:36, Ard Biesheuvel wrote:
> > On Tue, 16 Jan 2024 at 06:21, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 15.01.24 18:34, Ard Biesheuvel wrote:
> >>> On Sat, 13 Jan 2024 at 11:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> On 12.01.24 19:56, Palmer Dabbelt wrote:
> >>>>> On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
> >>>>>> Hi Jan,
> >>>>>>
> >>>>>> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>>>>
> >>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>>
> >>>>>>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
> >>>>>>> under the risk that the compiler could use GP-relative addressing. That
> >>>>>>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
> >>>>>>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
> >>>>>>> It was not yet observed with newer versions, but that may just be luck.
> >>>>>>>
> >>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Something like this should go to stable as well, but we will need
> >>>>>>> rebased patches.
> >>>>>>>
> >>>>>>>  drivers/firmware/efi/libstub/Makefile | 2 +-
> >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/firmware/efi/libstub/Makefile
> >>>>>>> b/drivers/firmware/efi/libstub/Makefile
> >>>>>>> index 06964a3c130f..d561d7de46a9 100644
> >>>>>>> --- a/drivers/firmware/efi/libstub/Makefile
> >>>>>>> +++ b/drivers/firmware/efi/libstub/Makefile
> >>>>>>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
> >>>>>>> -DEFI_HAVE_STRNLEN \
> >>>>>>>                                    -DEFI_HAVE_MEMCHR
> >>>>>>> -DEFI_HAVE_STRRCHR \
> >>>>>>>                                    -DEFI_HAVE_STRCMP -fno-builtin
> >>>>>>> -fpic \
> >>>>>>>                                    $(call
> >>>>>>> cc-option,-mno-single-pic-base)
> >>>>>>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
> >>>>>>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
> >>>>>>
> >>>>>> Can we detect the presence of these references (via the relocation
> >>>>>> type)? We already do something similar for ordinary absolute
> >>>>>> references too.
> >>>>>
> >>>>> If there's no `__global_pointer$` symbol then the linker won't make
> >>>>> GP-relative relaxations (because it doesn't know where GP is).  We
> >>>>> usually define that symbol in the linker script, but I'm not entierly
> >>>>> sure how libstub gets its linker script...
> >>>>>
> >>>>
> >>>> The stub seems to be linked together with the rest of the kernel, thus
> >>>> the regular arch/riscv/kernel/vmlinux.lds.S is used.
> >>>>
> >>>
> >>> Indeed - the EFI stub is part of the same executable as vmlinux, we
> >>> just mangle the symbol names to ensure that only code that can be
> >>> safely called from the EFI stub can be linked to it.
> >>>
> >>> If the effect of -mno-relax is to stop emitting R_RISCV_RELAX
> >>> relocations, we should perhaps add those to the STUBCOPY_RELOC-y
> >>> Makefile variable? (in the same file). BTW R_RISCV_HI20 doesn't seem
> >>> like the right value there to begin with: the idea of that is to
> >>> disallow ELF relocations that evaluate to expressions that can only be
> >>> known at runtime (like absolute addresses for global pointer
> >>> variables)
> >>
> >> How to do that best? Simply replace R_RISCV_HI20 with R_RISCV_RELAX?
> >>
> >
> > We'll need to keep the HI20, in fact - I got confused between HI20 and
> > PCREL_HI20, and the former is actually used for 32-bit absolute
> > addresses in 32-bit code.
> >
> > This seems to do the trick: it disallows relaxation relocations and
> > native word sizes absolute references. AFAICT, those are the only ones
> > we should care about.
> >
> > STUBCOPY_RELOC-$(CONFIG_RISCV) := -E
> > R_RISCV_HI20\|R_RISCV_$(BITS)\|R_RISCV_RELAX
>
> I would suggest to do that on top of this patch. Want me to write such a
> patch, or will you? You can probably more fluently explain why
> R_RISCV_32/64 is important, I would first have to understand what that
> is exactly. :)
>

Sure, I can take care of that.

For your patch,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

I'll queue this up as a EFI fix.

