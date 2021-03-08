Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752953317E9
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCHT6R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:17 -0500
Received: from mail-dm6nam10on2100.outbound.protection.outlook.com ([40.107.93.100]:11264
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbhCHT6L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGWKSf3lhmDMhmmQTEpTrT4t33r+P/Zy0zWlb30EflDDrBVqsye2Oao7uMUsLXV0FQF2ruigBO8pmcLwmYPINgvtGZQNzDOIpEbi7daa8c+BffHyXz3+cpqRKQYVX0YA9pf6TJ66Grb5R4YtTQ2jH0aKMIElIAvbwKLKCrJNSsq43Gc6ud782mXssMISimYa+idApFSsr8gFFFUhVYHlF1fPTX/Dk35pYx+vLhO6HjiP6yRXmJ82XeMljH/wko0nPVaStJTLZ69r1dP8ycjOk89nN3KCqROCbKILTj9nQo2aUu+PnSd0HKT3vUil2sMaZsISN3wirpxpcW3GjN3uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MZsD270131MXJLcltQca+mvW6iQTGDJWJ9XrTuht4A=;
 b=coXqrLLIxeRupwjUG+e5v3Myuh0c3lkzfFIR3zd5cLlSeof79LWnhriFwSrIIT+9Jz3PWKDUfACQLdZI5v01oVadwnn4NTmW9psdSBXo8Anqe1hl8HvIIuD2Sy6C/buS1CXMIsYcRcCsxAidKZCetOoPd71tDnUzi5MRNtGZhmhhMiUi2eaieDrYEAkd77lOX+SdMcNUvStc34MidwsOdlWqQRLiTDFxV+6l6mLf8LjocAyD4lihphgBnJkMElfkGgx7tUBKHkrJ0mntBRDkxfkLZ9AYOUMc+GHwHQ4ij8JoxZi0sMj2TwZYQsag9OBI9LH8ERTysepkeE6cRoKh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MZsD270131MXJLcltQca+mvW6iQTGDJWJ9XrTuht4A=;
 b=JNkY3NfKfpgIrmUNrzy/uURYFAfyfenGiSDcqgbddq2I5n2+Mmab0GoBovkRSaF/lFVYCp0MymwWcJJ5bzXQD/Aacn2gjbm02i5rSioOx7uAqGg2ky5Pq0s5L69+xi9+AmQUfVv37qzTiKkvOjWZ5qmPhUC13yJPS/He90ghk3k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:09 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 5/7] arm64: hyperv: Initialize hypervisor on boot
Date:   Mon,  8 Mar 2021 11:57:17 -0800
Message-Id: <1615233439-23346-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c538f858-612d-4c08-ff29-08d8e26c7f49
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB1797CE0369598963388B0FD3D7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUJA3smbWnWW9+jJydbopFkqTKqPa7hJ5JTwywfD5PRsXvKjoi83Rkit3Px0WTCsN5pjkKZFZmVZvB2KlqeICZxidDiTPMwhMennb6li5D1aOpyEuEjOGLOYry8J7Wiaf1rsAfmgtRULiI+tRYgcbS1YBB3IzdKOHudRfvF/0u8sCdzYpudqNWzwFsrJaQiYMaKo8bhXusduOQpHTgL0sXwnzrECl0U4XtwMA85x6yxlE9oaummDL6mzVVLrF+6sw3cF69ZWltxdMYYl5iHCDltOqsowTBtiSZIPY3Faa46l4ffPOX0tnw6i32bCZtSEEl/K3RC/BMHxcm6AKPwhaqf9ZI3Kj1RY7TZwSe91kH4/1ysAc8qZOEMGBiCTtJSRBmjBibHIifdu52uFu8sVJfyCcw+QgtKpfV16z5pOFTPHLueicVLih5Cc9uZ4mPyoUVrks0Xd4UOJ4sfQFCdeo9jG/Lx7cfkk6Ta2LuXuFBPn4AOXetYhA+FHNCwXJx+WxkQ+jifF1oCsN0UA1zkEPFRl+1LzygFgsJxXT4QHILMh8R95lgQVeWZTmAG2JH6am9/6ZyrJUdU9M9ClC6QOR7lejlr/UVfJYikl1uvUg98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2zTmMK6VjIZi8I2pX1DGz2X3JLhI5CJ3TJ1f5m3DQFWroIXhRlwK7zc/q9YC?=
 =?us-ascii?Q?/CiytX9Pfif/uBpokTpXIskO14nYF+aeESGQFfocEIVOrkxX8UHkV14rEVm/?=
 =?us-ascii?Q?xd6Gogse/ekUuTW33lSTwEeAc24+0Kf8q4DlNXLMxvq/SOFS1sOZ6eipd870?=
 =?us-ascii?Q?ni4sCvyZf8GT7RT3i2qKT5Iqd5MIBS23Rrv+R7ajRb+MbNFUNXXG9xGXwWSJ?=
 =?us-ascii?Q?V6sVP7CyHFr2y0iaJs6+wDYIcPLHsPq8QeoDgSmvhCedHZ51pvIT9GgXjhaO?=
 =?us-ascii?Q?2CHaucbJ+QQRj+I1ozhoW60zRIBde8wPUNraf+lmcmHlFIYTJX51jwTrOG7I?=
 =?us-ascii?Q?40B+vmR36ch8LHi9n+EEL/w1jilKBMd/y5V5Vg0ebBxA6YlxjSCBXIwE7Jae?=
 =?us-ascii?Q?2spq/9ziTw266bL437cKmuR0syvziX4DpLvgMQQODbBUbuhUwtko3Tt/8Rpq?=
 =?us-ascii?Q?F0irUS1lMFsh5Sv5/AKQA9TYBv2IH2TrJKe+E8UeGMAv+doLi0FOMEar5ixd?=
 =?us-ascii?Q?lt5KdrinOLqB3dGtUuMFQOaQ/9WJeOUZgkZvBlIMmlNAXsh5d7AmLgbnYJM9?=
 =?us-ascii?Q?apQXxcMkGPVzaz9r4oyiSNtfqctU9K6Vt2bEatykuLz3js9d2P+k/i9VfriC?=
 =?us-ascii?Q?6oXdyxUQtMVoRtAZ2QllRxjDzynH4peXCxLq3vBxo6Qd/Ol7TMzPyzb2tWDZ?=
 =?us-ascii?Q?Z2YVtgjcPXiYCZrQx5ha7b3i/NWWl+SxrKdqocq/5sTItYaLy/4i1Ovlt+2u?=
 =?us-ascii?Q?Aan50GuKGpGvxbQW+wfCNEBfDTFz6dU+peajXaBKbLktBd7rVJ39T86JvWXE?=
 =?us-ascii?Q?KXxyQMYSPqJ35I9PyzMOOXsetY/TK46L1e8XLYkOUID5NWdbqXbGX/TlRk1q?=
 =?us-ascii?Q?Cqr+ooov6d3qxrP6kCA960NavBFTn0A7tpXJmAK4Njjg+WGLkhNT5d/iG2eA?=
 =?us-ascii?Q?WV+8Af7ZG8rypomDLuwRRKBEzBJO2yJ6Ar3dqXZfmMBlDfGV8i6pUI10Bq+2?=
 =?us-ascii?Q?at9g2kK5Awya8NDMqWc2GMWjxXELQRUj7KINN1SKEXdKc0GawGH+h4AfqoXR?=
 =?us-ascii?Q?d5xhdCwFdBWBdys56JExsVBhGRhtGRZkbQ0BxrjhAuALmf0qHs/ES4QgeJvJ?=
 =?us-ascii?Q?idKSCyLbhdwCbT5XXD6lHgS6zLNsCiYO9usVIhvgs36Rk5SPNGWeTTb0/tXW?=
 =?us-ascii?Q?G+bfLQ4Tq6xv9dF7lQAdvc6yL4CR/kbeO2KHu1ciQ7/49CIlipzdNp/FTpe1?=
 =?us-ascii?Q?ftsmBcAljIOL+8a0fnInYeHOl0pXJ0/pz60DrHjfVdBvgLWDQWO+XsUDKDxU?=
 =?us-ascii?Q?M4vkKld5l2xjZRMFZ3+fVXjJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c538f858-612d-4c08-ff29-08d8e26c7f49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:09.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5vo5rAmKKUAbw8XmtP6y77IaJGzu8pig3xkKPkoFrHKltmAng0nS9EauGl1FHfv+tPfFiUcfW7jex94hx9D0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add ARM64-specific code to initialize the Hyper-V
hypervisor when booting as a guest VM. Provide functions
and data structures indicating hypervisor status that
are needed by VMbus driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c      | 119 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |   6 ++
 arch/arm64/kernel/setup.c         |   4 ++
 3 files changed, 129 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index d202b4c..125e83e 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -14,6 +14,125 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/acpi.h>
+#include <linux/version.h>
+#include <linux/cpuhotplug.h>
+#include <linux/slab.h>
+#include <linux/cpumask.h>
+#include <asm/mshyperv.h>
+
+static bool		hyperv_initialized;
+struct ms_hyperv_info	ms_hyperv __ro_after_init;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+u32	*hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32	hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
+
+static int hv_cpu_init(unsigned int cpu)
+{
+	hv_vp_index[cpu] = hv_get_vpreg(HV_REGISTER_VP_INDEX);
+	return 0;
+}
+
+void __init hyperv_early_init(void)
+{
+	struct hv_get_vp_registers_output	result;
+	u32	a, b, c, d;
+	u64	guest_id;
+
+	/*
+	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
+	 * have the string "MsHyperV".
+	 */
+	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+		return;
+
+	/* Setup the guest ID */
+	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
+
+	/* Get the features and hints from Hyper-V */
+	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
+	ms_hyperv.features = result.as32.a;
+	ms_hyperv.misc_features = result.as32.c;
+
+	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
+	ms_hyperv.hints = result.as32.a;
+
+	pr_info("Hyper-V: Features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
+
+	/*
+	 * If Hyper-V has crash notifications, set crash_kexec_post_notifiers
+	 * so that we will report the panic to Hyper-V before running kdump.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		crash_kexec_post_notifiers = true;
+
+	/* Get information about the Hyper-V host version */
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
+	a = result.as32.a;
+	b = result.as32.b;
+	c = result.as32.c;
+	d = result.as32.d;
+	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
+
+	hyperv_initialized = true;
+}
+
+static int __init hyperv_init(void)
+{
+	int	i;
+
+	/* Allocate and initialize percpu VP index array */
+	hv_max_vp_index = num_possible_cpus();
+	hv_vp_index = kmalloc_array(hv_max_vp_index, sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index) {
+		hv_max_vp_index = 0;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < hv_max_vp_index; i++)
+		hv_vp_index[i] = VP_INVAL;
+
+	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+					hv_cpu_init, NULL) < 0) {
+		hv_max_vp_index = 0;
+		kfree(hv_vp_index);
+		hv_vp_index = NULL;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+early_initcall(hyperv_init);
+
+/* This routine is called before kexec/kdump. It does required cleanup. */
+void hyperv_cleanup(void)
+{
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, 0);
+
+}
+EXPORT_SYMBOL_GPL(hyperv_cleanup);
+
+bool hv_is_hyperv_initialized(void)
+{
+	return hyperv_initialized;
+}
+EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
 
 /*
  * The VMbus handler functions are no-ops on ARM64 because
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b17299c..86ca5c5 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -23,6 +23,12 @@
 #include <asm/hyperv-tlfs.h>
 #include <clocksource/arm_arch_timer.h>
 
+#if IS_ENABLED(CONFIG_HYPERV)
+void __init hyperv_early_init(void);
+#else
+static inline void hyperv_early_init(void) {};
+#endif
+
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
  * requires a hypercall.
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c18aacd..1df8285 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -49,6 +49,7 @@
 #include <asm/traps.h>
 #include <asm/efi.h>
 #include <asm/xen/hypervisor.h>
+#include <asm/mshyperv.h>
 #include <asm/mmu_context.h>
 
 static int num_standard_resources;
@@ -340,6 +341,9 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	if (acpi_disabled)
 		unflatten_device_tree();
 
+	/* Do after acpi_boot_table_init() so local FADT is available */
+	hyperv_early_init();
+
 	bootmem_init();
 
 	kasan_init();
-- 
1.8.3.1

