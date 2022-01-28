Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0447049FF18
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351012AbiA1RTv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:51 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:31713
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343628AbiA1RSz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBt15EuDd8NhrC5RwK1UoLkRk3E9Xm4OJFu744lFbb4toXz4tac6FdIsuqKBeg0KesbnRgwxXY8wIPQN6G6YY5dGucCVX1ZXNdcIP77mLLJPlU5fdFPAPs9IjC0ZFvJxAkJ3/eaXy08McR2mpuTngSRVbZXrGUrnHdgTotd9LddmzQbU7DTH4Z7G0G7hj9YN5BUnIEZ5olkAxm26CA/f/14WeGo5e+nM5YbtDhrzW5zD795lF6GfURsLEfPgZUTNjgchw6fHPFHBwKpKESrmGbvEZpvjg6slKNCq2ryT6fr9cDF0Ohxc63eU0D/HzNHZEQMepFoqnEGv/KB/BRdI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncU5+qEzVlhVorbSIGSLF13VWjHvSU+K9B2TRpFC42s=;
 b=dc02TtGxNEewYhoVPiqWVDBVh8fH1Qt/O75SotRc7Yl/awdFHWYlGcFhrnfrIfGwbV6LQy816gD5G+8n/X9/Zf19pCrfpl9RZfShuX2OSYpePItTAi+r9+pfTS1y3Ffk6ayjcm4kDUrM8++D/x2I/wrv8qvp0wvxvosjhEW2DR253YS8CEvnP5T5mNpwkzjdZX3FoBPTdnOAiPT0AIUB27yNBG+eZprLWo1RcfTRFP/A5F7Zl+MyEJScWJC3U7pKQ7fa2SayPzJQGmeqc2v553v0a+fUF5MJPxVI3BNah7kD8OFVwrVsYEiJ/na73lw2z91iH0JUAhr1kNCXw2hMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncU5+qEzVlhVorbSIGSLF13VWjHvSU+K9B2TRpFC42s=;
 b=CxoZJFlfAZ/6e6N90uZC6+j+r3QbHLlrLixk2+H5klv/54/9o0pldVljO68qm8UsUN8OM5qpoGfetHbVjZbdM0daoi9r9q3/9CC0rRkF9hIyLNeEo8ASjOTbmhSCNzeMRFgSqENeCSdNsQ2q9CHftG3vSqrbA/OZvsk8EE2ctm0=
Received: from DM5PR04CA0037.namprd04.prod.outlook.com (2603:10b6:3:12b::23)
 by BN6PR12MB1923.namprd12.prod.outlook.com (2603:10b6:404:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:18:52 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::de) by DM5PR04CA0037.outlook.office365.com
 (2603:10b6:3:12b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:51 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:45 -0600
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
Subject: [PATCH v9 17/43] x86/kernel: Make the .bss..decrypted section shared in RMP table
Date:   Fri, 28 Jan 2022 11:17:38 -0600
Message-ID: <20220128171804.569796-18-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3389a56-841f-4068-df05-08d9e2824152
X-MS-TrafficTypeDiagnostic: BN6PR12MB1923:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB192385D4D90006FCCAB6A138E5229@BN6PR12MB1923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1FXiAf7cwfcpMAko42T5+ABWPqVMRmLtHg39g7JGzyqo/STFaP6+cx6VsnoPNf5Hi3uXjkFXBVbfIxudHSeKWQBlwFjgkhDp1SsoV1r5t9oItnHkX5zMxf3EcNQnGJrNllwuUEGwEcQZEaanILixV6Mx09bxEQImETEgfIO9eaH7K1MYB/wdPniIV4+/L8w+q2BtNCxTXJLBtkHRLOkzIuuYalXnS6NdH3dk0xpTiARhuqJwUJhI9ke62fmLw2takmRHcL+IQIvE/uEs+SyNNL2PhaRQSTJvPJMfR4RoenX9A9DiZV2raGU6C4AAmGBWPqpleixKwoNWuXCJ8aZ4tLj0qniuXpxkhRF/Cr0v4mJhTJ8qUYOPPvOQOttxBZHb2vQ4Jp0jGsYVSw239dPBCcUS7RWjlY0nx4/JBbQUVOEBDxcFi3Fbj4JydVPhPP3t2ezOGkVsG9cQw10bxLfSdyq5+OHXdqgtY+yDuhMP534Rhy2gjDw+lEeztQrM3ULGSFJwLQr/macnfZvfL83nQNdwY+wc0RTCb625+YInfxXdyKq+mZPmRc4WUDMRcbze+yumbH6DaV9mv4QyPyuErss0ktBK//w5wIFrqnuXE0qXVXFARnwVEZpmC4DA8kKod+oslfTNO/RgpcfFMH5BE835xeonZsd2YmRZqtozd2edEjm+6LQ4QPfRZqOiDL3E8kfFHGheUZ9DkiYboR+UH3SzgtM0+c7o2Z5YgXSBRU1MUTjjKd07QnjWOGm5F3rHtO3UiefwVqUIvUSWsE8uIB2Ho5hGa4dPmIa4rQUJck=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(54906003)(110136005)(6666004)(316002)(82310400004)(7696005)(356005)(5660300002)(8936002)(8676002)(86362001)(70586007)(40460700003)(4326008)(70206006)(2906002)(426003)(2616005)(1076003)(36860700001)(336012)(186003)(26005)(508600001)(36756003)(16526019)(7416002)(47076005)(7406005)(83380400001)(44832011)(142923001)(101420200003)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:51.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3389a56-841f-4068-df05-08d9e2824152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1923
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the .bss..decrypted section is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8075e91cff2b..1239bc104cda 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,21 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
 	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * When SEV-SNP is active then transition the page to
+			 * shared in the RMP table so that it is consistent with
+			 * the page table attribute change.
+			 *
+			 * At this point, kernel is running in identity mapped mode.
+			 * The __start_bss_decrypted is a regular kernel address. The
+			 * early_snp_set_memory_shared() requires a valid virtual
+			 * address, so use __pa() against __start_bss_decrypted to
+			 * get valid virtual address.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.25.1

