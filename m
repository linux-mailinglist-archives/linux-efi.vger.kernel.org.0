Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A503012D320
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfL3SJ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfL3SJ2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:28 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B27C20748;
        Mon, 30 Dec 2019 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729368;
        bh=2ZDafcrOFKSF2ybRq49KajpWushIOtD+aMmrNSMAiQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeCSyG1aj0vE5LjytNEE+uHQsYKF5CRlOuiMpw2+s+6+mqeoJfV7y7RpZgtToVdGq
         bB9YmB40X/UGIwFgUy2T6GVsWZBBa/lVHZqqAi73ClllzvJPcek6QL5gpxxpm9vioX
         Q5XPbhYXeOf6it2OBzhGY9lRMlj48gA8jZ5YtSNE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 04/14] efi/x86: map the entire EFI vendor string before copying it
Date:   Mon, 30 Dec 2019 19:08:24 +0100
Message-Id: <20191230180834.75601-5-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230180834.75601-1-ardb@kernel.org>
References: <20191230180834.75601-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix a couple of issues with the way we map and copy the vendor string:
- we map only 2 bytes, which usually works since you get at least a
  page, but if the vendor string happens to cross a page boundary,
  a crash will result
- only call early_memunmap() if early_memremap() succeeded, or we will
  call it with a NULL address which it doesn't like,
- while at it, switch to early_memremap_ro(), and array indexing rather
  than pointer dereferencing to read the CHAR16 characters.

Fixes: 5b83683f32b1 ("x86: EFI runtime service support")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index d96953d9d4e7..3ce32c31bb61 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -541,7 +541,6 @@ void __init efi_init(void)
 	efi_char16_t *c16;
 	char vendor[100] = "unknown";
 	int i = 0;
-	void *tmp;
 
 #ifdef CONFIG_X86_32
 	if (boot_params.efi_info.efi_systab_hi ||
@@ -566,14 +565,16 @@ void __init efi_init(void)
 	/*
 	 * Show what we know for posterity
 	 */
-	c16 = tmp = early_memremap(efi.systab->fw_vendor, 2);
+	c16 = early_memremap_ro(efi.systab->fw_vendor,
+				sizeof(vendor) * sizeof(efi_char16_t));
 	if (c16) {
-		for (i = 0; i < sizeof(vendor) - 1 && *c16; ++i)
-			vendor[i] = *c16++;
+		for (i = 0; i < sizeof(vendor) - 1 && c16[i]; ++i)
+			vendor[i] = c16[i];
 		vendor[i] = '\0';
-	} else
+		early_memunmap(c16, sizeof(vendor) * sizeof(efi_char16_t));
+	} else {
 		pr_err("Could not map the firmware vendor!\n");
-	early_memunmap(tmp, 2);
+	}
 
 	pr_info("EFI v%u.%.02u by %s\n",
 		efi.systab->hdr.revision >> 16,
-- 
2.20.1

