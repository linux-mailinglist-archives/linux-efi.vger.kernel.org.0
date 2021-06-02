Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03B4398B7A
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFBOGo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:06:44 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230248AbhFBOGc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0AE6eCruVuz0xt7lTjsi+2cn78gs4DEHl8Cie6H1zNiMVmGCN/je4VnnumQ3coWbWJszay3BflWixFO58mGZsXbdE58SxfT9QkVJgiOF3aczLZBKkEQzt4UQpDuM8jJ8WOGE7hicHJhrUm1HZ6SesOQ8dp9kaLPyD77sh50TTTgMEKuASSSGD8OC7yevTDY7sQ+BCNIARyhHxitmZdpINqY83Dq0q3pNd9iNXY1rCnyc45xdPi3S5Ud6C4+LjUVuC1RQ/Tk1tn6BDNDfDsb1G+O5+oUOKlkxV3GImpC6b1x3CxNd5qRkz0EgdEzcZJC3gY4tVU/Kc+5cyydoabayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvnlmLlXWAGp0I6uSkVUrY0fesrq1cGt4WK9Oo2B/f4=;
 b=XAihPSWQ2A07M9zLyFD+O++5Ls9yAX2henpdRgZaiFlmODVX4yl8J0YNa6vBik9b9L0r4u4hUIxGbGL2q5GITjEeljpBovyC4/pwMkH3faQS26h+Uv1LlqHxJy1bbg5eWPmF7nA0uaxhaem6KzQ0hL/WknWehewiASnwj73knXpjp7OZ8VmwXne4fgFHx+KRAYpln6Ofo5+o+1/EN4Dd9GqlZckucUZz32wglEZvcVwBSTFUpE6pRMWNwAYrUmKybNy1FD9H0WxhwY4QFQv4at/tsJA2Yy6+nLdLxJZxASNKz31P64NlKNTo/7RoG8VDPcEqnh2rwCG+jZVLCesGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvnlmLlXWAGp0I6uSkVUrY0fesrq1cGt4WK9Oo2B/f4=;
 b=OPE/UBTV/nEtcuT1bGELTybjYDOMXd4LFhZCdMDHkRI4m2S0db/7rZyYGfhFDL8LIoPwh1aZq9ua9PeiWFL7iuI2fzIMOljzXK4fsdAbt2EcZMi4G4ZxiMi/+d458+CHkNmY7592WNui4Jm9j2VdTxo1LcLxxdv+ZlTPoCmMMwg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:45 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:45 +0000
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
Subject: [PATCH Part1 RFC v3 05/22] x86/sev: Add support for hypervisor feature VMGEXIT
Date:   Wed,  2 Jun 2021 09:03:59 -0500
Message-Id: <20210602140416.23573-6-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf98b167-3851-475a-225c-08d925cf6060
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512FAF7DD494436218B69F5E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MThO5AXiJl1+pIa/2heopZBBVy+VWG61ljYuNkNAflXoR2N4irKSbK/uya/DtRPTRwlALZbWeNNOju2eFuQlZYltayRU5n0mYQsUUoiEz/0itEES7QegJnG0yMkBcLaUvtBYGTgDs1VL8hrv6uggANT4zBtP+odJUFXaabSTSG6z6X84xV6NcRCqVVWYIMnmovf4jArwUW6FLDEK6+BXojtEpn9NTL1DkfO7Oxqhg+VPP8hK6CMz/9el1d1zgh+cJxZuvaeJAUEN5AQml+FwRW5URANcfwBAL1PNSvjMlkriEPI/if1nCr6OsZiH0nSqaINaLBfYWE82nG+/+CvDZg0EeTiKKggy2Gq2hlH8y01S/k/1PvYgov0IRgGnha8I+HFbRCZwgvtfY6n3S21rGwOWY1xP7wHvkNKJzhzNLn/kTM/T9TbXu36v7G3lEQMzZFi/ya6z4W1/LlvNC07VQg1iE0EsuOWqFcuaxov818PIzHHryKG6Gc+CkpETAHWLXTN7EXnOBkmYHeWa6jGLQzyI7LSjoUiEYBFMlknWcIHfvCMpq/pkRgIIXOXhfEDgIctNB0g+lZHUUgMvGLkYB3VyOIfc0oTstRKNeEMN/S2f1/UQTl6nMvAQ4BxzzFkGxfc+NJVj8iGnLpxHGuPMhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?asaLTQzU+n5OkbM/bOqpG0waJeqVvFYR58RKAXAVxq+na03noRDwWQqtOPcm?=
 =?us-ascii?Q?qTdM1LFXiElFjxmvaTsP366ICfq66vHVrk+cn6KtDCqtJ8zLs4BUPiA/oAAn?=
 =?us-ascii?Q?C04ZZ+UoqpVHiEjY1GwuZFPqDdIiDxsLYB61E+/WI75Jx2P7rRauZCjtFWW5?=
 =?us-ascii?Q?edVGGytHSvpZGBd5z9NOxX+Vo7Ur3B6+ssQHXrWdXjZb2hpkOdj3pWimFN0o?=
 =?us-ascii?Q?Evj8Lx62FtirXluOJr/6lvkwbCVKl1O30WAZuPhDMJEyxeQjHAzHumxPtNcn?=
 =?us-ascii?Q?Wj+t4+kkLlcJSA5zRxGpz4Pa9u62XZ5blfB2Dw6Tt053+DuynoR+k/j2hjAc?=
 =?us-ascii?Q?IYXTHVSfWRKh7cs6b/RmX7Ky7yXZBbSqk22d1dp9Ax/QM2Ig/VBSYryQ7B/Y?=
 =?us-ascii?Q?RRlcEluP9tCN1hSDYzaO6ZYQwK6kCqGeJhpkulcYmR52aq3GEvOaKvvCqzvs?=
 =?us-ascii?Q?wZXnp9PvySyHaXTSgacIo4bKQofTe3Us96qZz8kNx3H5Kl13BCgEOOjb0gSH?=
 =?us-ascii?Q?yji2KAkeTck+R8c5KPen4gLftQTHfgSMOAIjAcSteZ1WU5eF1LFaq5WL53H4?=
 =?us-ascii?Q?hhnNYOdth7p85InfoOYsQuOvUv6VSOgkXl4a6T4k8wLhLPm4ZjIy/QtucfLB?=
 =?us-ascii?Q?xWKpSow/p0PMNr4l0Eyzr6gMF/VsNDlhly0emmRwMAJYDfW3D828/FvKck/F?=
 =?us-ascii?Q?QAaJC8f/BVdGfMNd8XeuxDqGwZJ7dR6VOzH2XIyvVFYVT0mTPA2mEOtMCIfD?=
 =?us-ascii?Q?JVzO/Rzg0qG1S+JIX5bE4zRbrXW/A2DH/e92/tdr7M7GwoqUPxhC2O004Emk?=
 =?us-ascii?Q?1j+nslIm5zw7U1n9T4vYFACw0jO15wVAaldsZhstLyJZzXFLc+0M+0LvCnZ2?=
 =?us-ascii?Q?v94g9RSwDgROqPYHbsHqHba7GEAU2GYJ7NE1I+nC3dvWSZf1pCAHObb3Smra?=
 =?us-ascii?Q?AFeMSH+/Kl5gKyIE31psfdUr/Drtp9ajfKcVjqrPUyC5HUYH9ua6MY4ZDzbh?=
 =?us-ascii?Q?Z1EU9EPYYOyBTPeoSSuAT1R3lhzXWPTj3yOJKV/gY8dDuGWdeMa3kI7GeC01?=
 =?us-ascii?Q?8miVA2P+FO6XjEhYNbnvnngEqclBwKEmutY2I4qY8+0DzKH8ntS2wSh6giJ0?=
 =?us-ascii?Q?wZsYqHmUbOigcaeG+S/DV2GVssKS4wO3QoGOI0tVFZJd/AJoSV117kQoV8nC?=
 =?us-ascii?Q?96tU307Egk8SyarcwxLAzY1rjX+FkpiQb2ZoOuSdVKQx9fvoAvLm0Blpk+VR?=
 =?us-ascii?Q?xqP0BsIy4dI0619AeWva703rWlAqhDgmhmoUo6MRQ6KRJwNi/tbeFu5RFnym?=
 =?us-ascii?Q?L0Hw5Upp9XUX4HkoZ+q7/Ywl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf98b167-3851-475a-225c-08d925cf6060
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:45.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qd19yKsuzEICjeM1hhxFnw1p7EjJAyFMrdrcCk7CtbpJYou8svrsioqe51vqTOzvLjp8rBp7uTzdhMmJu1low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification introduced advertisement of a features
that are supported by the hypervisor. Define the GHCB MSR protocol and NAE
for the hypervisor feature request and query the feature during the GHCB
protocol negotitation. See the GHCB specification for more details.

Version 2 of GHCB specification adds several new NAEs, most of them are
optional except the hypervisor feature. Now that hypervisor feature NAE
is implemented, so bump the GHCB maximum support protocol version.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  9 +++++++++
 arch/x86/include/asm/sev.h        |  2 +-
 arch/x86/kernel/sev-shared.c      | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index f1e2aacb0d61..981fff2257b9 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -45,6 +45,15 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* GHCB Hypervisor Feature Request */
+#define GHCB_MSR_HV_FT_REQ	0x080
+#define GHCB_MSR_HV_FT_RESP	0x081
+#define GHCB_MSR_HV_FT_POS	12
+#define GHCB_MSR_HV_FT_MASK	GENMASK_ULL(51, 0)
+
+#define GHCB_MSR_HV_FT_RESP_VAL(v)	\
+	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7ec91b1359df..134a7c9d91b6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,7 @@
 #include <asm/sev-common.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
-#define GHCB_PROTOCOL_MAX	1ULL
+#define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 70f181f20d92..94957c5bdb51 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -20,6 +20,7 @@
  * out when the .bss section is later cleared.
  */
 static u16 ghcb_version __section(".data");
+static u64 hv_features __section(".data");
 
 static bool __init sev_es_check_cpu_features(void)
 {
@@ -49,6 +50,22 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+static bool get_hv_features(void)
+{
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
+		return false;
+
+	hv_features = GHCB_MSR_HV_FT_RESP_VAL(val);
+
+	return true;
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
@@ -67,6 +84,10 @@ static bool sev_es_negotiate_protocol(void)
 
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
+	/* The hypervisor features are available from version 2 onward. */
+	if ((ghcb_version >= 2) && !get_hv_features())
+		return false;
+
 	return true;
 }
 
-- 
2.17.1

