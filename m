Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6459350E6EA
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiDYRTz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbiDYRTp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:19:45 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6E729CBB
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:24 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso11206038otf.12
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5j2s/6auQucRxLAf9Ddhgi2axiFoZCC4vb8eW6IJg4=;
        b=UzhU/r/fsPHYwIlw4msXifyEI7nxZ+jG1YJiVhaXK/tyfW8cpYaJCZ9n22kKw1OTaG
         TAqWQmNdaAAvWUWJy7tuAEkFKC1k1xx+QiP9XFDwUVwNG+gqTR9JYyhie98DzQVDUFRC
         pN+fqO4/xUBw0XwidyE4pQ4iCaQ6mnO5WIzMxQT44KdRDaHXx8SUXSadxxN82C8OVMib
         5s8lfCgk7cmVW/lOETzpLo+DdTXffubrQtnHKgYDM8QJpvhrg6T2d+rmPRY7tTq67C0a
         +nvNNcEmcxTrUWx7W38sayrPrRtfpyzPgOtD0A0hiKm057+YPcE21JGQ55likqqZyBOy
         DtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5j2s/6auQucRxLAf9Ddhgi2axiFoZCC4vb8eW6IJg4=;
        b=kNGQcECMLiycj5m9zJZhTJ4Jkm98DmcxjbcRN+hk9Lq+vdT9ch+XST765Q0jkxRhCN
         WM5o1ZTxh5S3Pw8CdHL5unrs82WSMQPGQX/WqfGeUz2DaGhiMS1IGe0+OtjH3Ec4iDX+
         oyZeUos7yhd75OUHIFiERD1xicBlV31JYZr8W6IKk12V7A7fP6FqkbMg9UmEgKAB3iiI
         sAJO+DSXcCbVdAjHYRjXEJc9S68do/ojZB7RPxPbx/oGeBgiaEo6dnR69talEU58CRcB
         tWK2EVCVbsqEoTu/jMkCVJsgG9mwV99Ahk6cEicCP05PNZqs5k4TWzo0sVxXcpBqcHPK
         nWNg==
X-Gm-Message-State: AOAM533Uu+TJopy91Ym19Z8nOWMX/A3Hk7/vJRdMMdbdxxZlAr/g/yYl
        ZPeuafz0IdQt4AJMU3QgSnitBQ==
X-Google-Smtp-Source: ABdhPJyQ41RMyEthWEjm+6ciDRpHPtmT8aytvsxpm9atcBLjPis+prWS1Cox48s8CUOayxhJspsWkg==
X-Received: by 2002:a9d:7dcf:0:b0:605:4e52:fc20 with SMTP id k15-20020a9d7dcf000000b006054e52fc20mr6661239otn.332.1650906983399;
        Mon, 25 Apr 2022 10:16:23 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id e18-20020a544f12000000b002fa0db80b13sm3952553oiy.48.2022.04.25.10.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:16:23 -0700 (PDT)
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
Subject: [PATCH v7 6/8] x86/e820: Tag e820_entry with crypto capabilities
Date:   Mon, 25 Apr 2022 14:15:24 -0300
Message-Id: <20220425171526.44925-7-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new enum for crypto capabilities. I choosed an enum instead of a
boolean for more visibility in the code and because maybe in the
future we would like to track from where the cryptographic
capabilities comes (in this case, the EFI memmap).

Add a new member in e820_entry to hold this new enum.

Add a new function e820__range_set_crypto_capable to mark all the
entries in a range of addresses as encryptable. This will be called
when initializing EFI.

Change e820__update_table to handle merging and overlap problems
taking into account crypto_capable.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/include/asm/e820/api.h   |   1 +
 arch/x86/include/asm/e820/types.h |  12 +++-
 arch/x86/kernel/e820.c            | 109 +++++++++++++++++++++++++++++-
 3 files changed, 116 insertions(+), 6 deletions(-)

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
index 9e32c9819e99..5837b7c1d197 100644
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
 
@@ -787,6 +803,91 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type,
 					    &data);
 }
 
+/**
+ * struct e820_crypto_updater_data - Helper type for
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
+static bool __init crypto_updater__should_update(const struct e820_entry *entry,
+						 const void *data)
+{
+	const struct e820_crypto_updater_data *crypto_updater_data =
+		(const struct e820_crypto_updater_data *)data;
+
+	return crypto_updater_data->crypto_capable != entry->crypto_capable;
+}
+
+static void __init crypto_updater__update(struct e820_entry *entry,
+					  const void *data)
+{
+	const struct e820_crypto_updater_data *crypto_updater_data =
+		(const struct e820_crypto_updater_data *)data;
+
+	entry->crypto_capable = crypto_updater_data->crypto_capable;
+}
+
+static void __init crypto_updater__new(struct e820_table *table, u64 new_start,
+				       u64 new_size,
+				       const struct e820_entry *original,
+				       const void *data)
+{
+	const struct e820_crypto_updater_data *crypto_updater_data =
+		(const struct e820_crypto_updater_data *)data;
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
@@ -1529,6 +1630,8 @@ void __init e820__memblock_setup(void)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
+		if (entry->crypto_capable == E820_CRYPTO_CAPABLE)
+			memblock_mark_crypto_capable(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.30.2

