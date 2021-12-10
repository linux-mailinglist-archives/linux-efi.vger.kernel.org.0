Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF3470492
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbhLJPtP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:15 -0500
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:5089
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243506AbhLJPsO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbfOf0JxYCp3ILZHMx64rE6j/H2JSTytgZqo0c+nvPbkVhjHXJ3JC2gBEox+8GbI3kfSOCOOBlHs1wu8MHP9gxvqfk/5xN8FhUw1+oBXKpOhWLoKvOxdo/TFQvInoMt8R0NIuub/LBCMQye+OgJARvVDv8YFHj7emRLrBOBl/i0oiVmXEGwB33yw91F8rh4yCVwb3zy4MzbWt7xaytlO/rMh9YH4Oy4Y5b12ba1EjHqloBkKS+xGJGcqW7q7gpznjDhABH+o45KI8ZqJQ7i53DB3JijQ1B+9wZRzuQPxLgDg96cFPn/ERbmqyTJ7iwzDWGKmgYHYXkhFWacEEM513Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=jttTD7+Yg6fqFP9xca5ys+XCO612KxKiP1j6+9PrSvkqJhJOleaMdfc7UXApOOhgyJnpHgkp0dGUSOb72TzmM79197wiKEAVqzTjhW0c66JzU/Td0St211+FxjEb29fHHxjYawmbObBQ0tzw1AzPu9gJQ8zRS1pIRrRna9cGsYfyEMzN5dPrmQm+Bu82A3sgaJ+t/idNooyTYy6YoCTM1cWzZ2PHD322g8wUlUjYPIPoP5eQsBaXEXTU4Sxhm6fLwdXsifccsd7e+m8V0JaS6sHbmVwGtCoT4AxMH6aAFqURT+Gl61KfGoF8QSA/t6qzFoT6o/z8JRjXrPiipLNwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=qG+kDzla+jpfE64TkAHyg4rhV2wPSCWrieNjCqofPZnviSebO6uVUi2LuefFeDsYDb4NM6+to1qpjaXY3ItHFIiIdC+XaOCU1kpy7ZIgwTeOWlehS6pTwpVDV+NDggKZ1lr5NH5wz+v9GUa2dvSfyT64u7rrcnYHAxHHpLUaXqU=
Received: from BN8PR16CA0023.namprd16.prod.outlook.com (2603:10b6:408:4c::36)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:44:37 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::d1) by BN8PR16CA0023.outlook.office365.com
 (2603:10b6:408:4c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:35 -0600
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
Subject: [PATCH v8 30/40] x86/boot: add a pointer to Confidential Computing blob in bootparams
Date:   Fri, 10 Dec 2021 09:43:22 -0600
Message-ID: <20211210154332.11526-31-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f3b083b-a4b9-4a07-372f-08d9bbf3f8d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4137F31354D2B8AF7A51B8E2E5719@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3wqe+moGk8broJ6CjwfkAcNRnIoSSbz6c3cTvxG7wRLfuARSxD4N4jPNNcnRoq6urTgqWOERP6YNkTnlzYLi6MBGYWdIfL4rSsQ76J52W+hlDKtaxfzfspILO8y3/272WsTU9lb6qFgBLLy555cxAH6NBCsgYE3+aoAdgA8y5uGAYC0eOoS+m6cv1GT/5cJ6vSQHP0bQgblBfwZinBc2PFpiGabhER6cewldbPIO+c05t5kSray7CKyqw8VRKy5veBZN+pag60oJ2qK0q6Ca/6SScnUqLiVq/S2fWcjdn+vKLc5xHOIBqPg6lQ5mstKjOk6pbYNCxZIBX6/Js4SRJaAvkxS4pTHKLofya1Wud8olciMWXY2pTBtLnHlHGsUpve2RBOFdVFabIb0zwzrolzXVe2eiJIRnWcVjzxSYkzRp/yj67JkY/IsGAqL8l2sKWhCLhz+Ec4pTK+748w2X4OnAjAQMjf7X1jZYBiDVfT0V3NPoAzJiAvJbFQo04mEzVFboNr9Ocd5f3NiaIS5/GzNiuemRow6A6ccl/2aOSriKyFQWyIszXXM5QEukYHYZjwKC5D8cRBTSQAMiwexpYnk5TBgWpQoCscKlGId2+KNdmtZqbyJ41CA/WzZX+vwxdB4JgbxeSJLyra2fi88z/wTwuixLvWin9TwkHVuaKywexrdTdzidVf29A6/38hc4NFD8mw8ohi+VxLEYoKinUvESx8icZmsjDDYR4qC6TcBur5HeSVlS+4TzTgYRKweyO7IK7T6WAb1hG12A99euv78shCJ/hLoaOO9FEeeMdjuEk7ffMs8avl70UrIjZfZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(186003)(83380400001)(4326008)(6666004)(70206006)(8936002)(508600001)(40460700001)(2906002)(82310400004)(86362001)(7416002)(26005)(16526019)(36756003)(7696005)(8676002)(70586007)(54906003)(81166007)(36860700001)(356005)(47076005)(5660300002)(336012)(44832011)(7406005)(110136005)(2616005)(1076003)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:37.5599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3b083b-a4b9-4a07-372f-08d9bbf3f8d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The previously defined Confidential Computing blob is provided to the
kernel via a setup_data structure or EFI config table entry. Currently
these are both checked for by boot/compressed kernel to access the
CPUID table address within it for use with SEV-SNP CPUID enforcement.

To also enable SEV-SNP CPUID enforcement for the run-time kernel,
similar early access to the CPUID table is needed early on while it's
still using the identity-mapped page table set up by boot/compressed,
where global pointers need to be accessed via fixup_pointer().

This isn't much of an issue for accessing setup_data, and the EFI
config table helper code currently used in boot/compressed *could* be
used in this case as well since they both rely on identity-mapping.
However, it has some reliance on EFI helpers/string constants that
would need to be accessed via fixup_pointer(), and fixing it up while
making it shareable between boot/compressed and run-time kernel is
fragile and introduces a good bit of uglyness.

Instead, add a boot_params->cc_blob_address pointer that the
boot/compressed kernel can initialize so that the run-time kernel can
access the CC blob from there instead of re-scanning the EFI config
table.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/bootparam_utils.h | 1 +
 arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 981fe923a59f..53e9b0620d96 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -74,6 +74,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
+			BOOT_PARAM_PRESERVE(cc_blob_address),
 		};
 
 		memset(&scratch, 0, sizeof(scratch));
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 1ac5acca72ce..bea5cdcdf532 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -188,7 +188,8 @@ struct boot_params {
 	__u32 ext_ramdisk_image;			/* 0x0c0 */
 	__u32 ext_ramdisk_size;				/* 0x0c4 */
 	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
-	__u8  _pad4[116];				/* 0x0cc */
+	__u8  _pad4[112];				/* 0x0cc */
+	__u32 cc_blob_address;				/* 0x13c */
 	struct edid_info edid_info;			/* 0x140 */
 	struct efi_info efi_info;			/* 0x1c0 */
 	__u32 alt_mem_k;				/* 0x1e0 */
-- 
2.25.1

