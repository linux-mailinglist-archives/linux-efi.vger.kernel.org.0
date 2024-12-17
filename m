Return-Path: <linux-efi+bounces-2385-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1A9F40AE
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 03:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05862188F18E
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81514885B;
	Tue, 17 Dec 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lHbbz+eM"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C614659D;
	Tue, 17 Dec 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402150; cv=fail; b=lGMo6bRKZIJ7/gQTF0+tCErvnB+7wvF6fzMtboOjVIZ9fZuy5xP95ooOw6mPxHwnjkF0FyB4KW2TW3W05ah9as5PjOiLiFFILciLA4+SRflBaKaWZy7L6LYOD1KhQkcZBHdedGf41Cp/jLIU/VXuCD3KmNVkq7UD03gDCXbvYvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402150; c=relaxed/simple;
	bh=v1HSg/IjluuiQfmkb7ZR4gFsi84bUBoiij58rQE8MJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwwcs/7Z9xkGdJB2VvcZcDXzj5I6ULDEsCbJweGrQBz/hNe4QR/uzrwBx189zRutq5RYVV0dxo7IP24nORaMMyPGZX3Bl/w0fUMJlPaDBBm4BbVvpNABQ30eb65s+TUYKPbEJNpQo9vgmv2ud1xgkSd01Nt2scEzMtvG0KeK7a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lHbbz+eM; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6N4ZBzmuXJ1n+12JntfqfWiVavhGkE3kxkBacYUrLXoExia169dExviadicXT3ECNHHEyAMzHEQSxy2Cw1SXMIZe0Z4LEiisOGIXQJR3hN/XOJTUCwgc9eEpQ+jojR2DfUfAx9pD9sfeGMK9GYyOpfGOyUTmk4f5Odwl0SUs58luUS/sXsjqV87vYWj6+F61ybFtd1B1y8H+VfVnzITpOoVhPF434kG9clhE+3VxAh/Xnz19Y27DcjZa8+TZQK9L7Nbnvfbw+7z1uUbpuxYFS2LPsgsN9xBEsAHqjeTN4niagbcuUwuGOkl06ktJBxYql+v93lpxLDYaS2ftwT7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9AZaeaHdtOY4ctdgehghhCStUx24YtBQBefI/xZtDc=;
 b=htLwC1h0MfX3lvRkpAz1RKyzVqzuBiFp5AgJvur9uYVMvrj/Rlvh017kXjUXYMgdOCtt88RGffzVhCN9tv3ONueKT7vJNhrbb5EoGCWyhmcXi736BLkTaQ29pMwE7dktIxLitsvZjQ9VicO9NpnlBRYnSIUg71ohGBTH9nSlo90M8kMsIMPWYWlPr7/i1yrSa/qgD+ZvVdkr/dxEOEIF5Pi2xbdk5tfi0YZb84OG6VRBR8e+L6zcADyQEffqYA2rSjzJwAnDTjegaAwxLHYOWg6Vc11Pa462580KNRHAJ7tTC9vm5dLIOd+cpfl3VgWB0GKclAbkXKAhfmzC+Ca3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9AZaeaHdtOY4ctdgehghhCStUx24YtBQBefI/xZtDc=;
 b=lHbbz+eMgHoVuQREqRlRQ3GSHjrs6e20suNgnPS01Hs6WUmHid+ZSam02NxyhtH5jMkLD9bO9LYGHkG4tASttjbgpf8m83okMm0rNP2l7oBRToK7IDaq8cRaFaxHGbQMuvZYVf9+m1M969Z9rq8PRRUyXfbPVt5tBqBbNa27oes=
Received: from MW2PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:302:1::21)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 02:22:22 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::c7) by MW2PR2101CA0008.outlook.office365.com
 (2603:10b6:302:1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Tue,
 17 Dec 2024 02:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 17 Dec 2024 02:22:22 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 20:21:20 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 2/5] efi/cper, cxl: Make definitions and structures global
Date: Tue, 17 Dec 2024 02:20:29 +0000
Message-ID: <20241217022032.87298-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7314bc-5524-4035-c7c5-08dd1e41a3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POi1uCbNjYbaaK2yEKXP8C3LtKvao9TNf0ZKYdQTz+SRtXbrOsCjEn2MIEEW?=
 =?us-ascii?Q?vTfmdpeCgeTo1L7xeABN9Wj+2uJWj8hDkPfkkmeipc3LiR68/OrL+zXzOoT5?=
 =?us-ascii?Q?UfdKrclqd5UeASIUeped1v43jvp1UBKeshlZ/+vKI9sVV6NhOhn5l6S2XWDe?=
 =?us-ascii?Q?xdTRLehCtCC42iKU0KRSgEgCI7kMKZqoU3XBeaSpBzUtQe7QqP3o5tnovpn1?=
 =?us-ascii?Q?U3/i/2s1wBk7TcQrt1VoPY8TQX1Roe6wxMj48xz952as1bRptrQb00SpQ5Co?=
 =?us-ascii?Q?o6x1fYBrnTO1peIqI8cWaK2u52I9vnbvuJzJQY0ItTRbI7wBZRQN0BeTjGNb?=
 =?us-ascii?Q?idiTeRZdGVCYj3gtB5iP3P6CKe2V0th2a7dwnU2RPQszsCGGL4gFQH191YA1?=
 =?us-ascii?Q?9jno/s0emJdhUq3Oe/RMzPPT/5CxQ5z9TWzATNuj5XZHkHElru98tNApp5N8?=
 =?us-ascii?Q?4IPR0sujapFYFtsIVS2d/1pfaA1vMFm88NChw+vi7iWySnIN0p3pdcZLwDgM?=
 =?us-ascii?Q?vAU3hCoirGp0O1vK/r0q//O9Ylu0Ba6RC+tX3m0NyP57ZzRGDTVJ51z+B8fo?=
 =?us-ascii?Q?6xOe2wAL+teiZmfXtrYTisJ3HqHrvcsLuFwvB+vzgbjxDULo6/TJ61dY9NKC?=
 =?us-ascii?Q?ybAf9+KOgA20XYIf+DyqxbbClyYakfLFyG2XRpKWD4O3+WJS0PmCt33ryuXg?=
 =?us-ascii?Q?B/9e4Z8ovnNlXSeFfOSoz8NuFsD4LEIRxOtKP3Bvc/YNc8k+LcQWJYp3Rcuj?=
 =?us-ascii?Q?GH1WpioajYb1Ae/TRWFkZTCTW8IkdswwQrt18KIMSM4vPzTS7mcK5mX7RGpC?=
 =?us-ascii?Q?nudaJeoFp6Fpf06XfktSB4zRM4TTDhtTz3cHxPzMFVRcdnTYCpjkxbH5NsQ+?=
 =?us-ascii?Q?UKVLsluUrpephjQgG52rVtTZWpaK3Vj68IY4hprHuo54fLDNlqsI+CXB4e4a?=
 =?us-ascii?Q?s/ZibrnuD83g215M8KKuMp9MPiH0KYajPOzgy2LV0eTC2Meuz82p7meN/Yd4?=
 =?us-ascii?Q?H/6gOKi7Tb8xQv8pMU8C7cGRSWZj/nw/RCxIBuLLfB1PDlU6swV4Kds/bJZs?=
 =?us-ascii?Q?lSK14VB1Xs+Bjq3+UQAwm0VNvM/FKVLYWcwcFqNm0iFQ8/j425cPzOJzUKTj?=
 =?us-ascii?Q?amHnuybJKdo0N0L4cozUg3ru3vVDfV+9Icjq3K937kB/PWaGRcxUarZtepfe?=
 =?us-ascii?Q?+lSSJIC3P/fR5TuqE5fhlciBHLAh+p6FfzKFKoUs3ntCS92/wIcQ9vkMm1et?=
 =?us-ascii?Q?SVm3MSbVE2iN3RZq5Cto0nhmlKwiNpa6nh9uDeM22aclgT7MjhxoHFIt+Ieq?=
 =?us-ascii?Q?g7FZXCnmCu+5nspl1EOotA+fquJyIbYlNlxzdOMqvy8ybgpvcrGkWNqhC665?=
 =?us-ascii?Q?TAIOO7XgS191I5tDC6A53EfsV0ECcab+03rLxzUrqA+VYi7pW/gLABgVfgNa?=
 =?us-ascii?Q?6VW1+AvAerqIxSa2Ffb/nsQnN/lJOxigFEgyxz+CV+cLaVO4175dhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 02:22:22.5059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7314bc-5524-4035-c7c5-08dd1e41a3d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381

In preparation to add tracepoint support, move protocol error UUID
definition to a common location, Also, make struct CXL RAS capability,
cxl_cper_sec_prot_err and CPER validation flags global for use across
different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/firmware/efi/cper.c     |  1 +
 drivers/firmware/efi/cper_cxl.c | 35 +--------------
 drivers/firmware/efi/cper_cxl.h | 51 ---------------------
 include/cxl/event.h             | 80 +++++++++++++++++++++++++++++++++
 include/linux/cper.h            |  4 ++
 5 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 8e5762f7ef2e..ae1953e2b214 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -24,6 +24,7 @@
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
+#include <cxl/event.h>
 #include "cper_cxl.h"
 
 /*
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index cbaabcb7382d..64c0dd27be6e 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,27 +8,9 @@
  */
 
 #include <linux/cper.h>
+#include <cxl/event.h>
 #include "cper_cxl.h"
 
-#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
-#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
-#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
-#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
-#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
-#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
-#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
-
-/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
-struct cxl_ras_capability_regs {
-	u32 uncor_status;
-	u32 uncor_mask;
-	u32 uncor_severity;
-	u32 cor_status;
-	u32 cor_mask;
-	u32 cap_control;
-	u32 header_log[16];
-};
-
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
 	"Restricted CXL Host Downstream Port",
@@ -40,21 +22,6 @@ static const char * const prot_err_agent_type_strs[] = {
 	"CXL Upstream Switch Port",
 };
 
-/*
- * The layout of the enumeration and the values matches CXL Agent Type
- * field in the UEFI 2.10 Section N.2.13,
- */
-enum {
-	RCD,	/* Restricted CXL Device */
-	RCH_DP,	/* Restricted CXL Host Downstream Port */
-	DEVICE,	/* CXL Device */
-	LD,	/* CXL Logical Device */
-	FMLD,	/* CXL Fabric Manager managed Logical Device */
-	RP,	/* CXL Root Port */
-	DSP,	/* CXL Downstream Switch Port */
-	USP,	/* CXL Upstream Switch Port */
-};
-
 void cxl_cper_print_prot_err(const char *pfx,
 			     const struct cxl_cper_sec_prot_err *prot_err)
 {
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 0e3ab0ba17c3..5ce1401ee17a 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -10,57 +10,6 @@
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
-/* CXL Protocol Error Section */
-#define CPER_SEC_CXL_PROT_ERR						\
-	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
-		  0x4B, 0x77, 0x10, 0x48)
-
-#pragma pack(1)
-
-/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
-struct cxl_cper_sec_prot_err {
-	u64 valid_bits;
-	u8 agent_type;
-	u8 reserved[7];
-
-	/*
-	 * Except for RCH Downstream Port, all the remaining CXL Agent
-	 * types are uniquely identified by the PCIe compatible SBDF number.
-	 */
-	union {
-		u64 rcrb_base_addr;
-		struct {
-			u8 function;
-			u8 device;
-			u8 bus;
-			u16 segment;
-			u8 reserved_1[3];
-		};
-	} agent_addr;
-
-	struct {
-		u16 vendor_id;
-		u16 device_id;
-		u16 subsystem_vendor_id;
-		u16 subsystem_id;
-		u8 class_code[2];
-		u16 slot;
-		u8 reserved_1[4];
-	} device_id;
-
-	struct {
-		u32 lower_dw;
-		u32 upper_dw;
-	} dev_serial_num;
-
-	u8 capability[60];
-	u16 dvsec_len;
-	u16 err_len;
-	u8 reserved_2[4];
-};
-
-#pragma pack()
-
 void cxl_cper_print_prot_err(const char *pfx,
 			     const struct cxl_cper_sec_prot_err *prot_err);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 0bea1afbd747..66d85fc87701 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -152,6 +152,86 @@ struct cxl_cper_work_data {
 	struct cxl_cper_event_rec rec;
 };
 
+#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
+#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
+#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
+#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
+#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
+#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
+
+/*
+ * The layout of the enumeration and the values matches CXL Agent Type
+ * field in the UEFI 2.10 Section N.2.13,
+ */
+enum {
+	RCD,	/* Restricted CXL Device */
+	RCH_DP,	/* Restricted CXL Host Downstream Port */
+	DEVICE,	/* CXL Device */
+	LD,	/* CXL Logical Device */
+	FMLD,	/* CXL Fabric Manager managed Logical Device */
+	RP,	/* CXL Root Port */
+	DSP,	/* CXL Downstream Switch Port */
+	USP,	/* CXL Upstream Switch Port */
+};
+
+#pragma pack(1)
+
+/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
+struct cxl_cper_sec_prot_err {
+	u64 valid_bits;
+	u8 agent_type;
+	u8 reserved[7];
+
+	/*
+	 * Except for RCH Downstream Port, all the remaining CXL Agent
+	 * types are uniquely identified by the PCIe compatible SBDF number.
+	 */
+	union {
+		u64 rcrb_base_addr;
+		struct {
+			u8 function;
+			u8 device;
+			u8 bus;
+			u16 segment;
+			u8 reserved_1[3];
+		};
+	} agent_addr;
+
+	struct {
+		u16 vendor_id;
+		u16 device_id;
+		u16 subsystem_vendor_id;
+		u16 subsystem_id;
+		u8 class_code[2];
+		u16 slot;
+		u8 reserved_1[4];
+	} device_id;
+
+	struct {
+		u32 lower_dw;
+		u32 upper_dw;
+	} dev_serial_num;
+
+	u8 capability[60];
+	u16 dvsec_len;
+	u16 err_len;
+	u8 reserved_2[4];
+};
+
+#pragma pack()
+
+/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
+struct cxl_ras_capability_regs {
+	u32 uncor_status;
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_status;
+	u32 cor_mask;
+	u32 cap_control;
+	u32 header_log[16];
+};
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 265b0f8fc0b3..5c6d4d5b9975 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -89,6 +89,10 @@ enum {
 #define CPER_NOTIFY_DMAR						\
 	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
 		  0x72, 0x2D, 0xEB, 0x41)
+/* CXL Protocol Error Section */
+#define CPER_SEC_CXL_PROT_ERR						\
+	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
+		  0x4B, 0x77, 0x10, 0x48)
 
 /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
 /*
-- 
2.17.1


