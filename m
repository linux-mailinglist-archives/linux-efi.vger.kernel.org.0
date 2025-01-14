Return-Path: <linux-efi+bounces-2621-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A680A10621
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA647A3F2A
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238E234D0C;
	Tue, 14 Jan 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsQww/Nd"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75522DC44;
	Tue, 14 Jan 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856289; cv=fail; b=k0BWEcWMedjpjQ8YlY+xuj/8SQE4KxTO5ehqfUqlW0puxaBfOxQ9d+Fy3TI4ge6Dqib0g0131fTNEsUH+ze5z+XEzV6ir3hik0dgKnvdsLGizXhJ1gTibRWA9zVKBUgsrjXtPyz3giVgXtmAvYjDewlB3cSbrY3wbOtgolQ9qzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856289; c=relaxed/simple;
	bh=0zYf+p5E5MaAANPYbPkfLFP2MEfoK1RjU4uL3W7M5cA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkMXCQOKPp2WFmf2x9cNGO0rjZkwxvS1gLpQh9RbEgoNFB+CbkFMwIH3jgH0ec5zZi238vUlbO4h6CiKpOhyStaupwAfqDo0kUXcApx+7PR6qHIONEWU19K91F3BoGFjbsRaNSR7lAmgUsojFbk8or6DvQmEddg1s357nVj3Cc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsQww/Nd; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4t0dmyFM8a97bhbAwHXUi+5ayAeNs1u7EtTZACvoKQ2Gavgu35ZXx11Cf0aASQfrl8pU9WfSa9WrySiRoLYCW5EZ3U368hAw3t0Cz8ifMH/S05qpKd+ytR1wt+qMgd9drZbXg/ZaPuQjtVUx7Vxmw+gRkjFgVp6UTIrE2b4n7FPyD/x4ZKyD2VMGwhYY//fQp3Szqfh+0EM00rPACa7QKE3XH6EH4uzqeeVdhf/DexNjF7gPyt0J/6RWxZKbhal/wDMlGLM7dCVk9sNqe3bhNF8hNWPvRPdv/gliLsPKu0c2EUclGpmhu6XnO1QgDcUjKLmxuoPvVa6XzHJ+6PRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD0gCUsFFRpF+TsySguR3r4p2K15EJa82yhn0whSggk=;
 b=xPdkMt5Yt2gwQrsDJZagMsCeGHj7oWvOHlForwDl0P/JlLzkHrwA5M+ZFAkT/tT4Qpxb59BPt8TK1lYmkbdQObMPAxQySac7KFCDaShJb/0WzI2x+VR0d/W4dR/gJRSDDpUp0detS3xkI/Rz0P/45OQlT0aMeaGm7XYcIzp0FfjnnYuPhWapgDCK4TNmXkhtJuaVT8f/bZ7rG1yiCrz+70lBu4PzzS7rpRXa5aKBXKVK9Ba6xscL8zLh0cXjeK2DFvGUuZpdCuCVOnJATL/fQDF0y/eTcWcfKky4IetH4iNOOaQtAuDK++K8TeOjDzzSpJTb13y37nzvTzXRblCFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD0gCUsFFRpF+TsySguR3r4p2K15EJa82yhn0whSggk=;
 b=ZsQww/Ndzqf2BJplMQXBzhEvfYEnYxDAes3VjNfcqlsdyzUzWjZW4VN3UIom7tLozHk1wyvkEj56r7n3vYh5QlWXzBWOwrfzunWPSAcOvndcrkCfwW5zQDnEQRV66MNEyugCNcetrhFT909NDSujUTI3NRAzuxGR0hCT38ZuLR4=
Received: from SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::16)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 12:04:44 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::28) by SA1P222CA0120.outlook.office365.com
 (2603:10b6:806:3c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Tue,
 14 Jan 2025 12:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 12:04:43 +0000
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
Subject: [PATCH v5 4/5] acpi/ghes, cper: Recognize and cache CXL Protocol errors
Date: Tue, 14 Jan 2025 12:04:26 +0000
Message-ID: <20250114120427.149260-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a34184-8f81-4a4a-0ad5-08dd3493a1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OE7ti6QlgNP0HoEqhytdOB3l7BM4nH2WFivHXWtCQBUuIpK7D7JWoHE7PQ+/?=
 =?us-ascii?Q?Q2E5VzLS+u+Hm7HgZjYY0XO23yd+lUQ2iaM25KwXYjKk57xRM3067LKJbk6g?=
 =?us-ascii?Q?2JEZ7xvichMK5fh6uelkpd68+7z0TP/XVIvouyA5yUwmywHCdXjxJLi8tzXD?=
 =?us-ascii?Q?ddaJmysCRl7h0JaFPWH+9WSb/FvbHNkLoBwd5qby09WqYHIngr7c4iYmbW9p?=
 =?us-ascii?Q?slqUYdz2qOfEoVBFl2VRm6KS/ftG9KXcMBbkvSE+ss6P0NyQOCfxQT91mExF?=
 =?us-ascii?Q?3VMoNhDnyJrlkwu3hrrCPg9Xq4Pej6SI4Y31lgD7bAzDLvK+z+Yg8uwk5JFl?=
 =?us-ascii?Q?60eMFLZCUDPSF+86pI45/b9sS7K32e3M2pnQIOyJFZTAUUFCTZM1bQKP+dwC?=
 =?us-ascii?Q?AaReSdsVU4DadZbxCw6C4iGeviv1V1Cjo9wmJaUiAu6OSzhKIINUeEij8b3M?=
 =?us-ascii?Q?sjT8ERlxWxABhWrHYp9HC/OcDokPPuvgT7qU57gGAMSDWqIFmCdmeVU6qJp5?=
 =?us-ascii?Q?/wehapdo576av1VjCHKnDFXjcOEPl0HeQ0OsugNFduMEGxalmMwzzJ0odjqL?=
 =?us-ascii?Q?JBv43sfgGNU35ydhLWULMno94h9nnNQ5D0z41LTj28utqexExrfAbcrEH4oP?=
 =?us-ascii?Q?HMYZRtLlbqX0ht9j7RPzvTcIqgr30t6E6p5ModZN939PpKsi5Xb4oyz4lWxP?=
 =?us-ascii?Q?xf8cx5Fv95WFBuB5awM2TJd8lO1mu5uVPC1QfSaVBUzYTMaiC0jcPq5HZNnF?=
 =?us-ascii?Q?kWF9ZT7Q/j1cQWAT3rr0P9KW+S296Lrc97NNnGheox2J9brjhO20vPDnIC7p?=
 =?us-ascii?Q?csQyFcMS6lMzM5qLq6ECHFu7DdJSnG3ctBgg8Vsq55hqg9cNHsKciB8bdNXE?=
 =?us-ascii?Q?idpPJdqBtg9NPu/S1jRwrfa3U+nLyyF2XvOtrKxvAK2k1AYhlVbzKbuFI2yW?=
 =?us-ascii?Q?KgosMyA4tBB/Tw2IdYjx3XpcIvwQnTQMB2KvNHKut7ovRILB5DnjG6bz0mFG?=
 =?us-ascii?Q?YjwBYkkojex9Zv9h5dS9W5vfIk5QHqYDUjwvHiKvk4i9+t7JDkQYYKmlnerZ?=
 =?us-ascii?Q?Pvlj8E9wHIaPJ5i+nQ7BxiDewINuY82FK8dFZ9Fg2wa2wChb/GRxwMk2+PoY?=
 =?us-ascii?Q?GZDSJbtNVUcet4ET4wdK9xPbG+GXXU9/jGuQSmHraoi+OS+qvB6JZeEcA+tR?=
 =?us-ascii?Q?BpBlRBPyd2QxkwrRZMwWxM9glXdbn21r4Mknj7I+CA2BsIjoc3N0eif6zEne?=
 =?us-ascii?Q?QicVfJNQWE3i5q3sV6mfNofR0WwpU6rDVsULXIYdsPbH/+kGiMhRRQlYBZTx?=
 =?us-ascii?Q?TSHLLAzTmwPdmhS+F/Ysf+vD73Gvr8iVAyp2V7PJxKoDrW7G1a2DG28RnrXg?=
 =?us-ascii?Q?tJ8F/SCpQlT6frgThxO3hM06Mor5eWTt7+ruTg3Wn9jCfwmz2TmWNpjd7iye?=
 =?us-ascii?Q?na3rt612GXVAEBjNpOqmlwSR7wF/qb/VNUaLm1rRfp0VCzI+rxYHctz78kPb?=
 =?us-ascii?Q?1PsEpc8boWhG1u0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:04:43.8224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a34184-8f81-4a4a-0ad5-08dd3493a1ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

Add support in GHES to detect and process CXL CPER Protocol errors, as
defined in UEFI v2.10, section N.2.13.

Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
information, including RAS capabilities and severity, for further
handling.

These cached CXL CPER records will later be processed by workqueues
within the CXL subsystem.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h      |  6 +++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07789f0b59bc..4ab3c8ae1360 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -676,6 +676,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				   int severity)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cxl_cper_prot_err_work_data wd;
+	u8 *dvsec_start, *cap_start;
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
+		pr_err_ratelimited("CXL CPER invalid agent type\n");
+		return;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
+		return;
+	}
+
+	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
+		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
+				   prot_err->err_len);
+		return;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn(FW_WARN "CXL CPER no device serial number\n");
+
+	switch (prot_err->agent_type) {
+	case RCD:
+	case DEVICE:
+	case LD:
+	case FMLD:
+	case RP:
+	case DSP:
+	case USP:
+		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
+
+		dvsec_start = (u8 *)(prot_err + 1);
+		cap_start = dvsec_start + prot_err->dvsec_len;
+
+		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
+		wd.severity = cper_severity_to_aer(severity);
+		break;
+	default:
+		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
+				   prot_err->agent_type);
+		return;
+	}
+#endif
+}
+
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
@@ -779,6 +829,10 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 66d85fc87701..ee1c3dec62fa 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -232,6 +232,12 @@ struct cxl_ras_capability_regs {
 	u32 header_log[16];
 };
 
+struct cxl_cper_prot_err_work_data {
+	struct cxl_cper_sec_prot_err prot_err;
+	struct cxl_ras_capability_regs ras_cap;
+	int severity;
+};
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
-- 
2.17.1


