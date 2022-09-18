Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F505BC018
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIRVgI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRVgH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015413FAB
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26F66124F
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74710C43142;
        Sun, 18 Sep 2022 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536965;
        bh=7HZgiqzu7o/tWfKhqeYeSjtgA75cQnUPmVMIgyCrRUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0BUkew0BR5qICHyO8up2cUq6ReYUaXqUYpfc111WCRbYi5NTTTfrOqXsFJHO8RQB
         r+fyRR1Wbaw8H48yUPnJSSZogWhJ2Jpnaw7H75uUn3ihtAfwmtqWT7G4uB07qNgaVO
         Cu1hmMIyoD1kU2SNiy1BA8vqtyiYkaqxKmAgJxbUSwtxNIxcLagob4SWOCE3k/YSK/
         2xI2//k314qTJKFoAQoRfTfPHzm+vtOmmnH/XaFkTvic8G9OW3D81WfI31m75dpAK3
         ZYn2yrUxYua8cPy53gf4hYgMO0C11g5KAEUvajJaVYN6YxanKqEvYI9dZI8iu/PP9D
         x/q0B932I2nRw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 03/12] efi: libstub: fix up the last remaining open coded boot service call
Date:   Sun, 18 Sep 2022 23:35:35 +0200
Message-Id: <20220918213544.2176249-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=ardb@kernel.org; h=from:subject; bh=7HZgiqzu7o/tWfKhqeYeSjtgA75cQnUPmVMIgyCrRUE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48fdgYWwLhjVcrl8sLqZFdaAlsdcvb39GlDuse6 YBIDQVuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePHwAKCRDDTyI5ktmPJJXPDA C87CoWiqRDu3R9G8Bcdz0lK8RCp0qAaQS3eFYNfQg8A2vi/dNiDAjqE8CIlw9j2Mwxns4WpXG3G66l l62jCg+4fzHruQ6mnqXnZS/+Zwyu7KjcCqfaAC5aB0sTdLod8Y4+Rb2XcEaK+Zi/KAjZE+zJP5aVsi 0wUN38b9S9rGCbgoKu7FUy8ITQWBTpGJhnRU1h71o8+x9zdJqQTh2DpNL0yaIjD6WPBXahb2XdBgN4 sWXF73LWU75ahQVB+fWR3L/Uzp70yLqXZiXhwKuDGWn1554IrQ1BheGcSvlOKPhqg33z4r1JaE5Xxx +0Pf2XYchCVYeZWzN2z2aIZPbEqTTjdVLMZX1aM97GHJuXLP9OlkzWcwHlehZSFO1sJasHB6AvDSFu IwYpP1yag/9Yra3iPK7iIzXLrZBFNb7cr9W/MabGdFL9k4d4OVpzXyCtzYzf37i5JzxULMOR5dB3MS 4zJt9PeG7dduTD/m/np/MLwww2uo60Qx9uLUlPj2lRP6A=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We use a macro efi_bs_call() to call boot services, which is more
concise, and on x86, it encapsulates the mixed mode handling. This code
does not run in mixed mode, but let's switch to the macro for general
tidiness.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 57ea04378087..97eaa487fdfd 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -160,8 +160,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	 * information about the running image, such as size and the command
 	 * line.
 	 */
-	status = efi_system_table->boottime->handle_protocol(handle,
-					&loaded_image_proto, (void *)&image);
+	status = efi_bs_call(handle_protocol, handle, &loaded_image_proto,
+			     (void *)&image);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to get loaded image protocol\n");
 		goto fail;
-- 
2.35.1

