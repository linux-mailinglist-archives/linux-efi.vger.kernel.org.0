Return-Path: <linux-efi+bounces-3457-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE4A9B442
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81BF1BA5036
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5792857CF;
	Thu, 24 Apr 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB78RJvU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226627FD55;
	Thu, 24 Apr 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512675; cv=none; b=GdKWvUucr85nnvduyvBTq388UhwiAo2PXWh/+uWWcTV2v6piZxCPoGC83GvV7RZTD5ddShyuDl88jHnlW6khBF7IwV4E15rg2KPRcK8zH2v1rDuuY0JubexNjXbgsQTy3rbTey9RxWcTSmZYcqCo7qjrtNS5YZxxWxt3NzfhCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512675; c=relaxed/simple;
	bh=Z5Mejh+oE5Ke6erKkFueD4BD0r8tI1KZOEe1fs6TDZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMScsTibojqDcu8V1v2aJwzSxUoYpTZ2Yjf2C6sM06zW0ftSoy2KunbsbBaL8ywNPTUebXh62HzQASltKV1RMXUqi01gTo7oW+ZpI5XYjFkAqX8pHjzA0W5AxmmGn6YWDTxolx9d+kAmTFvonmHjT94/QaFqgDNwlIGTTH9ZRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB78RJvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93B0C4AF0B;
	Thu, 24 Apr 2025 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745512673;
	bh=Z5Mejh+oE5Ke6erKkFueD4BD0r8tI1KZOEe1fs6TDZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AB78RJvUAT+czyJewthUei0e/xLR+rnlqpcWxBpMQG+q73WLOE/UJsPX67ELkeA3m
	 IIEc3gntDS6ObyolLFWmbaY0GbFJRPRQlp72jx5f+227U8ChKwOPRX5oM/YegAnDVM
	 uemGsjIK73BSJK2h9IRYm8hrfILWdIHGOy4G8y9LW1dwqTp1d53AiAin6nPExgFrN6
	 TzSlppfh8Ig/k7Nj278lULiQ0qcTWc1w6EpK9DVdi+zDxfAr9JAybP+1Q4qN49yrKl
	 9p2WGmv+q6eDOEHILvTjoUhlwuZkqXYPxN1NwbF3WCzDpa+1p5KA/+qF18dC4IlGxL
	 y5bblvD3mWMZA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so1344646e87.0;
        Thu, 24 Apr 2025 09:37:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5FB2fTdZBwVgAyDkWj58uhehwBcuXsVmTcyvzds53ekIrOt3g9TngAwDyCpNCT89Xk3OjLAPxga54bV8n@vger.kernel.org, AJvYcCWi41PrY4P72Sr50ZJLRwSxdtC03hfww0DQjhqFPBfwzZ5LmHcqd5ps+9sC6a8GO+yAQJukN/2jSnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJ0w+UFisoQmJcr80bW3NDN71Jr9VK/Cz991I5TOMWFXBypNI
	+fZxSOYYi6KpkuT+OG4CMUQYiB5/Ye4BwocNHEhwpZStxJWyw9xR69xl50DINV45w80qV7eT4/G
	j6pHKmZWMTHhfRp8LSpN0/ID9J+Y=
X-Google-Smtp-Source: AGHT+IEeDmPYQCfPVgY5Ydme7GUd1G2XmW0StrBFinM9VM0MCOMuZoT/OILlCHPstOmP5SeFd3CRSQP5ANHTq4w5LiQ=
X-Received: by 2002:a05:6512:1107:b0:549:8db6:9366 with SMTP id
 2adb3069b0e04-54e7c3fcbf1mr1320656e87.28.1745512672053; Thu, 24 Apr 2025
 09:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-2-vkuznets@redhat.com>
In-Reply-To: <20250424080950.289864-2-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 24 Apr 2025 18:37:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqmOiNX_DH+8uSsTROzR+hgvZ5DyE=3wVE7-dQ+2BW=Q@mail.gmail.com>
X-Gm-Features: ATxdqUHhiPMKVw_j3AGCvu_wJ4JwfoyH2ecF1fk3MjUiBOsPPk_MmQ6HO-CIRLo
Message-ID: <CAMj1kXHqmOiNX_DH+8uSsTROzR+hgvZ5DyE=3wVE7-dQ+2BW=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: zboot specific mechanism for embedding
 SBAT section
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vitaly,

On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
> by introducing a generation-based technique. Compromised or vulnerable UEFI
> binaries can be prevented from booting by bumping the minimal required
> generation for the specific component in the bootloader. More information
> on the SBAT can be obtained here:
>
> https://github.com/rhboot/shim/blob/main/SBAT.md
>
> Upstream Linux kernel does not currently participate in any way in SBAT as
> there's no existing policy in how SBAT generation number should be
> defined. Keep the status quo and provide a mechanism for distro vendors and
> anyone else who signs their kernel for SecureBoot to include their own SBAT
> data. This leaves the decision on the policy to the vendor. Basically, each
> distro implementing SecureBoot today, will have an option to inject their
> own SBAT data during kernel build and before it gets signed by their
> SecureBoot CA. Different distro do not need to agree on the common SBAT
> component names or generation numbers as each distro ships its own 'shim'
> with their own 'vendor_cert'/'vendor_db'
>
> Implement support for embedding SBAT data for architectures using
> zboot (arm64, loongarch, riscv). Build '.sbat' section along with libstub
> so it can be reused by x86 implementation later.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/firmware/efi/Kconfig                | 25 +++++++++++++++++++++
>  drivers/firmware/efi/libstub/Makefile       |  7 ++++++
>  drivers/firmware/efi/libstub/Makefile.zboot |  3 ++-
>  drivers/firmware/efi/libstub/sbat.S         |  7 ++++++
>  drivers/firmware/efi/libstub/zboot-header.S | 14 ++++++++++++
>  drivers/firmware/efi/libstub/zboot.lds      | 17 ++++++++++++++
>  6 files changed, 72 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/libstub/sbat.S
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 5fe61b9ab5f9..2edb0167ba49 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -281,6 +281,31 @@ config EFI_EMBEDDED_FIRMWARE
>         bool
>         select CRYPTO_LIB_SHA256
>
> +config EFI_SBAT
> +       bool "Embed SBAT section in the kernel"
> +       depends on EFI_ZBOOT
> +       help
> +         SBAT section provides a way to improve SecureBoot revocations of UEFI
> +         binaries by introducing a generation-based mechanism. With SBAT, older
> +         UEFI binaries can be prevented from booting by bumping the minimal
> +         required generation for the specific component in the bootloader.
> +
> +         Note: SBAT information is distribution specific, i.e. the owner of the
> +         signing SecureBoot certificate must define the SBAT policy. Linux
> +         kernel upstream does not define SBAT components and their generations.
> +
> +         See https://github.com/rhboot/shim/blob/main/SBAT.md for the additional
> +         details.
> +
> +         If unsure, say N.
> +
> +config EFI_SBAT_FILE
> +       string "Embedded SBAT section file path"
> +       depends on EFI_SBAT
> +       help
> +         Specify a file with SBAT data which is going to be embedded as '.sbat'
> +         section into the kernel.
> +

Can we simplify this? CONFIG_EFI_SBAT makes no sense if
CONFIG_EFI_SBAT_FILE is left empty. If you really need both symbols,
set EFI_SBAT automatically based on whether EFI_SBAT_FILE is
non-empty.

>  endmenu
>
>  config UEFI_CPER
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d23a1b9fed75..5113cbdadf9a 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -105,6 +105,13 @@ lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
>  extra-y                                := $(lib-y)
>  lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
>
> +extra-$(CONFIG_EFI_SBAT)       += sbat.o
> +$(obj)/sbat.o: $(obj)/sbat.bin
> +targets += sbat.bin
> +filechk_sbat.bin = cat $(or $(real-prereqs), /dev/null)
> +$(obj)/sbat.bin: $(CONFIG_EFI_SBAT_FILE) FORCE
> +       $(call filechk,sbat.bin)
> +

Please get rid of all of this, and move the .incbin into zboot-header.S


>  # Even when -mbranch-protection=none is set, Clang will generate a
>  # .note.gnu.property for code-less object files (like lib/ctype.c),
>  # so work around this by explicitly removing the unwanted section.
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 48842b5c106b..3d2d0b326f7c 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -44,7 +44,8 @@ AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE
>  $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
>         $(call if_changed_rule,as_o_S)
>
> -ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
> +ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a \
> +          $(if $(CONFIG_EFI_SBAT),$(objtree)/drivers/firmware/efi/libstub/sbat.o)
>

Drop this too

>  LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
>  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
> diff --git a/drivers/firmware/efi/libstub/sbat.S b/drivers/firmware/efi/libstub/sbat.S
> new file mode 100644
> index 000000000000..4e99a1bac794
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/sbat.S
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Embed SBAT data in the kernel.
> + */
> +       .pushsection ".sbat","a",@progbits
> +       .incbin "drivers/firmware/efi/libstub/sbat.bin"
> +       .popsection
> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> index fb676ded47fa..f2df24504fc5 100644
> --- a/drivers/firmware/efi/libstub/zboot-header.S
> +++ b/drivers/firmware/efi/libstub/zboot-header.S
> @@ -135,6 +135,20 @@ __efistub_efi_zboot_header:
>                         IMAGE_SCN_MEM_READ | \
>                         IMAGE_SCN_MEM_WRITE
>
> +#ifdef CONFIG_EFI_SBAT
> +       .ascii          ".sbat\0\0\0"
> +       .long           __sbat_size
> +       .long           _edata - .Ldoshdr
> +       .long           __sbat_size
> +       .long           _edata - .Ldoshdr
> +
> +       .long           0, 0
> +       .short          0, 0
> +       .long           IMAGE_SCN_CNT_INITIALIZED_DATA | \
> +                       IMAGE_SCN_MEM_READ | \
> +                       IMAGE_SCN_MEM_DISCARDABLE

You can put the pushsection/popsection right here.

> +#endif
> +
>         .set            .Lsection_count, (. - .Lsection_table) / 40
>
>  #ifdef PE_DLL_CHAR_EX
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index 9ecc57ff5b45..2cd5015c70ce 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -31,10 +31,24 @@ SECTIONS
>
>         .data : ALIGN(4096) {
>                 *(.data* .init.data*)
> +#ifndef CONFIG_EFI_SBAT
>                 _edata = ALIGN(512);
> +#else
> +               /* Avoid gap between '.data' and '.sbat' */
> +               _edata = ALIGN(4096);
> +#endif

Just use 4096 in all cases.

>                 . = _edata;
>         }
>
> +#ifdef CONFIG_EFI_SBAT
> +        .sbat : ALIGN(4096) {
> +               _sbat = . ;
> +               *(.sbat)
> +               _esbat = ALIGN(512);
> +               . = _esbat;
> +       }
> +#endif
> +
>         .bss : {
>                 *(.bss* .init.bss*)
>                 _end = ALIGN(512);
> @@ -52,3 +66,6 @@ PROVIDE(__efistub__gzdata_size =
>
>  PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
>  PROVIDE(__data_size = ABSOLUTE(_end - _etext));
> +#ifdef CONFIG_EFI_SBAT
> +PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
> +#endif

This can be unconditional - it is only evaluated when a reference to it exists.

> --
> 2.49.0
>

