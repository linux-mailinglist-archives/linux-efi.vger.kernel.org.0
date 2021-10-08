Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA41F427027
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbhJHSIW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:22 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:7932
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241072AbhJHSHv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB9Auqcrhgb7JCeGiUNFiCIucbGFwldZIaYeFwU/4ykyF2+rLPyAcGWPWOBfs7i7ZIkyjkGRIL16snTwi3swBpIJNffCr8Z9LX6KOMXgvEFA8hJUwr9CWEuoD6O2JV7z3Ud0SOpkdL1lIzBa25kbNeANH6kbwY6hiFOL4UgL1FZrm/Up04F53r56yKiwpXXyU/YsmagmxJH0ziv4v/+7QXJdcx/H2b52m2I9MDHDpmtMyBXvnnKzLe7/8ayDYU1gIDYlwrXQnOFMnmfCtwsUDJqvtGDgrQxCYV/t96B7GSDCUy6bEgW4zzaaY4DBLk10eWywHqq8HT5fpYM1KDR4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezeScwAExfss+B30zK2SpLkAtXrXs7MwtvPe1Myqw6M=;
 b=TJOOcvxULSp1QoFjYuQ/uxydDzMZp85ISE5R1ckYQ9HBFp+DIeRwKUh63+gLl5QyrWnlP2JhufIDktS82ZGTygMUaWNMXiGDb5y8Kvxd14lX07Y1rKtk2wVuXoScY9G0gT6qFqyrXA0RVBR7299Mw2i04OR+d0WG3qYxLbMQuL5sbuAMXIBZN5f3ymP+oqhYKepSfARhNqJNpgOi6k4EnQA2dTk3nXJSEYs6O5A1N822RKUcq26oCI8V0DwHP7O7hl/pVAxFm+yPe9bc0kxxeZObMlsqFPj8Ll29QMKStXNbrnB86DkZgkTWU1NiDTYzSyKqXVCnzVyNCJepBMD6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezeScwAExfss+B30zK2SpLkAtXrXs7MwtvPe1Myqw6M=;
 b=gIe0RU6ZIZY6cfd1ZEia1z+rGSS2MrGChBQh3CjUMfKHXWqW0vhHOrfjDZjYiRgchh6hkvTmCYzaW+97W7oxO+VlJVxb1+tJ7hmXPp1/XBi0K1hfQ79f46PbF23NJ406Tja9qMWH8kb2OYsZ2fHS9HOykMpG8ztS/v8LwTThu7A=
Received: from MWHPR22CA0041.namprd22.prod.outlook.com (2603:10b6:300:69::27)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 18:05:52 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::46) by MWHPR22CA0041.outlook.office365.com
 (2603:10b6:300:69::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:51 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:47 -0500
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
Subject: [PATCH v6 22/42] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Fri, 8 Oct 2021 13:04:33 -0500
Message-ID: <20211008180453.462291-23-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96db19f3-0c7a-41a8-72f9-08d98a864386
X-MS-TrafficTypeDiagnostic: CH2PR12MB4937:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4937539DDC709A648235A738E5B29@CH2PR12MB4937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftWy88xQ7tmCWZFMyQQSZKMQdSZwEH9ZGO5D7rHstWiwhOeP/PLyxpy9615qqqI/yIrU/cFlBRT1dC98uynXWJ/tMmSxBcaXOecJ5VfuW1R0RiZ/NQDFliieq44CAULlD2GZxi9gwGa5hlLZzU5nPm5oO0BSHWokVRFxpqn1oOGX/y5/KIVnPsbkVBd1xOWO1Iwycq6w/g89YVlB3QkUSfcMhJR5Il9xcMX38bcIo/WRug7OfhKuQlviykgTkAunKmvzgQ/QJMVu3oy4ndvvCi8RU8Zfa9IdHzNrXWV+xko9nqHDvsNumOQe1EGPbhqxb2mggRtwN84AU9AKhD+4wORoJ1FSUOQvQBCup+9JFvKoh+VkiU3wgN1aGeNeu6NDawLZqfRqjrJmdyGHr9fYV9UD/cFpvfB2Iid3SeGwg9dJHjTzAvy6FYTzBpuU3ape2hlDxJRyiULpvbFMOwzA0boRgl+fB1+4n8qXs5KlLuxPQ809YUO0MucWfZtyWsXykbc/X3Co/Q3UZp6xApMVbcj7SfJWvt3vfu2Z3/h6kGUPURuDHwMySQ+xY7ENe5BzOvGiM0PkJpLYa5MSD3ELN7e2umO/3cO/cFu5N/WLgsJg0i6i+a/s+knmeaBaOhNbO3Ow42b0JdELU5MM+CIvw6GdOz81suRhgyYMljETpGROl9InDm+L6lkI7P3wy44c6t2tzrTZutftPGafy/G/I9Lp0fu3Gw8lLBMT2kH0VNvNrxgKF5+ilTfi12sVO01p
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(110136005)(54906003)(7406005)(1076003)(16526019)(7416002)(7696005)(70206006)(26005)(8936002)(356005)(2906002)(70586007)(81166007)(6666004)(4326008)(44832011)(83380400001)(426003)(5660300002)(508600001)(316002)(2616005)(86362001)(336012)(8676002)(36860700001)(47076005)(36756003)(82310400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:51.1122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96db19f3-0c7a-41a8-72f9-08d98a864386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

The initial implementation of the GHCB spec was based on trying to keep
the register state offsets the same relative to the VM save area. However,
the save area for SEV-ES has changed within the hardware causing the
relation between the SEV-ES save area to change relative to the GHCB save
area.

This is the second step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Create a GHCB save area that matches the GHCB specification.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 48 +++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 0df489a70945..4a4de2454ca3 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -354,9 +354,49 @@ struct sev_es_save_area {
 	u64 x87_state_gpa;
 } __packed;
 
+struct ghcb_save_area {
+	u8 reserved_1[203];
+	u8 cpl;
+	u8 reserved_2[116];
+	u64 xss;
+	u8 reserved_3[24];
+	u64 dr7;
+	u8 reserved_4[16];
+	u64 rip;
+	u8 reserved_5[88];
+	u64 rsp;
+	u8 reserved_6[24];
+	u64 rax;
+	u8 reserved_7[264];
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u8 reserved_8[8];
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_9[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u8 reserved_10[56];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
+} __packed;
+
 struct ghcb {
-	struct sev_es_save_area save;
-	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
+	struct ghcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct ghcb_save_area)];
 
 	u8 shared_buffer[2032];
 
@@ -367,6 +407,7 @@ struct ghcb {
 
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
@@ -374,6 +415,7 @@ struct ghcb {
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
@@ -444,7 +486,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
-- 
2.25.1

