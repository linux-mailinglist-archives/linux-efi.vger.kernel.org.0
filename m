Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE11BE57E
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgD2Rlk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36436 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgD2Rla (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id q7so2895545qkf.3;
        Wed, 29 Apr 2020 10:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmSiqbQXtkyGqx7gLc0t3Wa1GjwmDthMxJ9GlsJOygs=;
        b=KHgGAhn1NPLteOO6sIw/hCMUvBzXgah2f1idW5CB5kLxTF1C4c/n7I5QXps3aDOoAh
         s8R6jCS0DRhYJ4r/idO24PbklT5ruzSiMNAIC5tMHL+ldopAVyRS5PsotK0izBo1wEVB
         u9t9nzSs2vsSVG0w/8ppP+UzCQvf4hgW5828u5fQRwaiYhQ8WMqxMRWW6YauJ3p4xUQF
         cVlFEsbZkBVjIKH6x6+ahqON+VBj4QKq9AELc3iCboaT2/rFOOKwdXQA2TArtrpP7VZ9
         1QE4yKsmY7www7xwCVsBDPFKzbv12FvrIpXfJtQf2KkKgjrbctah9QR6XeKC1bxqrAFk
         /CtA==
X-Gm-Message-State: AGi0Pua/cnOhtPCnGcb9mGIUED6q9LgvIMhYpDaT97Wm7IpjOGT6C+Iz
        hWJqbj+2uvQFxrLePz3oT9M=
X-Google-Smtp-Source: APiQypJdCNmF7MAA0wYyRFyK8VL980uLC1VuRzuc4U653Idhzn5qq/zdoAYRMRN9yYaUHAjVOKxvVQ==
X-Received: by 2002:ae9:ed92:: with SMTP id c140mr34220595qkg.29.1588182089347;
        Wed, 29 Apr 2020 10:41:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] efi/x86: Support builtin command line
Date:   Wed, 29 Apr 2020 13:41:19 -0400
Message-Id: <20200429174120.1497212-11-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
options.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 85a924fecc87..0faba30d6406 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
-	unsigned long cmdline_paddr;
 
 	efi_system_table = sys_table_arg;
 
@@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
 		image_offset = 0;
 	}
 
-	cmdline_paddr = ((u64)hdr->cmd_line_ptr |
-			 ((u64)boot_params->ext_cmd_line_ptr << 32));
-	efi_parse_options((char *)cmdline_paddr);
+#ifdef CONFIG_CMDLINE_BOOL
+	efi_parse_options(CONFIG_CMDLINE);
+#endif
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+					       ((u64)boot_params->ext_cmd_line_ptr << 32));
+		efi_parse_options((char *)cmdline_paddr);
+	}
 
 	/*
 	 * At this point, an initrd may already have been loaded by the
-- 
2.26.2

