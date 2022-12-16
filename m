Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D464EEFA
	for <lists+linux-efi@lfdr.de>; Fri, 16 Dec 2022 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLPQZn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Dec 2022 11:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiLPQY6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Dec 2022 11:24:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EAF5EDD4
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:24:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so4488140wmb.2
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKAmpdKbBscT+wI0zsC3ixLztutjRoSSvZIlGNHmM4Q=;
        b=5zZ212IkhjKj94ipOAPbwYPYOlsIe2Q2iWqZ84pUt+gO3r0Eyarf711NDpKVO1C14q
         nc7RKDG6tdAFzkDUhRHwpMXM+IdQ7pAncnZIS/bWk/Hi0ReDG9cPXdIIugmvowrmL6wv
         LMTwApz9J7YrsCYDgOiiPW37lHNWWdAZw1sOVAgSDioakBmFysGZiya7IoZO/Vgqhhwf
         SLaq/M9LNpwE9S8g2yUbEIti1w6dDDrrElKg7SELhEGIvFdL8X/d9W70ns0APlzb3KLh
         EyU6JIbiXwoEnIPZ0d5qtYxPEjutK2P0Q/qFUR125kgS+E3BEfl91D5jcEuGMxVOc/Kl
         QPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKAmpdKbBscT+wI0zsC3ixLztutjRoSSvZIlGNHmM4Q=;
        b=Hbkc01c4cMuQslwS2sf1ur2UVCSX5Cqyxzc2cq1udyVbWzghi7/14gLBq/n3EPUjxb
         4ec4lYmmtT4Y/KEbadAUygiXqV7x5ML7Mq7XiNQ9r5X1asj1c+Kc2+dcxdJShpkfOoNw
         pId3ogvS3E+ZBzE1JHEkzAgdkj3LPAf52V9PVox7gEgwR0ZhwErKau+LE/uMMrPwce52
         7YVDqT6HAEApvr//mKlJUrapCriWCWei1IZIzz+pguC1+pTjn83DQlyS7rmhPTWxyLSO
         cLQ1T8rqN9Il/dfNGf9hqW5UnoGOnquZEUZiioPyXIgU4WiYFFmABvKt1Kl6jA6W6vQ0
         nRmA==
X-Gm-Message-State: ANoB5pnRDoUK8v7ZAhNkZnRfPimO4dDuNlx1kLgO9coG3EVrCjK4by6y
        +BZgZJDHX8ePhL3IbP/ItiCbKA==
X-Google-Smtp-Source: AA0mqf7Kp1ma3mcIhSnx5tq7MByphnU57QGiZGBYUPbdSWTo0NaGRsZNrXC6At0HrKNSMT9J+W//Ew==
X-Received: by 2002:a05:600c:4f89:b0:3cf:d0be:1231 with SMTP id n9-20020a05600c4f8900b003cfd0be1231mr36102867wmq.13.1671207895040;
        Fri, 16 Dec 2022 08:24:55 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003d23a3b783bsm3450995wmq.10.2022.12.16.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:24:54 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
Date:   Fri, 16 Dec 2022 17:21:38 +0100
Message-Id: <20221216162141.1701255-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221216162141.1701255-1-alexghiti@rivosinc.com>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The early virtual address should lie in the kernel address space for
inline kasan instrumentation to succeed, otherwise kasan tries to
dereference an address that does not exist in the address space (since
kasan only maps *kernel* address space, not the userspace).

Simply use the very first address of the kernel address space for the
early fdt mapping.

It allowed an Ubuntu kernel to boot successfully with inline
instrumentation.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 58bcf395efdc..d5aa6ca732f2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -57,7 +57,7 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-#define DTB_EARLY_BASE_VA      PGDIR_SIZE
+#define DTB_EARLY_BASE_VA      (ADDRESS_SPACE_END - (PTRS_PER_PGD / 2 * PGDIR_SIZE) + 1)
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
-- 
2.37.2

