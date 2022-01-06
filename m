Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F58486B3D
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbiAFUep (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 15:34:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39448 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243881AbiAFUep (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 15:34:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTKSX011025;
        Thu, 6 Jan 2022 20:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vl8Otsn8BZVXB0CLDfvx+yjMbQA3IWvMR71V3Fmzgvc=;
 b=dA+YoglXWyAfZNS1oaZs7L2tXVJ5VXKcF9SBUHZGq7lNPr6+dig9uidUEC3cEMAGiHY+
 BshJ78pWY9TKo+2+8wxqM4/A96zwOiGUKIHx3ZHzlUG+vM4mztuT5KpbGt77Ms8sTeS9
 ZKH9TpCvgH5y3MRANrBfB/Li0YjbyIRs2lqRkqK+GPTjh6228Wdb7u1VXXDDn8g1z6bj
 sPnzd1wmer3cluQsFz1df+SRsVBpLRdaPEjXA8O35ysNtV0gSfblmEG/+KCDZpncQixl
 gcW8TWuZezLgfd3Izqki9Hn0rGJY6iXZdrZiWhGvtt7ey8vyxWXtfUM9wB4V8UxDGARI Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vb8e5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:34:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206KGBo8067060;
        Thu, 6 Jan 2022 20:34:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by aserp3030.oracle.com with ESMTP id 3de4w20kq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh0w+g4MLfkO0FQ0j+XYJNud+OO4W6KSndJhxhfiZM8pNn7KeH7N5z20Q5OfAtcaDsILq+YvNFutw+2r5WqPd8YeuKwNdNybmMnP+INP0hqDNNE3ACs30s5xZK6ZrRPcmBo0OcTKDgCm+wsJwSg4fSZlse1g48D5nPM5qtLazKSjsj8n8J8n4cGtHrOSiKG1ecGrCOG1ZbESd9yMZ870ztaRTxvefCbscBdPWvMmNClRbJ6gx0HNXxMAXY/8VoVrWFKMPOcWiMqycctQgjkV/WZwmHST47OJqo/m5Dh6J5Umf80wq8dRFGzkBrfM6QcXrZXxfkYspwbOVQxyFND+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl8Otsn8BZVXB0CLDfvx+yjMbQA3IWvMR71V3Fmzgvc=;
 b=luvgmhqYwskm5Uz3gkkgq2Ei16nrwm/R6avYqgAKSGOEiC2ayn9yblpgGeQQJbiDYAfrkwF7wNSYJyp+iLdZaucZw06hS6rYQewnbRP/FBwnxHw8ZK8021wArmcvJeGnOkyTh6lD7E3WXijymrCDn81JrPl2IjsqyZK+inW421I7I2gaQeTcXM8rkHHY2lK8AgPZybjEy8Kd1rDmfPs4Jun6k5o8extJzqTp0WHwj35e/8ijUQfPQN+BLYVf0G0TlD4V31LkMibxyivBoFzwIql/LnsqHSs++PfQ7nwclQV9tqa6NazDuIlOhsn+iKi5MHEER4xDoXomfRV17rOJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl8Otsn8BZVXB0CLDfvx+yjMbQA3IWvMR71V3Fmzgvc=;
 b=Uk6c/2OUgZzIn0pHIzkEILkk9dRy6+3ScqU74JW2o6fnoy4dDuXOe5hIxTWzvd3rEEsMIvFKmqqv0M4itHePX27ps63mLnox0TBgPO6nhra6dpxRRN2GOtKK6SuL1cEbW9oiUqFt20tWQzQHDuxg9qcmqgi7qDr0IKrlM+ypqCA=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB3024.namprd10.prod.outlook.com (2603:10b6:805:d1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 20:34:09 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 20:34:09 +0000
Date:   Thu, 6 Jan 2022 14:33:58 -0600
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
Subject: Re: [PATCH v8 25/40] x86/compressed/acpi: move EFI config table
 lookup to helper
Message-ID: <YddSNrV8CHoxWhbn@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-26-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-26-brijesh.singh@amd.com>
X-ClientProxiedBy: BYAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::43) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0adef45-4aa2-4ad1-cfd7-08d9d153e44a
X-MS-TrafficTypeDiagnostic: SN6PR10MB3024:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3024FF9EED3A3468ED1A573EE64C9@SN6PR10MB3024.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MpafFJO4yaWx8wvIs9Ey8jKLyKQJ6C5pkAezrH6vhEtVnEMdANwK/P82Sn7axdSQNyiX4V7IlkYYyY/WanTUAaGJP7MebfhCxW/9kPj+/5k2SzR9Bpzj/RCmftz/liYSCQ/HbeGg/IcTrOIB+iWLo6uVjhTVhUva5RFejMj9xcPG5KJXFckH2aS5e24NwSRSpngZHnBUmVaOPY8ta0QTbAyiv9Sbkry9C88Qf/fHrC6bv4DF+XYD0SA+HZ6WUdyOnSD8VG65hr+4JBw7pSSgq7NwnDg73mp0r9hujcrNMvZ+InZfwfl5YX+R+t6aY4qYutI94UwA0X+K0MdCVicuy4d3p1Cod/sHA5k+GWR5f4fTB5B6eS/h+LsZuGguu7jGh0C5TYG4lOP22/M7hoPt1GMGHZclnrIvTA24Mwkoex7uxQV/sV8l1OBOJQ8sCvM0iPPgrqP+GM0yRq/ZJs9uu4LJZZdt81LjafAVI2RKD3Iq/PN33V87gwa+5925AP1nipBWiPRoxz3/vLDFcBLRY9I5FV+IWeZINQZvkXcvgW+RczMO5x8qMkmwvmvEBWOArygMy+YBxu5OSB3EGE59wqx4b0SRCgS5z7O1Br8PPydfeEzMi8JiGs72NpzRO1ycCqQ0y6g9oR0f9SavFav+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(8936002)(26005)(316002)(2906002)(53546011)(54906003)(38100700002)(7416002)(6666004)(6506007)(8676002)(6916009)(66476007)(33716001)(4001150100001)(83380400001)(86362001)(6486002)(6512007)(508600001)(5660300002)(66556008)(7406005)(9686003)(186003)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UfV45eTu2sX72eEwnNXj3cT2n488wg84zn5mX0LV2j6rt39ooqZCZAI9owIy?=
 =?us-ascii?Q?zTkqAesAVNNrxa+GpItmPhBGMv21RkIWrd67diN9PFMqcUBCAfkfqf9x/KBe?=
 =?us-ascii?Q?v5iXlczAlHaWEbs7clFPkeqCw5qpDsUIARLUM4D4MpaMgV4QWXXQvbxXgZmP?=
 =?us-ascii?Q?KCoGRfkdwznPe/KT/TvrPYptDUjUwvq2okMc7GebB4MU9yBMQ0z4RNCxFbNx?=
 =?us-ascii?Q?5p2eUJFfruptNEDuuNC8CSsEHfFILwCRkQsHyWnNkbHlQ8GsqMU6Hw77Fgyw?=
 =?us-ascii?Q?VSok8UiObwyvtFr7nT+ASFLrbC42DKVzbstzoUkyPAi25jBw7IBXY9JEjPbp?=
 =?us-ascii?Q?g1d+Hp8n+myDQMtVAj0xOX5OlFBp5td4GOEfST5PLVZstSuw8J5QVPfzhQWx?=
 =?us-ascii?Q?5TsAk1dmVq0k6b4QJjYvUhhElSTxeH7qBJTvH9zoE66gZPuBmIOR4urK2nq1?=
 =?us-ascii?Q?VgElSZNNlR5Sq5lZ94z817F0xlfzSAPMPRm4SYglr7bKrXBZMUE3V0AppJSA?=
 =?us-ascii?Q?ALQqpaUtX96bAfjESq1EvjHO+EbkWlSf8t1SQRlSVX2KM49kN3/RQLlSwicT?=
 =?us-ascii?Q?4M5MPX6kOmHhBCqifadIzjXYXKkzRU3iHKem0SBaRgUuebrx+thpJjX/Khmz?=
 =?us-ascii?Q?GWP8L8JO16S+/+si/2D6at8bqONMZWz9kR7KF3Z7liuKKHhGLaeHNPmG+pGq?=
 =?us-ascii?Q?9pN1BJ8HqqGhKmUD/kl/EZFL0xZ8BOt2QehGDfHHkAMK/FnSi5ZP0Utgkbs5?=
 =?us-ascii?Q?KVz5/8abEwyN1eyJWyZJhlwxO1tEydWtnrDOoXuhhaZkHtwC0H1RImf+xN3z?=
 =?us-ascii?Q?imhzg3sTeUq9fIiN24wY4vHn2aHvmZIMBhkMeuXBF5BJxeFWVNO5ByETlKrh?=
 =?us-ascii?Q?XemfS1iDRaDFHxY/pf2eA+PQ0JwUP8p793mV/r1i/E0WmI2im6v8cbTSzZEC?=
 =?us-ascii?Q?1U8vUUG+kTfcuHd6yIFnytmp7rynl4s5zM6Yfq1k72/UYw2nUIpa/ETM9C14?=
 =?us-ascii?Q?TiRRycGUYC0rDkgVbn9+jwlzboJO7jDZopGPGU1NgBIoE4PFIgyspzDPO1xt?=
 =?us-ascii?Q?VIO0OrKmTQXaLVMAw7RQqdVyk/rF2KykXSP3Px54RaoyD/ON9qKwxRsEmu9K?=
 =?us-ascii?Q?TyrsPSmDPHJhB/eJvpM05O0NlpSJOU5zYsXdBHz0+OXs11XETYgBPBtxiOOA?=
 =?us-ascii?Q?1WyeFfibcukSVqT8sDubFZc1Su0B05X5ZFKZH1/AAX2v89vUrr50UXS6kuLI?=
 =?us-ascii?Q?cX8Qq/bsEmfsMGBLH7GBbQ46j9dcMyAe2SOqwUBBjg9mlh6MPJAxC1nFTooJ?=
 =?us-ascii?Q?hhl4bnZVXlQKdiKT1XRENHGE5uCnk977TPe22un5/RkRutTyHIBXlsrP4wLP?=
 =?us-ascii?Q?vkL94fdqrJITADn8K0bJiltgml9J2GhPBb2w8QGHNjvE+7TdPIsBmwxzS7k5?=
 =?us-ascii?Q?k42Mtvw+DlSiiaBAL6AMv+EdsFfndMoPqsON1wRXoJFrcB4rrIELmnPvbxU8?=
 =?us-ascii?Q?o9fIW9IGSrUQXT/z3SnnqB9pat+5udz9szPl8Kw4HYxsq6jl59eg1cZi7ckd?=
 =?us-ascii?Q?LmhpKz0ifidG6P7K5juJRx7SdvW0hEqvfiMjA6BPvio1RmEJASaBIjK/W2tj?=
 =?us-ascii?Q?nJiv4NkBxeHsif5mJloL9Ue54tDfPN2qeSrnBrTA7yzXzBpt/OGA25WYWdHo?=
 =?us-ascii?Q?5V+0Tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0adef45-4aa2-4ad1-cfd7-08d9d153e44a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 20:34:09.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX4ce2DCzSP/puYznwT4T8MYhfESROoobFBK+FqEuVejyiJlG4j/el2LKTdW3MCWsvnpA7k6aV5xX7EJsFxDipcKuvXqwX01Y+8xu8y9okc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3024
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060128
X-Proofpoint-ORIG-GUID: k7KGEJO9qWezJzN6VMxKJNp5EJa5IhN7
X-Proofpoint-GUID: k7KGEJO9qWezJzN6VMxKJNp5EJa5IhN7
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:17 -0600, Brijesh Singh wrote:
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
>  arch/x86/boot/compressed/acpi.c | 25 ++++++--------------
>  arch/x86/boot/compressed/efi.c  | 42 +++++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h |  9 +++++++
>  3 files changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 9e784bd7b2e6..fea72a1504ff 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -117,8 +117,9 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
>  static acpi_physical_address efi_get_rsdp_addr(void)
>  {
>  #ifdef CONFIG_EFI
> -	unsigned long systab_tbl_pa, config_tables;
> -	unsigned int nr_tables;
> +	unsigned long cfg_tbl_pa = 0;
> +	unsigned long systab_tbl_pa;
> +	unsigned int cfg_tbl_len;
>  	bool efi_64;
>  	int ret;
>  
> @@ -134,23 +135,11 @@ static acpi_physical_address efi_get_rsdp_addr(void)
>  	if (ret)
>  		error("EFI support advertised, but unable to locate system table.");
>  
> -	/* Handle EFI bitness properly */
> -	if (efi_64) {
> -		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_tbl_pa;
> +	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len, &efi_64);
> +	if (ret || !cfg_tbl_pa)
> +		error("EFI config table not found.");
>  
> -		config_tables	= stbl->tables;
> -		nr_tables	= stbl->nr_tables;
> -	} else {
> -		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_tbl_pa;
> -
> -		config_tables	= stbl->tables;
> -		nr_tables	= stbl->nr_tables;
> -	}
> -
> -	if (!config_tables)
> -		error("EFI config tables not found.");
> -
> -	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
> +	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
>  #else
>  	return 0;
>  #endif
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 1c626d28f07e..08ad517b0731 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -70,3 +70,45 @@ int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl
>  	*is_efi_64 = efi_64;
>  	return 0;
>  }
> +
> +/**
> + * efi_get_conf_table - Given boot_params, locate EFI system table from it
> + *                        and return the physical address EFI configuration table.
> + *
> + * @boot_params:        pointer to boot_params
> + * @cfg_tbl_pa:         location to store physical address of config table
> + * @cfg_tbl_len:        location to store number of config table entries
> + * @is_efi_64:          location to store whether using 64-bit EFI or not
> + *
> + * Return: 0 on success. On error, return params are left unchanged.
> + */
> +int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
> +		       unsigned int *cfg_tbl_len, bool *is_efi_64)
> +{
> +	unsigned long sys_tbl_pa = 0;
> +	int ret;
> +
> +	if (!cfg_tbl_pa || !cfg_tbl_len || !is_efi_64)
> +		return -EINVAL;
> +
> +	ret = efi_get_system_table(boot_params, &sys_tbl_pa, is_efi_64);
> +	if (ret)
> +		return ret;
> +
> +	/* Handle EFI bitness properly */
> +	if (*is_efi_64) {
> +		efi_system_table_64_t *stbl =
> +			(efi_system_table_64_t *)sys_tbl_pa;
> +
> +		*cfg_tbl_pa	= stbl->tables;
> +		*cfg_tbl_len	= stbl->nr_tables;
> +	} else {
> +		efi_system_table_32_t *stbl =
> +			(efi_system_table_32_t *)sys_tbl_pa;
> +
> +		*cfg_tbl_pa	= stbl->tables;
> +		*cfg_tbl_len	= stbl->nr_tables;
> +	}
> +
> +	return 0;
> +}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 165640f64b71..1c69592e83da 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -181,6 +181,8 @@ unsigned long sev_verify_cbit(unsigned long cr3);
>  /* helpers for early EFI config table access */
>  int efi_get_system_table(struct boot_params *boot_params,
>  			 unsigned long *sys_tbl_pa, bool *is_efi_64);
> +int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
> +		       unsigned int *cfg_tbl_len, bool *is_efi_64);
>  #else
>  static inline int
>  efi_get_system_table(struct boot_params *boot_params,
> @@ -188,6 +190,13 @@ efi_get_system_table(struct boot_params *boot_params,
>  {
>  	return -ENOENT;
>  }
> +
> +static inline int
> +efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
> +		   unsigned int *cfg_tbl_len, bool *is_efi_64)
> +{
> +	return -ENOENT;
> +}
>  #endif /* CONFIG_EFI */
>  
>  #endif /* BOOT_COMPRESSED_MISC_H */
> -- 
> 2.25.1
> 
