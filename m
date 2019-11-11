Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF89F6DC3
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 06:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKKFNo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 00:13:44 -0500
Received: from foss.arm.com ([217.140.110.172]:40490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfKKFNo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 11 Nov 2019 00:13:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D890531B;
        Sun, 10 Nov 2019 21:13:43 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F7D93F6C4;
        Sun, 10 Nov 2019 21:13:39 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] efi: Fix comment for efi_mem_type() wrt absent physical addresses
Date:   Mon, 11 Nov 2019 10:43:49 +0530
Message-Id: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
error rather than 0") changed the return type from EFI_RESERVED_TYPE to
-EINVAL when the searched physical address is not present in any memory
descriptor. But the comment preceding the function never changed. Lets
change the comment now to reflect the new return type -EINVAL.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Changed comment for efi_mem_type() instead of the return type per Ard

V1: (https://lore.kernel.org/patchwork/patch/1149002/)

 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 77ca52d86e30..47b0bf7a2b7f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -899,7 +899,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
  *
  * Search in the EFI memory map for the region covering @phys_addr.
  * Returns the EFI memory type if the region was found in the memory
- * map, EFI_RESERVED_TYPE (zero) otherwise.
+ * map, -EINVAL otherwise.
  */
 int efi_mem_type(unsigned long phys_addr)
 {
-- 
2.20.1

