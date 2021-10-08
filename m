Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E19426FE7
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhJHSHV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:21 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:29248
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239447AbhJHSHS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbzBvbNwD/FHi0lMe2tJHWr3BfjlEVvgsgQLMFeHz0cuYvUix63tStYjuWd84KX6CwBHbkmdARsWJm296u+e67109mS/AAuxuWmkRKiBiK2BXQoIUjavyK5W7Y2g5FBkWMzPlzN3ELOoCtLR4k7Za9ZkFk8xudroXB8ad1FFF/JKI+fKGDXoj7oEyFHvqwGY5Z+QyrsEXOz1ZcvNb5KYtICx8l+S85S/pEnl44NV7sWCw7VGEfF4JCYnTVy/LPGNiLGvaQKDGGzs4GVxUSoKwJNPpR7APu2Bdnh8/sLoKecS9JbCgzacy0P92cPvZa13w69oC+skcnwflhhXyKIGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K06qMf5wQfcHBY28JM4e6saqKResplI2sfOy4BBuMCk=;
 b=GNYIU2jur2sDrx7V3B8KoNWaW93ZkC0mr/SXAwkM05n7rZNv9nJUVKt6JVzVEsKt0uRroqtWKlO5TXRO0scgTgBZZ1VZCZFFs2AogTmQGE3TPVBmNQO6G3VVCb5zvgJL943Bh8LH42f+Mg9YbSxomy6jmoIkshwZ6lkUWoHug0PwGWtyQghDRshwBHKQbL3SQmtatvzQTczjdZ6X8dS9hh0jU3bwKJ7bV02zUsD4jeLZ1Vf1/ZWfVUes+WSqW1nQe9j6qs55w5jaSwk+hXv87jdc7QPtJZliEXpYR/hW8MGcduNo3KIx2N1Of9wSkxrhvlMyzkjGlYqJrE8023BE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K06qMf5wQfcHBY28JM4e6saqKResplI2sfOy4BBuMCk=;
 b=aZTVUYPVh8kf1h0Vp0+hY6GXGzuJiMaDBQq97uzxzm27jokjbxcPaZgRkwmCQ0n9iKFJGPik3Rc85IjYcAVTnFTPfulCswKPb/nadHXwmbn/sUhvB193UOoIwl1QcBkGo7YmnNI+0uXD/nUjxYgiH8o2fPkQUio3BxdwO4Rc/3Y=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 BYAPR12MB2999.namprd12.prod.outlook.com (2603:10b6:a03:df::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Fri, 8 Oct 2021 18:05:18 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::bc) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:18 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:15 -0500
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
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v6 03/42] x86/sev: Get rid of excessive use of defines
Date:   Fri, 8 Oct 2021 13:04:14 -0500
Message-ID: <20211008180453.462291-4-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 896dce4a-da8f-40c8-d560-08d98a862feb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2999:
X-Microsoft-Antispam-PRVS: <BYAPR12MB299991C50ABA2543127A7BA3E5B29@BYAPR12MB2999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfA3jWzl5z6EiSzzEhYoGlf+VtchUnNOBkA+5tNSeIrsACTFV3/9dP2kWUCVBzz/yHPCk4+7IOtJXOq5lIpVs1RSWaTx9pY/+hyiLU4bXXxgXjnqAbk6+mJI7xUxESUUUe93OFdIlhcCMVVrZ1jvAWYVP0A+aa1060SW9/MaliHp9U/GzVE5NQ06a3I+Nuokvkh8oJHZqWsq6rMoy50HJF+n9eutOk+9wydXtbUSYMQiwM6MSxx72qm17IxCiphNnfHYgcPEmOQt9mpvOY860u4JJXlHMUiScBREX/xUoctv2cgfDTd7me4gly3mV1NyfcpAlE1v/Fc2HW/kO822K7huqJFQlZJVvgyzCboEhHuF6bBcj59MMgrzKjB6lqleWiQZTlQMUMbyJxtLpUmSftBb6Gma9gI4quOEOaCmNzboVvR/nE5cAeq5HoMnPISz/e2MsBqfouJ+Sy5762L3h0aBeXYKVuXurMfI2W92BpChpa9cCaVWz+LYXvRGTUz9EkQHWOnf626tNx4PrDiJapTH8baZxuhatH9kZ4r8VA9GOssMvbPCkf33lGNgbHoRDPwS8SbLc/YL6/sSt9/GcyA8PT5SRat5Fjl2jFo83OUkFQeen/MLt7sEfQGbyXI69Ults8/BedAlYY3B5YsjRdVns9S9sCHgxWn7t4/gK61nN9LdEjpRlh0hBbvI1RibsZrvLGNnOxVpmDx5pPwkYhbMY74ccdUbs3gOe3FAMPGlyrN12ICFOhQkb9FmPG+ONdmbxEontwIcs98kIhI5eh40bOsQkJbbiwJInZPztnY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(508600001)(86362001)(8676002)(36860700001)(5660300002)(83380400001)(16526019)(26005)(316002)(110136005)(426003)(54906003)(336012)(8936002)(2616005)(2906002)(4326008)(81166007)(36756003)(44832011)(7406005)(7416002)(47076005)(70206006)(7696005)(82310400003)(356005)(70586007)(1076003)(26583001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:18.2442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896dce4a-da8f-40c8-d560-08d98a862feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Remove all the defines of masks and bit positions for the GHCB MSR
protocol and use comments instead which correspond directly to the spec
so that following those can be a lot easier and straightforward with the
spec opened in parallel to the code.

Aligh vertically while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/sev-common.h | 51 +++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 855b0ec9c4e8..aac44c3f839c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -18,20 +18,19 @@
 /* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
-#define GHCB_MSR_VER_MAX_POS		48
-#define GHCB_MSR_VER_MAX_MASK		0xffff
-#define GHCB_MSR_VER_MIN_POS		32
-#define GHCB_MSR_VER_MIN_MASK		0xffff
-#define GHCB_MSR_CBIT_POS		24
-#define GHCB_MSR_CBIT_MASK		0xff
-#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
-	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
-	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
-	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
+
+#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)	\
+	/* GHCBData[63:48] */			\
+	((((_max) & 0xffff) << 48) |		\
+	 /* GHCBData[47:32] */			\
+	 (((_min) & 0xffff) << 32) |		\
+	 /* GHCBData[31:24] */			\
+	 (((_cbit) & 0xff)  << 24) |		\
 	 GHCB_MSR_SEV_INFO_RESP)
+
 #define GHCB_MSR_INFO(v)		((v) & 0xfffUL)
-#define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
-#define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
+#define GHCB_MSR_PROTO_MAX(v)		(((v) >> 48) & 0xffff)
+#define GHCB_MSR_PROTO_MIN(v)		(((v) >> 32) & 0xffff)
 
 /* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
@@ -46,27 +45,33 @@
 #define GHCB_CPUID_REQ_EBX		1
 #define GHCB_CPUID_REQ_ECX		2
 #define GHCB_CPUID_REQ_EDX		3
-#define GHCB_CPUID_REQ(fn, reg)		\
-		(GHCB_MSR_CPUID_REQ | \
-		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
-		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
+#define GHCB_CPUID_REQ(fn, reg)				\
+	/* GHCBData[11:0] */				\
+	(GHCB_MSR_CPUID_REQ |				\
+	/* GHCBData[31:12] */				\
+	(((unsigned long)(reg) & 0x3) << 30) |		\
+	/* GHCBData[63:32] */				\
+	(((unsigned long)fn) << 32))
 
 /* AP Reset Hold */
-#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
-#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
 /* GHCB Hypervisor Feature Request/Response */
-#define GHCB_MSR_HV_FT_REQ			0x080
-#define GHCB_MSR_HV_FT_RESP			0x081
+#define GHCB_MSR_HV_FT_REQ		0x080
+#define GHCB_MSR_HV_FT_RESP		0x081
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
 #define GHCB_MSR_TERM_REASON_POS	16
 #define GHCB_MSR_TERM_REASON_MASK	0xff
-#define GHCB_SEV_TERM_REASON(reason_set, reason_val)						  \
-	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
-	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
+
+#define GHCB_SEV_TERM_REASON(reason_set, reason_val)	\
+	/* GHCBData[15:12] */				\
+	(((((u64)reason_set) &  0xf) << 12) |		\
+	 /* GHCBData[23:16] */				\
+	((((u64)reason_val) & 0xff) << 16))
 
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
-- 
2.25.1

