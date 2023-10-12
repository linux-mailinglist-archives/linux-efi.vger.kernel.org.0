Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCD7C7A30
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 01:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443151AbjJLXEb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443145AbjJLXEO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 19:04:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60151170A;
        Thu, 12 Oct 2023 16:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJcC/iR9pCqClblhi7LbB/eAR80kMJtS97nIZMxVPQ8Uyes3pRWo+FDU7e7VK+PUFAI0fNk2xdcDFGA4EIfRCwq2C12NRojonMr+K0+EnFI0alXTOABVwFKLJy1EJJdI1IFVK2w9f41SvrlNGcMjRAhGjmxmQkXBzZ+/D1L27fVzEVPrpT4338bbyhuroQNCY8yK3USI4Rpz7uxMmcWY8KOjtUYLJUUHnUzzZT82yHneqYrNCBNZN26/ODKchg4SrlG687V1RNXgumStj3Nb0b1CjJ/0fZa7inMEVZT8CHuVLc2odmzbXvhATu3fFWbXzDyRSyiUA2HGyQ/aimZ+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1ERuo4skm/jdK4N58q7YPYG4HzE31AGFrq1qdtQv0I=;
 b=Q/r4+kKZeonR9p657bSdoeE+c0Pg/Jq0ELOi97MefIwgFU98N5eGLgnoILj4ZFVByuK6FD5wPFTYfPOtnWUOnn3gCgaCD4EK8kN3dCI8abtD9Sxv7fjzN6M8o6pHLEcSu6Rm7EZxv9ooyj5cGHsDpInh7fKVNULpp1KcNF+t0lYGLoykvzUduLnn7FTqmiidk7Qd6gnViwCG/8u6Jdqm2kQr1kaUO5y9HUrfOm+FAtvrRz5zE+BqfAHBay+mSy2Swjb1WpH1PIeQ7PkBngyYqNBZnMgm8LHUJ+VeSxqyRhaqIyGfdsRh2vwWfuy42iFEod0w28EnJz4bxPXA063SoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ERuo4skm/jdK4N58q7YPYG4HzE31AGFrq1qdtQv0I=;
 b=sX7mZkdPyBWctlul47QQRv7y3lnlnDqTnsSrM09b709dHmTj97F2NEAlyPOOv1KlZLHJdQ9XLNhDeyWCwoK7QA8KJK6g4n650nhDXHk14io4cF21/Fw0RtZorl3d32bw2TMMX51yPtRfSBNmxY4l8yf4qNeZ2JFxACcMxt2XMZk=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 23:03:42 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::40) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 23:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:03:42 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 18:03:15 -0500
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
Subject: [PATCH 2/3] efi/cper, cxl: Decode CXL Component Events DRAM Event Record
Date:   Thu, 12 Oct 2023 23:03:00 +0000
Message-ID: <20231012230301.58500-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 650cde7e-2f6f-4ea0-24f2-08dbcb777ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuh2TLG3doPrF9j/WOI0G3tDEJzOj2Ua44E63dvDVqTB7x0bFYjUWCoSMqBR8V0pNYUUJU4LF/TLveS2E6C55DaCw9g/K1pUw2UXKM3+prWimLTARaNjz6CJmh5seqi8C8MFfXcZu3wqWTMBUwb/oSI+8zBHPVc8TLMZu7i/uX3sp2z0kCMaekve2Ud/0Bch/931KyYossZZPXVliKTzT40VjxGTSpUKT/s9UQfw/EzuUE2J+z4M8mw1F0z+E6dL4ixZ1F2mH6/RKfwsf5rWj/IgDDQG6XKY6Hj5EFjoPX4U4ggZ5Las0LgmfEVLn0B2BzvOOzPL/T92yTHPQZIzhToORQz/Q0XmFmXldcJBhKnfvPHHN95uyoMQzSRL/NBjjvbCwEyIG6+LKop/WLl4FQXNVQNTtOvnT6mge2ichTqWlCdYQWBGzm2NbtFlaOePd/G3wLAJ56EpmbxHTzqoQi/S+tVGBg0C3aDiaLELLPr5dEkhya/DQfVpIjdYbNNCOV4O1oZuAvNTZBdotxm/BKIWL0tDZHlzaUHpsXxl6WRUyx0v5csc++kJ0Y8NGI/ktOuAS+ZgSWbzfTN/PB6MYfqqmMw8TTuXUA3cH38ppvmMOLAq8UtjwLIMa1+YXWWMwBxZiPXTMqbosi8oD4axS2kIcnxa7cB0el0C2IJ1BkCWmHhRUQjDytbf9DuFllWgfoT4r15OzIS4smmLD421GZenbu3sLjS2nLGMpr0QfK3I+kTjJs/IIjPhoKbmrlpR4BgEqdgO+oX4JbNDoQS8Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(7696005)(2616005)(6666004)(41300700001)(2906002)(4326008)(426003)(336012)(26005)(478600001)(16526019)(5660300002)(1076003)(83380400001)(316002)(40460700003)(47076005)(36756003)(36860700001)(40480700001)(54906003)(70206006)(8676002)(110136005)(81166007)(356005)(82740400003)(86362001)(8936002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:03:42.3381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650cde7e-2f6f-4ea0-24f2-08dbcb777ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for decoding CXL Component Events DRAM Event Record
as defined in CXL rev 3.0 section 8.2.9.2.1.2.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper.c     |  8 ++++
 drivers/firmware/efi/cper_cxl.c | 79 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 28 ++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b911b1f574db..1d182487fa13 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -615,6 +615,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_gen_media(newpfx, gmer);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM)) {
+		struct cper_sec_comp_event *dram = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: CXL DRAM Event\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*dram))
+			cper_print_dram(newpfx, dram);
+		else
+			goto err_section_too_small;
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 8f7b88cc574b..3fba360b7dc6 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -30,6 +30,15 @@
 #define GMER_VALID_DEVICE			BIT_ULL(2)
 #define GMER_VALID_COMP_ID			BIT_ULL(3)
 
+#define DRAM_VALID_CHANNEL			BIT_ULL(0)
+#define DRAM_VALID_RANK				BIT_ULL(1)
+#define DRAM_VALID_NIBBLE_MASK			BIT_ULL(2)
+#define DRAM_VALID_BANK_GROUP			BIT_ULL(3)
+#define DRAM_VALID_BANK				BIT_ULL(4)
+#define DRAM_VALID_ROW				BIT_ULL(5)
+#define DRAM_VALID_COLUMN			BIT_ULL(6)
+#define DRAM_VALID_CORRECTION_MASK		BIT_ULL(7)
+
 /* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
 struct cxl_ras_capability_regs {
 	u32 uncor_status;
@@ -103,6 +112,13 @@ static const char * const transaction_type_strs[] = {
 	"internal media management",
 };
 
+static const char * const dram_mem_type_strs[] = {
+	"media ECC error",
+	"scrub media ECC error",
+	"invalid address",
+	"data path error",
+};
+
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
@@ -330,3 +346,66 @@ void cper_print_gen_media(const char *pfx, const struct cper_sec_comp_event *eve
 			       sizeof(gmer->comp_id), 0);
 	}
 }
+
+void cper_print_dram(const char *pfx, const struct cper_sec_comp_event *event)
+{
+	struct cper_sec_dram *dram;
+
+	cper_print_comp_event(pfx, event);
+
+	if (!(event->valid_bits & COMP_EVENT_VALID_EVENT_LOG))
+		return;
+
+	dram = (struct cper_sec_dram *)(event + 1);
+
+	cper_print_event_record(pfx, &dram->record);
+
+	pr_info("%s device physical address: 0x%016llx\n", pfx, dram->dpa);
+	pr_info("%s memory event descriptor: 0x%02x\n", pfx, dram->descriptor);
+	cper_print_bits(pfx, dram->descriptor, mem_evt_descriptor_strs,
+			ARRAY_SIZE(mem_evt_descriptor_strs));
+
+	pr_info("%s memory event type: %d, %s\n", pfx, dram->type,
+		dram->type < ARRAY_SIZE(dram_mem_type_strs)
+		? dram_mem_type_strs[dram->type] : "unknown");
+
+	pr_info("%s transaction type: %d, %s\n", pfx, dram->transaction_type,
+		dram->transaction_type < ARRAY_SIZE(transaction_type_strs)
+		? transaction_type_strs[dram->transaction_type] : "unknown");
+
+	if (dram->validity_flags & DRAM_VALID_CHANNEL)
+		pr_info("%s channel: 0x%02x\n", pfx, dram->channel);
+
+	if (dram->validity_flags & DRAM_VALID_RANK)
+		pr_info("%s rank: 0x%02x\n", pfx, dram->rank);
+
+	if (dram->validity_flags & DRAM_VALID_NIBBLE_MASK) {
+		const __u8 *nibble;
+
+		nibble = dram->nibble_mask;
+		pr_info("%s nibble mask: %02x%02x%02x\n", pfx, nibble[2],
+			nibble[1], nibble[0]);
+	}
+
+	if (dram->validity_flags & DRAM_VALID_BANK_GROUP)
+		pr_info("%s bank group: 0x%02x\n", pfx, dram->bank_group);
+
+	if (dram->validity_flags & DRAM_VALID_BANK)
+		pr_info("%s bank: 0x%02x\n", pfx, dram->bank);
+
+	if (dram->validity_flags & DRAM_VALID_ROW) {
+		const __u8 *row;
+
+		row = dram->row;
+		pr_info("%s row: %02x%02x%02x\n", pfx, row[2], row[1], row[0]);
+	}
+
+	if (dram->validity_flags & DRAM_VALID_COLUMN)
+		pr_info("%s column: 0x%04x\n", pfx, dram->column);
+
+	if (dram->validity_flags & DRAM_VALID_CORRECTION_MASK) {
+		pr_info("%s correction mask :\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4,
+			       dram->cor_mask, sizeof(dram->cor_mask), 0);
+	}
+}
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 94528db208de..967847b571cb 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -20,6 +20,11 @@
 	GUID_INIT(0xFBCD0A77, 0xC260, 0x417F, 0x85, 0xA9, 0x08, 0x8B,	\
 		  0x16, 0x21, 0xEB, 0xA6)
 
+/* CXL DRAM Section */
+#define CPER_SEC_CXL_DRAM						\
+	GUID_INIT(0x601DCBB3, 0x9C06, 0x4EAB, 0xB8, 0xAF, 0x4E, 0x9B,	\
+		  0xFB, 0x5C, 0x96, 0x24)
+
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
@@ -120,9 +125,32 @@ struct cper_sec_gen_media {
 	u8 reserved[46];
 };
 
+/*
+ * CXL DRAM Event Record
+ * CXL rev 3.0 sec 8.2.9.2.1.2; Table 8-44
+ */
+struct cper_sec_dram {
+	struct common_event_record record;
+	u64 dpa;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u16 validity_flags;
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[3];
+	u8 bank_group;
+	u8 bank;
+	u8 row[3];
+	u16 column;
+	u8 cor_mask[32];
+	u8 reserved[23];
+};
+
 #pragma pack()
 
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
 void cper_print_gen_media(const char *pfx, const struct cper_sec_comp_event *event);
+void cper_print_dram(const char *pfx, const struct cper_sec_comp_event *event);
 
 #endif //__CPER_CXL_
-- 
2.17.1

