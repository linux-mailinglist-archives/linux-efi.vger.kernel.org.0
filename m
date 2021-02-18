Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8F31F2EE
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBRXS6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:18:58 -0500
Received: from mail-bn8nam12on2126.outbound.protection.outlook.com ([40.107.237.126]:8481
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230112AbhBRXSy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srnvh+J3hqx0CAtCkHAPmK+ZcouR9meo5/GcHT0CireRrA0rcfCt99XgSmzmp75WWAV9Y+bufTMQoUeJ6H+XoJYVdDU6hWWXyvUwE40D+f/30EQVhPUZOWg93H1MLaNB8g5K5Pg8hMYJFP3evWhqjC944JPGiCw/KBfLpOZwDYbGT8+1qImiRMFHAfIL/VRB1NqoSYbPi891BbZqrEoEVV7K4mdKJ0w49XvUjk16llHKoSy75Guko7LXIxpaAuFfk+TZNdPpYiNkyJldw5xJsRswVawGP+DA4R7Ng2ZcYipb5rIXZyoGlqqZB0MwtoMf7GBqXFON9kGry2Mdp5imdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZw2TotSAHaYPjP3Nulqb1SDr7iLBPpWcJEkswmUl1o=;
 b=JCmR+E9g67QgsW4onRrYL9ida1bbny3PPnTx9VU+S9IsU620FkcOAAxZPiNwLkoRzv8gDHYqjQjTz4kF6Yvdq31Yda0VzgYWBZNWUADwpM/vGpAUjxWVgxxchDm2iHSXK0mDEYWeH1ILLJXeTNfQPmDLXdvF3EegIGTfOffcGIBDUWDcpHE1vICoR5M3mAHVenyqb4MnuwUqGNIukQ9OQEOXteNVBWogoO37p+YdJvy7/j0HQh2WPky1doURdsjHOWpgFE5YvYc0St57Ul0DxPNr9SKngzAe4Qdnzxt3ZXCRArLjH6RFn8T/Fo/EoraH6o5CJuGJupFbJ1ArQku3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZw2TotSAHaYPjP3Nulqb1SDr7iLBPpWcJEkswmUl1o=;
 b=dXEhJ9Jxu+byvmT6qqbwL8qxTHOdA5oXyjZB2N6o/4q853X9FJbg5A5dww39dc2chrsTDMtDgfOpmgADt9dLk7Au3GAUePdOy2m9k7rX+ALBPKSPPVg2TPyPhcV6vWKCzWcLBiwTBUH/ve3hks3jTAKRfIdzwE4MrkEpGprOAB8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:29 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 2/6] arm64: hyperv: Add Hyper-V clocksource/clockevent support
Date:   Thu, 18 Feb 2021 15:16:30 -0800
Message-Id: <1613690194-102905-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd1494f3-859a-47a4-1c91-08d8d4635c7d
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09833F72985939642F6545F0D7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlq/XaF2DyX3qF6wUcxz63yRYVF9DYDnG68ajxajJFrMPuif6SLXVHFE81cULo6AY5tjxAGqmrMwn0LDx6mAWgiQvWgyM/tfUdQFtnFxuY9okmQNRliEIqrq4vHfWhDL+/PllCjZwRkwOtGGZrX7BI/nbqWntdwe8QINXwRGJnfPH6/PpIoDc5Z/ydep9ba6F8dAMCJ7YyUHq2aRjkI0P9M/XkcKzxFZayNWbH+bCgO2u/ELSuoIn/geoewPZZFvpNGbPGwcpMtdXUL++PSFtHuxOA7Upm+O9bq4Kz2wBoby5fC8KEo2AvYbgwkR6X+k/+6Lc6eY0ujYxESzyEMOU78VX26dv7nQ6r14HD0tNujYt5qpq0fxtPXjN3bt6n/TJGmalHYp0EH8N4+c52v6GUdxAP9SmH2maRwUk1xgSN3bIvX3VLe574iT7BuyPfom/8w9NO3PBeincNhb291ULh/R9gUwklvcdlOz438/8biTDWFmmUzZJHZ/BM8hkhlzi9h1XoNEc5LPut6EUKGVQcDm8SgtYkhtcnh5vgKWjago8r27s9+9bI7Zo7NITCIc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(6666004)(82960400001)(8936002)(52116002)(7696005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TeXGJVhxJ3oBbAktI4Y0PZsnh6Vaco1XaWezkezAz38gTISRu06FIKJz8BNi?=
 =?us-ascii?Q?TUBqTnrzeUVRmYgWiYVgCP6k8f6qV+VmtlXJPyvLmN5eYiOR7lmZYf7Fy9qq?=
 =?us-ascii?Q?bh669+f6L5p/jy8MjLEQ44pAiJX+IrxwnyrmHF4lU0tnXBZwIi4cPi64GAtm?=
 =?us-ascii?Q?E0gufAde1p6BYQQhmtzugFQLd6XUuqx0cIV8RK4r95t9XtEkgLEAlgQPIuiC?=
 =?us-ascii?Q?/HpIJtKMfGj/uayF89An+56+J0f9J3rxrbrPRAEmDMCMBx5nCDzEfixU9Eii?=
 =?us-ascii?Q?z9kKbCj2G3NsGBL4w2+UVufGI6u/OXmTNZLcoO7hhaczf8Zln1P22zqif+DI?=
 =?us-ascii?Q?jhLgOezLDZsV4WiY31bvghhYlDNcAbyfaaOyyDjBAhgRyrsIsLx7MNSFL6m4?=
 =?us-ascii?Q?LDgLF7itVuffsYCpyvEZgf8jlFKYRXrA7NMX5fnu3COrmuoAj4Xw4t2I25GY?=
 =?us-ascii?Q?dq+UjJbIjAR67HlKfDRw9q7fDdAq0REMM/UNDGnldYT48O9rq9EKATMcpx/C?=
 =?us-ascii?Q?BNXPp701oVE3B7odGhxtBKdK4onNdAvKAT5u/o2Z24BEpdTwnJSvQ+9vyufo?=
 =?us-ascii?Q?r5sXcbXHHSIWwEHwuvdapu16bwc29WyFabmDwrr3Gk1t6eWUqB3ZY0gvM9Qg?=
 =?us-ascii?Q?WrRVf2UtHvzJgcjR/VA07CywUXfKso5cKWmUq/R2SHlKjAU746JucTiHLY5B?=
 =?us-ascii?Q?R7aR5IGliT73Of1um1b86UfBHH1wQIy3+YW29CkY91HLR9z3OteFvUxMB8Gw?=
 =?us-ascii?Q?zLFVzxvRu0thcuIgZFHg3lknqwGvkF4+zQBZfuVu+IvSX9OTCWGe9Ice9mED?=
 =?us-ascii?Q?aFPm9lJEdyUFCVA/JcJXfvKdNrEZPkPW2p69Ge35d2OtDQTgDGWZ9C/RfjCA?=
 =?us-ascii?Q?B+5y2aJW3qqOx4kBSqJUCLONqfS33CF1Nc0ShC+NnuHeJ06OTK+dTr4rXZt0?=
 =?us-ascii?Q?h4jDENqm5xEZZgCywxCgSGOzK3V5bj+rFIV0DvdFtS2oDaspuSapLz8fghE5?=
 =?us-ascii?Q?6S7HAVz+DKe2Ctxh79W2xOgOOm2255xNJU6T8/Zx4+eckLTVLcaGu/LOZdJV?=
 =?us-ascii?Q?PsdHCxMUmmywcItjeCWRMAqlciI3HtCBzbNZ/MJw8DXGgMFHF9FbSLqc7OHw?=
 =?us-ascii?Q?TPxTIhVtSlLrwQtarvxf2uo30SpwFNOGWhoqt7FUchiIYMosZRfdYXU01GmI?=
 =?us-ascii?Q?UMR5gEWlVUMsetqX8yUBz7uJ+UhfY5anBI3AqSZPxFHvyIEhgaSG+kit2OGH?=
 =?us-ascii?Q?3Ly61ovdG4ubeFWyZAb4xDTnl6GTB5ISeN/MipsWmMUjqb0XcdExulX76h75?=
 =?us-ascii?Q?CVs2WvTrxDKnbYMN71bnLfN3?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1494f3-859a-47a4-1c91-08d8d4635c7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:29.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF0EV20IuAUgf38VUb//HGxIphJWxvEoBi6gdn+psilKYucQPGyO2fmUuEs7dSQVa8/afie+8ye74QCJYQdqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add architecture specific definitions and functions needed
by the architecture independent Hyper-V clocksource driver.
Update the Hyper-V clocksource driver to be initialized
on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
 drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 44ee012..d6ff2ee 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
 #include <asm/hyperv-tlfs.h>
+#include <clocksource/arm_arch_timer.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
@@ -42,6 +43,17 @@ static inline u64 hv_get_register(unsigned int reg)
 	return hv_get_vpreg(reg);
 }
 
+/* Define the interrupt ID used by STIMER0 Direct Mode interrupts. This
+ * value can't come from ACPI tables because it is needed before the
+ * Linux ACPI subsystem is initialized.
+ */
+#define HYPERV_STIMER0_VECTOR	31
+
+static inline u64 hv_get_raw_timer(void)
+{
+	return arch_timer_read_counter();
+}
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c553b8c..f8bb5df 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -567,3 +567,17 @@ void __init hv_init_clocksource(void)
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
+
+/* Initialize everything on ARM64 */
+static int __init hyperv_timer_init(struct acpi_table_header *table)
+{
+	if (!hv_is_hyperv_initialized())
+		return -EINVAL;
+
+	hv_init_clocksource();
+	if (hv_stimer_alloc(true))
+		return -EINVAL;
+
+	return 0;
+}
+TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
-- 
1.8.3.1

