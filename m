Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9A3317E6
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCHT6R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:17 -0500
Received: from mail-dm6nam10on2117.outbound.protection.outlook.com ([40.107.93.117]:24800
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231219AbhCHT6K (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCTeN6EIpqlaFXGM4hizM6n2lIaxQg9+JEjLdadlJQFwlhrBnhcqiWkUGmO0RKadLBpeab07HF2fxlk8PRsSAU65LwLqZS4nwUMomICB9MWZ9SXzGw9r6HRqE8mMwbz+k5Dm2s2KAmNnJ2v0RL4hDia0iNnH9xZP8eJOp8BIRMs1dZE3HzPuZSuVYYIRGBEAeisaVKnGRgdNAeZoS632V8vPxSWZ3qMukJZQXLLLmWM+tGi6yvRMgwNKUJZJKmNo/77MWa3ATD3GknOP9NHR4o9VHscrIsV9/W6McJcaAOD0nHy9eu27rFUZOiABmV8o8K8SeNzAjKHk+aycTZatjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOTRZKeezOSyoE7f1kaPTj/KCAP7M5mHx1IFtayI1FU=;
 b=IPuU8FULYH7jaLbzF80fITqaI/1HNUFk7pfDhBcQ8IIotNMN7nCGv2/oe5+NkJGLGUygkv4HD75NgZKwp8qBphFKtEa7mLUVPE49qMFJozeVVKeLSxjyrHsoL4V5gzk4sGVaavJOgXAF7lBYn7q+004Cq8aeEICLKCBO605H9tSZKq0/ENg0PlzQr4qLCZpahsTvZt6AgupL9cK8VPt56ZFsQw2+Viqglw37s9zpvoisjlo18KLYfx6iMqmUKhYIJ6Mq/xX+1e1Gy2NsCShK4by5MrhpPZzVW7ydyHiOskMK//S2cYEep9EtwAlrWLdpw8WgIfMMFaNJCzM8fRCe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOTRZKeezOSyoE7f1kaPTj/KCAP7M5mHx1IFtayI1FU=;
 b=XdgC2gnAb3ZDNE9LibTXLhFcnCPWOlOR86bBrKMIZpm99LPUKkzt2CVeASvuZwkrc5NajWk11ZxcRr7GOULah39IOTNcKGkGV9bqLAiOmVvtAliPt2Czlsa6OiYG9Zf+1JAF7P6mnbMXfTMbCwCFSiblfvblFN99WseXCadsMkk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:08 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 4/7] arm64: hyperv: Add kexec and panic handlers
Date:   Mon,  8 Mar 2021 11:57:16 -0800
Message-Id: <1615233439-23346-5-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d411b56c-53e9-482d-776f-08d8e26c7ea5
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB17974E7D8AA13E4529E8EF77D7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36qZscnykHtJamseO5x3ony9vRO700KO5cNyXbC74eBgstO9pcd9iJLGK/D0gh8/Pi7PxiAurCpmsDtNP6HqfkYrOq6eh6rl6Jv0c3pP2Bn/OV/U5U6RjSQgE6exZODQdYgzBH8/IrKZQ5gRLrVrwHX2TPPJLywsfxSddWfb3XZD6xouOrpYC5HbK+Xu1AueJBw+6+H5zW0pt9uA7W9HxJfKWURfZoACVW/zXk6JIBhAHvYGKEyhGBM0HndJi7hNLnjvSyJFQU/eRpKUDcxyWKhYKMGTeXwEPlw5fvHieglZBe9s4whXilqWNXwCrrPAMSMjGoOBWa0Sld4yO0ONgEsCs7C1OVP7VqzPTvgm5klTAfXxKRt12TP2Lq8miHFhLL289HqTT5euSr1iQOoRNoTEOC9xlocoyC0n+I+YHzk99GmHH1jTvmNaUF53wv3+gmwsoa4/iZHZH4SMCseHi5yEtqUC1ohZMz5pDHbqaVw+4aJILhvvxCzdVdqazdrZZpt7bmlg3lB+32+X3XZFUHADWyGam80MaNk3Pyt9AFbKhDxAQ0pHgv42kxjqCEiUGFWA7+zUqGdU7kUwYOpzz5k5R223bVukZ4c7QZlueLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fVgdin+l5WTBLyWWvRs8DVdo1ELueacbbSzb0j4rx8GXSFMd5hWGhpkNGuMn?=
 =?us-ascii?Q?P3h8t3hUghr5nbQQYPhXN5x9fEvCPv9neLjj/qtkqCNuvHWQSHG4NZtvZ5BB?=
 =?us-ascii?Q?U8mGhWAzwv2uH+4rt0Qrj3mosywim80rbVL99xlqsMiu0Abc50aMm0poRbn4?=
 =?us-ascii?Q?ahfrwCixk7Hl8zFnjaGF6dIK9MFIAIomBo/1udKoseyX1+sYD+jFLwNLLLgk?=
 =?us-ascii?Q?jI0sgpIuYlGCUK3V5+vG3cn/6O0z3D44//RMg0h71AhYvyPioU3vqdIAJSm+?=
 =?us-ascii?Q?L84sfV1O5yQCmfQbop27MF3eQAjmiiG9ocCpZ5V3+0Q6SjX9jZs+du5TVkVz?=
 =?us-ascii?Q?kJEGs+sNGfh/s4U2yTQO9jF0u6qtrAf3par9z6WpgZ1bdKhklUmqxGuuUGKP?=
 =?us-ascii?Q?TlHHZS3UeLyB2p84zvVei/tvEGYC1iwF01e/IFjJPgA2U0xtpEXU2sGhCKSf?=
 =?us-ascii?Q?kf9lc2gZfkKDNPxnRdzpwa7CRu13DHuksVRXl/Z5R63XKlRPsHIx5chQIAxB?=
 =?us-ascii?Q?ZuVrAERyHk+CaFqnl86mNO/anaRJshrHXQd91grVjRYCGoZojKkdw1ov2lCi?=
 =?us-ascii?Q?OHxz67x3A+CxSAb3C7z3U7s/hFSAV6YT85uTjN+0B1qLMU7YvfXFXK2MjkmD?=
 =?us-ascii?Q?vjoA2+FmZAR8kjAqJtXA3JRj4u76SV7W1GBYNwktRlbb+N4Oa93ZGIqPb7GU?=
 =?us-ascii?Q?8szkocXMhXpsZIN/bYeJ2YV5vqwRfsob2uPs0Hpw+3EAffBZaBM66yPVlTvT?=
 =?us-ascii?Q?U58IBBD446Fvmsj626Ft6n7Rqc0gl8Um/73F3d8knja7gJseONYOIdcFPIlY?=
 =?us-ascii?Q?kmbMgKPUHQzeEZpaPhRyj7+Gf+5AdGKtAoq4FLLURa3tocu2BtxEaaUYBz+Q?=
 =?us-ascii?Q?jI820x9Xuqmxm2RoghS3K4BgFNmURHDfSmo/SzzpDkLKEFH1reeSeDbYqIXE?=
 =?us-ascii?Q?SY96gNJqUYhAIvO9U95+5Uo1KowKKJvwIjASIEwj6gKbaqwvqlLMdmVt5v4X?=
 =?us-ascii?Q?h4Qr8uUgW28HK2S/T3NXoitx17Nw2Zc5P1OkD+/Colx1QflIEps2FazIQ8MG?=
 =?us-ascii?Q?fueDpMTxsGW1/zh/M6hRDWGS2F9xBpIqDgWZGSCK5X9MxVoCMSKMkQsshNw7?=
 =?us-ascii?Q?n0BKipqa4wOj7SoKZrUx23dSKwOjLkYzyVd0lSbPyef/la4DXAPslT2pn2cC?=
 =?us-ascii?Q?908pM/BKQnzeVZ0+sGwXQ8VuLQVyVq80LxFmVR4WSnLr6zAz9dAekK9yWWMS?=
 =?us-ascii?Q?TbAoQDZkekE2XOuwyoHoFn8LkSFp7gJnVctoe8fnfcwIe6mgtFLUjKT0JUrq?=
 =?us-ascii?Q?H9lL5amhaxhV62wZZoqQNzj4?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d411b56c-53e9-482d-776f-08d8e26c7ea5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:08.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPeumcPW86sIb9r5ykrGXCX2wvkVuhGk3cfBoS8N2eHAsLIuXFOmeULClOydHdGUV0BVUbuHAJ3wxZtdmYSF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add function to inform Hyper-V about a guest panic.

Also add functions to set up and remove kexec and panic
handlers, which are currently unused on ARM64 but are
called from architecture independent code in the VMbus
driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/arm64/hyperv/Makefile   |  2 +-
 arch/arm64/hyperv/hv_core.c  | 52 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/mshyperv.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 1697d30..87c31c0 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y		:= hv_core.o
+obj-y		:= hv_core.o mshyperv.o
diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index d5a8a6e..fdcd69f 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -124,3 +124,55 @@ u64 hv_get_vpreg(u32 msr)
 	return output.as64.low;
 }
 EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+/*
+ * hyperv_report_panic - report a panic to Hyper-V.  This function uses
+ * the older version of the Hyper-V interface that admittedly doesn't
+ * pass enough information to be useful beyond just recording the
+ * occurrence of a panic. The parallel hv_kmsg_dump() uses the
+ * new interface that allows reporting 4 Kbytes of data, which is much
+ * more useful. Hyper-V on ARM64 always supports the newer interface, but
+ * we retain support for the older version because the sysadmin is allowed
+ * to disable the newer version via sysctl in case of information security
+ * concerns about the more verbose version.
+ */
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
+{
+	static bool	panic_reported;
+	u64		guest_id;
+
+	/* Don't report a panic to Hyper-V if we're not going to panic */
+	if (in_die && !panic_on_oops)
+		return;
+
+	/*
+	 * We prefer to report panic on 'die' chain as we have proper
+	 * registers to report, but if we miss it (e.g. on BUG()) we need
+	 * to report it on 'panic'.
+	 *
+	 * Calling code in the 'die' and 'panic' paths ensures that only
+	 * one CPU is running this code, so no atomicity is needed.
+	 */
+	if (panic_reported)
+		return;
+	panic_reported = true;
+
+	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
+
+	/*
+	 * Hyper-V provides the ability to store only 5 values.
+	 * Pick the passed in error value, the guest_id, and the PC.
+	 * The first two general registers are added arbitrarily.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
+
+	/*
+	 * Let Hyper-V know there is crash data available
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
new file mode 100644
index 0000000..d202b4c
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Core routines for interacting with Microsoft's Hyper-V hypervisor.
+ * Includes hypervisor initialization, and handling of crashes and
+ * kexecs through a set of static "handler" variables set by the
+ * architecture independent VMbus driver.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/ptrace.h>
+
+/*
+ * The VMbus handler functions are no-ops on ARM64 because
+ * VMbus interrupts are handled as percpu IRQs.
+ */
+void hv_setup_vmbus_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
+
+void hv_remove_vmbus_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
+
+/*
+ * The kexec and crash handler functions are
+ * currently no-ops on ARM64.
+ */
+void hv_setup_kexec_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void hv_remove_kexec_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void hv_remove_crash_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
-- 
1.8.3.1

