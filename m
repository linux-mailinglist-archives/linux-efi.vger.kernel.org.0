Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC19B1BE57D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgD2Rlk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46747 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgD2Rla (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id g74so2843141qke.13;
        Wed, 29 Apr 2020 10:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eri9nbMjJY+WMCJY05yR1IDSTdT6azrjQssNo0Q1FLI=;
        b=SzGzFB3jbWw9Ls67YVOY8rkXaK+nTR5xMpthx94BP8b1iU9nhoWeYtJB/MiH0bICdh
         snpMkG2RRZ03XmVvwiuXOrsdvZfzj+HpEpiig2BfDuSHG0LdWovBcBsfKM376NDdDvGW
         uxQFDGuk5BmvasPG0LMcSKxiP3u34edO3Ne8fxDcrBPyVmPTmgjIDvFQfmpcQSUJ4lVb
         03I3+S/6AvnOgqh5gLX1miQrpyHyNaZ5gsc1OiW+PVqS6bkN8J00UTdYJtlij0ya9HF1
         4vYhDUMwDAPSQgXjJfiHF+Th4t+d3tbI9QzjTXHUbC6ozrP/Vyp+T5O/5+KXLtrhguDQ
         amBA==
X-Gm-Message-State: AGi0PubUWn1aNlSEozxe4rf/TsfWbwCiJ5tgDGDu41KPFAeBu2EyJKlV
        RJrz7blj3F6uEgHFgxwrFy2iORbt8w0=
X-Google-Smtp-Source: APiQypKR4NOK+vPTtwvLiryqpDhyhnZmAhRJoEH2xksLBlvbg5LfIR9ZZS+65jr5WdPLze7mVwq8FA==
X-Received: by 2002:a05:620a:16b0:: with SMTP id s16mr34414127qkj.204.1588182088734;
        Wed, 29 Apr 2020 10:41:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:28 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] efi/x86: Drop soft_limit for x86 initrd loading
Date:   Wed, 29 Apr 2020 13:41:18 -0400
Message-Id: <20200429174120.1497212-10-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently the EFI stub attempts to load initrd(s) specified on the
command line below hdr->initrd_addr_max (2G) and if that fails, falls
back to allocating at an unrestricted address.

The only case when loading at a low address helps is for the 32-bit
kernel, where the initrd must be copied by the kernel into lowmem if
it's not there already. The limit specified in hdr->initrd_addr_max is
insufficient to ensure this in any case, since lowmem by default will
extend to about 0.9G rather than 2G, and we don't attempt to load the
initrd in lowmem at all for the new device-path based initrd.

Simplify the code by dropping this optimization for the command line
initrd(s) as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 14 +++++---------
 drivers/firmware/efi/libstub/efi-stub.c        |  3 +--
 drivers/firmware/efi/libstub/efistub.h         |  8 +++-----
 drivers/firmware/efi/libstub/file.c            | 13 ++-----------
 drivers/firmware/efi/libstub/x86-stub.c        |  3 +--
 5 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 2c0c2c34b4cc..32768fa04b32 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -378,8 +378,7 @@ static
 efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				     unsigned long *load_addr,
 				     unsigned long *load_size,
-				     unsigned long soft_limit,
-				     unsigned long hard_limit)
+				     unsigned long max)
 {
 	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
 	    (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL))) {
@@ -388,27 +387,24 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 	}
 
 	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
-				    soft_limit, hard_limit,
-				    load_addr, load_size);
+				    max, load_addr, load_size);
 }
 
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
-			     unsigned long soft_limit,
-			     unsigned long hard_limit)
+			     unsigned long max)
 {
 	efi_status_t status;
 
 	if (!load_addr || !load_size)
 		return EFI_INVALID_PARAMETER;
 
-	status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
+	status = efi_load_initrd_dev_path(load_addr, load_size, max);
 	if (status == EFI_SUCCESS) {
 		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
 	} else if (status == EFI_NOT_FOUND) {
-		status = efi_load_initrd_cmdline(image, load_addr, load_size,
-						 soft_limit, hard_limit);
+		status = efi_load_initrd_cmdline(image, load_addr, load_size, max);
 		if (status == EFI_SUCCESS && *load_size > 0)
 			pr_efi("Loaded initrd from command line option\n");
 	}
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index d8f24f5c91bd..930302d9415a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -265,8 +265,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 
 	if (!efi_noinitrd) {
 		max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
-		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
-					 ULONG_MAX, max_addr);
+		status = efi_load_initrd(image, &initrd_addr, &initrd_size, max_addr);
 		if (status != EFI_SUCCESS)
 			pr_efi_err("Failed to load initrd!\n");
 	}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index dfdd7954bf58..1ba0887818d9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -663,8 +663,7 @@ efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  const efi_char16_t *optstr,
 				  int optstr_size,
-				  unsigned long soft_limit,
-				  unsigned long hard_limit,
+				  unsigned long max,
 				  unsigned long *load_addr,
 				  unsigned long *load_size);
 
@@ -674,13 +673,12 @@ static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
 					unsigned long *load_size)
 {
 	return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
-				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
+				    ULONG_MAX, load_addr, load_size);
 }
 
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
-			     unsigned long soft_limit,
-			     unsigned long hard_limit);
+			     unsigned long max);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 50aaf15f9ad5..7dee3c5d81fb 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -124,8 +124,7 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  const efi_char16_t *optstr,
 				  int optstr_size,
-				  unsigned long soft_limit,
-				  unsigned long hard_limit,
+				  unsigned long max,
 				  unsigned long *load_addr,
 				  unsigned long *load_size)
 {
@@ -181,15 +180,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		    round_up(alloc_size, EFI_ALLOC_ALIGN)) {
 			unsigned long old_addr = alloc_addr;
 
-			status = EFI_OUT_OF_RESOURCES;
-			if (soft_limit < hard_limit)
-				status = efi_allocate_pages(alloc_size + size,
-							    &alloc_addr,
-							    soft_limit);
-			if (status == EFI_OUT_OF_RESOURCES)
-				status = efi_allocate_pages(alloc_size + size,
-							    &alloc_addr,
-							    hard_limit);
+			status = efi_allocate_pages(alloc_size + size, &alloc_addr, max);
 			if (status != EFI_SUCCESS) {
 				pr_efi_err("Failed to allocate memory for files\n");
 				goto err_close_file;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1d3f94f1dafa..85a924fecc87 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -755,8 +755,7 @@ unsigned long efi_main(efi_handle_t handle,
 	if (!efi_noinitrd) {
 		unsigned long addr, size;
 
-		status = efi_load_initrd(image, &addr, &size,
-					 hdr->initrd_addr_max, ULONG_MAX);
+		status = efi_load_initrd(image, &addr, &size, ULONG_MAX);
 
 		if (status != EFI_SUCCESS) {
 			pr_efi_err("Failed to load initrd!\n");
-- 
2.26.2

