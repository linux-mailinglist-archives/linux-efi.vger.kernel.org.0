Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690771BE582
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgD2Rlw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35429 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgD2Rl1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id c63so2900254qke.2;
        Wed, 29 Apr 2020 10:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNcbFcBqpcuqFq869O2rJKX45xd3G8ARmUjKz33/zqw=;
        b=F2eZMJjns1F3zNykCXKsi3Z6VupLI3mvnRu8EwGxd7H8jJg9VOgpPra/hDN7ie/XYG
         eGAfevAf3ciHEBBhEjCAbTIRC4IXHtw/b4gbIuJvtL6adhx2oWXfAn9RKWD5xxZP5Wj1
         SW3WxHWgjDO3cHchgztWwjvNPuFk3QI9k4qEY2ab5zDhCjFq3S9URS0EcY0A0e1+PDO5
         fXSnA1260OUjoZG46p37x0yURyXfKIm0tI8XRYAM8+SotEOZ+MwdWcNPMk11n4o3t4+Z
         fC57xgmASNr8eF4XQxYOE/oH0q5Fm5AtNPkd4138S11yQNGmIwwZk6CnBkOKxZXXeYoX
         KJeg==
X-Gm-Message-State: AGi0PubokkgafaTKMzEuewxm2+E2MAA+GocCz+OCiyHlXZO/1P6osZQv
        2gqO/n8sJ15MfDTXoMA/p2iZf0cClHk=
X-Google-Smtp-Source: APiQypKTW2hHx8g1COTK3HONNfuPE920a4LtjOiRXSx3Vb+HF8SQ04prPnlHzQYqye/9WDbwXTPi0g==
X-Received: by 2002:a37:a9c7:: with SMTP id s190mr33631397qke.75.1588182086301;
        Wed, 29 Apr 2020 10:41:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] efi/tpm: Use pr_efi_err for error messages
Date:   Wed, 29 Apr 2020 13:41:15 -0400
Message-Id: <20200429174120.1497212-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use pr_efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 1d59e103a2e3..8a16983fad98 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -119,7 +119,7 @@ void efi_retrieve_tpm2_eventlog(void)
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk("Unable to allocate memory for event log\n");
+		pr_efi_err("Unable to allocate memory for event log\n");
 		return;
 	}
 
-- 
2.26.2

