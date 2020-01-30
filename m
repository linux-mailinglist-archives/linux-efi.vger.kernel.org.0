Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1331D14E388
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgA3UEp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38103 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UEo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so4234185qki.5;
        Thu, 30 Jan 2020 12:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnKbYo98Oj2hAr68jP15wX0PjN2EEUHImQ5WrU9+YEQ=;
        b=Mc/leAIhClSCocd1TmoweenR3VCkHPHpNbyI7MHe3SR1XtptVnkyHkP8dNrHQy4MfD
         WpYywTueGohrR25QiqTtGdU6EhdTdAcVG/0gjudvws3iKHIvCZiseCQoDdh9k52G5TLl
         OSwS4OmIZUEykbnuFhS80N1ikuKa1Oy5MqZnbZ6NSzRGXUs5RExV5VBl/ldAms+eOn/9
         tt04Uu57qM8wYaM/Ms7LKt9RZQ5LEuziAOI+1hK+69I+gpdZRJnKvbrdcZgk2zDwH8bR
         iKPQSKFovgccTByaD8xKAg68WKNno1EqCzUNUuMDpHNOiitOHeJiaIys9n2hjE+YrRq1
         YLvw==
X-Gm-Message-State: APjAAAVVKyK8eH2SJ8seLbqVPQmIdc+0KgQ3wja+RP/2xvrqzX8Nyzp1
        EM2fiqZR5D2gfFBuFgWq/bo=
X-Google-Smtp-Source: APXvYqwutIrp16OcVSGypWQVp1j1BddFD0s1gr6ijVPosKI6RRha6RBy7A4Afc51yaQTKbO2AgBgLA==
X-Received: by 2002:a05:620a:1587:: with SMTP id d7mr6984425qkk.355.1580414683706;
        Thu, 30 Jan 2020 12:04:43 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:42 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/8] efi/x86: Use C wrapper instead of inline assembly
Date:   Thu, 30 Jan 2020 15:04:33 -0500
Message-Id: <20200130200440.1796058-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Call the C wrappers instead of inline assembly for cli and lgdt
instructions.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 287393d725f0..f89caae60057 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -9,6 +9,7 @@
 #pragma GCC visibility push(hidden)
 
 #include <linux/efi.h>
+#include <linux/irqflags.h>
 #include <linux/pci.h>
 
 #include <asm/efi.h>
@@ -877,8 +878,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 		desc++;
 	}
 
-	asm volatile("cli");
-	asm volatile ("lgdt %0" : : "m" (*gdt));
+	raw_local_irq_disable();
+	native_load_gdt(gdt);
 
 	return boot_params;
 fail:
-- 
2.24.1

