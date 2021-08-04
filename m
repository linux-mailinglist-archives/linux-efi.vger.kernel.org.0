Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC313E04F1
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhHDPxc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 11:53:32 -0400
Received: from mail-bn8nam08on2132.outbound.protection.outlook.com ([40.107.100.132]:57601
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239634AbhHDPxa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 11:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2bBPvskEeFNF/1cCWhMBCAfgs63EQ9EWkTmwyU8TE2FppiuonprjX/EmGzWCxVc5hokW+85n1uCUITr8o5PEypvIEol1ExBMNGPam6JkPjS5ubrIbAVF+rXPsPnXkcE9pcaoEMCjOpQB7hNlz7O3rQf61HDuqBWZ+STQdoCggl2lr5LBoiGUyklBPGKIHEMWUvetil9gEK6Sqesr0FfM7L48WKKD/8E/IlpH9PJsfzyQyOPdsjZ9XLpdHl6htA2/UOJkxeTvqrM3WziEhPE27hnSiZI94oY8+eebHbrvBEd26sYoLQkbKPGp6rxHK/JWoPD4byMBp0+yOyuO54o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeanwBBvMjpPwyFziZQ6X0gIeTmIfa8OzqXPTMw7nko=;
 b=gOuX2ZO7iZcaS4vKGkrbAJGAi6sMkb6vlTUwz9qx/RLIQd8w2rEKlZyy5QhQDP22Z3uxM717NNncIs6RUcxmtjU79tF5JEmdfJ9+V/ARdXGJ/g1/5cu9bTzMGS/H3kCHdt6lgKFGePw0ev7lJev6vSx0N9I6Js2x5yoeRsr+FGEaV6wMz/VIxwjUl5kBldyMcwYGp7vm9yOTY+JFwT3X6C6/Tg+y3VPZogqt6LMXmAvLaIGhUJxg+iSTtSNbPpw7o/HTlJPa1Qyom5dUNGvXBQt9DwJvlueJlyx8Q6TeClNA+s1Cv9mM74AM3muurmPUb/Iof5cCdjGESCB2NeLYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeanwBBvMjpPwyFziZQ6X0gIeTmIfa8OzqXPTMw7nko=;
 b=VWoMKbhX6eUVzyZvj3vRP3X8mgVXpnCJK64R1kL2MwmhPSlpcj2VxD0bkaTErV3u+dxEZ7UB8gfD72D+UjOjOrWtj4aDTlK0vuDDxvqstr4nMfuPw5zp1YnYBYz4S5fKIbvyIrZhvbR/UdVpoiAN/CRlgivYk3KSWZUYIuy6H2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1094.namprd21.prod.outlook.com (2603:10b6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 15:53:12 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 15:53:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v12 3/5] arm64: hyperv: Initialize hypervisor on boot
Date:   Wed,  4 Aug 2021 08:52:37 -0700
Message-Id: <1628092359-61351-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:53:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06bfa1dd-7411-4de2-a5a0-08d9575ff6df
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1094:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1094A047BFCDAE2E5D63ABC8D7F19@DM5PR2101MB1094.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUwOJtW5POJ6voInjPZhXeJIR502rKZAyfqkg5vZcbD26dDyiuyaZlSPqkjoV6Xx3+xTwi+dX7kHAl981/c2VkPNnYMhIyaBqiHWm25a+B54frYa2rHK6ZsvH1NFYikuIhADCJJUkMOHFtM6/XGqtoUgKT87enRQvDn32hPiLUF7NtL20k4lHovfqeBs95kGqe3QdwewspdWaPJYR1+SMCMP9k3LVoWSjvQsmLw/vTzvf1x9mZ9oR/Vd0LMi+CaVfw1eMnJcxp1YjELycYrSL4XmvwWhLZygHF448NHhQoAb9demwy+NhBelwqKdAWaGli7FAN8JRKdg1nzaGbVe2l0LExLGyUR5xq9/ZjzdE+24QmejWZIQUZFFaVgIgiGxDDLTSddhytc/245o9L99V6SxAUcRscPk2vtON4tW3P0rieVZRu022kS2OyHjKtW5ajualjIGb2UO1MOKWphs+k/ocNPSLrlkmSIqm9KUUtIHE7c/4xg9nafFxay+sdw1eXI3A8sN8RzApFKpDaYoKguJg/hYWIQPhXpLKXDTh78W/bboCTATYg8eJpKOpgyS8Pe/0VpaVyp6WRUMnkXU5eG4zAxO76BleLOrv+5HfezgDEqXqj+MnZ05ysSEJC9nvvs6rNrC95t2KS5Fgq1wPZtZ329J420K8MDmhbpwqkQwUC+AkNHlLupOLZlOQ+gbMluA8/qQcBoM6iUs6DPvwwzcH8JsK2dg7kshAAUkDgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(52116002)(6666004)(186003)(7696005)(86362001)(82950400001)(82960400001)(508600001)(10290500003)(921005)(38100700002)(38350700002)(83380400001)(2906002)(66476007)(36756003)(2616005)(66556008)(107886003)(8676002)(66946007)(956004)(4326008)(8936002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?me1juUWTE+FUgtC0M2jZFM+CAZsQ7vGO0YrPdmzq3K2Z6ZUd1+ikuqqLHMrm?=
 =?us-ascii?Q?YlyisKR0C/wCnAHWAWoL/sUExqtlqlXVhhx/A5/KXHsc2+oJk9fgXzoOFOPU?=
 =?us-ascii?Q?+OBArRgex2xlXcawbzD9mpW7jrycugjGKgrS0Thqai85x/tsHZ+6SA3OY1xw?=
 =?us-ascii?Q?fmGZEk1Ncum/0zVBad+WMmb6B9GVD/FysahHlwJAfbJMZpdQ/ucJLON+4lVN?=
 =?us-ascii?Q?JRzW4DHF0cKjo4jrvZ/29+luTtWxWhb0tGn9IoBJFJRM0t1t+p+Ly8ntP9GC?=
 =?us-ascii?Q?heb6OHHj4rjMN3oJD0nA9T9Bs84PhHtHU3jn38StnzMyUzYhY4e3GbbhcFmp?=
 =?us-ascii?Q?F7oG9JO+L1qy074RrmJn1NBWAfnoqBf1J0u6i7g8Qya7vaRg+oq1iW1iyMQG?=
 =?us-ascii?Q?u4McTHaig5D+GG3988V7cIuSS4+yXJ5foPP9fQdMCRo/dla3/r8X+JdqVL0T?=
 =?us-ascii?Q?BcR20UAqZ2pZ3/6i+g+aad2+0eJtBgSAAFiOEMP2F47mJIysIBwluhz1KUxU?=
 =?us-ascii?Q?JqtBwnxLBCp/rrTx/DWqN9BeCaFyETSJK5UpHiItSf17MI/s2DnWDA3yksxS?=
 =?us-ascii?Q?oyAqIN704TPHuNMgxfuYCObzFd+bQ94bo/xAZTQ7uPjnnnIgqJ/vW8v+UmDJ?=
 =?us-ascii?Q?W33N1Y16o6rcdlaHXAykQSyx9ArBmakKKKauS4im+DhrfMOPgQiBXBKVf8Lu?=
 =?us-ascii?Q?34EVe26qCC+/cShnZSXRW21mYmS45bOsHnc+eRxkitOSkDAkp8RYWPnoLQs7?=
 =?us-ascii?Q?tVi2R9AyFT74hm4cOpLgDl+/SucyJm2feMFXSHECDfvgV/npAUFP7kKvcGie?=
 =?us-ascii?Q?Dct5p8V8nJr8YIs/WyNl62FinS/sBdYMfBDcoii4IEmh+xyY+zD3gVUMUAFf?=
 =?us-ascii?Q?MEp+1YmzBvI4qjyuo6wpVfEvwXjR1CG98e6wNJYCPj/KPJYyOUq/9j8eXSyS?=
 =?us-ascii?Q?/dwQXqnBEO22eRjRgizhVf5VSfEMCm5EfUnYPDqog+XsyrlmgOEhFjXqG1k8?=
 =?us-ascii?Q?tYfSikZSYgL6sbwPHYBcnmJOuXPG6baVG0X6Hfp6sToVHXg4MQvd6aUIEDZG?=
 =?us-ascii?Q?Z2kJb6tZ7Tq7xcpLkXyyLWOjZ0CPgQSbFThYR7WWVZZfZlzCrBcEtdPTqtsw?=
 =?us-ascii?Q?Nw0kqaMelqwG2TXqLIQsRsH4CWGLTQ9Q5fidGfm28Vftsh8AlV00iXldBTjk?=
 =?us-ascii?Q?XapwcFhZa82CT0Tq4J1d9OWlRA3HJBBq/xlkc2IhkmOkk01Afv2Z08qrYNhq?=
 =?us-ascii?Q?s0jjKCxDmt0G2/Mdov7Imgzx8sfCbshk6I/Un3KD6hekRcro2S8VvhF3l9Fg?=
 =?us-ascii?Q?NeFo1rUPfVs0bS6gjZTG2G0B?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bfa1dd-7411-4de2-a5a0-08d9575ff6df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:53:12.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Ta/Np1fJbcqdLyJdRuwx0ioL7idD4l1v7a/LfPglVaq543w66COsuTQ7XD7Wf2mv2WfsmiJFkVI4pBdbmpqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add ARM64-specific code to initialize the Hyper-V
hypervisor when booting as a guest VM.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>

---
 arch/arm64/hyperv/Makefile   |  2 +-
 arch/arm64/hyperv/mshyperv.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/mshyperv.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 1697d30..87c31c0 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y		:= hv_core.o
+obj-y		:= hv_core.o mshyperv.o
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
new file mode 100644
index 0000000..bbbe351
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Core routines for interacting with Microsoft's Hyper-V hypervisor,
+ * including hypervisor initialization.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/version.h>
+#include <linux/cpuhotplug.h>
+#include <asm/mshyperv.h>
+
+static bool hyperv_initialized;
+
+static int __init hyperv_init(void)
+{
+	struct hv_get_vp_registers_output	result;
+	u32	a, b, c, d;
+	u64	guest_id;
+	int	ret;
+
+	/*
+	 * Allow for a kernel built with CONFIG_HYPERV to be running in
+	 * a non-Hyper-V environment, including on DT instead of ACPI.
+	 * In such cases, do nothing and return success.
+	 */
+	if (acpi_disabled)
+		return 0;
+
+	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+		return 0;
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
+	/* Get information about the Hyper-V host version */
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
+	a = result.as32.a;
+	b = result.as32.b;
+	c = result.as32.c;
+	d = result.as32.d;
+	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
+
+	ret = hv_common_init();
+	if (ret)
+		return ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+				hv_common_cpu_init, hv_common_cpu_die);
+	if (ret < 0) {
+		hv_common_free();
+		return ret;
+	}
+
+	hyperv_initialized = true;
+	return 0;
+}
+
+early_initcall(hyperv_init);
+
+bool hv_is_hyperv_initialized(void)
+{
+	return hyperv_initialized;
+}
+EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
-- 
1.8.3.1

