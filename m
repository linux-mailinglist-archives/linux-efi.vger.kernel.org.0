Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4332B6209D4
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiKHHBO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 02:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiKHHBN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 02:01:13 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F827B12;
        Mon,  7 Nov 2022 23:01:11 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 28E9C419E9E7;
        Tue,  8 Nov 2022 07:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 28E9C419E9E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1667890867;
        bh=vZj52kdIzoLSUwtu2CqHmy0BYlbjaJCqHxiUKCO/cd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g48XDX2t71X1ak9fkpwJ1LkdptwZH4QNlXEPC9KJi99AiC1bXAhq73j3pe9zM5GPb
         gqBoFcPHVGv5ASNCI22/l4JnYckx9q633LzhXInvb57QpVIM/Y6h1dNQXR9bVpPzMY
         avHZPSwyUr2a8jdWS53Mio5b9wwfqXsXqVxxfmqQ=
MIME-Version: 1.0
Date:   Tue, 08 Nov 2022 10:01:07 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/23] x86_64: Improvements at compressed kernel stage
In-Reply-To: <e2beec0b-22d3-91bd-c57c-8c8ad2137406@amd.com>
References: <cover.1666705333.git.baskov@ispras.ru>
 <e2beec0b-22d3-91bd-c57c-8c8ad2137406@amd.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d97fdff486959dbf841c92b3cb644740@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-11-04 21:21, Limonciello, Mario wrote:
> On 10/25/2022 09:12, Evgeniy Baskov wrote:
>> ...
>> 
> 
> Hi,
> 
> I was talking to Peter Jones recently about what was still missing for
> NX support in the kernel and he pointed me at this series.
> 
> So I had a try with this series on top of:
> 
> ee6050c8af96 ("Merge tag 'ata-6.1-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata")
> 
> Unfortunately I can't boot the system with this series applied.
> This is not on a system that enforces NX pre-boot (but that was my
> goal after I could prove booting on something that doesn't).
> I didn't apply Peter's patch 6 you referenced in your cover letter,
> but I don't expect that's the reason for the failure.
> 
> I get:
> 
> "Failed to allocate space for tmp_cmdline"
> 
>    -- System Halted
> 
> This is early enough [1] that I don't have anything else output to a
> serial log from the kernel.
> 
> https://github.com/torvalds/linux/blob/d4013bc4d49f6da8178a340348369bb9920225c9/arch/x86/boot/compressed/kaslr.c#L268
> 
> Since this is only in the kaslr path, I tried to turn that off with
> 'nokaslr' on the kernel command line.
> 
> I then get a failure of:
> 
> "Out of memory while allocating zstd_dctx"
> 
>   -- System Halted
> 
> This kernel was booted from the following path:
> -> Insyde BIOS
> --> shim (from Fedora 36 repository)
> ---> GRUB (from Peter for Fedora 36 w/ some level NX support)
> ----> kernel binary (self-built)
> 
> The BIOS on this system doesn't validate NX, but also the shim binary
> did not have the NX bit set in the PE header.
> 
> Your cover letter referenced CONFIG_EFI_STUB_EXTRACT_DIRECT but I
> didn't find this option in the series.  I also tried both with
> CONFIG_EFI_DXE_MEM_ATTRIBUTES=y or unset, same result.

Hi,

Thanks for your feedback!

CONFIG_EFI_STUB_EXTRACT_DIRECT option was removed in v2 of the series
and direct extraction is unconditional now.

You are getting really weird errors, which unfortunately I am unable
to reproduce yet. I've tried booting with fedora's grub and the series
applied on top of ee6050c8af96, but it did boot successfully.

 From the error messages it's some problem with malloc() implementation
of compressed kernel code. I suspect that malloc_ptr inside .bss is not
zeroed. This should not happen when booting via either non-UEFI
interface, or via UEFI (when kernel is properly loaded as PE image).
The problem, I think, arises when kernel is loaded as a blob, but EFI
handover protocol is used to start its execution. This is what grub
seems to be doing.

Can you please try booting with patches below applied on top?
If this fixes the problem, I'll include these changes in v3.

Thanks,
Evgeniy Baskov
--
diff --git a/arch/x86/boot/compressed/head_32.S 
b/arch/x86/boot/compressed/head_32.S
index 9871cc8466fb..69811d9ab4ce 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -152,6 +152,14 @@ SYM_FUNC_END(startup_32)

  #ifdef CONFIG_EFI_STUB
  SYM_FUNC_START(efi32_stub_entry)
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leal	_bss@GOTOFF(%ebx), %edi
+	leal	_ebss@GOTOFF(%ebx), %ecx
+	subl	%edi, %ecx
+	shrl	$2, %ecx
+	rep	stosl
+
  	add	$0x4, %esp
  	movl	8(%esp), %esi	/* save boot_params pointer */
  	call	efi_main
diff --git a/arch/x86/boot/compressed/head_64.S 
b/arch/x86/boot/compressed/head_64.S
index 2bb0e6da08c0..384706d12354 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -553,8 +553,20 @@ SYM_CODE_END(startup_64)
  #ifdef CONFIG_EFI_STUB
  	.org 0x390
  SYM_FUNC_START(efi64_stub_entry)
+	/* Preserve first parameter */
+	movq	%rdi, %r10
+
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leaq	_bss(%rip), %rdi
+	leaq	_ebss(%rip), %rcx
+	subq	%rdi, %rcx
+	shrq	$3, %rcx
+	rep	stosq
+
  	and	$~0xf, %rsp			/* realign the stack */
  	movq	%rdx, %rbx			/* save boot_params pointer */
+	movq	%r10, %rdi
  	call	efi_main

  	cld
diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
b/drivers/firmware/efi/libstub/x86-stub.c
index 95a69c37518e..1a2c52e77c6e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -24,7 +24,7 @@

  const efi_system_table_t *efi_system_table;
  extern u32 image_offset;
-static efi_loaded_image_t *image = NULL;
+static efi_loaded_image_t *image __section(".data");

  extern char _head[], _ehead[];
  extern char _compressed[], _ecompressed[];
