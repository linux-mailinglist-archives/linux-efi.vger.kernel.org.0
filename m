Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF02477C6D
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 20:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhLPTXX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 14:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhLPTXW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 14:23:22 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB68C061574
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 11:23:22 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 132so24281202qkj.11
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 11:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+BCPwrkfsgMMS4oXA2uOS9qbqDP/1NzYAX0XstAOPU=;
        b=LtMC1dg5tVLwMXBFPf+v2n/bdM2vXwbFTYBALQLLbgL+Tlyt8UqqSFYRBzZgm5hJtB
         PlN9EoluPLQvdJOY1pAMweK0lbIVZN8tv1l9JtokgxAo6hU8/H6xtll2Pc2Upo+goFOd
         IOzRMC5ktdEL29SjrUNVuti5Hw3XGZOFAjfgHYuYhrp6uZBa60WKCyvqAGbtc/2E37IY
         dkkZvXMhgQz9PXmp4tE09PEthLgecsUlx/WeHPjn3HZEJW1jLutVC8OLtDvEnCZMkTDE
         /Zcxv1WFToNIVEINQRWKB+yc+eGSSXfF4SwV1spENCBEoceBNpLiH/UEeNgBbM7TvxAy
         Z31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+BCPwrkfsgMMS4oXA2uOS9qbqDP/1NzYAX0XstAOPU=;
        b=uzSHJaBWvixjNa09iS1eyt7fVr+g7coS/uH6iAnEMM7jyfeNiPH137q9getbSxv+Kr
         2Vlqne/XtI1hQkRB4HC0UHuLPxnhChXHg8hg5dWMmgleWjhnQ7sm0VzVLwiSTAFsoRtd
         VCmIwobmAeU7hWrXkLD8mVgm3Ou3OglpQERF6sQjeLXxbyJC5k3cO/BpX/J1kBbIWYVr
         d8KaHCskgbxZCiu8nGvil84G6jYTpH7CXfGp69gLbdJE0wbzd0iMiKUJXyBHFTjzW0K/
         j78v78Dc9obidxxnDQ4mOvzs8YP3x2p0EzdGHoNgqHg/lh35rcDjDOuh/uQqLvEWxVZB
         nL4A==
X-Gm-Message-State: AOAM530ECzqwmyLJCuYsGb/cocDLeQbVBqUFbGC1uNj8Sbi6SBsQ/rFU
        XTGwzGaFvYNWTgzHJMJDQenHeg==
X-Google-Smtp-Source: ABdhPJyII4TMuf9tlEyytZBN5v/y4Y2dwyfW7UaFoDz3QyD92ZYPmat6ljjCCH5MYp4igQxgvQkT6g==
X-Received: by 2002:a05:620a:4f6:: with SMTP id b22mr12857484qkh.98.1639682601499;
        Thu, 16 Dec 2021 11:23:21 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id bp38sm3383460qkb.66.2021.12.16.11.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:23:21 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v4 3/5] x86/e820: Tag e820_entry with crypto capabilities
Date:   Thu, 16 Dec 2021 16:22:20 -0300
Message-Id: <20211216192222.127908-4-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new member in e820_entry to hold whether an entry is able to do
hardware memory encryption or not.

Add a new argument to __e820__range_add to accept this new
crypto_capable.

Add a new argument to __e820__update_range to be able to change a
region's crypto_capable member. Also, change its behavior a little,
before if you wanted to update a region with its same type it was a
BUG_ON; now if you call it with both old_type and new_type equals,
then the function won't change the types, just crypto_capable.

Change e820__update_table to handle merging and overlap problems
taking into account crypto_capable.

Add a function to mark a range as crypto, using __e820__range_update
in the background. This will be called when initializing EFI.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/include/asm/e820/api.h   |  1 +
 arch/x86/include/asm/e820/types.h |  1 +
 arch/x86/kernel/e820.c            | 59 ++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..677dcbabcc8b 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
+extern u64  e820__range_mark_as_crypto_capable(u64 start, u64 size);
 
 extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d886d0..7b510dffd3b9 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -56,6 +56,7 @@ struct e820_entry {
 	u64			addr;
 	u64			size;
 	enum e820_type		type;
+	u8			crypto_capable;
 } __attribute__((packed));
 
 /*
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..001d64686938 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -163,7 +163,7 @@ int e820__get_entry_type(u64 start, u64 end)
 /*
  * Add a memory region to the kernel E820 map.
  */
-static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type)
+static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type, u8 crypto_capable)
 {
 	int x = table->nr_entries;
 
@@ -176,12 +176,13 @@ static void __init __e820__range_add(struct e820_table *table, u64 start, u64 si
 	table->entries[x].addr = start;
 	table->entries[x].size = size;
 	table->entries[x].type = type;
+	table->entries[x].crypto_capable = crypto_capable;
 	table->nr_entries++;
 }
 
 void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 {
-	__e820__range_add(e820_table, start, size, type);
+	__e820__range_add(e820_table, start, size, type, 0);
 }
 
 static void __init e820_print_type(enum e820_type type)
@@ -211,6 +212,8 @@ void __init e820__print_table(char *who)
 			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
 
 		e820_print_type(e820_table->entries[i].type);
+		if (e820_table->entries[i].crypto_capable)
+			pr_cont("; crypto-capable");
 		pr_cont("\n");
 	}
 }
@@ -327,6 +330,7 @@ int __init e820__update_table(struct e820_table *table)
 	unsigned long long last_addr;
 	u32 new_nr_entries, overlap_entries;
 	u32 i, chg_idx, chg_nr;
+	u8 current_crypto, last_crypto;
 
 	/* If there's only one memory region, don't bother: */
 	if (table->nr_entries < 2)
@@ -367,6 +371,7 @@ int __init e820__update_table(struct e820_table *table)
 	new_nr_entries = 0;	 /* Index for creating new map entries */
 	last_type = 0;		 /* Start with undefined memory type */
 	last_addr = 0;		 /* Start with 0 as last starting address */
+	last_crypto = 0;
 
 	/* Loop through change-points, determining effect on the new map: */
 	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
@@ -388,13 +393,17 @@ int __init e820__update_table(struct e820_table *table)
 		 * 1=usable, 2,3,4,4+=unusable)
 		 */
 		current_type = 0;
+		current_crypto = 1;
 		for (i = 0; i < overlap_entries; i++) {
+			current_crypto = current_crypto && overlap_list[i]->crypto_capable;
 			if (overlap_list[i]->type > current_type)
 				current_type = overlap_list[i]->type;
 		}
 
 		/* Continue building up new map based on this information: */
-		if (current_type != last_type || e820_nomerge(current_type)) {
+		if (current_type != last_type ||
+		    current_crypto != last_crypto ||
+		    e820_nomerge(current_type)) {
 			if (last_type != 0)	 {
 				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
 				/* Move forward only if the new size was non-zero: */
@@ -406,9 +415,12 @@ int __init e820__update_table(struct e820_table *table)
 			if (current_type != 0)	{
 				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
 				new_entries[new_nr_entries].type = current_type;
+				new_entries[new_nr_entries].crypto_capable = current_crypto;
+
 				last_addr = change_point[chg_idx]->addr;
 			}
 			last_type = current_type;
+			last_crypto = current_crypto;
 		}
 	}
 
@@ -459,14 +471,20 @@ static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
 	return __append_e820_table(entries, nr_entries);
 }
 
+/*
+ * Update a memory range.
+ *
+ * If old_type and new_type are the same then ignore the types and
+ * just change crypto_capable.
+ */
 static u64 __init
-__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
+__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type, u8 crypto_capable)
 {
 	u64 end;
 	unsigned int i;
 	u64 real_updated_size = 0;
 
-	BUG_ON(old_type == new_type);
+	bool update_crypto = new_type == old_type;
 
 	if (size > (ULLONG_MAX - start))
 		size = ULLONG_MAX - start;
@@ -476,6 +494,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 	e820_print_type(old_type);
 	pr_cont(" ==> ");
 	e820_print_type(new_type);
+	if (crypto_capable)
+		pr_cont("; crypto-capable");
 	pr_cont("\n");
 
 	for (i = 0; i < table->nr_entries; i++) {
@@ -483,22 +503,27 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 		u64 final_start, final_end;
 		u64 entry_end;
 
-		if (entry->type != old_type)
+		if (entry->type != old_type && !update_crypto)
 			continue;
 
+		if (update_crypto)
+			new_type = entry->type;
+
 		entry_end = entry->addr + entry->size;
 
 		/* Completely covered by new range? */
 		if (entry->addr >= start && entry_end <= end) {
 			entry->type = new_type;
+			entry->crypto_capable = crypto_capable;
 			real_updated_size += entry->size;
 			continue;
 		}
 
 		/* New range is completely covered? */
 		if (entry->addr < start && entry_end > end) {
-			__e820__range_add(table, start, size, new_type);
-			__e820__range_add(table, end, entry_end - end, entry->type);
+			__e820__range_add(table, start, size, new_type, crypto_capable);
+			__e820__range_add(table, end, entry_end - end,
+					  entry->type, entry->crypto_capable);
 			entry->size = start - entry->addr;
 			real_updated_size += size;
 			continue;
@@ -510,7 +535,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 		if (final_start >= final_end)
 			continue;
 
-		__e820__range_add(table, final_start, final_end - final_start, new_type);
+		__e820__range_add(table, final_start, final_end - final_start,
+				  new_type, crypto_capable);
 
 		real_updated_size += final_end - final_start;
 
@@ -527,14 +553,19 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 	return real_updated_size;
 }
 
+u64 __init e820__range_mark_as_crypto_capable(u64 start, u64 size)
+{
+	return __e820__range_update(e820_table, start, size, 0, 0, true);
+}
+
 u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
 {
-	return __e820__range_update(e820_table, start, size, old_type, new_type);
+	return __e820__range_update(e820_table, start, size, old_type, new_type, false);
 }
 
 static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
 {
-	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
+	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type, false);
 }
 
 /* Remove a range of memory from the E820 table: */
@@ -572,7 +603,9 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 
 		/* Is the new range completely covered? */
 		if (entry->addr < start && entry_end > end) {
-			e820__range_add(end, entry_end - end, entry->type);
+			__e820__range_add(e820_table, end, entry_end - end,
+					  entry->type, entry->crypto_capable);
+
 			entry->size = start - entry->addr;
 			real_removed_size += size;
 			continue;
@@ -1322,6 +1355,8 @@ void __init e820__memblock_setup(void)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
+		if (entry->crypto_capable)
+			memblock_mark_crypto_capable(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.30.2

