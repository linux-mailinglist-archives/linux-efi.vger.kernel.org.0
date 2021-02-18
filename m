Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6489331F2E9
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBRXSv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:18:51 -0500
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:10081
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230090AbhBRXSg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:18:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK2qlUFPFlhvGRXY09sImmr1zM/iDtO2ZP3vu/DL9F5zk1C4415AqN+erktdVJfuIlbHqjmHGVXF16eS7AaRaAWbrBQ0Xi2XTiYE3s7wrMhgzGIkwAsqJPhoy2k+yC70ujHYf2rFeKW21NFa0rBwNhnpmR7nlYVlbuRJHgN2Deuv5rzrj8wXadJI2nE10B33qGqnD5ip1k6+gC+cPejBwbUbcLE+StYOzXi1pjEW+3/7hTNcgL29h67wRaW4FNVddqlClgTByb7RLvIUOunG076bNzHXJetlcNgOT1BI+N1LTjQUDovE45upSGKeidOh9jtGTQu28YS8twLj74Yeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mDWX2st2n1BwqBfjph5HUVeeeH9pNWSle/SPI0wSLA=;
 b=R3oHzVc6X/FDZDuKfKY0qlb8ISGeJN7VattTmgDUJKXccXQoIAaY+nmLUGRwzspVrjQSRTXRJ3A6a4JfE6F/6YOlCC6x3YLFttM81RI3Fw2zx9V3pLXJqvi8xYcxLUNNXcCSL7CGQJLnlNIVd1y5jnF8tHLpgggTprdg+sae+NQbn2qsmvp4vniLsF3Kak3MIWfZFobaZr/UpehCOnA8L85gAQB3WHBcRQUy54NPjVd7uxbVY8elxiGCNIYCv3O4VG6CEiRtYePRqFEZDFCssKXCb5oBZSTO5d+El6BN/r3DVkHOtTAfIPj1n1Tdthlpar6VC5jTWdK71iV+VG6ZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mDWX2st2n1BwqBfjph5HUVeeeH9pNWSle/SPI0wSLA=;
 b=apTWzLmECsHTEGAmC7IrymeYdo2djFm1AOt5gF8gDK2qR5ecBCg+aZWeNbhaLcswkcENiULByZ3dB/KZfX0cKDt696h1SNTMbVqD6BK6lT7/J/Vkt0uQbCxIDORxVv9QuGYGLaqy49Ii4CiUAfTiAzmVyXDajdpbNk/qK9TPeVU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:30 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 3/6] arm64: hyperv: Add kexec and panic handlers
Date:   Thu, 18 Feb 2021 15:16:31 -0800
Message-Id: <1613690194-102905-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51009632-5301-4708-0bd8-08d8d4635d75
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0983403BD28CC1FCB08FCF7BD7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkKDsK76qk3EbhsdKtaKMTNQmyK9zgZ0HDWEKY1i5CruJcAU7hxAfRSUcZyLPn4M4bTGm+4eFO44Em2iqERqeEhi7ySd38S4CyI+3tFgE6eHFl5hyl8gXkPNMzytb3PXLKWFyjBX9NtoLD6gNV49Firm3o/vccgcpmSIYgvZ0eqWTPpOyi2782CM2n1cpsYUDXcJIg0LH+SsrwkraKCITqlvfHxRHHQDmAfjmSoakyxJ2vYzS9qe25YJGHcaLOcsPndbzpxKzoBLDO9w5oKr2xgWnQ0EoBRDYROCOE70fK1lElh1IZZQ2m8covojWTyJFyFhvuFtu/OfwqPcMbvgY1SeMc+OrAcTFJvsrcwsrhQWaDjdWyE2i+VCvBZwUVjgCzkHaIKcFzcEcUpELYxS1eolfL0sF8ZXAzjFJ1ARuwwDdKohTNxnZqR/PRKKVEMzZmAmPRCiBNGBaU8MHVIpY2ZV439EDHSzduDTQOiDPsKZmj7VRVLY5NhDS+/VL7n1DSMaHQem9pfRGPmy/ZxXur5JdY9of7tCxv39jqTiVmftyv5vNWUX1N1V//uI9nw4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(6666004)(82960400001)(8936002)(52116002)(7696005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dca1jFIbSo5W+6ikSaaEjwmkySPAUOYliPyb+tf73J400QE8khpMKk0yjbJI?=
 =?us-ascii?Q?HTd/5XbtrC6QPN89WveptPha772Vh9fREzw+hKKJw++Zvsu8E1MKljsP8UZY?=
 =?us-ascii?Q?jROYx7LutxOzWDfGE3S2DcEcgpsOBsqzqp2rWKcT6QMvqNesO+ED8uTnU+Qg?=
 =?us-ascii?Q?2FGwEp6wyjgFJXjv+8WVHnJtbpqAME+TzVulg1IYPakUs4JX6pt8elZl4LSX?=
 =?us-ascii?Q?DoueE0m9nuZgcrYAf1L6GPpOOrP0TlNzOuFFvaMyONsx0pgJYnJ20dmo6prC?=
 =?us-ascii?Q?OI5/xDEh5RQdXvKQMTLRpBucr2pmRDV6OTynlRXEivynMiFMQB2wyJxQr5DH?=
 =?us-ascii?Q?36+WEV/sLJ+H95GqoomkzZter4k1Hw+KEYwoqO6ZXhWe+NqHmP81BdTJ3MjS?=
 =?us-ascii?Q?OnqSETEX/w0JpowONmM/5RKYpGVPhGGJbv3tf98TUF1ZRSzXHErT+9CUgsi0?=
 =?us-ascii?Q?m8xS4TUEBFDOIVE4d59JRqUkgHXLVfMXUXkfSuXGIeFUGstYol1wILG+eyi5?=
 =?us-ascii?Q?IELNnveWuvmUMmtR1gFCVIIxOJm+Axfh/xhcu4z/oEK4Q9PNi5HPmzrV+cbR?=
 =?us-ascii?Q?kr/Qruq1tGXvluvzJyEh6a4TEaUnIFH9UjJJZUxcQ/LFb1HYDdICR2JmAvy+?=
 =?us-ascii?Q?AfsnojVdzdiiEOYuMpdNjRSyowyD56iar4o/e9W96kxEItuboajmzKVAcMIZ?=
 =?us-ascii?Q?lAmrB2JbXD0Twf7Nvn0p7lBaRB02AFMSJs7Iin15Bx+HgmgJpxmPEIahQ9aK?=
 =?us-ascii?Q?wIALvZzhGIHFwY+MYJ6GGCE1gRY4QG09H/aLtPz6xDSB2BHmToQ+iOvXbnxo?=
 =?us-ascii?Q?cwX8bHkGVyB0eVzoUqBBu2WPPDsrkBHxmXghboz4U4gOkxaLJZUa6nbY4VMk?=
 =?us-ascii?Q?dBe57JNHnFzFr7ybpAmwxtP9tkzlhloZmFODv02FJVaES7PGH03SxF2KBULM?=
 =?us-ascii?Q?TyvBNXexaUsLgkbf/vlGdudvIqfI3oRLJnxZAHPEGQlAZMU8EtFu8+2EVYqi?=
 =?us-ascii?Q?+n9vI55JaZVFNU8uRyWCNSToU5gxs399fxkVLmojxOf03QBWrjXc5MPlAw+F?=
 =?us-ascii?Q?5ZNMOBZf3lBfuwEoZ8Mw65x9LA968UUHesjIOgFIuW/SoB+Jy3fO1IL6Keid?=
 =?us-ascii?Q?SRtmix9iWk9gVHA+WDe3KM/qwsJ0pcSKVlwwhy0C9WObalzXhGd9ZZPuH3K+?=
 =?us-ascii?Q?rgGElACNwT2pN5wnvVOsMd6Wqc+mKp0DsVlymTibFVJSKIAeGgjlwsTR8dIC?=
 =?us-ascii?Q?aHFIp6FlW+LdsugunfEeOLrTR6rxSsAtCnPcpI+FdO6CqAh1OxhdLkQR4KBP?=
 =?us-ascii?Q?mbtatXj2BHTFcg9ef+AEzA1B?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51009632-5301-4708-0bd8-08d8d4635d75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:30.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNRBM8ltN6CFlKqg0apCwwHmHR7/CNJx5+/vwC3sVBntiQH2egdlue8Hc7/HwzRGm1OUoPopCpVW2nWhvYB8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
---
 arch/arm64/hyperv/Makefile   |  2 +-
 arch/arm64/hyperv/hv_core.c  | 53 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)
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
index 9a37124..d4e3808 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -165,3 +165,56 @@ void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
 	kfree(output);
 }
 EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
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
+	static bool panic_reported;
+	u64 guest_id;
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
+
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

