Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399683BEF82
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhGGSn2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:28 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:46224
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233117AbhGGSmU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPsK/IlkQtGceYQSMy3Sw8CV2mrPn+Fh+pBKSuYmRwHT7RYYrTdksxcUELCSbeJ8rpBKfAjMVdDrtBlLCuBEfd6k7w5G5Kare7KjN2ei2hZOFoNjQerdtg81SaLHwSs5Dm9/C6v9eV7ZqIOycDYhMdJWlY4gp9vUecton6+/IO8qdgtkTmgd4+wTeDu+8YXNmNb6tyuGIM5GQg9hlyY1VOUSJB6mHEPUQ4e8XH9m5fzXrw0Wh5POdnCthsA14f0QKiTiwl64hy6B3mvy92DEz5FPvC3fEWHjtwlR8K4jfQgzsy5MQKBSDkjwQg3wNJ/SBeTBLaUDWEjSocHKSximwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJsHY8n2NA4exO9t0dViCB784NHvK8fDVYNzRX7Qd/g=;
 b=iKn2E4DViJ53Lpo9U/iIz13O5MEOGGyZKUSKS4tYcBuz/JA1W8/IOcp6BwEPhbjb6aL2noOy2qTLkI1oHmP0649MLd/qZaMLrddLdLL6bpIbnMrHXD2WAO6RrNgjQgbRwWOM/MbgHAUwGMVcilNx96VG5dlSn3Mi9qnOAnwNihuhmmQtFE8vfw3biDSyG5UxSdIPXVcIVy4B80+7wKuxLgOo/aMykwZcYgT2BLuO+mhTXeKsppC1uIVSqQjA31WJu0Awjey1xoaXfkrelKDCoQ0TiiZSgYtG2YwS9pnhyw9mfpHqr5nadUzEcznym8iR1PDQB2BDaD6x3hjAgosCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJsHY8n2NA4exO9t0dViCB784NHvK8fDVYNzRX7Qd/g=;
 b=NNDowqT6HXvX5rSOK+BqiWM8AbwZQh3Ryj9TlFpqAtPE2pgVJsxl2ZyXwE/PDOUt65oB1A/FB707WwLoWAhwQ89tE754C2Y3jAHc2GaFVWGVXHS6qQpr8/+le738YyBYrjVf4iwIXD9s1q80WPvAYSpVNR0pMU9F1tKgp2h6Jtk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:15 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:15 +0000
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
Subject: [PATCH Part2 RFC v4 31/40] KVM: X86: update page-fault trace to log the 64-bit error code
Date:   Wed,  7 Jul 2021 13:36:07 -0500
Message-Id: <20210707183616.5620-32-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acba4824-8c8d-45d4-322c-08d941766197
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082A1A3681E9DC61EBB40B5E51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ociQfiE1QYoGxZ9jmEUHAoN8CN4BCgazgKqSScSgxnIWcBG1ll1+5qTHVZc5uiP9l6DcjV7jA0jiYgjcdgZIW3L59CihO+UIaVyLGgoklDNL+YJan4BqRgdmRxQK+U4XRu8uzIS0YdC77kHhOn6gy5uoaC2pSZ15WpX4MD8PJys9OVrpvLEjqPchVlzAJOVolKzb906R85YfcSRTETBrnuo1nfeNTJPiHbMTrOWpziq0V++eV6N4gVrZlO82T6tmwMV+APZilQQ/fx5fs5wcD7TZJQo3UCpbIOq76zLMj6WpjiSWdh/RFzpnEqLuUptnjDd1Eujlcp34WM9/I2Hid3CLb8VX7GHDkuOBwtTw9yPrbdpxOfPW4UsVb5oWh0GG533f+uh1a+BaJpajb6esLBFedR4+iSn8+jtm/s00fXr7WKqn0h1mnltpOGLc8KCstJZX1mKVcDiOkMwCpFUnr6q43T07rdZn/It0uFSm4KrqxaB3tarf6npCOz5iL0xZM4vShIx089FVG85ue7Igd9EXZr4h7rjFJb/REhksCe+0uqtLnLZjiRHSC82FCBPWmADWuFlfWsOvh/B5uMPmOMwh9rI/KbDXXvUQpuXSCRjHExF3tiBaBrF8jy6u95Fk++eV1VBXxw04psnk+TcEVAjpmLcHV+JlKUw8rxFna9Hk9Hy9CIHvT5pGld18lcj/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IhPC2rsVeI4oA3QdOry8eSb1otqS8f2haYDG8fzPwh0cqEPnSMMpSdBu8rb?=
 =?us-ascii?Q?hSXa/qxrOhj9ua3Z3uiEbyrkN97vDcapE7JQPvWJz8BtrVx0xQBj+IJruWnI?=
 =?us-ascii?Q?cOW8ZxBm913FPH9+dlddFCH1pEvtV9fboXVETy0+DbGzv8tEk2d3ltDgwvJC?=
 =?us-ascii?Q?/QkP8aSOtwOIWttS3noRFoo1Q9Tnc+O416rb8jZcEinp0X+0IfcmqlTslmbP?=
 =?us-ascii?Q?wB3RTmzjwa8tuoMqt6jfkhK80L83/pWSajCQMRBfjG3/MkKhoj7vwdnR2iLu?=
 =?us-ascii?Q?ASLlemjT9sIfmbeaUEEr0RRbwqAM9fBLJOc8r4Mc2G352Ah2asfRUwmFZEAn?=
 =?us-ascii?Q?ElvYUrvah53YY3Q48XgIk8xnoFQ+JczV4qmYSrqtOTWoIs96Ppr1GL2Sqemy?=
 =?us-ascii?Q?qlQSFexIDuikhyH1vU4d2padfLjY+eoBdiB6s6qtaPHmvplv72KEix2IC/kv?=
 =?us-ascii?Q?qc3BrV/pvYWWx8GYd0S5DGSEihP5qKl1KcfvwRsymXyNOgLUt/GXsZFhSxbv?=
 =?us-ascii?Q?LdBn27mrEpNTE05Lab9Gcd7lveWCEK5snupoOnjnq4YUF8BKJRo4n7R8E1bU?=
 =?us-ascii?Q?XZEDCfI5zycZMljoPldWigesfrt6igywN/G9Z65SPBxvZ3jMBJorXHyviSPk?=
 =?us-ascii?Q?lwbnZgLl6vxl6Kafzfwe2CcJsaKL0PhDXpzWei8Ur8TUrANLzkMXqKICnBmw?=
 =?us-ascii?Q?RCJdK8pKyAmd6BDHsRN5yLP2IgWaVswxZnJYh2/YPbwOAak9c4VjqmCIx2yS?=
 =?us-ascii?Q?IfxuL5YKoLG1v4gfIBZCrKPMEmejF39BQruk7/m/D8oSvprzPd9KqJ/igcu2?=
 =?us-ascii?Q?StsUK+FoFuuu7JrXAj18nQRzqbzbrazexW1W1cFzow2+dlKaRVZbY5I5ED2r?=
 =?us-ascii?Q?37DgxbW0/oxCw4FLIhpg/GabuQnq+JGIl74Wri3uiBMmqxJ6sNsf/tgiEFdd?=
 =?us-ascii?Q?bdp9ewiuf99ahQnO+SCt+eAgiYoSmL7lbwHRG9e6OKxTCnDtFcbrJMe9h+z4?=
 =?us-ascii?Q?XbONFJ4x0PqEvrfIgfNgDIu8G7/awHfmgRYOMt5aaO4xG4q0TjdE97eFJTMo?=
 =?us-ascii?Q?XTdNXjCTb3rqR17LiSo4HR2VRZ+oPExqGbh+iPLRXH4JhO9y+PcYtgR62cx2?=
 =?us-ascii?Q?rjKgV9zeP/c7iqhJoblL3bCcL/E6jY0i7e7Xx9XQblK+mkoIvp4ZkWandMyu?=
 =?us-ascii?Q?CmFTgo5T2GfPTwXr49KU3myvprJtdAMqKMb+sf2zOAtoKy44rofeFR7qqb7I?=
 =?us-ascii?Q?m26V6QTTv1DgBNU3CRzwN9loqbTADDBqfLrPYSCsNpN0y/M1s5G99wgmF2xX?=
 =?us-ascii?Q?t3nfqrfcnVyBqSnkVk0aY90J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acba4824-8c8d-45d4-322c-08d941766197
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:15.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZMm2n822mavlKSMwYviTsg83k3BaxGeX3RDGGKL8iA2iSZeddftrPsb0q9Syt2A2JSKCBHbZxdnBykzAJpuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The page-fault error code is a 64-bit value, but the trace prints only
the lower 32-bits. Some of the SEV-SNP RMP fault error codes are
available in the upper 32-bits.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index a61c015870e3..78cbf53bf412 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -365,12 +365,12 @@ TRACE_EVENT(kvm_inj_exception,
  * Tracepoint for page fault.
  */
 TRACE_EVENT(kvm_page_fault,
-	TP_PROTO(unsigned long fault_address, unsigned int error_code),
+	TP_PROTO(unsigned long fault_address, u64 error_code),
 	TP_ARGS(fault_address, error_code),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	fault_address	)
-		__field(	unsigned int,	error_code	)
+		__field(	u64,		error_code	)
 	),
 
 	TP_fast_assign(
@@ -378,7 +378,7 @@ TRACE_EVENT(kvm_page_fault,
 		__entry->error_code	= error_code;
 	),
 
-	TP_printk("address %lx error_code %x",
+	TP_printk("address %lx error_code %llx",
 		  __entry->fault_address, __entry->error_code)
 );
 
-- 
2.17.1

