Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87FA4BE5
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfIAUgH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 16:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbfIAUgH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Sep 2019 16:36:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6808810A8139;
        Sun,  1 Sep 2019 20:36:06 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39B1360606;
        Sun,  1 Sep 2019 20:36:02 +0000 (UTC)
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
Subject: [PATCH 6/9] crypto: chelsio - Rename arrays to avoid conflict with crypto/sha256.h
Date:   Sun,  1 Sep 2019 22:35:29 +0200
Message-Id: <20190901203532.2615-7-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Sun, 01 Sep 2019 20:36:06 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rename the sha*_init arrays to chcr_sha*_init so that they do not conflict
with the functions declared in crypto/sha256.h.

This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/crypto/chelsio/chcr_algo.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.h b/drivers/crypto/chelsio/chcr_algo.h
index ee20dd899e83..d1e6b51df0ce 100644
--- a/drivers/crypto/chelsio/chcr_algo.h
+++ b/drivers/crypto/chelsio/chcr_algo.h
@@ -333,26 +333,26 @@ struct phys_sge_pairs {
 };
 
 
-static const u32 sha1_init[SHA1_DIGEST_SIZE / 4] = {
+static const u32 chcr_sha1_init[SHA1_DIGEST_SIZE / 4] = {
 		SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4,
 };
 
-static const u32 sha224_init[SHA256_DIGEST_SIZE / 4] = {
+static const u32 chcr_sha224_init[SHA256_DIGEST_SIZE / 4] = {
 		SHA224_H0, SHA224_H1, SHA224_H2, SHA224_H3,
 		SHA224_H4, SHA224_H5, SHA224_H6, SHA224_H7,
 };
 
-static const u32 sha256_init[SHA256_DIGEST_SIZE / 4] = {
+static const u32 chcr_sha256_init[SHA256_DIGEST_SIZE / 4] = {
 		SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
 		SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7,
 };
 
-static const u64 sha384_init[SHA512_DIGEST_SIZE / 8] = {
+static const u64 chcr_sha384_init[SHA512_DIGEST_SIZE / 8] = {
 		SHA384_H0, SHA384_H1, SHA384_H2, SHA384_H3,
 		SHA384_H4, SHA384_H5, SHA384_H6, SHA384_H7,
 };
 
-static const u64 sha512_init[SHA512_DIGEST_SIZE / 8] = {
+static const u64 chcr_sha512_init[SHA512_DIGEST_SIZE / 8] = {
 		SHA512_H0, SHA512_H1, SHA512_H2, SHA512_H3,
 		SHA512_H4, SHA512_H5, SHA512_H6, SHA512_H7,
 };
@@ -362,21 +362,21 @@ static inline void copy_hash_init_values(char *key, int digestsize)
 	u8 i;
 	__be32 *dkey = (__be32 *)key;
 	u64 *ldkey = (u64 *)key;
-	__be64 *sha384 = (__be64 *)sha384_init;
-	__be64 *sha512 = (__be64 *)sha512_init;
+	__be64 *sha384 = (__be64 *)chcr_sha384_init;
+	__be64 *sha512 = (__be64 *)chcr_sha512_init;
 
 	switch (digestsize) {
 	case SHA1_DIGEST_SIZE:
 		for (i = 0; i < SHA1_INIT_STATE; i++)
-			dkey[i] = cpu_to_be32(sha1_init[i]);
+			dkey[i] = cpu_to_be32(chcr_sha1_init[i]);
 		break;
 	case SHA224_DIGEST_SIZE:
 		for (i = 0; i < SHA224_INIT_STATE; i++)
-			dkey[i] = cpu_to_be32(sha224_init[i]);
+			dkey[i] = cpu_to_be32(chcr_sha224_init[i]);
 		break;
 	case SHA256_DIGEST_SIZE:
 		for (i = 0; i < SHA256_INIT_STATE; i++)
-			dkey[i] = cpu_to_be32(sha256_init[i]);
+			dkey[i] = cpu_to_be32(chcr_sha256_init[i]);
 		break;
 	case SHA384_DIGEST_SIZE:
 		for (i = 0; i < SHA384_INIT_STATE; i++)
-- 
2.23.0

