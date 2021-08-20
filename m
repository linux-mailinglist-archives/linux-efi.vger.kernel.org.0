Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76463F2F27
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbhHTPXg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:36 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:31073
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241293AbhHTPWp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPuBty+QUf/opknLzZpqEyr3zpP1KkDKZ9wRBGOGy/0Sk0z9fDfV6ADoeYNarVVEpM0CaW1ScHd4xdNBSXBPTiyixsXHQFOqavtrtKmMRfCAV7whnY7vxcSPgAQ2qMeM3t+6txOEv71cVGuBAcPCsWz+dGaJ6CLoDEDU4NuBK1qJuY3uJv48zkX9uAYuEhNvEEt86n1I0Bz2PjvknHWGlgt3KFRuqrk1DIdCrLmYMagfVvZtFV3nWcQB+1kPKDTRekrBo4T6MyPCUlCpnTpVbUTzDVi3S1IeNv+tx0PrW/SI66jVRgLRuuH8LkQzs9f5E2TSvHWtykCyYQ/SvxHTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/+bHTo94EVVINGI1AA9OmGjpus5VFiLwPvPo3mcMXQ=;
 b=NfRz/jkBI6YEMEcjUzg45MLaNW7/BP685MsCri7YZJwYYHhyFLueP1Rpgxa7b/QvMqzBQHbyQnxcBfA6H9aE7CHCRYlCQjlLvXzYNsFxMefBPnuYHqWDV3H6zNWB6wMjry/OQHgLeNx72LFGF/M7Xfaenz67eGs/5zGCL1N0RTVZoz3QcaCPAx5IOWjKdv8Iy/9BvihbC71l0c0IqKQ2v+4nnFffHw/LPBiUF45u3WctLwx7PAFCGdDt/pLcY2E9G5Ctj+eSRhjPuYyaItMYFme/9NRP/aBOIUZHxxsWSWY8qPuQ2NiDfxcQ+Q+OJSPu3pRMrZ3GhECsRTcnPUSH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/+bHTo94EVVINGI1AA9OmGjpus5VFiLwPvPo3mcMXQ=;
 b=nGauTfhDo2gdmyPtyQzu5+P/W+Jo8gj0s1LmC94IaQCxJ3s9KQtFQ2PkDTESlKSM0rlUcIIAFCOXiB4Njn1WQjBEeS3dN/+F3XMQhKleWLMkpaAL3i4t6Qa90aHrw3vbcq780H2hH6QX50oGde6qpJYcjlpN3fFdbdaMRt81eao=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Fri, 20 Aug
 2021 15:22:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:22:00 +0000
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
Subject: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
Date:   Fri, 20 Aug 2021 10:19:29 -0500
Message-Id: <20210820151933.22401-35-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a9fb13-c8b9-4cea-8b0f-08d963ee3088
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2637E4BF8ADDC07B54918136E5C19@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TycLKnsnCjYjK31Z873lPi1LDMvTkrfsbSq25mQjVeYJ/hv/hkaIcBdZgYMtm38A5OLvL9pJls6Rj1WFjhV1HqYS1h5ynmfvJuf4f+3UZ/MBTiRkKoeuJHi1CRnfu1I+77Clymn1t73Ns0IYOkl/ljlCr7BQxuUgQZ8A/J84dE3ANRoSx96n2xJ88sXh+fRGwsTYCV8w8QkWgnC1iT5sfsGryVm7dhx3qzsZAlobRY0cYpeIHFoOLQo4pvLmsNLZsyDONx7avo+GEVYRgDjgKLJQ1Blm5Sgp2NxYESQctZLjg4ntTkDWxWpkBoI0EfdXC0zeNEdhQnr7VYQxe7pqw1rl+dHWGMwRDwrYLvrUkOBMrOZwCk6Vz6p096EPdF0iH3VrM6HQnj0dFYlBBC6FF0Vywlhs0qd7hIDQGwxRQ1yi2VCYNajOkO7pxufGO5x0oVAqxMbNQRmV4Ecme9tlY0rhB3TnLzrQOPCMtfykrdjxpl3LookBuCrDQFmUTrMNszih/PtapaflVpn2nm6VVA+ezSaNpaHuB5KllA7VELPiAVVTyVIDr/AOK/N8zIY7lKcLrFFtkP6h/8TjIzyIKYc55nD0uVgjgcXGXR+WUfj31zrbAcejzuZp+tkkNTJnJj466WbUJMkgrukknvwPvo0hj3F+1gG7LCCvSa7d9CMxoUBesRH+djqM413WhETyISrn/GxTKW5zdR/4xULHBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(36756003)(956004)(8936002)(2906002)(4326008)(52116002)(8676002)(83380400001)(2616005)(26005)(86362001)(7416002)(7406005)(186003)(66476007)(44832011)(38100700002)(54906003)(5660300002)(7696005)(38350700002)(1076003)(316002)(6486002)(66946007)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QapVGBRQ9/8Kjy5pN2tNvrAE27q4BVH6/w/SDooAT4kkmNOMSrOAlNv0qquk?=
 =?us-ascii?Q?DUwGK3pblTLI3ZbPfAAGTGBhhkGMLUnCwPGUpHZnR4NgyTHg+JcTLRpXDjKM?=
 =?us-ascii?Q?Q2RzRyjzEaVIYLNAJJjT+DUo6Hm8iaYMuss0outWgr8dkYi2wwLM014MO/HH?=
 =?us-ascii?Q?4Uf7Ha7gJkw7zKVUN2tPwUoWc6ySFQYn0CkXxo8v+15t2L3Mev+KqQJ8qAoj?=
 =?us-ascii?Q?Axql+NtMDn/3JfsWtU7aIW4SL3MWKdCDnYDYzMJHgjM0UxPjIbF2TAYjLew8?=
 =?us-ascii?Q?dWLIOnnPTHk0SVHZC6KqYYOgTk1pJoFuGusXRX+35+Qe4wCACC5I+23e6UGi?=
 =?us-ascii?Q?/b4KZw87NEK1GdncJQedtvAG/5Pqy1FI9uG7fTKrXb81HTPTNyil2eF4NPxD?=
 =?us-ascii?Q?IU4lq1JQowNFJNc7psMvC+aEnl8XXoFYO9Dd58g4qv6VPj8mrpa3ExJVuk0A?=
 =?us-ascii?Q?lqaum6EEVsjoTq7QSxPp/cOMv3aEufiDw+xaGk8pktSkb44eHR6dAmS31Ge0?=
 =?us-ascii?Q?PriS2Acl2ZXCz6rD6pLZKjsMstAl1CvMXDun10MyE/vmwxenlZDUjg+6nJJY?=
 =?us-ascii?Q?cW3j1yMPw7Lg6yX/n7GnLQayVy0SmKuzAxeZ5mV2t6dTdRftLrEwZiAm4t4Z?=
 =?us-ascii?Q?k3fbfFWjXHcZS/42dlF1ufQRshDPTF738NC0H4aV105rc3ALRCCovbNBdyuA?=
 =?us-ascii?Q?LOYBCvnHkMgUi4RCzDRchEaaf7868Ckj/vAemaL7Jf1pk53/DLxp+h2MiFnn?=
 =?us-ascii?Q?/O+mOOq+PFlX45sgQpcn/WfLAxOqo/3Wadwv7Vtv+qNTS4Rrit2FnC5DV2Eu?=
 =?us-ascii?Q?PjiOn8LUevl2mnX4wFNJXvCkvfYWj34Uo2hrjSq+t16/tf3ve3wimhPJlU0L?=
 =?us-ascii?Q?zyCXaspe4eLSKKSQv0nd0LAMGDg0h5k6YFDeo/3JeL86m1K4ycxIhC1QkW8W?=
 =?us-ascii?Q?wf4b564bwgQVjkqc8uhaasoQUdJ1UxE85plt64wUg1lurNoxnauF8DEtz54M?=
 =?us-ascii?Q?rgD2/3lmFm2lUKOAs+pDHSd2CUEK9//GQuvuhU3crP9FzZA+WfQA8q/NDGPS?=
 =?us-ascii?Q?1NU7b4f1kwp5CHBQFz3To9ZFSC9cR5omHevhMr6o5dZel9WbW9UZFM8GNKaT?=
 =?us-ascii?Q?f25rml3lFCtupezdmZwIBMHtr5dPKRYKx3/9ssGyx3ZLb7cdW7Eq2+JOuLVP?=
 =?us-ascii?Q?Nc7ZWbdj30G2mqDw6fB6QIgTndCTfAeBgEfpZPEjk1CYdunsDUVpcQwJvsUS?=
 =?us-ascii?Q?yiZPT9WHLgVlFgDRvCRojretRpDUTEPx5+DVBtZs7ybsTN7JQpHxbhOky4Gq?=
 =?us-ascii?Q?hRUJlqEAwvTsep6g15AQTbOs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a9fb13-c8b9-4cea-8b0f-08d963ee3088
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:31.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHeRh0fpplqu0oiDL/wnPDaNA3qClCfrOuyyrjh0cAarQF3jtJBk9Fx1rCYj81phl0L0JOlT3lEc9cuFryg+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SNP guest request message header contains a message count. The
message count is used while building the IV. The PSP firmware increments
the message count by 1, and expects that next message will be using the
incremented count. The snp_msg_seqno() helper will be used by driver to
get the message sequence counter used in the request message header,
and it will be automatically incremented after the request is successful.
The incremented value is saved in the secrets page so that the kexec'ed
kernel knows from where to begin.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
 include/linux/sev-guest.h | 37 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 319a40fc57ce..f42cd5a8e7bb 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+static u64 snp_secrets_phys;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -2030,6 +2032,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 		halt();
 }
 
+static struct snp_secrets_page_layout *snp_map_secrets_page(void)
+{
+	u16 __iomem *secrets;
+
+	if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
+		return NULL;
+
+	secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
+	if (!secrets)
+		return NULL;
+
+	return (struct snp_secrets_page_layout *)secrets;
+}
+
+static inline u64 snp_read_msg_seqno(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 count;
+
+	layout = snp_map_secrets_page();
+	if (!layout)
+		return 0;
+
+	/* Read the current message sequence counter from secrets pages */
+	count = readl(&layout->os_area.msg_seqno_0);
+
+	iounmap(layout);
+
+	/* The sequence counter must begin with 1 */
+	if (!count)
+		return 1;
+
+	return count + 1;
+}
+
+u64 snp_msg_seqno(void)
+{
+	u64 count = snp_read_msg_seqno();
+
+	if (unlikely(!count))
+		return 0;
+
+	/*
+	 * The message sequence counter for the SNP guest request is a
+	 * 64-bit value but the version 2 of GHCB specification defines a
+	 * 32-bit storage for the it.
+	 */
+	if (count >= UINT_MAX)
+		return 0;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(snp_msg_seqno);
+
+static void snp_gen_msg_seqno(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 count;
+
+	layout = snp_map_secrets_page();
+	if (!layout)
+		return;
+
+	/*
+	 * The counter is also incremented by the PSP, so increment it by 2
+	 * and save in secrets page.
+	 */
+	count = readl(&layout->os_area.msg_seqno_0);
+	count += 2;
+
+	writel(count, &layout->os_area.msg_seqno_0);
+	iounmap(layout);
+}
+
 int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
 {
 	struct ghcb_state state;
@@ -2077,6 +2153,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
 		ret = -EIO;
 	}
 
+	/* The command was successful, increment the sequence counter */
+	snp_gen_msg_seqno();
+
 e_put:
 	__sev_put_ghcb(&state);
 e_restore_irq:
diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
index 24dd17507789..16b6af24fda7 100644
--- a/include/linux/sev-guest.h
+++ b/include/linux/sev-guest.h
@@ -20,6 +20,41 @@ enum vmgexit_type {
 	GUEST_REQUEST_MAX
 };
 
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPCK.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec for secrets page format */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imien	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
 /*
  * The error code when the data_npages is too small. The error code
  * is defined in the GHCB specification.
@@ -36,6 +71,7 @@ struct snp_guest_request_data {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
 			    unsigned long *fw_err);
+u64 snp_msg_seqno(void);
 #else
 
 static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
@@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
 {
 	return -ENODEV;
 }
+static inline u64 snp_msg_seqno(void) { return 0; }
 
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 #endif /* __LINUX_SEV_GUEST_H__ */
-- 
2.17.1

