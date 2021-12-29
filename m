Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14594816FF
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 22:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhL2VN4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 16:13:56 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33348 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhL2VNw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 16:13:52 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 904D120136C;
        Wed, 29 Dec 2021 21:13:48 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 77F7580F5C; Wed, 29 Dec 2021 22:10:19 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux@dominikbrodowski.net
Subject: [PATCH v8 6/7] random: early initialization of ChaCha constants
Date:   Wed, 29 Dec 2021 22:10:08 +0100
Message-Id: <20211229211009.108091-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229211009.108091-1-linux@dominikbrodowski.net>
References: <20211228153826.448805-1-Jason@zx2c4.com>
 <20211229211009.108091-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Previously, the ChaCha constants for the primary pool were only
initialized once rand_initialize() calls crng_initialize_primary().
However, some randomness is actually extracted from the primary pool
beforehand, e.g. by kmem_cache_create(). Therefore, statically
initialize the ChaCha constants for the primary pool.

In exchange, we can remove the dynamic initialization in
crng_initialize_primary(), as it is only called - as the name suggests -
for the primary pool. Therefore, no parameter to this function is needed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c   | 10 +++++++---
 include/crypto/chacha.h | 15 +++++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9b5eb6cf82ce..a5bf662578cb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -457,6 +457,10 @@ struct crng_state {
 
 static struct crng_state primary_crng = {
 	.lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
+	.state[0] = CHACHA_CONSTANT_EXPA, /* "expa" */
+	.state[1] = CHACHA_CONSTANT_ND_3, /* "nd 3" */
+	.state[2] = CHACHA_CONSTANT_2_BY, /* "2-by" */
+	.state[3] = CHACHA_CONSTANT_TE_K, /* "te k" */
 };
 
 /*
@@ -823,9 +827,9 @@ static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-static void __init crng_initialize_primary(struct crng_state *crng)
+static void __init crng_initialize_primary(void)
 {
-	chacha_init_consts(crng->state);
+	struct crng_state *crng = &primary_crng;
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
 	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
@@ -1797,7 +1801,7 @@ int __init rand_initialize(void)
 	init_std_data(&input_pool);
 	if (crng_need_final_init)
 		crng_finalize_init(&primary_crng);
-	crng_initialize_primary(&primary_crng);
+	crng_initialize_primary();
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index dabaee698718..147e56fc755e 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -47,12 +47,19 @@ static inline void hchacha_block(const u32 *state, u32 *out, int nrounds)
 		hchacha_block_generic(state, out, nrounds);
 }
 
+enum chacha_constants { /* expand 32-byte k */
+	CHACHA_CONSTANT_EXPA = 0x61707865U,
+	CHACHA_CONSTANT_ND_3 = 0x3320646eU,
+	CHACHA_CONSTANT_2_BY = 0x79622d32U,
+	CHACHA_CONSTANT_TE_K = 0x6b206574U
+};
+
 static inline void chacha_init_consts(u32 *state)
 {
-	state[0]  = 0x61707865; /* "expa" */
-	state[1]  = 0x3320646e; /* "nd 3" */
-	state[2]  = 0x79622d32; /* "2-by" */
-	state[3]  = 0x6b206574; /* "te k" */
+	state[0]  = CHACHA_CONSTANT_EXPA; /* "expa" */
+	state[1]  = CHACHA_CONSTANT_ND_3; /* "nd 3" */
+	state[2]  = CHACHA_CONSTANT_2_BY; /* "2-by" */
+	state[3]  = CHACHA_CONSTANT_TE_K; /* "te k" */
 }
 
 void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
-- 
2.34.1

