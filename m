Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCD398BB4
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhFBOIe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:08:34 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:38497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230331AbhFBOHj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAp0Bu61J/PS2txVpry3kQM3/bTssqU2C48QVcavXOO1GspPxCVL7Et+ry4CbWif3rCpDmMLmdH5U6oree9SoTBw9CRxpufaKwLZoNVNZb1B5BCxyGouQKeYOKaYcn1vo46t10SoM9E7uABU3z4vVXvums+Gw7IqOvv0wUNhLAV2D//f+q7jFBzMewSGdWiCzc0i3lCsXUBOBqbnL/k8OAN3jXVENn2W1p2SUf0/loMJza0KQBzKOHYZw3r2B5IBRqTugA7FdIBAtzzHXeiDwWxUDMiqoTj7o04DTorQDQjiCFX0iCoY1hfNg72+bZ7RYzx1t8k6tenPJ+nkCeJIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t0VtGyoAnhhXWNXyCvl2HZxmjAAoLOM3Dosv5S4/cM=;
 b=h6meVlBDw3WNjzzwM49tvAmbKkve8BM9AftS9L35xsYS+EzncngcNZiyjeOQtxcoSSqOjvbDLSZWMp9sg25EevVmJ2J6FN3MoPFT+25bZWK4gin9ycPt31fHw2Ca5aa0/F3bcA85FljCkaRdB9iNrRw6L9SSu47DVK44uill+wgMJRqd8Swr61EukM30rlGeu+iv+xYRBh3KvY6Ylta/UFJt6yyRDmOQK4exyKB3jmR89uUom9xpa+g9Yl6WhvK54q79rMcRjo8I+9nynUcb4vitKcnqlCTxg6UnM08Ti1CYyCt1ZV1do4lf22L8dchI42J66NqMvgWjWX7ioz0UkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t0VtGyoAnhhXWNXyCvl2HZxmjAAoLOM3Dosv5S4/cM=;
 b=u6b0IctE9EgNTvHT71BzVLI7ePt/DSIyoTjgIMTB3cltLlszqjRGjCLN6wtNBSkkWxWMNSBsmlhmHQaVs3BKaCWxR7wyv56dsTiIc+tlwX7cRUlGMmOpZCDDxSLopaKCMzZ1wDIg3T/XEvwAJPX8bjlSqt2E9C7zqw8fCq2d744=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:51 +0000
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
Subject: [PATCH Part1 RFC v3 08/22] x86/compressed: Add helper for validating pages in the decompression stage
Date:   Wed,  2 Jun 2021 09:04:02 -0500
Message-Id: <20210602140416.23573-9-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee8f10f-f9eb-42f6-0a4b-08d925cf626d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451203CBAC5B3E5FC8C5750AE53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVZJtB8mHDlOZbULrnkGt0Hb8JSr9uhdZt1ObMwDglxpBeDoCn/QDHCZAVqyKaKsZxjFVqth32eEV2tms3eG1jafzKKPDAyhGYxrnouJELkrkqjChkk6ye/FTgttkWCSyAEcF3oMGsI2gW4ET/JBUkx9aMvjFKB60FCy9kU2aZkKi5cWeql97HlQFxmy8TGeSAEtOaiAZsspKtUE6c25mQ8YVPb23PgC2285muzcS3ds/r74YnK1bVn/0NK0hCrEFh1tqWl39xOisE43xqEHbsmLOc40DgNZn/xdkpo2wbraNDWkFHvVi8Uauz48xjj32x7v9inq8Xwm2nHz1mob/YWnQMh4sRPFOsUhlvjms+NIC/LZNo3sL+s9VLdy1XacLdZRziEh6id4EsKfgqqwJ3I0pS7CzcAXHoT4FUuNa0eBkG00bkL3RJUq0oOsDUbtNC/7MJMmv3Dpr5eWhYkvcCUrPrcw/tG3vst8CnFWar9PwOiSlTc3aGhMmivX/Y2Zw9HdOivkFqLTeKshhGRCqRkDW6n9mjRdjPk5IjJ6oNFLOUWwd2AeqJrg5QTjMn9xgy9TRDklrJzJOvRf6fdh373OKZHG99qBYMjuXct47/CeEBCN7q9qzcmU2jPOPrFmVgdCvjVsNyDgkg4Niyi1Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uLMakkphVov1r07YfUnuZs7g7UESZkczmIofTcASYK5LeEdP41BZ+ZIxrGUN?=
 =?us-ascii?Q?phJLnIx0eJgXzb7uPvokIhstfoQxn74c4mzoF9byMLPiJBzpNBeP6RO2zWEV?=
 =?us-ascii?Q?JOzwhq9B2W8wS0O1tW1By/qZ8nSPVUG4qLbM2m14r7HsQaGux+uV+I6e3Qb7?=
 =?us-ascii?Q?S0TJx2ccnpYXIF2LQPIgGDHdCw7DOGpFeuHa3AAamdE7B3oXEtakhgbnGVKO?=
 =?us-ascii?Q?tV55NkGnsRWfhP03aN8nqRoa3D/as6aTT3kTomeEkvMEcem7s32vyArboqN3?=
 =?us-ascii?Q?YfTQImuFeWaehP70IpRwIeFfZEmGqWpRLqn709lO4IUWBaFJ4+th3W8QBlVc?=
 =?us-ascii?Q?NXVFCKvMEcXVNqtTIO6m6tBdjMhguvKjAv2W0cdX/qnCiNNvfmfVTRExrxcH?=
 =?us-ascii?Q?lExRgzDeg+iluCr6wD0U6cJIdn9VbCYcttHtUjvSsNk85Pddq489lC6tSaik?=
 =?us-ascii?Q?PBkXAvi6BuE01vBpElPsfRfz1pbk3a50g9Hs32gFR+/3+LLra6nEK8L1AtX+?=
 =?us-ascii?Q?iQWFJbDqaNn5alY3glWm3f0Hr9SkqIIA7v/wY2CFCf7MCMWj5scLwzonowqe?=
 =?us-ascii?Q?F/f6dGhlCvROwicNyJi5SWLksLY2t5+5EVeZkTk262fPoxltHQdefpO+uOOr?=
 =?us-ascii?Q?4wXL3tLE4SdagvEfAxO7hqCqfVaEPVA+gNqoOIuMCOsvLQbV7fXZdU2bI+/s?=
 =?us-ascii?Q?SlZ57AfpmVkEOnm93995aTMAzLgiNUobFsZURvT7amUdBbHhMq+d4ieOZHKK?=
 =?us-ascii?Q?XB9m5dWhHMV69rdppgDFQXsAe+B1PafgV+uWBN7eIrCtJ8ikYcO5AOV5AFCE?=
 =?us-ascii?Q?Ej3oj0k+JYPCF9maT+e4sMhuezeZLYaMkNLGoWnUmPGT1XdhmyzD1EtIKCM1?=
 =?us-ascii?Q?izkMQhNt+cplGSkqa7p/11KLTvCc66g0AubA9esW1/amYs8/uZIVFKDlFH6a?=
 =?us-ascii?Q?pLKH9/G3anuDNsQxKZv9P6bUiH+wc6/rdsSatqOI0kjXk4erPtlZ8Xoon70z?=
 =?us-ascii?Q?H86ttekCPx0z27v+Qw4LazorYKGY1wHcpnxmq7iA4jbgZo81oIAQh+O7OVbM?=
 =?us-ascii?Q?V7n2WnEPRo1unjW+eAFz6NGrOsm+xBENxpq29yBZVuS+67M4/2lhRnwiW/tW?=
 =?us-ascii?Q?vwQljIk6HYw1ApRe3w80mI8XKAG5y6JDoVoWepRW139cr19PUKwgOQdKxZKy?=
 =?us-ascii?Q?a0E5E2ZCUpMGyAZ0RoUYaF5tEG5rpLawzUhCEwPYdEE9k3rmKOUk51m1bMCb?=
 =?us-ascii?Q?4c7pNySTb26ZRPYNRs9Wx8CfkNm+Zo/zCchsWxzLnjw8Aqcl4AI1Ltrcbk7F?=
 =?us-ascii?Q?iq9mm7Gr3hXJ7ArIh2xtIDG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee8f10f-f9eb-42f6-0a4b-08d925cf626d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:50.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gux3QjWOJjWqxMP2mWCEUFWyF3i1l8H5lI1cIAiLulbqiKwcx756f0sGtJ9h76WZDaWlqfrAN9lPtKWFd0YKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
Hi Boris,

As you pointed in the v2 feedback, the RMP_PG_SIZE_4K macro is later moved
from sev-common.h to generic header file. You wanted to avoid the move and
define the macro in generic from the get go. But that generic file is not
included in part1 of the series so I kept the macro definition in
sev-common.h and later moved to generic in part2 series. This is mainly to
make sure that part1 compiles independently.

-Brijesh

 arch/x86/boot/compressed/ident_map_64.c | 17 ++++++++-
 arch/x86/boot/compressed/misc.h         |  6 ++++
 arch/x86/boot/compressed/sev.c          | 46 +++++++++++++++++++++++++
 arch/x86/include/asm/sev-common.h       | 19 ++++++++++
 arch/x86/include/asm/sev.h              |  3 ++
 5 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..59befc610993 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -274,16 +274,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	/*
 	 * Changing encryption attributes of a page requires to flush it from
 	 * the caches.
+	 *
+	 * If the encryption attribute is being cleared, then change the page
+	 * state to shared in the RMP table.
 	 */
-	if ((set | clr) & _PAGE_ENC)
+	if ((set | clr) & _PAGE_ENC) {
 		clflush_page(address);
 
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
index e5612f035498..49a2a5848eec 100644
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
index 0745ea61d32e..808fe1f6b170 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -134,6 +134,52 @@ static inline bool sev_snp_enabled(void)
 	return msr_sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+static void __page_state_change(unsigned long paddr, int op)
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
+	if ((op == SNP_PAGE_STATE_SHARED) && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
+		goto e_pvalidate;
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val = sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
+		sev_es_terminate(1, GHCB_TERM_PSC);
+
+	/*
+	 * Now that page is added in the RMP table, validate it so that it is
+	 * consistent with the RMP entry.
+	 */
+	if ((op == SNP_PAGE_STATE_PRIVATE) && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
+		goto e_pvalidate;
+
+	return;
+
+e_pvalidate:
+	sev_es_terminate(1, GHCB_TERM_PVALIDATE);
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
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 3ebf00772f26..1424b8ffde0b 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -56,6 +56,25 @@
 #define GHCB_MSR_HV_FT_RESP_VAL(v)	\
 	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
 
+#define GHCB_HV_FT_SNP			BIT_ULL(0)
+
+/* SNP Page State Change */
+#define GHCB_MSR_PSC_REQ		0x014
+#define SNP_PAGE_STATE_PRIVATE		1
+#define SNP_PAGE_STATE_SHARED		2
+#define GHCB_MSR_PSC_GFN_POS		12
+#define GHCB_MSR_PSC_GFN_MASK		GENMASK_ULL(39, 0)
+#define GHCB_MSR_PSC_OP_POS		52
+#define GHCB_MSR_PSC_OP_MASK		0xf
+#define GHCB_MSR_PSC_REQ_GFN(gfn, op)	\
+	(((unsigned long)((op) & GHCB_MSR_PSC_OP_MASK) << GHCB_MSR_PSC_OP_POS) | \
+	((unsigned long)((gfn) & GHCB_MSR_PSC_GFN_MASK) << GHCB_MSR_PSC_GFN_POS) | \
+	GHCB_MSR_PSC_REQ)
+
+#define GHCB_MSR_PSC_RESP		0x015
+#define GHCB_MSR_PSC_ERROR_POS		32
+#define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1b7a172b832b..c41c786d69fe 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -62,6 +62,9 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
+/* RMP page size */
+#define RMP_PG_SIZE_4K			0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
-- 
2.17.1

