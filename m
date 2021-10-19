Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F99432E09
	for <lists+linux-efi@lfdr.de>; Tue, 19 Oct 2021 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhJSGWr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Oct 2021 02:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGWq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Oct 2021 02:22:46 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6289C06161C;
        Mon, 18 Oct 2021 23:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5jnVxcYxSLSNyHRZhSAjgn6G56mHPGfAD/uLPfVYQy8=; b=CncSlbuLXsJcJbJatp6NgpmmH6
        IQpvucxwYnnOpeg9PSL7UnEZTwDdwl41DcdAfyUwXY093TERn7RmGbpxAF5hu7NrkAntI2E1zq/CZ
        V6Qs4JaGdCUsCzhsYNYHn9SJOnkEZ0XwPa05MtJD+1/c/juY3O0xoEWMMFiL9HGuOQKIGALV6zAFf
        RXUEnNs8T6FYfeOx0AObSUcpndjAJqpXVxsrHfXZI5gTRbUjXbnddE3KbBkVvCKKpgm2ZMUKzAnHt
        L54tZkTC0nwGoPwsvxqzb9SKYcVaxteATeodvF4ZUiQx541gGnVabkQK+V+NIGVv9uIXGNkqc+6Ee
        lt1WhQ/Q==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mciUC-000HLL-NQ; Tue, 19 Oct 2021 06:20:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 1/3] block/ioctl: use bdev_nr_sectors and bdev_nr_bytes
Date:   Tue, 19 Oct 2021 08:20:22 +0200
Message-Id: <20211019062024.2171074-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019062024.2171074-1-hch@lst.de>
References: <20211019062024.2171074-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 77b1b2453f395..d6af0ac97e57e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -132,7 +132,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	if (len & 511)
 		return -EINVAL;
 
-	if (start + len > i_size_read(bdev->bd_inode))
+	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
@@ -164,7 +164,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 	if (len & 511)
 		return -EINVAL;
-	if (end >= (uint64_t)i_size_read(bdev->bd_inode))
+	if (end >= (uint64_t)bdev_nr_bytes(bdev))
 		return -EINVAL;
 	if (end < start)
 		return -EINVAL;
@@ -543,7 +543,6 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	void __user *argp = (void __user *)arg;
 	fmode_t mode = file->f_mode;
-	loff_t size;
 	int ret;
 
 	/*
@@ -570,10 +569,9 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return put_long(argp,
 			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
-		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
+		if (bdev_nr_sectors(bdev) > ~0UL)
 			return -EFBIG;
-		return put_ulong(argp, size >> 9);
+		return put_ulong(argp, bdev_nr_sectors(bdev));
 
 	/* The data is compatible, but the command number is different */
 	case BLKBSZGET: /* get block device soft block size (cf. BLKSSZGET) */
@@ -581,7 +579,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKBSZSET:
 		return blkdev_bszset(bdev, mode, argp);
 	case BLKGETSIZE64:
-		return put_u64(argp, i_size_read(bdev->bd_inode));
+		return put_u64(argp, bdev_nr_bytes(bdev));
 
 	/* Incompatible alignment on i386 */
 	case BLKTRACESETUP:
@@ -615,7 +613,6 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	struct gendisk *disk = bdev->bd_disk;
 	fmode_t mode = file->f_mode;
-	loff_t size;
 
 	/*
 	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
@@ -641,10 +638,9 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return compat_put_long(argp,
 			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
-		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
+		if (bdev_nr_sectors(bdev) > ~0UL)
 			return -EFBIG;
-		return compat_put_ulong(argp, size >> 9);
+		return compat_put_ulong(argp, bdev_nr_sectors(bdev));
 
 	/* The data is compatible, but the command number is different */
 	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
@@ -652,7 +648,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKBSZSET_32:
 		return blkdev_bszset(bdev, mode, argp);
 	case BLKGETSIZE64_32:
-		return put_u64(argp, i_size_read(bdev->bd_inode));
+		return put_u64(argp, bdev_nr_bytes(bdev));
 
 	/* Incompatible alignment on i386 */
 	case BLKTRACESETUP32:
-- 
2.30.2

