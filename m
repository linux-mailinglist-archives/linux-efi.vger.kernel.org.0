Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457803F2F1F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbhHTPXW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:22 -0400
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:15585
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241310AbhHTPWW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R71UAQbRBjoFHrZXgTovy0JrHxtVaX1IF1hzHj7/DuRLslqnpYOkSzPiPKJ4E0dNIhDblgjU+jl0wJcI68a7PTM0xaD9WEKlKqbTNq1fJsNBCZPelUlsp4ZYy9tlyFtEbAvNeNnuxcr7gxHe3AHZa6z90xPyQq1w/xET2By8togtX9cGu9y2vf4XKz2W6gdso7y/tLEMT1HdPcxn4ILL++UyQL/QAT+B5Y1pO0qx+nZG1Gt6UWGmXxkbSl5LDhzeNIn7cTEWvI7MXhL4xeDHzwi4TpsPU+QKIk0BcJ2icAw9qRkmjfZw05gBXTN5TmXyEKOYQuLOXQdpBNeTaXWcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg4uDsa6Qr8QnbfmbHLe9rC3qM6rHyciMih+BkJQywo=;
 b=bXrb1ff18XVeaBXHqC0h6QKvU6+RVeRhfrnUqndAM6EpO6gShBTkw2qwSY8KbsEYLaNFAH2FfX9VY/3+IcuFs7A9xXJXTQVnQgmZ49AzsquUsof5xb3IzpXdDO/5TLmnLHFazxQ07WH0zt0dSgfhBJm2TiAo87I8trGQnM0Bpb9knpJgmjaCVx1YbrDXP2gFtrrrV89FrP39vchqB8KwJNECRZ5vlyFGKcF/DzMy4WWtSaEN50g1dacCceAJhmzt5M+o01kpWGTmT1DvofKi8iTsPqMOv6MYwi8e8TGO4UgAbSlifZTrwjjSI7kpWNpc1WtvCWVRAQtK8Hk6ZlJEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg4uDsa6Qr8QnbfmbHLe9rC3qM6rHyciMih+BkJQywo=;
 b=xpSvomUz96dVoyhXe7Od/H5Z7Rx4Q/G74+bCf03Gz5p5JIRDiOhTiRmzHSlF6qPycSzuFrWcTxSV5DOkk1MwTwddt3d3yT5zMO7o8WB4XszFuGJRlTBzH0PyPbZ3x1HdUr1bsnIiJLpSHmdVd/yp5lykKmIhlOHPJFfAaZSsb+c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:18 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:18 +0000
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
Subject: [PATCH Part1 v5 24/38] x86/sev: move MSR-based VMGEXITs for CPUID to helper
Date:   Fri, 20 Aug 2021 10:19:19 -0500
Message-Id: <20210820151933.22401-25-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93e8e9c4-cee3-4780-7dd6-08d963ee28a8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557618684D43B92DC56B15DE5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOWApcWyvUoiXU6usXQkNNXYChtV4/8D6oS0rQ6YT7M7on9PDfgtVhNgnilV66+zLHeV+oVDZ8Vg1OoyMQqUd+wm9wkfo3tluQs2s7xovCSzMrj6oHBvtC0HfDVf4YbOPSKAKmnZbe+ayYZc6Q5qEcJXykchFrNh3LL6I1isOpB1gr+TdoofY+8eeHlF9Q+AbxltZ2NSGZXgWWg0Du0ltIMnC/M5LIntNQxQLQfNcjmaj5rf4DPQUnlS7rLxiamDgQrVhsjR+KPTeNlQrQui+j4KaQfArGP9mmfP+FMietMVKiWrWqgFWnEh5k0uVGJNbg40vcPWhdROMwV75RNH6adtvMSEwk/6LUXXd3FtY8jja8RCiyWLSrT5CPKm6nGpkrfTgj2iHIEkG6BnqUfEUTWngDBxoXxKYIjxiwVySU5Alu59eqRGUMVQuNKLrxnxMDeUWEBBU+TfbwJrfze+ULLJDKrsKEmBat1/9QekKac8aVx7lJdJ84Icg1um1XWNxUyc1HE4nmUDa7si1BUHIWIC/KS4JXwGXrrJmXpvJNCkhzstQzMBLxYExSISB3W97csrF32JoRilPn+R9mOGR+cIiEyrH0//WGOmOvTYjhMVwC1H9l5PFfYmLXSrEEekgA1ADviArnrZy067LvZXSCBodxTN5FVwR9MjQqdfHHXEHytTbZC1OfksL27AdARGzw8RnOwVCKTb5Xy4sP6Wsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(36756003)(186003)(316002)(8936002)(2906002)(83380400001)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0gT+EjCi/kZYUOuD9bui/tdUD+te0Y1hdBxvrcLTIBEWWpAYdq0PRG4p9Spz?=
 =?us-ascii?Q?zT2o4OJgBMqsFsC8tWI6Y4EjyQR0TYHViCcNb6772AzOy0dz1pvujWaVWtVm?=
 =?us-ascii?Q?IPxKC650zuNlKBXmIp7VIeaxbuSp/NH+4Smx8tO/yyEzeRkcAkS2INc2IJ/z?=
 =?us-ascii?Q?uNPMDnORXG+5aGIqfLiS9RnIv2pG/s237btbb641mFCJQb1j35fYTAyi0xG/?=
 =?us-ascii?Q?x/sWHJzBwMiSL2ft8+MhOZGocKsozKvsxb09khAbfZhtXBR4Isk2aDFkbZhu?=
 =?us-ascii?Q?8GfZy3X0hhp1OMS3Q5xlblCXsH4p8Y3Pg3HLjzwtKcWx/ACJRmzyZG2AfDI3?=
 =?us-ascii?Q?fbvSxtBOAQfIuEPiQABmLtk8GbFdAbpalD1qrsmrXV/S3h+rPjGnBJKuGdAO?=
 =?us-ascii?Q?Us15f2meZciNhJ1972R0mgg/d6W5C3YjPbJgI0ZDVggvkWHgsnw+rPcHbS3q?=
 =?us-ascii?Q?thH9fP8o00x6wlMYp40jV+RBoqA214opLIGcCyts8gVmEZpX2OZlgXuq1FtP?=
 =?us-ascii?Q?xuGt2VUlIqniVbw20hwqnkn8yuZXyv+rRFeDGjbFhBI0CjEAKwQPt4oxakXE?=
 =?us-ascii?Q?MXBrH0lO0kToNhjsOCvcOUa5eTrINIAqamvlnJM1dok77z78dXTgLC8INFMj?=
 =?us-ascii?Q?NZ4KpV9exNnqGfe7kV3THDoFa/YeS3XG+Nhl2GEIK49ESp0fN9RsANjLSghf?=
 =?us-ascii?Q?ZPBPuWpQj4tgaJzder2FVNbPRjNd72/chtvnIeaJP+7/K3p6bS2aMyc0JPU+?=
 =?us-ascii?Q?WxExlGZWtDYUxSXQ+No+qkfaADFSxFzxkAv0KotHOrp9fSIiovf+wRjoXlYB?=
 =?us-ascii?Q?ut7lcWFi6DB6AsKCNgxvC7/9IAr7enEKqOaFkQDRtXOQsjM236+Lv7IFZwKI?=
 =?us-ascii?Q?/HzTTsNANba7hR5pozAAmzVZjETgosrIiFY2Ov5KMN/C4YfpAV1BMXqQ8Wb2?=
 =?us-ascii?Q?EoHTBVUUxsLyEmTEmsPBjj4MptzjrHYsYHYWzCAjXilvnejj6TpIMnRW2+pH?=
 =?us-ascii?Q?j+6A4fnk/qzZDVTLr3J7rzavtvh4wJexq+Srp/2YzTFO/lQq0SZMSn93JEQ7?=
 =?us-ascii?Q?1IwjpDdacoohmZko/p/zFXsPRl7j+oSylJLrGqIZyIdeNCUQMdHu83TeLzW5?=
 =?us-ascii?Q?/koby6hGiUHb1Z/9LWsMiVofXGyHXkjcbcUz6C5RurdWmRZ/7qoON2OACmQQ?=
 =?us-ascii?Q?J3S/fhLdEx8onQJiTuBvjhYcRgXlVVe3k6kMRX/RJCDGYtW3bSDyoSD9m0xS?=
 =?us-ascii?Q?9THUdkxf/4tytukhG4Weq+MNg7YkTpOj+dEr5KT4gA0JLKXEAocGtU5XZzJc?=
 =?us-ascii?Q?noZLo2oUjl06pLoq8O/AlZRA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e8e9c4-cee3-4780-7dd6-08d963ee28a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:18.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l/LzSDvY+wfnwXfENj4C14P2F0N6wej4lMuKoir6mB9+i0NAFon1Trlp+zE9ADLppilqX4JLzpgnFwgedoquA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

This code will also be used later for SEV-SNP-validated CPUID code in
some cases, so move it to a common helper.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1adc74ab97c0..ae4556925485 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -184,6 +184,58 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	return ret;
 }
 
+static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			u32 *ecx, u32 *edx)
+{
+	u64 val;
+
+	if (eax) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EAX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*eax = (val >> 32);
+	}
+
+	if (ebx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EBX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*ebx = (val >> 32);
+	}
+
+	if (ecx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_ECX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*ecx = (val >> 32);
+	}
+
+	if (edx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EDX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*edx = (val >> 32);
+	}
+
+	return 0;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -192,39 +244,19 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
+	u32 eax, ebx, ecx, edx;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
 		goto fail;
-	regs->ax = val >> 32;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->bx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->cx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->dx = val >> 32;
+	regs->ax = eax;
+	regs->bx = ebx;
+	regs->cx = ecx;
+	regs->dx = edx;
 
 	/*
 	 * This is a VC handler and the #VC is only raised when SEV-ES is
-- 
2.17.1

