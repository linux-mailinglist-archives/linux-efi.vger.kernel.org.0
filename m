Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1034072FE
	for <lists+linux-efi@lfdr.de>; Fri, 10 Sep 2021 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhIJVf4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Sep 2021 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhIJVfz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Sep 2021 17:35:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43FDC061756
        for <linux-efi@vger.kernel.org>; Fri, 10 Sep 2021 14:34:43 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a66so3647133qkc.1
        for <linux-efi@vger.kernel.org>; Fri, 10 Sep 2021 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZYwIVxWg7ffz/INc0659M3nz7BHC8MuosAKhqxPzkU=;
        b=Tn6wwgTeGMkgrkwrC1z7rYgv1fM90Ek1vUU3NH64I5u/easqYfFoVIxLC8BodjM3I+
         0jkORqZpTSb0Rx6Iv2aHYuxPwozfpj79FYjFQxhEN4hqUHO2VeruTFUJ8uQJ0GejN8J6
         htHqwHo+PpU7suawG6upzFbjsk9EHSPDTT4o5MZ0HzGPhKXcgX491xGjymffwoc6oJaF
         Cli/GziKBJ1wgc1YYPYEazSPqi1KuhAg+Yjp6r5gdyyop5DXSq+bOW4l4dlochSgbrUU
         SMZReyVwSJnpExBL6A6wczw6sfkHzdvATqo8aRwF3M4JYChd0tbbFWKyO7fEdaQRiXg3
         CcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZYwIVxWg7ffz/INc0659M3nz7BHC8MuosAKhqxPzkU=;
        b=aS6n7r/4ZNxlNhqsphyWG0iKQE5WS7AN89y96SnHDIMAMLmyHO6Pso5fP6RLI7QhNW
         Je+ZCz9MCYt92ehAOKs6OvA6DAihVmhEfqQkiRzV1IvtfSCL0h3Acg8IxybGfVSvCOs7
         SwunA5bQUtO5gHMvUbLnuGS/oXxlkFzrBtYj+hPCuWTuajve3oJoI6DToJ8S4BD26N9E
         jrzd+BfNjJy6LEewwTCF+xS1jrNNAAN+QFIVHOrv5/8iidAG13SWu7uxCZEzf7f083q0
         APKukQTKD11vxwui9X/I2vl0DsL9zCIG0B1ArzHOEEVAXhNfE4cRvBz21IcPiNz0srnL
         ybHw==
X-Gm-Message-State: AOAM533fRqvWeK9Oqjj//6SA7U3GOhKMslEhHZJlF1tgPrAknMwAIrPp
        ljWNSiadY2nN+f3UOu6P/+3ODGGt6tdqLeDavBIkCbDJmPB/BtJff4iOJfJ6awOFVtC8Kmi5YPD
        /i3j7hGhGEFKXo+gDvMMeM2+4MhJlAc4mBwXu5IuWpeo3IpzPeYnyI3YllEJgFfMGy7eWKULdp4
        TWOdcLtOuuJQBGvzI=
X-Google-Smtp-Source: ABdhPJzo/7teUXbk13m21scFbewXtA/9jQyr6nHm9cNK3GDxUMLUXomRfjSoKQkPzF99xXE9VG2JyQ==
X-Received: by 2002:ae9:e603:: with SMTP id z3mr9889170qkf.413.1631309682668;
        Fri, 10 Sep 2021 14:34:42 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id i27sm4392069qkl.111.2021.09.10.14.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:34:42 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com
Subject: [PATCH 1/1] x86: Export information about hardware memory encryption to sysfs
Date:   Fri, 10 Sep 2021 18:33:37 -0300
Message-Id: <20210910213337.48017-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910213337.48017-1-martin.fernandez@eclypsium.com>
References: <20210910213337.48017-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show on each local memory node if all system memory is flagged with
EFI_MEMORY_CPU_CRYPTO

Reviewed-by: Richard Hughes <hughsient@gmail.com>
Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 Documentation/ABI/testing/sysfs-devices-node | 11 +++
 arch/x86/include/asm/numa.h                  |  2 +
 arch/x86/mm/numa.c                           |  5 ++
 arch/x86/mm/numa_emulation.c                 |  2 +-
 arch/x86/platform/efi/efi.c                  | 27 +++++++
 drivers/base/node.c                          | 80 +++++++++++++++++++-
 include/linux/efi.h                          |  7 ++
 include/linux/node.h                         |  5 ++
 8 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/A=
BI/testing/sysfs-devices-node
new file mode 100644
index 000000000000..8578e49c328a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,11 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		September 2021
+Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
+Users:		fwupd
+Description:
+		This value is 1 if all system memory is marked with
+		EFI_MEMORY_CPU_CRYPTO, indicating that the system
+		memory is capable of being protected with the CPU=E2=80=99s
+		memory cryptographic capabilities. It is 0
+		otherwise. This attribute will only be available if
+		node X is local.
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..fc2e8c2e0d14 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -20,6 +20,8 @@
 #define NODE_MIN_SIZE (4*1024*1024)
=20
 extern int numa_off;
+extern bool dummy_numa;
+extern int emu_nid_to_phys[];
=20
 /*
  * __apicid_to_node[] stores the raw mapping between physical apicid and
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index a1b5c71099e6..f2b70b6de87f 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -20,6 +20,7 @@
 #include "numa_internal.h"
=20
 int numa_off;
+bool dummy_numa;
 nodemask_t numa_nodes_parsed __initdata;
=20
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -712,6 +713,8 @@ static int __init dummy_numa_init(void)
 	node_set(0, numa_nodes_parsed);
 	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
=20
+	dummy_numa =3D true;
+
 	return 0;
 }
=20
@@ -724,6 +727,8 @@ static int __init dummy_numa_init(void)
  */
 void __init x86_numa_init(void)
 {
+	dummy_numa =3D false;
+
 	if (!numa_off) {
 #ifdef CONFIG_ACPI_NUMA
 		if (!numa_init(x86_acpi_numa_init))
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 737491b13728..d92edbede560 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -10,7 +10,7 @@
=20
 #include "numa_internal.h"
=20
-static int emu_nid_to_phys[MAX_NUMNODES];
+int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
=20
 int __init numa_emu_cmdline(char *str)
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..778a2d21d0d0 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -441,6 +441,31 @@ static int __init efi_config_init(const efi_config_tab=
le_type_t *arch_tables)
 	return ret;
 }
=20
+enum efi_mem_crypto_t efi_mem_crypto =3D EFI_MEM_ENCRYPTION_NOT_CAPABLE;
+
+static void __init efi_set_mem_crypto(void)
+{
+	efi_memory_desc_t *md;
+
+	efi_mem_crypto =3D EFI_MEM_ENCRYPTION_CAPABLE;
+
+	for_each_efi_memory_desc(md) {
+		switch (md->type) {
+		/* System memory after ExitBootServices */
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+		case EFI_ACPI_RECLAIM_MEMORY:
+			if (!(md->attribute & EFI_MEMORY_CPU_CRYPTO)) {
+				efi_mem_crypto =3D EFI_MEM_ENCRYPTION_NOT_CAPABLE;
+				return;
+			}
+		}
+	}
+}
+
 void __init efi_init(void)
 {
 	if (IS_ENABLED(CONFIG_X86_32) &&
@@ -494,6 +519,8 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
=20
+	efi_set_mem_crypto();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
diff --git a/drivers/base/node.c b/drivers/base/node.c
index be16bbff11cc..c01ba33f2054 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/efi.h>
=20
 static struct bus_type node_subsys =3D {
 	.name =3D "node",
@@ -68,6 +69,15 @@ static inline ssize_t cpulist_read(struct file *file, st=
ruct kobject *kobj,
=20
 static BIN_ATTR_RO(cpulist, 0);
=20
+#if defined(CONFIG_NUMA) && defined(CONFIG_EFI)
+static ssize_t crypto_capable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", efi_mem_crypto);
+}
+static DEVICE_ATTR_RO(crypto_capable);
+#endif
+
 /**
  * struct node_access_nodes - Access class device to hold user visible
  * 			      relationships to other nodes.
@@ -584,6 +594,23 @@ static const struct attribute_group *node_dev_groups[]=
 =3D {
 	NULL
 };
=20
+#if defined(CONFIG_NUMA) && defined(CONFIG_EFI)
+static struct attribute *node_dev_crypto_attrs[] =3D {
+	&dev_attr_crypto_capable.attr,
+	NULL
+};
+
+static const struct attribute_group node_dev_crypto_group =3D {
+	.attrs =3D node_dev_crypto_attrs,
+};
+
+static const struct attribute_group *node_dev_crypto_groups[] =3D {
+	&node_dev_group,
+	&node_dev_crypto_group,
+	NULL
+};
+#endif
+
 #ifdef CONFIG_HUGETLBFS
 /*
  * hugetlbfs per node attributes registration interface:
@@ -644,6 +671,21 @@ static void node_device_release(struct device *dev)
 	kfree(node);
 }
=20
+#if defined(CONFIG_NUMA) && defined(CONFIG_EFI)
+static const struct attribute_group **select_attr_groups(bool cpu_local)
+{
+	if (cpu_local)
+		return node_dev_crypto_groups;
+	else
+		return node_dev_groups;
+}
+#else
+static const struct attribute_group **select_attr_groups(bool cpu_local)
+{
+	return node_dev_groups;
+}
+#endif
+
 /*
  * register_node - Setup a sysfs device for a node.
  * @num - Node number to use when creating the device.
@@ -657,7 +699,8 @@ static int register_node(struct node *node, int num)
 	node->dev.id =3D num;
 	node->dev.bus =3D &node_subsys;
 	node->dev.release =3D node_device_release;
-	node->dev.groups =3D node_dev_groups;
+	node->dev.groups =3D select_attr_groups(node->cpu_local);
+
 	error =3D device_register(&node->dev);
=20
 	if (error)
@@ -974,6 +1017,39 @@ static void init_node_hugetlb_work(int nid) { }
=20
 #endif
=20
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
+#endif
+
+static void set_cpu_local(int nid)
+{
+	int real_nid;
+	bool cpu_local;
+
+	real_nid =3D get_real_nid(nid);
+
+#ifdef CONFIG_ACPI_NUMA
+	cpu_local =3D
+		dummy_numa ? real_nid =3D=3D 0 : node_to_pxm(real_nid) !=3D PXM_INVAL;
+#else
+	cpu_local =3D real_nid =3D=3D 0;
+#endif
+
+	node_devices[nid]->cpu_local =3D cpu_local;
+}
+#else
+#define set_cpu_local(nid)
+#endif /* CONFIG_NUMA */
+
 int __register_one_node(int nid)
 {
 	int error;
@@ -983,6 +1059,8 @@ int __register_one_node(int nid)
 	if (!node_devices[nid])
 		return -ENOMEM;
=20
+	set_cpu_local(nid);
+
 	error =3D register_node(node_devices[nid], nid);
=20
 	/* link cpu under this node */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..0d9b304b204e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1282,4 +1282,11 @@ static inline struct efi_mokvar_table_entry *efi_mok=
var_entry_find(
 }
 #endif
=20
+enum efi_mem_crypto_t {
+	EFI_MEM_ENCRYPTION_NOT_CAPABLE,
+	EFI_MEM_ENCRYPTION_CAPABLE,
+};
+
+extern enum efi_mem_crypto_t efi_mem_crypto;
+
 #endif /* _LINUX_EFI_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index 8e5a29897936..6df1f90480f2 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -19,6 +19,8 @@
 #include <linux/cpumask.h>
 #include <linux/list.h>
 #include <linux/workqueue.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_numa.h>
=20
 /**
  * struct node_hmem_attrs - heterogeneous memory performance attributes
@@ -92,6 +94,9 @@ struct node {
 	struct list_head cache_attrs;
 	struct device *cache_dev;
 #endif
+#ifdef CONFIG_NUMA
+	bool cpu_local;
+#endif
 };
=20
 struct memory_block;
--=20
2.30.2


--=20


This e-mail and any attachments may contain=C2=A0information that is=20
privileged,=C2=A0confidential,=C2=A0=C2=A0and/or exempt from disclosure und=
er applicable=20
law.=C2=A0=C2=A0If you are not the intended recipient,=C2=A0you are hereby =
notified that=C2=A0
any disclosure, copying, distribution or use of any information contained=
=20
herein is strictly prohibited. If you have received this transmission in=20
error, please immediately notify the sender and destroy the original=20
transmission and any attachments,=C2=A0whether in electronic or hard copy=
=20
format, without reading or saving.












