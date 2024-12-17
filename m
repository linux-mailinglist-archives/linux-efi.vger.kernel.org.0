Return-Path: <linux-efi+bounces-2386-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99E9F40AF
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 03:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92741169791
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833014659D;
	Tue, 17 Dec 2024 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXRUUbLO"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F489F9FE;
	Tue, 17 Dec 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402177; cv=fail; b=XpnK7N8eabl12bgo0daMWMKdMkMfTdKujhltBxdH0SQxLFHHdUYNsZw+WlYR/X3Hv7pWmeK8OIZpwbY/XzY/HdByV06ffMfjzu6FS2gSJINFZEjPu/V1+jfijydVfrCb4DHGO6LfroM1ZjydOR0S7mz+ll9mH76qLK9r8ZZUcX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402177; c=relaxed/simple;
	bh=AwUFEUmowzR8btkjwtDvhAbzi4w4sBwwWsXOOgZTiWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGPMaSP+fc/JYpykUcORHMkkgnmWX1dBIC6DNgvd8qOXNugS44O78flQzVyNiPqVukHPeOa6mr8YCG7SsW1e+HCTUyEe4iviO1+io9VKMDUYC95dTUITYjwixqKpPytFFRDl5LQe61sdnSwz9nirMaSDcooO+HNSmO/NhxL2M7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXRUUbLO; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRhpnpnflAlFuKeVoEBr249qtggrwOXrh49Wu2ixl4+e0nWY7lvTe/G43aUeKCExDrDJW7cLvG4kqmeH39BlLV4Wlt3eNTP/lGsXtyVzWMYLZwMjREd4MTZxtBpHH/LsKNregLY6PzhqEfe7SkWY0u36qG2lg/iqUqo7kvSMSHyeUpG9nvaxVVTJ/YWT7QwEn0Ch18gKXnWHBVNCSw8Cd/O6k6YhSDQgWi21NfdA4I8HrzCi+62hHU0y+YOqG8R6PEj4j1KxfIqaB/oRQMoKD+k48VXZGo83DCkmKkumJ1onIBjpNczXu5kr5vLSIItxQk8uUITDBiFlz7+BRrUmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhY/HUqghD0SefTIHTCXeks6zY/k46pDWh4sPMj61oA=;
 b=ojEHqJGRoEgBVqCEj6ymMN4GKQuudBep7hn/tdit5NHRJoWkV4PaxcjTpVDL63pOOBZIEXX1CDq3tZXddsfmOjDKDVl0YKSRM0t8xtS3UFlQUdPcW0QL7orv1LhMeiD5wR59WWenjdxrCemAlyp9t/LUlmUdobDyKQkXLzjsurOJjuMwI+b83g7QpHzGLcrO2ytlKR2lX3vtb5BCksqb7Y/Qq5IsX0aFzwaC6E4ZzPfdhLqiWPLULS5JsawTziS0KbHphOWEXlXUaa5WlvG0+1mzvcXkri5UCUzXnwcq07Rz/P1ok1sd3sT7p0qVypHZyMJ+RVKPkwpm888yfm4SFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhY/HUqghD0SefTIHTCXeks6zY/k46pDWh4sPMj61oA=;
 b=JXRUUbLOS+D5xdpSzwzNI54WkmSxsHdLmWODUeEfxE7lYm66BzO8sxXSx2Tl3ppSdwlG3Kp+7/3K+jMuTODOmIGvrb0OVLrk5k4Nb4M9smiR+Zvz2tFJCEANMW4b0DNXaQG/rAdBAUCWhQQY9SmYXN7mP9+2ZvzRLba4GSt5Nl8=
Received: from BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) by
 DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 02:22:53 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a02:80:cafe::5e) by BYAPR01CA0034.outlook.office365.com
 (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Tue,
 17 Dec 2024 02:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 17 Dec 2024 02:22:52 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 20:22:09 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 4/5] acpi/ghes, cper: Recognize and cache CXL Protocol errors
Date: Tue, 17 Dec 2024 02:20:31 +0000
Message-ID: <20241217022032.87298-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c86eeac-bd49-48d0-9e7c-08dd1e41b5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?51I+/NIE0xa6Xnao3pTEEtbqslbCohwre2VZVrsf3i77dqDZEXZn+RE6o5ni?=
 =?us-ascii?Q?XC3dDHufUt0gwlairJQzr4UmsFuEGW2w40hzFzmqtTIn3wIBq8wrNybBNY2h?=
 =?us-ascii?Q?IiIhlTfrCWf/hH9h0kMhjHLU2zk0JP/qByjOGXeZm2eZXGtEeWPl6ap6HeWI?=
 =?us-ascii?Q?IQzSQvbjacSMqYiHvWjpYP/IsWYV0AFPAGIz/iT/5jUGTBjEm9tIu4cd5bMJ?=
 =?us-ascii?Q?xZ2voxGekMGoVIP5Eg0bliRBzn64htuiUim1WRv2svAXUS8W4MIFGUpOoerF?=
 =?us-ascii?Q?o0CuccyPsTDVkxfSUrb40zPouIQ2gvjl3XVPBOukaFfUPRugDFN4m7i1vYWy?=
 =?us-ascii?Q?dpcljlzy/sa32uakwlPygBDUBvk9VeqT+CbhTFeNc7Ni/eZCtzdI8V0evNuN?=
 =?us-ascii?Q?d/vdV4cBPkrHUOhIkz80j5v9AkZxRk+Jrk+Ratj07wvJ/eQlYtp/f9nb5Zs3?=
 =?us-ascii?Q?YMkmAebDO3WVYpOrbLig0E4BV+zz2GhlPFHa7oZTz3yfYIsAQLGDTBcJc13V?=
 =?us-ascii?Q?J9GVom/4S9wcWFnk1c5x/qy0KpObDI1BWg06vWNRiPNfVbpIublQDVORacet?=
 =?us-ascii?Q?7uTLMjOACsxmk2rbZF0pgTBR2s7xp7ITZQmJhSYYoFaQGzpd71kNiy7RG1Gs?=
 =?us-ascii?Q?0Gpi9J8CpVgrh9LyNhI/ROWa9hnDQow0JVcjn/5yXjxoO55FfKw82tzy3jYH?=
 =?us-ascii?Q?h/JhxWxFZewgsC+EPva+I3P3p9ER54rGfXFqd8omvyznYKIpnKNOePoZx8sP?=
 =?us-ascii?Q?e/fRq9KrC1atNQiQQB3SOUnf/X9LKhBe3rRhDcKt0JhEtPTqbO+n93caJUOP?=
 =?us-ascii?Q?a1C+8Izkps7ef5uE+4FdFBL5XjIYuP++TQKfc56eN39/DnARbFxvVwnd3Tr0?=
 =?us-ascii?Q?6/67pBjK23Vq2Z/K0GQS/Sfq7kLpJBrxzzOsaQFKxavzoh8iPryx/ejzGOxn?=
 =?us-ascii?Q?cWJCuIz98Y1/hDkW8H7L8+hQvBjjhIjnn+fcAF8MX6WKD8YetWFdoIwYfRTw?=
 =?us-ascii?Q?dsxW6gTM/RXdbGmP1C2nQor4nKDRGP3pGrXoWLSl5B1Ts9tdXwsvAHmPix87?=
 =?us-ascii?Q?AtMw2DWAaRXotKX1nKL00b5bWaQQ74NI3UKJhYqlipjRZXC1kNR92vVP8CRA?=
 =?us-ascii?Q?tBWtDVUGODz/Jd2+qmyY9GoUWRiif/iVGincDw7SSKapkcKp+r5zx8GQqer+?=
 =?us-ascii?Q?+THPFtmDINs2lFD7hP5Do4UtgZ40X1x43dzLJxfijf/M2fMd5SYCoKWbKiil?=
 =?us-ascii?Q?XKtuW8/hEWgcf69xzBYO+4GsIvc9vdoYh7v5uSdAsYk55uIyFl2HYL5Rm5I5?=
 =?us-ascii?Q?iJitJxtC/86iJI+D72Jvq4SQXMIq0d+VDh6GwOElLYsETVpPdne2kK3jt4gQ?=
 =?us-ascii?Q?iv9yUnf78Gvry45htxbyNI0n83oFvcAbKU/pLyWv/1QYb9eZTRPur6e+LjXC?=
 =?us-ascii?Q?aoSnppa/Or1GETpLyVq4lFYq+9dKfUj7cov+thCezEl7TpqvQ+vYgBeMtdlR?=
 =?us-ascii?Q?J7yAsH2hmiWV0JA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 02:22:52.6800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c86eeac-bd49-48d0-9e7c-08dd1e41b5cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

Add support in GHES to detect and process CXL CPER Protocol errors, as
defined in UEFI v2.10, section N.2.13.

Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
information, including RAS capabilities and severity, for further
handling.

These cached CXL CPER records will later be processed by workqueues
within the CXL subsystem.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c | 52 ++++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h      |  6 +++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ada93cfde9ba..63afef58b3b7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -676,6 +676,54 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				   int severity)
+{
+	struct cxl_cper_prot_err_work_data wd;
+	u8 *dvsec_start, *cap_start;
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
+		pr_err_ratelimited("CXL CPER invalid agent type\n");
+		return;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
+		return;
+	}
+
+	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
+		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
+				   prot_err->err_len);
+		return;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn(FW_WARN "CXL CPER no device serial number\n");
+
+	switch (prot_err->agent_type) {
+	case RCD:
+	case DEVICE:
+	case LD:
+	case FMLD:
+	case RP:
+	case DSP:
+	case USP:
+		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
+
+		dvsec_start = (u8 *)(prot_err + 1);
+		cap_start = dvsec_start + prot_err->dvsec_len;
+
+		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
+		wd.severity = cper_severity_to_aer(severity);
+		break;
+	default:
+		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
+				   prot_err->agent_type);
+		return;
+	}
+}
+
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
@@ -779,6 +827,10 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 66d85fc87701..ee1c3dec62fa 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -232,6 +232,12 @@ struct cxl_ras_capability_regs {
 	u32 header_log[16];
 };
 
+struct cxl_cper_prot_err_work_data {
+	struct cxl_cper_sec_prot_err prot_err;
+	struct cxl_ras_capability_regs ras_cap;
+	int severity;
+};
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
-- 
2.17.1


