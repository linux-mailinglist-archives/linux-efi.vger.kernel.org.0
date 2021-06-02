Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EDE398B95
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhFBOHx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:07:53 -0400
Received: from mail-dm3nam07on2075.outbound.protection.outlook.com ([40.107.95.75]:17697
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230454AbhFBOHH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/TKap/y/U/oSxNhIJXPTZ3KoyARYCHQ2b+H8F2TzAscEBmH+iw93D6/v+zic25V4gBXDyXNtAsoT4kBePX7f5OdYOZSCVN8iUoYUebRD3RBMA9isSJXHhuTMwB65M/L6w/sbmDODqvRhz3AXMsgv1Q8JgNl+Vt44b3Ws8nZnBiOsKtHcLrl+fAui/KQsI7IOTDPFTr3S5Bdkr7mJYXkqOrScOhCkHU12poCCbYLOT1wxmZiKY5ikc3ZXsmjHkiLgm8JETQDrZxoTDNdRvtoUYn2dVYLES2w3pD3HG8zw92SocJcVxtszH9kerw8gnbRdP0PTZ2ExbmiKfQ88ZHdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9+G/MqGiXWG6az0wDkUG2V0UdAJzb8jPMev6U9+w8Y=;
 b=dogfeKMbEDuoMswn2t+6bK8HJzByC8EiTyc4VsBX7d/kBYylqi3h6Z6W27KNdfksw/zxbeVgQt4TgXcNJQHvHhG5G1/2cvhaZB4zUv2Xdnv5aVzuoF4RcAdzmRekQBi6vm+lqhEhKQJQOd9Dzn6eXJsA+aENDVi0tPy1QGrXtf1R1TtnnJQmKN07DMQEgypBBKVJ7e4/G98Nh0lWmQ7pHnzqSk230EJ81ZHD6R+kkTavQcdsK4UYsn89s/401rNsHAPLpmCHlkAKDpPf60D8bzLCCQYVJOo9cBP17zymv6XUq0Sj8HwRWyKYffsEGHUxqLE+2ibXU15HYpt6xY6sRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9+G/MqGiXWG6az0wDkUG2V0UdAJzb8jPMev6U9+w8Y=;
 b=Rw8/omo698FayRC3xJtar40iwZoEU64fss0aY7cPVX8CoqqiK+HjE3I6eWZjDo+qrPX2OqhLT5LS17jG6+EpSgS61DVpfXCXrzLtUbeOnol9EsjVdt33CpnLvqUGrUTplVVSI8copnEMjuYYDwDmzbDE21YwLgtKIZC6wlzJwf4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 2 Jun
 2021 14:05:21 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:21 +0000
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
Subject: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing address to setup_header
Date:   Wed,  2 Jun 2021 09:04:14 -0500
Message-Id: <20210602140416.23573-21-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a92c46d9-f8a3-4e3b-21f1-08d925cf7263
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592BBA95BD985939E0F5042E53D9@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0cXrhWG18BEahp2Q6dZb4TGGlTTaFzxXdFnj0kA9fEy67BbeOsTX2qqaF1UtLi2EtuOeRE6ai5DtDAZb+dVC0YBMDeMjK9oWaVX6oR9YTxyhy71YGHGoz8RieqPWBcif72MlZikCTCGrXV10/rERjwf57mh1f7nQEq0RCnQt+kMuPgkpf+rBoxiPm+Si1OLOWRzb+fDz4wZaG915Olgx/X7ObVytjFzSVLGT6m3JjcwH2d9WjlyBeowQQRmoP1YousfgXwalJI/UssRKwUXSX6AEPhpzb5l7W+mZmZTFueUD5rBsRWIpMnx+ITUjB8AVsN4gfVNrHpdmNoNCEXSV15vUDjI5s3a5GHbL9xTOCWQHGW/foFt5MsA5IPlpSMIkGitnsx8jeMzUsPtAH4kZBXai861c7elLee6kwApEeWwcH9B3IihVREQ3nr1LPVfI3ehXMckgmRAOQznx9374O3F2u66LzewKdo1PvHtE9uY7/BMfVtrMcNNJZ49etPRHwguFx+KKhCFs3KyjKZmWU2G4LvTLE50lViB7Wv4w03kDFfSWPkzZS75TN8bL6at/w8mvFkbQc/OLWLlBSLksu+Mlu4QLcoYHm3BMdP6dqMiGk10tj4zO0+74okT4oA4Y1lyCSFtUjT3EyJPSmG5ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(956004)(8936002)(8676002)(36756003)(478600001)(54906003)(83380400001)(1076003)(44832011)(2616005)(38350700002)(38100700002)(5660300002)(66476007)(66556008)(2906002)(66946007)(4326008)(26005)(86362001)(186003)(7696005)(52116002)(16526019)(6486002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ra33CGRP85fegl8iq9FEQ6oPwIkZoHlHWOMlxpLIzQsVFKBVg0rsmNTVy6MX?=
 =?us-ascii?Q?RumvpjyHRRMrefRQ81C0v1x8RFcAg6YZ570SbAae3e0rEect55eBqswEvQ53?=
 =?us-ascii?Q?cuXwgdtpHaWNLD/OJlwKviMczP5tb9MEukZ8zueOA4u/BG8WpYKTrHzPw+gr?=
 =?us-ascii?Q?/0SJtRn3jhJd6m8JgdpQQp2r8dGVuz4EAyXHAKDdnlOp54tEv8NYyknX2XS9?=
 =?us-ascii?Q?r4go634w3ZLmeD0Q0D1LQDea0xA9KoUvwZkjNikyJftMJyU1P+mAykXhfAj7?=
 =?us-ascii?Q?nP4P1ivWoUCr7F4Oip8iRsIbSrXxm7prrcIBl9lQRssPj6IdIDCh6o1BoYro?=
 =?us-ascii?Q?HajJTBex62/W2A0gsfqDhD5q3M7Fx/CX3Q4gK8SKinjGwtk0AqMhmmUAA8R4?=
 =?us-ascii?Q?pZC3/lyjGRZT9q7+gGvXO8wGwnCmqzl0P7TOwd0d3PDchDp3s5dlI65Mue94?=
 =?us-ascii?Q?idLKwm4RNUD2CCz86w+q7MqtQNNc1cLZzLSlpmg3ba8yiXJq7dvvLuA+UsNV?=
 =?us-ascii?Q?ncnE1FVdSyTrna1BlWK2pOGceykWmX18ROSVZGBeFjXQ7oBOeurc/3WOK9UU?=
 =?us-ascii?Q?sgWLa4HCX2QzNf0xkxaK8rXOalAfGSAQIwRd8OqGjoBmkCR+XUIm5bc6FRfk?=
 =?us-ascii?Q?WKLj5E063L6EX9u+VIzNLBiOClIyDNnQDLnubjrk5X3QLjqk2sncxkrBCpCG?=
 =?us-ascii?Q?gvZaBxLrbaPPEN9frS1dwF36LJP7VAKnFbSROL3PNMpcOivkhGn5fNOJdjpn?=
 =?us-ascii?Q?kqRj9TZe1TtPDuXnswJSKBn4bUIQxA7aaswq4xOGcaLN5HW1zRDLQ50D3cty?=
 =?us-ascii?Q?4RZ6aO3kEhv4+0qoZ0eEHSsEUQ9tbfXEYq5448iJ7xQj9FxzFJIpH+1SPKHh?=
 =?us-ascii?Q?7Ty0180fMUPkjatfct7BiSjTxlXz5GR8Dih5LSVVvjEbrcE/v0rnwQoxwmHs?=
 =?us-ascii?Q?H1OKk4XvMx+on2KREDuqdRTY02d3TSYUJDxQSYayhmvtk9pCbe1/rWTC5iqN?=
 =?us-ascii?Q?qpzK93S6FaAxIxEybxTMyy3lvRg4/GEdfiCYM0B/L9sZngEUY0Lt4L6oT3rc?=
 =?us-ascii?Q?H2T/Fo1yayOyr5NLvF0JUv3IVgXtY3TjhtNujSuUcQGFU33KDJ7ay/sQyEoH?=
 =?us-ascii?Q?rZ+MRWjrjFnD00RE8bgXCXjlZAJSDKqxU+k6dKD8MXXNh3yiQzolUMsVhW4f?=
 =?us-ascii?Q?RSoIQpTYsKPVoGwhBXAlEHyDU4SzVLFdLvDhTq2MuIrfSfddriVaHTgT6Cpm?=
 =?us-ascii?Q?UX3JBU01OpJNS2ew1tN9gVH1vl1Zdm/n848daIbuz5wHyyFa9Vz6tIoUL2wP?=
 =?us-ascii?Q?GP4xl5oCK9gmUB5pZzsY418u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92c46d9-f8a3-4e3b-21f1-08d925cf7263
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:20.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiBqVOiTMkq+ZLdaQks8jpOvp81eCsojAUjdOo60nP6Mw25+LxwJTUulJQPrO8q4/rbYGPZ4jsK8C8o6AVWrTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While launching the encrypted guests, the hypervisor may need to provide
some additional information that will used during the guest boot. In the
case of AMD SEV-SNP the information includes the address of the secrets
and CPUID pages. The secrets page contains information such as a VM to
PSP communication key and CPUID page contain PSP filtered CPUID values.

When booting under the EFI based BIOS, the EFI configuration table
contains an entry for the confidential computing blob. In order to support
booting encrypted guests on non EFI VM, the hypervisor to pass these
additional information to the kernel with different method.

For this purpose expand the struct setup_header to hold the physical
address of the confidential computing blob location. Being zero means it
isn't passed.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/x86/boot.rst            | 27 +++++++++++++++++++++++++++
 arch/x86/boot/header.S                |  7 ++++++-
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fc844913dece..9b32805617bb 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -75,6 +75,8 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
 Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
+
+Protocol 2.16	(Kernel 5.14) Added the confidential computing blob address
 =============	============================================================
 
 .. note::
@@ -226,6 +228,7 @@ Offset/Size	Proto		Name			Meaning
 0260/4		2.10+		init_size		Linear memory required during initialization
 0264/4		2.11+		handover_offset		Offset of handover entry point
 0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
+026C/4		2.16+		cc_blob_address	        Physical address of the confidential computing blob
 ===========	========	=====================	============================================
 
 .. note::
@@ -1026,6 +1029,30 @@ Offset/size:	0x000c/4
 
   This field contains maximal allowed type for setup_data and setup_indirect structs.
 
+============	==================
+Field name:	cc_blob_address
+Type:		write (optional)
+Offset/size:	0x26C/4
+Protocol:	2.16+
+============	==================
+
+  This field can be set by the boot loader to tell the kernel the physical address
+  of the confidential computing blob info.
+
+  A value of 0 indicates that either the blob is not provided or use the EFI configuration
+  table to retrieve the blob location.
+
+  In the case of AMD SEV the blob look like this::
+
+  struct cc_blob_sev_info {
+        u32 magic;      /* 0x45444d41 (AMDE) */
+        u16 version;
+        u16 reserved;
+        u64 secrets_phys; /* pointer to secrets page */
+        u32 secrets_len;
+        u64 cpuid_phys;   /* pointer to cpuid page */
+        u32 cpuid_len;
+  }
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6dbd7e9f74c9..b4a014a18f91 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -303,7 +303,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020f		# header version number (>= 0x0105)
+		.word	0x0210		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
@@ -577,6 +577,11 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
 kernel_info_offset:	.long 0			# Filled in by build.c
+cc_blob_address:	.long 0			# (Header version 0x210 or later)
+						# If nonzero, a 32-bit pointer to
+						# the confidential computing blob.
+						# The blob will contain the information
+						# used while booting the encrypted VM.
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b25d3f82c2f3..210e1a0fb4ce 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -102,6 +102,7 @@ struct setup_header {
 	__u32	init_size;
 	__u32	handover_offset;
 	__u32	kernel_info_offset;
+	__u32	cc_blob_address;
 } __attribute__((packed));
 
 struct sys_desc_table {
-- 
2.17.1

