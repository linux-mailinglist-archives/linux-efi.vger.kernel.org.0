Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44A537EB4B
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244895AbhELTYA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:24:00 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:63361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348929AbhELRjq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggNPOu94u8GNHuLBEXL2eja/0wZvWgZeB8b8vRVG37h2Au5cKnl3RgDkQ38TyGY2WRSJwZpNsHoG1/OFBKK6SeTG+zwpWwH8X09tjU5hK3vVzN8gatUPvgiadVWB4/KK8RA++XpyJ2j1Z/5VttVgUqWf03UiLbbL5Opoi4ZhiA7x+HFAPn03roaR8kODq9XoTZSNgfdnj9QoIWnF8Mm91Zz1sw0a3/f2nM+1NOyIllE8kjl3DiAJhwbImvmrTfnuhawGgRufcPTTN2sNqvA0+/OZeH7E0uhq+3ztqk1sle13V6uGnc8j8yRGSo/qD9SetaKA1WXq1CqQmfiabPOTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVbzIfoFc54FVJycbFmHMnO1OpLO1BuWWymgC66mou4=;
 b=iVzIpAY7IrNuF1TOQBKRN1sT+OcVQSK9uPjIxbX3REDDblT5rAFfkjjCmksxWxcwcMBXxDfpqUyVcoEvVyPT+RSX5lNIs6Fx5P3IXlB1goIPaxjzC66jLhPJsaerD7xU89xjnPpdWDkZhCVtZH4NdZNl3K0ZvyDF19u9+KVgsMyvPqAr3Fxvchibo88ZR9o89397Gonw9dmt2tUH6QnpeuM5XNWSTiJyD9eLKNjs3e1xLcDQiUXqzakfQlt93jsok0MOLfjWeD9pWjE9C7hRakxXL5kZqqDaZLRoS8zBHL4LAQw+zD9tVH+uSqCok6DnVRpm3XMrtN+obj8/ZLHGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVbzIfoFc54FVJycbFmHMnO1OpLO1BuWWymgC66mou4=;
 b=iTjb3R7xPc7QZwREtnN8DMXZg4p0LUBJjn8ck8TgugfacUyPTl7wArxC9D+hrAJPZQ9SfOIPSX6RZN1BaMNwoKGlFgAJIc30agEYwDCqU1opWDw9L1gvh71SAL6vt44jXGocfQIIl/Fk57sCvv60B6jy2wrT1PjMEHL7QzH30QA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:32 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 5/7] arm64: hyperv: Initialize hypervisor on boot
Date:   Wed, 12 May 2021 10:37:45 -0700
Message-Id: <1620841067-46606-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.1.144]
X-ClientProxiedBy: CO2PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:104:6::28) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d4bd25-7a7d-48fc-b7e7-08d9156cc319
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB1483D7951052C73C110FAE30D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dv3SPONXEGWZNu5T5KjquyaH0J7No1w5/zFOSt2m4YjUE96KfU4ZkifStcK9BdwD8ZodEffDZfHBQAQhD7X+mqAyfIMm4kdvNV9RpkfI6r28ufUnoGzCUva5aprRsjlEK5NJPnCQ7XgTiJ3rpiGMXn2SPholpiDoD8zlko3wSOFc1umB5zqUpJJ6tIORGF6hm10dA3p+68nvXlym/MeZ7gFSkbD0QPv+UsaljHWCPpmnmcpMJPae6XEMcUsKLwMiStrzzkUdKvl44RU/lGtPWrvtOW4PFi1af1Bvvtj4L1UN214rgyxx+WmmNfO0NvmvB+HEMQJ2mLRLYr/6mmQaS/5uKpoid2bJR9Z9UxFVjMStpgySxqHtS6mqDUUkHWVaRPTfW3fmhhWoZZKn0YPx1CyhCHBrQt6kHciI9dAiIP5i3086oaS80ehk4tRC87z5yGet0OoFRYEs8kDRnNIvxoExjjkGJW3m1pdI6zZpJ1YPUid72bR8gdWGHhmV7wj1OZAo4lVyspupAY1+N+dIeZ8+BrkkbSvKcPLPwftij5U3HBInQzuWMyOj0uW93WXEffLVJ/LJGkPfWXjTnWvEr4D4+kJMMcmjhQ+PduDirRwwj5m+9WMY9nMnxOuE9QVNZryBRoT/WZWR04O1qx2ljYxu2yy1KySWzXjJMBbB1Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlOVFnnOAZcmUNgusZ/3cBr4JOGRd5jL5iEEja4/Xt3viiGlxruiUG0LteCa?=
 =?us-ascii?Q?+I7m1bfq6iijINklz6TNEPQbb198zY1T9JN5c6+3005OZhH4Du9sK4jHlMsI?=
 =?us-ascii?Q?OH3zpSVBtO43eAj3OcXIVGlvyjIDNeZT/NH0uZ7iaxC47hfJqlshgQdLxEix?=
 =?us-ascii?Q?ILIP3dbp9a/BrsPKWLnHE2/5u0UrSfHpvrtvUZ2fBpiPTYzN1MC6wpKvBnpl?=
 =?us-ascii?Q?9/AbTKLZ6cF+IgD1JwWvzFD8U5M+4CRvxgFLRGLRmXOVtMEi0UUugNWLggTW?=
 =?us-ascii?Q?1BPSsRPsNrMgIUhNmgNp+7XPTcCjYKI2OvaVMOnhN8ENzkflJ8Z6ia/fwb8J?=
 =?us-ascii?Q?/5q3StVCHq1zI3MQ+2f31i6p17+t63P2JwHRqt1W/Tad4ooOeZnR3TdeYWG2?=
 =?us-ascii?Q?b/8xjGf2ZwAWaCF1XtQI0/REODDaSEvMl072sogj3Fq4Sn15tm5LIaf1t55Z?=
 =?us-ascii?Q?etnB1GMb2y3hr5LNbS5R/LhA0f0i4gWrrUZgk3W3dGhtDXnQH35VXcnGTTB1?=
 =?us-ascii?Q?mTWYqyyRCEx5iJCfrqjULKjwhCceb8UfCHlXVMmYtw9gdCornial0Q2GJAT4?=
 =?us-ascii?Q?gPb5GRcFBaisjPFB4PXNTfmYAo+usRl13XiwqCIZ11nxSg2JQlP0BPBzEtZ9?=
 =?us-ascii?Q?v9AeVBJfK52a/TWO6sOwgE0yE+HR0oW1VrX/xhJnqksCHwCWTciw2g/mOTjP?=
 =?us-ascii?Q?hmJXwi0zArJCFsQ56TX2VsHWiD0sqH81K5VOffH2SR4z+aL7rLTb7tNsT7o9?=
 =?us-ascii?Q?35jQl1CUPWj4gezkfi5piDJtpr7c7z8rvul5TnykNsdF5mtn5K7jyyezW2/3?=
 =?us-ascii?Q?7C771bFQhkux9QgUWuV2ytmFtLk/ZJjPmd2fx85g5NRJdbIvDJhOZ79HlDiI?=
 =?us-ascii?Q?x6T3fgrMGvphbNI1eDeWDBXJpptI5Fz5DkJAjHXpHhxFcAy+teZuZBnl/Z/r?=
 =?us-ascii?Q?tNjCp87q9NZO7AdSSWNOz1tAxCyIlTyOxpwYhJk2?=
X-MS-Exchange-AntiSpam-MessageData-1: ZE+cXC0qwDphFxdL/B2+Uex8dhNgcYmjplY0wAsAKt7WlboRW63tm0UKr1jEEnUiDrPKZMzCDhuofqw//5238WvUY91/BRwyd9d3p/mFbE0pqLhcKIBQZiXqHY6L+e8iC0RUe+Hj6VkQMwa0/DOFUO0Bgu0IP2Fk2OPjEVE6GmHzg3E9RQ9PjbH2HmD57MMtnUuIOyrrjZKmQQJ0l8JzaidTKIf2vdrz/Yp6UbsT/6Dck0DjIAaKGwkTZNe6NG99actYxYo6ntqNOHpWuWxx/hVvjkublt5hL7HhmYpZHHHSmgi4GeieMK3up1ob0jMZkvU2KkDqAK3QmZcU1AQc89mm
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d4bd25-7a7d-48fc-b7e7-08d9156cc319
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:32.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AQTRJHb0TF75sjxIaDnj3apv/NNR9iEhbt207m2UJXjjr3QdegDcbfnF3vnb9NKM332N/Ac1Kwoh2HFYLHU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
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
 arch/arm64/hyperv/mshyperv.c      | 152 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |   6 ++
 arch/arm64/kernel/setup.c         |   4 +
 3 files changed, 162 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index d202b4c..95f7e4e 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -14,6 +14,158 @@
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
+bool	hv_root_partition;
+EXPORT_SYMBOL_GPL(hv_root_partition);
+
+u32	*hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32	hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
+
+void __percpu **hyperv_pcpu_input_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
+
+static int hv_cpu_init(unsigned int cpu)
+{
+	void **input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	hv_vp_index[cpu] = hv_get_vpreg(HV_REGISTER_VP_INDEX);
+
+	*input_arg = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	if (!(*input_arg))
+		return -ENOMEM;
+
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
+	ms_hyperv.priv_high = result.as32.b;
+	ms_hyperv.misc_features = result.as32.c;
+
+	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
+	ms_hyperv.hints = result.as32.a;
+
+	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
+		ms_hyperv.misc_features);
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
+	int	i, ret;
+
+	hyperv_pcpu_input_arg = alloc_percpu(void  *);
+	if (!hyperv_pcpu_input_arg)
+		return -ENOMEM;
+
+	/* Allocate and initialize percpu VP index array */
+	hv_max_vp_index = num_possible_cpus();
+	hv_vp_index = kmalloc_array(hv_max_vp_index, sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index) {
+		ret = -ENOMEM;
+		goto free_input_arg;
+	}
+
+	for (i = 0; i < hv_max_vp_index; i++)
+		hv_vp_index[i] = VP_INVAL;
+
+	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+					hv_cpu_init, NULL) < 0) {
+		ret = -EINVAL;
+		goto free_vp_index;
+	}
+
+	return 0;
+
+free_vp_index:
+	kfree(hv_vp_index);
+	hv_vp_index = NULL;
+
+free_input_arg:
+	hv_max_vp_index = 0;
+	free_percpu(hyperv_pcpu_input_arg);
+	hyperv_pcpu_input_arg = NULL;
+	return ret;
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
+
+bool hv_is_isolation_supported(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
 
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
index 61845c0..7b17d6a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -49,6 +49,7 @@
 #include <asm/traps.h>
 #include <asm/efi.h>
 #include <asm/xen/hypervisor.h>
+#include <asm/mshyperv.h>
 #include <asm/mmu_context.h>
 
 static int num_standard_resources;
@@ -355,6 +356,9 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	if (acpi_disabled)
 		unflatten_device_tree();
 
+	/* Do after acpi_boot_table_init() so local FADT is available */
+	hyperv_early_init();
+
 	bootmem_init();
 
 	kasan_init();
-- 
1.8.3.1

