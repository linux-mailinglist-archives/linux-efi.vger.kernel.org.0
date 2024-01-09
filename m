Return-Path: <linux-efi+bounces-369-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AC827D81
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 04:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E061C23457
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA44610A;
	Tue,  9 Jan 2024 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3vyBsHGh"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DE6138;
	Tue,  9 Jan 2024 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdJFPnFd2ZkTmb29muLeh2kt1CbSdC03PW8jIqX/DHeiZk2opqwcpsTJ89jN3xssCthhW1jSpATVVCnSNMOpK7JRL2V7+14HvtDmU/Lu1XIXl4FAyUbMxQuFMFXanYhEXcCxTHIP6/ZTeBevlK0S9QjEKU/7vf3vB0TTfaT850zSimJGA63thBw0ZsmOoAvDTsasx/mLJBYh36ewYUpA+wcfMgCnEncS7isBp7sBTJ60JDH6u50O8X3G1G3o5uWjQuJr06A6UjJwHxPkAq6t1OXIEI02dloc/YFfSQ2SiLqol//8SKXv99PtgtDtrTc6tNnAMBMEbcbWWpcI1VgprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4VDsdPH549mZejIGl9WijLAsxYPD46g+VgR/DNrwU=;
 b=nNILzluqsJdotcGXKYCyafIJk4cGP99EDLkjWY350Vi5lhU2Ai670xD5/WGz234gtTskSt8SRfNTH3hc8s9IJhVivhHm6sVTqfIU5pNKfMj1TVhuPkO5IK8ziiIfQ4ofnWX1onXKxgW1GdtDmrO/Q1OTNnz3gwa5kVWB/FarDw3Y4jDalWklJphRIuvJxx6JwIsY/JJZ3kIEO1L5uieH42snaCzjQxCJYlAnmzxmIQ11UtOWELLnmj6v6ReIERafXnH1yIs/T6g73UW02zLYPqJiDTQ8GCW/NzGx/ngTJ8DapY0lNhe0Ey0YpXMr44plmI3VEbG/F17FZd/NUQJviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4VDsdPH549mZejIGl9WijLAsxYPD46g+VgR/DNrwU=;
 b=3vyBsHGhmXYe446s9KxSLK08AbDmsoM2uYfnBEKCvqjJBWPNMa5FrKnUFlGdb59rRh/4uS5i7l5q8gZz2BWOXubV5hRuqoKOEGp4vpcY/cXDuHDIDHqjtahLs92LLPiDvKqyJLszvYq56VWOXk+0Skc3BEWEihF3wlKmB1DH29M=
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:48:14 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::4) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 03:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Tue, 9 Jan 2024 03:48:13 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 21:48:07 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
Date: Tue, 9 Jan 2024 03:47:55 +0000
Message-ID: <20240109034755.100555-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: f052e536-862c-458f-84a4-08dc10c5ce70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YUdAdEXCSWYY58wqfVbeHAVhNRxliHpYEmW+BFGFBX9M0LG6crp4voMYwXbxz42I99Y6/YmMjGy3PAmSn9XUMNRqoIvpG7Oz1cOu37e3WnbLTulbzyP0UDdtjXcmYQoKQohIlmnbBvBWgyIQ5sqC4jb9zA7ZCLwy/lR0NyW7i6OZh4Hf8Ru/ahoJdMRI4FGaApcJ6DhfTez7C0P3dIHuhQqWnfNbPpptfYS4gA5odcwkLdKKdO5hBGsGcRbtl05DW8E54lK0SvPVGfuCH3xsx8FM3JUfpxZlUA6eP7j+rdDwvvyTRFwSf1+qQiLa36dz+YfYREbQNIcSdlL7xMQVmgmtHsrFK1ZNbv40ESFTdRjBSIVqyuAdtqTWe40ktHk8c5eEThjsimKm9H/5icDGBYgEpdJOi4KFxBWWwxO6uKnttE8SshQC2jax+JeWua1cj5yBDXkF/yaqjuzfCwoJrQbFjs9Qstttq5cmn60qqPR+ZlcuEqh6PIm19M+0BZQ2oMm7g1IT78KfrXjWzNtOjb2U1OejYeljlPRUtJthnCPe2zizEv0YWucMdjDxCgEGBvx3ZQHvZmT0+ae/bE2UsAS2l+U+4kuO+UOONlBSev0SM9lfswdP1zV4zM9iToHc1mAyR76brQc0oPtxHV9I83w5QTid84CI7URu3rX7S/9iYJl421WCnMgFVBYuUrP+kR7DrRo7FQ9g7BdPAbjt0BGDjSGIhqq/OaAO4VCAmaXjoj3t/dewPKcSsUJkMRaG7kUWzQdftcKvmZoJftjGaOpaWoLSQgN77vMmPR6l/+PS8TNQLwg3NY2U+yVFcAH9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(2616005)(1076003)(336012)(426003)(26005)(478600001)(6666004)(7696005)(47076005)(36860700001)(83380400001)(41300700001)(5660300002)(8936002)(70206006)(54906003)(110136005)(8676002)(16526019)(4326008)(70586007)(316002)(2906002)(86362001)(356005)(82740400003)(81166007)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:48:13.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f052e536-862c-458f-84a4-08dc10c5ce70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046

When PCIe AER is in FW-First, OS should process CXL Protocol errors from
CPER records. These CPER records obtained from GHES module, will rely on
a registered callback to be notified to the CXL subsystem in order to be
processed.

Call the existing cxl_cper_callback to notify the CXL subsystem on a
Protocol error.

The defined trace events cxl_aer_uncorrectable_error and
cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
them to trace FW-First Protocol Errors.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Added warning for serial number check.
	Moved severity determination to previous patch.
---
 drivers/acpi/apei/ghes.c  |  5 +++++
 drivers/cxl/core/pci.c    | 29 +++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h      |  3 +++
 drivers/cxl/pci.c         |  5 +++++
 include/linux/cxl-event.h |  1 +
 5 files changed, 43 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1d4f3d68a0bc..4318b602e797 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -716,10 +716,15 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
 {
+	enum cxl_event_type event_type = CXL_CPER_EVENT_PROT_ERR;
 	struct cxl_cper_event_info info;
 
 	if (cxl_cper_handle_prot_err_info(gdata, &info))
 		return;
+
+	guard(rwsem_read)(&cxl_cper_rw_sem);
+	if (cper_callback)
+		cper_callback(event_type, &info);
 }
 
 int cxl_cper_register_callback(cxl_cper_callback callback)
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 37e1652afbc7..bde8ebf5e4b3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -836,6 +836,35 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
+void cxl_prot_err_trace_record(struct cxl_dev_state *cxlds,
+			       struct cxl_cper_event_info *info)
+{
+	struct cper_cxl_event_sn *dev_serial_num =  &info->rec.hdr.dev_serial_num;
+	u32 status, fe;
+
+	if (((u64)dev_serial_num->upper_dw << 32 |
+	     dev_serial_num->lower_dw) != cxlds->serial)
+		pr_warn("The device serial number in CPER differs or isn't valid\n");
+
+	if (info->p_err.severity == CXL_AER_CORRECTABLE) {
+		status = info->p_err.cxl_ras.cor_status & ~info->p_err.cxl_ras.cor_mask;
+
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	} else {
+		status = info->p_err.cxl_ras.uncor_status & ~info->p_err.cxl_ras.uncor_mask;
+
+		if (hweight32(status) > 1)
+			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+					   info->p_err.cxl_ras.cap_control));
+		else
+			fe = status;
+
+		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+						  info->p_err.cxl_ras.header_log);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_prot_err_trace_record, CXL);
+
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0fa4799ea316..216003d4aec1 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -93,4 +93,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+struct cxl_cper_event_info;
+void cxl_prot_err_trace_record(struct cxl_dev_state *cxlds,
+			       struct cxl_cper_event_info *info);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1ad240ead4fd..515983e7df10 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -995,6 +995,11 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
 	if (!cxlds)
 		return;
 
+	if (ev_type == CXL_CPER_EVENT_PROT_ERR) {
+		cxl_prot_err_trace_record(cxlds, info);
+		return;
+	}
+
 	/* Fabricate a log type */
 	hdr_flags = get_unaligned_le24(info->rec.event.generic.hdr.flags);
 	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 08e3979de9a3..96cc88aa04f3 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -113,6 +113,7 @@ enum cxl_event_type {
 	CXL_CPER_EVENT_GEN_MEDIA,
 	CXL_CPER_EVENT_DRAM,
 	CXL_CPER_EVENT_MEM_MODULE,
+	CXL_CPER_EVENT_PROT_ERR,
 };
 
 #define CPER_CXL_DEVICE_ID_VALID		BIT(0)
-- 
2.17.1


