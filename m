Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8BD4B8D3C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Feb 2022 17:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiBPQGN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Feb 2022 11:06:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiBPQGM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Feb 2022 11:06:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E12A97D2;
        Wed, 16 Feb 2022 08:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEbHH0ZHb3ezgC4ywFuBNnuSLu53MMOkIExE7wLRyp0CeuhUzsvaqq4nexBULssa+bFz+b6ar1z7AIB2+OF0aBKGt57W/L7sRi5RhTOsiIg6QrbpXEZG3Mc1/exXH5ePFP3Zsh0HLpFCdoNMgizorAGbSMHWei5VH+BmWjHF1UPYP75TQGb140oSmS2favxzEwlC6JW8zjnjnrj1HGM+U3gbDBO3K5MQjdm6D8PZb6FeUj10Ufl67CjCy26HRXQXgaRjFdNX7sUnLgXlrOUcqTqxFt23YORp+X3jNlgUG/7Wzza5gOz1uiLrVvyxeaKra01zgTLmXyxIAaNFpkjjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wtGCjNdm53g9e6ZPbTsFsIZUK3WUdRmo4IrtFwaFYE=;
 b=ahX92M19s55j/nGZXs+HnHOeFThObF2EPCIJSz5HztMY1gC6nCAhF+FK6KWI/bca9B6HH6lRDTOSiRS9S8slohd2EtaL1yyfEUvzJQl1UlVWVb3O8pyEcuCZAmlzTY+o0mnJr2L0o/7eb/KAjYWQuQxLNUhFmQDcbAoX52XrU6VRsUir9iVuHR2SLOoZP+XHfws2EGMAN7yVjiBp6yI0yt2X88wtw3VA4Fnl9emFsF6zmOYI2/s/2TMZDIG5OeiexyDT+Pm4g3r6P1m4/lzbhxjTqGG1jDkL6ryp8FEemv2upG4/XidXXga7eNfqsYjLMq0x6XK9hBPu6U7oSrhnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wtGCjNdm53g9e6ZPbTsFsIZUK3WUdRmo4IrtFwaFYE=;
 b=tOJz938KMSKt9UZsKJPmN1Kyy1ZlK8+2rFlBT8lfrrl5upN70PMN0Rx7FX1koWkBIa2QVIEytaaReHKsRP4tVIqAAvcB+N51IeDvBqa6lcEVFOFH8On2MyGeQHjrbhcExiW3COjfTyONDAUBbLzBrPQtSPceCafUXkUY435tvSM=
Received: from MW4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:303:b6::33)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 16:05:56 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::78) by MW4PR03CA0088.outlook.office365.com
 (2603:10b6:303:b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Wed, 16 Feb 2022 16:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 16:05:54 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 10:05:51 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when changing C-bit
Date:   Wed, 16 Feb 2022 10:04:57 -0600
Message-ID: <20220216160457.1748381-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Ygz88uacbwuTTNat@zn.tnic.mbx>
References: <Ygz88uacbwuTTNat@zn.tnic.mbx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7c46b2-31fb-40a3-9a5d-08d9f1663664
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB516731438D99C556E609DAC1E5359@DM4PR12MB5167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWzvDdeJA8Tlvpi1b/5D2jLawbWsrOCDpXYPf9hXwEcdXzn3zGclaTlrkpUcl6ExDswLZpfrpUFB2pOcCVHoOqhz0ioeLlTeTCw9DX1LZ3t5LgDz5+zjVBtPzdXzepsA1mfd/H3XOhQC3nfjyzNuyl+md0jkKmFzLFib/N+MGSApLd3s0tQV+LKGpjPj2hCnUyH+gO0IGvzsDkE0ShftH0Twh0EfI8tBOOv4lHTBn0W7dUt84seYGctQwvpwSJHE4+e+j8EjNx6lF4bPDwcH8wQXav13YGZ+KPbOmsSePHppyRSEuWpWxXWEozrqD8ufRJEbYZsvPQw8rNV76uvqldLRj1fzbAVvmZiIvHZlIRit+yrL6SiuTDMbSZeYi0/l6H4zfK9Lo4pVarjGPNZmq9h77MNB5/wo2A7dXC0tA2Hks187R4v7aO12t4tzlBaxOh7kWOZPrp7ZXK2N1pswgWjQxaENdno9voYkXkWz+KM8dNv9lrhbAN1LkIVLe8EryhkX3EENE/6RSHuVo9jomu4K9vvIckKBOaqvENgwZIBewOwQMCm/octkLuNZIHIUeJfp0Lavs6dXBa/4Anzzb5UKt7lCn53vN600aUVgqGqSg5dJE9Iw0XKMzd3QmxC2MbnUt7Mat+T0NwokFS+wqR8km7mYGXivHiU7hUBtFLRtJtWyKWkVrzlanVv3D8JLpFwNvxou3b+wwQEvTVBfug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(4326008)(70586007)(70206006)(316002)(54906003)(110136005)(508600001)(81166007)(356005)(36756003)(86362001)(36860700001)(426003)(26005)(16526019)(186003)(1076003)(47076005)(2616005)(7696005)(5660300002)(7406005)(7416002)(40460700003)(83380400001)(82310400004)(2906002)(8936002)(44832011)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 16:05:54.9125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7c46b2-31fb-40a3-9a5d-08d9f1663664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 11, 2022 at 03:55:23PM +0100, Borislav Petkov wrote:
>> Also, I think adding required functions to x86_platform.guest. is a very
>> nice way to solve the ugly if (guest_type) querying all over the place.

> So I guess something like below. It builds here...

I made a small change to use prepare() and finish(). The idea is that prepare()
will be called before the encryption mask is changed in the page table, and
finish() will be called after the change.

I have not tried integrating the SNP PSC yet, but want to check if approach
will work for Krill.

---
 arch/x86/include/asm/set_memory.h |  1 -
 arch/x86/include/asm/sev.h        |  3 +++
 arch/x86/include/asm/x86_init.h   | 15 +++++++++++++++
 arch/x86/kernel/sev.c             |  3 +++
 arch/x86/mm/mem_encrypt_amd.c     | 14 ++++++++++----
 arch/x86/mm/pat/set_memory.c      | 13 +++++++------
 6 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a..ce8dd215f5b3 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -84,7 +84,6 @@ int set_pages_rw(struct page *page, int numpages);
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ec060c433589..2ebd8c225257 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -87,6 +87,9 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc);
+void amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc);
+
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 22b7412c08f6..da7fc1c0b917 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -141,6 +141,20 @@ struct x86_init_acpi {
 	void (*reduced_hw_early_init)(void);
 };
 
+/**
+ * struct x86_guest - Functions used by misc guest incarnations like SEV, TDX, etc.
+ *
+ * @enc_status_change_prepare	Notify HV before the encryption status of a range
+ * 				is changed.
+ *
+ * @enc_status_change_finish	Notify HV after the encryption status of a range
+ * 				is changed.
+ */
+struct x86_guest {
+	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	void (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
+};
+
 /**
  * struct x86_init_ops - functions for platform specific setup
  *
@@ -287,6 +301,7 @@ struct x86_platform_ops {
 	struct x86_legacy_features legacy;
 	void (*set_legacy_features)(void);
 	struct x86_hyper_runtime hyper;
+	struct x86_guest guest;
 };
 
 struct x86_apic_ops {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e6d316a01fdd..3b2133fd6682 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -760,6 +760,9 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
+	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
+	x86_platform.guest.enc_status_change_finish = amd_enc_status_change_finish;
+
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return;
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018ea345..c93b6c2fc6a3 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -256,7 +256,11 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
+void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+{
+}
+
+void amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
 {
 #ifdef CONFIG_PARAVIRT
 	unsigned long sz = npages << PAGE_SHIFT;
@@ -280,7 +284,7 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 		psize = page_level_size(level);
 		pmask = page_level_mask(level);
 
-		notify_page_enc_status_changed(pfn, psize >> PAGE_SHIFT, enc);
+		amd_enc_status_change_finish(pfn, psize >> PAGE_SHIFT, enc);
 
 		vaddr = (vaddr & pmask) + psize;
 	}
@@ -341,6 +345,8 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 	vaddr_next = vaddr;
 	vaddr_end = vaddr + size;
 
+	amd_enc_status_change_prepare(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
 		kpte = lookup_address(vaddr, &level);
 		if (!kpte || pte_none(*kpte)) {
@@ -392,7 +398,7 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
-	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	amd_enc_status_change_finish(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -410,7 +416,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 
 void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 {
-	notify_range_enc_status_changed(vaddr, npages, enc);
+	amd_enc_status_change_finish(vaddr, npages, enc);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..a55477a6e578 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2012,8 +2012,15 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
+	/* Notify HV that we are about to set/clr encryption attribute. */
+	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
+	/* Notify HV that we have succesfully set/clr encryption attribute. */
+	if (!ret)
+		x86_platform.guest.enc_status_change_finish(addr, numpages, enc);
+
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
 	 * in case any speculative TLB caching occurred (but no need to flush
@@ -2023,12 +2030,6 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
-	/*
-	 * Notify hypervisor that a given memory range is mapped encrypted
-	 * or decrypted.
-	 */
-	notify_range_enc_status_changed(addr, numpages, enc);
-
 	return ret;
 }
 
-- 
2.25.1

