Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD70214E392
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgA3UEs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33462 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3UEr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id h23so4279931qkh.0;
        Thu, 30 Jan 2020 12:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gR9wEWnrXuHDCyGLZJV2SKQNiYCDxLyE5ZqlFJvnDGw=;
        b=nnMmepQ0vcddXQL+JQr0GXngyt3xrX5ClRjr1mXJ3cDOeW6TXX2rp3Wnqgb0C4a+zn
         +rQI3qGmvBnOmi8unQIy3yYmJJvTX0Qpk+skgIW03w87wHaDKLe82LNYnnebwBlTlPJZ
         h0XuXDeBPHmWyGQUJAXrK9gPm6Oq0hg47RPsTGVhrmK7gytAlVrZRcdqgc45de76M8pb
         HKmMnBPZ7ZwJdUlUhFFPMnD45rsMf7OLbKxB8neqhpaPTIsmXDdxNd8Hh4lsaWW2Ims/
         728BQpM6RSMHdEKA7ZAjEfB+Ci2phiuFPpQWYOu3HWWQnagsSlZNBwO8MuJoxKyqdOp8
         qlyA==
X-Gm-Message-State: APjAAAWC1LwhgroRvTPsIuzzkn5JQ7RAjs41Rwtn6Guy0qmgwR+uJh7h
        QPboryiDU9/FLv+Iwf2GkmTqTPEH
X-Google-Smtp-Source: APXvYqzGps4RvYmJqa6LUDzHKYKbGwlGDON7O2Qt6yaFSKt3Xb+xEgeUSVj6ZZni1u21qdZH5GP0Lw==
X-Received: by 2002:a05:620a:100d:: with SMTP id z13mr7313606qkj.475.1580414686830;
        Thu, 30 Jan 2020 12:04:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 5/8] efi/x86: Allocate only the required 32 bytes for the GDT
Date:   Thu, 30 Jan 2020 15:04:37 -0500
Message-Id: <20200130200440.1796058-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For the 32-bit boot GDT, we only need 4 descriptors. Allocate the
required 32 bytes using allocate_pool, rather than always allocating a
full page. The UEFI spec guarantees that allocate_pool returns an 8-byte
aligned buffer, so we don't need to do additional alignment.

The "size" stored in the GDT pointer should be one less than the true
size of the GDT.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index a72cfda91d7e..2447e4508aa4 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -350,14 +350,23 @@ static efi_status_t setup_gdt(struct desc_ptr *gdt)
 	efi_status_t status;
 	struct desc_struct *desc;
 
-	gdt->size = 0x800;
-	status = efi_low_alloc(gdt->size, 8, (unsigned long *)&gdt->address);
+	gdt->size = 0x20;
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, gdt->size,
+			     (void **)&gdt->address);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate memory for 'gdt'\n");
 		return status;
 	}
 
 	memset((char *)gdt->address, 0x0, gdt->size);
+
+	/*
+	 * The "size" stored in the GDT pointer is actually a limit value,
+	 * which when added to the base address gives the address of the last
+	 * byte of the GDT. Hence it should be one less than the true size.
+	 */
+	gdt->size--;
+
 	desc = (struct desc_struct *)gdt->address;
 
 	/* The first GDT is a dummy. */
-- 
2.24.1

