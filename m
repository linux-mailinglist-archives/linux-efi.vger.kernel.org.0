Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294445BC01F
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIRVgX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIRVgW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A913FAB
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA5D612AC
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF854C433D7;
        Sun, 18 Sep 2022 21:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536980;
        bh=RXnNlaksocyhUCf1TtF0nCIv72jfeLTz6q5C8n0AChA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEd4qGpaydhAQZM4Eh/z8tvEwtXPV6dry7iBPzVXVad6Q/UttBdQi4U0wPFOMXZJj
         du2Zcub3ND9c0w+xkYkYrPJnRmtgZgFIydrLhkuFhoh0r+mdGR0HLkynJA59Utmsmu
         TJtYbRquddob9HEHvKP/JQuN02qVihWAkHuLIpR+cjJtU+rDNR0KUb1c6Q+RFlb+qu
         gs/0tpsABEsQ9ff9hjlIOeDRjXETpKUyobLnGHRqaK4BZOOAGgAeINKRqQpw82S789
         WJNh4C4GNBJufoYUKOgF6Zt4gvwiZeYWUIyQ2kbt7Z8u03o2xpjzRcXpA6Xe49/RZD
         lPTMjmQexvDCQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 10/12] efi: libstub: remove pointless goto kludge
Date:   Sun, 18 Sep 2022 23:35:42 +0200
Message-Id: <20220918213544.2176249-11-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=ardb@kernel.org; h=from:subject; bh=RXnNlaksocyhUCf1TtF0nCIv72jfeLTz6q5C8n0AChA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48rArpB44oOut+AD+EXPPAeJWwXajGeoY705IPX GHglvjmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePKwAKCRDDTyI5ktmPJOJGC/ 9DEPaBJRIdXZQRWuiEk5KEatwI3jwBhslPT98LZnUlBqiZuVnfLhfzAvEydp7o0Ztf4ctowibWBCcI Hu21WWZNPHT4FxUQGSYxwfyJiCrSl/N305v2GuMydhD9Jr2VWqMFsfrGgaDIF83aoaNgpYVGfGNpB/ QiBjp62e+GmAM6gMYUG0Q2IS1CdW8hLtGbAw/+IMy16GfK3MnP3Ab7FaTfF9bqHgYLpGnKOvScU5Vw x+vUFpz81Rar3s28ZQ3XTiUuUhWnvSH0snWgGg79vLeakx7urMyB3YU8khuQ7ZesVzb+/18qihXvGZ uNf5hq6n7tvPPDRCesgvLPeZUMc/3INCtUT2t+ZPnUAS7ki4kaQAqh71r8qZkudMzCzXxnfslGEzau 2o0hii7SuFMFhvBFzBDycTQr3zxFM7v0fJ1+ABcpc5lwlKGzKY94ZG3QCmXWcwcH5U57sFuQ9Tz1XR WMqTfKXcJh1Bwc7hPqzSFvpQBXRPDN0ZsU3ZMyW/DWhag=
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

Remove some goto cruft that serves no purpose and obfuscates the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 22 +++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f1f7a823be17..76a1a395fad4 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -439,13 +439,14 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 	efi_status_t status;
 
 	status = efi_get_memory_map(&map, true);
-
 	if (status != EFI_SUCCESS)
-		goto fail;
+		return status;
 
 	status = priv_func(map, priv);
-	if (status != EFI_SUCCESS)
-		goto free_map;
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, map);
+		return status;
+	}
 
 	if (efi_disable_pci_dma)
 		efi_pci_disable_bridge_busmaster();
@@ -476,25 +477,16 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
-			goto fail;
+			return status;
 
 		status = priv_func(map, priv);
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
-			goto fail;
+			return status;
 
 		status = efi_bs_call(exit_boot_services, handle, map->map_key);
 	}
 
-	/* exit_boot_services() was called, thus cannot free */
-	if (status != EFI_SUCCESS)
-		goto fail;
-
-	return EFI_SUCCESS;
-
-free_map:
-	efi_bs_call(free_pool, map);
-fail:
 	return status;
 }
 
-- 
2.35.1

