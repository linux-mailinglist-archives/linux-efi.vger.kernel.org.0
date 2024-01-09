Return-Path: <linux-efi+bounces-367-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DA827D7B
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 04:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ECAB22F04
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E65395;
	Tue,  9 Jan 2024 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lG00N1UT"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40026106;
	Tue,  9 Jan 2024 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+eLOXEcPMGH4Op7Zrq0fLN4+zaTsZhKsyLsz6YqK7HfvosOoQo1zjFG5l6nHj4YAkqT1CKBfN8DuYCKfGzszCvhuSEbHBm9fL/XCTk9kWO873ZMGr9Sf4ZL+n44QbNjUU1TclpVi4rWHNCO7NT4NG+AMCz0OyU7u0DTzmKowFX/ygJUQtfLhgkE8vbpIjOCt0HelfV44g1sGzhoohHe8efOezH5tzLonHBpx7M1UJVsXtz40nVgy9cBhKW98pkW8a0v+0lnZ9nY01yAOjgkbZ/luxkEuq6cId0aFDxPGf+vl/4UxTnZtXt2WkAmz+3WwjWUjWABGTYNtq7zYfFSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoUtilH3GQrGKCOfbgpzmU0KAYF9juPbA1ck7qdC6n4=;
 b=mpBblyZ2duIIIyHx2JUo2hzdz9uXdTV+tj7Ek4SQQVfHOSBpPhA1PWPIPlvjP/ayRrCwiCu5w/pGE16IcDERm+EROMzBMy8pLiRRfHkC83JCucVsBUu4ei7G4XyEfvjucNbaOYNQKyZzOhjT9NrdBf5Y9qsvBIe539XHrZtA00QSOayhUhuysmBkKyAkE8BSVe0Ec19Kxr7pJrFKfdO+wb2cu2eK8mjS/vYPfwpBcq2b1aQQvIUX9GoqCNlvi5Oaa3oZvpc3PshLEO+FXorRdCFqI3GW4rXDK+W0a58j37tMaxHz6zBuV/1bI2OW3A9ycAjiH+U+K6zZOT8t6A1t1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoUtilH3GQrGKCOfbgpzmU0KAYF9juPbA1ck7qdC6n4=;
 b=lG00N1UT6EGISudk4SVp7gxFnsObLBJhXGgV3Y+fSb1FNHhC1zEnWY+eQ1Ma0r6yRaQ91IrNPV09P+w/q+f6ZIUkL74k5nRO16VNuxJp6OqoDe9sVZ4hVYj7/f3QB0bhRZfCsx6ObnJbHSQMi1v3m+AlcS5i/29fctADC3lkfQ8=
Received: from BYAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:c0::14)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 03:48:13 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::d8) by BYAPR05CA0001.outlook.office365.com
 (2603:10b6:a03:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Tue, 9 Jan 2024 03:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
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
Subject: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
Date: Tue, 9 Jan 2024 03:47:54 +0000
Message-ID: <20240109034755.100555-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5972f506-ed0c-44a7-277c-08dc10c5ce14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hMMbs/Dhyj3wdDL0MOld5ssxdYYGRHCfgQm6mqyETiDloWOcSqafpe15nSEx2WDV111y0OeB/RR4NY45V9B9qqd+k7pAVIrOIRawPYhzBqFoSr78K7K8bkwkzLGwnFPLHGdmb+cPZ9eEe9Jcaxof9IRME9VZsZJqhv5DcOpbHvCCmUsnZ2uUSx2A45vjbib8tAk1P2dBKlLOlKC7boZh1FurWHxJdTmAqvyLqwAIp5TMRyXuS5MKg62ZTgpiL+qV2Gnf13Wf+CXeY6g5qGM2SrFcTnMEMab0+b/5cFm9ovuAipTyInNcYvTHjkrDvTEF5PQhHy4e6urQ+jbzSh9IZluejjapYzqOLdNZxkm0tsEBVedbhRFsfwd7TN8JLna9sVIzOCWNC/3nUC9rTz2QxRrJ3RS86HInB/Hc/Z8hCMSQ4V6HlsgwcEjkpa+tt7fgLrY/0upftcjDdsEzbJfavR5R5YkQYW4kGHYTLXvfKD8MZmcLz7Tpc7SeyQydUd3wk1SM99w+KlylORvNtBLEn/7NayBrArTWNn8wGWAKfhDbcx/jj+K4hfY00opj1u647X1FrMsSl4r0qPETElupTblDV9JHnPROzIEXvUyhijl/wZWtcS4Jm4OKChG06DS82nCc6R26MpdV3B1o8D6XTmW1h1A5vCU/3/LEA2e0l38F4LEKw7AgQYlzBk9Kogtlmw9+atqK5CW2sQU9stAJRchbTCMl9IgU6ah1+v+7JgLy3vWGrGhbDQ8ZZu1Fv/fO471tHR8fEDWA1XnwUFcuiuHvF/a2FZCIlVvc6vLx+XYzhWQ6CXxlYa5MI/s3OJ+j
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(47076005)(81166007)(82740400003)(356005)(36756003)(40480700001)(40460700003)(86362001)(6666004)(7696005)(316002)(8676002)(478600001)(4326008)(54906003)(26005)(336012)(1076003)(16526019)(36860700001)(2616005)(426003)(70586007)(110136005)(70206006)(83380400001)(8936002)(41300700001)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:48:13.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5972f506-ed0c-44a7-277c-08dc10c5ce14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.

Add GHES support to detect CXL CPER Protocol record and cache error
severity, device_id, serial number and CXL RAS capability struct in
struct cxl_cper_event_info.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Change to sub-struct for protocol error specific elemenets.
	Set serial number unconditionally.
	Copy entire cxl_ras_capability_regs struct rather than pointer.
	Calculate error severity in efi/cper and change to enum.
---
 drivers/acpi/apei/ghes.c        | 11 ++++++
 drivers/firmware/efi/cper_cxl.c | 68 +++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h       | 13 +++++++
 3 files changed, 92 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 60b615d361d3..1d4f3d68a0bc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -714,6 +714,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		cper_callback(event_type, &info);
 }
 
+void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
+{
+	struct cxl_cper_event_info info;
+
+	if (cxl_cper_handle_prot_err_info(gdata, &info))
+		return;
+}
+
 int cxl_cper_register_callback(cxl_cper_callback callback)
 {
 	guard(rwsem_write)(&cxl_cper_rw_sem);
@@ -768,6 +776,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev);
 		}
+		else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			cxl_cper_handle_prot_err(gdata);
+		}
 		else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 4fd8d783993e..9b9b8c8f1157 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <acpi/ghes.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -44,6 +45,17 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
+static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
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
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
@@ -176,3 +188,59 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_event_info *info)
+{
+	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+	struct cper_cxl_event_devid *device_id = &info->rec.hdr.device_id;
+	struct cper_cxl_event_sn *dev_serial_num =  &info->rec.hdr.dev_serial_num;
+	size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err(FW_WARN "Not a valid protocol error log\n");
+		return -EINVAL;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
+		pr_err(FW_WARN "Not a valid Device ID\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Set device serial number unconditionally.
+	 *
+	 * Print a warning message if it is not valid. The device serial
+	 * number is considered valid for CXL 1.1 device, CXL 2.0 device,
+	 * CXL 2.0 Logical device, or CXL 2.0 Fabric Manager Managed
+	 * Logical Device.
+	 */
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
+	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
+		pr_warn(FW_WARN "Not a valid serial number\n");
+
+	dev_serial_num->lower_dw = prot_err->dev_serial_num.lower_dw;
+	dev_serial_num->upper_dw = prot_err->dev_serial_num.upper_dw;
+
+	/*
+	 * The device ID or agent address is only valid for CXL 1.1 device,
+	 * CXL 2.0 device, CXL 2.0 Logical device, CXL 2.0 Fabric Manager
+	 * Managed Logical Device, CXL Root Port, CXL Downstream Switch
+	 * Port, or CXL Upstream Switch Port.
+	 */
+	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
+		device_id->segment_num = prot_err->agent_addr.segment;
+		device_id->bus_num = prot_err->agent_addr.bus;
+		device_id->device_num = prot_err->agent_addr.device;
+		device_id->func_num = prot_err->agent_addr.function;
+	} else {
+		pr_err(FW_WARN "Not a valid agent type\n");
+		return -EINVAL;
+	}
+
+	info->p_err.cxl_ras = *(struct cxl_ras_capability_regs *)((long)prot_err + size);
+
+	info->p_err.severity = cper_severity_cxl_aer(gdata->error_severity);
+
+	return 0;
+}
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 3a41dd5723e8..08e3979de9a3 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -152,13 +152,26 @@ struct cxl_ras_capability_regs {
 	u32 header_log[16];
 };
 
+enum cxl_aer_err_type {
+	CXL_AER_UNCORRECTABLE,
+	CXL_AER_CORRECTABLE,
+};
+
 struct cxl_cper_event_info {
 	struct cxl_cper_event_rec rec;
+	struct cxl_cper_prot_err {
+		struct cxl_ras_capability_regs cxl_ras;
+		int severity;
+	} p_err;
 };
 
 typedef void (*cxl_cper_callback)(enum cxl_event_type type,
 				  struct cxl_cper_event_info *info);
 
+struct acpi_hest_generic_data;
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_event_info *info);
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_callback(cxl_cper_callback callback);
 int cxl_cper_unregister_callback(cxl_cper_callback callback);
-- 
2.17.1


