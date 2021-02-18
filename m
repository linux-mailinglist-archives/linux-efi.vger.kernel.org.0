Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0731F2EC
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBRXSx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:18:53 -0500
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:21217
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229763AbhBRXSt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:18:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7ZOVX4xQQm5ACfE0KcglE3AR4sclsRHirGCmZzHPocibDseDsQ7xRbZBfmR3t9NadtVR2lrixk897E6UMEUuq/6biI4QcdJlGw8ny3DePAGHeNPmFIY6X8TDz+hXUjChaFUM8DEXnZCZXgsb0fZKVIR2ObvJTaXP/wecYuVY6+QUr3NdYYdeMvQdZJzmxK7NvPE+piZSerhH5FR4SSz70SPZYRSON9fuCp/AFwT3YRyNJaZ3J+WeooGpPHu7DVCvREsN2vsUWkzh67twPzgm4dsU4Gts27JH60ETYrjXu5yZh9wA3oZyQCJexl9h05GL+0xPooiQz0A8vpmA0lPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDo+ZDvoLmIi/KDXSyw1p9toB337nlXDJdQCCtPfvy8=;
 b=fhL/5NMk/TNJ2tfuA64sjghAarGwC2i+sNi7BSnon97s+gxMoqsWZzaKp7sqkRJeV9aI9Dl7EI8IhJRlNFGw/ddiffnpklVSJvApKKrr01FkY6bJiGxSUKzVIoEXhhAHuqdxgbuhUDqnT7nAc59N2H2xq3kQs1IGvY2RM7Ycf3X2snQYTUzfP+XUuWFHHOH68iGV9XZPPFG8FnJJzEUZGbXPu5f7deCessRSNjWgx+uBh++6oc7/7Q9qefkQmYnF1UCxC+LOdiBE7gBd7yJ19uuQ7zO5ysJ/NKohAVUz4N8jTuMmLkdjla0lG6CjuE4kD7H2BN3DRZrl8j8u8vaVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDo+ZDvoLmIi/KDXSyw1p9toB337nlXDJdQCCtPfvy8=;
 b=NpRc3iFLPLtm+6unMP1idYXgmkYBC40ImNDPg8QejC7dGxNU+97JvZRzy7VFiOW/kaJ0PjhRyR1lsxpza0EDlFNHm/z7x9mdrMldrdsfHYQqQ0iOkyJ1VoN+qGFlL+UcLaLhQPBNKKtObEy+HE4RjR3AYDGUfXb1xWCUJb41qM0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:32 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 4/6] arm64: hyperv: Initialize hypervisor on boot
Date:   Thu, 18 Feb 2021 15:16:32 -0800
Message-Id: <1613690194-102905-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da76dd83-3e32-49f8-4af7-08d8d4635e4e
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB098398022F819B0854891FF0D7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtogyOUr91yQgx2+Ug3PncNKFyv+CeqApdcRUs3Kip5bwEomrG9f4tgn1iUnLP29HHY4hAboN+NZ8lbp52BVp/d2xT3JT7MLCNYfNc2rijerjjRivBnq0jZVdAdsTi2DyLNj+PqgiNR+fjUeudRX3HZmM3nGgMLvManbW4WzdWekIE7/0lfInRbD6PnbOb/bUKY0ZyUTQyvM2VUIObbQQcULX5Kgsm0M9eOySq7KdwwiOXY/ihRQsXNFR+/PIyDIHKq9wRvMvwZDoGtpgTNIjJJI7/VHY3QwNJBMEg17lD1FOww3jm/R+Dczktolmmt5AFAD9TCsLv5VCtqn/Sfq3w1BOgxl39NSw5YSv+8lOMjBqUJGholmYqO3I+fokx9ZA+ohMsMxTxxeBx62ZYNXLP6sAW7Q7v0qnZQC/nMQuhXA8Ot2rE20yFQC7QJGCFZ4LKE8PccYcPq4r8K9PXuwwa6KWh4t6T2MA86sLlR4G745NWfJRp0MTLlAVpATvhUQmvd/7L/vRiezr76PdThdWx+vGU4qntdkNxepzd3fskEzpGVyh9ubYLgNnQApZ/Bu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(82960400001)(8936002)(52116002)(7696005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jbaHnewebbHwf37f3Ak7fyZbkji408Si0zQ3+dX7eqWLl6/krK5IozUVBCIV?=
 =?us-ascii?Q?I4oK+P2yNMC51ycq6XQhQVtJuEQaom+uHPOO//ZF5aZmtXygj44pWWOBrfQ9?=
 =?us-ascii?Q?kBiQW2/WUexHMjWAY1oWsdlnmWlvUk+nED4i4FK9CylqONq1xGzG95hVTeEm?=
 =?us-ascii?Q?hIQtgxBk2YH+jAH+f1cggJa4PGyGSy+2AwA9HqwOpYRtOq/ESoy9Y6oG9oWF?=
 =?us-ascii?Q?V6LkB9JGaRp14SYM4t5QuDAw2v4qbQlZ3fT58xHTu0GoeGzs6y47P7GOPlAh?=
 =?us-ascii?Q?fWfL3/0RS6nGoY5ONLaxlrji6GhTewrwzhJbQahZyyvfhqHXne6h5Idrz7zp?=
 =?us-ascii?Q?KBeI4ultBDdG0UHanU5fYK5BZTVPwmioIhRdny3jE93qa7cBBNBwQLhYGEF9?=
 =?us-ascii?Q?Pr0OARLp56CAaWqvoQ7NSfWzezpzf76/yQ+Ue8OZoHg/qEEYWF6rEIV3Bwor?=
 =?us-ascii?Q?ca4dy1Bs8q0ySTawHJ4qy2RHro2xbp/ukS9OZz7aEU1HKy4gkGKaXyKDd6pW?=
 =?us-ascii?Q?DJiDxz/TE1hiOQEthGAgpwarTVE3rPSFwLFSR4emcw2iYCOvIX0UWJuPm+tV?=
 =?us-ascii?Q?pn3sPmDW50ydZnjAfmq2QvkCtqSdlrNYIRV9Tbp1f27rjHXxcj4NTPI8UOvf?=
 =?us-ascii?Q?9pH3qB6rRj0Cnb0dSF1/aQlLMe4OaY9wqLgtRRXNOSoveD+V1PfJ1JMIIvQ+?=
 =?us-ascii?Q?avC7+zhGMNH3BL+K9gFKpewqxVzOxJW1y+hli+rRE+Yd690k/Z7Si3RDHudS?=
 =?us-ascii?Q?tNpZvKoI4WiRYD6brR/wV27ad6OH+DkHxwhModyYQiMfulw6WOvv3mxHZox5?=
 =?us-ascii?Q?LBojJ1WDTET7TPa2AE2WNbH/tDsRkzzvkRhzAdyKVTuGg97X2KHzaHdcfgwi?=
 =?us-ascii?Q?4AFRaXP1HMkeoLJ6pdZsQS5AB3uXpoetv3yWQRXJAE2TAFDpXkoyNeyzM50Z?=
 =?us-ascii?Q?eirdfkm5W6fT/fG9DvPHVm/VA5IyZuaiSxOsRfChWNkscVgd61vizlywJ4be?=
 =?us-ascii?Q?IUCyk0uFDUS6h+th9XvV2YZ1EA4qKvbR4VqnZTvmm7pp3bQm7d7upE1SNWXf?=
 =?us-ascii?Q?/j7+z9wZz/OHDdFrf2OLdlEvtl2hNqos7MGrkb0RPrB4dVRb2gRacWRUXIiH?=
 =?us-ascii?Q?O3J2nEQ1oK+0ShvNTszgqm1OJ7b9aZnB4qZrcumHfF4Gq29UQxy2FNgLuxIX?=
 =?us-ascii?Q?AP8b7l1CeJq/E2KRZPbp0glLNmzYl2qVshwBlGCLDQXqDPOW2ZdINpk+WWK8?=
 =?us-ascii?Q?qtjcYvLiJXIYe7ZFE69DdYo78rkPRGCnLphjbIO4z2U3JxFE3ADAp35yG91T?=
 =?us-ascii?Q?2pvz85Bt9xDQyG0wGAIxsJl7?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da76dd83-3e32-49f8-4af7-08d8d4635e4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:32.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iV11DvYPkNGWk+PWi4dMP3auChQX98c5Rv1EAvKO/xnCH1ogQNLYXeZ3fSZoIrgQjWs7yJdOO145bL0tLSGafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
 arch/arm64/hyperv/mshyperv.c      | 140 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |   6 ++
 arch/arm64/kernel/setup.c         |   4 ++
 3 files changed, 150 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index d202b4c..c72bc66 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -14,6 +14,146 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/acpi.h>
+#include <linux/version.h>
+#include <linux/log2.h>
+#include <asm/mshyperv.h>
+
+static bool	hyperv_initialized;
+
+struct	ms_hyperv_info ms_hyperv __ro_after_init;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+u32	*hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32	hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
+
+/*
+ * As hypercall input and output, align to a power of 2 to ensure they
+ * don't cross a page boundary. Initialize the first element of the
+ * variable size array in the input to ensure enough space is allocated.
+ */
+static struct hv_get_vp_registers_input  input __initdata __aligned(
+		roundup_pow_of_two(sizeof(struct hv_get_vp_registers_input) +
+		sizeof(struct input))) = {.element[0].name0 = 1};
+static struct hv_get_vp_registers_output result __initdata __aligned(
+		roundup_pow_of_two(sizeof(struct hv_get_vp_registers_output)));
+
+void __init hyperv_early_init(void)
+{
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
+	__hv_get_vpreg_128(HV_REGISTER_FEATURES, &input, &result);
+	ms_hyperv.features = result.as32.a;
+	ms_hyperv.misc_features = result.as32.c;
+
+	__hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &input, &result);
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
+	__hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &input, &result);
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
+static u64 hypercall_output __initdata;
+
+static int __init hyperv_init(void)
+{
+	struct hv_get_vpindex_from_apicid_input *input;
+	u64	status;
+	int	i;
+
+	/*
+	 * Hypercall inputs must not cross a page boundary, so allocate
+	 * power of 2 size, which will be aligned to that size.
+	 */
+	input = kzalloc(roundup_pow_of_two(sizeof(input->header) +
+				sizeof(input->element[0])), GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	/* Allocate and initialize percpu VP index array */
+	hv_max_vp_index = num_possible_cpus();
+	hv_vp_index = kmalloc_array(hv_max_vp_index, sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index) {
+		kfree(input);
+		return -ENOMEM;
+	}
+
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	for (i = 0; i < hv_max_vp_index; i++) {
+		input->element[0].mpidr = cpu_logical_map(i);
+		status = hv_do_hypercall(HVCALL_VPINDEX_FROM_APICID |
+				HV_HYPERCALL_REP_COMP_1, input,
+				&hypercall_output);
+		if ((status & HV_HYPERCALL_RESULT_MASK) == HV_STATUS_SUCCESS)
+			hv_vp_index[i] = hypercall_output;
+		else {
+			pr_warn("Hyper-V: No VP index for CPU %d MPIDR %llx status %llx\n",
+				i, cpu_logical_map(i), status);
+			hv_vp_index[i] = VP_INVAL;
+		}
+	}
+
+	kfree(input);
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
index d6ff2ee..55a61a8 100644
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

