Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58363724248
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjFFMgx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjFFMgw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 08:36:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E70E5E
        for <linux-efi@vger.kernel.org>; Tue,  6 Jun 2023 05:36:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30e53cacc10so109204f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 06 Jun 2023 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686055010; x=1688647010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRJCBm1K3gKtA9P8oa436oFytzNm3ZRYlTVQKHg/5x0=;
        b=XM2xBLfv60ptr6Go/ry9Nj6ExuIoxylGWaDS0x0HaqXjZj14ydn90vmEhmG2WtoTx0
         qH5ZToAQJimQF0Eg9MVSsgCVWfV5C/BRlOc238Pl0cq4wPVlr+WGZE2BkYcKBmcWPppA
         J59b8Q9Pbun4Ij0HfysGKaIo1+ciqlXuxXHJCdhvXTHnpZucM5puJrLn0hQt+nq8cLmJ
         mgScgV3i60C2NOPGI+yRAsCwngLFQJ3JrfESANdaNzMAHH1YZmOeJk2oYYtl90l1veaa
         dKZDiWAREns7QCGSz2qGYD2DeOpMYA9I5OUT+QAMm7t1RGenWXFqVVeL4R3+Oyd1WiS4
         k/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055010; x=1688647010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRJCBm1K3gKtA9P8oa436oFytzNm3ZRYlTVQKHg/5x0=;
        b=RgyTxtSRRkGhwCQksw7gVLOPWPuhdRvXKO9FRPPSQFsBOt3eNpVrvnl5gC2rsRMsPn
         GAQx3gZ9GAVCVS/jO2iVrjQbHMbp2JxRSX0uwwjjyYU1IIxoR+xN11QxNaTr1JXTaFU5
         bUhGbLLB7XJf1LdzauNCDCeRyHTolDGaYLvfw/cbjoRJbTAIGsbxGNU7sxJq07dXpyJF
         qsKqroQWm0LaFrbnzZYpQl5UU+w6aX9QW8wcfuP635jOQ/C5pDzYXesLiE8kgrvar0U9
         Zz4uPDfX8WhV70/I89KmVXb4h3oS8VlLF0y/B7TzhJWOEQEGcfVZJpKY/0jjRmsnFAT+
         a0XA==
X-Gm-Message-State: AC+VfDzECKUljwQ43paPTpjBssWTB3RKSkiuwzll5NJhhE9ABI9F6Kcb
        +I1/pt7sOxYFerM2Q6fRiPCWvg==
X-Google-Smtp-Source: ACHHUZ5ekNV2hJsIy3WOef/8IkqukwqVEzw40hcPbnAIYJSpseFgboWCQYewyzkinKMGRbK3ARPnMw==
X-Received: by 2002:adf:edcb:0:b0:309:41d8:eec4 with SMTP id v11-20020adfedcb000000b0030941d8eec4mr1809470wro.39.1686055009833;
        Tue, 06 Jun 2023 05:36:49 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d564b000000b00307c8d6b4a0sm12592085wrw.26.2023.06.06.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:36:49 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 4/5] libstub: Fix compilation warning for rv32
Date:   Tue,  6 Jun 2023 14:32:41 +0200
Message-Id: <20230606123242.20804-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606123242.20804-1-alexghiti@rivosinc.com>
References: <20230606123242.20804-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix the following warning which appears when compiled for rv32 by using
unsigned long type instead of u64.

../drivers/firmware/efi/libstub/efi-stub-helper.c: In function 'efi_kaslr_relocate_kernel':
../drivers/firmware/efi/libstub/efi-stub-helper.c:846:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  846 |                            (u64)_end < EFI_ALLOC_LIMIT) {

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index a5c61a768d59..029d1581db72 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -842,7 +842,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 		if (!check_image_region(*image_addr, kernel_memsize)) {
 			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
 		} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
-			   (u64)_end < EFI_ALLOC_LIMIT) {
+			   (unsigned long)_end < EFI_ALLOC_LIMIT) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the placement is suitable.
-- 
2.39.2

