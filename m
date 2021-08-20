Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C963F2F2D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhHTPXr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:47 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:45857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241392AbhHTPWw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRWn31ejX2RVtiMUhkGn34Yfr6NibhzvMhYMF4CoLSs9GVx733OqPJoUwUQhwJRaCCTd2gmA6QkD6MaraQpk9v4U/kIXs5gUMZqJbQhlHX9bIS6BrzP9xGmSlSiQQ/Kynb7ulRgIV+zefjNKuSgc2lpjR9ZDM3GeDMpkUfz/3XV0Ml3iYHueS7TnvVF8sg1h9PGsj/i+L0PzPCcNYlulz5PEWvJVfEqnb250+NMFFugp9iKKXLhxRZJuAxuT2JvaEYt/f2qmlTVOBTUtSUKS9AgzWCGU6qyN+5QufwKKp03LEc25jfczKp5E2cThrW+mLio+Ue+R4hi+XnJxIL5cyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFyCnzIPinv/+8QkBlkc8Nj8XYKgOu+lQrVr+RAOJiI=;
 b=VSFf22ZCWH9mWdd0sg0rApZqmicA+1nB0iAQ1MrZEUxOBHyqMZRw6hdIeq5sfmb5UNiGTDf0lEb5kaxKEbx0Nj7iUZ41gWbRFZpVJatEDMrlf+tch9wchoW1mQBphgHm97+hiBRb96CLPfeb65/lDIKWQW6SvhgvbnMiKXPLbfm1ElHKcDR6g7SSYgTKBcz/f+NmD3uWeBYZwgBpvWjBfdsU2hbVT9qUVuvnid/97zyj/xSe/w+XZmka7noDbAdybBnFuWO1sFE2dsjVhOsH9eWc6K5avjmahiwdKoSmSMxumy0p+HIvwXEyex9002qUo4JWbcGKQ+8BP4HxwSIaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFyCnzIPinv/+8QkBlkc8Nj8XYKgOu+lQrVr+RAOJiI=;
 b=Y1SF+QF5kLcZpXiXZKClKuARjIO47aONJPH0zdAL+49fUB4tglklY1541ASBYeH16j1FjHLcrBRoOt+VyQLPIg58b50n6O2T6qozVSg6hx2o9FCjygVnLs1Jjqf0+9V+2DiMAD4nt365ZJ046l4ulXhXZ+k2jSyi3QlDU/xPiIA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:10 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:10 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 18/38] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Fri, 20 Aug 2021 10:19:13 -0500
Message-Id: <20210820151933.22401-19-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f3c0ec-bd06-40f8-835d-08d963ee23d0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446A49B540E0D0CA28F23E0E5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHryrdF+ULNnpOzaM1PMg+YLfM7aDgpjZEsjY2HIysl1AQ8DDHNJvsM3swyWFdqU8toKjaf+Nm6Dw/Jt5e1fHgYcLArvbsAMReD+uWDNZ0tpWez+eTS9nbclofNHN38xCpWU45gAIe0Ug1cScU/Q47EiNEVAp5176xMqXzHi56I7sL9R/ylZmHJtZtKbN1Zcr0lLeM47XSPF5wV30GY0RiT+/qRCU9bVm+OqbyztKOYoTVS5Mx5qv+WEyK824ZFhBXAO0cP01pyzCUwXpxdwXPPciKtn9pH3/FxzfEY/9RkIzODgvK2bNznn2cIjXndUB9ivkm+ecFODwR2hOSN9N8kBXDiAdwMxyoQCelgTCCRURaRW7hAC8bB0p+S7S85kSjRV322t4CZNBP2myuxBuTAyBj7tSOUbivbBwj7KqKdO8avY6GQh2LIchhvlCGNe1LyLtDfWEdM04CtMEVRWBpr4oFw0hFKwlukhfwujJsDQqSaDmcKusmpFO3WOiHfhCjTJosDQTZiYzPuvx2moNzY9tXBgdRHq42e+KxYeeQ2V/0Z6ogSdEPR9hgKxjHs5N645UWYl6QB6Ju4GcVJPjl7T7u88JG2cc6fjs2thWiA6AeDhi3mntbJN7/S6VdZFpmHxU7Px10muCz85OhtcWRwc+G7sOGx9FJLVNZbbzYX4f0BrIGxqwtXEGAGXfflIzN4YIeQYFExKP+ljFJSv1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(6666004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AT+CxfuEhLBhrPt7gaJCXNW7xLlJIoI9P96cDb32EocBHtS+fxkQK75sUl0F?=
 =?us-ascii?Q?pJqoC/5jDZA5zUGdg2eZIx2Mbr3YkPf1pFsqyWrkqAisZxPmbytvL952gTb6?=
 =?us-ascii?Q?yKvscF9deC3xncwfxcUUr9HrKWUc1zarq0CIqZyLZsVrz5Flgy/urkhos6G+?=
 =?us-ascii?Q?Xw2mHgZowwVKygTkn8/Eyr+pE83Xxwdq5R2UoFtNlHi0hME37vSI4rM6nQLX?=
 =?us-ascii?Q?Zlhyn0AcRbWA5YMw60Lnx7RvPUGI866/2ZSiYb+qyazfxrjnslIoipVKM+cu?=
 =?us-ascii?Q?tuLm60pAsf6fEM1/dvJqXqXCGt2M/Oml2DRFQ4g4+uG8dBAzP46jGOS5V/IF?=
 =?us-ascii?Q?VyvKRp39cw5eQAz4sgwaMc/VIlkBvUMEF1Q/8s1WmvoJ7AUW+y10k9qNxfJf?=
 =?us-ascii?Q?YVwlMZ0ugghgo3xIaUCh/WCbyks0l8z93ouLW589CPo7OxqqBECNNkHkTnS/?=
 =?us-ascii?Q?FPAlQWHG3rEB6ecb6TpwLMCC875g8yWL5ebxmKz1S1cNTGQ8f3G/AZLgmhVh?=
 =?us-ascii?Q?B7GSOhuNP0OJASE+ZDvHrY6HO+hdbTxIkxwalhhQ4bnekuETaJPIJnNI538F?=
 =?us-ascii?Q?Pgx31R4A4CkP80aK96TZ8XfSd2bVrEBw86J6vWwfky3iA3hjP8JYxn4Gsbfq?=
 =?us-ascii?Q?FS6kIsXI7D38PsTGXuivenolP65EraRBQGRS5DhSuA/7TRwnyXbx9Qu6tsC7?=
 =?us-ascii?Q?hxeDU0iaJe9oCgCCMUxuF9GJFuh8wGz/bAGV5dfBTpU4UkSx025EWkSUTSX9?=
 =?us-ascii?Q?0sTOe62xeTqKZgK5W3hr+NG3ZY5fLfukeQdc/4a0WQkeRYaPnCLJdbDNcmYa?=
 =?us-ascii?Q?E2flmf89X7BouhTMupo5HiAyWkUlegoY0En1FfWy60Wp43b27ADgDxJCYQXd?=
 =?us-ascii?Q?2STj5hfEZ6jwklLSBZEO3Pl/Ja7sTLw3xKMSXbnCJifM5dA8p4LFV9OuXJPI?=
 =?us-ascii?Q?riGVZn1DmlCgdhx2ZdO4IvHyORuWLJxLZSwCLvA6GtKS09vfiFh9A8grdvbY?=
 =?us-ascii?Q?dCkMLUZ732xMfj30FL1JD4O3LD0fKWxC9hk3e5knkf+B8rjuytby2ZyTnw58?=
 =?us-ascii?Q?XNL7ev8NSgy+lHW2nFcYqEw+u2y20h8jAJUPfmqlT/+g0AFcbbJi0ln1ptCr?=
 =?us-ascii?Q?xfYVA8S2oi162WQyJdgM1nwo+AlV8O7Dh5XeR1DB0cfVAfB+XtsZ3vf38cMa?=
 =?us-ascii?Q?VPOTPxlDnu/yKAQfmDsV9HcikYcQyTci8LtBFlYVpslnVhBM13jdRXMrIpnG?=
 =?us-ascii?Q?bj2vF+dfu6bwQUS/0BP/BPRygOQUfhPat5njSSPVUIXYVOFaNkwOxBTuaFMD?=
 =?us-ascii?Q?y/TUqhNXqMR9wSj9VbXyzpo3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3c0ec-bd06-40f8-835d-08d963ee23d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:10.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX7mwwalk8LbosEIEv7VT1pKlp+RfQ7KDEMnEOWCZ8MLNg3Ld6jQH22FTbuu3CL0uAdaWmTEICP4Gs9pc3HJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hypervisor uses the sev_features field (offset 3B0h) in the Save State
Area to control the SEV-SNP guest features such as SNPActive, vTOM,
ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
the SEV_STATUS MSR.

While at it, update the dump_vmcb() to log the VMPL level.

See APM2 Table 15-34 and B-4 for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 6 ++++--
 arch/x86/kvm/svm/svm.c     | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index e322676039f4..5ac691c27dcc 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -236,7 +236,8 @@ struct vmcb_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u8 reserved_1[42];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -301,7 +302,8 @@ struct vmcb_save_area {
 	u64 sw_exit_info_1;
 	u64 sw_exit_info_2;
 	u64 sw_scratch;
-	u8 reserved_11[56];
+	u64 sev_features;
+	u8 reserved_11[48];
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e8ccab50ebf6..25773bf72158 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3237,8 +3237,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "tr:",
 	       save01->tr.selector, save01->tr.attrib,
 	       save01->tr.limit, save01->tr.base);
-	pr_err("cpl:            %d                efer:         %016llx\n",
-		save->cpl, save->efer);
+	pr_err("vmpl: %d   cpl:  %d               efer:          %016llx\n",
+	       save->vmpl, save->cpl, save->efer);
 	pr_err("%-15s %016llx %-13s %016llx\n",
 	       "cr0:", save->cr0, "cr2:", save->cr2);
 	pr_err("%-15s %016llx %-13s %016llx\n",
-- 
2.17.1

