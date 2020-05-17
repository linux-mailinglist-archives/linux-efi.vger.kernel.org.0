Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703331D653E
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgEQCNa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEQCN3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:13:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D084C061A0C;
        Sat, 16 May 2020 19:13:27 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so4992524lfe.5;
        Sat, 16 May 2020 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0o7uTeMMiknzTDLyOmQ9sSn2udYzDsg380RDfhX0oU=;
        b=YRAo0d6kjWYnoIquN8WoAcF93xXF/b0Hx+sLB1OD3wj18IOr0BOdQ46D9Xvgx14PeP
         2bkzrOz+O5oRLA7X/xGJF9ROs41wfuhjyG4fJPTm0DNLmtD+3uBsTYS0wTqNd7g0eoxn
         ANYJGT1iETXbKG1wxKHYHEaWpP6GS4BRLB/a/SnDK2D0+L7qaohKPBhbYKumc2MWRFHT
         zXxHQlkkwIUDlTWI8tXgj4D3w+eprBdrtElhyOOKe+CFWyWvSvXUDTfnsXYBFX+dM4Jk
         xNS7OfcV5PkjSqco66P6p/8q4/TGF3qRy985F1FmDwXyQD78WCGBqnfeR3t3rpBwZCHV
         U/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0o7uTeMMiknzTDLyOmQ9sSn2udYzDsg380RDfhX0oU=;
        b=gT0TsCthJSPu613N6Lb+16MPuMSB/RRaV/dvdSLDIJhsJZaSjOaX/DS2UusEZ6BYw4
         YB1SgFl9z4Kg1cDZQhXFUT/BUSxEzimk/H2nXhlXSvxHS8vL7bYJ5gmxCbW3BXC2XOKU
         VX43CszK0XAQHvtPpBamm4c7kOQsMyxOA3gxsJPhAunz4UvUq3JVxJ74gb02dqkhrxY4
         pgDNO7GZXkP6A1ZHiC34EWakVkuPLjp99ryA1DLwJYkjC8VoziqlMscjvQD1/BZXt96s
         CtaSSqia2kmcrkaHzdw46H8AjNGFdIqyVs2q7nQAMbBOFcD+/AXmoU0FSU1kAyGbYiQB
         MyVw==
X-Gm-Message-State: AOAM532g7e/mU8otYyWsLwDcsa6hIjYY7xx7PYfkZnrP+dbf497CdYc9
        ssT8Zt5kU/ZF4k3nLrQ92+o=
X-Google-Smtp-Source: ABdhPJzojD26S2gUGtOFW0VMgSY+GHJksrLetZBcxRS85JMaN9V3ItxTn5tOdOu5dCTbnS/yl7Wn4g==
X-Received: by 2002:a05:6512:44d:: with SMTP id y13mr7099060lfk.118.1589681605951;
        Sat, 16 May 2020 19:13:25 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id z5sm3463149lji.30.2020.05.16.19.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:13:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?q?Nils=20=C3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v6 5/7] partitions/efi: Improve coding style
Date:   Sun, 17 May 2020 05:12:23 +0300
Message-Id: <20200517021225.22890-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200517021225.22890-1-digetx@gmail.com>
References: <20200517021225.22890-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 'efi.c' source code has a lot of coding style problems like:

  - trailing whitespaces
  - whitespaces instead of tabs
  - missing whitespaces where they actually needed
  - double blank-lines
  - improperly aligned code
  - improperly styled multi-line comments
  - unnecessarily assigned variables
  - NULL-checks that can't ever trigger

and etc.

This patch fixes few dozen of coding style problems without introducing
any functional changes, making code easier to read, and thus, easier to
maintain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/efi.c | 354 ++++++++++++++++++++---------------------
 1 file changed, 175 insertions(+), 179 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 34c25f708733..f0229e7a6894 100644
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
@@ -82,15 +82,18 @@
  * - Code works, detects all the partitions.
  *
  ************************************************************/
-#include <linux/kernel.h>
 #include <linux/crc32.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
+#include <linux/types.h>
+
 #include "check.h"
 #include "efi.h"
 
-/* This allows a kernel command line option 'gpt' to override
+/*
+ * This allows a kernel command line option 'gpt' to override
  * the test for invalid PMBR.  Not __initdata because reloading
  * the partition tables happens after init too.
  */
@@ -103,14 +106,13 @@ force_gpt_fn(char *str)
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
@@ -125,7 +127,7 @@ efi_crc32(const void *buf, unsigned long len)
 /**
  * last_lba(): return number of last logical block of device
  * @bdev: block device
- * 
+ *
  * Description: Returns last LBA value on success, 0 on error.
  * This is stored (by sd and ide-geometry) in
  *  the part[0] entry for this disk, and is the number of
@@ -173,8 +175,8 @@ static inline int pmbr_part_valid(gpt_mbr_record *part)
  */
 static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 {
-	uint32_t sz = 0;
-	int i, part = 0, ret = 0; /* invalid by default */
+	unsigned int i, sz = 0, part = 0;
+	int ret = 0; /* invalid by default */
 
 	if (!mbr || le16_to_cpu(mbr->signature) != MSDOS_MBR_SIGNATURE)
 		goto done;
@@ -195,11 +197,13 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 	if (ret != GPT_MBR_PROTECTIVE)
 		goto done;
 check_hybrid:
-	for (i = 0; i < 4; i++)
-		if ((mbr->partition_record[i].os_type !=
-			EFI_PMBR_OSTYPE_EFI_GPT) &&
-		    (mbr->partition_record[i].os_type != 0x00))
+	for (i = 0; i < 4; i++) {
+		if (mbr->partition_record[i].os_type != EFI_PMBR_OSTYPE_EFI_GPT &&
+		    mbr->partition_record[i].os_type != 0x00) {
 			ret = GPT_MBR_HYBRID;
+			break;
+		}
+	}
 
 	/*
 	 * Protective MBRs take up the lesser of the whole disk
@@ -215,10 +219,9 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 	 */
 	if (ret == GPT_MBR_PROTECTIVE) {
 		sz = le32_to_cpu(mbr->partition_record[part].size_in_lba);
-		if (sz != (uint32_t) total_sectors - 1 && sz != 0xFFFFFFFF)
-			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u).\n",
-				 sz, min_t(uint32_t,
-					   total_sectors - 1, 0xFFFFFFFF));
+		if (sz != (u32)total_sectors - 1 && sz != 0xFFFFFFFF)
+			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u)\n",
+				 sz, min_t(u32, total_sectors - 1, 0xFFFFFFFF));
 	}
 done:
 	return ret;
@@ -237,17 +240,18 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 static size_t read_lba(struct parsed_partitions *state,
 		       u64 lba, u8 *buffer, size_t count)
 {
-	size_t totalreadcount = 0;
+	size_t totalreadcount = 0, copied;
 	struct block_device *bdev = state->bdev;
 	sector_t n = lba * (bdev_logical_block_size(bdev) / 512);
+	Sector sect;
+	u8 *data;
 
 	if (!buffer || lba > last_lba(bdev))
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
@@ -255,7 +259,7 @@ static size_t read_lba(struct parsed_partitions *state,
 		memcpy(buffer, data, copied);
 		put_dev_sector(sect);
 		buffer += copied;
-		totalreadcount +=copied;
+		totalreadcount += copied;
 		count -= copied;
 	}
 	return totalreadcount;
@@ -265,7 +269,7 @@ static size_t read_lba(struct parsed_partitions *state,
  * alloc_read_gpt_entries(): reads partition entries from disk
  * @state: disk parsed partitions
  * @gpt: GPT header
- * 
+ *
  * Description: Returns ptes on success,  NULL on error.
  * Allocates space for PTEs based on information found in @gpt.
  * Notes: remember to free pte when you're done!
@@ -280,7 +284,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 		return NULL;
 
 	count = (size_t)le32_to_cpu(gpt->num_partition_entries) *
-                le32_to_cpu(gpt->sizeof_partition_entry);
+			le32_to_cpu(gpt->sizeof_partition_entry);
 	if (!count)
 		return NULL;
 	pte = kmalloc(count, GFP_KERNEL);
@@ -288,9 +292,8 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 		return NULL;
 
 	if (read_lba(state, le64_to_cpu(gpt->partition_entry_lba),
-			(u8 *) pte, count) < count) {
+		     (u8 *)pte, count) < count) {
 		kfree(pte);
-                pte=NULL;
 		return NULL;
 	}
 	return pte;
@@ -300,7 +303,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
  * alloc_read_gpt_header(): Allocates GPT header, reads into it from disk
  * @state: disk parsed partitions
  * @lba: the Logical Block Address of the partition table
- * 
+ *
  * Description: returns GPT header on success, NULL on error.   Allocates
  * and fills a GPT header starting at @ from @state->bdev.
  * Note: remember to free gpt when finished with it.
@@ -308,16 +311,15 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 					 u64 lba)
 {
+	unsigned int ssz = bdev_logical_block_size(state->bdev);
 	gpt_header *gpt;
-	unsigned ssz = bdev_logical_block_size(state->bdev);
 
 	gpt = kmalloc(ssz, GFP_KERNEL);
 	if (!gpt)
 		return NULL;
 
-	if (read_lba(state, lba, (u8 *) gpt, ssz) < ssz) {
+	if (read_lba(state, lba, (u8 *)gpt, ssz) < ssz) {
 		kfree(gpt);
-                gpt=NULL;
 		return NULL;
 	}
 
@@ -328,127 +330,130 @@ static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
  * is_gpt_valid() - tests one GPT header and PTEs for validity
  * @state: disk parsed partitions
  * @lba: logical block address of the GPT header to test
- * @gpt: GPT header ptr, filled on return.
- * @ptes: PTEs ptr, filled on return.
+ * @ret_gpt: GPT header ptr, filled on successful return.
+ * @ret_ptes: PTEs ptr, filled on successful return.
  *
  * Description: returns 1 if valid,  0 on error.
  * If valid, returns pointers to newly allocated GPT header and PTEs.
  */
 static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
-			gpt_header **gpt, gpt_entry **ptes)
+			gpt_header **ret_gpt, gpt_entry **ret_ptes)
 {
-	u32 crc, origcrc;
 	u64 lastlba, pt_size;
+	u32 crc, origcrc;
+	gpt_header *gpt;
+	gpt_entry *ptes;
 
-	if (!ptes)
-		return 0;
-	if (!(*gpt = alloc_read_gpt_header(state, lba)))
+	gpt = alloc_read_gpt_header(state, lba);
+	if (!gpt)
 		return 0;
 
 	/* Check the GUID Partition Table signature */
-	if (le64_to_cpu((*gpt)->signature) != GPT_HEADER_SIGNATURE) {
-		pr_debug("GUID Partition Table Header signature is wrong:"
-			 "%lld != %lld\n",
-			 (unsigned long long)le64_to_cpu((*gpt)->signature),
-			 (unsigned long long)GPT_HEADER_SIGNATURE);
+	if (le64_to_cpu(gpt->signature) != GPT_HEADER_SIGNATURE) {
+		pr_debug("GUID Partition Table Header signature is wrong: %lld != %lld\n",
+			 (u64)le64_to_cpu(gpt->signature),
+			 (u64)GPT_HEADER_SIGNATURE);
 		goto fail;
 	}
 
 	/* Check the GUID Partition Table header size is too big */
-	if (le32_to_cpu((*gpt)->header_size) >
+	if (le32_to_cpu(gpt->header_size) >
 			bdev_logical_block_size(state->bdev)) {
 		pr_debug("GUID Partition Table Header size is too large: %u > %u\n",
-			le32_to_cpu((*gpt)->header_size),
-			bdev_logical_block_size(state->bdev));
+			 le32_to_cpu(gpt->header_size),
+			 bdev_logical_block_size(state->bdev));
 		goto fail;
 	}
 
 	/* Check the GUID Partition Table header size is too small */
-	if (le32_to_cpu((*gpt)->header_size) < sizeof(gpt_header)) {
+	if (le32_to_cpu(gpt->header_size) < sizeof(gpt_header)) {
 		pr_debug("GUID Partition Table Header size is too small: %u < %zu\n",
-			le32_to_cpu((*gpt)->header_size),
-			sizeof(gpt_header));
+			 le32_to_cpu(gpt->header_size),
+			 sizeof(gpt_header));
 		goto fail;
 	}
 
 	/* Check the GUID Partition Table CRC */
-	origcrc = le32_to_cpu((*gpt)->header_crc32);
-	(*gpt)->header_crc32 = 0;
-	crc = efi_crc32((const unsigned char *) (*gpt), le32_to_cpu((*gpt)->header_size));
+	origcrc = le32_to_cpu(gpt->header_crc32);
+	gpt->header_crc32 = 0;
+	crc = efi_crc32(gpt, le32_to_cpu(gpt->header_size));
 
 	if (crc != origcrc) {
 		pr_debug("GUID Partition Table Header CRC is wrong: %x != %x\n",
 			 crc, origcrc);
 		goto fail;
 	}
-	(*gpt)->header_crc32 = cpu_to_le32(origcrc);
+	gpt->header_crc32 = cpu_to_le32(origcrc);
 
-	/* Check that the my_lba entry points to the LBA that contains
-	 * the GUID Partition Table */
-	if (le64_to_cpu((*gpt)->my_lba) != lba) {
+	/*
+	 * Check that the my_lba entry points to the LBA that contains
+	 * the GUID Partition Table.
+	 */
+	if (le64_to_cpu(gpt->my_lba) != lba) {
 		pr_debug("GPT my_lba incorrect: %lld != %lld\n",
-			 (unsigned long long)le64_to_cpu((*gpt)->my_lba),
-			 (unsigned long long)lba);
+			 (u64)le64_to_cpu(gpt->my_lba), lba);
 		goto fail;
 	}
 
-	/* Check the first_usable_lba and last_usable_lba are
+	/*
+	 * Check the first_usable_lba and last_usable_lba are
 	 * within the disk.
 	 */
 	lastlba = last_lba(state->bdev);
-	if (le64_to_cpu((*gpt)->first_usable_lba) > lastlba) {
+	if (le64_to_cpu(gpt->first_usable_lba) > lastlba) {
 		pr_debug("GPT: first_usable_lba incorrect: %lld > %lld\n",
-			 (unsigned long long)le64_to_cpu((*gpt)->first_usable_lba),
-			 (unsigned long long)lastlba);
+			 (u64)le64_to_cpu(gpt->first_usable_lba), lastlba);
 		goto fail;
 	}
-	if (le64_to_cpu((*gpt)->last_usable_lba) > lastlba) {
+	if (le64_to_cpu(gpt->last_usable_lba) > lastlba) {
 		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
-			 (unsigned long long)le64_to_cpu((*gpt)->last_usable_lba),
-			 (unsigned long long)lastlba);
+			 (u64)le64_to_cpu(gpt->last_usable_lba), lastlba);
 		goto fail;
 	}
-	if (le64_to_cpu((*gpt)->last_usable_lba) < le64_to_cpu((*gpt)->first_usable_lba)) {
+	if (le64_to_cpu(gpt->last_usable_lba) <
+	    le64_to_cpu(gpt->first_usable_lba)) {
 		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
-			 (unsigned long long)le64_to_cpu((*gpt)->last_usable_lba),
-			 (unsigned long long)le64_to_cpu((*gpt)->first_usable_lba));
+			 (u64)le64_to_cpu(gpt->last_usable_lba),
+			 (u64)le64_to_cpu(gpt->first_usable_lba));
 		goto fail;
 	}
 	/* Check that sizeof_partition_entry has the correct value */
-	if (le32_to_cpu((*gpt)->sizeof_partition_entry) != sizeof(gpt_entry)) {
-		pr_debug("GUID Partition Entry Size check failed.\n");
+	if (le32_to_cpu(gpt->sizeof_partition_entry) != sizeof(gpt_entry)) {
+		pr_debug("GUID Partition Entry Size check failed\n");
 		goto fail;
 	}
 
 	/* Sanity check partition table size */
-	pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
-		le32_to_cpu((*gpt)->sizeof_partition_entry);
+	pt_size = (u64)le32_to_cpu(gpt->num_partition_entries) *
+		       le32_to_cpu(gpt->sizeof_partition_entry);
 	if (pt_size > KMALLOC_MAX_SIZE) {
 		pr_debug("GUID Partition Table is too large: %llu > %lu bytes\n",
-			 (unsigned long long)pt_size, KMALLOC_MAX_SIZE);
+			 pt_size, KMALLOC_MAX_SIZE);
 		goto fail;
 	}
 
-	if (!(*ptes = alloc_read_gpt_entries(state, *gpt)))
+	ptes = alloc_read_gpt_entries(state, gpt);
+	if (!ptes)
 		goto fail;
 
 	/* Check the GUID Partition Entry Array CRC */
-	crc = efi_crc32((const unsigned char *) (*ptes), pt_size);
+	crc = efi_crc32(ptes, pt_size);
 
-	if (crc != le32_to_cpu((*gpt)->partition_entry_array_crc32)) {
-		pr_debug("GUID Partition Entry Array CRC check failed.\n");
+	if (crc != le32_to_cpu(gpt->partition_entry_array_crc32)) {
+		pr_debug("GUID Partition Entry Array CRC check failed\n");
 		goto fail_ptes;
 	}
 
+	*ret_gpt  = gpt;
+	*ret_ptes = ptes;
+
 	/* We're done, all's well */
 	return 1;
 
- fail_ptes:
-	kfree(*ptes);
-	*ptes = NULL;
- fail:
-	kfree(*gpt);
-	*gpt = NULL;
+fail_ptes:
+	kfree(ptes);
+fail:
+	kfree(gpt);
 	return 0;
 }
 
@@ -462,8 +467,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 static inline int
 is_pte_valid(const gpt_entry *pte, const u64 lastlba)
 {
-	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
-	    le64_to_cpu(pte->starting_lba) > lastlba         ||
+	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID))	||
+	    le64_to_cpu(pte->starting_lba) > lastlba		||
 	    le64_to_cpu(pte->ending_lba)   > lastlba)
 		return 0;
 	return 1;
@@ -477,98 +482,93 @@ is_pte_valid(const gpt_entry *pte, const u64 lastlba)
  *
  * Description: Returns nothing.  Sanity checks pgpt and agpt fields
  * and prints warnings on discrepancies.
- * 
+ *
  */
 static void
 compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 {
-	int error_found = 0;
+	unsigned int error_found = 0;
+
 	if (!pgpt || !agpt)
 		return;
 	if (le64_to_cpu(pgpt->my_lba) != le64_to_cpu(agpt->alternate_lba)) {
 		pr_warn("GPT:Primary header LBA != Alt. header alternate_lba\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->my_lba),
-                       (unsigned long long)le64_to_cpu(agpt->alternate_lba));
+			(u64)le64_to_cpu(pgpt->my_lba),
+			(u64)le64_to_cpu(agpt->alternate_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->alternate_lba) != le64_to_cpu(agpt->my_lba)) {
 		pr_warn("GPT:Primary header alternate_lba != Alt. header my_lba\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->alternate_lba),
-                       (unsigned long long)le64_to_cpu(agpt->my_lba));
+			(u64)le64_to_cpu(pgpt->alternate_lba),
+			(u64)le64_to_cpu(agpt->my_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->first_usable_lba) !=
-            le64_to_cpu(agpt->first_usable_lba)) {
-		pr_warn("GPT:first_usable_lbas don't match.\n");
+	    le64_to_cpu(agpt->first_usable_lba)) {
+		pr_warn("GPT:first_usable_lbas don't match\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
-                       (unsigned long long)le64_to_cpu(agpt->first_usable_lba));
+			(u64)le64_to_cpu(pgpt->first_usable_lba),
+			(u64)le64_to_cpu(agpt->first_usable_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->last_usable_lba) !=
-            le64_to_cpu(agpt->last_usable_lba)) {
-		pr_warn("GPT:last_usable_lbas don't match.\n");
+	    le64_to_cpu(agpt->last_usable_lba)) {
+		pr_warn("GPT:last_usable_lbas don't match\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
-                       (unsigned long long)le64_to_cpu(agpt->last_usable_lba));
+			(u64)le64_to_cpu(pgpt->last_usable_lba),
+			(u64)le64_to_cpu(agpt->last_usable_lba));
 		error_found++;
 	}
 	if (efi_guidcmp(pgpt->disk_guid, agpt->disk_guid)) {
-		pr_warn("GPT:disk_guids don't match.\n");
+		pr_warn("GPT:disk_guids don't match\n");
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
-		pr_warn("GPT:Primary header thinks Alt. header is not at the end of the disk.\n");
+		pr_warn("GPT:Primary header thinks Alt. header is not at the end of the disk\n");
 		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
-			(unsigned long long)lastlba);
+			(u64)le64_to_cpu(pgpt->alternate_lba), lastlba);
 		error_found++;
 	}
 
 	if (le64_to_cpu(agpt->my_lba) != lastlba) {
-		pr_warn("GPT:Alternate GPT header not at the end of the disk.\n");
+		pr_warn("GPT:Alternate GPT header not at the end of the disk\n");
 		pr_warn("GPT:%lld != %lld\n",
-			(unsigned long long)le64_to_cpu(agpt->my_lba),
-			(unsigned long long)lastlba);
+			(u64)le64_to_cpu(agpt->my_lba), lastlba);
 		error_found++;
 	}
 
 	if (error_found)
-		pr_warn("GPT: Use GNU Parted to correct GPT errors.\n");
-	return;
+		pr_warn("GPT: Use GNU Parted to correct GPT errors\n");
 }
 
 /**
  * find_valid_gpt() - Search disk for valid GPT headers and PTEs
  * @state: disk parsed partitions
- * @gpt: GPT header ptr, filled on return.
- * @ptes: PTEs ptr, filled on return.
+ * @gpt: GPT header ptr, filled on successful return.
+ * @ptes: PTEs ptr, filled on successful return.
  *
  * Description: Returns 1 if valid, 0 on error.
  * If valid, returns pointers to newly allocated GPT header and PTEs.
@@ -583,18 +583,14 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 			  gpt_entry **ptes)
 {
-	int good_pgpt = 0, good_agpt = 0, good_pmbr = 0;
+	sector_t total_sectors = i_size_read(state->bdev->bd_inode) >> 9;
+	int good_pgpt, good_agpt = 0, good_pmbr = 0;
 	gpt_header *pgpt = NULL, *agpt = NULL;
 	gpt_entry *pptes = NULL, *aptes = NULL;
+	u64 lastlba = last_lba(state->bdev);
 	legacy_mbr *legacymbr;
-	sector_t total_sectors = i_size_read(state->bdev->bd_inode) >> 9;
-	u64 lastlba;
-
-	if (!ptes)
-		return 0;
 
-	lastlba = last_lba(state->bdev);
-        if (!force_gpt) {
+	if (!force_gpt) {
 		/* This will be added to the EFI Spec. per Intel after v1.02. */
 		legacymbr = kzalloc(sizeof(*legacymbr), GFP_KERNEL);
 		if (!legacymbr)
@@ -614,12 +610,12 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 
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
 
 	/*
 	 * The force_gpt_sector is used by NVIDIA Tegra partition parser in
@@ -630,43 +626,42 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
 					 &agpt, &aptes);
 
-        /* The obviously unsuccessful case */
-        if (!good_pgpt && !good_agpt)
-                goto fail;
+	/* The obviously unsuccessful case */
+	if (!good_pgpt && !good_agpt)
+		goto fail;
 
-        compare_gpts(pgpt, agpt, lastlba);
+	compare_gpts(pgpt, agpt, lastlba);
 
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
-		pr_warn("Primary GPT is invalid, using alternate GPT.\n");
-                return 1;
-        }
-
- fail:
-        kfree(pgpt);
-        kfree(agpt);
-        kfree(pptes);
-        kfree(aptes);
-        *gpt = NULL;
-        *ptes = NULL;
-        return 0;
+			pr_warn("Alternate GPT is invalid, using primary GPT\n");
+		return 1;
+	}
+
+	if (good_agpt) {
+		*gpt  = agpt;
+		*ptes = aptes;
+		kfree(pgpt);
+		kfree(pptes);
+		pr_warn("Primary GPT is invalid, using alternate GPT\n");
+		return 1;
+	}
+
+fail:
+	kfree(pgpt);
+	kfree(agpt);
+	kfree(pptes);
+	kfree(aptes);
+	return 0;
 }
 
 /**
- * utf16_le_to_7bit(): Naively converts a UTF-16LE string to 7-bit ASCII characters
+ * utf16_le_to_7bit()
  * @in: input UTF-16LE string
  * @size: size of the input string
  * @out: output string ptr, should be capable to store @size+1 characters
@@ -713,20 +708,19 @@ int efi_partition(struct parsed_partitions *state)
 {
 	gpt_header *gpt = NULL;
 	gpt_entry *ptes = NULL;
-	u32 i;
-	unsigned ssz = bdev_logical_block_size(state->bdev) / 512;
+	unsigned int ssz = bdev_logical_block_size(state->bdev) / 512;
+	unsigned int num_partition_entries, i;
 
-	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
-		kfree(gpt);
-		kfree(ptes);
+	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes)
 		return 0;
-	}
 
 	pr_debug("GUID Partition Table is valid!  Yea!\n");
 
-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
+	num_partition_entries = le32_to_cpu(gpt->num_partition_entries);
+
+	for (i = 0; i < num_partition_entries && i < state->limit - 1; i++) {
 		struct partition_meta_info *info;
-		unsigned label_max;
+		unsigned int label_max;
 		u64 start = le64_to_cpu(ptes[i].starting_lba);
 		u64 size = le64_to_cpu(ptes[i].ending_lba) -
 			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
@@ -734,10 +728,11 @@ int efi_partition(struct parsed_partitions *state)
 		if (!is_pte_valid(&ptes[i], last_lba(state->bdev)))
 			continue;
 
-		put_partition(state, i+1, start * ssz, size * ssz);
+		put_partition(state, i + 1, start * ssz, size * ssz);
 
 		/* If this is a RAID volume, tell md */
-		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
+		if (!efi_guidcmp(ptes[i].partition_type_guid,
+				 PARTITION_LINUX_RAID_GUID))
 			state->parts[i + 1].flags = ADDPART_FLAG_RAID;
 
 		info = &state->parts[i + 1].info;
@@ -746,7 +741,8 @@ int efi_partition(struct parsed_partitions *state)
 		/* Naively convert UTF16-LE to 7 bits. */
 		label_max = min(ARRAY_SIZE(info->volname) - 1,
 				ARRAY_SIZE(ptes[i].partition_name));
-		utf16_le_to_7bit(ptes[i].partition_name, label_max, info->volname);
+		utf16_le_to_7bit(ptes[i].partition_name, label_max,
+				 info->volname);
 		state->parts[i + 1].has_info = true;
 	}
 	kfree(ptes);
-- 
2.26.0

