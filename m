Return-Path: <linux-efi+bounces-4947-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B18B9D38D
	for <lists+linux-efi@lfdr.de>; Thu, 25 Sep 2025 04:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4564A349F
	for <lists+linux-efi@lfdr.de>; Thu, 25 Sep 2025 02:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E482E541E;
	Thu, 25 Sep 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J58/SCUf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B552E0926
	for <linux-efi@vger.kernel.org>; Thu, 25 Sep 2025 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768240; cv=none; b=LSMhdZDQJcM84Hc/86gke6q27u1xanhYND1gTB/GyA7h4tLYeHIdP+0Ul8s+WArBXGdXZXM2nGRYxqYGxQLtqj6eV6t/Pa73HS1quzZqidHQ+1t/vCFhXoVlTROoWTMiRsnSFoBeZWmDBc0K9ZmOs95BRQtANTk5tgw4ltHqH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768240; c=relaxed/simple;
	bh=S7vb/zf3V2GaassUXCT9UJV1Et/9TJiqD8ubx2PkhwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmXbci2yKoIDzCqQND0TG1aiCN9M9fQrRMkEo7GtXY7HHtCjnUVL4ASYex6595rm2ozjCelWq9Y7Gui+8pTAJyedRyu6tkVY2Y3yhbAUp/s0qWSmq3TKUFZujpaac7+XT2hPrz9/DS1ddL5HW34ZinBsEzFStTVSN9DOgWNcMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J58/SCUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86401C4AF0B
	for <linux-efi@vger.kernel.org>; Thu, 25 Sep 2025 02:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758768240;
	bh=S7vb/zf3V2GaassUXCT9UJV1Et/9TJiqD8ubx2PkhwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J58/SCUfWipwZ1MVIpQEBYOUxqgqodgM0cUqxO+6oYTnwX30OAYYFnF0WKJxi5SU3
	 1YOU1P/IZqOtiBNDhKnXN1z4ovoCMhsotskp189F0RKKNay05fweIgyzg2e3gFkOa+
	 mrEzWgOqJIw9XZ1B1L1AdSJy3OwrymPL9j/QShB/+lcZEezrx+noPCD585qWFJNKzN
	 6E6HdZZvyCsVBaO63lJCmSambbsyS5Xwl45MRs1Bl9W47XafA1DEa4nLWflPswoZ74
	 CUlx92J4FcsuHOfMtemFUEOhpKfKnlSdBytdl9IRLQmzaeKqeOP4mbfyhOZCLS3Mji
	 uaOs9TbYVJNTg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2e66a2fb63so79843366b.2
        for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 19:44:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+PVm3QPbQW4ZCqSCEXAhTcuRllnja7WUHdWibvSpl1UrjvJiLE6cFTHNPf/fzkoPl+n4TvFb5PWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWwt9WyGbMs9h1WKKBN28us+hfvwmzUo4q478CcLa1SEiaO9G
	wWtRQ0c6/xG6956V+IvY2t1MttAHJlwYLjco3Sua8t6ykuv5OEBGvI0YxHIJDSAwQ0OJw80Cw4C
	8hI41hz7bJLj+BWZ29W/u4Jyru3eEcIk=
X-Google-Smtp-Source: AGHT+IFAKAis+f8CsaeB/ZYEn6Mbsm0qvkYWWb/1JIaJw+bN7o9FCGRKh+44tCSaadZ6c4rMcagZJ6G9mHVPClZ1tck=
X-Received: by 2002:a17:907:3f1e:b0:b11:c9df:7a73 with SMTP id
 a640c23a62f3a-b34bd34a2b0mr217761266b.57.1758768239043; Wed, 24 Sep 2025
 19:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919093615.30235-1-yangtiezhu@loongson.cn> <20250919093615.30235-2-yangtiezhu@loongson.cn>
In-Reply-To: <20250919093615.30235-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 25 Sep 2025 10:43:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4fdfB3fH0DnfgxNimPBsjiOGQZV-w0g63d7TVDOK5-zw@mail.gmail.com>
X-Gm-Features: AS18NWDZZeQr-H2-K3eeVtlqTGrlSQzrQ7P8GUhNaKX_KK-BVvdywIo1Js7nnoc
Message-ID: <CAAhV-H4fdfB3fH0DnfgxNimPBsjiOGQZV-w0g63d7TVDOK5-zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] LoongArch: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Fri, Sep 19, 2025 at 5:36=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> the following objtool warning:
>
>   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>   falls through to next function __efistub_exit_boot_func()
>
> This is because efi_boot_kernel() doesn't end with a return instruction
> or an unconditional jump, then objtool has determined that the function
> can fall through into the next function.
>
> At the beginning, try to do something to make efi_boot_kernel() ends with
> an unconditional jump instruction, but this modification seems not proper=
.
>
> Since the efistub functions are useless for stack unwinder, they can be
> ignored by objtool. After many discussions, no need to link libstub to
> the vmlinux.o, only link libstub to the final vmlinux.
>
> Link: https://lore.kernel.org/lkml/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5=
rcxzxxanzetd@6rrlpjnjsmuy/
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Makefile                | 1 +
>  arch/loongarch/Makefile | 5 ++++-
>  scripts/link-vmlinux.sh | 5 ++---
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9771619ac596..b8e7c63ae3d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1201,6 +1201,7 @@ KBUILD_VMLINUX_OBJS :=3D built-in.a $(patsubst %/, =
%/lib.a, $(filter %/, $(libs-y)
>  KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
>
>  export KBUILD_VMLINUX_LIBS
> +export KBUILD_VMLINUX_LIBS_PRELINK
>  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
>
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
Why does the LoongArch patch modify the common parts? Since the whole
series is small enough, I suggest modifying everything in a single
patch. And the single patch can be merged via the efi tree.

Huacai

> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a3a9759414f4..e9c61f76a045 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -164,7 +164,10 @@ CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(K=
BUILD_CFLAGS) -dM -E -x c /dev
>  endif
>
>  libs-y +=3D arch/loongarch/lib/
> -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
.a
> +
> +ifdef CONFIG_EFI_STUB
> +KBUILD_VMLINUX_LIBS_PRELINK +=3D $(objtree)/drivers/firmware/efi/libstub=
/lib.a
> +endif
>
>  drivers-y              +=3D arch/loongarch/crypto/
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 51367c2bfc21..b3cbff31d8a9 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -61,12 +61,11 @@ vmlinux_link()
>         shift
>
>         if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IB=
T; then
> -               # Use vmlinux.o instead of performing the slow LTO link a=
gain.
>                 objs=3Dvmlinux.o
> -               libs=3D
> +               libs=3D"${KBUILD_VMLINUX_LIBS_PRELINK}"
>         else
>                 objs=3Dvmlinux.a
> -               libs=3D"${KBUILD_VMLINUX_LIBS}"
> +               libs=3D"${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PREL=
INK}"
>         fi
>
>         if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
> --
> 2.42.0
>

