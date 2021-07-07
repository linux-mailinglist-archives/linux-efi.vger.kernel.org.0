Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E463BEE44
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhGGST7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:59 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:17601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231755AbhGGST2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrJinAzbDw6leG9de3XeUW1Fk3fAPcjLTAq4Z61V7r+xqrXWCEwdTw0+HSQVKIIcuJZrmHPiq9ui84Zm7/ZBJ0248SW18Jd1WxRb10ONWlaR3AWR4a/IwhDdXPVWHQohYB6q4zM7ZBsVT4JvNW9b66nqU/EaOc6xTa3sBbSphd8az/RJSqZaHgabzaEVqSMAFQkCU9syEd1r2/IAGvsM00qFbRcuUWFFUOtvv/LtjUyDSxQzqIw8WNDGvEvVDrGpjiVa7ta4cexG+qIXJSednLibJv+Ba5vdPRtnNMFUF/TMpsxXXeKAOAZjS6ZmE6hl6ztaNdBt3CUvo9kefDHtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcyoz5aUvbLHR2AC0SIalCexZMW2z/HEutwVqkx1aPs=;
 b=jCsSMuIE0AeN/CqP4Vj9EnHgkUBMUXwsGioRonbp0Bj/rcKPFUGEru3xNwyO/GNr2Sv7onL27OOZAE9gsujsv7a4AxrwmvenICAzuCmkYaXE83m/+aImgdzM8DoG05qB3i7J7gT90SgT5TCcR/PXwpbOLL/nlVXl3ik8OSiHhFTqZKRB2QAY2wGNRV/PZlTLSf6FQ6hjUpXJtBAexTZ2Acdua0rI0DAa5xKKRo2lXQCCQQpehK9wysTLHgCCSiFeQOO4s1YledtspsE0evoUdSL40qzQxGyWmOIYi2FQf0cfrOJaBpPotgFjor/UqVy1SPX3klSmmDMPqi8uC7LVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcyoz5aUvbLHR2AC0SIalCexZMW2z/HEutwVqkx1aPs=;
 b=LtciZA8iMEl0eG5qIibvgzoNzN7BEDPWUwu1LhIIn7XiNfsFRTfd4jrJXd+Hj3X5TKn72x/xXfq+VbdefKd5BNkeuSZyKIT8rs+wn3q+adZIkNDmp93xEEBmJiUxtWOZ/0cHv67ilxeljhsALCiDm+k3qHvYx7/J96WGtEWeGkA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:16:08 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:08 +0000
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
Subject: [PATCH Part1 RFC v4 16/36] KVM: SVM: define new SEV_FEATURES field in the VMCB Save State Area
Date:   Wed,  7 Jul 2021 13:14:46 -0500
Message-Id: <20210707181506.30489-17-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce648527-c3be-43ca-f235-08d941734a88
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB464427F04283EA04EFF99A8AE51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOW+guXPaU4CbIQglm1gr8l6aFQ0J30BHFyjTeXdAR1tHk9GqpnmTgf3HYvhXGXiObt2UQRlCcOMucUk1JSbfrqz1nbVt7Riw7cFJwOYwx2xeSUjSsZdxzzyWAhASw9UmNwW3zqM0NqnbXWCZdiZSzud5HMw7Kv79tXp8l9AvufI5hqHS50Gh1mWP8d/tmg9EmnomlWnNC/JeXjarIfo2md3MLjzVrDQ8V2IbxlgECYhI7QDKra9kN0watHKNfhV68HmFkLMh4diNiH3nUtXr6xJsYA3Zc1JzlG1FoNDC4xll0bHGUCvp/1zBe6GFRN30POpD/J4P8xqxXiGka6N8sGP6IDEKr4THMnN1yWTt1M6ZMFrSrj79PXuQvQtEuoISqJUBPWboU65cc57L4HTnRLc06JkE3l13d/7qlGrP9gbQtutJ4nEPNTIn/XsaBtHseRpe02p7SZkolcXvJ3/FsXIUCq5h3BbpoLrJt1PeoO04cIkNbA6AaT9n8//HCKZck9E2yyVYUvg7tRj4a6Woi8sNlowUnvutU8sBWE5yynZr15VDD4HvgJhDMDMfvb8/E1AZKiOekKX2BGhKhCk0nipSr7SOVR20lULwYRChNcy+sXkKPwPJqfNXoULygC/h6K2kUDuiDLVm+ddppi26FauxIxs5tAJEMeFRxCGzFd1dPNIa3hfnXuNFD9rTqjf8nW4XsFGbAkkvkVUX+6DaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(6666004)(2906002)(1076003)(4326008)(83380400001)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elEEzqqobmjRDWRowTxGWfU4vclYhzMTKwsc582m/kvcL1dzLiCvFwO0fNIw?=
 =?us-ascii?Q?yXpFVBGDxNzlpzFvTj9MuKZSyoCLWb8w5fzTm2RFz6TMYY4/KKV9TIbqZADr?=
 =?us-ascii?Q?TrgrjOcjgta2iea0VdmZ7kfoxpQrkvLNbJjPhmaNWLIfdI7087gYfdHSgIrK?=
 =?us-ascii?Q?0/sAMmNjkStwGe81kGye/ochMS9S7Kc9sVdy622+4Otow+wfJ0Adv5Rz1S3C?=
 =?us-ascii?Q?q2CQ7EkSfcFOoFbLxc6YKVvlX9HsT6YQGqwgdKGvThXFfdYqLw0mSmZGfsTz?=
 =?us-ascii?Q?pD1ggsNNNF3hBhiUlAc8uaKAlcySJHmUWgv/VwqGbTse+Ont1KjgPe0csGoU?=
 =?us-ascii?Q?ejoINkjKbq1f1JvLg2Nl6378639LtTmMJ54ADAmkA6naon8eLEJ2Fm++3SYy?=
 =?us-ascii?Q?NWMXJrePFbG8bvzpFdz+siIioZ19NUC7JXUXCYeBcJ6JefyfbarGd40KpXrJ?=
 =?us-ascii?Q?Mrl5Akgj3/Suj2VlgTPPOOjR8UXlm2T2U1EHvacbONRV9MZo7/Tm3XVB0xn7?=
 =?us-ascii?Q?HwsynJNjMWkq9KkhjixELoNS1kTGSfYpJabZA5cCOHt2tmhSJVIiWDPdqpGH?=
 =?us-ascii?Q?x068YYJ9tYSGPnfb9d2wFuOFh7fv9xOsiITx7YbEjQLxQkfIsGemYTD0Lr0g?=
 =?us-ascii?Q?Fq8U6sRSEv99eLyog72qfcOK6DsXdtQlp4IAhZs0a5AqVB/4Hq25hslhSWQv?=
 =?us-ascii?Q?tZ1FAUIXXgWnL1iOT5uoHmdywiBAunDVagnXI5DNy56yS6HtJzoxmEsR7Dv9?=
 =?us-ascii?Q?MA/L2RdUE+uhtvP+06Rgb+0pCWdmRPzMShAY5SUUZiv2TAXNzqeC67RLExrj?=
 =?us-ascii?Q?apvTK1ZL75YJalVF35h1SQIzWtGGUrKuiS6FSRyGdr2TB+vOYK7SmDQsjrXf?=
 =?us-ascii?Q?9fhFWBfdp0BGSdFWPnZj8/a7/kGsZ2QEIazDmlJ5P5Bcnwn9IL8KxI1AlVeT?=
 =?us-ascii?Q?i8P0DPTA6Yya58zcHznYPyS+uyC+M5o6IYDpj8B79BFMwJ8zfIPDUK2oNI82?=
 =?us-ascii?Q?bVgJpYb/2GvaYEtXZAJ/uEtq+OlyrTmFjxBdDnsw+ObypGfKqLSFTpB7VvXe?=
 =?us-ascii?Q?hR5/PFxew8hhXwP7My6YOOQ07q0EPV3vtUoHETAMoHFH4lL+L1CNY09LCv7/?=
 =?us-ascii?Q?eIgAojC1s6kV2ZEgLWuc+2ABANNyDFz1w9SoQ2MMgWWlwDu9QWkOwW3ldjXq?=
 =?us-ascii?Q?dozHTpfTa0FsFAys3S/VH5aEm7Th0K7dfUUieW7qhqHdV5nZJk0R+vRl2nbW?=
 =?us-ascii?Q?8NmF6dQ+QAwoeRYP4lHQ46T2bo1qG+2J0nEJTSykXfoWgbx9bb2nTbi092j/?=
 =?us-ascii?Q?pZxUYnOcB1RMub+HAfd4QX1l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce648527-c3be-43ca-f235-08d941734a88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:07.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdpX41fwvi2sL+vKOklu6bxRBNYFLmx8TQ69M5uzahzvkHsx+mm5bNLbwvB1FgVfRSsftp/yjgOSqn4uNoamFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hypervisor uses the SEV_FEATURES field (offset 3B0h) in the Save State
Area to control the SEV-SNP guest features such as SNPActive, vTOM,
ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
the SEV_STATUS MSR.

While at it, update the dump_vmcb() to log the VMPL level.

See APM2 Table 15-34 and B-4 for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 15 +++++++++++++--
 arch/x86/kvm/svm/svm.c     |  4 ++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 772e60efe243..ff614cdcf628 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -212,6 +212,15 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
 #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
 
+#define SVM_SEV_FEATURES_SNP_ACTIVE		BIT(0)
+#define SVM_SEV_FEATURES_VTOM			BIT(1)
+#define SVM_SEV_FEATURES_REFLECT_VC		BIT(2)
+#define SVM_SEV_FEATURES_RESTRICTED_INJECTION	BIT(3)
+#define SVM_SEV_FEATURES_ALTERNATE_INJECTION	BIT(4)
+#define SVM_SEV_FEATURES_DEBUG_SWAP		BIT(5)
+#define SVM_SEV_FEATURES_PREVENT_HOST_IBS	BIT(6)
+#define SVM_SEV_FEATURES_BTB_ISOLATION		BIT(7)
+
 struct vmcb_seg {
 	u16 selector;
 	u16 attrib;
@@ -230,7 +239,8 @@ struct vmcb_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u8 reserved_1[42];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -295,7 +305,8 @@ struct vmcb_save_area {
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
index e088086f3de6..293c9e03da5a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3184,8 +3184,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "tr:",
 	       save01->tr.selector, save01->tr.attrib,
 	       save01->tr.limit, save01->tr.base);
-	pr_err("cpl:            %d                efer:         %016llx\n",
-		save->cpl, save->efer);
+	pr_err("vmpl: %d   cpl:  %d               efer:          %016llx\n",
+		save->vmpl, save->cpl, save->efer);
 	pr_err("%-15s %016llx %-13s %016llx\n",
 	       "cr0:", save->cr0, "cr2:", save->cr2);
 	pr_err("%-15s %016llx %-13s %016llx\n",
-- 
2.17.1

