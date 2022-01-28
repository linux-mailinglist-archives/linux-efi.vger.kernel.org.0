Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127249FF43
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350873AbiA1RUW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:22 -0500
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:56097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350579AbiA1RTO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDHjIhd5aPPNBgDHrRQY58UFcWVKp/Q2y5fAyN9k1mAIffV9TzLnr88f9x5PBYq6ah2OQxO5bYYSrzVtIm4oLc3AibQpd1fW//roioPaRLkQCNACwXLe0BtgbCxoi5IMzAG1aerzIP1kcQO9a3fQNwegGQFsIF+NRTFPT+WpB1LB8V4LLI9myJS0jEZTfpGWVu8ytxTe3xcxQmXWMTI7J+LbY/pcAdUC0qDiRiQBMAKBG9LFmwbx38s075OERm4au5wwBG2PYHMyJd9/fe5wUvduZwLfIpBoYmuynwSOLQpNFV1ODr+gvDLHpIkViiJxNTXBc9OnOZ1pBklwwC+P6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UyigbC/5OH+gDX5rgjs6WIJN3yoYxn3v7zbUlJYC3Y=;
 b=IhkKS7yEwfQzJumTifHx52oXWL3oSIVK1anbKY3l1dNQrTSTYc6IxAPNu0vvdrRy4oXlFXhql9NeHks2dDTFCJAE76l79pd8ZYYEgPSnK6WQweQVbf3yRJF4jrRXaaIk7sc+0p/z5AWZ+8lLidUWWFEPh6Gdzl48Pvj7EcoXQ7JSGskyDmMU/W9R89uRcYJVpa749d3zdBVxDUW9rgAjdFnlq++dNzFhFOQ5eacrizUymrxEtCc8gV5IqrWiUyBG9YvLvFoonyJgAeGcD+p5quSCHRzFHIwWWQrC4TRmm0+ppwZ6YQeTGzsFJKlgAbqKYD1e9meG783ZSU3YjSH5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UyigbC/5OH+gDX5rgjs6WIJN3yoYxn3v7zbUlJYC3Y=;
 b=tqYeC7BttDmdCOKtpySqVzKsmd7ZO83JkXbGrjFu4FqtPQUd/xHHupk0qV1XRjJ25Apf6jUAL4KEdMlNtRlZTA1L4R2ugQdFVPWF5JIDUuc9krgpeOz1v4JLJOab9QlACN/4my0Yx79r3lSpXIBuKDh+9Z4MqIqQGxRSR9qZdFY=
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 17:19:08 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::c2) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:08 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:06 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 30/43] KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement
Date:   Fri, 28 Jan 2022 11:17:51 -0600
Message-ID: <20220128171804.569796-31-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09a9c17a-176c-4f84-25ab-08d9e2824b3b
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2863D236F4C6F38C74A4D0B1E5229@MN2PR12MB2863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ipjl2PqM4v9w4T4l/rjHJY7vRGoEidyWl7PBJ9RF4tS5npFqU7npJvWoJIdOsZnCwy495kdC6XvfqgQh+STbkeDdt9EB+m6hSFrmxvcEs+kURqlXeecQxA5qTJnSAX0s0SEkx0jpIF2Cs4tq/x6+t5oyGIKwrhwHpbjIFUzOaidaw8DI/lWonFIVEQlCo2K/V4ngfvVaZQZVjqKMv/nydduN/lS842+k0DOo+K8LckJ/QKVsvj9WLhUQ/ZAvUK7HtS5pB9sEBVRVszywgxhpXzocUoOUajFAqR9Mb2crPOaOj8gawMTv65cZgj61EKtjKe7wXAG1ycXKvdWo4yZ40cEab0NzznomqulkS3ACSpPMM0eLWNjT/WzVRCA1rkjnD/SWYuILoNzx0LuV0ps/NeVNorROW2Hb8zCKYgX4uOsFSDlQZc0wafeozQyeWeHVuhO4+UiUeAAlo4I2mNuzLTjxUk+5xJoIgiRcV31/d0yX0py/jo7DdEyUBgpuO8gi1LLT0GVdoyrSgrHJypsyNKuK4Vkrnj9Ks5+Q0934Q3xqUlJqiZCPe0d25Up2pcRSpixDVq1VH8waF/qNwPKaZj4YUnZAhLcgc70YQ0WdXLfEZjb3nGagHXPMRMl7KbPK3xRnGv3IYsZFCf3lp/AxfmsvgOKYmv/OKkWSRTpwJKu1xIykxnxE4yQb8mTsWHBM+aiv6EnoDizyZOY5fTGEuwStWA5mDwp3VA8NlBjAaD884riRI2Zbh+hEnuy/TgQdSSxDMVizAIKmdxEU/zzSK5uwac0lq0OiVk8TPLSj224NG33p3qxxmz+EqROXJMCY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700004)(44832011)(426003)(4326008)(81166007)(316002)(5660300002)(54906003)(70206006)(83380400001)(336012)(70586007)(508600001)(86362001)(26005)(110136005)(186003)(16526019)(82310400004)(8936002)(36860700001)(7696005)(7416002)(2616005)(36756003)(6666004)(8676002)(40460700003)(47076005)(356005)(7406005)(2906002)(1076003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:08.4179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a9c17a-176c-4f84-25ab-08d9e2824b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
index 1c6847fff304..0c72f44cc11a 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -433,6 +433,34 @@ issued by the hypervisor to make the guest ready for execution.
 
 Returns: 0 on success, -negative on error
 
+SEV-SNP CPUID Enforcement
+=========================
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
 References
 ==========
 
-- 
2.25.1

