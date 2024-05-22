Return-Path: <linux-efi+bounces-1058-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73768CC3D8
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC2F284FFB
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D647A7C;
	Wed, 22 May 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IoEs5M0/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735123768;
	Wed, 22 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390539; cv=fail; b=pACD8uxyXpDTFbGmJmcY4jFo1Wrm0FM3MLo7PBB2+Qmx2vyP3+Jf7HgRpbbhSt8Q5dygeUMkDwWJL7dl+eBxfkkFkIjKuJNA9i442GPaYXtNzwttVO4iQ8CO9Lw+ydi+SaH35CeF6/umTFJrmN6N01/sSFobdJ+tTa6tyeKxdzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390539; c=relaxed/simple;
	bh=WHF67jPsYsmRB40Yf0PQjBNDzL5h3tSYQL6+crLrk9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJxUqm7VRSv9oMOL5Z+H7MDf/9ZwGIchjuOCc3Ep6/bcRZp3k+wP3QRgSs+ftRfQGjmL4R1gUHrT0uMUMdobX3QwKIyptREmxOEdRNoCpeMnpQBCuoognr96YwUa+GdDpAdqD0E+8JeYXnYDgqlaEtOII54NGAoza+hWfJABHCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IoEs5M0/; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwCkGD8UQzmreccj/P59IBv11wT0bvHGPnL8Qo4JGPCNJmjLcjcMcFl7GtquMVaywH5DSZ5kd7yqaKJg0mXLeeFZPk6yEg2DinVWsTp3mJGHb7e088ZfEvGJ7ShVC5d1gftDZecpl0llQw3CFIQo1vpdyba1D4kbtSCH9iOsDpHuicCZZ4fR84JUkSAZZUBjCg5kgJiQZSfxaQZhHSAqRabh9MK2T8PIQOPBz0JhHLLiuFUpi9k7ln3w0hitxm+9yWFZEyJO70c6IGOMJSxkk19sP8fMIe8iF+EXGww6G/CqwRVRsiQiMPAJmGU/ahZ6D3bc2p/5Xmxi+wM3Xg2uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eycSI0A5auSGUyeKl4O/ntf8HSgeTTVsS9zAfHB44pI=;
 b=iV7cgNRc6bHy6fV3ys0M7wiSo03Lx+H407osBXcmZbDtsl155cpVXD+7Cf3eBfO0FOyLImqcbA85+qrCL66+5/LAD4yR7OnkO2fWcmcr0j7fmTL/VVUNQz51UfURK0seMy0LqMSxJy0cobr0I1+Z0A63uhZ2kPljmqk46W4MLugoKX6DGG2rio9Z4GLcQFRC2WUrpo24Voqz5WL3CkhMvZT/VVf8t7QasLdaCxrjio5OItX8vHXbCH49FXUtlbUM2yk6t3ncLP/oxBSw/EF5bsT85SEqruMS94JAa82FETacFF8qfXqm+jcwT/mY7+qjrKyLrjrwraIwsM7JyfDxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eycSI0A5auSGUyeKl4O/ntf8HSgeTTVsS9zAfHB44pI=;
 b=IoEs5M0/fnlRUtsG31gu44bm3TFmMW1QqzebQY5YLcdjjx9TQkYuWvQ226R+R+rd3mryKtkGg07X5h/Rw91fXG0SnqTB/x3/0aZC+LgglSqZDeJ3NqjqyGFmFQsFQ4RTmfB1C4YibVomLznFZYb0allISHpKhEGBqseLyX5J2j0=
Received: from BN6PR17CA0050.namprd17.prod.outlook.com (2603:10b6:405:75::39)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 15:08:53 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::3d) by BN6PR17CA0050.outlook.office365.com
 (2603:10b6:405:75::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Wed, 22 May 2024 15:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 15:08:53 +0000
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
Subject: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
Date: Wed, 22 May 2024 15:08:38 +0000
Message-ID: <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 75448cdb-8dec-4220-20c9-08dc7a71180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epTqHPU9QOmCToS33mzOykMjBHH8PfRxADUp3tYgD05oEdfHJrBknzivmkQC?=
 =?us-ascii?Q?Q9HrpY0yvnkm40y3TwDaBf7Vqed3NJjBrSYAwGwi77D5EgcxuM4RmON5FlaQ?=
 =?us-ascii?Q?Y4rlqXshRnMoywHgazsdDuHexHXw81sGIkm2IbGuvaZobRC0SGpBTouRPjc3?=
 =?us-ascii?Q?S9tnAS46pe9KkCnSHcePylqFkbIoSHRgwyzJH80N+R2nHWxSkWl5Wrr2729R?=
 =?us-ascii?Q?BZeRTrFMlIYGWX/6vUVqKXjM9S+wPBzSqW3kAcQO+YxiFGh6BYG7ODwnLMMd?=
 =?us-ascii?Q?CTNx+V4fQZ+jVSRslkXWRqCM/11sbYWotPojj3YoyCJtV6ofjUJfBz/L/anN?=
 =?us-ascii?Q?qHTrrl05/idCEiCASKXqBeIf46OCMekIYp1tv3fyb5vxpw/M70Nv5/O3N++h?=
 =?us-ascii?Q?Lp08ddCKXbBPaLF4oV1TYavaKlsa/UG3PFbvsfFEDbN00eyXAqcL7tRYZKiS?=
 =?us-ascii?Q?G34OX1S/uKWDODFioPapv+Y6gVHvJpipzM31DxVq4S8ffhKqbkkYoDTclMKB?=
 =?us-ascii?Q?stbvChEOtviWTG3lPFBSag10ecKoz0nG9/JdR8EFk9yxULFfwm4t4rYYjMHz?=
 =?us-ascii?Q?ZQTIwF3tuEa/MHXTegJDqYkFXus5duNKaS+TO5UweBSuoGwkrZ7uwJHGjZlG?=
 =?us-ascii?Q?h+SaLgIBx72qRQpudnUEfzWLzTfwnXZ6LR1j+xq90VzwtuQtlkme2DM5oExp?=
 =?us-ascii?Q?lLaoAiWKEwy7I29I0bHsvUGh4661k7f1iEjRUa+/CVa76kWaZbTao46czTUR?=
 =?us-ascii?Q?qif2qEQze6Y9MTGTE1OcLtYO24JK8HbrNwXZ3jGzPWQ5UPz/V4tAVWh/k14w?=
 =?us-ascii?Q?3lgh8/9lr1SUrwK+ew/L9Q0bW8E8lyS4LLAg0/XQ1zqfOZ2SRd9lOzHqv4rX?=
 =?us-ascii?Q?qYHbGUCAYsPrxtFL59JiDUidiZAptaD6NFs43P0ggtkX56/RuRL8aXJ2TbRi?=
 =?us-ascii?Q?AdU5SqX3OuY+iChkl4SeOV6nZxDj+Uikw/SwqsqDyFPclvMcxCQYPQFQQGrW?=
 =?us-ascii?Q?w1LW6tDzddcSf3/IrD9vlbbY3k3+eXUMolMbG4RpUz6Ylf248bgmC/1C2r0l?=
 =?us-ascii?Q?5OmMy519J7RBKcvEaV6svyen1DeHta4BIuwKM8LrdA1TKczohY2G3bTp2J+/?=
 =?us-ascii?Q?lfRWoSk17VIpQcS8KF0TjebM8k+7rliLZbZtsIjl+EunyTUEloYj0nTmRhVj?=
 =?us-ascii?Q?OXE3/V25KKvAdzytDFNZTIb1p0fjfofBvh+hOUBExPPUrsEc7zTbUQCTj5TZ?=
 =?us-ascii?Q?cmbSoMNRNGClql2HcJIV/+wWYCJAETYKOksOtLqvU6G9DEVF90gDeh0dXxeF?=
 =?us-ascii?Q?VZnwgE6UP8VqS2pl7rpasLpJbpW6dIlLH2SkFyYpIVDst/Rp7spbeK/QJ2sk?=
 =?us-ascii?Q?kOVgPrgZ7MtZqgFPxtuvR1zfFpFU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:08:53.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75448cdb-8dec-4220-20c9-08dc7a71180c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

When PCIe AER is in FW-First, OS should process CXL Protocol errors from
CPER records.

Reuse the existing work queue cxl_cper_work registered with GHES to notify
the CXL subsystem on a Protocol error.

The defined trace events cxl_aer_uncorrectable_error and
cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
them to trace FW-First Protocol Errors.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
 drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
 drivers/cxl/cxlpci.h      |  3 +++
 drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
 include/linux/cxl-event.h |  1 +
 5 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1a58032770ee..a31bd91e9475 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
 
 	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
 		return;
+
+	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+
+	if (!cxl_cper_work)
+		return;
+
+	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
+
+	if (!kfifo_put(&cxl_cper_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_work);
 }
 
 int cxl_cper_register_work(struct work_struct *work)
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..ef9438cb1dd6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -686,6 +686,30 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
+void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
+			struct cxl_cper_prot_err *p_err)
+{
+	u32 status, fe;
+
+	if (p_err->severity == CXL_AER_CORRECTABLE) {
+		status = p_err->cxl_ras.cor_status & ~p_err->cxl_ras.cor_mask;
+
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	} else {
+		status = p_err->cxl_ras.uncor_status & ~p_err->cxl_ras.uncor_mask;
+
+		if (hweight32(status) > 1)
+			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+					   p_err->cxl_ras.cap_control));
+		else
+			fe = status;
+
+		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+						  p_err->cxl_ras.header_log);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
+
 static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 				 void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 93992a1c8eec..0ba3215786e1 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -130,4 +130,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+struct cxl_cper_prot_err;
+void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
+			struct cxl_cper_prot_err *p_err);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 74876c9835e8..3e3c36983686 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1011,12 +1011,42 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 			       &uuid_null, &rec->event);
 }
 
+static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	struct cxl_dev_state *cxlds;
+	unsigned int devfn;
+
+	devfn = PCI_DEVFN(p_err->device, p_err->function);
+	pdev = pci_get_domain_bus_and_slot(p_err->segment,
+					   p_err->bus, devfn);
+	if (!pdev)
+		return;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver != &cxl_pci_driver)
+		return;
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	if (((u64)p_err->upper_dw << 32 | p_err->lower_dw) != cxlds->serial)
+		pr_warn("CPER-reported device serial number does not match expected value\n");
+
+	cxl_trace_prot_err(cxlds, p_err);
+}
+
 static void cxl_cper_work_fn(struct work_struct *work)
 {
 	struct cxl_cper_work_data wd;
 
-	while (cxl_cper_kfifo_get(&wd))
-		cxl_handle_cper_event(wd.event_type, &wd.rec);
+	while (cxl_cper_kfifo_get(&wd)) {
+		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
+			cxl_handle_prot_err(&wd.p_err);
+		else
+			cxl_handle_cper_event(wd.event_type, &wd.rec);
+	}
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 9c7b69e076a0..5562844df850 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -122,6 +122,7 @@ struct cxl_event_record_raw {
 } __packed;
 
 enum cxl_event_type {
+	CXL_CPER_EVENT_PROT_ERR,
 	CXL_CPER_EVENT_GENERIC,
 	CXL_CPER_EVENT_GEN_MEDIA,
 	CXL_CPER_EVENT_DRAM,
-- 
2.17.1


