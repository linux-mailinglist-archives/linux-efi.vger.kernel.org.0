Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93577E951
	for <lists+linux-efi@lfdr.de>; Wed, 16 Aug 2023 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjHPTG2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Aug 2023 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbjHPTGH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Aug 2023 15:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAC2705
        for <linux-efi@vger.kernel.org>; Wed, 16 Aug 2023 12:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944DF60BC0
        for <linux-efi@vger.kernel.org>; Wed, 16 Aug 2023 19:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD6CC433C8;
        Wed, 16 Aug 2023 19:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692212765;
        bh=41DcKeuHq9CESc1uBJ7MBgQE6TZonKhrfc5VQ/FnqfY=;
        h=From:To:Cc:Subject:Date:From;
        b=cAZVshrG2lsFWuJSSqH5fs/GYvO7S7JUlf00cKb7AcmMDTEd2YuowMxtj8G0sB4s9
         NE64DKZl3Iy+zHCkJkNFrZJrwMdbk09ppheK/GgzZfd8d2mf4MY6u4BT+KcjFZzcsQ
         Qd33dZd58v+I00GDXBpsQHDIny0A1PSGFf0RFbPW7JC8VNHOwbMht6R213pI1cycVL
         AEgy+HaJ4HiayyyEtBUgfdqq62gSrlaFoKco5FyPWg2wvGV1u3sG8h5rUL5j9Cv+Xz
         SWcBFmG70LQycaHYqbrznTER6Wg4fB8fFQboSzOImc1AeMG5VZvfEV4R2KDsCaqERC
         j98LhuqQ6ogCw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table
Date:   Wed, 16 Aug 2023 21:05:57 +0200
Message-Id: <20230816190557.3738-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=ardb@kernel.org; h=from:subject; bh=41DcKeuHq9CESc1uBJ7MBgQE6TZonKhrfc5VQ/FnqfY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWunOiS0n/qMXa9ySvtH856+a9UjffdzvjZav6HS1/F7 xNOS3rVUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyPZfhn2GmvRADT5+qyr/b /neYi64YX2ve7Wthwlb+8eTG3iD9Oob/YUxOG+SFGiJ8pJdvzz0nuf2mfiHrBZflGW2zN06sNDJ gBgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Kyril reports that crashkernels fail to work on confidential VMs that
rely on the unaccepted memory table, and this appears to be caused by
the fact that it is not considered part of the set of firmware tables
that the crashkernel needs to map.

This is an oversight, and a result of the use of the EFI_LOADER_DATA
memory type for this table. The correct memory type to use for any
firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
EFI stub), even though the name suggests that is it specific to ACPI.
ACPI reclaim means that the memory is used by the firmware to expose
information to the operating system, but that the memory region has no
special significance to the firmware itself, and the OS is free to
reclaim the memory and use it as ordinary memory if it is not interested
in the contents, or if it has already consumed them. In Linux, this
memory is never reclaimed, but it is always covered by the kernel direct
map and generally made accessible as ordinary memory.

On x86, ACPI reclaim memory is translated into E820_ACPI, which the
kexec logic already recognizes as memory that the crashkernel may need
to to access, and so it will be mapped and accessible to the booting
crash kernel.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index ca61f4733ea58693..9a655f30ba47db01 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
 				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
 
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
 			     sizeof(*unaccepted_table) + bitmap_size,
 			     (void **)&unaccepted_table);
 	if (status != EFI_SUCCESS) {
-- 
2.39.2

