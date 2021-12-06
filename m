Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3846AE92
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 00:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377465AbhLFXvv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 18:51:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30384 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230043AbhLFXvu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 18:51:50 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5V5K007611;
        Mon, 6 Dec 2021 23:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mztlyswdHRx/H55FD54IoTVHuxVGGbVaQ4S2o2VcPsI=;
 b=KkBF88nW68/PsH3F6mWdKmygVq5cu0ojOGpwRdjxIlzArAP4e+S5VQZwcpx2gYDSd6Kh
 7fx6Xa7F4azBSRcFN/iuRy04awrFEhP5NgIt8EWipUEDTHfM2GnwkcPC7hJsTK2FLCYc
 di2ZoClD6LVTKh9/LUAThfgkyAKecMFdYoXzs9dHMczWisuWNUj1cg8S8i4ZCI5e9G9V
 sveG64LhMUwvNeXv8YgYZ298gRg5+ToMf+Q3tlOePOv2Yl5PF3IocPle2lU/n36X99cW
 kAk4b9VoCbfHOwmzYFl1Gx2MN/uILga40QQhjGkwtZlDwYl9CQIC70oxXDvQrtLO9BEp 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ybmcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 23:47:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Nl9mJ140742;
        Mon, 6 Dec 2021 23:47:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 3cqwewswce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 23:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTi6Lu4MghDGtQv2IgSgC02yq17wvELnk3POO19vovnMdgtSP9MVxtOf+xHcqXm6tVNUYOKNBf+YHrMBcmD6tjOp95PllhBtc9t5oDl+C0bgcH2k4ixliS/xaW6MICidiYe9xcNeNQy/sNaCGo60fqyOp8ebfJNO76qhTU7jjwetjnWE7J1+TzNCwHEqtFX68toD1P8LEKfwekU6HZ/Nwty2ycLs9TqvJTp2UY7QAH9f/tf8SjPhAeaQ/eTWzLlcMUROlCQKeu/uKCAEuSRSyQSy91oOqnzhSx1muYUFP5UqR3WAc0MLoGqIC7cgJn15Rzd1mwZSiv3KgAcxjTaNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mztlyswdHRx/H55FD54IoTVHuxVGGbVaQ4S2o2VcPsI=;
 b=QqwBgUR1kpxSFIboB2K2enDDZdt4VuANrygTkdtgafK5usJHpOU+sDJTQW4SA+7oCjRFaxB0EtriFtuLMZncqp+E+WBGCWJH8PQkhnr0aDrIIzw1UDk9eYsITBHGEKYVgQRAzewkXWDoBQUe827kq2TvZkDMRRCU8DnjBXE0MKnveJs7XY9z+Qgv4HOtiMGevHoNfTd7gVjCMpm6us2wpPKQgDaGZQmzK21U+A6EGh33Ac65MpUjKYu7HMFzXLBxRYaxCHt0qAWFPHzcmvMJwclbL9mseIeXZQKeDcGABzSFEiJhu9gIMfgLqrsr3W+seLOSF0iTfsoHkN3+VQwGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mztlyswdHRx/H55FD54IoTVHuxVGGbVaQ4S2o2VcPsI=;
 b=Oso9C+SNqtrlR3wAtNG2QX2YQ29CZLiRypWGvKcRXIwUVE8FUff67PPbT0kh9oSx96ziloSwSrEwRwpb4KxUT0X7M1J+TxM8bBju9LIMy+BX46WAnDL+YMuYNXc8rpRawwW+WuAoIOpZjy+X0aCE7BDX3E5mwvkJwFpslPYhc1c=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 23:47:38 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:47:38 +0000
Date:   Mon, 6 Dec 2021 17:47:28 -0600
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
Subject: Re: [PATCH v7 02/45] x86/sev: detect/setup SEV/SME features earlier
 in boot
Message-ID: <Ya6hEPTkuUqhBn+z@dt>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-3-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-3-brijesh.singh@amd.com>
X-ClientProxiedBy: SN6PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:805:f2::43) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
Received: from dt (138.3.200.51) by SN6PR04CA0102.namprd04.prod.outlook.com (2603:10b6:805:f2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 23:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22073b67-c4c9-4137-dc77-08d9b912c906
X-MS-TrafficTypeDiagnostic: SA2PR10MB4426:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4426A6AA0C6A2482AFDA1BE6E66D9@SA2PR10MB4426.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mH/V9ku71Q6tqdXSRoB2DkT1F2Aar1W7CLOA17lPBH5bHe1dPSWIw1RExVNGuxr9BhdGvpPBD04xDz3uSJzpTCuoF3PN08+apG4hwyowFAj+UupjCUm8riRQDYTh9FHI0JoWrz791HizBd5XGOh0szyjKIpa03WAvPtOTSQv8YEwiJH5DCwaqv42zWlf2LfHXlB3+L3sHEylYG6fBbHfxw7xDRPodPozsgxRiQhhW+kOvPVzNiF9NpwIDTEOfqeuO9xXotUJL3Egh/8Oa0UZA/tprkqKVrFacX3k6P34UhYUHqlpf1B+BA05MxxN9kTWhJQS5Xy3N59cX6Gwu/4seFnSmAAM2b6EidTXFosnIAgzKCb0ASW9gUK3PJ9fFsvhHkf1Dogd/FbDaKJ0AAOmXZcB5P0iiTuabPRDVDEeB+iPWuPFxkcjMNvH2S189XigVzewc9wEYYCH7B6KbLAuoZLyMYAi1Fehx2zGiZIlm2Urq7xupY30UAKr3rFcToJGWckiYk+X8DBKwjdCBbpQVvWCS1jvoMULMAIQBhz/7oIG7HrI8XmVweeLg0dlLrMFaf7sHIZKDJtbLQzok0KCnXhfkwx/SoipFZtwDy906gsD6VtPCwEdUDAeq8sdhdO8ajYEw5Sli7p6dsnEnyh4d144F/QhkPactEA/gmEw249/9f//103Lf+zkOtTueI0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(8676002)(4001150100001)(6496006)(44832011)(8936002)(4326008)(6666004)(6916009)(26005)(2906002)(86362001)(9686003)(66556008)(956004)(66476007)(66946007)(508600001)(9576002)(186003)(38100700002)(316002)(54906003)(7406005)(83380400001)(55016003)(33716001)(5660300002)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r077alq/ws0xfvuXCVNOcXMfZNRv8MfLhiuHh5tNgHOF59OlMSSo9oxIJ7d1?=
 =?us-ascii?Q?Ku4iz7xURJW5X4LzXT81UV+C/N+2UvOjppNj9USB4dtF+NJIGt7eWL/Cfxuw?=
 =?us-ascii?Q?Nb/rwR4q01miAYwQYqHhqVDjLyoSyibnwSfw0O4hpyHTQjLsH5z5UDfmCzrO?=
 =?us-ascii?Q?yBdVwtN33I/dscktqCU+pEdAAkMzryFtIRqs6r190FndIARkQVHa6axbeke5?=
 =?us-ascii?Q?mpH3yYBLB2s9FvMpeA257kDuVNtdVLJGsFUfy5WsDvRq0VFnSzQa5L/BZPZx?=
 =?us-ascii?Q?JsMIdXsaVgZe+wQpVp9lcjsDjXgK4giAb3tS5sTlTWOABZmAQ763hvBtaOeo?=
 =?us-ascii?Q?dKoWGTvxRIcowMGBZTDyvKf7IFxRaRSCuTnwz7A38VfPeF5a9wtZXMkk9vIS?=
 =?us-ascii?Q?ZTcA1NIT0TNtGZGeHToGH5IXp3VCaivcfkx9fHBTp516dfgvNVVa7fZg8cxi?=
 =?us-ascii?Q?1v2/5TkNJc5EvDY+81wjV2Z4641eG8+oLg/k/4jdCq36M0kxF4IqMyxVawMo?=
 =?us-ascii?Q?nQ5EQPZsf/H9+DVA+ixHBR8rSrnuVsRAAc1VK45YYgEhBMCkUF5DaSh9sY6z?=
 =?us-ascii?Q?9F4rYQZy56zTbho7FsGNYfE1hJDCJnNJTOQYLpfFGJ7znrv1o2Yacq54W0Fh?=
 =?us-ascii?Q?Cc8bfCxJxXEVJmOxmWTtvRhKZ9Z0qtue4oOGYEPXfMxzC6eoUJXe5poqhrqq?=
 =?us-ascii?Q?fFg/ELmxpyIn6+6HGIOlT4x/n8lReRZsH9T03ybwJkrTdR8dOLLobosv2p+L?=
 =?us-ascii?Q?1qpexGiROD8PTWrXsyw8SNtOcaghqI0hp4eZdggLrfvhnF8wJHU8GuszA1Ts?=
 =?us-ascii?Q?RSXdSrRy9ZDlYvKOGsesbu++abxkSvSwThpTVsbx+6eBg9x688UOh/bxE84U?=
 =?us-ascii?Q?j3ItjT4k40ILU64Uwqtc2/ZE3YA28HFvIC11yGDh8xyynyjQgVBdhG59SVH3?=
 =?us-ascii?Q?lnIb6vIBOOvXqr92dqOI2pZZmLGuMuQ4HZV4HjETJahtNnJF+MWMCO+0PgDF?=
 =?us-ascii?Q?y3nm2ki2l32NiD9P9oWl4w9CsF4UGlZXcL91llm/lHTpmPMKzwaqYswLJDFd?=
 =?us-ascii?Q?Mg4Ldo7Sblwyd6g4XfpISv4VtiMFl7eS/jy49jbgURO2jiUKQuZL0RyuOuV8?=
 =?us-ascii?Q?u4JXDEqZhWc+teGwvcngmjYa+b5NDeAjxfU9+IWJuEaN6sQcjM8RRY3bF3EA?=
 =?us-ascii?Q?YmLCEatF1RXLfCAtdHWuQcN8fe3vVDqKF6bPtBEN91JOHEQqhi2xgBB6Z54G?=
 =?us-ascii?Q?hdvS8wS8AHCxcfQEwUiGgTztK6hfM3blL+E5qojslmw2MJraXaBZ4x0f0bPp?=
 =?us-ascii?Q?Cj7kgHqtfYBZ96LLAztxM4FJR+/6W2kIe4Q7lwsfPItccns0V/PQLQhS3KsI?=
 =?us-ascii?Q?n99DIx9fOlXRehMRvqbOw3dvkaecB1C2a9KtCYFx64My64DOqhkuhVqO4Be9?=
 =?us-ascii?Q?4YfeFqNXWKyYoUlOOsYdAkKxf1TTe1vyEQJru5DddJ7ffM95jREs4ADeSS+o?=
 =?us-ascii?Q?9+8sAAGs3PDOzTtMZExSFKaO94NgnPLtPND6bL5UUT5vB3Nnd+6L0wHGNFTe?=
 =?us-ascii?Q?XBXzIQxaFEFsOYPdB5PO4a4/TeIdtMqy7QLKHl6eznMhFxB8fw6OkfoFl4bo?=
 =?us-ascii?Q?E8iVI76lOFP1FwV7mqor8YlYtHrbEp57v6aAe++t+2rR0Z92PTt+Na7xpW5m?=
 =?us-ascii?Q?lTvhSQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22073b67-c4c9-4137-dc77-08d9b912c906
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:47:38.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DedSPMjnMBa1qjNUHKcjYTpWqVrcrUJ9HBj0R+ysTY/3LXgEXmQhsb4p1qY0xL7oM0F6UeQBBAnGEAVlmyt+AP9LSFePiC2nGFZOzFy40wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060143
X-Proofpoint-GUID: pMAQ2LG1MEj8fz9kNfMTwXwx1TSBvxKm
X-Proofpoint-ORIG-GUID: pMAQ2LG1MEj8fz9kNfMTwXwx1TSBvxKm
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-11-10 16:06:48 -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> sme_enable() handles feature detection for both SEV and SME. Future
> patches will also use it for SEV-SNP feature detection/setup, which
> will need to be done immediately after the first #VC handler is set up.
> Move it now in preparation.

The previous patch added the function sev_enable(), which has most of its
code duplicated in sme_enable(). Can sme_enable() be changed (and maybe
sev_enable() a bit) to call sev_enable() and avoid all the duplicate code?

Venu

> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/setup.h | 2 +-
>  arch/x86/kernel/head64.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index a12458a7a8d4..cee1e816fdcd 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -50,7 +50,7 @@ extern void reserve_standard_io_resources(void);
>  extern void i386_reserve_resources(void);
>  extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
>  extern unsigned long __startup_secondary_64(void);
> -extern void startup_64_setup_env(unsigned long physbase);
> +extern void startup_64_setup_env(unsigned long physbase, struct boot_params *bp);
>  extern void early_setup_idt(void);
>  extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
>  
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index fc5371a7e9d1..4eb83ae7ceb8 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -163,9 +163,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	if (load_delta & ~PMD_PAGE_MASK)
>  		for (;;);
>  
> -	/* Activate Secure Memory Encryption (SME) if supported and enabled */
> -	sme_enable(bp);
> -
>  	/* Include the SME encryption mask in the fixup value */
>  	load_delta += sme_get_me_mask();
>  
> @@ -594,7 +591,7 @@ void early_setup_idt(void)
>  /*
>   * Setup boot CPU state needed before kernel switches to virtual addresses.
>   */
> -void __head startup_64_setup_env(unsigned long physbase)
> +void __head startup_64_setup_env(unsigned long physbase, struct boot_params *bp)
>  {
>  	/* Load GDT */
>  	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
> @@ -606,4 +603,7 @@ void __head startup_64_setup_env(unsigned long physbase)
>  		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
>  
>  	startup_64_load_idt(physbase);
> +
> +	/* Activate SEV/SME memory encryption if supported/enabled. */
> +	sme_enable(bp);
>  }
> -- 
> 2.25.1
> 
