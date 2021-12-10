Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7F470DCE
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhLJWcQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 17:32:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51654 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344747AbhLJWcJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Dec 2021 17:32:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAKY2d2001928;
        Fri, 10 Dec 2021 22:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TYUPaRQ/dkoOvaF6Kn/LmPKJ2uT1T2meYG5AwbQC56Y=;
 b=rGbBENTI1LBVE38+s7opRtC0N0jNyYoyEnnf9fM0jGS8D78ETXZgWXJeXYDKsRUBjjhW
 pDZhZH1IG4M8fXycOyopCkZKb9BF+FpM5+gampq6XnAyilqANmYtdbuJk9LH8PckZJlB
 CNvl75lavSitSctKM6j2TLu/Voq8Lk8w6MdpkZM+7D8umGgnNecrDoLY0Ot+seif4PDW
 k2ExTc4yHQbU2cdsQAwqadHKaW04GwR0RyzikudejCxWQznkU6nPiJv7xofFOzIwW0wC
 I+eRS4ILD6xBqwqoYv2byHhMY2eUYygYhfBUj2YjVSnbQ88Vgy0O1c3tC6eUnJXaoLp1 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cve1v862m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 22:27:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAMFcjq133411;
        Fri, 10 Dec 2021 22:27:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3csc4y9hxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 22:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0kU49ndt0ufy3kGmF9WQBFx37s2N51o00QWcsfeLw1RcdPNKncWBg2WuDi3gIyhbDc5w174dRkvvyh1f51OXRWRlwM6oqKIwtLnKNGS9DSGsUyyPMUZCugrijGpEs7MlAdJaEgkpwZ8yeCKwDOV1YfrdIP8wHxQfymoEzgGln8X2cX//o31y7g+Apkvl++9I0Q9fYkfZhg05LDnDhbeQ75edPkKOCFlu8A6lTi1DbyjOq2I3A+XQdYwoso96hi1YFbpmeepRZg/tuUalh8+k3qBC8HZmJaEEs5AVL5kWjJq26DBZJBj3+7icR+z6PHzjo9j/uD9RfPY4XMyEqcUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYUPaRQ/dkoOvaF6Kn/LmPKJ2uT1T2meYG5AwbQC56Y=;
 b=CPduCJcOBuwhodSeXz1inrOqc8NOpmHUPWw9s+AQTgKNwlyGKYEXKKGVX5aNBj8kTLvgnHNuKccsnYq6B5CnbSIpF+XzTevAlNiddahz42It7095kj0ylnhppipc1ukS414MC85GViDbG/ex98y+ocSMRkqf42GRdEOr5ukklAdF3dUHBQYLs0wtbyuii0YFoAg5dnzOy7to0Gjqb+TawIyAqg1O8F4uonJWTJJpc4m7f4GbMGuz2PGZzsa3N8eMGfbBsj70eTUIqw7Oirtfz5xfpn7/p828lV8l5gL0SpWbxkF9sD85VwOtBqsVT74CiBlu184Qrj+TSOk4ZBM4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYUPaRQ/dkoOvaF6Kn/LmPKJ2uT1T2meYG5AwbQC56Y=;
 b=k/EAbGos8laEbZaVUop9k5nYOdmnwglMse//dCOtwlSB0pPGme/SX7tM7hEt1zdx8IH3UwrYeg6lxzImbcS0cVawLOZnyfJCpD3hiptpGrwXF+6BZbs5HiCU8V23DFTglTMKP34otJMeSLIN66X0BLcTDvHCruK2ax8Y5JHfr98=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by BN8PR10MB3716.namprd10.prod.outlook.com (2603:10b6:408:b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 22:27:33 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::813b:7ce6:3c48:a026]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::813b:7ce6:3c48:a026%4]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 22:27:33 +0000
Message-ID: <5d972a2c-e98a-0629-ad1e-30804148c5c9@oracle.com>
Date:   Fri, 10 Dec 2021 22:27:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 39/40] virt: sevguest: Add support to derive key
Content-Language: en-GB
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-40-brijesh.singh@amd.com>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20211210154332.11526-40-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::29) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f426bb82-080b-4ef6-5d26-08d9bc2c424d
X-MS-TrafficTypeDiagnostic: BN8PR10MB3716:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3716FEFF83342E4C4A9E9755E8719@BN8PR10MB3716.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rp6XKUwCoazO3TmBnOCMR2gcPEsBlrvgOTZ2m7b8PElSdr+SSR/EA9960JHFtO1xDt2gg7AXN8Fhwjd1nj61lK1aoERWCTb02DqwVMRtz3PjRoq3MVuImGUz9GvZyTdBGf3y4J6Ul2oXAZ0cR2ln1AxJ0/HOGhzSu4o/u65I1EJpPA670EKsKixz4pw3LQoeiX3AbGnP8SxEnkR3/dldUj8mPjcYFtY+lupZYPl/jJ/jsTuNreIeqd/cLCZ9PER6tHyCnIKnX/KItpDrO43RJdWpf/pxaYUgGRxGwkbF3n2iFtP64YdpIxo8rwO3PSrzFSEPiYHW+T8ofL9MiAIldlLVHMsHWPhlc4g3yzvJvSZ2lmy8Eiqekw1L9dbF2IVibYA42kuY2ZBnlE0FyCAVP3bdwb77eBltyIiDSLiTR+M8LlHmtMoP0/gh5E61HHD6V7AUu+f+Ai9GTuo67QoP7lvc+kg+YZyj6VaOHDCCu82jYywIqPkIADmca5aAwltYbcyxCGDHS5LIKNfQ75fAPpSz3QBlbKWCuv39dZQcxNfTDX1yj6Mzi0Qn/UGYwjzhksOcQt0peZGuH0S/lKYuHFbz4lEZ/1F0i83EEnpRgpUKQdQ9c/Ygr3UW5D6NYBWQlsUYo2Zt/3wCq3eiJ9sRZU4B9Jz8GiMXYRUYZP9wjuI1qnMAgixBHRY4PC2oKz2yn5qPnJCpXur4X2c7eNNLx9q4Yac/+NRkSiRgu8TCO4mT0/yQKq5q4BCNwF14H9glczpcWpTbwCFnmozIQFuePg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(316002)(38350700002)(38100700002)(66946007)(6666004)(6486002)(31686004)(8936002)(66476007)(2616005)(8676002)(44832011)(52116002)(26005)(508600001)(83380400001)(31696002)(36756003)(53546011)(2906002)(6506007)(7416002)(7406005)(5660300002)(66556008)(6512007)(4326008)(186003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE9CRGJCZk4xcS9xdkRRWllaOVRxaFp6c0lkMW9vcDUrMTNMM0FuRzNuaTMz?=
 =?utf-8?B?MUFDQjFSWTdieWZhQ1VCMVl2bUJiWExsVVlMS2dBYTFRaWRLbE05UklvM2Ey?=
 =?utf-8?B?dWsvcmRISzU5NWlRNXVYNVBPTjdjeE9wZVZQcDhTSjlybU5ObElaTXpwZE9l?=
 =?utf-8?B?WVBiMW9qU2h2Vm04SmNkZ3hUL0I1VlVhVVdQejBvVnlmOGUyOEZ3WHlPbGFn?=
 =?utf-8?B?RGx3OU80d2VWV3o4NTc1bXR2R1JkSk0yZ0dtV1dEWmV6cmI0MzArbnJjYXF2?=
 =?utf-8?B?blNDcFZmYWM3V2dHb1RORkFrZkYwRTRCTVZ3ZUZQYjdVZHdtMEtyLzhnU1JF?=
 =?utf-8?B?ZzR4OHc0bm9hbndwNzI3UVlOV3pXejA0UExSNGxEODZhbFFMWXZ2cmZCZXZo?=
 =?utf-8?B?bHlvU3RSN05ZdVhmMHIvdmE3bXRsOE1iSjFxZm9MR1dKM0kwcWd2bTlVY21i?=
 =?utf-8?B?SDJhUk9yc3FEaFJMd01TUGF4WUFyZVhoZndNd1RJLzdjbUFyREJmK3V1Q2wy?=
 =?utf-8?B?eHZUb1N6d3pydk1zM0lKTHl3SmdVZ2FTUkhGVjhMQitFc3VCWmE4dytIeWw4?=
 =?utf-8?B?M0RSMzVoR2w5NzVsMVdmM1I4bXBtbXBjcVhNZWFMVnNkZW53dlpvT2I3d1FB?=
 =?utf-8?B?cDRsU1B1R2dhN1YrSlBuTHJuVlk1REc0ekR1dUl6WTd1WjQ5dG44V3NzeWVX?=
 =?utf-8?B?dksxUUxjM2JHQ3pNdE5kTzBob0k2VUcybm9FRW95d1VCQ2ZHUWNTUU56U3JJ?=
 =?utf-8?B?Rm5iaWxmOTlEMkJ4YnJiRXYwQVNBMjg0WUtqSHh6Y2gxcDNUdTVmU2kvSlBP?=
 =?utf-8?B?VjRMeTJnSXdEbzNBVlhwUTNTNVVvdkdVOFArbHA4ZmtUZ3lWdmJveWJtdjcz?=
 =?utf-8?B?SXJXUjRJbWVGelpONEdjTXZZbVdBNmVuSkJmTW1BSkZTK0dOV2oyd29YYklj?=
 =?utf-8?B?Ulp1WWFqeWJyVndmSGJOdDVYRktsRUhlLzlxWXkxSzB4bkY0enAzNUpzTmhF?=
 =?utf-8?B?VHFxRS9DUml0dDJWSWRTS0tZZDZHQnpYNHdYK1l4UnYvVHo0Sk1ia1lqTERB?=
 =?utf-8?B?UnhwUEkyZVVxUUtYRWpzNGc5MG9yQ2Z2djdlalRaQkR0STJ2c1dXeVZqUjMx?=
 =?utf-8?B?ZnNpRzloY1BTZ2VSczg3RTlDZ3FqNXZOYUNMMWpScXk1NndpU1NycTdVaXRI?=
 =?utf-8?B?b0F0N0tYUEdQakt3OWVxNWw2YklGdWJlbXRHd01kcS9EaEhxeXV2Ym94Rjhv?=
 =?utf-8?B?RUo2U3BLMitXRlI4SkxiTEtTRUo4WCtweHhUQ1ZFb0NlVE15YWl1dm83MklE?=
 =?utf-8?B?U1RrY3VCNjdSWGg2TFg5d1B3c1BNWDV1UGhaTVA2R0F0b2ZCZWlpaHU4UHJa?=
 =?utf-8?B?NEtUYnBwaXNKU3R2M2VUQTUvSU9wcklxNUxkcXEwaHlWVGlUejd1NVZlQWdD?=
 =?utf-8?B?SWg0T2xtYVFFUUVsZlJwT1BESzlxMFpWT0FNMlV0MXd3elQ4bzNpeUw3L0hI?=
 =?utf-8?B?L2NyZ1hmdTZmc2tab2hJVDhMWWo1VFd4Ylk5WHpyK3IxcjVYMk10SWRMNkN1?=
 =?utf-8?B?Q0lWNkwwUFVzK1NFRERYaTZSL1FJYURXMWJPTnpHQTRkMnBNbWU3a1N1ZTlX?=
 =?utf-8?B?WXlYb1liVU9SZmdaOG1CcEl5ZWQrQVpOSEdvd2F6UVk3MXh4K2hkQ3hyb2Ir?=
 =?utf-8?B?SnpaTVh1Nyt1SS9sODgwaDV0OVRGOE9aSTV4WHRBUHZGbk0vWmNodng2WGtv?=
 =?utf-8?B?eXQvSEJTVHNiS09RMUZqWUFZc2JOcmVxSHBXejlWcWxmTTh5bk0yZGlBckdO?=
 =?utf-8?B?M2dCcmM1eHUxZjhEWEExL2RPempXR0VqTmt3NDF6QlhLeXlIQnduaEpKYkRw?=
 =?utf-8?B?T1gzdVh6dkVBMnd0Uld3YUhGbjZjbm9uaDhDa3VtZHVaSnFnMlZISHU0dzNT?=
 =?utf-8?B?Q3NGT1BkdUhYZ1dQUFRlQkxESTUrNFV5V0ptd3BDWCsrdkQxUkJLUWM1WVBT?=
 =?utf-8?B?VHpKYVlvTFFrWnFsWEhMUU1mdmE1U1RhTjNwbzhnM1h5R2M4NE11a1N3dVJW?=
 =?utf-8?B?MXp3ZjViR0YxeE1BR1FDenZ0YW9WNmQvT1o5bURyTUovQk5mVUlIU1lFd08w?=
 =?utf-8?B?VzQwMDFueCt6Q00vZ3VJb3FNQlY1RG5vT3BpZW1jbFlCTjkyeDR2YWl1MWVp?=
 =?utf-8?Q?GbOJw43+ULLREWPyOorLaC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f426bb82-080b-4ef6-5d26-08d9bc2c424d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 22:27:33.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJoFWy/aQYlmBmxhR/DuzvSPMbmBcnifP/7RZrrOEVUdUsKddeso3lEJjyPBoUGTwIdlvzu1Iq7KfMe+bEpIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3716
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100122
X-Proofpoint-ORIG-GUID: LfyAWeGBzaSR9EWJ5KlahgWuOkcdAbIV
X-Proofpoint-GUID: LfyAWeGBzaSR9EWJ5KlahgWuOkcdAbIV
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/12/2021 15:43, Brijesh Singh wrote:
> The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
> ask the firmware to provide a key derived from a root key. The derived
> key may be used by the guest for any purposes it choose, such as a

nit: choose -> chooses

> sealing key or communicating with the external entities.
> 
> See SEV-SNP firmware spec for more information.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>   Documentation/virt/coco/sevguest.rst  | 17 ++++++++++
>   drivers/virt/coco/sevguest/sevguest.c | 45 +++++++++++++++++++++++++++
>   include/uapi/linux/sev-guest.h        | 17 ++++++++++
>   3 files changed, 79 insertions(+)
> 
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> index 47ef3b0821d5..8c22d514d44f 100644
> --- a/Documentation/virt/coco/sevguest.rst
> +++ b/Documentation/virt/coco/sevguest.rst
> @@ -72,6 +72,23 @@ On success, the snp_report_resp.data will contains the report. The report
>   contain the format described in the SEV-SNP specification. See the SEV-SNP
>   specification for further details.
>   
> +2.2 SNP_GET_DERIVED_KEY
> +-----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in): struct snp_derived_key_req
> +:Returns (out): struct snp_derived_key_req on success, -negative on error
> +

Does it return 'struct snp_derived_key_resp' on success?


> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.

nit: derive -> derived ?

Otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

> +The derived key can be used by the guest for any purpose, such as sealing keys
> +or communicating with external entities.
> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
> +SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
> +on the various fields passed in the key derivation request.
> +
> +On success, the snp_derived_key_resp.data contains the derived key value. See
> +the SEV-SNP specification for further details.
>   
>   Reference
>   ---------
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index b3b080c9b2d6..d8dcafc32e11 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -391,6 +391,48 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	return rc;
>   }
>   
> +static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_derived_key_resp resp = {0};
> +	struct snp_derived_key_req req;
> +	int rc, resp_len;
> +	u8 buf[64+16]; /* Response data is 64 bytes and max authsize for GCM is 16 bytes */
> +
> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from userspace */
> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
> +
> +	/*
> +	 * The intermediate response buffer is used while decrypting the
> +	 * response payload. Make sure that it has enough space to cover the
> +	 * authtag.
> +	 */
> +	resp_len = sizeof(resp.data) + crypto->a_len;
> +	if (sizeof(buf) < resp_len)
> +		return -ENOMEM;
> +
> +	/* Issue the command to get the attestation report */
> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> +				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> +				  &arg->fw_err);
> +	if (rc)
> +		goto e_free;
> +
> +	/* Copy the response payload to userspace */
> +	memcpy(resp.data, buf, sizeof(resp.data));
> +	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
> +		rc = -EFAULT;
> +
> +e_free:
> +	memzero_explicit(buf, sizeof(buf));
> +	memzero_explicit(&resp, sizeof(resp));
> +	return rc;
> +}
> +
>   static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>   {
>   	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -420,6 +462,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	case SNP_GET_REPORT:
>   		ret = get_report(snp_dev, &input);
>   		break;
> +	case SNP_GET_DERIVED_KEY:
> +		ret = get_derived_key(snp_dev, &input);
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 0bfc162da465..ce595539e00c 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -27,6 +27,20 @@ struct snp_report_resp {
>   	__u8 data[4000];
>   };
>   
> +struct snp_derived_key_req {
> +	__u32 root_key_select;
> +	__u32 rsvd;
> +	__u64 guest_field_select;
> +	__u32 vmpl;
> +	__u32 guest_svn;
> +	__u64 tcb_version;
> +};
> +
> +struct snp_derived_key_resp {
> +	/* response data, see SEV-SNP spec for the format */
> +	__u8 data[64];
> +};
> +
>   struct snp_guest_request_ioctl {
>   	/* message version number (must be non-zero) */
>   	__u8 msg_version;
> @@ -44,4 +58,7 @@ struct snp_guest_request_ioctl {
>   /* Get SNP attestation report */
>   #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
>   
> +/* Get a derived key from the root */
> +#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
> +
>   #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> 

