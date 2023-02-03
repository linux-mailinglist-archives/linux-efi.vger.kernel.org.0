Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D67689B46
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjBCOOC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 09:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBCON3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 09:13:29 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DB1024B;
        Fri,  3 Feb 2023 06:12:55 -0800 (PST)
Received: from localhost.179.lan (unknown [94.29.124.73])
        by mail.ispras.ru (Postfix) with ESMTPSA id 9AEA540737BC;
        Fri,  3 Feb 2023 14:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9AEA540737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675433573;
        bh=fmtJBEhqbrQnl44SbeJjGLinHNhS7H1mBHfFyaqD6rk=;
        h=From:To:Cc:Subject:Date:From;
        b=TEcBQP+7Kit33vGhpoDmcFGlCBxiAKrHhjP7MdFcsz23tvIZ3S6HlDv98zLLPl4O+
         p/41e71xzAt9g3yck4w0kEf5qcG+AoHshZoZGidM/FpHwWsQ8Hi4qaJLUjlup1Bu8S
         wrxAT37NR8bpZ4ESNGVVrQMMa7GcsP3DBWFZc134=
From:   Anton Gusev <aagusev@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anton Gusev <aagusev@ispras.ru>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH v2] efi: fix potential NULL deref in efi_mem_reserve_persistent
Date:   Fri,  3 Feb 2023 17:11:36 +0300
Message-Id: <20230203141136.14881-1-aagusev@ispras.ru>
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

This patch adds a check that returns -ENOMEM if it's NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 18df7577adae ("efi/memreserve: deal with memreserve entries in unmapped memory")
Signed-off-by: Anton Gusev <aagusev@ispras.ru>
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a2b0cbc8741c..1e0b016fdc2b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1007,6 +1007,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	/* first try to find a slot in an existing linked list entry */
 	for (prsv = efi_memreserve_root->next; prsv; ) {
 		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
+		if (!rsv)
+			return -ENOMEM;
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
-- 
2.39.1

