Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3796427014
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbhJHSIG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:06 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:18452
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240865AbhJHSHm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hezeX1W2X37eYypHTZiiddfh4pA2Q+XoQRlxE44Wsef33xd9vsnIhYo1j2SkD8p38n3pzkZX98np45wC9dwyT7BoGnr9bgB9Y0lEW7GD573weCeOT5XMxoHjL+gvy26ONecdPOXpPADaWP4pEUVLGEe9QVwgB76bCfxV+LzjTjdhlxJ69sCAmqre7HTXNmrwD+U0fXWZwKD1bDrdKDtoMrMSy45VZpANKf7xo9gZWHyT4ErgXwGxyLMFoLc5Zh3SF9ToeNxu5ZUYrRQ3lPtGYrfkvrH244q+CHJJ/vy7c+1GDW+R3bSufPkCy/RHs0tityQFNmTqHB2PF/UCnr+n6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1eoABreZpUTPfl+akWiEMrwylz8pPJqxtykpDv1JbI=;
 b=SlkD/GKSGLao6A7e/hDr50kkV2IDuBKLF/Knf09PczNT/hVssUZrGp/HYsVecugPAa0siV9Hsh/kGcKBpvaF9BCNv+zH2l5Iu1TodBtS3RpeDujraBi+d9z9v2PTcrVXiJSimWURd+n0/l/8d+cyiJQiX7bvKy0o7evitI9ry71U7dk2zm3qsMY1TZyickdYspuYNcSz+LEuoFl9w5MyekLZlJk9OYDTPAUrBDVJpjsOjopuVyjFcuIyV8Lx9SKY5HQLLLHtxM1aYk25glKB5DPuW4i5PtYca2RIKHAze5ueIMklF8oX4RAXfHxfnqytgVY1fm/0tnozUQYlvUZPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1eoABreZpUTPfl+akWiEMrwylz8pPJqxtykpDv1JbI=;
 b=cPdJ7kJNlJtLTNGCBKUwM333g7XH080lWcO0gDuJtYrl22mOTpg0DOFTZWfgn8F6lNgJrMM5y4mc9u37bBZtl2/DAUZeTifCqqyguaiVT1mvDFCrBD9PoDuXs60eqZiM6ARgWXGEOlQCu9Vb/GcURv5p6blOahjQUwULrGvVdOo=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:05:42 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::57) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:41 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:39 -0500
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
Subject: [PATCH v6 17/42] x86/kernel: Make the bss.decrypted section shared in RMP table
Date:   Fri, 8 Oct 2021 13:04:28 -0500
Message-ID: <20211008180453.462291-18-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c0c9a6-e782-4219-79db-08d98a863e13
X-MS-TrafficTypeDiagnostic: DM6PR12MB4730:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4730BFCAB1CE83D0E3405DBAE5B29@DM6PR12MB4730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQjxJoPFrTwdvpE3ity4TgTdEF60Twyg9bxKQ0+DFz/wKCTpMbUEuEVO5PomqDHyz2Zkql5RycDhU3G6fPMoEACAKqJ6skXcaSZL3vtrS8G29yhpUVsDN6InxDOXd1mJywziyPhvs3a5QkM8Sf4gojMsFnBOllsCkiizPWSWfk1qPMCof2PTcv5ClQ8mlq81n/RrY1JNuxyMhA9jeThnivKY4H6BCzYP3EfYGmSDxS9lXDcx4PlA8Irdij/Xawgx4P7S/PV+DpmB0MJi3uNl570W9EdmTVf+J8kV0t4KJI/jk3Qa5OQVs9fbuZtGpkVlI9uvaiuED9mXUC9gJnE5roTCKnHjaURguN2TAQYT1axjWM/DwVzCedJk1zN3YxDrgNTk1j5L+jlvZCWhOZ1RwsUqSE1HcWrg+UFlVYhOwjfNYUgOv8I82gd/LJMJAzvy22PDOG61OEGpaG18xTQk9iWik5HgxrL5ZQiJFqr/bUjRcRHkeRNmyUBSiUPYll0ZDcf0hTkIAZ1rwpCzquTJPf+Te8KTkzTMAiD0ByGXeWVBeeEavOO/RzOswKmUC8r381wXQ0/dfzJCw4/Mjhzim9VsmxicFc2Lr9p+aDv3LWProIuZGhlZQWp3cxToau+FZHZUfXVIXQfebOkFtELyt/qyVTwQWKLez3zoW+2RRuk6RyvXS7eIjvgZ1A06PGvZ6q1VCYjDEoYAQwyvh/6YANbX+FlWkKG2jN3kIyvwelBc/7Ressl6wW++GqVCEccJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(70586007)(81166007)(6666004)(7406005)(83380400001)(7696005)(7416002)(426003)(336012)(2616005)(316002)(26005)(110136005)(186003)(4326008)(36756003)(8676002)(8936002)(82310400003)(54906003)(44832011)(36860700001)(86362001)(508600001)(16526019)(356005)(1076003)(70206006)(47076005)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:41.9711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c0c9a6-e782-4219-79db-08d98a863e13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the bss.decrypted region is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 3be9dd213dad..3c0bfed3b58e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,14 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
 	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * When SEV-SNP is active then transition the page to shared in the RMP
+			 * table so that it is consistent with the page table attribute change.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.25.1

