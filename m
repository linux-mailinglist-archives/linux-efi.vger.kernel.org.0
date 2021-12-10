Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD15947047C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbhLJPsv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:51 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:34273
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243482AbhLJPsM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czHA4wI3o5rGSYNAHlK8RLMRfUcb+00tQB1yD3PchSsgcc8dmzC3DKEUWrp0wY+fO3uG3mRK0P/7n1aaF68xS0P9zCE7aCAWRbTkZT7z4JDY8IjLm8/3jNZSmiW+JxVzflz+ro+4R1QkxbAyB6uqHv8jwbNBOZoqJybCjq+d9d/V9o5udczq4ux7IjPefNYnb31XN3N6OoBpObF9v6yVnLxeIYYb5cjNTk9g0rDYacTnz7KBmOwkDU2izz/dRDTl04aMCwUHAvLFM4N/cPtL+9bu+aw/iTZLsFiEXZ+YbQ7GT0WSVT3E1356uMv3gpyksmUYZnpYEmfUJQ32brkReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USZ7IqSnqGbFTc1ssk0UtidPESKIQlgefBywjBJ+Pto=;
 b=Jv+KOPp72DhfTaf5mW/F+MECm2GlprJXe0hZ6sD2m559qWSIupV1VxTRuf8pJ1HVGjxGszcBnY8itV2ycctQyud8vPHrSmEW5Fl0QByyyzuIldTXElfx5xXNTVwm9rajXKgvs+KewIovznhZ99tuw+LxUqZ/PlwLbr0xSeQuBr31oe4kUJgKg0VMcKTvWIRq7LdtqFQ9ZZGv9vLnk9JIq+G0LzjxP8ao1O//+OuBijirdwki8Fr3VcOrZDmXqT/u986vvjil0kG9GJkmKwlAYgXMQINr+MNSYGxCcg/de1OcKdyRISbnPRUCz2fnGz8iWaQhYJRY2tpG/+JHIqE8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USZ7IqSnqGbFTc1ssk0UtidPESKIQlgefBywjBJ+Pto=;
 b=i9/Hcmm1dlvd30/xn6INtR6e++IM9xrQWh508GNFHW40UZ/UF1ewi9PZ1h38MHIaeb5uq43zLRhdEvSvoXIuXlaW8IPh+gNBXR2K67gFAsgsMgM9FWQg2ms/hiF/6VG3ATCpk6vPQfJaZ6jbp5xDHvf/Z/3YLNRWz35fbB/jx+I=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:44:34 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::cb) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:34 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:32 -0600
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
Subject: [PATCH v8 28/40] KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement
Date:   Fri, 10 Dec 2021 09:43:20 -0600
Message-ID: <20211210154332.11526-29-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ff5ff79-c7f7-4324-0646-08d9bbf3f6e5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4211:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42113A78A966F5F18CE72342E5719@BY5PR12MB4211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jseMMkpdqSjfprkN1waj40PyXwys0+WrOM3TS3p0l4EMSnwkmALbpqrTR06KY5x++Hqkbe1q8eDt26wx5rPIe3Jkfr6Lm3gJ6mHPDbF6011vPO2YEEkzP9rV/vPjWAVcsrdSoubMgjis80doI1ZFgbwjwbEbdMMbsvu2/wDEOHRCANAkVgTpb+IiHz4iKJmG3S0tYowyljUO88iwfQgiC2ABqX7Ylf6wBmpzk4BUDsQCcnMemaWi/id76GWnzXduVwb54hYJARkl29FL6eOLjmrTYD3WcedlGwplx8KT5ZR1M2y99h3ChPQ9rJsJVgiorQA1Lqt9blcEN+ZXWUt00SfyK7Vm9xDwypDMsib+d0Y81ep2gHjAVK+dwdB+koG1jpEgzWVUbKBCx7U6JUQ3syFOyojM4e1j0tStoAOSMcYcPNlz5swMmYVfgJDjs632nzQ1Mgg4ey1JIZ4t6JTuPFGIa5AElzzQcFIG/qJCahw8qb2JIkPVWLXzZVhwTM5/lozwO4Usanu/2k56AgzbFYiC+4jPEdual5jKkFLvF/vCVbQqEg6UkFj93kLqlEsVdMhwu4GdPH/FQ1h3OTN55d3LgBoOUCl5mnjutQvZAJ47vZU0P2lUX5mv4qyErLi29mN/5rZq0avoHNN9p8/K28IxrLKzCZsUAihZjOWRuu/i78z/5p9ri14RSKYp6dwe29UKEJkKAhMzVv1Rn84OwhScdH6FERkpMiTV/TlJsQukhGZTo/VDYaOyF41qbSyCdxlLEbE1saUmU+MwAU9ULX2E001qfynxXNpDXjKi8tp/Z/SbANl0ZUaG10pdTeyG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(508600001)(47076005)(1076003)(6666004)(2906002)(81166007)(316002)(82310400004)(356005)(36756003)(110136005)(40460700001)(54906003)(44832011)(2616005)(426003)(83380400001)(186003)(16526019)(336012)(26005)(70206006)(70586007)(7696005)(36860700001)(4326008)(5660300002)(8676002)(7406005)(7416002)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:34.2818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff5ff79-c7f7-4324-0646-08d9bbf3f6e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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

