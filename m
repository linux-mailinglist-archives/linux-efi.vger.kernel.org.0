Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898EA398B6C
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhFBOG3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:06:29 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229762AbhFBOG1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRvrFSt26XYv14P915GN8eEEWZj6Mi4FRAnyUDNJcB94yijnZcZHhIx5ArIbol1Oy9TaI8lxeqvO0b4kzWWS9RpfP6F8ly/NoLJPKhVnorzXJyr+uqt4IrIyNvb2Ht7luuBC+I7oSIAW6U73n3Y8iUuFKrwFpTqnxCGGoXbkaMiGYhdPUt3PG4miWyXm7RG/8H9kOO1A8noco/UAGlGQ3xiciVEDnsLzqAxoC5qIz4Cky0tMj78M8QXXmGMJUlnP/6cdb3Dr8gJ0WTg/xCzeOWjO/CAH7kflRP1ZQw9+ahn/Zve3eXTGyUq++JeN8KwUN1xHa9dGETqkxq4uT3+1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P2zk1VcQPPAr7zpiOFCgxIcMjX1nTKHhNWkh8c8hO8=;
 b=Ro9AXZBO8+XdLI7b9r3L6qkogzv3FXJSh95put+64sd+0Mi2s2vIJwQJqZP5Tw0+L/emH7Z9CPg1YSikUbiOD4Kc5z6u9KuditPJ+EroW/DFa7BwCWqMzwpCqvHqOz1ebWUVzTNzK7ZxDzQn1YsYw/rjaAog9qQcA+Fgj5j9HyRmGuHv3M7eDLzoRpI9ezEPJlTVOAlOXuBkujI7oW+DaIg+01hQnfSdqSm0zawM4eFvQAZuRmIx0NEw1XB+cxi3zT2Sb5rFACzWUCbWX+VSfXUyKpw5pQeRvl+jBcA6jb/tIPmUw3EYCj5s3osglVhKXxBEfB4HFyYAGUEL+j1R0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P2zk1VcQPPAr7zpiOFCgxIcMjX1nTKHhNWkh8c8hO8=;
 b=pHib2uk5YI6TEkcn3sFqHrKQtUh0O7XV5ptozXU4cPynklvuFiGOrjG/qfEamDS2lwImQhF2syPyDbs5mz+XoAilxPaSxgSMpU6XZKdBZwlbavTVOY3/iAKR84cqhTi5ioRiS8dCKC7yc+yhJat07ZCEzb9xb5+UfALRHTJQDFQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:42 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:42 +0000
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
Subject: [PATCH Part1 RFC v3 02/22] x86/sev: Define the Linux specific guest termination reasons
Date:   Wed,  2 Jun 2021 09:03:56 -0500
Message-Id: <20210602140416.23573-3-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbdacf02-317b-4f14-6551-08d925cf5e5a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451226E58C5B8FC2B9F3D663E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HljAJUMv2piUD3WlQBYqwoZaFrVUmgMOgIMTf/ZHpSFDAZQolPY6V/EhRsuE4n5bZkFhKF94FcetQx63vBf2RQfkO3qxOrJMG1DTcs1L0S9xpCvn/ehZy7JXAkDAKJCC4md4yAKHLKEOKKzUT5oy0kPbEP9LwKCcuYGyewIH/whTJ209nii7qlGHOxyBHgRHU0kOqNk+0ug6lSn630DTTnZiU8yVVfj0ALRA2noeIUiV2W/6YNcUS7dDC+6chULzCGVxt6PqL4Tup39KH1XHacTG6eGBRj0AODVpOdHv4V3Rpr66/c7blDYcvFaeYjGGLr6u7t/Q5J8vbOlHCYiMUh4xqEyQjlTxHpCOKejkDiB9IzdvI8UtCbXB77TGYt/F+nP6aQrmZOIFBNR8qg7qF4cGpsFZ3kkwmLFW8n6k+RYOTbG6xPkaeD7AQLvct6gJMC4p3tQeuROBme0sey1zkle5hSZrbtEztMGP8yb+QJeWLMsLrHO1l0bhqBlHSdAhrxIesgWTJRhf0JwXo5UePxiF1f80w9Cfu7hKYmg+TsBnRNjsdqsdPS8B3sPd59tkmbz/MO08KXcYeSmLnIaFc9hA2ZNA37aa+5A3uNG+u0xItaXQLOkTRTPP7xpQcFMZXiFVd5j/6+qkN6ZqCcleBjacrk7GqoEWX3TMsJdWRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lRapv/AGxDDbJbsx9eWs2It0XxN/sDgroLQdPPLY4ywbCnILkfsBZMqEzeyk?=
 =?us-ascii?Q?EObcdv1NjrNqtAnEsbEOPW4EZEPElacWP8GmRBpPkdSD8ys0w9+CYHpeBwvi?=
 =?us-ascii?Q?GyelKsExYqhajpuBMMlfe0Fu27NyM1dWn+0zYomfUGSOiAO4VHJ1wBSbe6gK?=
 =?us-ascii?Q?MJH8Pfl+YdGGS06p/QhEMvXyhtptMKD2/QIqzgJV97zBeGfxHor/rZ1ifY8p?=
 =?us-ascii?Q?DBH9X1AFpLedGpgGOKI4igqziXvw3l7AdpWk2gJV6zlyu9pcV2fwmGwIIzns?=
 =?us-ascii?Q?//90a10oL9+L7/tS89HsFtu6cUjo34PC39LhLQRljGFBL/FTo/UM7asZi7aF?=
 =?us-ascii?Q?NUZ5JUJxsA78hE4AP3zxgXx6+YHSjSIMSe1YNqSjuTgKBu7DBw7+BvYXUtcg?=
 =?us-ascii?Q?cs7+axlNTVED2mqQgRTbvCcosnJ9ZDemb4gS/zenZiiAesmRiRKTQMwJhe5U?=
 =?us-ascii?Q?f+CUC0/CVz5wnsYqLgfIPkx8o+B4q78D4Gw3SlWkxdCy0jYvajLFEpiTF4h4?=
 =?us-ascii?Q?8/YFHINDtnt5fDZigJL+DamfcBdhzKK9tynQS215lL+9lgm3M9XZ2qdpEnPG?=
 =?us-ascii?Q?gv952fZmV88Tyym0LhgNCV4gqy6ZoNTV9Ibs+XsUYPtpMduiPOwNyhKFitnl?=
 =?us-ascii?Q?L1nGJ9nDDC+/1Z3YGzlYBwi8gYpwgqrYwY7F77/+cN1nv/IGmF2LNn0jdoZu?=
 =?us-ascii?Q?k2elGeS+DP8JA9tXInWEZRBjgNClG1NvvU69bs8ExjhIhvNYvL8TBuPWPgF1?=
 =?us-ascii?Q?3oart/sV1xG9N9CV3OjgplbkRYODo3fkBTNo6mLgCaPI0bi8qI9eVyOlhSYY?=
 =?us-ascii?Q?nAKcPdygyCXFmccBPhGz/MgD84qf9Qo9O+nJ03sHGPJK252gg1+0aIXibUeI?=
 =?us-ascii?Q?JeD2vNvSfTQ50d1jCIICg31rEY/a0sCS3u/S0y5Cd5h8gektxC6r/agQk/gp?=
 =?us-ascii?Q?J9btleHEko7scr/BNGg97bhOvxTAe6RV1uM/haEW9ZQdVF2Sn906icJjIVk3?=
 =?us-ascii?Q?C330cthEiCcGE3wGJizB7BGmVgrPOsyQhXugi6tDInLZoRpKbyEkhvWfFKkR?=
 =?us-ascii?Q?t0v4ggnIKhv98TI2EmwkQQX6y53cT+uVmhXn8qDP1xwGdVmJ2dEemPB/TQb2?=
 =?us-ascii?Q?TFOEYrnDK3U7vjZ7onAuyfrfHP8JDrv9o6hSiOaMkPOm7pKP/pDjrm+yNSOf?=
 =?us-ascii?Q?YRX+zLZw8bXxhCC0Y+x5eQePm0A5UtNugMvbiqA40eCNhqr+qmN3nq/4HyYH?=
 =?us-ascii?Q?qcLtgfvLkcL8KzT2yUcAA6iVMELWOKrbiqska09HyIbtQNo/Eem58xxnKIKn?=
 =?us-ascii?Q?HJ3bvUzTXPH671AqPwOGGuru?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdacf02-317b-4f14-6551-08d925cf5e5a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:42.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMkzeT5jv+LZP/Rixi2qLwXMPWBmEjSEFnC/OZU+DtTFfWrwmsNir4hCtYNBx1kaaGEksqzoP+cMSaOAIx+w6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
 arch/x86/boot/compressed/sev.c    | 6 +++---
 arch/x86/include/asm/sev-common.h | 5 +++++
 arch/x86/kernel/sev-shared.c      | 6 +++---
 arch/x86/kernel/sev.c             | 4 ++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04c022e..87621f4e4703 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
+		sev_es_terminate(0, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 11b7d9cea775..f1e2aacb0d61 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -59,4 +59,9 @@
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
+/* Linux specific reason codes (used with reason set 1) */
+#define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
+#define GHCB_TERM_PSC			1	/* Page State Change failure */
+#define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 14198075ff8b..de0e7e6c52b8 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -24,7 +24,7 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int reason)
+static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -32,7 +32,7 @@ static void __noreturn sev_es_terminate(unsigned int reason)
 	 * Tell the hypervisor what went wrong - only reason-set 0 is
 	 * currently supported.
 	 */
-	val |= GHCB_SEV_TERM_REASON(0, reason);
+	val |= GHCB_SEV_TERM_REASON(set, reason);
 
 	/* Request Guest Termination from Hypvervisor */
 	sev_es_wr_ghcb_msr(val);
@@ -207,7 +207,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 460717e3f72d..77a754365ba9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1383,7 +1383,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1416,7 +1416,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.17.1

