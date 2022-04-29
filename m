Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB8515565
	for <lists+linux-efi@lfdr.de>; Fri, 29 Apr 2022 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380630AbiD2UVc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Apr 2022 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiD2UV3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Apr 2022 16:21:29 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF40C8A9F
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:18:07 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-deb9295679so9217403fac.6
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLuObBmPkIWHGGIa0YgrZ0Lq4zFfhIdvg//A8xn7ggo=;
        b=bDqZaABFMgbCLkZSOOaIqWXwNxKq7mseURB3Uho4ueCz1dK5Sg5oiQmKB6FATHblrP
         jxnZ4zLyyzM4un446F22ja4cDAw0P+SRSXKTENRKrNSkVExlDHbFvvsDAMKzQahVqNEe
         X+hCpEFt+iz78gB+HqjFukCBu2GzDKsy4ueixp7I0CdFYyCkriviEhAVL8OZIBD7ik2q
         0GKnnbWIfLfaHOTPuDSlf0Cixh6bNynHXSQwTNdfmXYveHNXxLJZb6uvzHRaKx5skZRH
         1KxzopzMkI8RB0enn0HThdgeAIc2RAcq2FZit5fIVYtbtANMzb4NCuRHfNtkZrYF3bON
         EUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLuObBmPkIWHGGIa0YgrZ0Lq4zFfhIdvg//A8xn7ggo=;
        b=rqQ1pYX1c02Yea8W4klFhXPqbpMtjN7WXsYSNLAmE5B1EresnksjFcFZ9pMclMJXAn
         Sk4jXv9l+EOeJxyysXIJ5W5dFTF+z+8C4g5K+RO6o62fmTdYYFP/mYsqZuPjwdojS1S4
         ODiLiZVpgdWcRqG1PRoyXZ0+kmY16smptlqzzyTMczOXMkQ8n/yps9uj9po3wtt0ubwt
         KYkyWGVVTUStoAFhVyE43m8lGe+kTzR7onBMQfdUTO/SXckFDnYDWmD/W0D20cV1PnEM
         ONZ9gdVMf7DRodSXBz3fYMHFfSPi/m5lTP4pNZpHzDzXvFeyJ7ls2f7pGWg6gWap/bOg
         0qOw==
X-Gm-Message-State: AOAM530a+Buj+0Xawx4LdDNOsvBTob9hDGguEFnKxfz1RtNcevr62lcP
        Wpfa7FQoZdFG6NqA6+bv3hmyUw==
X-Google-Smtp-Source: ABdhPJzrZ8Kfl4T49yQr7FGvWCo8iE92bI2DDqgrilNpiLxjJDpWs/nerrD+omBLCh+QcoMFJfgdCQ==
X-Received: by 2002:a05:6870:708a:b0:e9:9349:9410 with SMTP id v10-20020a056870708a00b000e993499410mr2067692oae.265.1651263487078;
        Fri, 29 Apr 2022 13:18:07 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id q2-20020a056808200200b00325cda1ff9dsm71731oiw.28.2022.04.29.13.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:18:06 -0700 (PDT)
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
Subject: [PATCH v8 4/8] x86/e820: Refactor __e820__range_update
Date:   Fri, 29 Apr 2022 17:17:13 -0300
Message-Id: <20220429201717.1946178-5-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
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
 arch/x86/kernel/e820.c | 119 +++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e0fa3ab755a5..36a22c0a2199 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -586,80 +586,85 @@ __e820__handle_range_update(struct e820_table *table,
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
+/*
+ * Type helper for the e820_entry_updater callbacks.
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
+	const struct e820_type_updater_data *type_updater_data = data;
 
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
+	const struct e820_type_updater_data *type_updater_data = data;
 
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
+	const struct e820_type_updater_data *type_updater_data = data;
 
-		/* New range is completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			__e820__range_add(table, start, size, new_type);
-			__e820__range_add(table, end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_updated_size += size;
-			continue;
-		}
+	__e820__range_add(table, new_start, new_size,
+			  type_updater_data->new_type);
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
+/*
+ * Update type of addresses in [@start, @start + @size) from @old_type
+ * to @new_type in e820_table.
+ */
+u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type,
+			      enum e820_type new_type)
 {
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+/*
+ * Update type of addresses in [@start, @start + @size) from @old_type
+ * to @new_type in e820_table_kexec.
+ */
+static u64 __init e820__range_update_kexec(u64 start, u64 size,
+					   enum e820_type old_type,
+					   enum e820_type new_type)
 {
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
-- 
2.30.2

