Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1403E7CC3
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhHJPuc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhHJPub (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Aug 2021 11:50:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975EC0613C1;
        Tue, 10 Aug 2021 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ucVRByIrD+SeMuRdpyzbI33hXitcQChEIrjKgqdl5j0=; b=dZlqGpvGTuDDU3Qi9OUosHkE/n
        14reCvJuq8o0cZMtIDrF08aBLrpGqrBqBIhielCGsrOEQKp6zl7g0bmTY+968nTon+/HdTobFVHp5
        imaVaspjkR2Alavk4VJqhxNLcO4fo1oplNhJy6DVKLDJ81IEY4fa4NjQSR9M9Dxlly0GWIkUALllg
        5gl2/iaYuaVS+hbhaYrEyd5m6pimA+KPqTAJJ7odHSTTRaiFtZ/aYcT6I3Llxmsojpdd0rIlUfDNY
        4YqTmQfK8A8jxzkKLlmnaVP2Pr071Zz95OxkHGZhvnQ17e1lYUjpZFQEcnh4GHNb/HUP12ck8UHkZ
        8y2EwwWQ==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDTzE-00CIiy-5f; Tue, 10 Aug 2021 15:48:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/4] block: pass a gendisk to bdev_del_partition
Date:   Tue, 10 Aug 2021 17:45:11 +0200
Message-Id: <20210810154512.1809898-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810154512.1809898-1-hch@lst.de>
References: <20210810154512.1809898-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

bdev_del_partition can only operate on the whole device.  Make that clear
by passing a gendisk instead of a block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             | 2 +-
 block/ioctl.c           | 2 +-
 block/partitions/core.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index c0486f609978..21c441eb6773 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -349,7 +349,7 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_WHOLEDISK	2
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
-int bdev_del_partition(struct block_device *bdev, int partno);
+int bdev_del_partition(struct gendisk *disk, int partno);
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 36e0ec76b3b2..8f57b276b2f1 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -31,7 +31,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 		return -EINVAL;
 
 	if (op == BLKPG_DEL_PARTITION)
-		return bdev_del_partition(bdev, p.pno);
+		return bdev_del_partition(disk, p.pno);
 
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index af450931322d..679bbe82a227 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -476,13 +476,13 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	return ret;
 }
 
-int bdev_del_partition(struct block_device *bdev, int partno)
+int bdev_del_partition(struct gendisk *disk, int partno)
 {
 	struct block_device *part = NULL;
 	int ret = -ENXIO;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	part = xa_load(&bdev->bd_disk->part_tbl, partno);
+	mutex_lock(&disk->open_mutex);
+	part = xa_load(&disk->part_tbl, partno);
 	if (!part)
 		goto out_unlock;
 
@@ -493,7 +493,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	delete_partition(part);
 	ret = 0;
 out_unlock:
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 
-- 
2.30.2

