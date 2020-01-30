Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6813914E38B
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgA3UEq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42907 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3UEp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so4200546qke.9;
        Thu, 30 Jan 2020 12:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqydHU85bvvWn1OJe8yhKq7Ls97Ytffjp/MKGxfsBpI=;
        b=Gb53Gn/edCLgxBAREpQLiNgecu2I54UIzdKtDymF9421ZuCmDtOgkFKd3DNxfU8+4e
         mv+KYRbM0O5Q/VOuemmQmXbZvdm0OIE0VmaPeZt7NXKOgYAish3mT+pSrnTbH0XrI0oN
         CIHJ0W3E5gJ/eiQWj2cUoUXSE5b9yWonyP81pPgSdXvd+qhB30tLUZneupBTkjOq4mVX
         iHtzGpiUFEvrGfmxWMsl5cWwtmUGbWMhZmUhcaZnHP8tJVPm/Msc/HmOvAojZVbHQJ08
         c/bKjQ3oAYeuri5t/cUuxVrxiDMTZNxnffXe3T9kSmGSappx31FBuElgu4dyPcCFFsWJ
         i2JA==
X-Gm-Message-State: APjAAAXhD89Jl9Yrf61pZldgyAwGMdIJTSCD4b2NQieq9E9yeNJ6IPJL
        fv73BEZ4gvdAt2yaGrST9KE=
X-Google-Smtp-Source: APXvYqyiHqbOtHebuX5AOvef45bQiRx886hofKxHoAMlQ9CNxgL18VeszY2xyz5D72LThs/ArNiLvg==
X-Received: by 2002:a05:620a:16d3:: with SMTP id a19mr6359995qkn.427.1580414684510;
        Thu, 30 Jan 2020 12:04:44 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/8] efi/x86: Allocate the GDT pointer on the stack
Date:   Thu, 30 Jan 2020 15:04:34 -0500
Message-Id: <20200130200440.1796058-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The GDT pointer isn't needed after loading it into GDTR, so there is no
need to dynamically allocate it.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index f89caae60057..a0a2fd0528af 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -713,7 +713,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 			     efi_system_table_t *sys_table_arg,
 			     struct boot_params *boot_params)
 {
-	struct desc_ptr *gdt = NULL;
+	struct desc_ptr gdt;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	struct desc_struct *desc;
@@ -754,15 +754,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 
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
+	gdt.size = 0x800;
+	status = efi_low_alloc(gdt.size, 8, (unsigned long *)&gdt.address);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate memory for 'gdt'\n");
 		goto fail;
@@ -794,8 +787,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
-	memset((char *)gdt->address, 0x0, gdt->size);
-	desc = (struct desc_struct *)gdt->address;
+	memset((char *)gdt.address, 0x0, gdt.size);
+	desc = (struct desc_struct *)gdt.address;
 
 	/* The first GDT is a dummy. */
 	desc++;
@@ -879,7 +872,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 	}
 
 	raw_local_irq_disable();
-	native_load_gdt(gdt);
+	native_load_gdt(&gdt);
 
 	return boot_params;
 fail:
-- 
2.24.1

