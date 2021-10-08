Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40C426FF8
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbhJHSHl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:41 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:23136
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240320AbhJHSHa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erWSxe8xDgcH5NyEJaEyBbOg2cWc0my/qp9TUImgMpUt1wTpyHLKfT9Y6gMz5CjFJWOyBAQCynDG0Rs9SQKuq6d7BgwkdiRjIlTDwxgbVkvIM8WK7e3NvUYmDNP/07q0JCY1kG/U52A1/pEsvf6blwo/8KQsCfNOUfqBYrgM3g26liqhvj34X7pcyhNhxVPMFMPqm92+9uFIpCzoGh/XERbuWEwGBovD7m9XFjSaahhJ6fd9kxrvK+wPy4y6qf1KJRtO52B9hOq9C0Tf5zl+jM8vKNu26FeFfbFEBYlSclqbodwXSvP8oRQPZW7s7zfWDtgXYizkrZFlMfZ1JwNjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkrXMwUN2tL9EWoBzRkWKI0TcJjQz9ETB1UY+Lt+sVE=;
 b=CA3xQQTJ0EVIv0sJ1ZLTWt4gj+hOFQpy685F0tyVPuUPhwwqU16B8ZxV7Xu1Y4wsY93iYiyaAXF3IHIv0Wcwk2WB9/2khkaSZtYNceqr4NUD6sFPfEKfdmVz+z2xABakQyP18whshpOdWrEoeghQR/iUXi0zOZfWmWO5Sq+F2BkunGz2Wo2HsDvPkTmGSNteyY+2WhMJ3JYakIg7eTc0R/j+ksRSGhFwC0CTw+3h+Mpyy90UnVdpVwD9/lEhS1d9nu1hDCz9ZPLUtewc+k2sj5TCvcQ47i06gPZ4OdMTukeSvDXX9tcbHLOko8s+9ZwFSl+2QlyhXLzwBlsHx4GaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkrXMwUN2tL9EWoBzRkWKI0TcJjQz9ETB1UY+Lt+sVE=;
 b=txIak1DWTCXzLcs0B51fhwgWWcWhRevzqQAsTrHFPlscQpK5oLn7wgeTsLOsfW1j69rZOEVRsZqP8BAtcjwcVFQ22ZJrT/u6SW6vKAAFHpdy/x3bwl3aY5XLWzTYvNJRrDWYuapivSKFGFHN4K/yX+UDS6Lx87z/1adLEJdj3NU=
Received: from MWHPR15CA0072.namprd15.prod.outlook.com (2603:10b6:301:4c::34)
 by SN6PR12MB2816.namprd12.prod.outlook.com (2603:10b6:805:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:05:29 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::74) by MWHPR15CA0072.outlook.office365.com
 (2603:10b6:301:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:28 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:23 -0500
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
Subject: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features within #VC handler
Date:   Fri, 8 Oct 2021 13:04:19 -0500
Message-ID: <20211008180453.462291-9-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27db9027-eae2-420a-048a-08d98a863615
X-MS-TrafficTypeDiagnostic: SN6PR12MB2816:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28165AD3729A6D86D72C1156E5B29@SN6PR12MB2816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHE2kKm7pA8JWjCBhB9VO6n+tbmKXlwqAdqhjFdC97R9poAx0zwh8IBqe9w2hxl5IGrhtcd8Iuf5TPRfXATVnZVrNqKx7/WQfUPX4kIVutNLJ/MFnm0rvguh5RL+4fJtuzmaoVnLZgMnWE1k4MKC/IV27h5PKeP8GQIX7bY7cEd2kd6dplua/1aXgbxIKPDN1VKEu/WULYY6kqCuaJY903R3I2MxEWYXimEDUVQrPxlgVyfzpdU37wPYMOjENXD1bMi4rixxoQ0pWeqKQxo/SgfCEvsTIf33oh7TuWp9KKqPg3nv3w6S1V7OSyurnGjx9QcR4f9UHkCCCatzum8tDcqWDbLT8lNvIU1EhOZCpX9GdEb23qp+J80unytJcdehe2pD6eIQ5x4gy3KR3eylFBzcuErG3ozz2xKTWO2k9CZBBdzrnXTPdFOrlpVwWShGcLlnXfHqxyY7MEVddZAxKgROG91UJTdGH0SZ3N3V/UtzX3s6F41sdRC08BkmBLkoneMRF8D+qNo1hv0qOZb8eP3MSR59KcbxXIIBzj8PEYbsSqYtOCnhFCw7wFn0Km/JfT+u+jDizSYNTba9PjWw3Q9Whg096mH3ihT2e98j7mOxdNfpa8m4YZB8d928mT7qSxHg/IlEIo2rH9mt088X3025SIRqskNAOqA6NfSQByanP3b0TBSJ/bd15GAMQ9m+LmnABvofiwmLmfLparDKLRmDrgc4HIxXbcuGqATB/819sO9/KWT3kthMUX4ZzQYw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(110136005)(54906003)(2906002)(26005)(8936002)(7696005)(8676002)(44832011)(70586007)(316002)(426003)(5660300002)(4326008)(16526019)(7406005)(336012)(83380400001)(82310400003)(81166007)(2616005)(47076005)(36860700001)(70206006)(508600001)(1076003)(86362001)(356005)(36756003)(6666004)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:28.5594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27db9027-eae2-420a-048a-08d98a863615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Generally access to MSR_AMD64_SEV is only safe if the 0x8000001F CPUID
leaf indicates SEV support. With SEV-SNP, CPUID responses from the
hypervisor are not considered trustworthy, particularly for 0x8000001F.
SEV-SNP provides a firmware-validated CPUID table to use as an
alternative, but prior to checking MSR_AMD64_SEV there are no
guarantees that this is even an SEV-SNP guest.

Rather than relying on these CPUID values early on, allow SEV-ES and
SEV-SNP guests to instead use a cpuid instruction to trigger a #VC and
have it cache MSR_AMD64_SEV in sev_status, since it is known to be safe
to access MSR_AMD64_SEV if a #VC has triggered.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-shared.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8ee27d07c1cd..2796c524d174 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -191,6 +191,20 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
+	/*
+	 * A #VC implies that either SEV-ES or SEV-SNP are enabled, so the SEV
+	 * MSR is also available. Go ahead and initialize sev_status here to
+	 * allow SEV features to be checked without relying solely on the SEV
+	 * cpuid bit to indicate whether it is safe to do so.
+	 */
+	if (!sev_status) {
+		unsigned long lo, hi;
+
+		asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
+				     : "c" (MSR_AMD64_SEV));
+		sev_status = (hi << 32) | lo;
+	}
+
 	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
 	VMGEXIT();
 	val = sev_es_rd_ghcb_msr();
-- 
2.25.1

