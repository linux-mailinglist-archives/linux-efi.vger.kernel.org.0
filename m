Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25139469457
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhLFKzw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 05:55:52 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47830
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241772AbhLFKzw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 05:55:52 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 136723F1B2
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638787943;
        bh=9ySCV26avDqOMq3ybehcXkQhwvvZ5wxe1+MhhnplIPU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UYaXq9O6pwsUGZwb6iKUO+bpEpV7o9GD0YvP/WvzYl8m0qzZEq6oEkpc+oiKjZG8L
         Cz2ZAf3PublRNK9RnbvG3h1P9mB5J1Kkt38N9iSSzj7noH8hhko0AXq54BTK5+DQx6
         MiFZkiSGnqgsMzBh9PE6baSvp4ESY/KYjUqMVugYcoh8hEDJjB5tRxhHfGGjtLOlL1
         Z77STNKnYYf7IXIrBLoGOPkUEgietTQzAs3J2QZFlowQZDt1aGJfH/gTMSm1HpE3Bx
         BZAHNVacTqI94BYcijuPA7SoZUxFVKmkwwjgZulQKo/aAnXu3+3HJKKf32ZS4iojgW
         nJk4dOfu3nqZQ==
Received: by mail-wm1-f69.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so7674854wma.5
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 02:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ySCV26avDqOMq3ybehcXkQhwvvZ5wxe1+MhhnplIPU=;
        b=tkAIdUIE5aYaC7mlY9I6RTNcC3mklqqJbidYZ8QINTPo+mQml+0Idj6W3wxPOc+dtz
         uGPau3czycHLj4OuRhINCseZzzDsvysKT6ERLtLzEATfFBFzHdPD++uHvd0obBgDFuSk
         Ex26OdnUDqxN7tz8CeP08UtHFoCrwE2SUqADHsJcOOl1BEXqYwLZMlNNEY/zxd7iZIrm
         qvs4mv6hPJAsXOI2FGIAVxiGXC8DY1X3bDPYLUTchwqdZawD9QS/JB56BR/NETjHRKR/
         iNKxTGio4VrZGulorsG4hKZJinQ6lnOJ/bmQriqeeuDjP3iFTVWbE5r4eV7D7OLsGJpV
         KG1g==
X-Gm-Message-State: AOAM530x/DCxAOOpa8jgYqh0y4/STChC39BrU1NvTh5KjxD1iBjD3U+Z
        d3uck/zKjuQMKp0W1lZLfUUqeVeaW35pmguWuHRRxYGY/ha2YS8M8uITOCE/FetTUyAqagTPtvw
        PkkMtVdbXAVyg/Ll8mOtDCsVEo9UP75O3K/E5VA==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr41541830wrw.628.1638787942764;
        Mon, 06 Dec 2021 02:52:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG45T87x/hgkvmCoRGy/akWlcOnI21JXsfnjT5Dkr0Aq51ptEmkRfn19MELBpl7ATpCMOj8g==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr41541802wrw.628.1638787942625;
        Mon, 06 Dec 2021 02:52:22 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id l2sm13828074wmq.42.2021.12.06.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:52:22 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
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
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 05/13] riscv: Get rid of MAXPHYSMEM configs
Date:   Mon,  6 Dec 2021 11:46:49 +0100
Message-Id: <20211206104657.433304-6-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CONFIG_MAXPHYSMEM_* were actually never used, even the nommu defconfigs
selecting the MAXPHYSMEM_2GB had no effects on PAGE_OFFSET since it was
preempted by !MMU case right before.

In addition, I suspect that commit 2bfc6cd81bd1 ("riscv: Move kernel
mapping outside of linear mapping") which moved the kernel to
0xffffffff80000000 broke the MAXPHYSMEM_2GB config which defined
PAGE_OFFSET at the same address.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/Kconfig                            | 23 ++-----------------
 arch/riscv/configs/nommu_k210_defconfig       |  1 -
 .../riscv/configs/nommu_k210_sdcard_defconfig |  1 -
 arch/riscv/configs/nommu_virt_defconfig       |  1 -
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c3a167eea011..ac6c0cd9bc29 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -148,10 +148,9 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
+	default 0xC0000000 if 32BIT
 	default 0x80000000 if 64BIT && !MMU
-	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
-	default 0xffffffd800000000 if 64BIT && MAXPHYSMEM_128GB
+	default 0xffffffd800000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
 	hex
@@ -260,24 +259,6 @@ config MODULE_SECTIONS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
-choice
-	prompt "Maximum Physical Memory"
-	default MAXPHYSMEM_1GB if 32BIT
-	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
-	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
-
-	config MAXPHYSMEM_1GB
-		depends on 32BIT
-		bool "1GiB"
-	config MAXPHYSMEM_2GB
-		depends on 64BIT && CMODEL_MEDLOW
-		bool "2GiB"
-	config MAXPHYSMEM_128GB
-		depends on 64BIT && CMODEL_MEDANY
-		bool "128GiB"
-endchoice
-
-
 config SMP
 	bool "Symmetric Multi-Processing"
 	help
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index b16a2a12c82a..dae9179984cc 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -30,7 +30,6 @@ CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
 CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 61f887f65419..03f91525a059 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -22,7 +22,6 @@ CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
 CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0 rootdelay=2 root=/dev/mmcblk0p1 ro"
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index e046a0babde4..f224be697785 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -27,7 +27,6 @@ CONFIG_SLOB=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 # CONFIG_MMU is not set
 CONFIG_SOC_VIRT=y
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
 CONFIG_CMDLINE_FORCE=y
-- 
2.32.0

