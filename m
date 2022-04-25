Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE750E6E8
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiDYRTv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbiDYRTm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:19:42 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C92289A9
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e656032735so15500788fac.0
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ft+wZQIdPNos4T3lDuMvy0g55vrLthZNQPyCA6Ri2Oc=;
        b=aRdrpQIzsB5Rys7TKFmkToLr1c2+7gMgCFOy3LQCThR0i95Wdz60D85WV4oFBu6CP+
         NO1HiG+5q4S26R7wLVT3F3xuPjL0NFcMFbGs8ilMjJ+Rnv0GQrkwI3D/uqHL2+HU/NaN
         pOL8mA1pjelM8jseVenZ/cNtAoiSrf569bi8DQdPzZ7hCdC5MQfL2ZNL+bCrxWN7akup
         NE0muzOpw0mXDW12dhOGZHESYV77gW+gwQEDEVf0FOExUdFl7nneauWzSDfcATb6bzv8
         pbOUFGMAOnCG+imkMSUHMpmO7HHPZBqogf3HMvptmKVewa42f4DvUiHZ3Mz7SvPakHF7
         BmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ft+wZQIdPNos4T3lDuMvy0g55vrLthZNQPyCA6Ri2Oc=;
        b=sa+DykWqcsjFkzjJTjkuheD4k2MKwEmqwopdYkX8S2r6hFnoLlL2WwWCw6Vnqn1N3a
         oBRY6myZczcnojMr/DfM+kkVo7bdkdhfjsr5xNs2PMaJcRWJQUT54w/DvVyeJDprEEwy
         +qR4rVFa68tpSNbNorQsE2V2V8wyQkT2KWwypg9ivfMfo/4trGQTRo8zODu1cTdjzK2V
         NnWAaEs1UCRlLspbzc+ixnaIC0i8TtHa0pKcFeop6YyjRzPGgdEVihl5BHMS0hma38zO
         S98mssM7ugmpX9vKDXRAUDBRYA8sttfFZ8vC/al1+Q381RIJncbmQIngiSOriTAPHwTq
         CNCA==
X-Gm-Message-State: AOAM5334Nv6wPDJEg2lrdSkQ8FymCIUKjB61NfBO8BuOOdbfteo/Nfq4
        hOA4OTqLI0VjRdxXouGbuycCaw==
X-Google-Smtp-Source: ABdhPJxhe3SolTYD/SoMykhNbjVWS3EDWFMCXc59Vp6VJr5Cun6bm5rlf51Rm3y1ZigNDcBZHtq7jw==
X-Received: by 2002:a05:6870:63a7:b0:e9:363:51e1 with SMTP id t39-20020a05687063a700b000e9036351e1mr6295289oap.246.1650906976814;
        Mon, 25 Apr 2022 10:16:16 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm3651433oab.35.2022.04.25.10.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:16:16 -0700 (PDT)
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
Subject: [PATCH v7 5/8] x86/e820: Refactor e820__range_remove
Date:   Mon, 25 Apr 2022 14:15:23 -0300
Message-Id: <20220425171526.44925-6-martin.fernandez@eclypsium.com>
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

Refactor e820__range_remove with the introduction of
e820_remover_data, indented to be used as the void pointer in the
e820_entry_updater callbacks, and the implementation of the callbacks
remove a range in the e820_table.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 112 ++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 763b8b20a1fd..9e32c9819e99 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -717,66 +717,74 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size,
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
-/* Remove a range of memory from the E820 table: */
-u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
-{
-	int i;
-	u64 end;
-	u64 real_removed_size = 0;
-
-	if (size > (ULLONG_MAX - start))
-		size = ULLONG_MAX - start;
-
-	end = start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
-	pr_cont("\n");
-
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry = &e820_table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
+/**
+ * struct e820_remover_data - Helper type for e820__range_remove().
+ * @old_type: old_type parameter of e820__range_remove().
+ * @check_type: check_type parameter of e820__range_remove().
+ *
+ * This is intended to be used as the @data argument for the
+ * e820_entry_updater callbacks.
+ */
+struct e820_remover_data {
+	enum e820_type old_type;
+	bool check_type;
+};
 
-		if (check_type && entry->type != old_type)
-			continue;
+static bool __init remover__should_update(const struct e820_entry *entry,
+					  const void *data)
+{
+	const struct e820_remover_data *remover_data =
+		(const struct e820_remover_data *)data;
 
-		entry_end = entry->addr + entry->size;
+	return !remover_data->check_type ||
+	       entry->type == remover_data->old_type;
+}
 
-		/* Completely covered? */
-		if (entry->addr >= start && entry_end <= end) {
-			real_removed_size += entry->size;
-			memset(entry, 0, sizeof(*entry));
-			continue;
-		}
+static void __init remover__update(struct e820_entry *entry, const void *data)
+{
+	memset(entry, 0, sizeof(*entry));
+}
 
-		/* Is the new range completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			e820__range_add(end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_removed_size += size;
-			continue;
-		}
+static void __init remover__new(struct e820_table *table, u64 new_start,
+				u64 new_size, const struct e820_entry *original,
+				const void *data)
+{
+}
 
-		/* Partially covered: */
-		final_start = max(start, entry->addr);
-		final_end = min(end, entry_end);
-		if (final_start >= final_end)
-			continue;
+/**
+ * e820__range_remove() - Remove an address range from e820_table.
+ * @start: Start of the address range.
+ * @size: Size of the address range.
+ * @old_type: Type of the entries that we want to remove.
+ * @check_type: Bool to decide if ignore @old_type or not.
+ *
+ * Remove [@start, @start + @size) from e820_table. If @check_type is
+ * true remove only entries with type @old_type.
+ *
+ * Return: The size removed.
+ */
+u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type,
+			      bool check_type)
+{
+	struct e820_entry_updater updater = {
+		.should_update = remover__should_update,
+		.update = remover__update,
+		.new = remover__new
+	};
 
-		real_removed_size += final_end - final_start;
+	struct e820_remover_data data = {
+		.check_type = check_type,
+		.old_type = old_type
+	};
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * the size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
+	printk(KERN_DEBUG "e820: remove [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	if (check_type)
+		e820_print_type(old_type);
+	pr_cont("\n");
 
-		entry->addr = final_end;
-	}
-	return real_removed_size;
+	return __e820__handle_range_update(e820_table, start, size, &updater,
+					    &data);
 }
 
 void __init e820__update_table_print(void)
-- 
2.30.2

