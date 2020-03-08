Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D248917D293
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCHIKr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCHIKq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:46 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B577208CD;
        Sun,  8 Mar 2020 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655046;
        bh=zKc2SulQs20Cun6h+8jWyRK6CogiZd5HYwoguulFBaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDCdSQlouPvsqVU7VFKJjgMIGTsuaITPxaujpKw9pl+YMQxBU4FHqvul2LGA4s3q1
         R/zWLFuSHMtWyyBFL0frK0e87hiqS2+FDq7isOfgEhQPT0fUuQhnIq40ejkcp6MWgj
         sxrpdR1Eh4VwU6OBSltjKwpijeEB4n3es76Uqr8g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 28/28] partitions/efi: Fix partition name parsing in GUID partition entry
Date:   Sun,  8 Mar 2020 09:08:59 +0100
Message-Id: <20200308080859.21568-29-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Nikolai Merinov <n.merinov@inango-systems.com>

GUID partition entry defined to have a partition name as 36 UTF-16LE
code units. This means that on big-endian platforms ASCII symbols
would be read with 0xXX00 efi_char16_t character code. In order to
correctly extract ASCII characters from a partition name field we
should be converted from 16LE to CPU architecture.

The problem exists on all big endian platforms.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
Fixes: eec7ecfede74 ("genhd, efi: add efi partition metadata to hd_structs")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 block/partitions/efi.c | 35 ++++++++++++++++++++++++++---------
 block/partitions/efi.h |  2 +-
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index db2fef7dfc47..d26a0654d7ca 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -656,6 +656,30 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         return 0;
 }
 
+/**
+ * utf16_le_to_7bit(): Naively converts UTF-16LE string to 7bit characters
+ * @in: input UTF-16LE string
+ * @size: size of the input string
+ * @out: output string ptr, should be capable to store @size+1 characters
+ *
+ * Description: Converts @size UTF16-LE symbols from @in string to 7bit
+ * characters and store them to @out. Adds trailing zero to @out array.
+ */
+static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
+{
+	unsigned int i = 0;
+
+	out[size] = 0;
+	while (i < size) {
+		u8 c = le16_to_cpu(in[i]) & 0xff;
+
+		if (c && !isprint(c))
+			c = '!';
+		out[i] = c;
+		i++;
+	}
+}
+
 /**
  * efi_partition(struct parsed_partitions *state)
  * @state: disk parsed partitions
@@ -692,7 +716,6 @@ int efi_partition(struct parsed_partitions *state)
 
 	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
 		struct partition_meta_info *info;
-		unsigned label_count = 0;
 		unsigned label_max;
 		u64 start = le64_to_cpu(ptes[i].starting_lba);
 		u64 size = le64_to_cpu(ptes[i].ending_lba) -
@@ -713,14 +736,8 @@ int efi_partition(struct parsed_partitions *state)
 		/* Naively convert UTF16-LE to 7 bits. */
 		label_max = min(ARRAY_SIZE(info->volname) - 1,
 				ARRAY_SIZE(ptes[i].partition_name));
-		info->volname[label_max] = 0;
-		while (label_count < label_max) {
-			u8 c = ptes[i].partition_name[label_count] & 0xff;
-			if (c && !isprint(c))
-				c = '!';
-			info->volname[label_count] = c;
-			label_count++;
-		}
+		utf16_le_to_7bit(ptes[i].partition_name, label_max,
+				 info->volname);
 		state->parts[i + 1].has_info = true;
 	}
 	kfree(ptes);
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 3e8576157575..0b6d5b7be111 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -88,7 +88,7 @@ typedef struct _gpt_entry {
 	__le64 starting_lba;
 	__le64 ending_lba;
 	gpt_entry_attributes attributes;
-	efi_char16_t partition_name[72 / sizeof (efi_char16_t)];
+	__le16 partition_name[72 / sizeof (__le16)];
 } __packed gpt_entry;
 
 typedef struct _gpt_mbr_record {
-- 
2.17.1

