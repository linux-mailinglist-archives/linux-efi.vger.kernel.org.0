Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2D3BEDEB
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGGSSh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:37 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:62945
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231523AbhGGSSa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfzGshlJcesDkGbjqe2y0oKP04askys0DrXrnads//xPjaAMSXJD11GfB6kgQFSW3ZUoUV8ACVLxQIQbJI08idiGpgAeo8rvUMEZwZUn7S1PClnteknFuLU6156aqTO2Tko/v7+lIODqJaQ6/2SeTA6S6RAi0pXQAu6+D+NgaL8fVM5uust5rsnhJM2Hs+K9TzsRtq29HBfCYqpsQOPXbbPVF+GXOUndAyuySUtE15OOJzLaTGxCNCtiRldA2/4L2ba3lXbtp+SE+ZqRlY0KChWiCLgqODw7B6cHEn8hnAQPA80/PiDWHzh/9dNnJvgDFud0GxuYuH8Q+Pdag5/g6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auJREV1mAE69GKyOzop1JjXtKKGgG6Klxx/V2yHFQ3g=;
 b=OYG+R6gnHDIKl8kwHZ+0i9HSrJ/gbu/2mz1qQ03bZCLgubEoen8uSGIkTAua8WXbdlW9xSM1h94Y4FgCgy5LeoLVNDgIoRE4BZPOAeyvNVixPAkkXi3Walz+f9rMK+xdixUe5gB+g/aL/hWn4pJ32RymWBFZpn4P3kSLfg2S/p4rp/aoe1+CXyiUyX9xYXER+r2qVJLEQGzzE+hlr99+CXquEXxPqXyNvaloOkgoxqflAf3VVsksj5vlAaNtDeaCxluxdicHL0s6w1oGzRv3I8erFGQviIAa2X7Fdd9+dQ/AeF5zKqEtMrBHyOc6KIagcNsmFGt/dGOA2FvSrCxEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auJREV1mAE69GKyOzop1JjXtKKGgG6Klxx/V2yHFQ3g=;
 b=HrSGsT4R0zn7wwqppwYYfywID9vfpjr0B1JNGy9f47RkLCvA2MqGFsiWkaZDkQO5E0k1DYiaYaZEgyNmwDTJ0DVuhKICr7CeAKJnA935jhzFajVSVviSq624K0chhRzXIgL5ts4yLi7OhW2B+e6fUvfZIlRH/ypcbkrpVYcaQLg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:15:45 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:44 +0000
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
Subject: [PATCH Part1 RFC v4 07/36] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Wed,  7 Jul 2021 13:14:37 -0500
Message-Id: <20210707181506.30489-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb902a3-cd3b-4552-4c5d-08d941733caf
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3939C51545BB6311BC060F6AE51A9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7r/4kdHQ0rInqhvejQW7Zp8vNvNMLLfVj7/Jz/Rj+rK4G4w1NbO0Af4kRGdGETs4ZmL9XtzrO58LkZSA9Qj+ldYVUcCv04G7gPXYGG7ZwwSnvuc6xx8LaLhKXUoztdT3blUG/MWIhJxt4rIjQKTQ0yfIA8UIP8RcVti84cZcdpKA8bNeNer0I3tUWRlLvcdrqLacX15T3CcTGl09dRhynbnsFHQ+uto1yi6+q6RkbvhtJRT8IGQ7twKeN9iyH2Hu5YcCwdB+Bmc64b838v9mwID1EMzTomr1yxfPjtA+1wHN66VHZxGltiVs7nnprd6iq8FilveRbl7WAEWc3EJYz2s+wBdn5OTIZ6+Gdt1Iyej8HpXYjWpQ0MXXlww2dPZk8qGYXIHC8pLdj9sdJnIELAJdjNeJQztFuBaT5X/mEVV8U6tncGEge8zL6URcIG3BTUKBUZYOTPMBX2oOl5R6Gc0tQ0MvnnfrMLCJbp6IsGNVmpunAfeV3GVD1iMZdFbMVEVS7VGfojHWuTQ4wiv/buHQk7CnRHB8VbPlxgtFY98hqJI1G6EvouSEjCBGDSqQ7zSumAFjnuaN7D0hCrNUHWMt2sxT3xaqoc3t/sq/ocO6143JjjQtvjdZ3YmncdvACIQuZWCoFRlQdISapyD582ls0AIXQWil6kyMrp+r/NNEcSiQbftKOoVnHLVJ2xG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(44832011)(66556008)(38100700002)(38350700002)(66946007)(186003)(66476007)(2906002)(1076003)(26005)(52116002)(8936002)(2616005)(6486002)(7696005)(6666004)(5660300002)(8676002)(956004)(7406005)(7416002)(478600001)(83380400001)(316002)(54906003)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektzQzdvZ08zUEtnMzBKM08zak5PbjZqR1E1UmtLNGlhdHc5SjBzSm91QjRn?=
 =?utf-8?B?eURLcHBORG81SWJqNnY1Z1FzMkhJZ0pMbXJkUzZQSjJSV0pnTlh5WkhWbHBP?=
 =?utf-8?B?M05aMzZhcjdwZHBKSkdneEpRQ0lHeE1KcWRCWitLOGNoN0toeklsb1ZQZmtG?=
 =?utf-8?B?cjZ6RnMvbmhWZW1JaDFTK2ZvOFpUKy80QmhyckZRVzBqNkpOV1NFcDlMRG9E?=
 =?utf-8?B?RHgyQi9GZEw3WDUyTXc2MmJlUENoVlhTbEt5WVdvRkYydFB5bmhjcGRzMFBi?=
 =?utf-8?B?MGdKdml3TENLVUhRUXMvaFhsN1NRMVl5MG10UWQyaG9XMUExOC9qcmJ5RlQ3?=
 =?utf-8?B?UGJKRG5HNXUxRUI4cHFpQVQ5Skt2Ny80dUQrU0p5MHlKMnBOWmo1SkZVOVBI?=
 =?utf-8?B?ekdVK1BJUFZlVHdUMUpycHo4b2VNOWNNVkQ5dDE4L0VCV2VYVWkyQm5QR29M?=
 =?utf-8?B?RDhDQTFBZWtraVhSbjFDQnZiTVBGQk00ZERDbzJsK3RLUUZwV2RjQlRGNXRC?=
 =?utf-8?B?TUlMT0NNQi9iQm5ZbTI1U25VSGw4QUtCMFcyTm1KZXlKeklmOHhGQzUzVUZT?=
 =?utf-8?B?eUZWNnh5anpUSGVLRDA1c05ielUrTjg5VUVjTmpHaDJqcGNVZlpDWWE4NGdB?=
 =?utf-8?B?anVUWkhqUExEK1ZqMGprRzlvRUFnZVdPY25qaGJKcEhqbnJrWEFhUnJhL3JN?=
 =?utf-8?B?SHBvQ1RXNkMvQkZnem5OUFFxbnJPSmR0TVNYS09RMDQ5Y2d2bjcyRjkrUE5V?=
 =?utf-8?B?SnYwRmZoME5nOW1PejN1a25LZ3JJSlJWYXpacGZJRW5WK0xJQno2WjNxenJ5?=
 =?utf-8?B?cm1uaDhPY0NmQ25GZmFKWlNISVB1WkNmZHpwckFMVHRmeFBIMjhoMW5HdjRK?=
 =?utf-8?B?ZXV3TlNzTTBvckQ2RDJpektnclFITEFvR2dQMkllNzN0ZzFoRUZMd0hnU0Ir?=
 =?utf-8?B?TTFWTEdwa0xKc2p2L0lFRGRVTnRyUk1sT2krT3ZCVHBkRmo5Tjg2RldOaGdX?=
 =?utf-8?B?aWJlVUxiYTljSXhNVDFEL1hMYUhVL1kyMk0wTjFZQ01RREJ1cW11bkxXMlZw?=
 =?utf-8?B?QXRlQ3dYMEpQSm41bUFNSVdhRlFJMFJjZ0p2eE9UMklOa29jWTUwU0ZDV2hx?=
 =?utf-8?B?Mll3NzVQVkR1WVFRWlZUZC9kZkNXS2QwZ2NobWMzTlYxd2txUnFGS21jR3Jy?=
 =?utf-8?B?ZGdXZXY5UUQ1dWxsTXh0cDBRV0RwNE5aWGxXZmJNdmlUald2Y2pJTTJJczZq?=
 =?utf-8?B?ZGQ4Mi84MVYvTC9ZMjQzbjhBQmNvR2FJMUxjUVNUcjgvTVcyQnJmQjdCeDNt?=
 =?utf-8?B?Rzd4U04wV0s2Z3pnbUVPS2ZWRkk1TzJ6eTJmcUpXcHNPdVQyT2MvTjVseTJa?=
 =?utf-8?B?UGpMYldJK2wxQjd6OGtKamZUSHhLK2pmbjFieDBwekQ1WUgva1gvNVl0Ymgy?=
 =?utf-8?B?U0dFNm9rbHdEb0dCdG5YRzl0TmsvcmsxSU9zU1k4LzNvd1lDV3VVZG81cUhr?=
 =?utf-8?B?WXl4M3lmZ2J6b0R6bnpDeFd1NXhkWHFURENxa1lrSU1Qc21tMzZOVGtvWkhH?=
 =?utf-8?B?bGRSY0VnQzVNTG5mOHRvb0UyS2J6REN3QTVRTmxob24yVVZqTWJEK0sxdUI2?=
 =?utf-8?B?dU40OGtBR1cxRUh5ZHUvUXRLL2pPcC9oczk1bkVWMmpqVng5ajFLanJzY3N2?=
 =?utf-8?B?VVlTb0tvYTYrcUNrRjhzcllLbGk4MDJxL0FjT2YyeXZRS2h5Z0JWRm1nMGk1?=
 =?utf-8?Q?/UZoAWYPdpz/Uc0dpuhrSBb28zgSVZqEFyxjh8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb902a3-cd3b-4552-4c5d-08d941733caf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:44.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p9PEr6RfVFDsSCfxqGsddjjtc5oD8em6bLTWmjdOC1PC6T4aITahjzBV+Jc09hEAvMPWUIHlRVlT3EFVGgKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

An SNP-active guest uses the PVALIDATE instruction to validate or
rescind the validation of a guest page’s RMP entry. Upon completion,
a return code is stored in EAX and rFLAGS bits are set based on the
return code. If the instruction completed successfully, the CF
indicates if the content of the RMP were changed or not.

See AMD APM Volume 3 for additional details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 134a7c9d91b6..b308815a2c01 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -59,6 +59,9 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/* Software defined (when rFlags.CF = 1) */
+#define PVALIDATE_FAIL_NOUPDATE		255
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -81,12 +84,30 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
+{
+	bool no_rmpupdate;
+	int rc;
+
+	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
+		     CC_SET(c)
+		     : CC_OUT(c) (no_rmpupdate), "=a"(rc)
+		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
+		     : "memory", "cc");
+
+	if (no_rmpupdate)
+		return PVALIDATE_FAIL_NOUPDATE;
+
+	return rc;
+}
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 #endif
 
 #endif
-- 
2.17.1

