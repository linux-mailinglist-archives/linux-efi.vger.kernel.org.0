Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF975DCA6
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jul 2023 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGVMnE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jul 2023 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGVMnE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jul 2023 08:43:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B16710F5
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 05:43:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso2052436f8f.2
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690029781; x=1690634581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/der0KJlDJ6cwsQs4A7+tIRkxDY3MMfqGccPHIlX2cU=;
        b=gLMFot1BkI0ANTW5TAy3Bb9fjvPkiUYnwOGIenuWohOLcknH0XGZ0PpcM+5zX60Z+m
         6O4mMv39vxTp/o926alCtUzZc0ivcxXTWHFsLiwv6C4Q2uWPZiqQqH7ZRG7cAyIIDqdy
         Susq5+QUDRzIxDTk4TkHnxVhYEgD48ErFCEHctoPsAin4wdcl/dH0Zc/OtXYWM33syru
         Y7w3nuCizPPyraqKoDNUV/m3+Rheyc7jQn3KCBJ8/ZvNAsHAxzPaOmiORG74HLe+FOg4
         lU9ZgkmtlURKG7U2HY6d77tMENB8qrjtfCa9/CDqOzOTj7KREym6sTWEMenKl303dxM2
         TM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029781; x=1690634581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/der0KJlDJ6cwsQs4A7+tIRkxDY3MMfqGccPHIlX2cU=;
        b=lNPMVGZAmbB9rN/txPMAMNZfFbjg8hyBXp/vLidGtI4KIN7j/F5AIPO1fs2rEZnLRJ
         xliXUsi9bARml6rA+E4eJKzTojch3Zt+X5ujDL6Z1bnNNPhsK9rGn2702V1s7PofnvRG
         pZ3fL2FDwGVKwLi/tk0sJYLuOrN2NpVfHXxUoXlT5MZjmLQf44XXXz2zBWdAWobysahc
         DWAzKF1iSmMYcQO3AwpzKobRJL6wDYxhJom9soPjWDphN9Q+7VVdSTnEBX07oE4SrNsw
         DmFnnkZg4axYkYfhCiF9wjphQokCUVj9tpTMlRPk8hSGakc+kJ74wc3WGRycP8Q+d7fz
         vh+g==
X-Gm-Message-State: ABy/qLaqynfcLqN6vyl3ZM01D//Wy7ctwQpbVGvsDR7W6OarWRoIVAac
        X6oHBOGf3cjMnhemW8DQC5hEGQ==
X-Google-Smtp-Source: APBJJlHkvTt0JkOjTHC/10qCFsIyDPIAfKz5RSmvzPMUq5Ej1dnP9W1WU/kGxqayUnfN2+92c6cZ+Q==
X-Received: by 2002:adf:e6d0:0:b0:313:fff0:ff44 with SMTP id y16-20020adfe6d0000000b00313fff0ff44mr3603578wrm.38.1690029780939;
        Sat, 22 Jul 2023 05:43:00 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d690a000000b00316fc844be7sm6834681wru.36.2023.07.22.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 05:43:00 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 4/5] libstub: Fix compilation warning for rv32
Date:   Sat, 22 Jul 2023 14:38:49 +0200
Message-Id: <20230722123850.634544-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722123850.634544-1-alexghiti@rivosinc.com>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index be0c8ab0982a..afb857329799 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -130,7 +130,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
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

