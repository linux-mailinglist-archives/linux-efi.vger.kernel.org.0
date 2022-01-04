Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A75C484AC0
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 23:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiADWce (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 17:32:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21470 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235500AbiADWcd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 17:32:33 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204JSuYc013829;
        Tue, 4 Jan 2022 22:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=yOAK0R0htQwv6WcGg0ar/DzDTpvBft/u3SzkotG9foE=;
 b=rm3+Q/fO4cYE6vFb/1OD8oYZxV0y5pmfhxHdgK9F9DLP2ibWResM4hnsx+cXLODF7XhZ
 ttdNUV86cudriGq0J52ufRCBexaZaYkFae6pRwRWNEvFz9oCCfhLft6gcJFNQ5jC3tkt
 Fabdwe9lPBS4yxS5HUgrjdopy6y+baXsbj1Mp7MjSjBm7i1Nyb7ig2sDXNBBwWjEtJuq
 /vebvBioSyqNurekReX2Ynzr8ebIfbsuCpoWB6++vDUwFtNqpxa0m9RS5jBQkZ5gKA6c
 HAHquNIwwB0D9YCtmUrz65/TjLBbxhq80u9X0kmQtTm6P1x6a64nzdwaB3xwGpMFp0hA WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st3gda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 22:31:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204MVdBc059947;
        Tue, 4 Jan 2022 22:31:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3020.oracle.com with ESMTP id 3daes4aw5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 22:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpcHF2YVDQ+AcXx77T0FM8/lkxcx7UCeNMtGXlscF0XYwrvJFNA7EXEhh2rzDSFPsaR4VJrqRtSu5MlA1jyCRsTrnQNHEQL+f0eWsMHua7O7G3K1yeUPJdxw38q48PdJWtA4rJgwjCQce/QBJGR91sdNHMHaTxozni906Q89r1kuSeknsAhy8dNNBbG7j0B/fSnxFsQtLS4TFUy1z7IBz4SsfdVYcO7nFy2A1wNw7Lt0uBVfgPbk8TPjbIpXjuLiwXLXyqhYYD8S5wHDpL72JyRBG0QQ2IHZUOFwqd8TqDJd+GGZ5NyJEA/5xQu0c48QFD+9vlm1eZGoc0l8GryYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOAK0R0htQwv6WcGg0ar/DzDTpvBft/u3SzkotG9foE=;
 b=eTHW0Qj9KpfM/6xh/OU/EyYA1zPfnOE4qFKPULB/YtMUnzlCpwnfwzrE/6mSBwhkzg+x/yBcTSv912/tUpEdRFJ7Zduxci2WlxXDpX0TC1USgcX3ugM2yFajADwmQ7CHs8jIWNP6HGDkxVdCneqZjQPzTL1CVYryCa01h1oVOiO2wuTFtxwvr4FGotEJYR9sxwE/hUuXX5JpLf7rLafDmUwcVCRcpg1iFupbZr7GFyvedyz1mtOlVsfq3XkgOVA4kUphmGtAHiv1vBM45mLG06G+8+unbIafT4LfpXs1LP6OmSwEWLNUIfVJDgo3C/VjomjMsX60MS04JLh5ZgF8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOAK0R0htQwv6WcGg0ar/DzDTpvBft/u3SzkotG9foE=;
 b=WaPrE+LM4mec/H8XSQIgdu4NtjEP83HGTOUTwmRKJic1veFuEYopuslzb2OOU2KjtS7zEImH+aTforLK5uK/dAlCvImSfpZlfLfIWld5rVkWpN7ORb05z3bgsA5FVem4p1OHl9FXeehYAdeJzTd2X/OJ0xXfRbbnIt+L+kwayxY=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2573.namprd10.prod.outlook.com (2603:10b6:805:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 22:31:52 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 22:31:52 +0000
Date:   Tue, 4 Jan 2022 16:31:46 -0600
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
Subject: Re: [PATCH v8 15/40] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YdTK0h2ZKu4UxrhQ@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-16-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-16-brijesh.singh@amd.com>
X-ClientProxiedBy: SJ0PR05CA0200.namprd05.prod.outlook.com
 (2603:10b6:a03:330::25) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f8f182-298d-4f58-2f5f-08d9cfd2017b
X-MS-TrafficTypeDiagnostic: SN6PR10MB2573:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2573591A27E7A30107A81CC1E64A9@SN6PR10MB2573.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPKpCRUlKoojC/LKoODUhQ9pKZC/HSrg6pkMuCGx1jZr/NVFCvAsGoSNpzwrJ6hj4XrkIgmIeQgHrwE3V1tHi5pfB3XgXgj/8mwkoEuhgZyk+X3mlaYMReQrvtYslKkBZYN2OkVEwzGAOC2QHGkLWbshU2ZlcHlOFFEx1YyGv11myxW7vXHK9M1E8aNZSUkoQuYoaTQq2JD+TCyeoPeI/9f/qpj4dfvR9c98o8wXAFA3ZWpPdpabEQ0rrVdNkCSjMKYOJMOMBRk6K5rua39lnKaU9sllGKjXtZtXPcdw3OyYIRVx3NB/u8a2svEQ4RzKJGPE9nJAKc1fTIvUAF5L9PnPeDLpLucI0pGnEMEn09OfGl/7HzsRXunoBCgpjlF0jNOoU4JGXDUHyTVtfARCkYmQhnTn8CwC/MXBDAMjH8BwFtNBEb/lMK7kGToqxG+c7bBZhsoX/a7tbf2c43TyWQZ57KOBthLAlgQ7Lpo+wQB9vrlzXAEGPSa0Mm/ftskhZ+9dLShHE18RZ/KVqCmEh54/VxI/kNiBFs4toz5f4CCz8ZuHHhjbFNOr+Jz1yG4ZHjx1N8QA/0Lz1iGOsFLPUknPLsO3dhpIWqYw3nwLwwEO0Y5QTYXuGvqiMYnwY8IpmB4nlzhPMoZa6lzkQ1WOGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(26005)(86362001)(2906002)(186003)(66556008)(7406005)(7416002)(4326008)(38100700002)(6506007)(5660300002)(8936002)(6916009)(54906003)(9686003)(6666004)(4001150100001)(53546011)(44832011)(6486002)(15650500001)(6512007)(316002)(33716001)(83380400001)(66476007)(508600001)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pp+4LQRYVjkRutYkaIE1QypYxFgPTFy+SSdf2nKQX3zznfv6ugJso8onnM8?=
 =?us-ascii?Q?nZn5MH63X7RZ3rM02TgNdAdo2gVdyZqOOovLMkBG26ab/X2UY9aYI85x4rIE?=
 =?us-ascii?Q?cYU7Ncxj4UuGRGyRkrgm2hABWMnDzccNSJwy5tDoe11HPP+zf5T19LGc5+ta?=
 =?us-ascii?Q?V9B9QkEi8mkL5xthRr7Q7wRwZDYPqUIvEmEtM1sOi+L/dUlIkYTJG4k/B+J6?=
 =?us-ascii?Q?CuKu78CywnDpTFxF5YpvxFoonGzeAz3TxYiTtLqoJ9TJoqaALoI3tc02H79k?=
 =?us-ascii?Q?qBZzzH0Ggzg0tbQYDKXOw2GurSDW5zZIc2ybCw9lMn3v4eAwMZZaWTJavVDH?=
 =?us-ascii?Q?GHybFehlKR7Q9NXaQoWBgZ+0RAWkSNCIFlAmqMk/siTTScGaJQ3fEuPG49tp?=
 =?us-ascii?Q?jDYt3xBp6Au527HGGTEdstt9rUB2aG8Qh5l5plGQ335Qr1RkslDsw7JAxHjy?=
 =?us-ascii?Q?sMyZ0IzxtlJQy39RbLcFUl2s6WZ9xOSIC86LMrvgW8ro9d0qunU6EgNmUa6/?=
 =?us-ascii?Q?qeiFVW2R4KBTeDBS9KndXsTg6urCDJ6OqmB3XEvUBJ4qmRd+XSEVkcHyIX25?=
 =?us-ascii?Q?Y6DyTEc6GbI0y9IY0G6vl9RxT/h00Utbt7CAYq/SbzqMgDHge7DwHXTe+qdI?=
 =?us-ascii?Q?6GEMX8c0HzzjOuvJXGUIqz2EeUjBJlQ4HfOM97Tt1bjKLwu7Uia4Mr0k6To3?=
 =?us-ascii?Q?LY0I23nTNp4YoNF3o9vI3UuyhlzN1HY62rnjLCJwHIeDK1sHg2rmBeeS+UpV?=
 =?us-ascii?Q?E4Shacr1rcgIb5up6zgx6GVAKrkjO2GsFKbeT0sVfkmw6sHpoP0adqBsHvIK?=
 =?us-ascii?Q?0XHpjyUKlShqKEs8KFCsz+xwpZDdP9FNHJvROyEns0ug6/J3VeWY2WKXGb+S?=
 =?us-ascii?Q?VDPg3daeuJUO9lBIxCdZ672OxaIpMdmTNe/8PckKFO/Ln+naGEBg2V8QddQK?=
 =?us-ascii?Q?cvq1OfZycXHBrR/Mis8yIk6HPnKmZzY803pKo3fNBRg/3qr1nr5wA9UcP9qV?=
 =?us-ascii?Q?DXs6XOBaNYYlUQf93Jzwl2r81pXRvHHbuwJ3Rob/Bcx7nu5NXxuty4VCkTE3?=
 =?us-ascii?Q?och02UXyInFXEK91eJLWBd3p/tnHbDVzcBqGnmP81gkx19WJSTFebW/eucsP?=
 =?us-ascii?Q?T3z/j9wqWXkJEjZMSXmkG5fbLznoCYTuOPuBerrYnAompmWtI4Ptud6eMIPh?=
 =?us-ascii?Q?hcxBCbi6caFCmFTWHZJTTGFgtg3Nft40KbzLNAOOJWYH4mojT6MWKlPuuC0b?=
 =?us-ascii?Q?kleRmArOd5LZV+lapJk8gPcncfhDViTpLSInbX7yYYmg/6hOdPPY+dIUMtJL?=
 =?us-ascii?Q?JhKkHTuYoFXSwIv2p1JaqMcbU7FPd9BtvSEpnU75Qv30cjyITGVcTALp4j3c?=
 =?us-ascii?Q?9zvs8K4eSjJsWa6+4ezySBNCQ9IzpBorrqVMCRjBFmu4NDg7Gqhs5ZzmlJit?=
 =?us-ascii?Q?JCTv2A6FKXVqKUu9ekKzNuO3Ii6UmnscmrDtcCzb46VZLTMmGwEQnDu5cSIz?=
 =?us-ascii?Q?mENPrjsqREwIrVl7ogEg0wyy872z5dGtzpPbgTOoxFj2CNjdVb1LqDCGv6UB?=
 =?us-ascii?Q?YZL7C4bvqX5axUd9AH0H5/BuAItwVwEVXy0Buq5BQmNfgPozdOcQkok8pMVC?=
 =?us-ascii?Q?XMVj8btEohCxPDAaUlbzQF1eqiqNF6x8aSvukwSKrtEOnHIxlJDzknZBGlN+?=
 =?us-ascii?Q?EwVmUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f8f182-298d-4f58-2f5f-08d9cfd2017b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 22:31:52.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD9dOxYEUcGHpPi+FcpE0MI2nRGc8Gji2OBxabDWm4fYR5VtDKVsXZBUPVG64Re8Lnqwdn9I6ugD28W3u5g4ELmpIxdw9BnO+u3DxUyK2TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2573
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040143
X-Proofpoint-GUID: 9KfRaklx_0qArIExAAxuL1ymaxdhtVTP
X-Proofpoint-ORIG-GUID: 9KfRaklx_0qArIExAAxuL1ymaxdhtVTP
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:07 -0600, Brijesh Singh wrote:
> The set_memory_{encrypt,decrypt}() are used for changing the pages

s/set_memory_{encrypt,decrypt}/snp_set_memory_{shared,private}/

> from decrypted (shared) to encrypted (private) and vice versa.
> When SEV-SNP is active, the page state transition needs to go through
> additional steps.
> 
> If the page is transitioned from shared to private, then perform the
> following after the encryption attribute is set in the page table:
> 
> 1. Issue the page state change VMGEXIT to add the memory region in
>    the RMP table.
> 2. Validate the memory region after the RMP entry is added.
> 
> To maintain the security guarantees, if the page is transitioned from
> private to shared, then perform the following before encryption attribute
> is removed from the page table:
> 
> 1. Invalidate the page.
> 2. Issue the page state change VMGEXIT to remove the page from RMP table.
> 
> To change the page state in the RMP table, use the Page State Change
> VMGEXIT defined in the GHCB specification.
> 
> The GHCB specification provides the flexibility to use either 4K or 2MB
> page size in during the page state change (PSC) request. For now use the
> 4K page size for all the PSC until page size tracking is supported in the
> kernel.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

[snip]

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 2971aa280ce6..35c772bf9f6c 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -574,7 +574,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>  	}
>  }
>  
> -static void __init early_set_page_state(unsigned long paddr, unsigned int npages, enum psc_op op)
> +static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)

Is there a need to change the name? "npages" can take a value of 1 too.
Hence, early_set_page_state() appears to be a better name!

> +		/*
> +		 * Page State Change VMGEXIT can pass error code through
> +		 * exit_info_2.
> +		 */

Collapse into one line?

> +void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
> +{
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> +		return;
> +
> +	pvalidate_pages(vaddr, npages, 0);

Replace '0' with "false"?

> +
> +	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
> +}
> +
> +void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
> +{
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> +		return;
> +
> +	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
> +
> +	pvalidate_pages(vaddr, npages, 1);

Replace '1' with "true"?

Venu

