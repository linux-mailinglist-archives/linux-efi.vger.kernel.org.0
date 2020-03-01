Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C078B174EAC
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 18:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCARPQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 12:15:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37916 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCARPP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 12:15:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id h22so2487594qke.5
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j1CsMuYTE6EoIcNY8zZ7F2oq51IRyUcY204jkVXcn9g=;
        b=Vha2IKV+TIwBCfMX7/AdWgKTpkUeSlXzrrJnaxMdn9ZPNmydyFccjjbN9aKnLcU8aG
         AiXCK2p6EqrYTt1u7N9C19pKeee+ocmP1O5whMfhN1BrxnpXJ/89k44VpSKWP11lm45h
         1e09xhQ7Ys3duPyAJShaXm1UK7WZ+EuKlSOkK0PNC26flhy7SeeZ+MJNJtevwGcuIhby
         AJ35TH/tT2FKLUk1Qnk0EKaJlz4VmWzvuV8tG1ZpRVuPzzqpx0UeVgcc373dVghXfIlZ
         69wc5wElfRKQfICiH9AFfx0HUIc4m9NDryyWRe3YgzXbLKawEckvyRy15mhS50qw+EAy
         fXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1CsMuYTE6EoIcNY8zZ7F2oq51IRyUcY204jkVXcn9g=;
        b=aQatyV4U+dSOkJni3sr3YOFPYjMoKvINc7KlwysRdTK97KfRAzMUSU55RWgp6yNtvQ
         U4MFCKVTV2fMrMLWCOAFGj0lKGmaYc18J94qZUKY8FXpHCBwgAgxPXFi4ON86esN0nc4
         XBddjKycza2BThfCHVZsR3JDNt8QzEOZCJPLWZbdZtaTkn8y8z2wOUgqM9tAAHrghJ/g
         Jo8stm4ykL7ibJ7kPHNfu6NSQJjcGnFRjZSFQcw51nJJaoSLsjHO3PJVHos4Ui1D23HF
         RlUPIqI4cuhuYZ61fcwIdPdq/tLDkltW2jN+DTwiBU5iRoSTMrDJLXwTt8ccXwPpxJ17
         ra1Q==
X-Gm-Message-State: ANhLgQ2OdwhXfJZTgUdy/nZZqlyDF6ChCb4lt8Wh72oi5x/XDgf8zQ/P
        u3dwSWu9W7e/v3j0ZnNQrro=
X-Google-Smtp-Source: ADFU+vvNceVAEHmtMOC2arpr+LAOZeHU/WTKCnlXckHq6QqmbJH9QmnXsOj5A+jyNTiL+acTEJQWXg==
X-Received: by 2002:a05:620a:1345:: with SMTP id c5mr1122448qkl.182.1583082912912;
        Sun, 01 Mar 2020 09:15:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m17sm2039395qke.24.2020.03.01.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 09:15:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 1 Mar 2020 12:15:10 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, hdegoede@redhat.com,
        nivedita@alum.mit.edu, x86@kernel.org
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200301171509.GA1845222@rani.riverdale.lan>
References: <20200222155519.23550-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20200222155519.23550-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Feb 22, 2020 at 04:55:13PM +0100, Ard Biesheuvel wrote:
> This series is another part of my effort to reduce the level of knowledge
> on the part of the bootloader or firmware of internal per-architecture
> details regarding where/how the kernel is loaded and where its initrd and
> other context data are passed.
> 
...
> 
> What remains is mixed mode boot, which also needs the EFI handover protocol
> regardless of whether an initrd is loaded or not. So let's get rid of that
> requirement, and take advantage of the fact that EDK2 based firmware does
> support LoadImage() for X64 binaries on IA32 firmware, which means we can
> rely on the secure boot and measured boot checks being performed by the
> firmware. The only thing we need to put on top is a way to discover the
> non-native entrypoint into the binary in a way that does not rely on x86
> specific headers and data structures.
> 
> So let's introduce a new .compat header in the PE/COFF metadata of the
> bzImage, and populate it with a <machine type, entrypoint> tuple, allowing
> a generic EFI loader to decide whether the entrypoint supports its native
> machine type, and invoke it as an ordinary EFI application entrypoint.
> Since we will not be passing a bootparams structure, we need to discover
> the base of the image (which contains the setup header) via the loaded
> image protocol before we can enter the kernel in 32-bit mode at startup_32()
> 
> A loader implementation for OVMF can be found at [2]. Note that this loader
> code is fully generic, and permits mixed mode images to be launched from
> the UEFI shell or other generic components based on LoadImage/Startimage.
> It could be used without modifications if other architectures ever emerge
> that support kernels that can be invoked from a non-native (but cross-type
> supported) loader.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20200206140352.6300-1-ardb@kernel.org/
> [1] https://lore.kernel.org/linux-efi/20200216141104.21477-1-ardb@kernel.org/
> [2] https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic
> 

Hi Ard, I'm getting a kernel panic with this series using the compat
entry point.

What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
and then running it via

$ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
  -drive file=fat:rw:qemu/boot -nographic -m 3072

(The bzImage is in qemu/boot) Then starting it from the UEFI shell.

FS0:\> bzImage earlyprintk=ttyS0,keep efi=debug

First problem is that qemu loads the bzImage above 2Gb causing a very
early crash. Attached patch solves that issue and lets the boot proceed.
However, with KASLR enabled, quite frequently I get the kernel panic in
the attached log. Haven't figured out exactly where it comes from.

Thanks.

--CE+1k2dSO48ffgeK
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="jge-jae.patch"

From 3c3598944a88791ba8d1925791377c39fbaf3c0d Mon Sep 17 00:00:00 2001
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Sat, 29 Feb 2020 19:04:42 -0500
Subject: [PATCH] x86/boot: Use unsigned comparison for addresses

The load address is compared with LOAD_PHYSICAL_ADDR using a signed
comparison currently (using jge instruction).

When loading a 64-bit kernel using the new efi32_pe_entry point added by
commit 97aa276579b2 ("efi/x86: Add true mixed mode entry point into
.compat section") using qemu with -m 3072, the firmware actually loads
us above 2Gb, resulting in a very early crash.

Use jae instruction to perform unsigned comparison instead, as physical
addresses should be considered as unsigned.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 2 +-
 arch/x86/boot/compressed/head_64.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 2f8138b71ea9..2ba924c6ccaf 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(startup_32)
 	notl	%eax
 	andl    %eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fcf8feaa57ea..e3664ef11047 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(startup_32)
 	notl	%eax
 	andl	%eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
@@ -305,7 +305,7 @@ SYM_CODE_START(startup_64)
 	notq	%rax
 	andq	%rax, %rbp
 	cmpq	$LOAD_PHYSICAL_ADDR, %rbp
-	jge	1f
+	jae	1f
 #endif
 	movq	$LOAD_PHYSICAL_ADDR, %rbp
 1:
-- 
2.24.1


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="panic.log"

$ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF-mixed-mode-compat-section.fd -drive file=fat:rw:qemu/boot -nographic -m 3072

UEFI Interactive Shell v2.2                                                                                                                                                                                
EDK II                                                                                                                                                                                                     
UEFI v2.70 (EDK II, 0x00010000)                                                                                                                                                                            
Mapping table
      FS0: Alias(s):HD0a1:;BLK1:                                                                                                                                                                           
          PciRoot(0x0)/Pci(0x1,0x1)/Ata(0x0)/HD(1,MBR,0xBE1AFDFA,0x3F,0xFBFC1)                                                                                                                             
     BLK0: Alias(s):
          PciRoot(0x0)/Pci(0x1,0x1)/Ata(0x0)                                                                                                                                                               
     BLK2: Alias(s):
          PciRoot(0x0)/Pci(0x1,0x1)/Ata(0x0)                                                                                                                                                               
Press ESC in 5 seconds to skip startup.nsh or any other key to continue.                                                                                                                                   
Shell> fs0:                                                                                                                                                                                                
FS0:\> bzImage64 earlyprintk=ttyS0,keep efi=debug                                                                                                                                                          
early console in extract_kernel                                                                                                                                                                            
input_data: 0x0000000002b4d3ac                                                                                                                                                                             
input_len: 0x000000000085e2d6                                                                                                                                                                              
output: 0x0000000001400000                                                                                                                                                                                 
output_len: 0x0000000001f7b8d4                                                                                                                                                                             
kernel_total_size: 0x0000000001c2c000                                                                                                                                                                      
needed_size: 0x0000000002000000                                                                                                                                                                            
trampoline_32bit: 0x000000000009d000                                                                                                                                                                       
booted via startup_64()                                                                                                                                                                                    
Physical KASLR using RDRAND RDTSC...                                                                                                                                                                       
Virtual KASLR using RDRAND RDTSC...                                                                                                                                                                        

Decompressing Linux... Parsing ELF... Performing relocations... done.                                                                                                                                      
Booting the kernel.                                                                                                                                                                                        
[    0.000000] Linux version 5.6.0-rc3+ (arvind@rani) (gcc version 9.2.0 (Gentoo Hardened 9.2.0-r4 p5)) #3 SMP Sun Mar 1 11:49:45 EST 2020                                                                 
[    0.000000] Command line: bzImage64 earlyprintk=ttyS0,keep efi=debug                                                                                                                                    
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'                                                                                                                     
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'                                                                                                                                    
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 bytes, using 'standard' format.                                                                                                   
[    0.000000] BIOS-provided physical RAM map:                                                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000000805fff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x0000000000806000-0x0000000000807fff] ACPI NVS                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x0000000000808000-0x000000000080ffff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x0000000000900000-0x00000000be933fff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x00000000be934000-0x00000000be945fff] ACPI NVS                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000be946000-0x00000000be960fff] reserved                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000be961000-0x00000000bea6bfff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x00000000bea6c000-0x00000000beb1afff] reserved                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000beb1b000-0x00000000bfb9afff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x00000000bfb9b000-0x00000000bfbf2fff] reserved                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000bfbf3000-0x00000000bfbfafff] ACPI data                                                                                                                            
[    0.000000] BIOS-e820: [mem 0x00000000bfbfb000-0x00000000bfbfefff] ACPI NVS                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000bfbff000-0x00000000bfef3fff] usable                                                                                                                               
[    0.000000] BIOS-e820: [mem 0x00000000bfef4000-0x00000000bff77fff] reserved                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000bff78000-0x00000000bfffffff] ACPI NVS                                                                                                                             
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved                                                                                                                             
[    0.000000] printk: console [earlyser0] enabled                                                                                                                                                         
[    0.000000] NX (Execute Disable) protection: active                                                                                                                                                     
[    0.000000] extended physical RAM map:                                                                                                                                                                  
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000000805fff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x0000000000806000-0x0000000000807fff] ACPI NVS                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x0000000000808000-0x000000000080ffff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x0000000000900000-0x00000000be58700f] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000be587010-0x00000000be5c1a4f] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000be5c1a50-0x00000000be5e800f] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000be5e8010-0x00000000be5f184f] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000be5f1850-0x00000000be933fff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000be934000-0x00000000be945fff] ACPI NVS                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000be946000-0x00000000be960fff] reserved                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000be961000-0x00000000bea6bfff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000bea6c000-0x00000000beb1afff] reserved                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000beb1b000-0x00000000bfb9afff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000bfb9b000-0x00000000bfbf2fff] reserved                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000bfbf3000-0x00000000bfbfafff] ACPI data                                                                                                                   
[    0.000000] reserve setup_data: [mem 0x00000000bfbfb000-0x00000000bfbfefff] ACPI NVS                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000bfbff000-0x00000000bfef3fff] usable                                                                                                                      
[    0.000000] reserve setup_data: [mem 0x00000000bfef4000-0x00000000bff77fff] reserved                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000bff78000-0x00000000bfffffff] ACPI NVS                                                                                                                    
[    0.000000] reserve setup_data: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved                                                                                                                    
[    0.000000] efi: EFI v2.70 by EDK II                                                                                                                                                                    
[    0.000000] efi:  SMBIOS=0xbfbcc000  ACPI=0xbfbfa000  ACPI 2.0=0xbfbfa014  MEMATTR=0xbe649190                                                                                                           
[    0.000000] efi: mem00: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000000fff] (0MB)                                                              
[    0.000000] efi: mem01: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000001000-0x000000000009ffff] (0MB)                                                              
[    0.000000] efi: mem02: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000100000-0x0000000000805fff] (7MB)                                                              
[    0.000000] efi: mem03: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000806000-0x0000000000807fff] (0MB)                                                              
[    0.000000] efi: mem04: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000808000-0x000000000080ffff] (0MB)                                                              
[    0.000000] efi: mem05: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000810000-0x00000000008fffff] (0MB)                                                              
[    0.000000] efi: mem06: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000900000-0x00000000013fffff] (11MB)                                                             
[    0.000000] efi: mem07: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000001400000-0x00000000033e5fff] (31MB)                                                             
[    0.000000] efi: mem08: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000033e6000-0x00000000b9d8dfff] (2921MB)                                                           
[    0.000000] efi: mem09: [Loader Code        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000b9d8e000-0x00000000bbf77fff] (33MB)                                                             
[    0.000000] efi: mem10: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bbf78000-0x00000000bbf97fff] (0MB)                                                              
[    0.000000] efi: mem11: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bbf98000-0x00000000be49bfff] (37MB)                                                             
[    0.000000] efi: mem12: [Loader Code        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be49c000-0x00000000be56dfff] (0MB)                                                              
[    0.000000] efi: mem13: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be56e000-0x00000000be586fff] (0MB)                                                              
[    0.000000] efi: mem14: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be587000-0x00000000be5c1fff] (0MB)                                                              
[    0.000000] efi: mem15: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5c2000-0x00000000be5dffff] (0MB)                                                              
[    0.000000] efi: mem16: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5e0000-0x00000000be5e6fff] (0MB)                                                              
[    0.000000] efi: mem17: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5e7000-0x00000000be5f7fff] (0MB)                                                              
[    0.000000] efi: mem18: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5f8000-0x00000000be7ebfff] (1MB)                                                              
[    0.000000] efi: mem19: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be7ec000-0x00000000be933fff] (1MB)                                                              
[    0.000000] efi: mem20: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be934000-0x00000000be945fff] (0MB)                                                              
[    0.000000] efi: mem21: [Reserved           |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be946000-0x00000000be960fff] (0MB)                                                              
[    0.000000] efi: mem22: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be961000-0x00000000bea6bfff] (1MB)                                                              
[    0.000000] efi: mem23: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea6c000-0x00000000bea70fff] (0MB)                                                              
[    0.000000] efi: mem24: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea71000-0x00000000bea75fff] (0MB)                                                              
[    0.000000] efi: mem25: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea76000-0x00000000bea7afff] (0MB)                                                              
[    0.000000] efi: mem26: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea7b000-0x00000000bea7ffff] (0MB)                                                              
[    0.000000] efi: mem27: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea80000-0x00000000bea84fff] (0MB)                                                              
[    0.000000] efi: mem28: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea85000-0x00000000bea8bfff] (0MB)                                                              
[    0.000000] efi: mem29: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea8c000-0x00000000beb1afff] (0MB)                                                              
[    0.000000] efi: mem30: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000beb1b000-0x00000000bfa1afff] (15MB)                                                             
[    0.000000] efi: mem31: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfa1b000-0x00000000bfb9afff] (1MB)                                                              
[    0.000000] efi: mem32: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfb9b000-0x00000000bfbcafff] (0MB)                                                              
[    0.000000] efi: mem33: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbcb000-0x00000000bfbeefff] (0MB)                                                              
[    0.000000] efi: mem34: [Reserved           |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbef000-0x00000000bfbf2fff] (0MB)                                                              
[    0.000000] efi: mem35: [ACPI Reclaim Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbf3000-0x00000000bfbfafff] (0MB)                                                              
[    0.000000] efi: mem36: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbfb000-0x00000000bfbfefff] (0MB)                                                              
[    0.000000] efi: mem37: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbff000-0x00000000bfdfffff] (2MB)                                                              
[    0.000000] efi: mem38: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe00000-0x00000000bfe89fff] (0MB)                                                              
[    0.000000] efi: mem39: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe8a000-0x00000000bfea9fff] (0MB)                                                              
[    0.000000] efi: mem40: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfeaa000-0x00000000bfeccfff] (0MB)                                                              
[    0.000000] efi: mem41: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfecd000-0x00000000bfed5fff] (0MB)                                                              
[    0.000000] efi: mem42: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfed6000-0x00000000bfef3fff] (0MB)                                                              
[    0.000000] efi: mem43: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfef4000-0x00000000bff77fff] (0MB)                                                              
[    0.000000] efi: mem44: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bff78000-0x00000000bfffffff] (0MB)                                                              
[    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)                                                              
[    0.000000] SMBIOS 2.8 present.                                                                                                                                                                         
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015                                                                                                                          
[    0.000000] tsc: Fast TSC calibration using PIT                                                                                                                                                         
[    0.000000] tsc: Detected 2195.098 MHz processor                                                                                                                                                        
[    0.001418] last_pfn = 0xbfef4 max_arch_pfn = 0x400000000                                                                                                                                               
[    0.002451] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT                                                                                                                                
Memory KASLR using RDRAND RDTSC...                                                                                                                                                                         
[    0.019655] check: Scanning 1 areas for low memory corruption                                                                                                                                           
[    0.025410] Secure boot disabled                                                                                                                                                                        
[    0.025847] ACPI: Early table checksum verification disabled                                                                                                                                            
[    0.026363] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )                                                                                                                                           
[    0.026710] ACPI: XSDT 0x00000000BFBF90E8 000044 (v01 BOCHS  BXPCFACP 00000001      01000013)                                                                                                           
[    0.027515] ACPI: FACP 0x00000000BFBF6000 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)                                                                                                           
[    0.028190] ACPI: DSDT 0x00000000BFBF7000 00140B (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)                                                                                                           
[    0.028566] ACPI: FACS 0x00000000BFBFD000 000040                                                                                                                                                        
[    0.028792] ACPI: APIC 0x00000000BFBF5000 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)                                                                                                           
[    0.029091] ACPI: HPET 0x00000000BFBF4000 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)                                                                                                           
[    0.029390] ACPI: BGRT 0x00000000BFBF3000 000038 (v01 INTEL  EDK2     00000002      01000013)                                                                                                           
[    0.031325] No NUMA configuration found                                                                                                                                                                 
[    0.031502] Faking a node at [mem 0x0000000000000000-0x00000000bfef3fff]                                                                                                                                
[    0.032286] NODE_DATA(0) allocated [mem 0xbfe86000-0xbfe89fff]                                                                                                                                          
[    0.034426] Zone ranges:                                                                                                                                                                                
[    0.034560]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]                                                                                                                                      
[    0.034797]   DMA32    [mem 0x0000000001000000-0x00000000bfef3fff]                                                                                                                                      
[    0.035028]   Normal   empty                                                                                                                                                                            
[    0.035155] Movable zone start for each node                                                                                                                                                            
[    0.035313] Early memory node ranges                                                                                                                                                                    
[    0.035461]   node   0: [mem 0x0000000000001000-0x000000000009ffff]                                                                                                                                     
[    0.035796]   node   0: [mem 0x0000000000100000-0x0000000000805fff]                                                                                                                                     
[    0.036007]   node   0: [mem 0x0000000000808000-0x000000000080ffff]                                                                                                                                     
[    0.036228]   node   0: [mem 0x0000000000900000-0x00000000be933fff]                                                                                                                                     
[    0.036459]   node   0: [mem 0x00000000be961000-0x00000000bea6bfff]                                                                                                                                     
[    0.036671]   node   0: [mem 0x00000000beb1b000-0x00000000bfb9afff]                                                                                                                                     
[    0.036876]   node   0: [mem 0x00000000bfbff000-0x00000000bfef3fff]                                                                                                                                     
[    0.037937] Zeroed struct page in unavailable ranges: 927 pages                                                                                                                                         
[    0.038083] Initmem setup node 0 [mem 0x0000000000001000-0x00000000bfef3fff]                                                                                                                            
[    0.119644] ACPI: PM-Timer IO Port: 0xb008                                                                                                                                                              
[    0.120357] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])                                                                                                                                           
[    0.120983] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23                                                                                                                              
[    0.121322] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)                                                                                                                                    
[    0.121779] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)                                                                                                                                 
[    0.122002] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)                                                                                                                                 
[    0.122319] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)                                                                                                                               
[    0.122546] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)                                                                                                                               
[    0.122976] Using ACPI (MADT) for SMP configuration information                                                                                                                                         
[    0.123218] ACPI: HPET id: 0x8086a201 base: 0xfed00000                                                                                                                                                  
[    0.124945] smpboot: Allowing 1 CPUs, 0 hotplug CPUs                                                                                                                                                    
[    0.126014] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]                                                                                                                      
[    0.126292] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]                                                                                                                      
[    0.126547] PM: hibernation: Registered nosave memory: [mem 0x00806000-0x00807fff]                                                                                                                      
[    0.126796] PM: hibernation: Registered nosave memory: [mem 0x00810000-0x008fffff]                                                                                                                      
[    0.127046] PM: hibernation: Registered nosave memory: [mem 0xbe587000-0xbe587fff]                                                                                                                      
[    0.127315] PM: hibernation: Registered nosave memory: [mem 0xbe5c1000-0xbe5c1fff]                                                                                                                      
[    0.127593] PM: hibernation: Registered nosave memory: [mem 0xbe5e8000-0xbe5e8fff]                                                                                                                      
[    0.127864] PM: hibernation: Registered nosave memory: [mem 0xbe5f1000-0xbe5f1fff]                                                                                                                      
[    0.128162] PM: hibernation: Registered nosave memory: [mem 0xbe640000-0xbe648fff]                                                                                                                      
[    0.128446] PM: hibernation: Registered nosave memory: [mem 0xbe934000-0xbe945fff]                                                                                                                      
[    0.128735] PM: hibernation: Registered nosave memory: [mem 0xbe946000-0xbe960fff]                                                                                                                      
[    0.128975] PM: hibernation: Registered nosave memory: [mem 0xbea6c000-0xbeb1afff]                                                                                                                      
[    0.129234] PM: hibernation: Registered nosave memory: [mem 0xbfb9b000-0xbfbf2fff]                                                                                                                      
[    0.129495] PM: hibernation: Registered nosave memory: [mem 0xbfbf3000-0xbfbfafff]                                                                                                                      
[    0.129757] PM: hibernation: Registered nosave memory: [mem 0xbfbfb000-0xbfbfefff]                                                                                                                      
[    0.130125] [mem 0xc0000000-0xffbfffff] available for PCI devices                                                                                                                                       
[    0.130766] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns                                                                                     
[    0.141134] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1                                                                                                                      
[    0.147826] percpu: Embedded 53 pages/cpu s176472 r8192 d32424 u2097152                                                                                                                                 
[    0.150221] Built 1 zonelists, mobility grouping on.  Total pages: 771412                                                                                                                               
[    0.150451] Policy zone: DMA32                                                                                                                                                                          
[    0.150704] Kernel command line: bzImage64 earlyprintk=ttyS0,keep efi=debug                                                                                                                             
[    0.161459] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)                                                                                                                  
[    0.231164] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)                                                                                                                    
[    0.233207] mem auto-init: stack:off, heap alloc:off, heap free:off                                                                                                                                     
[    0.253204] Memory: 3024044K/3142020K available (14340K kernel code, 1520K rwdata, 3304K rodata, 1184K init, 1112K bss, 117976K reserved, 0K cma-reserved)                                              
[    0.257804] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1                                                                                                                                  
[    0.259019] Kernel/User page tables isolation: enabled                                                                                                                                                  
[    0.267142] rcu: Hierarchical RCU implementation.                                                                                                                                                       
[    0.267376] rcu:     RCU event tracing is enabled.                                                                                                                                                      
[    0.267561] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.                                                                                                                              
[    0.267915] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.                                                                                                                     
[    0.268225] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1                                                                                                                                
[    0.270606] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16                                                                                                                                          
[    0.278938] random: get_random_bytes called from start_kernel+0x546/0x716 with crng_init=0                                                                                                              
[    0.281978] Console: colour dummy device 80x25                                                                                                                                                          
[    0.285564] printk: console [tty0] enabled                                                                                                                                                              
[    0.286640] ACPI: Core revision 20200110                                                                                                                                                                
[    0.290843] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns                                                                                                     
[    0.294895] APIC: Switch to symmetric I/O mode setup                                                                                                                                                    
[    0.298636] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1                                                                                                                                        
[    0.304234] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fa41c1cc38, max_idle_ns: 440795210299 ns                                                                                    
[    0.305191] Calibrating delay loop (skipped), value calculated using timer frequency.. 4390.19 BogoMIPS (lpj=2195098)                                                                                   
[    0.305662] pid_max: default: 32768 minimum: 301                                                                                                                                                        
[    0.311267] efi: EFI runtime memory map:                                                                                                                                                                
[    0.311460] efi: mem00: [Boot Code          |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000000fff] (0MB)                                                              
[    0.311881] efi: mem01: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000001000-0x000000000009ffff] (0MB)                                                              
[    0.312000] efi: mem02: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000100000-0x0000000000805fff] (7MB)                                                              
[    0.312431] efi: mem03: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000808000-0x000000000080ffff] (0MB)                                                              
[    0.312998] efi: mem04: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000900000-0x00000000013fffff] (11MB)                                                             
[    0.313425] efi: mem05: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000001400000-0x00000000033e5fff] (31MB)                                                             
[    0.313997] efi: mem06: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000033e6000-0x00000000b9d8dfff] (2921MB)                                                           
[    0.314431] efi: mem07: [Loader Code        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000b9d8e000-0x00000000bbf77fff] (33MB)                                                             
[    0.314998] efi: mem08: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bbf78000-0x00000000bbf97fff] (0MB)                                                              
[    0.315463] efi: mem09: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bbf98000-0x00000000be49bfff] (37MB)                                                             
[    0.315998] efi: mem10: [Loader Code        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be49c000-0x00000000be56dfff] (0MB)                                                              
[    0.316459] efi: mem11: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be56e000-0x00000000be586fff] (0MB)                                                              
[    0.316878] efi: mem12: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be587000-0x00000000be5c1fff] (0MB)                                                              
[    0.316996] efi: mem13: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5c2000-0x00000000be5dffff] (0MB)                                                              
[    0.317402] efi: mem14: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5e0000-0x00000000be5e6fff] (0MB)                                                              
[    0.318015] efi: mem15: [Loader Data        |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5e7000-0x00000000be5f7fff] (0MB)                                                              
[    0.318496] efi: mem16: [Boot Data          |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be5f8000-0x00000000be7ebfff] (1MB)                                                              
[    0.319015] efi: mem17: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be7ec000-0x00000000be933fff] (1MB)                                                              
[    0.319430] efi: mem18: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000be961000-0x00000000bea6bfff] (1MB)                                                              
[    0.319997] efi: mem19: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea6c000-0x00000000bea70fff] (0MB)                                                              
[    0.320423] efi: mem20: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea71000-0x00000000bea75fff] (0MB)                                                              
[    0.320997] efi: mem21: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea76000-0x00000000bea7afff] (0MB)                                                              
[    0.321425] efi: mem22: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea7b000-0x00000000bea7ffff] (0MB)                                                              
[    0.321843] efi: mem23: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea80000-0x00000000bea84fff] (0MB)                                                              
[    0.321998] efi: mem24: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea85000-0x00000000bea8bfff] (0MB)                                                              
[    0.322433] efi: mem25: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bea8c000-0x00000000beb1afff] (0MB)                                                              
[    0.322996] efi: mem26: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000beb1b000-0x00000000bfa1afff] (15MB)                                                             
[    0.323376] efi: mem27: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfa1b000-0x00000000bfb9afff] (1MB)                                                              
[    0.323997] efi: mem28: [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfb9b000-0x00000000bfbcafff] (0MB)                                                              
[    0.324390] efi: mem29: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbcb000-0x00000000bfbeefff] (0MB)                                                              
[    0.324754] efi: mem30: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfbff000-0x00000000bfdfffff] (2MB)                                                              
[    0.325020] efi: mem31: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe00000-0x00000000bfe89fff] (0MB)                                                              
[    0.325422] efi: mem32: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe8a000-0x00000000bfea9fff] (0MB)                                                              
[    0.326015] efi: mem33: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfeaa000-0x00000000bfeccfff] (0MB)                                                              
[    0.326457] efi: mem34: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfecd000-0x00000000bfed5fff] (0MB)                                                              
[    0.326997] efi: mem35: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfed6000-0x00000000bfef3fff] (0MB)                                                              
[    0.327436] efi: mem36: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfef4000-0x00000000bff77fff] (0MB)                                                              
[    0.327997] efi: mem37: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)                                                              
[    0.334217] efi: memattr: Processing EFI Memory Attributes table:                                                                                                                                       
[    0.334653] efi: memattr:  0x0000bea6c000-0x0000bea70fff [Runtime Data       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]                                                                                 
[    0.335239] efi: memattr:  0x0000bea71000-0x0000bea71fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]                                                                                 
[    0.335761] efi: memattr:  0x0000bea72000-0x0000bea73fff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]                                                                                 
[    0.336162] efi: memattr:  0x0000bea74000-0x0000bea75fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.337072] efi: memattr:  0x0000bea76000-0x0000bea7afff [Runtime Data       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.337634] efi: memattr:  0x0000bea7b000-0x0000bea7bfff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.338127] efi: memattr:  0x0000bea7c000-0x0000bea7dfff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.338647] efi: memattr:  0x0000bea7e000-0x0000bea7ffff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.339136] efi: memattr:  0x0000bea80000-0x0000bea84fff [Runtime Data       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.339636] efi: memattr:  0x0000bea85000-0x0000bea85fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.340117] efi: memattr:  0x0000bea86000-0x0000bea89fff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.341013] efi: memattr:  0x0000bea8a000-0x0000bea8bfff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.341511] efi: memattr:  0x0000bea8c000-0x0000beb1afff [Runtime Data       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.342163] efi: memattr:  0x0000bfb9b000-0x0000bfb9efff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.342682] efi: memattr:  0x0000bfb9f000-0x0000bfba1fff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.343138] efi: memattr:  0x0000bfba2000-0x0000bfba4fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.343620] efi: memattr:  0x0000bfba5000-0x0000bfbaffff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.344164] efi: memattr:  0x0000bfbb0000-0x0000bfbb2fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.344727] efi: memattr:  0x0000bfbb3000-0x0000bfbb5fff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.345118] efi: memattr:  0x0000bfbb6000-0x0000bfbb8fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.346013] efi: memattr:  0x0000bfbb9000-0x0000bfbbbfff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.346548] efi: memattr:  0x0000bfbbc000-0x0000bfbbefff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.347122] efi: memattr:  0x0000bfbbf000-0x0000bfbc1fff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.347626] efi: memattr:  0x0000bfbc2000-0x0000bfbc4fff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.348138] efi: memattr:  0x0000bfbc5000-0x0000bfbc8fff [Runtime Code       |RUN|  |  |  |  |  |  |RO|   |  |  |  |  ]
[    0.348660] efi: memattr:  0x0000bfbc9000-0x0000bfbcafff [Runtime Code       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.349138] efi: memattr:  0x0000bfbcb000-0x0000bfbeefff [Runtime Data       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.349724] efi: memattr:  0x0000bfef4000-0x0000bff77fff [Runtime Data       |RUN|  |  |  |XP|  |  |  |   |  |  |  |  ]
[    0.350974] BUG: unable to handle page fault for address: 00000000a6403e90
[    0.350974] #PF: supervisor read access in kernel mode
[    0.350974] #PF: error_code(0x0000) - not-present page
[    0.350974] PGD bd890063 P4D bd890063 PUD bd896063 PMD 0 
[    0.350974] Oops: 0000 [#1] SMP PTI
[    0.350974] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc3+ #3
[    0.350974] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[    0.350974] RIP: 0008:0xbfba558d
[    0.350974] Code: 53 52 e8 77 fd ff ff 8b 5d 08 85 db 75 1c 84 c0 74 18 50 68 71 d8 ba bf 68 ba 00 00 00 68 5c cd ba bf e8 09 ff ff ff 83 c4 10 <8b> 03 8b 53 04 8b 5d fc c9 c3 55 89 e5 57 56 53 83 ec 28 8b 5d 08
[    0.350974] RSP: 0018:00000000bd8a0ed0 EFLAGS: 00000086
[    0.350974] RAX: 00000000bfbcf001 RBX: 00000000a6403e90 RCX: 0000000000000001
[    0.350974] RDX: 0000000011d293ca RSI: 00000000a600a370 RDI: 000000008be4df61
[    0.350974] RBP: 00000000bd8a0ed8 R08: 0000000000000000 R09: 0000000000000000
[    0.350974] R10: ffffffff92612840 R11: 0000000000000048 R12: ffffffff92600000
[    0.350974] R13: 0000000000000000 R14: 00000000a600a370 R15: 0000000000000286
[    0.350974] FS:  0000000000000000(0000) GS:ffff93c23e200000(0000) knlGS:0000000000000000
[    0.350974] CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
[    0.350974] CR2: 00000000a6403e90 CR3: 00000000bd8ca000 CR4: 00000000000406b0
[    0.350974] Call Trace:
[    0.350974] Modules linked in:
[    0.350974] CR2: 00000000a6403e90
[    0.350974] ---[ end trace 65970dab9fc6be95 ]---
[    0.350974] RIP: 0008:0xbfba558d
[    0.350974] Code: 53 52 e8 77 fd ff ff 8b 5d 08 85 db 75 1c 84 c0 74 18 50 68 71 d8 ba bf 68 ba 00 00 00 68 5c cd ba bf e8 09 ff ff ff 83 c4 10 <8b> 03 8b 53 04 8b 5d fc c9 c3 55 89 e5 57 56 53 83 ec 28 8b 5d 08
[    0.350974] RSP: 0018:00000000bd8a0ed0 EFLAGS: 00000086
[    0.350974] RAX: 00000000bfbcf001 RBX: 00000000a6403e90 RCX: 0000000000000001
[    0.350974] RDX: 0000000011d293ca RSI: 00000000a600a370 RDI: 000000008be4df61
[    0.350974] RBP: 00000000bd8a0ed8 R08: 0000000000000000 R09: 0000000000000000
[    0.350974] R10: ffffffff92612840 R11: 0000000000000048 R12: ffffffff92600000
[    0.350974] R13: 0000000000000000 R14: 00000000a600a370 R15: 0000000000000286
[    0.350974] FS:  0000000000000000(0000) GS:ffff93c23e200000(0000) knlGS:0000000000000000
[    0.350974] CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
[    0.350974] CR2: 00000000a6403e90 CR3: 00000000bd8ca000 CR4: 00000000000406b0
[    0.350974] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.350974] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

--CE+1k2dSO48ffgeK--
