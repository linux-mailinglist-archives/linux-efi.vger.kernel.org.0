Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37C6427077
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhJHSKE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:10:04 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:42762
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242845AbhJHSIS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hihj3JOg80h17qVhCXZPKU6sxvu20FdyDr64IS323O64Nx6Yo5V0I7UKrf3ckJ1NBgGVoMGFMeydfVIpmOdTxFiCZWu/PtWNqzr5Qg1siSit5pPpVWv0aO276S24nYU1bjLHYyQIkSF63e7JCY1Z4r+JCa2JUuwPyCxEmwpJluxVRPfHT0wIUFm1c2Onhdl3QMbNRl8P1zX43zKm7xqaYBZBMuNqLN7T9hMA6+MKlBYT19dF4lMxXD487l8bi2rQbzu0fErMaCyXQGn+4R06VlxAvxl0i6mkgG/qoLKmmM1OkSV7uv8lU3MI37cCZld/hEIl0mGwPFjLuNeoP76S0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJIlil3KevvyBvTVw/qIQ+PdjwPUUjQMwvvNTZxwAhs=;
 b=Jxaj5jfBtWfX2KXnNGXCn3W1ZB7QPYy1L2U4uqdcuwVUBD2l6gshJHIF47iPZi0OlahtDCssp0BucpnKm9FfSzztfXzzVxWPm31C5mCQEFW9F5sxB7WrrAsOsR+8TtpfTBUCbOZ+/wZIKBqnsBquL9Se/NQyqOwkasVUjTdJj2kv4rUIrvw7+UOqi+2bF/Yv4opRp5qWCE8IwvnKmeExjXf/xDEL9oKiRoPXOugxp4vcifwD7mwsIyzwRiCTI+O8d4WFBmymbqxxgUL3uqjJ7iQ3Fz67TSIqCwO5CtJ/Me/8KqxMmI6E4piFLT2UcTocyTlX63+nUH+kUwao4imrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJIlil3KevvyBvTVw/qIQ+PdjwPUUjQMwvvNTZxwAhs=;
 b=NM+385owdO6/PTBGizmSi4up7NwDRJmDxAXb9WaKGjBjkmQmjzAOVUSFmVrjMZVF9l/pxkUzrg1aONh1i98qB9MlofHjus9dXvQ9QWW1eFrYGYU33bTLJ7+sUisUcxDmYdupH4e18sljSPNjRfGb9+HsAY4a47hh//VeumI6hUM=
Received: from MW4PR04CA0043.namprd04.prod.outlook.com (2603:10b6:303:6a::18)
 by BY5PR12MB3748.namprd12.prod.outlook.com (2603:10b6:a03:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 8 Oct
 2021 18:06:18 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::23) by MW4PR04CA0043.outlook.office365.com
 (2603:10b6:303:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:17 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:10 -0500
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
Subject: [PATCH v6 35/42] x86/compressed/64: store Confidential Computing blob address in bootparams
Date:   Fri, 8 Oct 2021 13:04:46 -0500
Message-ID: <20211008180453.462291-36-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bdd76ffe-05ca-4a58-b2e5-08d98a865377
X-MS-TrafficTypeDiagnostic: BY5PR12MB3748:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3748F459198FAC5EA50C41A4E5B29@BY5PR12MB3748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6BKZn3UQZwmRcrJGY9Rd4DpWSVtcD2rGfkCEQgEduVws27Hq47qNCurak9ecGcgPKf0FpLGVXJw1YkNyv2K+0TeVVtADoPUddCSo6MOPqmgq9x0n/VQM2ScAaSWoV6GY8cGx2qjhD4hcnTQxqkYVDgrXjNXkxVWYZ1966OA2RQEeSPz1jYJEs8bucIy3djYYETKPIRBurnCLTDuz7ZLaQzCj2RBfEgHbT55VgIX3mZogTcJ1vh96Fp9K1DfYlPmWAd9SM5bnDQ/Ai4u3QjLEQlg5FSgNY/j4I5XsRc2AjPIzirTzzeoz9bxglbb8F2Dp2A2oRwQ7s+5XtcX0El/otXucwjOuMWux2E8O5GneEkZJxYNpYwosOGKBCHijxNPfV6j3UDAiIDJb2EdOgJiMAWs8lxh6YqgjmBgQ0pRjyxWTW7ZWHnrwelgPUm5vP+92Mk6FoHRZPRRV3HZ5iatfknpjeUlDqSd7dfRBJv2G+zPFFPTtsrBY08CYPp6RsxUFKgOrOZuyv1KgCDwfgZyA9bOLFIvL3RZLWvRKQN0zeK8hygNQFaDMeI51C6AYuqNsMLZjOf2NfssRIxPfcDI/fGJqGlNhD31NRfFHYp0gXujkyUBS8WSH41vsCz7WzqfKfe0WsMPmP+hu3CDqkCWzqEfA7zrMf2ItSMChdBU4RcWq6mfrWAslbOCGijITwySGsTTWxLMmhXrTeEYAR5nGz/G4NQMxcMiR9HpEZTolYTpnxs6PBtPsalqCXhyYaK2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7696005)(44832011)(36860700001)(6666004)(508600001)(8676002)(54906003)(110136005)(316002)(4326008)(2906002)(26005)(86362001)(36756003)(186003)(16526019)(1076003)(70586007)(82310400003)(5660300002)(8936002)(336012)(7416002)(426003)(47076005)(7406005)(70206006)(356005)(2616005)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:17.8631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd76ffe-05ca-4a58-b2e5-08d98a865377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

When the Confidential Computing blob is located by the boot/compressed
kernel, store a pointer to it in bootparams->cc_blob_address to avoid
the need for the run-time kernel to rescan the EFI config table to find
it again.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 60885d80bf5f..9d6a2ecb609f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -375,4 +375,11 @@ void snp_cpuid_init_boot(struct boot_params *bp)
 	/* It should be safe to read SEV MSR and check features now. */
 	if (!sev_snp_enabled())
 		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/*
+	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
+	 * config table doesn't need to be searched again during early startup
+	 * phase.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
 }
-- 
2.25.1

