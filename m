Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E9473994
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 01:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbhLNAdS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 19:33:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11378 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236812AbhLNAdS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 19:33:18 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL6oa6021570;
        Tue, 14 Dec 2021 00:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1SuRUYD8aFrsF0rfemX+wEqVy71lhYSHEYiboZyEHf8=;
 b=iYd8n+wvHT3lTTirOCQHgFSXmm7d179prf4TVu0n6HB1XAEswNovZQSYMXQww5A6dFHJ
 Tuot886pwws5EVZwjop94OSnDNxkwyqxG9vThP6664HrxwNEJgRy2Llt/GiwSWzaLLge
 xAG/2IAVOk70hHvrJug+6IIYRnyKAnK3f7TWpQvOEsmpJJk7AcH7xXf6VWmEwEFysO/1
 8PCkZAAycQz2jwSIcXdBefzXUBEZDVUDWUeTyuQWRhs47zUxtOO79qtxdJKPe9gUZS0I
 WD3jV2t9MrUPDguKIRULsFYmMxM6DGcBUX+4UbbOYVTQnGf/uAavfoQH1daKngfNTAzC jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3ukaagc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:32:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0VX1e163000;
        Tue, 14 Dec 2021 00:32:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 3cvh3wdw71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+HRswn66H7QVxiTiyv+sZJROWUyXvv+9I847/7Nus9FjYRDjCz7qrFnzm0qKU/GzQNRLFhhRemJiqj4+RhQo5B5q9SxJUFxrRXbatZC3QcwtwoBAQmaiLnnX9YjEqZfu+gnNHBtO4VuwR7ZYHZo1Iw7XIDDjCSCn2mqZO45dUKUpKTprbmYMpm1LtYo1FLtlaXXdw+aA9zqauUqQWNESCpfSjPqHFP7SS7ZqdudBZ9df1l4IK8G8M2wyFN2Uj1zBehQ5z0K9nC9dq9FCPJZUwvBCZbFnR0vHkaLGbz0a3oNn+dE8g04gb3sTiNVhmJSlravwOwmePsGk5bqeQ7Ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SuRUYD8aFrsF0rfemX+wEqVy71lhYSHEYiboZyEHf8=;
 b=dEI3zO6Wd5v+mXPu89tbil26Q4nFe3Lf1Kwf6v71nePBzlRw4tahCqTI1eB6Jc+lfWNZ3xH4yagL0nYTDSCvJ3rLyTL1oU2rpX6w0pzd/ZCB8mw7DifURIX/u/Wo/uV3a19A++dq+JqsMKNYA/9PVgxILhO9YRVL9BIbRSAJfaZK8lgdELW51Ol1wbNN+rQqk49UoB3qVNpCJOWwcAhuv6BPCmHufbxBABoxhfmRj6Js5ziYLBgTHYi8v2Dgbu3Y6JtOHlEjT513wnBinv7vC3fR/NLUuXuFciO9G6DRyx3g53tc4mu8XNDX6KGvsSiqeBHp+Ft64BJNw2QQjaa3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SuRUYD8aFrsF0rfemX+wEqVy71lhYSHEYiboZyEHf8=;
 b=pzlsP9pqBkvQgBH19O47OLVNSatmunGCXYfiHaIfypOCUhfKVQ3aZ8+rLhWURagK0bSDufgtvwJfgXs86+LecinM97TGwzoGus6j9OLy00k7MC7z7FS59cDWdZTaQiQ2aGajt/mqJtX6kEupDDebKaoWRr2qXhf+hHebHqT0dVA=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 00:32:46 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:32:46 +0000
Date:   Mon, 13 Dec 2021 18:32:40 -0600
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
Subject: Re: [PATCH v8 05/40] x86/sev: Save the negotiated GHCB version
Message-ID: <YbfmKJe6dDH+M/fQ@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-6-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-6-brijesh.singh@amd.com>
X-ClientProxiedBy: SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::35) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9707022-3289-4223-caea-08d9be99400c
X-MS-TrafficTypeDiagnostic: SA2PR10MB4793:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB47932ABD505AD80CEA052063E6759@SA2PR10MB4793.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2A0OpPVJ8oriVTDWRlpUevM+FIHphyFXR1Ng+TkHHzaqLT2s63IH6G79ZgI5dGAzw1I/VJFNHkT6egZryeLXjamdLB/3px2be2dWMsLgQW1Rh3lGjY5p6X/6s9QTCvkVEMTyEFpAczpHyErhMiHgjPd+GD1hKmwl/fDxTdvn6WUKQtWN1aZBAnPVHOnk8VFrd/AcVyMrIBMDpGsrxuRv928fAKE7sYYfZT2geYBWy4U8EGUyXWao3nN+AUVIGwz5oC2s462n2QrRCHpRiNsbqvcY0U8u/pIBFB+nuAjATwgU22DliETyjP9P60rUyH0IH6ZvmnXsYDY8smjgQEwj3SKy6xQ01v9vYgT4hpvUCJLXxFv8UGi40AhvZZITRBTMkJH5pnloOaWzQeG1GSUEk4XRYxlNrguLXwyRZ6OthEMln9D4LIM6nIndqEhnnOwjL1OJwofIxS7sKs7zxSVJuT7HbOgvy7CztlixwpKiBUmwUrPn5JxH5GgnU/QFkPCEYuR42wTaL/Ybbtd9TRJPMmlnKd4eiiWF1G8v07n8S50FnkSofPlqTKOk8VzwDHmy+k+zMxt3NflgZVu7buL13y+wv8OBcI/VquYKZmezIRnpvQxx+AslkpIFeEGk3iPrrpWWjf1mK1WtMY4ESdlLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(53546011)(66476007)(66556008)(38100700002)(26005)(66946007)(6666004)(33716001)(7406005)(6506007)(316002)(4326008)(4001150100001)(7416002)(83380400001)(44832011)(6916009)(6486002)(6512007)(2906002)(86362001)(186003)(54906003)(9686003)(508600001)(4744005)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cprcGbuZXzE8eSoZbyQU9fVdAPR/R404QICCh1bd8NGJ+8PJrt+xzJE/0lb0?=
 =?us-ascii?Q?u9Lb+vdSdfZgfg83kcdcfr0RKAHnq87JkZNdIJiqp4HElxjOatjqXTcf/SQz?=
 =?us-ascii?Q?nzl/J94NxN27N/VbV1CMJ5cBfeZAQ5qhEA09EJFzW7ydlOdc2sEcv5O7dTsJ?=
 =?us-ascii?Q?bQt3r9aT/pEGW7mSUi/Wn4rEJvXmfnrqOTCun4XzpdTfYZtzzwhiqa0u865Y?=
 =?us-ascii?Q?h5fyE8ZAkJiEtRddV7pPyk09ZUgD/P/l1yScKnBzX6m5Eqm5nUCqixrqBlfr?=
 =?us-ascii?Q?bn9YhMQjfYpGmVyVKEf6Rv6rT2tDQwgVvxn/LNK9D+qQ1V6mwFeKO+pj8yGV?=
 =?us-ascii?Q?RkBdBSn2b+d4PUfd/uhk+a0ZiIwa28gHXbgWgrz59jCCub9bjjZTXbC7UVSA?=
 =?us-ascii?Q?xyG68xT3MOLYYtEtBsd82YlB5w5z6bltydolgm1Ft6nT7zFTfUGQJ4rFPPH/?=
 =?us-ascii?Q?kCbC9xmrSz7/lbC4byYFMVL5ErAPOvLFobfORvOveztqp0IuO2mWZbjbKogZ?=
 =?us-ascii?Q?kwdZAhO1SWGAGSDYk/wTYKPPrrN0ljnOmnpwxqdKJe25t2TIuUf0lFAaR4eU?=
 =?us-ascii?Q?13nkHYaDL4+cCJ28w976qpL4yUxlKcFLFQ63R6itI4lwWCNjM5O1thfn+jMb?=
 =?us-ascii?Q?Hq4xEki9DutBUveTy1QUZwGFTatyRyEz/H4Q5070Li6KbnZ1qMdhacu8lK3Q?=
 =?us-ascii?Q?R1DQLK8QtiI/xlkKTg4TNUJ+JJVnCdEydP3Y6JMnn7vI0tIzrfdmiInmRXxX?=
 =?us-ascii?Q?pIevbBHbgzUEqAwPExWYwZ8ghF/0V9Ha9lwaJsT7mTa48TD72dgUF0x8klK1?=
 =?us-ascii?Q?412FSyqOIifLlZw2aPPOy0z3NVgxi9ct5RAnynOGOWWTyjLk+C2tQCGYGfdn?=
 =?us-ascii?Q?oSWUAHNYw6jiy/N8LKU8Od0+KpgkE0ivnOWTlwJ2rRFVcRXapZdwML0e7eNX?=
 =?us-ascii?Q?NqruFhWvUg3S6oNmP3F4wwSEcu3uAIytpbWyKwkGI1giK0obUsgkr7hOsk2I?=
 =?us-ascii?Q?/tEpvirOdAMyfMuOQQbmkvXunPdnmRKxNhpT0Mpx9fsWxeiifS58dI5XPbsz?=
 =?us-ascii?Q?JIvTcsMVB3vld8CymqL4DzM2I89ngNCen+HP0EhArf0q9YGwVyVTccouKhb8?=
 =?us-ascii?Q?bTiY4CJxjSsuGqq6vdXfu/5w5eOEKeDCnVX1KWcF/WjbfucwGdsEJIbMVBCV?=
 =?us-ascii?Q?62VSGicok79IB0CdkRT9odljs+n+aRJT7/UixB7YtPAdoErIldaplZL7UFSa?=
 =?us-ascii?Q?6pMzUAfPK/j6F3FhknvViV5ojUx3mvjap4FvMLRh14j7Afk6aP3R0k1Z55hp?=
 =?us-ascii?Q?xkI3UL5Fqv1tIn+NBbEYU5B26a8x0sY161uO6enTvgiVhp1XaE7+vJJzvzq+?=
 =?us-ascii?Q?hDsn5ZabR/0jiazruf5mvjcIKDrApe2YVFmK5hK5qaDeliF2BxDdYRghfYVo?=
 =?us-ascii?Q?Fsm16xinDv/LLHj4v0zYoGSNIIL84i1sjbBKHDcQqqN85kBIdldz54e+EnrJ?=
 =?us-ascii?Q?bnZREENNOoxDpe2Qcmx2a+giVkEDPLc9n3rdEOXfNZQ9q5gtygrwaWTWcUVU?=
 =?us-ascii?Q?QWqsJmrKHrgKEEjVA4+TUE7TKT+K8WWEaO6xlbvzXGwH6DflBajc0EVyrA+L?=
 =?us-ascii?Q?+UBAuevo6v26gpDzhLfUB9t6b7xTPFhxYza/0UtcWiMueqHM4JIoKRiW/gDN?=
 =?us-ascii?Q?Mqk2Og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9707022-3289-4223-caea-08d9be99400c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:32:46.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iko1PWT3K9oViV1YJr1tlsB1vLpCyrihdrSGIPliUuMCejaMVt2ROhNOfLOD42RrfJevAzWUH4VtaNH0BwEH3V+1PRDiFzidA1WpHAUzwEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140000
X-Proofpoint-GUID: NqATZFb-5utRWwTNxn4uv2Yl5fWOPUsA
X-Proofpoint-ORIG-GUID: NqATZFb-5utRWwTNxn4uv2Yl5fWOPUsA
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:57 -0600, Brijesh Singh wrote:
> The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
> GHCB protocol version before establishing the GHCB. Cache the negotiated
> GHCB version so that it can be used later.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/sev.h   |  2 +-
>  arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 4 deletions(-)
