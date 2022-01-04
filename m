Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712CE484741
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiADR5K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 12:57:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46752 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbiADR5J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 12:57:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GIf7h013829;
        Tue, 4 Jan 2022 17:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aV/OgfM3SLXGO7B9cPAEOJRLJUDUJpkw/gc8iJCBYnE=;
 b=dIbkYZ1BHRw7OX9xltWhreYSveOyK1jPf+nJ9eXwIpHQIfxuNiG7gEQrM1RZ7Ikl+O7w
 N/BZgAQw4t3/0lcrGvu2VjnYjPkqY69wYsXJLYOaQv4YwhFsUVHOoWgdmiknJ+uAinAY
 j1o5M4xWL3e7j+Wt64yp34VMQ969MMoiGOBtp0ZWVmjQ8fa85tw8GKhHlMiXUULS53Ky
 prl+t7oTlfL3IG4XSRImHB5FIaLU9ndo22qtlQfHQc34ik9P7f8w963XaYV5dNiQyhzp
 o/PWG8fQUCm+UTy7ezHKB2ApsVuROqeu/iw3Bq9xdo5+mugTdTVcn+S9GKa+OyftG1a6 zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st2wd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 17:56:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204HtkQu184320;
        Tue, 4 Jan 2022 17:56:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3dac2wyh6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 17:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwYnHFObGCNgM9Qp0etkWtfIu6eOkIALQsMon5dh2FDbv3+J0EqPMxO1K0sc/TZwirWFPIRrLGzCi3NB0oqLo2V4NQW2dXuyiSm/7Gorq/yMUT31qWNeAu69vtuZvOwU2wYFv3smpZbpz1IOO+R5ornVAShYJ1B9UMD7J5LWEXyHigoTnOxegRAh1xv79DNzT5B9XNkVgo6SuFtf/mf7Goz32im19kq2m9gNPbL2Xa+zCjLINc6RDi0PO0glnL6mdV+vXMDgDHlr5y5+U66yjDyQZVF8/FsUuDfl9KpL327SbzbbrhKvVQrrDCcT6QESWfZu2Jzr7N6dYkI8MB1bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV/OgfM3SLXGO7B9cPAEOJRLJUDUJpkw/gc8iJCBYnE=;
 b=aADaRnRMJdk0bkgk2Svxs7LnqmIlQ0rjlsPvr4Fi8lv0vOj1MQPybTxLYILy6Mo7Jp6DyQ/0xXHbF+i7L/DH1wxUbTfUGwiEA8P9+lfjkzAWBDg70sZMv7sgilZY36duthtQPf5Qmr/K5QivYTGMF1odDgrwZ3lip1taEVQ+AcGKq0+pO2tgitefTqiGmOpSnbA3dRhx9LKA0GGB07cjQVWb7tdVs/0Ue1GGQlPNMWZugARQCKadOuNTHSEVLbEAH7U92/Iq/UnyOqXG5bWgw7PxwBV1oUKKal46mRNAtz6z86eYQd7Ia0Agaer4MHSSz9/pD7I/MxjFIRMn4SzCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV/OgfM3SLXGO7B9cPAEOJRLJUDUJpkw/gc8iJCBYnE=;
 b=Vt0iXkZ8UpM8je2Vv8CRDJ7qBK7qAAmfugEA0S2yaTtsqlu3B3KGAS7Uv3vs50Rpx1VMdpF5c2YItp3DG5Sij/fr9RwrRVTRw5X2ieC9xlptPlmk5+dirlIA8zVvynqGRjn6S5qaroFpIj5MOpIuRYoHCQsj7cxoWQlCuf7+Fb4=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2462.namprd10.prod.outlook.com (2603:10b6:805:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 17:56:26 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 17:56:26 +0000
Date:   Tue, 4 Jan 2022 11:56:16 -0600
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
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
Message-ID: <YdSKQKSTS83cRzGZ@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-14-brijesh.singh@amd.com>
X-ClientProxiedBy: SA0PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:806:d0::32) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95e79e83-aeb6-4036-137d-08d9cfab86c6
X-MS-TrafficTypeDiagnostic: SN6PR10MB2462:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2462482AC262A5089C774DD2E64A9@SN6PR10MB2462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oujahH+ZiVXz/2GGXbdWZrhw3vNEVL9+nexdHhZINQSNdQuXT2SsvD24vT/qgHob0pbmAuEpt7oHyxqwudB2M5x25/rPvKZm0TEkDEYWWhYNxcg9PVt3vpHuXUO68r+ex1r4Yh6tfz9Oy2Igbgr05iqlSCp/tDC3/9hxPIly4oDCZ1ZEedbjKpNqxfbEvLbbQIw1AiKE74rLRqESsUZnz6fY1y39+HZRb+pAIhzr8w9WqawEWdQG91u1Zp+cl3QOJfcaRqRY5XpsA4TL+oNmErecFB+2thqO8jrk2dGW2AO4IB7Zy8eQtBtBJOrjIgPZ8RflLiDN7GdGXK8FvDzLCPLJ6OV0b91gEWn9Az1HofJar4+/Uo0d+EhbIji9Q+pYva4d4G8syy1RHYU//NPdLYXblKUmSph8r/cJXEBJnYHb5Jkoy5jz0xMfPfsMoxNSkF1JZ4TeTT1GxLukWlKX2KEf4+o8B0wPjk1rK6uVi/mRuqqStZC5Kmu7W+RFmrWJdjFM4eRT7lI2K+xcA8nljLN5BV439nCo/CZA63R8Qh0wASnJkCOJDOv1d8UxSvpmUyJpgDRZk4MfBFp52JpOgRLTL9sv2Ad/93M65Dv/sJKVDLHjs3Q92VPkaBJJ+hx+5SjH1MRu2lgGJ9EXDS5f7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(316002)(33716001)(6486002)(186003)(6666004)(86362001)(44832011)(54906003)(508600001)(4001150100001)(4326008)(7406005)(7416002)(66946007)(6512007)(8936002)(66556008)(2906002)(83380400001)(66476007)(38100700002)(53546011)(26005)(6506007)(8676002)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZyoPmZmAFotav5XoGCHsrUEht4eIPIcbDv4UqTu+5jA3QB6v0FWIYmV48tp?=
 =?us-ascii?Q?l0c/TiPRs6UBz7kX4LKFCZpvrQn6eQpjf0b7Y8WUHV2HD6/pdAZp4G8L7uVt?=
 =?us-ascii?Q?U76AAtlL9Tk5ZvDMS36WMQ9pM7Kfss3+/tnSR5lF9Cj0GAS8SzVz3TSjiWpX?=
 =?us-ascii?Q?a4iabGKK2cOPCi6C18sxoNHvPAU6HqMLJMVgLGTEHHdv3J4djsaOTsADZqLC?=
 =?us-ascii?Q?7CUKoFmn5L56Tm6EllSk4jQjzNj5j/mAEZBNfM23aeO7VAnKajipy13BT2Af?=
 =?us-ascii?Q?XsArQvlRvSkFFGcydFJ70mBmOl08zfw7kJ7Kj2xnBuaYEOdb6Asn+YfPp3qm?=
 =?us-ascii?Q?Nwz0u2KS8/q5M37bx2PIx9QWR25p8mEwXsrHxCGR4gsCKidpYkCluLEPHlBM?=
 =?us-ascii?Q?KXcWwX4FENW42EymeW+Cdr0UCMsjinoJ9Fi7rSd11ZenlSWf6iYP5Vw/CxAk?=
 =?us-ascii?Q?sKMtjBW9ynU4MFnOwwDnxat+sMZguqJiL1QCdXlhyGHroQgw2EjLsaIVSH++?=
 =?us-ascii?Q?nNPlysXEIckxf1dhEJqxB/8TaWF9geGfOB7XzQ9ARxahlPkJy53LKC7JbOeF?=
 =?us-ascii?Q?60rf5QST3R8A/8r5Xn1ayhLiDoL8mBdvOhtsF5b6hHi9Nf8tJYZT01K6WdFh?=
 =?us-ascii?Q?oY1hwEqE6PMTVvRlJ0K89Aaw7vLH7RnVrX1sPAO9nV/g+S9fzxKfp1UA07+1?=
 =?us-ascii?Q?2fmxrWoDMOUxR3yVF0Xhe/hQwu7FFd+tbDZDY9zim340CnzJ9xr/es2P6KdC?=
 =?us-ascii?Q?Ag6pXOD88nWtQdeQw5frJ0G7JCoz2kS5GY/CK0hHvoZRIFD6H/UemHXdbQbX?=
 =?us-ascii?Q?F2mrcbs82N4dQZM8NEU+lhj46ZTLMXpkjBi12gTsSQdmfjVYaEZiwd2BonL2?=
 =?us-ascii?Q?frdRyKieEhcBTqW5Y2HX5ug0UrTklDB2Yo89KgITuD+IjHyTkf3bsJQI2IuC?=
 =?us-ascii?Q?VjHoO8X8PeIpIu2fqFnah28puavB23O3aCiMlih81T/cZQ9d3s4oPRwoGPvq?=
 =?us-ascii?Q?rW+nvrbY2mEvWkvtcrWVM+KiTGBXQc9CisOvtnl6BMk8vi6Bcdm1Nr+YDytr?=
 =?us-ascii?Q?uINmNXEJFgZHloKbFA7earnF34YID7H/A1QtXQWuN2Ts2sOTW8mGACKkyM3Q?=
 =?us-ascii?Q?vc1tyYXlxTW/vbxtF7uHaTGW5UvAoqDLlwbReuelQY6KfsYumt2FU4LAhPe5?=
 =?us-ascii?Q?YB7uLP1NK9gAJCMLKLUMJJ4ooV3qzFze8Ze/6UgvIKFD4P9cBGPFS/mPEfcU?=
 =?us-ascii?Q?jA1F7zlVCOJB4DXFICMbcOeDLq5j5PK2a845FhWg3E61CGRhAoa3LuefdFLj?=
 =?us-ascii?Q?6gEG6NgtzcewUp/VRDk38gc4kaAobFsG/JP/ZzjrF2gm0NbtiiTaEuzmA8VW?=
 =?us-ascii?Q?ZyvUIlxc5tAbbZRvSHIOeSsE+0kCy1ui9eITHBiRcI7LqyOFpGLnGUFH9cs2?=
 =?us-ascii?Q?iV6AAR1PvbuVCGtWwx/hU6yYlZ1sNAPBaCXrQpOpYoUqF8nRsIx7YVRTDJFM?=
 =?us-ascii?Q?yatrhyLnvn8gKw2BK/E4O/3FrqFDB5lM+VMFGg32ErbgE+f3PIKAsFtkuOn9?=
 =?us-ascii?Q?ARzCtLO79pt5BhGovLCX1OrLeBibipLeKdPwWnLklAc/QIlUw6CdM8cbSjpt?=
 =?us-ascii?Q?7f5u5sxY475bZQKFkS81xQfBF3hXhktgxjWDJY2aW5pa7KnYwxxFpyQjCHWz?=
 =?us-ascii?Q?cPZHjQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e79e83-aeb6-4036-137d-08d9cfab86c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 17:56:25.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVWDPR2Hd6uypnzbt4LpczHLQ5v/1tKC/TzoaxA1bRoAwLjzbIFS+9lLXcMqOYRY1vgW9KQlQfK9YU8stfTmPfx7KJ6wRNLLMj8s/SS9avo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2462
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040120
X-Proofpoint-GUID: CXsZh6t48v_8KWiEHYhlqld48H-CPeJn
X-Proofpoint-ORIG-GUID: CXsZh6t48v_8KWiEHYhlqld48H-CPeJn
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:05 -0600, Brijesh Singh wrote:
> The encryption attribute for the bss.decrypted region is cleared in the
> initial page table build. This is because the section contains the data
> that need to be shared between the guest and the hypervisor.
> 
> When SEV-SNP is active, just clearing the encryption attribute in the
> page table is not enough. The page state need to be updated in the RMP
> table.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/head64.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index fa02402dcb9b..72c5082a3ba4 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -143,7 +143,14 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
>  	if (sme_get_me_mask()) {
>  		vaddr = (unsigned long)__start_bss_decrypted;
>  		vaddr_end = (unsigned long)__end_bss_decrypted;
> +
>  		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +			/*
> +			 * When SEV-SNP is active then transition the page to shared in the RMP
> +			 * table so that it is consistent with the page table attribute change.
> +			 */
> +			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);

Shouldn't the first argument be vaddr as below?

   			early_snp_set_memory_shared(vaddr, __pa(vaddr), PTRS_PER_PMD);

Venu

