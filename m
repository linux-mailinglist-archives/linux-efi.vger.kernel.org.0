Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65C714FE7B
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBBROA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:14:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42694 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgBBROA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:14:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so9601675qtq.9;
        Sun, 02 Feb 2020 09:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nE3tnB4sz785hw5rbejF4tfz+IwOjrONd7iKRpSiDW4=;
        b=cCpcclVECLtf/mzsi7r+zrxrQNe20fBNqPWzjRE4EmG1dzHUHQzw9ihCgXEwN3TU3D
         zwShAbg7Q53DPsu1vd8VB6ZglfbuP47Bu581Mq+/5PTlBoSNkNfVZVzWtj2f4zEBDeg8
         mbtoqVBkzwFJAy2AdXgFCi+w9JawJ00bWnwjh5kMo4DmSJ9PdoIZ8Lzj1T0iED2Hfidm
         Z9DGUi7l6MzQNeFWMeR+1Dz73TxihbjVtPiWUysmGvL3VLikctZQJbTg1hU9ZWb+hCYB
         f5A9HjtrrpQYAd6XOAWntHDOtifEg9dJ0LE7x1lNEmkWHsuthXM/akSbOaNA6U0gnPAp
         bywA==
X-Gm-Message-State: APjAAAUjIBZmlSvaZkywq0CIu56xaugRCkd2ak1SwPcs6zZP8au5xS5I
        ki2Rd/6/1yzQVyhxsympWmg=
X-Google-Smtp-Source: APXvYqywrKwTAqSUK7OknHSth/qSMhWR8q5OnxRqruS3jS1/r4EGgJPZ2ZEpHcnud/nfrcB59shC4A==
X-Received: by 2002:ac8:835:: with SMTP id u50mr20429296qth.15.1580663638947;
        Sun, 02 Feb 2020 09:13:58 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:58 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] efi/x86: Remove GDT setup from efi_main
Date:   Sun,  2 Feb 2020 12:13:51 -0500
Message-Id: <20200202171353.3736319-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202171353.3736319-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 64-bit kernel will already load a GDT in startup_64, which is the
next function to execute after return from efi_main.

Add GDT setup code to the 32-bit kernel's startup_32 as well. Doing it
in the head code has the advantage that we can avoid potentially
corrupting the GDT during copy/decompression. This also removes
dependence on having a specific GDT layout setup by the bootloader.

Both startup_32 and startup_64 now clear interrupts on entry, so we can
remove that from efi_main as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c   | 103 -----------------------------
 arch/x86/boot/compressed/head_32.S |  40 +++++++++--
 2 files changed, 34 insertions(+), 109 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 287393d725f0..c92fe0b75cec 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -712,10 +712,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 			     efi_system_table_t *sys_table_arg,
 			     struct boot_params *boot_params)
 {
-	struct desc_ptr *gdt = NULL;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
-	struct desc_struct *desc;
 	unsigned long cmdline_paddr;
 
 	sys_table = sys_table_arg;
@@ -753,20 +751,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params);
 
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*gdt),
-			     (void **)&gdt);
-	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate memory for 'gdt' structure\n");
-		goto fail;
-	}
-
-	gdt->size = 0x800;
-	status = efi_low_alloc(gdt->size, 8, (unsigned long *)&gdt->address);
-	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate memory for 'gdt'\n");
-		goto fail;
-	}
-
 	/*
 	 * If the kernel isn't already loaded at the preferred load
 	 * address, relocate it.
@@ -793,93 +777,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
-	memset((char *)gdt->address, 0x0, gdt->size);
-	desc = (struct desc_struct *)gdt->address;
-
-	/* The first GDT is a dummy. */
-	desc++;
-
-	if (IS_ENABLED(CONFIG_X86_64)) {
-		/* __KERNEL32_CS */
-		desc->limit0	= 0xffff;
-		desc->base0	= 0x0000;
-		desc->base1	= 0x0000;
-		desc->type	= SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
-		desc->s		= DESC_TYPE_CODE_DATA;
-		desc->dpl	= 0;
-		desc->p		= 1;
-		desc->limit1	= 0xf;
-		desc->avl	= 0;
-		desc->l		= 0;
-		desc->d		= SEG_OP_SIZE_32BIT;
-		desc->g		= SEG_GRANULARITY_4KB;
-		desc->base2	= 0x00;
-
-		desc++;
-	} else {
-		/* Second entry is unused on 32-bit */
-		desc++;
-	}
-
-	/* __KERNEL_CS */
-	desc->limit0	= 0xffff;
-	desc->base0	= 0x0000;
-	desc->base1	= 0x0000;
-	desc->type	= SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
-	desc->s		= DESC_TYPE_CODE_DATA;
-	desc->dpl	= 0;
-	desc->p		= 1;
-	desc->limit1	= 0xf;
-	desc->avl	= 0;
-
-	if (IS_ENABLED(CONFIG_X86_64)) {
-		desc->l = 1;
-		desc->d = 0;
-	} else {
-		desc->l = 0;
-		desc->d = SEG_OP_SIZE_32BIT;
-	}
-	desc->g		= SEG_GRANULARITY_4KB;
-	desc->base2	= 0x00;
-	desc++;
-
-	/* __KERNEL_DS */
-	desc->limit0	= 0xffff;
-	desc->base0	= 0x0000;
-	desc->base1	= 0x0000;
-	desc->type	= SEG_TYPE_DATA | SEG_TYPE_READ_WRITE;
-	desc->s		= DESC_TYPE_CODE_DATA;
-	desc->dpl	= 0;
-	desc->p		= 1;
-	desc->limit1	= 0xf;
-	desc->avl	= 0;
-	desc->l		= 0;
-	desc->d		= SEG_OP_SIZE_32BIT;
-	desc->g		= SEG_GRANULARITY_4KB;
-	desc->base2	= 0x00;
-	desc++;
-
-	if (IS_ENABLED(CONFIG_X86_64)) {
-		/* Task segment value */
-		desc->limit0	= 0x0000;
-		desc->base0	= 0x0000;
-		desc->base1	= 0x0000;
-		desc->type	= SEG_TYPE_TSS;
-		desc->s		= 0;
-		desc->dpl	= 0;
-		desc->p		= 1;
-		desc->limit1	= 0x0;
-		desc->avl	= 0;
-		desc->l		= 0;
-		desc->d		= 0;
-		desc->g		= SEG_GRANULARITY_4KB;
-		desc->base2	= 0x00;
-		desc++;
-	}
-
-	asm volatile("cli");
-	asm volatile ("lgdt %0" : : "m" (*gdt));
-
 	return boot_params;
 fail:
 	efi_printk("efi_main() failed!\n");
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index cb2cb91fce45..356060c5332c 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -64,12 +64,6 @@
 SYM_FUNC_START(startup_32)
 	cld
 	cli
-	movl	$__BOOT_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %fs
-	movl	%eax, %gs
-	movl	%eax, %ss
 
 /*
  * Calculate the delta between where we were compiled to run
@@ -84,6 +78,19 @@ SYM_FUNC_START(startup_32)
 1:	popl	%ebp
 	subl	$1b, %ebp
 
+	/* Load new GDT */
+	leal	gdt(%ebp), %eax
+	movl	%eax, 2(%eax)
+	lgdt	(%eax)
+
+	/* Load segment registers with our descriptors */
+	movl	$__BOOT_DS, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	movl	%eax, %ss
+
 /*
  * %ebp contains the address we are loaded at by the boot loader and %ebx
  * contains the address where we should move the kernel image temporarily
@@ -129,6 +136,16 @@ SYM_FUNC_START(startup_32)
 	cld
 	popl	%esi
 
+	/*
+	 * The GDT may get overwritten either during the copy we just did or
+	 * during extract_kernel below. To avoid any issues, repoint the GDTR
+	 * to the new copy of the GDT. EAX still contains the previously
+	 * calculated relocation offset of init_size - _end.
+	 */
+	leal	gdt(%ebx), %edx
+	addl	%eax, 2(%edx)
+	lgdt	(%edx)
+
 /*
  * Jump to the relocated address.
  */
@@ -201,6 +218,17 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%eax
 SYM_FUNC_END(.Lrelocated)
 
+	.data
+	.balign	8
+SYM_DATA_START_LOCAL(gdt)
+	.word	gdt_end - gdt - 1
+	.long	0
+	.word	0
+	.quad	0x0000000000000000	/* Reserved */
+	.quad	0x00cf9a000000ffff	/* __KERNEL_CS */
+	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
+
 /*
  * Stack and heap for uncompression
  */
-- 
2.24.1

