Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA42A1C04C6
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD3S2t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:28:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43657 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgD3S2s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id i136so2664370qke.10;
        Thu, 30 Apr 2020 11:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzOcH/m5zVvfS8Ajxoe5u2BiH2fwXioZ/jPs2mokyCI=;
        b=eSNm+45ZOm/agiD7TFn60lu67QtJGjnS5YXo17RpcHVNBPtBilJnSx3d2nlraDrpgk
         NbQzb+SkpBtP/txYzY6CJbxXYsaSd08m1sRSclRwRKpVra0aMjUk4OupFuRnnfrLsdtT
         RpArSK8BNygnJveucnon5f11PTiIFDiwxWZn+Znw4gMeSUJic09Py7wjgaLyjo3ahWrR
         rKAccfkEyxbkneoPJibBQokj8+B/x+PwNMeIIO+tpBJ4gUCa0EBIPd5gjU0P2gku5ru/
         J4AzM2402c4KsVc+7Kd1ZxoXK+fZYsZOYqoYNViNyplkEGP6BzbMs9N7tD09m/2nuke+
         5AIQ==
X-Gm-Message-State: AGi0PubAeDn9iI5dDq+6QyDDSrPDVDJ2BVWDc1h8hnhboxFrDDu2MMVY
        FN2de7d7OH91EkR9E6IfqSY=
X-Google-Smtp-Source: APiQypK3SdIIc2NkvJeAZt7bA9IFLrtVFdXX3J0GwvvGnZ0Se8oD3IETW73STBOW1eJd5UKtAsDm9g==
X-Received: by 2002:a37:e54:: with SMTP id 81mr4363648qko.284.1588271325839;
        Thu, 30 Apr 2020 11:28:45 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:45 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] efi/x86: Use correct size for boot_params
Date:   Thu, 30 Apr 2020 14:28:33 -0400
Message-Id: <20200430182843.2510180-2-nivedita@alum.mit.edu>
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

