Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6580E14E38F
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgA3UEr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:47 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41767 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3UEr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:47 -0500
Received: by mail-qv1-f68.google.com with SMTP id s7so2122569qvn.8;
        Thu, 30 Jan 2020 12:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGw51eodlDQTRRSZzi3JnU8O8iLU6nDU+Wq4d0dh7bo=;
        b=UiVe1JP7fWb2DZmcErsQQJxQli60rL5a+X24wSnOOGvur2PZg7k2pc5xaERfZ43FLK
         gkYuvJlNdphb3HmrKBN49oC89Oq8mb0WOHDMFdOq63txPXGVe0gzPHpVT5GN5fQNRUG7
         nZK8sE2sp+DcCX8Ao0m5r9JLdm+FU3iIJgry5Nvy04RML9qfY1Uxqbztwe+d/frdWEze
         ntzeGImXhcACmpduJHpskgg9688H6uUvtif4nCn7VyZ7GFZELyewpx14DQ+3TdvO8Eh5
         zNlcT0Iu5D+Ny7uWDKmlNhqU3s7E8zQB8kfoSnAxILW6YZDJHxEQajKebBcOwgZVY9wf
         M6xA==
X-Gm-Message-State: APjAAAUtStCMKiifHYc0Ylh9qL24O9RNv5FQktA6DiU6rZUjT4s7uwzV
        ZreKH9Oit7Dfpqk1uZpoUuqyhTyK
X-Google-Smtp-Source: APXvYqznf9GpVy9+TdlwAAK3iuFfms9+EU0eOpImcQoGzi2p+kZCzxchFcvdwwGhBIftSPWYzaIunA==
X-Received: by 2002:ad4:57c7:: with SMTP id y7mr3631659qvx.174.1580414685274;
        Thu, 30 Jan 2020 12:04:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/8] efi/x86: Factor GDT setup code into a function
Date:   Thu, 30 Jan 2020 15:04:35 -0500
Message-Id: <20200130200440.1796058-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move GDT allocation and definition code into a function in preparation
to cleaning it up a bit.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c | 191 ++++++++++++++++---------------
 1 file changed, 101 insertions(+), 90 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index a0a2fd0528af..066125a18391 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -344,6 +344,105 @@ void setup_graphics(struct boot_params *boot_params)
 	}
 }
 
+static efi_status_t setup_gdt(struct desc_ptr *gdt)
+{
+	efi_status_t status;
+	struct desc_struct *desc;
+
+	gdt->size = 0x800;
+	status = efi_low_alloc(gdt->size, 8, (unsigned long *)&gdt->address);
+	if (status != EFI_SUCCESS) {
+		efi_printk("Failed to allocate memory for 'gdt'\n");
+		return status;
+	}
+
+	memset((char *)gdt->address, 0x0, gdt->size);
+	desc = (struct desc_struct *)gdt->address;
+
+	/* The first GDT is a dummy. */
+	desc++;
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/* __KERNEL32_CS */
+		desc->limit0	= 0xffff;
+		desc->base0	= 0x0000;
+		desc->base1	= 0x0000;
+		desc->type	= SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
+		desc->s		= DESC_TYPE_CODE_DATA;
+		desc->dpl	= 0;
+		desc->p		= 1;
+		desc->limit1	= 0xf;
+		desc->avl	= 0;
+		desc->l		= 0;
+		desc->d		= SEG_OP_SIZE_32BIT;
+		desc->g		= SEG_GRANULARITY_4KB;
+		desc->base2	= 0x00;
+
+		desc++;
+	} else {
+		/* Second entry is unused on 32-bit */
+		desc++;
+	}
+
+	/* __KERNEL_CS */
+	desc->limit0	= 0xffff;
+	desc->base0	= 0x0000;
+	desc->base1	= 0x0000;
+	desc->type	= SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
+	desc->s		= DESC_TYPE_CODE_DATA;
+	desc->dpl	= 0;
+	desc->p		= 1;
+	desc->limit1	= 0xf;
+	desc->avl	= 0;
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		desc->l = 1;
+		desc->d = 0;
+	} else {
+		desc->l = 0;
+		desc->d = SEG_OP_SIZE_32BIT;
+	}
+	desc->g		= SEG_GRANULARITY_4KB;
+	desc->base2	= 0x00;
+	desc++;
+
+	/* __KERNEL_DS */
+	desc->limit0	= 0xffff;
+	desc->base0	= 0x0000;
+	desc->base1	= 0x0000;
+	desc->type	= SEG_TYPE_DATA | SEG_TYPE_READ_WRITE;
+	desc->s		= DESC_TYPE_CODE_DATA;
+	desc->dpl	= 0;
+	desc->p		= 1;
+	desc->limit1	= 0xf;
+	desc->avl	= 0;
+	desc->l		= 0;
+	desc->d		= SEG_OP_SIZE_32BIT;
+	desc->g		= SEG_GRANULARITY_4KB;
+	desc->base2	= 0x00;
+	desc++;
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/* Task segment value */
+		desc->limit0	= 0x0000;
+		desc->base0	= 0x0000;
+		desc->base1	= 0x0000;
+		desc->type	= SEG_TYPE_TSS;
+		desc->s		= 0;
+		desc->dpl	= 0;
+		desc->p		= 1;
+		desc->limit1	= 0x0;
+		desc->avl	= 0;
+		desc->l		= 0;
+		desc->d		= 0;
+		desc->g		= SEG_GRANULARITY_4KB;
+		desc->base2	= 0x00;
+		desc++;
+	}
+
+	return EFI_SUCCESS;
+}
+
 void startup_32(struct boot_params *boot_params);
 
 void __noreturn efi_stub_entry(efi_handle_t handle,
@@ -716,7 +815,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 	struct desc_ptr gdt;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
-	struct desc_struct *desc;
 	unsigned long cmdline_paddr;
 
 	sys_table = sys_table_arg;
@@ -754,12 +852,9 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params);
 
-	gdt.size = 0x800;
-	status = efi_low_alloc(gdt.size, 8, (unsigned long *)&gdt.address);
-	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate memory for 'gdt'\n");
+	status = setup_gdt(&gdt);
+	if (status != EFI_SUCCESS)
 		goto fail;
-	}
 
 	/*
 	 * If the kernel isn't already loaded at the preferred load
@@ -787,90 +882,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
-	memset((char *)gdt.address, 0x0, gdt.size);
-	desc = (struct desc_struct *)gdt.address;
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
 	raw_local_irq_disable();
 	native_load_gdt(&gdt);
 
-- 
2.24.1

