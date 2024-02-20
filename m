Return-Path: <linux-efi+bounces-589-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7081085B071
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 02:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7255283B98
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303E2375D;
	Tue, 20 Feb 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R6TqtmIb"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE222374E;
	Tue, 20 Feb 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391929; cv=fail; b=beAUxNjzbDcSpruOJB6b3WQU8ywz0H26/eSsKxFeB+LSomJlnvCy1MLNl7GFC418lB5z8zBpcTIr9ydKFgY+i8bMynpIGHgZkapN9YLPUrUnXeSXFaAC57c0SM2fqxgbyb3Tj3FIXJga/ZHCCUr6nCulsuCaO/3Nt+M8Yrh/tbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391929; c=relaxed/simple;
	bh=O3vkgHznduX8g9NApApbE8NlG1/BfaASoKe+AGvy84I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvdo9eJtRtLSbK+nuFkibm3bJGNu15/SE+CD5cgHBryRd+Caq1UhXpmMRkFJb5Maq+o5zmBxkq2u9dN1V46BMD8uaP2L2Dp57KKH9PQWnrtiXwRIas0g1PKBRFSvXLDmBEXxm9f3F/+U1GGA7YyLXB7nv3O6jMGzH1jnIb8qur0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R6TqtmIb; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TagMC2oVxinYpBDriv3Rs7kM5jXVhhHWsP2AZATQvBrVUIUiK3oM08/K20VdOpKvJlDmGHuRSeIQxGJSYR0+85WH8+j5ztxRO/X+1nTvwPMMODFsgum9ZV5kzAnk40e3H2STYPXwX1Qgrt5KX8zFKjDFtrJtZBidgCI9YojC+qjN34WbfzOJue1Y9UcAiPDOhysdDEXKFzpEl0SrYkwuZfr9B2TBMkZKQf6A5RBRRkGWiASaKk6GQ5jTXEHCmzyt/RB4YqO/CYzarhkyWIsrOYTAYNTd1rRRLqTQSPmBF0uzQ+ViInuShzZFypuQWeQHC8qucu2nxv+1F3bKroHP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoZDrwnDUW5jtawmOFj0tbKMZ0eAN7JvbDqwdqAfZqk=;
 b=QUClg1cnM29HWujYzcf4m+sVlVP7gbVTJuT7v4pZ3G1+OKL/V2pnE1vitNZv61eRiCE6vZNqD4dJUHeRT5JPxwG6eyUJbmfJEeZVagLc5s2vyG+1nqZNhOlZa1U/50AHQ+ZccpM6lWxcPMAal+dFRR3F5fIAJAZU467KKHcoDMDontZv3+HcLj9qnmw4pzxJ9I/TLu2hyFTV7ubB8V+21S8UDGIAzksphRSt0kzKQzVLH1eeKf4ZW7CE9wchCAGBY78CWGfxFBjqWgeQzrXgP9hELyAE+SlrKssrcNM4kLNjlRvTv6jm/guSam0Sofn6baphotjh+n5F/+gxTNCL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoZDrwnDUW5jtawmOFj0tbKMZ0eAN7JvbDqwdqAfZqk=;
 b=R6TqtmIbHOYviINMut6IwItbtkR0kOMB3uqruogJT3xCw36voHOpnKe9IGSoCnMyZkwJ0LIZkl8Zh/v2z7EVyeY0uKRHWAFrTQohrg/ZKqOnmWjfLFG4PBaDLKHQTR8CC6jGwmIRuCTXLIb8aRyhfSkGeY9EAlp8IJ+ur0SqeS4=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Tue, 20 Feb
 2024 01:18:43 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::86) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 01:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Tue, 20 Feb 2024 01:18:43 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 19:18:41 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <x86@kernel.org>
CC: <ardb@kernel.org>, <hpa@zytor.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<elena.reshetova@intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <kirill.shutemov@linux.intel.com>,
	<anisinha@redhat.com>, <michael.roth@amd.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <jroedel@suse.de>,
	<ashwin.kamat@broadcom.com>
Subject: [PATCH 1/2] x86/mm: Do not zap PMD entry mapping unaccepted memory table during kdump.
Date: Tue, 20 Feb 2024 01:18:29 +0000
Message-ID: <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708390906.git.ashish.kalra@amd.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com> <cover.1708390906.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a8e54e-1055-4a18-4aad-08dc31b1e0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xlAvNBQoY0bSnx8aPKaBrserGAkVoQtjmS5wHlNy0PZ++nvcAtgWbIRiNx4EyPBa0hBhRo4Qo3cdu7nTu55eb1xcJs22s0PkJJzfEyeKMw0JaD597YBNFTo9PwNp3pqcUe2rtF66sJrfyo1TOQYfMkJCHRwlyOosZIpMw5e5xwekR1KzsvDTdHxxL0+MgyXQ/MLjDS1C+dajxNd0wQk2f08JGR7iOWjEUaeTK+qww4ia29TBglllS5BlHFGNef3Q5zFOoOWiSOuMrBHlo+5+SEaDrjSlR5P3Pkhmoq92XlW9hPf+jJeWXW/qD15VFEmDvk/eyiHbKlSBVzrfvleo+wlHwHjfRJslNjU30j5pyIN0oEsC0TBBffTFdVMxmp3RTn9fhGY5uetUfrrTxUJwds2k/ZiRPd7ZOCSRjN9sLnaj8xNtYTwJyjJbWrbAAo4kjjB+taZxGLxsCTWJVZ9RwyasxDnedTPNq73Qv4y/mfj/B879h0HMxjOZQZHdQiE8Pob9g2Qxu/k5O7StlyQN3vgbm0GaM6j4R+49WXCOhJHvHgHHxgMv3VHR49gbo9mNXaGF+kOTpUuxnAsy+SGvirFlMVPtTbClVerxIkOSgDqdzACyLTTjbmO1XlsNu6zdjlVDLFBuNbFb8BBY+FpawMoMGVNebRnSofZFtg4dtj8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:18:43.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a8e54e-1055-4a18-4aad-08dc31b1e0f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

From: Ashish Kalra <ashish.kalra@amd.com>

During crashkernel boot only pre-allocated crash memory is presented as
E820_TYPE_RAM. This can cause PMD entry mapping unaccepted memory table
to be zapped during phys_pmd_init() as SNP/TDX guest use E820_TYPE_ACPI
to store the unaccepted memory table and pass it between the kernels on
kexec/kdump.

E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
be required by kernel to function properly.

The problem was discovered during debugging kdump for SNP guest. The
unaccepted memory table stored with E820_TYPE_ACPI and passed between
the kernels on kdump was getting zapped as the PMD entry mapping this
is above the E820_TYPE_RAM range for the reserved crashkernel memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/mm/init_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a0dffaca6d2b..207c6dddde0c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -524,7 +524,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
-- 
2.34.1


