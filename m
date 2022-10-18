Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A546026DE
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJRI26 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJRI2c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 04:28:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2475E9AFC2;
        Tue, 18 Oct 2022 01:27:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63354175D;
        Tue, 18 Oct 2022 01:28:01 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 773723F7D8;
        Tue, 18 Oct 2022 01:27:48 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Jia He <justin.he@arm.com>
Subject: [PATCH v10 6/7] apei/ghes: Use xchg_release() for updating new cache slot instead of cmpxchg()
Date:   Tue, 18 Oct 2022 08:22:13 +0000
Message-Id: <20221018082214.569504-7-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018082214.569504-1-justin.he@arm.com>
References: <20221018082214.569504-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

From: Ard Biesheuvel <ardb@kernel.org>

ghes_estatus_cache_add() selects a slot, and either succeeds in
replacing its contents with a pointer to a new cached item, or it just
gives up and frees the new item again, without attempting to select
another slot even if one might be available.

Since only inserting new items is needed, the race can only cause a failure
if the selected slot was updated with another new item concurrently,
which means that it is arbitrary which of those two items gets
dropped. This means the cmpxchg() and the special case are not necessary,
and hence just drop the existing item unconditionally. Note that this
does not result in loss of error events, it simply means we might
cause a false cache miss, and report the same event one additional
time in quick succession even if the cache should have prevented that.

Move the xchg_release() and call_rcu out of rcu_read_lock/unlock section
since there is no actually dereferencing the pointer at all.

Co-developed-by: Jia He <justin.he@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/apei/ghes.c | 49 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 27c72b175e4b..3ade61e6b7a5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -150,7 +150,7 @@ struct ghes_vendor_record_entry {
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
-static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
@@ -785,31 +785,26 @@ static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
 	return cache;
 }
 
-static void ghes_estatus_cache_free(struct ghes_estatus_cache *cache)
+static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
 {
+	struct ghes_estatus_cache *cache;
 	u32 len;
 
+	cache = container_of(head, struct ghes_estatus_cache, rcu);
 	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
 	len = GHES_ESTATUS_CACHE_LEN(len);
 	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
 	atomic_dec(&ghes_estatus_cache_alloced);
 }
 
-static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
-{
-	struct ghes_estatus_cache *cache;
-
-	cache = container_of(head, struct ghes_estatus_cache, rcu);
-	ghes_estatus_cache_free(cache);
-}
-
 static void ghes_estatus_cache_add(
 	struct acpi_hest_generic *generic,
 	struct acpi_hest_generic_status *estatus)
 {
 	int i, slot = -1, count;
 	unsigned long long now, duration, period, max_period = 0;
-	struct ghes_estatus_cache *cache, *slot_cache = NULL, *new_cache;
+	struct ghes_estatus_cache *cache, *new_cache;
+	struct ghes_estatus_cache __rcu *victim;
 
 	new_cache = ghes_estatus_cache_alloc(generic, estatus);
 	if (new_cache == NULL)
@@ -820,13 +815,11 @@ static void ghes_estatus_cache_add(
 		cache = rcu_dereference(ghes_estatus_caches[i]);
 		if (cache == NULL) {
 			slot = i;
-			slot_cache = NULL;
 			break;
 		}
 		duration = now - cache->time_in;
 		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
 			slot = i;
-			slot_cache = cache;
 			break;
 		}
 		count = atomic_read(&cache->count);
@@ -835,18 +828,30 @@ static void ghes_estatus_cache_add(
 		if (period > max_period) {
 			max_period = period;
 			slot = i;
-			slot_cache = cache;
 		}
 	}
-	/* new_cache must be put into array after its contents are written */
-	smp_wmb();
-	if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
-				  slot_cache, new_cache) == slot_cache) {
-		if (slot_cache)
-			call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);
-	} else
-		ghes_estatus_cache_free(new_cache);
 	rcu_read_unlock();
+
+	if (slot != -1) {
+		/*
+		 * Use release semantics to ensure that ghes_estatus_cached()
+		 * running on another CPU will see the updated cache fields if
+		 * it can see the new value of the pointer.
+		 */
+		victim = xchg_release(&ghes_estatus_caches[slot],
+				      RCU_INITIALIZER(new_cache));
+
+		/*
+		 * At this point, victim may point to a cached item different
+		 * from the one based on which we selected the slot. Instead of
+		 * going to the loop again to pick another slot, let's just
+		 * drop the other item anyway: this may cause a false cache
+		 * miss later on, but that won't cause any problems.
+		 */
+		if (victim)
+			call_rcu(&unrcu_pointer(victim)->rcu,
+				 ghes_estatus_cache_rcu_free);
+	}
 }
 
 static void __ghes_panic(struct ghes *ghes,
-- 
2.25.1

