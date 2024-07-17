Return-Path: <linux-efi+bounces-1445-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E6933F9D
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60B01C23276
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA8181D05;
	Wed, 17 Jul 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6XEBn0u"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579F181D02;
	Wed, 17 Jul 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230022; cv=none; b=Vhd3DREvO6jDpUY1VGbFA4lQ18gUNJuKMd6xOOxO6uaQ6RIS3lJVO07FsjH2QE0st/6y7twW9GZ2rUnnMazOSJAxYntzf0SmGkD2j1pCNFq2b08RoYtCb1hTylU7dd3yOnlTgrOMBRKYgD4PtjzKuwc3BxZ3YjKEegfDkFRmoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230022; c=relaxed/simple;
	bh=+C1WqdzqEyp+5cvzBvXoqDFMy+58VskXnImzRjjk8G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+58WTI4MpwbiYpKH1Y8iMzez9Kruhjd7dUmt6o6uhQ+gba4c7+mgLYqxtMn8R4sKrZZzwTxX4beY4n6TTp7aKNHh2nya/QdMuV61xDeC1qCov1a93u9caUu6mljgsxYf7XBMg7rNsq2utaUVMjwY088oyRHjVRnx6t4tDkLSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6XEBn0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AF0C4AF10;
	Wed, 17 Jul 2024 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721230022;
	bh=+C1WqdzqEyp+5cvzBvXoqDFMy+58VskXnImzRjjk8G4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T6XEBn0u8UWgflow1yYSdgYZFnzl87ENJgRrubWsLTRJon4ZeHVYXGNuX4Pu+xp3q
	 aIxGCxwnQdccvkFe9fNJWp8QZ5zfRYh6QSewMKlVcPPszmEjHTFp1jNJrZ7xq4st1t
	 /MYOsqDOa5EtfOt9Ddud5vRAxrG3iytCCWgDhoLj/HetAwM2vZofXYpt/I5U/LY0Tz
	 0aDbQ2zmDCpJDU1DQ0L5ai+oyjE0qg+t6pReQ06NcDAvz3vwnETvVBk2aZRetGDbeg
	 BawxvXGz5eeuHE4nkYXY8xL0A7REZR1DbRXupXBrOPMDCQqvmsgyAcRe1Csp28J1tK
	 fDImRPN6KSvmw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb1051360so65765221fa.0;
        Wed, 17 Jul 2024 08:27:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIgxlrhQPmdQRHvQPufWWNHDgUK4vxAXESmSv/vKzryJ1YoN0SHp+m5B4jW/MxNEVuGBovXsVbWPuOp9V2t/S0PYH6pSJNf9A0aayb
X-Gm-Message-State: AOJu0YxsOf7pNEJZPNu30UHVe8lI3dC1LKxdrXAaKM+2+YXcACPa6rld
	Wq0eyt4jCLx3eJzIyGePVbG77/mcN6kVWoQqCdsp6sWB6bn0t+aG6BeV0rzjPXEXtnmwf5ly0aP
	6moPRzcGqqOc983LBFXMOnJ49Vfk=
X-Google-Smtp-Source: AGHT+IEAvIs1aLSqVsB6ohHBySq81qP2DHUe3cqa5OzKOxp2YdfO7yHjoC6CLUoe3z7bunOrC8DgYlDxlVmZuQ18HbM=
X-Received: by 2002:a2e:9782:0:b0:2ec:5685:f06b with SMTP id
 38308e7fff4ca-2eefd13d80amr13907391fa.27.1721230020323; Wed, 17 Jul 2024
 08:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
In-Reply-To: <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jul 2024 08:26:49 -0700
X-Gmail-Original-Message-ID: <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
Message-ID: <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
Subject: Re: [Patch] Do not clear BSS region in x86 stub
To: "Shao, Marshall" <Marshall.Shao@dell.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 08:17, Shao, Marshall <Marshall.Shao@dell.com> wrote:
>
> Clearing the BSS region may cause the UEFI firmware to malfunction
> during boot.
>
> When booting the kernel from an older firmware version that has TPM
> enabled and the MemoryOverwriteRequestControl bit set to 1, the
> firmware's boot service might encounter an exception if it attempts
> to initialize the BSS region within the x86 stub.
>
> To circumvent the firmware exception, it is advisable to enlarge the
> BOOT_STACK_SIZE and to perform the initialization of static variables
> prior to the decompression of the bzImage.
>

What does 'advisable' mean? This patch looks like a few hacks thrown
together that happen to work around some issue in combination.

Please explain what the exact problem is, and how this patch fixes it.

If you don't know what the exact problem is, please say so.


> Signed-off-by: Marshall Shao <marshall.shao@dell.com>
> ---
>  arch/x86/boot/compressed/misc.c         | 8 +++-----
>  arch/x86/include/asm/boot.h             | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 5 -----
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b70e4a21c15f..bac5a3c55c2c 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -356,11 +356,9 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
>                                 void (*error)(char *x))
>  {
>         unsigned long entry;
> -
> -       if (!free_mem_ptr) {
> -               free_mem_ptr     = (unsigned long)boot_heap;
> -               free_mem_end_ptr = (unsigned long)boot_heap + sizeof(boot_heap);
> -       }
> +       free_mem_ptr     = (unsigned long)boot_heap;
> +       free_mem_end_ptr = (unsigned long)boot_heap + sizeof(boot_heap);
> +       malloc_ptr = free_mem_ptr;
>

This is not safe. This reinitializes the heap after allocations have
been made already.

It would be better to annotate free_mem_ptr as __section(".data") to
ensure that it is zeroed even if BSS is not cleared.

>         if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
>                          NULL, error) < 0)
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index 3e5b111e619d..312bc87ab027 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -33,7 +33,7 @@
>  #endif
>
>  #ifdef CONFIG_X86_64
> -# define BOOT_STACK_SIZE       0x4000
> +# define BOOT_STACK_SIZE       0x10000
>

Why is this necessary? EFI boot does not use this stack, only legacy
boot via the decompressor.


>  /*
>   * Used by decompressor's startup_32() to allocate page tables for identity
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1983fd3bf392..d92d2ccc709b 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -21,7 +21,6 @@
>  #include "efistub.h"
>  #include "x86-stub.h"
>
> -extern char _bss[], _ebss[];
>
>  const efi_system_table_t *efi_system_table;
>  const efi_dxe_services_table_t *efi_dxe_table;
> @@ -476,9 +475,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         efi_status_t status;
>         char *cmdline_ptr;
>
> -       if (efi_is_native())
> -               memset(_bss, 0, _ebss - _bss);
> -

This bit has already been removed in mainline.

>         efi_system_table = sys_table_arg;
>
>         /* Check if we were booted by the EFI firmware */
> @@ -1000,7 +996,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>  void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
>                         struct boot_params *boot_params)
>  {
> -       memset(_bss, 0, _ebss - _bss);

Removing this is not safe. free_mem_ptr is not the only global
variable in BSS that needs to be zeroed, there are others too.

>         efi_stub_entry(handle, sys_table_arg, boot_params);
>  }
>
> --
> 2.34.1
>

