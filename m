Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF25622009
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 00:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKHXGK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 18:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKHXGK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 18:06:10 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E463159;
        Tue,  8 Nov 2022 15:06:09 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1osXfK-0005wb-6u; Wed, 09 Nov 2022 00:05:58 +0100
Date:   Tue, 8 Nov 2022 23:04:35 +0000
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
Subject: [PATCH v4 5/5] mtd: ubi: block: add option to enable scanning for
 partitions
Message-ID: <Y2rgg6h22N6PfKNM@makrotopia.org>
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

Add Kconfig option CONFIG_MTD_UBI_BLOCK_PARTITIONS and enable block
partition parsers on ubiblock devices in case it is selected.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/Kconfig | 10 ++++++++++
 drivers/mtd/ubi/block.c |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 2ed77b7b3fcb..491330e42ab2 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -104,4 +104,14 @@ config MTD_UBI_BLOCK
 
 	   If in doubt, say "N".
 
+config MTD_UBI_BLOCK_PARTITIONS
+	bool "Scan UBI block devices for partitions"
+	default y if FIT_PARTITION
+	depends on MTD_UBI_BLOCK
+	help
+	  Scan UBI block devices for partitions (ie. MBR, GPT, uImage.FIT, ...).
+
+	  Unless your UBI volumes contain sub-partitions mapped using a partition
+	  table, say no.
+
 endif # MTD_UBI
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 75eaecc8639f..d9baa99ca093 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -430,7 +430,10 @@ int ubiblock_create(struct ubi_volume_info *vi)
 		ret = -ENODEV;
 		goto out_cleanup_disk;
 	}
-	gd->flags |= GENHD_FL_NO_PART;
+
+	if (!IS_ENABLED(CONFIG_MTD_UBI_BLOCK_PARTITIONS))
+		gd->flags |= GENHD_FL_NO_PART;
+
 	gd->private_data = dev;
 	sprintf(gd->disk_name, "ubiblock%d_%d", dev->ubi_num, dev->vol_id);
 	set_capacity(gd, disk_capacity);
-- 
2.38.1

