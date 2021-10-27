Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94343D1F8
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 21:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbhJ0T7I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbhJ0T7I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Oct 2021 15:59:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926DC061745
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 12:56:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bm16so3585279qkb.11
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bk3kSkKiF5+O1U3fMNyG9S2RIMzTHPEiiZAyUjokpWc=;
        b=QiK12Ulg/hzbwNQi3SakK5nMPg08HZm5FGmG1t9uBF8GcbLFx8zYlG3AZ44uUah6HC
         ApTS9ZysgI6CNXMOnvKkk1bkKx8mWYPiv2ZIcN3CWx4NfYNjIl5OrbqB3hZnQawMzXsZ
         6/m5brrDIU8LIFthz0xjUjTbIgccrcje+D/EKkNntUSwyFr0t80kUnelyIk6S5sw+IjW
         blRtjWERL4aF1lXFPXF/LHl3UUgpF/x3IL9sOVih/Pp97Q2sBQgeWWj2SOuEfiBjIOz4
         /yT7lcTFk0TB7GmxUbBNxvA/UsKiIzAz9rHZEIFB1zdgrVqCcAMySFyzaVzXdgeAsXvC
         +Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bk3kSkKiF5+O1U3fMNyG9S2RIMzTHPEiiZAyUjokpWc=;
        b=kb8rG9hclLNOL0SCEXFio0/bXHr5Zxy3GyfSc10cXzPYDcyKjm0xlMNRSa++WSr1O7
         UUN5ddpqV0lwU2q6gMirPNef6nHi5laFChOxUb1UytKrBpt0yrUNIzjOcUhUHIp7UbFw
         93OWI1sq3YclhhAsDZNLiE2h4a7L5b9wJc7m6AIJ5zdGqgfzqTsd5ttoGLPBbH4c5IBp
         xD8amFnBx0BRN1P2uRpt/oFBsScfMnM6InROvgwzHrrV+alQSNBTrUnvmR+oW650HR2y
         Ph9rwDEQIlsCiAWTgR86XRlhwJvO4d8yv7l4zaSjznhpDqYQFTe/eyRU8N4eXanK3upu
         gqEA==
X-Gm-Message-State: AOAM530McaCRg8mmabwdwNpZSUh63nD+KV5tdfRraOKl94NRC+hz6UFh
        46lrkmYQEOZlYzBy4KnrOGliBLk78a2LKEphI5zzwpSdfs1ZERMAPgOg/F8yyyyJpgYSiOymMYO
        AyMi6BHQimLXevAMwhFTR0Yf+GYu6ad5x7jTVJ6hDywrdjdi7I1AQwLgMowG2Nd4BNTjtSrQJcC
        xlh3ZYNV3eCPLtSYo=
X-Google-Smtp-Source: ABdhPJz7uJMfj7aX9d8ooPABukgez7mrCLXuCHQ/uOfpJ9StbOgFMXb0ALrFDKw2LpL9k9wUJDWLsQ==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr26151806qkh.232.1635364601626;
        Wed, 27 Oct 2021 12:56:41 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id x22sm713273qkp.103.2021.10.27.12.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:56:41 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com
Subject: [PATCH v2 5/5] Show in sysfs if a memory node is able to do memory encryption
Date:   Wed, 27 Oct 2021 16:55:11 -0300
Message-Id: <20211027195511.207552-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show in each node in sysfs if its memory is able to do hardware memory
encryption, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO
in the EFI memory map.

This value will only be shown if the memory is local to at least one
CPU, since otherwise it won't be able to be encrypted by CPU's
cryptographic capabilities. This check is done against the ACPI's SRAT
table.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 Documentation/ABI/testing/sysfs-devices-node | 12 ++++
 arch/x86/include/asm/numa.h                  |  7 ++
 arch/x86/mm/numa.c                           |  5 ++
 arch/x86/mm/numa_emulation.c                 |  2 +-
 drivers/base/node.c                          | 72 +++++++++++++++++++-
 include/linux/node.h                         |  1 +
 6 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
new file mode 100644
index 000000000000..313fc4193977
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,12 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		October 2021
+Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
+Users:		fwupd
+Description:
+		This value is 1 if all system memory in this node is
+		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
+		system memory is capable of being protected with the
+		CPU’s memory cryptographic capabilities. It is 0
+		otherwise. This attribute will only be available if
+		node X is in ACPI's SRAT table or if it is an emulated
+		node.
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..c3ed5c5be885 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -20,6 +20,13 @@
 #define NODE_MIN_SIZE (4*1024*1024)
 
 extern int numa_off;
+extern int emu_nid_to_phys[];
+
+/*
+ * used_dummy_numa_init indicates whether we used dummy_numa_init for
+ * initialization or not
+ */
+extern bool used_dummy_numa_init;
 
 /*
  * __apicid_to_node[] stores the raw mapping between physical apicid and
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1e9b93b088db..f8d3a0d6bee1 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -20,6 +20,7 @@
 #include "numa_internal.h"
 
 int numa_off;
+bool used_dummy_numa_init;
 nodemask_t numa_nodes_parsed __initdata;
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -712,6 +713,8 @@ static int __init dummy_numa_init(void)
 	node_set(0, numa_nodes_parsed);
 	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
 
+	used_dummy_numa_init = true;
+
 	return 0;
 }
 
@@ -724,6 +727,8 @@ static int __init dummy_numa_init(void)
  */
 void __init x86_numa_init(void)
 {
+	used_dummy_numa_init = false;
+
 	if (!numa_off) {
 #ifdef CONFIG_ACPI_NUMA
 		if (!numa_init(x86_acpi_numa_init))
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index e801e30089c4..f45bc30698e7 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -10,7 +10,7 @@
 
 #include "numa_internal.h"
 
-static int emu_nid_to_phys[MAX_NUMNODES];
+int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
 
 int __init numa_emu_cmdline(char *str)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index c56d34f8158f..b2e1a8832fcf 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/acpi.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
 #include <linux/vmstat.h>
@@ -560,11 +561,39 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t crypto_capable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pglist_data *pgdat = NODE_DATA(dev->id);
+
+	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
+}
+static DEVICE_ATTR_RO(crypto_capable);
+
+static umode_t node_attr_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	umode_t result = 0;
+
+	if (attr == &dev_attr_crypto_capable.attr) {
+		const struct device *const dev =
+			container_of(kobj, struct device, kobj);
+		const int nid = dev->id;
+
+		if (node_devices[nid]->cpu_local)
+			result = attr->mode;
+		/* else: hide the attribute */
+	}
+
+	return result;
+}
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_crypto_capable.attr,
 	NULL
 };
 
@@ -576,7 +605,8 @@ static struct bin_attribute *node_dev_bin_attrs[] = {
 
 static const struct attribute_group node_dev_group = {
 	.attrs = node_dev_attrs,
-	.bin_attrs = node_dev_bin_attrs
+	.bin_attrs = node_dev_bin_attrs,
+	.is_visible = node_attr_is_visible,
 };
 
 static const struct attribute_group *node_dev_groups[] = {
@@ -972,6 +1002,44 @@ static void init_node_hugetlb_work(int nid) { }
 
 #endif
 
+#ifdef CONFIG_NUMA
+#ifdef CONFIG_NUMA_EMU
+static int get_real_nid(int nid)
+{
+	return emu_nid_to_phys[nid];
+}
+#else
+static int get_real_nid(int nid)
+{
+	return nid;
+}
+#endif /* CONFIG_NUMA_EMU */
+
+static void set_cpu_local(int nid)
+{
+	const int real_nid = get_real_nid(nid);
+	bool cpu_local;
+
+	/*
+	 * If we have the SRAT table available we need to check it
+	 * otherwise it's enough to check if real_nid is 0
+	 */
+#ifdef CONFIG_ACPI_NUMA
+	cpu_local =
+		used_dummy_numa_init ? real_nid == 0 : node_to_pxm(real_nid) != PXM_INVAL;
+#else
+	cpu_local = real_nid == 0;
+#endif
+
+	node_devices[nid]->cpu_local = cpu_local;
+}
+#else
+static void set_cpu_local(nid)
+{
+	node_devices[nid]->cpu_local = true;
+}
+#endif /* CONFIG_NUMA */
+
 int __register_one_node(int nid)
 {
 	int error;
@@ -981,6 +1049,8 @@ int __register_one_node(int nid)
 	if (!node_devices[nid])
 		return -ENOMEM;
 
+	set_cpu_local(nid);
+
 	error = register_node(node_devices[nid], nid);
 
 	/* link cpu under this node */
diff --git a/include/linux/node.h b/include/linux/node.h
index 8e5a29897936..d32653fac39e 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -92,6 +92,7 @@ struct node {
 	struct list_head cache_attrs;
 	struct device *cache_dev;
 #endif
+	bool cpu_local;
 };
 
 struct memory_block;
-- 
2.30.2

