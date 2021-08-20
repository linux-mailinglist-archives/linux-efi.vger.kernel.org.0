Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA573F2F0B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbhHTPWr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:47 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:8352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241294AbhHTPWM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmDu52Cabgiweq6p1gWkAn+ig9hV2ZzNZbQoW/528HtQ8ptjZVnPAM5wKo/vKrIUFyvplxCIn0hPxnYh82R5TyaANU7w9O4J0R5j+wwq3gfUImXCSB6qz0pBQfw9vX9YXCiildEdKVzpldEP9L8p1IcVb73lEXEfQuVtyj1cd/hJsZWYD3mSxG3jmunHWw5/12nY3c3O3FWZQf4Gtqt7O5S8+rq87djctlQ+9wlCBIrb2aTdAYmetk01hFPEucR3cjV2394nTTnh/n3weZG5wal3m4vNv4Lb7oyD3Pc9SULHfCgOAFAAiS/W53A6cD2BPSx8tK3++6Bo8msa24zpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqpkdEwDOJ+PLbBJfLPfylH73xag1hy2mj3uc0e2fI0=;
 b=dZzAtEOf46jkNUPDf+7uer6g7I+uD92r7gy0R21+5v5XLY93VmI8OGiJBINP0+dpOEjEZjJul2Vi2EjmE4JPGMNN8Hb13dQlHxzEATaSbGI/sSSIdufJRp050aBwtv/JZcJbjxkVBZK+XXver7C1nsEQPBURH/Z2XagdO6D8hSonK32XFike7q51+VD0a8RbtLRGWxHUjhrtsNAMkvVrnVJUSXSXSq/sIVIagrfEFsEp1q5xMapas/M0i/3ihJEBAJ30loNVdPI7f4+Le/U+m/is9uP2LU3vkMCo3NSnTYxDys2UmMtOfUpvrwznypidjH4iaolBzFJx1fG/TkQkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqpkdEwDOJ+PLbBJfLPfylH73xag1hy2mj3uc0e2fI0=;
 b=a7v2hV/C8mLpO5yE4T/971dEuvnrVN6A87tt67n5ae4yuCV8GXlcu7ryCNbIJv8ZZ+dRN7036rcheKaN/r95H8WOjVkATc5he+mKq49pJIfbukn/eGeqCT05nexmib7ByO7PsZHKavxxw/a+LzIZrFOf7cm54tB3xW9Ck6+Scos=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:00 +0000
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
Subject: [PATCH Part1 v5 10/38] x86/sev: Check the vmpl level
Date:   Fri, 20 Aug 2021 10:19:05 -0500
Message-Id: <20210820151933.22401-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e41262bd-374f-4a5d-350e-08d963ee1d9e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2719030A229F70C10F35C06EE5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDm99JsYbM8QV2F6RlM1KMcwO+Ex8NCMsv7mX9Ihbc5T0cwuqWKpc39zEH5mvKiYPlJqwXi4BYKWMogyC7atZm+sMMCXK6zIZBipxjm4+J47TocTyWDMuS2SdF5kbxQIxZVlqWH98G3VdCqLJIk353tUoHn5AcTA8ysw16D2pT1vfBBG8Zz43oqw1RccvUkEHmnOTOc4ktUo5jp7Kn3yOjc0PMF8gc7aJg7FnlWuEH8fhemmVpjTX/+e+hcfqLO+98mcqxHw0DjkBjI8HNTnP7gefou9l0M5Y+JkUj1MeFBrdCJEOnHUpJgE6O+2q+BzC1jr7nUztfmbM5jc2ZOsAveUDSByZ2gJOw7E346mVhA1becmpS+E6FXNvfqAs6ZjcCbXFnBOUKJCoWpPVP8tjLaq3k3VrjMefeNabjrz27/fozhUKw1RUZBZnCI01oO4GqGX9HykEft5Tew/7CgP0REn9Tr1D4BNZDjky8cwM73ralTrGvwy/pjOqjJkhZwjtUQkSewfqATQgntBGgwUkfgi/qNBnBz27EMPdjAaed7+KzGqFAnnuxPevySZBncEiNNaRvruBf+EgyBFjZNdn1U5IoO2cIrBmUiUFregOZrZljFgi/8tXVYA/SviBY/CBTCA89qFzX3JomD4v+DD1Sbt8yPZnbOnSq22kKrmMkQX132nVo/gfSBMoN0nNLNJnH3GrXv+1i/XTJMcM13WHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmRM/nvM/vG9gud8jP8dMXnArX0YKDQiO+8QLaKq9AyyxLHkoNrNixCnD0m0?=
 =?us-ascii?Q?u62heYL9TOeLz9EYNvJYRLqxtbTLhF4+2m8iSJ2+ty4f8mzf0fnJRooGU92Y?=
 =?us-ascii?Q?icogMNguZtkvXubI9giUkSiQcVjQaoniQeiXIwVCqniRRUql1x251IwmXbSB?=
 =?us-ascii?Q?E2nNjwLz+ax7XbMWReQ7oeDuZB1Y0Bt/xsWkG4QVQuy/8YJDkyijn94qC63C?=
 =?us-ascii?Q?5nNIw8Y2+iRXk9F+80OCRWhn0lEPqpkNFlbeoSsqpLlfUFs+PmRvZFxw63nl?=
 =?us-ascii?Q?mDJvQ2jfJ3AlRGyUt0rm0zY25TWfhNu/uFCOEnze3ULmvV0ZBuCbuC0qVxhX?=
 =?us-ascii?Q?6PIGAKVRBwF+LavRkedIHGmDPlIhqVo/74ZPztuuQRhJ008QzozwqMHqyfEY?=
 =?us-ascii?Q?V6VT1yBaCmd6s5hBV1/bPNdOhaDJ+6sH/H0Mbv0cu/XucV9cOLw5fafI3U3u?=
 =?us-ascii?Q?uxjCxiXOiOntcehxH0vxz+nRvX6v7YayAB5g6bIVOCgioGPc6T6LUtDKzcty?=
 =?us-ascii?Q?bao0xuP6dxkDGZIAHMWE6Xy3+5ECrQAJhD2MiEVjfDGuqMzp1FXhWr0PyQEI?=
 =?us-ascii?Q?t3xT9aaY47d6B47XhQFKP9E6FUcfEBz3BEZRtoJuCG0/MV1QVAwDBTFETWTn?=
 =?us-ascii?Q?TXXTEnalrh09bZC87jnmls5HB00coszzwgNH8kmUXUjosHX7ZvY4jnTSSGBl?=
 =?us-ascii?Q?ClCv1F0DQD4voq94iZhl4PUguG8woURDGef6MqxrsCq2VA2lFCuLB9IjvEvx?=
 =?us-ascii?Q?CEf3cc1DYkhdzmdUq/5XMuKZV7zTbsByDGO/SSfpwj8gAS4yw0/DHjDzXZt8?=
 =?us-ascii?Q?AA35MR8fzLPyAQT4aKeRNhEOrl5Zo3gltm9P73pBRARERhXml2TxLOVNWXFq?=
 =?us-ascii?Q?ua0PLFYwo1dlJNOsEIwKdgB5r7Jjgub7MtJOERB8GwTShbjWI5IawW6oTQR3?=
 =?us-ascii?Q?lgx7ks5GLDE/m5LdbYIbty6TXa2fvkyJQrGNVLpkkwFmnObM+5J9rwWMbRTy?=
 =?us-ascii?Q?n1EX4Jq7nthV5OhviZEJKrmKLoWv5KllxHlsLwjUUL8+pWBxPCQW7Jtglvt+?=
 =?us-ascii?Q?WymsDQtzNS6uD6DqcMV6kr9PA7G4cdihIE7gpmRAyCbAAifCWP9XHqS6KFPJ?=
 =?us-ascii?Q?1njysOg8hmAFpIHcaNyNsaMr2J18VVqe9Lx7PWgcnXbo4jipBBTPydJoegkg?=
 =?us-ascii?Q?af3iTxaFrUowqUcrEqfOoOCJBsi6inTFROeFsP+atpDKRJ3rwrhBmuWHvUer?=
 =?us-ascii?Q?hqWboaRHCgOhzbcuwj1vzK3KfaWEfqSsWwVj7e1wA0MCgyPdi+g0lup3uKlj?=
 =?us-ascii?Q?LaXUTYb8rDDk9uo0rfiLgmi4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41262bd-374f-4a5d-350e-08d963ee1d9e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:00.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr9WK0a0Ov1oTRLV9EU4cFK+2dZ3OwCPd/wykVAtSJYfs82y2zZ7vt5ToB+HN3UOrFBlp/4ZKrbIVweOVkMaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Virtual Machine Privilege Level (VMPL) is an optional feature in the
SEV-SNP architecture, which allows a guest VM to divide its address space
into four levels. The level can be used to provide the hardware isolated
abstraction layers with a VM. The VMPL0 is the highest privilege, and
VMPL3 is the least privilege. Certain operations must be done by the VMPL0
software, such as:

* Validate or invalidate memory range (PVALIDATE instruction)
* Allocate VMSA page (RMPADJUST instruction when VMSA=1)

The initial SEV-SNP support assumes that the guest kernel is running on
VMPL0. Let's add a check to make sure that kernel is running at VMPL0
before continuing the boot. There is no easy method to query the current
VMPL level, so use the RMPADJUST instruction to determine whether its
booted at the VMPL0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 41 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        |  3 +++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 7be325d9b09f..ec765527546f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -134,6 +134,36 @@ static inline bool sev_snp_enabled(void)
 	return msr_sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+static bool is_vmpl0(void)
+{
+	u64 attrs, va;
+	int err;
+
+	/*
+	 * There is no straightforward way to query the current VMPL level. The
+	 * simplest method is to use the RMPADJUST instruction to change a page
+	 * permission to a VMPL level-1, and if the guest kernel is launched at
+	 * a level <= 1, then RMPADJUST instruction will return an error.
+	 */
+	attrs = 1;
+
+	/*
+	 * Any page aligned virtual address is sufficent to test the VMPL level.
+	 * The boot_ghcb_page is page aligned memory, so lets use for the test.
+	 */
+	va = (u64)&boot_ghcb_page;
+
+	/* Instruction mnemonic supported in binutils versions v2.36 and later */
+	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
+		      : "=a" (err)
+		      : "a" (va), "c" (RMP_PG_SIZE_4K), "d" (attrs)
+		      : "memory", "cc");
+	if (err)
+		return false;
+
+	return true;
+}
+
 static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
@@ -141,10 +171,15 @@ static bool do_early_sev_setup(void)
 
 	/*
 	 * If SEV-SNP is enabled, then check if the hypervisor supports the SEV-SNP
-	 * features.
+	 * features and is launched at VMPL-0 level.
 	 */
-	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	if (sev_snp_enabled()) {
+		if (!(sev_hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		if (!is_vmpl0())
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+	}
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index f80a3cde2086..d426c30ae7b4 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -89,6 +89,7 @@
 #define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+#define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index b308815a2c01..242af1154e49 100644
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

