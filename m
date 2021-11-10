Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADC44CBAC
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhKJWLK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:10 -0500
Received: from mail-bn8nam08on2088.outbound.protection.outlook.com ([40.107.100.88]:15680
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233653AbhKJWLA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdHEEDJoI7oeQUu7E5eCWD0rK+NjWWT3qe4G0S3fKKIRdeRpjTtgSz1GSkcwiXFW/tXDQirxt+TO2io4kCbybmeKAzQvjbUSlt88ekfpqyyFc3Jy7WgYlPVnv3XBkmshi0J7Ov6l0svPmM5VW95wPft0kxISIjBfnt9REuVMfmTMI9FaRo6WJLnYWttLqbhw7oju/CQtN32E/yRYI+G+zuTlzXLqLkkuCr+ui13LLwVidG57Eahyj5Ib7bLUOFI41JGjNqDGwJTIgN1xNzs67jsIrndf05EuipydATJvZC1+fk1HugxDljdHKksWthX/+4pGsVhgmMSiDQqVkQ2YFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDBEjszYq9M0kMD5/YGgLx58O2csQZDhNF4oEklWwDg=;
 b=fNJRx6l4hwAD2qAc2bJpVpTAZmfYSkY8UGif38TBtRjfC0/HXst/OHE0GYUNrw2ykVXK9wur7sP5pTbx2RQzduCUpdxsP6XjYsDYAL2XUg3OlQdbCuoH/UC05QCndiK88Syqv5z703RzJT86X2JT+UnoapthLs9yatrit0JW7Bh5VmGG4lLM9zflBlZhLaOqDqca80HeFiFxBRm+U/GIZuL9n9xm5c/hUVznCc4VgGozvKZq3lkW0Q95GkmDOxfIzo9CoLwIOiY05Xa+gCMeesHsCl9y/itB+Y3pdwso0g3nsKhBpSbPFmz4CCBYnFIvzmdT3bhFBZ0OgqCoAUZW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDBEjszYq9M0kMD5/YGgLx58O2csQZDhNF4oEklWwDg=;
 b=dJ0SeYbM+zSHZtyEBhruCCP2wHOSIKgTX8LvxOKqpcIGxsgE71TZNVdHEpylFgp0x+Df5f0vkXZuVqcGh79Vw3lSKw81x3O2YChSuVQDkukKPT5GpIrdUfuIFVzKfVLE3nN8WSSgR8R+Paw8lyhShKU8JDg04z1PGFJY5ndXTgM=
Received: from DM5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:3:23::33) by
 MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 22:08:06 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::9f) by DM5PR13CA0023.outlook.office365.com
 (2603:10b6:3:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:05 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:02 -0600
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
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v7 07/45] x86/sev: Remove do_early_exception() forward declarations
Date:   Wed, 10 Nov 2021 16:06:53 -0600
Message-ID: <20211110220731.2396491-8-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84a3cf95-2403-48f8-ff08-08d9a496927e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:
X-Microsoft-Antispam-PRVS: <MW2PR12MB23794B6146430F58FC2D1B8EE5939@MW2PR12MB2379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwzHQLclN9O+tw+M6HbygXr1kidAPdnNFpuzs2j89Z9O/pEQyLGs67qIMm8cHJ0482cLNAusXSs4UNxHtwe4XhDFiCoHHuNigX2h6zY6zAcj/2zh4piOSh0wIIYelN92CR7YO3wwt3o7nkyP/rjQuKVKDdKe7PisR2GL6c2qc5N8n5oU/wZUec7CvycHLkbcuhAr5kuL2LiZeDArXFrUgR/6/EzVYAxh5azw3A7vyfE8nUGK7AE8P1CthqrbOPjaMvHyvARHG0JLkzB7tAB+u7xm0PF71miO6rXWesnHQmB0jrIUbHaR30ROu4Ee7heo8az/fzXxj/bD0JAIshcPTY4L4H/5yGtqInoxtHit97CnYVvkFoReb7IqGVkEDZtaE4FWomwAVFHFHuJEcQjlTi1g3uVmFvm3oZstoAlEaUVEALg68U0WFcizn9BS/bhchk4kt7TdZkkmEDc+sHdmREJyaR48fNTxPVUTLHJRM9rQ7jFx9KPpvwBKnf+UFArKZqJ6540CTb4MmgxKx5b3r7JHPcWwlQ1ouU+ZZFQpnz/pbwn5ou+a2sMKa9PG+SWIVkzSBety3cmEvMPqbKgD0NdLi+ihMRxtwcvsNy497NGc+MRszWqlh2oUrNfarw2yzGDuDnuJEi99eBuIB4+IK2IM6Q/e9C+gz2VFizUhus6zAgQ/0S2HPv+GtaEHkJgz4RQDi7oSesmMAejqcnad4YhAjCLJvVUDI+88S+ma992kQ5EfWSkd+qSee/1qUCNS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(2616005)(86362001)(36756003)(336012)(4326008)(44832011)(54906003)(186003)(426003)(26005)(6666004)(16526019)(110136005)(5660300002)(316002)(82310400003)(7696005)(81166007)(70586007)(8936002)(7406005)(36860700001)(508600001)(1076003)(7416002)(8676002)(70206006)(47076005)(83380400001)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:05.8422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a3cf95-2403-48f8-ff08-08d9a496927e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There's a perfectly fine prototype in the asm/setup.h header. Use it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0a6c82e060e0..03f9aff9d1f7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
 #include <asm/smp.h>
@@ -86,9 +87,6 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -209,9 +207,6 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-- 
2.25.1

