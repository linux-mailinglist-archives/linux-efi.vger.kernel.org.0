Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA05E5F90
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiIVKNn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 06:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiIVKNa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 06:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94319DCCDF
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 03:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5973562AEF
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 10:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970AAC433D6;
        Thu, 22 Sep 2022 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663841590;
        bh=TYSVnwsNsGT3J0BJ8mtJuAk8W9omzdk1Jc2v5aQ0PNg=;
        h=From:To:Cc:Subject:Date:From;
        b=gggRTE/dTIx2i7cS7otlgYY5WRfePx/xruI3fF8T9Y0XOUsD3983HjPK29EvKLd/r
         Gtzb//MqMMimPsjgxGzbXPsuiTG8E+cjMGHlFUR9StdkuhaXhp1Urk1ntST9pGfLVc
         9I6AzoOLiuS044kDxYl2RqVfeAfiCGg7ZGfiR4xnOU5gTjWVeqWgImPP8jyq7qTSZF
         Re7C6KOvEDzCJyb8/XW6FkOKJ92Jm6B/2FUUHWPETZNnEzgiT/IEX8wTcefBVBbh/x
         sEQYR08Q6BPeg/+P6MiNBt/EgFhoMADB7rvPkzouUAWatDpGV9OLe4RoJMUAL+XSuY
         t996UuybuCcZQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Daan De Meyer <daandemeyer@fb.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] efi: zboot: create MemoryMapped() device path for the parent if needed
Date:   Thu, 22 Sep 2022 12:12:58 +0200
Message-Id: <20220922101258.1010763-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=ardb@kernel.org; h=from:subject; bh=TYSVnwsNsGT3J0BJ8mtJuAk8W9omzdk1Jc2v5aQ0PNg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjLDUpr7ezJQ29Z9nYMrGzSexe8Z5OSqMFTzugBiga BB/iuXSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyw1KQAKCRDDTyI5ktmPJJulC/ 91c2I9Brjax+3+EVgljmSFUw+pS3jcJypCWrDxC/HrgKv7Z6FsZen+Ng5mWg9VkEUgKgXVLXUut1vt hVrb/WhOo2Y39/JUwduevJ35nklzBS9oC0Gh8SxFT+/TMDXMJYj6gL40w4gctK17kwKdKEZiQIiXIK /Fn05D9B33IE/udTdInHlpkJyYR2zBLpQ5WPlJXWAPZJqC6EBdtUSH5DP6zDUoopENHl5n1q3jTgqa YPVam5GWFKFsqGbYiYGpqlr+6i8uudSSpCMFz7MU3IzceHsk6/0Dyc1hNXCqc7y5rMzR/GwYnFQIRN DCportMF1oGY+az+V0y8PDVvgm/jKSChSXOQBBHNfGMNhGSVNrt3sxcZzEl67Tvg+S/GjmhlCs06dX LbNevohCz06hATmIcFI4Y84iTqgLRW26u6081DrHKqsUWIETokf/8Qps4odzPsLvQ5WzdIuvq6SrJJ rwa8BOc0ZM20LajnQ/bz6CqjKLKOo+CZ4MU8Wy2s3W0fM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

LoadImage() is supposed to install an instance of the protocol
EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL onto the loaded image's handle so
that the program can figure out where it was loaded from. The reference
implementation even does this (with a NULL protocol pointer) if the call
to LoadImage() used the source buffer and size arguments, and passed
NULL for the image device path. Hand rolled implementations of LoadImage
may behave differently, though, and so it is better to tolerate
situations where the protocol is missing. And actually, concatenating an
Offset() node to a NULL device path (as we do currently) is also not
great either.

So in cases where the protocol is absent, or when it points to NULL,
construct a MemoryMapped() device node as the base node that describes
the parent image's footprint in memory.

Cc: Daan De Meyer <daandemeyer@fb.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/zboot.c | 20 ++++++++++++++++----
 include/linux/efi.h                  |  7 +++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index a9f41902c908..d65bf942dcd0 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -162,6 +162,11 @@ static void append_end_node(efi_device_path_protocol_t **dp)
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
+	struct efi_mem_mapped_dev_path mmdp = {
+		.header.type		= EFI_DEV_HW,
+		.header.sub_type	= EFI_DEV_MEM_MAPPED,
+		.header.length		= sizeof(struct efi_mem_mapped_dev_path),
+	};
 	efi_device_path_protocol_t *parent_dp, *dpp, *lf2_dp, *li_dp;
 	efi_load_file2_protocol_t zboot_load_file2;
 	efi_loaded_image_t *parent, *child;
@@ -191,13 +196,20 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	status = efi_bs_call(handle_protocol, handle,
 			     &LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
 			     (void **)&parent_dp);
-	if (status != EFI_SUCCESS) {
-		log(L"Failed to locate parent's loaded image device path protocol");
-		return status;
+	if (status != EFI_SUCCESS || parent_dp == NULL) {
+		// Create a MemoryMapped() device path node to describe
+		// the parent image if no device path was provided.
+		mmdp.memory_type	= parent->image_code_type;
+		mmdp.starting_addr	= (unsigned long)parent->image_base;
+		mmdp.ending_addr	= (unsigned long)parent->image_base +
+					  parent->image_size - 1;
+		parent_dp = &mmdp.header;
+		dp_len = sizeof(mmdp);
+	} else {
+		dp_len = device_path_length(parent_dp);
 	}
 
 	// Allocate some pool memory for device path protocol data
-	dp_len = parent_dp ? device_path_length(parent_dp) : 0;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
 			     2 * (dp_len + sizeof(struct efi_rel_offset_dev_path) +
 			          sizeof(struct efi_generic_dev_path)) +
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 89f16ec3ebab..da3974bf05d3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1004,6 +1004,13 @@ struct efi_rel_offset_dev_path {
 	u64				ending_offset;
 } __packed;
 
+struct efi_mem_mapped_dev_path {
+	struct efi_generic_dev_path	header;
+	u32				memory_type;
+	u64				starting_addr;
+	u64				ending_addr;
+} __packed;
+
 struct efi_dev_path {
 	union {
 		struct efi_generic_dev_path	header;
-- 
2.35.1

