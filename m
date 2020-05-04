Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12481C3085
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 02:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEDAi5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 3 May 2020 20:38:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43506 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgEDAi5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 3 May 2020 20:38:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id i14so3852102qka.10
        for <linux-efi@vger.kernel.org>; Sun, 03 May 2020 17:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xe4adJutx+xba2rhMdVuW5PoWzS5qzgrgFEqz6lAdLQ=;
        b=Xyy5s9DpstAJlWHHR1RQVOA0HtDuwGydjgsKZgVG2C1tz1rXh7BViWwwNQ3PHg/0ug
         parWYOPwBJqmgONr8t/ZDG8I3W+ifQQ/FvhVaTK3ju4G8bMkPDT5ASAKzWd92hv39CjO
         5JqEn2MqYQtaHpnE4qnEELzGK/84Usb5rpqbSEpRY3BOWQBEwfZq3PpDIAavzCCohl57
         TX4Q4I6i414O9Qi2+CyexPJEDKiidwe9rH5v1UkUxkp5+0fS6sczzr5JunTYHjoT3CE9
         0N/dPieQKU9ZPEQa4mIymPawVYU4juQFhUeostbpDYA0igVBTOITXFi06PK8K7WF+wX3
         b7zQ==
X-Gm-Message-State: AGi0PuYsx54KixM5pTAatfrlUif9xUCNKKAOeLjRPmulaC69oc0Rt5BP
        G1ZDqPMNJrDDw1jhuqtP8hw=
X-Google-Smtp-Source: APiQypJtJVt0GyWBgEfRHe5z7xsosNafvnRbGmAoKQYGLkCyLT806hattbrakTIcc5wYm6BLmviR0A==
X-Received: by 2002:a37:5c46:: with SMTP id q67mr13738205qkb.210.1588552734686;
        Sun, 03 May 2020 17:38:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t14sm9401506qtj.71.2020.05.03.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:38:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux@roeck-us.net
Subject: [PATCH 1/1] efi/libstub: Fix mixed mode boot issue after macro refactor
Date:   Sun,  3 May 2020 20:38:52 -0400
Message-Id: <20200504003852.1096018-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504003852.1096018-1-nivedita@alum.mit.edu>
References: <20200503154507.82880-1-ardb@kernel.org>
 <20200504003852.1096018-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")

refactored the macros that are used to provide wrappers for mixed-mode
calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.

Unfortunately, this broke mixed mode boot due to the fact that
efi_is_native() is not a macro on x86.

Fix this by conditioning the generic macro definitions on
CONFIG_EFI_MIXED, and removing the wrapper definitions on x86 if
CONFIG_EFI_MIXED is not enabled.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/efi.h             | 17 +++++++++++++----
 drivers/firmware/efi/libstub/efistub.h | 14 ++++----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cd0c3fbf6156..88f29f84a4d0 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -225,13 +225,13 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 /* arch specific definitions used by the stub code */
 
-extern const bool efi_is64;
+#ifdef CONFIG_EFI_MIXED
 
 static inline bool efi_is_64bit(void)
 {
-	if (IS_ENABLED(CONFIG_EFI_MIXED))
-		return efi_is64;
-	return IS_ENABLED(CONFIG_X86_64);
+	extern const bool efi_is64;
+
+	return efi_is64;
 }
 
 static inline bool efi_is_native(void)
@@ -356,6 +356,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
 						   runtime),		\
 				    func, __VA_ARGS__))
 
+#else /* CONFIG_EFI_MIXED */
+
+static inline bool efi_is_64bit(void)
+{
+	return IS_ENABLED(CONFIG_X86_64);
+}
+
+#endif /* CONFIG_EFI_MIXED */
+
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 874233cf8820..37ca286a40c6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,20 +33,14 @@ extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
-#ifndef efi_bs_call
+#ifndef CONFIG_EFI_MIXED
+
+#define efi_is_native()		(true)
 #define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
-#endif
-#ifndef efi_rt_call
 #define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
-#endif
-#ifndef efi_is_native
-#define efi_is_native()		(true)
-#endif
-#ifndef efi_table_attr
 #define efi_table_attr(inst, attr)	(inst->attr)
-#endif
-#ifndef efi_call_proto
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+
 #endif
 
 #define efi_info(msg)		do {			\
-- 
2.26.2

