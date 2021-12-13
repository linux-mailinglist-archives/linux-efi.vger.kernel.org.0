Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D659C4734B0
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 20:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbhLMTKS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 14:10:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16194 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232609AbhLMTKR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 14:10:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDIj9X9005506;
        Mon, 13 Dec 2021 19:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3UY9PWKb9ya49WjlFHgkI3wk6EsEl4OLAnHLhlPzhas=;
 b=vhIA39IQjVFYv7B1JlMIkE5ZNi4+vBlxHqQIAtAo2zqtGkrn7lIOum0KVkkrD5r33Cz+
 zZ+oehPLAwR2dev7dML9pwPvwmrAH3gXLudCLmR671HTkjq5ll4zYpL6RZfUsD59M0HH
 JPxAj+9Nx6l17gnbG1Q4uDHfChQNhee55ubCzDnhx5VyGa6xUVdtit55ani0aHEir2z2
 HWrBEeGah9VCWbkVck1mxqFZXosagwK8fadTTtU0PVKZANsi9EZTYTxGo5AlYAaWkItd
 7k2L2Ds2Yk2U0Sk5zgY3TcvhNp28MpED/xygtG9WYCQGWTnAVFu81VLvHzrUcH9ogr4P ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u18tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 19:09:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDJ1mxY118273;
        Mon, 13 Dec 2021 19:09:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3cvj1cq8ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 19:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8pFQvY6xjKesN/unACWTX0OhM64YVWfSVrpP/qtxvrLfQdonmgZuee+Ac9XdyHmeID+WPq9PQIICjOlNH7cE2GCS8dQaUQ1+e4MYGz/F+yyJkYGFQYTK1BZl9QYTqIB2oVGoGgWeKqzakr/x+gb3kS/kqb2dSayQkMYlY36PURf3CU0DIyHTDZjTzDtY6GEUKzFMAgNuS1Pn4filLCFKPzwFfrnJkxfqOfLewhMPvjPXpV8LzQ8gMiIz5kUc2+ljc+PyqWfFULSkWYuC0OnccQJLaQXZ2vX0rbDVczr4wDL+R2Ol6XBo8mS1cg1xNWuYnz6py5olsL2h6wi37hxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UY9PWKb9ya49WjlFHgkI3wk6EsEl4OLAnHLhlPzhas=;
 b=gIV90SJ1qrpYqWbA7Km+w2FpohXAVtMzzKHTACiFsOUDiGo6AIwxhAnRsiSdMuFR1z+ATl51UOx/QmAerZwKUx370LGlYM0U5UzEQgCmfjzTXfxzXlhh/0rKe7FU0RSGwP63hrHIm6Cx6p4qVqKDgrm2rifSo+xbhD1q9nQpZ72LcReMpN7frGUXp5LVAEiWbjWTXCo2Moc53MwRVanQbRAnXAaasTaB8exI9Hy/vypPLTq1VSv2NlZ4cvud+Ft3VOuekdj+P3hYsI+hLkqcxn8gupIucZENIBh3KcSG4nPgWDAPpZB4Uj90+bPN47CuS3UksiVBL7KV+i+hMfFw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UY9PWKb9ya49WjlFHgkI3wk6EsEl4OLAnHLhlPzhas=;
 b=HrhiPeUM8x3thILZB+z9sYpM28tCFU4OgT1qG91MQDgnMb0cxb8JPhHk2RSuhAS0kdVkd45YfPat+Kj35plwmBaL0NPs4WBQclra4UvvVLfaSph1AlJIYGM4Rf2TJQnq2uu9eZDfaAHqNYimNzCiI3u0XOOybTKFOrbNs0v6Slc=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 19:09:25 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 19:09:25 +0000
Date:   Mon, 13 Dec 2021 13:09:19 -0600
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
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbeaX+FViak2mgHO@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-2-brijesh.singh@amd.com>
X-ClientProxiedBy: SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eef57c9-18f3-4de3-14c7-08d9be6c13d0
X-MS-TrafficTypeDiagnostic: SN4PR10MB5623:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5623F54CD26A78E212806117E6749@SN4PR10MB5623.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikO55dQEOEJf7UpisOARx5/JotzZhnM06LDOqqzL8+SF7Cq2DViGpOzHs9sHMmIlmvPIPEpi08OZ402vhuzQOw74M8I5rHs1JP6iqdfzjhJe9e4iBQc/Ww3FsvQpIt5esP3ViVgD6JT7fjNNv06WsLagBbTB7+JGCmlecUR9G3aEMaV4Lp1ZuIdDj3j0rBLtFQ3WbG5iGDolkKn8xWkOFFzMrQ92F78ZK9T7Jtkgq3jmWAofNrnxx8vg9/P6nPTbh3Cfaj9pO5XUQWLVs9ZNw5l+ff7mVLzkmwLRuakSKEZ6ygZoPjcNpKXySrtJ5s2O8hgHYJJgZwbk+0QKJ/jyCx/TVGBD6z5kU2N2Lf53/RKTBvaY7yt8Loxd0vooa1sUUg1qcOD9DCg3FP4pQOJ6v1smvbp4A5AQUGHiAneb5G8ZZR1ga8VW6hxywppRBUQAn+m255KhW83umFssLEmUwekxmNZPFhXWHRfg2o1s0ZFFn8v3oLUSuO4HoAmlsvYt3MPbEgCNXmcX+GofQaPAjJWaamteoKCRHQ6MFNNxwcc3TpmpHn81EHv8PPybbNSHOituqEUNQhQCbouz1gb24vu7Dq+c9NfFBdqcBKnhRANnfR6zkJWKLm66OtSxrLhcZgwRakU8dkHtm9uktJ7o8ybUAdOIZVfAPji4RxzDsDMGskPHge01FFjeEQVj74sL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(4001150100001)(8936002)(6512007)(4326008)(5660300002)(2906002)(316002)(6666004)(6916009)(66556008)(6486002)(53546011)(66476007)(9686003)(8676002)(6506007)(66946007)(44832011)(38100700002)(508600001)(26005)(86362001)(83380400001)(7416002)(33716001)(7406005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4L4UsdwJd4Ra/yUpGYEXSEXFo2tZKQquokltT7CU2JSET5tAjziwCMt5wjHz?=
 =?us-ascii?Q?RVLaW1jbMf9/iFaDQfk6futf4FUac8MapjlFqZ7BSxf+DxnpBkEKeI9xJstG?=
 =?us-ascii?Q?DbO9u65/EXIztBLW2+x1D5kYpRkWTA/MxBovd92kadBVCR0jzJqufO0cV0Dv?=
 =?us-ascii?Q?5FfUgsUyS1uQ+SULV1Qi3VOn0gr2NLRpv4LXsyqJKvSENZw8l+SIeD7SH5wh?=
 =?us-ascii?Q?INFvJCcLWQlfL0GlwUgQT0tQ6Er3OttUPNJKX36ftQKfloYBi+i56QNmDQTG?=
 =?us-ascii?Q?4rTK9z9cId1YgUonU/4r37G2dG2T4LjRegsxTrvFJ3Md9GOO/WAyXTxYE9No?=
 =?us-ascii?Q?esGCsDg8QKITbnpIKpwn6DMaCf3snDgiQ2fkFbKGQSP7TMVRXuaJHMMtraMn?=
 =?us-ascii?Q?LAaLUNEPjGMmZ34mHwl5bQWiLhpnP4cczIG0DHlgVebisMQZMvHXs3SES8w9?=
 =?us-ascii?Q?sT4mQauziQrkzRzw+d+KVoABpCjEQRJlsCtX5G/4tS6c4FLd7J3czvnpqolK?=
 =?us-ascii?Q?c716oCf0T1xhOqd5WUQUZ5q4EfXNSWSs20U1MJzfqTW4sj9OGBmVN3Dg6Nam?=
 =?us-ascii?Q?N3ZbXMS8wONzM/jVpsDLBZCTg0v9911a+vk0Pu8uOtcR00Cabgvo8r0DZEqj?=
 =?us-ascii?Q?tDEyDyMftuC6M4sRzyVgjb/XAxGyGGCYPj1q5prrFsNgwJ6ML8kfK6beA7k0?=
 =?us-ascii?Q?H9jRNd1qmGsrMp2sw++kdGjICbo8fCAc8Dae7u/DXhwUz/HktUlF9dUuNVdq?=
 =?us-ascii?Q?sLoYzKaLb4SnPerS/TrZFC5SWKjc3SmGkMV9gqg7u4gmhbe0Dr1R8ckJaXiZ?=
 =?us-ascii?Q?4H8ydUq7uzjRm0YY18rOJ+uh+jhf8/6KXr7u1fhyacRJuYrxc7AKdZaNJejA?=
 =?us-ascii?Q?rhuJWIa96M9z7WqjQabMztsCcbGg4BjlmAIY/22GNlYPwc4lbZz6ZMU+SlZR?=
 =?us-ascii?Q?99hNAWF68CtttLqVVZvZ8EYcWIaVM7Nc4z2KAftWh6RTeEg1S9CCJ49KTdmE?=
 =?us-ascii?Q?+Ztahy3PJn1iOg0EX0OKAZiRPZFTViVJXjiCfIROrpUxxf3JqeBLfDS9gn7f?=
 =?us-ascii?Q?q2DU7qDAmpdMbQwpD/iEOgz69RYch2UafiJRFEJCaewqZ6ilbtKDXyo/Y7kN?=
 =?us-ascii?Q?A/hVlSoG0Ban9vQE0vMTOgjxazs7f7bb2M1Qbc8duUrh63rv5zmgQms9Sv4w?=
 =?us-ascii?Q?6e9v5MQTQH2Ej0oHb0i95L8nYola992+jp2Qi5LD/Z2I4mwnxmWubNes+HGD?=
 =?us-ascii?Q?DgBn29D73sa4hTdwXZpqFDNhWijSjuErWE+qvBaDIlCv6c1t5f+u1gy59cp9?=
 =?us-ascii?Q?V3KVg+JhUKs22G6DX/ziKr2VVv5TmW+ILOFnvB99Bh4YroJ5PaGfAMjg/W5e?=
 =?us-ascii?Q?P9ijCcZ7Vc1cnvhe6sCOgoFAuR7uJVU6UPidOuPd6RHBKTPqO5x4vbxLQ7Lo?=
 =?us-ascii?Q?Up98f91LcwQNQ4F3wnLtc3AkBBjyp97GUH6SqRxqQmEJelTWfQd01oL28myV?=
 =?us-ascii?Q?j5/7eUUHw+keuQrw/xB5FQClH52zMFQz2HnFW3VnUEfvithlYOTxEzs2ddFi?=
 =?us-ascii?Q?e2dePLcLyIBH392PM+B3QfIJ6zUzt6yHkCk9PQ0zu8drgekNR8IJTCbQdW2g?=
 =?us-ascii?Q?QuJ4CApJZw55BYnCuBKsK53Lc1F5CBlIAkJ55JJ3n6EAkLRUWVfQiMAkFAXd?=
 =?us-ascii?Q?B2I5VA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eef57c9-18f3-4de3-14c7-08d9be6c13d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:09:24.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOBV/Mubhz1IRemBmgNW7pAw6mtekfMZc0JCK1RE7T6tW5LsKAWJNrnH2gEDBJOTLlAS3ij+FETX1P7cIiBTvVV0Nd0JmUopXtsLuE7c+b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130117
X-Proofpoint-ORIG-GUID: jkxoasf5glodMdcRDKDACuq8NuzJOLfq
X-Proofpoint-GUID: jkxoasf5glodMdcRDKDACuq8NuzJOLfq
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:53 -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> With upcoming SEV-SNP support, SEV-related features need to be
> initialized earlier in boot, at the same point the initial #VC handler
> is set up, so that the SEV-SNP CPUID table can be utilized during the
> initial feature checks. Also, SEV-SNP feature detection will rely on
> EFI helper functions to scan the EFI config table for the Confidential
> Computing blob, and so would need to be implemented at least partially
> in C.
> 
> Currently set_sev_encryption_mask() is used to initialize the
> sev_status and sme_me_mask globals that advertise what SEV/SME features
> are available in a guest. Rename it to sev_enable() to better reflect
> that (SME is only enabled in the case of SEV guests in the
> boot/compressed kernel), and move it to just after the stage1 #VC
> handler is set up so that it can be used to initialize SEV-SNP as well
> in future patches.
> 
> While at it, re-implement it as C code so that all SEV feature
> detection can be better consolidated with upcoming SEV-SNP feature
> detection, which will also be in C.
> 
> The 32-bit entry path remains unchanged, as it never relied on the
> set_sev_encryption_mask() initialization to begin with, possibly due to
> the normal rva() helper for accessing globals only being usable by code
> in .head.text. Either way, 32-bit entry for SEV-SNP would likely only
> be supported for non-EFI boot paths, and so wouldn't rely on existing
> EFI helper functions, and so could be handled by a separate/simpler
> 32-bit initializer in the future if needed.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/head_64.S     | 32 ++++++++++--------
>  arch/x86/boot/compressed/mem_encrypt.S | 36 ---------------------
>  arch/x86/boot/compressed/misc.h        |  4 +--
>  arch/x86/boot/compressed/sev.c         | 45 ++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 572c535cf45b..20b174adca51 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -191,9 +191,8 @@ SYM_FUNC_START(startup_32)
>  	/*
>  	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
>  	 * will do a check. The sev_status memory will be fully initialized
> -	 * with the contents of MSR_AMD_SEV_STATUS later in
> -	 * set_sev_encryption_mask(). For now it is sufficient to know that SEV
> -	 * is active.
> +	 * with the contents of MSR_AMD_SEV_STATUS later via sev_enable(). For
> +	 * now it is sufficient to know that SEV is active.
>  	 */
>  	movl	$1, rva(sev_status)(%ebp)
>  1:
> @@ -447,6 +446,23 @@ SYM_CODE_START(startup_64)
>  	call	load_stage1_idt
>  	popq	%rsi
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * Now that the stage1 interrupt handlers are set up, #VC exceptions from
> +	 * CPUID instructions can be properly handled for SEV-ES guests.
> +	 *
> +	 * For SEV-SNP, the CPUID table also needs to be set up in advance of any
> +	 * CPUID instructions being issued, so go ahead and do that now via
> +	 * sev_enable(), which will also handle the rest of the SEV-related
> +	 * detection/setup to ensure that has been done in advance of any dependent
> +	 * code.
> +	 */
> +	pushq	%rsi
> +	movq	%rsi, %rdi		/* real mode address */
> +	call	sev_enable
> +	popq	%rsi
> +#endif
> +
>  	/*
>  	 * paging_prepare() sets up the trampoline and checks if we need to
>  	 * enable 5-level paging.
> @@ -559,17 +575,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  	shrq	$3, %rcx
>  	rep	stosq
>  
> -/*
> - * If running as an SEV guest, the encryption mask is required in the
> - * page-table setup code below. When the guest also has SEV-ES enabled
> - * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
> - * handler can't map its GHCB because the page-table is not set up yet.
> - * So set up the encryption mask here while still on the stage1 #VC
> - * handler. Then load stage2 IDT and switch to the kernel's own
> - * page-table.
> - */
>  	pushq	%rsi
> -	call	set_sev_encryption_mask
>  	call	load_stage2_idt
>  
>  	/* Pass boot_params to initialize_identity_maps() */
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index c1e81a848b2a..311d40f35a4b 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -187,42 +187,6 @@ SYM_CODE_END(startup32_vc_handler)
>  	.code64
>  
>  #include "../../kernel/sev_verify_cbit.S"
> -SYM_FUNC_START(set_sev_encryption_mask)
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> -	push	%rbp
> -	push	%rdx
> -
> -	movq	%rsp, %rbp		/* Save current stack pointer */
> -
> -	call	get_sev_encryption_bit	/* Get the encryption bit position */
> -	testl	%eax, %eax
> -	jz	.Lno_sev_mask
> -
> -	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
> -
> -	/*
> -	 * Read MSR_AMD64_SEV again and store it to sev_status. Can't do this in
> -	 * get_sev_encryption_bit() because this function is 32-bit code and
> -	 * shared between 64-bit and 32-bit boot path.
> -	 */
> -	movl	$MSR_AMD64_SEV, %ecx	/* Read the SEV MSR */
> -	rdmsr
> -
> -	/* Store MSR value in sev_status */
> -	shlq	$32, %rdx
> -	orq	%rdx, %rax
> -	movq	%rax, sev_status(%rip)
> -
> -.Lno_sev_mask:
> -	movq	%rbp, %rsp		/* Restore original stack pointer */
> -
> -	pop	%rdx
> -	pop	%rbp
> -#endif
> -
> -	xor	%rax, %rax
> -	ret
> -SYM_FUNC_END(set_sev_encryption_mask)
>  
>  	.data
>  
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 16ed360b6692..23e0e395084a 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -120,12 +120,12 @@ static inline void console_init(void)
>  { }
>  #endif
>  
> -void set_sev_encryption_mask(void);
> -
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> +void sev_enable(struct boot_params *bp);
>  void sev_es_shutdown_ghcb(void);
>  extern bool sev_es_check_ghcb_fault(unsigned long address);
>  #else
> +static inline void sev_enable(struct boot_params *bp) { }
>  static inline void sev_es_shutdown_ghcb(void) { }
>  static inline bool sev_es_check_ghcb_fault(unsigned long address)
>  {
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 28bcf04c022e..8eebdf589a90 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -204,3 +204,48 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	else if (result != ES_RETRY)
>  		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
>  }
> +
> +static inline u64 rd_sev_status_msr(void)
> +{
> +	unsigned long low, high;
> +
> +	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
> +			"c" (MSR_AMD64_SEV));
> +
> +	return ((high << 32) | low);
> +}
> +
> +void sev_enable(struct boot_params *bp)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* Check for the SME/SEV support leaf */
> +	eax = 0x80000000;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	if (eax < 0x8000001f)
> +		return;
> +
> +	/*
> +	 * Check for the SME/SEV feature:
> +	 *   CPUID Fn8000_001F[EAX]
> +	 *   - Bit 0 - Secure Memory Encryption support
> +	 *   - Bit 1 - Secure Encrypted Virtualization support
> +	 *   CPUID Fn8000_001F[EBX]
> +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> +	 */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	/* Check whether SEV is supported */
> +	if (!(eax & BIT(1)))
> +		return;
> +
> +	/* Set the SME mask if this is an SEV guest. */
> +	sev_status   = rd_sev_status_msr();
> +
> +	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> +		return;
> +
> +	sme_me_mask = BIT_ULL(ebx & 0x3f);

I made this suggestion while reviewing v7 too, but it appears that it
fell through the cracks. Most of the code in sev_enable() is duplicated
from sme_enable(). Wouldn't it be better to put all that common code
in a different function, and call that function from sme_enable()
and sev_enable()?

Venu

