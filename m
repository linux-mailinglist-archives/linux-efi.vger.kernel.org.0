Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214328858E
	for <lists+linux-efi@lfdr.de>; Fri,  9 Oct 2020 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgJIIvV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Oct 2020 04:51:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730726AbgJIIvV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Oct 2020 04:51:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E0C5FED773E5BDD649E;
        Fri,  9 Oct 2020 16:51:19 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 9 Oct 2020 16:51:09 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH] efi:mokvar-table: fix build error
Date:   Fri, 9 Oct 2020 16:51:06 +0800
Message-ID: <20201009085106.125079-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

drivers/firmware/efi/mokvar-table.c:139:5: error: implicit declaration of
 function 'early_memunmap'; did you mean 'devm_memunmap'?
 [-Werror=implicit-function-declaration]
drivers/firmware/efi/mokvar-table.c:148:9: error: implicit declaration of
 function 'early_memremap'; did you mean 'devm_memremap'?
 [-Werror=implicit-function-declaration]

add #include <asm/early_ioremap.h> to fix this build error

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/firmware/efi/mokvar-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 72a9e1736fef..c23d3686f1c7 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -39,6 +39,7 @@
 #include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <asm/early_ioremap.h>
 
 /*
  * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table is a packed
-- 
2.27.0

