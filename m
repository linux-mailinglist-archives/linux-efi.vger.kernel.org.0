Return-Path: <linux-efi+bounces-2622-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C20A10623
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 13:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4033A874C
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0B284A44;
	Tue, 14 Jan 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Amhvaf7"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1196234CF4;
	Tue, 14 Jan 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856290; cv=fail; b=aTQOxx+jDHfguf/SbkOyqhD+lWC7JpA2w6yi74l2veRSnssgiHh4A6UwxRShA+6DhnJs1l3IlQRIlh5Dd9++uPysUqFLfJy5A6VY2w++n+M3CVTL8RAo5Qzg8/XJ3FblJk9zFzHnsxy9Jf6st3+v9AmB69LRU2CkuETwxdwA6cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856290; c=relaxed/simple;
	bh=r66wy21DoXIuhM6LGPSr5PqMI/ljEX07YF/xv3eAHqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwSEk6gOGJNVXe8wOH1Km01IEgx8BpVa2zN8VNEGuYMtiL+LMRORArkjQ+UCZfvbAgVULT/9cml2n+3sGwkUeO6iAl2RmU2x2HQKvgB+q07QcyaUJpwDf1z83/pVkjrMZa4jggaIIZ7tNdTeHYPVRE9Ig+okG1E5ORUG7oeQ+kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Amhvaf7; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4XLcT3AN0FbBK1/go7BUH7OqI6J45+Pol8H/ZsuxqfMiZZLIvxtU4II27nCoEvDbeYCCZk0oD+AnAPKYBZuMcb9dw5vW3nQL6wD68TL/0ntIaqBeg34jZQyhW+GaWVXw90OI2Cd11kPTbmIr3JFEEIrAL30qXFE4RKXL9Dajr12C822Ec7TmCSVoUdq5PgUTbyIHwnTnCyPgxnLEbjX3jGNsOEt/1C6InIwZUg9nl/B33Qg75CXc3DZAVGRDiR+1lAKoizdnljzavL1568hrnTzKvsYysgkVQhser7wuUvSxOTa3/rDN+lCeAOl5lGFH9DWfTa3SpekzK5GWWbBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7vI1wOEQKQvvfs9jjIXFTI4ABlm7pJ76X/dJJH/kzQ=;
 b=LOSC07QBodGGCO+7IEkLN6EpSRzh4+Gp8WXntVu4zLrf4CpaPaOkCINQDjgoehikScnG0boZnSO5EwQAC+eADGTeOFQj1nX/tuHec3hlGdqAgeK1Al/3j+XIh51LpBy5Ddwwk9lnNe3HxbUrIsy08tVKSpTt94osOLW+halwYS90LADD5lX2hmt3nAlF0afKo3iNv92wCyuC/N425ISVuQWhonqelHA4zMrKVCnGV1w5CcDL2pzioCOOD6c8qPdnrt0GLpczNP7jNodEgwj0XZcMtYwrPHSp2LM//dYJuHE75FJhKAE1qj9CuMHT61ZYFCIEhBr/h+Eoo7ZJXMf5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7vI1wOEQKQvvfs9jjIXFTI4ABlm7pJ76X/dJJH/kzQ=;
 b=2Amhvaf7J0rKrdNj/oDfKbwKG/+hk6jMuXaCfXTxDSU4Uzn4+HqEAb2R6XfbNf2YS+8oZnZWi7akcSNIaT/YQEreUBeXSynAxndhRx/5sNLxk6aRCAXJeWLqFScFiw9rjkurRWUeLlhfBywmWK/684REVf70l2c8C5odca1s+2s=
Received: from SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::24)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 12:04:44 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::85) by SA1P222CA0115.outlook.office365.com
 (2603:10b6:806:3c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 12:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 12:04:44 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 06:04:42 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
Date: Tue, 14 Jan 2025 12:04:27 +0000
Message-ID: <20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: f889279a-7a1e-4b9b-548c-08dd3493a26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPPVrpv4YgDip7OtzH1C+MsZUTarDJp8buCqRHk54W6VXIJCpuE5lCZRHOa/?=
 =?us-ascii?Q?QOnUSltfYVdHliffs155abpkJta3GVcjhbOAT5V54n7tiEIKRQfgu5qVCiuH?=
 =?us-ascii?Q?4EWANbsgwi68gJ1fijnHcvzjxRDPDgRRxA2XY7wovdJYL8EYu4daIxKffM8F?=
 =?us-ascii?Q?K2rhLQI7pWoT57fwW19R37b2ZLgjugnJTi67EmTHftUy0lvayxtrpZ8XFnr9?=
 =?us-ascii?Q?2yn8lg/MI+915/drzEqUEaYBmhI1OzlWz2cBLifTKm7UYTC3EFK7kwkQrai+?=
 =?us-ascii?Q?leASAu21XrXC1i088yKBWB1bo0fQaafFBttIzkyjt20Dvt10e0Fz7ZDczRcy?=
 =?us-ascii?Q?NoxDASk6mYDbGaaDR09kl0lL7kpvf0wZ/t5b9lgaPyZx+DXiH/F56Z1XrV2H?=
 =?us-ascii?Q?whDcNdobhJ6v0j7I/OfYR79B9h8JLHcWjiN1zp5uifQ3IhzPPtgqVdZUHbAq?=
 =?us-ascii?Q?R7Kh7ZIMh+7XmHf9mMrz9uP+qofCJt5VXE3E1Xg5ipXFi3zbfNKC5RFsDasA?=
 =?us-ascii?Q?511W+C0XduUPh/2t6/qUUXfxG2FzShiYFtCeAodLtI3zScyKnz95B7LpMSwY?=
 =?us-ascii?Q?3CajgNxXqnlgHFK6a6VpYBYArecS3ttiysLR/XV5sqLVPI7YEsRUMjdvKVX3?=
 =?us-ascii?Q?At4k/MN81TMlBuSTj2apkYQ66qq1rODoXVCmg76exgLuNya1R9zMZIVVbdna?=
 =?us-ascii?Q?qpHI3rJa+NyqAk3K37S0b01nTUchpJVtb/lcu4nzY8gKM8B9Z+TCJrWBUEJF?=
 =?us-ascii?Q?GTdgWAy4OOmdrGDH5XAkT6W2UdDosQDpUSpgqOBqDR1CKD8h+8D2E0SsE0Qu?=
 =?us-ascii?Q?loQ0eS44OUUyMy0rLMLCLkSjJIwVGvgdhHM2XtW3lWSWFOuzZcxwfDtqdrpO?=
 =?us-ascii?Q?T3QweJVmEJ6NtMex2iCuHO3mlKXLTYHo39j6/qo9xLniZjCADXaGxb14ugbU?=
 =?us-ascii?Q?0UYGd+yzNEYdxwGA+n4H6KHsbeap1MG8TrIPGtYA+NbXAmCzgJDwL6LhFu/S?=
 =?us-ascii?Q?j5SjZfOl5xWUfvMKPXQ8eHFFWvDNc30rircbaUSVbp3Fet+gGdxeDYMqM5fg?=
 =?us-ascii?Q?4UDhU/lZ7D/armxykga5vAg0Pju8vP9Rr2jcvWo9ZUt6ev8+oT9ht56X8fCo?=
 =?us-ascii?Q?lQVg1LfS//9lhEE1H9CmJZwbH2J1W92wYoFRxJmGAV5a72HvlHzXKErEACY+?=
 =?us-ascii?Q?nnPYZWuSRf8GUJfKiUAktxOEhMQBYuYKlZy3OkrR6GlZdNzvYO4xkpjv5QAI?=
 =?us-ascii?Q?bd7lUVFLBf4U/knchFBoMGbWTpE6Mq6niPAyUwakrmr/6zqbBsYK15dCZc5L?=
 =?us-ascii?Q?Ju8zohsscTB3/MesnYK1VPWWHcgeLRHKF/7rtCNQvITPFPZ4SX1xz8yRupjb?=
 =?us-ascii?Q?iI9Lg2Ok7GsZcakgb/Ona+QXaXptGwMfD7xnbEwrAywmTyOeHfqJ54PrfkqK?=
 =?us-ascii?Q?hYb/sGa0eNo6tEtJBnMtfLkrTZJN5z+yWYiJT302rLqhbjK63HbNjbGojLtP?=
 =?us-ascii?Q?7YR8LTAooREefZI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:04:44.5411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f889279a-7a1e-4b9b-548c-08dd3493a26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490

When PCIe AER is in FW-First, OS should process CXL Protocol errors from
CPER records. Introduce support for handling and logging CXL Protocol
errors.

The defined trace events cxl_aer_uncorrectable_error and
cxl_aer_correctable_error trace native CXL AER endpoint errors, while
cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
trace native CXL AER port errors. Reuse both sets to trace FW-First
protocol errors.

Since the CXL code is required to be called from process context and
GHES is in interrupt context, use workqueues for processing.

Similar to CXL CPER event handling, use kfifo to handle errors as it
simplifies queue processing by providing lock free fifo operations.

Add the ability for the CXL sub-system to register a workqueue to
process CXL CPER protocol errors.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c | 49 +++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c   | 62 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h     |  9 ++++++
 drivers/cxl/pci.c        | 59 +++++++++++++++++++++++++++++++++++++-
 include/cxl/event.h      | 15 ++++++++++
 5 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 4ab3c8ae1360..8dc693e9b2d0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -676,6 +676,15 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
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
@@ -702,6 +711,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
@@ -723,9 +737,44 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c10eab82eff..4ec060032ae8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,6 +650,68 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
+void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, "CXL");
+
+void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
+				    struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds;
+	u32 fe;
+
+	if (hweight32(status) > 1)
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   ras_cap.cap_control));
+	else
+		fe = status;
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+					  ras_cap.header_log);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, "CXL");
+
+void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
+				       struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
+
+	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_port_prot_err, "CXL");
+
+void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
+					 struct cxl_ras_capability_regs ras_cap)
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_port_prot_err, "CXL");
+
 static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..23f2b1c9bd13 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -129,4 +129,13 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+struct cxl_ras_capability_regs;
+void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
+				  struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
+				    struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
+				       struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
+					 struct cxl_ras_capability_regs ras_cap);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..766447c169c8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1160,6 +1160,50 @@ static void cxl_cper_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
 
+static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
+{
+	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
+				       data->prot_err.agent_addr.function);
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
+					    data->prot_err.agent_addr.bus,
+					    devfn);
+	int port_type;
+
+	if (!pdev)
+		return;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver != &cxl_pci_driver)
+		return;
+
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
 static int __init cxl_pci_driver_init(void)
 {
 	int rc;
@@ -1170,7 +1214,18 @@ static int __init cxl_pci_driver_init(void)
 
 	rc = cxl_cper_register_work(&cxl_cper_work);
 	if (rc)
-		pci_unregister_driver(&cxl_pci_driver);
+		goto err_unreg;
+
+	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	if (rc)
+		goto err_unregister_work;
+
+	return 0;
+
+err_unregister_work:
+	cxl_cper_unregister_work(&cxl_cper_work);
+err_unreg:
+	pci_unregister_driver(&cxl_pci_driver);
 
 	return rc;
 }
@@ -1178,7 +1233,9 @@ static int __init cxl_pci_driver_init(void)
 static void __exit cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ee1c3dec62fa..359a8f44a2e0 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -242,6 +242,9 @@ struct cxl_cper_prot_err_work_data {
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
+int cxl_cper_register_prot_err_work(struct work_struct *work);
+int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_work(struct work_struct *work)
 {
@@ -256,6 +259,18 @@ static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
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
-- 
2.17.1


