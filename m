Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF197622006
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 00:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKHXFz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 18:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKHXFs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 18:05:48 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CF657D9;
        Tue,  8 Nov 2022 15:05:47 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1osXex-0005vp-Nv; Wed, 09 Nov 2022 00:05:35 +0100
Date:   Tue, 8 Nov 2022 23:04:13 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 4/5] mtd_blkdevs: add option to enable scanning for
 partitions
Message-ID: <Y2rgbfpYfpbLKHaf@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add Kconfig boolean CONFIG_MTD_BLOCK_PARTITIONS and enable block
partition parsers on non-NAND mtdblock devices in case it is selected.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/Kconfig       | 11 +++++++++++
 drivers/mtd/mtd_blkdevs.c |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 796a2eccbef0..12874dec1569 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -69,6 +69,17 @@ config MTD_BLOCK_RO
 	  You do not need this option for use with the DiskOnChip devices. For
 	  those, enable NFTL support (CONFIG_NFTL) instead.
 
+config MTD_BLOCK_PARTITIONS
+	bool "Scan for partitions on MTD block devices"
+	depends on MTD_BLOCK || MTD_BLOCK_RO
+	default y if FIT_PARTITION
+	help
+	  Scan MTD block devices for partitions (ie. MBR, GPT, uImage.FIT, ...).
+	  (NAND devices are omitted, ubiblock should be used instead when)
+
+	  Unless your MTD partitions contain sub-partitions mapped using a
+	  partition table, say no.
+
 comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK."
 	depends on MTD_BLOCK || MTD_BLOCK_RO
 
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 60b222799871..e6f2e0888246 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	} else {
 		snprintf(gd->disk_name, sizeof(gd->disk_name),
 			 "%s%d", tr->name, new->devnum);
-		gd->flags |= GENHD_FL_NO_PART;
+
+		if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS) || mtd_type_is_nand(new->mtd))
+			gd->flags |= GENHD_FL_NO_PART;
 	}
 
 	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
-- 
2.38.1

