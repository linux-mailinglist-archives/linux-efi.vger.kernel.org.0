Return-Path: <linux-efi+bounces-588-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295E85B06F
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 02:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47171F2277E
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 01:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6F200D8;
	Tue, 20 Feb 2024 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iUmFNhDU"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7F1F19B;
	Tue, 20 Feb 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391906; cv=fail; b=tgvY6IGL70PffzyZgoKrq7CH1cY8unJjDSido6Yr6/6Pt0XkiLdWeYF2qXZUcl1T2cziOZuOn2Z/28FbY/cHKjEke8OSK17gga3O63abl0icX04FqXdg/lgurPQK3d1msGKKLAtsCN0L98QQu4LG2frzlh0IYrI4pfhqdsB8GKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391906; c=relaxed/simple;
	bh=Brk4Zt+LEon5VOFv0ZtTFHApqC8oavdlfonRPAZMCUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8B9MQG13VMq9y5Xdt6c0CDf0t9kitJMUjgcI4JWKVxEvKGko0oo2Ea7xA+FII4manc4uNPsZwXmlGqDx/67wHQjdFe12qE8NDHLc/spg2DOEMqgqjy9YVZfB17a4zjm42JTnkD6ykAj3xYkQgMnAPtQju+M+ZOkXlDubswpQxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iUmFNhDU; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGHRIn2qMCanjuTmPfZTHblsAvU0ghKNaff/bpIWTT+eVFOonmU0/TOijkEqHsRDM+PRPIanh38uzJW/CEUGsmaJ4cAUYYnicYpgzolXZ5S39Vk+Eo2o8hNTRJ5bCpBmVM1Y61xZJlvfI1YRAZkDk0JUu1nZHo7UglyRgMlCBQBw0AczQ5tHFHQVSw6Uf6suuTkNppPEWTBEw1m8Ag/rjjKT73b8/ICZNk7facdDr9JIY2mvgsorlA3teXslR9JLByG5bXFkjl7Zxyjt9DLha+g2oYRcQMG5Uy/Hkifvu5PAUKV2WPROeYI32IOUgscnCIHoJt7whWFNlJTmvyIPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/U6sJ0OclzZik6cJmIyKjIWV08AkF1TdBBhLs9duZU=;
 b=aFd4t6SjjZeHT7pc7W7J6RnibyIasRkk4BJnLtrcnPDSQ/D4WUAzNMvhpObvtUuHdKO9VRzERrnODWinUh9qi5epfE0p7bV9SYX08s+MNcl9gZNN+mOsgSNwctQzCqLMZDYG1RX+p4EaXG/S6dmKPpVqf2808zlucYKJCkIpzW/tufQ9/GrfaodkabHUTSPbNTB5KSOwvZ4vv0ZAr0ReE4PDc0oYKOb+z7Pbo5FjPqIQSFgpsozBfSywh00cM7RrjlvVS5c9KgOvfHBSVHDfA++a18U3xEsDbrQKtsaEb9+K8p0vOxx0tinTvlIK+5t0aqRVvZHk/Dywnsu92QTZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/U6sJ0OclzZik6cJmIyKjIWV08AkF1TdBBhLs9duZU=;
 b=iUmFNhDUxPVlyI1A6HviYsEBje214q2BKUVKhK180jvnuMSQBokP8xgCBE+nN1jPAeHRL+7j/Z1crSPWTl81NbeTb+BJXAE9r9FjPuSA2YpmW6qCqfRg3EEm1sciacTgxQwQq8HUnNPS4jGj7FiBgyG04MvPy4jESrpeXfY5d8E=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 01:18:22 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::36) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 01:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Tue, 20 Feb 2024 01:18:22 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 19:18:20 -0600
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
Subject: [PATCH 0/2] x86/snp: Add kexec support
Date: Tue, 20 Feb 2024 01:18:10 +0000
Message-ID: <cover.1708390906.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7703b4ea-04ec-4a23-31d6-08dc31b1d46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K5aW9yopBz87tOv1frRg3BrZkBJRyGlftrn1zom3K6Joeclk1yANloL4GQXhAlcpzD7AXyUTjqvwJ68U+/tGCTo1yITdD1pD6S7oand2XtWRfHCnWzHwhGEzmQ19Gj/Thvst5sREhgKEcTG90dcgW32DjgVDesQjTUEfjeFONOSr7foGI+Nm7qQ1+/ew2wFOnq9aH7DJMlcUyRy3rATUklPIUp4X4O0imlyb2sVMRMohAuMjuXMKQxa85UUAWEi4zJrDkTcW8PnrmGAJ1R3HPUxgQySwGf7kXb/jiCv9ul1O2Jc6mDWYFLeqQ6Cc/g18kv6Nd/bZRddinfvupqw0+i9fc0CT+eO3z/stg2f5a6ZZHCG6LF5X9TWRakQuDRLxtEkWvZb8ybfjm8Sn5PvmNauqFBcgal3Fb3wHHFq3j9j4lII48/VJaBCG0gx4rIYBodCuRUa+5w10uTijrdYoN1XOADkG8J28dGHP1PAXY60wyDBuTjJsFx5cUyFIgFhCppiDGsVrI1VIyAWf8ggt2icP3How65QkpSNAOiEpV5iW5KxmR9iXXbtvHkNYuCHfgj5IECFWAR1Hgus8v7CgaFf7jOl1BiW45jd8L7TEQ8Errd9mxNqAVzUW55FYgBUfELvXs7bNPMEsYdnjRyQjMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:18:22.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7703b4ea-04ec-4a23-31d6-08dc31b1d46f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires [1] for chained guest kexec to work correctly.

[1]: https://lore.kernel.org/lkml/20240219225451.787816-1-Ashish.Kalra@amd.com/

Ashish Kalra (2):
  x86/mm: Do not zap PMD entry mapping unaccepted memory table during
    kdump.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/include/asm/probe_roms.h |   1 +
 arch/x86/include/asm/sev.h        |   8 ++
 arch/x86/kernel/probe_roms.c      |  16 +++
 arch/x86/kernel/sev.c             | 211 ++++++++++++++++++++++++++++++
 arch/x86/mm/init_64.c             |   4 +-
 arch/x86/mm/mem_encrypt_amd.c     |  18 ++-
 6 files changed, 256 insertions(+), 2 deletions(-)

-- 
2.34.1


