Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67B37EB48
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhELTX6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:23:58 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:63366
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348925AbhELRjp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bToKpT+CyDTl7eW9pFjgXKUC/aPxsGvRPpds9adEEVz8Av8YiirEtWvnRI1/5Ku9e7lhus57KATEgyHJ5U/G0dWPNIvU+mvbBara9J88CQotaVCQAQKYstj0UQStJkzI6o17LtiSpJtW2xctJBTFiGd1iFbw9IpSu9Fgoynymc1s0S+1sV0r+QwgirZf1QRZyJqQBEeSXHdnymJuYsedjG1ceMCnw/aKtDmP0QUzL30qH99PJlSdB7rYJjoveIv1stR3GvFHaSlbU2BamGgoJcwqjkOwgNxM40G2X3OgeBCdKCbMqrSFgnAZ7XqnuFzEXCAg6iekuobZj3dNZsRzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZkkc3ShRuBnw3rXH50igeHmtPPzARwnJKUOuSILbmw=;
 b=WZUXvOj8WoUkhbm17OuPN3ekqwsLGB+iXdQHvoGUuGQNjm/Rnli2ZvfkKybAQZejFvdV3pNr/5KETpodmpwe8Y0GOYI9U4wbl287gWu9oZfanFnixws+LqP2i/A10oUkSZADkG76BSPjsH7K+WNDghnemgGNQzlvVN+z1bQAUlJz5HCOiPwbGr39JZrtUuFWA+jyoZqew6mIzlSU3paKoaSf6Ciqlg24aMyZlyaxnmAfuB5AaqSzCu3Ze4Jjw40ajBvj6Jwl4uybAMpvbDWQYMkazhg6u4C87uK80XUZibTEfNiIiXKQaMtPZ3hr5IOaFbtLyoJ2TobsJlahv6QwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZkkc3ShRuBnw3rXH50igeHmtPPzARwnJKUOuSILbmw=;
 b=HvWgZhyXx0pdWQ5A1iTCsHvN5KiiZ+jn49mzP4uSVFeEdoV2ja5cz797Y7E3qTZnXrNxcHs1/UGSn60ca9g9coeDF8IuDcDn+v/MRfjqdKNzBnBA42ynT/R5ZBFZ1OZjIBDVbQUjTu7IPTcQz46oniRh4j0p0KivR1xKYfA/uZY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:31 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 4/7] arm64: hyperv: Add kexec and panic handlers
Date:   Wed, 12 May 2021 10:37:44 -0700
Message-Id: <1620841067-46606-5-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b1a7e7-1e13-454d-0c9f-08d9156cc27a
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB1483EEEE200F4C1AAC5581D5D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeGNaCgXbRONx1hikapsmEevLwZAF3i/0AehavXrQBW/k7n5tmnJz7cVKcmwgsEmwwtZB7ESouQ3rXrKKa0pMeHh98005PBaMYi77mHmAqy2cvnvKUyHbIHwgIUx0l8mySblAmh3i2oCJgD8RPkRiuU17STrc4hNrgJSK6yY+6n5H6IadhGwmM5xrfpyR1ENNhItOlk4Mu1wQQyee1zc8zx2m81L8wMwBMM13fZa0U8QKANyv5CZtyVc0IAVPOa59xDcnCHU+PV2sLlkv3HYt36IZnxWmlCTPO4Fn5YYK9VY+2+7EoGpt/w+m/08aNsRzEAcyos5y/wzGpTjWHO3wkZWw+xF3ST6BnXHOadNn6Vcsmf2bdtQNemJ83ALry7e6qTjwMsFB3fMBMEiv3hgZLPxzczGnt/X1LYXNAYuiBT+WUkOAS92QHZNAI5Tz0RjqMI6pwfmJYsC56weeM0EIX/Gz9g6j7EsHu1vRCdKWGQbT8kwPqpks4dlcLvKsa9eLO2qTt78P6mqUFdFvNwskiMSxAaRCp6cOCJHxc8helk29nXJ+wEyBFqNbEzNReVffFnJJ4+V6emPDPxc2H8+p5jYvIwZLFxAA29X6Th/9rJio5NqHyRdHZBXzFfU06Od7M0wx6f/9FfPzd22x7psCn87aUlXYI8Zx5mWceKsKtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhpgZs1KHw1Ib4sApbViVg4x2/cnd+DaGdMil/rsVSD1MXeQL4xeWqnnGJ6o?=
 =?us-ascii?Q?9knptlcpwBwPj7Dtxl7WDoEySAaf6dagZCywXSqC4lpe+pHj1HPQQvXskOXK?=
 =?us-ascii?Q?NTfSTSISL3msUFaPRqqIF3qgoFdThi/w0oHKfpLHcYSNV6TDoWuIaOReAG8B?=
 =?us-ascii?Q?iqDlHsf7oGzklbq7wbuoUlIfD4fdEFnEp4w3s46NTfFuC01UFOgduxijFeZL?=
 =?us-ascii?Q?jNyyrmI911w0b80UF22/rSWDGYgpWV0OkKX3U7vS1B6GmAwCiWKeYvuLKOA7?=
 =?us-ascii?Q?DnE21AL6OZoeeSHVajFs/zjODQALkjOMB8am4O70qVLbUEVUU16EggK8S/Xy?=
 =?us-ascii?Q?krbC/C6BaJcc+ftj3wuHxN2IxP1oWVQRlAcenPj9pwcT/smV0aT1Da48evOO?=
 =?us-ascii?Q?J0ACArrJC1HTLhdF6KerH/5pL/GzUIZ0hgQo0pEVVC4mKYFVcyOeSW2M7VQv?=
 =?us-ascii?Q?/va+zzx8Zo4RB52+5LqzPDttqAmMWrD2c2fSOQtwu5vVY5//45LpOYQJ8M+u?=
 =?us-ascii?Q?nLMyAVJDpXDsAUHbqGJGq2AIBQtyWrgiDnFQLj7Ymecmxxmf0weM1rXhl/qY?=
 =?us-ascii?Q?/XLoZwVVASavmcVau5KrBoZmc403KauewpnJOZych+Oimh5oLlHz1ked9JEE?=
 =?us-ascii?Q?OG1u7Bog1uML6JEKY1u07P1gB9YjBicIm0mCOcsnyeUavNEu3fXy81CGR6o3?=
 =?us-ascii?Q?I+6VTg8Ok6mCT9fQNx28cHL8aBQs3KFIWSP0iaQ7VZYjlygYAZvwGL7mzj7w?=
 =?us-ascii?Q?QNE079kfTzeMd1WLMkBv5tPjGTezGPZ+22O8TiFzKv129DEBWfbx12+sLJQX?=
 =?us-ascii?Q?6mJ7mTtgD3AfLdnl5sQdB0nh2UkWttrq+hGXxDUDcLWkHClgTP/sdtO2Znh1?=
 =?us-ascii?Q?URckfCjx6B7+cAvyTqv6aj5nkBCMlU5R5ASogBlYQHBYW1/oF/NCyrDVtXgE?=
 =?us-ascii?Q?cLH5yi0cKBCAc3+Nlad9+vfyVzooodLb+fydWrPy?=
X-MS-Exchange-AntiSpam-MessageData-1: ht+24SeosbWninSLgXvWMFIWXXSmb2iHTov79y31C36/vFNB3rSeMBMwoBk62M3zkpZLvNfsejnvQlPSL4BhQsQxmVLkCvTrZEcp8k1fS7IspiM5k6WoKtjLwbXFFxfd1Z1D55UTynL4NUpcM4fjuLPVy+EN6c1jP+M1vAndgCQGiG8thHc1VReI66QFklRTfvIltSgPAKgSeT+JWsXQwop1dkBakJtE9iOGqs50EiLqRzgjtWgqnmalzaOVpCBRj5/wA/HAuAOqxMdJzQxP7JnmgLWV+KeUi6D7d4wdt0Cw8/gY+jhg7Zug45hKHwbbn+PxnEfbiUZfkk4dgTPHQa0Q
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b1a7e7-1e13-454d-0c9f-08d9156cc27a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:31.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q44uxFaaa5qBRUzc/4JBU53V3kBmjcG494iJkE4qluCMBMi09EVavxorQLpz8SHqNCWxeHTmMawZNzh4YupEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
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
index 34004a5..56391f3 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -128,3 +128,55 @@ u64 hv_get_vpreg(u32 msr)
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

