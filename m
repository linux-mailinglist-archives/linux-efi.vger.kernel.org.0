Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F67427022
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbhJHSIS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:18 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:14433
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240772AbhJHSHj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1WirVqJYGVffunepYHan48fYPi86l99QcHsbYO7z7F3/+Ebslcl1zjWigzkcifMhxdzIko9YyDw6rHjNTyecgZ78gNuUMgv5nNOFttTtuvnl6aLt3dnl7nwWyF8SdFL4+RJqz/yEn6T24zoMh/W1YsN7hCg/rLoF4QdIEiOwVxTD9es6O0XAmyvIb3LIb2RviOzs57n6mYBCOOJ3Z4ZCHN2mRYCiyXpyAVSESSJa02dYquhQx1Pw5aQJ5ILQ22hVQxNbx25/XR38NX0bpdaj9dORxVcJa4dvkjJiQ7v0vQ0IrCtrWaGmBMQNoIMxH9E41IWaEURaUDixiUXfKbkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVZzYfFIuxr09TBb5rd/Y8bwnOVMlPMxvJq6EaFo/0A=;
 b=f1Qsko1k0c3kA/gjXPP+8oj9VxMlN1aMNIs+HPGkemDJmC3vPqOPnEyarVcJvj9dPvk0iOmQfVp7WnQx2ftIOT3ftZsEA6/dQpVea8aXDbrJvsIKwDo76h5OlD6PLsv0zmmSn47kTbpSgTn4elXy9semmU8OKM1qhAtCsvCd3hWoSzbDuQjEwztywZKwat3/AcuKdejIzjqX+fZxSUDRlD4V1qvfyby9ZcjWD3MGPEskjc7MHbqh0xxFkEQOO5Jss5+CZwX1a9MeKMPLaGR0Jm4KpGKs6OVz6JCvRKhPndsjtEThYwQtDOn6/Bps2RtXY7PLD/c69hiNl4HnCtyZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVZzYfFIuxr09TBb5rd/Y8bwnOVMlPMxvJq6EaFo/0A=;
 b=PwG2oZ/wyvVSo2NwVXHhwp9DdfRlrag6u8cLzNq6PYCxxEf5ElOWGNAYnruZwCAyy5dtY4bLn1v7gi9VL+P7ufzAwhGKSHyQk8yk6U2p3wO2r5BDNRP4Mg1pNSrfJ9NvWmLRQXurCew62QsgCn2XKX7lrC2mNBKfogwBySK2Ruo=
Received: from MWHPR15CA0058.namprd15.prod.outlook.com (2603:10b6:301:4c::20)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:05:39 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::34) by MWHPR15CA0058.outlook.office365.com
 (2603:10b6:301:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:38 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:35 -0500
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
Subject: [PATCH v6 15/42] x86/sev: Remove do_early_exception() forward declarations
Date:   Fri, 8 Oct 2021 13:04:26 -0500
Message-ID: <20211008180453.462291-16-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 797cb669-f0b0-431e-579e-08d98a863be6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4127:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41273B504980F168B9146333E5B29@MN2PR12MB4127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVg3X9nkc5PhDrYPzU265xE3EK8yofJTpx3ZrYl1Zsk0FHvbAgKjqytZOg6ZtQioMTiv37bLVliZMIm7SM0N+tV60VJr9FUsssJd1+KHTIY9+gsQfYA3Mko3OcTzC0vDXTJDKU95LZZVzSkn0UmEJ9M45hHr629RppAsMSPPwgx+gIYsmuMnUH4JzI3KeXvm9RB+gH8r0Nyt23z6858wzRPO/2ZjLKoiXJwUtLdi6eZaEfH2yrboGBkZyk3EccEFRgAZkF/seG+uanm5gkZ0yfFTsnWMg6PmDuYPBbBv20+ez0hJhy4BHEkNDTVba5pdZVa4/2LstPUHX+sj7ECE3hccSZueyEIiOUH3i4PXcPLhczdgZSCw4W3e4XoI4S54g+HdhaM/JJz9PQw53kbLpm/tHX8tuyAKPTz6HD+f1sUwkFCdvvVUUoAmrhw6jHb5Oh+I+QcLOa4iIl7NKjvqL6ulVm+ZT+S/XJy7mQ6tBfG4rwAcBQSo6CE/zYDXhJeHaBXiIRzKtXWmF+kkxZg72G0zz6sjhQxhl0qefEtCmUZZH4EUe6N3gj7zxwYEwfnQodf6bK8yNLJYaTQYc5L5o78L+yADTl7764ooQyo7sGw2xpGVS/H5qum+Wf0BSyObjsDKVyKDkpIz5cfFMNmUxp2vfHznTdVViqurvXJnY8cE8v3XWBm/Ev8QvCNa4MM4eKxgTJj+Q5B7eDwumOgqnM9+2nqsTKJqfxxhfwqa5rWo0czS9XVVMMRxYwk2npvh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(336012)(426003)(47076005)(36756003)(81166007)(356005)(82310400003)(83380400001)(2906002)(2616005)(6666004)(36860700001)(316002)(70206006)(86362001)(16526019)(5660300002)(26005)(8936002)(186003)(7696005)(4326008)(44832011)(54906003)(70586007)(7416002)(7406005)(8676002)(110136005)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:38.3308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797cb669-f0b0-431e-579e-08d98a863be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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
index 4c891d5d9651..ad3fefb741e1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <asm/fpu/internal.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
 #include <asm/smp.h>
@@ -93,9 +94,6 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -167,9 +165,6 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-- 
2.25.1

