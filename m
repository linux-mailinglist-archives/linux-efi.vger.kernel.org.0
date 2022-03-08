Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1514D1AD8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Mar 2022 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347547AbiCHOmh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Mar 2022 09:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347624AbiCHOmg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Mar 2022 09:42:36 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C33FBE8;
        Tue,  8 Mar 2022 06:41:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V6f6D8d_1646750484;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V6f6D8d_1646750484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 22:41:30 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     bp@alien8.de, rric@kernel.org
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v7 3/3] efi/cper: reformat CPER memory error location to more readable
Date:   Tue,  8 Mar 2022 22:40:53 +0800
Message-Id: <20220308144053.49090-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove the 'space' delimiter after the colon in cper_mem_err_location() so
that it would be easier to parse this way - both by humans and tools.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/firmware/efi/cper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 215c778fb33c..e4e5ea7ce910 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -247,45 +247,45 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	n = 0;
 	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
-		n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
+		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
-		n += scnprintf(msg + n, len - n, "card: %d ", mem->card);
+		n += scnprintf(msg + n, len - n, "card:%d ", mem->card);
 	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
-		n += scnprintf(msg + n, len - n, "module: %d ", mem->module);
+		n += scnprintf(msg + n, len - n, "module:%d ", mem->module);
 	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
-		n += scnprintf(msg + n, len - n, "rank: %d ", mem->rank);
+		n += scnprintf(msg + n, len - n, "rank:%d ", mem->rank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK)
-		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
+		n += scnprintf(msg + n, len - n, "bank:%d ", mem->bank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK_GROUP)
-		n += scnprintf(msg + n, len - n, "bank_group: %d ",
+		n += scnprintf(msg + n, len - n, "bank_group:%d ",
 			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
-		n += scnprintf(msg + n, len - n, "bank_address: %d ",
+		n += scnprintf(msg + n, len - n, "bank_address:%d ",
 			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
-		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
+		n += scnprintf(msg + n, len - n, "device:%d ", mem->device);
 	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
 		u32 row = mem->row;
 
 		row |= cper_get_mem_extension(mem->validation_bits, mem->extended);
-		n += scnprintf(msg + n, len - n, "row: %d ", row);
+		n += scnprintf(msg + n, len - n, "row:%d ", row);
 	}
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
-		n += scnprintf(msg + n, len - n, "column: %d ", mem->column);
+		n += scnprintf(msg + n, len - n, "column:%d ", mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
-		n += scnprintf(msg + n, len - n, "bit_position: %d ",
+		n += scnprintf(msg + n, len - n, "bit_position:%d ",
 			       mem->bit_pos);
 	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
-		n += scnprintf(msg + n, len - n, "requestor_id: 0x%016llx ",
+		n += scnprintf(msg + n, len - n, "requestor_id:0x%016llx ",
 			       mem->requestor_id);
 	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
-		n += scnprintf(msg + n, len - n, "responder_id: 0x%016llx ",
+		n += scnprintf(msg + n, len - n, "responder_id:0x%016llx ",
 			       mem->responder_id);
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		n += scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
+		n += scnprintf(msg + n, len - n, "target_id:0x%016llx ",
 			       mem->target_id);
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		n += scnprintf(msg + n, len - n, "chip_id: %d ",
+		n += scnprintf(msg + n, len - n, "chip_id:%d ",
 			       mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
 	return n;
-- 
2.20.1.12.g72788fdb

