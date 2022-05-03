Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817FC518869
	for <lists+linux-efi@lfdr.de>; Tue,  3 May 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiECPZW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 May 2022 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiECPZV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 May 2022 11:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3017512741
        for <linux-efi@vger.kernel.org>; Tue,  3 May 2022 08:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EC46150B
        for <linux-efi@vger.kernel.org>; Tue,  3 May 2022 15:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA4FC385A4;
        Tue,  3 May 2022 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651591305;
        bh=ZX5pHkHkuszXZz+8FglbDWVGgeqZi4kRMvyqn233t6w=;
        h=From:To:Cc:Subject:Date:From;
        b=W05auiGolwxFV74Q3g5484s0SbqAI+1WkrSTW9LQSMY8aB66aaq1EXH1LnFHWBcjD
         SQhNpYCr6QLqgmYWmbqMuRkbkB5OomyQ49LU6ynTg0m4phwv177AgPas6bREAI0xnP
         FqOWE8U5PrMF8rrrFTKti0t93M6YnmS3Vo7ZIDFcGT1dgy6OCdp0eHrMQYkdaAhO0D
         zQuRiQsy/+qmqgWPMX2I58CVUsSSJ09aBVMAPZTb1Tpe5Xz3fu+RLSnZWlfXbum8RN
         o6BPQHRzP2qmd48MXmJMjOKlnD3SnHPlcHEcI9RZUNK7Qp45FOG96os1moZq4SjtxH
         4AqsujCWsjACQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mawupeng1@huawei.com,
        linux-mm@kvack.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: stub: prefer mirrored memory for randomized allocations
Date:   Tue,  3 May 2022 17:21:31 +0200
Message-Id: <20220503152131.263711-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; h=from:subject; bh=ZX5pHkHkuszXZz+8FglbDWVGgeqZi4kRMvyqn233t6w=; b=owEB7AET/pANAwAKAcNPIjmS2Y8kAcsmYgBicUh7d5MOcsSassJxkLQZE75KIQCw+sxwJAvz1+rg 5PZa3qyJAbIEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYnFIewAKCRDDTyI5ktmPJKvTC/ d0u1RExcmL4hQ6E0iqrZJm4s9lhqN+/oYIWCe2mXo/2UPw4KAbZx4zPtpUwM8Nlde5Kn3fotyx7p1h xxyZAqmZ74ry+I7myZ9hHjUTFz6g49Nt1yYf+ULxohuPYiQzPCxfCeyag0R60zr2JxKFUvSuS9ZPE9 gmuf9kSR5SBq4cHJkBLteo82LmldK2m70LO7hAdAx8N6poOJ1LvfvTI2C6b1gBwy1BSV10u6UIIQwy Y+w91gtYSUW9xd6TxiJpKbgBBHji1aUpCn4ycYmKqmqwxklt2mMN0Gl1WReQTOZO6jIWiFWgE5Lp2i wHdVWUcSxl44Un9/zSyhNDcx1cQgCGWxxCIIj02X6mheu2uC8CsjNnBXKzrED3WuhSwmyoMSqh9w10 OyUAgTtSZ8odSoY2MMWHKhsSA/HYkuhFcrknnVQ/cbTodHDXtktcLXe1DM3cu5dBiljIjL6aCbTuCi MYtm/M8oEk2DzeaSo3TTDjgsz+ywSjUpxnsOGbcclyIw==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the system exposes memory regions with the EFI_MORE_RELIABLE
attribute, it is implied that it is intended to be used for allocations
that are relatively important, such as the kernel's static image.

Since efi_random_alloc() is mostly (only) used for allocating space for
the kernel image, let's update it to take this into account, and
disregard all memory without the EFI_MORE_RELIABLE attribute if there is
sufficient memory available that does have this attribute.

Note that this change only affects booting with randomization enabled.
In other cases, the EFI stub runs the kernel image in place unless its
placement is unsuitable for some reason (i.e., misaligned, or its BSS
overlaps with another allocation), and it is left to the bootloader to
ensure that the kernel was loaded into EFI_MORE_RELIABLE memory if this
is desired.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 724155b9e10d..07a762910312 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -56,6 +56,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long random_seed)
 {
 	unsigned long map_size, desc_size, total_slots = 0, target_slot;
+	unsigned long total_mirrored_slots = 0;
 	unsigned long buff_size;
 	efi_status_t status;
 	efi_memory_desc_t *memory_map;
@@ -86,8 +87,14 @@ efi_status_t efi_random_alloc(unsigned long size,
 		slots = get_entry_num_slots(md, size, ilog2(align));
 		MD_NUM_SLOTS(md) = slots;
 		total_slots += slots;
+		if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
+			total_mirrored_slots += slots;
 	}
 
+	/* only consider mirrored slots for randomization if any exist */
+	if (total_mirrored_slots > 0)
+		total_slots = total_mirrored_slots;
+
 	/* find a random number between 0 and total_slots */
 	target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;
 
@@ -107,6 +114,10 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_physical_addr_t target;
 		unsigned long pages;
 
+		if (total_mirrored_slots > 0 &&
+		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
+			continue;
+
 		if (target_slot >= MD_NUM_SLOTS(md)) {
 			target_slot -= MD_NUM_SLOTS(md);
 			continue;
-- 
2.30.2

