Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E059477D79
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 21:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhLPUY7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 15:24:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13760 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235570AbhLPUY7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 15:24:59 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn6OC025375;
        Thu, 16 Dec 2021 20:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3j25djCRWlC3eYgXYpXCrETKGiJ3E4MMOD4ue84yAhE=;
 b=AHyAmZiOF/kBB8nSXBequCPNyiqQOTZP0LqJffJarFZ1JSu60h+EWWDb8R/hDvPIJduN
 G/9cW2Zfz0lgIhsZoLvwv2ofEL9yFoIQCUPFwqzT0FNxsyX+DQbZwlRSEkv4eM/cPCO7
 dvaf86Iz0ei2mT/UfMnNefkd/ndQIJ9sXcEZdA7Bc4Va1BBxd6eSQBIO/4H7zr2Yzee4
 Vbq91mob+6HRTlwfEHTARC+zoRDKURNw89czi7gXf1LXXaWLvytPhbBbPpkRwsGd+Qia
 pg8lmb6Z6YT6+uA9g4VVC61f/RxIJWClA33NpmhZJSUv2GjNshAC8ef1jRWnMWzaKS2c MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc3xxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:24:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKFq7K177950;
        Thu, 16 Dec 2021 20:24:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 3cvneuabwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsGbFONMzlX5RDrDTAqMWv3PKGIX6w+vNWzgMJJXj4YgHcZiJvtz/jgjlMV275O3xEjkg10cLedbXb9Taa/JXZcfECiJeL3LOnboPgpTD32PnAgqo5haq9juXuioORURe4KxBHdrYheh8kGWtl5G1ELcIPLqnoEeVbPk8sFSwvRXeqPbXgOsqsNVkiJt7mNi9t+xRjNKH3h/kmPyWWJFnzK78nyAXFp6VzZowWJOX4IhVkDIaGjRfLzMMQsCwVIBDiEg3CFrojoSrw6Ysk+1DVIim9F1KXmB24etl/M6KFhAhk3SeH26HIdYgr8kJ0hrAI7cR5zlVtv0xUS5FliYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j25djCRWlC3eYgXYpXCrETKGiJ3E4MMOD4ue84yAhE=;
 b=QYjSsTh3jV7VEtMW5nHWmmY/9/mBj3nIiDdeGpfi/gfZSzffzWw1zPWwWGexjcMWJ8xmmywXX7agZnZvGMz64X/Ivmr31ReZDtsvwD9vAp8Tcmm75t7keOIRL0uF7RaTJo3vHdAw/PDI7s09LK/Egv1WBj528QfMSLq0MxWzWLnSsCqDH8ch2OTqIV7nib2FOtxhVMeKTZWaCgracl6HC+aRMZmu03xh7z9TQBn5zrJOsDeaT62Lk3F0wMyeK2iYlvyfq9XcUxGuHKj4iaQHYhqEUtqq4TbXAPdaF08QGet5EAG5ICVGVGxyG1lKDuBu8aiFcfxQk5sJhP0066OfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j25djCRWlC3eYgXYpXCrETKGiJ3E4MMOD4ue84yAhE=;
 b=cj4I4JEb41C5KyEkF5vR6fauN0+tLBYItMi3FYhc59eWrlwpbH27bYpSMpyU0oDDsDwz8wgezQ//k2WOLOi2WKsUFUfu2W6y6ICQvFI45i6T5s8hjD7CKB6tFxLlRAE9lTn5Lz1/InDpSStpFI1BRMLoecngeVzwm2+N+j//CPU=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2704.namprd10.prod.outlook.com (2603:10b6:805:49::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 20:24:23 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:24:23 +0000
Date:   Thu, 16 Dec 2021 14:24:14 -0600
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
Subject: Re: [PATCH v8 08/40] x86/sev: Check the vmpl level
Message-ID: <YbugbgXhApv9ECM2@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-9-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-9-brijesh.singh@amd.com>
X-ClientProxiedBy: SN7PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:806:125::8) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc4af661-a579-4735-6549-08d9c0d20c5a
X-MS-TrafficTypeDiagnostic: SN6PR10MB2704:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB270473033D6F84E9AF346F9EE6779@SN6PR10MB2704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99IuGlO0JysWP3S7+lY6JmZTQPCcTQ2BMMr1YZCIKaPNOhoJytNDF0+S4Lojsahs1mMuCjeEZPIBuONw9gSCfqMFB9OyF+F0J5YNXED16dObecxppU3L12R/jPpzTXjnb+Udehn7N7boIYobyHX6HpgBMqREqzp1SdaZzLQ5fZE5NsTDXzD2AAQW2b4tFRc0I35f8S6HANlVgveWlUCU+1imveQsyPrAOeCt0JRV/4TIfaYOqCfNJ2QGM4QrvlBcJNyrEmVSPehwc8SrnAPm/fqUMoO0biEenSfsYeJjlHJ/Pd7r5n/RnnzNNCW9YJ2qFABCJcPVKNRvv8Ba/7ioxIL7X55q/th5mUVSBXdFfaTYBNL++KUzh4tZ708NybisyEjzE/L8AY2PZCc5RhIjGekFZkoXA1EiVsRXU3nAKyNDpU0Z6gEQz/D0JyzI5aRfEKWZxyBxrZLimpr12bBR1KupCXMqRr9KxGR8gHSHRS59pCpEarQuiSys/9s3DnwCsEaCBT3NhOzGfWHYXZ5ezolT1xr9El+yQY7GeJDqtZ+rAwZMHOy+b86A2LCxJLOa+QM8RtwbxkN+CWfB1hr1oabVewJh4iakGhC8Ul/DJFiXoUxeMc8oxPsbwCpx7J2LpbwYuiBqzEuT61mYQLYBfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(6512007)(54906003)(44832011)(316002)(4001150100001)(7406005)(5660300002)(33716001)(2906002)(86362001)(4326008)(9686003)(26005)(83380400001)(66946007)(186003)(6506007)(8676002)(7416002)(508600001)(6666004)(66556008)(6916009)(66476007)(38100700002)(53546011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqbmpSx+aCKMVQ2FBHQuheOPwUD1tc4YLCQACQGsxDXNBOOevQW9GZQ/Ri/k?=
 =?us-ascii?Q?a0RtEtpz+FJsm6QL4gEepUSiOO+SiWHdOM1YQ6BgqEI6GntlNGtSeITBMY3I?=
 =?us-ascii?Q?btkatIjTito/mT1M+2aoDk7DWZoTbVbrZbdYfCgEPeaNQ6R9jyEmMleQXGFt?=
 =?us-ascii?Q?T9G21W7SEcoNjI5QdZ8YMkkzHwRm8acEsOvYQn8mj+jmCXbjCjQ/AUn+BwRI?=
 =?us-ascii?Q?eeDyGVpSE+vMD88SgnBx2yysQCqiHE7AvI+xdMbZMaJQ1Pl4Ft0pzJdvXwgL?=
 =?us-ascii?Q?2M3EXRWjbBl7kwBfMNW8O9VsMG/rr2AAmMWqUtEFGsvHSEMJYbJpApQolhk9?=
 =?us-ascii?Q?3h29kj6sCr+NzQpfqrdz4g7Ll/E6YSGLbnqPZIo1cLhZ7NO1J6IEobfP3lmz?=
 =?us-ascii?Q?JKm8kH3tT6AV/Qp6tJex4Scu4Jktpm/NJJUGwC7Qe4r4FrVB4EwPJFWNg47+?=
 =?us-ascii?Q?1BvE3XQmTQLRdyoqyEkDogu9auItimZGFEcjcyVYky7NgD8/zj6tzVZN/lU9?=
 =?us-ascii?Q?m9pQZRlXregbxI/6TfK09lLQXxWFWpJkbOD5/D56MfE+7/cZf3ZOnNknLNwj?=
 =?us-ascii?Q?EG6feUVqbRzBO0j7p4JTJ9PAMPzVtCgY1y2gq3I+bQpnocbqWpp5KXT6hUr8?=
 =?us-ascii?Q?gSYBbngM9Yq6eiXZ6BTaRxDdhvuWaJw1P7cbfWusDbTeMV/JLtIo+EzxG2oE?=
 =?us-ascii?Q?Ul8uUAXUk0LjuGLBF6Ooh29/MTgdnaaozJSioZZQ+8bVqsatMi5vCarSKdsR?=
 =?us-ascii?Q?dBBP5EUrPc5X9RMsQPqgbSzjqitYq3XXVLz0jEkbip7MMip+pbwI1k8Z8wdz?=
 =?us-ascii?Q?YYdU8WVIUSgPXWvJdBCCz10EpBHOCX8reuSEDCuwb2wKpYJ2lww5fGged5/r?=
 =?us-ascii?Q?tSKKqUCtkFAQ0AczfHK0ohn/5BNlu4sLuIknht64RQLQa66HH7juIGI9gNbI?=
 =?us-ascii?Q?2J2DuTdT5v/fzRto0UykNeP2f/hswpGX8Hf+Z/vE+ZPM6GDeZNADuj1SFuPR?=
 =?us-ascii?Q?Z8HuvV+87hop+ECKl91jODjqZaAuJhgWSuFbOG8YurWm399Uq02JgzBLJY5a?=
 =?us-ascii?Q?+31VXpN4LE5Lq2/3m3dP//CkL4J89T3jGb0g/bMxcFD5y+JhPQbJ6LYuT7I3?=
 =?us-ascii?Q?oRlRHWLXQjkqXfkdeuDFyXsxGghb+/nOh9KyVBiUwnQe4QHFmUmzIJuQ7oFk?=
 =?us-ascii?Q?wZStXgIusFkXMLl6HsrJWr7oszX5H4pjgUJ820fh4Th0xS/Eba0T+a+TuALR?=
 =?us-ascii?Q?hMuR5h+HQPULugTpu6VwhEhIX74ylJPxG0N91o13e4uAooVrjpbpdCi8ZQTm?=
 =?us-ascii?Q?YYRk8QZ+Q3lUya/xBKKWfLoXYgvAU0/ebKeiMK/nIsPrsGb6pe7ZC+qqfNC2?=
 =?us-ascii?Q?LzIC4qIJF10lWiC3qXMbvGy0qSCxeEawNPNFwlquRVIQM078rRqBLfGqMfoS?=
 =?us-ascii?Q?q4O+xR0AR6IlMRPFqjIvfB6qH95WHyAXu8U9LpnlL+2Oivo2h2m6z11YnHZp?=
 =?us-ascii?Q?PMI/21tG4CytZtNZqLljGgLW2CdplX+/IoU7a3ncQXHBfQskLJFhmdfi2Gpz?=
 =?us-ascii?Q?rZ+7lsscJutH81NyRrprDNKNEYCh1ZtuogLatJiObn9BgSf7YPztJIBkLPun?=
 =?us-ascii?Q?8tsYk8UddbUwXglJ9bUMY8quP+zxAFlyOQeA3f4lc/niKhVp9ehmyuU8v6Wy?=
 =?us-ascii?Q?Z9N38Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4af661-a579-4735-6549-08d9c0d20c5a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:24:23.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9ge3uVGm5f56o2Hzmi5JCYfXC9e153KK7vnPoyy3/2HOTtWvV5Dq1THC/CZwomvOzEOK/MQoAYON5Q+8KhJ37C/ufKbf7a1kKwzyy5b6rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=743 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: 3irgzlMd_j0HiyrOGd6SPYMEn8kWz0ZR
X-Proofpoint-GUID: 3irgzlMd_j0HiyrOGd6SPYMEn8kWz0ZR
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:00 -0600, Brijesh Singh wrote:
> Virtual Machine Privilege Level (VMPL) feature in the SEV-SNP architecture
> allows a guest VM to divide its address space into four levels. The level
> can be used to provide the hardware isolated abstraction layers with a VM.
> The VMPL0 is the highest privilege, and VMPL3 is the least privilege.
> Certain operations must be done by the VMPL0 software, such as:
> 
> * Validate or invalidate memory range (PVALIDATE instruction)
> * Allocate VMSA page (RMPADJUST instruction when VMSA=1)
> 
> The initial SEV-SNP support requires that the guest kernel is running on
> VMPL0. Add a check to make sure that kernel is running at VMPL0 before
> continuing the boot. There is no easy method to query the current VMPL
> level, so use the RMPADJUST instruction to determine whether the guest is
> running at the VMPL0.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 34 ++++++++++++++++++++++++++++---
>  arch/x86/include/asm/sev-common.h |  1 +
>  arch/x86/include/asm/sev.h        | 16 +++++++++++++++
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index a0708f359a46..9be369f72299 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -212,6 +212,31 @@ static inline u64 rd_sev_status_msr(void)
>  	return ((high << 32) | low);
>  }
>  
> +static void enforce_vmpl0(void)
> +{
> +	u64 attrs;
> +	int err;
> +
> +	/*
> +	 * There is no straightforward way to query the current VMPL level. The
> +	 * simplest method is to use the RMPADJUST instruction to change a page
> +	 * permission to a VMPL level-1, and if the guest kernel is launched at
> +	 * a level <= 1, then RMPADJUST instruction will return an error.

Perhaps a nit. When you say "level <= 1", do you mean a level lower than or
equal to 1 semantically, or numerically?

Venu

