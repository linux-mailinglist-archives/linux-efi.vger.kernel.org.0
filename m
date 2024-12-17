Return-Path: <linux-efi+bounces-2387-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F39F40B2
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 03:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88871188F234
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 02:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154614B092;
	Tue, 17 Dec 2024 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1zSrk5B"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4614A0A4;
	Tue, 17 Dec 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402180; cv=fail; b=WEg6PT80AkYjb7Jnpx2aintT/kpannA5UG9r2CMshoTQXoxTnfdxiqYI1RSlbVk/0hwJuF9+xAnNJDrE0ViP9JCCXOyXThFWTNkfFNenvcBPl56zLn4jFG8CAsvJc+zYHBhJqmL0TIZuWp0HrJOGpVncBMQ///LZuVUeLqT42jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402180; c=relaxed/simple;
	bh=bWeYYyYsgcTfJqTz3qE91HmbHlQaiTcOVl+/r4aWC/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z55CPbXFFit9jeksgdu2daQN7D/gcI5QE9Ry+1PfiwWAOkQpPRAvCZf+l8RsP/H7ELtpAv3sV6JFSKFFMuJ9JZwsXOi/u1A3/k76qVpmVQCHSstV1T22B7W/3N36MWQxUWEW9hxI+rxr/HpszF7FaJANOLRQVwB4s68aDZgl0hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1zSrk5B; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLo9iOzuxPiwAeGkfNWq5n2Is2lr5EvnWTLuMQuE8Qhr7BCVAa+FYEZKxmVelMIv2kqNxGteUujuJwoZZGyG78pqo0gwoVGDH+4V7EpGJeZ1KK25AJw2sOnXllSLg4+cGep3EJn/oM6OEf9fqIaAH211y5GUjyLOH+6DGCI3MVPpXK/SwGGfPwWdy/Qn/7RyESIZec9KuviN015HK6u/858Ie0R9jRy/WCHcsfQsZjZVHRtpUlqtBZj44uJ4/o9GpzpcZKrFJoZJF+XqR7lyCcdDZL+7JX5A8vPNv6xSMg+ynLvyJxgzwqQd8pXR/+yCNGEAnyWMxm7VbGpQoEI2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYmYVG+YAibn3eCiGUB8j1CTo8ulNxa7DWNAZmG7l9o=;
 b=xAMa4le31BOtqaZ80/ETQ7LsxscPa055cNxGECsu8fezN7bqflKSZ9+C0KmkZhTbQFnYLWsnrt6ECvHLoXBbZhlIuRqQsOcANcFtpP1FOR/1LcBsTHO+SNSvkBTgkjbHIdgjVYbLEzmjH7tzq7g8IzoO0xe7BBvalwYqvjpovXXG+MxRVxNR/s6fupuckWhu2w2NFtRsJG0bo0vVIGQ0m6QCdljFxeKmAsVJzgYokfQrM2fkgQlRJZX2UX5Nk3xF7wMnvV+alX4TtsJ1vvQl5iIzyBfImxKE6B2H1kkKPjWhVmRsflmKKzgO2d+QHMNR4OgOpVWcw1TLyPlDbhKEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYmYVG+YAibn3eCiGUB8j1CTo8ulNxa7DWNAZmG7l9o=;
 b=L1zSrk5BVc/wnwjf5DuF47dNOzS6+2irG5jSTKCOX6w/NWFJcPTCPkAdI0qUTuKZvhkFdBf8TdaZjNDQmyeef1s6e8ecYZS7sktMNddFYaCcjPF5VDr2IiZDuQ+baQFPc8TvWuBDjUAOQfXgccfwylNQNcYY956G+8uzGAv9Icw=
Received: from MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Tue, 17 Dec
 2024 02:22:54 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::56) by MW4PR03CA0161.outlook.office365.com
 (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Tue,
 17 Dec 2024 02:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 17 Dec 2024 02:22:54 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 20:22:28 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
Date: Tue, 17 Dec 2024 02:20:32 +0000
Message-ID: <20241217022032.87298-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cac499b-ecca-4c98-ba95-08dd1e41b6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fh5Z29dWOJbWj8hf2OJqWqdLmBgZljf4kqBBYEWkYpfL2Ue9pEos6tu4x6wG?=
 =?us-ascii?Q?iPdKn0JAzTq62j6DIoHnCQFotUOOEYNAg5cciobQV6dlD7a4C7Tr8hvDdVOE?=
 =?us-ascii?Q?GRgzpujFQRx4Xeqgl++uvPNd3V21FcP+rt1GDZunnGocoGmcoXBCc7AP1kXY?=
 =?us-ascii?Q?8LFIYSJwNOxMKxCcIzKjW2E9E6b0WCnDFKMnLGCdvzu922kN4Pcd28QuDaHv?=
 =?us-ascii?Q?0OJ5sT5xzoh1IGJXdGNTFzFLDwAL5cxd0pxgxh+w1rAaPDPKcyysP9MYOLGA?=
 =?us-ascii?Q?gGOQFDoZ6d0vUntt53geaMCK4vh8EvZSXt+otSA5udARscY95Sz66QKrZErK?=
 =?us-ascii?Q?c3TPEx8jar5dO30Z3qwokoQwCE16yg23AhYDg20ENkSFT1kTNOvqGN+dMnRQ?=
 =?us-ascii?Q?7YtsF1U1F68v/aKFp4sVxgOKVZVSJjgxlI9/PrrD+mEJ34FSIB8Ph9aNCtjl?=
 =?us-ascii?Q?h2I13CVhONqNifqazAQii+xlMLzgKOZeZLZ/hfb+EmAwi141ruaJA5qnWaa1?=
 =?us-ascii?Q?DSIvXkR1qBmreeXTCPhbF1eY3TiUDgOO5SqHQddBSGZpOwoFitKekGg/YBub?=
 =?us-ascii?Q?ZyzmYXO83DZduHeWcp0+ktdSqE8KwLnSb+Io2D1TtfheszehuGWIuUFnqEup?=
 =?us-ascii?Q?z0U1ZrYSMKjokmYVs6LeRCBULlLNZq59kg4IhBK0mJFKhicoCoxuT+3eHrKl?=
 =?us-ascii?Q?dyEX+4+e5qKKakBg8Xy2nvMDzeAy8zIgj+8wlQfKZy6OpaRitTk5zM3sgrgf?=
 =?us-ascii?Q?jBoRH0AZGSSn7fAWqJm0l4pNUG4Vest2IFy0xWTc20DJYf8xgIlLLxaAt1q8?=
 =?us-ascii?Q?/VFaMVNWGWRJVBNT2tRPb1lgvGEzPHWVxhkKEmRCBh3peZugEzjaWAl4vbJb?=
 =?us-ascii?Q?udnwSWF1tVUmxS+gVMIxGU58+OqpNTeJLme+aSepyh56SUUR3PaoLUCy5FND?=
 =?us-ascii?Q?J1iF2XzDpwRyGAfPpfTiDK/asxKnxJnbL5Wn/UHygm8DupXpXUGJ8MMKRkRa?=
 =?us-ascii?Q?Cm6nkDVK58UWoOMP0LzhwCIGQ/2dz3iOyH4qy5Kp3gjV5S9WD1bNZeDK6Xcx?=
 =?us-ascii?Q?7gBRl7xt1pn/KJW54dlQCGqz9ZKWfIReAQVkR/V+iRUW3Ixb0n0Ct7Ym+AMt?=
 =?us-ascii?Q?tI6CXXzl3ETtd1ps+ShI+7PNk9qbjNIDumF5kIw5NDaBfXfaArbYqisvbn3C?=
 =?us-ascii?Q?rlrMo1jK0UbL76nKHfUxmNpAaHT4wpF+IKmacXOTHeHSqDNEbN7LPxE6OkFa?=
 =?us-ascii?Q?ao0KsX0wnVBZvCPKFkO1L0skhrnjsdAv/XDt4Oq29nZs63H1ijZboIrFa6bB?=
 =?us-ascii?Q?V3ghX1IRdYms3oYOwOjYMqIgq6+L/vEYHIbToBHGtTDlQvC3M0qBFBVE2jEF?=
 =?us-ascii?Q?VvkbR99AFrCII7/PKCznNq4oQTXcNets70GcLkBGpRVeELkD7vEpNA1m+rW8?=
 =?us-ascii?Q?UQNQzAVFHMOJXUBsSv8MZBRUwTHupJVGI32Pzwm2aAj6O+rX8H2lELXYUEmb?=
 =?us-ascii?Q?PCdUbVnF1zo7c7o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 02:22:54.6090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac499b-ecca-4c98-ba95-08dd1e41b6f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

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
 drivers/cxl/pci.c        | 60 +++++++++++++++++++++++++++++++++++++-
 include/cxl/event.h      | 15 ++++++++++
 5 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 63afef58b3b7..635cd5fa284f 100644
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
@@ -701,6 +710,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
@@ -722,7 +736,42 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
+}
+
+int cxl_cper_register_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, CXL);
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, CXL);
+
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, CXL);
 
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 740ac5d8809f..5bad24965e24 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,6 +650,68 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, CXL);
+
+void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
+				       struct cxl_ras_capability_regs ras_cap)
+{
+	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
+
+	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_port_prot_err, CXL);
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
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_port_prot_err, CXL);
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
index 188412d45e0d..f6d467cd9232 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1067,6 +1067,51 @@ static void cxl_cper_work_fn(struct work_struct *work)
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
+
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
@@ -1077,7 +1122,18 @@ static int __init cxl_pci_driver_init(void)
 
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
@@ -1085,7 +1141,9 @@ static int __init cxl_pci_driver_init(void)
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


