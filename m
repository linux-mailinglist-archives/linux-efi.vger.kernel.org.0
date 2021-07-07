Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A113BEF78
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhGGSnB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:01 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:61152
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232921AbhGGSlt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DG6vcA01wDCi5xZwwzt0W7QowCCuFFNCCQXJPYnhYrQpO2MH6C9eP53EKd5I6PNf3LKars3efWe4VTuQtS/8nYVOC//+rsM6fxv2V/TMDTWjWD3m60eI92nyEC+cmMzdDlzjkvXPyUQT3h9c040ezOdTsBqSzdQFsYddvjpn9Pam0aaadADvBt0+zaPMNLuF0aRk8MkN0VZJfffl7EHVBiCe/UyogXjHDFHAn2PaZ+SP7w4STCNT38JoquHq2/dyh3N40z0MqdMKLfvSUfpAhVyen4ZfUyiWtQsQ2mC8io+uDWhZY7nxLfpHdae5UKry5S4DQMKIc2EoU1pVH1CjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3ig/SjWmQav36LO/5124ek20xvq0ll+4Y9DKzjMrzk=;
 b=Lc0Fx8OeEs0XuUX8XUBrpskfuvjdYIey0GmK4b5IIOjHPMmd7euVZBMT313H0dr21KPUhItRchCgZD33hZPpokyosHosKTA7J1uRZSh9QpiNKo1RL2xGoT3jHLCRaFqIJQvJxTeAD1tnjmn7JOs4Cn10uTAAW7zm+yUxTufFs2gCv0GRXNmC1NtCkmq6L1aCOQhcnssCTv59/oVzs3GgVwc3bVULgkvMaOwMeWfrRnELZq0F+OseWUX5gTYePhyTfH8IFKQtJJ0gun3CZkRmTSDtAJXDPQK8HxHLfl70Guv69Cg+EJomMPPKImXUQtW99jiz8Q38nglya8DCZggCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3ig/SjWmQav36LO/5124ek20xvq0ll+4Y9DKzjMrzk=;
 b=5Qq4k1B9CFIkcUxkg3LmXF6xxx/BYL5e2zSSBHr9ZfXBPo034tB/XI0rTuaLSGSyNnGkohSZVmx+od0t4HGPriqvgeF7if675PdNdO3AbO3RFtkVXAja8b4ZD5pPTfqW5gf4I1THY+T+fg94ax7mKlK/kpJQXjFoAd6OaAZEpvA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:25 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:25 +0000
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
Subject: [PATCH Part2 RFC v4 35/40] KVM: Add arch hooks to track the host write to guest memory
Date:   Wed,  7 Jul 2021 13:36:11 -0500
Message-Id: <20210707183616.5620-36-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f947ac85-85fb-4a24-9e14-08d9417667c6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40999956F351D8BE4103363CE51A9@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdUx6bTpXh3FCZxGXEVqrZy5kvXkc4c+PGDqJR63bIsOwXvWOh1h9nnUJzsBL4931PTBGFVaet7h/Vxb2KImqZmAs3m0szP5cYFnfD1alj6i2AL5qAbXk5HVp2XDq3NkotXjJ5YxGp1YIUsZEuRqyMsDdsYudNtUPezDbnS3ZXsi/M1AqVYG2vvacJNsxaYhYcQ1NIoNvHAxYZG4Qhc64wp+4S9Vpzzca4iak/K6bqrk+fihkMd2YJXiOQfeYqqzMoo+FZ+px8n2tgv8SYhq6onQMEAISGz4MO/LMSX/V1yVuVIWKCr34YSeIO87cO+l2uO8gJYKutOgvORJhcVellCXXz1U/TON8X3sXm4jEc0SncFLfcvlfDb0RaNWSoVNJM2RXFsZTSajbvduyTUX5Yn3FD0hSiY3HTxc2c+tt+e/DnOpW5pDuZh+q6zhXTIzqIxbXfc9NngrHGgyhxELr4HY9Zz9AGA2uDu0ObqN9Z31tsrLOSPy/C+pLx6+Pnk631pU9DbgClQ1XD93u+B3eCC6ekVrSt4J01bM+Og+ct22DUB959w+xrUvs4mppF97kLI2vbPFM5Zb5F71r1mPoHqbyWCKElsuuT1hwGxr9Ntk3CjNCjsZJK8TukZYgTEB5u350XcmCq42Xl+5tWhK8jolenUarCb6IT1mroyAO1Z+ktCLHDpvFVGZrmay0PvgIdBLIR8uIhl+Tf+iqOMvaWVJYwtBqdimB2e+bB8AnCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(7696005)(54906003)(2906002)(36756003)(52116002)(8676002)(7406005)(7416002)(6666004)(30864003)(38100700002)(38350700002)(4326008)(316002)(66946007)(1076003)(44832011)(6486002)(26005)(2616005)(5660300002)(478600001)(186003)(86362001)(956004)(8936002)(66476007)(66556008)(83380400001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXuC4tCHJGMs2UlU6t3YiYaYu4d4FSjwUK6Vp2jg9sy9Uos0wFiA1ulJCPT3?=
 =?us-ascii?Q?OsLP4YIqdJsZl/FaEox8qvKAIbiRcre/rfuq5tk167WzQdniAbSK+lkJmaPX?=
 =?us-ascii?Q?CPr1LK/zYKFUQS+A2gELWzVZbdfZFMhN6+sJ+JHe7U3agJr55QS/Ae2qQefA?=
 =?us-ascii?Q?hQQH4RMe1dleo17QM8itVYyeBy++pvHPTcJfZZcrW43d3UfwTfDiFK2+0T13?=
 =?us-ascii?Q?KW4UBFar1PZ+gQvuklJq9bbLkjQbRFCZfTHarYODR/xOwzcjtoOy9TZY1vRN?=
 =?us-ascii?Q?dtz1FHP39Zy6ooFnMiPtshUdkVJHnmA+OzyZlSxHhOIcgNX3aZZsFre/Ep8i?=
 =?us-ascii?Q?R+/0YXLqykxg675O9wpt2M00atDB2KjwxtNBI5QsiINwn1vtsx4sknc/IjWu?=
 =?us-ascii?Q?bhDD1/+KDaUa866aJdoAsWqo/jqESci0FrLezNBbQzgF38zxMGI4JvvuZjlm?=
 =?us-ascii?Q?D6ubvcZyxeBMtPC8eZdS2rruf5argNkrAQyNfx+VM+7fQXi51vhEXYPB1yv2?=
 =?us-ascii?Q?YoN0lGaRJ91VMsbWiruHaOQwKfkw/7BtTB8IAJSKD5JTqmOMethwvFsDxB8X?=
 =?us-ascii?Q?u729YeDJV136HPwfMo/gjFjP/o0JkfEM65+74dBatKoKnMt5+JMFophXJgXq?=
 =?us-ascii?Q?DACYdQuRsJkjXoCA9WwwysqDsxY4FddJ8NNu6AkqEWBJ5jLwcPYLMkNzkit2?=
 =?us-ascii?Q?ZDC+YB4+pWca8JDO3rNxoX30DnKHRBQ0gFY6MlJ7S1BVjueGeKJSbMFc05mE?=
 =?us-ascii?Q?QvRqjHlbsP42gHGEIVQScGf511L+Q4pdHqoaG3FDieXFopEgudiUvmGNalkH?=
 =?us-ascii?Q?7YzDKUDIXNaZ/y9VzH1eS8c15z6orM5lbHMPsqN+FKX8E4kBKB3qoOIiVHLS?=
 =?us-ascii?Q?W+8MqAIx3VU6Y9xic0zEmnG/+fLzWl+42SqSz22z24wsvOwDjA29Chn4ZRtp?=
 =?us-ascii?Q?oGNaZKEbpkWs4E6y+FjWiLUf3EXsDkAm+XOy2Fqa/QZRUu6XR+Rj7dahirQE?=
 =?us-ascii?Q?dr3Hr7SijA/eVVJpVLc5bYszAqvJ2Z03foy+QZqHD35fbaBlMLQJgxkgP+o9?=
 =?us-ascii?Q?yJkVcE208JeXpUNqZ4j+UUvm2IXQY2UO+F/coagjapuxx7OWJT8hozc83Lxy?=
 =?us-ascii?Q?NH8neTQ4hJcAP65i3B0GwIHoBPAEhT0IWTAsnjl+l/0WmT05iDtcLuB44uN2?=
 =?us-ascii?Q?cPQbKeGGy9MMVqH/GUYCJEQmqSqin0TlgLwXeJ/a9yhDy8jALlReXNi8Dl29?=
 =?us-ascii?Q?CTC8dOQBLcYAIgHdIaGL2yEMlQSn6wVUOAsC+Ljegkw4uzyya5GJKNH37VVm?=
 =?us-ascii?Q?hgpWcQCfjUmx6aIbpGJTGBM0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f947ac85-85fb-4a24-9e14-08d9417667c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:25.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RfxgWPgoyxPELOkcchszRMzly8webhEy0OUgLCCI1E1tLOAYIdWlpD5npbJcmnviizNDiTRvGXM+CiuFTUYDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The kvm_write_guest{_page} and kvm_vcpu_write_guest{_page} are used by
the hypevisor to write to the guest memory. The kvm_vcpu_map() and
kvm_map_gfn() are used by the hypervisor to map the guest memory and
and access it later.

When SEV-SNP is enabled in the guest VM, the guest memory pages can
either be a private or shared. A write from the hypervisor goes through
the RMP checks. If hardware sees that hypervisor is attempting to write
to a guest private page, then it triggers an RMP violation (i.e, #PF with
RMP bit set).

Enhance the KVM guest write helpers to invoke an architecture specific
hooks (kvm_arch_write_gfn_{begin,end}) to track the write access from the
hypervisor.

When SEV-SNP is enabled, the guest uses the PAGE_STATE vmgexit to ask the
hypervisor to change the page state from shared to private or vice versa.
While changing the page state to private, use the
kvm_host_write_track_is_active() to check whether the page is being
tracked for the host write access (i.e either mapped or kvm_write_guest
is in progress). If its tracked, then do not change the page state.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  6 +++
 arch/x86/kvm/svm/sev.c          | 51 +++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |  2 +
 arch/x86/kvm/svm/svm.h          |  1 +
 arch/x86/kvm/x86.c              | 78 +++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h        |  3 ++
 virt/kvm/kvm_main.c             | 21 +++++++--
 7 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 59185b6bc82a..678992e9966a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -865,10 +865,13 @@ struct kvm_lpage_info {
 	int disallow_lpage;
 };
 
+bool kvm_host_write_track_is_active(struct kvm *kvm, gfn_t gfn);
+
 struct kvm_arch_memory_slot {
 	struct kvm_rmap_head *rmap[KVM_NR_PAGE_SIZES];
 	struct kvm_lpage_info *lpage_info[KVM_NR_PAGE_SIZES - 1];
 	unsigned short *gfn_track[KVM_PAGE_TRACK_MAX];
+	unsigned short *host_write_track[KVM_PAGE_TRACK_MAX];
 };
 
 /*
@@ -1393,6 +1396,9 @@ struct kvm_x86_ops {
 	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 	int (*get_tdp_max_page_level)(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
+
+	void (*write_page_begin)(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
+	void (*write_page_end)(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0155d9b3127d..839cf321c6dd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2884,6 +2884,19 @@ static int snp_make_page_shared(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
 	return rmpupdate(pfn_to_page(pfn), &val);
 }
 
+static inline bool kvm_host_write_track_gpa_range_is_active(struct kvm *kvm,
+							    gpa_t start, gpa_t end)
+{
+	while (start < end) {
+		if (kvm_host_write_track_is_active(kvm, gpa_to_gfn(start)))
+			return 1;
+
+		start += PAGE_SIZE;
+	}
+
+	return false;
+}
+
 static int snp_make_page_private(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn, int level)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;
@@ -2895,6 +2908,14 @@ static int snp_make_page_private(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn
 	if (!e)
 		return -EINVAL;
 
+	/*
+	 * If the GPA is tracked for the write access then do not change the
+	 * page state from shared to private.
+	 */
+	if (kvm_host_write_track_gpa_range_is_active(vcpu->kvm,
+		gpa, gpa + page_level_size(level)))
+		return -EBUSY;
+
 	/* Log if the entry is validated */
 	if (rmpentry_validated(e))
 		pr_warn_ratelimited("Asked to make a pre-validated gpa %llx private\n", gpa);
@@ -3468,3 +3489,33 @@ int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level)
 
 	return min_t(uint32_t, level, max_level);
 }
+
+void sev_snp_write_page_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	struct rmpentry *e;
+	int level, rc;
+	kvm_pfn_t pfn;
+
+	if (!sev_snp_guest(kvm))
+		return;
+
+	pfn = gfn_to_pfn(kvm, gfn);
+	if (is_error_noslot_pfn(pfn))
+		return;
+
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
+	if (unlikely(!e))
+		return;
+
+	/*
+	 * A hypervisor should never write to the guest private page. A write to the
+	 * guest private will cause an RMP violation. If the guest page is private,
+	 * then make it shared.
+	 */
+	if (rmpentry_assigned(e)) {
+		pr_err("SEV-SNP: write to guest private gfn %llx\n", gfn);
+		rc = snp_make_page_shared(kvm_get_vcpu(kvm, 0),
+				gfn << PAGE_SHIFT, pfn, PG_LEVEL_4K);
+		BUG_ON(rc != 0);
+	}
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2632eae52aa3..4ff6fc86dd18 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4577,6 +4577,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
 	.get_tdp_max_page_level = sev_get_tdp_max_page_level,
+
+	.write_page_begin = sev_snp_write_page_begin,
 };
 
 static struct kvm_x86_init_ops svm_init_ops __initdata = {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index af4cce39b30f..e0276ad8a1ae 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -576,6 +576,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
 int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
+void sev_snp_write_page_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
 
 /* vmenter.S */
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbc4e04e67ad..1398b8021982 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9076,6 +9076,48 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
 }
 
+static void update_gfn_track(struct kvm_memory_slot *slot, gfn_t gfn,
+			     enum kvm_page_track_mode mode, short count)
+{
+	int index, val;
+
+	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
+
+	val = slot->arch.host_write_track[mode][index];
+
+	if (WARN_ON(val + count < 0 || val + count > USHRT_MAX))
+		return;
+
+	slot->arch.host_write_track[mode][index] += count;
+}
+
+bool kvm_host_write_track_is_active(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot;
+	int index;
+
+	slot = gfn_to_memslot(kvm, gfn);
+	if (!slot)
+		return false;
+
+	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
+	return !!READ_ONCE(slot->arch.host_write_track[KVM_PAGE_TRACK_WRITE][index]);
+}
+EXPORT_SYMBOL_GPL(kvm_host_write_track_is_active);
+
+void kvm_arch_write_gfn_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	update_gfn_track(slot, gfn, KVM_PAGE_TRACK_WRITE, 1);
+
+	if (kvm_x86_ops.write_page_begin)
+		kvm_x86_ops.write_page_begin(kvm, slot, gfn);
+}
+
+void kvm_arch_write_gfn_end(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	update_gfn_track(slot, gfn, KVM_PAGE_TRACK_WRITE, -1);
+}
+
 void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 {
 	if (!lapic_in_kernel(vcpu))
@@ -10896,6 +10938,36 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_hv_destroy_vm(kvm);
 }
 
+static void kvm_write_page_track_free_memslot(struct kvm_memory_slot *slot)
+{
+	int i;
+
+	for (i = 0; i < KVM_PAGE_TRACK_MAX; i++) {
+		kvfree(slot->arch.host_write_track[i]);
+		slot->arch.host_write_track[i] = NULL;
+	}
+}
+
+static int kvm_write_page_track_create_memslot(struct kvm_memory_slot *slot,
+					       unsigned long npages)
+{
+	int  i;
+
+	for (i = 0; i < KVM_PAGE_TRACK_MAX; i++) {
+		slot->arch.host_write_track[i] =
+			kvcalloc(npages, sizeof(*slot->arch.host_write_track[i]),
+				 GFP_KERNEL_ACCOUNT);
+		if (!slot->arch.host_write_track[i])
+			goto track_free;
+	}
+
+	return 0;
+
+track_free:
+	kvm_write_page_track_free_memslot(slot);
+	return -ENOMEM;
+}
+
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
 	int i;
@@ -10969,8 +11041,14 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 	if (kvm_page_track_create_memslot(slot, npages))
 		goto out_free;
 
+	if (kvm_write_page_track_create_memslot(slot, npages))
+		goto e_free_page_track;
+
 	return 0;
 
+e_free_page_track:
+	kvm_page_track_free_memslot(slot);
+
 out_free:
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.rmap[i]);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2f34487e21f2..f22e22cd2179 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1550,6 +1550,9 @@ static inline long kvm_arch_vcpu_async_ioctl(struct file *filp,
 void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 					    unsigned long start, unsigned long end);
 
+void kvm_arch_write_gfn_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
+void kvm_arch_write_gfn_end(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
+
 #ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
 #else
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6b4feb92dc79..bc805c15d0de 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -160,6 +160,14 @@ __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 {
 }
 
+__weak void kvm_arch_write_gfn_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
+{
+}
+
+__weak void kvm_arch_write_gfn_end(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
+{
+}
+
 bool kvm_is_zone_device_pfn(kvm_pfn_t pfn)
 {
 	/*
@@ -2309,7 +2317,8 @@ static void kvm_cache_gfn_to_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
 	cache->generation = gen;
 }
 
-static int __kvm_map_gfn(struct kvm_memslots *slots, gfn_t gfn,
+static int __kvm_map_gfn(struct kvm *kvm,
+			 struct kvm_memslots *slots, gfn_t gfn,
 			 struct kvm_host_map *map,
 			 struct gfn_to_pfn_cache *cache,
 			 bool atomic)
@@ -2361,20 +2370,22 @@ static int __kvm_map_gfn(struct kvm_memslots *slots, gfn_t gfn,
 	map->pfn = pfn;
 	map->gfn = gfn;
 
+	kvm_arch_write_gfn_begin(kvm, slot, map->gfn);
+
 	return 0;
 }
 
 int kvm_map_gfn(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		struct gfn_to_pfn_cache *cache, bool atomic)
 {
-	return __kvm_map_gfn(kvm_memslots(vcpu->kvm), gfn, map,
+	return __kvm_map_gfn(vcpu->kvm, kvm_memslots(vcpu->kvm), gfn, map,
 			cache, atomic);
 }
 EXPORT_SYMBOL_GPL(kvm_map_gfn);
 
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 {
-	return __kvm_map_gfn(kvm_vcpu_memslots(vcpu), gfn, map,
+	return __kvm_map_gfn(vcpu->kvm, kvm_vcpu_memslots(vcpu), gfn, map,
 		NULL, false);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_map);
@@ -2412,6 +2423,8 @@ static void __kvm_unmap_gfn(struct kvm *kvm,
 	else
 		kvm_release_pfn(map->pfn, dirty, NULL);
 
+	kvm_arch_write_gfn_end(kvm, memslot, map->gfn);
+
 	map->hva = NULL;
 	map->page = NULL;
 }
@@ -2612,7 +2625,9 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
+	kvm_arch_write_gfn_begin(kvm, memslot, gfn);
 	r = __copy_to_user((void __user *)addr + offset, data, len);
+	kvm_arch_write_gfn_end(kvm, memslot, gfn);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(kvm, memslot, gfn);
-- 
2.17.1

