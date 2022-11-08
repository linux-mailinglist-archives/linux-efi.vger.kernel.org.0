Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269AC620700
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiKHCya (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 21:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHCy3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 21:54:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D51B9C6
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 18:54:27 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5t3V6q07z15MSf;
        Tue,  8 Nov 2022 10:54:14 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:54:25 +0800
From:   Jialin Zhang <zhangjialin11@huawei.com>
To:     <ardb@kernel.org>, <ilias.apalodimas@linaro.org>
CC:     <linux-efi@vger.kernel.org>
Subject: [PATCH] efi: libstub: fix efi_load_initrd_dev_path() kernel-doc comment
Date:   Tue, 8 Nov 2022 10:53:10 +0800
Message-ID: <20221108025310.1393687-1-zhangjialin11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500021.china.huawei.com (7.185.36.109)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

commit f4dc7fffa987 ("efi: libstub: unify initrd loading between
architectures") merge the first and the second parameters into a
struct without updating the kernel-doc. Let's fix it.

Fixes: f4dc7fffa987 ("efi: libstub: unify initrd loading between architectures")
Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 0c493521b25b..1a42dedcce3c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -626,8 +626,8 @@ static const struct {
 
 /**
  * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
- * @load_addr:	pointer to store the address where the initrd was loaded
- * @load_size:	pointer to store the size of the loaded initrd
+ * @initrd:	pointer of struct to store the address where the initrd was loaded
+ *		and the size of the loaded initrd
  * @max:	upper limit for the initrd memory allocation
  *
  * Return:
-- 
2.25.1

