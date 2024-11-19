Return-Path: <linux-efi+bounces-2172-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B79D1C9E
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EDC1F21E5C
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C617557;
	Tue, 19 Nov 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rt6Sx1dq"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4148825;
	Tue, 19 Nov 2024 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976771; cv=fail; b=QXZMNuum9vbxKxfm7PEWQO2J14mgyd+klyPP+airbzr12sW8SuXD9rGELJTDJzXXImFWhD3gBHVKfcdRb6We9aUj6zS22csPK5ZmpfqmV1zRr+MfJmtqPXr0jKigEByMWsHDxCn0QXj39VGgU0q42kF3tzWrvpy6nud7HuEyzlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976771; c=relaxed/simple;
	bh=uDMGYcL+XLWGKPyQMmwJ/zGDeZ8pWEQWxwuO+NpzWXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvokNX8hz7xRG72fIMhaPqk+km1w4i2Tc/+vsBIF5zLXs90ksqq7f+tvGlskZIqL0U0I5hlpg0GX/rxdqolFYvRAhQUA2QqmQ1O6QyssZI45adw1ch1ygdMBdfd4mG0bMOJ30kMNd5RHTsC6No7DziZOdlzttORwFrKS4td1bDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rt6Sx1dq; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTe6zpY6/aIEmuST3UZn65tK2zHvxRj0q0iuCz+7JmyuMz7SbOVBhIdgZCzZW+C57XCXFgMZv1VT/pA4ZF8zn4ZsV7HjqvXoouSt5Y96387pepdzJ8ToOJ2FMWqqhlpGNjC0/R8wBGIa3/jBG6jircQk88OCZWLj2rPOT9XE/TNTnMCTeP5n1qDrTBXMmXBZ+8rz+nIbVqDml9/BaOFDsfxczi1jAynZAz8JhEA5Fj4BDedN9YkYRL8eH4pdjGp1gp4paseCBecnhpFQj3ULxfPX+H06OHiV67M0uxivL5tSRLgq3yhM0hXQu2SmVEXxyPYb1oT4aPAjTJgfRsEglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npLRdjlj8mH6FrxgIHDG+pOwFOBIlycwrCsQ1xxMtfI=;
 b=MwaZbvCZwRKIcTGasDAo30lcghdSlm0fj/JohZ6pzpcE1THD/kwVg/k8yuISvV17s/dmZyW4lpv3UHWY4LfL01l1luKvq7uw4TV8Pp7kliMH++iqYytcaCPPMFEy6X92+d+yJv0kEHsfee9UjaYfwLdrBRlBkrA9v04o5tlpNBJAaJ8PyHEa0MZ6oAHekRwtW2a4Amx2NgEzPXj2gqBy1bryMXMGQcP6PM7tfKOBwvqhaWiU9c7AFtZuAvKcKGo/BKifD9mc0YPP6Cbpixif7+CKbANynto5h+sz8aGpLzLIpQCRSid/OkCQNbv/WFOhnn6E57lNgxJ86xz47zYvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npLRdjlj8mH6FrxgIHDG+pOwFOBIlycwrCsQ1xxMtfI=;
 b=Rt6Sx1dqd5LDPfLX0Rcp8vwjzIzspwdHg6PzP2912G3CTD5tG+o1qNn1Ntq9NCg1CaItotH8xSEKLW4DfBHijUld75kKkm9XM35Kb9cyLQDVz2tnc9ukvdLJYsjw+MIBVXT+NfYvmpAiInweRPcIyAILq1X5sKo/MUVS07mTNh4=
Received: from DM6PR10CA0012.namprd10.prod.outlook.com (2603:10b6:5:60::25) by
 SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 00:39:26 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::ad) by DM6PR10CA0012.outlook.office365.com
 (2603:10b6:5:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:26 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:24 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 0/7] acpi/ghes, cper, cxl: Process CXL CPER Protocol errors
Date: Tue, 19 Nov 2024 00:39:08 +0000
Message-ID: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d65fd4-84e5-4212-709c-08dd08329ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEMwvRQL8Vzdlv7wwrtoYz5EC1o1tCPME6MRtTfKJR7bLRwOE1sGE5QcIz74?=
 =?us-ascii?Q?suEql+0W/t+/tva/UUjmFHrU9Xll6p0gJsrTZ8zvm23MuqBQ0vFoPmFeMQ/k?=
 =?us-ascii?Q?sVHXrKSfPRVBPYatMCWH5cROmnkOq/LA9wKoWOgTHMDUq3omBlY0IHGkqUIU?=
 =?us-ascii?Q?8eJkruPXCjJc/Or3zIvxyK+slR6nh6n4on/Bn8uguKqzk5QeXC6NidAt164o?=
 =?us-ascii?Q?yU5P3NqpA448tRsop3BifLtdjGnBCBfU6Zk4ynXlxVS+BvnZh8ZZp7VR/Gv/?=
 =?us-ascii?Q?af/qxU+j81gJQuYhXmPUBjbDTGTabGONI3Sc+dEQB6SEvVBLlfopQPRjJ+9i?=
 =?us-ascii?Q?QMqvXnvUYNhUHoKVu0UgEOp++pUcEcdJc++LIr0P8iV/zXPmgxFDagaVqfN7?=
 =?us-ascii?Q?L4N4YKT49f6c21pJKZbflwJvIrPl1otAdOuzn9q5Ej+VUb5EPpvLDLVypTdW?=
 =?us-ascii?Q?nUCI55RXwG+h7HgUUkSGKYr5IAjSR6Ra2tn5LTMZQ3Car8X0j/axCm21WM3U?=
 =?us-ascii?Q?DRMICIL1rhY9ET3VSLBoCO640AJR0ylLksXzBvOJ/wHHBcOwAutiDRKzzOjZ?=
 =?us-ascii?Q?4UzwnNCoFJmmEX6bMnblECklsv3NNL0VyV9SJ+xo/Y0xpv2o7d3Zd3b/RM2E?=
 =?us-ascii?Q?3cIL/3U/3BQzMo3ZtKaoAWlr4mgVjmOHIFWsH9IuC9BGuja2qEAepBnVL+H9?=
 =?us-ascii?Q?dOSiPq5tukn6X522C1tDh9MK5C4+22MD7fMWn93NYd1wcuPuXScI70hIbEeP?=
 =?us-ascii?Q?13PRI5bP0VWp1PboLJKUiCxMGsEzdTexNsmzmK6HsIOv/aW+lGtaqI4LFhY2?=
 =?us-ascii?Q?//oB4nUeMby+0eiRt8N44fa10V3aBIogLE76qMpzEiAiV5Nczg7HkCPL/o57?=
 =?us-ascii?Q?KvDwlNQeRYjLPAr6H5lLbaPSQmhvByDMPMLy0QZyukWDGNlIeyvxepA0dY/A?=
 =?us-ascii?Q?r3BorW7orkxcZPiokvSZx+hObO6RofNYZ18kJ4mmr5JjComtGlK2r4A+lMod?=
 =?us-ascii?Q?DTU13vMEOssIeocUceT2RcZaNrjv3QpeLNnx24z4iU/QW4JtRKWdgy9BsQP+?=
 =?us-ascii?Q?M9KODZVS75G+eucVlYYl3F6kdnyJZT410LAvX0DJO5z3JxTCesbAveejWQgL?=
 =?us-ascii?Q?xcYAnG5qWWMSWtDURjyZqwWDhQTumkmw8+u9IAAVDR49wFD2mFAkValxkKq5?=
 =?us-ascii?Q?fX87mp+sPbWLCkIBFPiAg2WvTqk2Pe5VU14nlpcbibb+QnM2R6OyyaE+C0Ek?=
 =?us-ascii?Q?HOWLMMpBHDf+6mPIO4RlmQK93YnI+KbpDzRJZLaeN9CaAsJpSY7xLIANzqYL?=
 =?us-ascii?Q?GZc4G+G07GHpzAfrLCaSs0FSZzpUsVyfxZbaIGkASSt7OkEIVysrVL0Paamn?=
 =?us-ascii?Q?LHs0YxYbPdhVV9jpmV0da2mDcB4EAyxbOxZP416APnwiwNqDQORSLE9Dessd?=
 =?us-ascii?Q?8SFHydaAZdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:26.0183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d65fd4-84e5-4212-709c-08dd08329ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

This patchset adds logging support for CXL CPER endpoint and port protocol
errors.

The first 5 patches update the existing codebase to support CXL CPER
Protocol error reporting.

The last 2 patches introduce recognizing and reporting CXL CPER Protocol
errors.

Should be based on top of:
https://lore.kernel.org/linux-cxl/20241113215429.3177981-1-terry.bowman@amd.com

Link to v2:
https://lore.kernel.org/linux-cxl/20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com/

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

Smita Koralahalli (7):
  efi/cper, cxl: Prefix protocol error struct and function names with
    cxl_
  efi/cper, cxl: Make definitions and structures global
  efi/cper, cxl: Remove cper_cxl.h
  acpi/ghes, cxl: Rename cxl_cper_register_work to
    cxl_cper_register_event_work
  acpi/ghes, cxl: Refactor work registration functions to support
    multiple workqueues
  acpi/ghes, cper: Recognize and cache CXL Protocol errors
  acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors

 drivers/acpi/apei/ghes.c        | 129 +++++++++++++++++++++++++++++---
 drivers/cxl/core/pci.c          |  50 +++++++++++++
 drivers/cxl/cxlpci.h            |   6 ++
 drivers/cxl/pci.c               |  59 ++++++++++++++-
 drivers/firmware/efi/cper.c     |   6 +-
 drivers/firmware/efi/cper_cxl.c |  39 +---------
 drivers/firmware/efi/cper_cxl.h |  66 ----------------
 include/cxl/event.h             | 109 ++++++++++++++++++++++++++-
 include/linux/cper.h            |   8 ++
 9 files changed, 351 insertions(+), 121 deletions(-)
 delete mode 100644 drivers/firmware/efi/cper_cxl.h

-- 
2.17.1


