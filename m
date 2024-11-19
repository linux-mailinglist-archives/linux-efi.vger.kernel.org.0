Return-Path: <linux-efi+bounces-2179-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2F9D1CAC
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D53F1F220D4
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4813A24D;
	Tue, 19 Nov 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OefkgQVo"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C4137750;
	Tue, 19 Nov 2024 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976780; cv=fail; b=ZUh+8qIKuN7nNCuJ8WshMqHz1gcJIawykE7XxHfoz74kc2rLw8aHgYQICtwDz5c1Him+v/RDeq3nP91BZerkvoS06hO8KVY3GbxSg/EvveajSm8cAGijtXh420g9XTsZOKRoK11fqp3ir8ORkN1ogdNjqgE3hU6Miv4KMxkQL7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976780; c=relaxed/simple;
	bh=eI2RxorsISW2gvo0IHk8IE5HzKi9kPQYotwHNSH/0CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkp20ituNYUUTSfoYo1swe1i69oEOrRgK/pVSLJH7az5OTmp8d2hGwdW4D+0Uin8cl5H9pkDfYoozdPLtaqQ3DPfqb3qc3O7VodEBIJBWSNpsjFZ7wxyqz7SKtqJIeuhVHVCsQK5ZB3/lt6rPYzUAGL9bu6lBVYw142RppZs2bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OefkgQVo; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGaY9xdUf9In0mM+anBHvItyVuqBamU5YaXUTcMfp3dbMzD3Umb7JkfU5pNLY0hgn38sEt2kiWRoaPidKeKJkRJib6BSyKREkYiJ9e5QlByESCxH2xbY7r4i1sEOm3E77gIiIMcZsUe6VcK3tF3yR/sfjyqKvYJ746390flSG6ZSoK6RospLfXLiY3h+URqOim23BXrTvu9WSe3W/RYRAqCxhlCXTVMYh4Qg739pT+nPAT8bvoeJtUzIuMoEd3KfBVu6mJsjCv9YowgXQGIO7NsqUjdUv1ADZp0V6wVk5YBa0dkrasVaY77OQpVkLWQM5jd2DEl4rvkrGTg8oEUfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R59fQdZTGIEMq/jvL0lLNzgH4fY3E1rfQySjzSVj9K8=;
 b=JoUxm8MDt6OZFG/fi8tTew9iYyrgallntSoCHjhoqOUdpgg45jJoyaOxYGTRBkdqFXZLEWcoZYN8igJIQ6w78QdqsaGTGURLZbV2hvjVaMiyCmuiDvNDSdcV+Pkj/K1+aW3DPgSCvx6oScAsnc+XS5+XVg8aDPReVTQ1wxBOKLutytJvcC8zeub9bPljjmqBY7rpbmC8oe4+wmPA78EFH0s5B5QVfTRiEHh4ie0YCGT7EXXnfox+3x07l/aoUEtY6w+o/Avj7KIY6dPyl2gGhGfCBaB10rhC9MTDa4qBkfhFIFc1AFOx7nJ4/keKta2yiM3zLttjM3OJbskqkRYl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R59fQdZTGIEMq/jvL0lLNzgH4fY3E1rfQySjzSVj9K8=;
 b=OefkgQVomG+QAluvUnjoQqdBvvVDnwVkc4TpTTP/cy3aa7pPPq6OWFqyYZDJBhfUURF6VsI2sSbDVC0QmTZPgLCK6BSzr3d7gYfDY6EWTtayvBJVBVE7wp1t5CgtVSuwcCGl2ds9Q0E+KUVfCKCcsZuulGaUM0tXxsK4liOa7k8=
Received: from DM6PR10CA0003.namprd10.prod.outlook.com (2603:10b6:5:60::16) by
 SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 00:39:33 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::34) by DM6PR10CA0003.outlook.office365.com
 (2603:10b6:5:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:30 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:27 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 6/7] acpi/ghes, cper: Recognize and cache CXL Protocol errors
Date: Tue, 19 Nov 2024 00:39:14 +0000
Message-ID: <20241119003915.174386-7-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 4501131e-541e-4fe5-4da3-08dd0832a189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIUimBHukhIAQ6QLGzlKSxNPcwMTjhQ9tnRY5k0Z+w2RS5cxYVHVsLToP17h?=
 =?us-ascii?Q?/3GtqduYOoaTZmnTrhymESVBnO0KTJnog1FfRhKzlVYawmmQvkCGR7tgePBl?=
 =?us-ascii?Q?rRZQEl2ZqiCxfzP8AjbdczV8ZdDIOEY2D4VJk30/zTQuwsciZlFuO0RQtIMv?=
 =?us-ascii?Q?xAG6uFdb2LrWBf4nLioDCMI8+/bowfLdO/vbdRR+S9AiqiVJqvS9siuGQ4S5?=
 =?us-ascii?Q?GJ1xFkOnPtBe2QWdHlfzJqqlo+Xxiqc/iMhVGW4f1IlSr6+Mqws8qHa+jMB3?=
 =?us-ascii?Q?1rPqw8aqIB971MrbiaIkuYFdHC68H8n9s2msEArjlYwkhKPzLw7Qwt+pBcc1?=
 =?us-ascii?Q?hLOKICoPWirVH8asYAqKclQOLlT6GOmg20vQqJ0DuBTVIS+tizB1HRYYMqVq?=
 =?us-ascii?Q?lqj3/cVm6VEH9ItnNF+usqr/hznSpMu/24Bq6zaFGgIkvHOBOimYlDgUwvW5?=
 =?us-ascii?Q?u/vagKpXN+zVQ7JqwsJv9wPbUMW2aNWHxa8aFX+95ouJiEsOaET9IExMPuBS?=
 =?us-ascii?Q?DU9yMJmhCbjAvTqlpGoYBy7xu8braIxAha2GCGkkdwuE/g7leYyQvQRz30j0?=
 =?us-ascii?Q?6PQT5Aj9d1xJAbeO8Qevg5H1n8sXLqz1JfQFuBVrQjQ9pyOmhFatBZ7+IHs0?=
 =?us-ascii?Q?ZPvvExabnLhEQp7kgyZDa8WhyK1zIG+4okwJkG8jQ94t71hWjlgDlooHOSL5?=
 =?us-ascii?Q?yA7O0ZB43q0xiTWWeGW3o7lSkdF9EtOZwbOYHl7CypunjQAOUj2MW/vEsH4e?=
 =?us-ascii?Q?9zEh8RbYMYNgtnwVyTHfACVBYg6cURJojBgV11lEydYnqzzgi1UUn/6wVPEe?=
 =?us-ascii?Q?UZH/eOJ4Q7vTeSw1CNLQ3Wx52VutGa782T6PiAR3VrW3i7HQs0Baih+zMUDr?=
 =?us-ascii?Q?x23Ax1R5T5RPd/fsYPYNPlDeIjncOE1baOxAXxUdRCTuHZh5eBSaQXIHJ+CS?=
 =?us-ascii?Q?Do77+WNFLubjztCfW2TxzU0Tf1gBp2OA3Hlcn18f3xhv3OQAzJH/Fl+5/Vty?=
 =?us-ascii?Q?P2ZwZtjk5m3+zWvZNZR2OTYynvuJZTtVt46z/pfjBgijUnKlSdNf6d06F0By?=
 =?us-ascii?Q?1rdpdgHrMOzuYnWIuOlVFxtJo4+sNTTnAm2/AceQGh9T4+WFHM3uqru25FA4?=
 =?us-ascii?Q?j9LffaVVV9J+9842NXuJkaFHNx028uaMjpUXUza7cQvZCDuS30mCtraP5PnK?=
 =?us-ascii?Q?dRgVdObZSoeJR1yIwA6p6BHHZ6v8hlDsTKhetExOW3ePiiKxCo+XgqW3XY7I?=
 =?us-ascii?Q?FnYVrzZUjSNsvUuFicUzIrd9aoERg6HTVehcg0pQupFQ0///HQKA5sr3a0hT?=
 =?us-ascii?Q?NGT/9IZ3XQYxJSO2cbX1VU9HYjsJySaKBAa1bd/iaEiAubi3fBWqr+Z3iSh+?=
 =?us-ascii?Q?V/9bI5qYp0XjuCVEepXn6hiLT39IrC0Ed88JwvmUnjTYbpt6Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:30.6901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4501131e-541e-4fe5-4da3-08dd0832a189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652

Add support in GHES to detect and process CXL CPER Protocol errors, as
defined in UEFI v2.10, section N.2.13.

Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
information, including RAS capabilities and severity, for further
handling.

These cached CXL CPER records will later be processed by workqueues
within the CXL subsystem.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c | 52 ++++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h      |  6 +++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 62ffe6eb5503..6cd9d5375d7c 100644
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
+		wd.ras_cap = *(struct cxl_ras_capability_regs *)cap_start;
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
@@ -795,6 +843,10 @@ static bool ghes_do_proc(struct ghes *ghes,
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
index 992568b35455..c9a38ebaf207 100644
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
 int cxl_cper_register_event_work(struct work_struct *work);
 int cxl_cper_unregister_event_work(struct work_struct *work);
-- 
2.17.1


