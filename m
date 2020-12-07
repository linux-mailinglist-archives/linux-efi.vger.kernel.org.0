Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840CF2D181F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgLGSDI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 13:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgLGSDI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Dec 2020 13:03:08 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Subject: [PATCH 1/2] efi: capsule: use atomic kmap for transient sglist mappings
Date:   Mon,  7 Dec 2020 19:02:16 +0100
Message-Id: <20201207180216.3349-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207180216.3349-1-ardb@kernel.org>
References: <20201207180216.3349-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Don't use the heavy-weight kmap() API to create short-lived mappings
of the scatter-gather list entries that are released as soon as the
entries are written. Instead, use kmap_atomic(), which is more suited
to this purpose.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/capsule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/capsule.c b/drivers/firmware/efi/capsule.c
index 598b7800d14e..43f6fe7bfe80 100644
--- a/drivers/firmware/efi/capsule.c
+++ b/drivers/firmware/efi/capsule.c
@@ -244,7 +244,7 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 	for (i = 0; i < sg_count; i++) {
 		efi_capsule_block_desc_t *sglist;
 
-		sglist = kmap(sg_pages[i]);
+		sglist = kmap_atomic(sg_pages[i]);
 
 		for (j = 0; j < SGLIST_PER_PAGE && count > 0; j++) {
 			u64 sz = min_t(u64, imagesize,
@@ -265,7 +265,7 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 		else
 			sglist[j].data = page_to_phys(sg_pages[i + 1]);
 
-		kunmap(sg_pages[i]);
+		kunmap_atomic(sglist);
 	}
 
 	mutex_lock(&capsule_mutex);
-- 
2.17.1

