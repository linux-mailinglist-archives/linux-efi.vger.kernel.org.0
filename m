Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2964A88D2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352227AbiBCQoO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 11:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352354AbiBCQoI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 11:44:08 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BBC06173B
        for <linux-efi@vger.kernel.org>; Thu,  3 Feb 2022 08:44:08 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p26so6159772uaa.11
        for <linux-efi@vger.kernel.org>; Thu, 03 Feb 2022 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi3rT5zncMeb0k62MKj5Wn1cLd6ugCHvnXJ1Eq5KCa0=;
        b=NvdHm8ZyWfi0qPRPM+5eaY3VcYdKTT5T5PTKPAIf5IKMvikxV+woDLhIxH25uoCdQw
         vHdVPqcx2Uu6lOdtf69jiorByv/Yvs+1n61gBbML04ly+vlppbwM04Q1IviA7SvPdgM0
         ZBHQTLbQDi8OoNzNC3bp0w+LKaZICP5hjZFgM7zBPDJXVshnejKKVoSV+MV9bZ0y30uG
         S/fkfQqlnAbcmdf/neL6WdvadA6sSua07/0pJqxn+CmxEMHxNwUt/VZKiRAGeaF4Bt0U
         WZdx6403WNT+MsccRohZzeT9QgsL8y9KHpGOTq/infNJ27I5cwtTt0Gl61HrfXKptJum
         F1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi3rT5zncMeb0k62MKj5Wn1cLd6ugCHvnXJ1Eq5KCa0=;
        b=WG9L2ISJm/JFnLWH3ReROhcbAHb3PUJW8yS2l7rYOAxngr1ggzpPWIIdICCltxTFrR
         5OD+IW+iil1xpFbucoN0EwG14Br05uDgyw90JNL/N1qcdBQ7fj78YGYNTTNwwGeTdWpv
         hzbpIZcAWJP02XoAW1w1jd6edTx26U1Y5mcw70L2l2n4IEofm3doMc1Rc8LYANvVdibU
         PYMmN1gtuM7VHEPlg3gljuCepmqairmOpxtQsNREY1MJ5Y7l2kI1LplKqKtUkbHPocLP
         Gtw8Idt0eWwQ5cVbrAl0tbIHC6k2pJ8qpdB8+Nn476G8uCyOzFL5aELBIWtHoBrCWmgd
         b5og==
X-Gm-Message-State: AOAM533+HMfx8kJiNV93lP5xd0K4HT+3dmaNRR7pb3YAMKU6eaRrHaPn
        vGToVjATPSsalBC6aJ8h4muaEw==
X-Google-Smtp-Source: ABdhPJzTU4dUSsxkR8M13OcbGpk/9wSKp/Q3vNcqDpl7kwLqhu0cZWStdgwP6MKmi2+t0WOgK4+gOA==
X-Received: by 2002:a05:6102:32c3:: with SMTP id o3mr13405580vss.4.1643906647473;
        Thu, 03 Feb 2022 08:44:07 -0800 (PST)
Received: from localhost (host8.190-224-49.telecom.net.ar. [190.224.49.8])
        by smtp.gmail.com with ESMTPSA id p2sm7048949uao.1.2022.02.03.08.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:44:07 -0800 (PST)
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
Subject: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
Date:   Thu,  3 Feb 2022 13:43:25 -0300
Message-Id: <20220203164328.203629-4-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

__e820__range_update and e820__range_remove had a very similar
implementation with a few lines different from each other, the lines
that actually perform the modification over the e820_table. The
similiraties were found in the checks for the different cases on how
each entry intersects with the given range (if it does at all). These
checks were very presice and error prone so it was not a good idea to
have them in both places.

I propose a refactor of those functions, given that I need to create a
similar one for this patchset.

Add a function to modify a E820 table in a given range. This
modification is done backed up by two helper structs:
e820_entry_updater and e820_*_data.

The first one, e820_entry_updater, carries 3 callbacks which function
as the actions to take on the table.

The other one, e820_*_data carries information needed by the
callbacks, for example in the case of range_update it will carry the
type that we are targeting.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 383 ++++++++++++++++++++++++++++++-----------
 1 file changed, 283 insertions(+), 100 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..89b78c6b345b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -459,144 +459,327 @@ static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
 	return __append_e820_table(entries, nr_entries);
 }
 
+/**
+ * e820_entry_updater - Helper type for __e820__handle_range_update().
+ * @should_update: Return true if @entry needs to be updated, false
+ * otherwise.
+ * @update: Apply desired actions to an @entry that is inside the
+ * range and satisfies @should_update.
+ * @new: Create new entry in the table with information gathered from
+ * @original and @data.
+ *
+ * Each function corresponds to an action that
+ * __e820__handle_range_update() does. Callbacks need to cast @data back
+ * to the corresponding type.
+ */
+struct e820_entry_updater {
+	bool (*should_update)(const struct e820_entry *entry, const void *data);
+	void (*update)(struct e820_entry *entry, const void *data);
+	void (*new)(struct e820_table *table, u64 new_start, u64 new_size,
+		    const struct e820_entry *original, const void *data);
+};
+
+/**
+ * e820_remove_data - Helper type for e820__range_remove().
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
+
+/**
+ * e820_type_updater_data - Helper type for __e820__range_update().
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
+
+/**
+ * __e820__handle_intersected_range_update() - Helper function for
+ * __e820__handle_range_update().
+ * @table: Target e820_table.
+ * @start: Start of the range.
+ * @size: Size of the range.
+ * @entry: Current entry that __e820__handle_range_update() was
+ * looking into.
+ * @updater: updater parameter of __e820__handle_range_update().
+ * @data: data parameter of __e820__handle_range_update().
+ *
+ * Helper for __e820__handle_range_update to handle the case where
+ * neither the entry completely covers the range nor the range
+ * completely covers the entry.
+ *
+ * Return: The updated size.
+ */
 static u64 __init
-__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
+__e820__handle_intersected_range_update(struct e820_table *table,
+					u64 start,
+					u64 size,
+					struct e820_entry *entry,
+					const struct e820_entry_updater *updater,
+					const void *data)
 {
 	u64 end;
-	unsigned int i;
-	u64 real_updated_size = 0;
-
-	BUG_ON(old_type == new_type);
+	u64 entry_end = entry->addr + entry->size;
+	u64 inner_start;
+	u64 inner_end;
+	u64 updated_size = 0;
 
 	if (size > (ULLONG_MAX - start))
 		size = ULLONG_MAX - start;
 
 	end = start + size;
-	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
-	e820_print_type(old_type);
-	pr_cont(" ==> ");
-	e820_print_type(new_type);
-	pr_cont("\n");
-
-	for (i = 0; i < table->nr_entries; i++) {
-		struct e820_entry *entry = &table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
+	inner_start = max(start, entry->addr);
+	inner_end = min(end, entry_end);
+
+	/* Range and entry do intersect and... */
+	if (inner_start < inner_end) {
+		/* Entry is on the left */
+		if (entry->addr < inner_start) {
+			/* Resize current entry */
+			entry->size = inner_start - entry->addr;
+		/* Entry is on the right */
+		} else {
+			/* Resize and move current section */
+			entry->addr = inner_end;
+			entry->size = entry_end - inner_end;
+		}
+		/* Create new entry with intersected region */
+		updater->new(table, inner_start, inner_end - inner_start, entry, data);
 
-		if (entry->type != old_type)
-			continue;
+		updated_size += inner_end - inner_start;
+	} /* Else: [start, end) doesn't cover entry */
 
-		entry_end = entry->addr + entry->size;
+	return updated_size;
+}
 
-		/* Completely covered by new range? */
-		if (entry->addr >= start && entry_end <= end) {
-			entry->type = new_type;
-			real_updated_size += entry->size;
-			continue;
-		}
+/** __e820__handle_range_update(): Helper function to update a address
+ * range in a e820_table
+ * @table: e820_table that we want to modify.
+ * @start: Start of the range.
+ * @size: Size of the range.
+ * @updater: Callbacks to modify the table.
+ * @data: Information to modify the table.
+ *
+ * Update the table @table in [@start, @start + @size) doing the
+ * actions given in @updater.
+ *
+ * Return: The updated size.
+ */
+static u64 __init
+__e820__handle_range_update(struct e820_table *table,
+			    u64 start,
+			    u64 size,
+			    const struct e820_entry_updater *updater,
+			    const void *data)
+{
+	u64 updated_size = 0;
+	u64 end;
+	unsigned int i;
 
-		/* New range is completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			__e820__range_add(table, start, size, new_type);
-			__e820__range_add(table, end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_updated_size += size;
-			continue;
-		}
+	if (size > (ULLONG_MAX - start))
+		size = ULLONG_MAX - start;
 
-		/* Partially covered: */
-		final_start = max(start, entry->addr);
-		final_end = min(end, entry_end);
-		if (final_start >= final_end)
-			continue;
+	end = start + size;
 
-		__e820__range_add(table, final_start, final_end - final_start, new_type);
+	for (i = 0; i < table->nr_entries; i++) {
+		struct e820_entry *entry = &table->entries[i];
+		u64 entry_end = entry->addr + entry->size;
+
+		if (updater->should_update(data, entry)) {
+			/* Range completely covers entry */
+			if (entry->addr >= start && entry_end <= end) {
+				updater->update(entry, data);
+				updated_size += entry->size;
+			/* Entry completely covers range */
+			} else if (start > entry->addr && end < entry_end) {
+				/* Resize current entry */
+				entry->size = start - entry->addr;
+
+				/* Create new entry with intersection region */
+				updater->new(table, start, size, entry, data);
+
+				/*
+				 * Create a new entry for the leftover
+				 * of the current entry
+				 */
+				__e820__range_add(table, end, entry_end - end,
+						  entry->type);
+
+				updated_size += size;
+			} else {
+				updated_size =
+					__e820__handle_intersected_range_update(table, start, size,
+										entry, updater, data);
+			}
+		}
+	}
 
-		real_updated_size += final_end - final_start;
+	return updated_size;
+}
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * its size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
+static bool __init type_updater__should_update(const struct e820_entry *entry,
+					       const void *data)
+{
+	struct e820_type_updater_data *type_updater_data =
+		(struct e820_type_updater_data *)data;
 
-		entry->addr = final_end;
-	}
-	return real_updated_size;
+	return entry->type == type_updater_data->old_type;
 }
 
-u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
+static void __init type_updater__update(struct e820_entry *entry,
+					const void *data)
 {
-	return __e820__range_update(e820_table, start, size, old_type, new_type);
+	struct e820_type_updater_data *type_updater_data =
+		(struct e820_type_updater_data *)data;
+
+	entry->type = type_updater_data->new_type;
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+static void __init type_updater__new(struct e820_table *table, u64 new_start,
+				     u64 new_size,
+				     const struct e820_entry *original,
+				     const void *data)
 {
-	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
+	struct e820_type_updater_data *type_updater_data =
+		(struct e820_type_updater_data *)data;
+
+	__e820__range_add(table, new_start, new_size,
+			  type_updater_data->new_type);
 }
 
-/* Remove a range of memory from the E820 table: */
-u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
+static u64 __init __e820__range_update(struct e820_table *table, u64 start,
+				       u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
 {
-	int i;
-	u64 end;
-	u64 real_removed_size = 0;
+	struct e820_entry_updater updater = {
+		.should_update = type_updater__should_update,
+		.update = type_updater__update,
+		.new = type_updater__new
+	};
 
-	if (size > (ULLONG_MAX - start))
-		size = ULLONG_MAX - start;
+	struct e820_type_updater_data data = {
+		.old_type = old_type,
+		.new_type = new_type
+	};
 
-	end = start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
+	BUG_ON(old_type == new_type);
+
+	printk(KERN_DEBUG "e820: update [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	e820_print_type(old_type);
+	pr_cont(" ==> ");
+	e820_print_type(new_type);
 	pr_cont("\n");
 
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry = &e820_table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
+	return __e820__handle_range_update(table, start, size, &updater, &data);
+}
 
-		if (check_type && entry->type != old_type)
-			continue;
+static bool __init remover__should_update(const struct e820_entry *entry,
+					  const void *data)
+{
+	struct e820_remover_data *remover_data =
+		(struct e820_remover_data *)data;
 
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
+
+	struct e820_remover_data data = {
+		.check_type = check_type,
+		.old_type = old_type
+	};
+
+	printk(KERN_DEBUG "e820: remove [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	if (check_type)
+		e820_print_type(old_type);
+	pr_cont("\n");
 
-		real_removed_size += final_end - final_start;
+	return __e820__handle_range_update(e820_table, start, size, &updater,
+					    &data);
+}
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * the size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
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
+{
+	return __e820__range_update(e820_table, start, size, old_type, new_type);
+}
 
-		entry->addr = final_end;
-	}
-	return real_removed_size;
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
+{
+	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
 void __init e820__update_table_print(void)
-- 
2.30.2

