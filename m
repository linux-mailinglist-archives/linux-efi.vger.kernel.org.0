Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02ABF110373
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLCR2y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 12:28:54 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44861 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCR2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 12:28:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id g24so4523919qtq.11
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 09:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/+awCAeOgqKgJG3ko+G8Rj7gAHCxBuEx0jFfH0vZp4=;
        b=ekKUY3HNUDFURa2dmJOKhB+6VUKUvP+0DviD1xWG/QqKqwYcUFKsmvErpI6xUYxnMV
         J/b3pZQshR86eJ5AkQzy9zic39YvAis1TOd4LErY13p0l44SlqQwWlxQtKwNoo/7eKPV
         B/BFeNVPqfGIRADu1NN4W4WmOQ5fG6djQSfMyMbJ1AlnS4lqwRm5yfcMeFNycOwCyMrD
         o142ypfnE3exMfBHMYqeJoGvAU3UOlGKpxJZMvnBP8GUPyDePUtecGNmHROIyT8g44jx
         BO0dAvXR6QH505AjKkkqELNpBAFqKYnDHVxKZkLtw4z8qjc/qKxPKbTEshB/I7IDfdHF
         z1Ng==
X-Gm-Message-State: APjAAAU5KFaq+hoJl2N5c8rlyBIDRB/vNVIT0s7fnvAhLgYGDs0Aegi+
        UyWprvHTXzAotPHy8SciAqF8Iais3GY=
X-Google-Smtp-Source: APXvYqxdU5QniBUj1LsriDY/x9IUxP3HtpBpw0FSdrKRvCy46OH4O+012hzsexJZlYGei8z3RrUI9g==
X-Received: by 2002:aed:22c1:: with SMTP id q1mr6049969qtc.337.1575394133306;
        Tue, 03 Dec 2019 09:28:53 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q187sm2143625qkd.92.2019.12.03.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 09:28:52 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH] efi: fix type of unload field in efi_loaded_image_t
Date:   Tue,  3 Dec 2019 12:28:51 -0500
Message-Id: <20191203172851.600543-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <CAKv+Gu8Lih6q7yVJ0Mbz8a0DoxdPdqBpue+Vh7b4aMgn9kZ=AA@mail.gmail.com>
References: <CAKv+Gu8Lih6q7yVJ0Mbz8a0DoxdPdqBpue+Vh7b4aMgn9kZ=AA@mail.gmail.com>
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

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
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

