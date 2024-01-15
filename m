Return-Path: <linux-efi+bounces-407-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315282DE7F
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jan 2024 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E619F2832D3
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jan 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBDD182A3;
	Mon, 15 Jan 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDsqGDId"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F4182A0;
	Mon, 15 Jan 2024 17:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83087C433C7;
	Mon, 15 Jan 2024 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705340061;
	bh=2cyFxe3uTqXct4jEHJssjWPzlGUygaQOIyDsjApVixs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NDsqGDIdECNVMWc+uAQHFv77zTzI5T522ItTdcWbGbiidpMdS71qAqKcTWOJWnWL9
	 +3C6sbRpMZs2bWs3h/nmboU8I2UO8EwSv8AVSssH5cCAXp7H6i4zX0kVUucRvOK4wj
	 o4rA7dLoHtMdlxxhe+yNFIjxxHByYyLNlZhPHnbyjnUxmK6KOZZ+xSGVe2zHXQ/QiF
	 I9tASWxZfH4n043KIl4rErlj0xolpjIUCtazroKabuEFa7b2Cb1qfPH1KzO4YeTJni
	 q4xTI9OtbnmvHXxmQDQTGTHXWU0uJtUk0J+jFlTvEwWCdT3ALxRo0cHm/K2ZX7fqKu
	 TTQs+myvvVlMw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eabd1c701so10909227e87.3;
        Mon, 15 Jan 2024 09:34:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxQyQ3IZ7MX0G7hkq7pIJv4FjFfPJlXFafYITsRpiWIrJKQIRZp
	uoUDwjeaNe9i3XeN3hQqT/bgl6aXJGPcLxLBVUE=
X-Google-Smtp-Source: AGHT+IHFo330I6ZljINXz/ysqRtL+x3YL/kuqlI40H8B493dbLWWGACXW6EkUsLbSJQXy3E03NMp49jK4CLZdbH39co=
X-Received: by 2002:ac2:44ba:0:b0:50e:7b63:556c with SMTP id
 c26-20020ac244ba000000b0050e7b63556cmr2378330lfm.101.1705340059757; Mon, 15
 Jan 2024 09:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9> <56b52d4e-9dc0-400c-a141-7e70f5c72afa@siemens.com>
In-Reply-To: <56b52d4e-9dc0-400c-a141-7e70f5c72afa@siemens.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Jan 2024 18:34:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGR1aQdvej+0drfim-ZP27ZhO9UR_i_PT6F+hsV0UvbJw@mail.gmail.com>
Message-ID: <CAMj1kXGR1aQdvej+0drfim-ZP27ZhO9UR_i_PT6F+hsV0UvbJw@mail.gmail.com>
Subject: Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 11:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 12.01.24 19:56, Palmer Dabbelt wrote:
> > On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
> >> Hi Jan,
> >>
> >> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
> >>> under the risk that the compiler could use GP-relative addressing. That
> >>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
> >>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
> >>> It was not yet observed with newer versions, but that may just be luck.
> >>>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>> ---
> >>>
> >>> Something like this should go to stable as well, but we will need
> >>> rebased patches.
> >>>
> >>>  drivers/firmware/efi/libstub/Makefile | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/Makefile
> >>> b/drivers/firmware/efi/libstub/Makefile
> >>> index 06964a3c130f..d561d7de46a9 100644
> >>> --- a/drivers/firmware/efi/libstub/Makefile
> >>> +++ b/drivers/firmware/efi/libstub/Makefile
> >>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
> >>> -DEFI_HAVE_STRNLEN \
> >>>                                    -DEFI_HAVE_MEMCHR
> >>> -DEFI_HAVE_STRRCHR \
> >>>                                    -DEFI_HAVE_STRCMP -fno-builtin
> >>> -fpic \
> >>>                                    $(call
> >>> cc-option,-mno-single-pic-base)
> >>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
> >>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
> >>
> >> Can we detect the presence of these references (via the relocation
> >> type)? We already do something similar for ordinary absolute
> >> references too.
> >
> > If there's no `__global_pointer$` symbol then the linker won't make
> > GP-relative relaxations (because it doesn't know where GP is).  We
> > usually define that symbol in the linker script, but I'm not entierly
> > sure how libstub gets its linker script...
> >
>
> The stub seems to be linked together with the rest of the kernel, thus
> the regular arch/riscv/kernel/vmlinux.lds.S is used.
>

Indeed - the EFI stub is part of the same executable as vmlinux, we
just mangle the symbol names to ensure that only code that can be
safely called from the EFI stub can be linked to it.

If the effect of -mno-relax is to stop emitting R_RISCV_RELAX
relocations, we should perhaps add those to the STUBCOPY_RELOC-y
Makefile variable? (in the same file). BTW R_RISCV_HI20 doesn't seem
like the right value there to begin with: the idea of that is to
disallow ELF relocations that evaluate to expressions that can only be
known at runtime (like absolute addresses for global pointer
variables)

