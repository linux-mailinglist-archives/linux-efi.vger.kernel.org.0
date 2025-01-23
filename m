Return-Path: <linux-efi+bounces-2723-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97420A1A02C
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30CF16D8DC
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73820DD7F;
	Thu, 23 Jan 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLYVXiLN"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543920CCCD;
	Thu, 23 Jan 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621905; cv=fail; b=loVz9aYWYxz+hOp7y0uYDGm2ss0KqdOiumgFqAgT5B04uxU2p6sNO25dInNa23HIp/2IMBBHcwncupl7XUUvi9owfHo6+l+Z6k4q4TONNKWOtmMAAEvIoTbEDUthkucWoomISQZy29pDGEU5YmtaNLLsxlt3geNg1HvuMSMC68c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621905; c=relaxed/simple;
	bh=nYtZtn05jrbRiNXU330/UdKXSRXBc7NR1p+Qrj5Y2L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTXipmB8YDbzfKGqBvuKQvwnSNcF7V2gEY9yroqH7rihlM14SAro8EYgA5uN7mph+ljS9TAXGr4Dxi+PueDMNODx4X4AeWpJ/W8IyP/WcU2FwEyyYap/0aN1pU4hd1EeR1AC/eZuDIByOnSQQ6IsUdDxX/dzhJ1M7tPTjB0iYN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLYVXiLN; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmyWnMYc206yAiWxFYlbj8iE9DBQPz1I4V0TTJhFQz8mekvFS53JTeN//4d7GRYz95oAH02KUQ7lwjt81MQURv2v6pBpPUxEAiwQIJqc4uIP0KnKUwhVNVj2YG7293ZxbqbirqNETNSR/Fk49spY6VCRQmtLj/l+c6DQof/1Llm/+ch9Q75mUXimDM5NIbtxngaMFSz1byLQJsZ3LccCrqC/dnbsIU3wQz97j+vyxO13y8WJyEMQXxfWlV7S/VdyDVhGxCkeLVRbfSa6iVMzQ3JgvYKabr/x0Ghk3frS2z+fzFOyuf6cMFQBVUE06DGFhMlyyaJ3dSSam3Ierbwrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUOSl0l/6+oCAycMRhw0c2mCUCrmhGHOPECc0DqVCCY=;
 b=dwHof2aORdPMT2eDM1/lAit+/RUJY55bN3XER0/QD5u87p1m1vFAyMqXe+Ky5ntQYrlnn27Wyhk5vO8Dd/Ii4Wf41Fuv08fwpKNmInjRhawoAHoKmVw+kEDixjJNwj7sr1R97quf3SMFB+gw+nDgJ/jRMCiTACz2XoLA9Z4NXfuNXZsTV21BWVQR2L+Q5h/hIoj8nW/vhVqdK4ir1TlkJcAJPymqNP9/c0cbQizn7PGsUwxGTcQ8EuDWcFUN+hopKm59A6wOvgHB9JoCtbtujdNYurcaV/0AMjHo9VYf7iPXicWGzmfCXOMjaFULIu8kFlAb+xwrhovxYCh4mmr6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUOSl0l/6+oCAycMRhw0c2mCUCrmhGHOPECc0DqVCCY=;
 b=iLYVXiLNPCMNaICElPUfkXEbe7y8bhjuXj2SLEQ1mVDLG6s3HxJeTUewa7idq0ZYmWd1e4rVOXq1rJevfOjKsbPfzd7gwyWjeBuMaGmqzx0LF7vIwIGpdjxuRFVCHU9hsdwQw96wMRJ/mJxVZM/pTRgc80cdw+lmkLHxz3Z/sfM=
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 08:44:40 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::e4) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.17 via Frontend Transport; Thu,
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
Subject: [PATCH v6 6/6] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Thu, 23 Jan 2025 08:44:21 +0000
Message-ID: <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: b81f9cfa-9fcf-442c-5ac8-08dd3b8a2d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FJCX2z0bOwkiENF6J7XB2SGhpcY4V7h/M+ZiAFyAsPioT+oJ+aW7w/anYb2J?=
 =?us-ascii?Q?AOD3ozMfZtwVgn/bn0R0mdqZyA9YWdz+jRhnQnEJi1eFN9OEsqs5/3c7gtVH?=
 =?us-ascii?Q?5RnflC7ApRUGHt5Fck6mO9iqDs71/o5kw5EZx11q3BwAl41MV+/6VusqZkbm?=
 =?us-ascii?Q?zBUqU8I5R3nEsm8gBIFTKllx1x+4zYJLO6Ue+9d/c6ypTj0TMNg8iXXU8lDs?=
 =?us-ascii?Q?zQ4Z0eGaRpotVJnFf1vyZIIbO33fkZF6Xcx+zssSGsuMJTz0wfBfnhMgHZgD?=
 =?us-ascii?Q?pmdCwX+VdvJgVy8lNoWW5Krsipzz025Yx4aCqVefSkyFtV9TCdgUeB9elBcp?=
 =?us-ascii?Q?2X0uIL3SfR/W5Sy9oDWieA7T62jOGudPNcpfjB+q7vX7vDDsZEHo0Z6LMeSJ?=
 =?us-ascii?Q?PRSpppoHGI2/9zmie1FOdl9So3KbMZU0po1+uZ3PDqMo/Ychha5AIf49nPWv?=
 =?us-ascii?Q?UmIhT3971EcEjVzTTt6RLiS0F1y5a4fQBNQ5HX5+eiwF7KgDj7dk0+kJNWBl?=
 =?us-ascii?Q?QXp2wStQTGOsgy6lHXvnEWeeAAwlZ/avHTJOGf7lHXd27Qy5IvIWTZGyeSYj?=
 =?us-ascii?Q?b7owxIVprGuSqjN0TTaSu54NLAenYm49c/Bwokvt8ruO+E2IwRUKPNkRwO7l?=
 =?us-ascii?Q?MUK3uiDre/yDGXB71A26cJ769ulYQxU9pVaLZ9/qMrgw0Bs2V7qj5U7p93RN?=
 =?us-ascii?Q?iA6XhKJGTjdQtGKcNVqgLQH77854PjZ1S4+0gCmRKgmkA4FjLj2JRaC9XLnD?=
 =?us-ascii?Q?MhorcEy+xh85p4Bwd/QGHn3cyTkyHKUujhJB3rBCjG6cBH28lVXBDGe0vyN1?=
 =?us-ascii?Q?pZPRbFBXClufNOJaToXZeomUCjG87+ReWaZ7PoUilviJSL44K1fj5y34PAU+?=
 =?us-ascii?Q?Zp884/3JUlaWaPQ4dtlLkIX/7iqSwE1npNP7FEDkUFPzFUjNGW1586YzjDSJ?=
 =?us-ascii?Q?N3TgFlLUb1U/36HQC1RkAENAps5CzlXUOgfUJtfE+OE6mv33p8v3t3RL49rk?=
 =?us-ascii?Q?hQuILXmBT8KvPb4PewTBqqYa9t6zGLGKGJHgfZ3gy3SZmbud2yT+l1WdsHbR?=
 =?us-ascii?Q?WLZpwMEtib3jKA14mly1k/Yqjkk/eTxW0vuTdgoXEu/f2FU7UVFPwuOu1idI?=
 =?us-ascii?Q?9yFmHYq6VavSAPl/yQ5b0f5yVx2v9OTg/QILwwldF8XUXLUG66LjC3RTg5US?=
 =?us-ascii?Q?vXC+3AF5l0e1KgGX0HkDcz6ACXwbcuOmfhE7qBuxKBSHFRVpkwfM+VUCIf9y?=
 =?us-ascii?Q?MLjLHM//2ZdymzOEfxzrhu+/IJcOCyvdEwVv51tcK3mMJyE0+CFkOHlAANRC?=
 =?us-ascii?Q?r1sZbBprL/buoUi/xByvfzPhIsM+1LALYpVpCLa3b6CTKgi5QWDJSjriH2eM?=
 =?us-ascii?Q?vByPdv3LGdXjaxTS9GGLo1vr9FRXtk3wG8z2RVENihJRDBroXwH6je97Z23g?=
 =?us-ascii?Q?r1cc9GLeRByHAoc6tEkRPLO+oXMdoCs9At25MGcisaM3jrgiKQdQikAx0l2c?=
 =?us-ascii?Q?PjuRUCWa6PhVO04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:40.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f9cfa-9fcf-442c-5ac8-08dd3b8a2d37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861

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
 drivers/cxl/core/pci.c   | 26 ++++++++++++++++++++++
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h     |  4 ++++
 drivers/cxl/pci.c        | 13 +++++++++++
 4 files changed, 90 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5840056bb9a3..b535da901dec 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -686,6 +686,32 @@ void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, "CXL");
 
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
 static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 				 void __iomem *ras_base)
 {
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8389a94adb1a..f684a2ae14e8 100644
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
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index e457616373ed..23f2b1c9bd13 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -134,4 +134,8 @@ void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
 				  struct cxl_ras_capability_regs ras_cap);
 void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
 				    struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
+				       struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
+					 struct cxl_ras_capability_regs ras_cap);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9d4b5f39b21a..766447c169c8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1168,6 +1168,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
+	int port_type;
 
 	if (!pdev)
 		return;
@@ -1176,6 +1177,18 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 	if (pdev->driver != &cxl_pci_driver)
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
-- 
2.17.1


