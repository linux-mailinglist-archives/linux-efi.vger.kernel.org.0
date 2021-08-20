Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7034D3F2EDC
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbhHTPV7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:59 -0400
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:31347
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241076AbhHTPVn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK9MHkjjMs+jiIl1pAjR71ogkiP44VCUQgBQLOJJpQYm7aibK3Ik1pIDWvLmsCoac4hiZzcUPxyLuV3fbepkPBzJzQz8lkERhfBHJzONigWxST5Vr6bmWW1NmQbhWbx7Un0ARIoB58LmFwK/oMRkNXy9j9G6iChb6pRcHacTJNor7IkquRHOenvDTu6+KUD/zm7TcXcRXNcBSDbnGjXxisvipE4oDFz0oNqCpa4kalxPXPkAqRyFS0YXXs7WRyMGx1NBARbk7HAcxUdQwMFwugEGS6BaKCv+kS0gMh3Bm/0yt3HlzPB2giCIEbfriUaP7iLGFoMDDYOx4K0RgrCo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cLFB+nk5W/JcHJ6k9OTbtKfrAocexuj+OA4KVCHTWQ=;
 b=Wbxbn9qyUFEHo/j8zMAX9ydie7kuCIvABiNwclBHRl29zEbtmTj3FCdgsOM0LNNl0pzobYnjdHIjaQESsi73lXF5+VdHCoOOUCgVt8Zx/USDe+M0c5/5nFGZkHsw2pVVFSJofJRnntMXKsQGheJ9fte4WN7/s75HSOdXXmgzQqRffto4hwo+TdpzyjsKAv1LC9arEi83SZ76dpiD0Wv7KtuJY3jYa8lXYmUO0K4IMX+5BoUF5GcVC0nRaqy1lQN9Qh/bL4eBrG4rvC2GF37dAQ5NPhlxTZ7fKDwCBeoIs9csFQDvqpi5XBpGPlyiRCf/bQJCgIQP3MEaQXSuO7hWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cLFB+nk5W/JcHJ6k9OTbtKfrAocexuj+OA4KVCHTWQ=;
 b=2pmqT3Fok+mxx7LU5c6NPVszk3mCwNbwGTDdPlz2wqQQWwJ5KinOIHCdGZdoKGETjuEPvgOKQDRPliJR6pLGAz/c7tFuS+Aes3Cc/zU3MajkTHbeV/oXrHm188AOyNZdDDbkN+z74yC5yjcbP90HUJ2t79ntfeFZ5zWbbJ9wc3A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:52 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:52 +0000
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
Subject: [PATCH Part1 v5 05/38] x86/sev: Define the Linux specific guest termination reasons
Date:   Fri, 20 Aug 2021 10:19:00 -0500
Message-Id: <20210820151933.22401-6-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1a0619-e322-40fb-da0c-08d963ee1913
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27191ECD79EB37288526C456E5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJLSMaTTyfmfsj/vg57i8IjJPVg0hx1cBm6XXQQeBr6lkwRl0gEajor00YtJtJDFDRZB+VsNfWdQIC5s2q86xAizEKUOPcf7pcGlyJmqDQB0ZmNtLkdPAYAR8iai8EnXAhTjijwCgyWPy6eUaUEBsM4MnoktK3Je4ux1gGqHB3XDNnnbx58QLc4zLfqpoLGefu9TIaS46Kx5mNXrlKxekw97DaBUY/d2de6kS9uQap9AZ+tjO+Z7QkGomc4VTIw0Ru4xgPXrF0VhBFqOkbjl1ZGVaVem+Y27jLMgg7h3IuoFheMggROCikkUeCx3unV8/HJ2h9wVv8XbDLJUTEKDqKbQ6pmbck3ULJRNAqLer8+Hf+tMF7Lh5yorqm5/iNRIbvQPpRCfAfjnDjr1XY8U2wemicVAkBwkA0Q4gXIB/Mb0CmgbrE1EPmjFWliXPFBJoQnC65Z7jqZ1OCIggFM284a0zwkhmvmNcs+AuUEv+WycLaLcw0BNVkfOdKFJJpbqMZGqw9XkWiH4GqpxnFK92rDeHhvDDYXHiB/0ecDF9KFDf++78EV9SqypXWuY8Ag/GLDd8Bpwn5ttbul9HGe6Yi3AwR8EBR7z/toN3Npp+WilvdyFe85VAJZlPOYddL7lLvH/wZTYybwP7EezMUQlp6vNxeZnUdnHo6FEuObyRHdbtsNrm0yjl35tw0ZqmBypzDsAtPLpG4lcAX2KiSWZkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRJpLAtEXhPwaw2M2EduNG+b3lEfL3hB+3lrmcGP+jDCeJZFZxWgIWqHCkwW?=
 =?us-ascii?Q?sc1QivgZhez5MnJC3IMv3xc2kKC2oh03KhA2w8eRXIRaKUlzuEOufwBQ7g7T?=
 =?us-ascii?Q?M774Jc4+O+rlHohN+T5ZDxkUGJHmY84UTx/xKMZhM1bsLDT+FXUb/ePtqkri?=
 =?us-ascii?Q?NJXQYobNmzARg8QsqjGLPjDhrco3QC3Wk/3hPC1Tni0VhVsB7Iakhaqi3dKk?=
 =?us-ascii?Q?ndYPxlpWN6YND0Wp1P09QuejRtSmYHIYLIBtpkXIscS2pX4NgeX9Hpn9xIfU?=
 =?us-ascii?Q?tJVvLB1yms4Udue3m2gmYdE5yi6b0K0jbbyBWK37d1WsiKUPDtHf7BC7hCyf?=
 =?us-ascii?Q?gbE6moNBG6XKCDtGPYLHbBtf5Nhq4QpCtgHi7T5mLIue0Sjet0TsE80p7jPM?=
 =?us-ascii?Q?AHe+YmkVOwxeVOQRSbj9aIrfddwGoNg/WEcvtsv4Dt4ElwSvjkYSBUwVCc92?=
 =?us-ascii?Q?hXfM4i4neFxz7UZt3KlUUwjfUzQYYu2l4eTRb7X8NiEMCMXpvhqLazhHh3Ug?=
 =?us-ascii?Q?z/rIdAjomgQmIY/ztJ0cijvuL6i4fAeABxhTAKVxPUhUMxN5GxrJ/k32NKzz?=
 =?us-ascii?Q?val8N6h4MDWpj+0IJHYC/czzf010Mse+sqOWKrPLCS9/qDXrEoaEflHoG8sH?=
 =?us-ascii?Q?fHOVnY5gv4n/IFfijYVjemwUemgZPFWP4s/HDiMcFwEbaTGGVzTkVd0eWf7T?=
 =?us-ascii?Q?aFp61X2woLZTZUd9oN0GNEfoGAwL2v4xS61N49TTZiGf1k5ye28TSDuLMTpU?=
 =?us-ascii?Q?7TyyYNfF4KjWKQUzeafcLoh/ulvGti6g8ugY0a7+r0kOHKWMz91FQ6vGI9g7?=
 =?us-ascii?Q?RiadZh9deZ4N1cDgKUGkY5qaS+xuSC5PZ8FkcNGsQHpDDDNvUqbOqXG9T4Rh?=
 =?us-ascii?Q?DlvmBdrLGOFfg72IX9RJu9CRkZ5NBbbgnw3uCWOrdG8dpjErkiY12vCoPMsi?=
 =?us-ascii?Q?xU7GUfObbcDBRpIL+kyp9WmrBTqIhhKw0mdzKrfOr0DuR382sWkXuiuWGneU?=
 =?us-ascii?Q?XWwWS+JhSHaSJLHoZrhtCD+Kxuo30mpmuNoKbZ/22YQ6LMo+iYp1TW4xJqzN?=
 =?us-ascii?Q?XGdkj/8c7gIFkbGXsrzzA+/DccijAPbmF6/a2Xw2oOfKdrr11SAxnqygAKCl?=
 =?us-ascii?Q?SkgzO5mb8FSj7wY9M2JCLl+H1EdiGNb+/EBqTyndOyydNzTTgvs4htCkPq7N?=
 =?us-ascii?Q?sarzG8xbwxqqZteM5STO6TY8DT6OaVDf7T6xRnQgCUnwiMFPHS7o3Hljvaez?=
 =?us-ascii?Q?Ka/Ru55y/bL8Ok9r9m3Ge/vBRJ4J2UbGQFsRdMb+o4CKgAC5rPcdoyuLlNEC?=
 =?us-ascii?Q?Ztddr8uZrAsYXb2hdD8W8a66?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1a0619-e322-40fb-da0c-08d963ee1913
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:52.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZWE1IMwuJ6WVMvz4vaTipBh+67w8Saw6otUnTd8phyIbTZT8x/1vF5dNlj3QxCrBmdzmTwebaI5pB2oC9jwPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

GHCB specification defines the reason code for reason set 0. The reason
codes defined in the set 0 do not cover all possible causes for a guest
to request termination.

The reason set 1 to 255 is reserved for the vendor-specific codes.
Reseve the reason set 1 for the Linux guest. Define an error codes for
reason set 1.

While at it, change the sev_es_terminate() to accept the reason set
parameter.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  6 +++---
 arch/x86/include/asm/sev-common.h |  8 ++++++++
 arch/x86/kernel/sev-shared.c      | 11 ++++-------
 arch/x86/kernel/sev.c             |  4 ++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04c022e..7760959fe96d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index aac44c3f839c..3278ee578937 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -73,9 +73,17 @@
 	 /* GHCBData[23:16] */				\
 	((((u64)reason_val) & 0xff) << 16))
 
+/* Error codes from reason set 0 */
+#define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
 
+/* Linux-specific reason codes (used with reason set 1) */
+#define SEV_TERM_SET_LINUX		1
+#define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
+#define GHCB_TERM_PSC			1	/* Page State Change failure */
+#define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 114f62fe2529..dab73fec74ec 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -24,15 +24,12 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int reason)
+static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
-	/*
-	 * Tell the hypervisor what went wrong - only reason-set 0 is
-	 * currently supported.
-	 */
-	val |= GHCB_SEV_TERM_REASON(0, reason);
+	/* Tell the hypervisor what went wrong. */
+	val |= GHCB_SEV_TERM_REASON(set, reason);
 
 	/* Request Guest Termination from Hypvervisor */
 	sev_es_wr_ghcb_msr(val);
@@ -208,7 +205,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 71744ee0add6..646912709334 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1429,7 +1429,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1477,7 +1477,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.17.1

