Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D31FFCD9
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jun 2020 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFRUn2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Jun 2020 16:43:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40201 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgFRUnT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Jun 2020 16:43:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id c185so6946460qke.7
        for <linux-efi@vger.kernel.org>; Thu, 18 Jun 2020 13:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFaPMB2tSBxEdI9eNZVWz8iq1mr37AhdNy5TZMgC9BU=;
        b=ewUNP3U2adgW7nF2S5rTT0yQG/rbCNhTj+pqB31okvkzLOUbkn73VWtILqsPr2ecnc
         SSYJOk/JQB8vejjB84RgBHkvCn9LJQERxgD7Ny01i3/BLT6J269PF/ThdJlZm4I4sSjf
         y7MeTZTAgcDOsU5H311wD2aKPVuNrKPetoXYgs04rfJ22ba6mBdHYcSFfY6oZdrPWeAs
         Oj+Uzgirr3Jwn/hEflp8Uv2IfJpCXZPTusdPm5zanfBVtj9KSuobmmn3MJL9snlfy3YQ
         l1kMk7tMJnRH0JPYp6nGMsw4yAmY/7tNCfsgqkhM6kiT/BliSAt/4iNoIDtLU2mFW6xk
         jFOQ==
X-Gm-Message-State: AOAM532IBYEO5zvBJr0a9zeDFDFIFnFZjT3/ro08qOpuLme6gUP9JyUH
        nMs1UhyalWA5QSw3s50TMwG66lCA
X-Google-Smtp-Source: ABdhPJyCeD9MPufQogTXzVPLkFRK5wnDyIviiiuOmZS6rIKZ9gKK/ItcfWQLG+34Ps40lrB6vx5RZQ==
X-Received: by 2002:a37:7786:: with SMTP id s128mr241244qkc.315.1592512997568;
        Thu, 18 Jun 2020 13:43:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l56sm4920451qtl.33.2020.06.18.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:43:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/x86: Only copy upto the end of setup_header
Date:   Thu, 18 Jun 2020 16:43:15 -0400
Message-Id: <20200618204315.3854787-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When copying the setup_header into the boot_params buffer, only the data
that is actually part of the setup_header should be copied.

efi_pe_entry() currently copies the entire second sector, which
initializes some of the fields in boot_params beyond the setup_header
with garbage (i.e. part of the real-mode boot code gets copied into
those fields).

This does not cause any issues currently because the fields that are
overwritten are padding, BIOS EDD information that won't get used, and
the E820 table which will get properly filled in later.

Fix this to only copy data that is actually part of the setup_header
structure.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 37e82bf397aa..3672539cb96e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -8,6 +8,7 @@
 
 #include <linux/efi.h>
 #include <linux/pci.h>
+#include <linux/stddef.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -388,8 +389,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	hdr = &boot_params->hdr;
 
-	/* Copy the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512, 512);
+	/* Copy the setup header from the second sector to boot_params */
+	memcpy(&hdr->jump, image_base + 512,
+	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
 
 	/*
 	 * Fill out some of the header fields ourselves because the
-- 
2.26.2

