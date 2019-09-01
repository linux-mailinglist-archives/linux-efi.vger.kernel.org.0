Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2597EA4BE7
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfIAUgM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 16:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbfIAUgL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Sep 2019 16:36:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E09698BA2D4;
        Sun,  1 Sep 2019 20:36:10 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF20860606;
        Sun,  1 Sep 2019 20:36:06 +0000 (UTC)
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
Subject: [PATCH 7/9] crypto: n2 - Rename arrays to avoid conflict with crypto/sha256.h
Date:   Sun,  1 Sep 2019 22:35:30 +0200
Message-Id: <20190901203532.2615-8-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Sun, 01 Sep 2019 20:36:11 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rename the sha*_init arrays to n2_sha*_init so that they do not conflict
with the functions declared in crypto/sha256.h.

Also rename md5_init to n2_md5_init for consistency.

This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/crypto/n2_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 760e72a5893b..c4bf85fc9601 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1295,20 +1295,20 @@ struct n2_hash_tmpl {
 	u8		hmac_type;
 };
 
-static const u32 md5_init[MD5_HASH_WORDS] = {
+static const u32 n2_md5_init[MD5_HASH_WORDS] = {
 	cpu_to_le32(MD5_H0),
 	cpu_to_le32(MD5_H1),
 	cpu_to_le32(MD5_H2),
 	cpu_to_le32(MD5_H3),
 };
-static const u32 sha1_init[SHA1_DIGEST_SIZE / 4] = {
+static const u32 n2_sha1_init[SHA1_DIGEST_SIZE / 4] = {
 	SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4,
 };
-static const u32 sha256_init[SHA256_DIGEST_SIZE / 4] = {
+static const u32 n2_sha256_init[SHA256_DIGEST_SIZE / 4] = {
 	SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
 	SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7,
 };
-static const u32 sha224_init[SHA256_DIGEST_SIZE / 4] = {
+static const u32 n2_sha224_init[SHA256_DIGEST_SIZE / 4] = {
 	SHA224_H0, SHA224_H1, SHA224_H2, SHA224_H3,
 	SHA224_H4, SHA224_H5, SHA224_H6, SHA224_H7,
 };
@@ -1316,7 +1316,7 @@ static const u32 sha224_init[SHA256_DIGEST_SIZE / 4] = {
 static const struct n2_hash_tmpl hash_tmpls[] = {
 	{ .name		= "md5",
 	  .hash_zero	= md5_zero_message_hash,
-	  .hash_init	= md5_init,
+	  .hash_init	= n2_md5_init,
 	  .auth_type	= AUTH_TYPE_MD5,
 	  .hmac_type	= AUTH_TYPE_HMAC_MD5,
 	  .hw_op_hashsz	= MD5_DIGEST_SIZE,
@@ -1324,7 +1324,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .block_size	= MD5_HMAC_BLOCK_SIZE },
 	{ .name		= "sha1",
 	  .hash_zero	= sha1_zero_message_hash,
-	  .hash_init	= sha1_init,
+	  .hash_init	= n2_sha1_init,
 	  .auth_type	= AUTH_TYPE_SHA1,
 	  .hmac_type	= AUTH_TYPE_HMAC_SHA1,
 	  .hw_op_hashsz	= SHA1_DIGEST_SIZE,
@@ -1332,7 +1332,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .block_size	= SHA1_BLOCK_SIZE },
 	{ .name		= "sha256",
 	  .hash_zero	= sha256_zero_message_hash,
-	  .hash_init	= sha256_init,
+	  .hash_init	= n2_sha256_init,
 	  .auth_type	= AUTH_TYPE_SHA256,
 	  .hmac_type	= AUTH_TYPE_HMAC_SHA256,
 	  .hw_op_hashsz	= SHA256_DIGEST_SIZE,
@@ -1340,7 +1340,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .block_size	= SHA256_BLOCK_SIZE },
 	{ .name		= "sha224",
 	  .hash_zero	= sha224_zero_message_hash,
-	  .hash_init	= sha224_init,
+	  .hash_init	= n2_sha224_init,
 	  .auth_type	= AUTH_TYPE_SHA256,
 	  .hmac_type	= AUTH_TYPE_RESERVED,
 	  .hw_op_hashsz	= SHA256_DIGEST_SIZE,
-- 
2.23.0

