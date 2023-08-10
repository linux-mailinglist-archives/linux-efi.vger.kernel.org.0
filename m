Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C137775DF
	for <lists+linux-efi@lfdr.de>; Thu, 10 Aug 2023 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjHJKdA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Aug 2023 06:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJKc7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Aug 2023 06:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA8E3
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691663533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IxYvDVR4KU+k/42fplfDX5WUZUDPhMAmNilXByOm/EI=;
        b=DHlLtAdTR/2uDmBswYAluyXEAsCOvXcw7+hCfyANGtwByr54TOfN0ioqrLkO5r9GFaei/e
        5DCini4DqoPyyfZ8oN6qhzaif+zwuvTJoxemBJTTBjmXg5VM4fVyG3H1zSH/Kn8CnnQnUf
        wjmk9DPf6fAqf0DUaQnGkkFGPLEWuzI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-O8kYZtlGM6i0SciETjNOKw-1; Thu, 10 Aug 2023 06:32:09 -0400
X-MC-Unique: O8kYZtlGM6i0SciETjNOKw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bc8f1290eso61163366b.3
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 03:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663529; x=1692268329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYvDVR4KU+k/42fplfDX5WUZUDPhMAmNilXByOm/EI=;
        b=dKLpMPRXtM9Gf7xs6dxheaUpknN+seU6l3VKurcncCyvQhUyJ19hVSLW1WqHShT2Cv
         fyVrMm19JyYr2mNd4h+Q09D4/9dkKnYs7Pszh2eiaRuAy1V1H6j+yE/uEfXjn09fLo1/
         bZ65bYtUU5Q9OWom7JTtzc4nilv0DAENyeM7CKWwaadxNPQQCsXxO1S8sGriA0Fv+nSv
         eA+1jbT0QnuV8hf3GqMeqQLifEowK5jDOn11sRtqdmEIZ7yBgifrBtcXsAzWnl4vigU5
         h1Y+Gf46mIoudYK3bB2FeGRkDRLrdtFBJIZpaCCf7E/cEj7n2sQhhKlHsZDRvItYdneZ
         pNTg==
X-Gm-Message-State: AOJu0YzxchUGtS2CH1PiZn/F5GIQIInU4iBVcVaO5C4wQ5dCF2M385iE
        BCr0SoAe0f+ivKUivqUn/Sx4qmGVmPsFKMoh46tbdBqFxyffEdzcN9C2VWSj91conxwEBGvLtaK
        LSgMJRt316pJJRgxRxG4l
X-Received: by 2002:a17:906:18d:b0:99c:9e98:70bc with SMTP id 13-20020a170906018d00b0099c9e9870bcmr1786235ejb.29.1691663528600;
        Thu, 10 Aug 2023 03:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk5rp0bOyNua4CDoY5tnECGJye2Gx1rDxf4zgJIxNerR+4wuVY3qtRsDX3ZJ4o2+mvZ05z5A==
X-Received: by 2002:a17:906:18d:b0:99c:9e98:70bc with SMTP id 13-20020a170906018d00b0099c9e9870bcmr1786211ejb.29.1691663528111;
        Thu, 10 Aug 2023 03:32:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kg23-20020a17090776f700b0099cfd0b2437sm744595ejc.99.2023.08.10.03.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 03:32:07 -0700 (PDT)
Message-ID: <e135fd0d-86d3-6c01-1b50-0736b21aaab2@redhat.com>
Date:   Thu, 10 Aug 2023 12:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] efi/x86: Limit mixed mode support to runtime services
Content-Language: en-US, nl
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Steve McIntyre <steve@einval.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20230810092835.1025088-1-ardb@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230810092835.1025088-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On 8/10/23 11:28, Ard Biesheuvel wrote:
> As currently implemented, mixed mode support on x86 depends on special
> Linux/x86 specific logic in the bootloader that is not covered by the
> UEFI specification: it relies on the so-called EFI handover protocol to
> invoke a special 32-bit entrypoint into the EFI stub that 64-bit Linux
> builds expose if they were configured with CONFIG_EFI_MIXED=y (and
> CONFIG_EFI_HANDOVER_PROTOCOL=y)
> 
> When EFI mixed mode was introduced, booting via the EFI stub was a
> prerequisite, as the stub code captured the context that was restored
> again when invoking firmware services, both at boot time and at runtime.
> (segment selectors, GDTs, IDTs etc). However, since commit 96738c69a7fc
> ("x86/efi: Avoid triple faults during EFI mixed mode calls"), the
> runtime logic no longer uses any of this preserved context, and simply
> invokes the firmware services in compatibility mode instead.
> 
> Given that the EFI handover protocol was never implemented except in
> distro forks of GRUB, mainline GRUB does not support it. However, its
> legacy x86 boot code will happily boot a 64-bit kernel from a 32-bit
> build, and given that booting via the EFI stub is no longer needed, it
> can also invoke the 32-bit EFI runtime services without problems. And
> even Debian's GRUB fork, which implements the EFI handover protocol for
> native boot, will happily boot in mixed mode with all the EFI stub
> pieces ripped out.
> 
> This means that the complex and messy EFI mixed mode support in the EFI
> stub is redundant, and can be removed.

How do you see this working, esp. wrt upgrade paths for distros which currently have a patched grub which will execute the EFI stub when EFI booting, both for 32 bits and for 64 bit grub builds ?

If I understand this correctly the 32 bit grub UEFI binaries will need to boot through the x86 boot protocol now instead of using the EFI stub. Will the current (distro patched) UEFI grub binaries be able to detect stub support is missing and then automatically fall back to the x86 boot protocol? I doubt that the current EFI handover / stub support patches in grub actually do this.

AFAICT this would mean that if this lands in lets say 6.7 and that lets say Fedora 39 then moves to 6.7 once approx. 6.7.4 is out all Fedora 40 x86_64 installs done on low-end machines using 32 bit UEFI will then stop booting ?

And this will also completely break booting 64 bit kernels on 32 bit UEFI using systemd-boot.
systemd-boot exclusively relies on the UEFI stub, since the whole concept of system-boot is to do as little as possible and rely on UEFI for pretty much everything. As such I also consider it quite unlikely that systemd-boot will ever get support for the x86 boot protocol.

Another thing to consider is that booting through the stub tends to be more reliable then using grub. There is a reason why Fedora has been patched grub to use the stub even long before 32/64 bit mixed mode support was implemented. I've more then once seen 64 bit UEFI systems where upstream grub would fail to boot the system, where as a grub patched to handover booting to the EFI stub would boot. And since the often low qualitty of 32 bit UEFI BIOS-es I'm worried that some of them likewise will fail to boot when using the x86 boot protocol.

I'm sorry, but to me breaking grub distro upgrade paths and completely loosing support for systemd-boot seems like an unacceptable regression.

I can understand the desire to remove this hairy code, but the diffstat shows this only removes about 800 lines. Now if we were talking 10 kloc or some such we could maybe look into some sort of migration path.

IMHO the balance between amount of cleanups versus the severity of the regressions / lost functionality tips the scale to the regressions being worse then the positve effect of the code cleanup. So based on my current understanding of this I'm against the proposed change.

Regards,

Hans



> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Steve McIntyre <steve@einval.com>
> Cc: Julian Andres Klode <julian.klode@canonical.com>
> Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Kconfig                               |  16 +-
>  arch/x86/boot/compressed/Makefile              |   1 -
>  arch/x86/boot/compressed/efi_mixed.S           | 322 --------------------
>  arch/x86/boot/compressed/head_64.S             |   7 -
>  arch/x86/boot/header.S                         |  20 --
>  arch/x86/boot/tools/build.c                    |  38 +--
>  arch/x86/include/asm/efi.h                     | 185 +----------
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   3 +-
>  drivers/firmware/efi/libstub/efistub.h         | 205 +------------
>  drivers/firmware/efi/libstub/random.c          |   4 -
>  drivers/firmware/efi/libstub/x86-5lvl.c        |   3 -
>  drivers/firmware/efi/libstub/x86-stub.c        |   5 -
>  include/linux/efi.h                            |   2 -
>  13 files changed, 17 insertions(+), 794 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7422db4097701c96..4604a4a3476b22c5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1995,15 +1995,17 @@ config EFI_HANDOVER_PROTOCOL
>  
>  config EFI_MIXED
>  	bool "EFI mixed-mode support"
> -	depends on EFI_STUB && X86_64
> +	depends on EFI && X86_64
>  	help
> -	  Enabling this feature allows a 64-bit kernel to be booted
> -	  on a 32-bit firmware, provided that your CPU supports 64-bit
> -	  mode.
> +	  Enabling this feature allows a 64-bit kernel booted on 32-bit EFI
> +	  firmware to invoke runtime services. Naturally, this only works on
> +	  systems that are 64-bit capable to begin with - typically, these are
> +	  low-end x86_64 Intel Atom based systems that were built to run 32-bit
> +	  Windows.
>  
> -	  Note that it is not possible to boot a mixed-mode enabled
> -	  kernel via the EFI boot stub - a bootloader that supports
> -	  the EFI handover protocol must be used.
> +	  Note that it is not possible to boot a mixed-mode enabled kernel via
> +	  the EFI boot stub - a bootloader that supports the x86 boot protocol
> +	  must be used (e.g., GRUB)
>  
>  	  If unsure, say N.
>  
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 71fc531b95b4eede..4de74ab39bff74fc 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -115,7 +115,6 @@ vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/td
>  vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>  
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> -vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> deleted file mode 100644
> index f4e22ef774ab6b4a..0000000000000000
> --- a/arch/x86/boot/compressed/efi_mixed.S
> +++ /dev/null
> @@ -1,322 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
> - *
> - * Early support for invoking 32-bit EFI services from a 64-bit kernel.
> - *
> - * Because this thunking occurs before ExitBootServices() we have to
> - * restore the firmware's 32-bit GDT and IDT before we make EFI service
> - * calls.
> - *
> - * On the plus side, we don't have to worry about mangling 64-bit
> - * addresses into 32-bits because we're executing with an identity
> - * mapped pagetable and haven't transitioned to 64-bit virtual addresses
> - * yet.
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/msr.h>
> -#include <asm/page_types.h>
> -#include <asm/processor-flags.h>
> -#include <asm/segment.h>
> -
> -	.code64
> -	.text
> -/*
> - * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
> - * is the first thing that runs after switching to long mode. Depending on
> - * whether the EFI handover protocol or the compat entry point was used to
> - * enter the kernel, it will either branch to the common 64-bit EFI stub
> - * entrypoint efi_stub_entry() directly, or via the 64-bit EFI PE/COFF
> - * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
> - * struct bootparams pointer as the third argument, so the presence of such a
> - * pointer is used to disambiguate.
> - *
> - *                                                             +--------------+
> - *  +------------------+     +------------+            +------>| efi_pe_entry |
> - *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
> - *  +------------------+     |            |     +------+----------------+  |
> - *                           | startup_32 |---->| startup_64_mixed_mode |  |
> - *  +------------------+     |            |     +------+----------------+  |
> - *  | efi32_stub_entry |---->|            |            |                   |
> - *  +------------------+     +------------+            |                   |
> - *                                                     V                   |
> - *                           +------------+     +----------------+         |
> - *                           | startup_64 |<----| efi_stub_entry |<--------+
> - *                           +------------+     +----------------+
> - */
> -SYM_FUNC_START(startup_64_mixed_mode)
> -	lea	efi32_boot_args(%rip), %rdx
> -	mov	0(%rdx), %edi
> -	mov	4(%rdx), %esi
> -#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
> -	mov	8(%rdx), %edx		// saved bootparams pointer
> -	test	%edx, %edx
> -	jnz	efi_stub_entry
> -#endif
> -	/*
> -	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
> -	 * shadow space on the stack even if all arguments are passed in
> -	 * registers. We also need an additional 8 bytes for the space that
> -	 * would be occupied by the return address, and this also results in
> -	 * the correct stack alignment for entry.
> -	 */
> -	sub	$40, %rsp
> -	mov	%rdi, %rcx		// MS calling convention
> -	mov	%rsi, %rdx
> -	jmp	efi_pe_entry
> -SYM_FUNC_END(startup_64_mixed_mode)
> -
> -SYM_FUNC_START(__efi64_thunk)
> -	push	%rbp
> -	push	%rbx
> -
> -	movl	%ds, %eax
> -	push	%rax
> -	movl	%es, %eax
> -	push	%rax
> -	movl	%ss, %eax
> -	push	%rax
> -
> -	/* Copy args passed on stack */
> -	movq	0x30(%rsp), %rbp
> -	movq	0x38(%rsp), %rbx
> -	movq	0x40(%rsp), %rax
> -
> -	/*
> -	 * Convert x86-64 ABI params to i386 ABI
> -	 */
> -	subq	$64, %rsp
> -	movl	%esi, 0x0(%rsp)
> -	movl	%edx, 0x4(%rsp)
> -	movl	%ecx, 0x8(%rsp)
> -	movl	%r8d, 0xc(%rsp)
> -	movl	%r9d, 0x10(%rsp)
> -	movl	%ebp, 0x14(%rsp)
> -	movl	%ebx, 0x18(%rsp)
> -	movl	%eax, 0x1c(%rsp)
> -
> -	leaq	0x20(%rsp), %rbx
> -	sgdt	(%rbx)
> -	sidt	16(%rbx)
> -
> -	leaq	1f(%rip), %rbp
> -
> -	/*
> -	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
> -	 * GDT and IDT that were installed when the kernel started executing.
> -	 * The pointers were saved by the efi32_entry() routine below.
> -	 *
> -	 * Pass the saved DS selector to the 32-bit code, and use far return to
> -	 * restore the saved CS selector.
> -	 */
> -	lidt	efi32_boot_idt(%rip)
> -	lgdt	efi32_boot_gdt(%rip)
> -
> -	movzwl	efi32_boot_ds(%rip), %edx
> -	movzwq	efi32_boot_cs(%rip), %rax
> -	pushq	%rax
> -	leaq	efi_enter32(%rip), %rax
> -	pushq	%rax
> -	lretq
> -
> -1:	addq	$64, %rsp
> -	movq	%rdi, %rax
> -
> -	pop	%rbx
> -	movl	%ebx, %ss
> -	pop	%rbx
> -	movl	%ebx, %es
> -	pop	%rbx
> -	movl	%ebx, %ds
> -	/* Clear out 32-bit selector from FS and GS */
> -	xorl	%ebx, %ebx
> -	movl	%ebx, %fs
> -	movl	%ebx, %gs
> -
> -	pop	%rbx
> -	pop	%rbp
> -	RET
> -SYM_FUNC_END(__efi64_thunk)
> -
> -	.code32
> -#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
> -SYM_FUNC_START(efi32_stub_entry)
> -	call	1f
> -1:	popl	%ecx
> -
> -	/* Clear BSS */
> -	xorl	%eax, %eax
> -	leal	(_bss - 1b)(%ecx), %edi
> -	leal	(_ebss - 1b)(%ecx), %ecx
> -	subl	%edi, %ecx
> -	shrl	$2, %ecx
> -	cld
> -	rep	stosl
> -
> -	add	$0x4, %esp		/* Discard return address */
> -	popl	%ecx
> -	popl	%edx
> -	popl	%esi
> -	jmp	efi32_entry
> -SYM_FUNC_END(efi32_stub_entry)
> -#endif
> -
> -/*
> - * EFI service pointer must be in %edi.
> - *
> - * The stack should represent the 32-bit calling convention.
> - */
> -SYM_FUNC_START_LOCAL(efi_enter32)
> -	/* Load firmware selector into data and stack segment registers */
> -	movl	%edx, %ds
> -	movl	%edx, %es
> -	movl	%edx, %fs
> -	movl	%edx, %gs
> -	movl	%edx, %ss
> -
> -	/* Reload pgtables */
> -	movl	%cr3, %eax
> -	movl	%eax, %cr3
> -
> -	/* Disable paging */
> -	movl	%cr0, %eax
> -	btrl	$X86_CR0_PG_BIT, %eax
> -	movl	%eax, %cr0
> -
> -	/* Disable long mode via EFER */
> -	movl	$MSR_EFER, %ecx
> -	rdmsr
> -	btrl	$_EFER_LME, %eax
> -	wrmsr
> -
> -	call	*%edi
> -
> -	/* We must preserve return value */
> -	movl	%eax, %edi
> -
> -	/*
> -	 * Some firmware will return with interrupts enabled. Be sure to
> -	 * disable them before we switch GDTs and IDTs.
> -	 */
> -	cli
> -
> -	lidtl	16(%ebx)
> -	lgdtl	(%ebx)
> -
> -	movl	%cr4, %eax
> -	btsl	$(X86_CR4_PAE_BIT), %eax
> -	movl	%eax, %cr4
> -
> -	movl	%cr3, %eax
> -	movl	%eax, %cr3
> -
> -	movl	$MSR_EFER, %ecx
> -	rdmsr
> -	btsl	$_EFER_LME, %eax
> -	wrmsr
> -
> -	xorl	%eax, %eax
> -	lldt	%ax
> -
> -	pushl	$__KERNEL_CS
> -	pushl	%ebp
> -
> -	/* Enable paging */
> -	movl	%cr0, %eax
> -	btsl	$X86_CR0_PG_BIT, %eax
> -	movl	%eax, %cr0
> -	lret
> -SYM_FUNC_END(efi_enter32)
> -
> -/*
> - * This is the common EFI stub entry point for mixed mode.
> - *
> - * Arguments:	%ecx	image handle
> - * 		%edx	EFI system table pointer
> - *		%esi	struct bootparams pointer (or NULL when not using
> - *			the EFI handover protocol)
> - *
> - * Since this is the point of no return for ordinary execution, no registers
> - * are considered live except for the function parameters. [Note that the EFI
> - * stub may still exit and return to the firmware using the Exit() EFI boot
> - * service.]
> - */
> -SYM_FUNC_START_LOCAL(efi32_entry)
> -	call	1f
> -1:	pop	%ebx
> -
> -	/* Save firmware GDTR and code/data selectors */
> -	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
> -	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
> -	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
> -
> -	/* Store firmware IDT descriptor */
> -	sidtl	(efi32_boot_idt - 1b)(%ebx)
> -
> -	/* Store boot arguments */
> -	leal	(efi32_boot_args - 1b)(%ebx), %ebx
> -	movl	%ecx, 0(%ebx)
> -	movl	%edx, 4(%ebx)
> -	movl	%esi, 8(%ebx)
> -	movb	$0x0, 12(%ebx)          // efi_is64
> -
> -	/* Disable paging */
> -	movl	%cr0, %eax
> -	btrl	$X86_CR0_PG_BIT, %eax
> -	movl	%eax, %cr0
> -
> -	jmp	startup_32
> -SYM_FUNC_END(efi32_entry)
> -
> -/*
> - * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
> - *			       efi_system_table_32_t *sys_table)
> - */
> -SYM_FUNC_START(efi32_pe_entry)
> -	pushl	%ebp
> -	movl	%esp, %ebp
> -	pushl	%ebx				// save callee-save registers
> -	pushl	%edi
> -
> -	call	verify_cpu			// check for long mode support
> -	testl	%eax, %eax
> -	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
> -	jnz	2f
> -
> -	movl	8(%ebp), %ecx			// image_handle
> -	movl	12(%ebp), %edx			// sys_table
> -	xorl	%esi, %esi
> -	jmp	efi32_entry			// pass %ecx, %edx, %esi
> -						// no other registers remain live
> -
> -2:	popl	%edi				// restore callee-save registers
> -	popl	%ebx
> -	leave
> -	RET
> -SYM_FUNC_END(efi32_pe_entry)
> -
> -#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
> -	.org	efi32_stub_entry + 0x200
> -	.code64
> -SYM_FUNC_START_NOALIGN(efi64_stub_entry)
> -	jmp	efi_handover_entry
> -SYM_FUNC_END(efi64_stub_entry)
> -#endif
> -
> -	.data
> -	.balign	8
> -SYM_DATA_START_LOCAL(efi32_boot_gdt)
> -	.word	0
> -	.quad	0
> -SYM_DATA_END(efi32_boot_gdt)
> -
> -SYM_DATA_START_LOCAL(efi32_boot_idt)
> -	.word	0
> -	.quad	0
> -SYM_DATA_END(efi32_boot_idt)
> -
> -SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
> -SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
> -SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
> -SYM_DATA(efi_is64, .byte 1)
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index bf4a10a5794f1c84..472ccbbf3e861831 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -263,13 +263,6 @@ SYM_FUNC_START(startup_32)
>  	 * used to perform that far jump.
>  	 */
>  	leal	rva(startup_64)(%ebp), %eax
> -#ifdef CONFIG_EFI_MIXED
> -	cmpb	$1, rva(efi_is64)(%ebp)
> -	je	1f
> -	leal	rva(startup_64_mixed_mode)(%ebp), %eax
> -1:
> -#endif
> -
>  	pushl	$__KERNEL_CS
>  	pushl	%eax
>  
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index b04ca8e2b213c6e6..1dfa27e2886ae597 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -233,26 +233,6 @@ section_table:
>  		IMAGE_SCN_MEM_DISCARDABLE	| \
>  		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
>  
> -#ifdef CONFIG_EFI_MIXED
> -	#
> -	# The offset & size fields are filled in by build.c.
> -	#
> -	.asciz	".compat"
> -	.long	0
> -	.long	0x0
> -	.long	0				# Size of initialized data
> -						# on disk
> -	.long	0x0
> -	.long	0				# PointerToRelocations
> -	.long	0				# PointerToLineNumbers
> -	.word	0				# NumberOfRelocations
> -	.word	0				# NumberOfLineNumbers
> -	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
> -		IMAGE_SCN_MEM_READ		| \
> -		IMAGE_SCN_MEM_DISCARDABLE	| \
> -		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
> -#endif
> -
>  	#
>  	# The offset & size fields are filled in by build.c.
>  	#
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> index bd247692b70174f0..22b5656e9404a276 100644
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -53,12 +53,6 @@ u8 buf[SETUP_SECT_MAX*512];
>  
>  #define PECOFF_RELOC_RESERVE 0x20
>  
> -#ifdef CONFIG_EFI_MIXED
> -#define PECOFF_COMPAT_RESERVE 0x20
> -#else
> -#define PECOFF_COMPAT_RESERVE 0x0
> -#endif
> -
>  static unsigned long efi32_stub_entry;
>  static unsigned long efi64_stub_entry;
>  static unsigned long efi_pe_entry;
> @@ -198,10 +192,7 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
>  static void update_pecoff_setup_and_reloc(unsigned int size)
>  {
>  	u32 setup_offset = 0x200;
> -	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
> -#ifdef CONFIG_EFI_MIXED
> -	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
> -#endif
> +	u32 reloc_offset = size - PECOFF_RELOC_RESERVE;
>  	u32 setup_size = reloc_offset - setup_offset;
>  
>  	update_pecoff_section_header(".setup", setup_offset, setup_size);
> @@ -213,20 +204,6 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
>  	 */
>  	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
>  	put_unaligned_le32(10, &buf[reloc_offset + 4]);
> -
> -#ifdef CONFIG_EFI_MIXED
> -	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
> -
> -	/*
> -	 * Put the IA-32 machine type (0x14c) and the associated entry point
> -	 * address in the .compat section, so loaders can figure out which other
> -	 * execution modes this image supports.
> -	 */
> -	buf[compat_offset] = 0x1;
> -	buf[compat_offset + 1] = 0x8;
> -	put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
> -	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
> -#endif
>  }
>  
>  static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
> @@ -295,11 +272,6 @@ static void efi_stub_entry_update(void)
>  	/* Yes, this is really how we defined it :( */
>  	addr = efi64_stub_entry - 0x200;
>  #endif
> -
> -#ifdef CONFIG_EFI_MIXED
> -	if (efi32_stub_entry != addr)
> -		die("32-bit and 64-bit EFI entry points do not match\n");
> -#endif
>  #endif
>  	put_unaligned_le32(addr, &buf[0x264]);
>  }
> @@ -319,13 +291,6 @@ static inline int reserve_pecoff_reloc_section(int c)
>  }
>  #endif /* CONFIG_EFI_STUB */
>  
> -static int reserve_pecoff_compat_section(int c)
> -{
> -	/* Reserve 0x20 bytes for .compat section */
> -	memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
> -	return PECOFF_COMPAT_RESERVE;
> -}
> -
>  /*
>   * Parse zoffset.h and find the entry points. We could just #include zoffset.h
>   * but that would mean tools/build would have to be rebuilt every time. It's
> @@ -403,7 +368,6 @@ int main(int argc, char ** argv)
>  		die("Boot block hasn't got boot flag (0xAA55)");
>  	fclose(file);
>  
> -	c += reserve_pecoff_compat_section(c);
>  	c += reserve_pecoff_reloc_section(c);
>  
>  	/* Pad unused space with zeros */
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 56ac915725077699..6e0c6639fa0869ce 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -183,9 +183,8 @@ extern u64 efi_setup;
>  extern u64 __efi64_thunk(u32, ...);
>  
>  #define efi64_thunk(...) ({						\
> -	u64 __pad[3]; /* must have space for 3 args on the stack */	\
> -	__efi_nargs_check(efi64_thunk, 9, __VA_ARGS__);			\
> -	__efi64_thunk(__VA_ARGS__, __pad);				\
> +	__efi_nargs_check(efi64_thunk, 6, __VA_ARGS__);			\
> +	__efi64_thunk(__VA_ARGS__);					\
>  })
>  
>  static inline bool efi_is_mixed(void)
> @@ -214,191 +213,11 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
>  
>  /* arch specific definitions used by the stub code */
>  
> -#ifdef CONFIG_EFI_MIXED
> -
> -#define EFI_ALLOC_LIMIT		(efi_is_64bit() ? ULONG_MAX : U32_MAX)
> -
> -#define ARCH_HAS_EFISTUB_WRAPPERS
> -
> -static inline bool efi_is_64bit(void)
> -{
> -	extern const bool efi_is64;
> -
> -	return efi_is64;
> -}
> -
> -static inline bool efi_is_native(void)
> -{
> -	return efi_is_64bit();
> -}
> -
> -#define efi_table_attr(inst, attr)					\
> -	(efi_is_native() ? (inst)->attr					\
> -			 : efi_mixed_table_attr((inst), attr))
> -
> -#define efi_mixed_table_attr(inst, attr)				\
> -	(__typeof__(inst->attr))					\
> -		_Generic(inst->mixed_mode.attr,				\
> -		u32:		(unsigned long)(inst->mixed_mode.attr),	\
> -		default:	(inst->mixed_mode.attr))
> -
> -/*
> - * The following macros allow translating arguments if necessary from native to
> - * mixed mode. The use case for this is to initialize the upper 32 bits of
> - * output parameters, and where the 32-bit method requires a 64-bit argument,
> - * which must be split up into two arguments to be thunked properly.
> - *
> - * As examples, the AllocatePool boot service returns the address of the
> - * allocation, but it will not set the high 32 bits of the address. To ensure
> - * that the full 64-bit address is initialized, we zero-init the address before
> - * calling the thunk.
> - *
> - * The FreePages boot service takes a 64-bit physical address even in 32-bit
> - * mode. For the thunk to work correctly, a native 64-bit call of
> - * 	free_pages(addr, size)
> - * must be translated to
> - * 	efi64_thunk(free_pages, addr & U32_MAX, addr >> 32, size)
> - * so that the two 32-bit halves of addr get pushed onto the stack separately.
> - */
> -
> -static inline void *efi64_zero_upper(void *p)
> -{
> -	((u32 *)p)[1] = 0;
> -	return p;
> -}
> -
> -static inline u32 efi64_convert_status(efi_status_t status)
> -{
> -	return (u32)(status | (u64)status >> 32);
> -}
> -
> -#define __efi64_split(val)		(val) & U32_MAX, (u64)(val) >> 32
> -
> -#define __efi64_argmap_free_pages(addr, size)				\
> -	((addr), 0, (size))
> -
> -#define __efi64_argmap_get_memory_map(mm_size, mm, key, size, ver)	\
> -	((mm_size), (mm), efi64_zero_upper(key), efi64_zero_upper(size), (ver))
> -
> -#define __efi64_argmap_allocate_pool(type, size, buffer)		\
> -	((type), (size), efi64_zero_upper(buffer))
> -
> -#define __efi64_argmap_create_event(type, tpl, f, c, event)		\
> -	((type), (tpl), (f), (c), efi64_zero_upper(event))
> -
> -#define __efi64_argmap_set_timer(event, type, time)			\
> -	((event), (type), lower_32_bits(time), upper_32_bits(time))
> -
> -#define __efi64_argmap_wait_for_event(num, event, index)		\
> -	((num), (event), efi64_zero_upper(index))
> -
> -#define __efi64_argmap_handle_protocol(handle, protocol, interface)	\
> -	((handle), (protocol), efi64_zero_upper(interface))
> -
> -#define __efi64_argmap_locate_protocol(protocol, reg, interface)	\
> -	((protocol), (reg), efi64_zero_upper(interface))
> -
> -#define __efi64_argmap_locate_device_path(protocol, path, handle)	\
> -	((protocol), (path), efi64_zero_upper(handle))
> -
> -#define __efi64_argmap_exit(handle, status, size, data)			\
> -	((handle), efi64_convert_status(status), (size), (data))
> -
> -/* PCI I/O */
> -#define __efi64_argmap_get_location(protocol, seg, bus, dev, func)	\
> -	((protocol), efi64_zero_upper(seg), efi64_zero_upper(bus),	\
> -	 efi64_zero_upper(dev), efi64_zero_upper(func))
> -
> -/* LoadFile */
> -#define __efi64_argmap_load_file(protocol, path, policy, bufsize, buf)	\
> -	((protocol), (path), (policy), efi64_zero_upper(bufsize), (buf))
> -
> -/* Graphics Output Protocol */
> -#define __efi64_argmap_query_mode(gop, mode, size, info)		\
> -	((gop), (mode), efi64_zero_upper(size), efi64_zero_upper(info))
> -
> -/* TCG2 protocol */
> -#define __efi64_argmap_hash_log_extend_event(prot, fl, addr, size, ev)	\
> -	((prot), (fl), 0ULL, (u64)(addr), 0ULL, (u64)(size), 0ULL, ev)
> -
> -/* DXE services */
> -#define __efi64_argmap_get_memory_space_descriptor(phys, desc) \
> -	(__efi64_split(phys), (desc))
> -
> -#define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
> -	(__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
> -
> -/* file protocol */
> -#define __efi64_argmap_open(prot, newh, fname, mode, attr) \
> -	((prot), efi64_zero_upper(newh), (fname), __efi64_split(mode), \
> -	 __efi64_split(attr))
> -
> -#define __efi64_argmap_set_position(pos) (__efi64_split(pos))
> -
> -/* file system protocol */
> -#define __efi64_argmap_open_volume(prot, file) \
> -	((prot), efi64_zero_upper(file))
> -
> -/* Memory Attribute Protocol */
> -#define __efi64_argmap_get_memory_attributes(protocol, phys, size, flags) \
> -	((protocol), __efi64_split(phys), __efi64_split(size), (flags))
> -
> -#define __efi64_argmap_set_memory_attributes(protocol, phys, size, flags) \
> -	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
> -
> -#define __efi64_argmap_clear_memory_attributes(protocol, phys, size, flags) \
> -	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
> -
> -/*
> - * The macros below handle the plumbing for the argument mapping. To add a
> - * mapping for a specific EFI method, simply define a macro
> - * __efi64_argmap_<method name>, following the examples above.
> - */
> -
> -#define __efi64_thunk_map(inst, func, ...)				\
> -	efi64_thunk(inst->mixed_mode.func,				\
> -		__efi64_argmap(__efi64_argmap_ ## func(__VA_ARGS__),	\
> -			       (__VA_ARGS__)))
> -
> -#define __efi64_argmap(mapped, args)					\
> -	__PASTE(__efi64_argmap__, __efi_nargs(__efi_eat mapped))(mapped, args)
> -#define __efi64_argmap__0(mapped, args) __efi_eval mapped
> -#define __efi64_argmap__1(mapped, args) __efi_eval args
> -
> -#define __efi_eat(...)
> -#define __efi_eval(...) __VA_ARGS__
> -
> -static inline efi_status_t __efi64_widen_efi_status(u64 status)
> -{
> -	/* use rotate to move the value of bit #31 into position #63 */
> -	return ror64(rol32(status, 1), 1);
> -}
> -
> -/* The macro below handles dispatching via the thunk if needed */
> -
> -#define efi_fn_call(inst, func, ...)					\
> -	(efi_is_native() ? (inst)->func(__VA_ARGS__)			\
> -			 : efi_mixed_call((inst), func, ##__VA_ARGS__))
> -
> -#define efi_mixed_call(inst, func, ...)					\
> -	_Generic(inst->func(__VA_ARGS__),				\
> -	efi_status_t:							\
> -		__efi64_widen_efi_status(				\
> -			__efi64_thunk_map(inst, func, ##__VA_ARGS__)),	\
> -	u64: ({ BUILD_BUG(); ULONG_MAX; }),				\
> -	default:							\
> -		(__typeof__(inst->func(__VA_ARGS__)))			\
> -			__efi64_thunk_map(inst, func, ##__VA_ARGS__))
> -
> -#else /* CONFIG_EFI_MIXED */
> -
>  static inline bool efi_is_64bit(void)
>  {
>  	return IS_ENABLED(CONFIG_X86_64);
>  }
>  
> -#endif /* CONFIG_EFI_MIXED */
> -
>  extern bool efi_reboot_required(void);
>  extern bool efi_is_table_address(unsigned long phys_addr);
>  
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index bfa30625f5d03167..b549ad66f3fce828 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -449,8 +449,7 @@ void *get_efi_config_table(efi_guid_t guid)
>  		if (efi_guidcmp(t->guid, guid) == 0)
>  			return efi_table_attr(t, table);
>  
> -		tables += efi_is_native() ? sizeof(efi_config_table_t)
> -					  : sizeof(efi_config_table_32_t);
> +		tables += sizeof(efi_config_table_t);
>  	}
>  	return NULL;
>  }
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 9823f6fb3e01f718..48deaed0d4e555bb 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -47,18 +47,10 @@ extern const efi_dxe_services_table_t *efi_dxe_table;
>  efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  				   efi_system_table_t *sys_table_arg);
>  
> -#ifndef ARCH_HAS_EFISTUB_WRAPPERS
> -
> -#define efi_is_native()			(true)
>  #define efi_table_attr(inst, attr)	(inst)->attr
>  #define efi_fn_call(inst, func, ...)	(inst)->func(__VA_ARGS__)
> +#define efi_call_proto(inst, func, ...) (inst)->func((inst), ##__VA_ARGS__)
>  
> -#endif
> -
> -#define efi_call_proto(inst, func, ...) ({			\
> -	__typeof__(inst) __inst = (inst);			\
> -	efi_fn_call(__inst, func, __inst, ##__VA_ARGS__);	\
> -})
>  #define efi_bs_call(func, ...) \
>  	efi_fn_call(efi_table_attr(efi_system_table, boottime), func, ##__VA_ARGS__)
>  #define efi_rt_call(func, ...) \
> @@ -115,12 +107,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	efi_rt_call(set_variable, (efi_char16_t *)(name),	\
>  		    (efi_guid_t *)(vendor), __VA_ARGS__)
>  
> -#define efi_get_handle_at(array, idx)					\
> -	(efi_is_native() ? (array)[idx] 				\
> -		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
> -
> -#define efi_get_handle_num(size)					\
> -	((size) / (efi_is_native() ? sizeof(efi_handle_t) : sizeof(u32)))
> +#define efi_get_handle_at(array, idx)	(array)[idx]
> +#define efi_get_handle_num(size)	((size) / sizeof(efi_handle_t))
>  
>  #define for_each_efi_handle(handle, array, size, i)			\
>  	for (i = 0;							\
> @@ -184,10 +172,6 @@ union efi_device_path_to_text_protocol {
>  					const efi_device_path_protocol_t *,
>  					bool, bool);
>  	};
> -	struct {
> -		u32 convert_device_node_to_text;
> -		u32 convert_device_path_to_text;
> -	} mixed_mode;
>  };
>  
>  typedef union efi_device_path_to_text_protocol efi_device_path_to_text_protocol_t;
> @@ -199,16 +183,11 @@ union efi_device_path_from_text_protocol {
>  		efi_device_path_protocol_t *
>  			(__efiapi *convert_text_to_device_path)(const efi_char16_t *);
>  	};
> -	struct {
> -		u32 convert_text_to_device_node;
> -		u32 convert_text_to_device_path;
> -	} mixed_mode;
>  };
>  
>  typedef union efi_device_path_from_text_protocol efi_device_path_from_text_protocol_t;
>  
>  typedef void *efi_event_t;
> -/* Note that notifications won't work in mixed mode */
>  typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
>  
>  #define EFI_EVT_TIMER		0x80000000U
> @@ -224,15 +203,11 @@ typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
>   * @event:	event to add to the aray
>   *
>   * boottime->wait_for_event() takes an array of events as input.
> - * Provide a helper to set it up correctly for mixed mode.
>   */
>  static inline
>  void efi_set_event_at(efi_event_t *events, size_t idx, efi_event_t event)
>  {
> -	if (efi_is_native())
> -		events[idx] = event;
> -	else
> -		((u32 *)events)[idx] = (u32)(unsigned long)event;
> +	events[idx] = event;
>  }
>  
>  #define EFI_TPL_APPLICATION	4
> @@ -324,53 +299,6 @@ union efi_boot_services {
>  		void (__efiapi *set_mem)(void *, unsigned long, unsigned char);
>  		void *create_event_ex;
>  	};
> -	struct {
> -		efi_table_hdr_t hdr;
> -		u32 raise_tpl;
> -		u32 restore_tpl;
> -		u32 allocate_pages;
> -		u32 free_pages;
> -		u32 get_memory_map;
> -		u32 allocate_pool;
> -		u32 free_pool;
> -		u32 create_event;
> -		u32 set_timer;
> -		u32 wait_for_event;
> -		u32 signal_event;
> -		u32 close_event;
> -		u32 check_event;
> -		u32 install_protocol_interface;
> -		u32 reinstall_protocol_interface;
> -		u32 uninstall_protocol_interface;
> -		u32 handle_protocol;
> -		u32 __reserved;
> -		u32 register_protocol_notify;
> -		u32 locate_handle;
> -		u32 locate_device_path;
> -		u32 install_configuration_table;
> -		u32 load_image;
> -		u32 start_image;
> -		u32 exit;
> -		u32 unload_image;
> -		u32 exit_boot_services;
> -		u32 get_next_monotonic_count;
> -		u32 stall;
> -		u32 set_watchdog_timer;
> -		u32 connect_controller;
> -		u32 disconnect_controller;
> -		u32 open_protocol;
> -		u32 close_protocol;
> -		u32 open_protocol_information;
> -		u32 protocols_per_handle;
> -		u32 locate_handle_buffer;
> -		u32 locate_protocol;
> -		u32 install_multiple_protocol_interfaces;
> -		u32 uninstall_multiple_protocol_interfaces;
> -		u32 calculate_crc32;
> -		u32 copy_mem;
> -		u32 set_mem;
> -		u32 create_event_ex;
> -	} mixed_mode;
>  };
>  
>  typedef enum {
> @@ -420,27 +348,6 @@ union efi_dxe_services_table {
>  		void *process_firmware_volume;
>  		void *set_memory_space_capabilities;
>  	};
> -	struct {
> -		efi_table_hdr_t hdr;
> -		u32 add_memory_space;
> -		u32 allocate_memory_space;
> -		u32 free_memory_space;
> -		u32 remove_memory_space;
> -		u32 get_memory_space_descriptor;
> -		u32 set_memory_space_attributes;
> -		u32 get_memory_space_map;
> -		u32 add_io_space;
> -		u32 allocate_io_space;
> -		u32 free_io_space;
> -		u32 remove_io_space;
> -		u32 get_io_space_descriptor;
> -		u32 get_io_space_map;
> -		u32 dispatch;
> -		u32 schedule;
> -		u32 trust;
> -		u32 process_firmware_volume;
> -		u32 set_memory_space_capabilities;
> -	} mixed_mode;
>  };
>  
>  typedef union efi_memory_attribute_protocol efi_memory_attribute_protocol_t;
> @@ -456,11 +363,6 @@ union efi_memory_attribute_protocol {
>  		efi_status_t (__efiapi *clear_memory_attributes)(
>  			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64);
>  	};
> -	struct {
> -		u32 get_memory_attributes;
> -		u32 set_memory_attributes;
> -		u32 clear_memory_attributes;
> -	} mixed_mode;
>  };
>  
>  typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
> @@ -472,11 +374,6 @@ union efi_uga_draw_protocol {
>  		void *set_mode;
>  		void *blt;
>  	};
> -	struct {
> -		u32 get_mode;
> -		u32 set_mode;
> -		u32 blt;
> -	} mixed_mode;
>  };
>  
>  typedef struct {
> @@ -491,11 +388,6 @@ union efi_simple_text_input_protocol {
>  							efi_input_key_t *);
>  		efi_event_t wait_for_key;
>  	};
> -	struct {
> -		u32 reset;
> -		u32 read_keystroke;
> -		u32 wait_for_key;
> -	} mixed_mode;
>  };
>  
>  efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key);
> @@ -507,11 +399,6 @@ union efi_simple_text_output_protocol {
>  						       efi_char16_t *);
>  		void *test_string;
>  	};
> -	struct {
> -		u32 reset;
> -		u32 output_string;
> -		u32 test_string;
> -	} mixed_mode;
>  };
>  
>  #define PIXEL_RGB_RESERVED_8BIT_PER_COLOR		0
> @@ -547,14 +434,6 @@ union efi_graphics_output_protocol_mode {
>  		efi_physical_addr_t frame_buffer_base;
>  		unsigned long frame_buffer_size;
>  	};
> -	struct {
> -		u32 max_mode;
> -		u32 mode;
> -		u32 info;
> -		u32 size_of_info;
> -		u64 frame_buffer_base;
> -		u32 frame_buffer_size;
> -	} mixed_mode;
>  };
>  
>  typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
> @@ -568,12 +447,6 @@ union efi_graphics_output_protocol {
>  		void *blt;
>  		efi_graphics_output_protocol_mode_t *mode;
>  	};
> -	struct {
> -		u32 query_mode;
> -		u32 set_mode;
> -		u32 blt;
> -		u32 mode;
> -	} mixed_mode;
>  };
>  
>  typedef union {
> @@ -592,21 +465,6 @@ typedef union {
>  		unsigned int		image_data_type;
>  		efi_status_t		(__efiapi *unload)(efi_handle_t image_handle);
>  	};
> -	struct {
> -		u32		revision;
> -		u32		parent_handle;
> -		u32		system_table;
> -		u32		device_handle;
> -		u32		file_path;
> -		u32		reserved;
> -		u32		load_options_size;
> -		u32		load_options;
> -		u32		image_base;
> -		__aligned_u64	image_size;
> -		u32		image_code_type;
> -		u32		image_data_type;
> -		u32		unload;
> -	} mixed_mode;
>  } efi_loaded_image_t;
>  
>  typedef struct {
> @@ -650,19 +508,6 @@ union efi_file_protocol {
>  							 void *);
>  		efi_status_t	(__efiapi *flush)	(efi_file_protocol_t *);
>  	};
> -	struct {
> -		u64 revision;
> -		u32 open;
> -		u32 close;
> -		u32 delete;
> -		u32 read;
> -		u32 write;
> -		u32 get_position;
> -		u32 set_position;
> -		u32 get_info;
> -		u32 set_info;
> -		u32 flush;
> -	} mixed_mode;
>  };
>  
>  typedef union efi_simple_file_system_protocol efi_simple_file_system_protocol_t;
> @@ -673,10 +518,6 @@ union efi_simple_file_system_protocol {
>  		efi_status_t	(__efiapi *open_volume)(efi_simple_file_system_protocol_t *,
>  							efi_file_protocol_t **);
>  	};
> -	struct {
> -		u64 revision;
> -		u32 open_volume;
> -	} mixed_mode;
>  };
>  
>  #define EFI_FILE_MODE_READ	0x0000000000000001
> @@ -756,25 +597,6 @@ union efi_pci_io_protocol {
>  		uint64_t romsize;
>  		void *romimage;
>  	};
> -	struct {
> -		u32 poll_mem;
> -		u32 poll_io;
> -		efi_pci_io_protocol_access_32_t mem;
> -		efi_pci_io_protocol_access_32_t io;
> -		efi_pci_io_protocol_access_32_t pci;
> -		u32 copy_mem;
> -		u32 map;
> -		u32 unmap;
> -		u32 allocate_buffer;
> -		u32 free_buffer;
> -		u32 flush;
> -		u32 get_location;
> -		u32 attributes;
> -		u32 get_bar_attributes;
> -		u32 set_bar_attributes;
> -		u64 romsize;
> -		u32 romimage;
> -	} mixed_mode;
>  };
>  
>  #define EFI_PCI_IO_ATTRIBUTE_ISA_MOTHERBOARD_IO 0x0001
> @@ -816,13 +638,6 @@ union apple_properties_protocol {
>  		efi_status_t (__efiapi *get_all)(apple_properties_protocol_t *,
>  						 void *buffer, u32 *);
>  	};
> -	struct {
> -		u32 version;
> -		u32 get;
> -		u32 set;
> -		u32 del;
> -		u32 get_all;
> -	} mixed_mode;
>  };
>  
>  typedef u32 efi_tcg2_event_log_format;
> @@ -871,15 +686,6 @@ union efi_tcg2_protocol {
>  		void *set_active_pcr_banks;
>  		void *get_result_of_set_active_pcr_banks;
>  	};
> -	struct {
> -		u32 get_capability;
> -		u32 get_event_log;
> -		u32 hash_log_extend_event;
> -		u32 submit_command;
> -		u32 get_active_pcr_banks;
> -		u32 set_active_pcr_banks;
> -		u32 get_result_of_set_active_pcr_banks;
> -	} mixed_mode;
>  };
>  
>  struct riscv_efi_boot_protocol {
> @@ -898,9 +704,6 @@ union efi_load_file_protocol {
>  						   efi_device_path_protocol_t *,
>  						   bool, unsigned long *, void *);
>  	};
> -	struct {
> -		u32 load_file;
> -	} mixed_mode;
>  };
>  
>  typedef struct {
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index 7109b8a2dcba81b3..14c991b8c6e07b5d 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -19,10 +19,6 @@ union efi_rng_protocol {
>  						 efi_guid_t *, unsigned long,
>  						 u8 *out);
>  	};
> -	struct {
> -		u32 get_info;
> -		u32 get_rng;
> -	} mixed_mode;
>  };
>  
>  /**
> diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
> index 479dd445acdcff8d..136c25706d3a1991 100644
> --- a/drivers/firmware/efi/libstub/x86-5lvl.c
> +++ b/drivers/firmware/efi/libstub/x86-5lvl.c
> @@ -30,9 +30,6 @@ efi_status_t efi_setup_5level_paging(void)
>  	efi_status_t status;
>  	u8 *la57_code;
>  
> -	if (!efi_is_64bit())
> -		return EFI_SUCCESS;
> -
>  	/* check for 5 level paging support */
>  	if (native_cpuid_eax(0) < 7 ||
>  	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index e976288728e975f1..dd679570d92f9121 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -32,9 +32,6 @@ union sev_memory_acceptance_protocol {
>  		efi_status_t (__efiapi * allow_unaccepted_memory)(
>  			sev_memory_acceptance_protocol_t *);
>  	};
> -	struct {
> -		u32 allow_unaccepted_memory;
> -	} mixed_mode;
>  };
>  
>  static efi_status_t
> @@ -975,7 +972,6 @@ void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
>  	efi_stub_entry(handle, sys_table_arg, boot_params);
>  }
>  
> -#ifndef CONFIG_EFI_MIXED
>  extern __alias(efi_handover_entry)
>  void efi32_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
>  		      struct boot_params *boot_params);
> @@ -984,4 +980,3 @@ extern __alias(efi_handover_entry)
>  void efi64_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
>  		      struct boot_params *boot_params);
>  #endif
> -#endif
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index a1b40527e627fb43..3d6f911dc8503bde 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -455,7 +455,6 @@ typedef union {
>  		efi_guid_t guid;
>  		void *table;
>  	};
> -	efi_config_table_32_t mixed_mode;
>  } efi_config_table_t;
>  
>  typedef struct {
> @@ -527,7 +526,6 @@ typedef union {
>  		unsigned long nr_tables;
>  		unsigned long tables;
>  	};
> -	efi_system_table_32_t mixed_mode;
>  } efi_system_table_t;
>  
>  struct efi_boot_memmap {

