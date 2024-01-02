Return-Path: <linux-efi+bounces-290-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056E821E6A
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE11F22575
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C010F154B2;
	Tue,  2 Jan 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hTLNFWDT"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314A14F88;
	Tue,  2 Jan 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwGArrMvyDRdHVGWSGqdD5WeRbD71PvJ9NduhlgwNy3B624k7LDZtONuy6Gg+YELhTCW5VbOkEOK2/toA2sZApZIxNFo+PQ6L9trfRsrjaI0P+0NKMxipqWh0Snr5GFA0Vyni9xGXnw7z1x09iYrkKTGy+3yYUKRmoHTiInYWOElezHKSihFdBhaUtPADaGKCERBxX3RdU4q1iETeBpZiZYCO4upur7F4FhwIHGjdvbEQKXb4A8y0sA8L24uaqJWqWSjIRN22XkqpPfGJhRojGkg5IrSG3rJWubfFC/V2bD+sI9+QuC8lZsvKoPJwAcdfco0YXOkwm5sQEdJKpZYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4ieMc43pUACuw3w3rZ3xh8UeF78hdTi+7ed7aebbbI=;
 b=nvJkFFpMDci6BlL17QeuU8Jq5UKmDxpJHR/I6z9HaHdwIgEvlklS26E/CqbVoPSXZpmClxvn/R922CbzDq8jjTkDIZJ6f54BviefNf3xQfu9/ttRawHKLHeSipCMaeCCOxwJRtX9jh5L3iZfRRD41rNhEQAw45CFMoGrc+0NNMswZPFDUwkMDBLOAOg6n7E1LEVk7C/PSobtPgABLice3EPoewCDtCTTqp2A4jRayxcRz3ppizfGXUvDXnWpi8+Rq2MjIeo9GznxXyonQIHTFGDBHdfnfmlZnfpNBlrW20aRvcTJziEH+fejymCCj/SMwyvyQu3OOB1FocGijsWhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4ieMc43pUACuw3w3rZ3xh8UeF78hdTi+7ed7aebbbI=;
 b=hTLNFWDTxqKogYo3vE6tQdTIcuWamLtvQPhpr8o1d7q3mRN8prmxLnmIZLCFeTbhtBm4iyry1POxItnSp3k4dJNWJ1lHq4YMELlDjm7O1a7ndr1UbN/+RGw7AbEHl+Jdtp+1mqnHbz9Q1p+mjL53dZWTDb27+jM0eS5yRHbEoiA=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:09:47 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::28) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Tue, 2 Jan 2024 15:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:09:47 +0000
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
Subject: [PATCH 3/4] acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
Date: Tue, 2 Jan 2024 15:09:32 +0000
Message-ID: <20240102150933.161009-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|BL1PR12MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d2e612-3d56-4166-0b03-08dc0ba4dc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHh6zms3NQ3q2crM1yKq+xhGPmL9h1nJR+Y6vb4mZvctEzf06Mokfqy717YUwZCFivb0cFAZCYPAQ3tuN8HRX6TtW/Fvh7aFELw0+FwZRlNRP52kn3BHE5Usb15ZT2nN1sIB0O4MHWBLRwhq3D5mT4G8y+0OYM6hEcciPh3EN08QDXPEQEdEoi2aSNgGdu/q5RYwfxJv4/ibYUQBhon5s4crLO+h1wXVlihiubIqqZqV+HIQwZFoPP0E0F3+JmiZ6CN7M+7Q100Bp+xU8jxZjol9a6YYLKlHGYilmbtSIrIid8c1DiO7goCAqYlz/TB4/iqIh+toYfjASRAOhWw6gcPosap2s3eZMYjjZBK/WLoEcfadq0wopWDoZO7iv4Fs2a5jX6TCvVLImwNmWFMe8Sqrb88fTtiN1KC7GXdGw3W2XF8i5YvQ8DxXBNPGudKMIzShC1Q5dDElLahH5tfmnk6MFgRpl4cCQgGtRcxQM0FdFPeAdFW9z2uY2MrkoPgTINWnLpma6TlGeyySSoexGfzfTQpEiK4mKCKHyYTXLsr9tNnMbHBi9AXcu+Lp7yJSsIFx1XwyRzpm56lSc+1SFUXrjsE9C8ssX6YNVNrNCFIDTyjEk+zI+c7wgq6diH1rEWOxhMGsx+BFBpW+PgJRA1102VxYqBW5opypm4Br2FhCCrFvheo+azpLc1bMqoxs0No25XjxjVd684FTCBUmoLg3s4649vuMrtYKvNN1DeECVHcQz+6YGTKc4PSfhW3NDMWv5n+m79YuG1DN9HFbYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(70206006)(70586007)(36860700001)(4326008)(110136005)(316002)(8676002)(8936002)(54906003)(2616005)(1076003)(26005)(16526019)(6666004)(83380400001)(478600001)(426003)(47076005)(336012)(7696005)(2906002)(41300700001)(5660300002)(36756003)(82740400003)(81166007)(356005)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:09:47.5654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d2e612-3d56-4166-0b03-08dc0ba4dc37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333

UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.

Add GHES support to detect CXL CPER Protocol record and cache error
severity, device_id, serial number and a pointer to CXL RAS capability
struct in struct cxl_cper_rec_data.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c        | 15 ++++++++++
 drivers/firmware/efi/cper_cxl.c | 52 +++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h       |  6 ++++
 3 files changed, 73 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d6a85fbc0a8b..6471584b2e79 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -714,6 +714,18 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		cper_callback(event_type, &data);
 }
 
+void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
+{
+	struct cxl_cper_rec_data data;
+
+	memset(&data, 0, sizeof(data));
+
+	if (cxl_cper_handle_prot_err_info(gdata, &data))
+		return;
+
+	data.severity = gdata->error_severity;
+}
+
 int cxl_cper_register_callback(cxl_cper_callback callback)
 {
 	guard(rwsem_write)(&cxl_cper_rw_sem);
@@ -768,6 +780,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev);
 		}
+		else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			cxl_cper_handle_prot_err(gdata);
+		}
 		else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 4fd8d783993e..3bc0b9f28c9e 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <acpi/ghes.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -176,3 +177,54 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_rec_data *data)
+{
+	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+	struct cper_cxl_event_devid *device_id = &data->rec.hdr.device_id;
+	struct cper_cxl_event_sn *dev_serial_num =  &data->rec.hdr.dev_serial_num;
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
+	/*
+	 * The device serial number is only valid for CXL 1.1 device, CXL
+	 * 2.0 device, CXL 2.0 Logical device, or CXL 2.0 Fabric Manager
+	 * Managed Logical Device.
+	 */
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
+	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
+		pr_warn(FW_WARN "No valid serial number present\n");
+
+	dev_serial_num->lower_dw = prot_err->dev_serial_num.lower_dw;
+	dev_serial_num->upper_dw = prot_err->dev_serial_num.upper_dw;
+
+	data->cxl_ras = (struct cxl_ras_capability_regs *)((long)prot_err + size);
+
+	return 0;
+}
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 90d8390a73cb..7ba2dfd6619e 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -154,11 +154,17 @@ struct cxl_ras_capability_regs {
 
 struct cxl_cper_rec_data {
 	struct cxl_cper_event_rec rec;
+	struct cxl_ras_capability_regs *cxl_ras;
+	int severity;
 };
 
 typedef void (*cxl_cper_callback)(enum cxl_event_type type,
 				  struct cxl_cper_rec_data *data);
 
+struct acpi_hest_generic_data;
+int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
+				  struct cxl_cper_rec_data *data);
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_callback(cxl_cper_callback callback);
 int cxl_cper_unregister_callback(cxl_cper_callback callback);
-- 
2.17.1


