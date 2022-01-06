Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB93E486D5D
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 23:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiAFWtb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 17:49:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61902 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245167AbiAFWta (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 17:49:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206KoXr1014686;
        Thu, 6 Jan 2022 22:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uV9w/rG3QsXszUxB4sbKPMLRApxEe9KQiNuD8hpK3ao=;
 b=hRRzIsxonh1I76pK+fd4woxIE7wakFcgdu3elASg1jkgUwHk3fDhxZOZE/vv1J0HuOIm
 msE/w6wes6rUiufDxNUqAgMJct9Q9T+x5jJ81UhvGrckK4uP82wMS8VeceNglGfm4g/j
 05/VFzkcrn6mLz8znYXCObHQIdajP1WhLmxNw4w8EXqZefo51ctDbdJX9PjVk+M5Trjl
 ubS8auyoMMuBZaWkvX2uMTfXaulHA4+o9bnUdbO1p0Z0aOC/yM/fiPbn21EpK3iFQmXb
 OgBGLOGSy+vshJrQjdvlLw/jHHWEzq/mcV1QIq0ogWkdGjI4nk1S1DmoNKVutVYVN8Ij IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8gpe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 22:48:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206MeCxM117844;
        Thu, 6 Jan 2022 22:48:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3030.oracle.com with ESMTP id 3de4w25u16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 22:48:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEp7Yc4fgr8a96og3cRF/xERbNM3E/AZ2B0Qp+nEFkR5/BaOftGblS63Xk7jw3+K0ygK3Nb79pf9Czhw/vHgiB9XxxTlQ4J0u9F41+4+gyPPCt9oWXthKtNkNkAvQgX6DWJU7fU6ydrGIG/L/UrCVhw0kgCNUGaENPbOusC7f+YMvop7q47WZYWdErjxsJ3O6P+tWJ1s9Me5Hr1wL+Yt2tMc//hHX3e+nv0mFW4t1S9IJ12zW2J1xH98P/S0Tx7GzmROb/EFKpj3La4P8NRYodHzmWtfxYnASBd16lflmwy/JucVHFPyBqcsAldsUJpKShV6LP+Rww8AiJXPwsQrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV9w/rG3QsXszUxB4sbKPMLRApxEe9KQiNuD8hpK3ao=;
 b=mueTF5uXimQrxUI2gIM/MUyLD/3PpMaN+Kqf85nDLkdQplSttu8TiEqVoV56Q0YNwmfQo4iJ9Cts1VF5bNhpKvj8kvqeASwdKs3uBPcCATo1sz5u789xbWv4saliIodPmv6UEihGd5gZpp6XM2/OKC3Bbdb4m9vZPzIKRMkQuN3tpdLfrZpVP20Wh/JfnSDBLTIvK1arysBEpuEEFVctQbh+ejC5oarHfGZhdmG7nqTY1yYJMgtbp4t4W5LGkk7zKNa5V+kRcbfY9/oEDxtnC6eOp7GELERMYcswK03TTHGdVQxopRj3ev5XEovnfPrbIu9yOniS0quPSTh4jJEj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV9w/rG3QsXszUxB4sbKPMLRApxEe9KQiNuD8hpK3ao=;
 b=ruRaO51l5XgJZOVA5Ifsar8TTXjsdhok2VhYZ0Wd7KQ1jaX/Q/t5tGnex7MePSLsMrJCWGzqLVt5UGnJKkgK5v+QGQy9HZDJEUqMM2HceFpKu1b3wlP4x1snUUb0I9yO87QQZWG8HzO7fdJh0C9R7saHKCw3b8vNMGpVF7xr6xM=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 22:48:46 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 22:48:46 +0000
Date:   Thu, 6 Jan 2022 16:48:38 -0600
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
Subject: Re: [PATCH v8 27/40] x86/boot: Add Confidential Computing type to
 setup_data
Message-ID: <Yddxxihyz+TQGqRG@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-28-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-28-brijesh.singh@amd.com>
X-ClientProxiedBy: SA0PR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:806:d1::16) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3023b0e-4267-4201-1eac-08d9d166b281
X-MS-TrafficTypeDiagnostic: SA2PR10MB4762:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4762EB17F2FD72E6098F5A21E64C9@SA2PR10MB4762.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OZ9dw/IsZkUgH6XCaiyqtPdmzPx+P2QYUhKw2YjdOvTsjRFEOkcjIefLpOwJUQlSLmL4UnTlkXBkIn7YySBNgFBxFmbmvueaAOwYRlGBI/H2z8x1XP8fwAvfoye6Raw5zgz1+b9C5NOSRdK9tYlSbt7X5KXy0lTP7SDa6pPkkqjV6+Xu8GwsY4Abg1YbwUmj6z2obsSxod8pq9S+dPlBowSlM/EGuadNZRUqABhTduD+s6SlrEnK7RxxGRvJmpjYR48aeh73omiGKOQ9z7DxOD3tXaG3lRXend6vLItHuifcnXemaaMDOCXAe0yVP6LnrECySQb/9MX0IJZ513CJV4gXYds1K3/Udx2Bg4iofGPfV0fmnh1EMkrjXoHKGD9PXf0JScMsapUW7RcGnhmZSNUO5Jcw8DQ3UKGxxDBnQ2REeaTSadlSn+nNeEA8Ta5NCMnp0bBL0U2CLYJD0aP59nJMEPlNOi9umOdGr+m+X6nvCK/Mnrg2t9bwL0r+lrjiedeZffc5GR21p+aAG/CXfy0X4wdp3/r4NX69fblAgqPT7BHgY30cqiy124eFI1fbE9+vQoL3NzJ5gzxnIOTXO4gFQMZTWRJOjr0LvSN/JJOfqz9G3K55Bpxfu6KUdMAt9WaQ5iNHQDQ8VyjszSZc8/flYETrqNUN7cP9WOsoVW5OffVL75K+bT2nZxTrPIN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(6486002)(66946007)(508600001)(6666004)(2906002)(4326008)(38100700002)(186003)(8676002)(26005)(9686003)(7416002)(66556008)(8936002)(6506007)(66476007)(4001150100001)(86362001)(7406005)(33716001)(6916009)(5660300002)(316002)(44832011)(53546011)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25MyC9d791eAvI8noyW8xMVOxAgpz71zUqVO9lHSgZCYhB/mezA+g72R7yG0?=
 =?us-ascii?Q?WOALmuc7exNXLYtysHKvc7rny48YlQXoPXQ2UnCccyB5vBFbDXM9epmuN2hj?=
 =?us-ascii?Q?/Q4rqxd5k1F+53aV47bj7QA1S3Zq53NX6t3OBkQLyN8/cBQMSCsExndb2SxC?=
 =?us-ascii?Q?wzTCYqwmLLWXa46IiSFOCZXZGdfeDW+N3DixSzLHISwjH/pDZgnlXboAjJGs?=
 =?us-ascii?Q?yRJTuWKFdCNt1SvSyLa7tkzcvA1/zj29LOAgTo45jZp6Qrlvcw5rCbMnV129?=
 =?us-ascii?Q?HsY+pERA3EdQFFNJ90UjxvozduPWWOJ32Kx5UerjcotrSJiTOkmCVPXvPt+T?=
 =?us-ascii?Q?/A5mnjjfsOlc9fY8CcKnWjp0p3GfGjK/rypK3TbvU2mDe5/wIgEfvsRwLF8S?=
 =?us-ascii?Q?FvC7QpDmcC/33n5l8E3GHvNPdHIA6Q+i+U+btUQcp02/Y76rhckbwj9Y6RKt?=
 =?us-ascii?Q?G+0JH3vfI1KgasIWDIrhJpI5MRa9Cnlf4vrBwSJ3K0/FetG0FkGWGVqlCuTY?=
 =?us-ascii?Q?+LgtjIEzzpBZxsrJs/cU8Fzq0oNgvwDGJ2jVvlRlwJ1YxxjOGZFRNSKMkvmH?=
 =?us-ascii?Q?rBgTd03CDU2v3oI6RgBcgqBjKlSCXJHkvhtjmcvWJhm8G1jXOVX6NcG9bD83?=
 =?us-ascii?Q?jcBEzbzuIG+9CzP82rflgfRQM7EBUlMfg2dvQeMn2irlIGqaUV2dNbQBkGrw?=
 =?us-ascii?Q?uaDyX3sEg0te05WlLL7B4VpCrfoMFCQEVDCPez0cMTvwCDWLl6B+gBqpsYkT?=
 =?us-ascii?Q?LLuCn7J80K7Yve08MfHM/oItm4nKf3jCaNRXbie3uVTRdgso2FxwVTTnu/xx?=
 =?us-ascii?Q?z/Lx/ESraUaQXsMy/prhAih23AaMdYdyXaFpT81bvadO2+didGNMB/0bZMKb?=
 =?us-ascii?Q?W00zl+tySu41JgYtHROlCsYKSEUKHwhJabsfe3fpUlcrBUdeZdSLvsvKTZ9U?=
 =?us-ascii?Q?xrvkDtvE2lfFM9kjqHBaBIjTEArBbeVhz6JQzM5jfNF04EEHrg/9IyBqD31r?=
 =?us-ascii?Q?DXdNo+9DcrGokBzXvX7+XOOo7UnIdMmj4HQcIlr8GiPCJq/daFTKcMmgU6FI?=
 =?us-ascii?Q?OG+GQYGvTrGz4HgF0TBDEF0/j2ZMjuur132Dv6kpzu9/tNQ94nNNweoHn+Z5?=
 =?us-ascii?Q?4XXfr/tvBF/bVAiFIJSag9XYwocg0wDCjDv/T74/q/vu7sDboR2gS/7Hb6hI?=
 =?us-ascii?Q?e4xZvszSLpqls0s7NfXZSiFn1aw2EKH1GfLl9NmKhOw8mIanwEFuorwNpaeX?=
 =?us-ascii?Q?AnmzTzCrUcw5ngJWbj335QQEbNdUFjJ27ccyXFYlnrrIZndzGnMkQPXPDDUr?=
 =?us-ascii?Q?aOwuL/4y1vcd4fZaWBbeVIUE1Cz1wUjqsbInYoZR/dioL7FWpfcto+nxmedI?=
 =?us-ascii?Q?KBdTW2xkaXSGxGctoQsUDMXRQN+Nn4GyfRfqh3F6inDxv3d1DzdUdKgsoa6v?=
 =?us-ascii?Q?ubCs6MdeMkhuIl+SQYAaUo4w0BTMkW4TccensRfEqds17wrXzRX7OorIojH4?=
 =?us-ascii?Q?lRk/g4ONCf/KG5/qwnbOaFHqnQTaPmtHCyadPKoFwv8gh1kTw60YBLsSHuW1?=
 =?us-ascii?Q?8RtcQEe4TgGdoDZVC9zfB+J+PMSmBXtlAsrOMFfpFI/3blE9W8V9nlTvrFsL?=
 =?us-ascii?Q?XS+I2/YELnHIzBHt56mvD/70IN4SZcx+g+r0Lk1Qc5Bh0/zKuJTmawYA+PM6?=
 =?us-ascii?Q?Fiftdg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3023b0e-4267-4201-1eac-08d9d166b281
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 22:48:46.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVlKLFpR2z8+DNCxUlx3C/+KMqakENofWEubyQsPCFT/x6jf7X2jW5hPkiuK+u2H9UK+HOiWZs1BONvFt21uvoeDy38MqHg39R1oEP+qSIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060138
X-Proofpoint-ORIG-GUID: vTskAwG4vPioZVYneogPdubVIPsgitpJ
X-Proofpoint-GUID: vTskAwG4vPioZVYneogPdubVIPsgitpJ
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:19 -0600, Brijesh Singh wrote:
> While launching the encrypted guests, the hypervisor may need to provide
> some additional information during the guest boot. When booting under the
> EFI based BIOS, the EFI configuration table contains an entry for the
> confidential computing blob that contains the required information.
> 
> To support booting encrypted guests on non-EFI VM, the hypervisor needs to
> pass this additional information to the kernel with a different method.
> 
> For this purpose, introduce SETUP_CC_BLOB type in setup_data to hold the
> physical address of the confidential computing blob location. The boot
> loader or hypervisor may choose to use this method instead of EFI
> configuration table. The CC blob location scanning should give preference
> to setup_data data over the EFI configuration table.
> 
> In AMD SEV-SNP, the CC blob contains the address of the secrets and CPUID
> pages. The secrets page includes information such as a VM to PSP
> communication key and CPUID page contains PSP filtered CPUID values.
> Define the AMD SEV confidential computing blob structure.
> 
> While at it, define the EFI GUID for the confidential computing blob.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/sev.h            | 12 ++++++++++++
>  arch/x86/include/uapi/asm/bootparam.h |  1 +
>  include/linux/efi.h                   |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index f7cbd5164136..f42fbe3c332f 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -44,6 +44,18 @@ struct es_em_ctxt {
>  
>  void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
>  
> +/* AMD SEV Confidential computing blob structure */
> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> +struct cc_blob_sev_info {
> +	u32 magic;
> +	u16 version;
> +	u16 reserved;
> +	u64 secrets_phys;
> +	u32 secrets_len;
> +	u64 cpuid_phys;
> +	u32 cpuid_len;
> +};
> +
>  static inline u64 lower_bits(u64 val, unsigned int bits)
>  {
>  	u64 mask = (1ULL << bits) - 1;
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index b25d3f82c2f3..1ac5acca72ce 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -10,6 +10,7 @@
>  #define SETUP_EFI			4
>  #define SETUP_APPLE_PROPERTIES		5
>  #define SETUP_JAILHOUSE			6
> +#define SETUP_CC_BLOB			7
>  
>  #define SETUP_INDIRECT			(1<<31)
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index dbd39b20e034..a022aed7adb3 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -344,6 +344,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
>  #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
>  #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
> +#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
>  
>  /*
>   * This GUID is used to pass to the kernel proper the struct screen_info
> -- 
> 2.25.1
> 
