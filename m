Return-Path: <linux-efi+bounces-170-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F173480CF34
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9231F219D8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC014B5A2;
	Mon, 11 Dec 2023 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E5t7jfdU"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E6F3;
	Mon, 11 Dec 2023 07:12:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7B6AE0006;
	Mon, 11 Dec 2023 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702307568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27exMqHpZla3nbyFfGXB40l8DvvyaMkXegra0K6TRzY=;
	b=E5t7jfdU0yZKAmOSFgdr3XJOL59pux6eGaoszNC8A0npWR2u+foG+ZchJ3XAfaYZ8BzyPx
	UTVQWoWy+FlGpqULjm4GBagvMpPIv72wahJCI9sNjoFQdPDS7vNLauHVKnLOVvetKcuCDK
	MZV6RyLjrgzC7nZCKyRtWeJjL7BIvrlrTD4uzzc7ddTx7sZD8qoB6t+NAKDO8mZYXHkZ8V
	D2jGIyzZyXTfTHHTWCiWdzow0n4TrvizEwEqCsJkpdsgGW7mrmtJ1qREUsKmkq/UMbSDZe
	fhuvP5km3b8DSK5SMcrtKaHBbxu5PEB5yImOt5oZYde4NYo4obchrvIT1PsppQ==
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
Subject: [RFC PATCH 4/6] block: partitions: efi: Move GPT-specific code to a new library
Date: Mon, 11 Dec 2023 16:12:40 +0100
Message-ID: <20231211151244.289349-5-romain.gantois@bootlin.com>
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

The GPT parser in the block layer contains much logic that is not specific
to block devices. Move all of this logic to a new generic GPT library so
that future GPT parsers can make use of it.

lib/gpt.c is designed as a stateless library. It mainly contains helpers
that validate GPT metadata.

The efi_crc32 function is moved out of the block layer GPT parser and into
the generic efi header.

There is no functional change.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 MAINTAINERS              |   1 +
 block/partitions/Kconfig |   2 +-
 block/partitions/efi.c   | 336 --------------------------------------
 include/linux/efi.h      |  18 +++
 lib/Kconfig              |   3 +
 lib/Makefile             |   3 +
 lib/gpt.c                | 342 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 368 insertions(+), 337 deletions(-)
 create mode 100644 lib/gpt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 22e37e2ea1ae..c01abee48b75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9235,6 +9235,7 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.c
 F:	include/linux/gpt.h
+F:	lib/gpt.c
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 7aff4eb81c60..c2b2618213ba 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -250,7 +250,7 @@ config KARMA_PARTITION
 config EFI_PARTITION
 	bool "EFI GUID Partition support" if PARTITION_ADVANCED
 	default y
-	select CRC32
+	select GENERIC_LIB_GPT
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using EFI GPT.
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 3630ebf4b997..58bcd2cbcdf8 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -83,7 +83,6 @@
  *
  ************************************************************/
 #include <linux/kernel.h>
-#include <linux/crc32.h>
 #include <linux/ctype.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
@@ -103,24 +102,6 @@ force_gpt_fn(char *str)
 }
 __setup("gpt", force_gpt_fn);
 
-/**
- * efi_crc32() - EFI version of crc32 function
- * @buf: buffer to calculate crc32 of
- * @len: length of buf
- *
- * Description: Returns EFI-style CRC32 value for @buf
- *
- * This function uses the little endian Ethernet polynomial
- * but seeds the function with ~0, and xor's with ~0 at the end.
- * Note, the EFI Specification, v1.02, has a reference to
- * Dr. Dobbs Journal, May 1994 (actually it's in May 1992).
- */
-static inline u32
-efi_crc32(const void *buf, unsigned long len)
-{
-	return (crc32(~0L, buf, len) ^ ~0L);
-}
-
 /**
  * last_lba(): return number of last logical block of device
  * @disk: block device
@@ -136,91 +117,6 @@ static u64 last_lba(struct gendisk *disk)
 		       queue_logical_block_size(disk->queue)) - 1ULL;
 }
 
-static inline int pmbr_part_valid(gpt_mbr_record *part)
-{
-	if (part->os_type != EFI_PMBR_OSTYPE_EFI_GPT)
-		goto invalid;
-
-	/* set to 0x00000001 (i.e., the LBA of the GPT Partition Header) */
-	if (le32_to_cpu(part->starting_lba) != GPT_PRIMARY_PARTITION_TABLE_LBA)
-		goto invalid;
-
-	return GPT_MBR_PROTECTIVE;
-invalid:
-	return 0;
-}
-
-/**
- * gpt_is_pmbr_valid(): test Protective MBR for validity
- * @mbr: pointer to a legacy mbr structure
- * @total_sectors: amount of sectors in the device
- *
- * Description: Checks for a valid protective or hybrid
- * master boot record (MBR). The validity of a pMBR depends
- * on all of the following properties:
- *  1) MSDOS signature is in the last two bytes of the MBR
- *  2) One partition of type 0xEE is found
- *
- * In addition, a hybrid MBR will have up to three additional
- * primary partitions, which point to the same space that's
- * marked out by up to three GPT partitions.
- *
- * Returns 0 upon invalid MBR, or GPT_MBR_PROTECTIVE or
- * GPT_MBR_HYBRID depending on the device layout.
- */
-int gpt_is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
-{
-	uint32_t sz = 0;
-	int i, part = 0, ret = 0; /* invalid by default */
-
-	if (!mbr || le16_to_cpu(mbr->signature) != MSDOS_MBR_SIGNATURE)
-		goto done;
-
-	for (i = 0; i < 4; i++) {
-		ret = pmbr_part_valid(&mbr->partition_record[i]);
-		if (ret == GPT_MBR_PROTECTIVE) {
-			part = i;
-			/*
-			 * Ok, we at least know that there's a protective MBR,
-			 * now check if there are other partition types for
-			 * hybrid MBR.
-			 */
-			goto check_hybrid;
-		}
-	}
-
-	if (ret != GPT_MBR_PROTECTIVE)
-		goto done;
-check_hybrid:
-	for (i = 0; i < 4; i++)
-		if (mbr->partition_record[i].os_type !=
-		     EFI_PMBR_OSTYPE_EFI_GPT &&
-		    mbr->partition_record[i].os_type != 0x00)
-			ret = GPT_MBR_HYBRID;
-
-	/*
-	 * Protective MBRs take up the lesser of the whole disk
-	 * or 2 TiB (32bit LBA), ignoring the rest of the disk.
-	 * Some partitioning programs, nonetheless, choose to set
-	 * the size to the maximum 32-bit limitation, disregarding
-	 * the disk size.
-	 *
-	 * Hybrid MBRs do not necessarily comply with this.
-	 *
-	 * Consider a bad value here to be a warning to support dd'ing
-	 * an image from a smaller disk to a larger disk.
-	 */
-	if (ret == GPT_MBR_PROTECTIVE) {
-		sz = le32_to_cpu(mbr->partition_record[part].size_in_lba);
-		if (sz != (uint32_t)total_sectors - 1 && sz != 0xFFFFFFFF)
-			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u).\n",
-				 sz, min_t(uint32_t,
-					   total_sectors - 1, 0xFFFFFFFF));
-	}
-done:
-	return ret;
-}
-
 /**
  * read_lba(): Read bytes from disk, starting at given LBA
  * @state: disk parsed partitions
@@ -323,119 +219,6 @@ static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 	return gpt;
 }
 
-/**
- * gpt_validate_header() - tests one GPT header for validity
- * @gpt:      header to check
- * @lba:      logical block address of the GPT header to test
- * @lba_size: logical block size of the partitioned device
- * @lastlba:  last logical block on the partitioned device
- *
- * Returns 0 if validation was successful.
- */
-int gpt_validate_header(gpt_header *gpt, u64 lba, unsigned int lba_size,
-			u64 lastlba)
-{
-	u32 crc, origcrc;
-	u64 pt_size;
-
-	/* Check the GUID Partition Table signature */
-	if (le64_to_cpu(gpt->signature) != GPT_HEADER_SIGNATURE) {
-		pr_debug("GUID Partition Table Header signature is wrong: %lld != %lld\n",
-			 (unsigned long long)le64_to_cpu(gpt->signature),
-			 (unsigned long long)GPT_HEADER_SIGNATURE);
-		return -EINVAL;
-	}
-
-	/* Check the GUID Partition Table header size is too big */
-	if (le32_to_cpu(gpt->header_size) > lba_size) {
-		pr_debug("GUID Partition Table Header size is too large: %u > %u\n",
-			 le32_to_cpu(gpt->header_size), lba_size);
-		return -EINVAL;
-	}
-
-	/* Check the GUID Partition Table header size is too small */
-	if (le32_to_cpu(gpt->header_size) < sizeof(gpt_header)) {
-		pr_debug("GUID Partition Table Header size is too small: %u < %zu\n",
-			 le32_to_cpu(gpt->header_size),
-			 sizeof(gpt_header));
-		return -EINVAL;
-	}
-
-	/* Check the GUID Partition Table CRC */
-	origcrc = le32_to_cpu(gpt->header_crc32);
-	gpt->header_crc32 = 0;
-	crc = efi_crc32((const unsigned char *)gpt, le32_to_cpu(gpt->header_size));
-
-	if (crc != origcrc) {
-		pr_debug("GUID Partition Table Header CRC is wrong: %x != %x\n",
-			 crc, origcrc);
-		return -EINVAL;
-	}
-	gpt->header_crc32 = cpu_to_le32(origcrc);
-
-	/* Check that the my_lba entry points to the LBA that contains
-	 * the GUID Partition Table
-	 */
-	if (le64_to_cpu(gpt->my_lba) != lba) {
-		pr_debug("GPT my_lba incorrect: %lld != %lld\n",
-			 (unsigned long long)le64_to_cpu(gpt->my_lba),
-			 (unsigned long long)lba);
-		return -EINVAL;
-	}
-
-	/* Check the first_usable_lba and last_usable_lba are
-	 * within the disk.
-	 */
-	if (le64_to_cpu(gpt->first_usable_lba) > lastlba) {
-		pr_debug("GPT: first_usable_lba incorrect: %lld > %lld\n",
-			 (unsigned long long)le64_to_cpu(gpt->first_usable_lba),
-			 (unsigned long long)lastlba);
-		return -EINVAL;
-	}
-	if (le64_to_cpu(gpt->last_usable_lba) > lastlba) {
-		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
-			 (unsigned long long)le64_to_cpu(gpt->last_usable_lba),
-			 (unsigned long long)lastlba);
-		return -EINVAL;
-	}
-	if (le64_to_cpu(gpt->last_usable_lba) < le64_to_cpu(gpt->first_usable_lba)) {
-		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
-			 (unsigned long long)le64_to_cpu(gpt->last_usable_lba),
-			 (unsigned long long)le64_to_cpu(gpt->first_usable_lba));
-		return -EINVAL;
-	}
-
-	/* Check that sizeof_partition_entry has the correct value */
-	if (le32_to_cpu(gpt->sizeof_partition_entry) != sizeof(gpt_entry)) {
-		pr_debug("GUID Partition Entry Size check failed.\n");
-		return -EINVAL;
-	}
-
-	/* Sanity check partition table size */
-	pt_size = (u64)get_pt_size(gpt);
-	if (pt_size > KMALLOC_MAX_SIZE) {
-		pr_debug("GUID Partition Table is too large: %llu > %lu bytes\n",
-			 (unsigned long long)pt_size, KMALLOC_MAX_SIZE);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/* Check the GUID Partition Entry Array CRC */
-int gpt_check_pte_array_crc(gpt_header *gpt, gpt_entry *ptes)
-{
-	u32 crc;
-
-	crc = efi_crc32((const unsigned char *)ptes, get_pt_size(gpt));
-	if (crc != le32_to_cpu(gpt->partition_entry_array_crc32)) {
-		pr_debug("GUID Partition Entry Array CRC check failed.\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /**
  * is_gpt_valid() - tests one GPT header and PTEs for validity
  * @state: disk parsed partitions
@@ -483,100 +266,6 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 	return 0;
 }
 
-/**
- * gpt_compare_alt() - Compares the Primary and Alternate GPT headers
- * @pgpt: primary GPT header
- * @agpt: alternate GPT header
- * @lastlba: last LBA number
- *
- * Description: Sanity checks pgpt and agpt fields and prints warnings
- * on discrepancies. Returns error count. GPT parsers can choose to
- * ignore this or not.
- *
- */
-int gpt_compare_alt(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
-{
-	int error_found = 0;
-
-	if (!pgpt || !agpt)
-		return -EINVAL;
-
-	if (le64_to_cpu(pgpt->my_lba) != le64_to_cpu(agpt->alternate_lba)) {
-		pr_warn("GPT:Primary header LBA != Alt. header alternate_lba\n");
-		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(pgpt->my_lba),
-			(unsigned long long)le64_to_cpu(agpt->alternate_lba));
-		error_found++;
-	}
-	if (le64_to_cpu(pgpt->alternate_lba) != le64_to_cpu(agpt->my_lba)) {
-		pr_warn("GPT:Primary header alternate_lba != Alt. header my_lba\n");
-		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
-			(unsigned long long)le64_to_cpu(agpt->my_lba));
-		error_found++;
-	}
-	if (le64_to_cpu(pgpt->first_usable_lba) !=
-	    le64_to_cpu(agpt->first_usable_lba)) {
-		pr_warn("GPT:first_usable_lbas don't match.\n");
-		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
-			(unsigned long long)le64_to_cpu(agpt->first_usable_lba));
-		error_found++;
-	}
-	if (le64_to_cpu(pgpt->last_usable_lba) !=
-	    le64_to_cpu(agpt->last_usable_lba)) {
-		pr_warn("GPT:last_usable_lbas don't match.\n");
-		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
-			(unsigned long long)le64_to_cpu(agpt->last_usable_lba));
-		error_found++;
-	}
-	if (efi_guidcmp(pgpt->disk_guid, agpt->disk_guid)) {
-		pr_warn("GPT:disk_guids don't match.\n");
-		error_found++;
-	}
-	if (le32_to_cpu(pgpt->num_partition_entries) !=
-	    le32_to_cpu(agpt->num_partition_entries)) {
-		pr_warn("GPT:num_partition_entries don't match: 0x%x != 0x%x\n",
-			le32_to_cpu(pgpt->num_partition_entries),
-			le32_to_cpu(agpt->num_partition_entries));
-		error_found++;
-	}
-	if (le32_to_cpu(pgpt->sizeof_partition_entry) !=
-	    le32_to_cpu(agpt->sizeof_partition_entry)) {
-		pr_warn("GPT:sizeof_partition_entry values don't match: 0x%x != 0x%x\n",
-			le32_to_cpu(pgpt->sizeof_partition_entry),
-			le32_to_cpu(agpt->sizeof_partition_entry));
-		error_found++;
-	}
-	if (le32_to_cpu(pgpt->partition_entry_array_crc32) !=
-	    le32_to_cpu(agpt->partition_entry_array_crc32)) {
-		pr_warn("GPT:partition_entry_array_crc32 values don't match: 0x%x != 0x%x\n",
-			le32_to_cpu(pgpt->partition_entry_array_crc32),
-			le32_to_cpu(agpt->partition_entry_array_crc32));
-		error_found++;
-	}
-	if (le64_to_cpu(pgpt->alternate_lba) != lastlba) {
-		pr_warn("GPT:Primary header thinks Alt. header is not at the end of the disk.\n");
-		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
-			(unsigned long long)lastlba);
-		error_found++;
-	}
-
-	if (le64_to_cpu(agpt->my_lba) != lastlba) {
-		pr_warn("GPT:Alternate GPT header not at the end of the disk.\n");
-		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(agpt->my_lba),
-			(unsigned long long)lastlba);
-		error_found++;
-	}
-
-	if (error_found)
-		pr_warn("GPT: Use GNU Parted to correct GPT errors.\n");
-	return error_found;
-}
-
 /**
  * find_valid_gpt() - Search disk for valid GPT headers and PTEs
  * @state: disk parsed partitions
@@ -682,31 +371,6 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 	return 0;
 }
 
-/**
- * utf16_le_to_7bit(): Naively converts a UTF-16LE string to 7-bit ASCII characters
- * @in: input UTF-16LE string
- * @size: size of the input string
- * @out: output string ptr, should be capable to store @size+1 characters
- *
- * Description: Converts @size UTF16-LE symbols from @in string to 7-bit
- * ASCII characters and stores them to @out. Adds trailing zero to @out array.
- */
-void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
-{
-	unsigned int i = 0;
-
-	out[size] = 0;
-
-	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
-
-		if (c && !isprint(c))
-			c = '!';
-		out[i] = c;
-		i++;
-	}
-}
-
 /**
  * efi_partition - scan for GPT partitions
  * @state: disk parsed partitions
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9cc5bf32f6f2..c4b818f77de7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -24,6 +24,7 @@
 #include <linux/range.h>
 #include <linux/reboot.h>
 #include <linux/uuid.h>
+#include <linux/crc32.h>
 
 #include <asm/page.h>
 
@@ -1348,4 +1349,21 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+/**
+ * efi_crc32() - EFI version of crc32 function
+ * @buf: buffer to calculate crc32 of
+ * @len: length of buf
+ *
+ * Description: Returns EFI-style CRC32 value for @buf
+ *
+ * This function uses the little endian Ethernet polynomial
+ * but seeds the function with ~0, and xor's with ~0 at the end.
+ * Note, the EFI Specification, v1.02, has a reference to
+ * Dr. Dobbs Journal, May 1994 (actually it's in May 1992).
+ */
+static inline u32 efi_crc32(const void *buf, unsigned long len)
+{
+	return (crc32(~0L, buf, len) ^ ~0L);
+}
+
 #endif /* _LINUX_EFI_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3ea1c830efab..de776911944e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -748,6 +748,9 @@ config GENERIC_LIB_ASHLDI3
 config GENERIC_LIB_ASHRDI3
 	bool
 
+config GENERIC_LIB_GPT
+	bool
+
 config GENERIC_LIB_LSHRDI3
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..fba8fae70efa 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -444,3 +444,6 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
 endif
+
+# GPT parsing routines
+obj-$(CONFIG_GENERIC_LIB_GPT) += gpt.o
diff --git a/lib/gpt.c b/lib/gpt.c
new file mode 100644
index 000000000000..16303634f4fb
--- /dev/null
+++ b/lib/gpt.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* EFI GUID Partition Table handling
+ *
+ * http://www.uefi.org/specs/
+ * http://www.intel.com/technology/efi/
+ *
+ * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>
+ *   Copyright 2000,2001,2002,2004 Dell Inc.
+ *
+ * This code was previously in block/partitions/efi.c
+ * and was moved in /lib so that other kernel subsystems
+ * could use it as a common GPT parsing library.
+ *
+ * This library should be stateless and not make any
+ * assumptions about the type of device the GPT data
+ * came from.
+ *
+ */
+
+#include <linux/gpt.h>
+#include <linux/efi.h>
+
+static inline int pmbr_part_valid(gpt_mbr_record *part)
+{
+	if (part->os_type != EFI_PMBR_OSTYPE_EFI_GPT)
+		goto invalid;
+
+	/* set to 0x00000001 (i.e., the LBA of the GPT Partition Header) */
+	if (le32_to_cpu(part->starting_lba) != GPT_PRIMARY_PARTITION_TABLE_LBA)
+		goto invalid;
+
+	return GPT_MBR_PROTECTIVE;
+invalid:
+	return 0;
+}
+
+/**
+ * gpt_is_pmbr_valid(): test Protective MBR for validity
+ * @mbr: pointer to a legacy mbr structure
+ * @total_sectors: amount of sectors in the device
+ *
+ * Description: Checks for a valid protective or hybrid
+ * master boot record (MBR). The validity of a pMBR depends
+ * on all of the following properties:
+ *  1) MSDOS signature is in the last two bytes of the MBR
+ *  2) One partition of type 0xEE is found
+ *
+ * In addition, a hybrid MBR will have up to three additional
+ * primary partitions, which point to the same space that's
+ * marked out by up to three GPT partitions.
+ *
+ * Returns 0 upon invalid MBR, or GPT_MBR_PROTECTIVE or
+ * GPT_MBR_HYBRID depending on the device layout.
+ */
+int gpt_is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
+{
+	int i, part = 0, ret = 0; /* invalid by default */
+	uint32_t sz = 0;
+
+	if (!mbr || le16_to_cpu(mbr->signature) != MSDOS_MBR_SIGNATURE)
+		goto done;
+
+	for (i = 0; i < 4; i++) {
+		ret = pmbr_part_valid(&mbr->partition_record[i]);
+		if (ret == GPT_MBR_PROTECTIVE) {
+			part = i;
+			/*
+			 * Ok, we at least know that there's a protective MBR,
+			 * now check if there are other partition types for
+			 * hybrid MBR.
+			 */
+			goto check_hybrid;
+		}
+	}
+
+	if (ret != GPT_MBR_PROTECTIVE)
+		goto done;
+check_hybrid:
+	for (i = 0; i < 4; i++)
+		if (mbr->partition_record[i].os_type != EFI_PMBR_OSTYPE_EFI_GPT &&
+		    mbr->partition_record[i].os_type != 0x00)
+			ret = GPT_MBR_HYBRID;
+
+	/*
+	 * Protective MBRs take up the lesser of the whole disk
+	 * or 2 TiB (32bit LBA), ignoring the rest of the disk.
+	 * Some partitioning programs, nonetheless, choose to set
+	 * the size to the maximum 32-bit limitation, disregarding
+	 * the disk size.
+	 *
+	 * Hybrid MBRs do not necessarily comply with this.
+	 *
+	 * Consider a bad value here to be a warning to support dd'ing
+	 * an image from a smaller disk to a larger disk.
+	 */
+	if (ret == GPT_MBR_PROTECTIVE) {
+		sz = le32_to_cpu(mbr->partition_record[part].size_in_lba);
+		if (sz != (uint32_t)total_sectors - 1 && sz != 0xFFFFFFFF)
+			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u).\n",
+				 sz, min_t(uint32_t,
+					   total_sectors - 1, 0xFFFFFFFF));
+	}
+done:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gpt_is_pmbr_valid);
+
+/**
+ * gpt_validate_header() - tests one GPT header for validity
+ * @gpt:      header to check
+ * @lba:      logical block address of the GPT header to test
+ * @lba_size: logical block size of the partitioned device
+ * @lastlba:  last logical block on the partitioned device
+ *
+ * Returns 0 if validation was successful.
+ */
+int gpt_validate_header(gpt_header *gpt, u64 lba, unsigned int lba_size,
+			u64 lastlba)
+{
+	u32 crc, origcrc;
+	u64 pt_size;
+
+	/* Check the GUID Partition Table signature */
+	if (le64_to_cpu(gpt->signature) != GPT_HEADER_SIGNATURE) {
+		pr_debug("GUID Partition Table Header signature is wrong: %lld != %lld\n",
+			 (unsigned long long)le64_to_cpu(gpt->signature),
+			 (unsigned long long)GPT_HEADER_SIGNATURE);
+		return -EINVAL;
+	}
+
+	/* Check the GUID Partition Table header size is too big */
+	if (le32_to_cpu(gpt->header_size) > lba_size) {
+		pr_debug("GUID Partition Table Header size is too large: %u > %u\n",
+			 le32_to_cpu(gpt->header_size), lba_size);
+		return -EINVAL;
+	}
+
+	/* Check the GUID Partition Table header size is too small */
+	if (le32_to_cpu(gpt->header_size) < sizeof(gpt_header)) {
+		pr_debug("GUID Partition Table Header size is too small: %u < %zu\n",
+			 le32_to_cpu(gpt->header_size),
+			 sizeof(gpt_header));
+		return -EINVAL;
+	}
+
+	/* Check the GUID Partition Table CRC */
+	origcrc = le32_to_cpu(gpt->header_crc32);
+	gpt->header_crc32 = 0;
+	crc = efi_crc32((const unsigned char *)gpt, le32_to_cpu(gpt->header_size));
+
+	if (crc != origcrc) {
+		pr_debug("GUID Partition Table Header CRC is wrong: %x != %x\n",
+			 crc, origcrc);
+		return -EINVAL;
+	}
+	gpt->header_crc32 = cpu_to_le32(origcrc);
+
+	/* Check that the my_lba entry points to the LBA that contains
+	 * the GUID Partition Table
+	 */
+	if (le64_to_cpu(gpt->my_lba) != lba) {
+		pr_debug("GPT my_lba incorrect: %lld != %lld\n",
+			 (unsigned long long)le64_to_cpu(gpt->my_lba),
+			 (unsigned long long)lba);
+		return -EINVAL;
+	}
+
+	/* Check the first_usable_lba and last_usable_lba are
+	 * within the disk.
+	 */
+	if (le64_to_cpu(gpt->first_usable_lba) > lastlba) {
+		pr_debug("GPT: first_usable_lba incorrect: %lld > %lld\n",
+			 (unsigned long long)le64_to_cpu(gpt->first_usable_lba),
+			 (unsigned long long)lastlba);
+		return -EINVAL;
+	}
+	if (le64_to_cpu(gpt->last_usable_lba) > lastlba) {
+		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
+			 (unsigned long long)le64_to_cpu(gpt->last_usable_lba),
+			 (unsigned long long)lastlba);
+		return -EINVAL;
+	}
+	if (le64_to_cpu(gpt->last_usable_lba) < le64_to_cpu(gpt->first_usable_lba)) {
+		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
+			 (unsigned long long)le64_to_cpu(gpt->last_usable_lba),
+			 (unsigned long long)le64_to_cpu(gpt->first_usable_lba));
+		return -EINVAL;
+	}
+
+	/* Check that sizeof_partition_entry has the correct value */
+	if (le32_to_cpu(gpt->sizeof_partition_entry) != sizeof(gpt_entry)) {
+		pr_debug("GUID Partition Entry Size check failed.\n");
+		return -EINVAL;
+	}
+
+	/* Sanity check partition table size */
+	pt_size = (u64)get_pt_size(gpt);
+	if (pt_size > KMALLOC_MAX_SIZE) {
+		pr_debug("GUID Partition Table is too large: %llu > %lu bytes\n",
+			 (unsigned long long)pt_size, KMALLOC_MAX_SIZE);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpt_validate_header);
+
+/* Check the GUID Partition Entry Array CRC */
+int gpt_check_pte_array_crc(gpt_header *gpt, gpt_entry *ptes)
+{
+	u32 crc;
+
+	crc = efi_crc32((const unsigned char *)ptes, get_pt_size(gpt));
+	if (crc != le32_to_cpu(gpt->partition_entry_array_crc32)) {
+		pr_debug("GUID Partition Entry Array CRC check failed.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpt_check_pte_array_crc);
+
+/**
+ * gpt_compare_alt() - Compares the Primary and Alternate GPT headers
+ * @pgpt: primary GPT header
+ * @agpt: alternate GPT header
+ * @lastlba: last LBA number
+ *
+ * Description: Sanity checks pgpt and agpt fields and prints warnings
+ * on discrepancies. Returns error count. GPT parsers can choose to
+ * ignore this or not.
+ *
+ */
+int gpt_compare_alt(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
+{
+	int error_found = 0;
+
+	if (!pgpt || !agpt)
+		return -EINVAL;
+
+	if (le64_to_cpu(pgpt->my_lba) != le64_to_cpu(agpt->alternate_lba)) {
+		pr_warn("GPT:Primary header LBA != Alt. header alternate_lba\n");
+		pr_warn("GPT:%lld != %lld\n",
+			(unsigned long long)le64_to_cpu(pgpt->my_lba),
+			(unsigned long long)le64_to_cpu(agpt->alternate_lba));
+		error_found++;
+	}
+	if (le64_to_cpu(pgpt->alternate_lba) != le64_to_cpu(agpt->my_lba)) {
+		pr_warn("GPT:Primary header alternate_lba != Alt. header my_lba\n");
+		pr_warn("GPT:%lld != %lld\n",
+			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
+			(unsigned long long)le64_to_cpu(agpt->my_lba));
+		error_found++;
+	}
+	if (le64_to_cpu(pgpt->first_usable_lba) !=
+	    le64_to_cpu(agpt->first_usable_lba)) {
+		pr_warn("GPT:first_usable_lbas don't match.\n");
+		pr_warn("GPT:%lld != %lld\n",
+			(unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
+			(unsigned long long)le64_to_cpu(agpt->first_usable_lba));
+		error_found++;
+	}
+	if (le64_to_cpu(pgpt->last_usable_lba) !=
+	    le64_to_cpu(agpt->last_usable_lba)) {
+		pr_warn("GPT:last_usable_lbas don't match.\n");
+		pr_warn("GPT:%lld != %lld\n",
+			(unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
+			(unsigned long long)le64_to_cpu(agpt->last_usable_lba));
+		error_found++;
+	}
+	if (efi_guidcmp(pgpt->disk_guid, agpt->disk_guid)) {
+		pr_warn("GPT:disk_guids don't match.\n");
+		error_found++;
+	}
+	if (le32_to_cpu(pgpt->num_partition_entries) !=
+	    le32_to_cpu(agpt->num_partition_entries)) {
+		pr_warn("GPT:num_partition_entries don't match: 0x%x != 0x%x\n",
+			le32_to_cpu(pgpt->num_partition_entries),
+			le32_to_cpu(agpt->num_partition_entries));
+		error_found++;
+	}
+	if (le32_to_cpu(pgpt->sizeof_partition_entry) !=
+	    le32_to_cpu(agpt->sizeof_partition_entry)) {
+		pr_warn("GPT:sizeof_partition_entry values don't match: 0x%x != 0x%x\n",
+			le32_to_cpu(pgpt->sizeof_partition_entry),
+			le32_to_cpu(agpt->sizeof_partition_entry));
+		error_found++;
+	}
+	if (le32_to_cpu(pgpt->partition_entry_array_crc32) !=
+	    le32_to_cpu(agpt->partition_entry_array_crc32)) {
+		pr_warn("GPT:partition_entry_array_crc32 values don't match: 0x%x != 0x%x\n",
+			le32_to_cpu(pgpt->partition_entry_array_crc32),
+			le32_to_cpu(agpt->partition_entry_array_crc32));
+		error_found++;
+	}
+	if (le64_to_cpu(pgpt->alternate_lba) != lastlba) {
+		pr_warn("GPT:Primary header thinks Alt. header is not at the end of the disk.\n");
+		pr_warn("GPT:%lld != %lld\n",
+			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
+			(unsigned long long)lastlba);
+		error_found++;
+	}
+
+	if (le64_to_cpu(agpt->my_lba) != lastlba) {
+		pr_warn("GPT:Alternate GPT header not at the end of the disk.\n");
+		pr_warn("GPT:%lld != %lld\n",
+			(unsigned long long)le64_to_cpu(agpt->my_lba),
+			(unsigned long long)lastlba);
+		error_found++;
+	}
+
+	if (error_found)
+		pr_warn("GPT: Use GNU Parted to correct GPT errors.\n");
+	return error_found;
+}
+EXPORT_SYMBOL_GPL(gpt_compare_alt);
+
+/**
+ * utf16_le_to_7bit(): Naively converts a UTF-16LE string to 7-bit ASCII characters
+ * @in: input UTF-16LE string
+ * @size: size of the input string
+ * @out: output string ptr, should be capable to store @size+1 characters
+ *
+ * Description: Converts @size UTF16-LE symbols from @in string to 7-bit
+ * ASCII characters and stores them to @out. Adds trailing zero to @out array.
+ */
+void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
+{
+	unsigned int i = 0;
+
+	out[size] = 0;
+
+	while (i < size) {
+		u8 c = le16_to_cpu(in[i]) & 0xff;
+
+		if (c && !isprint(c))
+			c = '!';
+		out[i] = c;
+		i++;
+	}
+}
+EXPORT_SYMBOL_GPL(utf16_le_to_7bit);
-- 
2.43.0


