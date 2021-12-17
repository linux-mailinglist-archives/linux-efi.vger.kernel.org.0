Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631764795C1
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhLQUsg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 15:48:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63544 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhLQUsf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Dec 2021 15:48:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHJsQDm011690;
        Fri, 17 Dec 2021 20:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=RuZgaJt5hZzn1+i4IPgya94LgXt4i0Ex3Xhl8/DEK0Q=;
 b=KmLQrKJGt16ij+LuPX5udgnh6ndZ7iVl57vpYVOGeWMWFNpGMEK90UgS13N50+90ps7i
 dRial13G9bVfoQmDcqkibVtDpwSjZntT5Q6qYFUcw0aRvwa8gCyXdlPPSD0GBJJAVGVq
 hjJpioEEPeXqjg81IIkp/xPfwERjuAwwTxRtKE6iEJWz62fhbwsd0FnVt4DJNpAKOHlW
 WDyHK+69rZpWG7F8qroSy0E0IMh6ty0/2nswPcLj1bJPbnE7t14f0kjSwusZRnoTkIfi
 Yae5j4hJsEpTnB4VkQVfjvE4XLMISa1n9GRmK64I/k7tr2YcX93xUUAX39kxLZkj1oUO 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5ev96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 20:47:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHKkMFJ155717;
        Fri, 17 Dec 2021 20:47:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3030.oracle.com with ESMTP id 3cyjubv4yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 20:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwwWuQ2xEQ2YMgPsKUDIDKB1QY8CpBa5r0kf4jqLxdCCMEX9vOXhtxxinB50rrjm6j+YcHo39gXDW9rWcTCyRiFjVROI1h4fGFegYFIkmdSgkU6FyTFRqGmfDkgl4Ri2E6KkzqnM4u6M1RU9klvaZSvgfYwV1DzOvLMJhPpsEWcXXrpey2JZw8JPFAarCI7maZtHjaiK4+qzTS/yyeFlazbj9mf/dBdPjRYZ4/P1IWCEUsbm+1I78jyhZdF2yAS//mu3gMfiVL4j5qRlrPZHkUNU8ZzZAdXOBwn80MJb8ajN7br3cvraMlHvROAjVOdFn6IXcC4aupEc3mZF1B1vGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuZgaJt5hZzn1+i4IPgya94LgXt4i0Ex3Xhl8/DEK0Q=;
 b=IgfdPdFfXD+zDXvbLkQl+ZkAMMvT97eheWonB5E4lOnRNQ4oDvqtCXpTBNbedSziMC62wI+GfQmE2tl51CxCi1TTPhAMicFpenPeVczRGFvMQCZP1xYJTSN8g8BlW+zM3Zj8QsVxKC/LKzRKfiTrS/vF7ZGPb+xOzlwavMTmNflvzB5r6avy0sGI63CFLMZ3GYppVeFc0MTRipGvQ2+zvrEXM8FVNcSz7nsRUTbWyt62iX1Ujed56PVrULtNolZ89CqyC0fMGHqrQCQXH9mbjtvIH3RS6xmsSbD2Reh65jhPTBxcIjKKS5/HPrdEU9xBru7cjXa9SGRtS6cZPNetGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuZgaJt5hZzn1+i4IPgya94LgXt4i0Ex3Xhl8/DEK0Q=;
 b=VVnM+HqwH9AaH1yhEtvI4eMG/eR23eOP9mFIvMT6yhFm4roElfO0CsqsV7Zix1TNWlt0NeL1YMlabWJelbxE1TQJgoc1Z8IyGzppifrj3X+njoHc9z5riCDWTc7F6TCRUAqFdaPjpndZQSIZjVkAI4LCQ7pKOEBAabkS1NzZ1Mk=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4425.namprd10.prod.outlook.com (2603:10b6:806:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 20:47:33 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 20:47:33 +0000
Date:   Fri, 17 Dec 2021 14:47:24 -0600
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
Subject: Re: [PATCH v8 09/40] x86/compressed: Add helper for validating pages
 in the decompression stage
Message-ID: <Ybz3XFbThJTUySNY@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-10-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-10-brijesh.singh@amd.com>
X-ClientProxiedBy: SN6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:805:66::29) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da89eeb6-b6fb-47a9-fa1c-08d9c19e7372
X-MS-TrafficTypeDiagnostic: SA2PR10MB4425:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB442522022D9E52421026CAA7E6789@SA2PR10MB4425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGWyaHC/JZ5qcYwVHwpu2aRqCYaCIs4icKp4psAtqGKSJHvMfzjMN2KGd586RxcKEAca/saNxTz01CdwBeWjG3jL9AdLmjX1NvADyXw4pNm3fuWASvGqQjeAOVtuw8JOShmLbeE5QGkGfprENraq1UhT25QacD2M75bCyCHn8s0vteF3RIJTRdxHlGhnbcOTGlGNe4nFPfqKpmKKq5Mov1XQLFKy2815bz5hVkQToGHcsjTJjsI7gujQ9+2Qu512H4/b17C1BL/iDnlasdg3oW5+oIJ/Bd/XL3Xa+6QMPa0WZrejUDos7fKZx8fZAGbFQZpQkM9ijNE6Qo2HbR86yN2FuRncpB1lrIWR+Z1ogrc03eUShFOwnmMWW0/iW1hbhmsAS1KtG/q9TUW7cKFgN81kxzSA1cDY3HaGhCdKgAYAC490UlzLuDBG6vz3guIwpO+wzEVNfO7ryg+fL8wjvxbYcE3MiyBSK+BFmJ7WZyapAW0mBrmxERl7Lxt2uxwTxwJlSVrbvzyAxng8dTTsnd8d4CTRrPMEQN9gLE2LfkstzhQQ6EqxZPNGs1CEkB22FIqiuXXmexnxht9wlYjv/YvbuWDou3uGkLRcMC0Hd3J5OPXz3yhsxmdMre3DFHZAW1X8uypc83JVts5tzdjYSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(6486002)(44832011)(4001150100001)(66476007)(316002)(66556008)(66946007)(86362001)(6666004)(8936002)(54906003)(2906002)(26005)(6506007)(7416002)(8676002)(7406005)(4326008)(33716001)(83380400001)(186003)(508600001)(6916009)(6512007)(9686003)(53546011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTZt9AxGRH11yKTUHwxnGVXrmdr37C3t4YNPe2UeNOmQ9N0nJiGkYRKGtU+i?=
 =?us-ascii?Q?dIJojsIzVm7txKhfLDDU9GcLlQyh4uyjSr/oyIe9WL4ndqh58G3JuUXQhuq7?=
 =?us-ascii?Q?co0gzxHgx3+eIgji+eDhe2TORG3nyISNXnFQrnncqNhtkvl4u8Rl4oU8zMlR?=
 =?us-ascii?Q?qJyqT8MTq3p5ALcza7z94yMBUzzpTqfr9nyl64Cg/J1b5g1z+vo9zuUWwhj2?=
 =?us-ascii?Q?XVroRrJlGuauYDIE//h72CIdwURoj7KS50AKo0PcZA78g9HcTp3tHSnwKjrz?=
 =?us-ascii?Q?uSj9ma3I3EA1Y9GszWa75iXHl3lRyCZv8+EKPGvGvwLWdHn1D6f6HfbHkq3g?=
 =?us-ascii?Q?4Lo1/J9TLkRSWjqc7PAQOwHqSTTMcmQk0FX9iaE90KcfkzGi7eC8LXmL9vHo?=
 =?us-ascii?Q?JU5Gnqpx/ayOnOcaoGxDiKMWialB+BKGGPvsLvqopeTqkZG933Q5SJGmHEEp?=
 =?us-ascii?Q?sy28Z4ExNRVxY/JLQVSXjCcSAtrO5qi3n8vDeRf4xx27tRJD2NcgAoRSu+kG?=
 =?us-ascii?Q?iiomQXExUQZJqJ8IBE1utuSvp67ePZNyRU5Fk/aBhU9dXMkrJkoX9bRcu2sp?=
 =?us-ascii?Q?LYVmcYJhNhnV6GGDN8mtRtdfTXydlEhHbWdYQjDlTFoZ7bdcQqNEb4KovLZw?=
 =?us-ascii?Q?nyZT1VVc3fOhOSxT/y71z60dXerXj2E6n1Z1TVD5plqd0Jf2iTHz6ay+EpX8?=
 =?us-ascii?Q?UbYuqVT4aJ91HtnckJnwpv/LUd0b3yL9HmPJwmBZpYZ60/Ol3x8wq6UoSN7G?=
 =?us-ascii?Q?vSJsX7AcKsvhHcf9ABKPQsG+On1qxqPi6eCAPyPCrpqrxrCS/00Nahrh8srj?=
 =?us-ascii?Q?iWu4l3h39XU7VaT2hWRYiidLyJWG9FpoDSOUxvfg3IoOSF52VQXZclENVE9i?=
 =?us-ascii?Q?5VGLRiUdiRfW9TacV1wv7MOoDHrpKFoMDpccPVnbprOJ5A8CDmkzt/Acymv5?=
 =?us-ascii?Q?jVSF2ypVCA5XWtv/5U4co89RDgdBYLoUbY4y3brMmOq8kua4OKIfWl4v/EMN?=
 =?us-ascii?Q?AcMSJcLzeZ+XjNWxvgXI7JrZ8GyY3LTPankaFR1NbdmxTkkGKElmw+3wRqYu?=
 =?us-ascii?Q?8QfSLzjnFZRheQjCdpAZsOOyOhKhZ/X9GxG9QPUgkoTd7EbN+JWxoOUXiJMO?=
 =?us-ascii?Q?saW9aA21psBwdhHATPdrsKIhdODTlvclGyivuqxU+SOVY2IgtW6sFSslbqDU?=
 =?us-ascii?Q?tqyJZoP5xR2YiQdrFSd2+VhKVXcr+CQULPQcnctSL8EYPJOznlQygTkyPyxW?=
 =?us-ascii?Q?WzqI5fBtFXmjJwB7rjn3A3dvFl6iaeVJsuI1A0NfB2WR9s87dxitbxRDh5/S?=
 =?us-ascii?Q?eYZnPVz3k2tZDYGdKgDhQaLRV5ZHYsEYtnQOfqUu57HDKJ5iDQifxgpdoIvy?=
 =?us-ascii?Q?JoZ2gYIsjA3PQ3p6tzfWW0ag5TZR0UWPneTuqLApScIOKrhpOCJtlHt4iCvU?=
 =?us-ascii?Q?ahJ6eWGA1LIJ1EJ8mCIBfY0ip9ClCwGSyKQpF+u/JrXgsuDMBuEdMl0AtdaT?=
 =?us-ascii?Q?7PKFPpY4OZllu1Ry6IV0SCuzTDKHDdYuSOOTNZUTDuFPxM3VJ0eTfV5NV43a?=
 =?us-ascii?Q?kuG+JCN9PzRTQXUAzlm4MG+jgLNhMm10ooFnltEZNhBS6WnYKsNyL/QxCHxx?=
 =?us-ascii?Q?9hnxprqcDsDdLvlC/GVCkwhR0VLF+7QZ8lXCYCJHTY8CPtwh9GWIZXJg8FhG?=
 =?us-ascii?Q?6belJQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da89eeb6-b6fb-47a9-fa1c-08d9c19e7372
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:47:33.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd89ZpN15+qE+oWsJy/TNZwkWIZXp3PyBRNU17LMqqIBAYkVpf21JGATIdyVaRo7iogTKrCV1g+RTJxiF0JIixB5eafHebcIoBzzpr9jKyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170116
X-Proofpoint-GUID: NR7D1ctXh-5qKxj3YZHHvgag0Cg42jY_
X-Proofpoint-ORIG-GUID: NR7D1ctXh-5qKxj3YZHHvgag0Cg42jY_
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:01 -0600, Brijesh Singh wrote:
> Many of the integrity guarantees of SEV-SNP are enforced through the
> Reverse Map Table (RMP). Each RMP entry contains the GPA at which a
> particular page of DRAM should be mapped. The VMs can request the
> hypervisor to add pages in the RMP table via the Page State Change VMGEXIT
> defined in the GHCB specification. Inside each RMP entry is a Validated
> flag; this flag is automatically cleared to 0 by the CPU hardware when a
> new RMP entry is created for a guest. Each VM page can be either
> validated or invalidated, as indicated by the Validated flag in the RMP
> entry. Memory access to a private page that is not validated generates
> a #VC. A VM must use PVALIDATE instruction to validate the private page
> before using it.
> 
> To maintain the security guarantee of SEV-SNP guests, when transitioning
> pages from private to shared, the guest must invalidate the pages before
> asking the hypervisor to change the page state to shared in the RMP table.
> 
> After the pages are mapped private in the page table, the guest must issue
> a page state change VMGEXIT to make the pages private in the RMP table and
> validate it.
> 
> On boot, BIOS should have validated the entire system memory. During
> the kernel decompression stage, the VC handler uses the
> set_memory_decrypted() to make the GHCB page shared (i.e clear encryption
> attribute). And while exiting from the decompression, it calls the
> set_page_encrypted() to make the page private.
> 
> Add sev_snp_set_page_{private,shared}() helper that is used by the

Since the functions being added are snp_set_page_{private,shared}(),

s/sev_snp_set_page_/snp_set_page_/

Also, s/helper that is/helpers that are/

> set_memory_{decrypt,encrypt}() to change the page state in the RMP table.

s/decrypt,encrypt/decrypted,encrypted/

> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 18 +++++++++-
>  arch/x86/boot/compressed/misc.h         |  4 +++
>  arch/x86/boot/compressed/sev.c          | 46 +++++++++++++++++++++++++
>  arch/x86/include/asm/sev-common.h       | 26 ++++++++++++++
>  4 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index f7213d0943b8..ef77453cc629 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -275,15 +275,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
>  	 * Changing encryption attributes of a page requires to flush it from
>  	 * the caches.
>  	 */
> -	if ((set | clr) & _PAGE_ENC)
> +	if ((set | clr) & _PAGE_ENC) {
>  		clflush_page(address);
>  
> +		/*
> +		 * If the encryption attribute is being cleared, then change
> +		 * the page state to shared in the RMP table.
> +		 */
> +		if (clr)

This function is also called by set_page_non_present() with clr set to
_PAGE_PRESENT. Do we want to change the page state to shared even when
the page is not present? If not, shouldn't the check be (clr & _PAGE_ENC)?

> +			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);
> +	}
> +
>  	/* Update PTE */
>  	pte = *ptep;
>  	pte = pte_set_flags(pte, set);
>  	pte = pte_clear_flags(pte, clr);
>  	set_pte(ptep, pte);
>  
> +	/*
> +	 * If the encryption attribute is being set, then change the page state to
> +	 * private in the RMP entry. The page state must be done after the PTE
> +	 * is updated.
> +	 */
> +	if (set & _PAGE_ENC)
> +		snp_set_page_private(__pa(address & PAGE_MASK));
> +
>  	/* Flush TLB after changing encryption attribute */
>  	write_cr3(top_level_pgt);
>  
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 23e0e395084a..01cc13c12059 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -124,6 +124,8 @@ static inline void console_init(void)
>  void sev_enable(struct boot_params *bp);
>  void sev_es_shutdown_ghcb(void);
>  extern bool sev_es_check_ghcb_fault(unsigned long address);
> +void snp_set_page_private(unsigned long paddr);
> +void snp_set_page_shared(unsigned long paddr);
>  #else
>  static inline void sev_enable(struct boot_params *bp) { }
>  static inline void sev_es_shutdown_ghcb(void) { }
> @@ -131,6 +133,8 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
>  {
>  	return false;
>  }
> +static inline void snp_set_page_private(unsigned long paddr) { }
> +static inline void snp_set_page_shared(unsigned long paddr) { }
>  #endif
>  
>  /* acpi.c */
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 9be369f72299..12a93acc94ba 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -119,6 +119,52 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> +static inline bool sev_snp_enabled(void)
> +{
> +	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> +}
> +
> +static void __page_state_change(unsigned long paddr, enum psc_op op)
> +{
> +	u64 val;
> +
> +	if (!sev_snp_enabled())
> +		return;
> +
> +	/*
> +	 * If private -> shared then invalidate the page before requesting the

This comment is confusing. We don't know what the present state is,
right? If we don't, shouldn't we just say:

    If the operation is SNP_PAGE_STATE_SHARED, invalidate the page before
    requesting the state change in the RMP table.

> +	 * state change in the RMP table.
> +	 */
> +	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
> +
> +	/* Issue VMGEXIT to change the page state in RMP table. */
> +	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> +	VMGEXIT();
> +
> +	/* Read the response of the VMGEXIT. */
> +	val = sev_es_rd_ghcb_msr();
> +	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
> +
> +	/*
> +	 * Now that page is added in the RMP table, validate it so that it is
> +	 * consistent with the RMP entry.

The page is not "added", right? Shouldn't we just say:

    Validate the page so that it is consistent with the RMP entry.

Venu
