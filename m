Return-Path: <linux-efi+bounces-2834-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4EA46E3E
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 23:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD877A364E
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 22:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AAB26D5D4;
	Wed, 26 Feb 2025 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7pYZkIy"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227626BD81;
	Wed, 26 Feb 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607936; cv=fail; b=Csb9qvsINK+/goN3pwuZvCXj1lMjqHQ3PeA0RlnEMHEfbeNfwe1PY0IZbTlSM55RJ+t+/QNAu0Tj5trPFQGHLp8A9uhoiMKO4Eaq/poCagPZYTCnymQDlrQodF7zIwh5rdqlXdiZhBm4WPxJEb8OVeRygeJxRD11X9k2F5Z2ALo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607936; c=relaxed/simple;
	bh=pIJ3OXuq16xfQx2OrioVDOVfnUQFCz7sly37zJOJj7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMFQGLrI6Eg9waVHxlnJ8Dt7VW2l5MlfsERQTKrCIH2riAYJfWLwtumNEmX93NCE+qvZRq00lFVl/dWgpkXu8ER4TzOptNy+C9Lvrtly/bHi/N7XMjcgTq4ip2Y12Nt5xWk2Tio33h0YC4b1hWSHqVDs/ZyI+3H6r3/8qoHHuBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7pYZkIy; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ4r2WE3e72wjC8AOppsycxKraKYaJ8NdDqVDq7yDFt/9njRHPFZUqotp9lyPthOXbNjRMY2L7bW/gvRjfs8CdBDEvdYcur1iX7E68jUoz/2znZ9g702iynGpAaWt8VcEoMrMY13pPA5QCmIMplkLL+ndAVhlcz4zqHUy8sIjsCxN4afRS0jKwNse7KBpiqUBg3rBm3eLrw2eYFzEAyimtl+Lb5t8opbNSYGfMOEHQACUWSG20EjKlcGfPTuzdXVPW7FjzG8GdgmGIwyNuua6DOSwqlZqqCFqCLWc/vs+Wo+VQ5DB9+QAI3mw39YVwjkfi9alZmFZHiHMSRGnSFVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5R3Bj9Oc0Tf4J4PKUrIxvWx4agLd5V38BvmxrTw2rA=;
 b=HfFimyDZGt92dY6Vw566ROjiqwUExYAXqTD7ve9+aBd9S5xkGZS2iMEh3mYXlGbSjJGb+dCoBTqcvxJMosWUo/M9BAf4YigDVJNlh/wZ5Mvca4URhevv8v68ArHaA2MUMUFTQeUUqg77i2rTEgUmRwdZ0IBnrxJW42EKZCfVU2OwCQqZvQTDMMuj9kSwnzrzSTeaDH1JUudXJvSwQtxneLgRKdGFZIoukBRscvOfUONDhhBS0rnAxJB4Hlx0PuzTOBFjsP2UpcUYRpVKnoAzPFEsqzwkZiYyK4HZKnwsyqjbv3ARTuVnydlIJ4D2lct330Rv8S1eggxMj2uGNFHS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5R3Bj9Oc0Tf4J4PKUrIxvWx4agLd5V38BvmxrTw2rA=;
 b=g7pYZkIyObyaDkE8hgOnRkHHWUxfib77baNLVNkGxUBiC5tPME5EMo4bEqsp2qG7j8eH4j1g4Fzq1t1GSAJ1S28A58/Wd++7e5XMSYcQQF1JnEBAv/vGvHCI6NkaaPbT+xa8YdK45Pqys2dNEQzNHe8UY9jUnOHuSIEvx9rxhbs=
Received: from BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 22:12:09 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ed) by BL1PR13CA0355.outlook.office365.com
 (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Wed,
 26 Feb 2025 22:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 22:12:09 +0000
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
Subject: [PATCH v7 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
Date: Wed, 26 Feb 2025 22:11:56 +0000
Message-ID: <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: a70b41f8-5c37-4dea-83ba-08dd56b29d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJ/lTCsMC6xFhiuUd1rDz4nQnaq/k+KkmmCh3OO8WJlHjZa3r9KrJi3+Bi8+?=
 =?us-ascii?Q?n8ATTR7ywXUCauQXm52tLMiwdSS+9CkIkfRM+Mot/MV6GqVJiVJr+ZEQPi46?=
 =?us-ascii?Q?P8xj7eKlnKVWE11Tfiqkxn4bChR5aiZKAecVeJvY7MHBaBz2Q194PSqKyax0?=
 =?us-ascii?Q?BCWRn4E5ZrKv7PsFSr1mNLenca0lWOXxl9eopTlGQcG8ukRv1Yw4qR+Hv6x1?=
 =?us-ascii?Q?7HofSsBb8ghUbnroB0gjiMnzbmHJLyuZizX9CfkdJpVyS0OQBOnicwmEC3Dv?=
 =?us-ascii?Q?KArNvfsmEJXviEnfQlMGuPkvHYOpGiwToKoZSKJ/zMeMaVyBj7TsBJeg0bvc?=
 =?us-ascii?Q?X+F2Bs8tBHvgn+cPx20FkkcF5bTmGzVRt/knF3IHacv7JDKQPiQf1FUQZ1nM?=
 =?us-ascii?Q?I3hf6ZlHHfGvw7bOdWQIwu0ne4dzruIdq5Jfq/xHQEYsIcEoPtZtSsDOu72c?=
 =?us-ascii?Q?Qfl+0cI+oXxCt2K4p/ROkoXAOzvudCdtYIzhiQPQepOueklr+ajuHFvs1G1F?=
 =?us-ascii?Q?IHL3ZWXRPUzuDUpxXOCjRRHEcaNxCgZ9T/FrzcWYe58Wu0NJZgEQPVtwQnLe?=
 =?us-ascii?Q?78ht0Mo64FlLqV5lwwTI9WbJZg0Xw0ZIk9HvPUJQGq7aPKO4YDFk7/BgwVM+?=
 =?us-ascii?Q?Ifx2mPESjYdvtjrs3lysWStXC3mkLAlQrkwrZv9HN9B6OmIgvyPcOEW2THKo?=
 =?us-ascii?Q?6yaEpile8bq4CDt62sqguWybluFyQTbsqV9qZUNvesBBhdGGiCHhi5vYbADr?=
 =?us-ascii?Q?7iqpgwv24ZpKFDrY54EF0dfn6jzrP/gPwn9xz83Ja2DteET/zjRdgYEMcDYi?=
 =?us-ascii?Q?G6HXyypm4p3IlduSD2HcR/x1R+FnUuQ7+v7DylB09jjKZUhc+zNE9Ji3Uqlv?=
 =?us-ascii?Q?bI9XJB3cQIl+KSTmrULp92s/pmVjd1gtDu9cIG3gU0GSj5AX6OxL4cKW1x0U?=
 =?us-ascii?Q?JbZGFRorbZJbZcoYMRVAps4rC76I5RF52gZwL6Y9J9Lmkt+NY5xQ7tkmuUhy?=
 =?us-ascii?Q?HBjnTyl6QadidSNj32SOsVfZ8gF9jEXyV/Reg1n7H6Egt963obi7OLXR1BrL?=
 =?us-ascii?Q?JOID0SQ6Jk9vOh+E9f+DcgT9vEJTf5PP0NtjKItqifLktvwZ94xLBJa+ffDF?=
 =?us-ascii?Q?gCeLMbCgHZO2mP3guSHKHOhDZj3SwpYbZRFjJh0oUKCqe9FYml14WjslplQ4?=
 =?us-ascii?Q?SgltE9NDOeHuIEAGkhW88HtdYlANR7rVwGoBgALyKcFtJbBUYKIf+dIjqvmA?=
 =?us-ascii?Q?yzxT+sxgEyNiuMCEK80IG/3O8lcaNsW/Gf0R8mrH6xt18FBvHswRaaHhuOrS?=
 =?us-ascii?Q?aYBe0ecYWwlGIDkrbcoa1FDd8nNVl7aV15GG6c11yIMrk+LIJxjl4RqgRMuK?=
 =?us-ascii?Q?AlTGySQlf8t0Xg6+w9XB1AhJxj2L611u9VKbIZoQXgK/HyC8DLC5rOKCqZ4B?=
 =?us-ascii?Q?4AbqOMEG1kep7qA3J/G3n1eAKKnsiIOfzMZQuAL5gMUDtxVycHNKPNKSpe48?=
 =?us-ascii?Q?hzuSwWPss7sibZk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 22:12:09.7510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70b41f8-5c37-4dea-83ba-08dd56b29d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202

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
Comments: There is a potential failure case, and I am seeking feedback.

If a CXL Protocol Error occurs during boot: Both acpi_ghes_init() and
cxl_core_init() are subsys_initcall. GHES might detect the error and
trigger cxl_cper_post_prot_err() even before CXL device is completely
enumerated. (i.e pdev might return NULL OR pdev might succeed and cxlds
might be NULL as cxl_pci driver is not loaded.)

Usage of delayed_workqueue(): Would delaying the handling/logging of
errors, particularly uncorrectable errors, be acceptable?
Any alternative suggestions for addressing this issue would be greatly
appreciated.

Tony questioned choosing value 8 for FIFO_DEPTH in v6. That was just a
random value that I picked. I would appreciate any suggestions in
considering the appropriate value for number of entries.
---
 drivers/acpi/apei/ghes.c  | 49 ++++++++++++++++++++++
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/port.c   |  7 ++++
 drivers/cxl/core/ras.c    | 85 +++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h       | 15 +++++++
 6 files changed, 160 insertions(+)
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
index 000000000000..8c596f035095
--- /dev/null
+++ b/drivers/cxl/core/ras.c
@@ -0,0 +1,85 @@
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
+	guard(device)(&pdev->dev);
+	if (!pdev)
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
-- 
2.17.1


