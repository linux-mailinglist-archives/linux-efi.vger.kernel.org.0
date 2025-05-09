Return-Path: <linux-efi+bounces-3648-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E4AB0EB3
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8F81B6489A
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C527A917;
	Fri,  9 May 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOaX9KxJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E627A137;
	Fri,  9 May 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782218; cv=none; b=aoIiA0jTaKB9wvzB8k3RwV3m7ioCZqWax0azvKd71f2aVB2LpZEG47iAgmHXKVqpp8KC0NOJrMr+qu3KYbhG3Cez6JcE+GSC4vz2rx5Jb8SmuoG+0fjuzOIQUdcEhqYia+BEPIcUfMrRiH64kpPB+ZMWVGuGWBvMylJgI/9KCvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782218; c=relaxed/simple;
	bh=x+d130iQ4OisBQ1RwPsHMzQrkjOFTBbyg4UmChoAzGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGIK4pXoQkQFSvXfcBOBoNVDdNtu9qJ20lxtZe9+CtGHZnU5hi8Kt7B+5VBNhAqwOz5uL5z0M4lhv1A5ZUGSYmyO424gfnJJrzrQbRJhH6u8kn2uDycuZ0hAw4iKOl8K6oj3tIkQf7OS9AZyyHXks4YF9qwSiWHLysF76d0456E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOaX9KxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E750C4AF0D;
	Fri,  9 May 2025 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746782217;
	bh=x+d130iQ4OisBQ1RwPsHMzQrkjOFTBbyg4UmChoAzGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BOaX9KxJUz8CzmtKc8p70TeZxOwMMeIU4P3Qtnex8TyDKK4VYg9IguIg1nbe6u4Cz
	 wejSp+/rUd3iHSV5P56w6VddU5fFt2ptNTSXNpmxHA+Ann9HmYECkHdCgo1rNjs8U3
	 LENz92T5AZFm83CWRB5QPTzB2ZJM8pF91OoSVGXASMjhwgJ3bJH+qgBMYKq6qn1dJw
	 tRdM03mLNDqEIfK3m8WLnRrefrtJIqW3xNUQAMfoCCUx5d6qaAzUWonrVBH+KglHXH
	 ARooMbo+YLL3oiMr4HECY+y+3dZOyLLu0/7Zmc3bQEWvRUdkBVRveB7lvSbPzIpc+B
	 WnYoYqTtBKKyg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54e9021d2b5so3742171e87.1;
        Fri, 09 May 2025 02:16:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy0Bm+jbZWF+WnpSb20oSWXIOl1S+UDiAVzoKXU3j+09m3RFg9RBqnnJVUQ55ra9p6xh8vBFjDbl8=@vger.kernel.org, AJvYcCV/ooNleSruqUJvU+MHE8sFzUjXpybXFwYc6r01DH78jHce2lYVPw6mRW/CIDblvlnIE4ad6vWh1zAdDePT@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPVVRM7ohPsSFUNj+2HGnNR9/PBICQn6leb0aV2/QC3zu17A2
	AO0fnrsE3ovAs0SS773DNMfs7oXH8VGg4B3McvgJPwodtujAJgmQ48CRz/FFeUqpfexcHJHw4Na
	gkQgfHoGWOy/ivW9RphnHFjv7MxE=
X-Google-Smtp-Source: AGHT+IHkBaVzoQTAsYshsXOwRceKOTjqdoPFSB4Nen3iA8jPmif43We1NbgcTURYcEcll6NAIemTE7E1kMosjzoprD8=
X-Received: by 2002:a05:6512:6613:b0:549:7145:5d2d with SMTP id
 2adb3069b0e04-54fc6769fc3mr707169e87.16.1746782215612; Fri, 09 May 2025
 02:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505154523.231233-1-vkuznets@redhat.com> <20250505154523.231233-2-vkuznets@redhat.com>
In-Reply-To: <20250505154523.231233-2-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 May 2025 11:16:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHSW1=k59J9vOQULw2A_htLiKYc0h9zQ12xYqmutja+eg@mail.gmail.com>
X-Gm-Features: ATxdqUHIWMlwRPxGAvRlP1N6SGtiAq6FedBV8uC9y8j_U6nYAhSL-_feheWMgt8
Message-ID: <CAMj1kXHSW1=k59J9vOQULw2A_htLiKYc0h9zQ12xYqmutja+eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi: zboot specific mechanism for embedding SBAT section
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

On Mon, 5 May 2025 at 17:45, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
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
> zboot (arm64, loongarch, riscv). Put '.sbat' section in between '.data' and
> '.text' as the former also covers '.bss' and thus must be the last one.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/Kconfig                | 24 +++++++++++++++++++++
>  drivers/firmware/efi/libstub/Makefile.zboot |  4 ++++
>  drivers/firmware/efi/libstub/zboot-header.S | 22 +++++++++++++++++--
>  drivers/firmware/efi/libstub/zboot.lds      | 11 ++++++++++
>  4 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 5fe61b9ab5f9..db8c5c03d3a2 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -281,6 +281,30 @@ config EFI_EMBEDDED_FIRMWARE
>         bool
>         select CRYPTO_LIB_SHA256
>
> +config EFI_SBAT
> +       def_bool y if EFI_SBAT_FILE!=""
> +
> +config EFI_SBAT_FILE
> +       string "Embedded SBAT section file path"
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
> +         Specify a file with SBAT data which is going to be embedded as '.sbat'
> +         section into the kernel.
> +
> +         If unsure, leave blank.
> +
>  endmenu
>
>  config UEFI_CPER
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 48842b5c106b..92e3c73502ba 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -44,6 +44,10 @@ AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE
>  $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
>         $(call if_changed_rule,as_o_S)
>
> +ifneq ($(CONFIG_EFI_SBAT_FILE),)
> +$(obj)/zboot-header.o: $(CONFIG_EFI_SBAT_FILE)
> +endif
> +
>  ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
>
>  LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> index fb676ded47fa..e02247458b65 100644
> --- a/drivers/firmware/efi/libstub/zboot-header.S
> +++ b/drivers/firmware/efi/libstub/zboot-header.S
> @@ -123,11 +123,29 @@ __efistub_efi_zboot_header:
>                         IMAGE_SCN_MEM_READ | \
>                         IMAGE_SCN_MEM_EXECUTE
>
> +#ifdef CONFIG_EFI_SBAT
> +       .ascii          ".sbat\0\0\0"
> +       .long           __sbat_size
> +       .long           _sbat - .Ldoshdr
> +       .long           __sbat_size
> +       .long           _sbat - .Ldoshdr
> +
> +       .long           0, 0
> +       .short          0, 0
> +       .long           IMAGE_SCN_CNT_INITIALIZED_DATA | \
> +                       IMAGE_SCN_MEM_READ | \
> +                       IMAGE_SCN_MEM_DISCARDABLE
> +
> +       .pushsection ".sbat", "a", @progbits
> +       .incbin CONFIG_EFI_SBAT_FILE
> +       .popsection
> +#endif
> +
>         .ascii          ".data\0\0\0"
>         .long           __data_size
> -       .long           _etext - .Ldoshdr
> +       .long           _data - .Ldoshdr
>         .long           __data_rawsize
> -       .long           _etext - .Ldoshdr
> +       .long           _data - .Ldoshdr
>
>         .long           0, 0
>         .short          0, 0
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index 9ecc57ff5b45..c3a166675450 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -29,7 +29,17 @@ SECTIONS
>                 . = _etext;
>         }
>
> +#ifdef CONFIG_EFI_SBAT
> +        .sbat : ALIGN(4096) {
> +               _sbat = .;
> +               *(.sbat)
> +               _esbat = ALIGN(4096);
> +               . = _esbat;
> +       }
> +#endif
> +
>         .data : ALIGN(4096) {
> +               _data = .;
>                 *(.data* .init.data*)
>                 _edata = ALIGN(512);
>                 . = _edata;
> @@ -52,3 +62,4 @@ PROVIDE(__efistub__gzdata_size =
>
>  PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
>  PROVIDE(__data_size = ABSOLUTE(_end - _etext));
> +PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
> --
> 2.49.0
>

