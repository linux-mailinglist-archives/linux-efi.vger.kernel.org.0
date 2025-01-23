Return-Path: <linux-efi+bounces-2719-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15038A1A023
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D390B188F4E4
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AB20CCC5;
	Thu, 23 Jan 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wbmqThpY"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DB20C47E;
	Thu, 23 Jan 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621884; cv=fail; b=ikBYiwF3UgCjhq/FGYQ77h0r5V06+C1ai5DF8PMbklwU8n2yDijueJ3Gid7f7k8wygezzzPtI0goyNqk1fIwrgooVhgprN0Rgy1gjS47/a2mogRe8DLN2zY8FBLdfYnQawu2RvmtjDNmDb4+HFQNTUSFXYW1uZ5+e37z+tuAGRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621884; c=relaxed/simple;
	bh=o/cfLS0LzY97UQA1bDoPwyPOCutGIVQXH6VTybP3K3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxxtuCTHNe92Dkb0Cd+fuqYbTxG+fM8uSFnYmG6T+Lmdav/hsrmK2wpuRXfZGOllFX6MLBzp1Y9kPxcrfDtPH7EZq5Ug3BhDpTLP3oR9vVsS12R9gy/7mUjUcJNTgAYQhXgSR6gCoHw4BT8fB86reCoE6I6TRGsh9xHwhO+mmow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wbmqThpY; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahB3qy9+mZZIVAoRkQwYyuK94p/z+4DtcFolADyTBl9WKkPkK7K76c3A6c59NrZaitNI+/OxDbEocXzr/PO8Bw9gu0pGYkGL9ePD7X6/UDhZhgqQiyFhOlZIjY+C/JGS6M7GnXAAk6UTI/5RXCyWWyt0vEwUKDACwN/6q5PqZH5a1XEXqMKmB43/Uur21gSRlvhhiSMELdS8hCjwx/e0aLR7tumsdtXcG+p1/ZzbsZl1dM01OFNECO0b+msVmADjvssTRUroqY8wcR2zo1S7zN92vQnnh6FebsmdRPpCVW9hm5B+LK2bLFRluxRVeaSlN8MritLgpB8z7o9W2IPYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Op9a0KynB/zw5oh+MjgW5BPVdnRtQD3w/I0Wb8xFik=;
 b=q8xxmALiSfWQTLXucGDVeegYZKJFuGip7rxCGrkfGT8xUgbQOGfKmL5iF6X0pUc62YFA4qz+0fb6BkRBvu3BDILZQdlAIoUTsrWQpikIdDGK9oYd1E6XXjeZuIaVIjoQEiuj42dlxkFacjRF99QWYwz4moOaKcwpDYmMGSv5p5wyoOBDx11W92C1dlZIwbGNwiFLPyeTyuwWgG2O5zUmBbRh+/l2F4LDpXjg+mK1Gm4SXLT+cwD2N1zM/bu+qH2j7IHwbO1l57dCqKxrFG3hwq+7ZpR8JT9Gs62zSpFHLM7R8rKqTsiLN0j4opgMtjl0x/VBhusSIpHVrJvpMLSA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Op9a0KynB/zw5oh+MjgW5BPVdnRtQD3w/I0Wb8xFik=;
 b=wbmqThpYs1RdQ3urcWLSSi3HqsTxs/vLPwFNM+tO/VHq0ODmW6xiYKNOMVmkJxTk5Dte/dhDumd/WIo+DNvsypTtXQTfR/NqHCi7oul3SG1/k5VFWaVongQHBKKVbn2XVJLrUBvZk/nmAmPkrBq95rwx8eLPQhvFR003axJMDso=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 08:44:40 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::fd) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 08:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:44:39 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 02:44:38 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6 4/6] acpi/ghes, cper: Recognize and cache CXL Protocol errors
Date: Thu, 23 Jan 2025 08:44:19 +0000
Message-ID: <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b76e9c-9ef5-45f1-6203-08dd3b8a2c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6IuH8iaejKBxgyTayWvdIyq2HH/Hq/jIKBnll4hYbaXx3kAl0xjgF1Uwg/rE?=
 =?us-ascii?Q?pwa3yJoPzbfIy0zA1KUNqQEl9YvuZYv/VkOZyBEOdAAJrOd+MDh38RZFl24a?=
 =?us-ascii?Q?VOBC8xh1Br4k1/ZmoTVTSSZsfZE4jGmna3wNOaM4gkBwszjfEPnBCWyAdo+y?=
 =?us-ascii?Q?i589PgVjqxHoucYCmSe8mtdGkcjK5fxZH+TNwncrwOTM4WAOZIatqNX2C3Yt?=
 =?us-ascii?Q?2IbKIbIoJhCypFS0TogCc7cYZwYieorAq1mJLvflpCbjuCSJi89ibIXHNSaM?=
 =?us-ascii?Q?q42aOo390uxEkj2m+DtxgLm8AoMCr9XFKS6xWwSdIufF3fwaiONsC4skKHn+?=
 =?us-ascii?Q?ocEDrnqGfuJNq7mrZe7VYPh/0m1bOQZisjLcIfIpdUJGZPReL11UcdQH8rck?=
 =?us-ascii?Q?VpNIOIz/VohIbyltf7cxqw6S8LEmNipE+1on41Jp50xOD4M5uUg9waaSQb4e?=
 =?us-ascii?Q?KImO860iIdiVZy46+qZmnQBAAN6DqP77U9XV2IhMDnk9hhBvXbqgPVQQ4+3S?=
 =?us-ascii?Q?nkjtHoIg50Zh3VzUc153TPcPoD1pq91MdR2R/vYC4YbcUhQEI7xsffuTDF1r?=
 =?us-ascii?Q?qI6sBrGIuPQNhQVoTXORLgu/nClBsDl25ysIu6Oz1vQvaGSJ5ZYMMPrCW6OJ?=
 =?us-ascii?Q?sHfOfrwBI3X8yri3nvmWCBcUUYM0dOqo6S+IWGvwiJFWyoppRzAx2PrxSezJ?=
 =?us-ascii?Q?klWukL9p8gpgJcbip6GKTBcoagjuicsD0Xd02i7XsdxmS2TNILHnrI8ejKXl?=
 =?us-ascii?Q?OK83p50M4xVrtTim5Km9Jbi88kOm2ttm9+NtY7U/ItwrBhNsDcEujhkKAtr+?=
 =?us-ascii?Q?ttLIP3SE+PhPIgSKy6461namFsW4WT2EonuBqcRhYScAcqJh+MLhgT5Kiqlk?=
 =?us-ascii?Q?cn9kxIzDhYV/bnqVuSLmZrA+j/SWiw/JKYrmF982s+9SXGU62jm2QXc2Tjcf?=
 =?us-ascii?Q?SXFPJBtBfIUn3awUK/cmTxsJh1xz/0lVsNfRYcSOABwwigyx3mlEv7h7ZNFD?=
 =?us-ascii?Q?pTowHHh5kNk1G/RxcT80mZ79eyBaI9kcqw6CKlpRKNBK2mV9lR+sizxSok5z?=
 =?us-ascii?Q?V9J5XMZQhTaluC3hprb+KHG/RWENkI1ibiIk2WjvU8IO5cZyBmxUVHZPE1NS?=
 =?us-ascii?Q?nkHmoY7ezCRb/jN5lo1e+0bqI0Hl30wU5y2B9eMkmh527Cle61buLBZUTTHL?=
 =?us-ascii?Q?Id4n03Soao65FCe2E0Qa/J1gp1TgHON1olYwU21yo4SUepxtKXJp8RO251Oc?=
 =?us-ascii?Q?jsTV+HfnU6d52EOFJkOFADtWxt/8qzhiifghNhRQ11a5eKlnxfDsWxkUTedz?=
 =?us-ascii?Q?f+Iu/a8O8kLNAY+scWudUM9y+lpHj5Shfc/CBCtZALkgY2LUQdF7QeZQqejl?=
 =?us-ascii?Q?uN90Lb1PLAwLO9gxhg4ry3P7cIWZyy+MIuF+MwWD8cfTUOuWiav2DNGBiN2n?=
 =?us-ascii?Q?h9s5ytWd+9Ch+DwP1VdWvYmY4P53HQjQMLMoQOyJpL3GP/GDcVwaNzVptnkI?=
 =?us-ascii?Q?dJT9s5VL0wERGhY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:39.5669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b76e9c-9ef5-45f1-6203-08dd3b8a2c9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

Add support in GHES to detect and process CXL CPER Protocol errors, as
defined in UEFI v2.10, section N.2.13.

Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
information, including RAS capabilities and severity, for further
handling.

These cached CXL CPER records will later be processed by workqueues
within the CXL subsystem.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
 include/cxl/event.h      |  6 +++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b72772494655..4d725d988c43 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -674,6 +674,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				   int severity)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
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
+#endif
+}
+
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
@@ -777,6 +827,10 @@ static bool ghes_do_proc(struct ghes *ghes,
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


