Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2E4A88D9
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352364AbiBCQoP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 11:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352354AbiBCQoO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 11:44:14 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE5C06173B
        for <linux-efi@vger.kernel.org>; Thu,  3 Feb 2022 08:44:14 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id w18so2873214uar.8
        for <linux-efi@vger.kernel.org>; Thu, 03 Feb 2022 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjdK5U5Da9cqL6OL8NEqAW4tX/0WDFOVYE3N0Y7mjjg=;
        b=RnHSE2ec2sy3mA4qRJGiuwYWc3KmdYerQlEAtmAWqgljRdYp/FHmkV11qBJPmqY4hI
         9PJJnVDjSOhF+R0a/Be7S6KXoosBDsqd0/nw2NkuWgQ6aA0W7R38t390QoRmY4vua4kr
         snytvlWjEUY9Fkyf5CjPalbYvWzn/RbuGow8QXySbzQ0cJD0P5xAS/Fepm7M+sX8rulM
         3vDcgzZd/fiJW/CQT8T9xOiDYDlyDqAL0XKfr+adDMFfSMHCNg5taonwfHtBBKIPm8rx
         t78P10CyuzuchirzZch6Vf17N4vuzDmRNAf6D5vEB2RYot5cPpubKjh4jBIHTO239Zct
         rzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjdK5U5Da9cqL6OL8NEqAW4tX/0WDFOVYE3N0Y7mjjg=;
        b=m6sQZIqsGQHNZ09qPx9IChCfX5WNvTmbqTEKdIvw/bK1dARRtqWKjD8SfRgrtaRq2+
         zXrvYAmttI5Ntt8VhdJQQhYafYsYeapBkgwS5fJLhrDauxNtNfrSFOidr1q3nydVeYsw
         +2wTCdVNaWOxBR1+89bqFsO5kv6B7VVuQI1U2h8gMpnAit+GReMn9m+Q6RolIfi7Uto9
         kCXGhAl4F3Al65VrAQGe9Jme8mgAViMKqp7ldnGjCeTBXgoCoDKJYd14NouJK7bWwkWH
         cHuu5Q9qkFjq40M05omnQPSNg9/zW3AJDGE1OUxmKWjbHH/6o5E9KBwZ/iIgihGa3eAF
         n0gw==
X-Gm-Message-State: AOAM531z4diCJ0mGWwYUqh+O8uZmtAnesNN6VKOvxpSAN8w00GnReSKr
        sbqCnFrGJMsR30Mzqj4V+lsVtg==
X-Google-Smtp-Source: ABdhPJxfw66WC7p5te/X+pajwCMpJVrLZDihaKaoVnPruFsPWW9RLMsUn/DfHzIlf64y+VH5gAesjA==
X-Received: by 2002:a05:6102:f08:: with SMTP id v8mr14207630vss.3.1643906653209;
        Thu, 03 Feb 2022 08:44:13 -0800 (PST)
Received: from localhost (host8.190-224-49.telecom.net.ar. [190.224.49.8])
        by smtp.gmail.com with ESMTPSA id u70sm3653044vsu.10.2022.02.03.08.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:44:12 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v6 4/6] x86/e820: Tag e820_entry with crypto capabilities
Date:   Thu,  3 Feb 2022 13:43:26 -0300
Message-Id: <20220203164328.203629-5-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new enum for crypto capabilities.

Add a new member in e820_entry to hold whether an entry is able to do
hardware memory encryption or not.

Add a new function e820__range_set_crypto_capable to mark all the
entries in a range of addresses as encryptable. This will be called
when initializing EFI.

Change e820__update_table to handle merging and overlap problems
taking into account crypto_capable.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/include/asm/e820/api.h   |   1 +
 arch/x86/include/asm/e820/types.h |  12 +++-
 arch/x86/kernel/e820.c            | 114 ++++++++++++++++++++++++++++--
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..4b3b01fafdd1 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
+extern u64  e820__range_set_crypto_capable(u64 start, u64 size);
 
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
index 89b78c6b345b..098882d02120 100644
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
 
@@ -505,6 +521,19 @@ struct e820_type_updater_data {
 	enum e820_type new_type;
 };
 
+/**
+ * e820_crypto_updater_data - Helper type for
+ * __e820__range_update_crypto().
+ * @crypto_capable: crypto_capable parameter of
+ * __e820__range_update_crypto().
+ *
+ * This is intended to be used as the @data argument for the
+ * e820_entry_updater callbacks.
+ */
+struct e820_crypto_updater_data {
+	enum e820_crypto_capabilities crypto_capable;
+};
+
 /**
  * __e820__handle_intersected_range_update() - Helper function for
  * __e820__handle_range_update().
@@ -615,7 +644,8 @@ __e820__handle_range_update(struct e820_table *table,
 				 * of the current entry
 				 */
 				__e820__range_add(table, end, entry_end - end,
-						  entry->type);
+						  entry->type,
+						  entry->crypto_capable);
 
 				updated_size += size;
 			} else {
@@ -656,7 +686,7 @@ static void __init type_updater__new(struct e820_table *table, u64 new_start,
 		(struct e820_type_updater_data *)data;
 
 	__e820__range_add(table, new_start, new_size,
-			  type_updater_data->new_type);
+			  type_updater_data->new_type, original->crypto_capable);
 }
 
 static u64 __init __e820__range_update(struct e820_table *table, u64 start,
@@ -686,6 +716,62 @@ static u64 __init __e820__range_update(struct e820_table *table, u64 start,
 	return __e820__handle_range_update(table, start, size, &updater, &data);
 }
 
+static bool __init crypto_updater__should_update(const struct e820_entry *entry,
+						 const void *data)
+{
+	struct e820_crypto_updater_data *crypto_updater_data =
+		(struct e820_crypto_updater_data *)data;
+
+	return crypto_updater_data->crypto_capable != entry->crypto_capable;
+}
+
+static void __init crypto_updater__update(struct e820_entry *entry,
+					  const void *data)
+{
+	struct e820_crypto_updater_data *crypto_updater_data =
+		(struct e820_crypto_updater_data *)data;
+
+	entry->crypto_capable = crypto_updater_data->crypto_capable;
+}
+
+static void __init crypto_updater__new(struct e820_table *table, u64 new_start,
+				       u64 new_size,
+				       const struct e820_entry *original,
+				       const void *data)
+{
+	struct e820_crypto_updater_data *crypto_updater_data =
+		(struct e820_crypto_updater_data *)data;
+
+	__e820__range_add(table, new_start, new_size, original->type,
+			  crypto_updater_data->crypto_capable);
+}
+
+static u64 __init
+__e820__range_update_crypto(struct e820_table *table, u64 start, u64 size,
+			    enum e820_crypto_capabilities crypto_capable)
+{
+	struct e820_entry_updater updater = {
+		.should_update = crypto_updater__should_update,
+		.update = crypto_updater__update,
+		.new = crypto_updater__new
+	};
+
+	struct e820_crypto_updater_data data = {
+		.crypto_capable = crypto_capable,
+	};
+
+	printk(KERN_DEBUG "e820: crypto update [mem %#018Lx-%#018Lx]", start,
+	       start + size - 1);
+	pr_cont(" ==> ");
+	if (crypto_capable == E820_CRYPTO_CAPABLE)
+		pr_cont("crypto capable");
+	else
+		pr_cont("not crypto capable");
+	pr_cont("\n");
+
+	return __e820__handle_range_update(table, start, size, &updater, &data);
+}
+
 static bool __init remover__should_update(const struct e820_entry *entry,
 					  const void *data)
 {
@@ -782,6 +868,22 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size,
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
+/**
+ * e820__range_set_crypto_capable() - Set %E820_CRYPTO_CAPABLE to a
+ * given range of addresses in e820_table.
+ * @start: Start of the range.
+ * @size: Size of the range.
+ *
+ * Set %E820_CRYPTO_CAPABLE to [@start, @start + @size) in e820_table.
+ *
+ * Return: The size updated.
+ */
+u64 __init e820__range_set_crypto_capable(u64 start, u64 size)
+{
+	return __e820__range_update_crypto(e820_table, start, size,
+					   E820_CRYPTO_CAPABLE);
+}
+
 void __init e820__update_table_print(void)
 {
 	if (e820__update_table(e820_table))
@@ -1505,6 +1607,8 @@ void __init e820__memblock_setup(void)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
+		if (entry->crypto_capable == E820_CRYPTO_CAPABLE)
+			memblock_mark_crypto_capable(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.30.2

