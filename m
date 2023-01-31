Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBCA682D73
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 14:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjAaNLa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 08:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjAaNLZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 08:11:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B4126D7
        for <linux-efi@vger.kernel.org>; Tue, 31 Jan 2023 05:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21488614C8
        for <linux-efi@vger.kernel.org>; Tue, 31 Jan 2023 13:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D818EC433EF;
        Tue, 31 Jan 2023 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675170648;
        bh=HyppcoYXBj7p84fADhvxadFYuqQD1bt6H/RuGB/+FZY=;
        h=From:To:Cc:Subject:Date:From;
        b=hXTulsBGR7ZiDhkSusfh0bhKS5IlvggT7pMwj2pdEDC+GnkkDTLfE2Vuadu0aq4tQ
         J2CGxoU1Ao0V440PPF2rrkG3y1Wvo+GfSojWKBucIT9EFluWBGv7Wypx22DQvus3JZ
         F+I0uac9yPtrE8/URAHELs8p0kEHy2eUPfiazQ9z6P79O2kn4vdOgbJ5mtcR0vPK7w
         B67+Lj517F4NB2Ev+IN/S1YIIDtoJW2To61kAwvx9dh0QYuurtaVem1fS0f9DqpEDp
         ti3lEesatnpRJUUMep1uFnaGHIWL3SUB0mdWdVXgStoRJi36JMt3X6yOOmBCY/VhYm
         FkdYIzvuq8d1A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: Use standard format for printing the EFI revision
Date:   Tue, 31 Jan 2023 14:10:43 +0100
Message-Id: <20230131131043.1707904-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=ardb@kernel.org; h=from:subject; bh=HyppcoYXBj7p84fADhvxadFYuqQD1bt6H/RuGB/+FZY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj2RNSEf6GccmQAug0t+xCyDYknZiAlFwVDoETg +zDwfJ8s52JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9kTUgAKCRDDTyI5ktmP JMdtC/0XxD1qTSWGaQDBVY6B3h7i0pvLLEHn++6bOq9ZdwhKBlUL4XyjAuDnW+1DFjwlJhXECTx JpcwobbsifoVKxrVnnuYXVumLZtZ36C6nmnGqLcGf6Ubc0OcH0PQrm13LBzHqwnXGpD+biKoHiv HZx/ayj14mia7AHf8iWDGcBrAzNyLfOQxoi1KZNG0CFsqy8PFyIoHDjyNQirkTha1kCIuRBuLp8 NVNoPWzzPs9lWH+Y7f1oHJqq6ahyI1MUdJWRAqXAhF8WaKJt3V9GRrxwjmSYgEWKjNpLeS2rX9k lUU9lVjaQDLsVqJs0ZFPiRp/kokTWIv+Du1zBhtAFIdyBcjjJTJ6pgSl7UKUQs12Bpp6+gLvKWM SahA36b4e1Q9TMHJcw3HDHBZ/QzQJOfv5RE6I4JrLcnaeFqgll0lutS6oG2InzW+DgcIvDZ/oVT Eck+mqOe0aAASPTHLcOnTBG2dB9QCght+bau+gJ66OJ3GCU82005tIsuKro8z4OY7mn7Y=
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

The UEFI spec section 4.2.1 describes the way the human readable EFI
revision should be constructed from the 32-bit revision field in the
system table:

  The upper 16 bits of this field contain the major revision value,
  and the lower 16 bits contain the minor revision value. The minor
  revision values are binary coded decimals and are limited to the
  range of 00..99.

  When printed or displayed UEFI spec revision is referred as (Major
  revision).(Minor revision upper decimal).(Minor revision lower
  decimal) or (Major revision).(Minor revision upper decimal) in case
  Minor revision lower decimal is set to 0.

Let's adhere to this when logging the EFI revision to the kernel log.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 14797a0332c60bed..6bbc8cc6dc0d4d45 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -806,6 +806,7 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
 	char vendor[100] = "unknown";
 	const efi_char16_t *c16;
 	size_t i;
+	int rev;
 
 	c16 = map_fw_vendor(fw_vendor, sizeof(vendor) * sizeof(efi_char16_t));
 	if (c16) {
@@ -816,10 +817,12 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
 		unmap_fw_vendor(c16, sizeof(vendor) * sizeof(efi_char16_t));
 	}
 
-	pr_info("EFI v%u.%.02u by %s\n",
-		systab_hdr->revision >> 16,
-		systab_hdr->revision & 0xffff,
-		vendor);
+	pr_info("EFI v%u.%u", systab_hdr->revision >> 16,
+		(systab_hdr->revision & 0xffff) / 10);
+	rev = (systab_hdr->revision & 0xffff) % 10;
+	if (rev)
+		pr_cont(".%u", rev);
+	pr_cont(" by %s\n", vendor);
 
 	if (IS_ENABLED(CONFIG_X86_64) &&
 	    systab_hdr->revision > EFI_1_10_SYSTEM_TABLE_REVISION &&
-- 
2.39.0

