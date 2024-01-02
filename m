Return-Path: <linux-efi+bounces-289-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C682821E67
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933331C2244F
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE361548E;
	Tue,  2 Jan 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmuHDemL"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAE14F7F;
	Tue,  2 Jan 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbqeyplA0JBrotd60HtoRjhhuUvZcxI6MXRzYu9W1rNBQfoWXbVNDRxh9etPCzarSY6ZLfg7qdABLJyy1KqLH5z5aZ3aCX7ri5myXxGKpC5Q3UW91L20PG+DkKHIy/CSnB6jhs5ObESWiGTOStLNPWJfSp7LEHPx4XGq95YRK6MbpK2OjsWFP+58wJ4e0jsv0Yac2Tvg+B0IsCh0wUZMkP2B+fOgX3efhj8ZnQcmR96BDSj6+q6EQqugfI2n5H9XBwOAb///W+kqb4CBDi52lgVw77O0npvgmm341GTyXMmxrwSV8OupJp5sAEWDt4vYbLG7UZCOouG7Hi9Etg2elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa/A0BplfTHT4VMHgccgIJ2VIXQOQr7bkgnOG/qWzkk=;
 b=DD2FrPEHtcc7zQ2qzRONZ/A+eiOfAc8Ia1SsPga/vspkw015gMeQU9UR+I2o45l8F7dwVtQfD6+l9OQ8dXYoZAvXkgwapD4d2WblgQ6e675McdA8ZW5ImzS2rRZ8KX9xHqmKtjbhHUBBpUnTUNgR6fk7SfFpCVYaXTn/KrGqL6gne1hnVFS2HNqJHkFxw2cr73IGivtlxQa8sr8VpNjcPrGNa7nyh1RTPREIq22oiYwZ2eI5EXsMZCibswVelenocqLi8VUG1j0zzlERrhySZULJu2v/8VUCeKRIulSIY1FxsqkKjSjCmyi+4G4mwC6v8TPEwxc10o0QjMKy8PYoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa/A0BplfTHT4VMHgccgIJ2VIXQOQr7bkgnOG/qWzkk=;
 b=MmuHDemL9K7X/9sM0SmQ1Hek7x0EXnhcmTfrqPu/0qfpL0MW8PWC4gviyX9/qGBrWfgPqKHMEPnQ1k6/M5NnA02UnbE1YTuDB+2DdjuTjEkQgOaZNiJeUFMNRcRWxm8FfiHm5nP4b8+A6NBTzV5ulNsoE32pzcrHAnqiXo2P8h0=
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:09:48 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::f6) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 15:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:09:48 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 09:09:46 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
Date: Tue, 2 Jan 2024 15:09:33 +0000
Message-ID: <20240102150933.161009-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5704745e-0b23-476c-2b1b-08dc0ba4dcd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/CuS4eNaX9HqKnxK5c5nht+eQ4HoV6j6uEne3QFkSrDVCeuoTCgLMmP+UPkj0tw2Ngd2U7rEHE6hSgbO3VwtS5Twmbor+Min18Fcsh9ZyoNqzpkyhG6fi1VnwdZ6OoCLT9nJsmSamiSKijVnAK+bVaWcXBLt2RCKndWyz7jyqy3VdVdIqyFjq4HW3dK9mQuKaQJq2sTTtOJLHIXvWTk3vu0L6aocE6wW5DC4hAgX9Oe2yypgkNMqucQbJLS7T9Gnt4TcgsujdpFkq64arsMt+1fVSqjZsNSPIoasnepRv34yTk5GFx/mYvTlUIRH9f4KDlpFKAvzOZoSrD1iwRPimC+b+v7t9iHyqoGsfGzdJw1YV0S4vg8DqD+vsFcpWTaBSW2P3MNv5g2H61mhCJzDvDfTZHPXi3lWiwEQfyf7HGzqbiptzZsbt7hxD1MmCTS1ME14lAHjMc1ygy3komJbxNpUZwoX1FxLM0/H701z3haCdQxidqRcH9EtVCtgLLYrgFLZe7uGtqTq6Gw6Ee7PEHaWY1VGRJslSNpL6sn+GkXj1CGRz2a8SGNr/1Ij0b1XxDomedShxCFTU0JuKHHvF9eaFAl+4IzS8EJdNWKO8RlxYvJDxdKLAJo/eDHw2VUR/Q/kZ0Ig1byKhFp8zc0dwxn5/zidgooRqiDof1IXL2184dfqgIhmAmKfgE+NsKMu41zoa02QvGZSJx/8pXONkdfQF6S9HTwv2TMMVaXTgfw0JsOCH2Vr/3Ee/g67jzyYAhJ7cyvWl0NBlp2lx9ixLg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(336012)(2616005)(426003)(16526019)(26005)(1076003)(83380400001)(86362001)(81166007)(82740400003)(36756003)(356005)(5660300002)(70586007)(4326008)(36860700001)(7696005)(6666004)(70206006)(8676002)(8936002)(54906003)(316002)(110136005)(41300700001)(2906002)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:09:48.6279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5704745e-0b23-476c-2b1b-08dc0ba4dcd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996

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
 drivers/acpi/apei/ghes.c  |  5 +++++
 drivers/cxl/core/pci.c    | 46 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h      |  3 +++
 drivers/cxl/pci.c         |  5 +++++
 include/linux/cxl-event.h |  1 +
 5 files changed, 60 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6471584b2e79..217494c7c884 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -716,6 +716,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
 {
+	enum cxl_event_type event_type = CXL_CPER_EVENT_PROT_ERR;
 	struct cxl_cper_rec_data data;
 
 	memset(&data, 0, sizeof(data));
@@ -724,6 +725,10 @@ void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
 		return;
 
 	data.severity = gdata->error_severity;
+
+	guard(rwsem_read)(&cxl_cper_rw_sem);
+	if (cper_callback)
+		cper_callback(event_type, &data);
 }
 
 int cxl_cper_register_callback(cxl_cper_callback callback)
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 37e1652afbc7..da516982a625 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <linux/cper.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -836,6 +837,51 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
+#define CXL_AER_UNCORRECTABLE	0
+#define CXL_AER_CORRECTABLE	1
+
+int cper_severity_cxl_aer(int cper_severity)
+{
+	switch (cper_severity) {
+	case CPER_SEV_RECOVERABLE:
+	case CPER_SEV_FATAL:
+		return CXL_AER_UNCORRECTABLE;
+	default:
+		return CXL_AER_CORRECTABLE;
+	}
+}
+
+void cxl_prot_err_trace_record(struct cxl_dev_state *cxlds,
+			       struct cxl_cper_rec_data *data)
+{
+	struct cper_cxl_event_sn *dev_serial_num =  &data->rec.hdr.dev_serial_num;
+	u32 status, fe;
+	int severity;
+
+	severity = cper_severity_cxl_aer(data->severity);
+
+	cxlds->serial = (((u64)dev_serial_num->upper_dw << 32) |
+			dev_serial_num->lower_dw);
+
+	if (severity == CXL_AER_CORRECTABLE) {
+		status = data->cxl_ras->cor_status & ~data->cxl_ras->cor_mask;
+
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	} else {
+		status = data->cxl_ras->uncor_status & ~data->cxl_ras->uncor_mask;
+
+		if (hweight32(status) > 1)
+			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+					   data->cxl_ras->cap_control));
+		else
+			fe = status;
+
+		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+						  data->cxl_ras->header_log);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_prot_err_trace_record, CXL);
+
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0fa4799ea316..462f1f9e82b0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -93,4 +93,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+struct cxl_cper_rec_data;
+void cxl_prot_err_trace_record(struct cxl_dev_state *cxlds,
+			       struct cxl_cper_rec_data *data);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7edbd53357e5..2b9f4dbf06c9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -995,6 +995,11 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
 	if (!cxlds)
 		return;
 
+	if (ev_type == CXL_CPER_EVENT_PROT_ERR) {
+		cxl_prot_err_trace_record(cxlds, data);
+		return;
+	}
+
 	/* Fabricate a log type */
 	hdr_flags = get_unaligned_le24(data->rec.event.generic.hdr.flags);
 	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 7ba2dfd6619e..b4558f206f59 100644
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


