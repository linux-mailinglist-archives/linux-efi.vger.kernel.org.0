Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5748390F
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 00:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiACX3n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 18:29:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6902 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbiACX3m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 18:29:42 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203K1NVI019409;
        Mon, 3 Jan 2022 23:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dPzT8KsScbWIrWLFqrwGewROxDnhGJs4SiRCGi8UKOA=;
 b=QO381llCR5mLKX+SZYtsC4gJmAlXR7qsxSUlzSlHWhyseLKaYHDbkbNtvyTc1uHhHoMG
 qvRZGLv1V4IoudFMu+H9Jl/EVsYKtQ00w9o5NZul0uilLTrrHlo5/teTEngGBkCEDKqN
 TjkvpVy0yGNUWzBoK6SgngaH/xnE9gS8b5E7Hc/Z1JJh1HYMJtyHZ6F/c6WS+aj1/dTX
 T+Inbonl7h5qNzgf7YOJ+cDXRHoUeahA523GuLscXAypXIXu6evkkfoA0A3WvD6h49sU
 jGkBeeNVsJaevKgvh48nCWx+D2zn0oXiFylZ2iOodpncxdxpsn3Lw90og0OG2vVHCUZU Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc43g8wb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 23:28:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203NG2PP049986;
        Mon, 3 Jan 2022 23:28:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 3dad0crakh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 23:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BubiV4v0snitB/7UX4Qhcw9lIV+r4YqdxtxX1SMUNMe+MLoQPLnEwPiDANvx9y/9Hn2N1SeCPR0WV7pbGaUHEz0LouR5oKRtPhi5QBNVRp1SnKuKGyD98Lx7zSVS1mRHh3YWXoWLLdNVQNtCGuEukqdZr7foRAYQR6tZeWmLHlBr90e8N6VFEdVkGmaehLeJTZJCAd78zXvOkH+Ljs5X4rGoaL5MG/BPbCjw3ythI8SPWWjJWoIEmIaLetQBh+xJrF5wxuQtvST+v8HoOwWI3xGTcejTtxHKgDJ+hGT0iwX0Vg1aBAaaOujbp7kZdDEXE0rhXJLCAjffhbQBhXUDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPzT8KsScbWIrWLFqrwGewROxDnhGJs4SiRCGi8UKOA=;
 b=IsPTjSFPkv9sYlw6HQj5WypYR6WGBGBrITKTLgYZcuDxrGMwkWB0sdtv9F0AF+kpxbJE5mMMnL5bxOgpQW/j3wZnxEHiY04z4lxLIOJYaY7S6RWldl3i8WlObHMJ9FjV5fqByGoSWEL1/AR5nsPlV7loCJzVpUSGI5Clqe9x2XiiqSgmHpbLbUvOxVqdq7r1o/9NssSNykWPd0Liz+E6nC83eXYCDdYlTJXJhiSzrRVs1bAwhJGA+K7o7WeumO6WTyoF2rObTxc7srvUL9j055Zq/3LhXsspehFWCvO/b3ekvO/r9iQgZRxlj6ztKjClx0PY6WXye5sullAFitSgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPzT8KsScbWIrWLFqrwGewROxDnhGJs4SiRCGi8UKOA=;
 b=i+Fpp8dzGeKVtIHDzlRTRycFkK0R+d+WSNXyEkeMZbQf4ChYqTmK7aaXMJ0DVqao7eanIte7I/DPgZnJbKElppU5p3w7/n4FNEwrylmo3o0WJZY7B+gtKkxCQ52wA9mPaM5W7bDaVlVJm2jDJLeCH8hS3qMizzK5epHgCpx1yyc=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 23:28:32 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 23:28:32 +0000
Date:   Mon, 3 Jan 2022 17:28:19 -0600
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
Message-ID: <YdOGk5b0vYSpP1Ws@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-13-brijesh.singh@amd.com>
X-ClientProxiedBy: BY5PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::46) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b77e7dd-9038-4af9-c871-08d9cf10c167
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3022ADA00D0BFA172D4157D0E6499@SN6PR10MB3022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wX7eYj/Ts1gBnoDUxyBSeup5lONK2YDjPsFGTEWsJrpJrDd2wTg+Ku7NWcXwfwmU61kGHF9Bd24o5dzxzgJd6x9kwexl2/ipP43PJz0GKK0KVKrmM4/jGD0UXqNqkLtnD4uKOD56s+TXfaqbc6SRjuldGuiU+SEk2R8Z1UFIATQZR2FFF40ceXojaQmCxF6HMsr1dlcHmcn0C0RVTLOu3+p5DFqEiY5KlCQNcK3VRlogYud7sa1SKN0yVfYfSpHrdDYm3E5tmFohtbCRFXHiOW7KALSkiPhE3Q+K93PnGmtrA25c/eQwgq4Br/6uv9vR2Pa7+VlMytwiSiGHHS0+itd+vIP2oIDEAGRSdY4fxDqkOvSD5LvPw2gn+AYHaJl9v19aV7u9R+FhAW8lH8j3BD2cFw3Vntp0ppEZsPnf/QEvAUqPl6ZQ7OHrl7PXiEqojUVp6e9rXfk4lnFD7tXKa3IZt+1hi6v1/+j6H339qoxdyn2X6zF/ErdKWQPye9WYMCyjdBNjxZtM0O/84uwA89bXimd9KDbOipNFzCX5PiROpzGrw3hu9Jc+eXoSnAPApRMdfgCHJHPcd7M51KiN7czuRmHx+o44PPkBAQNQ0879MJ9sNq1OjqbXS+CFI0iJZIMfxfC6qy9eW1oS1OdDcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(316002)(7406005)(44832011)(186003)(7416002)(4326008)(66476007)(6512007)(38100700002)(508600001)(33716001)(66556008)(9686003)(4001150100001)(54906003)(66946007)(86362001)(8936002)(53546011)(8676002)(2906002)(6916009)(6666004)(26005)(6506007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OfBFvksm4vyra/TILSA8hFBqzI2z4FciJ7SHANLMFzpj4Bk3tCduiHEbW3Wq?=
 =?us-ascii?Q?02OJm1kmA/W9KNMuUUtjNvq1Yk4IdjPkD+DNPJ+AxvEu5by8/71OQB8NhdUK?=
 =?us-ascii?Q?fkp5klWGq5i4oZIUvrS5o9l6cRpl7PQa8TuLWe6SOTpLD5CbPxakzqFuHP1i?=
 =?us-ascii?Q?BEvxf+mmaw1SWasu2iSzBpuZFCzEtn//+8ykVmHMuO2fXUIaPyBiHkBNcnZc?=
 =?us-ascii?Q?gjapyDL/BJqQ4bAxmnfbChqFrcXTeeX9AxSZJaD7BKcW199k70ZyRUjiOvB/?=
 =?us-ascii?Q?oqGvPuEov9fmDB/Nx+oNen8O8JRdg+UjPp3cmkmGk4r4j4I/mb+6dHQ7aMAc?=
 =?us-ascii?Q?ZjsqAT+O0Wqd/acq3cr2sbCBEoOcSE8W8w2IaRpIsvOQRnoArowGUD8OCThM?=
 =?us-ascii?Q?NFdtLja9K5I2thQ3vw/062U8icYgZn+Yov3TRcUkhjl2CjiA/cAXbCCf7aiU?=
 =?us-ascii?Q?b89o+3VmSu94U0c4jusc0c8djZaPJt2hK1FHwDShf/ctETOZQJtAnlRatLgh?=
 =?us-ascii?Q?DcIEg702D6oEx3ZHGFHj0WOs8RtXChI/PwKY6i4z7qAXBOaf04TtbawJLFPS?=
 =?us-ascii?Q?7Vm5BpjoJmDaEyRywyxC1A2Y0zNRV4nO/qW3N1SIDobqQEtiIi1zNi3izdgg?=
 =?us-ascii?Q?9GTRMjowxHryj5YMcrA0AIWGenBuM1Gi7aL8sYNrOeS0B1d101C03dqEZMRj?=
 =?us-ascii?Q?ezjvAAne4jB5p3oSMoxT1c+NXdhUv32FWnk1aXoZmyyIWTAIVKeHAfWVC7ip?=
 =?us-ascii?Q?y9kz8OMloi/UNlkyYycuPkMqmM3kkZ1MWLr6su/d4YYYbfOeOMZHq5UJvW9u?=
 =?us-ascii?Q?RZY6fE5kPQcNbmG7QeDeJz7FV9IDPCzgBCjwN12yOHusUuwjgsQlxJiJ0MBs?=
 =?us-ascii?Q?3enMBPzjJ4uksQcP1mpUVB1cI6fd49bU74/FfhuX2B27Z4KIwrMAuDSPpUSn?=
 =?us-ascii?Q?74Z9KO7fSu9RVgGSgpUZeaMGMgb0pfLtPpO8EJsC8Yv+DeDQ+b+e0NU5+JXJ?=
 =?us-ascii?Q?eiOJBJ/E36B+ApuVV7Hv964P/ejYK6HTymG6hsE4bmd+ItMzjKQEJt9BHDmF?=
 =?us-ascii?Q?ST5wH4HkyFIVpKPmdT9Gs1hPe0qDRDR7eVnFiv37EZvqN9nqXNSx0Ur0lfDb?=
 =?us-ascii?Q?ZZPhr36h7s76KnhxZ+vLjjyf6VmH5oXd+LPA11Y6f41bRzT8oX3TqOAY6ufn?=
 =?us-ascii?Q?lGAIWpN9oVYX/H1abDYn3mdnfUToUWC3FZgrIwMWeDllyCGEJQuTJFFGKL0Y?=
 =?us-ascii?Q?r3g4iKfirfh5lheuju8rZOZyWNx5fUurnANiPWaOBHFQ+uR8Vhaq1naZLPEI?=
 =?us-ascii?Q?L00TWCPmM+BaY7PjrxHm4U2SJeHznqae5SQIa8MnmrRL1VOyxBVCgwfwGPB7?=
 =?us-ascii?Q?3EFRyHIyg8DWlDmbn8vmCzAvMQSaGajV43Q4sYKzqOwjp+2RNHer3+73tvZc?=
 =?us-ascii?Q?U7Omo+KgRtxSJLliWcU9494MoOLRXY3/MAdeMF94cpMQNluXKZBGpH55zsoW?=
 =?us-ascii?Q?h7+WUJTuFwIwd2H8Byg/khCf0balx5pR/u7ybKCR7zZbOI68p1RzAVV6oV1f?=
 =?us-ascii?Q?gQ/Dn74Bg56kQeoGTEkRi+2quHSOEOnncqs1AiLMA7jbO986vWh+mqWsg4fm?=
 =?us-ascii?Q?dNsGiRxVwKAeVT2qPXeFCr9DRcldhoGTmPduyvdTV/vG5OxtjpnVNNWrnXFa?=
 =?us-ascii?Q?AXDjGw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b77e7dd-9038-4af9-c871-08d9cf10c167
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 23:28:32.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0SBb5bmwFgSdHntsfrn6ljpS2L08EVLL9iEOzLsGOI1UlVpB4348eD7I+gA9hXVFdqffmhc7L1ahdu2VoEMGM2UEohRLO2n3OXC6c7AIm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030157
X-Proofpoint-GUID: Qfz8r0mQqiQxzL6hAvx18UN-RlzkM6Xh
X-Proofpoint-ORIG-GUID: Qfz8r0mQqiQxzL6hAvx18UN-RlzkM6Xh
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:04 -0600, Brijesh Singh wrote:
> The early_set_memory_{encrypt,decrypt}() are used for changing the

s/encrypt,decrypt/encrypted,decrypted/

> page from decrypted (shared) to encrypted (private) and vice versa.
> When SEV-SNP is active, the page state transition needs to go through
> additional steps.
> 
> If the page is transitioned from shared to private, then perform the
> following after the encryption attribute is set in the page table:
> 
> 1. Issue the page state change VMGEXIT to add the page as a private
>    in the RMP table.
> 2. Validate the page after its successfully added in the RMP table.
> 
> To maintain the security guarantees, if the page is transitioned from
> private to shared, then perform the following before clearing the
> encryption attribute from the page table.
> 
> 1. Invalidate the page.
> 2. Issue the page state change VMGEXIT to make the page shared in the
>    RMP table.
> 
> The early_set_memory_{encrypt,decrypt} can be called before the GHCB

s/encrypt,decrypt/encrypted,decrypted/

> is setup, use the SNP page state MSR protocol VMGEXIT defined in the GHCB
> specification to request the page state change in the RMP table.
> 
> While at it, add a helper snp_prep_memory() that can be used outside
> the sev specific files to change the page state for a specified memory
> range.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

And with a few other nits below:

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> +
> +	 /*
> +	  * Ask the hypervisor to mark the memory pages as private in the RMP
> +	  * table.
> +	  */

Indentation is off. While at it, you may want to collapse it into a one
line comment.

> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
> +
> +	/* Validate the memory pages after they've been added in the RMP table. */
> +	pvalidate_pages(vaddr, npages, 1);
> +}
> +
> +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> +					unsigned int npages)
> +{
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> +		return;
> +
> +	/*
> +	 * Invalidate the memory pages before they are marked shared in the
> +	 * RMP table.
> +	 */

Collapse into one line?

> +	pvalidate_pages(vaddr, npages, 0);
> +
> +	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */

Indentation is off.

> +		/*
> +		 * ON SNP, the page state in the RMP table must happen
> +		 * before the page table updates.
> +		 */
> +		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);

I know "1" implies "true", but to emphasize that the argument is
actually a boolean, could you please change the "1" to "true?"

> +	}
> +
>  	/* Change the page encryption mask. */
>  	new_pte = pfn_pte(pfn, new_prot);
>  	set_pte_atomic(kpte, new_pte);
> +
> +	/*
> +	 * If page is set encrypted in the page table, then update the RMP table to
> +	 * add this page as private.
> +	 */
> +	if (enc)
> +		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);

Here too, could you please change the "1" to "true?"

Venu

