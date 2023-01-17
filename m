Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F366E0A0
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 15:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjAQO3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 09:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjAQO2d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 09:28:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FD305E7
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 06:27:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B5C6144E
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 14:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93081C43392;
        Tue, 17 Jan 2023 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673965657;
        bh=Wrp3SuN2sf33gurMiIx27fDLuT7yPVKXHH1EzZKlC4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qO6UZKm85lxdidHzRIBlEmzabel00R6fT+epRLagkglI9c324eFQl24LKV6Ys7xr2
         pxzMg0EXzd4Wh6S+apqPFFDf4RFzXM2/GF5pvorIzQ1aw5OUhMtRqvwcADmASrEpRI
         LVM4tgZdlnFUf+JAz/uaPVTfXBDbkIO/HVzaPE48oNKVc+JSif3YXg4p/59BDefRWy
         JZPp3193gnm4ox5QK/omEFu9PGsg3Hfuu+savxQGIHi76hjL4Qs8RWJUzepdWPaBOT
         d3VvO+3ophnb4v28xgTqzGsUdZli8ADalukiKkL5D16eXgRQWWGuSe2K9J2zdk4OWI
         XQwXFzv+ffPOw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [RFT PATCH 2/2] arm64: efi: Force use of SetVirtualAddressMap() on MS Surface
Date:   Tue, 17 Jan 2023 15:27:18 +0100
Message-Id: <20230117142718.564299-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117142718.564299-1-ardb@kernel.org>
References: <20230117142718.564299-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=ardb@kernel.org; h=from:subject; bh=Wrp3SuN2sf33gurMiIx27fDLuT7yPVKXHH1EzZKlC4o=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjxrBFK4LKNEyKO1VtL2pr9bayyhVzwVhz3steIhq1 N9crJECJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY8awRQAKCRDDTyI5ktmPJD7wDA CtuOFuG44iYE/4fcehhVRuxvJyzfsCG8MPJP42IX+GpJ4W/3BdRV6nmp4H4y52itZcDQc13yDxrRuk tP/Xjhtt7bcIgdS88R4Uvv1tzjZnmKaAeW/I6xYuRmzPT70ka6hAbWe7cRSsrSLFXpf1MBqZk0uzho 1BKac/OLexVJWMZ4cZL2MqSnbzNQSfIcU367p7NKgbKjuTEPjNOzp+oB05tahotW7FOerYyN1PIw75 u1xtxfHxptcaEBHk2FPs2a9tvrqaoSK93b9cupSeGBPWNcC/RX2mKkZcIRzDNqVkmeogcRmIs4HC7B fpfvFCE8MJETCZuuQ/2KVO5qacEraQGmlTotiIYJnZSPinIOLTbJ8LVcw4hwO1Yepvfh9Wz9fkDASu NC+75IMnH6PP4sOZUDKeqUCIbMyEacKaXtbioSswxJPIg6FPLgevddQ+Rgbnt8YKwrWD/k7rSGDJjx AD56fzaj80Cx9FMZRQPlwglje0ejLXopO7qQkvKS7C/sY=
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

Qualcomm Snapdragon based Surface machines crash in the ResetSystem()
EFI runtime service if SetVirtualAddressMap() has not been called prior.

Unfortunately, SetVirtualAddressMap() itself crashes at boot time unless
the mapping being installed is a 1:1 mapping, as these firmware
implementations violate the EFI spec by accessing the new mapping before
SetVirtualAddressMap() completes.

Now that we have worked around the latter issue by always using a 1:1
map when the size of the VA space permits it, we can safely call
SetVirtualAddressMap() in such cases.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index ff2d18c42ee74979..cc3757fc29bdda24 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -22,7 +22,8 @@ static bool system_needs_vamap(void)
 	 * Ampere Altra machines crash in SetTime() if SetVirtualAddressMap()
 	 * has not been called prior.
 	 */
-	if (!type1_family || strcmp(type1_family, "Altra"))
+	if (!type1_family ||
+	    (strcmp(type1_family, "Altra") && strcmp(type1_family, "Surface")))
 		return false;
 
 	efi_warn("Working around broken SetVirtualAddressMap()\n");
-- 
2.39.0

