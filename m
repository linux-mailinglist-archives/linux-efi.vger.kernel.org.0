Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5845B3BEDEE
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhGGSSh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:37 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:17601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231544AbhGGSSb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIzVYkdVHJF+iXUwCyF9pVtDLvGwkdEOFIgVXkB2UDZcEaVt4WQCXQjWByJQmSncqLTd4r6jhb6u6TB1EE2eJpVWytp8xRH09s/C+wyAsPrJjrI1t3MSM1mDWLFIJlUl48qBO7bGsA58Eoa6dVL3CXoNrE41WbOYiZsly1rXy4Pw+BR/Az2KEOBKfY6ShXC9VJwmZWBy2J03dBwS09nNuFepPBBt3fYUHlch2MualrubW4w3+sSSMPjUos6Y5EIySaNIZfmG2vskL94wQ0m0g4CTc1p73Z5SzSOV23rVCV8M+lUhviIW9cflXoI7/rbYp2X2OEAKX7fMYkkeo0GNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvoY8el3yU2so1Jui4tnPlK0mBoD4b0ju1oQd3/iTM8=;
 b=RXKOj5Q9SzEou/GMuwKekuvUS6kI27SgFTaLpeRvnKZb5lDJoKViRrP1W7SuKQ6CtquJX8otFLLPMGpCDVEcd6oElDnp2py7uXRrvFRro7U7AQrnazEJR4dRmAkY+Aj8TKarDHlqJVv60h4HHcnMGJC83p/rOFADjPutFmdQrwMiWLK1SF3NQiOU8aWYFfmUBLEpwCyrJOuyXXniNlikTIO1pr8ammDwe/WrjSv0CbN76PJwSPMftv7NPOwZM5UPZtFzmg4f937e3EW0y4S35JHp+91w+iE8cQGiDvBZwEqUg2xDf7YfuwIu0JgVXQbMJx7VLZixHitHvcJFOunVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvoY8el3yU2so1Jui4tnPlK0mBoD4b0ju1oQd3/iTM8=;
 b=2f+xWiifcMSzSI7sgqtVi/Qj2J+Oy+ft/kpnZgKhlGcLVxixuiKwBhOu8hR9AJMFPb/VRd9V4v2+PJlovE4aI6d90qmNRHCyS60iqQ5Gstu+qBdUd/pWrBtx4S9vvktDKfRjb8o5SPXuvat2iX/a1Rl4ujlt2glscybTgej6aSk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:15:47 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:47 +0000
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
Subject: [PATCH Part1 RFC v4 08/36] x86/sev: check the vmpl level
Date:   Wed,  7 Jul 2021 13:14:38 -0500
Message-Id: <20210707181506.30489-9-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0fd1a2c-736b-420e-d2d6-08d941733e64
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4644B3084808D35E4D24476AE51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jd3CPoHSuuMuXk5EQiVPFl3eQ1uJDnGzMJ57R1QczEy/KMmy5ZIvc2cjWi/Jh5RejFPt/ALa7fgnzGHTmlOnhhTwR73Vvqm+4mqMQQGTLtXZxrNQwkglg26vY0978xdyIU710XFfXS4RXPikjwDHNSbFnjfoaVvJUV0lFUT3TRPaWZ0YtspORy3X0cvtP2pG6u4PhL8RfdzJ06ZTkQNlH2b4kezKUd0mmbncdsMK10DVzQr5AjuLs2jg8NnpZO1T8xUumInFilSG69N4rTQl3glk2IqpDIJlkKyryP6i3ScNYW4fObuO6jmIM0pzKYUfbe43eYGF/STBq2m0ox9mLvvExSCYbOxLdz9gWvHZzl4mSf4V2TfX+2kauro601309n0GnxrJBiDiAx7ECAa8g5bvVZ3w/LEoL+xtBBWcianCzcnqRM53h0qHhzzdRvDsaI20HVSDJ0rPdYxkenH9YHcMF7PxWfM+gixsmmjv7X4R8av87cDAlerjiUUzLFtSfZM4yHFkJxNVxwBFTFkZsG27ZJwBXDIUDIGlOrM3yxH4fNegm5KAcSUk61CnjP0uLxoPVnYAbuZ+/BP+qdzWfkKNMPQOqURbYbknuIuURv7N9acYkzDF+PonG9ClfWd7HoYcFPymAwaZ59oXmvrjSBbBiwDSUpkwErGvRFSw/UHJUVNUExx9XUsXlz5ciDr2iIDU4d9/Nd42n3jd4LKj5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(6666004)(2906002)(1076003)(4326008)(83380400001)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MwNYl/Km4rkrETT3j8M9Qs7XErV4lLAQjL+ZdVx7fxUiYr+XXDTG70RrolRU?=
 =?us-ascii?Q?Jst/3CwnfWnxNMXeqgUeBPxNd20hYb91Uf9PiezO3ziKar0IAh1zJW022qLe?=
 =?us-ascii?Q?QLW2mv4B3At2zomoGdtOLw87q+1GqxvNIcDu1UrnSlVqP/63CjTdiRrc3iM1?=
 =?us-ascii?Q?0J3/wIzmu1pInFeT/erN4hfhi10C1rAH9nBRhoE4zPRn4BbtkXnSowgMfYjT?=
 =?us-ascii?Q?5ZG0XNvFgIj+HLwxvpMnR48idxDUyt4VT4ll3+XYG8qnriTrVc6DrGKIi6yu?=
 =?us-ascii?Q?3/32+gZDMKcoPd54R2fWOeeFRaxuedoqeERCXV5FgGAWkgi7l7ra5MSpdcJe?=
 =?us-ascii?Q?upy+uJz3G4bya+5pBsjcVmR/iMLR9G8Fc5J4wA6jkHbBryDVUtKFURF+fq4a?=
 =?us-ascii?Q?u2bdADthGEx9uHYZUv5nb+jXUGVNC6F+4dJEbFz1OF+yhK7Dgmsb0vbOSY5u?=
 =?us-ascii?Q?Zg4oqPIDNBWCz0r4O65gk6Z6ytudOsuDWGYFHPOLcoJqFXBkzzNMkXX5qbuG?=
 =?us-ascii?Q?nN+AwIVQ3Ov69x+u2nerC/AEUxxSkD4t7aqFeWZwAtBFvsyMiwyHsSBZSsOa?=
 =?us-ascii?Q?51pOry41aWdUj9WIoPGxa7dv7d09gbP72eJSiYP9dxccgWHx7AJcOnT46MkJ?=
 =?us-ascii?Q?9VD+OziWIB4Inos8PzPWBvvA8mx/rAxq8H88AKZgBRKthyfYszVCvdqAonjk?=
 =?us-ascii?Q?dbEX29vo7ayaHeK8+8Ltrk1+ZHBsOsHKHKrlSi7lzTKzOOo6TOiDsyzGlvZ+?=
 =?us-ascii?Q?GVB0tIeHBrHYfihGcoubJtoSWEiy7+kGTYBrkR7VQWOJba4O34CuU7CKmGpJ?=
 =?us-ascii?Q?AMpvxaDZSrFlP+zVQrQF8hWYkynUesbULM9cNq8Ehzb0OwKixKnpuR+FuOrG?=
 =?us-ascii?Q?HJxpZiRtRyr1UsIRdk+GCadX/e3g6IV2Dn5ytNqjHxfrBYv3sYJ+RZYiQ7c7?=
 =?us-ascii?Q?OwGmxRMwN0EwlgeBAgzWtKjdCtc+NJsDvib9JpiczeABaE9+z/Qy5CMiHROM?=
 =?us-ascii?Q?vDV41z70iSk4jG5jK/VFg4UEbALpPmYjYmhViP6UfBEJG/bEFkoTGuDSenpO?=
 =?us-ascii?Q?CbrbMBtSYImoztwj/TzTSzvGCwCC+WP0Xm7iBUWXQ8keJb6dhRTidEO95DxM?=
 =?us-ascii?Q?1YeZ6wXcukTDRkZYFiTcdSWWiyS1oeWcKrG83AFX8L+F26ZNjcPqEr5a/q21?=
 =?us-ascii?Q?9RljyX2dDPAlEHgrRixU98QryOdM/FhhuN6YmbslvY6sGMZjAXcoQVWfhVCQ?=
 =?us-ascii?Q?R21kKG5fWLhs30knT34vvDRyzlIl3pRn8mXB5vZWKStln0spb4XZOeX9U0bm?=
 =?us-ascii?Q?vSqHUdu5bBKarx/yNZN+VPPG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fd1a2c-736b-420e-d2d6-08d941733e64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:47.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2DVAxP2JAMlPBmvYESZGzn44/nBkVY0uz6PQVUJsCLNqn6OLzfH/3bhRDCoeBO+rfhN/bX2Yomr842Nr0kTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
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
index 7be325d9b09f..2f3081e9c78c 100644
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
+	 * at a level <= 1, then RMPADJUST instruction will return an error.
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
+		if (!sev_hv_features & GHCB_HV_FT_SNP)
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		if (!is_vmpl0())
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+	}
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 8abc5eb7ca3d..ea508835ab33 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -78,5 +78,6 @@
 #define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+#define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 
 #endif
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

