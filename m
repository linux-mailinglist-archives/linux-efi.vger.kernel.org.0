Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FD7DB162
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 00:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjJ2Xdh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Oct 2023 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjJ2XdS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Oct 2023 19:33:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD151FE7;
        Sun, 29 Oct 2023 15:55:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A2CC43391;
        Sun, 29 Oct 2023 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620137;
        bh=b6kCZ/VuTqfdqRtkQc9f6g0UaXs3C8pEWBckCzBd+Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EClnxfQaXYm+cJT43BKvI1JeQoyQeVEeYexFPKhLPIYhCTgu2Spqo0km5PO5vX9+T
         MSGfNB1FQ3kK0yPfzu3tIwjDlWcVt3rl/j3brYMVAl1DUi46Hf4j8CHWBf2chGMnBr
         evX/DqgcMo10Ggc67QFU4dgHQuQPJygDTqhy0CRxLwLViWsS/0nTVoDRjiK0da9q2p
         fIkM06kFAKPiOFFt9DmqIWFvnXuMsoH5Mp51XwJ1G8zVN2W+8z2tQOrdVX599u9MYx
         MvMFsyDxrInO65HxnDH1K9uxBB01Ve2fUexbj69YfKVFBU24Ka0U5kTtAtMpm4D/3c
         M9xjyY0jWptag==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuan-Wei Chiu <visitorckw@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 27/52] efi: fix memory leak in krealloc failure handling
Date:   Sun, 29 Oct 2023 18:53:14 -0400
Message-ID: <20231029225441.789781-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 0d3ad1917996839a5042d18f04e41915cfa1b74a ]

In the previous code, there was a memory leak issue where the
previously allocated memory was not freed upon a failed krealloc
operation. This patch addresses the problem by releasing the old memory
before setting the pointer to NULL in case of a krealloc failure. This
ensures that memory is properly managed and avoids potential memory
leaks.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f11768426..9cfac61812f68 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -273,9 +273,13 @@ static __init int efivar_ssdt_load(void)
 		if (status == EFI_NOT_FOUND) {
 			break;
 		} else if (status == EFI_BUFFER_TOO_SMALL) {
-			name = krealloc(name, name_size, GFP_KERNEL);
-			if (!name)
+			efi_char16_t *name_tmp =
+				krealloc(name, name_size, GFP_KERNEL);
+			if (!name_tmp) {
+				kfree(name);
 				return -ENOMEM;
+			}
+			name = name_tmp;
 			continue;
 		}
 
-- 
2.42.0

