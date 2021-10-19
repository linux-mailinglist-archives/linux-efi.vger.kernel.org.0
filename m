Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF3432E11
	for <lists+linux-efi@lfdr.de>; Tue, 19 Oct 2021 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhJSGW4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Oct 2021 02:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGWz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Oct 2021 02:22:55 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A818C06161C;
        Mon, 18 Oct 2021 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=P0Qb5DQF0h6Vh0HJc/CLwBlglni+7Xd8PpHSfCQ3aWg=; b=sHj2kDpMMRysIff/a9GcdgwK9q
        pEdgWrNIOaa5o98is8jbTV2m+5teuZOvR6nLD7a+D5wo9ruzkJpAIiKMZL2SvnbFU7qqazBnUzkAr
        CzVKUikkZGfoghzrbgCszJQ/1lakJiFFJO4cX09mGTuJBdqiD/5QS0keKDqKA56xvsrYg5gNdstV/
        IsRDpEQ59aDx7T+Jau0l9CRTNcVKHGco+jjVWsQsfI0+dfKbfrn6SSk+86dcBzFDrbqi1/oH8MZaZ
        tfNJcavptzEkBb/vzLRWVO18vnxg9bAkTmacgsI81F2RcxKhpswvP7OmnCkahQ5L9cepE4ExRlzew
        GtBeqQAA==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mciUK-000HMH-N6; Tue, 19 Oct 2021 06:20:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/3] partitions/ibm: use bdev_nr_sectors instead of open coding it
Date:   Tue, 19 Oct 2021 08:20:24 +0200
Message-Id: <20211019062024.2171074-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019062024.2171074-1-hch@lst.de>
References: <20211019062024.2171074-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the proper helper to read the block device size and switch various
places to pass the size in terms of sectors which is more practical.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/ibm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 9bca396aef4ad..d56912fe81732 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -198,7 +198,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 				char name[],
 				union label_t *label,
 				sector_t labelsect,
-				loff_t i_size,
+				sector_t nr_sectors,
 				dasd_information2_t *info)
 {
 	loff_t offset, geo_size, size;
@@ -213,14 +213,14 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 	} else {
 		/*
 		 * Formated w/o large volume support. If the sanity check
-		 * 'size based on geo == size based on i_size' is true, then
+		 * 'size based on geo == size based on br_sectors' is true, then
 		 * we can safely assume that we know the formatted size of
 		 * the disk, otherwise we need additional information
 		 * that we can only get from a real DASD device.
 		 */
 		geo_size = geo->cylinders * geo->heads
 			* geo->sectors * secperblk;
-		size = i_size >> 9;
+		size = nr_sectors;
 		if (size != geo_size) {
 			if (!info) {
 				strlcat(state->pp_buf, "\n", PAGE_SIZE);
@@ -229,7 +229,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 			if (!strcmp(info->type, "ECKD"))
 				if (geo_size < size)
 					size = geo_size;
-			/* else keep size based on i_size */
+			/* else keep size based on nr_sectors */
 		}
 	}
 	/* first and only partition starts in the first block after the label */
@@ -293,7 +293,8 @@ int ibm_partition(struct parsed_partitions *state)
 	struct gendisk *disk = state->disk;
 	struct block_device *bdev = disk->part0;
 	int blocksize, res;
-	loff_t i_size, offset, size;
+	loff_t offset, size;
+	sector_t nr_sectors;
 	dasd_information2_t *info;
 	struct hd_geometry *geo;
 	char type[5] = {0,};
@@ -308,8 +309,8 @@ int ibm_partition(struct parsed_partitions *state)
 	blocksize = bdev_logical_block_size(bdev);
 	if (blocksize <= 0)
 		goto out_symbol;
-	i_size = i_size_read(bdev->bd_inode);
-	if (i_size == 0)
+	nr_sectors = bdev_nr_sectors(bdev);
+	if (nr_sectors == 0)
 		goto out_symbol;
 	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
 	if (info == NULL)
@@ -336,7 +337,7 @@ int ibm_partition(struct parsed_partitions *state)
 						   label);
 		} else if (!strncmp(type, "LNX1", 4)) {
 			res = find_lnx1_partitions(state, geo, blocksize, name,
-						   label, labelsect, i_size,
+						   label, labelsect, nr_sectors,
 						   info);
 		} else if (!strncmp(type, "CMS1", 4)) {
 			res = find_cms1_partitions(state, geo, blocksize, name,
@@ -353,7 +354,7 @@ int ibm_partition(struct parsed_partitions *state)
 		res = 1;
 		if (info->format == DASD_FORMAT_LDL) {
 			strlcat(state->pp_buf, "(nonl)", PAGE_SIZE);
-			size = i_size >> 9;
+			size = nr_sectors;
 			offset = (info->label_block + 1) * (blocksize >> 9);
 			put_partition(state, 1, offset, size-offset);
 			strlcat(state->pp_buf, "\n", PAGE_SIZE);
-- 
2.30.2

