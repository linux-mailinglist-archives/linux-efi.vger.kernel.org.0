Return-Path: <linux-efi+bounces-1859-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E009298B19D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 02:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF84B20AB0
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 00:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEF2A1D6;
	Tue,  1 Oct 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BXp7qfaA"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353464A07;
	Tue,  1 Oct 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727744015; cv=fail; b=IHZdpZjoUMJCPYTXwpdGN/s/IgvxTJjitU22PJPpYMxLPPjZv2I5s5VADSWnHm54Jn086lQ1hvNNzfjqYxWGlFmNFWDgQfC7eWSoRQ0ZLl04stLiIFH+KxQckjGPRz8yix1FjqnFiW9rjUKUX7+x8lzCZAFWxsqaRNMk3gPDROU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727744015; c=relaxed/simple;
	bh=VZccbom9MKVnveKfEsVbvcqF4J7BFqAWtMdhon6M+GE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXHtr5arpqz7CuqGbAwPX6RdHNT3atkRq8zoUmyKF5xugrmPmCmAluJrA8Q2JqF6bRlahOV4U+e+fNEFSjm5Rfx/l/3EwlZMyWJEyJ6yDGtBjrLagUZ9VrF8HvtSDzYUBhdQA/pdyu3RC43h6T3oiRN5vNP+cg+/h0SzO4QGT2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BXp7qfaA; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5y5RCTQthFVHsTQNxEkm1Qq2bP1N1N3AV/lQXiK5Mm89MbERY5gH7z1rAVMWQwNZiXwRwZpGU4CB0U57ceLeMZyB+8kcUTLg1UgdpfRJAAiLfZZF/rrZDYmFobwClv67uLHh4AXuTcZIwOhcD2vWdswOSt7ZVN//mi4TCZFnRwXoHWHJXHDaZ0rtnVlOEBuMqvcBRD3PSF1mBsZ5qwxjqPJFB5hnWD8K5ViAFAbv9iLzQezj4Tqg6CphVPZui3vROO6ECs7rvsMH9gVBqCDI/ditI4Mt5NOv5p0qHVa16TE7eaW7BDI9zdYhV62qJFNvh85dUSuUwPvnw2JtUPY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVZ0uNU+sZKj27kOQnDYZg1/V0MhyxKQ6l9rYmErz1I=;
 b=Pg9lfLXFQ0sYdc1U8rNpMHOcccguEV40R//w+SS4lJzpsNqsIvRTx0lQP1rB5tWEKZHBcl3cZ55nFq2r8ppZ2Gss8CpH3hP8hDXXK6FI5LaIkTh8a4FTN49Jvz/FXWoKtQJ/8Wp1z2pNnFET3MtbMP78DFGzsIXaziu8Yt77ZOxA0z6939i+Q1eQ/JpCGjCsOrnaTPNtVeUOXB2BF8l4vyyYp+SN/AUo7ZgGNE6V6A0G6wRQMogOl06xCHCwk/QiYtbCAAUELJgCHBPl+usrKsWliHYKcqcXWV9TvwMIWj//tnv//CBOr8npGtuD4pdH2yY0dVnpQZjv+UYVMmEvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVZ0uNU+sZKj27kOQnDYZg1/V0MhyxKQ6l9rYmErz1I=;
 b=BXp7qfaAFT6Xy1tgIzdi/eiTV1/4PERpWvZos4GL1Bi8OBRHs0Erh12qQ/4tdMRgGpPUUP7uGHoUvkDa5gn7SlMIGowSBanuFDBB6QyFawVSCFoisiXws2vSluwUnM1T+jqRPrw/r8whuoDKYp+y01b24q/yT8GlvTvOfMFvgNw=
Received: from BYAPR11CA0040.namprd11.prod.outlook.com (2603:10b6:a03:80::17)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 00:53:29 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::a3) by BYAPR11CA0040.outlook.office365.com
 (2603:10b6:a03:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Tue, 1 Oct 2024 00:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 00:53:28 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 19:53:22 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
Date: Tue, 1 Oct 2024 00:52:34 +0000
Message-ID: <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7eb268-e517-45a0-5370-08dce1b376c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1BFVirFdAiWjOl8KQCbYQ9JagBd/6qImxPqoIixuqQk8468fOChg8LKM5EZj?=
 =?us-ascii?Q?GISjFNKzJHsBl89Vj7Axd++LFiEzTs1DOU1Fef3TGt1/eB+tTRPTxpc8QfMe?=
 =?us-ascii?Q?DvogDayZvDIqWn7Wz3gKIz78+3cvO3ED75dv6VCvpTLwXqyqCPM0Km7ouXhQ?=
 =?us-ascii?Q?kulrv/AxU1Ex2cgpYQq9Ay6R2Mg4eKc+jDjZxLgWE3LPP/Fpf8idsv4Fx3Y0?=
 =?us-ascii?Q?1/yR1gNYWn2TxuDtfYjbKV2gNjFOv3vrUQmRczU4GXMEuXr4n2q41o5hkqqs?=
 =?us-ascii?Q?XuIW9iB95w7NYN74MbYNkuNL/of7rYv8GMvyt6gHO63TpJtXfy7jMIlm1hZe?=
 =?us-ascii?Q?wEjBfvBx9vzCst1BeKDEaypa9P+1Kn+Qgpo3o6wuuT1KmXO4Za9VspuDEchP?=
 =?us-ascii?Q?tEGiNBUv/mGs9/hRiR9j4BS2ZXxcwtKFMCwONvdz0UiVgx6roqV/aAWmkJyY?=
 =?us-ascii?Q?HQMmvr+9w+INZL1YhVrffU+P9Zk/UMRcMXQFhvI3R5nmNzBilb0kvTRaw8aE?=
 =?us-ascii?Q?FtkyEkJF7oJXvc+RJxkL5wqSTdorI7squhGV6chX4AS/rOGGK3zNTVij2mLH?=
 =?us-ascii?Q?3JxR9ZK5unny9Uefjdfsfdts6g4OHGVtezqDpya/ARYuKRpt3Wz0f+Q8zHVJ?=
 =?us-ascii?Q?GI9m4a9XtRKkSHFB77KxLxC/iQeww3dwVxYScYefc0y5pdnvNv0imoK9yEHw?=
 =?us-ascii?Q?p4i+wGU8gLXGBfQad5o/qNwwMmWpNwuILhMDryveyBlNFHHthbE5VfOk/joE?=
 =?us-ascii?Q?l4r1f+xE6N+ujgiSEhjE97ezzu6iMYKMZyCul3U+lMj/L3muptgQVkzXdpYU?=
 =?us-ascii?Q?STudIZgIHbSl6DGSaw/1dTYutpgYV2GQe0a3k8bvrpWKmGwF26Oqmb84R1lG?=
 =?us-ascii?Q?8UnPp4prU9HIeZhJP2EOheIU5ip9dJ07IQx3H83JLotOYOIWhEB/KA/seiq+?=
 =?us-ascii?Q?9x+1ke4HefPz1cx0Qxuwbe1KV+cjKu6ZroMRn1eqXLR7Oq2TSRAszKp4HunD?=
 =?us-ascii?Q?onYD7VlCQIWaAo9dSiijemTRHaNeUIWyCyXQScRkwiBSz8DSFwl/JZLR4sDL?=
 =?us-ascii?Q?VQ36sKTxnvLXXLtz3woSVj+YkUyVaONPXvkcjQ0vasAYDUVW9XoFSJ1w17jf?=
 =?us-ascii?Q?C9viSbAZzhXUayKumtyqha43BWXCA0xb2deBxTp9Q3x0isCsuypxT+yJEPqR?=
 =?us-ascii?Q?SO8bnTUGRGlw1b7Z+ut8R3MRtQmgsedA6NVYV3AxSQA5QUwjyKIN44LwvldE?=
 =?us-ascii?Q?4EUREyU9LbY1iGPR6ZncW5QjH8UUR1whNzahjmy4hTc/n3MeWcbdlGS+09QJ?=
 =?us-ascii?Q?MXJV6xXJm/8TsuroGAo91mLNIdWFclL2bBSwyo1EK15fy41wh9zaH75yxpWB?=
 =?us-ascii?Q?lHk9SRXG5pFmJRmKrn0aVJ7SP+tlcD+1vJ1ZYEnhmOm6Oaw0MAmBWs8KI6nZ?=
 =?us-ascii?Q?2Ni6v0W/aUhjbcPuiZqo/cXPIPKOlTfN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:53:28.6309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7eb268-e517-45a0-5370-08dce1b376c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

When PCIe AER is in FW-First, OS should process CXL Protocol errors from
CPER records.

Reuse the existing work queue cxl_cper_work registered with GHES to notify
the CXL subsystem on a Protocol error.

The defined trace events cxl_aer_uncorrectable_error and
cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
them to trace FW-First Protocol Errors.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Removed pr_warn for serial number.
	p_err -> rec/p_rec.
---
 drivers/acpi/apei/ghes.c | 14 ++++++++++++++
 drivers/cxl/core/pci.c   | 24 ++++++++++++++++++++++++
 drivers/cxl/cxlpci.h     |  3 +++
 drivers/cxl/pci.c        | 20 ++++++++++++++++++--
 include/cxl/event.h      |  1 +
 5 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9dcf0f78458f..5082885e1f2c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
 
 	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
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
index 5b46bc46aaa9..39ef24c8991f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,6 +650,30 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
+void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
+			struct cxl_cper_prot_err *rec)
+{
+	u32 status, fe;
+
+	if (rec->severity == CXL_AER_CORRECTABLE) {
+		status = rec->cxl_ras.cor_status & ~rec->cxl_ras.cor_mask;
+
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	} else {
+		status = rec->cxl_ras.uncor_status & ~rec->cxl_ras.uncor_mask;
+
+		if (hweight32(status) > 1)
+			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+					   rec->cxl_ras.cap_control));
+		else
+			fe = status;
+
+		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+						  rec->cxl_ras.header_log);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
+
 static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 				 void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..8acd8f2c39c9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -129,4 +129,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+struct cxl_cper_prot_err;
+void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
+			struct cxl_cper_prot_err *rec);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 915102f5113f..0a29321921a0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1064,12 +1064,28 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 			       &uuid_null, &rec->event);
 }
 
+static void cxl_handle_prot_err(struct cxl_cper_prot_err *rec)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = get_cxl_devstate(rec->segment, rec->bus,
+				 rec->device, rec->function);
+	if (!cxlds)
+		return;
+
+	cxl_trace_prot_err(cxlds, rec);
+}
+
 static void cxl_cper_work_fn(struct work_struct *work)
 {
 	struct cxl_cper_work_data wd;
 
-	while (cxl_cper_kfifo_get(&wd))
-		cxl_handle_cper_event(wd.event_type, &wd.rec);
+	while (cxl_cper_kfifo_get(&wd)) {
+		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
+			cxl_handle_prot_err(&wd.p_rec);
+		else
+			cxl_handle_cper_event(wd.event_type, &wd.rec);
+	}
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 5b316150556a..d854d8c435db 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -115,6 +115,7 @@ struct cxl_event_record_raw {
 } __packed;
 
 enum cxl_event_type {
+	CXL_CPER_EVENT_PROT_ERR,
 	CXL_CPER_EVENT_GENERIC,
 	CXL_CPER_EVENT_GEN_MEDIA,
 	CXL_CPER_EVENT_DRAM,
-- 
2.17.1


