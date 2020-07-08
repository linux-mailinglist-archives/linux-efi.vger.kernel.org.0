Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C7218D36
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgGHQke (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 12:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgGHQkd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jul 2020 12:40:33 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F2620836;
        Wed,  8 Jul 2020 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594226433;
        bh=qcv6XOwJonmyIIS3hjVNF+gYz6JEyXz2OkaZsFvK0+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HySN+awD9iBiPt4DP2uFwQXfuhPkMMg7/4nd8JIZ8wj+hRKakcoLISFVjITcfaLkq
         zJ+HqsMsQeeWUelDfYEPbRW+vGMX/x6IS3vivCe2qiDb/XgXJrvLaxrlVo9zpAFHWh
         t6FBsrdGgpnaUZBm/2kdmslH53WpA6zHEsQsDha4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/5] efi: use sha256() instead of open coding
Date:   Wed,  8 Jul 2020 09:39:41 -0700
Message-Id: <20200708163943.52071-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708163943.52071-1-ebiggers@kernel.org>
References: <20200708163943.52071-1-ebiggers@kernel.org>
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

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
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

