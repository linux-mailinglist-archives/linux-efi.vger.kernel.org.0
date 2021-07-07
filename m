Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44153BEE25
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhGGSTc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:32 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:41568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231489AbhGGSTU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1HfDtf/r9QcYP0qt9T/NIUoI44npi2AbIPphWQkynxv+wIvDTbQWZTIIbkLE671mWquSWYZ9/K5Rw8Ch+hL4v0nBADxvjYBcgX5e+olpGZ+y2kBcuqH7YdyDba781MRYjoKrC5tJHmJwI50hOOUl7A7qUhfVIz0+G5p9EoCVKh+MNsd03dar9axWoKIfc06zeXbCOIvD1L8U6BRD2tCSlWI7RhCItYlei4FuOEtOiJ+g3255/jOYXAOxT9Nyv1CRn/xk2FX6i0e7ABDtKg63btPTrflTY3gVybpB8cRFJOulkdjWRJ67pb6ys+CZbiGlZXkDz5pXHkojCdOaExmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2UEm+g7vGiRO+IwbGeOaepODcTaS5c1f0WvKtelg/8=;
 b=K7RWYnkl2FsmNyBw37U/3Sc7IIZkyaE/o3iv0yQ7jcDTD0SCb46ElCt7kTD/SIZFO0PLxjrlTnwYa56WB7lXi5EFnIHQPE5ofXz30cFGHitqoWyuNN36g4qZCLt8CMCvXEtwecUoT5lwwgQUybyAFvYa7CiuDJ6yW9GQ3XDNFYlo/Mzwb24ehnwX/krVnoPmagXGFL/SqPca/r+aqGqrL5RfgY/r14c1X9a1HoYduOXlqNkY5A/TqXXqaOygcWYMFgskbzP8i0efUBY8r5teZNqGqA4XYsg9o+0xMLUsA9T/lI67o78DIW8EAKcko4z2h+dA3ulqS89ic3B4Qr/Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2UEm+g7vGiRO+IwbGeOaepODcTaS5c1f0WvKtelg/8=;
 b=ZZRIudS7O7mWO+/x4vuc/ZWw8dAnV+5aGLpqk2Vf5gIzTwY9qAX4HpX14wsVktYm5RiFl3XWvLG2AMoviuOL3biFUBk879CL1PsQP8WEJXyo/wkIBHIKBnWp5EmTnn+NtLsif2pYO9xPw/Uadbge4rWYHdBH/EGyq9m5Mem2Rpo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:13 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:13 +0000
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
Subject: [PATCH Part1 RFC v4 18/36] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Wed,  7 Jul 2021 13:14:48 -0500
Message-Id: <20210707181506.30489-19-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1e99b7-ed0b-4902-e95a-08d941734db7
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016AE673506062085A6F5D6E51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IY67mWT85vMMeoTFmGl2HXUxpV0peO6/0IgihhmnJiMjAr63egtE3YFb0AtbY6K1AVd4rroKIsADqtXJG+55S6o/6s33qn3UJJQgu9laW+k5wXjLj3o35toQLaS3a+AKy7vuHuwLnOTV4DI70oOtHyddPJSIKsPdgU1cm5uJgbSf4fyNUHkYh50q20Ozirb+OQsuZWgtaWzckI47kaSxup68ThkEREmA2WK/ElFohN4RDTliDh76GQr86gX5Sm/7YHCDliFpZR7zNDK5hJv8eru32tzueTxb9dKXc/ym/aUDJKfmO5TeeDaoyIKBwDty1q0ok7SES6JGH+F9i2wuYDHroa/v22TFACSY90/xrxXPOa3izlx7ZGE98MuniID5m5F8S2LEj+aT3VxBWjDqVttqtiU8eKiOSFnZD7niwDpOXv70bT25/1tkBc8dDXBRLnsT9zTZ4010C1M0Gekz0aVCan/r92MUYWI0oSivOeTeehhghiwfrmdGcuF1eOpKQ60y/lHtBAn9pWCHQ9NI+hgqlU9c+zxft51SVdOfOSlQVCshC+ZFRQyZiNPcOKdhzGSHOgDd5/SuuPj9PWk8zRJH8VPcPN0ij8zu82JFJNWWk4aQC6/dG2b7hj5FOXSQFxQIc1dkN4kSYxEUbbK9z2V9ibAHZAqeO+pTHYGs/Q/+qc4XYvtik/oG92LEtkQ+G26w6kH5JEx4lWaslbWmKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJELrMwPCjJ6sadsuDNX1nbKPjuUMGfup7LXVwEMZHEbhK150KIP3yqy3DTc?=
 =?us-ascii?Q?MSecrWQ8qzt9bLVc8KKXFiQBvvRwl29zXrj/ERrBiBkrb1lZ0jGTTG6s63+W?=
 =?us-ascii?Q?/1VxrjeoIsE8Fh5rtM4X4AjC/a3fT26i1Sz4lfI28SijpaDkiGMvTF3dPKnx?=
 =?us-ascii?Q?Wh1BNop4h2PdmaKuJ9eoH2FhXzurJNuYh4YR5jqf490CXkbvutH6QB25lxky?=
 =?us-ascii?Q?ZRJkswXbMvldCp5nT1kQ7B+yJf2OH30m8xZ/lE9ypm9cfmXLA/ZfyE0ZQxxR?=
 =?us-ascii?Q?lsupnPHRKGXZqpb77THY4iNnmZYnzMMhXSkjhTi6w28ja6MR3RSg3MU/PnWu?=
 =?us-ascii?Q?bWhRuWFtl0EHnEMT57bHdoAhbSmQMcG7TE+e7VELzWpcmlfTySpc09PTKd6u?=
 =?us-ascii?Q?efuWygIGveYjanqsya9ujv7oD9Idzh/IcWpLdKsMlEPUErpFe1/juQp4jLvv?=
 =?us-ascii?Q?Ys4Qo0ZiztxG2aYhcrrQfC/pzZfW+8ciIgzVPe2StXDTzIRiMGa9TqlqGhLv?=
 =?us-ascii?Q?DBY0161SXgi3GIgZjMUSTPW6bviRfVMaNUsQOZd09zGk994/7HB5nrqvGOAg?=
 =?us-ascii?Q?fv5BsdcUzUfB1AIzi5x7rYYW+J6x9JjF2SZWXC5OUgDmDAJwliXNeJKlsvCr?=
 =?us-ascii?Q?f/57C39kGshSE7xjBSx9Leig5DWZLWrBprGZdTUWx3YZ/gROVymhsu2qg1YV?=
 =?us-ascii?Q?r0YFH2HZdRHzEakyeEQdRnkHjjzSoRJDo0HA7Pez4pxqRF54BUmkQtZtSCh+?=
 =?us-ascii?Q?kaBkbwRqSvwnHXJQhn37YhP8ULriCA0Ftg3lOXbvf1nJOFnq6cnRbYCJ7851?=
 =?us-ascii?Q?h7n+2u0jV5W8bSufKHJztFEZ9e9bTl7hwXV5D/ms88X/cuH5Jz3n5cN3ZilJ?=
 =?us-ascii?Q?/eo030Ue19xTTX6ONNAv67q++mgqgqo9lLxO/vXdYPnx2ag22Pv2Vyuhk9yD?=
 =?us-ascii?Q?YCP0dyls05Syvx5icg8M4SpqzEguCiKZsFsl1Ouv/RlAgkTc/3ECd3zoW7Qe?=
 =?us-ascii?Q?Fz/XT0ozMj+gpG/KUlPzoVk/aFJ/s4Ou00+L1JSMDkrR5/NKLx2sMixeNdwU?=
 =?us-ascii?Q?LkqdiL9xj+5LaYID0lXMMIWIIjd+NBS78freVDONzcLh9sZ5lMH/54/Uk82/?=
 =?us-ascii?Q?LnwRYMOWyBTH24Nd6gfg/LTDN/U/lAtZpy0nQMUI69gplIkFR2roVaiehqCb?=
 =?us-ascii?Q?q5ZHbQwqi3TArgb0/F6YRm5jGPLArCqZY07GpvXTankdJq7eNGmBHOrpff4x?=
 =?us-ascii?Q?gzlgsuZTzitAu28x9D4EtxZ8Hop9bOP5Z4Xs6IFn6GTcWa1zzneVNvaXxxue?=
 =?us-ascii?Q?g/tKGHR10/mchwvMUN6/0KLZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1e99b7-ed0b-4902-e95a-08d941734db7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:13.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TLzsh9HK4xmRKIw2p3dSUTM5xObkJaWIQ4lflwhww9JN1DBGKE3frgGDAIJxSXNfzUwlsU+6kbmq6OPBG7JbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
index a7fa24ec8ddf..f679018685b6 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -355,9 +355,49 @@ struct sev_es_save_area {
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
 
@@ -368,6 +408,7 @@ struct ghcb {
 
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		272
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
@@ -375,6 +416,7 @@ struct ghcb {
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
@@ -446,7 +488,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
-- 
2.17.1

