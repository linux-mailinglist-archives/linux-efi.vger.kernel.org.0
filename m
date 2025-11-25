Return-Path: <linux-efi+bounces-5681-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4274AC865B2
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145BA3B280A
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070032AADF;
	Tue, 25 Nov 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l3/EU2fo"
X-Original-To: linux-efi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545D32ABCF;
	Tue, 25 Nov 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093490; cv=fail; b=oKTJkixdVa5rPuZJ0y8eh20+yuLaN7CC26Eu/LyGqXAHxSWC647tF5CSJAF4pm6LFnX3YBtYurXVvaYW1VY8aKjVEZg2h53IoeRMJQ+jkX88ExQnuVbogLuIW4lewZtgNGccBFa5lcvSGCTqZYLV8anPLnIYNe8NtaNabyq/Gfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093490; c=relaxed/simple;
	bh=zunOsLhk/nK2UV33Nj7opg6eVmVx1EXTy10PhNl/1Ac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X0/Xx9Jjv+fHyTXK8OpMSiYOzrALF7w9sR1VzLHAJZEcwFCvHUfePP/uEvnJDWKEOXed1HkDZgWxO9iT5aIT7vbunCy4TE8QbYSq0TrZj6Dbd/wPc3LF7ouvZyeKRmnEJmbSDMlQOj8r6Y2HYERvuIBiZC7F5WfopRcOGSStptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l3/EU2fo; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAfdnPYhMC+fUQHTlSjT1Jv2pOODm5rdAPz9+NvEqJVxfBxMo+rg2ir7/aZghczAHQGGtGqDUQVuHQYgcicqR9wFF0rGWtL9Bvj3i4arx56eJF1rlYlpMZ1zIdsrBnCnjdtnycpCUCLd7otvCg3PdbvW/0iewofrMsN9CXv8kuSmYiN/+ah3oYqMV2eU4tYO3SGagIzYCDgpD8Ct3d+TCZO3mYzCO0dnRfjR2nIw8vphYesNkdgikSd5iLP5+VB0mCGePv4DH9bkQEqwDJ/+eicQ4L0DemTJrtNgXHMIC5PIPLwJi8TRT6fbWaBH+u+oWjpisFPcPl8XMn6JK2QdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp4OsSPxeDDE9xmIFKoGl6JcfucAwCyyuiFLWEoMc3I=;
 b=YOJ4bQdI9qW9ofeNa7/GrVxDFcTwHXui5ygcdhdyRrrgrXr5MSJPbOMOjAckgmSzW+O2ORdrt7pZzMEA+hoWs9NlVTi7dO4lUbhuz4rNi28LmuofC4G1kMWYaIs+jkOZZSjwO7yBdU6x6MLdETME6zGUcH0pfnYhHqsIa60lGqG5eS+ORso0rRvR9IlBhyTcmK9JOOCg/9q5lX1emIOZNtyBWCwgiVPrAt25Lf9IvKh93539x7V9o9bSBclnhtkQuurq/WSx3n80nFZb126qw3CnrWgoyJJfSDk1gkPNkZhI5x3ruFvOFIB5/48uGlp/QUpHQP7Zp5yxfHMKpr1fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp4OsSPxeDDE9xmIFKoGl6JcfucAwCyyuiFLWEoMc3I=;
 b=l3/EU2fo+vNeuWhjdvkTnnRjyLOqHsq6QU7kPlq67BzA/p+pgkxuWiZpv2vqW65v8lWzd9cV+KOB7bOpnorpPS5kS1kWbu9tljyUbQYUUsgh5K2VC2F8MnXyBvegBD3GTzTUc9E8w5cwl0ywr4YiOcHfnUACF4gWymiHuZuWuow=
Received: from PH8PR21CA0004.namprd21.prod.outlook.com (2603:10b6:510:2ce::11)
 by SA5PPFF1E6547B5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 17:58:04 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::e7) by PH8PR21CA0004.outlook.office365.com
 (2603:10b6:510:2ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Tue,
 25 Nov 2025 17:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:58:03 +0000
Received: from ellora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 11:57:59 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-mm@kvack.org>, <linux-coco@lists.linux.dev>,
	<linux-efi@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <kas@kernel.org>, <ardb@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <prsampat@amd.com>
Subject: [RFC PATCH 0/4] SEV-SNP Unaccepted Memory Hotplug
Date: Tue, 25 Nov 2025 11:57:49 -0600
Message-ID: <20251125175753.1428857-1-prsampat@amd.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA5PPFF1E6547B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 86353bbc-e21d-485a-da2c-08de2c4c2e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICdtxo97eixVfgU7GbQyGO7soaZG37jKvMrV9s8njsT00t3cxyCv4DYLAlB1?=
 =?us-ascii?Q?v3dVgpVQC6DOuipUuvxhv6nw+DxCltfMJO1bwS/m1P1K/Ia26GH5bPfFAIxl?=
 =?us-ascii?Q?jMYXOHV2YDXGWbvlw7E/PhVIDxZWmE2glVdTB7DpCNfbALZZ2fPeEYLw9ex0?=
 =?us-ascii?Q?ZwVk8SulEeiDGz4W+3S/0OGsMIV+99+eN3VVqfpvFq1SECnKnwt6CxUfGsLe?=
 =?us-ascii?Q?OAW7iaf0Voa6ah2WHg+ExoXa/A0f1vXbmZiPRHZ9SQAJ+ViCJERXJ//Kf9dj?=
 =?us-ascii?Q?AGpanz6TGXuvweNCHgWnDkQaedRJTi+CEHvc7alAR78tOxxdA90V0vO+CGKr?=
 =?us-ascii?Q?ZPGce3LMBYRHctDBBltWZAhIw0RQn8wVULK3Ct+f7JY9x0U3872nlFnKgLua?=
 =?us-ascii?Q?v5Xq1c9Pi9dY37qO2/bflB4l6Qe5o0zlQ7Fjvu7Q4zubrsyATXWyz/CCphDb?=
 =?us-ascii?Q?Pe7DJR8tmjWWui47bAkP4TnNNn6RUoO1Va76NthU7+NtmX63l8M/lpB5KHCW?=
 =?us-ascii?Q?gA/+BziWtJ3kc+zTNDOse7Z6qySSJyBZAfHQapS3JoBsdla1t9fkKmUQW/VU?=
 =?us-ascii?Q?b4kimoGwvTcZkGgMo3HCOrMy29tAttUNdKITTqW1Vngl90FT+ZA9DouXCbmp?=
 =?us-ascii?Q?SedyPkbJqKe9BWW4hIiSTvZdfxq2qPMEY9KaY2+P3l6ujW0Z181Y0tCh+VUm?=
 =?us-ascii?Q?wx4lIRIQVH8xgkZ8567xe1qbow8rFMFW3CloozdCNuAWMKpbSGrQDNVigjZ+?=
 =?us-ascii?Q?vUJpjugrAQkKlHCGTjM5GYUKB8VCk1dgF4f+GHVCuqdDNG8Ejz5DE4DJfdoI?=
 =?us-ascii?Q?Z3FHZ8dyK5sDokVKVaxsbGwqJbrzmBt1WCZA+tS36bd8ubH38ylxIbdt9GbN?=
 =?us-ascii?Q?pf54bM7ubOhKPHSivjok8jZ5lUBaSUox4K0R3NMfFLcrZA4QJo7zOkwOjJM2?=
 =?us-ascii?Q?OlIigZ5EYYcoZArSWAWjw75EdOKISPCgpvFazC9m1XOXXFZmrgNh/nMpX9nY?=
 =?us-ascii?Q?s9OSwGLwYvjAeuMWq0jfLSrEXOGEmVUPXXBj/oRdkh4OyFI3fZG4fJQ6FtYf?=
 =?us-ascii?Q?N2sE+i7bAYBdXnN3+BgJqiaVFg9SZhyOYNgQkLgbtM181plt6te8Cg+0LBXG?=
 =?us-ascii?Q?YtuSDB7m8pGIhusApfsa2P2ASeEWnbarCsIH65DLmT2t6CejuXMrSbg0FBfs?=
 =?us-ascii?Q?Ph+21vr8BxKT3oL3P6t4l7hdWexSura1PX+g8eyZPLO2fQF86Yl6gDeBhp1/?=
 =?us-ascii?Q?apX8PjLRVZ3UCeywvcNgEqu7ZQUamgiTCCVCcgr0bZYsoOWOaKsJUJThIyZC?=
 =?us-ascii?Q?rQhiTGapaJOx/ZbnxMVmcCVfOq/FYXBznNDC7UevqgIFjx7m4jj3bc//we0w?=
 =?us-ascii?Q?+UYZhO8ARhx1DndivSUoIzd7+eY93OyRFuqOovYMzmQo5UOuG9Rps9GJaAIp?=
 =?us-ascii?Q?1U42lzqWHOmkNIqfsysI5MAxAKBPS/JdDvOLJ7JPZ310WdRSGNTtn/zErUF/?=
 =?us-ascii?Q?Y7kOMsDA+/DTqJUFF8VXxhC+nYehF+ZvVlH5iI6AJWLcn1EOYFTuNxYlNvy9?=
 =?us-ascii?Q?q6AJtzfMzUEmnQTk4rk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:58:03.3640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86353bbc-e21d-485a-da2c-08de2c4c2e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF1E6547B5

Guest memory hot-plug/remove via the QEMU monitor is used by virtual
machines to dynamically scale the memory capacity of a system with
virtually zero downtime to the guest. For confidential VMs, memory has
to be first accepted before it can be used.

The unaccepted memory feature provides a mechanism to accept memory
either up-front or right before it is needed. The unaccepted table that
tracks this information is allocated and memory block reserved at boot
time. For memory hotplug, this means the table cannot be updated to
track additional regions and accept them as the guest physical memory
grows.

This proof-of-concept series extends the unaccepted memory
infrastructure to support memory hotplug and hot-unplug on the SNP
platform. On a high-level, it does so by decoupling the memory bitmap
from the unaccepted table so that kernel can manage bitmap when memory
is added. For hot-remove, it reverts the page states so that the
hypervisor can reuse that memory. Hot-remove also presents a unique
scenario where the memory we attempt to share can already be in a shared
state set externally which can cause pvalidation on the platform to fail
since no updates were made to the validated bit. Handle this case by
tracking the state of hotplugged memory within the guest and disallow
pvalidate operations on the same state.

Usage (for SNP guests)
----------------------
Step1: Spawn a QEMU SNP guest with the additional parameter of slots and
maximum possible memory, along with the initial memory as below:
"-m X,slots=Y,maxmem=Z".

Use the "accept_memory=[eager|lazy]" kernel command-line parameter to
specify whether hotplugged memory should be accepted immediately upon
addition or only when first accessed. By default, lazy acceptance is
used.

Step2: Once the guest is booted, launch the qemu monitor and hotplug
the memory as follows:
(qemu) object_add memory-backend-memfd,id=mem1,size=1G
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1

Step3: If using auto-onlining by either:
    a) echo online > /sys/devices/system/memory/auto_online_blocks, OR
    b) enable CONFIG_MHP_DEFAULT_ONLINE_TYPE_* while compiling kernel
Memory should show up automatically.

Otherwise, memory can also be onlined by echoing 1 to the newly added
blocks in: /sys/devices/system/memory/memoryXX/online

Step4: If accept_memory is set to eager, all memory is accepted
immediately. Otherwise, memory is accepted on access. For the latter,
acceptance can be triggered by simply running a program such as
stress-ng that requests enough memory to cover the newly allocated
hotplugged regions.

$ stress-ng --vm 1 --vm-bytes={X}G -t {T}s

Step5: memory can be hot-removed using the qemu monitor using:
(qemu) device_remove dimm1
(qemu) object_remove mem1

Tip: Enable the kvm_convert_memory event in QEMU to observe memory
conversions between private and shared during hotplug/remove.

The series is based on
        git.kernel.org/pub/scm/virt/kvm/kvm.git next

Comments and feedback appreciated!

Pratik R. Sampat (4):
  efi/libstub: Decouple memory bitmap from the unaccepted table
  mm: Add support for unaccepted memory hotplug
  x86/sev: Introduce hotplug-aware SNP page state validation
  mm: Add support for unaccepted memory hot-remove

 arch/x86/boot/compressed/efi.h                |   3 +-
 arch/x86/coco/sev/core.c                      | 127 +++++++++++++++-
 arch/x86/include/asm/sev.h                    |  34 +++++
 arch/x86/include/asm/unaccepted_memory.h      |  31 ++++
 .../firmware/efi/libstub/unaccepted_memory.c  |  12 +-
 drivers/firmware/efi/unaccepted_memory.c      | 139 +++++++++++++++++-
 include/linux/efi.h                           |   3 +-
 include/linux/mm.h                            |  18 +++
 mm/memory_hotplug.c                           |   9 ++
 mm/page_alloc.c                               |   2 +
 10 files changed, 363 insertions(+), 15 deletions(-)

-- 
2.51.1


