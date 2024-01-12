Return-Path: <linux-efi+bounces-401-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9482C59B
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jan 2024 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7C285363
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jan 2024 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C702156E3;
	Fri, 12 Jan 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akADFvt8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA34156CD;
	Fri, 12 Jan 2024 18:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4CEC433C7;
	Fri, 12 Jan 2024 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705085490;
	bh=TTvtQ1O6bYOGyAq062N/HpL4Y1P60eFyaPwHfY+VEu4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=akADFvt8gXXY2XwsyOWh+FzLAlO16KTuPXmF51KI2OHRZyeGB2tApPR+VdwSk3djC
	 emYrLUeRvqeeSUHEDxSrXwi3wLnd13XUWrsZt25/AmCpx1H/IujaxslJUiPCcjfRmu
	 Fu6W7GIMa48md5m1/dJQG7filnocPXNlW4PLI6Ym/rgTkK3rwO2Mwn7JY6u1wdzJoa
	 RfvUtJnrUDwZ59IedaB8AHpYjYZsRVunDJQXovH2De6WefcsUeBfw9Wz7fHqPeIVvr
	 MeEvotyw9xtfp0O/NC3d9K9sQr928uyLG8Ort+lbY02RhT81JYgp8pZAgJR0abmRKg
	 HdIAMC+fhP62w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso7545088e87.1;
        Fri, 12 Jan 2024 10:51:30 -0800 (PST)
X-Gm-Message-State: AOJu0YzxspiWLp1s+ONYhTJ4QMbUsA0eTsQbCQiI9mAdCehRuzNu85jf
	REU7ldTGHSk6Nr2bI1Zp5w22kaKBta01/h8Ovzw=
X-Google-Smtp-Source: AGHT+IF/mJ1IiMoZ6NPwfATjHVnzpVsMppdDErD+ZdVIZRVx3da7n5+7RstE4IMHTnRRX1Hbfzfy8FSwdL54R9TFLLU=
X-Received: by 2002:a05:6512:21a8:b0:50e:76ca:52c6 with SMTP id
 c8-20020a05651221a800b0050e76ca52c6mr731172lft.52.1705085488444; Fri, 12 Jan
 2024 10:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <42c63cb9-87d0-49db-9af8-95771b186684@siemens.com>
In-Reply-To: <42c63cb9-87d0-49db-9af8-95771b186684@siemens.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Jan 2024 19:51:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHUAQVrzdqFXDX1Fid38Gov3R-DNwJSSXXNqVgJPr6cBw@mail.gmail.com>
Message-ID: <CAMj1kXHUAQVrzdqFXDX1Fid38Gov3R-DNwJSSXXNqVgJPr6cBw@mail.gmail.com>
Subject: Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-efi <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The cflags for the RISC-V efistub were missing -mno-relax, thus were
> under the risk that the compiler could use GP-relative addressing. That
> happened for _edata with binutils-2.41 and kernel 6.1, causing the
> relocation to fail due to an invalid kernel_size in handle_kernel_image.
> It was not yet observed with newer versions, but that may just be luck.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Something like this should go to stable as well, but we will need
> rebased patches.
>
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 06964a3c130f..d561d7de46a9 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax

Can we detect the presence of these references (via the relocation
type)? We already do something similar for ordinary absolute
references too.

>  cflags-$(CONFIG_LOONGARCH)     += -fpie
>
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   += -I$(srctree)/scripts/dtc/libfdt
> --
> 2.35.3

