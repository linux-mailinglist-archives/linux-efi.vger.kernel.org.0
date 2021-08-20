Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C600B3F2F02
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhHTPWj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:39 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:58049
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241181AbhHTPVr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ4z2TYLuBgLSwMMdCEcLUXcjup0wMjOc9I+OeCYmvOymS2wgKD85dHqfbEwiU+cHCr6NgeNTZYazu/lFTWw7r/3sYRObmS3pxCtMqVmKPMTw0gHsvsZ6+ME2G7f3HnkyfaY1F/wdMApuPjeF5Nwxs7r9xv1AOs6qcJVRk6fjJ4fvU+Olq375A1WuyZwyzpMZgGvKNm1La9Zo61YvyOWkmAJAAxESPvnNp6BVDgKPZ/9Jb4dSBfcVygGcaTESTxIJbe2dj6u3ALj7hHbfhgfPH5Dld18W+ARLIM5fbGzDxzH9TwyCCulvgSBKBxL11QdULSt02JbFDuO8UWrt7ybCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ddQWHaNiYgV43Q257s4xEf1zk0XVHq4COBE+Hcvlfo=;
 b=KLGOwskrAMVFbLtObXAR4vK3xjSe7YU3sRUbmSuCmMXG0fmkUTud7g24Rw7wl3PieZebYq5DMtxu0hVtqHJa6iDtL01PtOj3UkXOQh21DODifOwWzubTHA85/lzsT8DuyCp1TfRm4L1++1wDznvNBTISNzv55Da0iMIryC0xZSHRCJPB4QRfEWvIUTkZW9SGSG8gZUoBpC3Mi2v49dg73TQ/x5iqh9g3xyginmoCpIxP8NaPF/AkD1hAxnFj7TI3y4lnm2QLWKCdBkr+tKZdihc6hLdEWM7CjcPcUKVB8xaG14vGuDy/yLQD38PcmwRjU9Kx9u4js9bQcJ2DVmXO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ddQWHaNiYgV43Q257s4xEf1zk0XVHq4COBE+Hcvlfo=;
 b=a0WkRk8CqeFyi738sDAWp/PCkW/QAwfFPLSV5BtpP6FedTNJVXZJN5WH8I/80JJF4mBXzoEHF/vGdJ74yt5yZ86d+VWIzkqXLGBfu/gTNzQg4Ac4i2ndtkYiOU/bGfD3r7amjASqinnaax7VMLmS4T9owGm/QyNu0DV/zqxLrJg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:01 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:01 +0000
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
Subject: [PATCH Part1 v5 11/38] x86/compressed: Add helper for validating pages in the decompression stage
Date:   Fri, 20 Aug 2021 10:19:06 -0500
Message-Id: <20210820151933.22401-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d4e756-1ec1-4390-f144-08d963ee1e7b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446B523A2FB852EE2A000F0E5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DS4kscSkh+I4MtH8B4DF8FVrYmwbvRqIdQlOwDgWyS5hHWactWvwofwd0HlvRk2XYEYHNOukWPHYI9aSBPA3UExHzemLBZlMxuiZiqiFEwUL1NV/Oi8ltCZ7ONyLGLv4JxV8QyAq7dy+SswkBjEjGmpLvHkDL4BYq8SaaWf4HpkmD2ipJwkaminKLyyfENsS9h/JJwFWV4kSdi3oUK3prS8okJ0AXkiJ2LD0HIwgl/fixUZJ6oX6yzbAFWKxxqbra0BB64xgGd+Eb4R7mwhUMaxrdBcHwzB2PSd1vuI5aImI4tIhJPACxK7DUPxwGWg10qh8OGHVlxQ2EA1SmSPxs9byXhGncmKsXWrfZ5XiG29LnZgvdL5M09yhCUjuCRp+tPUR79atqY8+UrH/Es8DnHD+zcm4DksRf21iS2Pn5TxU6EAEiad3huA0vYFaZlKmX2fsHtrtkMpQ7MPBOBto4PAAgwYgQyEl493m4yxlUwyaJ+ZLBy0nKMvE8HneqBiXsT/UNzgQc7g1v0ec/uH5N4YhOHd9IoBkq6qFgxoc6heM4rNHBlfQRRxu5H6xmw58gnC7/cvBEyZ5SprwTkyW6QdZVH5CFxn11gTCvQz3urDiWdYx2SK7SqA1UVJ9mknn5cdhU0CunBCZhnIfNKk8GTcabohWGBJqU6uhvKLaPw4/VMjx9RMtIr7x/y1zzvY/vFv1z2nRbHZFLr9JKG0DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/AqrxWvwu4GA2Xe370DjQtVMv5UBvDeIUOx1OmYUsKlyNReYA3Jj72gjSjR?=
 =?us-ascii?Q?WlFHb9N8YyOrb4FWUrfSuJE+2m4h2qAOkG60ZUHvdc6TApBtXIlow/kaGF6c?=
 =?us-ascii?Q?jyk6a+ZRcqb0i7AhcI5qFuK0sNHkiFGYajiFa8dk7O+RYlrH56J+YO9rUzf4?=
 =?us-ascii?Q?OMG5uzgjeRuPuBK1hHWV72XBb2J2ufzl0bZmMv/pplH62pf5X+G4DjBRh4S1?=
 =?us-ascii?Q?5WvOTzwO1ewQ1rSc1mlc7bAixhUzrmZirnFgrvxcq5NAt8YWZO8Lt6NafQbJ?=
 =?us-ascii?Q?9LKxsqvimRg12aTRQzRm3wgpdxg9j8ZisKUubuX74//SR7i7EGk815J9hHGB?=
 =?us-ascii?Q?W+ALgTCOXZlGAlEdzIBlgxDso05vCQfK0o/CsReH7uMsfCpYViFGPlHGUDeD?=
 =?us-ascii?Q?gjtX4z4sQRSe4TLpXI2gzv1oxC5HBj2GQ96BWZNUnaf9UkMWxqWFdNG1+DKl?=
 =?us-ascii?Q?r5ogYC8BXXiYtSKw+JpQh3My0ao/FqS8szOLfXfCljNpyPqUIzSwWT/yEvB9?=
 =?us-ascii?Q?e4qffSYkjAqLj+R/KSwJVcBSTTfhdX6jZfyDNxZBgzd0l6TzTWd+dvgiw6Pt?=
 =?us-ascii?Q?AejIWa5uFBHHyqBwVYRB+0D30ebBVYVuT41kNrs9xdUaGkAhF+IrGQV3MVGN?=
 =?us-ascii?Q?+Tr3p4Yi08a/Jn7PNX2Bsd5aMSGzh7a4iErw8klmjFJTB7xrfFZvHpJnUvVQ?=
 =?us-ascii?Q?ovlumD0BJotA9imz4OxdIdBs5ziG40AvyXt89Wms7RYOK0WFeigMTliB7s3h?=
 =?us-ascii?Q?ygEjmoEP/8PyI91RnQqTtXxz51qwTvwV0gcpnnX+mk5X8Mc4Kaumg+bWJvWa?=
 =?us-ascii?Q?q2uJB2qM2YubAnNm5YUY6W+oaOOnL213nun5lIZTqWaSUOIh4WPQsYeyTr4p?=
 =?us-ascii?Q?4b+0yZ9pnNKJgl64xUMH8L2S3AfRA3XALXtGEykIdEItlfY/7Thoauars9Jp?=
 =?us-ascii?Q?+YqM5yFVuMArty8dZ3MWcRZOG0b6XoF1JMN0xPZuIxLVU2z15e6z1ApCEdZO?=
 =?us-ascii?Q?+JxE/zmb2u3heHvbUCyk+mgfQ4nFzDJaAQxDG8zOVgg+RetXroQ5TTLqgo2R?=
 =?us-ascii?Q?jgpbXjxj70cyeZADClWuugRjTq1trwrDR4YIuraYkwqFvh+2vVhNlPfJRguB?=
 =?us-ascii?Q?68bNrUobdkmqZNn1aLLUfaz75fAH6QhlR7yPZOPsoT4jw/2TUo2/53BAo0qB?=
 =?us-ascii?Q?Xdi42Dpw5ShWd84KMAwesn9zYSPIWzAMcX8wNDoUAHvCvJtnpvD/HnlDBd3H?=
 =?us-ascii?Q?B2E7yUFGQF70kSJtvi+yefUF+RZ3OUoqNhCWTTQXMTcsYpFZrelpTTOuk8fb?=
 =?us-ascii?Q?6fRU7cxLlGDRjWeIEFTSROG2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d4e756-1ec1-4390-f144-08d963ee1e7b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:01.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTaZJLzp78K7w9PjXLmMbsWNyxeZ6NRuqWvT1qk5LtDwHXJKDqm2vYYmgeUiAYWiufF9tyrIb5o3BuHqpt8lvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Many of the integrity guarantees of SEV-SNP are enforced through the
Reverse Map Table (RMP). Each RMP entry contains the GPA at which a
particular page of DRAM should be mapped. The VMs can request the
hypervisor to add pages in the RMP table via the Page State Change VMGEXIT
defined in the GHCB specification. Inside each RMP entry is a Validated
flag; this flag is automatically cleared to 0 by the CPU hardware when a
new RMP entry is created for a guest. Each VM page can be either
validated or invalidated, as indicated by the Validated flag in the RMP
entry. Memory access to a private page that is not validated generates
a #VC. A VM must use PVALIDATE instruction to validate the private page
before using it.

To maintain the security guarantee of SEV-SNP guests, when transitioning
pages from private to shared, the guest must invalidate the pages before
asking the hypervisor to change the page state to shared in the RMP table.

After the pages are mapped private in the page table, the guest must issue
a page state change VMGEXIT to make the pages private in the RMP table and
validate it.

On boot, BIOS should have validated the entire system memory. During
the kernel decompression stage, the VC handler uses the
set_memory_decrypted() to make the GHCB page shared (i.e clear encryption
attribute). And while exiting from the decompression, it calls the
set_page_encrypted() to make the page private.

Add sev_snp_set_page_{private,shared}() helper that is used by the
set_memory_{decrypt,encrypt}() to change the page state in the RMP table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 18 ++++++++++-
 arch/x86/boot/compressed/misc.h         |  6 ++++
 arch/x86/boot/compressed/sev.c          | 41 +++++++++++++++++++++++++
 arch/x86/include/asm/sev-common.h       | 20 ++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..3cf7a7575f5c 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -275,15 +275,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	 * Changing encryption attributes of a page requires to flush it from
 	 * the caches.
 	 */
-	if ((set | clr) & _PAGE_ENC)
+	if ((set | clr) & _PAGE_ENC) {
 		clflush_page(address);
 
+		/*
+		 * If the encryption attribute is being cleared, then change
+		 * the page state to shared in the RMP table.
+		 */
+		if (clr)
+			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);
+	}
+
 	/* Update PTE */
 	pte = *ptep;
 	pte = pte_set_flags(pte, set);
 	pte = pte_clear_flags(pte, clr);
 	set_pte(ptep, pte);
 
+	/*
+	 * If the encryption attribute is being set, then change the page state to
+	 * private in the RMP entry. The page state must be done after the PTE
+	 * is updated.
+	 */
+	if (set & _PAGE_ENC)
+		snp_set_page_private(pte_pfn(*ptep) << PAGE_SHIFT);
+
 	/* Flush TLB after changing encryption attribute */
 	write_cr3(top_level_pgt);
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 31139256859f..822e0c254b9a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -121,12 +121,18 @@ void set_sev_encryption_mask(void);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
+void snp_set_page_private(unsigned long paddr);
+void snp_set_page_shared(unsigned long paddr);
+
 #else
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
 	return false;
 }
+static inline void snp_set_page_private(unsigned long paddr) { }
+static inline void snp_set_page_shared(unsigned long paddr) { }
+
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ec765527546f..5c4ba211bcef 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,6 +164,47 @@ static bool is_vmpl0(void)
 	return true;
 }
 
+static void __page_state_change(unsigned long paddr, enum psc_op op)
+{
+	u64 val;
+
+	if (!sev_snp_enabled())
+		return;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val = sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	/*
+	 * Now that page is added in the RMP table, validate it so that it is
+	 * consistent with the RMP entry.
+	 */
+	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+void snp_set_page_private(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+}
+
+void snp_set_page_shared(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+}
+
 static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index d426c30ae7b4..1cd8ce838af8 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,26 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/* SNP Page State Change */
+enum psc_op {
+	SNP_PAGE_STATE_PRIVATE = 1,
+	SNP_PAGE_STATE_SHARED,
+};
+
+#define GHCB_MSR_PSC_REQ		0x014
+#define GHCB_MSR_PSC_REQ_GFN(gfn, op)			\
+	/* GHCBData[55:52] */				\
+	(((u64)((op) & 0xf) << 52) |			\
+	/* GHCBData[51:12] */				\
+	((u64)((gfn) & GENMASK_ULL(39, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_PSC_REQ)
+
+#define GHCB_MSR_PSC_RESP		0x015
+#define GHCB_MSR_PSC_RESP_VAL(val)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
+
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
-- 
2.17.1

