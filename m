Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0614838D7
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiACWso (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 17:48:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33360 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229876AbiACWsn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 17:48:43 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203L2Opd025298;
        Mon, 3 Jan 2022 22:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=85lNrKN5TTvftCbvYi+Fpvf7DID7AvABXK/BU2Ztm9g=;
 b=uN3UQ+uuyODmQ0GXbXQb2+i0m+G7OJCM2RCS1reEhHaHQ0tJWaB9sWUSHRfwmvKAZHG7
 AX3O5OmLnOeeuJRdPw8Q/3tPhN+OGdAsy+gpzsQr1Kz0GkQ0wxqlNqNg79zzTlJbQQmh
 MtD+nyNDR4EqYRDaHZmEJxL3nVIJsZk3kSRl8Ek2ygNgR8Swa6I0FtAWMnDEbDJWQyHe
 PNhaIBXBQg5ZbyFOrd/sB81FGSdrFD7twv/AY3Ib1rxKeSyprA/HfElrI/V1XAUUVxOf
 utAXa8meBolS36Ee6NPPYiyeLbUkyUVucg/aiSU6jTnG9iSrU0ov/ATW7JXuLi6/Aaqz Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7r562-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 22:48:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203Mg1iv158837;
        Mon, 3 Jan 2022 22:48:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dad0cpy2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 22:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgNaGvCV0L08kaVWF1OntE9fdn/TTJxNzzWSkOZqj31wr52shHcA942hzyoohkLmjGa5/6HigkSo4/xy8NZRpefUmWp7Ccf3jJOB3mmq47V5tnxCuGiEWZiFNVxtnYlejr15knWGxUWBIKgZEQcqMwn8XO8vqL0c1k8fTBnc06A04PayGD7Ml/PT0YK0chmzZ8gjC1K3yOFjyr5uhN0Gr6CAOQAMuRgpz+N/98yewuZnGfs0oEYw7Dd3UymLOiFs+glSrsFrxtXQEwAMrkU3tGe5bbZ8uUqTdUcHFZA1hiUD2suz5ObAKc6t7ft9VYBOP21DeuQFV/subqumGHqeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85lNrKN5TTvftCbvYi+Fpvf7DID7AvABXK/BU2Ztm9g=;
 b=ikcRLK+PXotws6YjlTw93H3WBrqNgobCASEYqbXdcV17+sfgrvu1WIdSQfWhGZ1hTtsonjlkhpk3B/4BE6e+VHpK890IxEt3EGVVl4j6UuFsc71CzV9JsPjtjRnVEjyKCvi9PfkbMtmZBIuRwfw5zSBC+VVlzBAQ0lWnSu7smD8+8za1iCO7YyJHnWrgtQKP6Vy+64fy9Yge48y8W112jHq/bKychdo+4k6ttQMO99ezbFMoqPkSP2KsniLlgoCzAg/tCL80V1cOyF3i60JDEPrcHxMNDMh1jPAkfj7JaEw134wK6gH3yW9jIWeBsVZkaFbGxrQZlxg97OG0V2MIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85lNrKN5TTvftCbvYi+Fpvf7DID7AvABXK/BU2Ztm9g=;
 b=Mqqp1JB0l7q1MZ5QXIiYgQu3OhHawv9CRY04Qh5tZiiux+v1LN9MNWUWffGTkGoU4aG7Hd2aFGHhtUJhjoh8QkWWDC0uJSXpFFIbX7LXcpTKe496X9ruzmmOyzyi3W4BE9aSKaTi7tkXBRtUeq5v/Kp116qrQWEpmQMv2af9D9g=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Mon, 3 Jan
 2022 22:48:03 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 22:48:03 +0000
Date:   Mon, 3 Jan 2022 16:47:52 -0600
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
Subject: Re: [PATCH v8 11/40] x86/sev: Register GHCB memory when SEV-SNP is
 active
Message-ID: <YdN9GNLQiajXbV7U@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-12-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-12-brijesh.singh@amd.com>
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6e12a1-3cdb-4863-9e82-08d9cf0b19d0
X-MS-TrafficTypeDiagnostic: SN4PR10MB5543:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5543B4098079D68E41E361A5E6499@SN4PR10MB5543.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbFmCea0gO+XXEutz2xLJbrRq1UtGGsqze+p6ieiKUsql4AimrYt3+VMcl+R02JuSXGPYuTmxQMa1oZinsywNg+WtghEKmA5XYSfL6h2N2UsYpPh5VcLmQ8rPc11hPen7kH4lyDyc2TixlivP16yU68VRQ+OWkYtMx8r8ne3O+cMwVA48Sl/bkagbVG8Y3taF/G+oH8cm3mg0T13h0mQx5a2x/lCGxM3EkHfaiHpi20nTLytxJuTXPuyoolQVmk3Gm/eJyjJ5N9RSm9LiZVHHXxVkuWZVJAjeuhksfzfFSxvt2IOvutf+Tzz6adz2W0aK6mCYAtc+vc9sC5f95Ft5a8GFmqczfVwVFLZhM79+xl6A1/4ccdM38QVbLun04f3UTQ2SvwF9DbdtmUpSsDjxeGcrwqw2EZC4u5y/f6ZnPJqy2HC0pWB7UNlxu69CYSXqesyTfAC9lM1kPqwzUT2YkTNs7T8qYPJHeupRA+wdkccCBY03Y5Eu5snvcbYMglwcm7tBin8pnyVDnt7TQHO9GYMii0Ko4KObQIOcM1AM1Y8dAZwW9mh3g6ekf+k4lHig3u1fllsX2Qll8Mskky9nXQJ6b4Antw/V0PgaiUSp/UzTjomMtkk0LoSazpHCkmhBadZOB0MWfo6j99LDYZsVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(6916009)(2906002)(66946007)(38100700002)(316002)(8936002)(53546011)(4326008)(83380400001)(44832011)(6666004)(66556008)(7416002)(6506007)(508600001)(186003)(6486002)(66476007)(9686003)(6512007)(26005)(4001150100001)(4744005)(7406005)(5660300002)(86362001)(8676002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/Dj1SMRNkRP6xw/wIOHtW33g8xXQmwxtCiegPZuVMFTNluf40hhq3x1tfQv?=
 =?us-ascii?Q?1L+bBG5QzRzU1FXlsKkUf7XaiTUQqr4GDu8eXKwAf2bjEOWgMjUai7V9DgKN?=
 =?us-ascii?Q?gY4RT8gC4ca5zF7sfYriNOk8C/jNQ7xHaLYSoaHrUTBdABbA77Iqf1pRPEqD?=
 =?us-ascii?Q?iMEndhbyo0i6482ADxH42kBrLZivx61Fk/YX9SLIUImIUVp3zXWoeBFadZ1Q?=
 =?us-ascii?Q?n/ojJhKKkPCccmcbbkcEvDCvABd0g96xrwpOYHKKHjAfnuxerQqMRRQm4dLk?=
 =?us-ascii?Q?lfbIJ8rpYVy7UKWOHRt+a2xFa0qi0AuQLV83Ytm91p9yQ+IyDbPznO+wIUnL?=
 =?us-ascii?Q?LdcOhTlYt5AvLElrhm8+apBiDrki4y13Ve0FVJ9kfrffYPKIWUCA8BIeXQRZ?=
 =?us-ascii?Q?ep5d3nCQYXR1N44gBl7umC219LI9edF2KNcVevslci5MVFRqG9CN6pIRn7ad?=
 =?us-ascii?Q?YMM1cRtrfZSgD+8oBwtzyrzOKaGNRxnIHslRGQWdZ9j2GTucqDD6pnIp8vse?=
 =?us-ascii?Q?ndEFmL+ucXHj0jjyghBey6Xk0z5oXMY0c3/sryvM+puXHIOhQWLXLmzYPzgF?=
 =?us-ascii?Q?rrQbdS9vJMkZ4Pa/zGC/Nta2ji3DBk0oaJOH8+IQSMqOq88cW15hLX5OnuMR?=
 =?us-ascii?Q?uXS8G5c1n1jWnPssBra6MBudoJ1cv+f5JfNE6cUFn3eCQa4Jbn5ENF/rGasY?=
 =?us-ascii?Q?8/ZRFOvg4ggrBIQ5Ttgz+IOmzAhrT37Xf6MIJNsxgH5nz/4qWZyCQVQkgM+u?=
 =?us-ascii?Q?/f6/t0bQR+Cjc06Sx5NmCdIsVnO1M8Y+7zrYOs/ydY9nOFd6WlyF5tVckVxh?=
 =?us-ascii?Q?OO13LuHMgDh9N9bcZlw812KkpuRJeK045ktEWr2G1c4sV4crB6YtBfXawkFG?=
 =?us-ascii?Q?wyAKvvX8IsbxnPFI56UrWqTw2jsGiN0PA4rbg1Jzj230sP1ZDwhFGbcVkOFv?=
 =?us-ascii?Q?hZi0E4wpkdMgMzpt0plQKVAlHGvOeirmN2X/qUawZOROcfLjoEwYGB3pmLrd?=
 =?us-ascii?Q?s89dNhnQShjYaB5jb5CV3yovNuLcoisT5S8jUGMkvnlZ1G/XaSekaWoleo/f?=
 =?us-ascii?Q?6uZVaBKzL/OyJhCtEtyFZO/YfAAw1+S88shcihtEEt1IGkrmbC16GE2pH0MA?=
 =?us-ascii?Q?ynKLls+NNM4qXASDSPKSFU1FcPraoyNr5uVCNkMCwqphXhXHuFBw6NCYJr6q?=
 =?us-ascii?Q?dEiAQNNxIUIjwDZjvam7zkBAPcm3NeSycwJDHp8m0akHgrl3GyUDdn6E1Yad?=
 =?us-ascii?Q?eD0X4Va5LJfuUzrfXFD3tyQnaZi5AGjz4SQcqtOvFN2IAWKLoiLew3lsn83x?=
 =?us-ascii?Q?IBuoC1WpkzyD7QNy/EOnCOxOEkyRpRWHpwCPjKniODbTty0zD7/NQCi1G8Ug?=
 =?us-ascii?Q?fGzTFvmyrJ+vOzDWyTGigB+ejWcJRKbftNlLizVVspje9+Vf7WG02cltdvcF?=
 =?us-ascii?Q?3shTLVzqcrjLNMxP8PNQDuJynS54WGx/L53TAM283dZIGziqMlHiAnCy12ye?=
 =?us-ascii?Q?itv4TfAQxiLo1lsjVJr/zvftyk+IAoDaIDaeqqwBtXomUjzhaZBmGgobsBfu?=
 =?us-ascii?Q?izmHF5iNbP+9D63oyPIPoSRRklx1wcWlrnPo8B2w2AS6YfvKm67PTyfJ3y+D?=
 =?us-ascii?Q?5cIa6epk/MYIUQ8gmK9ybhIWaUuhUPU0qxgwW6EvbSyrUfVzXuGKT8PMoWA4?=
 =?us-ascii?Q?ft7xhQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e12a1-3cdb-4863-9e82-08d9cf0b19d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 22:48:03.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlyQUibvCwFbyWnoQG5MX1Ejm7kae5Ua0Ro6JLrSToI9KIT7RtXpy+U5RHkCVGZWuIoed2OOUsvFM1+25a9F2HJ+URmFJAYAIS2vTi/FtEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030152
X-Proofpoint-GUID: rmgiQe9MY1sLBwhJFtjD-0AKkOL4m7vo
X-Proofpoint-ORIG-GUID: rmgiQe9MY1sLBwhJFtjD-0AKkOL4m7vo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:03 -0600, Brijesh Singh wrote:
> The SEV-SNP guest is required by the GHCB spec to register the GHCB's
> Guest Physical Address (GPA). This is because the hypervisor may prefer
> that a guest use a consistent and/or specific GPA for the GHCB associated
> with a vCPU. For more information, see the GHCB specification section
> "GHCB GPA Registration".
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/sev.h   |   2 +
>  arch/x86/kernel/cpu/common.c |   4 ++
>  arch/x86/kernel/head64.c     |   1 +
>  arch/x86/kernel/sev-shared.c |   2 +-
>  arch/x86/kernel/sev.c        | 120 ++++++++++++++++++++---------------
>  5 files changed, 77 insertions(+), 52 deletions(-)
> 
