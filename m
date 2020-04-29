Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75541BE578
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgD2Rlf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:35 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46126 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgD2Rlb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:31 -0400
Received: by mail-qv1-f67.google.com with SMTP id 59so1544422qva.13;
        Wed, 29 Apr 2020 10:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ripA1cv3wgZlf0slliRjLteC8ID9H9NjTXvUNwlSmw=;
        b=Kyqu9KjzelJrKSKUBBoYDwMJDOe5Mj3X02OwbB93F5Fkc+syyboPJ9q4gRf+NRg1lU
         +rPwcFeVGKpzbewV6O3n4MufQD2WUy/DOXBb3HwuLfZROsAvrDX7KtRqXC4ZZsosnrYP
         +av6MoYLzsFzaDbyc0THxc63lEvvlvA5c2qMYb48YTd3t9vfoDWok9uU6SzAgnCX4h71
         DHmLxRi+3W2RJkbp83AYJpK4KYy6myl4RDCCibk5dxL1+ZL4aK6cEi1gphzg4PZpBNLy
         4PEuPaHshZrfYgi1IsnJLHz5GeddN1m2N9YWgUNcn2gSZIXe9g/z4MLIQqDGgdh8rj2Q
         8J8Q==
X-Gm-Message-State: AGi0PuaMhRWA3gFVbOloo1eCC36ZqpXoTpRpJO2ucfB/yNsqRC6lphlG
        wuc1vusewFEorHyovzfNswVH/8sN/mA=
X-Google-Smtp-Source: APiQypLd1+gq1CorW1pD17UsROfO8KWa/WyQ4fPOauRmaeHs92LijWzsyPo6W7jgeHDt2nzBAewvOg==
X-Received: by 2002:a0c:f34b:: with SMTP id e11mr33725259qvm.76.1588182090079;
        Wed, 29 Apr 2020 10:41:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] efi/libstub: Check return value of efi_parse_options
Date:   Wed, 29 Apr 2020 13:41:20 -0400
Message-Id: <20200429174120.1497212-12-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
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
 drivers/firmware/efi/libstub/efi-stub.c | 18 ++++++++++++++----
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 930302d9415a..a4399537b4e6 100644
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
+			pr_efi_err("Failed to parse options\n");
+			goto fail_free_cmdline;
+		}
+	}
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0)
-		efi_parse_options(cmdline_ptr);
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
+		status = efi_parse_options(cmdline_ptr);
+		if (status != EFI_SUCCESS) {
+			pr_efi_err("Failed to parse options\n");
+			goto fail_free_cmdline;
+		}
+	}
 
 	pr_efi("Booting Linux Kernel...\n");
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0faba30d6406..ca549f26f45d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -739,12 +739,20 @@ unsigned long efi_main(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	efi_parse_options(CONFIG_CMDLINE);
+	status = efi_parse_options(CONFIG_CMDLINE);
+	if (status != EFI_SUCCESS) {
+		pr_efi_err("Failed to parse options\n");
+		goto fail;
+	}
 #endif
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		efi_parse_options((char *)cmdline_paddr);
+		status = efi_parse_options((char *)cmdline_paddr);
+		if (status != EFI_SUCCESS) {
+			pr_efi_err("Failed to parse options\n");
+			goto fail;
+		}
 	}
 
 	/*
-- 
2.26.2

