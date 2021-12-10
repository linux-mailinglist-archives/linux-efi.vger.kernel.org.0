Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2412B47043B
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbhLJPrm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:42 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:21993
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236428AbhLJPre (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh0iVejF1EcjPxMcKcRiTLaxzNIbqLTCxPD4bY1dkEiAtT5yFevJ+dUMMqGLPzdjTuTHZPn1wrDr37cQUZKHq/kRDPYNxL/z08yOoAcudvcmSK6OPdkPZseVcKvmkEgmqSAK90lFDFGhut+YnlIRlqdyNa6UdZHR/WNeiJnJTdYBF2hCung//Lqqz7s6fEFBghY4GEYQolPUh+OZoZrAkiwy25Y8evIjKAx6bvwpeNCMVWUBAI0ybsYNsRHxJeffeosKCGnufPH95lWxe2Jtt8G6oRiCds4aeDfWV2MvSkC/Q1QHs6ANSDxRnacN15ERjZWjN2y+rQ47tr22UqpA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cife7IOICCyiVH7Aa9ZyofIqNelDnpiR2NYgGBKIphc=;
 b=n0PAomMdleZrmRTJ3X30eSWpNshQaHoOZ9FYtHXLpOOeC6HqdHhufuwBxgA7wJPGR4GzDduf/zmRfU/l1jQSFgdn/h/+A1lWNMzOZfK7X8C39fFAZ+pw6HycD5bOldL2QdqpPxd8DJmIT0y08KsXK7b+gB6eINk5lQKzeOkVsWEId3S0uZj/F3LIpWxDIpX/nB35cQLEWowPyX+t3aOJSEoMPhhYkMHbLvWYoRGX13V82fs4Hn9HjKq0Jna+XOgqwz1uTIut7dm1JuzNyN0OHIH8/q56ir47XLr0FMs8txInANBh7owYbshLGwWNTja5pukBSC2n49CaNBahDhDPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cife7IOICCyiVH7Aa9ZyofIqNelDnpiR2NYgGBKIphc=;
 b=jC+x2KPAtjNLz2kMOiaDUMoVGNYWkIDtuSaFs7uDB43VAxSrDr6b5iYjV3Z+ywNuJqDGyL0SXWwxKzyoPojenYRpWP3EECBk9Ile/SQ7fEa25ysJGTew/s0fk49pZ4iC/H0mbfsi2bR1FaXzG6xwGuSreBJmOGZ7SR1SRHn2spY=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:43:56 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b0) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:43:56 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:54 -0600
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
Subject: [PATCH v8 05/40] x86/sev: Save the negotiated GHCB version
Date:   Fri, 10 Dec 2021 09:42:57 -0600
Message-ID: <20211210154332.11526-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9178b389-aa2c-4945-c341-08d9bbf3e07d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB148723204F1D48890137A169E5719@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5FLWbFYVcjRuFebkvF9L/2XgxWVRaElLdX3CITjchZEh98Wgw46yYVhbjocTPXKbkqvyIZuXT0xNC25wLkyAX8ZUigsbn2LEjhufpdZn9Tvxfcs/CNEBmgBRXdc+EHeKhhuhHtnRVV7D87n2hd2904i2iFAYxjoyDyYShNigq90DuTdkwmLBMcHqkYN0vxZXB/CaLumMsod0ZE+zDa+vjelyCCGvYZx+aksbRBeM0+EqnGwpBXmH0BeWZaLk8pv8nozvLt4wYOzc72TFSQxxh0Q0njtO7YU7CLD2BjS5D6p+nnmez4VB0FsKoKiSNjZokcqY2DMDmpMJKBeiUG5CMlkY03EjA3310aQKC0KIT7JG4O7DqiXq1OkWmNGxTUroGTpaOEejAmVKBMbat1UsZjtBz94eIzPfgAGIKD9XnhmVHthJ/ypSEbgESiZp1OqZmTa4r2uBuVbVB0Y297HDVlR1FaGjdT4JsE4e4rndXz9PbuK2h29IVFVv8tro93S0OgZTrv6LoTmN7gTakKoA11zLLrYS5nvDNAbSSJg3aC3bioZnrNOL4vHR+iw7cHKsEdQJsPZzYqVrfWUZDw4tiJoZpR1iegDMkf5horrIUQUxR3og91anQol8p4ploxM7VZCTzAht2T30As+1ceNJqVTWhDeJBSZ+BoUIJVW/UalIgKQ5lSW1qpCZ7b+CQuEC1IYUt+BbmL0K72U30mW9D9bwEXyMq7grBRo+H1/on3eFUhT8BHMX4WEyipEMrnd806S4VialqTK/emmoFDHf+kTnSSFcjBtWognCIyse81Dq1jpCPzWFFHkjLaQKNWC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(83380400001)(70206006)(70586007)(82310400004)(36756003)(36860700001)(7406005)(4326008)(54906003)(110136005)(7696005)(7416002)(356005)(47076005)(40460700001)(508600001)(81166007)(1076003)(5660300002)(316002)(26005)(44832011)(8936002)(426003)(186003)(2616005)(336012)(16526019)(2906002)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:43:56.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9178b389-aa2c-4945-c341-08d9bbf3e07d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

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

