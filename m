Return-Path: <linux-efi+bounces-2620-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE05A1061E
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 13:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D699B3A86F0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E022DC5D;
	Tue, 14 Jan 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="By5+hI02"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1120F98F;
	Tue, 14 Jan 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856287; cv=fail; b=gmvpJWlXoDszF4agnAgdzEKMAfR+vt+vNV+P/ykeIfr0MhG34HvPuEQaE5q/d7h5lJ0B3vKT6CxNcZsSnsTc1GWcOaAiRpH/hHH8PmQGInNIs4WDCm0SGex0QHAo+esSQnGJ4sy6i6kfC6QoBDniFPIZvP10d29g4FUqdnYq9Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856287; c=relaxed/simple;
	bh=UBL/b/K7iVFHLAvBrL5eqfd279v4PDKw8UD8L6hhQQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byS6s5b9PVXrobvqPRlNwlaHd9Yz749tvNFHlKCXR+KUKbdIYbgPNLyw3r1W/CuiRJ8E1TQBHcCKh+K90KABc1APLJqruyazVfKGp1+i65MY44j0T5cmSQie8ztiCcz3hhHVXwKNelSFSyd7Cb15B+kH4WLdF/RrLiJw0l5K4eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=By5+hI02; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc4R+7V/UuKxgPscOCfBTCXcVQxs2ob7piyD6eXOgnneqi9CEjn0FfCAm4CalbJrsx8ZuljXjNqvsDDUGvtbKj/nMIXnJUH8uL+r6dr3j58+yUBwwGFYj7oRo3edu7b874GBJMW1q/HrEvhHTVmhib3jH0WMlpkJZUWCUGEwzc1nBoCOo1bIYaN5hMz9+j6kD1gUyctzGeGoldlvywrI2dfWR4xaUAObE7biBUGHC8bAR43x9Zeoi3Hu11004zi1umQwBynJ1MgB1HYLuw5GuvTdKHm0hzE6RxJzVscoryIeQ2KguxqMYt5lNzz3VL9DwFY4b3AYfIt5ItXM2VzFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B94FjdI/9BIi6raps7RIhArGu1oRNOzA/PlrSPnx8E=;
 b=Q78VXl9DM6ZOH+GTzQvfYv8cDdkX3yMxiDKqQ8bHyLms2VmkgVM5UPa52+v8D+YpKVFMkCFcmZ5QO28AMZHOcmicFXHO/c1/qRjrcYHJGCgMHhU/DZR1HPL1XWv8EtMM6tombUIu4i/ea8bX5GnZCK4ykkfGeX4MY9KEcEecyoJQ+Oeas5N180vZjnHwrW84dFFPmGuAESyI7IsLJqbhiqUFsUtQbQAnKfGHefwqTbfH3ghA+PiQz2aDm00IM/NpOo096DY0BuRK43Z7+PBNZ59jRVxuLCs4fEGP0rgywDFsx6d5NbpuEermRmKWieyGPEx7lAYhIXgjD6N8SKEi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B94FjdI/9BIi6raps7RIhArGu1oRNOzA/PlrSPnx8E=;
 b=By5+hI026bjIwKp4aAVsKyei7WyfFchEzHP1QyTwfT/eu0UtL53Dgjfo/mBa5AadVdViOUiAdwflG2ubIPf5imYKUOyKqx06smpDyW85dt8Oqa4PkbAQV2jXh99MgJ5ABUQz+GGAbtiFrIIoNx/ASVtE2augeizQg3+yoe6/lmk=
Received: from SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::20)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 12:04:43 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e4) by SA1P222CA0116.outlook.office365.com
 (2603:10b6:806:3c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 12:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 12:04:42 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 06:04:41 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5 2/5] efi/cper, cxl: Make definitions and structures global
Date: Tue, 14 Jan 2025 12:04:24 +0000
Message-ID: <20250114120427.149260-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: c547b58e-3fc4-4c3d-5178-08dd3493a102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cv1VO11fr0iUU6mweBp3WizeCf7rJVwxolDUD9qbDl1D+nsaLozzpwShBIlw?=
 =?us-ascii?Q?DiMfKVufWuFWi2E85vUqRxf+px99GnlrLolSY5W7RHSeq/E7GuA6A74WH+LZ?=
 =?us-ascii?Q?6vPJIpgabeGrHtDda56BWC0OrOwNNyn8ScELeWNmXr7UXCCBR8GDJSKLZS4j?=
 =?us-ascii?Q?JUDLDBygBtVhaM8UBBMK9uCPOOuJQlc4px+Qz3R4uqM9FxWKNv2qgKcoC+k6?=
 =?us-ascii?Q?o9R3pS0kdK5edxZpaut6Xi7BERko5GJKQ5cioUYqN/dOqzuivGAkgtxa8BXT?=
 =?us-ascii?Q?VAiIuuomyNHdvbbdtGznlVlyv+mx+frGHBSDOIb1os8FFSMnks+/vplAkJmS?=
 =?us-ascii?Q?szE5VB0YsK/1gtbi7jtBY2cG8wOOv0d0zjvLoN5giXnYzoUhcl0ovcsU0dB6?=
 =?us-ascii?Q?NIJVrVZtuKzaFdl3Xtn32AeddhIxIwphRMxRw4cvhfGU+VRwPBq3LlQwcL0k?=
 =?us-ascii?Q?cyPkOhDGTrVN/dVJkgrzFa48pqp7uVMW4/cNdwkq8r6k4C5PjJuHm6G5Pkip?=
 =?us-ascii?Q?7VOnvzXCyiTs8d+GltunP8vcPoBrnSSf6ixm7za96wdEip00x1d00pGtslca?=
 =?us-ascii?Q?qOxpMbOoUFi3sKQE5AgC+2ohc0ke0T62BC/U1ygQWzeNNkcOJogpRDWl+Mlu?=
 =?us-ascii?Q?nRrspgIN0kUgyr+kMpB5ekbpTEOPkt8YIuzE9LVLqyD+193OEr/g3r8Yu0bR?=
 =?us-ascii?Q?xQE22BUCiml/94vm/zrU+u+9a65hMH1dNHiL0xOsz6C2TxUojEgnl+ycoE5w?=
 =?us-ascii?Q?fDG1dadZu7MwLG/eUv+mVmpu+nDgLe5nDKMbK3C0jL7xYpWAlUjPoJ0n4frv?=
 =?us-ascii?Q?xH9D+jLPwIq8ILqWAdJgSeeZXn7rVt1bKfy5oy2u1gqlqXQcjfVdwdf38E4k?=
 =?us-ascii?Q?51rpxN1iztTBfGStIb/c7/eznuX1ETxzdw0qe5OwQquanWKFPdL3Fjak4AaH?=
 =?us-ascii?Q?cse+xAS61dZmhghFsum2S/QNXgr/5fBE9IVXfUgVm+ZHjxgfKYf34Dwu/Iyi?=
 =?us-ascii?Q?/J5r02DROV84i2MP3qimvXstOPO15M+1BN+3AcSEmSoGHIZ9ENs1lZZhzWSk?=
 =?us-ascii?Q?h69EC/Uvb3kALYST83bDmfJ5PNNbvJuQQ2uwSwp5z1O7iIR3Q4WgKSDMIJ/+?=
 =?us-ascii?Q?8XhqxZlG/E1zc4BQnBfMiPj2bBxXVT1FWpkD2Me9G+tPZHFoBv/uvTtVV9j5?=
 =?us-ascii?Q?jObf7BTpBA9HNlRFu86dK/0xKZR00gmHzrB0rXFGbmQpWLV4rb3jVmiCf6/Z?=
 =?us-ascii?Q?ODonunSJP9Zlg2+4a/Nme6IwqL/EVS60+QXJGiuAP1GSo1LW8jCF4QXaDlku?=
 =?us-ascii?Q?6AcSb6SK8nTBYA7T6nZ9ZTzMpWlPNqMm97YOL0+ruu6QnNr7IuG06MMNrGnf?=
 =?us-ascii?Q?qa91IJcj+HTiYmD4hSEcgz8fMyNpAxmEb+69XtXLXAZuBeP/caFxAXQScfwa?=
 =?us-ascii?Q?2qnqgkPBsBI50Ck0EqCNUy886SV1x734zKxp4f4qKrWORyvg8LBRzIk7Uk/N?=
 =?us-ascii?Q?cLhfpad7+H+Jl7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:04:42.1817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c547b58e-3fc4-4c3d-5178-08dd3493a102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

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


