Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E456F1BE583
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgD2Rl0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:26 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36958 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgD2RlX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:23 -0400
Received: by mail-qv1-f65.google.com with SMTP id y19so1576519qvv.4;
        Wed, 29 Apr 2020 10:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzOcH/m5zVvfS8Ajxoe5u2BiH2fwXioZ/jPs2mokyCI=;
        b=fjvTBd5axusa8j50qjOLy/Pl5KexImAIDdG4tW1m+Ypn0HclwKdj8WWTsfcw13/KLi
         +PXmkISfJpFEUjfi7qvar3dVw6Omtvo3cxE1j9T/6OZf5F4R2u0eBx2/4JQNKdD486dn
         OGfVMwDkzItUc3C630f82rLvySv+/goJwqCCZkAWFqdWia3EmgRX7mT7xS23glLXvX2E
         NuDzr0U9pB4r5pOfqa811ZPRDEBB53drRMyu56J8RzyRGAcb9h4Yr73macVNKMF7Epll
         Lj4TwP4OyMMQ6geX5byMXU9VdQtKvWSXFhBNu4O0ot0YSiWm+LOL08AgqOoa572EeUal
         OEgQ==
X-Gm-Message-State: AGi0PuYaIL+ar01BJRGAE+R0YtSFPeGdH2Q7kqnJ5j0LYdM2u0fshxmh
        sKCXT2VPX8rF1932yhJX+Hw=
X-Google-Smtp-Source: APiQypJjWyRFFMBmXSV7SqYxkg8nbzXq6dVoC+akmTG0YOzx6zqkoUtn024JEjBQfIFxs5PAIjPJkw==
X-Received: by 2002:ad4:45ec:: with SMTP id q12mr34740939qvu.157.1588182082544;
        Wed, 29 Apr 2020 10:41:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] efi/x86: Use correct size for boot_params
Date:   Wed, 29 Apr 2020 13:41:10 -0400
Message-Id: <20200429174120.1497212-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

struct boot_params is only 4096 bytes, not 16384. Fix this by using
sizeof(struct boot_params) instead of hardcoding the incorrect value.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 597793fe8d22..d4bafd7f6f9f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -379,13 +379,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
+	status = efi_allocate_pages(sizeof(struct boot_params),
+				    (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
 		efi_exit(handle, status);
 	}
 
-	memset(boot_params, 0x0, 0x4000);
+	memset(boot_params, 0x0, sizeof(struct boot_params));
 
 	hdr = &boot_params->hdr;
 
@@ -439,7 +440,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 fail2:
 	efi_free(options_size, (unsigned long)cmdline_ptr);
 fail:
-	efi_free(0x4000, (unsigned long)boot_params);
+	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
 
 	efi_exit(handle, status);
 }
-- 
2.26.2

