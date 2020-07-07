Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849D4217754
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jul 2020 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGGS7j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jul 2020 14:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgGGS7i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Jul 2020 14:59:38 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E87520738;
        Tue,  7 Jul 2020 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594148378;
        bh=Bn+IyxIo+LTpMaVmenFVoMH6nKxa3TFlGyhMt2qcqIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ya2LjsQOpMA4jFX695MpD2n0EPdavGymXS3UOgsc1En6PwLt2szLP5ZfLY/wVahIJ
         qJvdANVkNoNU0pkl0DJabIX2fGVrVfg67+XIlkLPaXMCUUi2UW7mPLKap2AvZXoH2t
         IRDfoHlZhEaauJ/dMQaojYd4Dsh3w/A+dV81pRXc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] efi: use sha256() instead of open coding
Date:   Tue,  7 Jul 2020 11:58:16 -0700
Message-Id: <20200707185818.80177-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
References: <20200707185818.80177-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that there's a function that calculates the SHA-256 digest of a
buffer in one step, use it instead of sha256_init() + sha256_update() +
sha256_final().

Cc: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/firmware/efi/embedded-firmware.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
index a1b199de9006..e97a9c9d010c 100644
--- a/drivers/firmware/efi/embedded-firmware.c
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -37,9 +37,8 @@ static const struct dmi_system_id * const embedded_fw_table[] = {
 static int __init efi_check_md_for_embedded_firmware(
 	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
 {
-	struct sha256_state sctx;
 	struct efi_embedded_fw *fw;
-	u8 sha256[32];
+	u8 hash[32];
 	u64 i, size;
 	u8 *map;
 
@@ -54,10 +53,8 @@ static int __init efi_check_md_for_embedded_firmware(
 		if (memcmp(map + i, desc->prefix, EFI_EMBEDDED_FW_PREFIX_LEN))
 			continue;
 
-		sha256_init(&sctx);
-		sha256_update(&sctx, map + i, desc->length);
-		sha256_final(&sctx, sha256);
-		if (memcmp(sha256, desc->sha256, 32) == 0)
+		sha256(map + i, desc->length, hash);
+		if (memcmp(hash, desc->sha256, 32) == 0)
 			break;
 	}
 	if ((i + desc->length) > size) {
-- 
2.27.0

