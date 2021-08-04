Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262D83E04F0
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhHDPxa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 11:53:30 -0400
Received: from mail-bn8nam08on2132.outbound.protection.outlook.com ([40.107.100.132]:57601
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239629AbhHDPx2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 11:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMOeLZc9b1eGBkxxO5e1yipeYNAu44mr+MullA1EKIdKg+p1MRt7AZrcP95iJZ5k6KuUo+eKRb5EGAt1H1WIOqW7J3yDubRHGzBgwUzOlSJqvz5NrnYoccCrSuDiCAmtfsIugSq2dimYyoZGzoYvfnSTu/uJ9dBfD86khSb5YWdiVE+s+HL29nN0j3vZ4SrFfhUniuR6xqJxZVbtQHVhDgEUSMgH0oaNf3t/ZDlqwbOQfUU0uYIyo5UBn7gTtMuKyFeQ2pQfqBMIgf80BSPBn6QfCsURtqy0Rd8wH2HDsJUHLjLr983anEsD6l21ji6BT8rRqxYsG58I4gEZVs0fnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR6yWwIC12Qn9oJTNddmHO1SwcRXNllw2dBR67NLJVc=;
 b=dMjZYCOBJ0tOI80rolgpHMapgkAaioklEPmbHErPsPmOlTFTIVwUoQ75Wr2ae73Y3UCUKKqCK54eJtGw+tjQqlxkg0ruyhf3pedzz/pHg2YfgdUu0UldggW00Wx2fVQpLoYB5HYvt+fyiwrIqPHDnixZmTCH+gEvOe5MVshhl6d7Hygdg8XuTEaO6wav510b2jf8hI5fJ8XehHJCO7dPEYzGLGVwZ+BV4nPNe1Omf6o4Ev1qiVjIZpdY7+6Xb7iAR7IqaO4IUMVKVnaAIN/AKykJY8dF2+m30/3ACQjfwBzMDrmNBELpBIA1+SNPvs7zuzC/vuotZTIFSt0Z7gEu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR6yWwIC12Qn9oJTNddmHO1SwcRXNllw2dBR67NLJVc=;
 b=NRbiS6iHEkf/lSDBUuzDHGAbBVnQCA/e3OqviILUvByWtzOI7DHVlqQvUxfQ61ZYhOOzCVEdRC6j3/Qxl/Nz2ntQxXBlQ20T4QorXr/1jenFQaaGypDNeqVlmZ5rwzCfumtBANocYgIa3MkgzS/N0JLORhc+WhuLEmBv6QTEUaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1094.namprd21.prod.outlook.com (2603:10b6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 15:53:11 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 15:53:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v12 2/5] arm64: hyperv: Add panic handler
Date:   Wed,  4 Aug 2021 08:52:36 -0700
Message-Id: <1628092359-61351-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:53:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30930c07-85df-4475-a9f4-08d9575ff652
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1094:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1094396D436030E37BF75D84D7F19@DM5PR2101MB1094.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIVoVmfnHxpTqG+Jkz8Ed/M9EmQEUODWewenrXcYCVbq98mzWD+mr5LYPbn/3HFSGwB4QtlpBtXOKuB/iYaKgYzZt9LF0QzxXIq5H9ngVxBDuKOahxjN6EZqaRBnFWB8Qw2CmV3YGqHddHYbAnjrAlXFUjlaqzLTZpq+a9Pgfs05DPG3Ts13eFpPCpO7jFDj4Uuhc54hN9S/I801+XRtNAjfcvwg/dgvk4wFbRhk5ZsRxflnSUbUQyh4Plwomi+MI7gaNUebSIlBUYVc+xF9/IIJ8xlBeaJ0MgzeW0v3Ye2CXZLjIyjKQNQoTlCX2rIt23npxmTaO1BSrjI2Z65Pyb6EPIjr+ZN8nXTwRACJat6vw67nTIX7wV3boDVehnFMqZ9gWypBPY0YJY1Ggf/KOrUj7fVJVkgGK7sfLmf5CByQyWse02bumO3iAsVKv7HMWCzPzv8LYk8yyG9V4F/6AHZAFRQY0eVd23pAYo9nzKDhRCj9ljKAIZ+hy92XFNWM+0QowtrlSDeu2pfRjupSfmgMfzD8TbMnfjgC93P7GLJ9UPL9xqYvUoLFJ6A+1xqKBff5dRwCdrt9hEYgDl9uezi0gr8BkoVrZ9ULsRijd6fwwuagCpdP2znolXDhHVD2QBjZiIR5dsFsVFvO4h4+SpWNgEujqwwmOGXUvPrp5N/z1wEv58RTEP6rVwoATka8xTAE7lLFTjR1FEIiK5CrOlNcIr5h7xGjw7ofi2+Tcu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(52116002)(6666004)(186003)(7696005)(86362001)(82950400001)(82960400001)(508600001)(10290500003)(921005)(38100700002)(38350700002)(83380400001)(2906002)(66476007)(36756003)(2616005)(66556008)(107886003)(8676002)(66946007)(956004)(4326008)(8936002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tbj+hl77BVe8I5bN5N9G0ESQi1Eij32YAY1WT7QpzpLUajDER3gLXo9QVl/O?=
 =?us-ascii?Q?YpeO8M7exMoutuZngzgzRQsowFET1zpYgdJJ+2ajqkkt4tpI8Suj9iEVCW3q?=
 =?us-ascii?Q?kKcaTkHKlxbb4OHWMlYvcYDetZpOny1QkGD0G4XkSkSKgPkjO/hw/5PgkoGv?=
 =?us-ascii?Q?sNT0XFzUrBkcsLznNCrPc/Sw09zafwL8WkXFqQfZQVzYD10KHTPOGq4tn+GT?=
 =?us-ascii?Q?eKWMLcOQmOdKtGbVooaW+4n0NQlNndU1VpGO8rk7OtC1JBvP/7kijbc9NbKS?=
 =?us-ascii?Q?YJbrt/8myj3UkeGKvoIkBiWlvsx0qBstAZU28M7lNIB5eHyqq8xece1+IH6u?=
 =?us-ascii?Q?wnb/8WCyU+3dHPqOqholUvINmvZNGZgACK3g3/ly+WoEAjnnlZ2ODkrCl5EM?=
 =?us-ascii?Q?1+lt3hB4pnAUE6mFlmOje+UdESo+WKBDXCrjaOkRXBKvvT33voCTp3g107jn?=
 =?us-ascii?Q?+VaVeXUQqSB7m309XHr55MsppeRtBCig9j6XN7GryhLZTHayQtN//d9g2cyG?=
 =?us-ascii?Q?sx9DMRoKVdwu3Qp08V7vZislAYFQXfqVwW4m8O3ggfLvBGM9dRmZyWPRZZKx?=
 =?us-ascii?Q?WDyF/ApFI3+re5iRVKJqrXZWjpaePp21qwPqbXRoHdbhhR0fqsd1+ROkmfeF?=
 =?us-ascii?Q?xiMDctrpsCVW2zMgS7TuQLz+yUAHUQKt0ogYutHmrkYL9phrLKaBqg34aXQG?=
 =?us-ascii?Q?Sq7hcMcv601jD3jTyZxAUdXL/iZzPTjmgKP4Dx2uZiv7DkdHVFKtCU0aWCpC?=
 =?us-ascii?Q?eDTawVTf+BYqFJ+/Tqpm7zpAv+wx8QebPxA0YsZRJw/hiUWYLgRFF0XLm9F1?=
 =?us-ascii?Q?hElj7h9onpilncwf+gOtZT1ntZG01sXTtfqaRVx2Po2yeFhOttMDiX8N0MJN?=
 =?us-ascii?Q?dlTrD2SW20/Khy6y5dwz0bikzHAoUZ0Z7lsH/Yqk9JAmX3VkElSilkNo77Hl?=
 =?us-ascii?Q?/fZ8vCxJw5a8/RhWbnfl4OOt7qG2Svsgiex2xzxZo5GonwQHpydgd0wbH9Dr?=
 =?us-ascii?Q?Qlc7zU6O8OqPJpafSvGvKE5J30vGQjLcsPdrh+/1cbPseUEmEcTJg6V/+irx?=
 =?us-ascii?Q?NENurk2vOjL0HRmP4Bc6wGvLOCnmLa40I9C2Q2oK7JUsbhklF0i5GOlWvZ8o?=
 =?us-ascii?Q?xMKD+buBMEFGII1RcaYNzCRiysH5jahYN+YQk+Yp5oOtLh0CP71lK16ymEi1?=
 =?us-ascii?Q?kLb7y7tRWOsX5zTDYHE95erriL7CNskMim4FaR/hRndHLYTD5Qvyiu6/K4TC?=
 =?us-ascii?Q?QBaTUTwIOVLMJDhpH014H5KIJHNY3FqrgMwKeL0dpJ4c6+VfZNKI8K8oEUrJ?=
 =?us-ascii?Q?XWH6o29GH5wKJQk4Rskh78z8?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30930c07-85df-4475-a9f4-08d9575ff652
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:53:11.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCwRb8hVCBfRAIOeAdSA0djxOAxrVIpy3IuWwVAvAchATkUVyDqNRNE5nmuNfgHHlacRLR6KLaybC5xHRkbPzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a function to inform Hyper-V about a guest panic.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>

---
 arch/arm64/hyperv/hv_core.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 4c5dc0f..b54c347 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -127,3 +127,55 @@ u64 hv_get_vpreg(u32 msr)
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
+	 * Pick the passed in error value, the guest_id, the PC,
+	 * and the SP.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->sp);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, 0);
+
+	/*
+	 * Let Hyper-V know there is crash data available
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic);
-- 
1.8.3.1

