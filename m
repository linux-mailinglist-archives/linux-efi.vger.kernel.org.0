Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4638AA4BD5
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 22:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfIAUfu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 16:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfIAUft (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Sep 2019 16:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BDFE8535D;
        Sun,  1 Sep 2019 20:35:48 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4872060606;
        Sun,  1 Sep 2019 20:35:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Atul Gupta <atul.gupta@chelsio.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] crypto: arm64 - Rename functions to avoid conflict with crypto/sha256.h
Date:   Sun,  1 Sep 2019 22:35:25 +0200
Message-Id: <20190901203532.2615-3-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 01 Sep 2019 20:35:48 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rename static / file-local functions so that they do not conflict with
the functions declared in crypto/sha256.h.

This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm64/crypto/sha256-glue.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
index 04b9d17b0733..e273faca924f 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -30,15 +30,15 @@ EXPORT_SYMBOL(sha256_block_data_order);
 asmlinkage void sha256_block_neon(u32 *digest, const void *data,
 				  unsigned int num_blks);
 
-static int sha256_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
+static int crypto_sha256_arm64_update(struct shash_desc *desc, const u8 *data,
+				      unsigned int len)
 {
 	return sha256_base_do_update(desc, data, len,
 				(sha256_block_fn *)sha256_block_data_order);
 }
 
-static int sha256_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
+static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
+				     unsigned int len, u8 *out)
 {
 	if (len)
 		sha256_base_do_update(desc, data, len,
@@ -49,17 +49,17 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_base_finish(desc, out);
 }
 
-static int sha256_final(struct shash_desc *desc, u8 *out)
+static int crypto_sha256_arm64_final(struct shash_desc *desc, u8 *out)
 {
-	return sha256_finup(desc, NULL, 0, out);
+	return crypto_sha256_arm64_finup(desc, NULL, 0, out);
 }
 
 static struct shash_alg algs[] = { {
 	.digestsize		= SHA256_DIGEST_SIZE,
 	.init			= sha256_base_init,
-	.update			= sha256_update,
-	.final			= sha256_final,
-	.finup			= sha256_finup,
+	.update			= crypto_sha256_arm64_update,
+	.final			= crypto_sha256_arm64_final,
+	.finup			= crypto_sha256_arm64_finup,
 	.descsize		= sizeof(struct sha256_state),
 	.base.cra_name		= "sha256",
 	.base.cra_driver_name	= "sha256-arm64",
@@ -69,9 +69,9 @@ static struct shash_alg algs[] = { {
 }, {
 	.digestsize		= SHA224_DIGEST_SIZE,
 	.init			= sha224_base_init,
-	.update			= sha256_update,
-	.final			= sha256_final,
-	.finup			= sha256_finup,
+	.update			= crypto_sha256_arm64_update,
+	.final			= crypto_sha256_arm64_final,
+	.finup			= crypto_sha256_arm64_finup,
 	.descsize		= sizeof(struct sha256_state),
 	.base.cra_name		= "sha224",
 	.base.cra_driver_name	= "sha224-arm64",
-- 
2.23.0

