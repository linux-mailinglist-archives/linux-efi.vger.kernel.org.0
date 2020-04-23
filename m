Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BED1B5AFC
	for <lists+linux-efi@lfdr.de>; Thu, 23 Apr 2020 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgDWMCX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Apr 2020 08:02:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgDWMCW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Apr 2020 08:02:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74FED95CD6BA08DDF2DF;
        Thu, 23 Apr 2020 20:02:21 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 20:02:14 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <ardb@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] efi/libstub/arm: Make install_memreserve_table static
Date:   Thu, 23 Apr 2020 20:08:33 +0800
Message-ID: <1587643713-28169-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix the following sparse warning:

drivers/firmware/efi/libstub/arm-stub.c:68:6: warning:
symbol 'install_memreserve_table' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/firmware/efi/libstub/arm-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 99a5cde..8a26cc1 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -65,7 +65,7 @@ static struct screen_info *setup_graphics(void)
 	return si;
 }
 
-void install_memreserve_table(void)
+static void install_memreserve_table(void)
 {
 	struct linux_efi_memreserve *rsv;
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
-- 
2.6.2

