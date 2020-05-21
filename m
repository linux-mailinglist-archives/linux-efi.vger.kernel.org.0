Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C391DC391
	for <lists+linux-efi@lfdr.de>; Thu, 21 May 2020 02:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgEUA3X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 20:29:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37780 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgEUA3X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 20:29:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id m11so5655919qka.4
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 17:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MtEKwwdraZgwWfl3cz7n+JmLAuBcOpq0LiXo7nMKbY=;
        b=PBCth/Xm5AFBz8koL/UFHdTpPVydcCsZkAqnk7t3lY77xQ2aYgIMDLDybMoGFPudRH
         2u8Z6iC1iW6d/4CTKN79lI7LvcIbGBdq7zhFKR45P7O7Whjo+WmC9m5EcrIFwmtnIqtm
         Tc8LprWH7vc6BUSZTVJsHGNAfB529rR4phC/kPmwzhGqt/gtK3X3SUC1nmPGKMkTpycF
         GaCUPZzqvTe0rblCAZLWUmZYU6CujRlZzCtW+JM6cCrj6XKgvgEQBM6K48f8Adpm1IUF
         65Om3OFiUQtCWsJ9BdwpS2T8qdfqz+BKGHZUWQRskBto+I/NXlMvebEGt59aSgUGEBaF
         2tqg==
X-Gm-Message-State: AOAM533yd+PlGd4QdhCl+/wRlRXsJfVTr885d5qT47RjNgZBd9aFxQxF
        W/I+eYWUEwY4++jr5GOv1690hJv4
X-Google-Smtp-Source: ABdhPJxIQGAKI5KVV7t+D9W/KGLXP9paKoLPm5aAdsRL95MnrStcs8UlGU1c5dTgtNhsRYoPk63uQg==
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr7689817qkk.490.1590020962175;
        Wed, 20 May 2020 17:29:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f16sm3973591qtc.69.2020.05.20.17.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:29:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/libstub: Don't parse overlong command lines
Date:   Wed, 20 May 2020 20:29:21 -0400
Message-Id: <20200521002921.69650-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAMj1kXGuM6sEE5HoAmGP7EZDnyUsW73FH+f2C_MvH76UCMYkpg@mail.gmail.com>
References: <CAMj1kXGuM6sEE5HoAmGP7EZDnyUsW73FH+f2C_MvH76UCMYkpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Check if the command line passed in is larger than COMMAND_LINE_SIZE,
and truncate it to the last full argument if so.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 2a6aded4f2a9..89f075275300 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -9,10 +9,12 @@
 
 #include <stdarg.h>
 
+#include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
 #include <asm/efi.h>
+#include <asm/setup.h>
 
 #include "efistub.h"
 
@@ -216,22 +218,33 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	unsigned long cmdline_addr = 0;
 	int options_chars = efi_table_attr(image, load_options_size) / 2;
 	const u16 *options = efi_table_attr(image, load_options);
-	int options_bytes = 0;  /* UTF-8 bytes */
+	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
+	bool in_quote = false;
 	efi_status_t status;
 
 	if (options) {
 		s2 = options;
-		while (options_chars--) {
+		while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
 			u16 c = *s2++;
 
-			if (c == L'\0' || c == L'\n')
-				break;
+			if (c < 0x80) {
+				if (c == L'\0' || c == L'\n')
+					break;
+				if (c == L'"')
+					in_quote = !in_quote;
+				else if (!in_quote && isspace((char)c))
+					safe_options_bytes = options_bytes;
+
+				options_bytes++;
+				continue;
+			}
+
 			/*
 			 * Get the number of UTF-8 bytes corresponding to a
 			 * UTF-16 character.
 			 * The first part handles everything in the BMP.
 			 */
-			options_bytes += 1 + (c >= 0x80) + (c >= 0x800);
+			options_bytes += 2 + (c >= 0x800);
 			/*
 			 * Add one more byte for valid surrogate pairs. Invalid
 			 * surrogates will be replaced with 0xfffd and take up
@@ -252,6 +265,11 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 				}
 			}
 		}
+		if (options_bytes >= COMMAND_LINE_SIZE) {
+			options_bytes = safe_options_bytes;
+			efi_err("Command line is too long: truncated to %d bytes\n",
+				options_bytes);
+		}
 	}
 
 	options_bytes++;	/* NUL termination */
-- 
2.26.2

