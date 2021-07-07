Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95E13BEF53
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGGSlt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:49 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:36832
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232593AbhGGSlN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEkBvNk4t6bv9LlD7Pi+LZPdX9ywnQTQxNUO3cPWSLeI2QEgMK8Lt5Fehx9ohm9030SNWSObevZWJcimplBSkau4kw2YTgfem0aM5wVVWshp1sEyo23Q0p648brP8iAIo4BT/geG0K1DXeja2Bl9Isi2HOzmOQq/1+3NKBGAgQ0LIXcQhVEX3dVr+fq1b0hd6uPnoKsg619sgslygqJsw/alKHl3g93Zu1W4tJVisg9b2fwrOIkOJhIy7b4k5luaqIlcp+vfpY+pval0o01e3Cw9aBRFowdsP3SC3uKtBKeNc5JgZN6AxRaOYKs0JoEzC5/Q8q2liM9tdTKf9uKSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5fkC3xFRR9pL5wKKPvCx+W+UqhkeLVogvMDzAl06Y4=;
 b=nnDXxfMmJr9GGGyf/sjkH5aADcbyjIM9BfrmsftQRzvbngmx2ZjMIfbzV67A9OuRW31UmfIv0rcZ+IlNanLkvALORfW9NUpNGvhrksvYFPCrS92dVc/Tx7d0yvX9AJkCifope0lWBhr6aKzVZx81esJ6+WnsnidUg8mjWy2tZ/GZOJ9HxAypsvjBQqqWj5WJHTuBre0K4Jj0BR2H9pH+QcHAdL8sm7bGMViI2f8Gcwxuj0xfWUCZg4Duoewl3ujsC7s4R2HQ5H3c6VbLCnW/iH5axkel/M79aICi2BXFL75fniPi19hBiZLrNBWS7x0PN0qEQ9wxEs3rjfoR0KQsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5fkC3xFRR9pL5wKKPvCx+W+UqhkeLVogvMDzAl06Y4=;
 b=3EDjPhspW33F+tuFKakv2y8fARXp4zhC8Vr4uzzcvutJ94oPlkZ8AjbeoCCwZhj/+oDYQgMtDyJI1CL3kywUDi68A4eyW5LuAQbMfDxJ97AoIsqYCH3S2NzSJTafJF88tsGseyyXFG5zl/POcifS4zqvM/bhsG6/2SYXxcau/G4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:07 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:07 +0000
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part2 RFC v4 28/40] KVM: X86: Introduce kvm_mmu_map_tdp_page() for use by SEV
Date:   Wed,  7 Jul 2021 13:36:04 -0500
Message-Id: <20210707183616.5620-29-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2bafdb6-c5d5-430e-9eda-08d941765ce7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB408288F85945292177F18BFEE51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4sNUAzchDDkHg9fV3XB+2Kotg4I48itUae4dwCDEFNAmUMO4PwwnLRR+N3Je3EOTyTRaCVNs5ZHW/VKZKFGXsjiZDn7P5hoC3MRxRRAjJT4I5u4uFKBD4XcYVTDDSBLU04anJXV1258dSnAuY4CIVxMKbvzaXl4N7YRzuqcFOYSeCDCVG0W/G61hLf7ex6Y508F/2kPwEnBfyRiRj/ZuyKI3pzfAHmndqgz8s6pczExgSAMDhdUvj5PeVejlHI5a6BmOFzD2rn+OKKpKC6+gfFFBtx3+AhOAsQrmJatbF+jKzbRXAFeGXrvp35IbF8tbc8kiZvnKdhq5mA2QGviq7DMsF9RHRQT1uaTNmAvvDbWmcByTKehJKjsdowU20SvGVPuRqAppykDODaWXIQz56b0VPw6STmCseUdFhqsdciqpRkNvn5rnDZhJSM36VksvPxXfj2XRV0GmXF+++i3tzEVsfMiBYLx35M3KHwZ6NOSTm0Y1yMyYxhAcIy1bZKmczteyKjFtKfRszQSmlBANMCazM8b5baQKCi5eB3H+ukJAV73A6mY3uHy1SsV2dVXQPsAn4H5JAPldvZ91C+kvipDwj9fX1c/5Xu/0Kr8xCEFaszwvvDi4RxPHcbWZq8epzjtOo1330oqsBIvoHvCecU7Lvl6GZR8yKViQRqOyJmFA5qITpCZlkBFTk30415P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IwrtTWnmRVTHJk52uIUPqXYLnOAlBk9dKuW7eJf8ZKsnEKNx1VG3yRItUXEO?=
 =?us-ascii?Q?SPxUp+KGKf0qdLCoC2CuO7T6hwkOGvG4MoAmhxNsCeOO+CpX5lRPX1Nhcn6r?=
 =?us-ascii?Q?H35mo7+KdEYe4oTVtFdPaq6dD51qf0Usk/rAEBFCBsrTjN95wBAD7tdHd9uS?=
 =?us-ascii?Q?cKe3sCu/ckJtDIWXxk02bzGrInDRsUyO3HuUwRNSwjn3JTiu1dgc9GqJ914n?=
 =?us-ascii?Q?fViVr2Db1eDpZPDXEMVRjj9X8p8wJPf8+p3fvkV0OSBiCRTBfygDOXpDFcrg?=
 =?us-ascii?Q?V4WxIyVFwUkrLlGCosHUbx98nW40P+Z8owTsuX3oUi4oXungIcYnHQi7Kz+U?=
 =?us-ascii?Q?YwIg3Y/edS5ctw0/7AUGQnArIE7hkJfEIZHw2rBV9oDOSxE2vaazPjabdwmL?=
 =?us-ascii?Q?gVNu58+V/oJpMQ9kHotytYxr/Zqrz48tzAJa0O+YYDpTIIopDdYX5lpJn8v0?=
 =?us-ascii?Q?HKuhHyGcmJsorS/rUMqQ/UCaHIkARBz4lrnX710YyQ5ciXLn3mmCagWbcAbm?=
 =?us-ascii?Q?moXQd9DacHpHdfADPbDeE+TozTD8y7mTMgs+l0DJrBRafxfEWWPvXmT+hrQB?=
 =?us-ascii?Q?W3hs3wdgGaHG8/XJDh1OqgWH+plT4SV6FWCU6oUMyHRYif7a7sK6kzT/HodH?=
 =?us-ascii?Q?GhWwIL50j3VFk3QhVF5NJ1EV/IFqF5vOHH0Of+B/4FpKXPog0vqB73gZpz08?=
 =?us-ascii?Q?eBFxCwRjH2Zzxq6CbegHePt3xPEUzDy1ycqYsGb+0R5wik4TaVY+KbsbyuGh?=
 =?us-ascii?Q?FaKdkBR30jaToic798bxcBWt10pfGTXI5Km0ju3UmR98+D6Kadg+udDu3MWW?=
 =?us-ascii?Q?JSCA9ZMy6FvcMGRcgbdCeqxK0m9hlhpAzdTp4qj4/Db/O9NfbZUvJRYl9Bfu?=
 =?us-ascii?Q?SqHn8ABXx67A3iVHZR4dTY/zotiNhP/NlsLzZz3Kn9alygmdZiZSp3IzonFb?=
 =?us-ascii?Q?2i/5nVV3EKJUgROzaRhbwvhXCFIGrYC2Ez8cds1E1v8rsmYg6wY0RrrglVFk?=
 =?us-ascii?Q?0dekYPqg9weRsQsDkTNYKUgcYoGoYB4snz5n0+bVFRujR5ylLxOtt7lV5xli?=
 =?us-ascii?Q?xJ0wEUuApc/6y9F+glYEoXrdu9GI4+4KUVoPkC4neGURgdbzAkeub1JvWQTr?=
 =?us-ascii?Q?22v7QRSTK7iZze+s8OlVQ6kghyzqxQ4gEBAyOvSWUi+QKdc3iClhQHMOzV/B?=
 =?us-ascii?Q?AL4/nBPpExUHVcCInRt+hA10nDMpBJo3r8XTPs+sMFGg73ubG3rZg12yk2gi?=
 =?us-ascii?Q?3Ttgab1D+B1lPnJYWkgwZsEm2F2/parYPrUZL1muCIq1J4m862rI7VcfezCy?=
 =?us-ascii?Q?oeBWaPD3jjuyuBrIkMi/VNTN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bafdb6-c5d5-430e-9eda-08d941765ce7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:07.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLxdOytghXreAZ9JkGU71uWh2wtSfskSFzsPk+t7VYaM2gTmv0N0hhn9c0iBBjvqgq01FjeXiIYQVqSBoGktXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a helper to directly fault-in a TDP page without going through
the full page fault path.  This allows SEV-SNP to build the netsted page
table while handling the page state change VMGEXIT. A guest may issue a
page state change VMGEXIT before accessing the page. Create a fault so
that VMGEXIT handler can get the TDP page level and keep the TDP and RMP
page level in sync.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/mmu.h     |  2 ++
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 88d0ed5225a4..005ce139c97d 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -114,6 +114,8 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		       bool prefault);
 
+int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code, int max_level);
+
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 					u32 err, bool prefault)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7991ffae7b31..df8923fb664f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3842,6 +3842,26 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 				 max_level, true);
 }
 
+int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code, int max_level)
+{
+	int r;
+
+	/*
+	 * Loop on the page fault path to handle the case where an mmu_notifier
+	 * invalidation triggers RET_PF_RETRY.  In the normal page fault path,
+	 * KVM needs to resume the guest in case the invalidation changed any
+	 * of the page fault properties, i.e. the gpa or error code.  For this
+	 * path, the gpa and error code are fixed by the caller, and the caller
+	 * expects failure if and only if the page fault can't be fixed.
+	 */
+	do {
+		r = direct_page_fault(vcpu, gpa, error_code, false, max_level, true);
+	} while (r == RET_PF_RETRY);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_map_tdp_page);
+
 static void nonpaging_init_context(struct kvm_vcpu *vcpu,
 				   struct kvm_mmu *context)
 {
-- 
2.17.1

