Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4337EB49
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbhELTX7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:23:59 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:63361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348924AbhELRjp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFyErEOTNZ47TXSbuqe+ZQWXlaWppnJnBtOcOjoXazz334fdFso4TcYLVXF527FWoLOjOO+GQSmlThAuO4+1aDmfNwuO1JpktZiTBJG3RRajbXGcE+2v02mgCLZrwomn8OQRBMwdNMbvHqtVEcDWaal/TVNoJrVoAfDYYjKPGl0jrJBERmhhBz6Mfq09zOgk1dJdW8vuua6yKMiY1+r5SI4+0iQvilRWL63LmoXHLw+DIUyiR7wnWeOEgm86tzR7+yHdWi6+MBAgqWD7GGPZDXC0e3ixAgTUgd/9eD9CdO9uw+5itknngZCSFj+rjOvHnKS8+WqgFhcI+z8Lg8CxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eDbNMeS6zC5u6Jeu69d9rdLRidgmO42mzoRJ9nuRUM=;
 b=cSZXI6IeIqZ6fZnHDMnYWJMcl4IcO1PnwsNM2U+1pZx1LafwPGKZofZxO6w3FVGM1+6/eVqUvR6URTKSqoD+x4SUaws4+8ZAnKIOjfH88BEf0oGSZYRNtsVUISrx32eDk4TS9r9d/Zz9UEg4RNC/ktOv/3aousDXZ9+w2/e83u0Wbsu3sOgaP/NeskNXAdIxCpGtfdE/qSXe6jMBjUb3/K7HgRf34hWmoX+TYpRtbomlSM9NygDttOOD8ybAw938CNeO+1ZKvOCSW6D0L9m55vYuFyGjJ+BMSCg2eFwHpsxnn/qLTiknrYz58JC7tOMlCNAjxFkkgCfPTsEen9FZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eDbNMeS6zC5u6Jeu69d9rdLRidgmO42mzoRJ9nuRUM=;
 b=GYTw+wg2kmeqrRYw8tVzU8wEc3PTk36GCMMmU44f7w+FPDzNLnplKmI4dHiMMrTUP/k7Kol9bDAVFX3B+tTwlO0dbuU0USBZ+1ikayf/c3irQ12WssdJkhagoLKigKQBCeuIF91k9qMPiHzFgTfyYIK9GvGS8N3dPDkBw8MMM6M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:30 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V clocksource/clockevent support
Date:   Wed, 12 May 2021 10:37:43 -0700
Message-Id: <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e0c636c-b1f8-4b7f-b4ad-08d9156cc1c0
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB14831CD5EF6803CA0C1E27F2D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ls1Uc0/jDxnBfopMtuk2271YjtZroAcJ1mlB4k4XSeOxysPyOBIcoOgD5MlDx/b8Zbm3YhSqefXr4xXB11u8OO3q1t8o7Z/jyBPwz5jc3bfMNBwxo88sZgP9GgroewTImqJ5Zc42SJM2KTdhuJf6xpdeAT2wLjgbp9MCjgQoR2iJol5/PR2JrSKGDLb7jqEBilJRZawjP90YYXwBukUUExJKlssQO5muvjlt33w1+OzD6Rakql4nn8xmaFPVM1KiP4hOY39f5o+QlAyMIEA2IQ6HyjFGcte2neex/vaOJQt23bqAihqik+1HoHYfl+Et6P0eRHbE7g7sQKUTqKhb76a0jalpS10Xm68miKBk5d6VofwUgPab79lK2MC+mKC/V63fokP8rK/5h8JQO8czqgGfPNWaj4q9dduK8D11YZM8U6ZCwSms3wDFJNwBUx9TGPBf8yC0hUQBR+JzqkrpcfonUCWU1pldah3j9thYz2GM1NM0cIzWTvgTtUTLUMc8LZChXkGHqbkJ1BYf/cmwj1QTR4HY3P0w9ClU8S9Sy8bb8J1FgeZ/Ji3tv5beEEhbSIwkn10MKaA7rHjwhHIuZOvS5to1c0I4tTAGI9TcjkLO6DyRTC+VzwhLA+6JVSlWiv/mTcg+y042N66SOfNDRNJ/8ZzKgOQHPR2RAL1Xx+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9BhlIQSejG6scey+/uo7d1VQ7glFSWOyxq1ha80VS/XbYQRSwBTv0FHJp+s?=
 =?us-ascii?Q?KurcuUUYbmsqt4jno/eMKcqkL4vAu6dQyEX8EMNmtoVpUmRtV/R+hXZxc0zr?=
 =?us-ascii?Q?wzhDF/j52s0WrGTvFARGGFRJNnP48i5YxAFvTBBnwzW5FevpnfSQYCmBA3DE?=
 =?us-ascii?Q?VqiSJ52pXRvBOlWiQoIzVCF6LcrprAJQ3Ii1n4oJaqdQK6uGEnYlRiYhKoC9?=
 =?us-ascii?Q?SEItGtyhSWs3vvfD64ARDjym7y7YZZDIG4ddqEQ/OHOnRgxPnExRPejmvicM?=
 =?us-ascii?Q?087p/Z75qlkVL6FWlYcITEsGPcVIHwWoSCTKxrkXxvV+wKq+tem9j/QMyn0/?=
 =?us-ascii?Q?uh6cSrTElFlI+u+lVXsldWxEa1G/yodAYtnmYsB7/n1UriXzLkQrPpXWSfx9?=
 =?us-ascii?Q?K4Gq3Y/sjvMTkE3yxh18z3cqIszXN3hn5CaZKHhsuDmHrWLaL8UKHlm4/lgQ?=
 =?us-ascii?Q?2XoI3AqKZRznNs5nmUijg3eggtXiKMMjYexf/R4pqhtVXxwIG21fSg+Y7PND?=
 =?us-ascii?Q?1CoGIhL7UN+3LQzZmi1CE04bu77QwWtNdeS7V6SIZGJe8hcGVomKtN2+Px9x?=
 =?us-ascii?Q?Nk5X9OLSFWXnavFcEzGtV9vrov3CA/WIKxvHoyP3LFrI9wtSrinMiBaV1+hv?=
 =?us-ascii?Q?T2Nb5rfQtzTCEsnGE1GYQj/QXw6z2Fjezi2zbdzzAwfyr3Mt0v25sadQozEm?=
 =?us-ascii?Q?OXYaksX/HG4rzw+9CCvYzI7G2SM50YJR4vcm7SwZQPAklwfCNOqJxQKLIcSk?=
 =?us-ascii?Q?AO+yVITZeiGIN3AB3ou48LFBAMomL85iqi4PRRQKFwM/OdNC06+IQ9pk9KRt?=
 =?us-ascii?Q?fKuPvyPPNjXOxwdexv+zfTL6Ufj6PwWXQlayuXphQOVzuCmhw2ViiEr6eVTH?=
 =?us-ascii?Q?gxkujHWsonseoI9YdXcCT1x1sTetlMCye+RhChXkyLF6C5qnt5qtjHNYCB4T?=
 =?us-ascii?Q?m/0R0eeKcIqQIOSVGZ+UcSkkY5BS1fhrj+PTGIhY?=
X-MS-Exchange-AntiSpam-MessageData-1: pTtLbH6JMD7zJ38Eywe7hmH8XmgUe/GbR3b8C1SHkhSV/aHEsJL5rvBg1KcH8bGRbCtGXD/hbsgeH9Ss2S0P9hFiFWUmHB2BM4eufbuQHqs5zckMeMWLvMPz8298hxcD9XaSik75WHu8aQkcK9a4JTunIkJwyLiJSfWKdHnPl+o7xqqaFi8s1igrKrzBm5WJ/TamWUHfilzGa+ubDp77Yc5cNqzvOhdITLLhGoGt27yhH6QO4sRYzEMUW6aGc9NHspdVGxydBXkcYBIXl5S4dTqnvlyH8Myg8k2jphM+raVaAsgd9EGGMfeh9CbImkxxagbcO9lCA5PvqjN8nMsyvvM5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c636c-b1f8-4b7f-b4ad-08d9156cc1c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:30.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBmyLHu2KB0aYvHqVXt9mu41d7tOmRWkuXVib/m3A91hchu1nQUin8kJBF73G3bWmxwPPosaEftlNsdkQOZY/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add architecture specific definitions and functions needed
by the architecture independent Hyper-V clocksource driver.
Update the Hyper-V clocksource driver to be initialized
on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
 drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index c448704..b17299c 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
 #include <asm/hyperv-tlfs.h>
+#include <clocksource/arm_arch_timer.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
@@ -41,6 +42,17 @@ static inline u64 hv_get_register(unsigned int reg)
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
index 977fd05..270ad9c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -569,3 +569,17 @@ void __init hv_init_clocksource(void)
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

