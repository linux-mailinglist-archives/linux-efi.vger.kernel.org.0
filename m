Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51073271912
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIUB5k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Sep 2020 21:57:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbgIUB5k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 20 Sep 2020 21:57:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D5E38B385E5EBCB57BF2;
        Mon, 21 Sep 2020 09:55:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 09:55:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ardb@kernel.org>, <linux-efi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] efi/libstub: Fix missing-prototypes in string.c
Date:   Mon, 21 Sep 2020 09:53:23 +0800
Message-ID: <1600653203-57909-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix the following warnings.
drivers/firmware/efi/libstub/string.c:83:20: warning: no previous
prototype for ‘simple_strtoull’ [-Wmissing-prototypes]
drivers/firmware/efi/libstub/string.c:108:6: warning: no previous
prototype for ‘simple_strtol’ [-Wmissing-prototypes]

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/firmware/efi/libstub/string.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index 1ac2f87..5d13e43 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
-- 
2.7.4

