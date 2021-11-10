Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F163D44CC3A
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhKJWNz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:55 -0500
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:19300
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234068AbhKJWLy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az1J/vaaRMSQ7/2wjxrDGoYeKvY6GmseQHQdBrTlvYqXV/Rm8DTyBSl2hHqO9A2PtdEp3xdrPJcLH8oP7JF8OROAm30FUXEy4m0B8XDVQV5+gfzfuOpj7zHetc2N1v6QjE3S4CnaIRWRxLCV3Uip6Zot1z9t6v9NcbZRLHjJ159TYPSVb577sBK2e+h6Y9x/IrHvci0T6sK5HW6uYet9KdIZzgNwhSw3WzSP1WtLHhHiTZWC7JYG9NM/UP1YWblMfOb3Cau/cCnBrBri+6G7RuXQcFTjVpCRkgoteXay9fop2GQkf3mu/l9lnUVhlTbSVSmxj7zqU1HygPUgkw8WnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USZ7IqSnqGbFTc1ssk0UtidPESKIQlgefBywjBJ+Pto=;
 b=nQ1pXOOhCVlAOnP3UYJi+cUXjHltzQlQdknspWXys8NaFWYXqNoVfUq4pzo59eAoqGG0DAw9iiCdzNKlsRseweBcSwhOztwDeKKW/HyGuWXSdWGwBiYSOgL3Lr6RMSdb73mdEd02D/mHaNr4CXcZXVKyUsgIkAvFEtm1giYgdX+W8B3018HY6uq4I7KgxMj54j/wjsgJvddwvgtdhtPBbCWrzakFOz27AaNqWaO/9PUTeI/Gm8o5EMVrvAQE/+Q/iwSdqHr74Q4dg8dzNH9+zP8m9svVvaGbVGT/drifXF8o2xDtTEGUhcOuhGtD6MdeNUU4FJW4v5e/aUFH017eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USZ7IqSnqGbFTc1ssk0UtidPESKIQlgefBywjBJ+Pto=;
 b=afyEfs/msf4/CVcNI+GepPRj9nLK+UnZyNUv1YN8UJAtUb23u7orG2pzp91X6kDekd96mxTW8yMlYlzTDN/9y/cQ20ehGA7v4eSbkO9i4l9AWU113qZKc2WHM1dtVFoYd5zRaawgI9+rCf4rSEC7pP7dxY+ybgcQ1aRwuOsZvwU=
Received: from DM5PR21CA0001.namprd21.prod.outlook.com (2603:10b6:3:ac::11) by
 BL0PR12MB4612.namprd12.prod.outlook.com (2603:10b6:208:8f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Wed, 10 Nov 2021 22:08:57 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::b9) by DM5PR21CA0001.outlook.office365.com
 (2603:10b6:3:ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:56 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:46 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v7 33/45] KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement
Date:   Wed, 10 Nov 2021 16:07:19 -0600
Message-ID: <20211110220731.2396491-34-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a4c6f45-4b77-4863-e1cb-08d9a496b0d4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4612:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4612FDBBED86874100D88DF5E5939@BL0PR12MB4612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rgn+QORLHy1oJetOjq86/H+y8yMidvLaaEpWKovouHu0hW4Iptk8aNAZfSYFib6BgXm5yhsh9afr1y4z765tg1z/6gCULfGr0AU03kLxqEvzC5ii6mEcZ8aTn9kT2k19LGpyS6IyLwBq1x5tqddyRP/hD4n9pI9n2FmCgc7DgKn/EJ+6E96lSHGOQc+oNIKTKV9aYdu896aDJoIfacjwVpAQaYwE1iyQT/IrG6dPouILxZiYcEK+Oobsual2eHhndLXXRcZqisHuwcd9USVaBohOrHr/RsJjSKkR4M1d5m7LzHc3IUhV0cLzMXQtBapmst6PWuFg6mjxnSgvGjYOmTV1gK/aDts5vvUmxetVwDavALx/uqja1FmPXzQY0o1Dl83qoa7zo23LmK0EQL4AgQxGBAfTu6BT4JSsQ28G04OTG6APhj16GkEuzgHrmMcINw1FkxssxrTAYRoHNXphV0nVbHVN5HeyF7U/MVZMC91e3dNhP1tmvYUI/n8dQpT9dNIbykjnAg0tQpHo827P18BFChemkZWwI2uF2iWROBNTWkUGLKifcMR7V2OqVjZVDBG6it0bLLidrIOTaqlXkXfe5Nwcbw58lIPkcgQFEC4TQ0RSgywL8UJ8VViiykDvgryYzpAGl1z11d/JyNeJIhBBIF20PH4vqPsF3ZE/iwwwV/6R8o2tqH5ApJONfpPBvyBlisEifXUNzzIO3iIwkSa3K2yNvw6qicxQYmeRkNgH5S8ovluZQNlqaRmwGnNo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7416002)(81166007)(8676002)(70586007)(508600001)(86362001)(70206006)(7406005)(7696005)(8936002)(316002)(356005)(110136005)(54906003)(83380400001)(82310400003)(2906002)(5660300002)(4326008)(2616005)(426003)(36860700001)(16526019)(26005)(36756003)(186003)(336012)(44832011)(6666004)(47076005)(1076003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:56.7627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c6f45-4b77-4863-e1cb-08d9a496b0d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4612
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Update the documentation with SEV-SNP CPUID enforcement.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 .../virt/kvm/amd-memory-encryption.rst        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 5c081c8c7164..aa8292fa579a 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -427,6 +427,34 @@ issued by the hypervisor to make the guest ready for execution.
 
 Returns: 0 on success, -negative on error
 
+SEV-SNP CPUID Enforcement
+=========================
+
+SEV-SNP guests can access a special page that contains a table of CPUID values
+that have been validated by the PSP as part of SNP_LAUNCH_UPDATE firmware
+command. It provides the following assurances regarding the validity of CPUID
+values:
+
+ - Its address is obtained via bootloader/firmware (via CC blob), whose
+   binares will be measured as part of the SEV-SNP attestation report.
+ - Its initial state will be encrypted/pvalidated, so attempts to modify
+   it during run-time will be result in garbage being written, or #VC
+   exceptions being generated due to changes in validation state if the
+   hypervisor tries to swap the backing page.
+ - Attempts to bypass PSP checks by hypervisor by using a normal page, or a
+   non-CPUID encrypted page will change the measurement provided by the
+   SEV-SNP attestation report.
+ - The CPUID page contents are *not* measured, but attempts to modify the
+   expected contents of a CPUID page as part of guest initialization will be
+   gated by the PSP CPUID enforcement policy checks performed on the page
+   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
+   implements their own checks of the CPUID values.
+
+It is important to note that this last assurance is only useful if the kernel
+has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
+Otherwise guest owner attestation provides no assurance that the kernel wasn't
+fed incorrect values at some point during boot.
+
 References
 ==========
 
-- 
2.25.1

