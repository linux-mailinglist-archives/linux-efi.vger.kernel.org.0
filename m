Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9D3BEF74
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhGGSnA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:00 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:36832
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232919AbhGGSlt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDPq6Nx5od9ndsMHe+qKuHnUZrunb4NIhUDQw5X+OJeaLDikpK0RJmEUmxE2JRIfqj8tjV8yt7SK0L1Gh73kxQd0Ba72FaR6MP1gi9JJerZn/8lyY3HfQbU+O6FfkTfr84h7GblXSeV8RbLT9Cqx9BexWv/XgL2+wmO+pxnIPweKT878HvWhrmJmWZXo4DxTJ/krAzJrfJcBxcguPRQqdZt3SSDVMSBvoaj182WZWKza7M2D9ijfW6tsQvvFWr7Ql6oU6WvVIKoDhbM+1HrNYTM1hjA9HyoELik0k7AHzXq2yu7+q+dF/3weMMqUNWYHdqAv32Dx5nJMQbCCnwt1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuQ6jECD770ybRkBmH8s+erhZW7p02EbJr+4zvD24f0=;
 b=molAb8dfmByoOZtJxp5PqmBNwSKrntGxfuD/6tnK+y4jN52Z536D2xW5MXG/7F2MMvsalIhG4+jn2/HzyvfE//6y4GXsRnVmMZU5U1LjsA99u0RnpXExUwiEXRzVRJhYppGkA7sAYamTz7iuvARwpAQgobTMaArwhR35Kr0zgH0pJFRjXkyDrf+cBvgvojaLUw+P7WKMPf7NABavwSfcxtAurN/uq/x+KmZ6r4qd4gX0HhS/15YR2CZyIhAV2msMxAdCAvGf7IS/yxSR/3HbCTnIYuCCsxE7Cwav0taP/s2nFcITJ7z2B41/7sE51gQ9b+UOQOul/YcJjlcWO+4ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuQ6jECD770ybRkBmH8s+erhZW7p02EbJr+4zvD24f0=;
 b=acca1ZLbjN0fFl8Bu8sN9kWlV9QVluFh7ncbkQNyaYGFJXafobmQ1LumfOitSuvCRmpSd1HPv9Ekrloe+D9ajV/8vz6ZGKFW0TB7KjMjqYa/YE5abJdS96x0UYWcJZrOqVxD/b9k2eYqRGaeFAvpQLlx0zd/GEVbohKsjXvtvB0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:12 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:12 +0000
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
Subject: [PATCH Part2 RFC v4 30/40] KVM: X86: Define new RMP check related #NPF error bits
Date:   Wed,  7 Jul 2021 13:36:06 -0500
Message-Id: <20210707183616.5620-31-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6216c3-c8f7-420f-dd66-08d941765fff
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40827DA277F8AFDE9AEF9C11E51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYcpruXvypZvk8eSF7XPsBtW8SctmASGxfsf2AbuYYBtd7+MSiE9gEAv2VPB6v+EULaMxbS59ZHbQm11TfYI6zTQasVl5xcOz1nMJpG6+uqVibQhshtSV3NA9B43gQzRzWh5wFJZeRFZO0qq1O+uH26SLIfATtDzhBEbyC1fVMYlMhqsBCjRSQScoKzCX2yjlhD/GPZKz7K0rVoYynIu7XgKMDVDZNPTk/m+CCEm5RceWrR8pQ5/Q2MctqKGv0BoU8kfYl0vu/Ks+n0BPEPKH8RFJtxA8iDBINO9S70rMvzhxmbykG4fnAcNt8FsRIUmoGfnk+JBmaKUYIwg1iG8GvwDM3gE1mflow1aC+acWPvrUtIaXP60W2j8Ww6fYEAILJKl2rLigfoXvEKp39Mt0zvSIQqnXwf/5NyjGMXUdNsXWDMGp2eO+p3NikjehCpQXYHdf3FZvUBoiSp2Cxq2CzhnloDcGMrpfswcTkbKJ+gpf8NZrbUt/HeC+TbTdmnxrgwtalbb6GuAENRo4cPVGs/wggi6xkUQxYFg/Pf6/ScmGzrljs0Le8S2OZfXXWcHTVvEx3h0bKz9JGOpX1xbDKutJ0wLIBx00oCSroGhzOMh3HWI/0yKwTtsfrlL5kY4i2cmpxoSzA1qMYBHxmS6L4gkKi8tRZqq51bOPPfUyjRcksbghYta5D487ycvfQQN+VF7Pp0n7QfmrJCvEhStGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0cdMLuw0T6bBAbnyyZd3gExyvhWO0L8HhErufAmslxIppHLxkdkEok4lsjw?=
 =?us-ascii?Q?0SVEMsNXNGTRrb0mvZUi+Cw0kYJvfAWQyIuimaAxiMxk8o+ZBwqcfCPdgQ2X?=
 =?us-ascii?Q?inMZfWI8MwAo1jUnjo3GSIqXrY2QAHF9TBco55t4qV020Ah+LEiVl7v//zbw?=
 =?us-ascii?Q?QrdT1w4Hxbz4ThEu0pjIunbAYteng0P0o7Z2REKTukirL/N2AsBiOT+RnC+t?=
 =?us-ascii?Q?6ebr7/9p5Iu40BbNu8mA4F5TaPLyKcOPueZF7kTIDroDXZJHQ89khz7EaY7z?=
 =?us-ascii?Q?ImWORk6Ynsjh2xh4cEWmYkKJYDxbrbPOK1yTW/Pe+PRiYKjIFEe4Hy3LhslR?=
 =?us-ascii?Q?4WwUPGmXgrH2qkzHFw2O2uLJJF88RjVn3mkVa7VimvsdRf8RwfO6EApPI+1J?=
 =?us-ascii?Q?mBxcncOHovM/bvqe9UpMghux2amb/jXNECx4Qvf3ymUMZovGZbZFUN228NIL?=
 =?us-ascii?Q?cV1koTA3QPVdZyIMuqbsNd39KE2fGrJF14ntomQyeA8rjpMerzBWUkEyf715?=
 =?us-ascii?Q?TcKIoXi1k4+KAbfzdYRtvCQGvnFi4+ZtlrD7423IF1Rwe0bKsNQ0EDyUS73D?=
 =?us-ascii?Q?tDlxFxU8Paz0dulkVVK2qg+6nhQhowwJObxpVC6lthngR+s7Bk+EX7esUrKZ?=
 =?us-ascii?Q?MuvqKas7ei1TTxMc5PwYel8C/MmMIsT1TrYTLDN6fgRRWZnNwB1/SIKJI3u7?=
 =?us-ascii?Q?8c7sr67H8czqTx8HkUTsUrRrbiiUvJxg1qIjADqNw4rBfJ7/RmcfMHcC6awV?=
 =?us-ascii?Q?FKAvoEJq32yhWF3T527R+r0CQE9O4zwpMudYYKrs9JNj4L8tcMnjnWmdGQZA?=
 =?us-ascii?Q?SaJcUuKtiAtzYEiQhCZBPM8AsR9HmrxNbBC5RxEQfxwKW0CLpL5P4EDk8BZI?=
 =?us-ascii?Q?WHjHHHMyOni8jB932mFedCnuA9EqCB/LVCh3P9IW/4aEK5dcNl+0SPKP2r0V?=
 =?us-ascii?Q?urHCbppzV/JO8SyZfDHwh4gBaBPxSDufTzhbWS2M1i+Q7Jv4MTMhGLj5kcGA?=
 =?us-ascii?Q?ohA3sjjDYn4hd0DslC9xgWS03DJHmtwAcUqHx0zs2PDWHtF3fdh8bn6F+Dzs?=
 =?us-ascii?Q?jJb+dEr0MZiT87T5XSZEe21tw9xtFisZhSX2WyLl7GmvWFLALcybO1zQFZZl?=
 =?us-ascii?Q?gt2uWqz/RBGwWsuhP7C/E28l7Di5739RNBe9AL1Dzm2SB7nUfz/lghCDPDRx?=
 =?us-ascii?Q?t7qKNb8eO4+MORDM6cQi+XnXyd0ew4DtD02PboVI6Gmo0tUlFKIvvA+frsaa?=
 =?us-ascii?Q?fXXHvP3OOgajDrM0ljQq4+xWE0n2eBuSkwSo/TvINYIvlGRkN/8C3LHwWPwG?=
 =?us-ascii?Q?srVdqgoGnKIlzttFOBgZCTlI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6216c3-c8f7-420f-dd66-08d941765fff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:12.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XYg23nNB2yDtQ3DEmDxjNufO2SDOkYMKif3inBzUx/k0PwAynvxEOmBcDaXQBdkDRRYG5uKgArNTiILPVrTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When SEV-SNP is enabled globally, the hardware places restrictions on all
memory accesses based on the RMP entry, whether the hyperviso or a VM,
performs the accesses. When hardware encounters an RMP access violation
during a guest access, it will cause a #VMEXIT(NPF).

See APM2 section 16.36.10 for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cd2e19e1d323..59185b6bc82a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -239,8 +239,12 @@ enum x86_intercept_stage;
 #define PFERR_FETCH_BIT 4
 #define PFERR_PK_BIT 5
 #define PFERR_SGX_BIT 15
+#define PFERR_GUEST_RMP_BIT 31
 #define PFERR_GUEST_FINAL_BIT 32
 #define PFERR_GUEST_PAGE_BIT 33
+#define PFERR_GUEST_ENC_BIT 34
+#define PFERR_GUEST_SIZEM_BIT 35
+#define PFERR_GUEST_VMPL_BIT 36
 
 #define PFERR_PRESENT_MASK (1U << PFERR_PRESENT_BIT)
 #define PFERR_WRITE_MASK (1U << PFERR_WRITE_BIT)
@@ -251,6 +255,10 @@ enum x86_intercept_stage;
 #define PFERR_SGX_MASK (1U << PFERR_SGX_BIT)
 #define PFERR_GUEST_FINAL_MASK (1ULL << PFERR_GUEST_FINAL_BIT)
 #define PFERR_GUEST_PAGE_MASK (1ULL << PFERR_GUEST_PAGE_BIT)
+#define PFERR_GUEST_RMP_MASK (1ULL << PFERR_GUEST_RMP_BIT)
+#define PFERR_GUEST_ENC_MASK (1ULL << PFERR_GUEST_ENC_BIT)
+#define PFERR_GUEST_SIZEM_MASK (1ULL << PFERR_GUEST_SIZEM_BIT)
+#define PFERR_GUEST_VMPL_MASK (1ULL << PFERR_GUEST_VMPL_BIT)
 
 #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
 				 PFERR_WRITE_MASK |		\
-- 
2.17.1

