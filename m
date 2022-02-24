Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD76F4C3311
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiBXRCg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiBXRCY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:02:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE5793BD;
        Thu, 24 Feb 2022 08:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHQk9g6C1Vs6wkguT2p62cBTqgZmWPA3X+PVZnrfHoSt8v81Pxql58XSLDkbOuk+FyRFIk5ETgkFFOOWCGJRczdxSCpuj6vHbUfV44Omq0IykiB/N9Zqsn6FaRlSx6SLSphxNexUq1D2VIs3VY3A3jGrCnK7KdrskgmeIUCNTM5JeuUZwWZhdtCsL+rGoqmOO++7IFGnd9NY3JffrhhFADHwrDtpiZHdhSkSkpvNdpS0K3btp2+hPHDkgBsqXt+By1onSEmGcwRQ5qr6UgyoJfB/IyF1F78G6oLAv6x9nHyea8qPzPKLlFEQ20RNKKShPP4fipul7w3pNeO1TEPBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbvaTYmaqxdr+kYYkpTp/E6MXTk5T4w/SS2QoHRoiF4=;
 b=DGfw0UPdd3Yv7MEJz5deti9m1eRGK9EYXt3dxPNdNuaAvDkZw+ulXoRpFcTuhtIuufPkyfFqfFmo4iPHmujPAKv9PW8fAFT4TXDIfffJybTw1FsR4FK9/H8EWsEPuHbyjUHOBnKbUiyjVWVUeiJQ5jL2r0Nm3VLrH0Z2IM9/+WSaBwABKGql7hAqCwfKKC0RYR3/mOWQZfrO2aQMob88z84/XwFcF5k8obsAJzj0w6nZwaTFHscUQX2GoYwh9LJCrPqqt6A8UW/kOppkI06r4TQ893quXUP/5ZpyXOrYIUYGz2tMVMThLfeU5O18FCzWrFk6EBkj0qrsre7gp9nTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbvaTYmaqxdr+kYYkpTp/E6MXTk5T4w/SS2QoHRoiF4=;
 b=B+wSRBWRJ5hZrTLAJ2GWHAVm9IK3qynSdoyVNBRYI1QtNm4ZhoF/IHpS/Y8N5eA0yvAqh1vChbJZB9W4u778GXzKMjZdP6of25YoSIN2KWrryNsbfyAsHSLl7o56nNR9PTqcmtbmQzAb23sC2A3NcF2evfw3ApfU0VIOx7feDOM=
Received: from DM5PR13CA0046.namprd13.prod.outlook.com (2603:10b6:3:7b::32) by
 BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Thu, 24 Feb 2022 16:59:15 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::c9) by DM5PR13CA0046.outlook.office365.com
 (2603:10b6:3:7b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:59:14 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:59:11 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v11 45/45] virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement
Date:   Thu, 24 Feb 2022 10:56:25 -0600
Message-ID: <20220224165625.2175020-46-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aefc08b-9bea-4e07-037a-08d9f7b6fc90
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2514B7AF55CF351B596D867AE53D9@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PM4fly/+FQ6FsUXRLeuEXR3vYtiFtqswb+DtfMIlweBk8+aC/o8maJYMZQA22woGeNxzU49qjSN9HNdYVsiXUD4bYXNh0SCFkOPGRZSEG7WtHVhY/sKUS/3YXzM/SY9XIbWzgMUf7F+iVNEeIxYxQX9vRn1m41VI1ggAF3HBK8NxN280CFur3gud0y0koHL1K6uQlU0arAN/JMbRarWuO9UsGx/eCD2y47glWW+Kf+ELWudZHK/W9nsPeECFy8YahrVlBL+eSDnjI4d438YB0JdR9q6GDXrWACE35a5ppK6OCwIWi+F6hgLvKr1LEgyWIs8Sija9yPMeRaNqYBtRXy1eXYlcBIQwISmB8kr2/8sN1+NC2RE/tOv85XDOV0jZ17rmnL1T1wO0QJ9chZZcI4T42RZhiWkFsZe+ahTpSc2LHOpiymffeaysIkza4m9wA05hdMZ6x66ejGH2b+yUYQm4eGwcHWgNrDrQL4Xh/1kPtdEBf1C5GrT8FMsxoVvdA6krpt+Y9EYQ2JFoCIvBxqF2hjXchc46x5HGDI44uGgb8yFPZMJuczN+/ABnZzpOCS65uV+c9qUBYxC2Usk+eo4LukmdRokp+CDejhU70IZvEWvdezFvwkWKozIcbH9k1EGGvEV4oo/O/dCfBHoHIgTge6rfhEGU2GK6lPjn/DYU1ABs7/fR9g6dZ1fVFX2X3nL3AX/oWNV0SXbj8YOe85Kmh68c5zpeJe/gCqJUB0Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(356005)(316002)(426003)(36860700001)(40460700003)(336012)(26005)(2616005)(1076003)(186003)(54906003)(110136005)(81166007)(2906002)(7416002)(4326008)(86362001)(82310400004)(7406005)(70206006)(7696005)(8676002)(8936002)(5660300002)(508600001)(16526019)(36756003)(83380400001)(44832011)(70586007)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:59:14.1947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aefc08b-9bea-4e07-037a-08d9f7b6fc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Update the documentation with information regarding SEV-SNP CPUID
Enforcement details and what sort of assurances it provides to guests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 0f352056572d..48d66e10305b 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -118,6 +118,35 @@ be updated with the expected value.
 
 See GHCB specification for further detail on how to parse the certificate blob.
 
+3. SEV-SNP CPUID Enforcement
+============================
+
+SEV-SNP guests can access a special page that contains a table of CPUID values
+that have been validated by the PSP as part of the SNP_LAUNCH_UPDATE firmware
+command. It provides the following assurances regarding the validity of CPUID
+values:
+
+ - Its address is obtained via bootloader/firmware (via CC blob), and those
+   binaries will be measured as part of the SEV-SNP attestation report.
+ - Its initial state will be encrypted/pvalidated, so attempts to modify
+   it during run-time will result in garbage being written, or #VC exceptions
+   being generated due to changes in validation state if the hypervisor tries
+   to swap the backing page.
+ - Attempts to bypass PSP checks by the hypervisor by using a normal page, or
+   a non-CPUID encrypted page will change the measurement provided by the
+   SEV-SNP attestation report.
+ - The CPUID page contents are *not* measured, but attempts to modify the
+   expected contents of a CPUID page as part of guest initialization will be
+   gated by the PSP CPUID enforcement policy checks performed on the page
+   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
+   implements their own checks of the CPUID values.
+
+It is important to note that this last assurance is only useful if the kernel
+has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
+Otherwise, guest owner attestation provides no assurance that the kernel wasn't
+fed incorrect values at some point during boot.
+
+
 Reference
 ---------
 
-- 
2.25.1

