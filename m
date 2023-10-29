Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E227DB1A9
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 01:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjJ3ACo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Oct 2023 20:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjJ3ACk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Oct 2023 20:02:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337E2736;
        Sun, 29 Oct 2023 15:58:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C5C4167D;
        Sun, 29 Oct 2023 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620287;
        bh=50C/Dk+kc52f0ekJyekD5vmvlInBqIqlI31HCEGQ6zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhrshRHa6vFkTQy+GsK+18zZrdI0xpi6c/v6ctYHFbVFHAWT6IcXGG/CNvLQv/Is1
         bo+LXRIVQh1o9u4OjeLhMIQdEQqVAy0LJuAgaTHzaAAGPxQ0RaIYILj4vstmWha8z4
         hBWjIVFf5dJ9UJWH3GsNAMHjIdB8DluM70TVQcOxZlIfNU4Fv7P/BfGvont9kcEHGf
         RuNy93YTF5yj9vezTbHR9kXud1rHrxJ7MDsiBr4Ci6eFOmNDldYurhXns62UnCIRLP
         Er3M4eAYKHg1SZ7OTleMy5inEGYK53ghnamJ3htE4xRkj+dfIdJJR2dLKm6eWMrEAa
         gHo2IYqTS9vCg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuan-Wei Chiu <visitorckw@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/39] efi: fix memory leak in krealloc failure handling
Date:   Sun, 29 Oct 2023 18:56:51 -0400
Message-ID: <20231029225740.790936-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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
index b43e5e6ddaf6e..b7c0e8cc0764f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -245,9 +245,13 @@ static __init int efivar_ssdt_load(void)
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

