Return-Path: <linux-efi+bounces-2178-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA49D1CAB
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A03A282918
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D01798C;
	Tue, 19 Nov 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/nUZ0t2"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62112F375;
	Tue, 19 Nov 2024 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976779; cv=fail; b=kKQpk511kPQnwI3oicP9OhcAdc0cvZUDXLi7buybdF66kQM1ryilQqj/xpcrdba5Nk0WyohBns5uVmheejk6ILXsdZpEA56FQDXKt2ysa6ARmCC46EKICUF8UPn6HyzHJQJ/FMzkzPe7r1UnfTt2TK3/Khx8dN3swLonSIJHJ/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976779; c=relaxed/simple;
	bh=s1dTVHODGYZHn4DWYL4w6ARvDv58hIcasPs2LJRX848=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3TdgG/p/a28Epxp0O9/x7RVGcXeUd+Q3FLRSOftVtNR1+q7b6w2Z71/KZV9KPw/ZPZKfOGYjCzqCL7JAIP6uNbQ2lG5UdKGxZXv9qrEQmpd3tU9EJLfyOY6a0nt2ZyrXXpV27FoHn3G3QfEITHkyxbnwN/uOaETlq8+XKrr9yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/nUZ0t2; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYlTSjjPa53W9sjZQbbF9zXIpqj4z6U+V75x8ZDS4iwsA3SmVCKw10tg9hP4lAOW6fs5QzZS75DYUeEFgJW/aRvBfmRqofYLHawXhQPXVtERxu5WZHTX3RSlyxgfvZVH/H1vG7kbPT6LV4chI1rd/dFhK6KEvyjqW27iVo9rweovIIleoj6gk/Rurk1vzfa5kQmN4YNkE8C3H3ADq4A0ndBsSJFZpq8bklkX1OHjY88AY/NvpthU/teblW8fMDyi2ajytq+Pnr77ET+Pps7BtdWkQGpJWX2Q8dDze+KgdXoQVHWyhgBzmdzxTP49tmdYD6PLCZEFTik+hTX+PEOiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXo3T/9XOSb8PMo6JY0TO7NVnXhFQUcqrbXmC+2RFeg=;
 b=glXrmyxEC7YgTNyj7bClQ7NO84+xhQdXFFKXR7aAysbz1aSoph1vjK3UI1vZv5Fg5hqC8EUkePuPASg6vOBJEtoDV8ykJllKJCd2wNhQWKc2CQKEPqH0AV47GINiEE2zfxKFCmxWBJ441DXMmYVcLZnFCnu/wca69U4Ik8xIwk/ULQnlgKHoSiU9YBF+VmDNaESnNOtp4MAG1On/CqOUbKO9iWxemJXLDe3wpHTtLhhPuclK8tYb3XVZ3DbpCVG/vcj4+/t5odszkW3I2yxMnOkT1Gr8hhSSTD9KYn4y6Jap7Y+lunlVN6+65U/Y0pMXV2oCcaOt4vE7S1xvUD/SLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXo3T/9XOSb8PMo6JY0TO7NVnXhFQUcqrbXmC+2RFeg=;
 b=s/nUZ0t2uRlQZbDq3WUA5h1CPsMv90jkpG5Z8ymg+f2kfiuezzyctYNd4sgO7zinXaW5L/YOxwooFMweXqJwnQaWz2UYseZUTbyi+XbGFyn/2oyaHUiIuo8jn6BG07VbPVWWCHhCHo+qtfoaKUCEJWI7CTXLQTTlCKl7caA5Hjc=
Received: from DM6PR10CA0001.namprd10.prod.outlook.com (2603:10b6:5:60::14) by
 SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 00:39:34 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::a2) by DM6PR10CA0001.outlook.office365.com
 (2603:10b6:5:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:34 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:28 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 7/7] acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
Date: Tue, 19 Nov 2024 00:39:15 +0000
Message-ID: <20241119003915.174386-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 447822bd-3f13-40ef-e5e2-08dd0832a389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUUIu/6lVVTnS8utfx6mpo7o67f7DiU8gt1rx64KBZVSrUbTDqjp0I+/NqVD?=
 =?us-ascii?Q?+c9xF6UFJg9NjwoG218tSrRDB2VeYD924SOAB+vmOuZPlDKtszbNEa66zFIv?=
 =?us-ascii?Q?EFD3Lz/9njJNJkRtxxZyX7Q9BFT99QoB5ROkJ8zvd9dvckPoFLaE8Wq5YkdP?=
 =?us-ascii?Q?L2QOQ+b4e9d+3y+QGuCNXRXrYd/qMSk+BKu4SHI9ue+SAAy2loo6TLzble9I?=
 =?us-ascii?Q?nryDyNdOWCyWJ2/VDnVCUjRDWn/xTw65KZuMbkRM33655zIDz+iXhB9Ihf2R?=
 =?us-ascii?Q?TgYVkViXh2oJnjaSLUZgZnH3YUDvaHk65kqLF7/1i5SoFr63dsqS8ZuW6bKr?=
 =?us-ascii?Q?ft6virdKhgmzGICWzUV3OsxwJqn7pPXDTYukyj0ZvZlzalK2OPtkguyvVDF4?=
 =?us-ascii?Q?ggx3vUdov6QDxZDG4dyWc7cwUozVVSDD6mVDRAA4NUqpBb+sUfphM3aOmPNV?=
 =?us-ascii?Q?cfHDPlXA3NPiznOWkkGweHDFelWMRdY9zZmL8v4f5iqkMYG0vyTiljtduKn8?=
 =?us-ascii?Q?p4FLWlIHat/ER88kKBM2G7HLYxsIv2ZRmfEUNRHNWBqun7fh345hp3Jtvxls?=
 =?us-ascii?Q?pQYon6eGPG7ezUp8mlnAeqtmL9AeE6MppkWlOG7lGIenyE2EvOGo5VBVj3mN?=
 =?us-ascii?Q?qjlsAFZ44etMX4coIVh+tkiq3k9q3ek3bLkTzm7JYVRTCz+q2HlYtBL/DrFR?=
 =?us-ascii?Q?KNz6K6LtZm/cPAgX4FnSCB0m91qEXnVyeOEkwxD4rHGTXGXcw0HR/eE2RjDY?=
 =?us-ascii?Q?Nqe2tIO7LT7CVhltrv71b7fmnDoS7k/zXxZfo/yLwWhQflHL0iYDyt2D6Qxz?=
 =?us-ascii?Q?CAr/R52/XrqeqBVHH0MxmXp+vg5snbAKfuL7npdpbUwNrmL8pnpU3V91vnIN?=
 =?us-ascii?Q?JzUxs1q0UCozON2lTBdrbMyU3mHfCfQ7jODldhS2YXYSiZXcVqG8+ec5wDVB?=
 =?us-ascii?Q?8fujZskNYAHLb7+vw//JCE/9NWowxXj9jBPGa12Z4TnmYttuwTdLijCFXZnO?=
 =?us-ascii?Q?ykVx/UiAyXSZUgbJly5gqc/DRCyPsSL3EtjKjZnEWFE+Re8JtXCi9PONa/by?=
 =?us-ascii?Q?1A1K1UtNc59zAgJLZHrh5GtQhcqWKQYxFDruGZcG3hBfVmo92xHpw5dootkR?=
 =?us-ascii?Q?dYTaXxHPb4NSlel5A0XkOsFFBd/P3OoSNt6VzJP2CxHcKAloEsKW7EpgVabo?=
 =?us-ascii?Q?ehjUgvsXsyiWR3fN0ETuqs6mnaqVt3WZmy0ecfI3iuZQylP+Q8PKd67qIhmH?=
 =?us-ascii?Q?w8glx68A8qpBHNL9qEa7lYDfiV4Z9MZRmQuBfdSxEuNjj1vglTcOIKD1SfJP?=
 =?us-ascii?Q?RlyOaA7w9I89ob69SdrTzNEgYyOdBZPMwAF+qL3yPehLQdMfJgg8cm7CaP3m?=
 =?us-ascii?Q?ErLmi+w/S8DhfUwxJO4hEi4UUaSzW/7Pjbb49ysd4c0Zzcu0sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:34.0651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447822bd-3f13-40ef-e5e2-08dd0832a389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784

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
 drivers/acpi/apei/ghes.c | 41 ++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c   | 50 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h     |  6 +++++
 drivers/cxl/pci.c        | 55 ++++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h      | 15 +++++++++++
 5 files changed, 167 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6cd9d5375d7c..32062b6a9985 100644
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
@@ -722,6 +736,13 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
 }
 
 /* Room for 8 entries for each of the 4 event log queues */
@@ -809,6 +830,26 @@ int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, CXL);
 
+int cxl_cper_register_prot_err_work(struct work_struct *work)
+{
+	return cxl_cper_register_work(&cxl_cper_prot_err_work,
+				      &cxl_cper_prot_err_work_lock, work);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, CXL);
+
+int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+{
+	return cxl_cper_unregister_work(&cxl_cper_prot_err_work,
+					&cxl_cper_prot_err_work_lock, work);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, CXL);
+
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, CXL);
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4ede038a7148..c992b34c290b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,6 +650,56 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
+void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
+				  struct cxl_ras_capability_regs ras_cap)
+{
+	struct cxl_dev_state *cxlds;
+	u32 status;
+
+	status = ras_cap.cor_status & ~ras_cap.cor_mask;
+
+	if (!flag) {
+		trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+		return;
+	}
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);
+
+void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
+				    struct cxl_ras_capability_regs ras_cap)
+{
+	struct cxl_dev_state *cxlds;
+	u32 status, fe;
+
+	status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+
+	if (hweight32(status) > 1)
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   ras_cap.cap_control));
+	else
+		fe = status;
+
+	if (!flag) {
+		trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
+						       ras_cap.header_log);
+		return;
+	}
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
 static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..5e4aa8681937 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -129,4 +129,10 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+struct cxl_ras_capability_regs;
+void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
+				  struct cxl_ras_capability_regs ras_cap);
+void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
+				    struct cxl_ras_capability_regs ras_cap);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 88a14d7baa65..e261abe60e90 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1067,6 +1067,53 @@ static void cxl_cper_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
 
+static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
+{
+	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
+				       data->prot_err.agent_addr.function);
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(
+			data->prot_err.agent_addr.segment,
+			data->prot_err.agent_addr.bus,
+			devfn
+		);
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
+			cxl_cper_trace_corr_prot_err(pdev, false, data->ras_cap);
+		else
+			cxl_cper_trace_uncorr_prot_err(pdev, false, data->ras_cap);
+
+		return;
+	}
+
+	if (data->severity == AER_CORRECTABLE)
+		cxl_cper_trace_corr_prot_err(pdev, true, data->ras_cap);
+	else
+		cxl_cper_trace_uncorr_prot_err(pdev, true, data->ras_cap);
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
@@ -1079,13 +1126,21 @@ static int __init cxl_pci_driver_init(void)
 	if (rc)
 		pci_unregister_driver(&cxl_pci_driver);
 
+	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	if (rc) {
+		cxl_cper_unregister_event_work(&cxl_cper_work);
+		pci_unregister_driver(&cxl_pci_driver);
+	}
+
 	return rc;
 }
 
 static void __exit cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_event_work(&cxl_cper_work);
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index c9a38ebaf207..5f83c3bfc813 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -242,6 +242,9 @@ struct cxl_cper_prot_err_work_data {
 int cxl_cper_register_event_work(struct work_struct *work);
 int cxl_cper_unregister_event_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
+int cxl_cper_register_prot_err_work(struct work_struct *work);
+int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_event_work(struct work_struct *work)
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


