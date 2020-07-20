Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1782822584F
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jul 2020 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGTHUx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jul 2020 03:20:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTHUw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 20 Jul 2020 03:20:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 921756D60384099ACE38;
        Mon, 20 Jul 2020 15:20:47 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 15:20:41 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <ardb@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
Subject: [PATCH] efi: add missed destroy_workqueue when efisubsys_init fails
Date:   Mon, 20 Jul 2020 15:22:18 +0800
Message-ID: <1595229738-10087-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

destroy_workqueue() should be called to destroy efi_rts_wq
when efisubsys_init() init resources fails.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5114cae..f8cce41 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -379,6 +379,7 @@ static int __init efisubsys_init(void)
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
 		pr_err("efi: Firmware registration failed.\n");
+		destroy_workqueue(efi_rts_wq);
 		return -ENOMEM;
 	}
 
@@ -420,6 +421,7 @@ static int __init efisubsys_init(void)
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
+	destroy_workqueue(efi_rts_wq);
 	return error;
 }
 
-- 
2.7.4

