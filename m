Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70CA4BD3
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfIAUfp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 16:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfIAUfo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Sep 2019 16:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0144F368DA;
        Sun,  1 Sep 2019 20:35:44 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B75DE60606;
        Sun,  1 Sep 2019 20:35:39 +0000 (UTC)
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
Subject: [PATCH 1/9] crypto: arm - Rename functions to avoid conflict with crypto/sha256.h
Date:   Sun,  1 Sep 2019 22:35:24 +0200
Message-Id: <20190901203532.2615-2-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 01 Sep 2019 20:35:44 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rename static / file-local functions so that they do not conflict with
the functions declared in crypto/sha256.h.

This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/crypto/sha256_glue.c      |  8 ++++----
 arch/arm/crypto/sha256_neon_glue.c | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index 70efa9656bff..215497f011f2 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -39,7 +39,7 @@ int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL(crypto_sha256_arm_update);
 
-static int sha256_final(struct shash_desc *desc, u8 *out)
+static int crypto_sha256_arm_final(struct shash_desc *desc, u8 *out)
 {
 	sha256_base_do_finalize(desc,
 				(sha256_block_fn *)sha256_block_data_order);
@@ -51,7 +51,7 @@ int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
 {
 	sha256_base_do_update(desc, data, len,
 			      (sha256_block_fn *)sha256_block_data_order);
-	return sha256_final(desc, out);
+	return crypto_sha256_arm_final(desc, out);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_finup);
 
@@ -59,7 +59,7 @@ static struct shash_alg algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	crypto_sha256_arm_update,
-	.final		=	sha256_final,
+	.final		=	crypto_sha256_arm_final,
 	.finup		=	crypto_sha256_arm_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
@@ -73,7 +73,7 @@ static struct shash_alg algs[] = { {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
 	.update		=	crypto_sha256_arm_update,
-	.final		=	sha256_final,
+	.final		=	crypto_sha256_arm_final,
 	.finup		=	crypto_sha256_arm_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
diff --git a/arch/arm/crypto/sha256_neon_glue.c b/arch/arm/crypto/sha256_neon_glue.c
index a7ce38a36006..38645e415196 100644
--- a/arch/arm/crypto/sha256_neon_glue.c
+++ b/arch/arm/crypto/sha256_neon_glue.c
@@ -25,8 +25,8 @@
 asmlinkage void sha256_block_data_order_neon(u32 *digest, const void *data,
 					     unsigned int num_blks);
 
-static int sha256_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
+static int crypto_sha256_neon_update(struct shash_desc *desc, const u8 *data,
+				     unsigned int len)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
@@ -42,8 +42,8 @@ static int sha256_update(struct shash_desc *desc, const u8 *data,
 	return 0;
 }
 
-static int sha256_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
+static int crypto_sha256_neon_finup(struct shash_desc *desc, const u8 *data,
+				    unsigned int len, u8 *out)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha256_arm_finup(desc, data, len, out);
@@ -59,17 +59,17 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_base_finish(desc, out);
 }
 
-static int sha256_final(struct shash_desc *desc, u8 *out)
+static int crypto_sha256_neon_final(struct shash_desc *desc, u8 *out)
 {
-	return sha256_finup(desc, NULL, 0, out);
+	return crypto_sha256_neon_finup(desc, NULL, 0, out);
 }
 
 struct shash_alg sha256_neon_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
-	.update		=	sha256_update,
-	.final		=	sha256_final,
-	.finup		=	sha256_finup,
+	.update		=	crypto_sha256_neon_update,
+	.final		=	crypto_sha256_neon_final,
+	.finup		=	crypto_sha256_neon_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
@@ -81,9 +81,9 @@ struct shash_alg sha256_neon_algs[] = { {
 }, {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
-	.update		=	sha256_update,
-	.final		=	sha256_final,
-	.finup		=	sha256_finup,
+	.update		=	crypto_sha256_neon_update,
+	.final		=	crypto_sha256_neon_final,
+	.finup		=	crypto_sha256_neon_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
-- 
2.23.0

