Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5F656C5E
	for <lists+linux-efi@lfdr.de>; Tue, 27 Dec 2022 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiL0PSp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Dec 2022 10:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0PSn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Dec 2022 10:18:43 -0500
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 07:18:40 PST
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D447C2635;
        Tue, 27 Dec 2022 07:18:40 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3277:2370:7116:d41b:2bcc:5af4])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id 383653C04DC;
        Tue, 27 Dec 2022 23:10:16 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sai.praneeth.prakhya@intel.com, Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH] efi: fix userspace infinite retry read efivars after EFI runtime services page fault
Date:   Tue, 27 Dec 2022 23:09:36 +0800
Message-Id: <20221227150936.19242-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUlMVhgaHUwaSEpKHxlNQ1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTExBSUhMS0FMSkpNQR9PShlBSRkYGEFOGh1PWVdZFhoPEhUdFF
        lBWU9LSFVKSEpCSEtVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6Shw*ET0vTi0uOQxRAwkP
        GTMaCUhVSlVKTUxJSk5IQ0pNTEJKVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxMQUlITEtBTEpKTUEfT0oZQUkZGBhBThodT1lXWQgBWUFJSUhNNwY+
X-HM-Tid: 0a8554225d302eb0kusn383653c04dc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After [1][2], if we catch exceptions due to EFI runtime service, we will
clear EFI_RUNTIME_SERVICES bit to disable EFI runtime service, then the
subsequent routine which invoke the EFI runtime service should fail.

But the userspace cat efivars through /sys/firmware/efi/efivars/ will stuck
and infinite loop calling read() due to efivarfs_file_read() return -EINTR.

The -EINTR is converted from EFI_ABORTED by efi_status_to_err(), and is
an improper return value in this situation, so let virt_efi_xxx() return
EFI_DEVICE_ERROR and converted to -EIO to invoker.

[1]: commit 3425d934fc03 ("efi/x86: Handle page faults occurring while running EFI runtime services")
[2]: commit 23715a26c8d8 ("arm64: efi: Recover from synchronous exceptions occurring in firmware")

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/firmware/efi/runtime-wrappers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 7feee3d9c2bf..1fba4e09cdcf 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -62,6 +62,7 @@ struct efi_runtime_work efi_rts_work;
 									\
 	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
 		pr_warn_once("EFI Runtime Services are disabled!\n");	\
+		efi_rts_work.status = EFI_DEVICE_ERROR;			\
 		goto exit;						\
 	}								\
 									\
-- 
2.17.1

