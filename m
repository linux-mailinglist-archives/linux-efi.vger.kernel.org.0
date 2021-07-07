Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED523BEE1D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhGGST3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:29 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:45792
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231643AbhGGSTR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF/lgwCRw3TZc+NKvIZYNxgVY7AN9dcGoGXwK+jLI8OxbYumUD/K3xRszTQKEtrY5Q0vEoIqHygteCnzgnHCEtBdhtgrUfdoWMwURSMcafdu8UXZLl8n1ZaezpaNvi7G3rE1Ey9WGQgIKoHAEZhkCtdflkYsmCVfk1MUoSHoWkEbzNNhFCy/N6jaOetmKHGGQNwideIztehOGwrMO13o9gX83LbzwbIJiWOQyfCXgkvqUy+OKn1xeZEmhPRZv6MzlQCo5QfYiD2mQJk7J9roMiR2QvTjerES9vBpg6rhQL5Fuk5kIO35uiH5fG54lN6A+QCJe0LnquQIP141X7lm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiUqerpB9vjzA1VWp+uR5Yl+kyR8h9OKCLWLo/DJvek=;
 b=Bj5FGSWSWV/VuD6b68SMLUJ5SltR8mD6Ub6XzlRRaUAQY4j2qshUR8cf4ArE2N8Nn2Q7TbN7bX/E2+7LNOr5G/gziRh8hEzaMFFeAq36q4rE8+nL07/N7kKsCywnuEKCNgu3BJ/+NvVJiWGRx2+08aTXbPf6fEX+bKkEaO4PNms5AbAKumAPXzxIoBrPTapuP/yzU8UhJppEv1/si6D0bmKFvuuPDQAVq7o0Whcd3WfTSwrFX2M+/no61DelABW9coQTmY5l0E2TTKZgLW8PNpKt2iasz2qpTZzYTM4dt1g/U6Qgf/z5wDT+/gD1RdMdAXay34m9hMihb9Nq1rOJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiUqerpB9vjzA1VWp+uR5Yl+kyR8h9OKCLWLo/DJvek=;
 b=dWWovH9GBQMrAiIOwaCL7qorkuYuPLFa+fcEHy6jCRrdxzwj70upBkeWv2KW0djoWwCf2ztrj+i71g8JAL3exkKvjasiHhLj2w+lOidATwbt1qaAx+bNdTDwkTom84DPWNIooFuNJZ9z31G70WQBIscMrdaivRVJCzEIndAU2Kg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:33 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:32 +0000
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
Subject: [PATCH Part1 RFC v4 25/36] x86/boot: Add Confidential Computing type to setup_data
Date:   Wed,  7 Jul 2021 13:14:55 -0500
Message-Id: <20210707181506.30489-26-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52d29a9f-0353-4d48-64e1-08d941735953
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3683D90852A49ECDFACCFC59E51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyW23MbKhxUc6nBezNiwIm6LFU0etLhpU0ol1CjPOxyKJWUS4ao7MmBXAcBx7HzxUpj/zj4jFvEKf0P1B0Q2fEULyfsgCCxul9vUmu6TA/YZ0QyfTATtQHnNAaGJ7f8tRkaRlrO6t3cb0zvTonIb+Uqet5mwa2/TeynL/rxiSeEMBbsZ2vMAqYLmrH+fY3p1bAiFkXxsQaY9tp5wx2ELI92CgfNoMjlvMtxkLDtDTMou8JF5MJ40nkpbRtviwLs8eNQqLLL0CZzGA3KQCWoHRLRAWe96i0LLdj8I472qVUUf+fkQ3SyypIvGKVzp02yurQU6CKr8Y3TLFDBZWGQ0yOV0aSOtF/k8at7aySEnj5KLYdQffQpvavDEy11ou1eSI+t/A/oX3emdugxG0bLYxbqZzup54rGQwOgwxSoNqGvOPUsG6Zh0aonlDS3t6v2WgsmcHnXv9oxJTGxeRafk+1qD/DwIlmOUUvNwYtgNntONDAUsnZR346OIsD9aJDFvWo7QGeVGOTVPmHL99bYbntjKqEvBJyEe7iOZ3GO5mQQ/GOGgcK7txRf5VZYc06E/NFOfyO1qpVHlq6z5WZjUA17x5sP3rzni5BtvFvpwxd+DkRvDfQwjI4tx//BjxbI433dHzp1KyPC8AXqz8pu2LK4eALP+wKSZP76CBfmnbfQt2X254f2ZixE+RxG3iarpjbCQy/n43FEOp2bvV8CCOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HEAOp9HCNFe5cDkdM2bbRFcacJDzNKREs/9inZO2XYpJAENATJu8V4Mp3IIx?=
 =?us-ascii?Q?VJJXct+0v+BO080/vEvoRvGvsTXpkltIyjwn3DXvGOBXvKqiWxjE0oKFyBDQ?=
 =?us-ascii?Q?oRQB0YxiuRKv5LWPC8Jn18AI8JyjI5QqWYL6LEg2/KDvhvbNIju5UqKor9wI?=
 =?us-ascii?Q?2FTN8VDPEsibUZ389Lq2FQGWZAihIxLDbJcI01Tn1McCSVLUAhycEalqtYLM?=
 =?us-ascii?Q?W4KNkjEY0yHEvq6CY+QglmGXTzDrMF9WaXYqh42X72NdlR+3TEEMowMn4YFM?=
 =?us-ascii?Q?ax8nByrC/NI1kdl2Q/+0965SMEX/0gdOKa9s+ieSW+dOSMOfi92uikQbg7ok?=
 =?us-ascii?Q?wEG8LMLklwh+A113tWvKXF6RqYZ0nIn/ikq2XtfXpBSWH3eXYvUAF8e196Gh?=
 =?us-ascii?Q?Co/35MbuA54r2T+LvECOyiq1XN0iNSXVGDLRlM1Pz8yXSIQsabMceEygLChq?=
 =?us-ascii?Q?DAzUADjWrWzxPJtWxTqqNRRPStcvEX485hCuuR8PJEKJNgTpO58Mk492shMQ?=
 =?us-ascii?Q?rX62IMaztD2+myoWBCVKjPzIm5qrFq2rajmMEnuVtIWD+/sVlPIlmBV87bWs?=
 =?us-ascii?Q?P/xjjTyoxbWfFufXniLHCrN6HMO3kTAzhJwZk5xvXs0txMs+iSb8lNBamDkB?=
 =?us-ascii?Q?Ds1Nf1wJIrlAW3VqT6LYQhOKPXSeFJf7xwsuhU4Xqfg26QqFlxRi9n8werVV?=
 =?us-ascii?Q?bAuk2xidnjju7TDwBrf9L7wz6sJcVL6bmRAMYZ/Ly5sq4W6/s7skWLrl97Ox?=
 =?us-ascii?Q?CLUxl2zHPx6yik/LiqoX6qK9zWTzdPXP7vrmSOldBh66esC5imMtL5GByWQt?=
 =?us-ascii?Q?G3hBVYTMIh73TUf9ovd4JMlHlPDGzxvUPp3/0dDv85uwB09Ytpi/Z4pdlpC0?=
 =?us-ascii?Q?LqP1ud2yvbhWG+is3fssuhJiqd2KFeTJyx+mQ7dp6hebdhu/uMyGSPsO4izn?=
 =?us-ascii?Q?GvMcsfqfihNiHFptXs1GlXpevw3HoKD//Jwj+SflvIYRCff8FE0E31J6HeJj?=
 =?us-ascii?Q?DLiwsUaN3/L4qxGTIECrgQYxoIpDlpy8KD43Lee4KZHL2A9FxAdOZulGUEGL?=
 =?us-ascii?Q?w6pFsvRJsKdM+yVFWJLYqZsZtvAdonksn5oM7bzMqUemUn9dIQ8Zi6sFTohI?=
 =?us-ascii?Q?MVBUFztBSrVHxuN8zqNhOWQAeyFlCrTP49EKg/SJGBPwoqA5W7BPrIc5ijQM?=
 =?us-ascii?Q?dkjv/N/NKsiz2SBWkIAHdyKHYZCvfa1QgHDWEbnsPHLzA6MEKxcSTB/agmtI?=
 =?us-ascii?Q?t0Rm1CZ4PeG4CEhV9rA31vVsubpuwY1I5V/5SvsaLAq5KiGAj2FuVIc2u4fL?=
 =?us-ascii?Q?PKj6aHmU8zOr5X1I/IkRJfaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d29a9f-0353-4d48-64e1-08d941735953
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:32.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwZ9Vikw2AAiJFsspTcYPUiDDdzcwGcH7raiYjCfMkPATyVblQIG7Zfwfltr418KZL92qS1RSTJesDMUAIQBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While launching the encrypted guests, the hypervisor may need to provide
some additional information during the guest boot. When booting under the
EFI based BIOS, the EFI configuration table contains an entry for the
confidential computing blob that contains the required information.

To support booting encrypted guests on non-EFI VM, the hypervisor needs to
pass this additional information to the kernel with a different method.

For this purpose, introduce SETUP_CC_BLOB type in setup_data to hold the
physical address of the confidential computing blob location. The boot
loader or hypervisor may choose to use this method instead of EFI
configuration table. The CC blob location scanning should give preference
to setup_data data over the EFI configuration table.

In AMD SEV-SNP, the CC blob contains the address of the secrets and CPUID
pages. The secrets page includes information such as a VM to PSP
communication key and CPUID page contains PSP filtered CPUID values.
Define the AMD SEV confidential computing blob structure.

While at it, define the EFI GUID for the confidential computing blob.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h            | 12 ++++++++++++
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 include/linux/efi.h                   |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f68c9e2c3851..e41bd55dba5d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -44,6 +44,18 @@ struct es_em_ctxt {
 
 void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
 
+/* AMD SEV Confidential computing blob structure */
+#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
+struct cc_blob_sev_info {
+	u32 magic;
+	u16 version;
+	u16 reserved;
+	u64 secrets_phys;
+	u32 secrets_len;
+	u64 cpuid_phys;
+	u32 cpuid_len;
+};
+
 static inline u64 lower_bits(u64 val, unsigned int bits)
 {
 	u64 mask = (1ULL << bits) - 1;
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b25d3f82c2f3..1ac5acca72ce 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -10,6 +10,7 @@
 #define SETUP_EFI			4
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
+#define SETUP_CC_BLOB			7
 
 #define SETUP_INDIRECT			(1<<31)
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..75aeb2a56888 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -344,6 +344,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
+#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.17.1

