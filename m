Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764E13F2EC8
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbhHTPVb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:31 -0400
Received: from mail-bn8nam08on2046.outbound.protection.outlook.com ([40.107.100.46]:11233
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241042AbhHTPV3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQYvdvkcfMEYca3m6nLMU45IbEnRWlXKe4DKCZ60Zf/gxUPcZsgygnnfDt/X2Pv1awvH9ZoN5J/N9STt/bhg3R/6pu2ApAFRYNJEasVmQ5jFsVUerAAHItE8edosBNthmyafw62bZH46xk9yG8RGupVDzNGYYwHgi3DlsH74SKmNvum1ecqYMe95yIYXf/8V9hUYclCtAMvmjcYZUKDfa0j39JeLSJCAlGQXp8NhYg4Qtrn9Jquwk/phlnyUAXeaBj8GT5AQZryHv4YIS5oNVlW3H89ylgvLNU9KFK0dT1cmTroGKVWUSjbzc9uHJGAP6J7IrlSiZA+M0LlEHHo6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO5CBULvSRYz6y1MYiiXQ4rtiz9Cj7y8LYIG1pAHdNc=;
 b=h6Re++w8EpOuZLYUDLu64Yi/Jiu3OYbF8vfrX6Ed0Yq4bXqOv9CBTyzFDsD7h5aH1KwDK5LXVcLQujEomXyQu15OSKJdemnYGZh21aZ4jU17Jhm/svz7Fm58K0XQjFkXeyH4ea87vUVadSSAkM5UtcAcGJyonNyNOXXS+9SIw//RP55+NwAcLZvq2O3KIHy9/KMoKby3lQq6MinPALM7q/RSG6NPG62nG9+WQTHoaHHQA6fze5HwK8SrCk/UGfxzvxL9iBLkZ51HQANxiSi0y0m+yWInpGQ4FwN1ueRE+1Mpg8v2/NWlWmLPBIE2j3MEdpDZJS1VJjQ7/8MIWIrnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO5CBULvSRYz6y1MYiiXQ4rtiz9Cj7y8LYIG1pAHdNc=;
 b=Iwtmz/cn+rO1eMOxeC/YVk5PDJbJDxEsVfD1bS8XwvulYdGa+4CYh7GXUG/josUvxt5hrdXe2cd2lis57bP4Dxf8O/MfB+U74cf+n3sW7wtbYweEKlyzftyiZSybKv2Y49M4WbmHGwD4AO4g1tPnIpHui0kuLNjtv/X+uxFeHug=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:48 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:48 +0000
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
Subject: [PATCH Part1 v5 02/38] x86/sev: Shorten GHCB terminate macro names
Date:   Fri, 20 Aug 2021 10:18:57 -0500
Message-Id: <20210820151933.22401-3-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2259aa3d-213d-4ed2-c24b-08d963ee16cd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557857D82A68DF774A62CA3E5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJQn6Pd+PtMQCPBrxGjJGbJf9skReS4KoIii6N3o5dQ1VTQe2RyArgIGBUlJtJhCzSoymHZDFxgPx4omrmDgka7BFRJQY+d6Bysvw4MmSUyL/IkH+Q6Vy14EmDNVfH/7lNb1dEhX/KywORzX3P4NxGqmcSKr5V4HPbChZZ3DLZK/bS5IggZCYyjEr7f4lKu9BP6AkSvfDRBo/Hx+1i2ltdNH//JlXQydsOEWJchnY8uLJxWmvsBsllf4UT0STNHwxhotECgiaxpmgYt4DmexuVP4NvU253EceaWFQKcWyjUYE5usE8heTSQ7h5QEj0i4t01aLCcoxC5E5wdiZ65vIjQ3ojcS1c2pQN/5DhCmog6Rb6V6VVfIHdNPvstfcL/lMb+A6p52na70VSIsFNAQoE/94jtaK3qiPU0yYVhwQR+PCPF1E2RXRMb9O1DIA9GdTlGlpVClZ2MIQKx9HLz45dFkt9bKMXHqXkjsEscjCvNHC5IVYpt3cgI2K49sCGAbxUptRYQAFHarcLfL8g52NV7PlTfc1BAOCZzmWOmRXrLtXjZNHXXHTau/MejKtVKS/DfF5x1eZDTMUdtjhmDYfwdFCesxHjVDuU2QdCAKQJjS1DVZ4VBc6BHG1vtfBBXcbz8e+naAeFtYmG5t/uPRUaoof3x7PgvDcm6Qqwqrs1rYdob5cbNhE1Y+3wwhw6ZSrE4iItOk3lJNKY8YzgPGtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(6666004)(36756003)(186003)(316002)(8936002)(2906002)(83380400001)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vwZAHDQeVK/dlBvXSptKFbJdnYdYaoR/NvmqqV9WhLfHWPBGGUMs0hFSkzvR?=
 =?us-ascii?Q?MbBf54s4dVabVs7CBLOqHqqrZB4UESZr4KJWOODSmpPn8ZC0sx9V96/5pKCM?=
 =?us-ascii?Q?+wJ1EWvD3cg/oWG/TL3zm6q2eDM9qKgUx361D3Unxk/SAwn7OB22F04Nj8nt?=
 =?us-ascii?Q?oyhZWnsqJWwDxHIuahc4ojJQY9AgzW/x/aZV87MKPprbnUnPnctr/kPrrf7U?=
 =?us-ascii?Q?lUDoZpy6mUjocv5mpQh1Lpa8UJk4Zwon9nxIqJ4FTLO76hzOSLdvEN+SJ1vz?=
 =?us-ascii?Q?dwBHYuh/bI5G2oNYbm6PSry5v2MNm7/LrEeCKMgOSoT14eZecff1hI+aokNY?=
 =?us-ascii?Q?3h2578qpxQo0Avxaw8d9oel7hUPlsF1UoOwPZoKyREhhR/kMEO8qm2wPOml9?=
 =?us-ascii?Q?RJNkg0GA7mxoLNmgIkjCgUJpE4mfkqKylv6LERmxiOupNw5J1GQzShSlM9Q5?=
 =?us-ascii?Q?aleeC4uNOAlmhZMil+RHVCgPjurPs9ISf2WTUgmxmp6o4vd1qYaZ5AL3Wbr4?=
 =?us-ascii?Q?R4p1OGyCKlCjJZaY37YrtslJE1ASnNxX11p34qJRHpvq6NaVE2sFLH4b24lI?=
 =?us-ascii?Q?/0WRfICdTh8W+Zk5X+Rp+xROvgus5sGIcmoHVYQxbHiyOfahXmWwO7qo68LV?=
 =?us-ascii?Q?qPVigUpNGE5Tb0B+2OSNluf4eDTH/DHyRNizVd8COXODPOrU6iC2eXk+u6+n?=
 =?us-ascii?Q?zbDxSake+MFTDIkqBNjD0mVwQrS948RAoynibLPLQ+ahTl83iNCMWOKOtGrg?=
 =?us-ascii?Q?WmHYtaA6UOYtgcguQip+487lyoGfaabaSo4VnWy1Xv4Xo/jCW5HwWl57b4mT?=
 =?us-ascii?Q?MW8cB0o8Kj3w4CMrNrF0lSPSzL/cLg4D9Z71aPQBMihVYHkYRr2zoDwivxge?=
 =?us-ascii?Q?56X6Gz967TRg9ZaheKejGVkmZ7diiY8iJvRkwBt4YUvkoFbJtimLvcCOINYW?=
 =?us-ascii?Q?ObMNESh1jauBuTwWL05f/hirTKF26UTWLZuEwBc7zZap3xk9Sn0wvJlBsxWC?=
 =?us-ascii?Q?pTKCF/YVDoj7VzgvlvDivk/g8R5iFf5vWyv1fbMp9FFW7jrgJO2cA6X3YrWv?=
 =?us-ascii?Q?CJ93nmvcQcGcikm9JxSmtPwAlX/aT1gwrguMCeRKeDntkcot8BQaEKIC0xcl?=
 =?us-ascii?Q?euITyjGwP1RM0Av5V5Ts/kPtTSPs0SE/qz1Iv0+gQZUh7seHnF6Di/eAv015?=
 =?us-ascii?Q?yTykEs15i2PTCPLZl8helSe9vO+BCwqYAxlE0STQZEch1JInmPSiZLo8png3?=
 =?us-ascii?Q?sF02ULCe5owJquGUiY8wPfiqVXfZOrMVCI77yK42Jhw/ldeMkq4Rq8GUD8oo?=
 =?us-ascii?Q?iprYfyJlMaPb79Yq/lIpYl7e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2259aa3d-213d-4ed2-c24b-08d963ee16cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:48.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxKffzocIIPPdK+u+AOrUxftr4S9x6VetlVQ29hD6yNqIBdRTvunLx5UGzOErC5zTT3u4dwVRxwDwbHRQM9isw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 6 +++---
 arch/x86/include/asm/sev-common.h | 4 ++--
 arch/x86/kernel/sev-shared.c      | 2 +-
 arch/x86/kernel/sev.c             | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 670e998fe930..28bcf04c022e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
+		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 2cef6c5a52c2..855b0ec9c4e8 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -68,8 +68,8 @@
 	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
 	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
 
-#define GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
-#define GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
+#define GHCB_SEV_ES_GEN_REQ		0
+#define GHCB_SEV_ES_PROT_UNSUPPORTED	1
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 9f90f460a28c..114f62fe2529 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -208,7 +208,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..71744ee0add6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1429,7 +1429,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1477,7 +1477,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.17.1

