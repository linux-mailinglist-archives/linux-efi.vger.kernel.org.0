Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6D232576
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jul 2020 21:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgG2TdD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 15:33:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39878 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2TdD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 15:33:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id l6so23389960qkc.6
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 12:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GH4hjr+KtlyXRPJQ7rmAwftHj2VvTfyj8hXxXoMFuY=;
        b=HEPVNfq+Engxol6Zw9TztcMU2YksBTYs4NqajoEpdtF3lKGqtbMaDrK6dx96AlASxX
         4oSA3E9MiEKIsHOZLEbuFA3L25KYEF38jz4RiWViTyNdCkGrIe+G2kQrDKQt2mesVcbv
         dprNNqKfas8el/gjCiyaUIagDiAEcE84X3wuMswZTHVk433E5MKV3AN1BGjx/Cp3yCMg
         buMicg8ORA9EOITP7v7Awd9GN25bdombiiBtcWPmRkXDYKXnypp0PlVSMfUC+4+EKYP5
         KuHv2QCwp7KbiNQmTO6jH3ahFy8FiWlnAZIhK+nAFPwbIblIMQG2XiwLxxDq/oXmqUYv
         y/Mw==
X-Gm-Message-State: AOAM5303NkYnPHSlxxX60v1n5Z7qiBIlYX01j3f35zIgYcQz20bwzbKH
        ZTEz6K0e4y2+TpKxbNd4ArL9nrjj
X-Google-Smtp-Source: ABdhPJzmKwLNt5WgX4let9WIxubXXp7LLdplDrOv//m4GLwrqgXMCF377xjRkMnA6NF7QEM9cNtiuw==
X-Received: by 2002:a05:620a:132d:: with SMTP id p13mr16004330qkj.161.1596051181753;
        Wed, 29 Jul 2020 12:33:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g24sm2682908qta.27.2020.07.29.12.33.00
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:33:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/libstub: Handle NULL cmdline
Date:   Wed, 29 Jul 2020 15:33:00 -0400
Message-Id: <20200729193300.598448-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Treat a NULL cmdline the same as empty. Although this is unlikely to
happen in practice, the x86 kernel entry does check for NULL cmdline and
handles it, so do it here as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 37ff34e7b85e..f53652a3a106 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -187,10 +187,14 @@ int efi_printk(const char *fmt, ...)
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
-	size_t len = strlen(cmdline) + 1;
+	size_t len;
 	efi_status_t status;
 	char *str, *buf;
 
+	if (!cmdline)
+		return EFI_SUCCESS;
+
+	len = strlen(cmdline) + 1;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
 	if (status != EFI_SUCCESS)
 		return status;
-- 
2.26.2

