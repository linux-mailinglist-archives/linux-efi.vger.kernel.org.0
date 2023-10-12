Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19E57C7A32
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443119AbjJLXEf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 19:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443025AbjJLXEQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 19:04:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF90171B;
        Thu, 12 Oct 2023 16:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTgerzICCs93yO1IYEkVm9CQfyE+zrEVq/jK811n1M4Q4BuZDoHoyhINN3xpjjzTSnjxSi1bzzyBWmTcz+HxOaC6GuUVFdjlSdzIn9pGN/XpO8EYOlf2Bhq7obqzjVfqaL5BWkN5Y33oqX5coVlIdhZTptP5wiRRAYCGAI88dFmQjuHyDgYlb6SfRrmQOUVeshnv9poucgO0HkdH/OZFepD0KodRZqLA61gCBK+AXMq/60sP8WVPhsyTFxO7oNQ9P/J6ECnjUj2Jhr8qwCmtJ4A4KodSwODHtxqg8jO4ez8DsvAfwcRnPXJOx5ob1bhl50KhUNW4Al5l2t4kqfyZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GHDMaRekfkY5tn+h3X1v2GJ834yQWjhhkO9TDmiY9Q=;
 b=ft4vnNBKF/Zo6ZBPLyfel0Tq+CtNW7slFgWV64VRmegYq8m14OK/R4HM38wcnzgx3cmGyIZho0Ap82GH9TRp2bSi6klTqRxbj0G6pA+s3I16pQJZ8LedAWrhMkl+SKrMAxgPwszgj22uPoNkF2HuoG+1oH2/wu/7UawjWr6LaPN0Tz6WbOhMcxEsAK4zWkG2oCK7asERVK01adhWbdP9h9MwnoKo65xxzujeOCsVKGlJluxd+Jsf4NH+jLkaS9KjXCPuuWB62Q+lTV/EcR2LTvHGJiQd2yrfyllL/ejq7gBpPIm/bAJx2R6l+pi13/fZkELkrCg+sd6PrVycaylrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GHDMaRekfkY5tn+h3X1v2GJ834yQWjhhkO9TDmiY9Q=;
 b=LQ0Jp9g2MMJmcY0mywq93JHwA/u/i9ExCgluqFYW0gTEMwzkhPhnUsLlog1jH0yw08PAviIT656pRqvzGHMdsOMtxVWscwsZDhre4if3S3foxtitHwk0XAQ+YMVR0zydt3FUvluNYB9L1Cq+KQYv1d16XK6M5Ko2AZdhs94PSg0=
Received: from DS7PR03CA0200.namprd03.prod.outlook.com (2603:10b6:5:3b6::25)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 23:03:43 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::90) by DS7PR03CA0200.outlook.office365.com
 (2603:10b6:5:3b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 23:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:03:43 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 18:03:41 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 3/3] efi/cper, cxl: Decode CXL Component Events Memory Module Event Record
Date:   Thu, 12 Oct 2023 23:03:01 +0000
Message-ID: <20231012230301.58500-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM4PR12MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: c98d8329-53d3-4e54-d13b-08dbcb777b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyodAyKVBbZWthb1sU0DSN2957D+9jS4Y+A3Vqv9TitK5po/Zv7SwANRv7doen+Z6KsS8W5ab2CiZNvop6jGF3CjASRktl5vCjLL2IJ52hZ899QIEB9nmUKz+AZhBmfGj6H2IlnlvEOhcxvAUTQtZ37Pw0HLFBGG/5VwRDpIV6yd1/PoL4ftFTAamBM58OV9eC4agIaB1P62Di5nXlhTzkrm7v6vHWZkyjfLfrxUc6gPJRC6ymSQXZDKmSz3uUo01J5nWpLph5EPPZ4cGpSc/D73IrbLawV/0p/LnJ9mARvtcVr5zAlkd93LoAddOP3FhP7kbyWe/DCUjqZW1QIEyiQLheMIWM3DV0yQzGSXi4z/3meiL3ADQ8IX8y4TTNRznOttm7XGmFe8+LG6uucBLfjTixkWA0gX1Ynq1xUx+wWn0oOaX8mJkx6tWu3GMxt2vHWvaVaXo6CQtrMUiHLm2tjg18y5PP41Tl9dRyC1U6Ra4nwSrYKH8JdKruoMSTcEpfNkA7xuZ+wB/kBXsRqj8MCGcE5ZACpBGhh98mbKde4sDDBLYGDYrsUjoyBIvV//03Xe7g2pJ6eetdHP8algBFjgVxkntRvtGSngIOMFpXUeNGeLmSRCPfNHpJnTRLBwKW6efloyrOTFCHDldLrwVL/IjjP94ZF+jA0JB7uXkPBLOu6+oDyI52v3D9uxiLIVAGSPfEY8/1rxRGoY66ISLPG0d5gyww+lZWCvzsv4zps6dBTaiu0uAqj35bedwiBhbBrZknVSXEeSbygP1rSsoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(2906002)(40460700003)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(40480700001)(70586007)(54906003)(70206006)(110136005)(316002)(7696005)(36756003)(83380400001)(47076005)(16526019)(26005)(82740400003)(336012)(426003)(36860700001)(81166007)(2616005)(86362001)(1076003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:03:43.0569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98d8329-53d3-4e54-d13b-08dbcb777b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for decoding CXL Component Events Memory Module Event Record
as defined in CXL rev 3.0 section 8.2.9.2.1.3.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper.c     |   8 +++
 drivers/firmware/efi/cper_cxl.c | 110 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h |  32 ++++++++++
 3 files changed, 150 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 1d182487fa13..5b45bf513512 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -623,6 +623,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_dram(newpfx, dram);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_MM_MODULE)) {
+		struct cper_sec_comp_event *mm_module = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: CXL Memory Module Event\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*mm_module))
+			cper_print_mm_module(newpfx, mm_module);
+		else
+			goto err_section_too_small;
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 3fba360b7dc6..5be10ca20c7c 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -39,6 +39,11 @@
 #define DRAM_VALID_COLUMN			BIT_ULL(6)
 #define DRAM_VALID_CORRECTION_MASK		BIT_ULL(7)
 
+#define DHI_AS_LIFE_USED(as)			(as & GENMASK(1, 0))
+#define DHI_AS_DEV_TEMP(as)			(((as) & GENMASK(3, 2)) >> 2)
+#define DHI_AS_COR_VOL_ERR_CNT(as)		(((as) & GENMASK(4, 4)) >> 4)
+#define DHI_AS_COR_PER_ERR_CNT(as)		(((as) & GENMASK(5, 5)) >> 5)
+
 /* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
 struct cxl_ras_capability_regs {
 	u32 uncor_status;
@@ -119,6 +124,45 @@ static const char * const dram_mem_type_strs[] = {
 	"data path error",
 };
 
+static const char * const mm_module_event_type_strs[] = {
+	"health status change",
+	"media status change",
+	"life used change",
+	"temperature change",
+	"data path error",
+	"lsa error",
+};
+
+static const char * const dhi_health_status_strs[] = {
+	"maintenance needed",
+	"performance degraded",
+	"hardware replacement needed",
+};
+
+static const char * const dhi_media_status_strs[] = {
+	"normal",
+	"not ready",
+	"write persistency lost",
+	"all data lost",
+	"write persistency loss in the event of power loss",
+	"write persistency loss in event of shutdown",
+	"write persistency loss imminent",
+	"all data loss in the event of power loss",
+	"all data loss in the event of shutdown",
+	"all data loss imminent",
+};
+
+static const char * const dhi_two_bit_status_strs[] = {
+	"normal",
+	"warning",
+	"critical",
+};
+
+static const char * const dhi_one_bit_status_strs[] = {
+	"normal",
+	"warning",
+};
+
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
@@ -409,3 +453,69 @@ void cper_print_dram(const char *pfx, const struct cper_sec_comp_event *event)
 			       dram->cor_mask, sizeof(dram->cor_mask), 0);
 	}
 }
+
+static void cper_print_mm_module_dhi(const char *pfx, const struct dev_health_info *dhi)
+{
+	pr_info("%s health status: 0x%02x\n", pfx, dhi->health_status);
+	cper_print_bits(pfx, dhi->health_status, dhi_health_status_strs,
+			ARRAY_SIZE(dhi_health_status_strs));
+
+	pr_info("%s media status: %d, %s\n", pfx, dhi->media_status,
+		dhi->media_status < ARRAY_SIZE(dhi_media_status_strs)
+		? dhi_media_status_strs[dhi->media_status] : "unknown");
+
+	pr_info("%s current life used: %ld, %s\n", pfx,
+		DHI_AS_LIFE_USED(dhi->add_status),
+		DHI_AS_LIFE_USED(dhi->add_status) < ARRAY_SIZE(dhi_two_bit_status_strs)
+		? dhi_two_bit_status_strs[DHI_AS_LIFE_USED(dhi->add_status)]
+		: "unknown");
+
+	pr_info("%s current device temperature: %ld, %s\n", pfx,
+		DHI_AS_DEV_TEMP(dhi->add_status),
+		DHI_AS_DEV_TEMP(dhi->add_status) < ARRAY_SIZE(dhi_two_bit_status_strs)
+		? dhi_two_bit_status_strs[DHI_AS_DEV_TEMP(dhi->add_status)]
+		: "unknown");
+
+	pr_info("%s current corrected volatile err count: %ld, %s\n", pfx,
+		DHI_AS_COR_VOL_ERR_CNT(dhi->add_status),
+		DHI_AS_COR_VOL_ERR_CNT(dhi->add_status) < ARRAY_SIZE(dhi_one_bit_status_strs)
+		? dhi_one_bit_status_strs[DHI_AS_COR_VOL_ERR_CNT(dhi->add_status)]
+		: "unknown");
+
+	pr_info("%s current corrected persistent err count: %ld, %s\n", pfx,
+		DHI_AS_COR_PER_ERR_CNT(dhi->add_status),
+		DHI_AS_COR_PER_ERR_CNT(dhi->add_status) < ARRAY_SIZE(dhi_one_bit_status_strs)
+		? dhi_one_bit_status_strs[DHI_AS_COR_PER_ERR_CNT(dhi->add_status)]
+		: "unknown");
+
+	pr_info("%s life used percent: 0x%02x\n", pfx, dhi->life_used);
+	pr_info("%s device temperature degree celsius: 0x%04x\n", pfx,
+		dhi->device_temp);
+	pr_info("%s dirty shutdown count: 0x%08x\n", pfx,
+		dhi->dirty_shutdown_cnt);
+	pr_info("%s total corrected volatile error count: 0x%08x\n", pfx,
+		dhi->cor_vol_err_cnt);
+	pr_info("%s total corrected persistent error count: 0x%08x\n", pfx,
+		dhi->cor_per_err_cnt);
+}
+
+void cper_print_mm_module(const char *pfx, const struct cper_sec_comp_event *event)
+{
+	struct cper_sec_mm_module *mm_module;
+
+	cper_print_comp_event(pfx, event);
+
+	if (!(event->valid_bits & COMP_EVENT_VALID_EVENT_LOG))
+		return;
+
+	mm_module = (struct cper_sec_mm_module *)(event + 1);
+
+	cper_print_event_record(pfx, &mm_module->record);
+
+	pr_info("%s device event type: %d, %s\n", pfx, mm_module->event_type,
+		mm_module->event_type < ARRAY_SIZE(mm_module_event_type_strs)
+		? mm_module_event_type_strs[mm_module->event_type]
+		: "unknown");
+
+	cper_print_mm_module_dhi(pfx, &mm_module->dhi);
+}
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 967847b571cb..c37dd624a522 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -25,6 +25,11 @@
 	GUID_INIT(0x601DCBB3, 0x9C06, 0x4EAB, 0xB8, 0xAF, 0x4E, 0x9B,	\
 		  0xFB, 0x5C, 0x96, 0x24)
 
+/* CXL Memory Module Event Section */
+#define CPER_SEC_CXL_MM_MODULE						\
+	GUID_INIT(0xFE927475, 0xDD59, 0x4339, 0xA5, 0x86, 0x79, 0xBA,	\
+		  0xB1, 0x13, 0xB7, 0x74)
+
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
@@ -147,10 +152,37 @@ struct cper_sec_dram {
 	u8 reserved[23];
 };
 
+/*
+ * CXL Memory Module Event
+ * Device Health Information - DHI
+ * CXL rev 3.0 sec 8.2.9.8.3.1; Table 8-100
+ */
+struct dev_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 add_status;
+	u8 life_used;
+	u16 device_temp;
+	u32 dirty_shutdown_cnt;
+	u32 cor_vol_err_cnt;
+	u32 cor_per_err_cnt;
+};
+
+/* CXL Memory Module Event Record
+ * CXL rev 3.0 sec 8.2.9.2.1.3; Table 8-45
+ */
+struct cper_sec_mm_module {
+	struct common_event_record record;
+	u8 event_type;
+	struct dev_health_info dhi;
+	u8 reserved[61];
+};
+
 #pragma pack()
 
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
 void cper_print_gen_media(const char *pfx, const struct cper_sec_comp_event *event);
 void cper_print_dram(const char *pfx, const struct cper_sec_comp_event *event);
+void cper_print_mm_module(const char *pfx, const struct cper_sec_comp_event *event);
 
 #endif //__CPER_CXL_
-- 
2.17.1

