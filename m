Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BB4532136
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 04:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiEXCre (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 May 2022 22:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiEXCrd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 May 2022 22:47:33 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA0369F1;
        Mon, 23 May 2022 19:47:30 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 May
 2022 10:47:30 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 24 May
 2022 10:47:28 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] LoongArch: Fix unsigned function returning negative constant
Date:   Tue, 24 May 2022 10:47:25 +0800
Message-ID: <1653360446-15598-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The function set_virtual_map has an unsigned return type, but returns a
negative constant to indicate an error condition. So we change unsigned
to int.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/loongarch/kernel/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 69ebdd4220ec..f9fdeb1ae358 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -102,7 +102,7 @@ static void __init fix_efi_mapping(void)
  * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
  * are also copied to @runtime_map, and their total count is returned in @count.
  */
-static unsigned int __init set_virtual_map(void)
+static int __init set_virtual_map(void)
 {
 	int count = 0;
 	unsigned int size;
-- 
2.7.4

