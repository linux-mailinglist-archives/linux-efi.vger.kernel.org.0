Return-Path: <linux-efi+bounces-2720-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82440A1A026
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD973AE797
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906120CCDC;
	Thu, 23 Jan 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SkboEcmd"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0E20C47D;
	Thu, 23 Jan 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621885; cv=fail; b=pKmk7KmyhBlgFWJ6INznxy9lqyPLnocSe4Y/u2SoVW7LGd/RzN8UeA5NvOT1GReb49pFMIDWdeLlgOfwi+4GGx4i5C/ibXOWRw6FBTBGrG2DP5piIIxUHYINWJEYyRxg4sbtq0tQ++otM2Uw5ADUCz8QJbQByC2ofvZPKtJ+0U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621885; c=relaxed/simple;
	bh=UBL/b/K7iVFHLAvBrL5eqfd279v4PDKw8UD8L6hhQQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDBFHKW/TUwha0mRGmXWXW8nJ5HT0wMLYyo+Hv4eS8ba3Pgztv6Ln0+kas+A4bNy+71H+ME54KKbIqoWFLdr4TqfL469FPF3fLlgLIlgUP6fMHe8how2EcrcjH2XPVQDzVow4wwqFs+JbmSSv+TF4UxWfq++4CqPjJi3zcz/rC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SkboEcmd; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMkEsEPwic863AMS8N5Ss0i4MvvcTr3ySrWh35nwjcPEI+lsvBlwtRifSd+c+N/txzw66kqLRLXl4omNDAKqYcoT/O8lhG+vYsTe5H09VLN51i4AQhbBUf+ZWjYa/FmK//7/wti0azezChE6U6DsVS/KurMvO550iFidmjKJl25ztIFuXILYjFc/X9e5Ln+kXo2ZaqXa/pGyw79DZ1Sa9NPF9yFs0JN64zVSC4d3I0F1HumBQw8d0aEsWyWf1ghkUMFGvkz34/gySoWfQJ/H+sqC++YPxiQbk9GbfH/At1RocJECrHOEpsy3anekKEOXMk+XtL0CyzeV320cw7noQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B94FjdI/9BIi6raps7RIhArGu1oRNOzA/PlrSPnx8E=;
 b=cdxKA7o7S/atbLu6AjzeFdP+oGBB48t5I9XnIPo46bVewa3R2gbiIDxn1Fh3Y8WFeaZqBo376Aa9sSNQ6In4cAnn/UVPZve/BrvNHu5kbZ9WShe7GKAvG8jQ3O7QZwwp7sDXKikJp5LpghI3MRx3te5ABOO9bCHbFkz/nWj9PIoVyLrKOJIUFigtAeQS625HmNSTDWLX4SO8BgT5SKNTgU7UcJeGF4PR9xEF6ZxPrL+VZoOLiSFi3iu68CPhN5qkHKImSGGBEeO8l/Xo+79cp1AU7Myc3bb4XA7W75I3G6Td+qckGNrKUY+Y9nAdQk8mQ7CTaXrTF0zffwECeRLOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B94FjdI/9BIi6raps7RIhArGu1oRNOzA/PlrSPnx8E=;
 b=SkboEcmdAPgAU+VxpXeh3KDP4/2l81F0Sp3l+sEdXUNoWQTBMkW6yy6l6CjqcAZpfi9jryGZfc3/DK5pmvUqfME4Rz5vYRCytOiye1vpSIMVJDV0d6iBhbZWvgFBr1EPdb30ZLKcoOwQi8Ac+BeU8GH/h/FhhuhrNpBhQtlvFb4=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 08:44:38 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::4b) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Thu,
 23 Jan 2025 08:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:44:38 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 02:44:37 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures global
Date: Thu, 23 Jan 2025 08:44:17 +0000
Message-ID: <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: a387767a-1091-4ad6-f265-08dd3b8a2c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8uA3lXBoTkbwq/pxnilahbRi5IL5CRByYqxRFQm647sYVSYM+IsDe5YjsV1?=
 =?us-ascii?Q?YaP9lLaVi64PpxgXIAKS7XLHLzvisg0ej8WE0X93r3eVJFLrOfzn3DNyKqQe?=
 =?us-ascii?Q?aQGv+25J5zBRyrXbiNSItZoV2HYoV1yTImfrJfrmGYCGhSnDHlifs2zyQYul?=
 =?us-ascii?Q?DKfZo7ovwaOobX32sgLxwvLCFNumy3xN75krbI8Qlgmb1gEgiTl2HhuOYea2?=
 =?us-ascii?Q?XfLogstvGC2WG5EzqN8Q4HCqAJ93XQo14AQ2Jy85JEqqY3zlmTjhZG37ff+e?=
 =?us-ascii?Q?jQCFbHJlzNdrbz3YogpWtut4KFF+m2NlSaekRivD+tB9aejXXLBMpHkty+id?=
 =?us-ascii?Q?1ncfhBTro6zzpsUCQtzVVtQLVAXF1T4Lj5eH8ZTNj4q7RIYyGom7Lfjz9gRd?=
 =?us-ascii?Q?FHRGatR2GKpTK9kRAVlRIfQgu0Bmi2s85Zh6I8Mkt7WOOlYZI8a75/Mup61Q?=
 =?us-ascii?Q?UE67kOtfdLQbzZSVhMBCo2WThP9baAt+CZrS2GjuJrptdnenQhM1tNXrpuP9?=
 =?us-ascii?Q?4rhRLwxqmXcqfoVhkcU1XuAJ7ZnbL77UE3R1/wmGpEQ+mS1fhzUN7ZsHUd1S?=
 =?us-ascii?Q?CwS35ANeksf+iUscU0dil+tMulg6cYEzhqPxewSJYlWgnSrtiTNdQ1e06eOY?=
 =?us-ascii?Q?mTGJhdkiq7s1TwrD23kt/Pgn0aYZu46/cinNdRWI0iNYUrEUln+FsYw6BDq0?=
 =?us-ascii?Q?WoPA1LLYV/zGYs0m12Ocfn0+yRs1IaUWrTGwcVW0yJsUGYuoWHtqZI6SFJe7?=
 =?us-ascii?Q?DrrOYWQKo1bbJO37x8z0wwEm6/DDh8alnSJJadQJkt+asCO9URoIqGlZSM/B?=
 =?us-ascii?Q?bORmL7QtfWhOQwxS487fye1ZzTjccOStWNAni66Rcypvuv/68gRYaYDT7q/E?=
 =?us-ascii?Q?L8toUungp6NZH8r9Cl7rbMSIiyvP35CqF0p3vECTEWepDg0Cf8FiuSlXLJ6C?=
 =?us-ascii?Q?kNvsUhHc/JL4NjNlK4AwKaGtTS3KeNZdGDE8Tk70Z3EsaZIIL2PZlp5V8JvI?=
 =?us-ascii?Q?G7WUrekbbs5zivMDy/tRaVAea2KmcOFwqWpLpKvOnfvbzsOZAE22lNAZY7Z2?=
 =?us-ascii?Q?GmVYbpXX5k845resuojDg/XN5SfXs+vhDGdcNiDt5xgR1KnB8Y1dhChmG2rp?=
 =?us-ascii?Q?Tnk7IZg/KDoRyhiqAnpk+9xTyjzJ1nlT0781oKtjHVLKhwXo3Ts1o17p4RWM?=
 =?us-ascii?Q?FH4fdR7VMNgSAG78nbh3hGnzPc7QIEtdBfMUziz8LeH9dIKUeTbbNeztqX8b?=
 =?us-ascii?Q?ZiZFcLma4c8t2hBRbiLXISWefNVbVQ7Fb/flBK1pK8uDiMd12C6ZqRLqJpkV?=
 =?us-ascii?Q?5weiqz256s5/pfg8W5nkMkTp+hBlqWDgqR1wgZo/IPX0codjW7fd4BheXfql?=
 =?us-ascii?Q?j64LVBdB0xrwOf1Q+mVuRDvCBvyEyn13MjGtkzu7t/KO/FysDO42+GPc75n2?=
 =?us-ascii?Q?O40WmYVya4DYo4NI83C842UPw/2fIn1bjvrjMQpgAQL8iBY1i13FGlzmKRpO?=
 =?us-ascii?Q?mV2PUhJpA/nRs7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:38.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a387767a-1091-4ad6-f265-08dd3b8a2c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

In preparation to add tracepoint support, move protocol error UUID
definition to a common location, Also, make struct CXL RAS capability,
cxl_cper_sec_prot_err and CPER validation flags global for use across
different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


