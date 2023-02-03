Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10B689157
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjBCHzn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 02:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjBCHzm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 02:55:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B885921B1
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 23:55:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so3209292wms.1
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 23:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzLCWkEIOjhYvr7p7s7uKUj96vyQiWAZD9+xORl+Fd4=;
        b=RNbsXzhKVKZxHcgsFaAKcfD9UisdA54thxQEMptVrQU50TCPpIrIoDoH5Mrs7FLXcC
         TvIDeuAwtQfvPqHlkhztQSpgHOhD+ZBeX/Yj0qNU2lDiIltrMSKOAH0/xJ/bSe6VJnpp
         UAk0ZYxoTsPGOaXgrPrBVoXkmbk16GogJR/EKsHE/HFgkcbjNPfJimSuJgqHiMoQqaA7
         GjpWmzJ0KuF6Pcc1+xYmELaKCHCT3o9guF4QNy2wCQGpsrFYCnnGNJxS2vT11IFzEIqG
         D0/RB2ZTFAcLMwPojzCsn2VX8d4VL1jnYSnZ/7a/uHAmHEXoFShAAwCWIr7bev0YulQ4
         zgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzLCWkEIOjhYvr7p7s7uKUj96vyQiWAZD9+xORl+Fd4=;
        b=oKTmnygiGKuRYPhIbDVHHBY3Gc8p/8DWsq3wP5ND8h7KHqpqmz97Y4pRfcrdESLkXL
         Oy22JI9IhNv3AlYIqC5OYSPfZcpyZWrsHC/rrPLtSatAhKrpy/dbSqNLKT91Yi0NuDn2
         pRqLw79Z2Ke7e94g3gC+C5v6SSkkxPi2sXic2pwGJREsyCfdDJDuzmjS/LYz4vwVHaOR
         Fj5/7jWdWNkfwNBctHZvmcSH4+8CqVtXD/STmhyc6RbMy2uIZ9PJksw1LpJ9dZiN9Cc8
         hSRrAYSFH8iJbZLcDBzBBmfoVt7/NfdZX8wSZuonul6STEeuaEy2VXHn4gvsvVQF30U4
         vkpA==
X-Gm-Message-State: AO0yUKVhiPsgBhTV1RiPPOSPMmcZmZlk4Ult3rxLR+qe05LoOaF5H21i
        RZju6aLNhX6QPqOyM5dbUXuKpw==
X-Google-Smtp-Source: AK7set8Ng4rWQLKejgMNowdItupEL7W3ghbSkoK2CGvBB2irYgdK4IKmwO7aKmqD1n06vvjIFgC7Rg==
X-Received: by 2002:a1c:6a01:0:b0:3df:de28:f819 with SMTP id f1-20020a1c6a01000000b003dfde28f819mr4504287wmc.15.1675410938775;
        Thu, 02 Feb 2023 23:55:38 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm6820254wmc.31.2023.02.02.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:55:38 -0800 (PST)
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
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
Date:   Fri,  3 Feb 2023 08:52:29 +0100
Message-Id: <20230203075232.274282-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
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
index 478d6763a01a..87f6a5d475a6 100644
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

