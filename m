Return-Path: <linux-efi+bounces-1055-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D058CC3D3
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244151F231ED
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6B249FE;
	Wed, 22 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PBkUe/Gk"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8932940B;
	Wed, 22 May 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390537; cv=fail; b=U02F5fT+EdjjFJD6pPXzq5m//wsWGFTt2TC4Rpinv9iQrz4qy+ZCiNnnaY1K1YU287uOp+a7Wcfoy8N3w3nGg2FUHTa10AtEcEHlYC8CFj9kLQctXCS9ugQ8XyTHwiwl7tk3jNorNel+RbDkPWw1fOAW7NjnSwC+zVS7zVmcf3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390537; c=relaxed/simple;
	bh=xQQ8aJ19aqMa+vADwtKC//4tDYxm5PWzjQI12/T9HXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dimjnq0opmm4y7R8D6yem1X++Z2C+K1g4NUGRc4RvommBCsTJMPRYRy6sxmj/OXdcZyhK0QNSrRSfOCXYhyF4Qngsuvm5jWbrO3mLR21QdooilWFn8IIbnp3t4b36qioSaLYD3m60WzBlOE268M5BCQ8fVTt7Sc+b1Ogu3FgKRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PBkUe/Gk; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+mOKOBc94qZlKrayLJ+03si50Hntcx9bxrWph5T3AU3CIMXr9lEpD1+UO3VEn6wtKvKrLsq1Pa8R/Rf7RZmThoNxWnNzY+Ij6YOlucxQxaeQQ6SzNkeLFGGyjJhliveWgA1/FyRRsA6nAvwwfPJfC2eYMy9bKsq2MNRPWHt1Jx78QuC/DjKC0dCldbgiFKiBYov6KGxblo677TsOxBKQSI2sPY2Kp6oRlww65ha9YGZmoIwHmFBNE8Gv/QlWYHDIRbZ0MBAE0aB0vpZWbRwBcQYeoFxmyKBiTU8wEsfbiGp+ti6TdqgLl23JDpwdFquAEVX5RW4etJe3vKbcGk7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcrtcZIpbk2yYWXWUWZwIHg6zWYYwDSA9jkDyuYyA5M=;
 b=Un8oLXR74c2fFk0afobpETC0lB3rT9rh3WoE5EMqLJ9f5T55C4ST3rCqiPVjNcRUm7Jfqe/+O1uTvfYcOrWApfvW3J8PUjBy3YXRI4+EH7cTzp32XJNfCb7j0FUrZ63icvLzHYJXlI0eZF6H4TN4Nb0bCEe3YeNJFRG2zYhkN/iL1IPskCglsfOmu/kFLKD8cbY3Om16Lu7/4lg5I4mKUfO/qQ3+uQhNFUU8qXBWPX7l5nlLgw4ukD74roT2JeE4ZdvUdhAlpHjTjEYwWd19s12p9tBdKXggPB1JGJvPk7DX/HxLF1eK6qEdOl4/z3so/QXHzvROnvXlirat3sf05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcrtcZIpbk2yYWXWUWZwIHg6zWYYwDSA9jkDyuYyA5M=;
 b=PBkUe/GkeyqA7XmmG+9MmCMN2gW5Y0rBVBlVyomxftukTOg2n2Fwvzt7KEpQz4ra1vecyDrOBtad18e7oiTKIqzKFIjeN7pd4qvVs8H/yEbVNEurLo23RtM40HJOIvRWcY218xn+U1w5QH7LgSdUE0PYl7bCLZ3iluewt5yR2Gg=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 15:08:53 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::f6) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Wed, 22 May 2024 15:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 15:08:52 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 10:08:51 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
Date: Wed, 22 May 2024 15:08:37 +0000
Message-ID: <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: f1490577-c123-497b-ad0f-08dc7a7117d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MdKq8w/d/sw47xx+v+ZvM8LSmdkWWHHAykYiiwK52mYefJhpRQ8CWpxt3C5a?=
 =?us-ascii?Q?HUKZYyx76n9lmAGeQVwJUXJ0RhorYWI5Vil63iPkMU2ot3lqVjZ4YSG+cuGt?=
 =?us-ascii?Q?ChoOIbNQXxWGbLlMFvvPgTFh6f35Aug/j1emZDo81AHTzFcpa450nbKvDs9p?=
 =?us-ascii?Q?cawCk1qbX3leL4f8bWjZqThPNYmZklr8ymqFKHnR162zf8m8MXfFl6x45ifz?=
 =?us-ascii?Q?UOk2YFqSC9FyppzSDZzh04uxSVaLgu9n2YBNo+SU5CcUigL9dvy1QQ76zPKt?=
 =?us-ascii?Q?q18Kup/CpwrBnS3/KApDTe9AftC8VUz1AvPrctY1WF+bdd5YD8Rc9rTjRNy9?=
 =?us-ascii?Q?XxeBVZx3FUv0kWAQl7a2Vnc49jNXDt9spczA7KVIk6ExVkziIlpipWYNPGxW?=
 =?us-ascii?Q?E5oc1jA9RniiFxWkmvVZPLwHmF2gHtKxKckWEHEUYFEKfdjqcY430yFvfLeI?=
 =?us-ascii?Q?HXcVfAwqM+MTBaBeV4ExWNNimt2gM9aLLfdaPRtawBC+CKZ3SSorVIbdslPH?=
 =?us-ascii?Q?uiqgIwBP3XipBol/YRfn9MfFnrzYxh2o0h3mL1vj9S27Esaa644QnAzkt3rU?=
 =?us-ascii?Q?dfBl0H7HqyJCvlKyWnIEYvAZSqjkN5XpTEte4QbqFT5P8vbkHDY5wG77SI9z?=
 =?us-ascii?Q?eNp+wwU2/UsJXmT3l7YIgUJuxagJuk/ECOOZ6SlkAkyyGZfNtPr1JeD4sJd3?=
 =?us-ascii?Q?DHl7FfXHRv7ENRhoG8oeDtA/ScCAQIf4dfRgv8UzYsPhttcDGnQQrVg58BPL?=
 =?us-ascii?Q?9I9/QuO3MBNBxHDOVid2Gns0JE2noAOXneURm/xOds/KPeZ1WMyVxf5jFya/?=
 =?us-ascii?Q?qzvM3XHw3EqU78sHfTGvTjjvdq+FC07gQDqrCHRHJyuET/xoo0SP1OSJ24mz?=
 =?us-ascii?Q?EoIF6rKGYgAaecuHorVcwDPDww0K/dCibDwTts8DgqFTtYd1IThlY2L9pbub?=
 =?us-ascii?Q?tuH+VESFpDqUYjKoU0UCiW/ixr2rMcQGSeIZGx8SirDIPqJhOvxx3COw8eWi?=
 =?us-ascii?Q?el0DemkAPjdMaDh5fcEkCbTgxQDTIgbfuqTQG5NGspuVRmT+aVh1VS/LuAj3?=
 =?us-ascii?Q?JSM5yGyGqi9BKLoHT3Rpvv5ZLBddOwatUuklwiC5DnHJK5ZnHbBCyuGhRgqw?=
 =?us-ascii?Q?7eJl/RdkvRY1qP5W21QyULihaV4CK3fib9FvzBWv3KfFBb2JZVLmCOq3SWkS?=
 =?us-ascii?Q?9UxTidv10R/+uNVa3cQtFS8mmcSzc8nN/9+OC1zE/wP4UqY1N4OfEvq4wi+X?=
 =?us-ascii?Q?nh1Q/GSLIZfR8lzVqwOWw5KakFA/21k6PrOqW5Y3OIJ0b3bkk3r1e9uzvyRk?=
 =?us-ascii?Q?7XFdLsLJ5JUyKnPY+XlLYKVz18/fmfJOaaEFJCy141BNPvtmJHMbNg/AFvqG?=
 =?us-ascii?Q?/HeDBTo+mxBlbfaq83kWC277fxOg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:08:52.9202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1490577-c123-497b-ad0f-08dc7a7117d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.

Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
Severity, Device ID, Device Serial number and CXL RAS capability struct in
struct cxl_cper_prot_err. Include this struct as a member of struct
cxl_cper_work_data.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c        | 10 +++++
 drivers/firmware/efi/cper_cxl.c | 66 +++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h       | 26 +++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..1a58032770ee 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 	schedule_work(cxl_cper_work);
 }
 
+static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
+{
+	struct cxl_cper_work_data wd;
+
+	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
+		return;
+}
+
 int cxl_cper_register_work(struct work_struct *work)
 {
 	if (cxl_cper_work)
@@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
 			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			cxl_cper_handle_prot_err(gdata);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 4fd8d783993e..03b9839f3b73 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <acpi/ghes.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -44,6 +45,17 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
+static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
+{
+	switch (cper_severity) {
+	case CPER_SEV_RECOVERABLE:
+	case CPER_SEV_FATAL:
+		return CXL_AER_UNCORRECTABLE;
+	default:
+		return CXL_AER_CORRECTABLE;
+	}
+}
+
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
@@ -176,3 +188,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_prot_err *p_err)
+{
+	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+	u8 *dvsec_start, *cap_start;
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
+		pr_err(FW_WARN "No Device ID\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The device ID or agent address is required for CXL RCD, CXL
+	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
+	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
+	 */
+	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
+		p_err->segment = prot_err->agent_addr.segment;
+		p_err->bus = prot_err->agent_addr.bus;
+		p_err->device = prot_err->agent_addr.device;
+		p_err->function = prot_err->agent_addr.function;
+	} else {
+		pr_err(FW_WARN "Invalid agent type\n");
+		return -EINVAL;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err(FW_WARN "Invalid Protocol Error log\n");
+		return -EINVAL;
+	}
+
+	dvsec_start = (u8 *)(prot_err + 1);
+	cap_start = dvsec_start + prot_err->dvsec_len;
+	p_err->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
+
+	/*
+	 * Set device serial number unconditionally.
+	 *
+	 * Print a warning message if it is not valid. The device serial
+	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
+	 * Manager Managed LD.
+	 */
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
+	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
+		pr_warn(FW_WARN "No Device Serial number\n");
+
+	p_err->lower_dw = prot_err->dev_serial_num.lower_dw;
+	p_err->upper_dw = prot_err->dev_serial_num.upper_dw;
+
+	p_err->severity = cper_severity_cxl_aer(gdata->error_severity);
+
+	return 0;
+}
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index f11e52ff565a..9c7b69e076a0 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -165,11 +165,37 @@ struct cxl_ras_capability_regs {
 	u32 header_log[16];
 };
 
+enum cxl_aer_err_type {
+	CXL_AER_UNCORRECTABLE,
+	CXL_AER_CORRECTABLE,
+};
+
+struct cxl_cper_prot_err {
+	struct cxl_ras_capability_regs cxl_ras;
+
+	/* Device ID */
+	u8 function;
+	u8 device;
+	u8 bus;
+	u16 segment;
+
+	/* Device Serial Number */
+	u32 lower_dw;
+	u32 upper_dw;
+
+	int severity;
+};
+
 struct cxl_cper_work_data {
 	enum cxl_event_type event_type;
 	struct cxl_cper_event_rec rec;
+	struct cxl_cper_prot_err p_err;
 };
 
+struct acpi_hest_generic_data;
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_prot_err *p_err);
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
-- 
2.17.1


