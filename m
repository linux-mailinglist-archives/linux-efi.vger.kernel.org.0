Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A923E7CD3
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhHJPvx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbhHJPvx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Aug 2021 11:51:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DADC0613C1;
        Tue, 10 Aug 2021 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QlWw4HkDy5SAmkfrpc0mwZV7UjMebgqtnRR8/HWQxmk=; b=PVGigAGcwUI+QHwHRB0vYyQH1Q
        KklGjuGhGSV4919sBOMK3Fr4Y0/z0yzMkSEKR+9mYZDDvA2EniwedJONHYQ6jxPO2a9wuWnDmfLXa
        0HOwTrF7vJPZCMNBtWJG/YOl9FeY0rTfIxoXAWKgQNSLhGjz6ubkMRrw1heI/XX4SR7RBV23bby1x
        V+o3dpzzSA4Va/TLTT1WNotu2qOW/UIc44m/LH3aMfRIefnjDzecl6Un621VMMF7eWh/25MD8dqlK
        JKmmEQ5HpdI7Q/htOkTku6Qi3n848uiVuLJSTuqpz0S/aflwdA05oLWPdYtaCYOM0hkETUkz8k5QG
        oqezCzzw==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDU0g-00CInx-TV; Tue, 10 Aug 2021 15:49:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/4] block: pass a gendisk to bdev_resize_partition
Date:   Tue, 10 Aug 2021 17:45:12 +0200
Message-Id: <20210810154512.1809898-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810154512.1809898-1-hch@lst.de>
References: <20210810154512.1809898-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

bdev_resize_partition can only operate on the whole device.  Make that clear
by passing a gendisk instead of a block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             |  4 ++--
 block/ioctl.c           |  2 +-
 block/partitions/core.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 21c441eb6773..db6f82bbb683 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -350,8 +350,8 @@ void blk_free_ext_minor(unsigned int minor);
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 int bdev_del_partition(struct gendisk *disk, int partno);
-int bdev_resize_partition(struct block_device *bdev, int partno,
-		sector_t start, sector_t length);
+int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
+		sector_t length);
 
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
diff --git a/block/ioctl.c b/block/ioctl.c
index 8f57b276b2f1..eb0491e90b9a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -43,7 +43,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 			return -EINVAL;
 		return bdev_add_partition(disk, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
-		return bdev_resize_partition(bdev, p.pno, start, length);
+		return bdev_resize_partition(disk, p.pno, start, length);
 	default:
 		return -EINVAL;
 	}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 679bbe82a227..6462d983cb3a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -497,14 +497,14 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	return ret;
 }
 
-int bdev_resize_partition(struct block_device *bdev, int partno,
-		sector_t start, sector_t length)
+int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
+		sector_t length)
 {
 	struct block_device *part = NULL;
 	int ret = -ENXIO;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	part = xa_load(&bdev->bd_disk->part_tbl, partno);
+	mutex_lock(&disk->open_mutex);
+	part = xa_load(&disk->part_tbl, partno);
 	if (!part)
 		goto out_unlock;
 
@@ -513,14 +513,14 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		goto out_unlock;
 
 	ret = -EBUSY;
-	if (partition_overlaps(bdev->bd_disk, start, length, partno))
+	if (partition_overlaps(disk, start, length, partno))
 		goto out_unlock;
 
 	bdev_set_nr_sectors(part, length);
 
 	ret = 0;
 out_unlock:
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 
-- 
2.30.2

