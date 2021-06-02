Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE4398B99
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFBOHz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:07:55 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230366AbhFBOHJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff/xrw8XWNGBsDzA9lRNK7FKyKubXWIqFnB1oz13hn3px2XMC/M+U/1Mmyh+TvCT49rKeTPiZ5cPLBrGCODSEM/fw5hd9M3IUTY+YnrUzri/9QQoj1tsYSo5zFRf0jcPTY9+dYiU1SDiOpmPZYcPgFD2QK4Nu5vYTyC+QPrM6n4tUSV0N5nMu7z0ND958yfrMMT3+j0VTJdFt1EzggddZWIqi84BBNzM/VwG8Y/wLucoFUolIkf2jFc2iSyl+Fzrw7hpC2usbSkHGGo6I1dKJw/3Heotd1Sz45n6s0j1qgB9o/r88MJZSAFpnph5ukqopBn08Oe54lawM/pDhMSTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WeZ6oeX6YiFcQ2u+1zWHvfSKD7SaAk5kyErgRQgHKo=;
 b=Hschy3yU7XR5tP8d5V6Ps5SiiHO2s01OyMVFFL0VvKioE4xgCqsXjFco6SdsA0jDJRDzVnB16+MCFWKDyH4iQvD+wr56T/1Svv8VtTg+DxjCwIYQ/yfhfYFJ1Jv5twJ40SgTVPKdPDo8EvF2sY/v6JrXpAeKHbMwS2tRrERkHUAQIfhiYM9QYrwI0qfyB8nHI2WurbixxYiIK7hSH7o/QFWbIqPqjNNnQHWurkUZyT0Pr2VKeHkMf5I8ZLB99ro6Gw9PMeCeFYQxWCB8lTBrEQi1YEJlMWmj27zjrLT/kM7k34/qsQ9k81g5VPPhAu6z6f3JXohXj8acqEc/lwNGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WeZ6oeX6YiFcQ2u+1zWHvfSKD7SaAk5kyErgRQgHKo=;
 b=Tt00zlsYvop6DlpphixPrrGiIN15c2GTfEllbpUh7lACpwTIWCERwIUq9d8Ysws476v7hEKaQ/8e693y+7jjoyBMqdv5hKoZIu8WpjBAYSiLx/yEaruFy3Jz2twuCL8d4r61vsRG58YCUgT1y3k1Vy0fZRexfMzp5WtLnpo7J00=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:48 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:48 +0000
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
Subject: [PATCH Part1 RFC v3 07/22] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Wed,  2 Jun 2021 09:04:01 -0500
Message-Id: <20210602140416.23573-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd941646-53db-40f0-c849-08d925cf61c1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512BC80F5A06C30450A1445E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1Uus7Cao9GBo6Oymb8DkhAC9YbUeOUh/2LunI66YNJ9XEosLKFAp7ajyufx80T+E12/H5ak2jW77vJeZhXnn1LMqb3E4HlVeT8Vs2H2+l7mK+8eGdHolYYZ4e5xGtNXZLyUUWDZZNv+0aILllMbopilw+FdfIhd/yHlbkNFLHtBS0sMa0c6e/krBfNeG4NTkTF1oJONz5mJmbGphfI9TcIATeT8TFcKTsfCIouoUU0ad2owuRXD5wLJztOxjQrLySq36voxiQRQ7XXUqis7PaM9jtrNXPAJMaFmL6DYvdbfYnfvd8FqXuyJ/kWCVLK5kyyULA4GDX2R85pq65FljT0pbdbjZXwuxFIEhlo7t1aamDKLnF6dBkw6nLH39jSMgJsGVuX2kh/HgRrx51AnxpDFU88o2VT6XPRiIkBYE+r+rbCUSHtg8vwUFocrlaZmZZoT22KAhdDz40DaWFbP76dN2jjRhLkm7Y3H22R+B/ryUNljUIAKt5ORt951IH8sWvQ9+VvzUyHGc3n4ImJoqATAOjF961CK0BCKthatFXpDjqPur8JH/2vDjoZTmAo/5N4b2Ed+RI6R0X4Qi0RsnfUxbBxZBB/WonTqQUKGZvDF0D6s/gAjU8pJ7yzt6xuuuZeBMz1YrJC0hFX3Wy5oTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFpTR3ZkU0ZwbTY5MnQrN2hIdnRnWElkTkZKSVkyc0NCejg1cTBuUHJob3l4?=
 =?utf-8?B?QjdVSURXTkdQWXYrZjhldXlrR3lCNXdSNGRVd1ZUL283QjRzRTFmVU5WajZT?=
 =?utf-8?B?ZlF4S0NjckF1WGxJQmRKRm1sbHJpYnB6Wi9VeGFid2U3ZTZjY2RGeERURkt1?=
 =?utf-8?B?d3U0U1AzY0l2QUVJV2hQbXFYVmN3aDhQZzY0dGk0alQvdlhUUXNwR1lDUzdJ?=
 =?utf-8?B?RDlYY3p6TTh2QzZjKzZYSmtEYjFPYTJpOWFheUNNaE5Nd1lldHNCVHZDaDFJ?=
 =?utf-8?B?TWNTOUoyQlk1V1hxSzRoY2lnMDZGMDJzZjNiRFY3NVlRaTVuUnlCbU5Pamp0?=
 =?utf-8?B?S0dLWm5SNUtlZzI0OFFDS0ZSRXU2RGRpeDBrOExWVlZSMG5Ub3dtclVJeTEz?=
 =?utf-8?B?OHNTaDRqRExmVndGQ0JzNUNUQWhFRmVFZHM3eWU0SDZrTTBQMWNUSFZBdjlY?=
 =?utf-8?B?UlljVlFxZlpaVzUyRStJcm4yU1lYR3ZaV3dLeTNlT0NtZG45THNmcmxxenc2?=
 =?utf-8?B?Mkh5S2tTbXM1aDNWdmJ2cWJrRTBzZ2ZRWHJ0R3hIZnRzNlZHUGIrMVVyRzZM?=
 =?utf-8?B?WVJydGlHMWtSem1TekUrOWRicGc4YkN2Rk85VlZDWVNncm10SFdCa0VzTVc4?=
 =?utf-8?B?SXZNTzhoSEUyeGU2YzVCZGZxN3RBQWpuZnBLSHJuSGJaNmNUN01nMmdzclJC?=
 =?utf-8?B?WFlpeFlDNUxKa2t0VWJMdFA4c1dybGR0U1pNckt3eE1rS3pSQ3M5WE5IbWVz?=
 =?utf-8?B?Q3JIb01ZUzV0WTR6dTgxeVZVdlhOSTJQNHlhY0cxSUhDTU9oYzN1MDhTdUFz?=
 =?utf-8?B?cHExd0phd3A1WWQvQ0h6QWc5a29pdGVqT1RTR2RUenRmditxN3lZTTJncFZG?=
 =?utf-8?B?eDd6UUxtdVZvdG0xeVE3TXMrQ2UrbjlTZXlURnREV1hOVkFiZlFhY2hpQUkr?=
 =?utf-8?B?Mi8yNTJmTW1tV0N4NDhmSzcrdldkYzFqRzlnNUo3TmJ2UkExa29xQ3JBOWJv?=
 =?utf-8?B?elJxSkhHWkQrcHV0SjhxYzE2bFY1YUlaSG1vd2N6dHJ5MjloVjVrRTF6Szdu?=
 =?utf-8?B?U2lzWElNS3BXWldWQjF0clB5VDVwZ2VKR3RrWXlRZWp0Z3c3cEFEckUvckUr?=
 =?utf-8?B?VzUxTEEyc0EzaG8vbDJYcG1iRVRIYjkzdmZsUzQxV1dDTEFuRnEvc3cvczlx?=
 =?utf-8?B?VFNBMWRCWmhBWUZjK2pyaC9vUGRvNXVNNGFBbS8vdUtiRkVEanUvRDd5cW1u?=
 =?utf-8?B?MlRCRnBPbWIwSmc4WFl6MHRtdElybVR5MENaTGVYRTM4ODVxaE9QS1RMejN5?=
 =?utf-8?B?QlFqdTJrYmkzNFNuMzUwbkxhellKMHBpWVVEd1lGWWFxZXJ5SUQwRW8wY3Mz?=
 =?utf-8?B?aW1GVkRCVjdTOUhnVldlM091MTNNTWswdk1PbmZvSlVEWVNhQ1NVdTI3UTRQ?=
 =?utf-8?B?dGE4ZE14bWUrYlhaaHE4V1JSWmNQbmdnTEdHZTJMV1VaVTRoRnBhbkJia1BK?=
 =?utf-8?B?TnQ4eFYzUWlCN25FUW9lc0xsYUVjUmcwa21mL0h6S0RqK0tCZC9RNklLSFB1?=
 =?utf-8?B?Ly9yK2dEKzJLNUplemQ5aGxodExIeS9PM2tJd1A0SmlFdUVHUXlsR2l0L1dl?=
 =?utf-8?B?ZDJRNmxUMmxGRVpSTXhmV1I5eEMzclZGVlJZbnBkbFkrRHlSbWRKRnlNUytl?=
 =?utf-8?B?eVpwRFRZWWRHQ2hjMlRmbE1oVUg2anh4TEJjMUxYR3p0Z2VCb3JkaldGV2V4?=
 =?utf-8?Q?h7LkwpPK0LnRH8cFoIXqDgR8yuZHhZdLXrITMFI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd941646-53db-40f0-c849-08d925cf61c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:48.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmKBsSK5ugnc1ixsx2RFf4v1mvJDYJkKSBbyrM6WArf5wLOiiMIxWZvDE95nKywootYNrg+l+Yqy2xWmhyxNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
 arch/x86/include/asm/sev.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 134a7c9d91b6..1b7a172b832b 100644
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
@@ -81,12 +84,29 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
+{
+	bool no_rmpupdate;
+	int rc;
+
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

