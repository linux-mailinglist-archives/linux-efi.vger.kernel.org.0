Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEC51FA5E
	for <lists+linux-efi@lfdr.de>; Mon,  9 May 2022 12:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiEIKvl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 May 2022 06:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEIKvi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 May 2022 06:51:38 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABAE91558;
        Mon,  9 May 2022 03:47:43 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1no0vV-0000G9-Tu; Mon, 09 May 2022 12:47:42 +0200
Date:   Mon, 9 May 2022 11:47:36 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/5] block: add new flag to add partitions read-only
Message-ID: <YnjxSFgvgtPq5oAb@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add flag ADDPART_FLAG_READONLY to allow partition parsers marking a
partition to be set read-only.
This is needed for the uImage.FIT partition parser added by a follow-up
commit: we need to be sure the contents of uImage.FIT sub-images
remain unaltered they are validated using a hash within the uImage.FIT
structure which also serves as partition table.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/blk.h             | 1 +
 block/partitions/core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 434017701403fb..c20592fe9bed4b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -404,6 +404,7 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
+#define ADDPART_FLAG_READONLY	4
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 int bdev_del_partition(struct gendisk *disk, int partno);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8a0ec929023bcd..3e70860beb655e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -399,6 +399,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
+	if (flags & ADDPART_FLAG_READONLY)
+		bdev->bd_read_only = true;
+
 	/* everything is up and running, commence */
 	err = xa_insert(&disk->part_tbl, partno, bdev, GFP_KERNEL);
 	if (err)
-- 
2.36.0

