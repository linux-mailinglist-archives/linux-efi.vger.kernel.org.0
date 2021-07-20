Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE263CFCE9
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhGTOXa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:30 -0400
Received: from mail-dm3nam07on2098.outbound.protection.outlook.com ([40.107.95.98]:28896
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237636AbhGTOSe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSl9huDf7d7b+aGy1glw+2cnTR+o4MGjpZsh2Jl3RkWzSTB67u4XTM5NMECwmAwxsL0ginEjzGn4chMOGkMhMF45bO+0wr24fObyLVJnXXtY/PYGR7EGj/hHwF3ewAVgzet9x369Dovu5jIjb4pqhJyg2aFwBG7cNJCf9cOQg7EWAtt2O5wL959d4bMaiIKjJySn3WWVs21MVP9jMLde776RoUC3I6HlK8XBJaGnKaRm+KZKuFCHUX3ARMPlmgLKDOy/DV2sEygD32LFCl9fRPrgFNwfulmyW13WviwmWnopNA8ge4ZaYKcX/gt9CW4sm/4lAkx2314SUY9vuy2hLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HiU6XS82HAdj4fww7xmvbixCsaas4zL7arlWJnpwmY=;
 b=lRHF18iHm+8ranSkqKRgH+pzs2yWroI4FR475CVR5UwvYJyfpkQbEph+sNDaowREx54V07sSf2+9BizS8la+SlTtc2y9NleJAjU6JxP9AFBGOZMI5YjFElatHgLx50SNf7X0Ccf+398rQ4ce3qzef5eIb+IJDS5THkDxtxQey+TwKsEEpCc6K7q8PMyMSt7/rrguDOrrcPKQIavoxxjs8PgOKAkwkFgaKlhMEkLBm8UmUhzkTvkqG3cWXUndw68u869llChunakp4XHZqxGndPhS1gVW5vesgJy6RU/x+Hol2dDL3NONDI8jpeK3DH3FJRUktTHPPxeDSQjejRJu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HiU6XS82HAdj4fww7xmvbixCsaas4zL7arlWJnpwmY=;
 b=K0B5wtsLNTB6J9yj6CywetJu/CQj7ir7zVnNQW9qkUl+X2b3nh4IVBlz6iDWeY4azCam0XyCYFwA/pK37NkisyB//Rzw0xZT51o/jWIZ1s3Eu7STd7XrSVkKl0e2ttkkBenNdtWeQYZ9jjVww1Z/xkmFtBInwwDcZNLmL99RMUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 14:57:25 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5%9]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 14:57:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Date:   Tue, 20 Jul 2021 07:57:01 -0700
Message-Id: <1626793023-13830-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8d6978-8505-4a94-db7d-08d94b8eaf8a
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09819F7720767C8FEEDC9218D7E29@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjZR65UjztKnY11MuSdKui8os7jbL3rtIq8I6OSqPjuIHuPpBsRK2HlHsNMYOba8wVCSty/+rq77oAJMhg6rtcugEg6RAuHvB3hOrwn0/jf5rUh968lagsEJ4tV9wDTboFgwobKPzwgBVuL80foRxsWzk9NHaT9clFGkivJv5OrcjWm28fvrRks+5KiIN6O0qjhP2ePvGaDC2qNuIYcc4FQ3BVTjDPm1JG1r8HDCHBfaGTN8kIWFBiqXnfM+kP52JIARHr+Wa0ZLpRsTs50aF9zzfrCFFXMICC62QkYhIEHS2gvFqWqNeyP2AWVclfYdoRd0flIpFGslvZxDj1SjRuUdFTxAPQensiomL45xgTTJADSBL2Yr3qyA09hMxgkLVsj2ljjqdV+Vhmugd8QzVKtVXaMKUcw6N0F5ydOSbxfivlE4Hc/oQkyzRkoMGahxDV58VpgIVNZyHS/MsMaZ9Q9Ygvd84vHse8oOP8EfGYE9QitCzMik9syl9vWJ6JQJBZPC3B1dliyvDKHrBZlr4BA4L1sY5+W9VCfmVmtxk+ILCe3S6c4ZuNHP6AngglkQku2LiOk14E0Th2rA2O7RjdPxM0oeapy9BADzI3E2f35x3ieccRTxjJ38rN82SyTqhmhRZfQmixqpE0WXYMXFT5SEOVmDJhAPGuHum1aZgRddz4M4L2ZXO1TFLvOFd3sT9HB7yYqZc1x+PeG/vRBIQMmhkohlAcfq6TdmNoYuXjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(6666004)(36756003)(508600001)(956004)(10290500003)(66476007)(5660300002)(38350700002)(4326008)(8676002)(38100700002)(66946007)(2616005)(82950400001)(186003)(52116002)(7696005)(107886003)(6486002)(8936002)(82960400001)(316002)(921005)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwBzX8mTmywXKH5p4rsThRTUXDaNxcJn44cwfrPSCfy0MBbX/sA0XVHLRl2A?=
 =?us-ascii?Q?4XmnIqAeYdgtMclJ+0tf6h0ICkzFuDxKNe1ZMqDSH9fjEx0UP4TpxEi8gre/?=
 =?us-ascii?Q?WBOPrC104k1Plj29cgdrB709k+jYAuGTlXnfze1PEfuopYqf8GfirX6pASnV?=
 =?us-ascii?Q?lM9Tcktz9cTUvpSb4Ag3c/jXezKVhTRiBpNKu+/0jZHgJAf92G7BeGKFDJrq?=
 =?us-ascii?Q?fr+UMFAhkhTf/WT6bvGbx8kmGU/VDaXKmRVWgO+nzuNfhbmivpwSPNPvoUuQ?=
 =?us-ascii?Q?UWtQL6G9Pnf86Q0mi3U5mz8wvRyclOmeEjM3zkXkfzHVldNFez5DUtWMHY4s?=
 =?us-ascii?Q?cjhED4zFVy/lpkf7ISwEoTKdLQTGidxPpkc6BNm5epZboWhmfjqrqkf7xsqH?=
 =?us-ascii?Q?yyJJyxT9UU10AKHKxo1LWxMd/V4cHXceLvEv9CUEfoLDJdOMPDuquXjc2gEm?=
 =?us-ascii?Q?kt0srBOQXt5ABlR1+qTAXY2rjQqsY+X/IjA6vTaQdoelkooQAY/Nrz+yiMgg?=
 =?us-ascii?Q?cfF+AUnzYgHHizHSwq1CNPo+KsgOu+cUKxLDf5jmb6XDKv6AgbW0t2/48EBu?=
 =?us-ascii?Q?EccIprDL/yGheVvWWr9FiqyS4hikx8SYln9UoWZH2onbewWhUPChkx0Rc9bc?=
 =?us-ascii?Q?ylxBPCRdtUSupAIKVVQ8OkZBL2GFzMdS9gVxVMVfqKg6uERP8GXjZy+arn0O?=
 =?us-ascii?Q?cz7gcYw5v91Qm+z+EF3vgJ75z/GZniL81zD32oVKaxJ9ia48JJaK/acQ8yRM?=
 =?us-ascii?Q?zihw/eW5JM2tBpKmEsDPCRNQFdMA33o2FOhgs2yrTZ/Yf6875BISh/EYvRZ3?=
 =?us-ascii?Q?X+vyU7VqWAzvHrOz/VoMFYMS3EKfWgEIyRuhVK9ecZlirmDX82tza2mUdZMu?=
 =?us-ascii?Q?PKKqlv5hVhm2yrrsQOj9M7Y/+ZCZ1zSYjw7p4EpJ5oH4Gyy5fypAr8CbUIdC?=
 =?us-ascii?Q?HH25voto4sJHw/i18F3C96edsISu0yWoQdwaLZzCYMJATc8iSClUplKn4Tv1?=
 =?us-ascii?Q?Oh8ysJuHSsNelgi3A74tM7ua7uZSF/fV+EW4cRyzrAYRcINuEd20E45Uj6eo?=
 =?us-ascii?Q?N1+TeDDgrdK3L4Y/iwYjNOrf48ylkjtyniecOW1Ze6rQHkRmXA5fMvqG61Ke?=
 =?us-ascii?Q?HjvAsj4f5bIemK1F4YYHDfqnXdoDJlSx5AycHcq62DWjc7UPDvdzpyDrnc3v?=
 =?us-ascii?Q?iVj+uL/5jMyRpApAnGPa7h35Wpawl0SkNI6IPm1e3kbDKaB/CB44GQ41r6cU?=
 =?us-ascii?Q?XNvhK8VAx1taCo8hCTa1Gsh1WJmD7zFEox6o/oUjYv6VVrjvYrX1+lEmpqa0?=
 =?us-ascii?Q?uPMU1sUSm83ICgPZjum34djr?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8d6978-8505-4a94-db7d-08d94b8eaf8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:25.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8PkzWOjLzrsRrsYK1ZYyGfJH3P5O0Ka1GosjTZBi5ZalUR6m0Vba844ANLENLHyNX3rhMKwJ2pPwfsCo/CVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add ARM64-specific code to initialize the Hyper-V
hypervisor when booting as a guest VM.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/Makefile   |  2 +-
 arch/arm64/hyperv/mshyperv.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)
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
index 0000000..2811fd0
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,83 @@
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
+	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
+	 * have the string "MsHyperV".
+	 */
+	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+		return -EINVAL;
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

