Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F624398BA5
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFBOIM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:08:12 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:37216
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230093AbhFBOHU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0LyKYs2hKNb0bNVUlV3mTHYJq4NCNG3DUnuvNEup5DBPFhzrNVfxX0gMqdz+ELVPmtBuiWkA4DYHsrrSQ24GHsbD4iaBCzeY4TK5lj+JgN5FxuEVBFDjf64MZ5bBHL1YU5LeSYgi0T6l6zYVPPgQpNnZ/vVwJXiwfu9LkCk9BnWwfeJ9D0QJhGuqFbJy4kVkPoXa5fs1j+N2vYTXUWOa2q07Xj5REmgvvsrhlLM8rUSWE0UOHBCWWK6FK6E0KYJpYa6qGPJv7fBjSc2Ir82l+KYWilBz6ZWCvzxORcdDEtZeFYhp65Fgen52SNJJiYLH6eZPZZSjU3KJq2ZZV1E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JhxqSka73eZEhSsicofqkCL2gbRrNJ9DD4pCzki9Q=;
 b=ETaiQbEZ5oudP9HGADRP3iv5I00tdBddGq9uk7IvcN72qz2Eezl9rC0Nz6V2rMzzu7899RoXIoC/q5llcEFA9+d+7Mo0GzKil215S6ILRGl+DmuqN0sxe/yj+V3x26mbt4dyQbcLYzGqqpJp+RfxB7jSFnVJ8Lr4rxVv/iYved4GRbJr8+Rmchqrc2rw0YVAAglNWT41E7FxHCQSg8UTXCXQ0u/nYQ7q+FVpdOyuqKU7ljOYOVBMakKKJD2K/TXCS3kYXb85mDLxctRC7uSh+9RechAWyf+rThLJ9yRoKOAeH73gLamZGwQxPMFgZQGZjrL0u6kRtqnlpsXzrA/5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JhxqSka73eZEhSsicofqkCL2gbRrNJ9DD4pCzki9Q=;
 b=nBEktVK38UGaUxUOvo/TOdo/At6P+k6Ebr4EI2UPBKZ4WEpRkzVV23s0NmIzELkC71XbWE9PxnuQS7IoNVAN4LKifek0TpoYzBBEN/tpiLg9ROofMqdy29byi0k09umEvP2Xg3+F8RB27SyDBWbvBMfC1LxHLeHlXLkUZ18qfwI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:04:59 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:59 +0000
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
Subject: [PATCH Part1 RFC v3 12/22] x86/kernel: Make the bss.decrypted section shared in RMP table
Date:   Wed,  2 Jun 2021 09:04:06 -0500
Message-Id: <20210602140416.23573-13-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086a58ba-9ae5-4089-dccc-08d925cf6793
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27667551B4CC005B286BF700E53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/qmT3VUUaHs/FG0ISKZANvVC4j+NE03guJ7pAe9gQ8BYj1r0h4Wfg4l0Sl9m+bTkH24xmvjpdHasq0Zrr1J1+u0+bo6IOtJR3f/h/L6oKdHyA27/DgpyQYMvKnvLOuQvgVldwAM/ewgpVJ59MvAiWNyTWug0IgkCxuPnvcqyYXXrAnBb3GRlCauFYgdYI1EkvNGpYAcy9A0HLt7hZuGIay6oIsE8AiwyUeENOYwzgj4+uBBT1WtJPfdprnH3pLRcO3W9GqtLDr0DvnGhVQOy14wEdn+d/pqqgcdi4WPSoPpUTGwHEkz+NvNzK9NosD5RjdimXiSd3GZOZy20aNtF5uLrjt1qj/jXbYX/CSWrAaPgd6kjAM+DKSphxtkTE2ux5usZ2+adisL8BPo+lnz88hk1Bv0vyex08ObuyloLRL2KrafYG3GKsOyJ9H8B5JTHX/pZoIIZuKxNV/tK7vJusumHtpdNY1A2eyRkPCiPL4iYyZwmUHV/ITNnJ3Z+hIVCN5Wu1GG05F73ipOcan6YTtxROA9YHuveJKtp6DJF64JMxzpGCvJu/xriqycbGmIN8wn575ZszP+Tc9UG04pUWOKUs7lET5L/b/3bU7t+zHUqcH+ZLz1Z3NgJOMHsr9Z3QA+/5pexl05zVBzFboIeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(83380400001)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(6666004)(66476007)(478600001)(5660300002)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t/LfuCVb4vBYxe2e4KhvjRl6+HhUnbRDxLo8zu9TKLCrlLEn7v9CSilt+DEB?=
 =?us-ascii?Q?q82/Cek43bkRv8zXeMuRsdi2zc/KfYi6GlLP0twLmQL6GILD8lj1LpXiaWEx?=
 =?us-ascii?Q?Ezg2VKS9NqS03HreP45MUClYXJVKTRjswZscPgQ2pC1bIDtlezCMN1F4LZjT?=
 =?us-ascii?Q?LnVD0zKDm5LX5OpEoJpRtT47BYNOSQbfDHXW0FCgErjHWTJPJhyoOYq+ENwu?=
 =?us-ascii?Q?zgf1RXIZSsy3reEBUW2MH5vPBLX7larvabUD+1sJnyQHFjqwg2RdJOpQrVYM?=
 =?us-ascii?Q?zV3+IzMQujQ6AQqYAfeYF+DMypWrBRFhgV1ZgK0J9WeUTkBpF75r6kwpaiEw?=
 =?us-ascii?Q?2HmGd9ytFGSTuNLWMt++jI1sV5tYEzCUihraufc/mxMFXqFWvUeMHElHAkqc?=
 =?us-ascii?Q?4AzWJ2lb/l5FTa6T8HRgjL17Tn57IrJmIjqRoRqwde7fjFBwrfQUFlSLS0Bv?=
 =?us-ascii?Q?X9ueXldiHHmf8w3buL1tEp1KUbffCHW0zsy9FE9qxL2gLyH/q9TZfy3agDEU?=
 =?us-ascii?Q?IhT6eXLfw1LNnx0lne7IFo82h1jNbbolyefdg673dgerRBZbQOklQtyXW2kR?=
 =?us-ascii?Q?RHmLwe9nTohRUV0N9Hyk7R/V2FrS4DPj59EFZoMzKxAa8F6L1ptLF0egzLJf?=
 =?us-ascii?Q?MMcbwX4qAQq2F7MxyXmy/YfNktZDdStB3mqNDAVh6ZowQpgAAHIwWINUWv8r?=
 =?us-ascii?Q?iW6PmCzL/haj1xkMhsgepZ686vCtl3wi1XwHuuzZf53+yAZJMAwSCE1dVnju?=
 =?us-ascii?Q?plQ3WAVr+PU6IFDSt2CJGHpmUfTK7f0o7yXHiL7zwsyAEBt4ECKvVKWVhRjt?=
 =?us-ascii?Q?z8I1z4dZf2l1DmpV/xRrRRzr0w+AIrGj2cc891vTATiN7QqUIuCw6hWZ9AOA?=
 =?us-ascii?Q?WJLJwqqFRg+fPzVSCQ3aSkNvmC2W8qBmEayGJh2uMQqPXahP0RxTqZWvdUlL?=
 =?us-ascii?Q?6vWy7Zm/v7blvL7DB8zEFQPlyqPsm+kc0HSY19kuxto1I5MqxdiTMqzbpeR8?=
 =?us-ascii?Q?yQplvqqo6RBMy8AdqEwNyG/RJNBNgb/o2dIowOfBRlnymdu6JtlT9Ig9aKi8?=
 =?us-ascii?Q?7yxtAWJ0fS68dVa50TXySHlVApsD0QQINN5X47MkY6urC9fTTCK6bCLXIg3T?=
 =?us-ascii?Q?MX2j9Iv8qV2ZffiOnnlhqa58ErF7SM4JAqP2Xa7D/CJALiib7+21Y3EO7Am9?=
 =?us-ascii?Q?Iw+9hQ6FAEdn02jrkaYHxE/xLPtRch1y07VdChpOUBefXtWTcgiEactC76Fi?=
 =?us-ascii?Q?7ib2t9cHurRoKkk2TY6PJjrmFOLTNBp6LRa4a2MV/tZKA+KzjSd+GzM7sFOl?=
 =?us-ascii?Q?CkQGm0ScS9CgFmZAxB+rV+k6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086a58ba-9ae5-4089-dccc-08d925cf6793
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:58.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5wic2EQO1WWU6+jTNCGsluTK7GyeVhiME3lEIlMHlQinTrsCP9vuTVqcds2BI423fcxHHueUZg/bKFEDkve7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the bss.decrypted region is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..f4c3e632345a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -288,7 +288,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (mem_encrypt_active()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * When SEV-SNP is active then transition the page to shared in the RMP
+			 * table so that it is consistent with the page table attribute change.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.17.1

