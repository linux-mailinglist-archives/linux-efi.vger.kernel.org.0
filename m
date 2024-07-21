Return-Path: <linux-efi+bounces-1472-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664F9384B2
	for <lists+linux-efi@lfdr.de>; Sun, 21 Jul 2024 15:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8559280EB9
	for <lists+linux-efi@lfdr.de>; Sun, 21 Jul 2024 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DFA15FD15;
	Sun, 21 Jul 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmTJIvyO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA48F58;
	Sun, 21 Jul 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721568400; cv=none; b=K8XZ/9k4/lvTJTZ2VckoH5wRhu7hZt/+ofKtAwZgzBo20Y3c//GUjZVJEVvqK9T+jy88+LsrH1rN9lplgBXooEtEwIT6CBBAcQPFgrjfgtA3BRKyg8mPNb7evzBHw3seJK8mji+t2kwRMCD9X9+7ZXqBcGqO5TMxxKFqhfY5+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721568400; c=relaxed/simple;
	bh=QJzbwuryGyyBsNVOMDgRXv6W5GwkjbWvJhLSlNCYCT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGwm39xmGXfkKiuDqDGymiu4DH8ZHN2zdlIsnBoANGOp1d4sdGTAGWAlA8KLyzqoN8J55A2eoz1zH94ADq27saoiHf8P3iUzhMqvGDvMcxof+PzxIO8AScoBlIVyoMiMVLlwF5co+OM+HmaVL0GX2TNdhRq+/S5yc7cLNPmdnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmTJIvyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0031DC4AF0F;
	Sun, 21 Jul 2024 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721568400;
	bh=QJzbwuryGyyBsNVOMDgRXv6W5GwkjbWvJhLSlNCYCT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JmTJIvyO1CoAwx+CxTRqmTN/PCFxY7KabzZqnoOrEW0bbp1qRgp9eT/HaYGKv4fFg
	 Uq/J52emIcIZBvnwM00tqQouak7arHw4RXyxJgJKQQVWT8DMcs4XsVzOryb9TIYllo
	 GRF6aAL1w3mV4eLMf8hkSqJE9zLrSN9MA2LgGopf1ft4okP66EwsjQwBJKPOv2OhGR
	 8OdpzDkGos4Ji+qAAJU9s+OTvSV5v1q2LEr5CKN2BjRp4Ml1lO4BoVHctJLcK4UFlR
	 e6N1TYMojcpWDeXcPz2Rh63JgxDP0Q2Gv3NBWJbCg3h8Ab59X0i0yQ7Tozwh0/DoRD
	 925Zvfu06qnkw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so6472041fa.0;
        Sun, 21 Jul 2024 06:26:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq7i8e14WEBa7ytbWohpe+1jcbT6iFcc5m3QXEz4eq34vayneX/rgP9SCFFDOpgsFmxAn0hMAW4hdKBQNfnqefTBE3JyE8NdqzNgxX
X-Gm-Message-State: AOJu0YxGm/XM89nIIfLwOBmEFkR35xnwnHult7jYFzGe91LrCdamS3kp
	gq0ZEZ95niWAKRmf+zJnU8gb+gr3NMVb6rhpPGq5UEO74g33wsSfAi5fWq2ndTWClPnabHts94j
	7rjedMm0VrAPoCCDNcSIhdD3m4Ow=
X-Google-Smtp-Source: AGHT+IGUEXIkOXd6zMlXfW607ZOVj3rma8Y1IuG8d8DCTXG6wnkMRUeqRLeIrA0f8KNhPinf28ntpjLaxQLuHUji46w=
X-Received: by 2002:a2e:a7c7:0:b0:2ef:2f8a:52d5 with SMTP id
 38308e7fff4ca-2ef2f8a55b4mr1234791fa.8.1721568398213; Sun, 21 Jul 2024
 06:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com> <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
In-Reply-To: <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 21 Jul 2024 15:26:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
Message-ID: <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
Subject: Re: [Patch] Do not clear BSS region in x86 stub
To: "Shao, Marshall" <Marshall.Shao@dell.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Mishra, Ashish" <Ashish.Mishra4@dell.com>, "Chia, Jia Yuan" <JiaYuan.Chia@dell.com>, 
	"Dion, Christopher" <Christopher.Dion@dell.com>, "Caisse, Joe" <Joe.Caisse@dell.com>, 
	"Mukundan, Govind" <Govind.Mukundan@dell.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jul 2024 at 17:40, Shao, Marshall <Marshall.Shao@dell.com> wrote:
>
> Hi Ard,
>
> Thanks for your reply. Here is the problem I encountered, and the problem
> still exists in the mainline:
>
> Firmware: UEFI 2.4,
> EFI loader: systemd-boot
>
> When I update my kernel from LTS v6.1.x to v6.6.x, the kernel fails to
>  boot when it jumps from the handover protocol. And it fails only on an
> old Firmware that MemoryOverwriteRequestControl(MOR) bit is set to 1.
>
> According to the TCG Reset Attack Mitigation Spec, a Memory Clear Method
> will be loaded in the memory on boot, and this causes the EFI loader
> and OS memory address to shift. Another important factor is that my
> BSS region and boot_idt entries are not as clean as those in QEMU and
> other platforms.
>
> This means that clearing BSS in the handover function can cause the
> firmware's IDT/GDT corruption, as you mentioned here commit <7b8439b0369b>

This commit ID does not exist, I take it you mean
ebf5a79acf9a2970e93d30a9e97b08913ef15711

> (x86/efistub: Drop redundant clearing of BSS).

systemd-boot does not use the handover entrypoint, it uses the native
PE entrypoint, which no longer clears BSS with the commit above
applied.

> I noticed that most of
> variables in BSS will be initialized before accessing, and only a few are
> not, that's why I removed memset part in handover entry point.
>

It would be better not to rely on special semantics that deviate from
standard C. That said, it would also be better not to rely on this
funky EFI handover protocol in the first place, which is only
implemented by downstream, distro versions of GRUB. Given that GRUB
now supports the native EFI entrypoint properly, the handover protocol
is essentially deprecated.

This does not mean, of course, that we should stop supporting it. But
removing the memset() there may break things in a way that only
becomes apparent once the changes trickle down to systems running
those older GRUBs.

> In terms of the BOOT_STACK_SIZE, I found out that the boot_stack region is
> used in this case (at the beginning of _bss), and 0x4000 is not sufficient
> to cover this issue since the data in boot_heap will be overwritten during
> decompression.

EFI boot uses the EFI firmware stack, and never enters the
decompressor, where the address of boot_stack_end is loaded into
ESP/RSP.

This means that increasing the boot stack size does not prevent an
overrun, but is affecting the image layout in a different way,
avoiding your boot issue.

It would be nice to get to the bottom of this: can you double check
that the PE image metadata is accurate? llvm-readelf -a can be used to
dump the PE header of a bzImage.

> Prior to image decompression in EFI stub, it was ok.
>
> 00000000008fc000 g       .bss   0000000000000000 .hidden _bss
> 00000000008fc000 l     O .bss   0000000000004000 boot_stack
> 0000000000900000 g     O .bss   0000000000000004 .hidden spurious_nmi_count
> 0000000000900000 l     O .bss   0000000000000000 boot_stack_end
> 0000000000900010 g     O .bss   0000000000000018 .hidden pio_ops
> 0000000000900028 g     O .bss   0000000000000008 .hidden boot_params_ptr
> 0000000000900040 l     O .bss   0000000000001000 scratch.0
> 0000000000901040 l     O .bss   0000000000010000 boot_heap
>
> My thought was that increasing the size of boot_stack should be harmless.

I'm not bothered by the change itself, I just want to make sure that
the fix is guaranteed to address the problem rather than paper over
it.

> As for the memset part, there could be an alternative way, althought it
> looks a bit ugly.
>
> memset(_bss+0x10000, 0, _ebss - _bss - 0x10000)
>

So now you are applying the memset only to part of BSS, right? How
does this help?


> However, I've updated the diff, if you think this is more like a
> workaround, please take this thread as a bug report. Thanks!
>
> Regards,
>
> Marshall Shao
>
>
> Signed-off-by: Marshall Shao <marshall.shao@dell.com>
> ---
>  arch/x86/boot/compressed/misc.c         | 4 ++--
>  arch/x86/include/asm/boot.h             | 2 +-
>  drivers/firmware/efi/libstub/x86-5lvl.c | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 2 --
>  include/linux/decompress/mm.h           | 2 +-
>  5 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 944454306ef4..49b68f57dd18 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -50,8 +50,8 @@ struct boot_params *boot_params_ptr;
>
>  struct port_io_ops pio_ops;
>
> -memptr free_mem_ptr;
> -memptr free_mem_end_ptr;
> +memptr free_mem_ptr __section(".data");
> +memptr free_mem_end_ptr  __section(".data");
>  int spurious_nmi_count;
>
>  static char *vidmem;
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
>  /*
>   * Used by decompressor's startup_32() to allocate page tables for identity
> diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
> index 77359e802181..bebae4fdfb93 100644
> --- a/drivers/firmware/efi/libstub/x86-5lvl.c
> +++ b/drivers/firmware/efi/libstub/x86-5lvl.c
> @@ -10,7 +10,7 @@
>
>  bool efi_no5lvl;
>
> -static void (*la57_toggle)(void *cr3);
> +static void (*la57_toggle)(void *cr3) __section(".data");
>
>  static const struct desc_struct gdt[] = {
>         [GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 078055b054e3..ffc62af50669 100644
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
> @@ -1059,7 +1058,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>  void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
>                         struct boot_params *boot_params)
>  {
> -       memset(_bss, 0, _ebss - _bss);
>         efi_stub_entry(handle, sys_table_arg, boot_params);
>  }
>
> diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
> index ac862422df15..62c04691c898 100644
> --- a/include/linux/decompress/mm.h
> +++ b/include/linux/decompress/mm.h
> @@ -36,7 +36,7 @@
>  /* A trivial malloc implementation, adapted from
>   *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
>   */
> -STATIC_RW_DATA unsigned long malloc_ptr;
> +STATIC_RW_DATA unsigned long malloc_ptr  __section(".data");
>  STATIC_RW_DATA int malloc_count;
>
>  MALLOC_VISIBLE void *malloc(int size)
> --
> 2.34.1
>

