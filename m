Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0BC41C79D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Sep 2021 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbhI2PAg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Sep 2021 11:00:36 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60484
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344831AbhI2PAg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Sep 2021 11:00:36 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BD563F325
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927534;
        bh=RA0oQ/GNq6rz6phpPIFpMyTQ81TXHbN7QIZjBCAB7To=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=l+/JyiBnDPKvR2nQlDVIa/QzVGDvBjjbn90StDzN4VXH9JlotG3wLRxiowVKzWS4C
         R7j0U/7pMQMZIgDgYmH9Kmw+7FhtuHTsWmtIMAKIToSxbMl9YcoTWNbADiEBs7KFol
         5qh07nFndYXKst/v9BG7iZ9obHKvqNH+bxmRMBEIWgJXUl7yNnEGAkPc3XvNGFXdEt
         wt21KbYoJCTYA4Dhj7eudsjlJw/2QuqrUougicEyZVMO6Vi5yfZgFOKIg1cQD4klRX
         XieViW5V71k/i5/uVchZr+0DSLpQg2pSt57VHglmTFLhWnr7h5Qz77yfy0B0w1NpW8
         X5vCxC2hfpRrw==
Received: by mail-ed1-f70.google.com with SMTP id x26-20020a50f19a000000b003da81cce93bso2679290edl.19
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 07:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RA0oQ/GNq6rz6phpPIFpMyTQ81TXHbN7QIZjBCAB7To=;
        b=jF8Snid9iQoaYOUuxdUkRfB4uciZQjFbYO6gRtBdGtL4PcOWA/5BVf9nlu8WBSYSvu
         cGOyqE4OEOaBS64HTs4cKCQqA8wDERUongrwkhvrK5Yhx/T6Zc+KQXrFcikxnzHQJ0wt
         0rbvL2dnzWYvzBBT96TMxjLhkAFajeOVGFrwn7/2aeGJzknUEB+B9L/+weTRWT173/fC
         4XufoCj2NbdvQeN1eU1cBc4czmhEKjJGMEBnX3aOtLUYUkpXzuCYh5azGlH4kP3uclsP
         Z8wp76etGAZfKAgyYTPN9TeabBQC6PqpS8kwLgpDRiAIB+55IDYGw+SQPiWzAeTFzeuy
         2yMA==
X-Gm-Message-State: AOAM5332wwx4pEA1qvx1o4XcoiKhX9ymOoYioojWTEpimVzkqA0AKDIe
        igAczUYI5ZVEekmDgjvoJguYQXNC/5qyiTipM8Hz/T3iARBakCIn8XcOyrURpJQzLT+75W1Cmbv
        a/9TVKafEqqAM5d7dwpPDnChrZkD/zRrLOWoAwQ==
X-Received: by 2002:a5d:4601:: with SMTP id t1mr337438wrq.298.1632927523931;
        Wed, 29 Sep 2021 07:58:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Xul4YkTp0i2000EdwnyM/dfQJdSoDvVKFV41EJ96ssAvHUBnlQjrNR56d8PaVsoSbDyBOQ==
X-Received: by 2002:a5d:4601:: with SMTP id t1mr337419wrq.298.1632927523734;
        Wed, 29 Sep 2021 07:58:43 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id c7sm142194wmq.13.2021.09.29.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:58:43 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 07/10] riscv: Improve virtual kernel memory layout dump
Date:   Wed, 29 Sep 2021 16:51:10 +0200
Message-Id: <20210929145113.1935778-8-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With the arrival of sv48 and its large address space, it would be
cumbersome to statically define the unit size to use to print the different
portions of the virtual memory layout: instead, determine it dynamically.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/init.c  | 65 +++++++++++++++++++++++++++++++++----------
 include/linux/sizes.h |  1 +
 2 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d7de414c6500..a304f2b3c178 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -90,34 +90,71 @@ static void __init zone_sizes_init(void)
 }
 
 #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
+
+#define LOG2_SZ_1K  ilog2(SZ_1K)
+#define LOG2_SZ_1M  ilog2(SZ_1M)
+#define LOG2_SZ_1G  ilog2(SZ_1G)
+#define LOG2_SZ_1T  ilog2(SZ_1T)
+
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
-		  (((t) - (b)) >> 10));
+		  (((t) - (b)) >> LOG2_SZ_1K));
 }
 
 static inline void print_mlm(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
-		  (((t) - (b)) >> 20));
+		  (((t) - (b)) >> LOG2_SZ_1M));
+}
+
+static inline void print_mlg(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld GB)\n", name, b, t,
+		  (((t) - (b)) >> LOG2_SZ_1G));
+}
+
+#ifdef CONFIG_64BIT
+static inline void print_mlt(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld TB)\n", name, b, t,
+		  (((t) - (b)) >> LOG2_SZ_1T));
+}
+#endif
+
+static inline void print_ml(char *name, unsigned long b, unsigned long t)
+{
+	unsigned long diff = t - b;
+
+#ifdef CONFIG_64BIT
+	if ((diff >> LOG2_SZ_1T) >= 10)
+		print_mlt(name, b, t);
+	else
+#endif
+	if ((diff >> LOG2_SZ_1G) >= 10)
+		print_mlg(name, b, t);
+	else if ((diff >> LOG2_SZ_1M) >= 10)
+		print_mlm(name, b, t);
+	else
+		print_mlk(name, b, t);
 }
 
 static void __init print_vm_layout(void)
 {
 	pr_notice("Virtual kernel memory layout:\n");
-	print_mlk("fixmap", (unsigned long)FIXADDR_START,
-		  (unsigned long)FIXADDR_TOP);
-	print_mlm("pci io", (unsigned long)PCI_IO_START,
-		  (unsigned long)PCI_IO_END);
-	print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
-		  (unsigned long)VMEMMAP_END);
-	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
-		  (unsigned long)VMALLOC_END);
-	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
-		  (unsigned long)high_memory);
+	print_ml("fixmap", (unsigned long)FIXADDR_START,
+		 (unsigned long)FIXADDR_TOP);
+	print_ml("pci io", (unsigned long)PCI_IO_START,
+		 (unsigned long)PCI_IO_END);
+	print_ml("vmemmap", (unsigned long)VMEMMAP_START,
+		 (unsigned long)VMEMMAP_END);
+	print_ml("vmalloc", (unsigned long)VMALLOC_START,
+		 (unsigned long)VMALLOC_END);
+	print_ml("lowmem", (unsigned long)PAGE_OFFSET,
+		 (unsigned long)high_memory);
 #ifdef CONFIG_64BIT
-	print_mlm("kernel", (unsigned long)KERNEL_LINK_ADDR,
-		  (unsigned long)ADDRESS_SPACE_END);
+	print_ml("kernel", (unsigned long)KERNEL_LINK_ADDR,
+		 (unsigned long)ADDRESS_SPACE_END);
 #endif
 }
 #else
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index 1ac79bcee2bb..0bc6cf394b08 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -47,6 +47,7 @@
 #define SZ_8G				_AC(0x200000000, ULL)
 #define SZ_16G				_AC(0x400000000, ULL)
 #define SZ_32G				_AC(0x800000000, ULL)
+#define SZ_1T				_AC(0x10000000000, ULL)
 #define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.30.2

