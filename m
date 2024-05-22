Return-Path: <linux-efi+bounces-1056-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6626C8CC3D4
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894381C22CFB
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292D928DBF;
	Wed, 22 May 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j+ejNDKH"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE72942D;
	Wed, 22 May 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390538; cv=fail; b=jLt06OZHwhhJSiqjD9xFYPWonm+VZwcPSRf8TIsO90t7lcTc6c3y/euYD1fjmXYfIwFIGrf16zcTMyS46OmcLm1lU/EZEawmOSsGIpN15kKrYysDEKDuZcWx8aah2+gkPdJ/AOb/NIcoFceR0xOC/dFYbHWmUu/4ycRemWYma4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390538; c=relaxed/simple;
	bh=oP4R/tpiyqd2rosVrWbMWHScizgRRqwmxEsuIUHf3Jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bsDPw1nhZ+qxkxPPKqZJIGWxfDjlRN6y/+d3Hy/PGZHXTvYSxQVhcKjpF/HNnlks8otbD1+IbaP2uHxej93ytTeFNxmiPcRafUsXg4eA4oR3ZfjdEGEzvj2peJm0FVLNafNcLg4AzjJYQe3zkBWtSFI7w5Dx2+/KEL3SFKoFEUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j+ejNDKH; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXZj9xRkg86KD8ykOjCd/eQ3cKzfXiQE68KDt1Jf2u1p/iCcFiZk4f5C5afO7yw2MREqolTsw62yomdti9kD7nvSbsaLdAPWm8A1Xi4tK54+WNs9sZdV6+rIrTyJ/iE5TIlfClQ+zrrz71y+NfCAGWf6JkKjGT8CEuuRKdzFApAglA5g4n/2cSLIF+Olxyot+L+uE9mZJr8m2iI/DC4bXzMxVBy2hF5GD+6NMU0WA2d8IzjOeRTtSK2rbfalL/jCb8/U2GzSagmUei3lgctXGmz/0dnz7Qsu840zvTW4SFPjp6LmKfFSosq7TT6VOC3RoFsH9BwrRsbuEr9C9stBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqqeIBP6dghrqcO6p9Ojgm1CLshDcGlvjVbPqQBKzd0=;
 b=CK9RH28Cep1qp4NtJ4yxFD6k2RcYfMRHF3k3u+Mfa5KQ05F0Zpj9bv6CtzBthc23JAtIZVxvBUz/K/fqcK1IYCWfKZHKeNSMkKnz8oefz0NUzKpj97T/KHjjsWxWesi/EccahNW8VDFYPdLHA5+OEaxz685pB0NDpndeqJ4K/s8FF/eG8xQByNhXf2lrgk1fXHi8ixf40FyC3x79nf/z8gHmwke6sM7KSlmx57YRIXX/n1i0eAdqRvVg7WrvDWmgF6pgOCISqFfP834BSAUHZWO/1W3WP+QgCGbtSZzhvWYXHQ3c4ry7CjufzpVaFiUMm2BuR37P7SYOq+e32gAmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqqeIBP6dghrqcO6p9Ojgm1CLshDcGlvjVbPqQBKzd0=;
 b=j+ejNDKHkp3fNc/3tsSdrKQT1MVui9SiuB3FTlADxi7qENM97dMqjVYcRtO51pL/CXmSIzmcZ+YQmOFiNuNstzGmvja3CBPnooyB7jwa3KTfYLhl4MVDxbNMuiCm5RwJ2xVLgfxH8q4dZM3FB8VcSOUEHozGga1cH4lG2PdyPVM=
Received: from BN6PR17CA0042.namprd17.prod.outlook.com (2603:10b6:405:75::31)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 15:08:51 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::f5) by BN6PR17CA0042.outlook.office365.com
 (2603:10b6:405:75::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 15:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 15:08:51 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 10:08:50 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH 0/4] acpi/ghes, cper, cxl: Trace FW-First CXL Protocol Errors
Date: Wed, 22 May 2024 15:08:35 +0000
Message-ID: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: a0830fc8-9715-410c-30e0-08dc7a7116b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Wct0gw2QI4YraDoPk/JRdqJe0pIFiGRltTM3+lSyIXvP7aOY3NoC6/GfUIk?=
 =?us-ascii?Q?nutVkpyjibOxa0Noh6+wU3+UUszWontoW0E8ejr09Y6W677bUv5rBukmtnDn?=
 =?us-ascii?Q?ETqIdV6ZsQZEOgUv4SAuJ85c8yhv6Z/vOIAh9eMihPeneixVGPSNJq5c3FSR?=
 =?us-ascii?Q?pFWZ+YB4w3Cz+lf8t7JV3QtK0TtUL2OH1A37bWzdn705CyjsejSbiK2Nn+Su?=
 =?us-ascii?Q?38YPjbjk+9+io5+XWauLh7mgkXU3sWXlHnCKJZRBffX/qMZNIvmw+KdFN1uY?=
 =?us-ascii?Q?aRNhHhZTB/kqAk8UPrfp2E9/8x2+C58AuRGVFd3JM5m90UpXFTQslybV6Wkb?=
 =?us-ascii?Q?kWOPuxJJ/dq+wYT8FFjDaxSGE6g4vMFt1dunuqNFFkUkCK4/PYpyQjlJwyQc?=
 =?us-ascii?Q?oV+HYaBmj0IQMOCVIFyfI3bdSzzq/YAu4rGOpoViZgktfsReF5xTpPds2ucq?=
 =?us-ascii?Q?3bQWy7V4JfUwWiphpodUWln9JzJPq4+ALZ8Vt8OyhuZ3lZunKXNj2HwK4sTj?=
 =?us-ascii?Q?XXAgmxfR1TiNtt6kcq/RVcUhunip9SrH/k2RqR5kkEECALinTuBBBT1FAMBb?=
 =?us-ascii?Q?uYLFNcGhLx3B3KZnmgOdcB/9Ee64AR6r3UcEhUjtKciIPNMTXcGgUcyWCmFI?=
 =?us-ascii?Q?Ji9zBJsBoELvcjvRja8P2ZzmHQo+8yRgS8Z3ZWlEHgxom/F0ceWJnQSY3v5z?=
 =?us-ascii?Q?2afl4/0KXrrkE7jqQ737roVFGWdvTbqzF9js52fma4EztmRL5VrnqHY9ratj?=
 =?us-ascii?Q?Rx42wnE8c+jHeFCFul7qZegj7vLl+4QSPhjdC0LRFJdci0ky02uoZ3mGTZp4?=
 =?us-ascii?Q?WTX3yG3OR6ZH/iG9izK4orQGv9oUA9DuRkiDmgll1A97LeUh1FZDVo88lZl4?=
 =?us-ascii?Q?UTt/i1LJh4dGbi9m3NdJtCEm/8RcHHMdk+S1VCIHOW+9pKESyD3V6B7bmwgr?=
 =?us-ascii?Q?WR9vSN+n31IdmCfraXtRSc8nDiV2elvFiBpih3PqzSUs3sDKC8iB6SPgmka5?=
 =?us-ascii?Q?x/1VACp6s3GmL4GNx+fllr5A84aM4T33PX01XRNPTVzeTIz1mx+UgKf9H/lU?=
 =?us-ascii?Q?hQhfvil+M23vg2NOZA9dMJa76efoDX81GfXiBJdg/zRXLvS6ugqVAbns/ZM5?=
 =?us-ascii?Q?2D5HgYoavJZVgkHCqIcMUAR073ZzdTB9Bt0hGrsEWGeBMNNYu78eBj9iGCZt?=
 =?us-ascii?Q?whCIP4q5wf+7kW7nMbqYtZMH/8xs9o+6oItQt/DiLj+pCj3CXyC6nJ29Q1Wy?=
 =?us-ascii?Q?tX6ud/6Ut25vJiojC693uJaWM6KhwWdLCbYzTYv7ZfPEmLRM3zuF0Pj57WLr?=
 =?us-ascii?Q?sFwG4njkH3GaGz5Iid0uYqQTEu4l/y7dFRuKVYEUd7SPxTi5Cbq3nJpZtDfk?=
 =?us-ascii?Q?QGBNEs0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:08:51.0296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0830fc8-9715-410c-30e0-08dc7a7116b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

This patchset adds trace event support for FW-First Protocol Errors.

Reworked the patchset to reuse the work item written by Ira for handling
CPER events.

Smita Koralahalli (4):
  efi/cper, cxl: Make definitions and structures global
  acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
  acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
  cxl/pci: Define a common function get_cxl_dev()

 drivers/acpi/apei/ghes.c        | 24 ++++++++++
 drivers/cxl/core/pci.c          | 24 ++++++++++
 drivers/cxl/cxlpci.h            |  3 ++
 drivers/cxl/pci.c               | 60 ++++++++++++++++++-------
 drivers/firmware/efi/cper_cxl.c | 77 ++++++++++++++++++++++++++++-----
 drivers/firmware/efi/cper_cxl.h |  7 +--
 include/linux/cper.h            |  4 ++
 include/linux/cxl-event.h       | 38 ++++++++++++++++
 8 files changed, 206 insertions(+), 31 deletions(-)

-- 
2.17.1


