Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB5477C1D
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhLPTCU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 14:02:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49664 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231410AbhLPTCT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 14:02:19 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn64p016286;
        Thu, 16 Dec 2021 19:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qMhXvCz9GQZ64/zMgvaX3d3miwUZakYOkA2J8hfMhrg=;
 b=TUvXqfjtvjXII16PtXJxf5lN9ND4rQ4Dm+axXIp08lPFZipLt9YZkvaL3TlJjZpIex2z
 5RxlI2kTmgKDtVfqQsymROnApipX/NJXy9NuQjCIRn8MW1Z5h4bWHDVn6GTIxQ1V6Dn/
 0s7VrIxlnW8OUB+X5E/768QDvopXokuMq0Dh+WP6CI7+P1JddS7PHzrdwlNsYEm4/xQv
 cRlR5SXcu2CyhlEk58oGoFf23rCiS7Ck0HjgZBXo0VYU9Ul0Nvo8d15QzLPuBAJ/ylji
 UVlRbxi80f5+EtSXxA9mf+KW9xKUes0qUo8RE3KpPvI+LGToz1k4q71GOGDZdDeQBd8E Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbkruk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 19:01:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIqCiC021259;
        Thu, 16 Dec 2021 19:01:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3030.oracle.com with ESMTP id 3cyjuaapkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 19:01:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqHKYQmSLPEwIUNHTiYSA1nHCYh0wjjN26Chf3w/JZxkeF+5daUbMHjgXVbme7BD/uB7Xh/4L3Qagz9SfYkiNQplMFLii79XVxHojfiGyi/BFifUJZ3jZlFQgwnf54+K+oT+IgaHBH9UiY48pXiVZh3NEff33SKMIgBqyUorE9Rpztq+oZEcyDCzo8iVlHqLzwZLXz7F6UroX3nLar4hQSUD18C4jCWIz04epVlxHYtJa9GvgD0ErW0EtUXGbpvnhzCAUJuoSMXQpB7BawgFgooEGaewQk9BqarPH0tpuofWZkjiEnp/k1Od2mSQYGIaEZP6wOTLoPBuUJojbcx+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMhXvCz9GQZ64/zMgvaX3d3miwUZakYOkA2J8hfMhrg=;
 b=HVI2Cvk3XfoqrwPNN0kwr5OrD2N6YUDXqtvmwsBoimTdog9X6rokH6BhrKW8zNhH1KyoCxzpdYlClJucNKeitYAbMfekUhRFbMCSuCzKH8zUpaWKfcQmIIfZvnxS4mHYKvHAoTiDgQWtIc8Im2Z9rarToPs+HolNcbabFR/vgoYnFrri5bYF9iK5zqMJ6e6lOReLNbqbh80xGP5gKA0rrTjzzDUwdqRmatZmoz5ZUTfK4g7WXOphIW8KRbFSzYFcU0WvQhK5DxUU+G7SFmSgiSGMk5WP+dJPQDIW4E73dYs7D8Teik9Ara4ynD1Hw301ZqMOsuNJ+x4ph0s9v5V0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMhXvCz9GQZ64/zMgvaX3d3miwUZakYOkA2J8hfMhrg=;
 b=foCzHsgz66IH0z9AJo0aqb+VNg5moOccNNc/attef8DIfqAlBsL0VEYI4QAF/YKXwRgbcmWnCVsFuoVM33JiGaOEEEp3tIGzhKDDa+qyXeg4Zu7v+nrFZsp4jy5eoPMqgrLnDg9GyHvEsu2s+P5CFpMh3INgkkn8FnV12MqQMjk=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2621.namprd10.prod.outlook.com (2603:10b6:805:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 19:01:22 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 19:01:22 +0000
Date:   Thu, 16 Dec 2021 13:01:13 -0600
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
Subject: Re: [PATCH v8 06/40] x86/sev: Check SEV-SNP features support
Message-ID: <YbuM+WgDr+wL+jsu@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-7-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-7-brijesh.singh@amd.com>
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13783614-086a-4af3-4f9b-08d9c0c67387
X-MS-TrafficTypeDiagnostic: SN6PR10MB2621:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2621C28633AE07CD0A9EEC5BE6779@SN6PR10MB2621.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxOlVpK17IHKc8imJn+kGZn3wV7jKat76yDJV6CXvIyrJJBTyqlkXDMzx8M38Z/+zkni+GyC/zZ7I7wPSQmUqZ7zUg5mwpICxt7AC/E0vmOyCT+WMgrQsJaP/4dOTvvci3V0Z2TK2r6MQoCHwSe6AAqx5VINzzIysxfi4OI/GV+m1gJTA9UqT2YeYtONtoIw94xzJh0PsoY5gU5NnYQO92h4dS9kZJgu3vel3jkh0SHiOV9NJRHhIhWYIuea5a0um6EZYtHdFfAM45KKsuYPKvIJzHphwgWFOinl5DZnnlhyQ67/SbyrM5ddnkrYWDT8wk7+KrGiABMRGzRVXpDJeZLQGUWWToXbqSutNr2uwHfTR0m4lojXQDwlMs+rM1xrkmPmxSowMg8YzQ6FHBcB8sYWmEvSQQitMwkEyWMRInnUzBQ09ScneMe7+SYk6neA4WiMM+oan4NcGfvLiVvY1L9oWBnE8Q2D7gi2H2dhltIAHGyJz5e4MBgt0Bx4f1dRIkEzQ+9T7MMQDJk+ybfQP91/Vdpo6daJ+7aTo7AzrfhoCv601ocg7MfWICFmh7M0Y7hOkGCxTEb6oT8/TznwRla23gMv7OcTBT9X5MKN/U4my6JbAg3hdzRWvYBK5NVGrj8LkWici+QO6lCRPvWS6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(26005)(83380400001)(8676002)(54906003)(33716001)(38100700002)(6512007)(316002)(4326008)(6506007)(186003)(508600001)(6486002)(44832011)(7406005)(8936002)(9686003)(6916009)(86362001)(6666004)(53546011)(7416002)(4001150100001)(66946007)(66476007)(5660300002)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAGEdmBrNuMdeggd0NZWBM3lrllqd0TBmywtiHbtmWqpe578XB6YvfUiOOXB?=
 =?us-ascii?Q?JnXaatGQ4k8xSd6uiw+pZpCo2GXbwEvXFOkbOIR1VYaqTnepIcZLmBPPFzj2?=
 =?us-ascii?Q?TJ5aZqjwMTqQ+VbRjgYdUOmQvnQLMSRynyY71NUTuasQrfZChNH5WT19sPaX?=
 =?us-ascii?Q?TbgOeK5Y11OySmFgj9widXzynw4gNzxZou6pkaFrBnZWiBxrr4znxHbOtmmP?=
 =?us-ascii?Q?pqrGtm6UVW7OwYBIxPGH2Tu5gg16gfa2/Dnqb2/oR6g/kxBQX8Q9azCWjJKb?=
 =?us-ascii?Q?x67PVd8Su+CIHb9FSWmyu5P6N6TILOVBSG+OzcjZXLmkKSFcg83RW8snQU1d?=
 =?us-ascii?Q?swEBkcWZeb7o/a5G3DKxD96xyjNyCQ/m/gubCVMX9uxTdVvVJLbNpxp8mGud?=
 =?us-ascii?Q?HpD+4PxWFtDql+lDXHFCy5kHohwJnrpcNKTjKoy7fRbsbAzUCD23S1M2o0j1?=
 =?us-ascii?Q?ZSGH5iWnWL6zi4JCd7BkKxy5FbRZ2BDdRDV2FMYY0+gX3dCO81JbVZWKZuTM?=
 =?us-ascii?Q?R9V1jv/KaI9zD5hklngVC/YqeqosJRfejg6ZlK5H7RXuU6SSDB2gjzVCpdaC?=
 =?us-ascii?Q?cbMaHaFYIkqUhvreaSU0iropC4c6l/9eihsmxkMtqoBHgyWqIOBg1wfAlZ9C?=
 =?us-ascii?Q?ypIrSvSgLxWFN9i7zTwgX/IiXMLHw+SxelOTEkxWtgwR5k+6DuxdW5tVD4qH?=
 =?us-ascii?Q?HgysUB8XYQpTJ4Shv9Cmkl4EXlT3wkvt6V3MhKv+I4bPfqXxG3Y9QqXyfHTz?=
 =?us-ascii?Q?FHg05iAvNRG4Kq0QYjbLbpOirSbNN1kJ1SIP5lGRckH9LEkVtagV/YYoubHe?=
 =?us-ascii?Q?RqBQ6NH+5JItwev3deZ+Z+MLco9CqqxYFy6rL+NLaQrCWphQwlXaKhQMrb9h?=
 =?us-ascii?Q?tPI9c8wVjo9t3r6NouRTCW5lmIqWcljPromi/5JU+Y3DaAJgY3OzTnW4Zm1H?=
 =?us-ascii?Q?/5PXMWJRfBfzFZRVkj3syBQmLp+miNHhsZxLPKrl+KJ4zKJ9ZddbQ+fOcmmj?=
 =?us-ascii?Q?m7O8zyVUNJ12+kC0Br8C7v2GtV7aR/RGptciZ9JAUAKpHN41eo0UYu6rYwcA?=
 =?us-ascii?Q?23uLAc7mtozkaQuiP8WpbRSaThLjhyw3ns0GhwVilupBGPRli4VNtsaActQw?=
 =?us-ascii?Q?A8gp4TJ2N+NBigD3TEoxeH0prKHKVxVAM4xAMZos69o8Aj3mqeSk2IRKLzf6?=
 =?us-ascii?Q?9NTv79JIqvRoLcoVJPJEg5DEjpNH47Og5HAzD/P80Lk8mZIf4GoNhehPdNJ6?=
 =?us-ascii?Q?BLGuEZPwB8ONkLeTvx1mxLOf9JewnHcBsXGp6q52xTXXygOjVMFv1OWtMi2w?=
 =?us-ascii?Q?CHfmyLzup0S2cG80cRaJeYzvJruMkNcRFNA3IRnFR33U3exCK238XE8xvqdt?=
 =?us-ascii?Q?NALTU12fe82LGISW+C80DaZjUUzYbjaYPDRIideO0EGeGx6QePBUZuaLAS43?=
 =?us-ascii?Q?42V3tUyut3YwjDZMfB81uhK+vaU0IL9dnP9GgTkbhQ9D2A2dtK45XgKF8z68?=
 =?us-ascii?Q?ARmius8bTUaL+JVrrel0PGqcUmLGgKVxD+tSFLn9ngK3c+4/7UWm2a7AP0aj?=
 =?us-ascii?Q?fYem68PbFoFR9D3LN9wmUMvFyDQuz/D3PpZk9BT10yuPl2ZmK3N7olYZ0vIh?=
 =?us-ascii?Q?ElXnyftL+BGm+kc1wRwe4oGkGOI5EN8uUDJMd6A2l2/2ZV6ZVHkkV4CZScFO?=
 =?us-ascii?Q?QimV1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13783614-086a-4af3-4f9b-08d9c0c67387
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:01:22.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqgROCoRgFZ8ifw4SX+Y7NHvtAMzXYF/uarD0E1UrYyuN0JwBahLuhlI593sWHyXQ8VD+uxt+VbuRlk0SRkEG2uWxo0fs4QLdTSUF+RpRTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2621
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160105
X-Proofpoint-ORIG-GUID: jbccMwoIjphroNV3RQFMZLVeopGdnTU9
X-Proofpoint-GUID: jbccMwoIjphroNV3RQFMZLVeopGdnTU9
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:58 -0600, Brijesh Singh wrote:
> Version 2 of the GHCB specification added the advertisement of features
> that are supported by the hypervisor. If hypervisor supports the SEV-SNP
> then it must set the SEV-SNP features bit to indicate that the base
> SEV-SNP is supported.
> 
> Check the SEV-SNP feature while establishing the GHCB, if failed,
> terminate the guest.
> 
> Version 2 of GHCB specification adds several new NAEs, most of them are
> optional except the hypervisor feature. Now that hypervisor feature NAE
> is implemented, so bump the GHCB maximum support protocol version.
> 
> While at it, move the GHCB protocol negotitation check from VC exception
> handler to sev_enable() so that all feature detection happens before
> the first VC exception.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 21 ++++++++++++++++-----
>  arch/x86/include/asm/sev-common.h |  6 ++++++
>  arch/x86/include/asm/sev.h        |  2 +-
>  arch/x86/include/uapi/asm/svm.h   |  2 ++
>  arch/x86/kernel/sev-shared.c      | 20 ++++++++++++++++++++
>  arch/x86/kernel/sev.c             | 16 ++++++++++++++++
>  6 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 0b6cc6402ac1..a0708f359a46 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -119,11 +119,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> -static bool early_setup_sev_es(void)
> +static bool early_setup_ghcb(void)
>  {
> -	if (!sev_es_negotiate_protocol())
> -		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);

Should the name sev_es_terminate() be changed to a more generic
name, as we are simply terminating the guest, not SEV or ES as the
name implies?

Other than that...

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

