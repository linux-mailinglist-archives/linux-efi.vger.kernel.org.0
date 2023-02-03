Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498586899A3
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBCNXA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 08:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCNW7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 08:22:59 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088D8B7FC;
        Fri,  3 Feb 2023 05:22:54 -0800 (PST)
Received: from localhost.localdomain (unknown [91.193.176.190])
        by mail.ispras.ru (Postfix) with ESMTPSA id 584D140755C7;
        Fri,  3 Feb 2023 13:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 584D140755C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675430572;
        bh=/mqhUR6IYx88WP+hi34PVWHFd7gTVLUoKCSdY6SQTq8=;
        h=From:To:Cc:Subject:Date:From;
        b=dYNR8/UxoBVusxbvHEZSi4mOvOFpfigueLHO/82MWEBGbuXWT6Va/MzJIDpSxOTgg
         MyPSWLb/zX8WLYZgg3xgJatTGCDl4NsxYcQqp8GD7dw+NXVBNskm4rE9IueYevM7W8
         gZaktnxTPFsLh5XG5o+DgibjSsnMMmMXv35RQg14=
From:   Anton Gusev <aagusev@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anton Gusev <aagusev@ispras.ru>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] efi: fix potential NULL deref in efi_mem_reserve_persistent
Date:   Fri,  3 Feb 2023 16:22:13 +0300
Message-Id: <20230203132213.11758-1-aagusev@ispras.ru>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When iterating on a linked list, a result of memremap is dereferenced
without checking it for NULL.

This patch adds a check that falls back on allocating a new page in
case memremap doesn't succeed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 18df7577adae ("efi/memreserve: deal with memreserve entries in unmapped memory")
Signed-off-by: Anton Gusev <aagusev@ispras.ru>
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a2b0cbc8741c..48d30c806d94 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1007,6 +1007,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	/* first try to find a slot in an existing linked list entry */
 	for (prsv = efi_memreserve_root->next; prsv; ) {
 		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
+		if (!rsv)
+			break;
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
-- 
2.39.1

