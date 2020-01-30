Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0814E38E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA3UEr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:47 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40649 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgA3UEr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:47 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so2124239qvb.7;
        Thu, 30 Jan 2020 12:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjVUUC9GeSxswqTBmlSIsojDO4ClxU+Z5qhOSfTZCXQ=;
        b=H3uA7Ftx6+48XnMGeqv71zgBeUXyGESqv6QcSNMimAQM1oPZk1dEque9M0E18X0Pub
         d8mmBdiLrpgfQ72I6SLDgqam1YAQDA9MLgvyNODNU2Hqju7CZajAyv4RkkDN9GjpU2V0
         4ySMKq1+BONJwMJDUvxnts36krgHoauJan7hdtzG1PwNLFdlre3VyGCAVbiFm+HVg7gB
         pWjDMkXOyP9JRsDHLckD0x3Q07HvVZV/onhG42GqQqxUawe140BpEZ6EUlvG4Y6LR5Nl
         z1sQ+yZRr+CSzPyX801SpVGmsa8j6D8GmdKGt5L8jrBoQds6DAV7oLFlo0I0us+QwMOM
         bZaw==
X-Gm-Message-State: APjAAAUMFkjPhvc3UkUaCZRYnAq1mX13tPt2bIkZu7epWSs7ms2/rnxL
        vq8f59vwyRIDPSWHh9Rrgs4=
X-Google-Smtp-Source: APXvYqxe0suoxfEIaimYpPwE6XFMaZI9ucPlhsk9xOFgR302sg0dFkfVnRHyUM8uNjBafLAe9Pr7og==
X-Received: by 2002:a05:6214:3a1:: with SMTP id m1mr6292884qvy.77.1580414686037;
        Thu, 30 Jan 2020 12:04:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 4/8] efi/x86: Only setup the GDT for 32-bit kernel
Date:   Thu, 30 Jan 2020 15:04:36 -0500
Message-Id: <20200130200440.1796058-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On a 64-bit kernel, the next function to execute after efi_main returns
is startup_64, which sets up its own GDT, so setting one up in efi_main
is unnecessary.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c | 60 ++++++--------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 066125a18391..a72cfda91d7e 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -346,6 +346,7 @@ void setup_graphics(struct boot_params *boot_params)
 
 static efi_status_t setup_gdt(struct desc_ptr *gdt)
 {
+#ifdef CONFIG_X86_32
 	efi_status_t status;
 	struct desc_struct *desc;
 
@@ -361,30 +362,10 @@ static efi_status_t setup_gdt(struct desc_ptr *gdt)
 
 	/* The first GDT is a dummy. */
 	desc++;
+	/* Second entry is unused on 32-bit */
+	desc++;
 
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
+	/* __BOOT_CS */
 	desc->limit0	= 0xffff;
 	desc->base0	= 0x0000;
 	desc->base1	= 0x0000;
@@ -394,19 +375,13 @@ static efi_status_t setup_gdt(struct desc_ptr *gdt)
 	desc->p		= 1;
 	desc->limit1	= 0xf;
 	desc->avl	= 0;
-
-	if (IS_ENABLED(CONFIG_X86_64)) {
-		desc->l = 1;
-		desc->d = 0;
-	} else {
-		desc->l = 0;
-		desc->d = SEG_OP_SIZE_32BIT;
-	}
+	desc->l		= 0;
+	desc->d		= SEG_OP_SIZE_32BIT;
 	desc->g		= SEG_GRANULARITY_4KB;
 	desc->base2	= 0x00;
 	desc++;
 
-	/* __KERNEL_DS */
+	/* __BOOT_DS */
 	desc->limit0	= 0xffff;
 	desc->base0	= 0x0000;
 	desc->base1	= 0x0000;
@@ -422,23 +397,7 @@ static efi_status_t setup_gdt(struct desc_ptr *gdt)
 	desc->base2	= 0x00;
 	desc++;
 
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
+#endif /* CONFIG_X86_32 */
 
 	return EFI_SUCCESS;
 }
@@ -883,7 +842,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 	}
 
 	raw_local_irq_disable();
-	native_load_gdt(&gdt);
+	if (IS_ENABLED(CONFIG_X86_32))
+		native_load_gdt(&gdt);
 
 	return boot_params;
 fail:
-- 
2.24.1

