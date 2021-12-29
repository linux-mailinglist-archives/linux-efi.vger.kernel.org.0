Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956D4816FA
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 22:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhL2VNx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 16:13:53 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33320 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhL2VNu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 16:13:50 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1F5CB200278;
        Wed, 29 Dec 2021 21:13:48 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D6AA180F5A; Wed, 29 Dec 2021 22:10:18 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux@dominikbrodowski.net
Subject: [PATCH v8 5/7] random: harmonize "crng init done" messages
Date:   Wed, 29 Dec 2021 22:10:07 +0100
Message-Id: <20211229211009.108091-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229211009.108091-1-linux@dominikbrodowski.net>
References: <20211228153826.448805-1-Jason@zx2c4.com>
 <20211229211009.108091-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We print out "crng init done" for !TRUST_CPU, so we should also print
out the same for TRUST_CPU.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9d4e1907e4b1..9b5eb6cf82ce 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -831,7 +831,7 @@ static void __init crng_initialize_primary(struct crng_state *crng)
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
-		pr_notice("crng done (trusting CPU's manufacturer)\n");
+		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
-- 
2.34.1

