Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A162317A
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 18:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKIR2C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 12:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKIR2A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 12:28:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C5522502
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 09:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D64FC61965
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 17:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B272C433C1;
        Wed,  9 Nov 2022 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668014876;
        bh=+qAX0WCvBvt2ZAO/ZEiX9R0/faeC3FYXr+Bab8yJpgc=;
        h=From:To:Cc:Subject:Date:From;
        b=jO+Y4K3gJ4veSjvsiZi/HzZJ0acSEXeVQ1VnAof5HQw+aD6eWUWe7bLkMcrouWPt/
         jyAoTIqYKcR8bjPsnuzcvJRQWJMx4Qggl0tWFmvoPUwc21ymyGWXoco83BRRq/ey3+
         Va9qK7e2TSCY/+H134d048Iu22+ixFsglJVK/2sLvu3HyQsNf8MS5Mtql52tM9HQTZ
         Rf7YzAk8w/sYECJvHy4Do9tHCTQZ45ScxUKVR5XmhLsY1b1XL8KvbE4+iuqIPy4fTB
         mPw0Y8Hf+Bil0mSjMTcSDU6QB3eZrqjo5xOiWz+LmNjxdWwhYkWotlFGEd060+bwzL
         EoSW3JFKvg4wg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alexandru.elisei@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: Override runtime supported mask from a EFI variable if present
Date:   Wed,  9 Nov 2022 18:27:50 +0100
Message-Id: <20221109172750.2823891-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=ardb@kernel.org; h=from:subject; bh=+qAX0WCvBvt2ZAO/ZEiX9R0/faeC3FYXr+Bab8yJpgc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBja+MV/zaQ/eSZ2P2yAsMJlaau9JYjgexMxcsv3yjW a10qOGuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2vjFQAKCRDDTyI5ktmPJCBzC/ 9wf8y4W6QdO7otQdDy4IflhzXmGDZBOzJRjUiRDfFIcgeYuAmWKiJDT/3SzFtjTiLQWhRn3Q2ptt1j WDa3zHM9tS7ISAmkYX6P29TeapwVrKGB+actatY9DftWRMm6cUNdTNuLkXrV+F2qX0mp9jzVj3RehJ 7rMhknupRYXr5QS+rFvUhIYXxn2uAmsARVmC7z9n7ARnutfs186bhEUDwcA4nx2kgXb5XvCJJyNuax 6WUZXlbcioYdlYI91XR8ddZR/8hyABgTajQeVq3ZENmBY4XBRVBuF/DHccz8QnIrMRsW+Acm2NZHV8 KiEbDFbeXTDMmMNliFemJgXB8206OTR8KBxUak0gXewYhj/hF0hPDQnM12Tmo5cOcDzMoIpB6UoF3q dY5SP6XqkFiBWkONTkcTfJJ41nvWoZZaX2X8HWoOzSMJ3lCHPlCpcHYlC51UhL1uusNEoXUj1glgsg 7rViqw+NszT3rq7405JOEsL3zhaXvz4ubAM+NmqVA2Ulg=
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

For debugging purposes, allow the runtime override mask to be set from a
EFI variable if one exists. For instance, the RT supported mask can be
set to 0xfffd to disable the SetTime() runtime service, and enable all
others:

  echo -ne "\x7\0\0\0\xfd\xff" \
    > /sys/firmware/efi/efivars/LinuxRtMaskOverride-eb66918a-7eef-402a-842e-931d21c38ae9

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a46df5d1d0942751..faed1ef78c044924 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -367,7 +367,17 @@ static int __init efisubsys_init(void)
 		}
 	}
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		unsigned long size = sizeof(efi.runtime_supported_mask);
+
+		if (efi.get_variable(L"LinuxRtMaskOverride",
+				     &EFI_RT_PROPERTIES_TABLE_GUID, NULL, &size,
+				     &efi.runtime_supported_mask) == EFI_SUCCESS)
+			pr_info("Overriding runtime_supported_mask to 0x%x\n",
+				efi.runtime_supported_mask);
+	}
+
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_TIME))
 		platform_device_register_simple("rtc-efi", 0, NULL, 0);
 
 	/* We register the efi directory at /sys/firmware/efi */
-- 
2.35.1

