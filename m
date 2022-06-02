Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA353B25B
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 06:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiFBEAX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jun 2022 00:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFBEAW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jun 2022 00:00:22 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B281D5016;
        Wed,  1 Jun 2022 21:00:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VF8otVW_1654142413;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VF8otVW_1654142413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 12:00:18 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ardb@kernel.org
Cc:     chenhuacai@kernel.org, kernel@xen0n.name,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] LoongArch: Fix unsigned expression compared with zero
Date:   Thu,  2 Jun 2022 12:00:12 +0800
Message-Id: <20220602040012.19756-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix the following coccicheck warnings:

./arch/loongarch/kernel/efi.c:157:5-11: WARNING: Unsigned expression
compared with zero: status < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/loongarch/kernel/efi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index d36a325a990c..2f25a7fe0868 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -145,16 +145,13 @@ static int __init set_virtual_map(void)
 
 void __init efi_runtime_init(void)
 {
-	efi_status_t status;
-
 	if (!efi_enabled(EFI_BOOT))
 		return;
 
 	if (!efi_systab->runtime)
 		return;
 
-	status = set_virtual_map();
-	if (status < 0)
+	if (set_virtual_map() < 0)
 		return;
 
 	if (efi_runtime_disabled()) {
-- 
2.20.1.7.g153144c

