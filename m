Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758373F2EF8
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhHTPWZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:25 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:40033
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241113AbhHTPWH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGQKeWJaCW7Vj6lhVuHqnNOGLu1rnMjeDNS2rgjWteBBh0TleWNG35CKWq8gM7SJap74SiDizvKnr49K+fiZ1Kvq3XjVILyBJmIArX+IYjFDD/edDLjlMoLm19FCJc++oNxlm8fKwkEstY0v90BkrvaGV1Avqx2YBwS63H+P6M+kTyGa75lFOsD1io12C+Q8eaJXikGLcsDotfkMdwpRxHpdMT09iA9EmutTtj1BxR/Mo9wMStdM8LN+M83GzjFAMeD6T4TXZz4PMaFbL/07AwGk8ldWQF1SKiEoiGW+V6oWKx8eXH2AT77XoP8JmyvjzlYdL7vdmPRp23ZwVvBNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPqecF0mlgVCWxPykDtuEmjBzoo1ck8E4JtGimOV45A=;
 b=PlIGBJz4H9HTp5bxaXU9JGjAjyKR2frBj9+a5f8SIEJZC3hTAvLoeERDhHpO0+29/7v2PFgwfvJCxZ+um3OdzXf9dxAoGYAGHzMFZAi0+QRCOohZ7QEediHOkUki9U4Qf5RN2LnsbsMj8mEzHU1Rm6ZfmCz6aiA0qYy0Q5oZaAaGSTLhvvwrzaZFE6NRUuzIoSxsMc2F1ly+GJMX4vRjpqJQNrkuykNxfIyA7HXKmVsULt8sT0RxQxPb+8QqKNWbRu4UNikxJ/Micy4JSjgDq1BzTwtxQFWVOiJp3jr4z1uvxT+9gxogqVxcTOdzu61aUONona8SKrhPk/mh21+lEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPqecF0mlgVCWxPykDtuEmjBzoo1ck8E4JtGimOV45A=;
 b=EPQESU93MY1rwqJfRvYek8gOPioUyxwZHK9/yWziSiRykQfdS1Y9QOsTmh2esuAtEsj14/P4ueoJfmKuMf+ct1/r6p73Z9Yzc/nZ3o9HRqUb5htNQ3t7F6J4KBUTGXN4m5wz8xN7NN6rawi2TiIzWT5/q25GRJR7C2N9IlyOE8Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:06 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:06 +0000
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
Subject: [PATCH Part1 v5 15/38] x86/kernel: Make the bss.decrypted section shared in RMP table
Date:   Fri, 20 Aug 2021 10:19:10 -0500
Message-Id: <20210820151933.22401-16-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 581a0918-586d-47d5-93ef-08d963ee2178
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24466F0CA05870121A004F3CE5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAV86zezDXU5KMcdD/vtC6DRV/pM0hD1Cpmc21wQpsOBOo02LCpZyp6aFeQdQC4dZDYtdj8QgHWA2Xtd/cM/cyUoCCwNXgPOoXrsKojsbpxUsuszGncrOF1kEbBUPIUGf3HcJyPDUM3JxFMaXHnmHFdJZc5IDCCOyrLrCvuq8WoaQikLmiL/V2EZTSqD4C6d1djk9yGvQwgcKb50R+l0IkI2Md4sDI5RyRac8iRaMcMjaOna39er2TgIy8YIXtftXD5KqSVJ1paYPFQVCeSvUcBU3yJ1eAJXy9kgX9FsSNTrDk1KnpQ78F52QrpR2rBH3uPMsbGRsxUBAXlQP9+yMcHobq+Ke4PgZ/JFPzzh4k4wdrSESs+0qLC9Vhv7+gZY4nrpjkxnsA+sGHijpk36STp4to59EAPh+J3rZGr4JDCMRZ+2NHQpHHseAufckZItiFq5O5RX5LRJuMvRomrcSYEdhlqpM8IQzPmWXrsJ0FtiEwkEErHdtuTFR97p7Z26JQ3HB8upSrT+ebyFP+2LRHknHUgK4x228GJxUjkDYCVzT1bEkru1lDrBn7ntyqxJWFflehPGjB5usCiC4EOLZfsPybFRTqg1QOWqUNpzErMkjGXa6lQMbsnYQ8ke0fVbyHnAsuyrXW4oHsM+O2reBboAdd2Wcdf9i+z8PbuKL8zTX3TYsd5UuPdE8n5Do3tjIlDq2Kqci4DGqy92Rq2uTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(6666004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7yXieiTM1Mz1WdrSg1nKCgrwWaIiuECtXfZve51U9zytfnGX6FpIccdCinBn?=
 =?us-ascii?Q?nr6Milt0a88chDFmSyYpu5E+VXKfavtYEHngBplj+8G212CvVn+LmriBgX8U?=
 =?us-ascii?Q?+FYfMoD7+lh1gHF0JXxuxOJQOnc8p4bDrxOhxSwP/2J32KtePxMX9IaJKhPs?=
 =?us-ascii?Q?Ykn+G2z52a9UCe45zDEf2l/W+JjrGGG0Nt5U2JFMUFEoBXmoK+t+jaxjAbng?=
 =?us-ascii?Q?RASvAsbRNssFOekzWlLEx0XC8Fo6x1Ph+qyHeTrqF9Ch7bhSmeZ3tD713G2p?=
 =?us-ascii?Q?7K0vMcJN87W5+zfGv9VQmE+QmlFi7eXXGvUrZTi62yEs3FJea4XP7ficSQE8?=
 =?us-ascii?Q?vUyrsFcnJB2QBT2KeKT5s8eE9hy835CIPpYm56qo7jrOc4RXTsCFeM+b3eAS?=
 =?us-ascii?Q?egHUXnU+in509XzRo7gvNEJosXDuz3w6ICllRlEAX+TkYVeCi2KmWtZzQnob?=
 =?us-ascii?Q?otuc722SrNVlfzhc+Pvbc13WP6KGZ7Ksx36QwXoNbxIPgcnYZRRZjxo5VddQ?=
 =?us-ascii?Q?B6Ruzcs3LkYOcEuooozfcvXwKlp3zkfgaYwfCvVzCdco1KNSDsZAQzxX5Qvh?=
 =?us-ascii?Q?U7AkadaSWQkkPAtsn/T6ooGwChsbDCC/u5rQ3vRbWwcpXAcOq0w1aV0CDPz3?=
 =?us-ascii?Q?DAG73ydRgO471tw/jHqWOZCCjyKHvRfTc1mjdWw8DVv/X2ZW32vXVzOwtVuq?=
 =?us-ascii?Q?WC1bL4PT7mmNdVgJ4F0CBwoiL0zxMdM6VRdhCD1m6+8orSL09Ao2h4UkrUWi?=
 =?us-ascii?Q?+AsgAD1Et0JRU+DAznpZqXgprW12Fdr5MegUuyB0aJwcKvq0BocG4/iBsJPd?=
 =?us-ascii?Q?6wAe9kZWnX9TIRmep0BdtmC2fCp/6bceOjNvIvMNwuasX7pvzuStmgGKNVmu?=
 =?us-ascii?Q?Z0d7WLuIb857m/v1b5sm4Ri9TxMsAqUZ3de6hTtayPK3BS+2B3oFrLyHe30c?=
 =?us-ascii?Q?IRULuvzKZinooK+nHUCFpUrpdR3kYLZz9IXpJXMNG7/QLTu2oxGBf85qfLFc?=
 =?us-ascii?Q?PjrXCWotMBVHPbZVp/x9WWNVcb4saGquL6gYUdOW4dATaO6g/IKZ0efvj6sW?=
 =?us-ascii?Q?XRwZ7cAuoLVZvWqElYG7QY28pvji32IVBnU8KgNAM7TPc/SOceb92ogZIgym?=
 =?us-ascii?Q?ZzbheVReobTitP8I11SPP9JTf/Sfj8Ce2cAe0byhQu0YfbUKUFQliNSH5s91?=
 =?us-ascii?Q?6bMrk0mPTXDzp8QwkCU+3i1NTl4S2bZxDQ37xH7mpLIFWeIT+Or4ujNlG5+O?=
 =?us-ascii?Q?vEhWyMEp9Dpv0MipuP3aBkk3Qjyq9OkYA+TujHqZqcFQ9YICvT3VuSVFVYts?=
 =?us-ascii?Q?YAkXz6MFe/8Q9dt71ztXvNjR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581a0918-586d-47d5-93ef-08d963ee2178
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:06.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE45MM+cgVOyTddj7Vi1vzW/pC02CEKdsmI4qGRYNsXRS1ogLu9WZk1amvWmv5WaqfWXbkb+4N//VhzAi5v4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the bss.decrypted region is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index eee24b427237..a1711c4594fa 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,14 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
 	if (mem_encrypt_active()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * When SEV-SNP is active then transition the page to shared in the RMP
+			 * table so that it is consistent with the page table attribute change.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.17.1

