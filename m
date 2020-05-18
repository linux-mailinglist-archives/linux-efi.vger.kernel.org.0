Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F801D87D3
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgERTHV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38782 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgERTHU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id f189so11453101qkd.5
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4do69Wep452APl8XbyWaG1WGCko6ouS5yf+9bYLCbLY=;
        b=dqeTnAwdcGR4l+nACjmG2xgenjB157vFahQqyMRC373jPpA5LSdqXJYziojtVqTy7l
         LMIQE1WdfRvGH3rUChlL9xyG5whlxAaIPpc2XJR3Jd4B37ul4P5JrAQ70hxZ8sapy7Ds
         MG5OyGJiMW4WgqsjBfVwvFq/umT2ewcHXMMbm+/ClQFl385BaqxmPIJtcoYYG6ObQAM2
         XIDYurdI/q7hiafy+T+e6F1Rz7ylB1B1iwHiWKcaMWM6mb9h4zyLW0r6uP0GoxKo4bCs
         SwTrUTeASwhIcXrExTM56E1kbBrU2dgakv2ec1G0/D1rV4v3gBA5+Mp1taCGgc/NEmSg
         sOdQ==
X-Gm-Message-State: AOAM5339v8HrjNGZ+dNVV7+c/VrfgGg5hbGGkuNINp7EFpZSDAM3upqy
        mr32c5B6B1INSW2L96d/wr6fp71SAFE=
X-Google-Smtp-Source: ABdhPJyLZOy8cjzNYsTmcwLcHxWfA4ifGFc+eomG0XJLJ6hVVNGHJEUN/lTVdLCZ7yM/SmHRKcQyfQ==
X-Received: by 2002:ae9:dc47:: with SMTP id q68mr16431297qkf.17.1589828838956;
        Mon, 18 May 2020 12:07:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:18 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 02/24] efi/libstub: Rename efi_[char16_]printk to efi_[char16_]puts
Date:   Mon, 18 May 2020 15:06:54 -0400
Message-Id: <20200518190716.751506-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

These functions do not support formatting, unlike printk. Rename them to
puts to make that clear.

Move the implementations of these two functions next to each other.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 18 +++++++++---------
 drivers/firmware/efi/libstub/efistub.h         | 10 +++++-----
 drivers/firmware/efi/libstub/file.c            |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 2927f3d30344..c6d7ef35e9f7 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -26,15 +26,21 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
-void efi_printk(const char *str)
+void efi_char16_puts(efi_char16_t *str)
+{
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, str);
+}
+
+void efi_puts(const char *str)
 {
 	while (*str) {
 		efi_char16_t ch[] = { *str++, L'\0' };
 
 		if (ch[0] == L'\n')
-			efi_char16_printk(L"\r\n");
+			efi_char16_puts(L"\r\n");
 		else
-			efi_char16_printk(ch);
+			efi_char16_puts(ch);
 	}
 }
 
@@ -279,12 +285,6 @@ void *get_efi_config_table(efi_guid_t guid)
 	return NULL;
 }
 
-void efi_char16_printk(efi_char16_t *str)
-{
-	efi_call_proto(efi_table_attr(efi_system_table, con_out),
-		       output_string, str);
-}
-
 /*
  * The LINUX_EFI_INITRD_MEDIA_GUID vendor media device path below provides a way
  * for the firmware or bootloader to expose the initrd data directly to the stub
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 998924916b03..4f57611a65f2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -49,10 +49,10 @@ extern const efi_system_table_t *efi_system_table;
 #endif
 
 #define efi_info(msg)		do {			\
-	if (!efi_quiet) efi_printk("EFI stub: "msg);	\
+	if (!efi_quiet) efi_puts("EFI stub: "msg);	\
 } while (0)
 
-#define efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
+#define efi_err(msg) efi_puts("EFI stub: ERROR: "msg)
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
@@ -605,8 +605,6 @@ efi_status_t efi_exit_boot_services(void *handle,
 				    void *priv,
 				    efi_exit_boot_map_processing priv_func);
 
-void efi_char16_printk(efi_char16_t *);
-
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
 					    unsigned long max_addr,
@@ -630,7 +628,9 @@ efi_status_t check_platform_features(void);
 
 void *get_efi_config_table(efi_guid_t guid);
 
-void efi_printk(const char *str);
+/* NOTE: These functions do not print a trailing newline after the string */
+void efi_char16_puts(efi_char16_t *);
+void efi_puts(const char *str);
 
 void efi_free(unsigned long size, unsigned long addr);
 
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index cc177152d0df..933536c5236a 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -47,8 +47,8 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to open file: ");
-		efi_char16_printk(fi->filename);
-		efi_printk("\n");
+		efi_char16_puts(fi->filename);
+		efi_puts("\n");
 		return status;
 	}
 
-- 
2.26.2

