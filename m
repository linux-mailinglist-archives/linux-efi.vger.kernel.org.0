Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D150E6F6
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiDYRTp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiDYRTg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:19:36 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0897286DE
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:10 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so4058187fac.12
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzwUVSRCTs7yF7NC9RaputFYAMnZCA1mZDnEg/SpEoc=;
        b=DRhjerDdBI/0oOQFXmN1bF3llrdra9rWGkn4nBmO2KvVeB0kt07/vY4ECI/VgIUTxQ
         sEEELkTAlRFpqnnphHIURXWHe5ayIwoUn290gBIKXtC72XqXx4eVZ2exM/MeQo3aMwLq
         5TQBGmO5ZWIGihyIk5bNmzHyYQsuur11t33L3jm41ClHcfiTxNdWeR6CcS04NWp2+oNC
         Vy6DkPYgyGo/rI4yQKqeUbZ7xe6KtAVzY/lsaFLXMegNf49MDK4RcnH29l49Z44BeMjE
         sVxFRdiXIYpE6tHva/FHqq/TWZzN6osF+tqnTL42iOJvPOmzWE80X8BAjt8K8iEd4w4N
         HXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzwUVSRCTs7yF7NC9RaputFYAMnZCA1mZDnEg/SpEoc=;
        b=GTkZN9/fmA9EPYJMP2XNf50B3cfdXZL9dqWniLNm4KVdCU2qvh89ldXikHULECfmvx
         fJyDYqZLauhhelzUEB5Mwpv2UxfvULpieklxM4T4oVw8EsQhwOzJdzSEGeR7UbHbEjnR
         U6DvvWSZm64Fsh66WVuuXvhLSwpJ1Yo31jR/8fVMEmT9v1zMiJsRnOTvaYQa63vY7el7
         Jska29dCbQzYhDSOHwWAcLPVTsjRkV+d0GGs5/k0T/wsHvyq7xP0fuxUrs9i699Kidep
         8hQfSNeBu7KAc5rULi7m/36W4e/TDFsIYtW+LMybZsGlEz3U7li0W8hj7YHEmPn8q1UD
         W4iA==
X-Gm-Message-State: AOAM531sktis1adC3vN3rTthakJmf8xLLV0d7WwrpkJifnE9qAX76u1p
        u8yz00a9n1MXDcs732KjjACtag==
X-Google-Smtp-Source: ABdhPJwbA+Mxla+CdrXZkNdzNcBLQ0nX8DluKtoxXNDB7ZKRkcFPHsqw5ahJLlGkdY1qBkKGVXMlzA==
X-Received: by 2002:a05:6870:462a:b0:dd:f4f7:24be with SMTP id z42-20020a056870462a00b000ddf4f724bemr7488816oao.39.1650906969504;
        Mon, 25 Apr 2022 10:16:09 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id z13-20020a4a9c8d000000b0035e6c882517sm1471792ooj.16.2022.04.25.10.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:16:09 -0700 (PDT)
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
Subject: [PATCH v7 4/8] x86/e820: Refactor __e820__range_update
Date:   Mon, 25 Apr 2022 14:15:22 -0300
Message-Id: <20220425171526.44925-5-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Refactor __e820__range_update with the introduction of
e820_type_updater_data, indented to be used as the void pointer in the
e820_entry_updater callbacks, and the implementation of the callbacks
to perform the update of the type in a range of a e820_table.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 146 +++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 923585ab8377..763b8b20a1fd 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -607,80 +607,112 @@ __e820__handle_range_update(struct e820_table *table,
 	return updated_size;
 }
 
-static u64 __init
-__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
-{
-	u64 end;
-	unsigned int i;
-	u64 real_updated_size = 0;
-
-	BUG_ON(old_type == new_type);
-
-	if (size > (ULLONG_MAX - start))
-		size = ULLONG_MAX - start;
+/**
+ * struct e820_type_updater_data - Helper type for
+ * __e820__range_update().
+ * @old_type: old_type parameter of __e820__range_update().
+ * @new_type: new_type parameter of __e820__range_update().
+ *
+ * This is intended to be used as the @data argument for the
+ * e820_entry_updater callbacks.
+ */
+struct e820_type_updater_data {
+	enum e820_type old_type;
+	enum e820_type new_type;
+};
 
-	end = start + size;
-	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
-	e820_print_type(old_type);
-	pr_cont(" ==> ");
-	e820_print_type(new_type);
-	pr_cont("\n");
+static bool __init type_updater__should_update(const struct e820_entry *entry,
+					       const void *data)
+{
+	const struct e820_type_updater_data *type_updater_data =
+		(const struct e820_type_updater_data *)data;
 
-	for (i = 0; i < table->nr_entries; i++) {
-		struct e820_entry *entry = &table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
+	return entry->type == type_updater_data->old_type;
+}
 
-		if (entry->type != old_type)
-			continue;
+static void __init type_updater__update(struct e820_entry *entry,
+					const void *data)
+{
+	const struct e820_type_updater_data *type_updater_data =
+		(const struct e820_type_updater_data *)data;
 
-		entry_end = entry->addr + entry->size;
+	entry->type = type_updater_data->new_type;
+}
 
-		/* Completely covered by new range? */
-		if (entry->addr >= start && entry_end <= end) {
-			entry->type = new_type;
-			real_updated_size += entry->size;
-			continue;
-		}
+static void __init type_updater__new(struct e820_table *table, u64 new_start,
+				     u64 new_size,
+				     const struct e820_entry *original,
+				     const void *data)
+{
+	const struct e820_type_updater_data *type_updater_data =
+		(const struct e820_type_updater_data *)data;
 
-		/* New range is completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			__e820__range_add(table, start, size, new_type);
-			__e820__range_add(table, end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_updated_size += size;
-			continue;
-		}
+	__e820__range_add(table, new_start, new_size,
+			  type_updater_data->new_type, original->crypto_capable);
+}
 
-		/* Partially covered: */
-		final_start = max(start, entry->addr);
-		final_end = min(end, entry_end);
-		if (final_start >= final_end)
-			continue;
+static u64 __init __e820__range_update(struct e820_table *table, u64 start,
+				       u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
+{
+	struct e820_entry_updater updater = {
+		.should_update = type_updater__should_update,
+		.update = type_updater__update,
+		.new = type_updater__new
+	};
 
-		__e820__range_add(table, final_start, final_end - final_start, new_type);
+	struct e820_type_updater_data data = {
+		.old_type = old_type,
+		.new_type = new_type
+	};
 
-		real_updated_size += final_end - final_start;
+	BUG_ON(old_type == new_type);
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * its size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
+	printk(KERN_DEBUG "e820: update [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	e820_print_type(old_type);
+	pr_cont(" ==> ");
+	e820_print_type(new_type);
+	pr_cont("\n");
 
-		entry->addr = final_end;
-	}
-	return real_updated_size;
+	return __e820__handle_range_update(table, start, size, &updater, &data);
 }
 
-u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
+/**
+ * e820__range_update() - Update the type of a given address range in
+ * e820_table.
+ * @start: Start of the range.
+ * @size: Size of the range.
+ * @old_type: Type that we want to change.
+ * @new_type: New type to replace @old_type.
+ *
+ * Update type of addresses in [@start, @start + @size) from @old_type
+ * to @new_type in e820_table.
+ *
+ * Return: The size updated.
+ */
+u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type,
+			      enum e820_type new_type)
 {
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+/**
+ * e820__range_update_kexec() - Update the type of a given address
+ * range in e820_table_kexec.
+ * @start: Start of the range.
+ * @size: Size of the range.
+ * @old_type: Type that we want to change.
+ * @new_type: New type to replace @old_type.
+ *
+ * Update type of addresses in [@start, @start + @size) from @old_type
+ * to @new_type in e820_table_kexec.
+ *
+ * Return: The size updated.
+ */
+static u64 __init e820__range_update_kexec(u64 start, u64 size,
+					   enum e820_type old_type,
+					   enum e820_type new_type)
 {
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
-- 
2.30.2

