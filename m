Return-Path: <linux-efi+bounces-2835-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C028A46E3F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 23:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11D0188A8CF
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2426E17A;
	Wed, 26 Feb 2025 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5DaxHZ4D"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64626BDB9;
	Wed, 26 Feb 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607937; cv=fail; b=FKt5WI4bVPLDVFajS875Fo2JmuUv7Ayvw3OPvd/bmP6/IdtoAu1UZBntZzJMZmXXFdCdAO88EXeMWcmlEFcuFMigDi5/NCm9yPBbGHXUt6gCR/5Sdh4eR0CezS233dg7v2be4xokqvcoB2rnrmNTBOIPZsTKM03j3ur58ib+twc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607937; c=relaxed/simple;
	bh=VyQWRUmUINPfhPtCX67dNTJl2JiB4uxnUVsPljVwEik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuFeCM4qGN4R6T9kw9VFgeIZiFA91Y2z20NOiCAklObhQgnk7rFgMIG+nVOnQM078qEJI99WbqT7S24hTSJT+IzBjHgu8iR5BZOsw7snAyVl1vVprjemC+wbmeyqDnbFKRad9c7gJWYE0/SVdrfoAqa0TEn0L4rfYlwOxvrpz4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5DaxHZ4D; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzIZFbxI3HmbO13rZ8mR95X6VRjklqjnod3WYYLY0Iz8jrKOxD6l8/tM0BTeJJ3FdewgXNXYXBI+jETnnTjEEssJrzDy+kyhfOuAa0wRXYUsRf142NvRFFA0r+d9+DxZV9C2enmjXTMbrsdUcrjlICHM4OyussgN9UoIiS55F6TCZNedOEIZMPeneS0goFdahk6lfb09n/bPrIkOpuq+d8Ezq9tMI9x40wnfiybuFnKmEajM5GmsOv++usFBkJuOnJUWW3nXQn5HGlFmLQYHEpecQfxW3gOUffx9+4pnxr8Kra8QdXs2/Wvp/dmL4Axza5a0+UNz/v1Ue/7A1PH/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0ZoG52bMmX+/51qGaa7wcC1akpQgEWFO9wQy34s/Ks=;
 b=jbL7EKLPj64hCdiNC+WzvUDEjs8B9SEiPnpQo+TA5jAkH78h2GixykJZJedCh6r4/nYPiSNeAHeX95O4OUDHZuCo8aLrYX5k54HFWAL7vGj2xkIyAn6ikui2U++O8SU63mogtfTRnmbk6R2lmtsG1Rp88P7BpN8gDK0qwv+jeB0cgKHgr34pxW3Xx42OJ4RhkvGypxsg6/qf3cDjWPuFzJIMNxApZXyVqelHr0B5+gBS/1V89Pje+3cgIrfv85oPnddj4/VK9hnklFm/LudnT5wbp4w2XqEIc3yp5FcTu1BIJ9/B/DJEXfwibSOQ7wd86CnpJI6fhOQVUVZqrvHaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0ZoG52bMmX+/51qGaa7wcC1akpQgEWFO9wQy34s/Ks=;
 b=5DaxHZ4DbeWIccR/pf0BXbBUF6Rw43oKYWsI7qrNY8j94AMNHZAfU7YSjXKnYv0UCdT7r4RIW3eXWHizZKowR/sPi6aVlKlgewQ0Z4QDsoCj/HrxZMQjfEfi/Pt3/NM6/mFMsEeD8ECY8hsOSLKlyg2tpP9iSYi2T/3zB2MhBWU=
Received: from BL1PR13CA0349.namprd13.prod.outlook.com (2603:10b6:208:2c6::24)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 22:12:10 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::9c) by BL1PR13CA0349.outlook.office365.com
 (2603:10b6:208:2c6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 22:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 22:12:10 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 16:12:08 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v7 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Wed, 26 Feb 2025 22:11:57 +0000
Message-ID: <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb09642-9926-492c-cf46-08dd56b29d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HyRfTmA55MptVl35GbfZ2GCYA+kxRSewaPYzmD4/9obqHXLjJ7ac6+8jJnzG?=
 =?us-ascii?Q?sD2SvjgNBp5azMulYMd6Ul33ghJdspBi+Z/w55BEvuZRun+rF/I0Pjt370yq?=
 =?us-ascii?Q?M8R+Iir8nqViD7n9dDQInQSlNsX0ZkrTTnAGWJCDT3kGKeGjRPS/QD0SN4zO?=
 =?us-ascii?Q?bhUasKNDNTnOV1/RykrM6tBd6tvzfI4saUATqcKpjIxH5wJMuVW0HWyqLTsb?=
 =?us-ascii?Q?KLG3CsajkI4Flk6e/xfKWTEEb+k913Qj08OlY+LrQDa4oUwjvXiNPvLN9yEj?=
 =?us-ascii?Q?tvc1dTVfP8LvdZltfTudfPK/8tqo2z21FDyIjOQuER3nkR70PbxyeYmn1p+J?=
 =?us-ascii?Q?gVuLQ2uCa9IrM6bbHMeUfnCzGCe4T1emR36UTIdZUpmmIz9kIjyhNcKOmTFy?=
 =?us-ascii?Q?PQBcO++ZAkdiHTBYAwtOm//bmxUm+ooyCvQJahbu7ENIZcHJItDzRgJnbAfB?=
 =?us-ascii?Q?FK2H4/hA6fmWbHSGUU2gqeMmCWW079gCD1VE5beBzNyvpT/akBS5WFq8OKnL?=
 =?us-ascii?Q?bs5BxDFjN0wdqRd+G7tRqVzOe6g9+nnxaUnmTJr7Kiw5Xmgd/MrbTgYVYZSi?=
 =?us-ascii?Q?lB3QIFIJZmxIcvwxAoLHv9lR1BZ5D0MMfYWJeqEPQHQcwfpByMzgepy9WiQl?=
 =?us-ascii?Q?fWNFvcVmcgYZ/jKHg7NputDP6ERSfNjzdRoamomQO+vJl+xLK21tDGx9ETt2?=
 =?us-ascii?Q?0F2D9glq/rAUxEDl48a4EBN3zM+V9fAS9yQORt+Oys2ylxgCBF1xGD33A3Wf?=
 =?us-ascii?Q?tTJWJqY3SwZcgN4lgRU3TZfwpGXHGc8BnvtPbDe6KF5Sbuk1zgBQcPSjm37V?=
 =?us-ascii?Q?YHqSOTWuGNv0UrAjGZrGEf6cXjSlBaRP5YfIsCkvKu7xKzi4K75icS7k5uwR?=
 =?us-ascii?Q?mP28AOwAmZ7ipxp0xNYRq75kEbDaY3iel9rm6GgiDkfVeRiqUtB20MsLul5/?=
 =?us-ascii?Q?0RGxJ5Da9WI57ucfTQQkoNxZaQbwqhQzIQR0findna1Xq2BqfqkTBTsxRrpd?=
 =?us-ascii?Q?uWX1hqFrHHfh6evmE15eoc0REzvZLip3HUUzijE4jDX7gRyKeWRQAidkWsoS?=
 =?us-ascii?Q?Nh+sfYjmb2gfz2dgAG2UAFEhLMa4BL58LmC+AHPNksr8vD8wby5jMDuecwIl?=
 =?us-ascii?Q?/MWxHsd+nD/zTFeMR8c6aOP00XUK72UTyh/g2kLiijiDq4ZZSW3znJkX0NKK?=
 =?us-ascii?Q?HXu1tf7DJjrxY/agLf8Fk5QFjbL77oz/uWkPT7BSCDVOgf1uro5g9up8EsUH?=
 =?us-ascii?Q?6gkq+T6yUN1iTdrpzXsYoe6SJg3i0MABhPGpHKbypDC6OgcHB2r4RKeLTmOk?=
 =?us-ascii?Q?G5izaUoPEpOrSIuNMg+x685hXW1Rdu6FrljyIN4yUGFc/AiBbfweXQj54mfq?=
 =?us-ascii?Q?psO1WMDjGGTbcatxMHyYtA1PL5AxA8By6KY7l5PG8RQB3YCER2owMSooEEq3?=
 =?us-ascii?Q?rZ0qYUwDcbvedkb1CkNKd9yVHck0wwhiDuBP5aphUV9/wDvs6HkN0LlqNm6p?=
 =?us-ascii?Q?fIwHV6Fw06crV9o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 22:12:10.2510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb09642-9926-492c-cf46-08dd56b29d7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

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
---
 drivers/cxl/core/ras.c   | 37 +++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 8c596f035095..0234645a9eef 100644
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
@@ -49,11 +73,24 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
+	int port_type;
 
 	guard(device)(&pdev->dev);
 	if (!pdev)
 		return;
 
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
index e3f842dcdf1d..220a667ff377 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,6 +48,34 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
+TRACE_EVENT(cxl_port_aer_uncorrectable_error,
+	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(dev, status, fe, hl),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__string(parent, dev_name(dev->parent))
+		__field(u32, status)
+		__field(u32, first_error)
+		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(parent);
+		__entry->status = status;
+		__entry->first_error = fe;
+		/*
+		 * Embed the 512B headerlog data for user app retrieval and
+		 * parsing, but no need to print this in the trace buffer.
+		 */
+		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+	),
+	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
+		  __get_str(devname), __get_str(parent),
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
+		__string(devname, dev_name(dev))
+		__string(parent, dev_name(dev->parent))
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(parent);
+		__entry->status = status;
+	),
+	TP_printk("device=%s host=%s status='%s'",
+		  __get_str(devname), __get_str(parent),
+		  show_ce_errs(__entry->status)
+	)
+);
+
 TRACE_EVENT(cxl_aer_correctable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
 	TP_ARGS(cxlmd, status),
-- 
2.17.1


