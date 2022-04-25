Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE150E6F4
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiDYRTl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiDYRTc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:19:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780627B16
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a10so17820820oif.9
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scNNecAxK89bCsIv0vpIcsFL1bTqr463ACa9Pmhvay4=;
        b=Xwe/HZQ7QWugCsF4WnCrUGpuXwV1gaK3ZKZdlbT70p+37ejUk3CLqzzzPcu5CNkCLf
         CGrax6l11PoWQUWAiqepna03GEHKQuPCaABKVFzgk1+QB6dKZPw49cMsm2dI7OipMjGf
         4p3gpErYOE85yNl37xI80+X0kBuIv8a27lPKf1GrFBbjhxbzGv6Ff97rQZQLsW4P5MBp
         4dhjSTORIXAlRYu7rKmo5mqF78SpA5YnhC42lifS4/WCQAGP8Z0cVIe2jdgK6Ds0IgOv
         9U7YRa3Dd0uYubs5wbYMhhiw+1OBoJ0kh1nuJi6TtmpkxTeJ4ecWP8jBdria2LZdCbkW
         fkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scNNecAxK89bCsIv0vpIcsFL1bTqr463ACa9Pmhvay4=;
        b=6pwIFOEJWAW9TodxAwItPrZ+bssdmDBuRXUWt6tRuPAQ0JgKTaDPXLpn0ox1XLHFm5
         gXxSGfWg0UmU6lLeYEOTpOSD7ijjf95WER3If5VYM9c2ycQ/SfG3+YO99evNpCvkI7Jm
         HVbNSFi8SklYSV3JTZTISUxgdzkdX22t5/mpzJdctZuQ/3mk+SX7MnETb8laql41Ot4R
         xAzstJVxs+VdZ85Bh2xaJPFkSfM0UKvFSkBPNWWGMc3p7R/z16FGASfFFklh74koH+5N
         ZaQCrUpJOvkhGvbmTFfqUbPzq1QFoTChI1tPFa+ZvkMQB7Btt4JcovSFhVSTykwAOsQU
         si8g==
X-Gm-Message-State: AOAM531Q8//a6CDtEMi0Czvz7Ku9RaHibG/LhVFlFGCyREPM63ImcWqF
        gL8EfsYcqasQNPhWcQSsfYr+tA==
X-Google-Smtp-Source: ABdhPJxdW0TUVi/qCKY+MEYfc75LBEinyGxemFyKERNQFWQ35/MgZzJ97hAPoKTCadYesjTyi6gU6Q==
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id n62-20020acabd41000000b002ecff42814fmr8838220oif.63.1650906961998;
        Mon, 25 Apr 2022 10:16:01 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id 1-20020a05687011c100b000de98359b43sm3502824oav.1.2022.04.25.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:16:01 -0700 (PDT)
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
Subject: [PATCH v7 3/8] x86/e820: Add infrastructure to refactor e820__range_{update,remove}
Date:   Mon, 25 Apr 2022 14:15:21 -0300
Message-Id: <20220425171526.44925-4-martin.fernandez@eclypsium.com>
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

__e820__range_update and e820__range_remove had a very similar flow in
its implementation with a few lines different from each other, the
lines that actually perform the modification over the e820_table. The
similiraties were found in the checks for the different cases on how
each entry intersects with the given range (if it does at all). These
checks were very presice and error prone so it was not a good idea to
have them in both places.

Since I need to add a third one, similar to this two, in this and the
following patches I'll propose a refactor of these functions.

In this patch I introduce:

- A new type e820_entry_updater that will carry three callbacks, those
callbacks will decide WHEN to perform actions over the e820_table and
WHAY actions are going to be performed.

  Note that there is a void pointer "data". This pointer will carry
  useful information for the callbacks, like the type that we want to
  update in e820__range_update or if we want to check the type in
  e820__range_remove. Check it out in the next patches where I do the
  rework of __e820__range_update and e820__range_remove.

- A new function __e820__handle_range_update that has the flow of the
original two functions to refactor. Together with e820_entry_updater
will perform the desired update on the input table.


On version 6 of this patch some people pointed out that this solution
was over-complicated. Mike Rapoport suggested a another solution [1].

I took a look at that, and although it is indeed simpler it's more
confusing at the same time. I think is manageable to have a single
function to update or remove sections of the table (what Mike did),
but when I added the functionality to also update the crypto_capable
it became really hard to manage.

I think that the approach presented in this patch it's complex but is
easier to read, to extend and to test.

[1] https://git.kernel.org/rppt/h/x86/e820-update-range

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 148 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..923585ab8377 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -459,6 +459,154 @@ static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
 	return __append_e820_table(entries, nr_entries);
 }
 
+/**
+ * struct e820_entry_updater - Helper type for
+ * __e820__handle_range_update().
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
+static u64 __init
+__e820__handle_intersected_range_update(struct e820_table *table,
+					u64 start,
+					u64 size,
+					struct e820_entry *entry,
+					const struct e820_entry_updater *updater,
+					const void *data)
+{
+	u64 end;
+	u64 entry_end = entry->addr + entry->size;
+	u64 inner_start;
+	u64 inner_end;
+	u64 updated_size = 0;
+
+	if (size > (ULLONG_MAX - start))
+		size = ULLONG_MAX - start;
+
+	end = start + size;
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
+
+		updated_size += inner_end - inner_start;
+	} /* Else: [start, end) doesn't cover entry */
+
+	return updated_size;
+}
+
+/**
+ * __e820__handle_range_update(): Helper function to update an address
+ * range in a e820_table
+ * @table: e820_table that we want to modify.
+ * @start: Start of the range.
+ * @size: Size of the range.
+ * @updater: Callbacks to modify the table.
+ * @data: Information to modify the table. This must be an struct
+ * e820_type_*_data.
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
+
+	if (size > (ULLONG_MAX - start))
+		size = ULLONG_MAX - start;
+
+	end = start + size;
+
+	for (i = 0; i < table->nr_entries; i++) {
+		struct e820_entry *entry = &table->entries[i];
+		u64 entry_end = entry->addr + entry->size;
+
+		if (updater->should_update(entry, data)) {
+			/* Range completely covers entry */
+			if (entry->addr >= start && entry_end <= end) {
+				updated_size += entry->size;
+				updater->update(entry, data);
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
+						  entry->type,
+						  entry->crypto_capable);
+
+				updated_size += size;
+			} else {
+				updated_size +=
+					__e820__handle_intersected_range_update(table, start, size,
+										entry, updater, data);
+			}
+		}
+	}
+
+	return updated_size;
+}
+
 static u64 __init
 __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
 {
-- 
2.30.2

