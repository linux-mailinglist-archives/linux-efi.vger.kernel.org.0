Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362211D6246
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEPPhm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgEPPh0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 11:37:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464AEC05BD0B;
        Sat, 16 May 2020 08:37:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so5336509ljj.11;
        Sat, 16 May 2020 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCfDgD0BOTw7K9rKkuVs5dDCTL68za+UymQx9p6OCAo=;
        b=Tu95+p9LzkryZ16vSFZZQPj7/Fw+f6F4Qd52s6KxDrpoMlLM6glOlN/7FxCAdHIxgm
         vSbowE8l/GmXrqZgkQ9FoNdCoCcXSr6WwbgF85fOMhy502POhoZcHbGULKcxZC7sLx+P
         mF3xhaiD8ijbJVKjyhetN1hE3spflbHWTDgdr+WUvzISCsCl2y3gO036TN3A+R4l25WD
         yN8kZHV5l7j1gtfJr/T9pqqsu7UB+OMCffo9W5wo/26Do1RLJjsWH4HxijkvhYsRlxAO
         DQnxGCqvldqp3xRObAOuL80oefJfL6Hy+qF/K7RO8bz8FeRyAcSxzJsav1oBjLMxQYw6
         VNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCfDgD0BOTw7K9rKkuVs5dDCTL68za+UymQx9p6OCAo=;
        b=un31ORivh+G4dUM4AxtVAIzISF765TxBUKxghU/sL+QWbf+0QaB/Y7hvXfRC9O9xMh
         qnBXI5k8X1vXZk91ByfU5iIwuyCUP5MlH0WhboquzKeBKnHWOg7wdJ9zqvuJxoniu+Dq
         aODQVmRPge0I3xplEcroSFcNur96nysiVo3TC5nq2hGxuxU4xmtAGCVz3B5/xm2oUNmA
         S0MAhg7AzC9ONPDE0JQy1wQY0a+uibGeE5fp68aFEQgVWPCTuareZYqo8ff0mkyW2OEk
         37kDaUX0PVMIppEdFUsZv3InhInU+gOVoubCV75s9TtiFTo/xQyt70iYrF9iFnftkIgc
         fT0Q==
X-Gm-Message-State: AOAM532ebaP/1Fp3S1DWHFyJrkxS8Jns3zsToNl3/mgWfc+loVjG9oLd
        NDMuEmZslGzMSS9BIs/kqWw=
X-Google-Smtp-Source: ABdhPJyjz6TSw1+Q50zR2PhQEFqRV9q4+gSgAVTNYqnkDFl5nbJo2ngLzGQ96G1iDJ8aI7KbZ9oO7w==
X-Received: by 2002:a2e:3a10:: with SMTP id h16mr4897156lja.49.1589643444763;
        Sat, 16 May 2020 08:37:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm2845356ljj.64.2020.05.16.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 08:37:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?q?Nils=20=C3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v5 6/6] soc/tegra: Expose Boot Configuration Table via sysfs
Date:   Sat, 16 May 2020 18:36:44 +0300
Message-Id: <20200516153644.13748-7-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200516153644.13748-1-digetx@gmail.com>
References: <20200516153644.13748-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

It's quite useful to have unencrypted BCT exposed to userspace for
debugging purposes, so let's expose it via sysfs.  The BCT data will be
present in '/sys/tegra/boot_config_table' binary file if BCT is available.

Suggested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c  |  4 +++
 drivers/soc/tegra/Makefile   |  1 +
 drivers/soc/tegra/bootdata.c | 51 ++++++++++++++++++++++++++++++++++++
 drivers/soc/tegra/common.c   | 17 ++++++++++++
 include/soc/tegra/bootdata.h |  2 ++
 include/soc/tegra/common.h   |  3 +++
 6 files changed, 78 insertions(+)
 create mode 100644 drivers/soc/tegra/bootdata.c

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index da6bcd85398b..5f40463f1b97 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -72,6 +72,7 @@ static void __init tegra_boot_config_table_init(void)
 	u32 iram_end   = TEGRA_IRAM_BASE + TEGRA_IRAM_SIZE;
 	u32 iram_start = TEGRA_IRAM_BASE;
 	u32 pt_addr, pt_size, bct_size;
+	void __iomem *bct_ptr;
 
 	t20_bit = IO_ADDRESS(TEGRA_IRAM_BASE);
 
@@ -90,6 +91,7 @@ static void __init tegra_boot_config_table_init(void)
 
 		pt_addr = t20_bct->partition_table_logical_sector_address;
 		pt_size = t20_bct->partition_table_num_logical_sectors;
+		bct_ptr = t20_bct;
 
 	} else if (of_machine_is_compatible("nvidia,tegra30")) {
 		bct_size = sizeof(*t30_bct);
@@ -106,12 +108,14 @@ static void __init tegra_boot_config_table_init(void)
 
 		pt_addr = t30_bct->partition_table_logical_sector_address;
 		pt_size = t30_bct->partition_table_num_logical_sectors;
+		bct_ptr = t30_bct;
 	} else {
 		return;
 	}
 
 	pr_info("%s: BCT found in IRAM\n", __func__);
 
+	tegra_bootdata_bct_setup(bct_ptr, bct_size);
 	tegra_partition_table_setup(pt_addr, pt_size);
 }
 
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index 9c809c1814bd..8be2bfb4d95d 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += fuse/
 
+obj-y += bootdata.o
 obj-y += common.o
 obj-$(CONFIG_SOC_TEGRA_FLOWCTRL) += flowctrl.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
diff --git a/drivers/soc/tegra/bootdata.c b/drivers/soc/tegra/bootdata.c
new file mode 100644
index 000000000000..e18a27b74023
--- /dev/null
+++ b/drivers/soc/tegra/bootdata.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <soc/tegra/bootdata.h>
+#include <soc/tegra/common.h>
+
+/*
+ * spare_bct[] will be released once kernel is booted, hence not wasting
+ * kernel space if BCT is missing. The tegra_bct can't be allocated during
+ * of BCT setting up because it's too early for the slab allocator.
+ */
+static u8 spare_bct[SZ_8K] __initdata;
+static u8 *tegra_bct;
+
+static ssize_t boot_config_table_read(struct file *filp,
+				      struct kobject *kobj,
+				      struct bin_attribute *bin_attr,
+				      char *buf, loff_t off, size_t count)
+{
+	memcpy(buf, tegra_bct + off, count);
+	return count;
+}
+static BIN_ATTR_RO(boot_config_table, 0);
+
+static int __init tegra_bootdata_bct_sysfs_init(void)
+{
+	if (!bin_attr_boot_config_table.size)
+		return 0;
+
+	tegra_bct = kmalloc(GFP_KERNEL, bin_attr_boot_config_table.size);
+	if (!tegra_bct)
+		return -ENOMEM;
+
+	memcpy(tegra_bct, spare_bct, bin_attr_boot_config_table.size);
+
+	return sysfs_create_bin_file(tegra_soc_kobj,
+				     &bin_attr_boot_config_table);
+}
+late_initcall(tegra_bootdata_bct_sysfs_init)
+
+void __init tegra_bootdata_bct_setup(void __iomem *bct_ptr, size_t bct_size)
+{
+	memcpy_fromio(spare_bct, bct_ptr, bct_size);
+	bin_attr_boot_config_table.size = bct_size;
+}
diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 3dc54f59cafe..2b4b49eacb2e 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -3,10 +3,15 @@
  * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/sysfs.h>
 
 #include <soc/tegra/common.h>
 
+struct kobject *tegra_soc_kobj;
+
 static const struct of_device_id tegra_machine_match[] = {
 	{ .compatible = "nvidia,tegra20", },
 	{ .compatible = "nvidia,tegra30", },
@@ -31,3 +36,15 @@ bool soc_is_tegra(void)
 
 	return match != NULL;
 }
+
+static int __init tegra_soc_sysfs_init(void)
+{
+	if (!soc_is_tegra())
+		return 0;
+
+	tegra_soc_kobj = kobject_create_and_add("tegra", NULL);
+	WARN_ON(!tegra_soc_kobj);
+
+	return 0;
+}
+arch_initcall(tegra_soc_sysfs_init)
diff --git a/include/soc/tegra/bootdata.h b/include/soc/tegra/bootdata.h
index 7be207cb2519..d5c7a251517d 100644
--- a/include/soc/tegra/bootdata.h
+++ b/include/soc/tegra/bootdata.h
@@ -43,4 +43,6 @@ struct tegra30_boot_config_table {
 	u32 unused_data[3];
 } __packed;
 
+void tegra_bootdata_bct_setup(void __iomem *bct_ptr, size_t bct_size);
+
 #endif /* __SOC_TEGRA_BOOTDATA_H__ */
diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index 744280ecab5f..0bc11b45c98e 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -7,8 +7,11 @@
 #define __SOC_TEGRA_COMMON_H__
 
 #include <linux/types.h>
+#include <linux/sysfs.h>
 
 #ifdef CONFIG_ARCH_TEGRA
+extern struct kobject *tegra_soc_kobj;
+
 bool soc_is_tegra(void);
 #else
 static inline bool soc_is_tegra(void)
-- 
2.26.0

