Return-Path: <linux-efi+bounces-240-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A49817D39
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 23:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E631B21DDA
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10D74E14;
	Mon, 18 Dec 2023 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2LkWNuL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413D740B0;
	Mon, 18 Dec 2023 22:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACAC433C9;
	Mon, 18 Dec 2023 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938430;
	bh=bnMaUsbsfJ/Mgj0ipxaF2LvUK40Y5atE6jfvwPpoS/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j2LkWNuLc/R/R4Rwb+682uk4YWicH5mA1ioiq16Kfogpk+iJUuEZMeK2YQHHBJnw2
	 ApEI6PyQPMvlAHYQVlxOoyOcWr8heyLReDEWsKTfJCfwduJsdMDRZg4vCPYfJhKDdp
	 0NRB9vszSjXnyU90WongfbS1z8RAw42k2CdTFHialKNAs0eMbC8ZnM8iYZWkEKEe5N
	 zUUGclAG4VI4+lRuWZnk/o7o+J03ayeX6h8Eu3GFndhAUOp8XvVpP4/ZBFyLI66+30
	 PM0C/S1FX2YWqPrDP8qYLWgFXpJWWKrvzrPhH8IhTiuo8NGSVI0hFhjEYT4iHnIKYd
	 5qLbH/MHwIffA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e1d61b657so4583121e87.0;
        Mon, 18 Dec 2023 14:27:10 -0800 (PST)
X-Gm-Message-State: AOJu0YyJFzGKthpB6UBBKpSOdQ9mod2hx3ZnFFEUn5JwY0Y6vNbkSeuq
	NP2OJLFxqqomm5ySdElPGwGstIAlofUgygvKJ5c=
X-Google-Smtp-Source: AGHT+IE5PD6bA3gdRugQvcpyePbVaEF0dHlVX9xB0hLKvzMTHvGRMVP+zf7v4xHZsx7TcAiHHWqhGA7ZfLplkmX0kz8=
X-Received: by 2002:a05:6512:3a5:b0:50e:3eeb:47e0 with SMTP id
 v5-20020a05651203a500b0050e3eeb47e0mr578082lfp.56.1702938429095; Mon, 18 Dec
 2023 14:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218080127.907460-1-masahiroy@kernel.org>
In-Reply-To: <20231218080127.907460-1-masahiroy@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 18 Dec 2023 23:26:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFmoXKLzFQnfTgatSpsQj=6HnExRoYtH_jaYakGZFwrkg@mail.gmail.com>
Message-ID: <CAMj1kXFmoXKLzFQnfTgatSpsQj=6HnExRoYtH_jaYakGZFwrkg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: zboot: do not use $(shell ...) in cmd_copy_and_pad
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 09:01, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> You do not need to use $(shell ...) in recipe lines, as they are already
> executed in a shell. An alternative solution is $$(...), which is an
> escaped sequence of the shell's command substituion, $(...).
>
> For this case, there is a reason to avoid $(shell ...).
>
> Kbuild detects command changes by using the if_changed macro, which
> compares the previous command recorded in .*.cmd with the current
> command from Makefile. If they differ, Kbuild re-runs the build rule.
>
> To diff the commands, Make must expand $(shell ...) first. It means that
> hexdump is executed every time, even when nothing needs rebuilding. If
> Kbuild determines that vmlinux.bin needs rebuilding, hexdump will be
> executed again to evaluate the 'cmd' macro, one more time to really
> build vmlinux.bin, and finally yet again to record the expanded command
> into .*.cmd.
>
> Replace $(shell ...) with $$(...) to avoid multiple, unnecessay shell
> evaluations. Since Make is agnostic about the shell code, $(...), the
> if_changed macro compares the string "$(hexdump -s16 -n4 ...)" verbatim,
> so hexdump is run only for building vmlinux.bin.
>
> For the same reason, $(shell ...) in EFI_ZBOOT_OBJCOPY_FLAGS should be
> eliminated.
>
> While I was here, I replaced '&&' with ';' because a command for
> if_changed is executed with 'set -e'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/arm64/boot/Makefile                    | 2 +-
>  drivers/firmware/efi/libstub/Makefile.zboot | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..a5a787371117 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -44,7 +44,7 @@ EFI_ZBOOT_BFD_TARGET  := elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE    := ARM64
>  EFI_ZBOOT_FORWARD_CFI  := $(CONFIG_ARM64_BTI_KERNEL)
>
> -EFI_ZBOOT_OBJCOPY_FLAGS        = --add-symbol zboot_code_size=0x$(shell \
> +EFI_ZBOOT_OBJCOPY_FLAGS        = --add-symbol zboot_code_size=0x$$( \
>                                 $(NM) vmlinux|grep _kernel_codesize|cut -d' ' -f1)
>
>  include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 2c489627a807..65ffd0b760b2 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -5,8 +5,8 @@
>  # EFI_ZBOOT_FORWARD_CFI
>
>  quiet_cmd_copy_and_pad = PAD     $@
> -      cmd_copy_and_pad = cp $< $@ && \
> -                        truncate -s $(shell hexdump -s16 -n4 -e '"%u"' $<) $@
> +      cmd_copy_and_pad = cp $< $@; \
> +                        truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@
>
>  # Pad the file to the size of the uncompressed image in memory, including BSS
>  $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
> --
> 2.40.1
>
>

