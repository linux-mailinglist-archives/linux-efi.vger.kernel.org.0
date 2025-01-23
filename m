Return-Path: <linux-efi+bounces-2722-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AECA1A02A
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17257A7398
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F420D4EE;
	Thu, 23 Jan 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="weBflZkW"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CD20C493;
	Thu, 23 Jan 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621886; cv=fail; b=IvybtHCgGib94Z8v3243D/FcN5P/mbXSKnlD4USBk8iRKg65SRIQfbiKepaKW6q0bxY/QHjghL3yUgJPzUSkT70S01GeqCqcvsRQIcTG1t08fzz9B+bMe5dqfY9lpDzf27WscZmDC7wumEHedsssfkdzZ1ThoAZ5peShhiHXkx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621886; c=relaxed/simple;
	bh=dpyyD7H+tDpsxviEFRpt8Cuy7h7MRuWBMCjs7WvKLho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8/ZrTmrVfnLZgiwCIt1qxTU1vAWbYHt210vYG3W0/KyBhWvpluM3eKJ+XEXljeny6kUkKZ8fNuvFilpzXeRZoKuCwQEfkkGT9FEhE4lcuDAWLJVq4iuDtK0wDoHM/peysmIfzuWG622k2w2fXp6vi5cshtbIl4dga6laTXoG+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=weBflZkW; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yykX8DtB6ZQOsPfweXs9a82tmWYAidksdvkcOiwgoNMv3qtHtoBhZadwrvI/LHFs9IeMgQH8ggmh9OeRCBldx+O6gJ3jF8j+4EKNTof1y8B1bVgxOj0b+uVrgb014235Spc0Vd+qFR0g5qiyJftVB+cxYQbNxVhUpxuBh5UzUDS2i13VPTBL0pDluqsITOtxX80xk/ds35PMqJI42cF24+UnN/nV5BS9kMDE04sSD7M1z/ZKCgHrNoMJCgt+qCFXFf3ear4l0ujdkTWkhJcvWWRSbIGawOz4F5PZl3nc4Vvb+bx3X/YH5dgdwFJYGI+jOh6Jw6E8uv7yTLQvwC0cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF/JMimVRWY4uHrdxO6dWiqIWgpb8KLSjEjMWyuvX94=;
 b=Y/IcpZC57mYdMzVvPOSlAnTZW9cGVdf16DyUqOw1WL9IsTaUEEchQ7c72IjJ4zEUnzuSAiVbAhCWY3xHnX3Uv5nsAntF8zF5Gp3ghkaqebiWsUXByfJ06tRSJLigzCXv6IgSKX0kLoOm1r+0xh3eXMMK6sLbxnIzn/7iH/vX3N/azCWMnj+tFklgXLF9r5scRCUCmcRi6m4sUCsysV75icehib3AgwM7JXAO4ExF8MmTV+BDu8oq2ob2sKKleWVyAsiwjjnIwfOowNAykXyZ8KBT/0bzc204ykFZ1B6UA5d6lqCws/aHB3cEqV0OUCWRkC5MvNpY1jovX0WjsHaSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF/JMimVRWY4uHrdxO6dWiqIWgpb8KLSjEjMWyuvX94=;
 b=weBflZkWCNsdm/bfeUUm1jXTcQN9ySWYzoqGns9vzrlf/9qZR/hF2kp/Zy0dR5QWn5g991KIgz/SGSejxd6RJznXnGLv8DgOJCM4C2PUhwKZTPZ/5VcXckElQD8GQH6CqP5up2N0wkgod3Nvzjx6Y95xKoE2DPI2IYrAgrlh8cU=
Received: from BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 08:44:40 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::49) by BLAP220CA0029.outlook.office365.com
 (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 08:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:44:40 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 02:44:39 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
Date: Thu, 23 Jan 2025 08:44:20 +0000
Message-ID: <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3c4bda-5b96-44b9-849f-08dd3b8a2d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eyv8FUDlweVdOPDLiYVC5IHkiecFGawy/1kPQYnfYLapQ+gBJPH5seTsnDIg?=
 =?us-ascii?Q?IIJmxhnJvK9c/fMIdbkVGV5WzbwDV9LbdvW4oRcW8Po2HDqzNJTT76Tr3Kom?=
 =?us-ascii?Q?Texh2ZG5Ub9ux7nE+dlF5c+IuDpIzkjyyOHTBLodCsk4v+7LGncp0vDZV3W6?=
 =?us-ascii?Q?6ai0I9RyZ8cDjZSDIhskRo233SYdgdM8S6jTTOu3H7ZdvS1pAYrRTbtYyu3x?=
 =?us-ascii?Q?qz8GUqDbh46pGgna/0Q4hUmBaVikS/mtA7CR63hlvRxsLc37T6hY5ZjewGj9?=
 =?us-ascii?Q?5KDL11RSeeTwdB5NZ5gnVkNjkhtIMDAkcyOIOidatMv6GKioyGS6SeHFteWv?=
 =?us-ascii?Q?IPN121k5sgjMBAiCWQbae7nQ9S7/Z4BEiNh0WGOb36fyfIlJA0i8XpZNvIQs?=
 =?us-ascii?Q?pN5ORMb0n/Dp0bmxn8f2kD1t61WsMVn3CS8EB99HDY4u4s4gLhyT9qWEmfSj?=
 =?us-ascii?Q?bU0EeSWsDS4uCQEaE1LMVE2P0W5odBufDejUU7tKGYoPmSFwbqe9XEpnrIA0?=
 =?us-ascii?Q?Nc/SYIg9CsJWHQDQRiswgE+6kOLG05ncdo/8FUxeTINIgFtSXlyCjfBroKsa?=
 =?us-ascii?Q?3BpLnUWbFwuYPdXeJNhtuhOa8IoeDq3pSnpkGG/e3oXCd3sk5DOGX9w7/ka4?=
 =?us-ascii?Q?sGK/hJM+326nbag0a2MOd8rpHIZuL4R+0Q/ccV+IAweaD5gcgRoZEdfojeoz?=
 =?us-ascii?Q?Ku8fKkDuf87zjOCmnzJNKPcGgcw/y9toZL2eA8YF0s8eeyGaqNmuj7FITfEj?=
 =?us-ascii?Q?xjnL2xVZN7VC/U3pGsuWH47yJzif05psLtT1i+YQFrGUgDJBv3phB1A1V1a4?=
 =?us-ascii?Q?KWXk2Sk4UdWfWFZCg5fdi5dSqFPEo7tPo/mMj7wJsHhTm7VQ/2/iv4WlDnvH?=
 =?us-ascii?Q?1Z8IQx0BSV6acXXCVnRIxtEtNoXoVF76hv0xJQm4KvGMZ70c0xSIXQyoMGSr?=
 =?us-ascii?Q?2ZbQLgL/X9BxvyKxwWJNmrmYuY4jEQdgb/Bk+YDHW1Y/rfZaoGwvEjRDEMDl?=
 =?us-ascii?Q?O9v0KhL9sTq3IU90iZQIziUInD/3B00WPUU7X0fdfqZrZbIuZEr18pWAQ6rP?=
 =?us-ascii?Q?pgNoMjlY+412iZ15+ox8MdH7AMd+T/bhrYyNr/EwH83fJwk0qVzlj+hYMLFY?=
 =?us-ascii?Q?DWI5qy/jCWJxUiu8+0POL1NkOp71zwawQ0r5yTX8x79WdNCglSdGtCKb+l4L?=
 =?us-ascii?Q?QBi2fcZY+s7FaLKjGst2OrUHz4JyB1Ug/Zln0Em/lzcskWNJQgDCfL09CuAz?=
 =?us-ascii?Q?VketwKID/8hct9Eurtp6sn19p/QlpFYNzjfx/le/0PBVMdoNVhyJknPN1jGy?=
 =?us-ascii?Q?WbWe6/PggEyMiO1wPWw/55xwfzfXJO069RNCN7NDIh0g2soJOYzTK1n7Ko90?=
 =?us-ascii?Q?rfM9E6bq6yxkA8IdzcG3SMj4dqoK7r7MFgCfsTtH/NAHwr+XeMZuUCSj91g5?=
 =?us-ascii?Q?0SQ3wVfTqkUs7nKLszcHuaxFqKg8gChmtN14k3VANbP09NoLZoPwzSLKxvLc?=
 =?us-ascii?Q?ZeLSnf2VEWSCjhY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:40.2387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3c4bda-5b96-44b9-849f-08dd3b8a2d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757

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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/acpi/apei/ghes.c | 49 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c   | 36 +++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h     |  5 ++++
 drivers/cxl/pci.c        | 46 ++++++++++++++++++++++++++++++++++++-
 include/cxl/event.h      | 15 ++++++++++++
 5 files changed, 150 insertions(+), 1 deletion(-)

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
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d58ab9d33c5..5840056bb9a3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,6 +650,42 @@ void read_cdat_data(struct cxl_port *port)
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, "CXL");
+
 static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 				 void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..e457616373ed 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -129,4 +129,9 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+struct cxl_ras_capability_regs;
+void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
+				  struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
+				    struct cxl_ras_capability_regs ras_cap);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..9d4b5f39b21a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1160,6 +1160,37 @@ static void cxl_cper_work_fn(struct work_struct *work)
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
+
+	if (!pdev)
+		return;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver != &cxl_pci_driver)
+		return;
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
@@ -1170,7 +1201,18 @@ static int __init cxl_pci_driver_init(void)
 
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
@@ -1178,7 +1220,9 @@ static int __init cxl_pci_driver_init(void)
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


