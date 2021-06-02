Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67E9398BC2
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFBOJc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:09:32 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230458AbhFBOH4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T27ptREqty8Wiplqbn4NUNMw6ZcxiGHOsmfHLDbhNuCLywtnsZoAfyQIsytP2DlB1h0r5Wa1GDxCsP/X4Ct1hKxaq7sEPTuKyfDvhM9yAzz8q93IIOj4sH4u7dNeS8FOvrd+66KStColNBnC5BHvQ5nTNOIW2B4ccDmclNksEna+7mRub1PwZPUr5c9OjnKbmEqmcL4di9iekz/epF5/8rkRIhqcw6leWENXSXKw94lUzQ1BYizomQf61isBXk86pYVKbYMCCDQT/6uEr+Ej7elBpULQlxF5uyuUA08591i9MZBh0ry1jH8Km2IfLn6lMPWQ8W+rr64s+72a1V3Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkm+wd0FGqja+GedI6rO+BZXARHGCW6YTHtk4DGiXTs=;
 b=C/vklcuaMeFs4Fp2TWVsx8u6I/L4SuiThYr5JUog+yAmVN/du1QyzmCC75lR7c0S9q3Stmk/VDkPxX5wfuje5DTh18duEtu0ERCgkctu+sulvnOmbp5h2eotDKjt2ju7utcxCc3f/fbL4wn8PZMMkb8jkvGS0OrcBAWPaPsNY193Eq9PCJvNf43OE2WSiyRVXjNMku//lceYzGBaF0B7zDUQZ6xjlhEAzB7v5tAHgGGleVqmCUrftI50Kf5wFNSQbSjhB26irQezC2FZeE0VkbIRTDhnV43FkcxHKx8AdJWo067N2hO3NSWqTF8N4UprnfxrHLr56voJEOu2PqUCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkm+wd0FGqja+GedI6rO+BZXARHGCW6YTHtk4DGiXTs=;
 b=4fjUT8YM2jfyyQumuz88ZNbhTA3k8i5DLc40KPGvspiPWZ0Da+Rc5CMU15dbji5lTVXaIMTnBcaDREEphdOcJn5MtyoA+OqZF5/IOkGvqHBE2R8nCNHrR5JNzYuSMWjkhPNUKekhoCcbS6S6I0LxW8yIGWrUaFZUQmtPpx57F8M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:53 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:53 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 09/22] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Wed,  2 Jun 2021 09:04:03 -0500
Message-Id: <20210602140416.23573-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e162c06a-b768-48a7-0d1e-08d925cf64ab
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512891CE7A3908E03D3132FE53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53LdoIBVatvIqBpZpkPWHqRAhhtnsZjeU8wMC3hfxm9gXU80nPxJmyvLjWpDr6e5keIxG88VQ7nG3w1ewmp9gjhJ1BgtM32Jy/1wite37OoX34r7ZCOuFu4Xua2Hw2BTUChBF78jpeHXkKFAafsFS5TMIt6l6cXArCVexhqNzVlq0eKu18kX8PT/ArrhV2L/WwdECAPf1HfzjVRE52u5H+5Xz8izpe+Hv6mCzHETW6nlg9PJhn29CTx/+Qa9E4mBjJnVWrA/MswMIbTHLRxrvENGIki31dg1aqQNCLGbMB8PFA8WfEFZAXiITAdSE4UMmgi0sPcl5+2fgXXM6MKOcIb93329jGrlfw5PJMB/1VKS99Ir2202+Nli8Pil6LQyRby0u+tQZXW1CAmxnVCWqBd4fJQMPvuWQ6k4s0hLjZXx4sYz5A815GO9jqwQ7qXYtSH+z3uMMCfz1rhIZk5cTMpSR7mIlXr2L5korkw3KcV5tOaVfA1mK2Jgjv2vbOnKbvpx9FVlCHrdLUCDz9ryVDQzA1GeJTCgVyyjSZSiDG2X2ncmRjYtcjNEvkdxNocMbZczuoGfW7iWVXykmf2VGWDKkHQymu8uW+O8jbVZr/2/kMhBwkVKpWNlQaRX1M50dy2Y5hWZ5Ly5m0P7e7h51Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GyhB7dMrnoJv+W3ZiAMKrRPUzYcFP1uvEnc6EB/cA24K7hHgl7dmtXOgnUtf?=
 =?us-ascii?Q?A1CTyzQVf9PROi5V6zaZ37e4aXfVYg+mbpjD80pwM4IkOZOVKaOnWEoor/nO?=
 =?us-ascii?Q?DTra0+LUCqXu/i4qH51v2svqqDJVRGJEVtcNjlH/ss7VR0UlYxKnc199QGK9?=
 =?us-ascii?Q?Vi1xUwJs3Vj3N2flGWjaSIWNl7kpk77w65gvrpe+5JZwYMIsBt4uqZciA4Uo?=
 =?us-ascii?Q?pAz6POg+5GEYetCEUSGnCuhffXnx6uaZk1Ntoyu7YAkB1hmbd9v5M1pSarj1?=
 =?us-ascii?Q?Ah4zG9ENCwlbmiR6nDL2ww5eIXsgHERsvbO/Cbyspl1f4RA9ElKMUQn/dkHa?=
 =?us-ascii?Q?8Exh0neBdEPTigiOGTyZ4NCB4z5m4xVp//m6cWSgnghu6DkONg7KZmAbXO2f?=
 =?us-ascii?Q?CNxTIbouOPPLCws242Aya9smNcoylUn9DPVuQq8q2p8aPIJ9CCwR5Dp3wMfT?=
 =?us-ascii?Q?iA4tnSFFtO2xpJWR8/Muwv8deHPEEAmvTrjYFRGTZUOxhigEwa/pJxVcEQPO?=
 =?us-ascii?Q?9ti3fndXA7Z28AZsi7bkw44xW7TtEZ3d5VWWIAlBhKgOgET5JE04vhr6qB9Q?=
 =?us-ascii?Q?OUvrTO6rLG4qEYHaMn8kIsrcbqjygx6g/Bw8t4Y3VhmA4qdUyqp2FZHyyFWR?=
 =?us-ascii?Q?/q5gzMsLObA3dVIcKEHV24G3q/P8M2lRWfxtBVvjOncVgDLtJdSLAjIQB2ML?=
 =?us-ascii?Q?s75oWR9kawdO00pty3QfJ7wZRVCIzA9AM+aijN8roCG1ETRgr4SUnGl3aqI6?=
 =?us-ascii?Q?EPkpQ6zqZ4njOYL5kiwi9aWMUPh0BOTRcIOrzq0oBLKXCrgAuYSCWN7ze4hs?=
 =?us-ascii?Q?aYrZmzacfSyGsQIUOVX+whpUKcgKkF7kJ4171sn6IfTMdie37/yP+O8U0rTB?=
 =?us-ascii?Q?H0iCvh3hbR8Mblu3LN/ITV9WOciSukzsUjSVuEFYlhtyfMzWdPOkRWQE08Tq?=
 =?us-ascii?Q?64lIIjVHTEggNSVA2KKICllxbkQ30o9UE06HL5rkCph58W1rPwnfEOs7QY64?=
 =?us-ascii?Q?gdGCwDHl7fXaMN8CzqVpLhJXPIxQvb3TVYxGTeBxKULyF8U1on5A+jsOueK5?=
 =?us-ascii?Q?TPZ80f8HNTFe1uWok/uGMWFEB7HULkvcaMS6W5NszHPqqvfV9732qX+e0qla?=
 =?us-ascii?Q?5kaQfL57DfYnQeFXY24PSmFtzSSuveLYr4rYEkU1XFJg1xFKtuiGghJbvAWq?=
 =?us-ascii?Q?gSYBoRckk2Uhj2acpHxadQGXEzIBzjSAC8Qb9g5nMQQxngdDTFY/6m+TrkQ+?=
 =?us-ascii?Q?H8zqWFKLO+Bg0gFpsx2JSkr/TA7uvOxrHh5/XIv0c9Fe7Zq5QoCtlN8sJkbi?=
 =?us-ascii?Q?3TcMgGvGfsxwE3wVdL0/3zSC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e162c06a-b768-48a7-0d1e-08d925cf64ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:52.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RMZMdqDJ4t/ckVhG0fYH5vmeC9TldAMhVxpJwU/8GPlPAEv9SH1Kj6LkCcuxjPGh5pvWwPRXSGRJUvjcsz7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required to perform GHCB GPA registration. This is
because the hypervisor may prefer that a guest use a consistent and/or
specific GPA for the GHCB associated with a vCPU. For more information,
see the GHCB specification.

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 11 +++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 808fe1f6b170..4acade02267b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -203,6 +203,10 @@ static bool early_setup_sev_es(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SEV-SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1424b8ffde0b..ae99a8a756fe 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -75,6 +75,17 @@
 #define GHCB_MSR_PSC_ERROR_POS		32
 #define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
 
+/* GHCB GPA Register */
+#define GHCB_MSR_GPA_REG_REQ		0x012
+#define GHCB_MSR_GPA_REG_VALUE_POS	12
+#define GHCB_MSR_GPA_REG_GFN_MASK	GENMASK_ULL(51, 0)
+#define GHCB_MSR_GPA_REQ_GFN_VAL(v)		\
+	(((unsigned long)((v) & GHCB_MSR_GPA_REG_GFN_MASK) << GHCB_MSR_GPA_REG_VALUE_POS)| \
+	GHCB_MSR_GPA_REG_REQ)
+
+#define GHCB_MSR_GPA_REG_RESP		0x013
+#define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b8312ad66120..b62226bf51b9 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -77,6 +77,22 @@ static bool get_hv_features(void)
 	return true;
 }
 
+static void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_GPA_REQ_GFN_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_GPA_REG_RESP) ||
+	    (GHCB_MSR_GPA_REG_RESP_VAL(val) != pfn))
+		sev_es_terminate(1, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
-- 
2.17.1

