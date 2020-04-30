Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118141C04C0
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3S3G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:29:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37217 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgD3S2z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id s63so6781334qke.4;
        Thu, 30 Apr 2020 11:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaTlpZTdOGwOAmOlYM6QocHZMIAZdayZgSPeQ/GyX0w=;
        b=bNBFS0IpxhG39ftQz/LLaz5gSPDrJVu09s0hcybCUr/pDpS9ZLRHk1h5w8qq2iAuBv
         o87YhMbUpwIC1h134UzvZWjjknMd06cjNqz2RpL35PrOOGWi1BgvdFYQUX64lC6FnNoi
         GkTSjht0myptHnm1pXuDtBpLWwAHvOmEhz4OVTYjG9VlOGb8i3CoEnfZkJkPhLE4ms5c
         KKXcdG8wAnly8541Ah/pFVm8lmZdFmJedFPvEPraZ0LyEdB8VH7Nw4jih5X3YGwD7jjl
         wqqyzuybwIZ7sDzpr36BQp1MNKrCGFSvkdpf8mz7/1iHL3fqHn9seFKS5pfZKeiZUC8X
         VV0g==
X-Gm-Message-State: AGi0PuZyol9rvgHHXfVppeTzHqGoyWKQcw+xKP7t0UenoYnT3x6tGYW1
        to38qkQKvaaiFYBOR7GbASE=
X-Google-Smtp-Source: APiQypIWFscbdbXQU8hwcGQyOL2j0mYsOZluvds19Sk40KtsjdDFtV1aN52tYBeThUjGkE6rJJBcKw==
X-Received: by 2002:a05:620a:a07:: with SMTP id i7mr4609694qka.98.1588271334327;
        Thu, 30 Apr 2020 11:28:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] efi/libstub: Check return value of efi_parse_options
Date:   Thu, 30 Apr 2020 14:28:43 -0400
Message-Id: <20200430182843.2510180-12-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200430182843.2510180-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_parse_options can fail if it is unable to allocate space for a copy
of the command line. Check the return value to make sure it succeeded.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub.c | 23 +++++++++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 63541c2440ef..c2484bf75c5d 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -207,11 +207,21 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
-	    cmdline_size == 0)
-		efi_parse_options(CONFIG_CMDLINE);
+	    cmdline_size == 0) {
+		status = efi_parse_options(CONFIG_CMDLINE);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse options\n");
+			goto fail_free_cmdline;
+		}
+	}
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0)
-		efi_parse_options(cmdline_ptr);
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
+		status = efi_parse_options(cmdline_ptr);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse options\n");
+			goto fail_free_cmdline;
+		}
+	}
 
 	efi_info("Booting Linux Kernel...\n");
 
@@ -223,7 +233,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 				     dram_base, image);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
-		goto fail_free_cmdline;
+		goto fail_free_screeninfo;
 	}
 
 	efi_retrieve_tpm2_eventlog();
@@ -326,8 +336,9 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 fail_free_image:
 	efi_free(image_size, image_addr);
 	efi_free(reserve_size, reserve_addr);
-fail_free_cmdline:
+fail_free_screeninfo:
 	free_screen_info(si);
+fail_free_cmdline:
 	efi_free(cmdline_size, (unsigned long)cmdline_ptr);
 fail:
 	return status;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c84c5678e3e1..37154bb93c59 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -739,12 +739,20 @@ unsigned long efi_main(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	efi_parse_options(CONFIG_CMDLINE);
+	status = efi_parse_options(CONFIG_CMDLINE);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to parse options\n");
+		goto fail;
+	}
 #endif
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		efi_parse_options((char *)cmdline_paddr);
+		status = efi_parse_options((char *)cmdline_paddr);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse options\n");
+			goto fail;
+		}
 	}
 
 	/*
-- 
2.26.2

