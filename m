Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729B7432E0D
	for <lists+linux-efi@lfdr.de>; Tue, 19 Oct 2021 08:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhJSGWv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Oct 2021 02:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGWv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Oct 2021 02:22:51 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8077C06161C;
        Mon, 18 Oct 2021 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cVRlbj/aDA1df+OnX5tR2NCB09gURSE+BHC2YmDSVXA=; b=J2Ic+e1V8Ze7phbDF+s/ZkAW2H
        A3M9DiQW4xrNPNCYxhHfKt0lOb679+CGe5vDYwnZ7NXkTzeaIlmaL8tSAFEY1UraQl626lI2imJxQ
        KFRZt+Q1jsKtm7jchnKPFEbr01ViLbc8AqjsrM0VouMRy3gkiLu3H9CJa7V5ZCWBeqkJTVjTHUhh7
        2Ws9lTFdgAatx8ThbnlkvpcLMp0Dey/q7fLun6EhdQbxMDDccBu121NngQ3CBFNWQQymSdedgnBzT
        JJZYKMHJNZF5KLuBcsaCdUZpg62sExcKQ3WnTOYt6hmCKgiTDwBpNzOw/G+jgep85R05vOM3Bsuil
        BZRyDPEg==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mciUG-000HLb-N6; Tue, 19 Oct 2021 06:20:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/3] partitions/efi: use bdev_nr_bytes instead of open coding it
Date:   Tue, 19 Oct 2021 08:20:23 +0200
Message-Id: <20211019062024.2171074-3-hch@lst.de>
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
 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 7ca5c4c374d4d..5e9be13a56a82 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -133,7 +133,7 @@ efi_crc32(const void *buf, unsigned long len)
  */
 static u64 last_lba(struct gendisk *disk)
 {
-	return div_u64(disk->part0->bd_inode->i_size,
+	return div_u64(bdev_nr_bytes(disk->part0),
 		       queue_logical_block_size(disk->queue)) - 1ULL;
 }
 
-- 
2.30.2

