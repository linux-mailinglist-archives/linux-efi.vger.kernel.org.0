Return-Path: <linux-efi+bounces-431-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A5D83C3E7
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jan 2024 14:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC9287E75
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jan 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA555E40;
	Thu, 25 Jan 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5VlD/dC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14055C12
	for <linux-efi@vger.kernel.org>; Thu, 25 Jan 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190162; cv=none; b=SG4GwPoMZGItyJWE/r+zJxkpl6+qeR8p15CN4BbMeOd5syMrAr1dE1KWU6qdUAdsOo2zueFZ/1Qbj4/159ZqmKz1toRwaXc2/GsXRo73XYD6Ape80n0rJURYKn7LuRVaR6zTa1fuiuZqU3fjLm1FmVW4zbYRNIf1ZfC4HW7yPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190162; c=relaxed/simple;
	bh=1Fa4nYgqKlt0nGuSRb8Zyy8ey0V1vm0P85HE0y6dksQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRXmtm1tbLv+WFdaoAIolwIgW/mtcFoLOtIViI0QkJSLiMdjIqwWuDpSiheAUY5dFpQUK8izDwioCJ6QJpgN430lFJAqlTRVM8WcZKtx9zR2/Cf/9WBbE1LQAnvdty8wudcjVal8J19bq5ZdJPSkt+HOYhTdtlr2IozgBwdVwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5VlD/dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE4C433F1
	for <linux-efi@vger.kernel.org>; Thu, 25 Jan 2024 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706190162;
	bh=1Fa4nYgqKlt0nGuSRb8Zyy8ey0V1vm0P85HE0y6dksQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g5VlD/dCagO2eJ24etsA6jMauhqWtLIBe31fwkIPXaASRa/pU3Ah6Rnag1jwe/Qzb
	 Ls5dzxs4CBmnhqNn6upfjw0AQrgHgRjLmMwFt7is7kgQWn/9pi3kjkaTfuN2WGYVVr
	 blpyJCNym61iNZDNSQ/MfvsdxR08pqV3bCY65pg758pziv9dVPhpAQ5ObsAtPPKvPU
	 n7gaDRDzPTZyxKDO2riWw5fUMBMdFUamG+Cn6r9Cvdh8i/20FiY9HmZIQaYObvDnE8
	 26pzIYmVpaf0YIvsRD9U5vwi6wffvdCud02Sbq6p0Y/KhKZ1Ul2kgncAt6eEk4rELO
	 AqAl7aLxDQfKA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf1c275e95so25412091fa.1
        for <linux-efi@vger.kernel.org>; Thu, 25 Jan 2024 05:42:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8Ou+kz5d/E3u7L1v5Aikhn/t/z4v7o22gCmA3PAxS65vHC6of
	lq8dsEscBpL1CCdqD2oRmaM4M6/cXr/FARI6gfxW+QwgXObKmhLjaSFGIBFSnTcMQqRYvMYPFDL
	6ysw+VkaMsO/HKf8Ial8DyJXHTf0=
X-Google-Smtp-Source: AGHT+IFl1mjYt6W6D5TFcEys7wnSKhplxbCAGiDoq+Qqblv2VrQUXypuuwgWYQPOt2UEpryQVzcuO7uH/qQHMWInEg0=
X-Received: by 2002:a2e:95d9:0:b0:2cc:57a7:9076 with SMTP id
 y25-20020a2e95d9000000b002cc57a79076mr534081ljh.65.1706190160458; Thu, 25 Jan
 2024 05:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125134058.2076660-2-ardb+git@google.com>
In-Reply-To: <20240125134058.2076660-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jan 2024 14:42:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEoLOshENQO=RjQRq48DTdMyrC98eejj8KUxwGZSHWW8Q@mail.gmail.com>
Message-ID: <CAMj1kXEoLOshENQO=RjQRq48DTdMyrC98eejj8KUxwGZSHWW8Q@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Remap kernel code read-only before dropping NX attribute
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, pjones@redhat.com, jan.setjeeilers@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 14:41, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Currently, the EFI stub strips the NX restriction from the entire loaded
> kernel. It would be better to only apply this change to the part of the
> kernel that will actually execute from the firmware's 1:1 mapping of
> memory, and make this region read-only first, rather than relying on
> memory with RWX mappings before calling ExitBootServices().
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Note that this patch relies on some non-trivial rework of the early 1:1
> init code, which was necessary for unrelated reasons.
>
> https://lkml.kernel.org/r/20240125112818.2016733-19-ardb%2Bgit%40google.com
>

Forgot to mention: tested with Mu's OVMF build, which implements the
EFI memory attribute protocol (and happily permits RWX mappings btw)


https://github.com/microsoft/mu_tiano_platforms/releases



>  arch/x86/boot/compressed/Makefile       | 2 +-
>  arch/x86/boot/compressed/misc.c         | 1 +
>  arch/x86/include/asm/boot.h             | 1 +
>  drivers/firmware/efi/libstub/x86-stub.c | 4 +++-
>  4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index bccee07eae60..75c0b0be9685 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -84,7 +84,7 @@ LDFLAGS_vmlinux += -T
>  hostprogs      := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>
> -sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
> +sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRrSTtVW] \(_text\|__end_rodata_aligned\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
>
>  quiet_cmd_voffset = VOFFSET $@
>        cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b99e08e6815b..71c8415ee62e 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -330,6 +330,7 @@ static size_t parse_elf(void *output)
>         return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
>  }
>
> +const unsigned long kernel_ro_size = VO___end_rodata_aligned - VO__text;
>  const unsigned long kernel_total_size = VO__end - VO__text;
>
>  static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index a38cc0afc90a..852adf628067 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -81,6 +81,7 @@
>
>  #ifndef __ASSEMBLY__
>  extern unsigned int output_len;
> +extern const unsigned long kernel_ro_size;
>  extern const unsigned long kernel_total_size;
>
>  unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 0d510c9a06a4..cd05081301c7 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -236,6 +236,8 @@ void efi_adjust_memory_range_protection(unsigned long start,
>         rounded_end = roundup(start + size, EFI_PAGE_SIZE);
>
>         if (memattr != NULL) {
> +               efi_call_proto(memattr, set_memory_attributes, rounded_start,
> +                              rounded_end - rounded_start, EFI_MEMORY_RO);
>                 efi_call_proto(memattr, clear_memory_attributes, rounded_start,
>                                rounded_end - rounded_start, EFI_MEMORY_XP);
>                 return;
> @@ -805,7 +807,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>
>         *kernel_entry = addr + entry;
>
> -       efi_adjust_memory_range_protection(addr, kernel_total_size);
> +       efi_adjust_memory_range_protection(addr, kernel_ro_size);
>
>         return EFI_SUCCESS;
>  }
> --
> 2.43.0.429.g432eaa2c6b-goog
>

