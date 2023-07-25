Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C017761ADE
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jul 2023 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGYOEC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jul 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGYOEA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jul 2023 10:04:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3991FCC;
        Tue, 25 Jul 2023 07:03:59 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9JZx2Y8qztRlW;
        Tue, 25 Jul 2023 22:00:41 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 22:03:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ardb@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] efi: Remove unused extern declaration efi_lookup_mapped_addr()
Date:   Tue, 25 Jul 2023 22:03:27 +0800
Message-ID: <20230725140327.24960-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit 50a0cb565246 ("x86/efi-bgrt: Fix kernel panic when mapping BGRT data")
this extern declaration is not used anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/efi.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index c31a9895ecb8..d4ec0d9c896f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -727,7 +727,6 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 	return EFI_SUCCESS;
 }
 #endif
-extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
 extern int __init __efi_memmap_init(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
-- 
2.34.1

