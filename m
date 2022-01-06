Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E841A486A20
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 19:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiAFSrX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 13:47:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12246 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242981AbiAFSrV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 13:47:21 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTJRa011017;
        Thu, 6 Jan 2022 18:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=20Aks+5KUrK07oS+xpAT6UhzQeXfX728dSVie6epkTs=;
 b=OWxnD2yENpb6P0wFnpcyjE7hgtffajtZ3cmJP5rBjDULk1L50lDJv2f9jiFxfbOyLHPd
 jt+/pQ0iH1viSzdMs3lgmmxkORhbIixTRFUiQBb1jfkpnnWvZJNlTOfcX0V53HWd7esC
 WcIWEEQibMvE8Hr2YO/cIgBM28f0Jd7D5NUjyqVubpOlgGjScf5eFp7ulNXsiKlm/fFH
 6whgGyKV9okfccSveD0cJllnXKkLs2WEazzvPfja/8LHv+2jN1YnVtiPOF+0HVZOLaJe
 Y0gqZxFs/HDr4+bVBcCI3zoBQWuUgKfplqsaSj783UEkAc1mfXA0PB1UIooQt8A0BDxS kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vb85jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 18:46:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206IVKGc194433;
        Thu, 6 Jan 2022 18:46:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 3de4vm4x58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 18:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7YA1iAymeFmeFCj8d2csWaBQVgPF0W3AteTnWtLuxflg245jPfz7Pa69m5iqXLVSSeQUGzd3/QTiKaShafAOx7sWmM3ZV0cF8saMS7NPyiphnWUYXtH4KjVRar/t0b7hqrW2m4b2sa0kLiWBzBKUqXatHdMqDxvo1oO1DO3HWDRPfvmp5K/f0lD6UMuewOJgTRqytv8O+gLysEZCuOqcIDrqYpYieqooBQCOKmO+8dIkOg8TYxQaZhMkSZV43W3dfTAS2jciA7pTKtFgHzUeqHfoBNMSGEJJjNL0g0CFq0otDQdN5uvmOhHQtyOekvviYjT6RcC6r2jxBUJEV+yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20Aks+5KUrK07oS+xpAT6UhzQeXfX728dSVie6epkTs=;
 b=lXN1NAmUo1JOecAPshcojBldkw9z00Y4pNOsTrvNwEUobXxAZpd4zoGlNUZ4m4prJJF+LndTTaNiZoPM6JnO8XBoU4PdlvZco3c4Fmwk3pH38FWQsG6o7IG2EaXwGcjLN/61FemSqHyaeJePbaAFzANvfiRocKHLX6Bc4P60LkETZbQTFXktJM5uv7I8TPSU6eL6O+XolfkA8s3p+BTB9xbN3YOCf35mbI0yT2oVRGuxiFNMOUITI6qn2nHnpBZ+E3QpaamMT9PP1jtiss24F6ZvBcqGo1NXoBRva4vOsSLBlnEUxA6igLo5q4DeAI3izF1FqpUaHqXXZvxNEFHw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20Aks+5KUrK07oS+xpAT6UhzQeXfX728dSVie6epkTs=;
 b=cJA9xSDHTUKs6nDpoWXvUHfG15qJFsAJpfaiHgFFcNlhw/SRPNZGfmSScq+WBLBP43ZtJhOzPH2RLtwfDP+cV/efQo8inG08brN4dyESN1tNKuVK3wBVNclYHn6IgxDHKX6IL5kn2F+AHZlwi5fSLbREKEJqD+BYydwAszxmaVg=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2910.namprd10.prod.outlook.com (2603:10b6:805:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 18:46:46 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 18:46:46 +0000
Date:   Thu, 6 Jan 2022 12:46:37 -0600
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
Subject: Re: [PATCH v8 23/40] KVM: x86: move lookup of indexed CPUID leafs to
 helper
Message-ID: <Ydc5DUrsKlOKneIB@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-24-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-24-brijesh.singh@amd.com>
X-ClientProxiedBy: SA9PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:806:28::29) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89aac3e5-da68-4f80-f428-08d9d144e3ee
X-MS-TrafficTypeDiagnostic: SN6PR10MB2910:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2910B5BB9532FAEAE39CBE72E64C9@SN6PR10MB2910.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nb4H9041GN4zYSfwFGJ/QTn7oyJEFsHMRZf6L7ZxbNiEThJaSATNjtNyaJECRV1DXRhuG1eOZy+Hotoz0TP/pVUprJ0qw4sNUKKWIvDLpI/tf8RgaId4i7c3SpbAaEORU29dtMvi+Q7QHXdqyY8M8+BTZfFDCjqx073eep4HiNn+uDZmaf17VsoQ21r8GG61RPU5shIcvCsBgT7ECMuORQMK+hWIZSJ4fAtDX0KUvzXWgwcLdmceVW9wZNEuaLZFOWJFCCXdUPyLM4TrGbsqW+PRHZWhKDWp+zpsdMWt3m06zSmNhSJwyGXW4kEWLAuttAU9a6tPPxMt7l+6hEY4IYS2uuOW1wNXL9IX4umrQpOac1IJQmJnm5Z3Lh/OJ5hlJYlTlgkE1Odopl8E+XREFR53pVmXwkFD6hfG7aAHxGeZi19vUNnqCLqEb6UBz5Yayrbvwh8UftY7KPFqcHg1Z93Vvsrc6QKojUIDVfa3W0AGu48kuh845RcTaeDBAohDxFVRgHMDoFLWyKavNHB5l15uKTAlmbuIYY4fqjvt2xeIWC5l3Co/QuduijO87757LUa7REBBVo4DXubVQKFfi7mbO4OBUsAB0S22VwQYhTGBAe2+LUhJwDoZNieVHcfVayEFpb8dUqoYBZrMVCulgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(86362001)(66946007)(66476007)(44832011)(66556008)(4326008)(7406005)(38100700002)(6666004)(83380400001)(5660300002)(316002)(6506007)(6916009)(54906003)(8676002)(53546011)(8936002)(4001150100001)(6512007)(9686003)(2906002)(26005)(508600001)(33716001)(7416002)(186003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpCL/GKUEQxsQ5EzAEjuLuRHNICPChwdf1dwyPGUYGZ6Z8b54wI5l+WMhHX/?=
 =?us-ascii?Q?O/zOhjunZP5rc/Pokk+77hfQpobOF7E+obg9ioZgYgu6eGu1mFCleX2Bf92x?=
 =?us-ascii?Q?owDZe/SbQ9VTN9tHN7PyMtXBPjjJOYlm0S39Myo9vlYl1rnRo/5Va7s+Eeyn?=
 =?us-ascii?Q?x/axcAsUvI5H142FVTJbs433QPmSXfjwhcVPAfbtqnkBwSfhwzvqObPgxE1P?=
 =?us-ascii?Q?hzDwY9QuR1SOR3W7heIJ3S02XkHWakzs4/Ce8/L9rqNUk+t11WDClzXu8ltp?=
 =?us-ascii?Q?gh5F1vaMDkdcBnzBCq01yRu70+E++vzKOCKaEF7aBcp6y07+LHu1v1BCjcKn?=
 =?us-ascii?Q?zaIMq6DN7IJu7pYTdismegNX9GFFcQ2cKtLo2nrcPrFTrz8nMdSN3i9ir1/h?=
 =?us-ascii?Q?c6vPeYoBuTdfy3kj6sCtQVdzHuaM/nW+UISEYzFVYYg4alWFh33lkvsCTlvN?=
 =?us-ascii?Q?c2dMIUpobnOOpFC1Kk7bKBk5I1p8+Yp2VInsxAlR8/ngZYbWW33PxuWvFfJe?=
 =?us-ascii?Q?Ijf7VE9ZoetnGPxt+fnYL4YoILTT0Ev5AUtyL0v89Ih4OABrh26k8rtD+zet?=
 =?us-ascii?Q?GDC8r67BRFqXDVxKYPyIn+ru9zKeGZo7h7Nu12375Z/5WGLsqGI43a/uOpSm?=
 =?us-ascii?Q?3O4msUTFsPMiDNtAK6yWhGmnxTKWj40mb62WSz8bsyl43z2olmDnhBb9H0Ei?=
 =?us-ascii?Q?PU6mWVMNIBMjy/NRb0gxfVizFPPQ5H+aJVINuURSzgtjIylKxxbULEbOiAip?=
 =?us-ascii?Q?bFr+QTN86SR8DRy+prPm+7NU0bt82frYspaF+mKb7lZP3Xxdv644SyogUsyq?=
 =?us-ascii?Q?Xq1k57ZC4P/IVlpwijRZZJl+GJ+JVjC3fUsb2a+OcYwGcrbQLbZZrNn9a3BX?=
 =?us-ascii?Q?k6jgta0EdPlPzUqu1l0+Rds/6N1q0PNwrbAwQjF/Q6ZQC6vOCDNt1/EncEh7?=
 =?us-ascii?Q?ZgkuHIu4Z1jOzV+D+5TgKy58dFUWz8Nleuf2BT78ZCZfZFVu7UU/OC+jMqIE?=
 =?us-ascii?Q?/l318BcvnHfS+LwsRQop8QIygucXlNULRIIFaernmViAE+e84+bkucCI0jwY?=
 =?us-ascii?Q?42Nsy4kB5JAtQ7Ivyzc8HcfatH4xuGr0yv1y7ckCMH2BormfX2aOpa1Xqfem?=
 =?us-ascii?Q?bvoEQ8T3TdS9VrcZQS6jKwc/aX1GCWBESqVVTXOseVFHlTb9XWY/rcrVDYyb?=
 =?us-ascii?Q?nwUiyYoW2kQcN+US95u/2G2j8aIDfbIQNEGB0n0NyqrC5vpZMFz6NQ9ydoYH?=
 =?us-ascii?Q?hpUH1pnle5yvOe6tzPhNljVvdyapk5pPQdAok1/MqtAS+/uozzedxsX53zKZ?=
 =?us-ascii?Q?PgFRYFwfTXqvDHie2mlQXsxUJnFcMlh5VKn/A+7yiKZAj0qmZxC/2XEj5Cgt?=
 =?us-ascii?Q?dFNffdr+1N4LaXAAl5BXJaTjig1vb23r71cQRwUv/e2w4UPwdTjwFvpt1x/a?=
 =?us-ascii?Q?K1mycfGyWI7r4Q0gQz564W+P1hYkZo6b2DZqvjIFKRUdQ+T0qHjpmH+ISTes?=
 =?us-ascii?Q?PJqYC4Ju043qFgAzryTnu2m6U0IolxFri9EVQ5di859+/3kSKbo4SIVyUPby?=
 =?us-ascii?Q?hmaZLJL2U8tCmufJj4tLvXPmam1kQbMq4x1qA3035Q/vuArIkYeLxdi/PZ2t?=
 =?us-ascii?Q?0KsKlbezr3gUZpWbv1zro6Xcjntw7sBtE4i34yqm+H4Zx3dnHGtP0xHULdGE?=
 =?us-ascii?Q?hyKobg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89aac3e5-da68-4f80-f428-08d9d144e3ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 18:46:46.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhxBYYprjvGLDB8YDux+SchKIYIduSzRylr6w9A3PHzEHcRykoWMQ2gLYTMcdZ2XwnV5v5B5JYEGztieHJbk6bhF/LgsB2Du4P2RQov2KlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2910
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201060122
X-Proofpoint-ORIG-GUID: dNlvFG1sWnXrjwQdmv-3Oz0x6Z4R6hz4
X-Proofpoint-GUID: dNlvFG1sWnXrjwQdmv-3Oz0x6Z4R6hz4
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:15 -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Determining which CPUID leafs have significant ECX/index values is
> also needed by guest kernel code when doing SEV-SNP-validated CPUID
> lookups. Move this to common code to keep future updates in sync.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/cpuid.h | 26 ++++++++++++++++++++++++++
>  arch/x86/kvm/cpuid.c         | 17 ++---------------
>  2 files changed, 28 insertions(+), 15 deletions(-)
>  create mode 100644 arch/x86/include/asm/cpuid.h
> 
> diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
> new file mode 100644
> index 000000000000..61426eb1f665
> --- /dev/null
> +++ b/arch/x86/include/asm/cpuid.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CPUID_H
> +#define _ASM_X86_CPUID_H
> +
> +static __always_inline bool cpuid_function_is_indexed(u32 function)
> +{
> +	switch (function) {
> +	case 4:
> +	case 7:
> +	case 0xb:
> +	case 0xd:
> +	case 0xf:
> +	case 0x10:
> +	case 0x12:
> +	case 0x14:
> +	case 0x17:
> +	case 0x18:
> +	case 0x1f:
> +	case 0x8000001d:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +#endif /* _ASM_X86_CPUID_H */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 07e9215e911d..6b99e8e87480 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -19,6 +19,7 @@
>  #include <asm/user.h>
>  #include <asm/fpu/xstate.h>
>  #include <asm/sgx.h>
> +#include <asm/cpuid.h>
>  #include "cpuid.h"
>  #include "lapic.h"
>  #include "mmu.h"
> @@ -626,22 +627,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>  	cpuid_count(entry->function, entry->index,
>  		    &entry->eax, &entry->ebx, &entry->ecx, &entry->edx);
>  
> -	switch (function) {
> -	case 4:
> -	case 7:
> -	case 0xb:
> -	case 0xd:
> -	case 0xf:
> -	case 0x10:
> -	case 0x12:
> -	case 0x14:
> -	case 0x17:
> -	case 0x18:
> -	case 0x1f:
> -	case 0x8000001d:
> +	if (cpuid_function_is_indexed(function))
>  		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -		break;
> -	}
>  
>  	return entry;
>  }
> -- 
> 2.25.1
> 
