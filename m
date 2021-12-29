Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15A4816F6
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 22:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhL2VNu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 16:13:50 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33256 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhL2VNt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 16:13:49 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 21128201218;
        Wed, 29 Dec 2021 21:13:48 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id AB05A80FAA; Wed, 29 Dec 2021 22:10:20 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux@dominikbrodowski.net
Subject: [PATCH v8 7/7] random: move crng_initialize_secondary to CONFIG_NUMA section
Date:   Wed, 29 Dec 2021 22:10:09 +0100
Message-Id: <20211229211009.108091-7-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229211009.108091-1-linux@dominikbrodowski.net>
References: <20211228153826.448805-1-Jason@zx2c4.com>
 <20211229211009.108091-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

By moving crng_initialize_secondary() a few lines lower to the
CONFIG_NUMA ifdef section, we can remove the __maybe_unused parameter.

Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a5bf662578cb..64949c43f588 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -819,14 +819,6 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 	return arch_init;
 }
 
-static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
-{
-	chacha_init_consts(crng->state);
-	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
-	crng_init_try_arch(crng);
-	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
-}
-
 static void __init crng_initialize_primary(void)
 {
 	struct crng_state *crng = &primary_crng;
@@ -871,6 +863,14 @@ static void crng_finalize_init(struct crng_state *crng)
 }
 
 #ifdef CONFIG_NUMA
+static void crng_initialize_secondary(struct crng_state *crng)
+{
+	chacha_init_consts(crng->state);
+	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
+	crng_init_try_arch(crng);
+	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
+}
+
 static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
-- 
2.34.1

