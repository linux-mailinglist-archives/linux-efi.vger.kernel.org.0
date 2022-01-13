Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA48748DFA5
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 22:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiAMVbD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 16:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiAMVbD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 16:31:03 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07865C06161C
        for <linux-efi@vger.kernel.org>; Thu, 13 Jan 2022 13:31:03 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so1195518oto.4
        for <linux-efi@vger.kernel.org>; Thu, 13 Jan 2022 13:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAoRDHUwm1eMqcpMENH9/PXAOANb+EVYwXPhK3cnDlE=;
        b=WyLcYtkIoEuLzTKFelzWIIRxp2otZLIQNxuK8bOnSYN8hupRQ5twgB0y0nOgm9LYFa
         LkAoZE1KMLj54jhKyrRJKAQqIJA14pYL74bk98T29Vh+BnfHFUucPEVK4w3iyY7ZdvGK
         pGjvFfLkY6pwUTtTZtUzLbQ5gMtDz5tIjSoHomVEsuwyR7v2K8XmkZ9C8zVC1fGigot+
         4W8pYmormQTKPOxQmpnBLhCcUUx0NNvVXMqYr2klyHUUjvnr4A7pWc0tPammCG0NePdk
         FwdYdvLw9/t+tdwWfW+77N9PncJIuQ3Q3L5hWbr//+w2wzULi2HBhfkJE1Wty1NZrfgE
         bi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAoRDHUwm1eMqcpMENH9/PXAOANb+EVYwXPhK3cnDlE=;
        b=08rDuH8AVAsmA6hb+0qSws4IA62dl40S3S6+/uLr5ZMIWzgoJLmnbIgLxoSPA8rUhQ
         Jnx1tgHRQg2f3FjI+UwVaatKDkWdlPPAI5r0zvy44OWKAKLk5zpGznrECawzryoopLnD
         bRw8tw6OY8YmaKpwBZOdkRAoBhG0rDmSLo8pjkyJCpQWeYY1t2fOVAlYSeDDwG/2rL/c
         O7+ONUF/fdH11JS332ClTP4iVB9RwPtFSuzqUhha+dOdDpQcDR6pzCFxtZWMvrJD3tG9
         M5Syu7XpiF1vVPjqG8lT9h3y8guxN4d6OcDfTL9QkuIeZENK1+tjYNwc1Wn8jwxk4L8A
         0+dA==
X-Gm-Message-State: AOAM533FWrhZni0Ct5F1lgN5GUlXvNwGhXCwjqLeuCSEU6C1lxPV6kTs
        LSyb5alvz+LwkyuWIm80qzevbSu7zCmLkree
X-Google-Smtp-Source: ABdhPJzPsE5o2ZryrBn+0ysWSz+aUIEFzgLWkqw12mZ95CWeEziw/kOfErJzDUXmn2mxu4nyuUtYMg==
X-Received: by 2002:a05:6830:2694:: with SMTP id l20mr4819858otu.242.1642109462316;
        Thu, 13 Jan 2022 13:31:02 -0800 (PST)
Received: from localhost (115-127-16-190.fibertel.com.ar. [190.16.127.115])
        by smtp.gmail.com with ESMTPSA id i25sm880263otl.8.2022.01.13.13.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:31:01 -0800 (PST)
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
Subject: [PATCH v5 3/5] x86/e820: Tag e820_entry with crypto capabilities
Date:   Thu, 13 Jan 2022 18:30:25 -0300
Message-Id: <20220113213027.457282-4-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new enum for crypto capabilities.

Add a new member in e820_entry to hold whether an entry is able to do
hardware memory encryption or not.

Add a new function __e820__range_update_crypto similar to
__e820__range_update but to update crypto capabilities.

Change e820__update_table to handle merging and overlap problems
taking into account crypto_capable.

Add a function to mark a range as crypto, using
__e820__range_update_crypto in the background. This will be called
when initializing EFI.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/include/asm/e820/api.h   |   1 +
 arch/x86/include/asm/e820/types.h |  12 +++-
 arch/x86/kernel/e820.c            | 112 ++++++++++++++++++++++++++++--
 3 files changed, 115 insertions(+), 10 deletions(-)

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
index 314f75d886d0..aef03c665f5e 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -46,6 +46,11 @@ enum e820_type {
 	E820_TYPE_RESERVED_KERN	= 128,
 };
 
+enum e820_crypto_capabilities {
+	E820_NOT_CRYPTO_CAPABLE	= 0,
+	E820_CRYPTO_CAPABLE	= 1,
+};
+
 /*
  * A single E820 map entry, describing a memory range of [addr...addr+size-1],
  * of 'type' memory type:
@@ -53,9 +58,10 @@ enum e820_type {
  * (We pack it because there can be thousands of them on large systems.)
  */
 struct e820_entry {
-	u64			addr;
-	u64			size;
-	enum e820_type		type;
+	u64				addr;
+	u64				size;
+	enum e820_type			type;
+	enum e820_crypto_capabilities	crypto_capable;
 } __attribute__((packed));
 
 /*
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..bbf67b77bd18 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -163,7 +163,9 @@ int e820__get_entry_type(u64 start, u64 end)
 /*
  * Add a memory region to the kernel E820 map.
  */
-static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type)
+static void __init __e820__range_add(struct e820_table *table, u64 start,
+				     u64 size, enum e820_type type,
+				     enum e820_crypto_capabilities crypto_capable)
 {
 	int x = table->nr_entries;
 
@@ -176,12 +178,13 @@ static void __init __e820__range_add(struct e820_table *table, u64 start, u64 si
 	table->entries[x].addr = start;
 	table->entries[x].size = size;
 	table->entries[x].type = type;
+	table->entries[x].crypto_capable = crypto_capable;
 	table->nr_entries++;
 }
 
 void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 {
-	__e820__range_add(e820_table, start, size, type);
+	__e820__range_add(e820_table, start, size, type, E820_NOT_CRYPTO_CAPABLE);
 }
 
 static void __init e820_print_type(enum e820_type type)
@@ -211,6 +214,8 @@ void __init e820__print_table(char *who)
 			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
 
 		e820_print_type(e820_table->entries[i].type);
+		if (e820_table->entries[i].crypto_capable == E820_CRYPTO_CAPABLE)
+			pr_cont("; crypto-capable");
 		pr_cont("\n");
 	}
 }
@@ -327,6 +332,7 @@ int __init e820__update_table(struct e820_table *table)
 	unsigned long long last_addr;
 	u32 new_nr_entries, overlap_entries;
 	u32 i, chg_idx, chg_nr;
+	enum e820_crypto_capabilities current_crypto, last_crypto;
 
 	/* If there's only one memory region, don't bother: */
 	if (table->nr_entries < 2)
@@ -367,6 +373,7 @@ int __init e820__update_table(struct e820_table *table)
 	new_nr_entries = 0;	 /* Index for creating new map entries */
 	last_type = 0;		 /* Start with undefined memory type */
 	last_addr = 0;		 /* Start with 0 as last starting address */
+	last_crypto = E820_NOT_CRYPTO_CAPABLE;
 
 	/* Loop through change-points, determining effect on the new map: */
 	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
@@ -388,13 +395,19 @@ int __init e820__update_table(struct e820_table *table)
 		 * 1=usable, 2,3,4,4+=unusable)
 		 */
 		current_type = 0;
+		current_crypto = E820_CRYPTO_CAPABLE;
 		for (i = 0; i < overlap_entries; i++) {
+			if (overlap_list[i]->crypto_capable < current_crypto)
+				current_crypto = overlap_list[i]->crypto_capable;
+
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
@@ -406,9 +419,12 @@ int __init e820__update_table(struct e820_table *table)
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
 
@@ -497,8 +513,80 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 
 		/* New range is completely covered? */
 		if (entry->addr < start && entry_end > end) {
-			__e820__range_add(table, start, size, new_type);
-			__e820__range_add(table, end, entry_end - end, entry->type);
+			__e820__range_add(table, start, size, new_type, entry->crypto_capable);
+			__e820__range_add(table, end, entry_end - end, entry->type, entry->crypto_capable);
+			entry->size = start - entry->addr;
+			real_updated_size += size;
+			continue;
+		}
+
+		/* Partially covered: */
+		final_start = max(start, entry->addr);
+		final_end = min(end, entry_end);
+		if (final_start >= final_end)
+			continue;
+
+		__e820__range_add(table, final_start, final_end - final_start,
+				  new_type, entry->crypto_capable);
+
+		real_updated_size += final_end - final_start;
+
+		/*
+		 * Left range could be head or tail, so need to update
+		 * its size first:
+		 */
+		entry->size -= final_end - final_start;
+		if (entry->addr < final_start)
+			continue;
+
+		entry->addr = final_end;
+	}
+	return real_updated_size;
+}
+
+/*
+ * Update crypto capabilities in a range
+ */
+static u64 __init __e820__range_update_crypto(struct e820_table *table,
+					      u64 start, u64 size,
+					      enum e820_crypto_capabilities crypto_capable)
+{
+	u64 end;
+	unsigned int i;
+	u64 real_updated_size = 0;
+
+	if (size > (ULLONG_MAX - start))
+		size = ULLONG_MAX - start;
+
+	end = start + size;
+	printk(KERN_DEBUG "e820: update crypto capabilities [mem %#018Lx-%#018Lx] ", start, end - 1);
+	pr_cont(" ==> ");
+	if (crypto_capable == E820_CRYPTO_CAPABLE)
+		pr_cont("crypto capable");
+	else
+		pr_cont("not crypto capable");
+	pr_cont("\n");
+
+	for (i = 0; i < table->nr_entries; i++) {
+		struct e820_entry *entry = &table->entries[i];
+		u64 final_start, final_end;
+		u64 entry_end;
+		enum e820_type type = entry->type;
+
+		entry_end = entry->addr + entry->size;
+
+		/* Completely covered by new range? */
+		if (entry->addr >= start && entry_end <= end) {
+			entry->crypto_capable = crypto_capable;
+			real_updated_size += entry->size;
+			continue;
+		}
+
+		/* New range is completely covered? */
+		if (entry->addr < start && entry_end > end) {
+			__e820__range_add(table, start, size, type, crypto_capable);
+			__e820__range_add(table, end, entry_end - end,
+					  type, entry->crypto_capable);
 			entry->size = start - entry->addr;
 			real_updated_size += size;
 			continue;
@@ -510,7 +598,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 		if (final_start >= final_end)
 			continue;
 
-		__e820__range_add(table, final_start, final_end - final_start, new_type);
+		__e820__range_add(table, final_start, final_end - final_start,
+				  type, crypto_capable);
 
 		real_updated_size += final_end - final_start;
 
@@ -527,6 +616,11 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 	return real_updated_size;
 }
 
+u64 __init e820__range_mark_as_crypto_capable(u64 start, u64 size)
+{
+	return __e820__range_update_crypto(e820_table, start, size, E820_CRYPTO_CAPABLE);
+}
+
 u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
 {
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
@@ -572,7 +666,9 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 
 		/* Is the new range completely covered? */
 		if (entry->addr < start && entry_end > end) {
-			e820__range_add(end, entry_end - end, entry->type);
+			__e820__range_add(e820_table, end, entry_end - end,
+					  entry->type, entry->crypto_capable);
+
 			entry->size = start - entry->addr;
 			real_removed_size += size;
 			continue;
@@ -1322,6 +1418,8 @@ void __init e820__memblock_setup(void)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
+		if (entry->crypto_capable == E820_CRYPTO_CAPABLE)
+			memblock_mark_crypto_capable(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.30.2

