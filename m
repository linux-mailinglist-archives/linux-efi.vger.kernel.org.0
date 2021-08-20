Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A013F2EFC
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhHTPWb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:31 -0400
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:31347
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241272AbhHTPWL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfoMczt1+451JBaWK/NiipIxXebYxNNTedWtLrVSgRk9KeZzacm0hkeys/W34WB+sHmPchbin0pSuHyN86YCkEQEq3hBp48yoe1CO035W+gMTPuw16e6Jf6ppnRVfjWvg6oHKOqRBAT5dwWxqQPVJal56FLtVAo35lwARWceAT9QbmmCOCZPXEyzQBwc073ge8FGsDV2N1buTfIQ6UlGvWMhSLfS/Y/iklF0Z3FPd1mMf2AdkABjMKpF/CEhWLg7SzIlIbfdiBcGAv8lKGrDKgJ8mhwUFFJG5R1yuTUL+XjZGQ75aWVCmtFUBAmdJ2grDS0LWt5PCI/eP9czXTNLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auJREV1mAE69GKyOzop1JjXtKKGgG6Klxx/V2yHFQ3g=;
 b=RsVgovd0vt9/mNNu60YCCQVK9t3KU0e7NU6P5Re6eTJkFZtkkW8EZgmVBfORSXTSWi9dnd4bTkhE6+65lvKMvI31Rq8WlQzoJnMrR6rqo11v/HoxHvjzip0Oe809ecKULKsPgbwxL7OL6Z5Uc4R7+V2kC0LaafFiLyDYDu8s2uILvfvElcJZgb/F/A6yyTsp5yzqVvMri4QtDxZU0m4KmfdRximb/7ivBvmcX5zUmceCFqiXL7lYx09hTF9h16bCL+NNFjYgZ4orlAOBWYYGQK9T4+4xVJKx6ZUbvqnmJjvIdr9/tVlfBxtAtGMVfT/uqPfAAt2GaK4zKugTlGYeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auJREV1mAE69GKyOzop1JjXtKKGgG6Klxx/V2yHFQ3g=;
 b=pqWF3NbfSqkis52praMqadny4to4lBJ3hVfH8QLgKtWwO6brMlw+VqnzEb83xvM3b+WQRH7aT/ZNDdOYJN8B+tiIYsZFa5yPn6Slhre2roIciqqR2fqM68z5mZUhQD7UQcCK2JrPy3OqIHu3DLskXHUm5g6EVUGRCS6/gF3zhUM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:59 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:58 +0000
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
Subject: [PATCH Part1 v5 09/38] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Fri, 20 Aug 2021 10:19:04 -0500
Message-Id: <20210820151933.22401-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f61b4f-680c-48b4-9dfc-08d963ee1cdb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2719CADA9839DDF7751F8B91E5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SE3PBf2cG3x9f+g4a5lKM0BZNlC0PPT8cJ+ItgL9QBTDwTogzzuiuz31stZ1C3RyqDqohdCnifRIJimTf+bdukOkkhNuxzPkJmqlajZhMDYyJU9+7q4jnTsU1QBOhonoqGC/w4U1TFxOqtQP9m9JZ/0/GiorzK1UO9UWWVrSSHRLsDeXvZy7iRPMNmCiyzXWlO6CLNDOm+DBvhJVfTjvmWQJdgF34cwpkDRyCfbzt5Kytw//iioaxF1gCb+343lfRolnxzZFPROLO8HtRqTAkYs/IzlPo26kDT6tJjkaKhsE9sOfBOMmFz2uAItVYq0qXvIleVa4G4AJ5qBXQ3rP0ijunB98fZUjf5fPcAn6mTvu38R/zO4IuYxhDu3YZMR/JVVIz8GEO7XC3iVqV0E3PcfThFn/5gtcLY8utbjW+0xV1hXlvzlvV0y8Nj9K9qbqBCWcBWOkBIHqEocRhw+N4zz+HGRCHhaxuYlt1zIaaQ2H5N3yTePTs79g7uXWiFKeedOaHYPd2mtgxcpR3h+12P5mhHEQG3y+tQzx7rBBu670Wza4+8K/rCdfhjP8J1S0b7NTue5dCOKiCXNJTQx7g34qixgjYWA3N59TaZuxdbjTPjXpIWvFjAXkphc6ivIjK72l9YQ/aGHBFhXpEg/JjPIiRragt5HJzEfGrMEz3lE5FP2aP4ciXBHWcPLFc0O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExXWVhNUmNSYkZxWGRWL1JCclZTZHJKbUR6Y08vWjNUcytFY1FCT05IYmpl?=
 =?utf-8?B?ZlFDbXYyMmxZYzhzVnRIZFVxTVRmRmFwOUlpRTV4Q21TNG8rSVVmVjFUa0VK?=
 =?utf-8?B?MUV6ZVlzVWVqbkxBZGFQYnVLVGR0eVBwc3ppUkFyLzhNUmhrOXUrTktPNkZw?=
 =?utf-8?B?NWc2RnlTdjVTNXdQN2g2WmJkSDZVb0VNTlRlV2dzRWsreGlpL0QveDliOXMr?=
 =?utf-8?B?U1NzZldxdDlTOEN5dzQ1RnBEZ0x5QXJiWm1JaTJjeWg2MjRQZXh4MDgzN2Yx?=
 =?utf-8?B?MjBYelFRdml1NU41QlU4L0xueDRxVFROM21NWHAyUnk3c0h5Wlp4NHF6TEJ1?=
 =?utf-8?B?OXZTbThZWEwvbmhFN1FqZW5YRVpRTjB5OGZHbWpjblJhTHlhRytrTytrQXgx?=
 =?utf-8?B?bzN1Y1E0NlgwMW5YYi8xRjF3NDNVcm5GQVBqNFRLS1BBbnRGWXlUNUpTbHpk?=
 =?utf-8?B?Vi91U0dQeGNFVHFIdmppaXk3S0loNFBzV3E0eWowS0dWL3lDRVQzMk82cFMw?=
 =?utf-8?B?OThFclFPVnJUMjNzUlhOdHRwQ3N1WkFYOVZ4RmFGN05qL1orOXNudStodEJ3?=
 =?utf-8?B?aTV4QUxqYzk2djAvby8wdVpOQzlPSnJZeUkwNHJYamhXdG9sTDFVU3NSb3d6?=
 =?utf-8?B?eVJvdlJFTFRkNkd6R215RFBuZTZjZi9JSE1XTFZnYzY1MG40Wm1Eam5WaEY3?=
 =?utf-8?B?VjJlV2huYW5NWHd0THRyN1QxZjhsMHV1Z3Z2VDJqb3Z2NEFYTkFHNXNCb29U?=
 =?utf-8?B?QlE0bFdwelZXbXRabU9LU3VTN3NTOHIzbzluRWd3VnZtVWczSUk2dUFNV052?=
 =?utf-8?B?ek41Z0lFNVZZVVZYNlZ1bWFQN3JXejg2aHNIeFpmZlNtanRKSGpHYVFZY3Uw?=
 =?utf-8?B?Z2JNVmdjNm8vR09KblQvVkphN25POERIelFZaFNzSkQ0V0h0R2ppVGw5eTh3?=
 =?utf-8?B?ZlBock51MmFJYTBGZWtoNFVLZS9SOE41bFZmUGVLZnF0c3NwTUxlTHpuRERo?=
 =?utf-8?B?dlcwTHVQdTlpMldrRXFRRTN1bVAxelNCSGttUVBILzAyNG8zWDRraGY3Zk9J?=
 =?utf-8?B?R1ppczY3MnFBVUhwUC9HOGdqa0ZYb3dQbTNxYkM4c1pPUFB6QlFuRTFhczZw?=
 =?utf-8?B?dEJHeXlzT3ZiSTlKN1Urc3NsRkVZa1lac1JLMWhPei81VmNHK2x0L3FobTdR?=
 =?utf-8?B?UU5URENFZWV1Z3RUQkpYL3lGWE9wWjRJcktCcEhDTWZwNVNGcUpKTmw4SHVU?=
 =?utf-8?B?MWN1QkJ3d09ZMng5MkEvNFR3ZDlFWHhHaDBFTEVkelFZaXhMcmZVWVlEZVBh?=
 =?utf-8?B?aFIzNlBFZyt3NXNXbFIrbUpJdzZibmQwc2NNVXhuSFJmaGJ3S2N1aGtVZm55?=
 =?utf-8?B?MkxrcEdCTS9CZDJwekVSZnB6TjRrTVhHZlpyejlwNjJ5Sng3cnlvSTdwTDFT?=
 =?utf-8?B?UTJrNmJvSHhYSGlvR1ZMVUpHMFBpSVhDVGxTV1dnWEZ5cTBsOXhnL1NRbkp3?=
 =?utf-8?B?NGJaT3hITlIvUWF2cXpLMmQ2S1Z4bVdWQlBaNUJkTjZhMWJPbTJUYWxLVVBu?=
 =?utf-8?B?Z25nelN6VGVLWHV1YTV5aksxd3diZE5DK3NuZjFseGh0VkZKRlJHdjBtcmxw?=
 =?utf-8?B?eXFQTmVublhBNFRQMXlJU2dJV1N3VTI1V1E0UUxxZ0ZNbm1OQjAzYk8wc0p5?=
 =?utf-8?B?UlBiOVZUZmg1MVliVVhpaVlaTzIxdFRlaURSWGhvWDBQN2hQTndqSW83bGJp?=
 =?utf-8?Q?kVGKgcB815VSloSHNEedOWl0j5NtfP65PXKoU2J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f61b4f-680c-48b4-9dfc-08d963ee1cdb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:58.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvycn0ITVwHVl1zVYwIaCgPNEoLGPQg+s7vLX89vwQclifwDaUHtSMPf/PjjsJf02bgz9AyhF+/ECUHihZzvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
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

