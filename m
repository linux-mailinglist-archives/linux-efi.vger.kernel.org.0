Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D844704A8
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbhLJPtg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:36 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:23809
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243628AbhLJPs0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqwwB+Vy387Cb9F7CA5rm0u/OMQNzqBv+xcePOSRYPkeXhffSw3s9Ix9Cb8FAcRU2wln0Hafhizk8R3DHcF3N4sohaOgL72BZ0kyzW6zMea7B+waSGCC424k0l/brHo6ZXFrNUZAnHDFh8PIk5SGAQxKrhCKAikPevhvIenkU9jRiIMTjgfbqujfbFW6C2RJ8UooBI2WFgULEeWhyaOxttZ3CuR7KAbbLh10t2Sk+Qvd3EuSOka4S81SHQ9NCcvhUfQxMeUjI7xML5gwwhsJLWVvJaTmBpQMt+SaWMJQi/Yl3nR44cJ19GjzR3o7xsUd7dLUic7IyXntx0RXcUYEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GejiJvRquzaZ/jH8gcWW/ctDe+J8poV69Uwy20M0BeY=;
 b=eY37eaZcP3Hb7+UOb77jWKpvTxI1JObQwVE14qUz0QNRNuW87izrAO1LVjuOShWE+fd4ErmcAI4bLTaaqyed6RKIOIUstEDAEb6dn99C1QhblneoK8ccJ5+B7HbgTJ0nQUcWLUGDmWzWUWinmT44uvjSH3SVUVZzfA4K2B9ddi7s6AusgU6R+YT+i/17+26hbQYIEvNDQsnQZzXIdqvLvTStdroqKrX+jqQm4LD2cwjKw1TbCw06zzzuU/lFRY7fA2WRhh2pAZ+22FfUKQ6XjAM/HRVlwqq4kx7QUpk0rJrNeSKsolTIWySjw/5Cvh3WUHQMiV5l+OoTUPdUKEugAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GejiJvRquzaZ/jH8gcWW/ctDe+J8poV69Uwy20M0BeY=;
 b=WQWcSMsF5lv5/enNKKEGKL+FB4FyHAAd6bKAnlGZ2WvL68PRZEzsv3Xawsmm99a7Dcxwp3B3Q/LYDrI5Q/wybscWE8a3ed73Fvua4oj0kvrK7lzPDcJyhH35KcUIRZwkzu9WjhxM2EEkbs4O4TkFQUDagmPoppsX3X2OU2osNBg=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by DM6PR12MB4793.namprd12.prod.outlook.com (2603:10b6:5:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 15:44:49 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::68) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:49 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:46 -0600
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
Subject: [PATCH v8 37/40] x86/sev: Register SNP guest request platform device
Date:   Fri, 10 Dec 2021 09:43:29 -0600
Message-ID: <20211210154332.11526-38-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04595ecd-eeef-4a28-fb3a-08d9bbf3ffb9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4793:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47938C7493A454E6439D87CDE5719@DM6PR12MB4793.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZW4EblUpYq0JWGpTGMP9Xmo4ztF3sTlor6w46IqI6OiVtUXmGivqMPMo3/rKhhXJkvqO/u5LD+8A0DBht1xIngvmBAhnJD3LQtPg4buyBZJTih5Fes5N/0LO2zwHXHXUDJUCUYQyoma0EzHoBvpwOwVdcsO93YyeSuUEu5hjB99vlkSjGVLJg9YmDBKT15YCQ2oSXLml0Z4NtkiwgVeHiyFWqdyqCe7RqZZiSwTyJTm44wk7SzP2bFERAEQ/jBIp4Lo5cBeD2jq8XzU6DKjQS2r90jiO7KmJrr3Kc5YmX8pAMQW95CwcStbmlJTnme5CwpDYk275Yj5WxFkDXzbvpefQ/DhPlUazgeWCq3KM6UFFzs/RC8hXcVbpmqHTn64Kn3jcuvUvSnnbkK7ynpS/2Dpnq2mVkGqvaYK3nSH89R3hxuiFOgLdcNcsuv4ZGetnwrN+CDOPyWbTsTsm1UqPp2AI4LNkoVbF6TsrlLjsnul3n0B/I7ztacsZk2gA5oDzYuVPFGm46MMBKkf8zoWy+LnWcE/xOXSLGPA1bXoZ3oh0jfXkK+YVN+wIuP307Xajpqdr1ViQBudvEMXi8rnxtu7SoICGwlPGSACbuTEtxVtt3sFSOUNjgjqStqMIKp2VAhkeXgDX6mwYcoKoexTZNxRTDqqqYahJ05FZ2DmI1Sll+dQ90io/OXv7m+tu6al8QmS0I1h7BtnXAPJhg6BY3UexL9sVu3eJ7hEK0D7PCcm6l+gzRm8mvY9S015vS7qoa+5X30AyekJsjbA5BTuTRNB3yQPb29oQglom5HPkd3y1z18mltXFro+cBHVOg+E
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(316002)(36860700001)(508600001)(2616005)(36756003)(1076003)(40460700001)(81166007)(2906002)(336012)(70586007)(8936002)(70206006)(83380400001)(47076005)(110136005)(356005)(426003)(54906003)(26005)(5660300002)(7696005)(82310400004)(7406005)(7416002)(16526019)(4326008)(44832011)(6666004)(86362001)(8676002)(186003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:49.0992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04595ecd-eeef-4a28-fb3a-08d9bbf3ffb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4793
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides Non Automatic Exit (NAE) that can
be used by the SNP guest to communicate with the PSP without risk from a
malicious hypervisor who wishes to read, alter, drop or replay the messages
sent.

SNP_LAUNCH_UPDATE can insert two special pages into the guest’s memory:
the secrets page and the CPUID page. The PSP firmware populate the contents
of the secrets page. The secrets page contains encryption keys used by the
guest to interact with the firmware. Because the secrets page is encrypted
with the guest’s memory encryption key, the hypervisor cannot read the keys.
See SNP FW ABI spec for further details about the secrets page.

Create a platform device that the SNP guest driver can bind to get the
platform resources such as encryption key and message id to use to
communicate with the PSP. The SNP guest driver provides a userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  4 +++
 arch/x86/kernel/sev.c      | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a47fa0f2547e..7a5934af9d47 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -89,6 +89,10 @@ struct snp_req_data {
 	unsigned int data_npages;
 };
 
+struct snp_guest_platform_data {
+	u64 secrets_gpa;
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 289f93e1ab80..bb33e880a1fa 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -34,6 +37,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid.h>
+#include <asm/setup.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -2102,3 +2106,60 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device guest_req_device = {
+	.name		= "snp-guest",
+	.id		= -1,
+};
+
+static u64 get_secrets_page(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static int __init init_snp_platform_device(void)
+{
+	struct snp_guest_platform_data data;
+	u64 gpa;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return -ENODEV;
+
+	gpa = get_secrets_page();
+	if (!gpa)
+		return -ENODEV;
+
+	data.secrets_gpa = gpa;
+	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
+		goto e_fail;
+
+	if (platform_device_register(&guest_req_device))
+		goto e_fail;
+
+	pr_info("SNP guest platform device initialized.\n");
+	return 0;
+
+e_fail:
+	pr_err("Failed to initialize SNP guest device\n");
+	return -ENODEV;
+}
+device_initcall(init_snp_platform_device);
-- 
2.25.1

