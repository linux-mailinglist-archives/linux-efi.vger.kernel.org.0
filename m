Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9FA75264A
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjGMPMM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjGMPMK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 11:12:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671CA26BA
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 08:12:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31297125334so551288f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689261127; x=1691853127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZf0qeWm+WX+bv1IFZf8K1PwMyRHAPQhF5RBE2OKQPA=;
        b=ZM5qANd6WeLcZwwFyXrmgXdeZPNHygoE7OaWvEWRKzI6UtObzCbxmP3zfVqwTLzgAp
         keJuo6AS8TIX1aCmgkYH+hkVg9JP4/xN+jttfihreMuN52dV92KDQmnS8kU3iRTU7rdy
         2e6GVnlzyUsnuTl4jVke9Nwyp0wBlzEhYAdgATXfHP5f/4PpjQ1ZxOAg1WZvp9E3EP5T
         DEtvRG8vuWwwh7fsE7Uki2T1eHqRl5vzuvYyrhQf7VtOOB7p5qWWkhRFFRp7gfQXG8DY
         9/s77o7lGA6InfdsnqviK2iU70I6ww9NBY0DBqJYBvoilr+Z0ei7BaGkP5wughoExpr5
         +cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261127; x=1691853127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZf0qeWm+WX+bv1IFZf8K1PwMyRHAPQhF5RBE2OKQPA=;
        b=hLmnGOuHTrz8NoSv+YXT6ngTNu07lYOHQd7MtHPis1KWqXGZo3G5jOnTeQMJaxGSpK
         LRXNyjUxXjLqWvSJ29NZM7JIVRyrRvx42ICZ8sb20e4UW37c7b+Te6ubY84sQV3Wntpf
         gk0DvW8DIsRMnccM7mA6gvbSCKVAsWqPlk1+F+7BKpdf+wSayh962Qij3+81PTXavEuc
         L9lznlnSxjDCnRI9MUBlf/2I73w37osm+LcMvJCiF+wMR4Ki7Q7h/Rr87rcDftwkv8E2
         eW6J387iCJNIZu5h81tGDOuBMtccak4VWA+kXgbV9ANPOgTJgDDoqB1cF84SCeWk5kjz
         +Izw==
X-Gm-Message-State: ABy/qLZH1TsFGtTNfvqX7XzqevTBFP4jQNu32szy6Uvvh3JS5whCykks
        4jZWDAGjfFGXbA/RNUyjvxDZAg==
X-Google-Smtp-Source: APBJJlFkFNYrMUFbwh2cf53W6lfedDnWlkmEMnNDIb2MSpNlVfunzKxcD+6qsHxJqfHT2NQg1TXzlA==
X-Received: by 2002:a05:6000:104d:b0:314:2d59:c6d5 with SMTP id c13-20020a056000104d00b003142d59c6d5mr4451359wrx.15.1689261126945;
        Thu, 13 Jul 2023 08:12:06 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q10-20020adfdfca000000b003144b95e1ecsm8137817wrn.93.2023.07.13.08.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:12:06 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v4 4/5] libstub: Fix compilation warning for rv32
Date:   Thu, 13 Jul 2023 17:07:59 +0200
Message-Id: <20230713150800.120821-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713150800.120821-1-alexghiti@rivosinc.com>
References: <20230713150800.120821-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
---
 drivers/firmware/efi/libstub/efi-stub-kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-kaslr.c b/drivers/firmware/efi/libstub/efi-stub-kaslr.c
index be0c8ab0982a..afb857329799 100644
--- a/drivers/firmware/efi/libstub/efi-stub-kaslr.c
+++ b/drivers/firmware/efi/libstub/efi-stub-kaslr.c
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

