Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B13BEF4C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhGGSlh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:37 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:37344
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232467AbhGGSlL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNgObeCizbIUZcB2OXAY+IW1m0HRf8Rt57Gv+TxTSXZf3RnSLpAaHycW2Pdxw+B2Nj7HkcpfoHUyzW1PRE+yvs/QVq1ERDiEQkwVmVIhYTKZHfCHbtYopc/ew1hw3IpWfFknzJmLfJ9Aw8fBuwWE0DPw2mNmXSfTOMDh3LPCYV0lWXMd+fKE+EYXz76mXQMiZnY642e9AioUHkvP3QbBxMkIewaAGStEwlar+ldPN7Dg/ma6QuS9rsgN5T8QoR4EG9H77f+HWraxYVcx0Vav0FD3s/v6VXXbmkCk52dzJrEJ02MVwFa5beW/Kq43hU41HhETVP/gbzn6zeh468ojdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb6Km5viwoXyRU0rKJB8pC+lAqS2CVG30a+Z6f4SAPM=;
 b=ZIFJEEh30KWo+MKbLZavsjrL5t1NXf+e0qaqYSBLWUEDyfkD1yo4jexVQBWI9LCc7wajlb6IaqCH+EEyBYj2FrDfDYCwEQs4Ewp/4BG+r9puUaG5xImLQOXFJuRVOnwGtTjtq85s8sYiavWrs62o8rm4RIWlA3g5gabwwWfDBbzizuTmJCSCdZ80fViI3kZwNSDr9Fj3i0w1lRXdbOKWZxwPNLDi0KehpkQ+TI4J4CIGgGpw9egD8CpZXgIeVL69tq5NLfbGHNbe/d+g8grZBR69Php5x2JXzwHTfU3fq/DSXigVvopizi7ZFFwg0BH6YkE65rbZiJJfosUkEK3zIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb6Km5viwoXyRU0rKJB8pC+lAqS2CVG30a+Z6f4SAPM=;
 b=YVva+FclOTdh2Vmri3x6VTo5jkFUXNc8Hg9WyOTERhHZFK+87R0KJZrHNc1UShNhP07tpE8Sqg56vsnF2CenlktCnSH+GqIG1UTQIkHAo/6clgnC9ZrShiloFXracp4J+oQckYOrQ+sDa7E4DgALSJMHxYsVdX+SIsWL21j8xlg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:04 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:04 +0000
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
Subject: [PATCH Part2 RFC v4 27/40] KVM: X86: Add kvm_x86_ops to get the max page level for the TDP
Date:   Wed,  7 Jul 2021 13:36:03 -0500
Message-Id: <20210707183616.5620-28-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0564c62-a31f-44c9-7cac-08d941765b65
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082B48F96FA174688F3BB9DE51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AtUwv30Gj9vrQG4Q/OGHOQkYNhjoqv+b/xEU2LULzuGNylHGx5QHk8sFgt7PjmvIkQewfjquAUO8tZHooCc6C/T0lkAM/z7MsOZ4BZXLl/lZ/M61qJo0AmD+X21Nlv5EA+P1oXCZ6xDSRBxGPheDVb3LnV83nD8Tv0umwK0tEVeM1MIn/7SgNbUyGSZlno1EpCabp5QKH+kPaiN5WoHpLZzv4FA06G8bW8gk7kLd7ccIAbVliX81goa3o6Vyo1nAW92wHkzF5oQadkrrZn9ovSvcgA3gSZE4u90ZUn5uIoX9ImyqVzELYTyU24e4wDSZJztUFw6Qvz701QlNux1KB9KvALXd/rHqwMgMmfcbeqtkXqkBVk7gZ1so9m3CnVOxSTqUVxKF7RalhBp/eTp9/PFs0bLbcuc0DjggJDX9F/m29dD/NYnji645tWaX88mhgvjKIAoI3jJIaDVbMmWHvtMgw8T/h2gkHKSYrKPsF4O3UMpJW4uaOnnlDGA+ssYLtTguxErBjE/bUU75jbbPfSsuraol1DXxZQidlW4LsRtv78U6pyAHD9dFKyRdN/7OlDWmhAkFnVSRhTghesPk7WQqwK67RPtoEoGqiEJVPRJa3XgDU2kQBYiCy4XYGTmU/DYDQgfmHvniVqhzdpuYxTSDcRVEzE0jv6gqmE1ek+7p7l4qhSgtTOoZUqfqDNHlk2W6O2/o3jqpi+ZtuczsPPGSkC/wo6X4i9fCVFYArs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jLdRBC6zcega0Qx0gjjb5FDXWezMxYPLAUi4dQ/ToB+LdTpeKpd/QIVx9xLT?=
 =?us-ascii?Q?/ix3PRpWlPi0qGa+dv62BPISkxEQlVTjGOtjLjPItgJPqTHzZNS62Qc588gt?=
 =?us-ascii?Q?k+bMLyELlVYINDg4w8gCAlxbY9WLwI//6g0RO+Q80ym+f1/vI02M3CTYNVqj?=
 =?us-ascii?Q?QMkRXTgZoqxWcnxw0ezOZ07z9QrzJAeRv7f/Jb6oVcR6qshNeSVId+WCBQVy?=
 =?us-ascii?Q?4qRMya3CXTJOu8DSRMx9uYQfxc3NCr89arDVX3V6pmsReBwuMLc3Vex5bbvj?=
 =?us-ascii?Q?M3M4/l/9Vjy0epvMJpF7E4eL452AfTeLLCFD0DjKd9mhq/NADepEMlkDN5ya?=
 =?us-ascii?Q?ynLy0dwaO8LgZRPcrTEhtFdYqF34qtIqLnMID7aLzPvEdcXzu2yn68qJGeg3?=
 =?us-ascii?Q?Nosjc2HaRM5BcsFA+F02S+x+lz0rJDj8egOvCFTWzZmJL6QIVWUQtZmfqb1z?=
 =?us-ascii?Q?cROA/QMYUzeEvcJg8VZ2vHYRbZQNHdqe3o1HUvLUnuHCaZq4NwHiiTQ+01OP?=
 =?us-ascii?Q?PPovvFzad5HLovHWsTPRFr0LbB+daadvOW7WZL3CKfBriuyPBFumQ4tN6c0a?=
 =?us-ascii?Q?7wrCwlaUQQ6SVkotkDtUfIllKCx+nX3IyW9ac35AFf974P35b1xKkLZhMLZ1?=
 =?us-ascii?Q?97cS595d0P2MlQ4waMy/JUoyCIW/gY4O0++6iWl+m2yln2ifXK9JWgNwPfCb?=
 =?us-ascii?Q?HTg1r6/uJtI+9UKQ/i86MtNGY6MvG+sfiFj+58IwavgXYKh8zPrf9Vb3CAQP?=
 =?us-ascii?Q?53jo+yaPYczK/x0efBtK5OdX2of41nkEH1NDgLNZAmRiioQlsIhJpGNSiXrU?=
 =?us-ascii?Q?2+W/xKk3h5uCmSEouDT4qgVEe9HA2drr/7QB4ynyni4BxluhOpQZmYPuQWPM?=
 =?us-ascii?Q?tu0H41QHCOGad0Eg3m0jgbywjo6k2rJMxV7PJBv8Od1grcwDRZSYI0WEwS7f?=
 =?us-ascii?Q?EdhLx5l32fPmRmaioP9RYweT2puzqGIneLqR6RmwzAQyub9SUIfXJqYxOuL1?=
 =?us-ascii?Q?f7Rwl7bqYO2orAY9k8gFK2uMnP5c9PmkFn3nvQQ0yHSnDalQo2QGXwOeim5H?=
 =?us-ascii?Q?1hAFePJObzCxd+wNqy9hU3mFMJnZjztof9XNKCwBjoEVLbEfR9k7MKnxn9Xe?=
 =?us-ascii?Q?2AblUNmB8Paa5zgXlPQp/vL4FpOr/WlScNu0GJ5rvoZbbTcLqFY9WMfTc92s?=
 =?us-ascii?Q?WET/EK9a+hDotBPf2G+zYx2wJRYrRsChKIAA6jjyPfb1g+PTKMe6qhb9xuwC?=
 =?us-ascii?Q?AUYYbR1RE2SgsJnwOnBABQ+vEFZYqacsD0AXRN8i1k2KbYRhrVjZ9RfzS5/y?=
 =?us-ascii?Q?pisZFI0pBE54D7iO/7cH7/Ka?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0564c62-a31f-44c9-7cac-08d941765b65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:04.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/QmPPQvEbP5c/OQdru6bT0/+TpwBxNUs3A9lYFoaXVNfizXZc4Zknfwf27KPDRv/+JbYxq4/FR1Jyi7TJC9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When running an SEV-SNP VM, the sPA used to index the RMP entry is
obtained through the TDP translation (gva->gpa->spa). The TDP page
level is checked against the page level programmed in the RMP entry.
If the page level does not match, then it will cause a nested page
fault with the RMP bit set to indicate the RMP violation.

To keep the TDP and RMP page level's in sync, the KVM fault handle
kvm_handle_page_fault() will call get_tdp_max_page_level() to get
the maximum allowed page level so that it can limit the TDP level.

In the case of SEV-SNP guest, the get_tdp_max_page_level() will consult
the RMP table to compute the maximum allowed page level for a given
GPA.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          |  6 ++++--
 arch/x86/kvm/svm/sev.c          | 20 ++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/svm/svm.h          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  8 ++++++++
 6 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 188110ab2c02..cd2e19e1d323 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1384,6 +1384,7 @@ struct kvm_x86_ops {
 
 	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
+	int (*get_tdp_max_page_level)(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0144c40d09c7..7991ffae7b31 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3781,11 +3781,13 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa,
 				u32 error_code, bool prefault)
 {
+	int max_level = kvm_x86_ops.get_tdp_max_page_level(vcpu, gpa, PG_LEVEL_2M);
+
 	pgprintk("%s: gva %lx error %x\n", __func__, gpa, error_code);
 
 	/* This path builds a PAE pagetable, we can map 2mb pages at maximum. */
 	return direct_page_fault(vcpu, gpa & PAGE_MASK, error_code, prefault,
-				 PG_LEVEL_2M, false);
+				 max_level, false);
 }
 
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
@@ -3826,7 +3828,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 {
 	int max_level;
 
-	for (max_level = KVM_MAX_HUGEPAGE_LEVEL;
+	for (max_level = kvm_x86_ops.get_tdp_max_page_level(vcpu, gpa, KVM_MAX_HUGEPAGE_LEVEL);
 	     max_level > PG_LEVEL_4K;
 	     max_level--) {
 		int page_num = KVM_PAGES_PER_HPAGE(max_level);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f8824c9a5dc..fd2d00ad80b7 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3206,3 +3206,23 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
 
 	return pfn_to_page(pfn);
 }
+
+int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level)
+{
+	struct rmpentry *e;
+	kvm_pfn_t pfn;
+	int level;
+
+	if (!sev_snp_guest(vcpu->kvm))
+		return max_level;
+
+	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
+	if (is_error_noslot_pfn(pfn))
+		return max_level;
+
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
+	if (unlikely(!e))
+		return max_level;
+
+	return min_t(uint32_t, level, max_level);
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a7adf6ca1713..2632eae52aa3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4576,6 +4576,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
 
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
+	.get_tdp_max_page_level = sev_get_tdp_max_page_level,
 };
 
 static struct kvm_x86_init_ops svm_init_ops __initdata = {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index bc5582b44356..32abcbd774d0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -568,6 +568,7 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
+int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
 
 /* vmenter.S */
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4bceb5ca3a89..fbc9034edf16 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7612,6 +7612,12 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
 	return supported & BIT(bit);
 }
 
+
+static int vmx_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level)
+{
+	return max_level;
+}
+
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.hardware_unsetup = hardware_unsetup,
 
@@ -7742,6 +7748,8 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.complete_emulated_msr = kvm_complete_insn_gp,
 
 	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
+
+	.get_tdp_max_page_level = vmx_get_tdp_max_page_level,
 };
 
 static __init void vmx_setup_user_return_msrs(void)
-- 
2.17.1

