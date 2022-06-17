Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1697D54FC76
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 19:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383420AbiFQRtQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383268AbiFQRtP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 13:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280B3F885;
        Fri, 17 Jun 2022 10:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F77A61F14;
        Fri, 17 Jun 2022 17:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960CBC341C0;
        Fri, 17 Jun 2022 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655488153;
        bh=PRTYl9cGcXlUxdUr/r7+4Kaowbx7SkDShSOpXJhEviM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWbuSYbv0EI66uKQNIhCHVmHqsHfykouUmD9eq9CpmGNei4uVgKaNMkv8tiwCvTVX
         nx0SM8eEM0lTCxPSVws4TDWEryho+KMvn3zGkYvKP5yKPQxf8iSG/TZoU6vy1BKiYk
         ofsjxbJ7jWtWMaXUgHy68Zh+7slsvtbVNif8wd7jri2M+V9nXbFfGYphRi/QRHY2fh
         GoVTuXoOGzcAr39RribXur6X0Zt4kwNTZIVzGDXKIV/9Jvw7dGSYuriCh9hm3Qnt7r
         ZJVgA1/14pLM0A2QIGNvCGIJ01P0/ge4pd+jLHsT37n2bjON9xrX3OvdYgpwtOdJdM
         QgPpBGkKVHMpw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-input@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 4/4] brcmfmac: Switch to appropriate helper to load EFI variable contents
Date:   Fri, 17 Jun 2022 19:48:51 +0200
Message-Id: <20220617174851.1286026-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617174851.1286026-1-ardb@kernel.org>
References: <20220617174851.1286026-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223; h=from:subject; bh=PRTYl9cGcXlUxdUr/r7+4Kaowbx7SkDShSOpXJhEviM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBirL6CWaquSqLfyrN7l/DCfLI0uHD6hNWG9QW+emqE 2fHS4G+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqy+ggAKCRDDTyI5ktmPJPb9C/ 995YoHB7auDHHI3CJMJiJkvfWZZSjdbMHDjz9xGMBF/zTnI3Z69iW4BLPUQzTsQycDX/AMZd/NMLs8 ynIHqcpNpnia6ZB1li/KQPUw/EfhYelR5DKeQE1+nsqvGieG4/wANRehhU2Pd3qinh1hQow7rFZ4Xn 5iKBalmtopiTHkaeTaj4u4tfVFAAY4msylHEYDfXc5/3xubPgRwbGr6KV3D1J+P5TLnGA7KncCkvzx ZbcOwPhQ/yU4DHNKb4avRbA4P2jmF7/VbMQASy5fqlXnFLqJV0R4abx4Tk1FA02DSfJE/zyraPUIl+ tXQZzCNldoLl/jF7CrSVbinF5zvJ3dNXMfn1QXKqq3sVNyUHNRRmQi5Gb8WnOOKNjBseNaDWnpP8H8 MF/GU7qWeGFgkqHLN7NNONoeNy+KDP0cRgkIHiZ4mV45fL81+9ILRSa5dyL8i5OEf0q+TEAkJuZzEN aapEXPeYEgYcIVOxGD8jokAW2D8OeSP7vrqbEUC/8NQnk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Avoid abusing the efivar layer by invoking it with locally constructed
efivar_entry instances, and instead, just call the EFI routines directly
if available.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 25 +++++++-------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index dcbe55b56e43..b8379e4034a4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -459,43 +459,34 @@ static void brcmf_fw_fix_efi_nvram_ccode(char *data, unsigned long data_len)
 
 static u8 *brcmf_fw_nvram_from_efi(size_t *data_len_ret)
 {
-	const u16 name[] = { 'n', 'v', 'r', 'a', 'm', 0 };
-	struct efivar_entry *nvram_efivar;
+	efi_guid_t guid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61, 0xb5, 0x1f,
+				   0x43, 0x26, 0x81, 0x23, 0xd1, 0x13);
 	unsigned long data_len = 0;
+	efi_status_t status;
 	u8 *data = NULL;
-	int err;
 
-	nvram_efivar = kzalloc(sizeof(*nvram_efivar), GFP_KERNEL);
-	if (!nvram_efivar)
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return NULL;
 
-	memcpy(&nvram_efivar->var.VariableName, name, sizeof(name));
-	nvram_efivar->var.VendorGuid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61,
-						0xb5, 0x1f, 0x43, 0x26,
-						0x81, 0x23, 0xd1, 0x13);
-
-	err = efivar_entry_size(nvram_efivar, &data_len);
-	if (err)
+	status = efi.get_variable(L"nvram", &guid, NULL, &data_len, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL)
 		goto fail;
 
 	data = kmalloc(data_len, GFP_KERNEL);
 	if (!data)
 		goto fail;
 
-	err = efivar_entry_get(nvram_efivar, NULL, &data_len, data);
-	if (err)
+	status = efi.get_variable(L"nvram", &guid, NULL, &data_len, data);
+	if (status != EFI_SUCCESS)
 		goto fail;
 
 	brcmf_fw_fix_efi_nvram_ccode(data, data_len);
 	brcmf_info("Using nvram EFI variable\n");
 
-	kfree(nvram_efivar);
 	*data_len_ret = data_len;
 	return data;
-
 fail:
 	kfree(data);
-	kfree(nvram_efivar);
 	return NULL;
 }
 #else
-- 
2.35.1

