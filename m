Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E402110E3C2
	for <lists+linux-efi@lfdr.de>; Sun,  1 Dec 2019 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLAWLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Dec 2019 17:11:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42507 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLAWLA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Dec 2019 17:11:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id a10so7666651qko.9
        for <linux-efi@vger.kernel.org>; Sun, 01 Dec 2019 14:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBWSdyRAaJwCKKxRmt+7qRNIMCXrVeIZ4EYGcCDDmww=;
        b=sOJOyJzo1cm4foTqK3yA9ZWQ26avNu25kdHAdEZuVONHavlBJEo1zxzFdBTe7yGY5Q
         w1JyhQygcN2hVpN8nOMu+meMu+XEcUfCMDNG+rDltErR8NxC4UEsIrGf9nr41UkKCFRk
         QGJOj0TLHfPX6IEzBTMx7g5ne8N86MiX9tI0eJ0OGYLhmyDrM2Sjtzcl4ImNJS5bzVOH
         ut/iUfOKVuWedjDiAghw93IEoBbZKJt8ysEaAzfOusuwvis14CX2Qa3wgFnHGpdvExXf
         5w5jM3OLVQnrwuZDPihEYSLoq0KfLEYdSHfxoIQvK+6v4R8YBCkpcnEdgOkHCyI+fZsL
         2qlA==
X-Gm-Message-State: APjAAAXGwRXyTG5SXTxXb9H1cFgkoT7u2CLFYL5ByXsdIyfOV8XBIEwr
        CAXCoNHFA8QaGy+EvEfuWHQ=
X-Google-Smtp-Source: APXvYqxlIV8Hefngre0kNSYuOAV4j++lyB9PXGTx9JkEtI+91VGIB9UzUA5JjxfT0OFnq+z84AYK8g==
X-Received: by 2002:a05:620a:1643:: with SMTP id c3mr14143662qko.451.1575238259642;
        Sun, 01 Dec 2019 14:10:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p7sm5358899qkm.123.2019.12.01.14.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 14:10:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH] efi: fix type of unload field in efi_loaded_image_t
Date:   Sun,  1 Dec 2019 17:10:58 -0500
Message-Id: <20191201221058.831985-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The unload field is a function pointer, so it should be u32 for 32-bit,
u64 for 64-bit. Add a prototype for it in the native efi_loaded_image_t
type. Also change type of parent_handle and device_handle from void* to
efi_handle_t for documentation purposes.

The unload method is not used, so no functional change.
---
 include/linux/efi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 99dfea595c8c..aa54586db7a5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -824,7 +824,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	u32 unload;
 } efi_loaded_image_32_t;
 
 typedef struct {
@@ -840,14 +840,14 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	u64 unload;
 } efi_loaded_image_64_t;
 
 typedef struct {
 	u32 revision;
-	void *parent_handle;
+	efi_handle_t parent_handle;
 	efi_system_table_t *system_table;
-	void *device_handle;
+	efi_handle_t device_handle;
 	void *file_path;
 	void *reserved;
 	u32 load_options_size;
@@ -856,7 +856,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	efi_status_t (*unload)(efi_handle_t image_handle);
 } efi_loaded_image_t;
 
 
-- 
2.23.0

