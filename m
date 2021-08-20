Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9183F2F15
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbhHTPW6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:58 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:18017
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241051AbhHTPWV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apVRyn0fK6VtDpQtyZybtenjds7NWgLvjVanmMtVMSg+Y5G8+U1AoBV/hdtljGEEIDJxwQcG/Jnq/cEA5CmTWqpLPAG/CtnOclUunBLUYwDHcK91BqPLIMxMm4xgg7WkgGth7k6OaMVH2ySqPSrVIif6nzLtLAqyRcmQKcJ1rvH+ScVuIZ3mkqe0Cn0OXEMKozFis5Ga2FoZpGBChvZxkl3kcaGuJnO2ZOKgbg+niR6ihEag97Ft8yvnJpoBGfZ3OEv1mJNBjKneJj9BGmQz/7NlJqCaoShAb8dGmg9p/fOz0HrpJ7txLlhdI2MX4nzAxWo+lw0vRZr7uhDtK4JgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g94HUF5z//jEzl5Mw8OJ7CXYsyA5fsqJXW0iW+/UsVw=;
 b=D5qrrZCZL/Brsid9zpLGNe6PN236D385EnOpT4BIl5NN3VCJRBRe/YreMKenbzDHivET47Lftr7kso9H3YF0NPrdSdwSrK5QXwfbEyUiWbAxOifnqkwww7NoTgcYZsmBDdyDYZwBccu9SerKJ4bVHAsksKQmdt9a8TbiJEwoodvNVA+/srPOpF7vDh+tqx/KTTnSAlkPirAT1d3iSuc+FTLCHFRSZU86tBTVn84o3z3lMl530RZEaxuc/WGlgcHcPbkGLJvXIa8yg4Vkvu4lYrQtke8109FH0q43nJURfbVLlHgM9L4w7UnBkjGncjFsUb3RSKjcEDSw2gq9QPLw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g94HUF5z//jEzl5Mw8OJ7CXYsyA5fsqJXW0iW+/UsVw=;
 b=5nVPuLzi/uTJw40UQUMUZKGmAjeH2Df+TC95NDWRiWVm4pM9kWoVZkJ2Qa/k6JyE+nqlFWKzcqiLSohJZZqldqe2kl/ogTHF0oEL8vEXr3Ll+549PZjRpZHTX/hLo1dMM+GmYg3ChmOVYAyTIEoNsnvKIqgnr8ONH7lBH2nOSEM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:22 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:22 +0000
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
Subject: [PATCH Part1 v5 27/38] x86/boot: Add Confidential Computing type to setup_data
Date:   Fri, 20 Aug 2021 10:19:22 -0500
Message-Id: <20210820151933.22401-28-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b34526-d1a9-4fa3-f3b4-08d963ee2b01
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26386CCAC6B778BE7BE83280E5C19@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNo43tdMD6ZuOnZJmU3SVt1aLsDWz9U76p5ZvlvVmBYb1/erXU/eGq3D5DRLUgACVaxuP1arkx2DxfouT3AaK2D3GBB2LNF5X2ELdOzKVl1uYa3L2sUxJqwbCMjHm+kp5wb96uPg1kN697rs2/2RVWpf71HTXuDtawNlrYtVmSTnR6+MnmaLapMvV3XOBO5tUc04nPrXi55egclFN8693jDIona7TvQFcvhDtx9C2PsHuN9iKRrzCt1VGHg1d7oDkjArJzuvJg+xPlWohxbOMm9CUQFC4mjSgZ5Vqn/KY6hvejJ9D5awa81CBzTO7dehzt/3TtrCFIcmlnOFwQ8lO3ucAn8mUPF3WiS24Thh7M4XOJeAShBC9GcexHmDs07p6PpLksQb9DM6GqoWCApO5T4Io6eQN6hC2pHYtj4bfMpvki6Fk28bBK3eNX2dWZYWzWssnFJFs5rNKJiGBijsvp7kGmXsyQoSaIis1ioHqOFHEK5+u1AVxXlPJyXMtSm1mQnQXFLJUOfMixDutSFe5MRlrYnirK05WzVWj3o2vWMleUps3H3tbQV5UDwJ0sBrs6L0jDGEikqNj/WRVYH5/CuZLbVgEyASLez8SC8MbavrrW6WlNWDs0qHKuyt1C9wviCY8qWWOJlFRcVQWQ0zIaZGHYydYM2qe7tX03gYUDXCXWC9GXM8jsbFyEOBXtNe+UyjJ2W1G8SfM87qSYkbIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8676002)(8936002)(86362001)(316002)(54906003)(1076003)(478600001)(2616005)(44832011)(2906002)(4326008)(7406005)(956004)(66556008)(7416002)(66476007)(186003)(66946007)(26005)(5660300002)(36756003)(7696005)(52116002)(38100700002)(6486002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZf+syVFMfOU9/pxzA9QImpBD/sXH/jSwNoGm6N8W9zZU4GsAbeonfL/mAIp?=
 =?us-ascii?Q?BPOh9BnORJZqXgOyGEeUOMVKqElpQpMsrlb2dhccr0vvpFBkK9ZYIEJ0kVMD?=
 =?us-ascii?Q?sKP+ish+xDGIwhUAsV+JZ0t0zqMhlJE7C8nhZhgdgE4Q0G3IjPub3jx5IKA2?=
 =?us-ascii?Q?ikVsUdt0VBOx4j3+twlaBbnimUQZbgizNg3IvLRVTOFXprnjNcqzaT9Z+lQr?=
 =?us-ascii?Q?pcXvg+XTxY7Wwsnqg4TtTMxatnor5l1UWivFqZ4tnt7OYGfGE6Ok0CtHpOkw?=
 =?us-ascii?Q?xhMbfnjgtaW3xr5ABff9FXIN0tukfZYGP6KT/CPedZS/YlLXaercUwVDOwpO?=
 =?us-ascii?Q?EJMpTaNEY2TbMJXXyRud9lVgmAGx1TZZf1eGK3GBx7K+PeqEYNm7KIMtUsCs?=
 =?us-ascii?Q?w3CMaI7+BN6dXn9P9DTYAw6uqirf57O655hoP5bZb51UCEyBOFLcY9pVa5Lo?=
 =?us-ascii?Q?N4Y0V2QoacPUuUWlbpqHBcZcniTZTJ1rF28VKHmX95PCZWIDYaA7hsGvcaHu?=
 =?us-ascii?Q?2umK7SC3lX+zjAMT5oQb9HqRJhuF6LNP1o3Au+D3QVoQClqpL6/+xbVM/o4v?=
 =?us-ascii?Q?PQpAARm8RtiZxowL8pl7CPwdK2zTSmO8LWGIF55S/KWi/+DX2YGMnoGiIWG1?=
 =?us-ascii?Q?l144bb6oVD/tnDITQu73M5HEPecE/pUlJLiKVDaGqCxEr5zRyDMUHuC9y7/y?=
 =?us-ascii?Q?1SezQVNiYxsJFX6dwz/f3y3I3NoRy1duMKQoL25RFkVnc+yItoPWy15eCpNk?=
 =?us-ascii?Q?iyXHQu3rySKvaJuGm3uGye7aIv6D3cKXcb35GD+Znv3s2WTBTEmJSZ4RAm2P?=
 =?us-ascii?Q?kTrq7i8GCm8zWySYejlWJ/XXlRLhw7FIfjT1c4NbkB9fjmCqm7xRvB3Lru4T?=
 =?us-ascii?Q?+I7kQNrOo6MAoM5l2FGzM563JQCvQ4lIuaTmrrIFbgNXyePHinWCdaEhA7/w?=
 =?us-ascii?Q?wZpHhYZ5QSmTsYZtxiwBoik2fNFoZkRp/PIcjyKE8bKhtJXv5Zm+XBTrNJxy?=
 =?us-ascii?Q?5hsHCOcyqBWHbygidzsUGQEwGsLKnBacU1LayvVUIBnT+zpWxRB1vtuZZ2o0?=
 =?us-ascii?Q?CvK/dl4T7SEjvajIYT49VAFUIgiCuTLp5HjfoXmzMt1tXUorvqxOHf43sXMe?=
 =?us-ascii?Q?cNrDUc0fd6v6aRRhK4kYHiJwDWFtIieDE3Scax/WFVoHK+w5Y5kY0npxADpp?=
 =?us-ascii?Q?NxwVFDc2Mymu0teQ/m2Y8/g+OESsPYnl89E4wT4qg2zbtpuwrkdAd3fUJh0v?=
 =?us-ascii?Q?Am5/BWmJbIsGeLCUgfZXG2fvx5cINITOj1qFx3cE+K0OYiPbDqa6IWvT7ikU?=
 =?us-ascii?Q?Ww8CivxyiDAuuizIlSDlnkwn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b34526-d1a9-4fa3-f3b4-08d963ee2b01
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:22.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VmFFpMN4bqBehqvbyZ+xNuJ8CGlT0d7YDwycDQGpOwiRNz44531fwnlyyHxy/UtRUPKK3C8LrJ7VDjttYgbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
index 7f063127aa66..534fa1c4c881 100644
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

