Return-Path: <linux-efi+bounces-2619-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2EFA1061D
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1801699D7
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CE229614;
	Tue, 14 Jan 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AwXZosBi"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D820F985;
	Tue, 14 Jan 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856287; cv=fail; b=cGo5idlMenhXaP6kbhilXNnQgFZbFvRqDl05RcIuMjSNkFi1QaUfNRlFFtNL0+v50CfkxAzCYPujnq6r8XOXMVC1soKtWwJBuj+dS+pR5NEq1nR53+j45uJPEe/rGoen0W4/ayzeWgfJTsVpYygAutJwHwEixORsZ6lkkVTGB/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856287; c=relaxed/simple;
	bh=dFATjiEsqWPrNpXInOlOEZiH5vSDzDmvifr8RXVavlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaFamt0iqjAi/Z4VL59EwlwrA65lh8kaIE8EyIaWCdtZhpuw80Mm14ozNFYbIluwe3NLtGoMr2WWjl88Kl753clZZ+9y8TJ0SZFswHZZlk7HJOZ/aQRH2GS3H+9tSLVXjSZn+d9jfINNH5J9SesxaQQzf1WTgIc60ZXh5kinJ2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AwXZosBi; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpv/WSZnwR4OMi/ArPspwKp4PI4ycFBJgkDCjZ2I3WoOGj6zVZZz+4fc/9X4c+8jLd/LZq4glNUQSz33Bb1u386/O6zMwNEKV1zVvR2gPAkxzCtvB5gwZYGwWErxto1JumwkgNK+BOC5PgXRRcGsZWByBu0kvvf+ZpAqBcEqHUiQ7+DKSjeCg/F93uQ29//X+HBb1VjXuSKrXdCQuBoE51SizvlhqxU+7TfZacUxDTctIopA01kr2I0ws5lrE4FjNXHhLAen/Hr1U3o1t0Ni1+1qCObRBtgdz1MMz3AC2B/EgKq5USm2hnQ6mNBYIfKsYp0lFsM4G8UONHNaroT4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHfzDc8hxvCj/BV+aIO8xtZPQXrTUJi3McVEavgo4pU=;
 b=ux+VpxWnBe77wd6NyLWs1/Hrk39jiHZI6K5z5Vd/4fPSMk/lwX+DJoNX3G0AvOWTecrVKmO+va4wYo/fYyzTuKItqf8yGAuFTXmk6BVPWxiTheictG5RzackvZrZVvB/bjv6EeMx7vXyF60vOunul0Hz0AQnBkve/uRhQ513noqXDYWX+XFi/2EAHOQDCIYMwSV/etNfvJ988uYnjIsr2MCVzQlfr+g6MvOzHhv6uFdHruuTw+sQ9Uve8B90OiIbJVSclbKLh/1A1f0rGBiA5y9kp8bfpdXGaTejpgKtv4oFAc/mGuVukzyH1u2azIUUSgeKzOBfwgyK5cMjGkVCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHfzDc8hxvCj/BV+aIO8xtZPQXrTUJi3McVEavgo4pU=;
 b=AwXZosBi2gPQ9ojK7UJKzGG4qCJ74Qolc9NZu1dfvYZAzpR6NdfFMlo91/0LWUY0ekHmxZXc3fntvT04h6jjkk9/xOQ+GNIL16t6CdWG6IYhQEO4Qf8YX3jq7pz3uRKCdxQHsbBYqo6kG7cW0Ak2yyuoQ4cLQPk4yO75oQVxv4A=
Received: from SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::18)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Tue, 14 Jan
 2025 12:04:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::1e) by SA1P222CA0119.outlook.office365.com
 (2603:10b6:806:3c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 12:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 12:04:41 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 06:04:40 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5 1/5] efi/cper, cxl: Prefix protocol error struct and function names with cxl_
Date: Tue, 14 Jan 2025 12:04:23 +0000
Message-ID: <20250114120427.149260-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: 79634c6e-9069-4792-df10-08dd3493a0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CJPUZ0Rnhag7POzadld80mLTtPjKxa4+4txQuVKKuE3N+3QmqV7AQtQ01d/V?=
 =?us-ascii?Q?CxXWeu1kGSgE2nF3/zV0nTxcsIRkOhf4oHadmZ98H2ADdO3DY0uT1oMiRjMQ?=
 =?us-ascii?Q?MNlB+ncD1wfybtqxo4glZ9XNrvNlbxg9wxz0Ohc4ri1wryZcAUr43HQlk1Yu?=
 =?us-ascii?Q?CRsf/Y6dXkY99cbZ9QoGV3IAVtChSZJ3J+f65zjIztee4X8owNYj3R2nXTDi?=
 =?us-ascii?Q?P/pyk1vNzbbwF4QpUS+esJjqJcFlCoelNQHz1Sw+my3bJT8ne3SEZvsPDejW?=
 =?us-ascii?Q?8ShTimAYFmVx5zlKIZPkD5lk39q/YMITciM5tSVmaEf70rZNt9zpv0D3aJ1q?=
 =?us-ascii?Q?xyaWHTt0t8XnS3FwNA8hjXBNLALp6iCUEu9qGd4V8Fv6sYASyy/g1zYGigbQ?=
 =?us-ascii?Q?PYXiMZIv+601jT4fI+qGMzGKQpJ8dIdji/BBjsY2WAQt52Ym2M16c7/kvdCO?=
 =?us-ascii?Q?KAbDsUU6DQXlBoq/twlvPs/J6RWz6t3/Tz0HekyJCxC66tKTd2MWVVNbR3HM?=
 =?us-ascii?Q?lR03Oj1WcgwbDTabgZc11LEDYAs7xWlH2APEHzquNwrsBMqazr3qHmudWOFO?=
 =?us-ascii?Q?3UFerA6QjsP21E4XP4O9LA5wgHOmbGTA+p0GJi4+1K61S+eFBzXd/gc9MSVh?=
 =?us-ascii?Q?G5ryJ9oSQ/IU/3UvgY0IuoT3KQzwv6046hrd5gf9IfIasypc9lwhn+Yt0q9R?=
 =?us-ascii?Q?SWW6UkyPUoYn0FDXRfWVmRyn5sr1SpUyy/tymVRMyzon8oeUT+ef3iYm+PZS?=
 =?us-ascii?Q?zP2C5sKe34T3WqYF0nz7VzNqBpmupZHdWBHi8NNIzEVN4Xuj87Z3Z2mXK8S9?=
 =?us-ascii?Q?35lEw2tWMqmKXok+wtHW8IZFErMhZpsGmNh6nxR0tlWsPl51HX9PbZJEZ7Dj?=
 =?us-ascii?Q?OjjOiHUDzF0vV0dGKEi1NvNsPhlZ8CpH65tGpSFsnIp865tUPmXMCfgnxpu4?=
 =?us-ascii?Q?VMbfoSLlRPQMPvf02BebjnW9OjVwnlwMe/bP1yAAkS2hDQTdk+jpx9f6ohjZ?=
 =?us-ascii?Q?gcjAXccONkOEa16nVxGqi6YRvUrWovF35xnMmFC7g/eJVryFTWXlZX+uNADf?=
 =?us-ascii?Q?Z9W/gsq5SvCy5oZ4PezgF/GIm/cEiiUek+c6EUrdYrcpzQY9guHlSJAeuXCP?=
 =?us-ascii?Q?ZDxE0lPyzG21oWnKGj06gEbgEqQQWs1Q6lx0uR0lmYDG3brs3zcmZPFVjD9x?=
 =?us-ascii?Q?B7AJmMEtpO3y4BvVnikYLl2tI3s5nNIFA5Vu/tejmxoEsr3isqcS4cs6c8yj?=
 =?us-ascii?Q?nBNH0eeUKMGOWAISobjWEsK3L+Pga/RFPUyzjXMvQoCgVmCCl0N5gxUj7/ez?=
 =?us-ascii?Q?4m/Y0J9Tyv872/L5+VRnIkQIFB8zLg926IjKsyr4XwiQuCVFp5A8Tn0OyGSn?=
 =?us-ascii?Q?5bcwXcBWDso5wBcMXcUo+nJgupr8Jr5JmiF9OJgBkzzXa/uxdyoAbQ6F+3RB?=
 =?us-ascii?Q?CENNpIwAerboxDBb3L6toeIMTwWvy2o4eFwIwIY5qNVOrruEJBANRq7xzEm5?=
 =?us-ascii?Q?dFzvv2t/g3iL1Y8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:04:41.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79634c6e-9069-4792-df10-08dd3493a0ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

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


