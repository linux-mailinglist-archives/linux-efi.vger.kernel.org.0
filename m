Return-Path: <linux-efi+bounces-480-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6E849D5A
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C639287E3D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E662C1A3;
	Mon,  5 Feb 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC8Mjy6y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F12C19F
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144582; cv=none; b=CwuS67CXcp3hMvXC3rwt7ZNG/bDlI3bBGCtmVIgtmnpWersF0ubpSaq0fYIQx0HEPYScyHlQIu3lSzTKx5DgVMT3VmBhdkNZNvCSP7Ay/eXoR9nh9pYoH07YB+6kheQ2mNVOblVq/x23eOfd6mcENHWUaSE47g2e34WzxSp8Oqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144582; c=relaxed/simple;
	bh=INpbiAnUW/tBdtxD2Y21kMqeUCVZ8i323xrSot9n0WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR0I2V/RCSfdLM1jq4se+gJd1+Qkw7gfdTcaHH+Bgg4d3a4K9o62sSsBF2bNsJj0Qbo3ERvQmrs3yASzDaF9LNC9TOSAJCRLHWoii7ozgc2tcTxLwUi6McKAQnTn++jITi7Hq2Lgl0XjLpJCqu0fHsMHmQDwGkzL/LgTIed8eWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC8Mjy6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307A6C433F1
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707144582;
	bh=INpbiAnUW/tBdtxD2Y21kMqeUCVZ8i323xrSot9n0WY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UC8Mjy6yLPjPzSGoLMlbV5zirq0y2bONkcFvmDl8NR1Ra3Hq7KPlQvx0mVkGG2IZH
	 fAhsISEgqcfbvWPJiF9uHaMWglD3Ac6hVrqhVMLiO6YbYFhyEbNmbCY2EFxV1W3vbY
	 4YB1scxa2VlFK3sc7CjWL5kIq8BMqc5eDmVOhAbPanZfKiwNFMMdPp9tDs0oLVIqz6
	 3PMHQampKCJMYQURAnsCEF8zeI5gdGxFmv3Zg9Zq2XtI7JqdQAS7IfoCopOFpTa7yo
	 Mu18pnqg8+1oQ5VtPiwCeIikhZGxcSQaBSqQEz7Npb/a5FOWK2oVe5nNWFe239ZLQQ
	 wthHMquJced2g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5113303e664so4669326e87.0
        for <linux-efi@vger.kernel.org>; Mon, 05 Feb 2024 06:49:42 -0800 (PST)
X-Gm-Message-State: AOJu0YyhP+iVnMZcmZj7R2GlYJFtobAdG+5lYRLlj1Nhq6E787isQsQC
	xtDBI9tq7mLpgoMrYsgWkhHPCZ+5YoyT7L14/a052AbJGkpt1hctepdD+0l9jUGJ53QL4ga220A
	yWptwxXWPmvkGRgFuoVDZqAe/i8s=
X-Google-Smtp-Source: AGHT+IFx7Cn6XV1bWFcq06ibwrsLmY2kVBZLdi8zXALTINGz0IAdM8wLt/hU3SM/y1oQ5O4Whi0wZbbPYAhwjYz+o5E=
X-Received: by 2002:a05:6512:1153:b0:511:53fa:b971 with SMTP id
 m19-20020a056512115300b0051153fab971mr1528896lfg.9.1707144580372; Mon, 05 Feb
 2024 06:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707141974.git.baskov@ispras.ru> <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
In-Reply-To: <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 Feb 2024 14:49:28 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com>
Message-ID: <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot: Order sections by their RVAs
To: Evgeniy Baskov <baskov@ispras.ru>
Cc: Mike Beaton <mjsbeaton@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 14:44, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Image loaders which check the contiguity of executable images consider
> sections adjacent in the section table to be adjacent in virtual memory.
>
> Sort sections by their RVAs in PE section table.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/header.S | 56 +++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>

Hi,

I just sent a fix for this issue:

https://lore.kernel.org/linux-efi/20240205081106.2415414-2-ardb+git@google.com/T/#u

Could you please check whether it works for you as well?


> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index b2771710ed98..097b84ab288c 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -153,6 +153,34 @@ section_table:
>                 IMAGE_SCN_MEM_READ              | \
>                 IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
>
> +       .ascii  ".text"
> +       .byte   0
> +       .byte   0
> +       .byte   0
> +       .long   ZO__data
> +       .long   setup_size
> +       .long   ZO__data                        # Size of initialized data
> +                                               # on disk
> +       .long   setup_size
> +       .long   0                               # PointerToRelocations
> +       .long   0                               # PointerToLineNumbers
> +       .word   0                               # NumberOfRelocations
> +       .word   0                               # NumberOfLineNumbers
> +       .long   IMAGE_SCN_CNT_CODE              | \
> +               IMAGE_SCN_MEM_READ              | \
> +               IMAGE_SCN_MEM_EXECUTE           # Characteristics
> +
> +       .ascii  ".data\0\0\0"
> +       .long   ZO__end - ZO__data              # VirtualSize
> +       .long   setup_size + ZO__data           # VirtualAddress
> +       .long   ZO__edata - ZO__data            # SizeOfRawData
> +       .long   setup_size + ZO__data           # PointerToRawData
> +
> +       .long   0, 0, 0
> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> +               IMAGE_SCN_MEM_READ              | \
> +               IMAGE_SCN_MEM_WRITE             # Characteristics
> +
>  #ifdef CONFIG_EFI_MIXED
>         .asciz  ".compat"
>
> @@ -185,34 +213,6 @@ pecompat_fstart:
>         .set    pecompat_vsize, 0
>         .set    pecompat_fstart, setup_size
>  #endif
> -       .ascii  ".text"
> -       .byte   0
> -       .byte   0
> -       .byte   0
> -       .long   ZO__data
> -       .long   setup_size
> -       .long   ZO__data                        # Size of initialized data
> -                                               # on disk
> -       .long   setup_size
> -       .long   0                               # PointerToRelocations
> -       .long   0                               # PointerToLineNumbers
> -       .word   0                               # NumberOfRelocations
> -       .word   0                               # NumberOfLineNumbers
> -       .long   IMAGE_SCN_CNT_CODE              | \
> -               IMAGE_SCN_MEM_READ              | \
> -               IMAGE_SCN_MEM_EXECUTE           # Characteristics
> -
> -       .ascii  ".data\0\0\0"
> -       .long   ZO__end - ZO__data              # VirtualSize
> -       .long   setup_size + ZO__data           # VirtualAddress
> -       .long   ZO__edata - ZO__data            # SizeOfRawData
> -       .long   setup_size + ZO__data           # PointerToRawData
> -
> -       .long   0, 0, 0
> -       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> -               IMAGE_SCN_MEM_READ              | \
> -               IMAGE_SCN_MEM_WRITE             # Characteristics
> -
>         .set    section_count, (. - section_table) / 40
>  #endif /* CONFIG_EFI_STUB */
>
> --
> 2.43.0
>

