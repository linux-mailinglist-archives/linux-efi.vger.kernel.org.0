Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1B44CC30
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhKJWNn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:43 -0500
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:8737
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233740AbhKJWL5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPnY1EyPOXgjlBkIww3whMI5en20HKCX6F+6Mv9KM6oemvsiXxSc65Gg1UWXnOICNOs9WWfbPD7NmiltmDeOUuX+IBFRpBWdHEkteuOO0l8caE/kT9wmS9ife8SeuO1T5rn4hv7UbIXr9mtfNi6xlqc5ggk/Gb5r4zW/E9sFMu7wkBZ6u2LZFNFqOIbmaAyPGazOlvjCRlUjS+6X1s+VXvloMCc5KItoABA43Y+PuJ+sgsdCXTzyVxH6+tmfZu369A/qdPXB1awTUXJb4BbqCSwtuC8Ve+pJv/P5NUDxF7CLQlE2izg0eegBu9Sc6xjKvTC2LD7oSyGKKbgxy2vC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLNSNcHyQmX3StakwtCH8//iywpGSA2QTnLkafWlUNs=;
 b=Ud/IURe7TnhHwMQHKYqBmtY832x83Un7vb4LATI7Ec0ZLfmWLIBuntHwYRF0MQv6O96muX7YcIzRBXSe+JpeGnsMKlbg+8F4tw6rPk8bRvLKrwvfz/KcfbYla+sB65bghcEd70Fm9xRw73aXl6CPcXjD2oFAHYXAYOyrbWV7Y0mGrj/pNjFNzbk921S647ikiwQ7eNI96h/y+woJF1UDFcEnG03pZmfuJ7XZXO/nMe5RbJp1LSE2SwrajcDjpgrDM4tYiMUYTHs9+GsYHjUMWhIOsP+IzS14F/0Vz0ySRo9aWwie9z2FnATADcvNtUo3byV2vArOW/lIQtiq+60NPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLNSNcHyQmX3StakwtCH8//iywpGSA2QTnLkafWlUNs=;
 b=0rQHsV+rKekpc1HQj2hFKLZ1KX+0Ev+ELKCOaoa0vlVmKtprI55RKbfBMkDrX9BZcbu+VW65vU5f6yTmMQ2oVYdcCdsq2/xZaHwIQccpJFR3YWuNJ+UAnxrd3LzeYU6tJD70RHiQdUlCg5dlJ07PVrTZnvHdh0MPfavdm/LyfC0=
Received: from DM5PR06CA0087.namprd06.prod.outlook.com (2603:10b6:3:4::25) by
 BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 22:09:01 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::fd) by DM5PR06CA0087.outlook.office365.com
 (2603:10b6:3:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:09:01 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:59 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v7 41/45] x86/sev: Provide support for SNP guest request NAEs
Date:   Wed, 10 Nov 2021 16:07:27 -0600
Message-ID: <20211110220731.2396491-42-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06810cfd-30e5-4971-7239-08d9a496b3c2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3079847337CBB82480E9C8E9E5939@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wio9UdiKAATt9+cWAp4rSQBaRaSwZ0SkqOJGxQepSiZF2TN8vbViZhEgyPkEV6GSBtLPb0yMaDJX2fmqIIRFWM+Y9xIdZkDd6NeMouERcWf6QxunQebUXcHg5rNXRJSWM9eT3ttYA4LWWGQxgyfe6IWspokqGQaJXiMehfl3SLN1sK1y7uY3RL35vFgDZHDu0jEbGZu+F4lxxjVkzDV05h+RDfvbzoZ2r7b0b+ZCNKxlcsPuvnofSHRfQ5kiY9SqhDmHem9HfwyLYrKM+J2y3WFyacbSUEwGL0oIf5+JNirourUT3vvCUa84CEAqeTd7YxBhahnYBYNFJcor6C8RghKxAFjNDBBXhxUhWWPcsmy/6TkuQNDvQ8XktjeK3m9j2Xdy8H5LF057rukYpxEeIzsa/QLekJK/HBfD6k6dAFho36bDETFe/0gxlog6KsCIxbxdlP/K3QnabvCqvcSMJRd+CjpqWwohufO9MAcSoF2R0Aoutm7QBiqqVsEKCNN7/vqyUz4xvqPe7x+NXDnT4Dx5efZcy0Ui+t4k1Bat6X/EcTFBcqp1fMcJlTVJqZtbuCA6YmB5YLflf7+VKakx/L003WAZslJOlrguVzxoQYt/QK5J3p78QRWBGhk2rrqvZkcLgY/F/+fW1w0CEW4WBg8m4gpG4dbe7vfqxN5oDQHtFVEU1rM4XU8N5/3r4HXgrK3WYG9nmYs5lw50YU7vSYHaecx13V2em2MvFGHFS9oKe7UYmZW6/Caw1lFw+OzF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(7696005)(5660300002)(186003)(4326008)(83380400001)(70586007)(1076003)(86362001)(16526019)(8676002)(54906003)(508600001)(2616005)(82310400003)(81166007)(356005)(110136005)(336012)(7416002)(47076005)(36860700001)(44832011)(36756003)(6666004)(70206006)(26005)(7406005)(8936002)(426003)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:09:01.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06810cfd-30e5-4971-7239-08d9a496b3c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
with the PSP.

While at it, add a snp_issue_guest_request() helper that can be used by
driver or other subsystem to issue the request to PSP.

See SEV-SNP and GHCB spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  3 ++
 arch/x86/include/asm/sev.h        | 14 +++++++++
 arch/x86/include/uapi/asm/svm.h   |  4 +++
 arch/x86/kernel/sev.c             | 51 +++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 45c535eb75f1..cf66600b1c68 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,6 +128,9 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
+/* Guest message request error code */
+#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 76a208fd451b..a47fa0f2547e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -81,6 +81,14 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
+/* SNP Guest message request */
+struct snp_req_data {
+	unsigned long req_gpa;
+	unsigned long resp_gpa;
+	unsigned long data_gpa;
+	unsigned int data_npages;
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -148,6 +156,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -167,6 +176,11 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
+					  unsigned long *fw_err)
+{
+	return -ENOTTY;
+}
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 8b4c57baec52..5b8bc2b65a5e 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,8 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_GUEST_REQUEST		0x80000011
+#define SVM_VMGEXIT_EXT_GUEST_REQUEST		0x80000012
 #define SVM_VMGEXIT_AP_CREATION			0x80000013
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
@@ -225,6 +227,8 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_GUEST_REQUEST,		"vmgexit_guest_request" }, \
+	{ SVM_VMGEXIT_EXT_GUEST_REQUEST,	"vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 5d17f665124a..0faf8d749d48 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2112,3 +2112,54 @@ static int __init snp_cpuid_check_status(void)
 }
 
 arch_initcall(snp_cpuid_check_status);
+
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return -ENODEV;
+
+	/* __sev_get_ghcb() need to run with IRQs disabled because it using per-cpu GHCB */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (!ghcb) {
+		ret = -EIO;
+		goto e_restore_irq;
+	}
+
+	vc_ghcb_invalidate(ghcb);
+
+	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
+		ghcb_set_rax(ghcb, input->data_gpa);
+		ghcb_set_rbx(ghcb, input->data_npages);
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, true, NULL, exit_code, input->req_gpa, input->resp_gpa);
+	if (ret)
+		goto e_put;
+
+	if (ghcb->save.sw_exit_info_2) {
+		/* Number of expected pages are returned in RBX */
+		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
+		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
+			input->data_npages = ghcb_get_rbx(ghcb);
+
+		if (fw_err)
+			*fw_err = ghcb->save.sw_exit_info_2;
+
+		ret = -EIO;
+	}
+
+e_put:
+	__sev_put_ghcb(&state);
+e_restore_irq:
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_guest_request);
-- 
2.25.1

