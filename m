Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9253E7CBF
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhHJPto (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhHJPto (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Aug 2021 11:49:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826DC0613C1;
        Tue, 10 Aug 2021 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RqFe/g2/KiqMEzYa3YxMw+ZiuYDIebvOLsET3nSOnoA=; b=Y5hI8bLkVG3+X1nQIxykYV7G3x
        xOoulSJx9mS3F5k6vE+uj6RhgiNwmyW6tLqxZ1te3PMmLvxIU5/F6vj1o+OAu0HFUYc8OXsxwFLUJ
        LWCVDePASgjY76Iiqew9GJsELwcGbY6XpxDJHD9Kpn8q89gK5U0ZMTwZkUqSALKNY5p5gWeXYPJ36
        7j/I++I4T/tVx9OIU838eWYMIeMnNhrrHkV/zOr/vXIKnqhBkc8fugrKlWNykWS0Qy3I03cgYhyBz
        mbkR7bUwe85SAV6D3O8WzAWM96UBMRU5wgsAZ28CMdMg9cgLK5xN6U3CPshHgFeKaB0S5kxsDpCQj
        rzDILvNQ==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDTy9-00CIfM-AD; Tue, 10 Aug 2021 15:47:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/4] block: pass a gendisk to bdev_add_partition
Date:   Tue, 10 Aug 2021 17:45:10 +0200
Message-Id: <20210810154512.1809898-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810154512.1809898-1-hch@lst.de>
References: <20210810154512.1809898-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

bdev_add_partition can only operate on the whole device.  Make that clear
by passing a gendisk instead of a block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             | 4 ++--
 block/ioctl.c           | 3 ++-
 block/partitions/core.c | 5 ++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 56f33fbcde59..c0486f609978 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -347,8 +347,8 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-int bdev_add_partition(struct block_device *bdev, int partno,
-		sector_t start, sector_t length);
+int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
+		sector_t length);
 int bdev_del_partition(struct block_device *bdev, int partno);
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
diff --git a/block/ioctl.c b/block/ioctl.c
index fff161eaab42..36e0ec76b3b2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -16,6 +16,7 @@
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	struct blkpg_partition p;
 	long long start, length;
 
@@ -40,7 +41,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 		/* check if partition is aligned to blocksize */
 		if (p.start & (bdev_logical_block_size(bdev) - 1))
 			return -EINVAL;
-		return bdev_add_partition(bdev, p.pno, start, length);
+		return bdev_add_partition(disk, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
 		return bdev_resize_partition(bdev, p.pno, start, length);
 	default:
diff --git a/block/partitions/core.c b/block/partitions/core.c
index c1b66d07ff19..af450931322d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -451,11 +451,10 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 	return overlap;
 }
 
-int bdev_add_partition(struct block_device *bdev, int partno,
-		sector_t start, sector_t length)
+int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
+		sector_t length)
 {
 	struct block_device *part;
-	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
 	mutex_lock(&disk->open_mutex);
-- 
2.30.2

