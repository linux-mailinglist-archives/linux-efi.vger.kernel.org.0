Return-Path: <linux-efi+bounces-2717-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C72A1A020
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23793AE608
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102320C480;
	Thu, 23 Jan 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kQQ1GGr1"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156320C03A;
	Thu, 23 Jan 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621883; cv=fail; b=LG6yAaDpurHOXwGYVGh7BiY2Hwem85OF5eR9+txe6pYpym0CLqg7hbKWjCbUuZaf1sF+fXQD9LPRBArbQUGzvDykaCenZzMCfW9HQBXd3PB16RzneO6Rp3E80BldNA+UzxiOwDjNksCp13BkzlehxwPGyn+0vuA0uim4BHaiFBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621883; c=relaxed/simple;
	bh=dFATjiEsqWPrNpXInOlOEZiH5vSDzDmvifr8RXVavlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxsfeRYhERHXyHvXgHbC9flFQu0Qblb0jXuXid40aVF1V1PMyHH5Kt49UxPv1583/pYun+c8gi7UK2xFkM0m0fMmWp650/m7BBZnU6GNzgFIf7iQTDBM/20S0Rk4cRgIjDjA1Mdxd1Xe2IYvdjm5Lig4DWVLv7yPZ4HhnYgowf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kQQ1GGr1; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts0bElHnc+C9y8b2f8y+M4f7O8irvxFTu+0a9q/XUaLX/IFXneMBGn8F5btTzPNvJhk3QBsPA+Uh4eNSc/Kg3HRmDpTXfG8DOnQHHs5H5ePkAABStM8KIuZgVdy8wHsloWzRcvv6yoKhE3jHCKjJ+cCwIbavT/DUA0IGfJY8mmPUGykjUZJsjrTn24OFqHmnTBRGTRtbyNYL9V1Q1usZokdtoi0wy2rmjpakxPkaevw2HPiE+aP6Cj6SfPIWsy9T2oerdemZ7AOjkCROrgZk1KmoXRGyxnfHO095rNRey2LpQwSols+gXLm0gEif4/GgnzmCL8LNUvIVeBft2bVzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHfzDc8hxvCj/BV+aIO8xtZPQXrTUJi3McVEavgo4pU=;
 b=iKuwCt+LIwyllPAW5E3D+wRVrDwO+6Q5YbmZATGI3EkDSEPJP06UBD1FKuVIWMIAlX8kHcLQuCUYtO1bX/8EjbEdnyKt+x9VQrHGXfTzRlkiwK6Awxxd356DFo4c6pdBE450CaUOS0OOU7TX+sdA7y18gyBhViS5liSNxGbJ62b2tIhJvVnKuWmZHX9zM7xIqjOIKtRCLUoN4vwVtI4DY6wDE2AfFhjuUWHXU8InLqWaXz7jmQ7F3L1KnDThGzUHA2sh2/sINKe03kf3wsb3/t3XrSCIbr0WQjg8YZWtiqTx1+kxs3bF2d06Ew4wFAG8UE0abSM9YGCSNBnIOkfh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHfzDc8hxvCj/BV+aIO8xtZPQXrTUJi3McVEavgo4pU=;
 b=kQQ1GGr1/CNxTdsYiy2SFtTWuj6QWQB1IJ9E+N64kwzk8seqtzgeScDkrFEm7B0qq22ys9bCOsZ7X3yHitJmB/IdAyOrawoqbhoD68L6m4EVKEM098y3WE1YNrbLxhDQ8/ntyHIXudfaKWYoy0khGDC+m+DExj5lp+yp4jYf6RI=
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 08:44:38 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::fc) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 08:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:44:37 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 02:44:37 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6 1/6] efi/cper, cxl: Prefix protocol error struct and function names with cxl_
Date: Thu, 23 Jan 2025 08:44:16 +0000
Message-ID: <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dba83c-363d-4743-818a-08dd3b8a2b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?de/tw2GzEEJT49KF7cn1g2t38ZRuxBoNG/N97jnbNEeFCw7t9LsE+S90uhuQ?=
 =?us-ascii?Q?16rSM/ToHaQPPzDOBbxoh+8B3e4Uel5FChJW1pFS5ib95YkZ35EUyKH7GpxC?=
 =?us-ascii?Q?FOrqmFGNghJ1SBEcsnH14WURLzOE0vHRlWIyIRyt9/stpv1P3TaCTAGv/mgj?=
 =?us-ascii?Q?5zfS0uOC4kzcAF87/lN7YrfSYLtLQ8/mkkfI+Kb3KWKeXF7SMjfreR8u+Q//?=
 =?us-ascii?Q?KgVr6bSOQCcno8rvcUVziGPVeMhG8iiTuZ08ljk8KnJqVNLjZwRcwPwZi1HR?=
 =?us-ascii?Q?cuTQthT15fLXZ7J10FAbm8cyLPS0HkVfFnztYkTo8yl8U3i5MQNXmh3NI5uM?=
 =?us-ascii?Q?TCj3Ygd7/1OlOBeuhPJJWzvOYXB97jCp2RMm5YUUayeN6PU7FCD85A+nOQUF?=
 =?us-ascii?Q?u6T5dQKWEqdFKNXaGhbXjqd8iaX+rwWS1dGCLWGYXmDem0UQW8wyHIacBqjB?=
 =?us-ascii?Q?yZFx+4YelvgWWNaWKoaZdNbZtoCFXsSkeepHfKS1Gn+UXZmfTYlftrLvEyKd?=
 =?us-ascii?Q?7fILuEvq+32hZQk8Hok/esT5fWmfyUYzjDPcc1TUURKeShsMfNgt0prxPAoJ?=
 =?us-ascii?Q?7hmKMKG0QoxO+PYD6ri86h6Ji88Z2imAK88iiT2LSN1Xr4Q9HKg6tFwHVq6e?=
 =?us-ascii?Q?mP3t8wutZbFEW8ni/a1xKuHjZzaVwrkq9F9iQlvtjoS8cesKRg+kPgHB8j6d?=
 =?us-ascii?Q?kDjiYJ1tmqHPppaSUukjApITaTBiM7LbX9Dlx+/HqFhv2Pk9KbgyAjv3UsV4?=
 =?us-ascii?Q?zkB/N+K6SCUbfl1f6DmjPucEZE/I5qd/JkkMs6lCVp0Zmh2m0hvNH/Xx5gjM?=
 =?us-ascii?Q?zFCo0znplEHUQtUr2Muxa8EgThkGtMT+qH0SkcBcDbLRA5ia6wb/Ou2Up3+L?=
 =?us-ascii?Q?lpxBsTNLh8aQImiwOrggZ5O95sWLCksH8gApRJJHeILAApqkarafEEFwuQhz?=
 =?us-ascii?Q?XDCFyIP8xkQITxT333h6zY+TzlS4HM/ZfU7/CkYjIO1MBOZBEHCKUai6sUqC?=
 =?us-ascii?Q?Csy959LW7RqtpmKFrWT9YHdsWlTSdYqnoroJJkEMAP+QYicSUgTbwsUuKOHz?=
 =?us-ascii?Q?rkSWzNlgxfKAtxkToaQeJjCaaiyBgyGXW44KzdfWpA8GrAJM1YVUFi9LOQqb?=
 =?us-ascii?Q?vR89TC9Sra6FASA7SgbqsQQfVBMjks1jgr/Y7uwJaIKKmeDQM7DA7HO4WvvK?=
 =?us-ascii?Q?n0mUwuwTKtbZVulKlbbQiu7ECAqdWWgnCStgUhBbtu+aBxU1xsYwrCwMYgeU?=
 =?us-ascii?Q?NCr/6r7Yrvbkr/hKMw4A7Hc2RoswbhMCU8wNwwMdUn39FrJpGy3T/XfZWK5G?=
 =?us-ascii?Q?FySi+mMKK9wj9dExhOUQPflXTvuZWIrhI28p987njtKjSSI0fsBw6Vynjo8a?=
 =?us-ascii?Q?jASTE23lkdC2QVo5DJo3bOtJP7s90PkO+Wp+CPhga5/O1jp+Y9mC5o7vUDrF?=
 =?us-ascii?Q?bDFQkFSPR82m+/X2ZY4xQCpliU6brBai7qANxpE8LPmlSCoXOUz+sH7eee62?=
 =?us-ascii?Q?gAAipZTJy63jByA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:37.8637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dba83c-363d-4743-818a-08dd3b8a2b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

Rename the protocol error struct from struct cper_sec_prot_err to
struct cxl_cper_sec_prot_err and cper_print_prot_err() to
cxl_cper_print_prot_err() to maintain naming consistency. No
functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/firmware/efi/cper.c     | 4 ++--
 drivers/firmware/efi/cper_cxl.c | 3 ++-
 drivers/firmware/efi/cper_cxl.h | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..8e5762f7ef2e 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -624,11 +624,11 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+		struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 
 		printk("%ssection_type: CXL Protocol Error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*prot_err))
-			cper_print_prot_err(newpfx, prot_err);
+			cxl_cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
 	} else {
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..cbaabcb7382d 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -55,7 +55,8 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
-void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
 		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..0e3ab0ba17c3 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -18,7 +18,7 @@
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
-struct cper_sec_prot_err {
+struct cxl_cper_sec_prot_err {
 	u64 valid_bits;
 	u8 agent_type;
 	u8 reserved[7];
@@ -61,6 +61,7 @@ struct cper_sec_prot_err {
 
 #pragma pack()
 
-void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err);
 
 #endif //__CPER_CXL_
-- 
2.17.1


