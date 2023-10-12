Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A37C7A2A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 01:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443228AbjJLXD5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 19:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443212AbjJLXDm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 19:03:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0831112;
        Thu, 12 Oct 2023 16:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCeQAInqGiXd/ibG5n6qWtT4qIU5XuBobKyD2CZic/9ZBeRopngaFHqkc+JSP+Xc9kLSn44id01LiXcmSfRpx0SpJot83lO5n5T0VxGnxfQiyl4A42caqPgqC0rjGWXTaXov7bltmcOawi9aN9HCc2f0JXF+rnU1wD4Zg5O5UHmmAXLOHkbej8luFaMvH8XJs6aMiqtcMrg4zf2BwCUQYNpgqYgxutqyeW1Z+4IPox/DpYONEuzLyvmeQS3NfmP3hm7kpw5IzFU88GoF64tQuCueiyaA4/XErKRF5TWTRwIJgrVGGk6ZEbi0Dkx57A2IKmgR7Hvg/6Cu4HUCa+spXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpAULVGxNk/AEj6PFj4uEc4Ap8fwDpyq9CBXKrh30PY=;
 b=F61+8k63s4QrOIIqlnSdwPOSoVH7T/jDwgjrHz6MEg6/GHL3A5lUwpbX4uQnnbNE6fNzsOtKwljFEFh6/XJCYDVkHNYkXvChJNCAQ2lxJE/hjLrgSQPz/0vqduLN60fdu3GgS2Jo64Vs/bwdeIFO/z78eYxbDjCKDYBdbmmt1IT7QQ30+2B3zqvcoltmHXhSJECR2/B11FRRVsdR4X37RtMEgASkWeccX9FvKARaHnGe6a9R4ImdB8Uua4ckNnCpwgu+bLSkWJr1dKVRMlj+shkFYfaMxC5ShFmWFyZ2P2j3JL3irQRR21//O1CKFtbQ8JTNLs9AWw4bMdPIkWmUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpAULVGxNk/AEj6PFj4uEc4Ap8fwDpyq9CBXKrh30PY=;
 b=u2OFOlVSqosUsDOZkeGlAecUjRFPARw0rBl900p9E9N8fKxdjofvIBd2mi6d62g9fU/jrpusSv0ZR/D5I5KJWkyWGwJuf+ualbkJkFjPEShgoEMP+thXh/tZXyWAa8XOG7w7Cmqa06WvOwPCH/kNA9KXW6DrVrCSkWqY8kpRwTI=
Received: from CY5PR15CA0066.namprd15.prod.outlook.com (2603:10b6:930:18::10)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 23:03:18 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::9d) by CY5PR15CA0066.outlook.office365.com
 (2603:10b6:930:18::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:03:18 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 18:03:14 -0500
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
Subject: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General Media Event Record
Date:   Thu, 12 Oct 2023 23:02:59 +0000
Message-ID: <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH0PR12MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: dedf88b9-ed82-4cc3-6d51-08dbcb776c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzrnhm4M3r/kZKz6NERV8gXNHRReqBL7m/D6dAbHykY9sOTSvL6SD3szb6C692Jysf7asfpdsgr//zwEqCDimHcgU96cUZC35t4MYkjAJ+IoXKaxVRi7fm75LvH66zq+kyNAJNEhDNFJrrT3tC0qkZosKBYWyJBjyZbwW5s/9OgLQuINV66Pw5fVOJteK+ty3S6vV6NcagQv+3RxW80KRJYTOnt8bKqu+7a13ungcGoOtj4De5egdOGd4T4iU3zkUPtnB7YOhlj8zxmukutiKOLEJGbk9tjzxjOMKG14MMHABjX/Xwkn4KKjBXYautmq/Tojb/USySnvJFz0zADu1tdpNEMviqHD8Avmfkb3LBHPCBR5SwNG2NnfUEcF2DfbWz0Xl7aC/OQUMbGj4hLW39IQ5cQCUVo/pbeGvOEq/SXhBwww5GiDG4qtQ+Xh1YMvunJevJ3jCTDb+Z2xlnyjuBEsI/9MlCbkktKzatcKA4RjEx85iOIE189p31Vob8OU0GeikzwUnk+SKHqpbrYSApy+vjg+dvnb8UHZCerVui1prxUSufwRNhwFAQLsc0gcge9u7aUYyeLs34qQOa875Mdg7SOBevvex50PDYRgO+07UHbn4s+EPP1ZjdSzhFZwZiO6jAST1ytGjWGsN7gPWZWPqck20Uq6Cu7ygIxa7SHyHbVdu1kmJ1LF5x4RBCEI1pMm6rCIo6JLjFsG4gfhpdZL3TP8JnyBRlHQ9K+0ifaZs5toWbEbUW5CllmzB16eGTmH4BU6sKNGxxSTOU7S6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(478600001)(26005)(36756003)(40480700001)(16526019)(316002)(70206006)(70586007)(54906003)(7696005)(110136005)(2616005)(8936002)(4326008)(5660300002)(336012)(83380400001)(8676002)(426003)(6666004)(1076003)(41300700001)(86362001)(36860700001)(47076005)(2906002)(40460700003)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:03:18.0196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf88b9-ed82-4cc3-6d51-08dbcb776c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for decoding CXL Component Events General Media Event Record
as defined in CXL rev 3.0 section 8.2.9.2.1.1.

All the event records as defined in Event Record Identifier field of the
Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
CPER format for representing the hardware errors if reported by a
platform.

According to the CPER format, each event record including the General
Media is logged as a CXL Component Event as defined in UEFI 2.10
Section N.2.14 and is identified by a UUID as defined by Event Record
Identifier field in Common Event Record Format of CXL rev 3.0 section
8.2.9.2.1. CXL Component Event Log field in Component Events Section
corresponds to the component/event specified by the section type UUID.

Add support for decoding CXL Component Events as defined in UEFI 2.10
Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
section 8.2.9.2.1.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper.c     |   8 ++
 drivers/firmware/efi/cper_cxl.c | 143 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h |  62 ++++++++++++++
 3 files changed, 213 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..b911b1f574db 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -607,6 +607,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA)) {
+		struct cper_sec_comp_event *gmer = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: CXL General Media Event\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*gmer))
+			cper_print_gen_media(newpfx, gmer);
+		else
+			goto err_section_too_small;
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..8f7b88cc574b 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -18,6 +18,18 @@
 #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
 #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
 
+#define COMP_EVENT_VALID_DEVICE_ID		BIT_ULL(0)
+#define COMP_EVENT_VALID_SERIAL_NUMBER		BIT_ULL(1)
+#define COMP_EVENT_VALID_EVENT_LOG		BIT_ULL(2)
+
+#define EVENT_RECORD_SEVERITY_MASK		GENMASK(1, 0)
+#define EVENT_RECORD_FLAGS_SHIFT		2
+
+#define GMER_VALID_CHANNEL			BIT_ULL(0)
+#define GMER_VALID_RANK				BIT_ULL(1)
+#define GMER_VALID_DEVICE			BIT_ULL(2)
+#define GMER_VALID_COMP_ID			BIT_ULL(3)
+
 /* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
 struct cxl_ras_capability_regs {
 	u32 uncor_status;
@@ -55,6 +67,42 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
+static const char * const cxl_evt_severity_strs[] = {
+	"informational",
+	"warning",
+	"failure",
+	"fatal",
+};
+
+static const char * const cxl_evt_flags_strs[] = {
+	"permanent condition",
+	"maintenance needed",
+	"performance degraded",
+	"hardware replacement needed",
+};
+
+static const char * const mem_evt_descriptor_strs[] = {
+	"uncorrectable",
+	"threshold",
+	"poison list overflow",
+};
+
+static const char * const gmer_mem_type_strs[] = {
+	"media ECC error",
+	"invalid address",
+	"data path error",
+};
+
+static const char * const transaction_type_strs[] = {
+	"unknown/unreported",
+	"host read",
+	"host write",
+	"host scan media",
+	"host inject poison",
+	"internal media scrub",
+	"internal media management",
+};
+
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
@@ -187,3 +235,98 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+static void cper_print_comp_event(const char *pfx, const struct cper_sec_comp_event *event)
+{
+	pr_info("%s length of entire structure: 0x%08x\n", pfx, event->length);
+
+	if (event->valid_bits & COMP_EVENT_VALID_DEVICE_ID) {
+		pr_info("%s device_id: %04x:%02x:%02x.%x\n",
+			pfx, event->device_id.segment, event->device_id.bus,
+			event->device_id.device, event->device_id.function);
+		pr_info("%s slot: %d\n", pfx,
+			event->device_id.slot >> CPER_PCIE_SLOT_SHIFT);
+		pr_info("%s vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
+			event->device_id.vendor_id, event->device_id.device_id);
+	}
+
+	if (event->valid_bits & COMP_EVENT_VALID_SERIAL_NUMBER) {
+		pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
+			event->dev_serial_num.lower_dw,
+			event->dev_serial_num.upper_dw);
+	}
+}
+
+static void cper_print_event_record(const char *pfx,
+				    const struct common_event_record *record)
+{
+	const __u8 *flags = record->flags;
+	u8 severity, event_flag;
+
+	pr_info("%s event record length: 0x%02x\n", pfx, record->length);
+
+	severity = flags[0] & EVENT_RECORD_SEVERITY_MASK;
+	pr_info("%s event record severity: %s\n", pfx,
+		severity < ARRAY_SIZE(cxl_evt_severity_strs)
+		? cxl_evt_severity_strs[severity] : "unknown");
+
+	event_flag = flags[0] >> EVENT_RECORD_FLAGS_SHIFT;
+	pr_info("%s event record flags: 0x%02x\n", pfx, event_flag);
+	cper_print_bits(pfx, event_flag, cxl_evt_flags_strs,
+			ARRAY_SIZE(cxl_evt_flags_strs));
+
+	pr_info("%s event record handle: 0x%04x\n", pfx, record->handle);
+	pr_info("%s related event record handle: 0x%04x\n", pfx,
+		record->related_handle);
+	pr_info("%s event record timestamp: 0x%016llx\n", pfx, record->timestamp);
+	pr_info("%s maintenance operation class: 0x%02x\n", pfx,
+		record->maint_op_class);
+}
+
+void cper_print_gen_media(const char *pfx, const struct cper_sec_comp_event *event)
+{
+	struct cper_sec_gen_media *gmer;
+
+	cper_print_comp_event(pfx, event);
+
+	if (!(event->valid_bits & COMP_EVENT_VALID_EVENT_LOG))
+		return;
+
+	gmer = (struct cper_sec_gen_media *)(event + 1);
+
+	cper_print_event_record(pfx, &gmer->record);
+
+	pr_info("%s device physical address: 0x%016llx\n", pfx, gmer->dpa);
+	pr_info("%s memory event descriptor: 0x%02x\n", pfx, gmer->descriptor);
+	cper_print_bits(pfx, gmer->descriptor, mem_evt_descriptor_strs,
+			ARRAY_SIZE(mem_evt_descriptor_strs));
+
+	pr_info("%s memory event type: %d, %s\n", pfx, gmer->type,
+		gmer->type < ARRAY_SIZE(gmer_mem_type_strs)
+		? gmer_mem_type_strs[gmer->type] : "unknown");
+
+	pr_info("%s transaction type: %d, %s\n", pfx, gmer->transaction_type,
+		gmer->transaction_type < ARRAY_SIZE(transaction_type_strs)
+		? transaction_type_strs[gmer->transaction_type]
+		: "unknown");
+
+	if (gmer->validity_flags & GMER_VALID_CHANNEL)
+		pr_info("%s channel: 0x%02x\n", pfx, gmer->channel);
+
+	if (gmer->validity_flags & GMER_VALID_RANK)
+		pr_info("%s rank: 0x%02x\n", pfx, gmer->rank);
+
+	if (gmer->validity_flags & GMER_VALID_DEVICE) {
+		const __u8 *device;
+
+		device = gmer->device;
+		pr_info("%s device: %02x%02x%02x\n", pfx, device[2], device[1],
+			device[0]);
+	}
+
+	if (gmer->validity_flags & GMER_VALID_COMP_ID) {
+		pr_info("%s component identifer :\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, gmer->comp_id,
+			       sizeof(gmer->comp_id), 0);
+	}
+}
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..94528db208de 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -15,6 +15,11 @@
 	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
 		  0x4B, 0x77, 0x10, 0x48)
 
+/* CXL General Media Section */
+#define CPER_SEC_CXL_GEN_MEDIA						\
+	GUID_INIT(0xFBCD0A77, 0xC260, 0x417F, 0x85, 0xA9, 0x08, 0x8B,	\
+		  0x16, 0x21, 0xEB, 0xA6)
+
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
@@ -59,8 +64,65 @@ struct cper_sec_prot_err {
 	u8 reserved_2[4];
 };
 
+/* Compute Express Link Component Events Section, UEFI v2.10 sec N.2.14 */
+struct cper_sec_comp_event {
+	u32 length;
+	u64 valid_bits;
+
+	struct {
+		u16 vendor_id;
+		u16 device_id;
+		u8 function;
+		u8 device;
+		u8 bus;
+		u16 segment;
+		u16 slot;
+		u8 reserved_1;
+	} device_id;
+
+	struct {
+		u32 lower_dw;
+		u32 upper_dw;
+	} dev_serial_num;
+
+};
+
+/*
+ * Compute Express Link Common Event Record
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+struct common_event_record {
+	u8 identifier[16];
+	u8 length;
+	u8 flags[3];
+	u16 handle;
+	u16 related_handle;
+	u64 timestamp;
+	u8 maint_op_class;
+	u8 reserved[15];
+};
+
+/*
+ * CXL General Media Event Record - GMER
+ * CXL rev 3.0 section 8.2.9.2.1.1; Table 8-43
+ */
+struct cper_sec_gen_media {
+	struct common_event_record record;
+	u64 dpa;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u16 validity_flags;
+	u8 channel;
+	u8 rank;
+	u8 device[3];
+	u8 comp_id[16];
+	u8 reserved[46];
+};
+
 #pragma pack()
 
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cper_print_gen_media(const char *pfx, const struct cper_sec_comp_event *event);
 
 #endif //__CPER_CXL_
-- 
2.17.1

