Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098415B4018
	for <lists+linux-efi@lfdr.de>; Fri,  9 Sep 2022 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIITqk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Sep 2022 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiIITqO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Sep 2022 15:46:14 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B236869;
        Fri,  9 Sep 2022 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/q9eNcU3uzrC4vnpWsAF5H9wAjfFopX07fmzyDgI15M=; b=AtvsIuqKCKXtdg78Gc+1WUzE8b
        dPJVkIa/LVmXo1MsStXD32O8hF1TUOKb4Yi02aOtlLfr1zKxqzYiPNSF+zSoCh7KFEU8g8GhdtB2W
        tj2IXFa5GraXvFjaGW07lEK/V6SefMSj2N0b3Gokcnyjs/VL6zjPZ4bdeOVn2A1zscyt2jvpXt87i
        oStBDQQdoikF/txOT7Ug1inDhdM5b0kbfddgo8RwJBAotyWB9vhWkcK7iOJqu7KxmbJIc9QUrdoyd
        hExDDtRkWd9XbJlSJgkL6rnCdO19Xe36Re+VeV6+IQI3Av9AZ/TToPYKLZSyxgJ/+eX2PLoYH+0Vy
        E3rPHm7g==;
Received: from [177.215.76.177] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oWjtX-00E5na-3x; Fri, 09 Sep 2022 21:42:31 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        matt@codeblueprint.co.uk, mjg59@srcf.ucam.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V2] efi: efibc: Guard against allocation failure
Date:   Fri,  9 Sep 2022 16:42:14 -0300
Message-Id: <20220909194214.186731-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is a single kmalloc in this driver, and it's not currently
guarded against allocation failure. Do it here by just bailing-out
the reboot handler, in case this tentative allocation fails.

Fixes: 416581e48679 ("efi: efibc: avoid efivar API for setting variables")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V2:
* Rebased against 6.0-rc4;
* Dropped from the original series [0].

[0] https://lore.kernel.org/linux-efi/20220729194532.228403-1-gpiccoli@igalia.com/


 drivers/firmware/efi/efibc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 8ced7af8e56d..4f9fb086eab7 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -48,6 +48,9 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
 		return NOTIFY_DONE;
 
 	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
+	if (!wdata)
+		return NOTIFY_DONE;
+
 	for (l = 0; l < MAX_DATA_LEN - 1 && str[l] != '\0'; l++)
 		wdata[l] = str[l];
 	wdata[l] = L'\0';
-- 
2.37.2

