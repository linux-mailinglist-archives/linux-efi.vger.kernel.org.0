Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EDF3F2F48
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbhHTPZA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:00 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:5249
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241250AbhHTPXU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEaYfhV6G9nMyIQgj1PEg8iaARZVrfeiQmL+LnypyPSoFbkzuXlrzqpRHgo7FqV6RCL2GEh61R3keYbLqobkm0yGiKfsJcvmt37xX0JxruHnQH8x/IRzzpHR7AM5sZdUulYPbIEcVQ5s4Dpp1eWBiqfjOTQkNZbuyIoOBswVou8YJJH5MgdT94f1LDWqtLj4W/Ahhqy5EaA0MJ+0/l5StbpO1c6AQ2bGR1h5iI1Dtctkagp8bhBOG5e+hkPdHRjZzfKne6JEpCE71h8jnhfKiIsF8avqF4cQNRjgK2nk6rykk65FspNmij45w8J/EGb9184Lbhz+/hgpvissgezINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqx/QsgOVB/SYDeLx4UhWZPPc6BLaGZV9MlEYf9LX/k=;
 b=m8W9wAryG8qp8jJtFDPMzjzvhomwvjIrX0C+m7whopHEEukfjfwMyDr1hEcFKc0obKNWUD9apb1P/AJcAYa3SUCCeuImjHXXiDyEFdIrqREtbPtq0sGN2jC88n+ipT+XIY1i3Rz0sp05aCGFTqhJyH7NMYLCKSkwfr8XVMZ43DGBESEbcqLf+QDwlF4Axjhex+x+OReBDLpGf/ngn2vI/6HEkRGFEX2yrH3WBohbnfkHOI8Cwzo+WihAHXt2KlH/LLyHA/iuhRDHWCjSgxKGSoUygnS8WJY9Zu97oRgyxQzrA3TrgFke1KCMPolucQicTcMkvZOaQDPgmLQBg2AFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqx/QsgOVB/SYDeLx4UhWZPPc6BLaGZV9MlEYf9LX/k=;
 b=nvlQV/qngjb/FiNfLdrD5gqoWVXNhmCGTz0fGL39hv0Mwb2yrEQaCglE+4rbbDZ9O9hw+J7VSLObbwXCHvSHfRPhlwp/jz9NiybvohIzviZC00S4gUR0luRSbo5EEbFF2p1fpQ4MNmfL6WG29fOD0rK327rN1o1Plc6frSX1ipc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Fri, 20 Aug
 2021 15:22:04 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:22:04 +0000
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
Subject: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request platform device
Date:   Fri, 20 Aug 2021 10:19:30 -0500
Message-Id: <20210820151933.22401-36-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 219a4af7-401f-4b6e-cbb7-08d963ee3145
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB263766DBDD67C63DBDFC3D88E5C19@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pi7s78NIG/pzWvI1T1hi+QQoBRH8jfA5VDRhufUJuIfPd2qltGzg07W2f3puqeAH0OEY7MBKvwe9LP+tIXRzeHja+AI7RXbc9AZ/wQzeEwzCbFPFf8IMVVn0+XmkRgEMsUy8/6iqKRChUBYXdxX56bfxU/QlJdD+d5UtO5Kn1GistUKbhx3dKhLbd4p1RI+xu8f4NXHHyhICERBYo1BhbEBrYDwsIrIrCF54r3MuiK79V3WfJdoHZaGZspClrA+UkCO2vs/JsSXNDrtQPp1yPImH4HNKAw6rUzIc7GUVT6jMu717VC/vZfY4tP+F1TJuYSxYeJdOMX89uOlk7rK4zgORyeGeKrmoU0MQdmYkX/6bbkDm22391mc3/LfBm7XegJLg5QUR/8udBn/V3eEIYJlfkFl5G3tDMopIBNHAMkqCgk62qsf8WrEQiRrrQLF4ZV+LLQYPxR9KRc5LQMOm7OyOS5sZHVnSUb5kib8z+Z5Id4KyFxu/1Y5E7B8XEMg4dtQkMGL6BY6IC5HEi+EvbOqT6rpPqykzFoEufiRWiP5492IpPM/GmhBdPM7HEpnw5OwaAFPqO6XhTAFPfHLIA80ZwXUNvcriIWMtq3QmGCMv1QIHqwLyZmHoemkOOih3dIRxLwCUR/M6SWQ+Zg7qmjE20+eQRr9SaHTRM3TBdTeGYGG3KmycVpkgGY6cvi1mL1YlmfD1pH/D2+c1Flc0eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(36756003)(956004)(8936002)(2906002)(4326008)(52116002)(8676002)(83380400001)(2616005)(26005)(86362001)(7416002)(7406005)(186003)(66476007)(44832011)(38100700002)(54906003)(5660300002)(7696005)(38350700002)(1076003)(316002)(6486002)(66946007)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6j9d4e+i/guQXwHWM9ybatHMzqpRWkdTPFeRHjlnkTSckvh5LGIckJtZPZq?=
 =?us-ascii?Q?1H5u/8NO3jb/oJumIV92v1LgonZ+1Xq3H5fGZh75lVd6uJ+ndatUaHK7RdgE?=
 =?us-ascii?Q?tcCHq9UfOoff/fEB8wDQfWDE6QcFMKHGp/xWv9KUS68JuXf3/I3+TVuBhIWH?=
 =?us-ascii?Q?505jKd+4PMj1vWB7qTF+O9mRnkkK63YuQL+HAYB22TcQusw+wir12PI3/Sv5?=
 =?us-ascii?Q?MaalAeR1ev7oApfqpaBilwDZRfROMnksZJagr0PSCNyZMiNSTc25k+XVdUxE?=
 =?us-ascii?Q?7uquZAGtU4fJ7OX/Xvx6DVLINpF0IPVzCbQToLN+J2X+ws/29ADTqQPBTQxK?=
 =?us-ascii?Q?9YKq1uSzu9fCtM/0hTdvTo10+VBKM7Vp758CgiQB0DPWmjG/PcFS2gqyRvrs?=
 =?us-ascii?Q?gb0eSbocKgl2rkuVZTrBRjcD2dVbD+1xsNREVDulOWURBE/I4hSuYMfTf3MU?=
 =?us-ascii?Q?+ALkI/z94uqW7+ksa1KFtLndBYCTUUNdo9FHOCtDMfyJrtCY5Z8xBSnxCdb7?=
 =?us-ascii?Q?/s0tAJl2TZUD/Dw60VIf3VXtpqtIASqEv0lBGMoI4xFewACxkk+/WVtj+Gb1?=
 =?us-ascii?Q?kzr3z/oO0BPoyhCsDJkF5z2INLadoqZRQS4+KGlYIUXd/vs2Enoh1NRp1AMu?=
 =?us-ascii?Q?GcnFYqPdqG58IBn2i9DKyObG16YtUmIid89GQwFDOWdgyrVrGTWGeJIu/zzu?=
 =?us-ascii?Q?74LtzIFG4RvORU/jLJ8suzcWQwrWHUzmoJ4JG15pMgz2yILNC2HyqxhC3r6u?=
 =?us-ascii?Q?h7vHazktNZ0T7ZCrh3TKvlITs7ul7EO7H7lediGgOopI7CJ9RL3w0Y7qDyHB?=
 =?us-ascii?Q?b6jrvzwErZUEHsQC8bFXTJfmQG0Vb+mHZgjo0vHqPHnEbz1BeUiBz2O0SjmQ?=
 =?us-ascii?Q?6D4bTW+uv6UGfvJ+U0WkZt+V4VvslM0r3QuWKr/QLJ0qXhKN24zzybnKLt9W?=
 =?us-ascii?Q?zx1LubNLJvl5x4uqfGhAr0igkzhmmvBm+TQmfdJfHWF4KqNToj9KnomLZNXf?=
 =?us-ascii?Q?Z5DENMjo1V+78pofNuzjDgQ/d7VGESJCZF5WTS/nodXUIaBWIKgDYP9OkaAD?=
 =?us-ascii?Q?gvkL6G+PdJUZNhaWGFY2EX159Wz6rAEudb2y4lDr6cZ/1Ve3h4KP08cyM1pj?=
 =?us-ascii?Q?GYxz9kk+L0N1kJ0r6BQYSPe/zfzuXT3epWjGw53gBYK3EHlCwYZWRt7Fla7W?=
 =?us-ascii?Q?us1cg9BjcxEwYsUD+3JnhPFFLZi2gz/oK6XGsut94H+dy+7KCHqowl7X9Opk?=
 =?us-ascii?Q?PCF93Y18xKVP/C73L+nAOO860Z9Zp0NmhLcfklx/RHwZ+l2T2KvFkUzkS00e?=
 =?us-ascii?Q?Y+7MFcLbO3sSodI7bxxFcnmq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219a4af7-401f-4b6e-cbb7-08d963ee3145
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:33.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJF8N1+1MzNPZLzNfNlZUJnlxb7hSFQnqPI1lrsLyt3+ICg/cWUrSojnlaAPzC9hBj6LYZci2vBduMuNLPFzsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides NAEs that can be used by the SNP
guest to communicate with the PSP without risk from a malicious hypervisor
who wishes to read, alter, drop or replay the messages sent.

In order to communicate with the PSP, the guest need to locate the secrets
page inserted by the hypervisor during the SEV-SNP guest launch. The
secrets page contains the communication keys used to send and receive the
encrypted messages between the guest and the PSP. The secrets page location
is passed through the setup_data.

Create a platform device that the SNP guest driver can bind to get the
platform resources such as encryption key and message id to use to
communicate with the PSP. The SNP guest driver can provide userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c     | 68 +++++++++++++++++++++++++++++++++++++++
 include/linux/sev-guest.h |  5 +++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f42cd5a8e7bb..ab17c93634e9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,8 @@
 #include <linux/log2.h>
 #include <linux/efi.h>
 #include <linux/sev-guest.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -37,6 +39,7 @@
 #include <asm/apic.h>
 #include <asm/efi.h>
 #include <asm/cpuid.h>
+#include <asm/setup.h>
 
 #include "sev-internal.h"
 
@@ -2164,3 +2167,68 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device guest_req_device = {
+	.name		= "snp-guest",
+	.id		= -1,
+};
+
+static u64 find_secrets_paddr(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* Verify that secrets page address is passed */
+	if (info.secrets_phys && info.secrets_len == PAGE_SIZE)
+		return info.secrets_phys;
+
+	return 0;
+}
+
+static int __init add_snp_guest_request(void)
+{
+	struct snp_secrets_page_layout *layout;
+	struct snp_guest_platform_data data;
+
+	if (!sev_feature_enabled(SEV_SNP))
+		return -ENODEV;
+
+	snp_secrets_phys = find_secrets_paddr();
+	if (!snp_secrets_phys)
+		return -ENODEV;
+
+	layout = snp_map_secrets_page();
+	if (!layout)
+		return -ENODEV;
+
+	/*
+	 * The secrets page contains three VMPCK that can be used for
+	 * communicating with the PSP. We choose the VMPCK0 to encrypt guest
+	 * messages send and receive by the Linux. Provide the key and
+	 * id through the platform data to the driver.
+	 */
+	data.vmpck_id = 0;
+	memcpy_fromio(data.vmpck, layout->vmpck0, sizeof(data.vmpck));
+
+	iounmap(layout);
+
+	platform_device_add_data(&guest_req_device, &data, sizeof(data));
+
+	if (!platform_device_register(&guest_req_device))
+		dev_info(&guest_req_device.dev, "secret phys 0x%llx\n", snp_secrets_phys);
+
+	return 0;
+}
+device_initcall(add_snp_guest_request);
diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
index 16b6af24fda7..e1cb3f7dd034 100644
--- a/include/linux/sev-guest.h
+++ b/include/linux/sev-guest.h
@@ -68,6 +68,11 @@ struct snp_guest_request_data {
 	unsigned int data_npages;
 };
 
+struct snp_guest_platform_data {
+	u8 vmpck_id;
+	char vmpck[VMPCK_KEY_LEN];
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
 			    unsigned long *fw_err);
-- 
2.17.1

