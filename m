Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1C697ECA
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBOOxY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 09:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBOOxV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 09:53:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099039BBD
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:53:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so19402821wrg.13
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW33dZcmgamFLHOTdXPHNpGgKYwkutrhlJjCm0kdncM=;
        b=6f34A81AdUxOH0WhwVsAvnd7QnICuPh2mkx2g5yciHqCqPGB4OLnzv6jky6q1O/hfm
         U8F+RjNXec7Y3q/+PaEfH5Gy/8JiPNBVK+ekDTDUwVbuHxDvJY2pBvK+7o3JLJYKBeVc
         +3bZj2WL+kSOUhvYVXJeDXUBE/x1YUhkmTJa1BP/fJrk3Upr2bOataEn5EsQDgE7Al0l
         p/MwLupVTscio/uIUYgKKQNBp2N8PnioSN8WwCs3TQ+r0TJf5OikyF5qKuiiV1kwRMsT
         38ZAAhCzhyz2clBQG8uC/c7VjaxqSlOcpzoWyNMmtBvZfPDu2mzkVHsF2Oz4Z87rstpo
         ecJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FW33dZcmgamFLHOTdXPHNpGgKYwkutrhlJjCm0kdncM=;
        b=AwQC9iqNAGOS9aGY5fli+6F2Rrsn58GUjLgreuC/9mb6GjfwDlSxhhw95RrRz5u/2q
         YIOlJXJ8q4uF1zlLKd3oJgD6nFtLHDclBY5DqoKl+Epu22n+gJ1ITs6JQr2sdt1eMGTa
         7Mt0e4cQaFjywCLxSfzf0FI+l3fhBqCDoHncEv8WPGb7wLJaRPEPgplOHLXZ4SugFwQH
         xaHM1Uk7HegQeoafv5+xGdOOG5v2m5dXjL+mN1xVRPM+rxmfM5IGy5leP5WXBZA0vEYD
         dsohIugh29Tduta8tWEHapnmpkDI5x48E0qV/BAJY4OHGKelo3bRGSbp9ovGxUf8wIpP
         Ss2A==
X-Gm-Message-State: AO0yUKWfNRWgVoKVAYWfCPLG33Xj8mo5xBFWnos4YuY5gsB4nskBnvyV
        2BK1HXyW8JP8wjqSt19VNE/imw==
X-Google-Smtp-Source: AK7set/WnuTHm92+t20uOay6ITH6KB/xE4G2qx8LvXnqLdm4L7GdGScfCmsVgnF5z780Nk79xDddFQ==
X-Received: by 2002:a5d:404c:0:b0:2c5:5881:be0f with SMTP id w12-20020a5d404c000000b002c55881be0fmr1904111wrp.25.1676472797736;
        Wed, 15 Feb 2023 06:53:17 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm15411785wrt.3.2023.02.15.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:53:17 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/4] riscv: Dump out kernel offset information on panic
Date:   Wed, 15 Feb 2023 15:51:11 +0100
Message-Id: <20230215145113.465558-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215145113.465558-1-alexghiti@rivosinc.com>
References: <20230215145113.465558-1-alexghiti@rivosinc.com>
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

Dump out the KASLR virtual kernel offset when panic to help debug kernel.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 86acd690d529..d33065f4c084 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
@@ -330,3 +331,27 @@ void free_initmem(void)
 
 	free_initmem_default(POISON_FREE_INITMEM);
 }
+
+static int dump_kernel_offset(struct notifier_block *self,
+			      unsigned long v, void *p)
+{
+	pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
+		 kernel_map.virt_offset,
+		 KERNEL_LINK_ADDR);
+
+	return 0;
+}
+
+static struct notifier_block kernel_offset_notifier = {
+	.notifier_call = dump_kernel_offset
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &kernel_offset_notifier);
+
+	return 0;
+}
+device_initcall(register_kernel_offset_dumper);
-- 
2.37.2

