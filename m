Return-Path: <linux-efi+bounces-167-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC880CF28
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63551C21286
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43354A9B8;
	Mon, 11 Dec 2023 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pZDzHfZF"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36335DF;
	Mon, 11 Dec 2023 07:12:46 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F33A8E0009;
	Mon, 11 Dec 2023 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702307565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUfspWPSm5Z0Eq757vAt+6Dbv5F4kK+jkRV9nwdv310=;
	b=pZDzHfZFTFcXA83fdSz6qeXmYOMnGzzXt7Go6hl6HC1uA0zmUz5dD/PBwK9CBqWBc1IRIP
	TqMlLl+F6qM9FZtJawatH4mtHx9J8JMKfl2Yw6Fx5NH8bz/lXsSeIH5kR11sSLLvLN0167
	qDfchrxV7bewOAQOCV08QA2MOpcV5MZZwZ+PUQVzpCbpUMdF5faSIhg0A7KCi10pN8s8Hq
	w8gRlxq7gFxNLiV6AdigXGeOnjuf49G1yuwwwSjbaSP2VjUnYZWNhikuXIGc8G53kc9eIz
	gSmVNjlArKmnkbxT1ftG3y+MhWW2uncGF7yr21/ZBInT8c2WlL49UDlquit93w==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [RFC PATCH 2/6] block: partitions: efi: Fix some style issues
Date: Mon, 11 Dec 2023 16:12:38 +0100
Message-ID: <20231211151244.289349-3-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211151244.289349-1-romain.gantois@bootlin.com>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

The block layer EFI code is quite old and does not perfectly match the
current kernel coding style. Fix some indentation and trailing whitespace
issues in efi.c.

There is no functional change.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 block/partitions/efi.c | 181 ++++++++++++++++++++---------------------
 include/linux/gpt.h    |  35 ++++----
 2 files changed, 107 insertions(+), 109 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index db50c3f2bab3..bac514a62d61 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -23,7 +23,7 @@
  * - Ported to 2.5.7-pre1 and 2.5.7-dj2
  * - Applied patch to avoid fault in alternate header handling
  * - cleaned up find_valid_gpt
- * - On-disk structure and copy in memory is *always* LE now - 
+ * - On-disk structure and copy in memory is *always* LE now -
  *   swab fields as needed
  * - remove print_gpt_header()
  * - only use first max_p partition entries, to keep the kernel minor number
@@ -40,7 +40,7 @@
  * - moved le_efi_guid_to_cpus() back into this file.  GPT is the only
  *   thing that keeps EFI GUIDs on disk.
  * - Changed gpt structure names and members to be simpler and more Linux-like.
- * 
+ *
  * Wed Oct 17 2001 Matt Domsch <Matt_Domsch@dell.com>
  * - Removed CONFIG_DEVFS_VOLUMES_UUID code entirely per Martin Wilck
  *
@@ -65,7 +65,7 @@
  *
  * Wed Jun  6 2001 Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
  * - added devfs volume UUID support (/dev/volumes/uuids) for
- *   mounting file systems by the partition GUID. 
+ *   mounting file systems by the partition GUID.
  *
  * Tue Dec  5 2000 Matt Domsch <Matt_Domsch@dell.com>
  * - Moved crc32() to linux/lib, added efi_crc32().
@@ -103,14 +103,13 @@ force_gpt_fn(char *str)
 }
 __setup("gpt", force_gpt_fn);
 
-
 /**
  * efi_crc32() - EFI version of crc32 function
  * @buf: buffer to calculate crc32 of
  * @len: length of buf
  *
  * Description: Returns EFI-style CRC32 value for @buf
- * 
+ *
  * This function uses the little endian Ethernet polynomial
  * but seeds the function with ~0, and xor's with ~0 at the end.
  * Note, the EFI Specification, v1.02, has a reference to
@@ -125,7 +124,7 @@ efi_crc32(const void *buf, unsigned long len)
 /**
  * last_lba(): return number of last logical block of device
  * @disk: block device
- * 
+ *
  * Description: Returns last LBA value on success, 0 on error.
  * This is stored (by sd and ide-geometry) in
  *  the part[0] entry for this disk, and is the number of
@@ -194,9 +193,9 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 		goto done;
 check_hybrid:
 	for (i = 0; i < 4; i++)
-		if ((mbr->partition_record[i].os_type !=
-			EFI_PMBR_OSTYPE_EFI_GPT) &&
-		    (mbr->partition_record[i].os_type != 0x00))
+		if (mbr->partition_record[i].os_type !=
+		     EFI_PMBR_OSTYPE_EFI_GPT &&
+		    mbr->partition_record[i].os_type != 0x00)
 			ret = GPT_MBR_HYBRID;
 
 	/*
@@ -213,7 +212,7 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 	 */
 	if (ret == GPT_MBR_PROTECTIVE) {
 		sz = le32_to_cpu(mbr->partition_record[part].size_in_lba);
-		if (sz != (uint32_t) total_sectors - 1 && sz != 0xFFFFFFFF)
+		if (sz != (uint32_t)total_sectors - 1 && sz != 0xFFFFFFFF)
 			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u).\n",
 				 sz, min_t(uint32_t,
 					   total_sectors - 1, 0xFFFFFFFF));
@@ -235,17 +234,19 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 static size_t read_lba(struct parsed_partitions *state,
 		       u64 lba, u8 *buffer, size_t count)
 {
-	size_t totalreadcount = 0;
 	sector_t n = lba *
 		(queue_logical_block_size(state->disk->queue) / 512);
+	size_t totalreadcount = 0;
+	unsigned char *data;
+	Sector sect;
+	int copied;
 
 	if (!buffer || lba > last_lba(state->disk))
-                return 0;
+		return 0;
 
 	while (count) {
-		int copied = 512;
-		Sector sect;
-		unsigned char *data = read_part_sector(state, n++, &sect);
+		copied = 512;
+		data = read_part_sector(state, n++, &sect);
 		if (!data)
 			break;
 		if (copied > count)
@@ -253,7 +254,7 @@ static size_t read_lba(struct parsed_partitions *state,
 		memcpy(buffer, data, copied);
 		put_dev_sector(sect);
 		buffer += copied;
-		totalreadcount +=copied;
+		totalreadcount += copied;
 		count -= copied;
 	}
 	return totalreadcount;
@@ -263,7 +264,7 @@ static size_t read_lba(struct parsed_partitions *state,
  * alloc_read_gpt_entries(): reads partition entries from disk
  * @state: disk parsed partitions
  * @gpt: GPT header
- * 
+ *
  * Description: Returns ptes on success,  NULL on error.
  * Allocates space for PTEs based on information found in @gpt.
  * Notes: remember to free pte when you're done!
@@ -271,14 +272,14 @@ static size_t read_lba(struct parsed_partitions *state,
 static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 					 gpt_header *gpt)
 {
-	size_t count;
 	gpt_entry *pte;
+	size_t count;
 
 	if (!gpt)
 		return NULL;
 
 	count = (size_t)le32_to_cpu(gpt->num_partition_entries) *
-                le32_to_cpu(gpt->sizeof_partition_entry);
+		le32_to_cpu(gpt->sizeof_partition_entry);
 	if (!count)
 		return NULL;
 	pte = kmalloc(count, GFP_KERNEL);
@@ -286,9 +287,9 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 		return NULL;
 
 	if (read_lba(state, le64_to_cpu(gpt->partition_entry_lba),
-			(u8 *) pte, count) < count) {
+		     (u8 *)pte, count) < count) {
 		kfree(pte);
-                pte=NULL;
+		pte = NULL;
 		return NULL;
 	}
 	return pte;
@@ -298,7 +299,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
  * alloc_read_gpt_header(): Allocates GPT header, reads into it from disk
  * @state: disk parsed partitions
  * @lba: the Logical Block Address of the partition table
- * 
+ *
  * Description: returns GPT header on success, NULL on error.   Allocates
  * and fills a GPT header starting at @ from @state->disk.
  * Note: remember to free gpt when finished with it.
@@ -306,16 +307,16 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 					 u64 lba)
 {
+	unsigned int ssz = queue_logical_block_size(state->disk->queue);
 	gpt_header *gpt;
-	unsigned ssz = queue_logical_block_size(state->disk->queue);
 
 	gpt = kmalloc(ssz, GFP_KERNEL);
 	if (!gpt)
 		return NULL;
 
-	if (read_lba(state, lba, (u8 *) gpt, ssz) < ssz) {
+	if (read_lba(state, lba, (u8 *)gpt, ssz) < ssz) {
 		kfree(gpt);
-                gpt=NULL;
+		gpt = NULL;
 		return NULL;
 	}
 
@@ -486,31 +487,31 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 	if (le64_to_cpu(pgpt->my_lba) != le64_to_cpu(agpt->alternate_lba)) {
 		pr_warn("GPT:Primary header LBA != Alt. header alternate_lba\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->my_lba),
-                       (unsigned long long)le64_to_cpu(agpt->alternate_lba));
+			(unsigned long long)le64_to_cpu(pgpt->my_lba),
+			(unsigned long long)le64_to_cpu(agpt->alternate_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->alternate_lba) != le64_to_cpu(agpt->my_lba)) {
 		pr_warn("GPT:Primary header alternate_lba != Alt. header my_lba\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->alternate_lba),
-                       (unsigned long long)le64_to_cpu(agpt->my_lba));
+			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
+			(unsigned long long)le64_to_cpu(agpt->my_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->first_usable_lba) !=
-            le64_to_cpu(agpt->first_usable_lba)) {
+	    le64_to_cpu(agpt->first_usable_lba)) {
 		pr_warn("GPT:first_usable_lbas don't match.\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
-                       (unsigned long long)le64_to_cpu(agpt->first_usable_lba));
+			(unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
+			(unsigned long long)le64_to_cpu(agpt->first_usable_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->last_usable_lba) !=
-            le64_to_cpu(agpt->last_usable_lba)) {
+	    le64_to_cpu(agpt->last_usable_lba)) {
 		pr_warn("GPT:last_usable_lbas don't match.\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
-                       (unsigned long long)le64_to_cpu(agpt->last_usable_lba));
+			(unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
+			(unsigned long long)le64_to_cpu(agpt->last_usable_lba));
 		error_found++;
 	}
 	if (efi_guidcmp(pgpt->disk_guid, agpt->disk_guid)) {
@@ -518,27 +519,24 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 		error_found++;
 	}
 	if (le32_to_cpu(pgpt->num_partition_entries) !=
-            le32_to_cpu(agpt->num_partition_entries)) {
-		pr_warn("GPT:num_partition_entries don't match: "
-		       "0x%x != 0x%x\n",
-		       le32_to_cpu(pgpt->num_partition_entries),
-		       le32_to_cpu(agpt->num_partition_entries));
+	    le32_to_cpu(agpt->num_partition_entries)) {
+		pr_warn("GPT:num_partition_entries don't match: 0x%x != 0x%x\n",
+			le32_to_cpu(pgpt->num_partition_entries),
+			le32_to_cpu(agpt->num_partition_entries));
 		error_found++;
 	}
 	if (le32_to_cpu(pgpt->sizeof_partition_entry) !=
-            le32_to_cpu(agpt->sizeof_partition_entry)) {
-		pr_warn("GPT:sizeof_partition_entry values don't match: "
-		       "0x%x != 0x%x\n",
-                       le32_to_cpu(pgpt->sizeof_partition_entry),
-		       le32_to_cpu(agpt->sizeof_partition_entry));
+	    le32_to_cpu(agpt->sizeof_partition_entry)) {
+		pr_warn("GPT:sizeof_partition_entry values don't match: 0x%x != 0x%x\n",
+			le32_to_cpu(pgpt->sizeof_partition_entry),
+			le32_to_cpu(agpt->sizeof_partition_entry));
 		error_found++;
 	}
 	if (le32_to_cpu(pgpt->partition_entry_array_crc32) !=
-            le32_to_cpu(agpt->partition_entry_array_crc32)) {
-		pr_warn("GPT:partition_entry_array_crc32 values don't match: "
-		       "0x%x != 0x%x\n",
-                       le32_to_cpu(pgpt->partition_entry_array_crc32),
-		       le32_to_cpu(agpt->partition_entry_array_crc32));
+	    le32_to_cpu(agpt->partition_entry_array_crc32)) {
+		pr_warn("GPT:partition_entry_array_crc32 values don't match: 0x%x != 0x%x\n",
+			le32_to_cpu(pgpt->partition_entry_array_crc32),
+			le32_to_cpu(agpt->partition_entry_array_crc32));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->alternate_lba) != lastlba) {
@@ -581,20 +579,22 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 			  gpt_entry **ptes)
 {
+	sector_t total_sectors = get_capacity(state->disk);
 	int good_pgpt = 0, good_agpt = 0, good_pmbr = 0;
-	gpt_header *pgpt = NULL, *agpt = NULL;
+	const struct block_device_operations *fops;
 	gpt_entry *pptes = NULL, *aptes = NULL;
-	legacy_mbr *legacymbr;
+	gpt_header *pgpt = NULL, *agpt = NULL;
 	struct gendisk *disk = state->disk;
-	const struct block_device_operations *fops = disk->fops;
-	sector_t total_sectors = get_capacity(state->disk);
+	legacy_mbr *legacymbr;
 	u64 lastlba;
 
+	fops = disk->fops;
+
 	if (!ptes)
 		return 0;
 
 	lastlba = last_lba(state->disk);
-        if (!force_gpt) {
+	if (!force_gpt) {
 		/* This will be added to the EFI Spec. per Intel after v1.02. */
 		legacymbr = kzalloc(sizeof(*legacymbr), GFP_KERNEL);
 		if (!legacymbr)
@@ -609,17 +609,17 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 
 		pr_debug("Device has a %s MBR\n",
 			 good_pmbr == GPT_MBR_PROTECTIVE ?
-						"protective" : "hybrid");
+			 "protective" : "hybrid");
 	}
 
 	good_pgpt = is_gpt_valid(state, GPT_PRIMARY_PARTITION_TABLE_LBA,
 				 &pgpt, &pptes);
-        if (good_pgpt)
+	if (good_pgpt)
 		good_agpt = is_gpt_valid(state,
 					 le64_to_cpu(pgpt->alternate_lba),
 					 &agpt, &aptes);
-        if (!good_agpt && force_gpt)
-                good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
+	if (!good_agpt && force_gpt)
+		good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
 	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
 		sector_t agpt_sector;
@@ -631,39 +631,38 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 						 &agpt, &aptes);
 	}
 
-        /* The obviously unsuccessful case */
-        if (!good_pgpt && !good_agpt)
-                goto fail;
+	/* The obviously unsuccessful case */
+	if (!good_pgpt && !good_agpt)
+		goto fail;
 
         compare_gpts(pgpt, agpt, lastlba);
 
-        /* The good cases */
-        if (good_pgpt) {
-                *gpt  = pgpt;
-                *ptes = pptes;
-                kfree(agpt);
-                kfree(aptes);
+	/* The good cases */
+	if (good_pgpt) {
+		*gpt  = pgpt;
+		*ptes = pptes;
+		kfree(agpt);
+		kfree(aptes);
 		if (!good_agpt)
-                        pr_warn("Alternate GPT is invalid, using primary GPT.\n");
-                return 1;
-        }
-        else if (good_agpt) {
-                *gpt  = agpt;
-                *ptes = aptes;
-                kfree(pgpt);
-                kfree(pptes);
+			pr_warn("Alternate GPT is invalid, using primary GPT.\n");
+		return 1;
+	} else if (good_agpt) {
+		*gpt  = agpt;
+		*ptes = aptes;
+		kfree(pgpt);
+		kfree(pptes);
 		pr_warn("Primary GPT is invalid, using alternate GPT.\n");
-                return 1;
-        }
+		return 1;
+	}
 
- fail:
-        kfree(pgpt);
-        kfree(agpt);
-        kfree(pptes);
-        kfree(aptes);
-        *gpt = NULL;
-        *ptes = NULL;
-        return 0;
+fail:
+	kfree(pgpt);
+	kfree(agpt);
+	kfree(pptes);
+	kfree(aptes);
+	*gpt = NULL;
+	*ptes = NULL;
+	return 0;
 }
 
 /**
@@ -712,10 +711,10 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
  */
 int efi_partition(struct parsed_partitions *state)
 {
+	unsigned int ssz = queue_logical_block_size(state->disk->queue) / 512;
 	gpt_header *gpt = NULL;
 	gpt_entry *ptes = NULL;
 	u32 i;
-	unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;
 
 	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
 		kfree(gpt);
@@ -725,17 +724,17 @@ int efi_partition(struct parsed_partitions *state)
 
 	pr_debug("GUID Partition Table is valid!  Yea!\n");
 
-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
+	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit - 1; i++) {
 		struct partition_meta_info *info;
-		unsigned label_max;
+		unsigned int label_max;
 		u64 start = le64_to_cpu(ptes[i].starting_lba);
 		u64 size = le64_to_cpu(ptes[i].ending_lba) -
-			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
+			le64_to_cpu(ptes[i].starting_lba) + 1ULL;
 
 		if (!is_pte_valid(&ptes[i], last_lba(state->disk)))
 			continue;
 
-		put_partition(state, i+1, start * ssz, size * ssz);
+		put_partition(state, i + 1, start * ssz, size * ssz);
 
 		/* If this is a RAID volume, tell md */
 		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
diff --git a/include/linux/gpt.h b/include/linux/gpt.h
index 84b9f36b9e47..633be6bc826c 100644
--- a/include/linux/gpt.h
+++ b/include/linux/gpt.h
@@ -4,7 +4,7 @@
  * Per Intel EFI Specification v1.02
  * http://developer.intel.com/technology/efi/efi.htm
  *
- * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000  
+ * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000
  *   Copyright 2000,2001 Dell Inc.
  ************************************************************/
 
@@ -31,26 +31,26 @@
 #define GPT_PRIMARY_PARTITION_TABLE_LBA 1
 
 #define PARTITION_SYSTEM_GUID \
-    EFI_GUID( 0xC12A7328, 0xF81F, 0x11d2, \
-              0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B) 
+	EFI_GUID(0xC12A7328, 0xF81F, 0x11d2, \
+		 0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B)
 #define LEGACY_MBR_PARTITION_GUID \
-    EFI_GUID( 0x024DEE41, 0x33E7, 0x11d3, \
-              0x9D, 0x69, 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F)
+	EFI_GUID(0x024DEE41, 0x33E7, 0x11d3, \
+		 0x9D, 0x69, 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F)
 #define PARTITION_MSFT_RESERVED_GUID \
-    EFI_GUID( 0xE3C9E316, 0x0B5C, 0x4DB8, \
-              0x81, 0x7D, 0xF9, 0x2D, 0xF0, 0x02, 0x15, 0xAE)
+	EFI_GUID(0xE3C9E316, 0x0B5C, 0x4DB8, \
+		 0x81, 0x7D, 0xF9, 0x2D, 0xF0, 0x02, 0x15, 0xAE)
 #define PARTITION_BASIC_DATA_GUID \
-    EFI_GUID( 0xEBD0A0A2, 0xB9E5, 0x4433, \
-              0x87, 0xC0, 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7)
+	EFI_GUID(0xEBD0A0A2, 0xB9E5, 0x4433, \
+		 0x87, 0xC0, 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7)
 #define PARTITION_LINUX_RAID_GUID \
-    EFI_GUID( 0xa19d880f, 0x05fc, 0x4d3b, \
-              0xa0, 0x06, 0x74, 0x3f, 0x0f, 0x84, 0x91, 0x1e)
+	EFI_GUID(0xa19d880f, 0x05fc, 0x4d3b, \
+		 0xa0, 0x06, 0x74, 0x3f, 0x0f, 0x84, 0x91, 0x1e)
 #define PARTITION_LINUX_SWAP_GUID \
-    EFI_GUID( 0x0657fd6d, 0xa4ab, 0x43c4, \
-              0x84, 0xe5, 0x09, 0x33, 0xc8, 0x4b, 0x4f, 0x4f)
+	EFI_GUID(0x0657fd6d, 0xa4ab, 0x43c4, \
+		 0x84, 0xe5, 0x09, 0x33, 0xc8, 0x4b, 0x4f, 0x4f)
 #define PARTITION_LINUX_LVM_GUID \
-    EFI_GUID( 0xe6d6d379, 0xf507, 0x44c2, \
-              0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
+	EFI_GUID(0xe6d6d379, 0xf507, 0x44c2, \
+		 0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
 
 typedef struct _gpt_header {
 	__le64 signature;
@@ -78,7 +78,7 @@ typedef struct _gpt_header {
 typedef struct _gpt_entry_attributes {
 	u64 required_to_function:1;
 	u64 reserved:47;
-        u64 type_guid_specific:16;
+	u64 type_guid_specific:16;
 } __packed gpt_entry_attributes;
 
 typedef struct _gpt_entry {
@@ -87,7 +87,7 @@ typedef struct _gpt_entry {
 	__le64 starting_lba;
 	__le64 ending_lba;
 	gpt_entry_attributes attributes;
-	__le16 partition_name[72/sizeof(__le16)];
+	__le16 partition_name[72 / sizeof(__le16)];
 } __packed gpt_entry;
 
 typedef struct _gpt_mbr_record {
@@ -103,7 +103,6 @@ typedef struct _gpt_mbr_record {
 	__le32	size_in_lba;    /* used by EFI - size of pt in LBA */
 } __packed gpt_mbr_record;
 
-
 typedef struct _legacy_mbr {
 	u8 boot_code[440];
 	__le32 unique_mbr_signature;
-- 
2.43.0


