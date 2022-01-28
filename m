Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDA49FEE8
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350534AbiA1RSm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:42 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:42721
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350536AbiA1RSg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzQYYjwryYi7d0iI1b95nAlC6hzOlJnIMkNtNgHhnMqg1hjfOe+CSjR6qbx23ti8Qtow25t5Px0TGV+G3n0qj7el1XrbxHMFNV79pYwAXKCRZM7uaNNOE1cWsayRhcL9WMa1FQxdnX4KhGaQ+HbRc8/W4qgBIqlNa2LA5y7xnSVtK6Nuq0OrpHUIMK7HLwEtqv9KmVFShKK884bqbXBFKPJ2eD7/l3qeDi5fu6Q1Kw3lS+HgA51autOE0il12ffXgO4gSG2IEDJAQh+u3uWRI9o9+hAI+WvHFQg3jGm85pt9o2k6nEN1CLhtRjiBKJgMZMyYUHekJqraoh1RNdP1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW12IGctCHQ59PAs+7VbIe+Nhdv+NxvQBr3aNl1R/eU=;
 b=lSrbv9ri7TQAEqcjKLeoY3SfWd3nyEBTFRespL4ZScBldSXPAWTsz6xxQUyTDB6/AGdTwmf0TNIDNRjx3kBW2a1YwsuH5ovqRaKZd88bEc9ObjOEcwIiPCSMzvJnJJsrNNzPga9L4T5HG4QEzcikxDtO/YbnIlbcfwwRwC3QSO1AYapFaOBHnSiJPps+IHVIZFlHix8lmk2ZKgqk52St8TfKzmUBVqXBQOXwg5zKMl7jt1frat6hZ2lklOGyHKm6R3BD6fHvOyMADKzsbzg3MOqJx5Vh6xMAy5JtVEV7xspuZio4Uxq7NsJ5RYLWyl+ZIvKNxdShA9wcF4D6YOf9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW12IGctCHQ59PAs+7VbIe+Nhdv+NxvQBr3aNl1R/eU=;
 b=BUVbC0ZEHPClp9KLpU0f+IbLZ21+6pyeWUOcZcXdD5vnjFYyEDM1QzacW/6UD1w5eq36CqVaZm+UHrb1cmeoNrOP9Dvq3/3H0CCAcSPCrbJvYvQJ8MBS058j0TTcR2WlLrA5S/ADRfaON4IbDsD3aKSAmyLD8xaGRmRp/V6GmgI=
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:18:34 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::de) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:34 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:31 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v9 09/43] x86/sev: Save the negotiated GHCB version
Date:   Fri, 28 Jan 2022 11:17:30 -0600
Message-ID: <20220128171804.569796-10-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80339e2a-ac9a-4c27-9c29-08d9e28236bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3866CD11F7029B0CC4A0951BE5229@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLYisixtuzmc8yy623GOpJIJSZNtmUKj64guBT9gG+BSt5lmloxKLKEmJdh17C8ESoC+LfESfEhkXBcvjUGsCuQ7JrKF3jRZItTxTF5DXVtnNv0hY5qdK4VzKC8eoCEtwkhT5hLiTZCixMuKI7FOVAX6lH9MN24gugHtB12KkmDO7K0LvI72dXHJIxazdMV/0IXad5onKukGd9dCOJUl889xZu6x1tEbw6rCqlcS4ipWG61dV7ssEKTtd3FCv7YXxxHxftgjJ9tJMYju3GwAtvGHG8FwwLFUCm4VMs3PHtP4E2BHb253swbs+t+TS4sNq5+DVqnuF8goBPcrk0zTZzksJmJZgq6Q9vlQKJWz/abhvbxH6o2YvplLKxNQ3uSs9VnLML269uarFOxaEh/3F8/JV5lOyTSJuQdxZ7Ms+W7joG4j2USTv2rjWTc21lNr343QweP0UIoEWfzUKIadrOu4Wbu9q1I6uJ2tBkynogzetqrqfWypY+02uQf8JNeYb5v0dMlbymKDtCpOrDp4hSd7mwz6jC3BtNenV99/A/58iABT2S4FEapxBc8nc12lefeQGFAaeS1sGGtZpGrsL+kx3lyZybz5CKfI0BjT6PFqY+H7KR2s9sNVyX6OjihWcoM//gROSHBuZIUUY09gApFtYsw/huAMIl9FJ5PhLmBqGxIs5s5z43dBmITQPZXGuCotoousN4tO7iLFHCYQtOJ4r5Z9XVlOXlZLFaxEpLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(1076003)(16526019)(36860700001)(186003)(26005)(7696005)(2616005)(336012)(83380400001)(36756003)(426003)(40460700003)(8936002)(7416002)(82310400004)(5660300002)(4326008)(70206006)(7406005)(508600001)(356005)(81166007)(2906002)(316002)(54906003)(8676002)(86362001)(110136005)(70586007)(44832011)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:34.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80339e2a-ac9a-4c27-9c29-08d9e28236bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |  2 +-
 arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ec060c433589..9b9c190e8c3b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -12,7 +12,7 @@
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 
-#define GHCB_PROTO_OUR		0x0001UL
+#define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	1ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2abf8a7d75e5..91105f5a02a8 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,15 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+static u16 ghcb_version __ro_after_init;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -51,10 +60,12 @@ static bool sev_es_negotiate_protocol(void)
 	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;
 
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
 		return false;
 
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
 	return true;
 }
 
@@ -127,7 +138,7 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 				   u64 exit_info_1, u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.25.1

