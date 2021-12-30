Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1776C481AF1
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 09:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhL3I7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 03:59:11 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60846 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL3I7L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 03:59:11 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2574320140C;
        Thu, 30 Dec 2021 08:59:10 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 6720C8067E; Thu, 30 Dec 2021 09:59:05 +0100 (CET)
Date:   Thu, 30 Dec 2021 09:59:05 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v8.1 7/7] random: move NUMA-related code to CONFIG_NUMA
 section
Message-ID: <Yc102b3gCiIjC88e@owl.dominikbrodowski.net>
References: <20211228153826.448805-1-Jason@zx2c4.com>
 <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-7-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229211009.108091-7-linux@dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

By moving crng_initialize_secondary() and crng_init_try_arch() a few
lines lower to the CONFIG_NUMA ifdef section, we can remove the
__maybe_unused attribute from the first function, and reduce the
footprint for !CONFIG_NUMA.

Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c |   52 +++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

v8->v8.1:
crng_init_try_arch() isn't used elsewhere, therefore it needed to be
moved to CONFIG_NUMA as well.

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a5bf662578cb..181b61104948 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -783,24 +783,6 @@ static int __init parse_trust_cpu(char *arg)
 }
 early_param("random.trust_cpu", parse_trust_cpu);
 
-static bool crng_init_try_arch(struct crng_state *crng)
-{
-	int		i;
-	bool		arch_init = true;
-	unsigned long	rv;
-
-	for (i = 4; i < 16; i++) {
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv)) {
-			rv = random_get_entropy();
-			arch_init = false;
-		}
-		crng->state[i] ^= rv;
-	}
-
-	return arch_init;
-}
-
 static bool __init crng_init_try_arch_early(struct crng_state *crng)
 {
 	int		i;
@@ -819,14 +801,6 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
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
@@ -871,6 +845,32 @@ static void crng_finalize_init(struct crng_state *crng)
 }
 
 #ifdef CONFIG_NUMA
+static bool crng_init_try_arch(struct crng_state *crng)
+{
+	int		i;
+	bool		arch_init = true;
+	unsigned long	rv;
+
+	for (i = 4; i < 16; i++) {
+		if (!arch_get_random_seed_long(&rv) &&
+		    !arch_get_random_long(&rv)) {
+			rv = random_get_entropy();
+			arch_init = false;
+		}
+		crng->state[i] ^= rv;
+	}
+
+	return arch_init;
+}
+
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
