Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B799B48B9F3
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 22:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiAKVx1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 16:53:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57024 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244453AbiAKVxY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 16:53:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJO67p019147;
        Tue, 11 Jan 2022 21:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2H5Wg4txvEfKvOhUbzDzkGIZsIxoIAbeL9o4tNy2Qrc=;
 b=qOeVVrZ4XMps0YWU2JTsWGwSCKzHB83bUFhWmooeZxuIo1K/2Wpq114HIB9mntQydk4o
 tKctaFYcBWNTd3JfUm7ltKOVpAZyjYYiq9Ac4Ha15bdr3x7ELWoLj26GMaCFQUxj2jpA
 n5d+tEn/ruZsyC8loHe5PbeRCZhK1RcYv5sU+EeOX3PEeksDWU0PMHhGxo351Ubq7lqO
 cvG0hbbZ9V7P1VDjUm2kgAVClXvv4TJ7fFzNjVqqJreGuXMzy4K4FPcUJeGEbL9a0y/1
 fs3vTgs1QEi8T8zrCPucPWMVb9PQeCLHf+OOmzvp6aXjO6MVyNJF37V0IqnTA2jTazvN XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nmaa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 21:51:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BLkAH6181554;
        Tue, 11 Jan 2022 21:51:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 3deyqxuqnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 21:51:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/KpF+xJOAoVE+DMS7eaZp5A3thXzSAU67TTlRO/LH6qubDcf2WCQWJsx89WjoY7FSrZA+XHKDfDfl3XPc1L5vG5fMsbvW5N+MRAUqm9KSm/WWAqqvosdjQ2H3moatAalbkc9hICf9DoBg/soAw7or8OHlksEICEo2+lTElILQ5XZ2hYxZ104H1uPpEmwTkVSvsDpkPAU32ib+wQ2tGLT97Mii+zrGtV9TDMe6exg/PN8JjoGVLIN6Idao6ssnK3OM7Q8hPHkft96/KUHw1zZwXCBjrJF4nzW6edIWR5R69Nd+4A7vbgW/OlASaRznamquSK0RKf8KXoWgkEo7t+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2H5Wg4txvEfKvOhUbzDzkGIZsIxoIAbeL9o4tNy2Qrc=;
 b=PV+ko7zOZDUH66OMVg8jSxef0gAbbnNZ9xnrTjB6zF/tSl9i4pAVakMSnJ2661+1OQmbp1SjlNjoM6WolJj566PLQ7Arp9DidG5Rhcc1vFTkjUJgKv2maZ0tM3Xpmi6yfU2wg4WdRlgBdtF7BV/2SptzNE8x/6InhRKjTtTPHp+uIn80tB8Q0azyM6FID7oAXC1tDaAMEgFBlVbC8fVt4Zz5FVvnd8IKDAQUo34QSjROhXdbOyAn3ZXW+nm8N7MJEdNttvTHXt5BZvoOkkTcYi6icV32qDRYUnOdRpuMUXlnkdFK7OxySQlsI6Xfa8uYKBt9cYIrkTGznyrvfqt0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H5Wg4txvEfKvOhUbzDzkGIZsIxoIAbeL9o4tNy2Qrc=;
 b=qVEoaKnB08hU5Kr7Yz2NDnWdOVqvrrOhYIimQ0H/jpVwwHhmAoa3evC0iGwHCZsRu4wCvdfaR0ItqDcffCPg7IIxPDvklL1LtNqlOFF4Hrkt0GynvQ0o5n1+jpqKdzT0A5r/gbHManolU2N0SqAAPjMZvJegpl2+UhK9UMidn20=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2893.namprd10.prod.outlook.com (2603:10b6:805:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 21:51:35 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:51:35 +0000
Date:   Tue, 11 Jan 2022 15:51:29 -0600
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
Subject: Re: [PATCH v8 12/40] x86/sev: Add helper for validating pages in
 early enc attribute changes
Message-ID: <Yd374d2+XdBD+vTM@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com>
 <YdOGk5b0vYSpP1Ws@dt>
 <7934f88f-8e2b-ea45-6110-202ea8c2ad64@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7934f88f-8e2b-ea45-6110-202ea8c2ad64@amd.com>
X-ClientProxiedBy: SA0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:130::10) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19359e98-2caf-4fc6-7d28-08d9d54c8959
X-MS-TrafficTypeDiagnostic: SN6PR10MB2893:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB28938289459D297D670959BEE6519@SN6PR10MB2893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bxpY5tNXiYO7udzPhKCArQcXWwltWt2rYjBBqCQR/klv0Uawh+NkrCFnaH2p+6QTGw6xr7BQ0zAPc8NYgxTD7nQzjBUKZIPrBwFyrPi7FJ6qdpFuCASTnFvFNsqsRIU0RcR1/4I3//+/1rW9Q1q116yptQZRZNBt6HjDUrZUmqsuuB/XY8akhpFPY/M4jrwGb1oh2HMjn4uznKFUQsxuxNDktdUoqidt817/K7ZnaoiCNjAWaUPNEZKkcJrauKHRC8h6vQAtKDSRax05axtGsFrEjbZmGJ8+L4SE+VpC6xrJqAUwawiIpbUQG/hPwO7SAGuOeSs0Z1ERgUDKk2ILkNSpPYP5Q+nKu1Aevjc2meliCBSN9L7QqcC3cG90VbgQGiR+O+c9FJKS8iKxooHsTjWxamyg+P3B01bSU1kqvDfSuMilMqp3eUUeUmrcAZVgHhidY8zywFd2m0AbjsMr3CgbPP7VaqaIFE5y0R4rcj1OIRmI9LZhzb+4Orq7ovo3a+b01UkWLFKoCTAJ4XbDfQOS2n1EMGeyV1VyQMLQS05cM1POfhYvRByHT4ruFFCTVUQnHBq/4d19AQgv/el0vQ8gRxgWn0CzvC9cC5C6J99U3q6oHmgYyVCNlWma6By6Sgd7P8jWv+H1KAde3f8fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(508600001)(6666004)(66556008)(66476007)(66946007)(5660300002)(6916009)(4326008)(54906003)(316002)(6512007)(9686003)(2906002)(7416002)(7406005)(26005)(6506007)(8676002)(8936002)(83380400001)(33716001)(86362001)(186003)(6486002)(38100700002)(53546011)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TvWw7zu5XZFR1ynBbo0bd/h7grFNi1TQgSPJZLUUOsLcLrqud5vovdqGltUf?=
 =?us-ascii?Q?jKyH9eY1SK0kxqvd0yDc6DDYmqa2WEGN/VcFUn3tV/9eTFCvFzvMOxjAJ08K?=
 =?us-ascii?Q?M3oJ5I0ePCV2ss5iLCQPz70cv+0wXajkWfHMxCaJaRmv6s6FSAPuVBk04mNc?=
 =?us-ascii?Q?XU48FoknV6CXmhF9+HYYWijFKVVeD7oT5CO1ADSOM4w8PpjwrFxwcw4eVmMc?=
 =?us-ascii?Q?JQnWOxJyL1vpjXSAKBRzrEgtc9wzKaIR2GgX26rwV88opD9AK4e1lJwCl9cc?=
 =?us-ascii?Q?kG0/lOpWhwVoPMaL7JyoIZ04YjGQD0mWUc0q2QRvIofnLvxF1nD09MebJObT?=
 =?us-ascii?Q?7qt25RyiSGy4hUBys/u7A+0XrDC11DZQ7o0pqQ93sHM+jyrL6sgXuGpM7esb?=
 =?us-ascii?Q?4cfF0EOhIHhAnqHH75IbrtziSiHC4CHcuS3Be326VvrKkwJw7DpePeKi2lWa?=
 =?us-ascii?Q?q5aeWH+8dkiZd6E62HI5x7iQ0KD17Pp2Gtigi4VsETywBlF480sRI/zrZmPq?=
 =?us-ascii?Q?IKfji+ggSs0TGAL15ayeRNLCRNTIOjvOb/OoJvXgWfchFjeN0y/BI9Ob4cUS?=
 =?us-ascii?Q?e6VcMFQ8g5BS//UGSfwqP1q8De5fWgPdH8R+QO9WTVTXxg4zz7Abz13ECgFZ?=
 =?us-ascii?Q?i5/U/8oVaRkRXVaS+7A06PL1VWMnMKNadaEKSfuW3EZZbo3eJjTl54ORwLJI?=
 =?us-ascii?Q?jYcLqf0cLomvb27WFemqnIFhcu/B/pFcMojEDVf3gDIm8svIIQ+T2lyv4grv?=
 =?us-ascii?Q?x2w0Gu1f2wpTB3twdkTFzGzVWslNbTZGr1KmjL33uFdlBo4zTIUxRnZfu9bO?=
 =?us-ascii?Q?7KnNQGci1VQv+ewLVeBjeBw7pDUct81tyv8oH6e+BE3mX0tYiJx6crdPOMr4?=
 =?us-ascii?Q?pMnvmCTgLnDc2go+lfgp2Zn7PuYifRx11974eetqP0UZXQjuZDV8NjW1X0zw?=
 =?us-ascii?Q?yl2VYGnDOXZMh/d9gX1dTWWIUModPuCnHfyf4JmDT1cS76HVFBiTKhJZm71/?=
 =?us-ascii?Q?tzRj6CcqDdp+EhbkpIZwIEdxl28ADlik7mKGsI6YiQYrBvvWXH7jogs3BGk9?=
 =?us-ascii?Q?F39NZm9eLYsU8XzDHzeE258Lo15UwwWdat3QNGTbtcrVmjlFdqt+EhyTpCgV?=
 =?us-ascii?Q?Qhc8Se3HZpbpLBsjqN4WT1CKJ10XH88Ib0fQPBKFuXH/rXLy7JaMNQUTYOdC?=
 =?us-ascii?Q?HHwd1mLQ3G0z0DHHFUvMJqioVSxoEDBOA54uCeb/UtX40kp5FEimIy4m3y5L?=
 =?us-ascii?Q?9JTgAGwYYy+C5KFQCBCWMEd0733rDIIBZQnZiIuqZucs1zQeTohqjadpYvH1?=
 =?us-ascii?Q?KMFSQ9xgKrB1wtZCnEzDFTseWRAsKBgP9eMCN7E9FbK8lxzBiCWWjei+HqVI?=
 =?us-ascii?Q?l8yg/5hqvjucwiaYQ9ZcIC9aets8ybGwyJJ/rfrzkLN85UmbW6jtyMVB8AVA?=
 =?us-ascii?Q?9OJyrYmOJEdW69Fk58kphUWnpddBwFWN1FWE5JJJrgLLWIbVfrz0kK965LfC?=
 =?us-ascii?Q?22WTr/gzJhROR4Cp//3vo/tBbB2zKd5XTKEZybGoNhDDTrVJyM1fT6SUips/?=
 =?us-ascii?Q?/ZhVWqqD/AOe1zTboeKJXYFfTOi7P93jdKuNClt5Go/A0/oo2RvigbzRg3+7?=
 =?us-ascii?Q?/rt+YgQgA9EF+SbEHeCia5mDApPNEz4nw9CsAaYPEI2Vrbv0wEQ1xM2IQLlv?=
 =?us-ascii?Q?ucHgDA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19359e98-2caf-4fc6-7d28-08d9d54c8959
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 21:51:34.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jVCTiv7KhhUR/y+MDX0S5HjkgeqrYEpGSVSJNU9nXdSNqWNLwr194TVKK3ZObYUX25SNDeg+9XrcaB5OBnjZj8J1OnpSmSdByH15ZYN2K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110113
X-Proofpoint-GUID: p5eFSxbNhQxgbQPqQ_lFNnRRt04lfmJz
X-Proofpoint-ORIG-GUID: p5eFSxbNhQxgbQPqQ_lFNnRRt04lfmJz
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-01-11 15:22:01 -0600, Brijesh Singh wrote:
> Hi Venu,
> 
> 
> On 1/3/22 5:28 PM, Venu Busireddy wrote:
> ...
> 
> > > +
> > > +	 /*
> > > +	  * Ask the hypervisor to mark the memory pages as private in the RMP
> > > +	  * table.
> > > +	  */
> > 
> > Indentation is off. While at it, you may want to collapse it into a one
> > line comment.
> > 
> 
> Based on previous review feedback I tried to keep the comment to 80
> character limit.

Isn't the line length limit 100 now? Also, there are quite a few lines
that are longer than 80 characters in this file, and elsewhere.

But you can ignore my comment.

> > > +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
> > > +
> > > +	/* Validate the memory pages after they've been added in the RMP table. */
> > > +	pvalidate_pages(vaddr, npages, 1);
> > > +}
> > > +
> > > +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> > > +					unsigned int npages)
> > > +{
> > > +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Invalidate the memory pages before they are marked shared in the
> > > +	 * RMP table.
> > > +	 */
> > 
> > Collapse into one line?
> > 
> 
> same as above.

Same as above.

> 
> ...
> 
> > > +		/*
> > > +		 * ON SNP, the page state in the RMP table must happen
> > > +		 * before the page table updates.
> > > +		 */
> > > +		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
> > 
> > I know "1" implies "true", but to emphasize that the argument is
> > actually a boolean, could you please change the "1" to "true?"
> > 
> 
> I assume you mean the last argument to the
> early_snp_set_memory_{private,shared}. Please note that its a number of
> pages (unsigned int). The 'true' does not make sense to me.

Sorry. While reading the code, I was looking at the invocations
of pvalidate_pages(), where 0 and 1 are passed instead of "false"
and "true" for the third argument. But while replying to the thread,
I marked my comment at the wrong place. I meant to suggest to change
the third argument to pvalidate_pages().


> > > +	}
> > > +
> > >   	/* Change the page encryption mask. */
> > >   	new_pte = pfn_pte(pfn, new_prot);
> > >   	set_pte_atomic(kpte, new_pte);
> > > +
> > > +	/*
> > > +	 * If page is set encrypted in the page table, then update the RMP table to
> > > +	 * add this page as private.
> > > +	 */
> > > +	if (enc)
> > > +		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
> > 
> > Here too, could you please change the "1" to "true?"
> > 
> 
> same as above.
> 
> thanks
