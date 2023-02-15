Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB470697EE5
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBOO4B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBOOzx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 09:55:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505B3B0C7
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:55:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so19410052wrg.13
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFZ2YC0fgNO5IScjFj8fCx7wxmBPNhh2ssV4/ZbMqxU=;
        b=eOcBAPjgIt+WhR5hfDh6Za/xsjISTX28UboARgwu3/BWNk29fi7nOSnVlLooTINvq1
         grawxRamDHGBT4+ca/x1g6aykZIGQHvEcxaPK0ng4ME3P7LeN86UCeEG1igcxZpCEGIR
         dmhwWJQj956L2JopjfuW/6YiIByJhmuyCGnpe90XUIkUU2/aPPN8YNp+IF+fuFVNVc8b
         jlRxZf7TY/wT/pBg5m4JqeOXB+3WdZPSXj0YQbbNb4kxRluMaEIrN00aZ2wejENicNPT
         hIbHd6OK/COzir6+MX0Hb1aIZttsuCqE938jaK24wNVS9H+FAo4nzwdC2HcYnK0U2Ugr
         503w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFZ2YC0fgNO5IScjFj8fCx7wxmBPNhh2ssV4/ZbMqxU=;
        b=IF2LqTUpIeRYZBOIPtmY+HTx2qIL7fAPo4gPIhO5trE+3eKv3mhlwveTJjFVaoPHH2
         yptlyKDUxtqgE7LohdwsT68c8BAKQRmB5AvLnjQTV/xtN+/r54AN6Dy0xP9GN2TMdFEo
         e0Zcch5iUwzlfM3uWuGA9j3nh9L62HP9JSopGkH/CknumrXSkmVe1MRANpma8tbVD1Zy
         7x6P8GVN+t3ddlpTpa1uVdrHTqtwye6PNOyQv3JQccXImNRRPzTRH8gmyKF9J1nLkEoO
         cEHv20m78MPfa2Hy4haweFpKZUyD8F+h5czswxIfXJOe6PrSbpMSBvFztCb/oa6NigwZ
         bGAQ==
X-Gm-Message-State: AO0yUKUuDauCru+8NVCnhQY04BKbjO5iEMyxeA2rhrObHF8oA7f8hn8T
        ra5HPP+ePwfUg9a5zn9cQF1fGw==
X-Google-Smtp-Source: AK7set9ydRMCaArnxU7Ht9ckCOmyaOWeWDHgmLuOzZo9PdkdFiBT5s/U7hY3mzZhXL75FAh+JivHQQ==
X-Received: by 2002:a5d:544b:0:b0:2c5:5687:5ed5 with SMTP id w11-20020a5d544b000000b002c556875ed5mr2053017wrv.18.1676472919291;
        Wed, 15 Feb 2023 06:55:19 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003dc1a525f22sm2637468wmn.25.2023.02.15.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:55:19 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 4/4] riscv: libstub: Implement KASLR by using generic functions
Date:   Wed, 15 Feb 2023 15:51:13 +0100
Message-Id: <20230215145113.465558-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215145113.465558-1-alexghiti@rivosinc.com>
References: <20230215145113.465558-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We can now use arm64 functions to handle the move of the kernel physical
mapping: if KASLR is enabled, we will try to get a random seed from the
firmware, if not possible, the kernel will be moved to a location that
suits its alignment constraints.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/firmware/efi/libstub/riscv-stub.c | 27 ++++++++---------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 145c9f0ba217..0c3c4a13afa1 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -30,32 +30,23 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle)
 {
-	unsigned long kernel_size = 0;
-	unsigned long preferred_addr;
+	unsigned long kernel_size, kernel_memsize = 0;
 	efi_status_t status;
 
 	kernel_size = _edata - _start;
+	kernel_memsize = kernel_size + (_end - _edata);
 	*image_addr = (unsigned long)_start;
-	*image_size = kernel_size + (_end - _edata);
-
-	/*
-	 * RISC-V kernel maps PAGE_OFFSET virtual address to the same physical
-	 * address where kernel is booted. That's why kernel should boot from
-	 * as low as possible to avoid wastage of memory. Currently, dram_base
-	 * is occupied by the firmware. So the preferred address for kernel to
-	 * boot is next aligned address. If preferred address is not available,
-	 * relocate_kernel will fall back to efi_low_alloc_above to allocate
-	 * lowest possible memory region as long as the address and size meets
-	 * the alignment constraints.
-	 */
-	preferred_addr = EFI_KIMG_PREFERRED_ADDRESS;
-	status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
-				     preferred_addr, efi_get_kimg_min_align(),
-				     0x0);
+	*image_size = kernel_memsize;
+	*reserve_size = *image_size;
 
+	status = efi_kaslr_relocate_kernel(image_addr,
+					   reserve_addr, reserve_size,
+					   kernel_size, kernel_memsize,
+					   efi_kaslr_get_phys_seed(image_handle));
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
 		*image_size = 0;
 	}
+
 	return status;
 }
-- 
2.37.2

