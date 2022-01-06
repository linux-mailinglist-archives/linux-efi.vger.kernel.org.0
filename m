Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70298486B6C
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiAFUsw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 15:48:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40816 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243985AbiAFUsv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 15:48:51 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206KbJR4016714;
        Thu, 6 Jan 2022 20:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hUyrx87jTgbmTaYW/HxxrfosGHLKpFfDngJzxOdiPHw=;
 b=e1qRLzMy5WgUh4ieSKoE7gH0mZAnGI2nVpAD20+YPIbfgWUqnPZPVXwOYcJErR4K02nS
 aQHSKfhXh6kxAkRX9b4y36a3iK3tv0MrybCgCtsRghKe0XyXW8T0Z9AL7rD8Vn34qf/4
 PPOzdPU+wh9FIWpsuj177PlwsvRtyw01H6co4UsZPOy0/hNUXCJySR88Q/NsiXUsENPt
 XCUzysDLSbws/Np/VOcxoKdH93EdFCUYndfFkFyj1qmbJa2o0sKg3QVTFJTvmICJcn5t
 im1HxELwpUrR0CxJGADOxkHMwfbDKBR4D73Juybg8fGrAoCvKV5F0oi8fj42vXVXwaDU CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v88gbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206KfkWW102039;
        Thu, 6 Jan 2022 20:48:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3de4vv94fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/xsk6gFAID+wAzRoFE/z+Io56uWn2WtwhPdlnSPdt84NGarSG03caabYArIMy7SRidYKoEhvwAY0noZ7kzo1mYtcdswGyrQDB3flKydH4+uKh2M7YMiNnkWmApo651iPJWQio1AmbMWDvi44uF5OUMqftyhWmGfXW6Ee7TY/YANW2x3exw65BIIZ70yEKwHd5MqDM5aXdHb+pyiAhKbIqczqZd3Po5XWr6/6HsUK9gUTXQNxon1J6TVjyNedJENVNZCyBJUYPA1NcZ155FG5ntJSSpVDYgymYEa/wIQUorzwKgNzs+SvZEYEc23o/W5UFJjdwHUNREJECZxT3vIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUyrx87jTgbmTaYW/HxxrfosGHLKpFfDngJzxOdiPHw=;
 b=iDxaSwvf07dRTvVkmYTYSFPBIlWnF+YoUU6JgxT5pGXkN32SpQihh/wsWQq0G5QUJGL4EzAdLNXrymxkYZOMtvCiRWcxeqT/YIKYtznnicUMrNfo7BzMtov0Sk6bR1u+5fF/qL7OWt2lmqeFbAquHWHw7FOlGpvVa+TeZ21y+ZccbaDK8djSiBCmSNCdIZN5G0+jcGvC4rVwWAUHMzG+bOe/wn2XtrxrRtjVnV9eV2LRh3lBz8cTYIzfeXrvkOHuPRh/NRLJhL0oEpk/4DoGyGahRtKUGAxQoRfB6HLzII5y/XG33LPSO241RfCpBgYYDmdzTbchr2kZ3U5C8Wm76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUyrx87jTgbmTaYW/HxxrfosGHLKpFfDngJzxOdiPHw=;
 b=Q4fbVAaNbnLjseenq7bVBT+wSaoVcRVgAnCN4e6Jgsn6eDrOWT/l4ndXKnUK/tqco8LYsqoV6KB523EJH49qlp2PrG32bLDTpkQ12GLWq9hfRcjRZd3YQ+XQ/5kiUm8s207pafZNdrclmOsAm0Xm+xJKB6IOC8e/ottZLqNCao4=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2830.namprd10.prod.outlook.com (2603:10b6:805:cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 20:48:00 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 20:48:00 +0000
Date:   Thu, 6 Jan 2022 14:47:52 -0600
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
Subject: Re: [PATCH v8 26/40] x86/compressed/acpi: move EFI vendor table
 lookup to helper
Message-ID: <YddVeKgHAaB4A1Cd@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-27-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-27-brijesh.singh@amd.com>
X-ClientProxiedBy: SN7PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:806:122::18) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d818881-ec0f-4afb-40fc-08d9d155d39f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2830:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB283082079CC50783F4A22955E64C9@SN6PR10MB2830.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcSGmEVt5zy2XiL+7SkqJURfdKcv5Nvi+rW7nJr4Ob42FAh2H3lpGgOol4WfBNgufSs3AOirj7lyheMtLmA27Soiz05VyLJeBR766yOSgrDlq4R1Oo/cBAzvnr+ZysudgrKK3x0ioNi7VW33rBimt55wIrdOEqu0S0fSBjqJssa42ynMOrNlAoaWL3D9M0kHPyEBzUq8LBWVb7enAXGh5z5vlRZki/UBqljgHf7wXobqwrNLfeOk8RzTN02Bnb+o6ciO0XQ6jc8NbARpOO6iiZjOpGhmB2pLD/gRen9bgjI+Iiw/GwbSMHAVYQfLT8vkfbJoDV7slR08pDBhAt3i4K/d1HsOUhCX9zS0C0+YllYCTbkSSzKdrQ6FQNYDKU2WvZXxfmTTucELaTJGFW+lVMf8tk29Ir1bRMQlulb82YUf5/6MAvGSqR8xImXJ8qj4W+xqKK+gT7yen/jtC9s7Yk+G+DhwYKT6jZYEvUPFEwwZJD8l7yOOqqSnkHYwh4ZvyCUu43M+39RQJOUKCwH0kA0sBBfv7wqES83sgQBs4AMRMxwXH6a9bCvp2TnlzNjLoG9D3m861ufb5KUu1mydV/pQTKteIIqtszMkQy/KcbX2Tk2th+Pqyny25qp4IlYNMo5IS9JVAjLWRv29MdUnYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(8676002)(4001150100001)(8936002)(54906003)(6916009)(53546011)(7416002)(26005)(6512007)(9686003)(2906002)(508600001)(33716001)(7406005)(6486002)(6666004)(4326008)(186003)(66946007)(86362001)(44832011)(66476007)(66556008)(5660300002)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mskmqqwqaeTzLF0qd1uU3H39JxbkSqKgEH8OwZlkEB3HA0ZwwWTtCTT2qgED?=
 =?us-ascii?Q?KZCL198ZDH00aTv6LDTU7YTz9kH7eYYA0wRsxruAuqlneevlDZ295RjV5ARM?=
 =?us-ascii?Q?cDy1TeltFrYxltFjegk76+ET5zlA5jXXc6VEJCkHH/Yb4nOXbcMHHMDKGPfa?=
 =?us-ascii?Q?EKBGdJ0D0ziTP4MOGOFqOKZ+BNTMmgl9jYeXix6fhag055pxT1p9DtpbZ+gG?=
 =?us-ascii?Q?/BOq984Yan02Pu76vjpEOfNeYFgbXXv8dWnfuZTHczc7PcrlGxFRCwg+/x1Q?=
 =?us-ascii?Q?P5rPh1k7E7/XX9Ku6k/fCNhG27XDd3juyBzUJVPMV1EMa1tDvStTDY1NTaer?=
 =?us-ascii?Q?7qKjauQP962O2qS33IaIzmDQ/ihaIApO/mVzCUS8z1khPlhckyUkCSZvZ7aY?=
 =?us-ascii?Q?yxPhzRvV9xDqJXdSsPPCpXCLdGNtX9O+YEDoF8bgCNuR1NFBvOGnlZAR8pF/?=
 =?us-ascii?Q?AvYHvegI7Qv2HTSRJepYrxQgdWJEZ96J7itdHSBQRLA3lLIANsWt87Ga1Auv?=
 =?us-ascii?Q?ebn21z8B/5P9jDvXxIQpCKaThjpnbttjFLUZkzJqSS6TVe6ca+F3wj03o4oQ?=
 =?us-ascii?Q?FJIO4VEfI1NA3YZaEvzaviod5zrZIIZisBdwdkFGoK4EPbaXn2hHM5nhAB8V?=
 =?us-ascii?Q?X3BznCIaGxGMivHM6KOF6sykOaSp9AT9mAi9+NW/A7atmQ54PJCEgbTcl3I2?=
 =?us-ascii?Q?vJmfT/j5lqa2CLufiz06vCIXq2cGSpGoFxrggrIr0hrcGFeBwE9t0pPnBmC2?=
 =?us-ascii?Q?SJRtPtgphUTMdI0xC3zOoh+w1d7CqMbEIpdV2Mropneln16O2c15BwuVkmgf?=
 =?us-ascii?Q?eJzUe3sgW/zfcP+fJu+1kASWe5CYEefB/cDT80E+SFLqnhw0Dh4pEEISp7cB?=
 =?us-ascii?Q?STCXXwKdFovFLglbBG1vXyzqcJLrast/DLTlDh31rhq01gHaHnaSddiu4Wxp?=
 =?us-ascii?Q?FVjyjLf4KRx2P+73Yd3mibosiotRKzyP4BUrz2ZhABs4u20/TkDALTZzWyAl?=
 =?us-ascii?Q?PzB/xANbjyzKoALnFq1IfWDFLwR3iJjBXk5SpIbE+YXwskXzIeZJ2q1idhvl?=
 =?us-ascii?Q?GUdTGHy4+65h6cdTN8ss+K8mYIEhBbsQvNhLHSnqOO5Aw+A2zRocFbkBCslh?=
 =?us-ascii?Q?xlKm+UWD0+ZifadSbtr+KFng13XSRkekF48pcOaLjHlQiilqd72HIpwP78L/?=
 =?us-ascii?Q?DqYPC0kg7SJ2zZKIXiWbrwiHIr5wiRNUoymZjwx+JxoLbqJepJO9oZvXbkVd?=
 =?us-ascii?Q?6ECFL7aL0RFfWPhm95v6SuwmdHnRv0uOajkk5P4tegUacickL5V9CRZJdCfA?=
 =?us-ascii?Q?k4aH8OR5P7LCPtS2q4nI6eD/vWpkChVJAFrRFlLgunqQ+dj5r8mLpUkWrqxl?=
 =?us-ascii?Q?PP1Oi2TXV331DHotdWKafWBPWnPGnQPSbrBa2YBOq2LPRIovymItDCdQkbw1?=
 =?us-ascii?Q?nk8DtRo044dh9ImQ0LwlbznoRAYwx19KLpSqjuhY6XIPB3IG/TG6ZEeD5PWV?=
 =?us-ascii?Q?+99buDFi6/W2SGWytsaT3XAWAJ/Y2q7Bow2Mr0DHqf6+kFXTUlbCfsdndqMI?=
 =?us-ascii?Q?gcqtSrFvrKyqrU082nmtlFPHWdTUKpTXspnU2PNEcrpiV3QQhWso/ytA55Bj?=
 =?us-ascii?Q?0xix5qVAmggPzDq4JGN1kIt3CaRv6I3BVq4+1/+azvkKHhb9be8lt4zpNWVc?=
 =?us-ascii?Q?7m/ZNg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d818881-ec0f-4afb-40fc-08d9d155d39f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 20:48:00.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5l0roe9C6/1CjZRnF0kXm8XSlWVIMYgS6IFgfq0ww7yjqAOCx0Xy+aIw/AIQjqjRykGf6tiWj5PbpQXVeXzXy13dTv1B8TjHmue8dv+Ytk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2830
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060130
X-Proofpoint-ORIG-GUID: 0MMmaKFVtNouZBknYbqXfSWXIjTXh2Zm
X-Proofpoint-GUID: 0MMmaKFVtNouZBknYbqXfSWXIjTXh2Zm
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:18 -0600, Brijesh Singh wrote:
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
>  arch/x86/boot/compressed/acpi.c | 50 ++++++++-----------------
>  arch/x86/boot/compressed/efi.c  | 65 +++++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h |  9 +++++
>  3 files changed, 90 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index fea72a1504ff..0670c8f8888a 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -20,46 +20,28 @@
>   */
>  struct mem_vector immovable_mem[MAX_NUMNODES*2];
>  
> -/*
> - * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
> - * ACPI_TABLE_GUID are found, take the former, which has more features.
> - */
>  static acpi_physical_address
> -__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
> -		    bool efi_64)
> +__efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len, bool efi_64)
>  {
>  	acpi_physical_address rsdp_addr = 0;
>  
>  #ifdef CONFIG_EFI
> -	int i;
> -
> -	/* Get EFI tables from systab. */
> -	for (i = 0; i < nr_tables; i++) {
> -		acpi_physical_address table;
> -		efi_guid_t guid;
> -
> -		if (efi_64) {
> -			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
> -
> -			guid  = tbl->guid;
> -			table = tbl->table;
> -
> -			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> -				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> -				return 0;
> -			}
> -		} else {
> -			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
> -
> -			guid  = tbl->guid;
> -			table = tbl->table;
> -		}
> +	int ret;
>  
> -		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> -			rsdp_addr = table;
> -		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> -			return table;
> -	}
> +	/*
> +	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
> +	 * ACPI_TABLE_GUID because it has more features.
> +	 */
> +	ret = efi_find_vendor_table(cfg_tbl_pa, cfg_tbl_len, ACPI_20_TABLE_GUID,
> +				    efi_64, (unsigned long *)&rsdp_addr);
> +	if (!ret)
> +		return rsdp_addr;
> +
> +	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
> +	ret = efi_find_vendor_table(cfg_tbl_pa, cfg_tbl_len, ACPI_TABLE_GUID,
> +				    efi_64, (unsigned long *)&rsdp_addr);
> +	if (ret)
> +		debug_putstr("Error getting RSDP address.\n");
>  #endif
>  	return rsdp_addr;
>  }
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 08ad517b0731..c1ddc72ef4d9 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -112,3 +112,68 @@ int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_p
>  
>  	return 0;
>  }
> +
> +/* Get vendor table address/guid from EFI config table at the given index */
> +static int get_vendor_table(void *cfg_tbl, unsigned int idx,
> +			    unsigned long *vendor_tbl_pa,
> +			    efi_guid_t *vendor_tbl_guid,
> +			    bool efi_64)
> +{
> +	if (efi_64) {
> +		efi_config_table_64_t *tbl_entry =
> +			(efi_config_table_64_t *)cfg_tbl + idx;
> +
> +		if (!IS_ENABLED(CONFIG_X86_64) && tbl_entry->table >> 32) {
> +			debug_putstr("Error: EFI config table entry located above 4GB.\n");
> +			return -EINVAL;
> +		}
> +
> +		*vendor_tbl_pa		= tbl_entry->table;
> +		*vendor_tbl_guid	= tbl_entry->guid;
> +
> +	} else {
> +		efi_config_table_32_t *tbl_entry =
> +			(efi_config_table_32_t *)cfg_tbl + idx;
> +
> +		*vendor_tbl_pa		= tbl_entry->table;
> +		*vendor_tbl_guid	= tbl_entry->guid;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * efi_find_vendor_table - Given EFI config table, search it for the physical
> + *                         address of the vendor table associated with GUID.
> + *
> + * @cfg_tbl_pa:        pointer to EFI configuration table
> + * @cfg_tbl_len:       number of entries in EFI configuration table
> + * @guid:              GUID of vendor table
> + * @efi_64:            true if using 64-bit EFI
> + * @vendor_tbl_pa:     location to store physical address of vendor table
> + *
> + * Return: 0 on success. On error, return params are left unchanged.
> + */
> +int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
> +			  efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < cfg_tbl_len; i++) {
> +		unsigned long vendor_tbl_pa_tmp;
> +		efi_guid_t vendor_tbl_guid;
> +		int ret;
> +
> +		if (get_vendor_table((void *)cfg_tbl_pa, i,
> +				     &vendor_tbl_pa_tmp,
> +				     &vendor_tbl_guid, efi_64))
> +			return -EINVAL;
> +
> +		if (!efi_guidcmp(guid, vendor_tbl_guid)) {
> +			*vendor_tbl_pa = vendor_tbl_pa_tmp;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 1c69592e83da..e9fde1482fbe 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -183,6 +183,8 @@ int efi_get_system_table(struct boot_params *boot_params,
>  			 unsigned long *sys_tbl_pa, bool *is_efi_64);
>  int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
>  		       unsigned int *cfg_tbl_len, bool *is_efi_64);
> +int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
> +			  efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa);
>  #else
>  static inline int
>  efi_get_system_table(struct boot_params *boot_params,
> @@ -197,6 +199,13 @@ efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
>  {
>  	return -ENOENT;
>  }
> +
> +static inline int
> +efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
> +		      efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa)
> +{
> +	return -ENOENT;
> +}
>  #endif /* CONFIG_EFI */
>  
>  #endif /* BOOT_COMPRESSED_MISC_H */
> -- 
> 2.25.1
> 
