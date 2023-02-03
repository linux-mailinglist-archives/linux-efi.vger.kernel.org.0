Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFC689165
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 08:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBCH7J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 02:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjBCH6o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 02:58:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ADF4B890
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 23:58:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so1720669wms.0
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 23:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=871OGCI0aHwZZE6OKggKudWipUlPKXToB5Kn7OlT7Ew=;
        b=zxo+RmsRYbmTV2GBrpNufXdujUjhcH0oMw9j5vw4ZRalgJ4I1cOhlV1C6t1CiPO9Zp
         YaaGRnQszq9GGZq6WxD+7C92ArWV6pidfP5FKA4avWgqAagZ8rjf7xji+cN7YukH2I2k
         wqeisO5oGVk9dgLC2pqP54eE8M51d7EXmkXxarn7ku5SQQFhvuV/8ywSMfkz1OVsFhgf
         ThAyJzUtj/rTZAGZuYcsw9bAQX3egZJxoPAtCYO5ube6UuxkJZhv47CZFl6S62yZ44KL
         lliwcfw3Mt5NrBTeSEwXw5eT/gLhpc1gtyvk/S+vfw1G6F450VMIo2gYYaYTT7VcIZbN
         CZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=871OGCI0aHwZZE6OKggKudWipUlPKXToB5Kn7OlT7Ew=;
        b=tF+QvRdLbvYSNc7/CNJtQrYexVlVsMGCs8R4EdwlhMtxsc1vnTb4zTuK/09ap0rJta
         qjt2nTwSBTs6lAiwhOZ/FQswOgTGZCw8b9a3vseVZ6VvBnCMcMAyq/u9q/+qUY+PGEoQ
         nYphFIPTqq8ZWpzOtNX9W29wZsrCt+LqZXRN4LXIp11j5lAzdVjbIBI/X1f+Q57EaSaT
         q7H0shF+FrERNyVaTGTA8Js8+w75trvhzFoN9mA91o+Ri0l3FB2m+QazaY22W3pOtmUq
         Wzq3Hviyx7BLqektT2a5q/iD+83/Ib0Wt58HTLnxK5GbusfV/IwH+LGwN9Gh0iUHOaxI
         fl/Q==
X-Gm-Message-State: AO0yUKU7FWllZj2ecsFcx7mxEKEzjOXSIH0nJI0rN13/jRoEtDH2etMd
        OlEBfDVd43FaGvbxer3ghoTPQQ==
X-Google-Smtp-Source: AK7set/fcrczUSS6O74y0FBZWDMhE3+GRJrRdbPuvTZ/5CyO7Dk5VOPCkEvL96gQxIUxMHi1viU1eA==
X-Received: by 2002:a05:600c:cca:b0:3db:1919:41b5 with SMTP id fk10-20020a05600c0cca00b003db191941b5mr8877209wmb.21.1675411121802;
        Thu, 02 Feb 2023 23:58:41 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003dc433355aasm2034857wmn.18.2023.02.02.23.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:58:41 -0800 (PST)
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
Subject: [PATCH v4 6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
Date:   Fri,  3 Feb 2023 08:52:32 +0100
Message-Id: <20230203075232.274282-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
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

If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..0f226d3261ca 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -117,6 +117,7 @@ config RISCV
 	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-- 
2.37.2

