Return-Path: <linux-efi+bounces-2833-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029ADA46E3C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863B41885108
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 22:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429A26BD83;
	Wed, 26 Feb 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nf3HlTkc"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0326B95B;
	Wed, 26 Feb 2025 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607934; cv=fail; b=idg8nNQ1jHKVKyW9/iWVRz8DW2DTe4r68n/XwsUpVqTuvXfjkqtNR6vDEfe78NztP/Q7rSW/0l1lTky1pmRBC8ULVamuQwoK0pKOzfgBx9QaFqCm/6VjGTc8XRG0KI72qQpGupNA1CIgXdxE9NKJ568ziOFWSMcwbAZaVueId6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607934; c=relaxed/simple;
	bh=hwUyM4njh4cOzXYWT3DVA5BzxB3mOlJ/W9tw1gUn+SQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZF/jwO0qc0n/JlmsLMH9rVG5jOC9TD2noBPVXi29Rl3MYcmWdH5bPgcmj8jd6kjL4aB4q4zfN+4gegjiX1hWmU9Z444UCsCAfc8fV8aJWVYaP2FuYXsrDLXp5RsdgdGmQQffL0fZqRKIA89fBB6FUT43zG8EzrAuebyB0iB6+a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nf3HlTkc; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naz9pkjJ/wycxfYZM9YM9lB3ZE4SaKLDVvem7GFE9MGY/ZgYCyXMGABRz+aW4FfyzgyeajF5oXDIqjsVNuO39SuraK0kbBzjcLvKQ6bVsT33gLAGAJs6t2N+LheWCXmDjDDSF0NxcAhc3bmjmziLG+z+fem1oELz0cfRe0N19Ib3Ay71qoWypyzJ7c7m4EcXcdI3XPt4XIYHmxV1sDZa1Fn13+MFPW93BlPQGV6Z/fJptLMIvJpv7UrmSpeV3t4U1Sx/lqIveKri9raLGBgbNxiRKu73BvR7HMEiZNrZenRixm4XCMQau8TxBNSQFspDEOP6ny++xrMZg+P17hgS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY6CDvkfOchfnWgnYB2zpRg1IBAbWUnObA1PEMpsQHo=;
 b=sk+zE5UzXmcqhTp9Jwa7aqDt4263XoVUKlltVPlU5k5f24dPpF9OSe+WBgOpnO4OCq9iFcsM9WcCISODMbiH6t3287JVlGhIudMR/OZB7M6h+uV18bo6/E/O8nzxeH33E4eRaX1KYA7TN4poDWW5xGlFkRlutpkTNRaiVP++dydw8X3QwWZ1yhW+uHeJq7XZKabSno2L16YBn8tYSYnwdZYIML7CscbvyWHRSHjOxOHRifmpYBKpJYigauDs9do3Ru3ppvY/LlkjJGNFy/wQ0Wv0Oq0XAguN5/g91IMooc9X6MKs7kk+UQ8yw5og3R0WCpGo+qNSygdVdWR0mEWq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY6CDvkfOchfnWgnYB2zpRg1IBAbWUnObA1PEMpsQHo=;
 b=Nf3HlTkcdcbwZvbMh/v1YJJqZZW2s6XIbls2GsoVGW9/W6NEWEJ011ZQ2mgC/bjBcMfGrW5haNrcfollXNMkIabURn203eZuWGH5fS6QmGdfXgq1bpkQbcrdBnB+pWJWfkeLzX9ANaNiGKP1JbIdMMz6Nvb2ezbhELbcmFX6vqU=
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 22:12:09 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::83) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Wed,
 26 Feb 2025 22:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 22:12:08 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 16:12:07 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v7 0/2] acpi/ghes, cper, cxl: Process CXL CPER Protocol errors
Date: Wed, 26 Feb 2025 22:11:55 +0000
Message-ID: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 69665647-2886-4412-6369-08dd56b29c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ngpnM336q24PkebbtTUvzQKzTZwy3Zxjkg1bfe7altb+c/VAN2Tf8/toh6/i?=
 =?us-ascii?Q?E8f2p/ysWV/0wUNEyH7+pj2Jswq2RmY7dJolOHXPRkQDNqVYoulyZNOyInpr?=
 =?us-ascii?Q?2EYLCbEfZOV5M4do8D8fAFcFTJYbzuhXkb8WNM6PRWrmABfIbKB3XWu5hMHR?=
 =?us-ascii?Q?dZWZ0fjqyaLJS9Q6/6TmUi31XLmBWUwrUfizAIPtE0tE/zeHXH50J/UfD/MK?=
 =?us-ascii?Q?ORa9N5cvzLdeFtXEROFXe1iM/mmmxC79SqdZJBdQCoglAJapb/F4ZRy3Sl9h?=
 =?us-ascii?Q?ZQkjSPZCA7+nUN3THzt0L0PtXQ+Xi2GPqqHolPNPGhH637zTKPNeVoy5fVMa?=
 =?us-ascii?Q?3o1yqVJmEwzZOHF7wyqeDmyY9KyDZyEad5gF+5nVTsiLb13yR3VPKj4xX7+e?=
 =?us-ascii?Q?5Yn6G3FuQnLHGBWmi3thdaojHUQk9ENfP0Lqk/+2JJX0j4qq0UW9V+6Ccx9Y?=
 =?us-ascii?Q?88/Z2Y7L3yxJNDtooEhxEzrY3LMKIYD3NxAm4BqEVcsjDoG/pbzQHM5zHRy4?=
 =?us-ascii?Q?1Rh3WBBw49hxcw1F36za07Z6VJnbftmEBJch78PaNAyfh+DJ0HdUcBNJrRnR?=
 =?us-ascii?Q?l8F65FvMcz5FgXc2xH7XcLa6qV7sCClfBx1EkQbIjwGVMvuyG6y+0FQAwadV?=
 =?us-ascii?Q?l3NZNRQ+SF9cLNeIVhqviswamsEgjKm5lZQ6Xy+4+koDjCkcdvgwdxJLOWAS?=
 =?us-ascii?Q?vaeJ9P1+QLQo32J9ptbRTk1zSuiY3hPi/BQISJe9sCiYcvcKIM6t+1cmzpqT?=
 =?us-ascii?Q?FI7ammB/DwQ1/8fkjgvII/fa5kgt4XrgFzMs+k9aMJzhsguSXNbmRj3789nV?=
 =?us-ascii?Q?9zmmqw7+CpbStiwXrpxF69rjpddxvWywzObLhaYeL3DsfYZV2wsbWnojeYpY?=
 =?us-ascii?Q?idx9KmAQcdVy9E13oStgAJSJBFeBIXJyL7sCvLnTwvuDyvSvJzF3pj83Izb4?=
 =?us-ascii?Q?4C95lYTfRCRmX8Hf9taNgIt8S2yuf9RddmHG49HfcSMo41pagy7PoplxCzxz?=
 =?us-ascii?Q?Cr9rDXNQenpHrf7nV7u7Ts+PBAV7QrCzYxmkXiP7HhnGc+crfPKAY953DUfE?=
 =?us-ascii?Q?Yd9oQbFj5tjBLMC8EwfJSGW0GjMJKm637GoBzQLFXfLbk7dQf4hO4E72G2Ej?=
 =?us-ascii?Q?ZHD2IV5RpLKRDx/QLCAs62tUornL3aFFg8ICYW7TMy+BL80ccC/x70575zPx?=
 =?us-ascii?Q?vzBOoz/eo2TB83ylfyTVCoOEIpsfLRsedeRZCCkqsLpWUg6lMM+k8PsCoIe5?=
 =?us-ascii?Q?wzVP0lgczlE8MBiXvE37EvQ4PatPRTbtPhfRaINIOpvC6TsarZs1zESjyl2N?=
 =?us-ascii?Q?g8j7BWP2QlhJxdXhg3XCIJl8ZvfmCWcl7BWnfCoBv1rPrzTmO6ynjypPw3GJ?=
 =?us-ascii?Q?WpKd3pVWUHLh7wKTpIeixQwhpZVI8ADTTeoD0DiHjSMLTZpyRM+jihXPUKxc?=
 =?us-ascii?Q?/JlOg0u7XevX/dKC4vZwVj+lS6Af9OaWLEWyBO9+dKf+E6QE9RASqehhiRTI?=
 =?us-ascii?Q?8wjFTHlX67n1qnU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 22:12:08.6729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69665647-2886-4412-6369-08dd56b29c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

This patchset adds logging support for CXL CPER endpoint and port Protocol
errors.

Based on top of cxl-next.

Link to v6:
https://lore.kernel.org/linux-cxl/20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com

Changes in v6 -> v7:
Reworked to move registration and protocol error handling into a new
file inside CXL core. (cxl/core/ras.c).

Changes in v5 -> v6:
[Dave, Jonathan, Ira]: Reviewed-by tags.
[Dave]: Check for cxlds before assigning fe.
Merge one of the patches (Port error trace logging) from Terry's Port
error handling.
Rename host -> parent.

Changes in v4 -> v5:
[Dave]: Reviewed-by tags.
[Jonathan]: Remove blank line.
[Jonathan, Ira]: Change CXL -> "CXL".
[Ira]: Fix build error for CONFIG_ACPI_APEI_PCIEAER.

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

Smita Koralahalli (2):
  acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors

 drivers/acpi/apei/ghes.c  |  49 +++++++++++++++
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/core.h   |   3 +
 drivers/cxl/core/port.c   |   7 +++
 drivers/cxl/core/ras.c    | 122 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h  |  47 +++++++++++++++
 include/cxl/event.h       |  15 +++++
 7 files changed, 244 insertions(+)
 create mode 100644 drivers/cxl/core/ras.c

-- 
2.17.1


