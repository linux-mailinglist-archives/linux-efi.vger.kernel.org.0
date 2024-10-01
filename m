Return-Path: <linux-efi+bounces-1857-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E019698B199
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 02:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58985B20DB1
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD12209B;
	Tue,  1 Oct 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hF+dFvmV"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9D134C4;
	Tue,  1 Oct 2024 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727744013; cv=fail; b=qaaarQXjHAGoIbylUeF1hcKh0QC4bUnDfDWaiWpr+8OB34t2t9k2Usduf26A07O7F+vmxK08T6zZeihi1JPeRv5/5ADTuz69uy0LB1bW8XBZu0/QUKsWsmXACL1eRpe0JYULp9jJreVAcBEZ8Nosgx2gY200XT14rSqF9xrVPiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727744013; c=relaxed/simple;
	bh=iLKW8fmgrZChTG2tB7EltCGTjcFc8XZ8i+mAGjZw3Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hluW7mASDFc052YQITVRz52lS+YS40MDkBxuC2fLiZUJWEZXXlNYAbayRr6jnxc4z4Z5A2V7yJwuRnyWEANDpOot7Odk2fK4SSUSUCfLhMaooqzpqz/DxBRMFm2zm7AQagKQ7ZmT3v2LIVV223+qIaWvnzjqV0b/5iI9+kEBC0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hF+dFvmV; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZcErOOUjVitQ9Ej0Hy1qDHk8tycBUAQhXOv58tXxApXGM9LAU/8SR6Pu1fgEswBTh47rkPrauFnxHuEoqG0gKGoUzQh2FqoNJP8czy5vAJcnkX0Rw3gtspyaBRxHYxpQ0ku7BxNdORFfofW9AXqbUc/IPd9/yQ+p5vaEF3xk9HzC+auAryR3Hye2d3iFN89A1kGj00G41yh1gMAe8QtCXnIc9oeFRcte3t+NHP7x/iyO0aiH7wB8kZvWHzWxAayhR7/p2G+2Xl9TqJkh/ZSLyfFZvOkveDGO5rYGkf5vKcFaNMPi4XolHwiSIsBy5AXr1a64Z2HDxQJ/dpjA7JyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOvQimOQn07EwLXdjIt4PauGk5wY+2FucRd9CmNaPYY=;
 b=oqSzg85nRYLyyi5BPnypkiPVJc3CoErtW9HxJ+3qr0dNirtWl1jsMK0fcQaKoV0Le0m9ASlQv2WTfkEy3bD6D4yQP8ihpARavbYXod7m/VN3Ley19a883wpzPAHrpRAjp7LaiY4RNBXH7Zy9ioOxSiSzTgBpVlE12n++oCtlfoa8oHrfmyP6+5V5NavB8aCRgnFr5nhfiKCC6K5Sqw0wfGCl++9KVqABXOtY0npFbsq1aXST+UWQJLpy02V2aNOpu7pRX9/IMOWGBPo9tdYfsOIdhQ7Xph6yUWRoWQ9F90Ii866Z5X3s0UeUjCSe8XxfpCzLqCO1iZAqxwQMByHxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOvQimOQn07EwLXdjIt4PauGk5wY+2FucRd9CmNaPYY=;
 b=hF+dFvmVYwHgHLv57xoblnkzrSddas7JNwSpKkuL5jv0Mjo8G2qz6fvQYgfmNM8UJlcUUi/FWY6sZx4+LOxX59JxaZTe74B+3XMw7/tF1lE5sm+WsZpfGNm/Mu4mAQfhRiIZGNPTcihd3D5SMomMFCClIc+X7tptsM3JA5eoyS8=
Received: from BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 00:53:28 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::bf) by BYAPR11CA0045.outlook.office365.com
 (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 00:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 00:53:27 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 19:53:21 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
Date: Tue, 1 Oct 2024 00:52:33 +0000
Message-ID: <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4579d8fe-956b-4ad9-328f-08dce1b37643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Al59W8A9M/4JLDbSheyLtRGp87nKWpNDuMiM9hOdgWH1AqJYVSEqEuBLzD0C?=
 =?us-ascii?Q?WLBoXHfWOvXXyIoT6msVaUkXEhnjqz6XMZvrltuvBYNscGiRPkcX5K3ebJX6?=
 =?us-ascii?Q?1izO2i7JyfP9vVMQD2fKR8EPZBz+YPODGPLR+y0OVSLBV8EcT6a0+5k9UkP+?=
 =?us-ascii?Q?LvDRVoCAKlRMzOz7DputmHJ6qssLEMVfg04He7PI+mZces0TFU2tuNraD6Pe?=
 =?us-ascii?Q?3Ex0A5Vka+z7BDnoq5pC0+VAeNm4IPuj8vVhbmHreNRd2a9eoogQRuDKKiCp?=
 =?us-ascii?Q?LXVl/bCmS5wiGjdLv87LA3XelZB0mWKdqfvUbi9xHkE/ylfULY35CY+MmRy6?=
 =?us-ascii?Q?PF5+nGEc7AStgVt5ZVWLbdH/TSYRbJpBAZaoJ4lgmyM14Rl851Rn/gqKxOBr?=
 =?us-ascii?Q?ra8OczbPSVJJtkzvOWWUrNtaZ7vttt4bUUJddKb9bj/wySQj1djp4SBfQ/zR?=
 =?us-ascii?Q?aLQrlf2RSqAPQy+U7sZYrqUT+RAXIUBPlzSghK9oNJjeo9wWDHVqMGEyLhis?=
 =?us-ascii?Q?uWrYLsodhYY0w2drRhddSqY6pvCi0phQex9fX4JsfqIsMRXN4nYgj/Yo/8c7?=
 =?us-ascii?Q?xLKh6TeAxxNmATV39Q2gd1ph/hU8ls/PYYa+LQfAN8rpoVo6zetEJFqiZtdF?=
 =?us-ascii?Q?DOnZW/IYg3jJh6ZxN7NFn/KyISiAbrpdXY+7NjLJ+Z4a8LRhH7Wv1nQKl2Pu?=
 =?us-ascii?Q?Q0vk8b9yTeqrzNIFWcC2kR2hf0ksb/GVkBg2e0f5kIJo6blVGyAQxC14OarL?=
 =?us-ascii?Q?k70V3fKQl/ZYr/NZLk8w+Azo/5aTiFtQQYe2wKCAmUfqmULvAGfbzXNg4BAR?=
 =?us-ascii?Q?aLMzFDYn/JYRT/FW+JrC/vTdy5qQ/n9vdPa0Dvsk9fiZ71xQh7f2e5bgnn2J?=
 =?us-ascii?Q?UKRgr81gyTY1o+1otEXlq3J5FWhfvLlpy7Yrwnoimv1MtQPm2YB9fribLBey?=
 =?us-ascii?Q?8q5SkrR/v7Oq1se3KLKDzC9YIkdwe/S/zrQx7t6VATilqRH3JUZR/htjZpTN?=
 =?us-ascii?Q?OK9qaGqd+orBFT8TGfiZRF93qPDH4K16bhsEqNT1mPlx5+CEnV30iiZTUIsH?=
 =?us-ascii?Q?HmgdhSHj3YBIf9UzvzX01Xk5CAu39VrlNa5iuZB9mageR7ILLcYz266/LfgS?=
 =?us-ascii?Q?ZFMm1wS0Mms3IUAQkjmrvTK4ZDFexGOs0OPTOvx+sTVvQwyMjgBgKunOiqCT?=
 =?us-ascii?Q?3WjMzmnoYNDe9b7slHhPgUgCK/Nn1OlOO5mHpA+D0BFN1jBHAr3kyHdXhUhB?=
 =?us-ascii?Q?RbSyn2XmUgWaDFPiShq5OCaIyrfL6sBEOrNjTwC5IvpGFvuQnxlcvXhH9hwa?=
 =?us-ascii?Q?/ddCpCg5K/X0GaRP5+PP1BPT/ybcTlb/RawZuISpTRs5UmrdjriOkHMHaFrQ?=
 =?us-ascii?Q?WPJXUs/TYnEw1ecUKaB5TgYoZIHEVexOxR/gnU1Xb6NuMdnUBMxPq74DXdMj?=
 =?us-ascii?Q?4tzjTg5R//V5JoS+NmGcnPSjllcCU7aP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:53:27.7872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4579d8fe-956b-4ad9-328f-08dce1b37643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.

Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
Severity, Device ID, Device Serial number and CXL RAS capability struct in
struct cxl_cper_prot_err. Include this struct as a member of struct
cxl_cper_work_data.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Defined array of structures for Device ID and Serial number
	comparison.
	p_err -> rec/p_rec.
---
 drivers/acpi/apei/ghes.c        |  10 +++
 drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
 include/cxl/event.h             |  26 ++++++++
 3 files changed, 151 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ada93cfde9ba..9dcf0f78458f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 	schedule_work(cxl_cper_work);
 }
 
+static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
+{
+	struct cxl_cper_work_data wd;
+
+	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
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
index 4fd8d783993e..08da7764c066 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <acpi/ghes.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -44,6 +45,66 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
+struct agent_info {
+	const char *string;
+	bool req_sn;
+	bool req_sbdf;
+};
+
+static const struct agent_info agent_info[] = {
+	[RCD] = {
+		.string = "Restricted CXL Device",
+		.req_sbdf = true,
+		.req_sn = true,
+	},
+	[RCH_DP] = {
+		.string = "Restricted CXL Host Downstream Port",
+		.req_sbdf = false,
+		.req_sn = false,
+	},
+	[DEVICE] = {
+		.string = "CXL Device",
+		.req_sbdf = true,
+		.req_sn = true,
+	},
+	[LD] = {
+		.string = "CXL Logical Device",
+		.req_sbdf = true,
+		.req_sn = true,
+	},
+	[FMLD] = {
+		.string = "CXL Fabric Manager managed Logical Device",
+		.req_sbdf = true,
+		.req_sn = true,
+	},
+	[RP] = {
+		.string = "CXL Root Port",
+		.req_sbdf = true,
+		.req_sn = false,
+	},
+	[DSP] = {
+		.string = "CXL Downstream Switch Port",
+		.req_sbdf = true,
+		.req_sn = false,
+	},
+	[USP] = {
+		.string = "CXL Upstream Switch Port",
+		.req_sbdf = true,
+		.req_sn = false,
+	},
+};
+
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
@@ -176,3 +237,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_prot_err *rec)
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
+	if (!(agent_info[prot_err->agent_type].req_sbdf)) {
+		pr_err(FW_WARN "Invalid agent type\n");
+		return -EINVAL;
+	}
+
+	rec->segment = prot_err->agent_addr.segment;
+	rec->bus = prot_err->agent_addr.bus;
+	rec->device = prot_err->agent_addr.device;
+	rec->function = prot_err->agent_addr.function;
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err(FW_WARN "Invalid Protocol Error log\n");
+		return -EINVAL;
+	}
+
+	dvsec_start = (u8 *)(prot_err + 1);
+	cap_start = dvsec_start + prot_err->dvsec_len;
+	rec->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
+
+	/*
+	 * Set device serial number unconditionally.
+	 *
+	 * Print a warning message if it is not valid. The device serial
+	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
+	 * Manager Managed LD.
+	 */
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
+	    !(agent_info[prot_err->agent_type].req_sn))
+		pr_warn(FW_WARN "No Device Serial number\n");
+
+	rec->lower_dw = prot_err->dev_serial_num.lower_dw;
+	rec->upper_dw = prot_err->dev_serial_num.upper_dw;
+
+	rec->severity = cper_severity_cxl_aer(gdata->error_severity);
+
+	return 0;
+}
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 57b4630568f6..5b316150556a 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -158,11 +158,37 @@ struct cxl_ras_capability_regs {
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
+	struct cxl_cper_prot_err p_rec;
 };
 
+struct acpi_hest_generic_data;
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_prot_err *rec);
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
-- 
2.17.1


