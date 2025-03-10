Return-Path: <linux-efi+bounces-2958-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A0A5A877
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 23:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B803AEF8D
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5B1F4CBB;
	Mon, 10 Mar 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BtszYOUG"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F71F09AC;
	Mon, 10 Mar 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646343; cv=fail; b=giw+54S9tJsEXfQ2jW+bf89nPH4ZHBuoNERrtepqErACtP/i0KJLK73gzUo4mIgUFr9Utm6QHX3O8sse3dEoh806wQjtmPjHVxpe52fnaPzRvWgWhNEVqdoC5Si8VDp7Mwvv3xyo+nS8qsf8lqKrRUuspR/BYVbuqj4pdcMJJVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646343; c=relaxed/simple;
	bh=laxmvwzGtfI08NuDgZ/7o0w7YakggaI4ihJlpqaHUh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXlOWiDFD/ILErHeeeS0tVqn01Wwsh5/X8kJGztZNedkZWayICKifsrLMTrk5FO3F1j1vXfnUisrXVLfh/FIkyOnULCW8Gjc9zdkUUQjKC+xTlOGPwpt9u2jAmsXXAITZX82dOX6nzy/gGgXFTp1GxxTf0hH92p/wTZXB+X7uns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BtszYOUG; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynLz+c6SSDReimP1E+ZSy2DHO7nmPsJ45tk0WxPF7fdk6r3PXZl/AAYg4SA2nv3M2q2PP4UYiPsQjS/YIPoET6/4LR7k3R9vehn/tkZUzjkoPZPmXk+jXRi0UueVSe6VlQN5+4alxBZrL2yULSgm5K3jy6AXBY+aNHfodClK6kJToIyzIN1KRKsZlxflA8NkQVU7dvPdsMfaB5aA/9xxJxvV2oHL1lo+nH3Apxwe+xdjkmncxCHwubS4TOpF/+WLbDEoZUMtBwAbTtLFa2mx98/7pwth1uRzY31P1MJ1+QYMzs6gkyS/mQGPjQTSxnlulzcJWqbvgRmBj6XowaSf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lOk3FAoa1+mdZM0McfWdxGked0I1Dot6ZLuX7dgXFE=;
 b=cFPE1judr6ZmbnajkqQyrZl0EnxFDM7lO/67RASJwaLEESx6Az3J4V1LrDOjCIQP6LkILlUnD6KBdNaOKHFFwpj/H+svFgha8QPAxWQ+1eS2BmAG5HwiuBWwv/df3GbkAYLSIxIhrpL4URt4HJq1AJwdDCYeVACiqs0TfYe/s9w/LCGgEWKXjH2Cg63nayol8kpY8HhjPuoK75HGeBhfW7URDfI1aJu8l0sMKHVOqps4bNWwx5NjNsBzeA7ohAenGuDi8RLscE6ypdUoWAETYMU+z5gbxibRu7HWoS+4Q7oil/9QYN08/uLsdR7Js3WUQIT3989ToZzfyw9Ow7fwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lOk3FAoa1+mdZM0McfWdxGked0I1Dot6ZLuX7dgXFE=;
 b=BtszYOUGTZN8PcwM3thf/zvknwAu8Y3kF++nvz7xtmox27tT9ssf86fmG1FOjwD9+KfKJo/V/zdmmsrAFNkjiJgUn2t7XJyJQ8aDve/znS8ZLqCIfFVARBHENtk7Oq8vFnDdCNnYGu6GXfcZbNKOd47TfnXNMn58gu7Ry0BHqHc=
Received: from SJ0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:a03:33e::24)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 22:38:55 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::b8) by SJ0PR03CA0049.outlook.office365.com
 (2603:10b6:a03:33e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 22:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:38:55 +0000
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
Subject: [PATCH v8 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
Date: Mon, 10 Mar 2025 22:38:38 +0000
Message-ID: <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0aab9e-08a9-4b36-a6a9-08dd6024574b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BFvqvoYGrqWIRaaqRJs3QwY6hhZ2kCrlU/vUrQExaY3G/abb9IvqOiNgsW02?=
 =?us-ascii?Q?xeXlvTElxA6YoqI37jA3wIqGDVv3opjcWjIGXJLvE/2gj4sq15BnAEuSJ/61?=
 =?us-ascii?Q?Q/efk7U96cxsro06JcxJCWVjcreenk/7f0SLCTwvWi3jqU7P4Gt22DLnJu8u?=
 =?us-ascii?Q?kB59DitFBd73Wg3lB6Tp1zFfP0royTr1fLJkb1gfDNNbZusWaPslVVV2Asqo?=
 =?us-ascii?Q?qGL0nBqTw6i5l/igawZz5EnGxj83L0qxrbg8yD9c30awpETSDB7zkR4A57lI?=
 =?us-ascii?Q?rB/v/rD/rAKrprYPRes5ESzBPIZBQbIyu34RzIqr5o7mT3Pkm8/TfNE8bBke?=
 =?us-ascii?Q?8s+XWszSwLuEUka61vXsxWIMCeMaziAbtf6UeV+Xj8QvMu7+MqyoQzcI5bjV?=
 =?us-ascii?Q?i7FcD0i0w8XiZIxiI8VaioRGgq8kT96jgnE6BOxSjtT4F6T2WXa+ixjUifdc?=
 =?us-ascii?Q?CVtB1DlSCJgN7kDi+A67v0UVVbXj+GEd0mqOiHX61WFEFJkGjzkZcgRmGrai?=
 =?us-ascii?Q?BEaulMi9QlvcrPAn90UxdW7cU/viqmiekgRtfHGXcSKLw6rYUQG8zUY3MPDF?=
 =?us-ascii?Q?zZOYtsq9iNTyZxmoAQiSuv6x5vdETUOOCVxvdaUytze6TMXJqyV6BjVKtidT?=
 =?us-ascii?Q?0UuyXd510M/t4Wq5NIYE+bgOxHXxGthyN8NBOgxjwbHTA9lNBp50yP8FGeO2?=
 =?us-ascii?Q?w4LbK3/v5EKv61GvQFgImml9n3ZOuBfnrKLQVF3UFrVYCc6GqRBUem9ZJlgR?=
 =?us-ascii?Q?nZayarVC2Vw9gFyFffrXusZNHlIspUKsGU+WXYQu4S8ra4hph/7r338BZeRv?=
 =?us-ascii?Q?CxJ1sL1mpGJoLhqtF4/dvwZ/Rne7tLLm2qAyTboZrHdOmgha53Wsmaw5qKul?=
 =?us-ascii?Q?1yD4TeB01UCGYc2d+owmZYTRKvwA3h3/WEcbmSZUVcBCWpPL3I/jP7KCGVfJ?=
 =?us-ascii?Q?eRxDhAj1AlL9zvXw4dtwWsUAIr+z19w9Iju73FQG53hBfMPgNIhJthIU/Khq?=
 =?us-ascii?Q?uD9GvsSt+5ji5/XYE1nivY1Z/yINQEeGZGRRFzN1bSLOPIL33seVFA/OKMb9?=
 =?us-ascii?Q?om91gW4CA9cFlxcE9MRfWbpNX6N58kMA2PAYkfoqXACJrJrdRBWY70V7krsn?=
 =?us-ascii?Q?FY9rghdFjPaPN9UmWP8qSc76MmD0sdxk0Jotsnw1tmfLSBRANYcgXBUI2n98?=
 =?us-ascii?Q?jqCUjdB7SwmLm4adubAeAfC4xZOmSifw+aSJKkAdcA+TGFp35fW+krM8rO63?=
 =?us-ascii?Q?pP8Bz5v7JzVkZxGKjRoCS0CP/bPqMnMQLCRLSdYyI64grNdIpihowQDQjWL8?=
 =?us-ascii?Q?HFNXxMB3WwhI4Mmk1+j7DWELQ8oiQ24Gkk0LQ8isXEjb3ncsfVT0wPQ2SM6L?=
 =?us-ascii?Q?z+iE74q3pncYJdw4/Qci9egcLzdGrqCJ194b/7TI/t5eVJhFWVuMaFy65Spc?=
 =?us-ascii?Q?Xg9S2ZjLgVWKD/iBVUcbMx7+ukVw/MbAf7PC8YUo1+8IMZrkJfCl8MYWgGn9?=
 =?us-ascii?Q?oK1Y0tm3q3EwNpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:38:55.4580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0aab9e-08a9-4b36-a6a9-08dd6024574b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

When PCIe AER is in FW-First, OS should process CXL Protocol errors from
CPER records. Introduce support for handling and logging CXL Protocol
errors.

The defined trace events cxl_aer_uncorrectable_error and
cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
to trace FW-First Protocol errors.

Since the CXL code is required to be called from process context and
GHES is in interrupt context, use workqueues for processing.

Similar to CXL CPER event handling, use kfifo to handle errors as it
simplifies queue processing by providing lock free fifo operations.

Add the ability for the CXL sub-system to register a workqueue to
process CXL CPER protocol errors.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c  | 49 ++++++++++++++++++++++
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/port.c   |  7 ++++
 drivers/cxl/core/ras.c    | 86 +++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h       | 15 +++++++
 tools/testing/cxl/Kbuild  |  1 +
 7 files changed, 162 insertions(+)
 create mode 100644 drivers/cxl/core/ras.c

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 4d725d988c43..289e365f84b2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -674,6 +674,15 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+/* Room for 8 entries */
+#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
+static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
+		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
+
+/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
+static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
+struct work_struct *cxl_cper_prot_err_work;
+
 static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 				   int severity)
 {
@@ -700,6 +709,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
 		pr_warn(FW_WARN "CXL CPER no device serial number\n");
 
+	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+
+	if (!cxl_cper_prot_err_work)
+		return;
+
 	switch (prot_err->agent_type) {
 	case RCD:
 	case DEVICE:
@@ -721,9 +735,44 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 				   prot_err->agent_type);
 		return;
 	}
+
+	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_prot_err_work);
 #endif
 }
 
+int cxl_cper_register_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+
+int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work != work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index e1d591e52d4b..139b349b3a52 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,6 +15,7 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-y += acpi.o
+cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3d3b00835446..1803aedb25ca 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -119,6 +119,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
 
+int cxl_ras_init(void);
+void cxl_ras_exit(void);
+
 #ifdef CONFIG_CXL_FEATURES
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6a44b6dad3c7..0fd6646c1a2e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2348,8 +2348,14 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_region;
 
+	rc = cxl_ras_init();
+	if (rc)
+		goto err_ras;
+
 	return 0;
 
+err_ras:
+	cxl_region_exit();
 err_region:
 	bus_unregister(&cxl_bus_type);
 err_bus:
@@ -2361,6 +2367,7 @@ static __init int cxl_core_init(void)
 
 static void cxl_core_exit(void)
 {
+	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
 	destroy_workqueue(cxl_bus_wq);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
new file mode 100644
index 000000000000..9b1773273e23
--- /dev/null
+++ b/drivers/cxl/core/ras.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <cxl/event.h>
+#include <cxlmem.h>
+#include "trace.h"
+
+static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
+				  struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
+	struct cxl_dev_state *cxlds;
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+}
+
+static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
+				    struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds;
+	u32 fe;
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	if (hweight32(status) > 1)
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   ras_cap.cap_control));
+	else
+		fe = status;
+
+	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+					  ras_cap.header_log);
+}
+
+static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
+{
+	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
+				       data->prot_err.agent_addr.function);
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
+					    data->prot_err.agent_addr.bus,
+					    devfn);
+
+	if (!pdev)
+		return;
+
+	guard(device)(&pdev->dev);
+
+	if (data->severity == AER_CORRECTABLE)
+		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
+	else
+		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
+}
+
+static void cxl_cper_prot_err_work_fn(struct work_struct *work)
+{
+	struct cxl_cper_prot_err_work_data wd;
+
+	while (cxl_cper_prot_err_kfifo_get(&wd))
+		cxl_cper_handle_prot_err(&wd);
+}
+static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	int rc;
+
+	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+
+	return rc;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
+}
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 8381a07052d0..f9ae1796da85 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -254,6 +254,9 @@ struct cxl_cper_prot_err_work_data {
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
+int cxl_cper_register_prot_err_work(struct work_struct *work);
+int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_work(struct work_struct *work)
 {
@@ -268,6 +271,18 @@ static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 {
 	return 0;
 }
+static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
+{
+	return 0;
+}
+static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+{
+	return 0;
+}
+static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+{
+	return 0;
+}
 #endif
 
 #endif /* _LINUX_CXL_EVENT_H */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index ef10a896a384..4efcc0606bd6 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -62,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-y += $(CXL_CORE_SRC)/acpi.o
+cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
-- 
2.17.1


