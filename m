Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257C2486AC2
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbiAFT75 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 14:59:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63256 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243518AbiAFT7z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 14:59:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTJnW011017;
        Thu, 6 Jan 2022 19:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2HQmcxcCNxgVp8dWnq3lGu+flDS3TrYzkOF82LCmPEg=;
 b=cWsMdySA6zYhPQ67RP5svGCsnNMq77vqf3UPkNW8+rK9qTGSrqz/aHmGm/eeRuXO6TyV
 UHZdJ3rdlqsdjk3Zw2m143/ueCez/gmL5Ts+x2Q5ja4O3/ie6vFhtq8/7HKcfgkVb2KK
 MmCS8TRIfrgBfZNTaz+9gRbs4GR86pNfripIGD0OhSPZCJRBJME/uuE52xJlbXHIGxrg
 LkJEt+pmYCLrAXTJwqrhcBWV71O7Al5edko/hnC3N4CMndnol84UuZ20ZfVNaYGJsPNj
 MnOyDzC3LMRCp6+u9tjZS1AC+dQXuB6015Z33rJornaJe9pjJfY/a+b1QfHMIHOWLRiH yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vb8b6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 19:59:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206JaDHo135381;
        Thu, 6 Jan 2022 19:59:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3de4w1y9bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 19:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXFcRTQ9tJYrhKWT/RPUfTsXnqSbXSCNsS+RfJkp67DNkB9wuopqErKx6fsRqIORq8I0JaK+np9rprcXSC3ZplqtSWYLfTrsLzro5B59+bnqBotwS5LWwshfpoNO7YlUYTuNsYC6i7Unixyxuvg3zTKzaegGoe3H/yiNrfgdYv1UQGtid/nep9Ue3GpYzZWM2jUBOVlkBdakNwYfpTA4piwhJeoolWgY/SDdq4Mgt4zj341Y5tByo3uC62CYMkkBPqDXpt3heS9x/yq9mg4dsvJIR02/5gz+v4UtgzLBq676vq0mqJfJlvlQmQRCiX8Labq+7jjb5PU2dL54671RqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HQmcxcCNxgVp8dWnq3lGu+flDS3TrYzkOF82LCmPEg=;
 b=LEGI65h3k1jY8QYoBZvp66JgsAsTUbiv3q88InAP8yalnW42c5gfl+5u5ymIaQHWUmnz3/aH/X8wHAItDTUdqJUCc71mu3cUby4vSuBn5tTCcaNvQqPmN/kG80uYgn0wcVZY5siDkJUoAWU/yVPE8KAS45R72JdrZAna3JGL37L/mmRl6VhYE0lkUfoQUYiV91EcU9jy8rAhusAmCTaKVm6f+D+X9XTZbW8YvkmaDDJVEIkrxOoQgfvCNJdgKQgA1cbrQsfhy1wbEVzyAaXir8v78rlUdCRSTsykXmmtyovx/sv9QQAMydL7C2yFLABZwcvTs2GHsvf/RH5F+PfyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HQmcxcCNxgVp8dWnq3lGu+flDS3TrYzkOF82LCmPEg=;
 b=cmdHioKZKq9cAJPF2wBZFQKNNJe9YBmsuZjH+8K32oojabokl9S2sPI6U77A6EwCXnytK6ljeQ17EhRN6SpXUQNAe+VzXagOeuIsO45RqqFtHVnFms7f27JJuW0TYb87sGsmQT4KGyvNjek47J6oeIh9zqgWdEXPKqw4kjGQ+X8=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2911.namprd10.prod.outlook.com (2603:10b6:805:d7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 19:59:17 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 19:59:17 +0000
Date:   Thu, 6 Jan 2022 13:59:08 -0600
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
Subject: Re: [PATCH v8 24/40] x86/compressed/acpi: move EFI system table
 lookup to helper
Message-ID: <YddKDNPTnoQaHu2f@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-25-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-25-brijesh.singh@amd.com>
X-ClientProxiedBy: SA9PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:806:22::21) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7189e649-a102-476c-d38e-08d9d14f0539
X-MS-TrafficTypeDiagnostic: SN6PR10MB2911:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2911DCF74F41E24E7BDCAD26E64C9@SN6PR10MB2911.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Vva+FyNNyyK79snVuknc4xfLvU/2kKsfolo3PyIYdePBqYmdInZta0oR3iAX3n0ZgdNYRYhjT0Z6rEa51e3Vy7MK1bqDsOu//pfH9rH2wW2FHeEkU6W2DGxHPvH/yCUw8HJfmoPB2ozslR3vjS1bLGdCpHBocPQB+JCEuks8zrGWuiOmEYe9YgjLpNr7Y32OQjPBdbsXj8DXeT+Dpxa7giwbG41EF9vQ0P/36HI9b4h7z64A1Qr2/9rry97MXtxK1Ep3zWIK8om6Gzo9IoScnyjvi2vPAATlfo9LPG2v9x1U2Urie9tsUFGAzvUI//h//t+uz4zQd9ULkST1Ulk2gFfDqsiqvTDb68nhQmyl9e97d99ulrm1B7tFFdbWpqhJn74i8Fi+/Mak5r6qmFZbFzz/kiHwA9JI6tSlxd6Z+rs2oHSsyaVMFkcz/A5bFsLaIEva+TBSH2LZW/nFCwfsN7JPKCLRyKPq2bbhQM7UyTdJdxWiHTjKZ2fL6nSeu8E5Cvqrfux246uGpz9VHuzVYSy4/H3JaiB4/1q1t5i6SjBfHgbHyhnHJMFtlgSmVOL8hAQkl1mlyqHUGhJZ7RIjSN+9tUwhv7mabiv9kD/o3pu9PE1gvG6VXgSrFRKS6uZN74hlCVUKXWH48HZ6bdTvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(53546011)(6666004)(9686003)(6512007)(66476007)(66556008)(83380400001)(8936002)(8676002)(4001150100001)(38100700002)(316002)(5660300002)(54906003)(86362001)(66946007)(33716001)(4326008)(6916009)(2906002)(508600001)(6486002)(186003)(26005)(7416002)(7406005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUx0E56DRIg8YqUNGrrI4P+wkqFOTJNYdn/w44dNuG/9zmFSTRLcRNEWWuSo?=
 =?us-ascii?Q?knl2//x0jQxkF3alkJsS4PIFIrAr6wQ0hLHRiAwLsKx8h4GlyL1Sgn5e1ldx?=
 =?us-ascii?Q?ShlAK1qI8TSzu7ZzLasQV0gq2HoBKsEU6Gs8ZkqP7ShsbFWsNznCNk3TUNBO?=
 =?us-ascii?Q?8DALaLY2vLrIt+Ip1pK8yzdPIJzXngbSHlS/5T4rUthI1keaZy6Zhy4VyDuY?=
 =?us-ascii?Q?7lXThqo+rTgJBnwh0tjsD2K4dcOo+aaO8fD0JrMlnUz6n5LY6tU9+g/ItnjX?=
 =?us-ascii?Q?OocVw569oWQJBBq2wQLjPAhJBf8hjuWhBfMb0BxDr4aEzp0hZNtSTe7JCFeB?=
 =?us-ascii?Q?FCGzfBWbfUrGSHMfdipB3ArBTl/iqjSoSbQpTHV1Ev3za/D3KA8QukPUEG3e?=
 =?us-ascii?Q?qRW+yGrN5B67meGpAtaDg9PGWN0V3cgeY+aMfZoj1KEPlAU+1p1oE5RONCiY?=
 =?us-ascii?Q?2gttlJQRZbT8K5d8fugbq424P2fmcnBT9y/Ep28e4zQdycwi4ST8z0NfoK23?=
 =?us-ascii?Q?ubwyqQXs2tetL/cFl1B1QcFBGVkkGnKJ0QPWH4nyBi3hb748X19aINVVKCeY?=
 =?us-ascii?Q?QZjX89h3SElojFsYqPVODa2/E8EYYADgM0+J59wnirJgW610zT6psbY79zpV?=
 =?us-ascii?Q?11yk4TW5li2KfKLdxMnMg5gjHKwfQ9WDVtZCuuVBW9i3WBO/v7NNfbwLI0Ar?=
 =?us-ascii?Q?impxOf8UMQazrEPlzKU9DrzhxVctSnx2RShDlrXQ374rrlLwUD34pnopilLk?=
 =?us-ascii?Q?u8MDyPWpFpcYrKMKZowAkixvX6PK4gRhb9Lg1LyyHCy2LoRU0z1Zk72tMZhG?=
 =?us-ascii?Q?sksG6nSUwSGxvRh/MGsBpwrl/Vj/yBIDf2tF1NpFiYhzasFrkSnl5dZbi9Nz?=
 =?us-ascii?Q?98lAaxuWCzEWcNIkgIWFGAHxjh0F00bdNuT2ZWvCDNe+9QKi7PH0MiVtSrVt?=
 =?us-ascii?Q?CChDbWiT5NXDHazjnqSS8VTPl9vGlkMu/bAEe0XG89ksG9E3fY+NAT8cI4Cq?=
 =?us-ascii?Q?b+By7boRogBwy21upCToK+zUhZw54/LGypW+PhzsxNppdW8uU4TBC4g+uF9p?=
 =?us-ascii?Q?o4/8EY5r526pXu4IOtn+Mk6Sn6mOojcKQVvqA5ZXIRcXFV5vYID5FFfoQ8OB?=
 =?us-ascii?Q?AaBUjuHvOgC5PysJFpKfONnQOyv0bXOAYK1bk7aI1NEnY/172QCQK1RSVf6H?=
 =?us-ascii?Q?o0qIiQ88xKpMhucIHX276kLq7JFC9YRLPT7yuVJQYdcAppCR0ZNqHydE4fgZ?=
 =?us-ascii?Q?0ZJoPFnW4q9/UWG+9GUC62SKAbBuwWl1XRMG3dxXAEW+aMJNsNEW7Ykz1Cgj?=
 =?us-ascii?Q?3yqI5l/zxJNAq3ywiGrVp3UKiHjyJsXZX3xbCNHTWPR2bxYxhXiL7qn22eT2?=
 =?us-ascii?Q?ve+jzsawY++2/RMX275utD8rf2+574lKPUyq904mmWBHeeuHXMmyCPoM9l7z?=
 =?us-ascii?Q?l9Q2YX1kfzDXOpFAOJjK0f140AKa9QXkKmwUORz5SaC10jvFXpAaFJG1Y5sl?=
 =?us-ascii?Q?hxKU9gkXTxx7kvzg8frL4+YYDwQjpy3eJgDqptfeJdhVzvxBIFTigJBF/lqd?=
 =?us-ascii?Q?ZnfOKUFcXg4YEp2Ou7C8y2nzbxLkXeCADOiYcSQ59JEghytWmaOgzPo9EG/6?=
 =?us-ascii?Q?17+WSHFM/oeAonKYHkPmEG7qMku07dtStYMOACgwatl49gMNH1HvDutHoRuU?=
 =?us-ascii?Q?qzktQQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7189e649-a102-476c-d38e-08d9d14f0539
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 19:59:17.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrV20zjBRaOYxfSZsT7gppTCwsiXUw7yfm1fInTa6gTj1t6ZiePrFbxyYCBeEo4TVEdXMF1R4ja6GoSSkZ43DKXdhKzAfKxty29K16ytLQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2911
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060125
X-Proofpoint-ORIG-GUID: wgiu0y_xoREVOvE1LoNLSOAplTYbYXPV
X-Proofpoint-GUID: wgiu0y_xoREVOvE1LoNLSOAplTYbYXPV
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:16 -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Future patches for SEV-SNP-validated CPUID will also require early
> parsing of the EFI configuration. Incrementally move the related code
> into a set of helpers that can be re-used for that purpose.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/boot/compressed/Makefile |  1 +
>  arch/x86/boot/compressed/acpi.c   | 60 ++++++++++----------------
>  arch/x86/boot/compressed/efi.c    | 72 +++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h   | 14 ++++++
>  4 files changed, 109 insertions(+), 38 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 431bf7f846c3..d364192c2367 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -100,6 +100,7 @@ endif
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> +vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 8bcbcee54aa1..9e784bd7b2e6 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -86,8 +86,8 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
>  {
>  	efi_system_table_64_t *systab;
>  	struct efi_setup_data *esd;
> -	struct efi_info *ei;
> -	char *sig;
> +	bool efi_64;
> +	int ret;
>  
>  	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
>  	if (!esd)
> @@ -98,18 +98,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
>  		return 0;
>  	}
>  
> -	ei = &boot_params->efi_info;
> -	sig = (char *)&ei->efi_loader_signature;
> -	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +	/* Get systab from boot params. */
> +	ret = efi_get_system_table(boot_params, (unsigned long *)&systab, &efi_64);
> +	if (ret)
> +		error("EFI system table not found in kexec boot_params.");
> +
> +	if (!efi_64) {
>  		debug_putstr("Wrong kexec EFI loader signature.\n");
>  		return 0;
>  	}
>  
> -	/* Get systab from boot params. */
> -	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> -	if (!systab)
> -		error("EFI system table not found in kexec boot_params.");
> -
>  	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
>  }
>  #else
> @@ -119,45 +117,31 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
>  static acpi_physical_address efi_get_rsdp_addr(void)
>  {
>  #ifdef CONFIG_EFI
> -	unsigned long systab, config_tables;
> +	unsigned long systab_tbl_pa, config_tables;
>  	unsigned int nr_tables;
> -	struct efi_info *ei;
>  	bool efi_64;
> -	char *sig;
> -
> -	ei = &boot_params->efi_info;
> -	sig = (char *)&ei->efi_loader_signature;
> -
> -	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> -		efi_64 = true;
> -	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
> -		efi_64 = false;
> -	} else {
> -		debug_putstr("Wrong EFI loader signature.\n");
> -		return 0;
> -	}
> +	int ret;
>  
> -	/* Get systab from boot params. */
> -#ifdef CONFIG_X86_64
> -	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
> -#else
> -	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
> -		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
> +	/*
> +	 * This function is called even for non-EFI BIOSes, and callers expect
> +	 * failure to locate the EFI system table to result in 0 being returned
> +	 * as indication that EFI is not available, rather than outright
> +	 * failure/abort.
> +	 */
> +	ret = efi_get_system_table(boot_params, &systab_tbl_pa, &efi_64);
> +	if (ret == -EOPNOTSUPP)
>  		return 0;
> -	}
> -	systab = ei->efi_systab;
> -#endif
> -	if (!systab)
> -		error("EFI system table not found.");
> +	if (ret)
> +		error("EFI support advertised, but unable to locate system table.");
>  
>  	/* Handle EFI bitness properly */
>  	if (efi_64) {
> -		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
> +		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_tbl_pa;
>  
>  		config_tables	= stbl->tables;
>  		nr_tables	= stbl->nr_tables;
>  	} else {
> -		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
> +		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_tbl_pa;
>  
>  		config_tables	= stbl->tables;
>  		nr_tables	= stbl->nr_tables;
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> new file mode 100644
> index 000000000000..1c626d28f07e
> --- /dev/null
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helpers for early access to EFI configuration table
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Michael Roth <michael.roth@amd.com>
> + */
> +
> +#include "misc.h"
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +
> +/**
> + * efi_get_system_table - Given boot_params, retrieve the physical address of
> + *                        EFI system table.
> + *
> + * @boot_params:        pointer to boot_params
> + * @sys_tbl_pa:         location to store physical address of system table
> + * @is_efi_64:          location to store whether using 64-bit EFI or not
> + *
> + * Return: 0 on success. On error, return params are left unchanged.
> + *
> + * Note: Existing callers like ACPI will call this unconditionally even for
> + * non-EFI BIOSes. In such cases, those callers may treat cases where
> + * bootparams doesn't indicate that a valid EFI system table is available as
> + * non-fatal errors to allow fall-through to non-EFI alternatives. This
> + * class of errors are reported as EOPNOTSUPP and should be kept in sync with
> + * callers who check for that specific error.
> + */
> +int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl_pa,
> +			 bool *is_efi_64)
> +{
> +	unsigned long sys_tbl;
> +	struct efi_info *ei;
> +	bool efi_64;
> +	char *sig;
> +
> +	if (!sys_tbl_pa || !is_efi_64)
> +		return -EINVAL;
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +
> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		efi_64 = true;
> +	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
> +		efi_64 = false;
> +	} else {
> +		debug_putstr("Wrong EFI loader signature.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Get systab from boot params. */
> +#ifdef CONFIG_X86_64
> +	sys_tbl = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
> +#else
> +	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
> +		debug_putstr("Error: EFI system table located above 4GB.\n");
> +		return -EOPNOTSUPP;
> +	}
> +	sys_tbl = ei->efi_systab;
> +#endif
> +	if (!sys_tbl) {
> +		debug_putstr("EFI system table not found.");
> +		return -ENOENT;
> +	}
> +
> +	*sys_tbl_pa = sys_tbl;
> +	*is_efi_64 = efi_64;
> +	return 0;
> +}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 01cc13c12059..165640f64b71 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -23,6 +23,7 @@
>  #include <linux/screen_info.h>
>  #include <linux/elf.h>
>  #include <linux/io.h>
> +#include <linux/efi.h>
>  #include <asm/page.h>
>  #include <asm/boot.h>
>  #include <asm/bootparam.h>
> @@ -176,4 +177,17 @@ void boot_stage2_vc(void);
>  
>  unsigned long sev_verify_cbit(unsigned long cr3);
>  
> +#ifdef CONFIG_EFI
> +/* helpers for early EFI config table access */
> +int efi_get_system_table(struct boot_params *boot_params,
> +			 unsigned long *sys_tbl_pa, bool *is_efi_64);
> +#else
> +static inline int
> +efi_get_system_table(struct boot_params *boot_params,
> +		     unsigned long *sys_tbl_pa, bool *is_efi_64)
> +{
> +	return -ENOENT;
> +}
> +#endif /* CONFIG_EFI */
> +
>  #endif /* BOOT_COMPRESSED_MISC_H */
> -- 
> 2.25.1
> 
