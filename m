Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9235B45090D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhKOQAj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 11:00:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35906 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236627AbhKOQAd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 11:00:33 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFErPvr005202;
        Mon, 15 Nov 2021 15:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nUu3yphitltnf2Yh3vbTHO+6oxfujp7ZZ0m9CeiB4rc=;
 b=HwitxpkYWYzznMlb6fwN1bbO40zPgOmxd4syBHqb3iUYFY4O4uUyvigpE+6Cd9DWrCyd
 TkExNuxRr9NAx2Rk1Sw6xrUgQUDolw7j5yWvQb/2+Kz3jjmmTcmYYtHtRfxGJ3hka2WD
 OeAAeiEQizY0bVBpZ1c6/QlAQj+IXFelmtj/C98+irfT22oO1NaSsHv+IZl7DzWA0YS7
 GZg5WLrQKLaew3ac8HamV5HIyN0GNnZYXCV7+QxicIBXuz4Ej5O7swz0RgJfvs1WnQfI
 9yW1nJK7MW+w/NalsSjsjEu/j3T02TYIq6X8KS45PI4DIlCqB7HvB1ihv7u1tOL52t35 xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxkgd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 15:56:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFFuLIE164838;
        Mon, 15 Nov 2021 15:56:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3ca3dekgx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 15:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icRfip6MfxMz9gTq28QIkvlJdmb58sM4RVmjMl+C+/+KgsvvpBfgTpgJXYlqFCqZg6oKn6/EE5J8Ne4jdpvCqp4CP/f234ubIMhJ1QuPGd6kNWjQruHNnpfBEKtJZs5tbzpGW1+zsE1Ux1sDM4KXiqoZPkaAtJkbvAwmn8FOT4YOs4S2XkH1hnIV+scEx7QA9H9MZ24E3ePemycxD8Msb4CNoxe88VgqU7LbjRPXwaTY1kDum4+EkQuBGEGhWKOXGbjpMmXC5flgyOVeYct9vHWhBAhPFd4n3t8FZLTYTSXEih8AwErRbOznGmpZIp6UkEiybsxnsRHffnFDmojTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUu3yphitltnf2Yh3vbTHO+6oxfujp7ZZ0m9CeiB4rc=;
 b=PjuVqpQXLcZVIkX0ZQwhKWHvV+Mnr3MpLACXVeYDsh2WWzH0iFwstWSqti3kNjCkcWSZch5OXr30F+AE5nkAC0bUsH9HLMVXiw+kKj1XkxHdekgNjnAc56q63M0UlVxQwD1su0w9FAYuNEy2l/T5ndvNG5640lNZqxxuwyW90X5IwKuDhBv7DGYWvW00xYST2Zn0A2FNz6RH8+9+roH8e9W0I2bfwmiTFm7WYG9QcOwNBmh8Vx5UUyDCofp+ET8Jg5od6vrPgBl2/QWlnGhf5ZArl+4Pgw3m+w9zrfVxxOFE+FOM9fZu4fcvtWeWHFcOBRlomB9g95E9L0OGtjSnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUu3yphitltnf2Yh3vbTHO+6oxfujp7ZZ0m9CeiB4rc=;
 b=BuZ328jof9Sq8JTcIS13M7e0nl06OzpAoWqG6bCj2+XFPbq1/XqnvuSACoOljOJ2BIWCwHH1Hmwghw/mMlitg1YBU12xe6aLlqHGL26MyoKo1v0J/LJUESnbZ1bWQghQEhIj8K8UZS+t+QmwnN5Mu4hFFLl5XajXOmBujJrqG3A=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2719.namprd10.prod.outlook.com (2603:10b6:805:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 15:56:16 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 15:56:16 +0000
Date:   Mon, 15 Nov 2021 09:56:08 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
Message-ID: <YZKDGKOgHKNWq8s2@dt>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
Received: from dt (138.3.200.60) by SA0PR11CA0072.namprd11.prod.outlook.com (2603:10b6:806:d2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 15:56:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f452154-8bd0-4310-9907-08d9a85074de
X-MS-TrafficTypeDiagnostic: SN6PR10MB2719:
X-Microsoft-Antispam-PRVS: <SN6PR10MB271936E71F6DA0098873BA53E6989@SN6PR10MB2719.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RG3SI+ykuLHmTJkRG87hRlMA2IFDsHe3BeYXbYCtyAHWpCgJjRJTWJMYKa1yj97ytebTg7+YuneXMKM5jwi3OkflubATiQsJLF6xsoSmd4zow+mV1J6vz1Eu65KLWzGcyi/5HLVxSBg1r8pxzy/j6MV9NZI5vUKIdx4Mb2hhV1AWEW3idFRam9lFKZLWVoQVoERhgKbmtMiZz/pvLBhX18mMBw+nHtfDaGS6XTnkWW2+CS0ppOMmbdBOVyJOVAxtdntGED0SZh8d+opzeemUH6F33+feAP5xS6zgCwH/QvbmjfpRyRj4UKV9LlVkfX+7bbrQDMZZpqBb8/UfA2MOQnc5zQu752h6vWMpri1sIpUXJV1U6a3+BAjIt0zyDTjxEGgFlPyvNo0skGekz2fdod+IBlAZpeFd88SiRzlUM5L8WgBaKv1lm2Aryfb4KjENttZhjPVezoKWLPhBcSUee1XgHySJsw330Nc2gS78YGPdMhWodphUw4ZYNNMBqHpw3DQsEMACTrqBRX4n19XYbYso2zoLo/s1weUKol8whNExPwPEUiOWRMe8qb+Y1uuWJtFZj1UQh9whFVq9CQq6rZquTxFfA4ZwxD2hQtnZfi8GbElcuHk4NWvn63Leb1MBUsmoAW3q/GHtIWvdukFXsUxwRzHsD2+pzRo2eMiaMV1CVDcIia1H8UrnfwaVQsgpWOyxeWSqt+fQrnD4QcG+e3hgpo61GpJF+vrVIQ7qS+leY945JjPwCt/OZEnz6p1R9Yp9vgniORgkNSvTGpCFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(956004)(316002)(53546011)(86362001)(44832011)(83380400001)(2906002)(8676002)(38100700002)(4326008)(66476007)(66556008)(66946007)(54906003)(6916009)(26005)(9576002)(508600001)(55016002)(33716001)(8936002)(6496006)(4001150100001)(30864003)(7416002)(966005)(186003)(5660300002)(7406005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4zFVnMrn1Psh8t50lg3O5kf6hrh2rcxDaRd4tuyFVWKb3BvG2mCb2DJLbwL?=
 =?us-ascii?Q?McuOerpEEKUz8jdqgd3+4iZYDFsoLDNnsuQLXXH/4nMo8ioZMW6qeU8Wi/wO?=
 =?us-ascii?Q?B2/TW8xJYubBBqh3ELfmiRuTGm3CNIB0lsBifD3oAjPgbleP0Ka1SN25koqM?=
 =?us-ascii?Q?QbBr1TmZohuzz+19+syc6RYWxvyXy3hl1hWYmZyODiTcVpMgp7LOiDBlUMmR?=
 =?us-ascii?Q?A1x3N77/GxvXmZC/w664G9d6NQecnfMgv41vaiEve1rTs0j30nL47dUxPSVI?=
 =?us-ascii?Q?VpNnfQVsJdGZgZcOaOHfnVZHBhD5dbdxwN5/VIki4kkyuPHViaZ+Ok2JPEU/?=
 =?us-ascii?Q?8Lhgk/ZZ6ujvNjtSHtcsCOgapO2JhddJ3xNz95uQ/8Ofl7ZnMk37QxaEPRCD?=
 =?us-ascii?Q?SGWy1NiBnVbruAFv79rqX0/XTWPBNE0v9xichsBs4i8dH6pHyyeE0wilocJN?=
 =?us-ascii?Q?xALPQ9ceEHYnzOjHo869e5AnS5q2AwIgmmlZvNb9N6AJVw2yMpOVu3ty4rci?=
 =?us-ascii?Q?c05VSR4BdFZZ9zggk9HYO60z3VgHPaMq9enwsoG0L+72CmBQcPnqYUBzk44S?=
 =?us-ascii?Q?aEA7LB/oF0uUrPdQGo2+siLVRha1uZtsC7n8xT+o7qKLx+/J8dfvuuDOKh/I?=
 =?us-ascii?Q?igt2EniK+YFUhOGyF818ndbwgiB1q1KqaE0w3YdTnY1v21L+nip3JU3rKBaa?=
 =?us-ascii?Q?FYrFK6mrbAYBVT+E33PP9dQliRbTn4l9FQAsTTVYoFpFYP3ClXJwZKmeXGwz?=
 =?us-ascii?Q?b0+X4UHyAzVnKEsvZMC4CwNQRnARevByxKO1GMeDYsMQ4u0wtUNnFjX5X7P2?=
 =?us-ascii?Q?HOiwXwo/zcyWT0nfG19ogDA160hK8O7x6UT3kl97aJ1uq3PQiFMnw/Rb7vsR?=
 =?us-ascii?Q?u4tCYtTXoTcAOvBUuS+pbs1ZczHC24cDyQ187W8j+BQeNByVkYwLm8VDZ/0x?=
 =?us-ascii?Q?2ujWAn9UgN62IWEWUggqlU6eatfYJ/ndAvF7T+/cDIdQJqPx82pCPfEinMfA?=
 =?us-ascii?Q?I8LB8EsLQsKXPdDmb2ZuOwANoQPO3CGD1+0wv2E7BLDZpuSdqgk64oC7fOy5?=
 =?us-ascii?Q?/ghyLdjlj552R9fWgKNC4ePlzKKUMtYD+kMj9OLOD9Y/zLgp3VdScaYoYW8Q?=
 =?us-ascii?Q?lfsk7AfknlZS3znH8+dg561ES3h0ZkQ3oycbn5DoN6beR5yqCIshCS2i1jhU?=
 =?us-ascii?Q?J41lkTm/gCh20oRcp3BaoKMpI3nTnssOTZgSXnSTx1MARLKCHDc4N5x3Uqez?=
 =?us-ascii?Q?UD0NJWnnpxEyTxas2lvsNR8imHUuDoSlmYjQE9ukVf6zIseihFOf5DY43dj6?=
 =?us-ascii?Q?e5MtvmMeWF8dUo+aBX7tEKGtWb6KysMQyeVSqevk0qrwvGuhlKCHcstaCQGu?=
 =?us-ascii?Q?TdCocBJ5SuFLQ5OzDC89CcAjt9ZtM2e+bsivQHhL8vyM5TDtEZipCl9Q6+LR?=
 =?us-ascii?Q?MllsgNTs8DOPgOUAC6wC8G6z+RkzHCbFEXXjJfGj8TUfxrM4Rjz9xXdgTqXd?=
 =?us-ascii?Q?I5ZZ9kY3XFxp/K+gqOSqpEM6TyGBs5COva6ieedz1LWroKGL4KdKCyEgcBDs?=
 =?us-ascii?Q?ZyMRE4m0mfJin8YCYPl2gUxMRN7j8f6a9aRr/zJ0dJ4V7CQNQn0rTBdTfGod?=
 =?us-ascii?Q?iX2GZpdhy7oY8Dy7J/i1M4taEBM+MGC09KccgiHnlze8K68WImAHUg09WF1m?=
 =?us-ascii?Q?YBqa4A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f452154-8bd0-4310-9907-08d9a85074de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 15:56:16.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6nbOyWxM7r3w+gRQLKuwVi0OHaaRd1pVOdvvsMlS1A0GvaExWZLNoKvGnVDoXbPFjTIyNhxUyJcQU4W4agP59S2SwLXGQ038fOkWTNPcIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2719
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150084
X-Proofpoint-ORIG-GUID: s1f33QozKKs-b72nX3lMZCPk5uDVk3U1
X-Proofpoint-GUID: s1f33QozKKs-b72nX3lMZCPk5uDVk3U1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-11-10 16:06:46 -0600, Brijesh Singh wrote:
> This part of Secure Encrypted Paging (SEV-SNP) series focuses on the changes
> required in a guest OS for SEV-SNP support.
> 
> SEV-SNP builds upon existing SEV and SEV-ES functionality while adding
> new hardware-based memory protections. SEV-SNP adds strong memory integrity
> protection to help prevent malicious hypervisor-based attacks like data
> replay, memory re-mapping and more in order to create an isolated memory
> encryption environment.
>  
> This series provides the basic building blocks to support booting the SEV-SNP
> VMs, it does not cover all the security enhancement introduced by the SEV-SNP
> such as interrupt protection.
> 
> Many of the integrity guarantees of SEV-SNP are enforced through a new
> structure called the Reverse Map Table (RMP). Adding a new page to SEV-SNP
> VM requires a 2-step process. First, the hypervisor assigns a page to the
> guest using the new RMPUPDATE instruction. This transitions the page to
> guest-invalid. Second, the guest validates the page using the new PVALIDATE
> instruction. The SEV-SNP VMs can use the new "Page State Change Request NAE"
> defined in the GHCB specification to ask hypervisor to add or remove page
> from the RMP table.
> 
> Each page assigned to the SEV-SNP VM can either be validated or unvalidated,
> as indicated by the Validated flag in the page's RMP entry. There are two
> approaches that can be taken for the page validation: Pre-validation and
> Lazy Validation.
> 
> Under pre-validation, the pages are validated prior to first use. And under
> lazy validation, pages are validated when first accessed. An access to a
> unvalidated page results in a #VC exception, at which time the exception
> handler may validate the page. Lazy validation requires careful tracking of
> the validated pages to avoid validating the same GPA more than once. The
> recently introduced "Unaccepted" memory type can be used to communicate the
> unvalidated memory ranges to the Guest OS.
> 
> At this time we only sypport the pre-validation, the OVMF guest BIOS
> validates the entire RAM before the control is handed over to the guest kernel.
> The early_set_memory_{encrypt,decrypt} and set_memory_{encrypt,decrypt} are
> enlightened to perform the page validation or invalidation while setting or
> clearing the encryption attribute from the page table.
> 
> This series does not provide support for the Interrupt security yet which will
> be added after the base support.
> 
> The series is based on tip/master
>   ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'

I am looking at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git,
and I cannot find the commit ea79c24a30aa there. Am I looking at the
wrong tree?

Venu

> 
> Additional resources
> ---------------------
> SEV-SNP whitepaper
> https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf
>  
> APM 2: https://www.amd.com/system/files/TechDocs/24593.pdf
> (section 15.36)
> 
> GHCB spec:
> https://developer.amd.com/wp-content/resources/56421.pdf
> 
> SEV-SNP firmware specification:
> https://developer.amd.com/sev/
> 
> v6: https://lore.kernel.org/linux-mm/20211008180453.462291-1-brijesh.singh@amd.com/
> v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/
> 
> Changes since v6:
>  * Add rmpadjust() helper to be used by AP creation and vmpl0 detect function.
>  * Clear the VM communication key if guest detects that hypervisor is modifying
>    the SNP_GUEST_REQ response header.
>  * Move the per-cpu GHCB registration from first #VC to idt setup.
>  * Consolidate initial SEV/SME setup into a common entry point that gets called
>    early enough to also be used for SEV-SNP CPUID table setup.
>  * SNP CPUID: separate initial SEV-SNP feature detection out into standalone
>    snp_init() routines, then add CPUID table setup to it as a separate patch.
>  * SNP CPUID: fix boot issue with Seabios due to ACPI relying on certain EFI
>    config table lookup failures as fallthrough cases rather than error cases.
>  * SNP CPUID: drop the use of a separate init routines to handle pointer fixups
>    after switching to kernel virtual addresses, instead use a helper that uses
>    RIP-relative addressing to access CPUID table when either on identity mapping
>    or kernel virtual addresses.
> 
> Changes since v5:
>  * move the seqno allocation in the sevguest driver.
>  * extend snp_issue_guest_request() to accept the exit_info to simplify the logic.
>  * use smaller structure names based on feedback.
>  * explicitly clear the memory after the SNP guest request is completed.
>  * cpuid validation: use a local copy of cpuid table instead of keeping
>    firmware table mapped throughout boot.
>  * cpuid validation: coding style fix-ups and refactor cpuid-related helpers
>    as suggested.
>  * cpuid validation: drop a number of BOOT_COMPRESSED-guarded defs/declarations
>    by moving things like snp_cpuid_init*() out of sev-shared.c and keeping only
>    the common bits there.
>  * Break up EFI config table helpers and related acpi.c changes into separate
>    patches.
>  * re-enable stack protection for 32-bit kernels as well, not just 64-bit
> 
> Changes since v4:
>  * Address the cpuid specific review comment
>  * Simplified the macro based on the review feedback
>  * Move macro definition to the patch that needs it
>  * Fix the issues reported by the checkpath
>  * Address the AP creation specific review comment
> 
> Changes since v3:
>  * Add support to use the PSP filtered CPUID.
>  * Add support for the extended guest request.
>  * Move sevguest driver in driver/virt/coco.
>  * Add documentation for sevguest ioctl.
>  * Add support to check the vmpl0.
>  * Pass the VM encryption key and id to be used for encrypting guest messages
>    through the platform drv data.
>  * Multiple cleanup and fixes to address the review feedbacks.
> 
> Changes since v2:
>  * Add support for AP startup using SNP specific vmgexit.
>  * Add snp_prep_memory() helper.
>  * Drop sev_snp_active() helper.
>  * Add sev_feature_enabled() helper to check which SEV feature is active.
>  * Sync the SNP guest message request header with latest SNP FW spec.
>  * Multiple cleanup and fixes to address the review feedbacks.
> 
> Changes since v1:
>  * Integerate the SNP support in sev.{ch}.
>  * Add support to query the hypervisor feature and detect whether SNP is supported.
>  * Define Linux specific reason code for the SNP guest termination.
>  * Extend the setup_header provide a way for hypervisor to pass secret and cpuid page.
>  * Add support to create a platform device and driver to query the attestation report
>    and the derive a key.
>  * Multiple cleanup and fixes to address Boris's review fedback.
> 
> Borislav Petkov (3):
>   x86/sev: Get rid of excessive use of defines
>   x86/head64: Carve out the guest encryption postprocessing into a
>     helper
>   x86/sev: Remove do_early_exception() forward declarations
> 
> Brijesh Singh (22):
>   x86/mm: Extend cc_attr to include AMD SEV-SNP
>   x86/sev: Shorten GHCB terminate macro names
>   x86/sev: Define the Linux specific guest termination reasons
>   x86/sev: Save the negotiated GHCB version
>   x86/sev: Add support for hypervisor feature VMGEXIT
>   x86/sev: Check SEV-SNP features support
>   x86/sev: Add a helper for the PVALIDATE instruction
>   x86/sev: Check the vmpl level
>   x86/compressed: Add helper for validating pages in the decompression
>     stage
>   x86/compressed: Register GHCB memory when SEV-SNP is active
>   x86/sev: Register GHCB memory when SEV-SNP is active
>   x86/sev: Add helper for validating pages in early enc attribute
>     changes
>   x86/kernel: Make the bss.decrypted section shared in RMP table
>   x86/kernel: Validate rom memory before accessing when SEV-SNP is
>     active
>   x86/mm: Add support to validate memory when changing C-bit
>   KVM: SVM: Define sev_features and vmpl field in the VMSA
>   x86/boot: Add Confidential Computing type to setup_data
>   x86/sev: Provide support for SNP guest request NAEs
>   x86/sev: Register SNP guest request platform device
>   virt: Add SEV-SNP guest driver
>   virt: sevguest: Add support to derive key
>   virt: sevguest: Add support to get extended report
> 
> Michael Roth (16):
>   x86/compressed/64: detect/setup SEV/SME features earlier in boot
>   x86/sev: detect/setup SEV/SME features earlier in boot
>   x86/head: re-enable stack protection for 32/64-bit builds
>   x86/sev: move MSR-based VMGEXITs for CPUID to helper
>   KVM: x86: move lookup of indexed CPUID leafs to helper
>   x86/compressed/acpi: move EFI system table lookup to helper
>   x86/compressed/acpi: move EFI config table lookup to helper
>   x86/compressed/acpi: move EFI vendor table lookup to helper
>   KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement
>   x86/compressed/64: add support for SEV-SNP CPUID table in #VC handlers
>   x86/boot: add a pointer to Confidential Computing blob in bootparams
>   x86/compressed: add SEV-SNP feature detection/setup
>   x86/compressed: use firmware-validated CPUID for SEV-SNP guests
>   x86/compressed/64: add identity mapping for Confidential Computing
>     blob
>   x86/sev: add SEV-SNP feature detection/setup
>   x86/sev: use firmware-validated CPUID for SEV-SNP guests
> 
> Tom Lendacky (4):
>   KVM: SVM: Create a separate mapping for the SEV-ES save area
>   KVM: SVM: Create a separate mapping for the GHCB save area
>   KVM: SVM: Update the SEV-ES save area mapping
>   x86/sev: Use SEV-SNP AP creation to start secondary CPUs
> 
>  Documentation/virt/coco/sevguest.rst          | 117 +++
>  .../virt/kvm/amd-memory-encryption.rst        |  28 +
>  arch/x86/boot/compressed/Makefile             |   1 +
>  arch/x86/boot/compressed/acpi.c               | 129 +--
>  arch/x86/boot/compressed/efi.c                | 178 ++++
>  arch/x86/boot/compressed/head_64.S            |   8 +-
>  arch/x86/boot/compressed/ident_map_64.c       |  44 +-
>  arch/x86/boot/compressed/mem_encrypt.S        |  36 -
>  arch/x86/boot/compressed/misc.h               |  44 +-
>  arch/x86/boot/compressed/sev.c                | 243 ++++-
>  arch/x86/include/asm/bootparam_utils.h        |   1 +
>  arch/x86/include/asm/cpuid.h                  |  26 +
>  arch/x86/include/asm/msr-index.h              |   2 +
>  arch/x86/include/asm/setup.h                  |   2 +-
>  arch/x86/include/asm/sev-common.h             | 137 ++-
>  arch/x86/include/asm/sev.h                    |  96 +-
>  arch/x86/include/asm/svm.h                    | 171 +++-
>  arch/x86/include/uapi/asm/bootparam.h         |   4 +-
>  arch/x86/include/uapi/asm/svm.h               |  13 +
>  arch/x86/kernel/Makefile                      |   1 -
>  arch/x86/kernel/cc_platform.c                 |   2 +
>  arch/x86/kernel/cpu/common.c                  |   5 +
>  arch/x86/kernel/head64.c                      |  78 +-
>  arch/x86/kernel/head_64.S                     |  24 +
>  arch/x86/kernel/probe_roms.c                  |  13 +-
>  arch/x86/kernel/sev-shared.c                  | 554 +++++++++++-
>  arch/x86/kernel/sev.c                         | 838 ++++++++++++++++--
>  arch/x86/kernel/smpboot.c                     |   3 +
>  arch/x86/kvm/cpuid.c                          |  17 +-
>  arch/x86/kvm/svm/sev.c                        |  24 +-
>  arch/x86/kvm/svm/svm.c                        |   4 +-
>  arch/x86/kvm/svm/svm.h                        |   2 +-
>  arch/x86/mm/mem_encrypt.c                     |  55 +-
>  arch/x86/mm/mem_encrypt_identity.c            |   8 +
>  arch/x86/mm/pat/set_memory.c                  |  15 +
>  drivers/virt/Kconfig                          |   3 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/coco/sevguest/Kconfig            |   9 +
>  drivers/virt/coco/sevguest/Makefile           |   2 +
>  drivers/virt/coco/sevguest/sevguest.c         | 743 ++++++++++++++++
>  drivers/virt/coco/sevguest/sevguest.h         |  98 ++
>  include/linux/cc_platform.h                   |   8 +
>  include/linux/efi.h                           |   1 +
>  include/uapi/linux/sev-guest.h                |  81 ++
>  44 files changed, 3524 insertions(+), 345 deletions(-)
>  create mode 100644 Documentation/virt/coco/sevguest.rst
>  create mode 100644 arch/x86/boot/compressed/efi.c
>  create mode 100644 arch/x86/include/asm/cpuid.h
>  create mode 100644 drivers/virt/coco/sevguest/Kconfig
>  create mode 100644 drivers/virt/coco/sevguest/Makefile
>  create mode 100644 drivers/virt/coco/sevguest/sevguest.c
>  create mode 100644 drivers/virt/coco/sevguest/sevguest.h
>  create mode 100644 include/uapi/linux/sev-guest.h
> 
> -- 
> 2.25.1
> 
