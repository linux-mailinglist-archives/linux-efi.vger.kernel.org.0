Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C14737AA
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbhLMWhc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 17:37:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35550 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237073AbhLMWhb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 17:37:31 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL6oFf021570;
        Mon, 13 Dec 2021 22:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0AYou5OgtH1XR67KRsP0ZUi3aHIdZqjatMNI4vLEycU=;
 b=lS//FBR+YTLOIamjsix42RXzOcLXW++wZCRaCqP7IXT4Hd2vgVx8JQq2lfQrzcN6IlGH
 A7n+TPOJzHkYt44WKamIkKogvJnfRrw1Bcy8sFOwTkRPiQDAycG4ofJyQyMbcvo/HGUj
 +rBZwdDNiM9BobhNhuh5/lh/GQeLlYsk6yJ410aYkO3gLpRld0x6MvOZS9qbnCPPWXLY
 93KMnOm5YX31fefZXBccjOZQXPzD9/6q4hYnJ3O1bt6IrlT1OCtKDWQoyWgWl1ZarG6k
 es6nIRLyFgSTu1eco54ZTVZAvQ2/3IPsQKZpGRl8Qx5XpVkC++Oa/JqogFaczkp87a8F dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3uka4v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 22:36:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDMURtI049821;
        Mon, 13 Dec 2021 22:36:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3cvkt3mu9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 22:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NclVSF4vJe6fZHHrS6MNMM6HPV1hI9W39hHXjsJGjaf6uNP7XYdwbh8nU5rQr9s39DoppAdWrRuz4xIfu/TE2Q7NwfKCsG9l7QbCOhEEJpvm4pt8a1fqrf1gibKzXSgqZMBmLTqWB5DshGNNooeLVxPHqv9KohF52+xPAZNgUu02YzSqeBw1PwiQ+Mw4sbDo5UmngATgPAyqQWVegbLOj4B9n1ZgfOro0d+EFBSBpNb9wgtelkDDnB35fVT9gXZyg+wWGOiTJCxbbRe3fFNaowSjq83WEB+x3aDeHpCZcCGpyTBcQBJJwKVI5iXP2NpBGBYGbY206l5RSHD3VzDcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AYou5OgtH1XR67KRsP0ZUi3aHIdZqjatMNI4vLEycU=;
 b=UjgouGyshm9hbqKAWBYsspvk4k40MO418UNobEeyKWSMag2xyf5Y9dpaOYaVz8YgjiJuhA9ZkCFOV8MZqwzyYIw6/0sHIhDzsjFxZjm2tMAdWa+xZnEbzldVivTT738lj/xoK7XXmnwt4dHR4gOAHbOcxr6reVhwm0DYXIheDgh/htrWPnRgAjlpCVsIdz4iL3tXTDyulsiuSt4el8ZSXQsbQwO1cqXk23AzSnGSC25M58If1NUyOVvvSUO2NJ4YYdYh2x1FOlzV8SStW53SnhDFkwUlHClJq6Y7emvnmX2C1IIiaMZT/k1hJa4ueyby6ETCoW4jhNVTVL+aL0S3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AYou5OgtH1XR67KRsP0ZUi3aHIdZqjatMNI4vLEycU=;
 b=fwAqSE33blFHk6WnMqAc9UUZS0E52a3EtOcBU0jS9HDF1anwuJmSl+sJE2H7DizFBfvImxOWE9w8UrmLo1HzpivNSL8wMzyKipA53fG+NeyzME671zHKAJ63UcJMvcE4IuHGTL4OVoB+85UT8jLuCzDAOhmAnaz9nfFC/1E6HqI=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:36:48 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:36:48 +0000
Date:   Mon, 13 Dec 2021 16:36:42 -0600
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
Subject: Re: [PATCH v8 02/40] x86/sev: detect/setup SEV/SME features earlier
 in boot
Message-ID: <YbfK+tQ40+z9BUo+@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-3-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-3-brijesh.singh@amd.com>
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89c99c1c-5368-4419-9a72-08d9be890c94
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5622407D6F515E1FB87F37B6E6749@SN4PR10MB5622.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQY+trGQoTMzLCwkWHvCWP6GV0kfZieiqQvJop/sDfFRvYujZddK1Ad5NQ4QaWOND3ofsztalRaJNjg4OCHDMdG1V02rQbLx9JJQNrvTAPniXf7vdgD/poMEqLH/0zR8QLpkQj6QMTfgA3V1cZpWhJbcqwmVOpj1WJ/8YPWp83DPMj24oH2aEc8TGMVMVS6XTzm32gkoUL7PXQ1+S2SYBHOY4AgAaE48a2eDdCBEEhFhzHixjtXBNu3UQBh4yykAoLHClOHYWm0/MD31XzWQJwxdYMl9LhqSK5jNAjbjxnceAKIoUpvb1PNsGy9URuMRdPvLP8INuh0FwvFcT4iL1YvDrvAwJaxHEH9Smm8WrOQkVFX3ZYlWCpnIlXYQg9wjtjSoT1ADkBzsAw3R3zZp2KPwiBMX4/hfoengNZBE6z2RO30pN9Tzpb4uxVm6sfYjQ6ohz54M9bG2sYiZOYMaJeW3lSLvoY8YcS2qY7TJk0Whx3+1+gGK6XUDUelyeFKLsyub5dD/VHyLJAYe2mW1Sw1gU50vtvHP6mqGMmUmRO4rHdkCsIku8NfQSvRpZToHYn1xhUrwxzUmTi8whdm/Ex3XggaR1hkCcSRbycvnTxzL0J1M/x3xD2x6mAF2qtpwTu2pj8beVE53D+AWrRWN9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(53546011)(66476007)(6506007)(186003)(26005)(5660300002)(6916009)(44832011)(6666004)(2906002)(508600001)(316002)(66556008)(6512007)(54906003)(83380400001)(33716001)(66946007)(38100700002)(8676002)(7416002)(86362001)(7406005)(6486002)(4326008)(8936002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9jtdfCdA0obP1P6eDBTA9kZTdcdQBmsjCyUqzPUSV8UUJYf0kI9h/Ij297q?=
 =?us-ascii?Q?hLs1k1E3Rtef5WuSK0WivAHh5mf2b4jfT0tkwc6O1oWKHOwJylvYDjZwnolP?=
 =?us-ascii?Q?S/jxqKyApKnyz6ovR6V8Ucq133jzlcOVk41iIQM3f5lYBm3HS2E8S1HG0wi0?=
 =?us-ascii?Q?mAZppz0yB9VUtHIulZUMBBpuoYcRVJUMpHcYZPvsRwodAgfZvPCXexshmr/u?=
 =?us-ascii?Q?lYeRgFTgFM+2J+r1vsmdM6lMEeY2DHAPm52NPktf3d2YiyLY1b8nFtcYG8tT?=
 =?us-ascii?Q?ELrh9Zbul6tEJzXGP8RinVghcJH/EGWSBY+e2e+sN4ee4ddzGxDceIzoyGVV?=
 =?us-ascii?Q?JbNIQFtnvgj+966aAX+STjA0iJbBqxOX6P+hawLzK89QFdbEdoW6rw9mMacO?=
 =?us-ascii?Q?6B2hwx6Cfv7D9jBg3L9o1MBiu90m06N700nK/u2p/zCvooe10IwWXKSWzfJ1?=
 =?us-ascii?Q?RRSSUHJevOLbOMRfmD10LqbIwbnVpnLQOjAz66PX5HZC9qkdz3IYOq9zFcRV?=
 =?us-ascii?Q?TpajVl4Pbw9c2qgyWbzSGIIhKkp0m3Mdzh8NiheNsmypYibq+Kv+XxYq746d?=
 =?us-ascii?Q?RfJezHWjtr0F1zXMrVxPJtuxCCS0AIeam0grBmynvuwOkTTDyLMbY/Vv2+Y/?=
 =?us-ascii?Q?nrlL01wZYHgJw6BrlOk7wY1diXUoWLeFOFnF1CkgCg2i6lQb3D96NyIPToDn?=
 =?us-ascii?Q?HV1gR6YvTPehe6QfJqaUdKjvvkEyEMqdz3Ka9nbI3T7t6+Lg3YdvW/OTRhzC?=
 =?us-ascii?Q?HQqEHU7oVqrKnIFrrZTLALGOn0FMeTqhJMawZW41DTHQbaOhXwdGIbkKUnNd?=
 =?us-ascii?Q?2txKwWPsutyE3kExMKZQ6jO0ifsFuH2j3EGkVc4B6UraA9ZmyiuBwrv/8Qzx?=
 =?us-ascii?Q?EmXFcwcC0V/xtJha2i4ufXg16xyZcBOuReCLNBLpddUdTlqfkrcQXZcdHhK0?=
 =?us-ascii?Q?w3ak8uynpX4C48A1K8d6QGS9PZeY/fwRtGKiOlqe1x5z3/9zHMTSH0z2o5L3?=
 =?us-ascii?Q?8ptrsUGjUTRVX7VqhqcjYHPY3hLOPIOD8eWxmqEOrUetf/bLcKDHjCwWAtni?=
 =?us-ascii?Q?91iCtVmXRioocM10AgWS06MP4UWgXsMlmW+baCmvmPnmmvpr0xWdVr4Bfem9?=
 =?us-ascii?Q?eaK5wdHIE7JVaznfQbAy9zlJ9AXNf9qL9SZUP95WP1nN8yqytFhO9arQA2pn?=
 =?us-ascii?Q?0koxl35hFb9mmQ5s0FBgfpBjDUVz8OW4JwpTAULDytC6KCrD4u0ikdzw+qHK?=
 =?us-ascii?Q?I9HBXTWU4Mng24uEoLwwAA0pNsyN8fsZz6RJ8eePUp/UTfFZTXMxXx8JeGsm?=
 =?us-ascii?Q?E+nRgpIW2BFdIQWS1pIWe+McvvgdM63dTiC4A54iKfyBiZQFNrVrCPNuifp5?=
 =?us-ascii?Q?WmWXFDb/bLLJC973RiS1ebRXdCC/nkKrYoU+3MOLu+YcKyTXyCb2MK2E9QZM?=
 =?us-ascii?Q?WEOjzVxnl8+N0VKILwydzOXoNP2t3muzu6ZViiQCljgMedrIUlgQ1n3Mjoh9?=
 =?us-ascii?Q?RJ3xkljRwU2v57kzLFgF5YO5hqA05Jf3+FfUP9nsDTurcTkbAwS3Oe1vlelh?=
 =?us-ascii?Q?hRjdieIDJL+lQ70S8/DSbmuEmZR1SB84xMIENywuKIXdfTST6KJCUZWypM1x?=
 =?us-ascii?Q?6SSfxC+xW8i047F4v3F0a+V8YgEm0YLVd/Wf3nWylWAFfUEM0O8gxrRTmoUW?=
 =?us-ascii?Q?sltYmw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c99c1c-5368-4419-9a72-08d9be890c94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:36:48.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgsCMryQFDwzWKWLUYB+JPTNmA5WLUsXB+nUEHL0uUtRqeytqacgdkY8psdM5/v7SlEBaKl53MhyZ4JUulmokcIK0/a3vyuusx+JXmLm3uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130131
X-Proofpoint-GUID: 1JTb1RxnfrutvmFwJK4cAjkkbwymTSC8
X-Proofpoint-ORIG-GUID: 1JTb1RxnfrutvmFwJK4cAjkkbwymTSC8
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:54 -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> sme_enable() handles feature detection for both SEV and SME. Future
> patches will also use it for SEV-SNP feature detection/setup, which
> will need to be done immediately after the first #VC handler is set up.
> Move it now in preparation.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/kernel/head64.c  |  3 ---
>  arch/x86/kernel/head_64.S | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 3be9dd213dad..b01f64e8389b 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -192,9 +192,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	if (load_delta & ~PMD_PAGE_MASK)
>  		for (;;);
>  
> -	/* Activate Secure Memory Encryption (SME) if supported and enabled */
> -	sme_enable(bp);
> -
>  	/* Include the SME encryption mask in the fixup value */
>  	load_delta += sme_get_me_mask();
>  
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d8b3ebd2bb85..99de8fd461e8 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -69,6 +69,19 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	call	startup_64_setup_env
>  	popq	%rsi
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
> +	 * be done now, since this also includes setup of the SEV-SNP CPUID table,
> +	 * which needs to be done before any CPUID instructions are executed in
> +	 * subsequent code.
> +	 */
> +	movq	%rsi, %rdi
> +	pushq	%rsi
> +	call	sme_enable
> +	popq	%rsi
> +#endif
> +
>  	/* Now switch to __KERNEL_CS so IRET works reliably */
>  	pushq	$__KERNEL_CS
>  	leaq	.Lon_kernel_cs(%rip), %rax
> -- 
> 2.25.1
> 
