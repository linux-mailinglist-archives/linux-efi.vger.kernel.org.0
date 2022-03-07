Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FF34D09D1
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbiCGVgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbiCGVgY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:24 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F204887AC;
        Mon,  7 Mar 2022 13:35:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqehOuFZjpSg87pCZvHVOw3DUGI4X9BEVt6x5O0GGl/6DSwVLA8eqbg5AldWIPD+auS+3fgM7LMkbU3QznkoanyaVXtAsvlvOGB9SqA2F7fkkuOwIVW9y6fCaOkeAjd/9/vxTv7ghsHZfhyfPOVMjTrdyhorfx0EErFUbKZSq3VWu5GiHYGbHsse0BF/U13K0Lesa/suUm/F/0YBfd1763wQKRQEDbfF4p8EJLSfC3ZaoDXMQ61+P6MX+GMZyDWkDuQmOqRXOFQuycQ2kIxq42RtosQX11VcmO8nG180ItsebFL020PR6cArcgdq8BOWbDKqh/KdnayrqYX4j97AxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fjby3ZULIjruvsd7FOdrUKJk+dLEcfVzhSung1Dsq4=;
 b=EEK9SlOFddhnqpxMYRH5TSSQgL05bmWJZNbTA9F/29vTz5y7Kw4mMOJahpEOffYkYAvx9SbO2XLXSGGDguN3P51RdNVc5/IFXchDNLuRm/43xC306DmcbPMitw97sTijA6pt2swEkK/eVnrc6/oL42VnVYpITSSkH/S9V6nVyTxnU0a1KihyneaqMlaIyYgi/3DmA3nIFmoVEfC60D6m5GxZjToGiB6kyNCHl1qxkDU97GhVVl9YlGoi1mNP++u+CYHhdmuE9UJrmfndSBq4Uddr1m4ADjeyqp4Qdzcx0b9Bm3cmhrLtLZvaODpPFBw2TqK6RifYKGiO4GRU2cnTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fjby3ZULIjruvsd7FOdrUKJk+dLEcfVzhSung1Dsq4=;
 b=W5KDCr5Xr3RfhyHfRn2hx6cN64nwgtNMDKlqUUqifElwipndDWHcUGuZs9Eq1RIx2YObgPcZnlIM4Wfb5yLBbCSWc5OqoF2fJwyNVcUDzvTiNMt+Hgt/JNKWgSDpbWWL4Rk3MDTzWvgEyAME6wJi+pKst6lfhJsR6zHJG9u04pc=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 21:34:58 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::25) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:50 -0600
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
Subject: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section shared in RMP table
Date:   Mon, 7 Mar 2022 15:33:29 -0600
Message-ID: <20220307213356.2797205-20-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462b1a0d-b51c-4899-6480-08da0082546b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5894:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB58940656B93CE5EEB764ADE5E5089@LV2PR12MB5894.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdWYAYGDR114x2AC8wO2FQXIv49PJYeNN1vDS/cnALbUkbV7rzimZeVBYagblxobW3IUoto7HONJjoBTMhnNXKBwF/0t8wWDDv/Fy3vEwjMyMcF6zCuv5J/0P5xUtPzQliZ4NdWCBIAKkIs9YD4gZN9lcAnfDyxWbFcuAt/hzCNKfhHjIYcr5hWYip7mTR2n11CG4Lo7Bk+zDDGWuTrzOoQqnGzFWHnLwu0+VPVrZR9D98RnriRz3T7KjTEyR7k/Ey5krX7IwT7IwnYMkh4qLLSLpK/hHEHsvWcuedzz/KcmA1/+yK4UeO/crY2FlaPVDq6EwltmbjxyICzA1Er4XWnkT80W23FMUdMORENFX9212CKd2WXzQLvEuImWLz4dyNAb/37xPWRSOmSkJSys4Sv1v5Mc7lM27dK3I2g6EcvxiLLm7n9Jvcbk0mhFIhORjxf+Gv/PxqQzPg4gKsCFAk62446ew/kVJSWIz00AGxUJAYBZh23pulN5wQz0ZqL2uHCuvgB8utzlLPjruJiQSFtNVPOI3pKlOZZ8A8ntR2JnHpmuMbooJgoFCLHYggCfxUzDH6Voeof+5K1mo7i33qe6ucqG3WNJr4x3C+VFbIIkI+MOyMwK5Q20PYWlfcIaUSldgrhz0hRQYrS0unmU7lcO4Tmc2sMabldSxnKK1EZO28lHQ20t4UQgvpX1Xk6Mu+/3LoFR4X4biZ99nIUTpd0UmSS9k8b+FB++trcMfw86fqbITm1H8yzPQxbbR+q+O+pi7N7B7UpxUWBLJB67dGXzRzM3h8ouSfzytGycnR0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(70586007)(336012)(7416002)(426003)(7406005)(7696005)(70206006)(8936002)(86362001)(8676002)(508600001)(2616005)(1076003)(83380400001)(44832011)(82310400004)(40460700003)(54906003)(110136005)(316002)(36860700001)(36756003)(81166007)(26005)(186003)(16526019)(5660300002)(356005)(2906002)(6666004)(47076005)(142923001)(101420200003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:58.7637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462b1a0d-b51c-4899-6480-08da0082546b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/kernel/head64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 83514b9827e6..656d2f3e2cf0 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,20 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * On SNP, transition the page to shared in the RMP table so that
+			 * it is consistent with the page table attribute change.
+			 *
+			 * __start_bss_decrypted has a virtual address in the high range
+			 * mapping (kernel .text). PVALIDATE, by way of
+			 * early_snp_set_memory_shared(), requires a valid virtual
+			 * address but the kernel is currently running off of the identity
+			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.25.1

