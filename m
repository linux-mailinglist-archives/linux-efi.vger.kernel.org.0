Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFABE5255EC
	for <lists+linux-efi@lfdr.de>; Thu, 12 May 2022 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358150AbiELTj6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 May 2022 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358151AbiELTj5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 May 2022 15:39:57 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4312689FB;
        Thu, 12 May 2022 12:39:54 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1npEfA-0004wY-E8; Thu, 12 May 2022 21:39:52 +0200
Date:   Thu, 12 May 2022 20:39:46 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 5/5] mtd: ubi: block: add option to enable scanning for
 partitions
Message-ID: <Yn1igrfT/yUipBUs@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 2ed77b7b3fcb56..491330e42ab201 100644
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
index a78fdf3b30f7e6..8b26e38f082ce4 100644
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
2.36.0

