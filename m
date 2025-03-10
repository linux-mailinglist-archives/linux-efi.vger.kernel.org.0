Return-Path: <linux-efi+bounces-2957-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1103A5A875
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 23:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA732166EB8
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E71F09B5;
	Mon, 10 Mar 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IRvdbHyu"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08F1E834D;
	Mon, 10 Mar 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646341; cv=fail; b=Ugayhy9lRQvRc7LMuM+2Hk+glg4IE/CI3bVpq36UIS+YzqZchAEiho28JqFbU8fCvU4+OX7Pvtm9YJ1bVLCvzd4GGK4ylc/q67gtmkVaK4ah4kCUQs2A787f5kXmL738kupqr6l0MOSo/CNY7E8EkEMhpfV9hFlG41CSkDgdqxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646341; c=relaxed/simple;
	bh=PBEuAzppPJ2sVYnVvYu83v9k7P/YTpfAhTd7BxRP1iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myIy1df747e7vxnQuMGETSf5whGRX46DnhdnrjrN88/ek6E+nu/khI/hOHHbDDKqmdQOtHVr2NKFf0XfeQogGvkhiLdsiR9wwA89De/2fn5jFHvwJ9PFro4ys9x2+Vusq33eJuQ09mBUsAybzv7XD6Gzii+0FiZDfOMNpDey5kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IRvdbHyu; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g62/5AV8fI2B6ibA5xCtF0bAwJhIZTaeU1RnGtf/eJSk9RF5zHw9W/Tp7qGjNPXu4TTOGTXEgiRoguZmNZQgHVPgGmoCBYgFLVOEtRZ5O8z8zk9qTjQpuuPdwJJ/d+o4tpSC1PIqOtEpFgO9RyBmPor4FFl/RDjxQxb3GWiRPUJjE4lcHz3vgb4x+SZriCc5TN9eangddP/fWMzKLbW1H4+3uXX0ur1LxhOd9h+hm/Sl338QtT51SR8aM45/d1ATcYIijjo2SM9eYCCswV8wZqZvELPqZV7n+X2SnBzThm4WvQGFTNpLca6J0QYM2mF7K+aqTzC55kGAnuThQyXewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsXFq3GR82kR0wvwseFtepUUsoQEWXVHWyrodGEFJ6w=;
 b=TMn4cmeutbU7X0qZt+h2jhgVYB1zPsYvWlLpUusf7DOelUriMO8ey33+m2A5xIosMClxbijcgZmYKma5NOw71o0SI0i6IPk0myFXeQ70sgnyznE7mLfvD5pPrqCdzJiIqgEvzT1x+3kXVNHDmThICu8ogDtcUp8xjAnL3QU3jB80sdNqrl8jehuLl0Ae/LpVC+7sOg1FQmnq65BZTAs4oPdN26iDnw9W8TmvwKSnTGY4VonDzgunu1FyqGEtk/PqoJR/qlbJr6jC/keTtTk6T5wXI0405w7cfc2OWoQx2GiwHzNiTQyCgvPA2HjuuPUBMBXbHwvs8Drq8DfNrLWiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsXFq3GR82kR0wvwseFtepUUsoQEWXVHWyrodGEFJ6w=;
 b=IRvdbHyuoyb3P96OlEyaPfYouLDFDy0VeCt4Ikuo5ZrWO9EVy5LREv1XPkOQwmTGKTIh6u4qt3U70EO50MR2wue/DXDfFGiZM0aSeiHkUa6qN4YeXyh13wAhXnbrT5yoymRP+qeELGSdBGLU8umn2x+PZcd3vi0rd6mZCAYj3Nk=
Received: from SJ0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:a03:33e::11)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:38:56 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2e) by SJ0PR03CA0036.outlook.office365.com
 (2603:10b6:a03:33e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 22:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:38:56 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 17:38:53 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v8 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Mon, 10 Mar 2025 22:38:39 +0000
Message-ID: <20250310223839.31342-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8239fbe6-d2dd-471d-c924-08dd602457af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C8BYYJOZzZrJ/i4CdyRz6Ck/+4vldAH0Moa9JDENRwTajShC1tZYDAY0HPcz?=
 =?us-ascii?Q?mpQ4tThNSle27am64JP3FMOFYSSkbH01TISOMzMJqRz5BNP8H0wWUMAGdocs?=
 =?us-ascii?Q?dXGX1wO+6y+T5XnwKaCDu3Txt8KYq0U0MdLzx1LKiM3UuGhn64+VZQwhVOSt?=
 =?us-ascii?Q?uzAehr6iWC8qUdBiM+bcYPzXLczIp4Nq8yKLHs91uATt20mEOo4AP4pWjVUD?=
 =?us-ascii?Q?/xGzjn5zb9VygwGLNGr9n3/dRw8dytmAVIptWXTgTnwYUf1E+v0kRNjx+XvC?=
 =?us-ascii?Q?QkvijmXXIghj0Shf+QmHuDOPM32t5aUwvSV/mNbD8fJYqhqS9gCblYRaNopx?=
 =?us-ascii?Q?TVbW9z/VjYIZNyr1VN2x5LWGy//PFjuwN5leTR1pGpbA+DIvCyK2szwHlHoU?=
 =?us-ascii?Q?vPtNi/yAph0V25Q754xx6HYnIXfIbPylbgJbdiKX0R5QlJ7lyxvQudiqLd1k?=
 =?us-ascii?Q?MsHQIq+n1PYpGRstVT2XVMhYfNqH2NKCr8ofcX6sVUSt7YvkFMRGhf6iig3+?=
 =?us-ascii?Q?+nBN4vd34B/N++9Mj+bPK4/aE5N+W1KmZb+8dt6vuphov2AZQpmSDaW54lXY?=
 =?us-ascii?Q?2y1nKzpOF3IdsqF3wiaCvGNOCXWSOWKzbJ+QWn3VYdxXTRmbn0bvBLMeIdUB?=
 =?us-ascii?Q?CauBX6XK26Bu6FoqQxaPhdy7aGvJs5HXnAbKZJLBu0r0181jarJp1eeR/2YQ?=
 =?us-ascii?Q?/cgx5xh6JgQzTwR+jZFXV3Qtxh2FMMpYBkv/Kr36nQicqcVwSZOddVfpaqnl?=
 =?us-ascii?Q?j3xOYylmDFhfvjLBtc6RwrUjZmIxgm9wSqdrMzQXo/r094ysqpvGy4Hc/fKQ?=
 =?us-ascii?Q?5cruO+shv8weJdqMYIQA67u8Jxe4MPQe+0TrlG2Wh/v7y7wS3x+pg4UEQwwl?=
 =?us-ascii?Q?BPqdKiYS0BP0cxSYezB8NYS1Gu25ydGYo5VKp5KSWXUUuFNOWrj3kSyLAQAX?=
 =?us-ascii?Q?jI6tmJAOOAowho0PRfYVevmD1eVZMgaOW1hK1jxAJvCjl9iGArh7vhwpmHNa?=
 =?us-ascii?Q?LJtaUmySk0raHphRojP9GaR4LHqHJTO3FXJnUuO9X1DMTJnem7pBNCEqRIGH?=
 =?us-ascii?Q?8v7+PYHxKi18nEKSrXLg2bFnzUB9gVyv8zASl5XU/PD/t1DGddq/ChYse+uW?=
 =?us-ascii?Q?4pKM9ntoDGnewlq8mniIIEEyi7Z33l7Wn0irAihnQBRYdRKDDqProhpLdM00?=
 =?us-ascii?Q?fQJuxBQ0lgf/ZHzK63c2Y10qx5hduPtyqOZ4igSgNwdrErGNPnzQNIQVVXXz?=
 =?us-ascii?Q?DZ4SPab50ayFT3uO+LV6UtjGBNmNxzAHmpSnHRWCaUe/pg9EY0GsbSSuo7vW?=
 =?us-ascii?Q?ZZgyn7EoCPtgwfw9I6PY/zJSAa/lZhfvWbUy5rfydD6qdCVzNi0oTK2f5Kv4?=
 =?us-ascii?Q?T2bJdzxIKBCWSGq86Tdk2oKVgHgYPB2mom2vvx+o1Lg/d1Q9ui+mooY4XXnU?=
 =?us-ascii?Q?4wLf11y0laeuUWKd7IN4iIeLnmTufc89KIA8Ga2gpITfbTu1y1sVX+w7xghV?=
 =?us-ascii?Q?eigRO+xYYMRi6ik=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:38:56.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8239fbe6-d2dd-471d-c924-08dd602457af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

The CXL drivers use kernel trace functions for logging endpoint and
Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
Upstream Switch Ports.

Introduce trace logging functions for both RAS correctable and
uncorrectable errors specific to CXL PCIe Ports. Use them to trace
FW-First Protocol errors.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/ras.c   | 37 +++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 9b1773273e23..7617c186891d 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -7,6 +7,30 @@
 #include <cxlmem.h>
 #include "trace.h"
 
+static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
+					      struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
+
+	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+}
+
+static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
+						struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	u32 fe;
+
+	if (hweight32(status) > 1)
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   ras_cap.cap_control));
+	else
+		fe = status;
+
+	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
+					       ras_cap.header_log);
+}
+
 static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
 				  struct cxl_ras_capability_regs ras_cap)
 {
@@ -49,12 +73,25 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
+	int port_type;
 
 	if (!pdev)
 		return;
 
 	guard(device)(&pdev->dev);
 
+	port_type = pci_pcie_type(pdev);
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
+	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    port_type == PCI_EXP_TYPE_UPSTREAM) {
+		if (data->severity == AER_CORRECTABLE)
+			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
+		else
+			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
+
+		return;
+	}
+
 	if (data->severity == AER_CORRECTABLE)
 		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
 	else
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e3f842dcdf1d..25ebfbc1616c 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,6 +48,34 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
+TRACE_EVENT(cxl_port_aer_uncorrectable_error,
+	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(dev, status, fe, hl),
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__string(host, dev_name(dev->parent))
+		__field(u32, status)
+		__field(u32, first_error)
+		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+	),
+	TP_fast_assign(
+		__assign_str(device);
+		__assign_str(host);
+		__entry->status = status;
+		__entry->first_error = fe;
+		/*
+		 * Embed the 512B headerlog data for user app retrieval and
+		 * parsing, but no need to print this in the trace buffer.
+		 */
+		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+	),
+	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
+		  __get_str(device), __get_str(host),
+		  show_uc_errs(__entry->status),
+		  show_uc_errs(__entry->first_error)
+	)
+);
+
 TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
 	TP_ARGS(cxlmd, status, fe, hl),
@@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
+TRACE_EVENT(cxl_port_aer_correctable_error,
+	TP_PROTO(struct device *dev, u32 status),
+	TP_ARGS(dev, status),
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__string(host, dev_name(dev->parent))
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(device);
+		__assign_str(host);
+		__entry->status = status;
+	),
+	TP_printk("device=%s host=%s status='%s'",
+		  __get_str(device), __get_str(host),
+		  show_ce_errs(__entry->status)
+	)
+);
+
 TRACE_EVENT(cxl_aer_correctable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
 	TP_ARGS(cxlmd, status),
-- 
2.17.1


