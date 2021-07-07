Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8693BEF93
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhGGSns (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:48 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:10336
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232867AbhGGSmy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOQbHHlb/F1rJCnfKG3ph+Cc/k7lVv7m946llgNdws3fjrbJkQ2RMLqQTu+zZ0pIgTwfvJ0uHX8N43pBPbtvd/h7AZUNprEzXm18EH+paEMLEiGSYRx3Q4w12pVR0AK9yCLZf3lQd2bNM16pFUl9zMcpx0B7xZfMqE36/LGolp/VCyYsDjlJFBztOJHQlQFjizNiP2/C9hZ6PhKFiHrSXaVfvniGwa0DCRIbALLjesgXn/bFzfMKjZ2p3RzmqJHjFu43VseWV8tnXp9DlfEizOw+9QAbXe9Mua/UTYRVVofqW1gz51RwS+8thG2UNLcNsB6o5UrmpJ9MRE304P5ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s1VSgNXt99nVhtkV72vJN7zG51DtFbnprBMZTQx5QU=;
 b=djlClkt4OnxeSu/fnR85ok7XI5ACkQkTqP6ILvG0cdlqDkDDfzuaU3Lshx9kKDWralertAiiOcgcTsxkd++/Fw/6OaexqKbA9zvGaBOwLcTKEyz2uqjHHXpFOYeuvfhcYG4nk29mDlEjDtaE0/nG3WfYMQpuWnL2s+rWrZXG2iHb0uiij3wPXX93+48rA83BHfokh3LDMbBVG/Th7L0mrUimCiFrgYpL1laFPPmUXx8HunDZJo1fHuWaVj7g44dOSCI6HL/srN2o7NXGmFfO6OMx3Hbk//YRzFuWpa8Sm40JJmy9zaJfhvNZSPyNOO61TtbSrg8SkDWMEPsZM0gCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s1VSgNXt99nVhtkV72vJN7zG51DtFbnprBMZTQx5QU=;
 b=i1jec8cs8sD/nC5b3hdUHZx7bJE3Jgffw37BPpfDbXDV8CnDeSeJOEN/eCB1OEzqMqA9wEzrA/TM7Ard64Nk79gkmyAQWaaHyrngTHJgmhIFXt1NgYkmp7hbNkn+3V+78BYgcDosfHkLCI+71tnZ6Y9bEg/GqlTBb8L04JZRT8o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:36 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:36 +0000
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
Subject: [PATCH Part2 RFC v4 39/40] KVM: SVM: Use a VMSA physical address variable for populating VMCB
Date:   Wed,  7 Jul 2021 13:36:15 -0500
Message-Id: <20210707183616.5620-40-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04b77c44-bfc1-4115-e4a8-08d941766e38
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40993991232F13769D7BEB1BE51A9@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xuyADU9eUbe/Yf8tDPv95GyeHCgb99H4rjbtQvY+Ef7QqVlyTJ2qePjaefkca9F7MYRQrhLhgG1qCjY5k4L01lZCoB39C8b/9INC/3LbNVQaT8waLxIGeOX71nktqWqVf7gkco53eQ1QFUCilOLropEhQIMvBGpKh2JFXtORjfX4tyqmkhAYZATuKfJssyAWU+s7gJ9yJtNkPFnu0QtYE6W+mj9ASk5qG7GXoB4WEL4lPPi0vRB6EwJZpZQo/nHpl0dC7E+eq+EjXOXTv0A1vzOL86tu2k5iVGJIbhv0j5JjrF5V600T3cFtd9o9Ze4J94iK2ap0FF7UVp+GQKYya0Z1d189DmcL8wk6akXze2LwQiW4Ip4fPVOOVN2FQRblAjIyApixkk6MPpIDXBBUVWNW9HVX2Vt5I4EJO5kMDs3Vt/Ga25ncLSqTGqecbgrwA9TL8SV/TxHhTce9A9EQKA44nOpFMZ6C8IqEKvIQuGk2arNIYLm0cLO/tp1Z4FfLGNOA4PfnPaHgd2GIOTmG9SehK+r6id7GkoWtsKj0Fwt3Dl/N8/cUoVZO/d5RSLWDPcq+1VmZjC7psRU6CamI+OZjvBg983nttd7jZHWqWlNf0XBcXuuTSlYTqhHfq6oU14FNTVcHtxau557p7wTtQQnt+P03aT9/ezRwI210ZX5HOPb06jILAgMMREMHXa1OHW591rprV8mLHNZbTB1bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(7696005)(54906003)(2906002)(36756003)(52116002)(8676002)(7406005)(7416002)(6666004)(38100700002)(38350700002)(4326008)(316002)(66946007)(1076003)(44832011)(6486002)(26005)(2616005)(5660300002)(478600001)(186003)(86362001)(956004)(8936002)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gm5eQNaG35w9Eum+2+4gK9R2+YcrzI9V6v4iszEy8SquCFqlPuhjUUZJNHjg?=
 =?us-ascii?Q?qmzJyPWfMH1959CXia+NBrTq69WaTpPYf7dV55kmqRk00Ve8Wzrz6O1G3PxB?=
 =?us-ascii?Q?8l1w9UL/dGo8zy1BLEkFzwwe01VkIZbWuexVwoxBgbEtgD1/B4MfvfHOJ3E3?=
 =?us-ascii?Q?7fEfEQZqIUOF4PAi+kfHqQz/xBUtxHVxSI5HSRzCUaTci/8CQaxUU+34gRqI?=
 =?us-ascii?Q?ExrnTr5C0dz0NLzTfVtEblUkiPJK/wnP3y0No/tvSazKGKKeMg30u3Kk23MX?=
 =?us-ascii?Q?r1kdoEVHC+ixEa7LvcY3XiRN8a8GpIerelEjMMsok3tqdgddDHYF325ZY5sW?=
 =?us-ascii?Q?nwxDip1CsNWMvmKdodz2DmiI/3krrT6JvuSMNzmm824LL1aYVT5uCgedWp8Z?=
 =?us-ascii?Q?OsR2cSHQdKFI0KcLvOyS/m1yvoqHqmpeyAOhxhdD2je2CsODi8uxv/2r7hQV?=
 =?us-ascii?Q?TA6COKEZFJ1VT7fRyOI8JeKRrLHYQyahCf70wCf0j1aILVRImuvXqroGumgn?=
 =?us-ascii?Q?P1RhK40YS0yrrff0N0YgcUf1nWW2muttaexLC3XdA/hX4ed/l4i7GDOpcXQL?=
 =?us-ascii?Q?3cp3Svqf0FHh0ecZj6NZ+zQt+oCA6lM9hSXPH+9vYJ7VOFGlSTv2zsH1KVO1?=
 =?us-ascii?Q?OnWavd4hEY3WWRjUxOd00Mg6XnTCV0MwE89fWz+0mxD2hNY4WvLz97L5TnKb?=
 =?us-ascii?Q?PTc2EDO8xzvnjwj42PxKvwQw4nDMueRR0kXz9G9KhhNpd99XJzcSd9XkHc/w?=
 =?us-ascii?Q?x8swPRGI7fI0m53hEPHfKfc4haI1mIalB1DVq5ylZQOpLNcoPrOa8Vp/hsX3?=
 =?us-ascii?Q?tj0aS82tNB9JSWR4mtM8y3BMUcoBe0jlggjkeCE2TzQCMMZdh5a/I4rXs0Hm?=
 =?us-ascii?Q?m3d7Ls1QqYTo0+J9l8oKqWZ9QG12otDAPWnJXVeO7xTl1SDdCN9p/f5K1xV3?=
 =?us-ascii?Q?wUvOo+Z5t/VWrvqdfJ5h5X1ckYCZYJwPqdLOnw8K9B+jfDkJul11m6Vuf60l?=
 =?us-ascii?Q?oUfTX9uuWlWNE8Anc3D9mknnNDy/TPm4uOjC94ezglY8CEMQRF40KG8QN54L?=
 =?us-ascii?Q?VaJidnTcixKBYaCLkOS+zR9DlC9EjaXwl58fPCnTh8nAF6zbQ946P1FW1VDp?=
 =?us-ascii?Q?a3mdlQTbRdKx7V/jJfqu1ds6/ULLWy0njx1bQEtE2KdVX7WbW48Res0MOlVq?=
 =?us-ascii?Q?JzsOUVay+8EyjQqf0pQebmI+aVzktP8Dn39DFfIVz2d0fQuwLA8IrQTDXlk/?=
 =?us-ascii?Q?zrC6ZhDKjlMr2SqQM0GIUaKEyUJ1GI8nKfvbFgc4vbVoQPrM2Nrt2uJcoB4Z?=
 =?us-ascii?Q?yMtN3mu/1TLFl5Hw3lzANTBc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b77c44-bfc1-4115-e4a8-08d941766e38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:36.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEkcLtqSpLH+JvEh7uvjN5BRSQOhbhIrxWBYA/5rQNfW21eC9CznzhU3gmWvMBFyMB6paAWFudjG2927l5EmvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

In preparation to support SEV-SNP AP Creation, use a variable that holds
the VMSA physical address rather than converting the virtual address.
This will allow SEV-SNP AP Creation to set the new physical address that
will be used should the vCPU reset path be taken.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm/sev.c | 5 ++---
 arch/x86/kvm/svm/svm.c | 9 ++++++++-
 arch/x86/kvm/svm/svm.h | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4cb4c1d7e444..d8ad6dd58c87 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3553,10 +3553,9 @@ void sev_es_init_vmcb(struct vcpu_svm *svm)
 
 	/*
 	 * An SEV-ES guest requires a VMSA area that is a separate from the
-	 * VMCB page. Do not include the encryption mask on the VMSA physical
-	 * address since hardware will access it using the guest key.
+	 * VMCB page.
 	 */
-	svm->vmcb->control.vmsa_pa = __pa(svm->vmsa);
+	svm->vmcb->control.vmsa_pa = svm->vmsa_pa;
 
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 32e35d396508..74bc635c9608 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1379,9 +1379,16 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
 
-	if (vmsa_page)
+	if (vmsa_page) {
 		svm->vmsa = page_address(vmsa_page);
 
+		/*
+		 * Do not include the encryption mask on the VMSA physical
+		 * address since hardware will access it using the guest key.
+		 */
+		svm->vmsa_pa = __pa(svm->vmsa);
+	}
+
 	svm->guest_state_loaded = false;
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 9fcfc0a51737..285d9b97b4d2 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -177,6 +177,7 @@ struct vcpu_svm {
 
 	/* SEV-ES support */
 	struct sev_es_save_area *vmsa;
+	hpa_t vmsa_pa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
-- 
2.17.1

