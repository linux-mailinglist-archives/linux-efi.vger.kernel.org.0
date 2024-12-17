Return-Path: <linux-efi+bounces-2382-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FA9F40A7
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 03:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA181165232
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89213D276;
	Tue, 17 Dec 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sjwPnnQe"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC313DBB6;
	Tue, 17 Dec 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402145; cv=fail; b=I3uoIQEfD9Gjot3Jivzd+/6UvHZnow+hzPKH2vXFgD6nBZ5QVEg/+3wd64IPsQHFuW4Ou4N6jdp4MuwfpeOAKif7miCCiGA13AuyNjn7Kei1NzbEeNRLdJ8gAYeUkS7nPv2Xc3dhHS1MsxwHAKj8slSxD8vX0VfiDE8hInr+OcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402145; c=relaxed/simple;
	bh=KEGN8Cqgakjmmin93a9lJ/VAX8582ZOmhChhzHp/CLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwK+5YN6iMC+zTnIiPZWKrkpAr2KZtn7uN0LtIjFOPTpihNZRiX0ERl2qrBW54NR8ZN//X9YabKsBJ3xzHinTZ2udTZt13RciuG4bEYYeo0BTLHLXwIM+VwPuhYCpCPGkBxLxF+mN8qd9YahxctssngatoJtGj8jVWX/9RlkH7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sjwPnnQe; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzKrx/AJS4O1TnjeNNfYssrfxcOvbAEUvH+XP1UsfVdFxrruKO2UQ1lFlphF/9Ol9+K/yxle3iCD26neTzZrgGMlXzttwjxFRH3mCUWrYVVT0XMg5o1O6+iXItiC0T4JPjWmwhYMkvUzFt7QQz3UYfRcgi7ESS2nus+Aqfl9cjk1YU5oPnD+mQ49c+gqIzCbb18Xvu7nQ6CXLyaIo6BOEykSOBw3Cvr4eX7t/OlFOtS7ehaf0BxRtUKPMRIpRQo2Ds0YM+j3Lj3/oTNOcy+sCW/l3UKAaZR39RJ7S6eiUQsaKcLhjvU5PR9zaqleBOARgbZEuR8mz2unq7lV+zoifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa8x101QXXGHPXVUXRy/2Lohv8/rFeSvceo22497Zp4=;
 b=wiPsXQLPxozh5g5+phVklMZD+KHY8LbGrDy8NVyw1TW20FUei6kphNqhN/h8vKge1JpySv8ZRSgVnqXQvbDDxCFBjluHSJN1/AwGPjyLyjhcs2CyxsJ4wIwc0/ujH4YykCuB76gjWGoIBxW3uelaLv1QEfichb/7ed5fgfCrB/mDH5YxZP3vF0apyNRDEq2GJHe63A4VcCEUTX0cvk+da04Fed0Ns3VGXlIzSG8OcogTg9DhGX9wE4kKCeyzpQTEVc2+I8n1flhiv2BqPcTbbc2xkYbMuMzke7OgiCs5fbX7K2JfWqMS8Q4jCyCm21JiBbxVbGxqHGBvK0xHRV5Heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa8x101QXXGHPXVUXRy/2Lohv8/rFeSvceo22497Zp4=;
 b=sjwPnnQelLSKf8SepYQAX8qMfz68GCjlEDqz3GyY7Gnoc45wy39HFrcdtICobW3/TSqncNgA4IYJCeOCNCgh8kb70KjXuSdl8mvngI3L249i2Q1ATgat3A/cNnFMQwMOEWAYf8QAH05IvI0aIsaZdBWzirwi7AoB1qzx1nk8aS4=
Received: from MW2PR2101CA0009.namprd21.prod.outlook.com (2603:10b6:302:1::22)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 02:22:20 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::87) by MW2PR2101CA0009.outlook.office365.com
 (2603:10b6:302:1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.4 via Frontend Transport; Tue,
 17 Dec 2024 02:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 17 Dec 2024 02:22:19 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 20:20:43 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 0/5] acpi/ghes, cper, cxl: Process CXL CPER Protocol errors
Date: Tue, 17 Dec 2024 02:20:27 +0000
Message-ID: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ea7acf-9382-458d-7793-08dd1e41a23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBo29L3sjCT73uLy40z/BC+QYaSy18+cW07AoTMyffs0nZDIkUiQPGKu+MB5?=
 =?us-ascii?Q?+e3+d6U6R5HdrwuOhfRnogswSEFdwQuzX//suzeNM4BPRUvbhbTZHT5Tpkhn?=
 =?us-ascii?Q?kSem4Z4VDqu9pL/VhMQEX8usp5e7LvAVG/ubU2AGLFI3h9M/a/xIN0oWSU+7?=
 =?us-ascii?Q?nbdmzVjHCURAvIfLDb8E6NnQkFVR2l17HR0VZyKc023tqJlJOYiqKwN9XDNl?=
 =?us-ascii?Q?1yCdrofPRbAaybR5ZElXegcHtFKlmBuZ1kwXhzWHJ7eTzkui2rFqMvnhke2h?=
 =?us-ascii?Q?VhPT462ashn4iYdwKtPVuYnIO0QV6yDy0wXr9dOqpSvARo2q5iNwB1es+Bj4?=
 =?us-ascii?Q?IZ2x15d9JlPYN8dAYzqh3GYccOzvoZuAMpGbjOJJ66VzRPlMk1b8R99x9Xwq?=
 =?us-ascii?Q?+8LnActwNTCjPOfsKkK4dRC0BIL08cCiZrFuaVgANrc10wBvfL7V8aW8bm0W?=
 =?us-ascii?Q?qaT6EuqrvG+oSERChuxyinwsvNlkFRjSTxPe8R2YFfBWpsAzAMlDoaIVYa1i?=
 =?us-ascii?Q?CBx22+r+icePWR+0u4psOGbfDekPKeCpLMD2iEh3k74ozw1jqPT/Lf0cYS66?=
 =?us-ascii?Q?AkYBjFas25Xvjd+WvwBKm95jhC644iyqQEqmMwdhSjLYosVWf/O2mJHr9qyv?=
 =?us-ascii?Q?cnvO3eexSzv2OQkxJSC80GRtFVSu3wFIXBn/nDnEzxIgp45MA1kHnFMZ0cHb?=
 =?us-ascii?Q?ggJARYhOO/V/AYUwS3lHCPLlwqeVHBwLqbgaoBtBkr/DYRBa6IbkNr+SKWyb?=
 =?us-ascii?Q?cG23bMTsjvTYWhqLIYi3svL3IJVbrligHt1zhIgAxJwkpQbmy3Y7HGx+rZ8K?=
 =?us-ascii?Q?IKjMbWEbs7aUyZfqOncR+UYdRza4qNJ83R2hF6Q23Nh/c2fi7MnRFqsstEJB?=
 =?us-ascii?Q?4Nx8a2GYJgyqg3HegU4MWSlLrJ8NyPNgPpq17QuQh+GVteIOhf9ZbNDBN8hi?=
 =?us-ascii?Q?1582REatd8uZf/yA6VHyVpQiFyrzffz2qs+RoT5a31RHo0sop++7ILiBSn+7?=
 =?us-ascii?Q?eVIb7OjLM1hANPp8w4uVSfa/VgifeF5IWP/WsoSUJ2QcwmgzYzP+HbotDLp0?=
 =?us-ascii?Q?1Ju3FZufokwXdfxjWb4Trm1m2+4q/PKkcrt+3mhiRGYVOciPLZt5w0Sl9HAD?=
 =?us-ascii?Q?/WFF+Gc6C3MPhNAKX9+Oo9BfqEjmBH1tuwrRibwwRrDhMIyZQi8ux2FlCKwk?=
 =?us-ascii?Q?PpZvuOXpu01W0sYdUp2fT274i3Rctb5muBViNhRaiBBU4qXXxiN5rfkPtRvh?=
 =?us-ascii?Q?o/x/aYLiB1awBqxloHxxykAZBrPHUe5ynvmGdDtaMc0+TgkGCNlKQsnr/cCm?=
 =?us-ascii?Q?wIbIxaLrdsDW9rASwKoo5Jqs7cpizmcBZ67OnO6uENPtDOif6E7S15zOXjKL?=
 =?us-ascii?Q?ZaDFyDft42kpTZPG5SJKHsc0ag27DRiiodk7gJeda5Jc8cOKuqpDpu3u2Vtq?=
 =?us-ascii?Q?fUSA/1hPcDXr8lfnMcFdY17xFMblPYEv0HBrooAo5Zbf9TfAss1UI8Ho3lg2?=
 =?us-ascii?Q?QOJ9LH0rrqRYt2I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 02:22:19.8339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ea7acf-9382-458d-7793-08dd1e41a23c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

This patchset adds logging support for CXL CPER endpoint and port protocol
errors.

The first 3 patches update the existing codebase to support CXL CPER
Protocol error reporting.

The last 2 patches introduce recognizing and reporting CXL CPER Protocol
errors.

Should be based on top of:
https://lore.kernel.org/linux-cxl/20241211234002.3728674-1-terry.bowman@amd.com

Link to v3:
https://lore.kernel.org/linux-cxl/20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com

Changes in v3 -> v4:
[Ira]: Use memcpy() for RAS Cap struct.
[Jonathan]: Commit description edits.
[Jonathan]: Use separate work registration functions for protocol and
component errors.
[Jonathan, Ira]: Replace flags with separate functions for port and
device errors.
[Jonathan]: Use goto for register and unregister calls.

Changes in v2 -> v3:
[Dan]: Define a new workqueue for CXL CPER Protocol errors and avoid
reusing existing workqueue which handles CXL CPER events.
[Dan] Update function and struct names.
[Ira] Don't define common function get_cxl_devstate().
[Dan] Use switch cases rather than defining array of structures.
[Dan] Pass the entire cxl_cper_prot_err struct for CXL subsystem.
[Dan] Use pr_err_ratelimited().
[Dan] Use AER_ severities directly. Don't define CXL_ severities.
[Dan] Limit either to Device ID or Agent Info check.
[Dan] Validate size of RAS field matches expectations.

Changes in v2 -> v1:
[Jonathan] Refactor code for trace support. Rename get_cxl_dev()
to get_cxl_devstate().
[Jonathan] Cleanups for get_cxl_devstate().
[Alison, Jonathan]: Define array of structures for Device ID and Serial
number comparison.
[Dave] p_err -> rec/p_rec.
[Jonathan] Remove pr_warn.

Smita Koralahalli (5):
  efi/cper, cxl: Prefix protocol error struct and function names with
    cxl_
  efi/cper, cxl: Make definitions and structures global
  efi/cper, cxl: Remove cper_cxl.h
  acpi/ghes, cper: Recognize and cache CXL Protocol errors
  acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors

 drivers/acpi/apei/ghes.c        | 101 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c          |  62 ++++++++++++++++++++
 drivers/cxl/cxlpci.h            |   9 +++
 drivers/cxl/pci.c               |  60 ++++++++++++++++++-
 drivers/firmware/efi/cper.c     |   6 +-
 drivers/firmware/efi/cper_cxl.c |  39 +-----------
 drivers/firmware/efi/cper_cxl.h |  66 ---------------------
 include/cxl/event.h             | 101 ++++++++++++++++++++++++++++++++
 include/linux/cper.h            |   8 +++
 9 files changed, 346 insertions(+), 106 deletions(-)
 delete mode 100644 drivers/firmware/efi/cper_cxl.h

-- 
2.17.1


