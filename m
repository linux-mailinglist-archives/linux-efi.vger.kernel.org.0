Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190941D87E5
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgERTHe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37383 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgERTHc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id 4so9073760qtb.4
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0U4lP2Gno2i2zMEA9MGcxzzT1Kesn7iBU88/MXxYkf8=;
        b=T569DxNkc9M451w37xZsLg47km0J4dPqSszYiz3haeAljLVt/KP2ad/haGpwhmyzZt
         gaDv3bj52ZCR2n6DAztuNUoihGq55mZCdLxPHVlGPZ1NQMom3LtJ9urnodf/3XTjE/Sm
         DYMrVPSzZ023IaFrUAGay5/WInNknF2iVREE+pAB0SCAJoqxNuuOFfvDgBIm80vu44PK
         BtxpXY32stRln520RKOTiARN8hbDY8vFlAnl7h0rixRmL48NM6MhSF57u9K8enA1CYdp
         w9dWK1yLrmFWiUKcgFuwVAUbMHf2YQV2rWSz1OSNKVoSEdcpOUHcamiWaYBxQh6dRBSl
         0VmQ==
X-Gm-Message-State: AOAM532b75sUgCKuNPXZx37eojY7nAhYrgiU0tgidz4hEUNFwmctCJXX
        q38/HMbnhkc07kwDmiVEFd/cXJMkFX0=
X-Google-Smtp-Source: ABdhPJzek70I2WmZ1MqEqFaiqRgbIs/dPw2hDhEdiIVNZiSvo6Yi3ouk9/rKtxPRgeG11x4yToTqBA==
X-Received: by 2002:ac8:4e16:: with SMTP id c22mr8381024qtw.281.1589828850695;
        Mon, 18 May 2020 12:07:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 17/24] efi/libstub: Implement printk-style logging
Date:   Mon, 18 May 2020 15:07:09 -0400
Message-Id: <20200518190716.751506-18-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the efi_printk function in efi_info/efi_err, and add efi_debug. This
allows formatted output at different log levels.

Add the notion of a loglevel instead of just quiet/not-quiet, and
parse the debug kernel parameter in addition to quiet.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 29 +++++++++++++++++--
 drivers/firmware/efi/libstub/efistub.h        | 14 +++++----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 5ecafc57619a..c0278a8063b7 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -11,6 +11,7 @@
 
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -18,7 +19,7 @@
 bool efi_nochunk;
 bool efi_nokaslr;
 bool efi_noinitrd;
-bool efi_quiet;
+int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
 static bool efi_nosoftreserve;
@@ -58,6 +59,28 @@ int efi_printk(const char *fmt, ...)
 	char printf_buf[256];
 	va_list args;
 	int printed;
+	int loglevel = printk_get_level(fmt);
+
+	switch (loglevel) {
+	case '0' ... '9':
+		loglevel -= '0';
+		break;
+	default:
+		/*
+		 * Use loglevel -1 for cases where we just want to print to
+		 * the screen.
+		 */
+		loglevel = -1;
+		break;
+	}
+
+	if (loglevel >= efi_loglevel)
+		return 0;
+
+	if (loglevel >= 0)
+		efi_puts("EFI stub: ");
+
+	fmt = printk_skip_level(fmt);
 
 	va_start(args, fmt);
 	printed = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
@@ -100,7 +123,9 @@ efi_status_t efi_parse_options(char const *cmdline)
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;
 		} else if (!strcmp(param, "quiet")) {
-			efi_quiet = true;
+			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
+		} else if (!strcmp(param, "debug")) {
+			efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
 		} else if (!strcmp(param, "efi") && val) {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index caa7dcc71c69..3a323a009836 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/kern_levels.h>
 #include <linux/types.h>
 #include <asm/efi.h>
 
@@ -34,7 +35,7 @@
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern bool efi_noinitrd;
-extern bool efi_quiet;
+extern int efi_loglevel;
 extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
@@ -49,11 +50,12 @@ extern const efi_system_table_t *efi_system_table;
 
 #endif
 
-#define efi_info(msg)		do {			\
-	if (!efi_quiet) efi_puts("EFI stub: "msg);	\
-} while (0)
-
-#define efi_err(msg) efi_puts("EFI stub: ERROR: "msg)
+#define efi_info(fmt, ...) \
+	efi_printk(KERN_INFO fmt, ##__VA_ARGS__)
+#define efi_err(fmt, ...) \
+	efi_printk(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
+#define efi_debug(fmt, ...) \
+	efi_printk(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
-- 
2.26.2

