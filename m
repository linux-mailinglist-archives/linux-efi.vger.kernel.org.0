Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F333F7B5A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhHYRQG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 13:16:06 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:37473
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233392AbhHYRQD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 13:16:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnzTKJzmZYZnrfVyW1ddGtr0ZAXSFKrlvhwtsaApbL9y/zW/lZjzgvAh7dg/SZcWBJOqpQEYXdsLBPq8s3fYclY1pllRbeGCS6fMKD7RqdA8dIScjq0xp7Dkzes2nyT4uNQEZ3pkx+fvOBlhYBpBfwgE/k2nvzeCZDc4b1lMfFmruj4Nf/qUjB8jMDKhAw3xi2l1eijdJbOs+X3alTwmaUEKFeTuXlENjL8nZO4USUYy+Xar4C/FQ5BNd5UO/6EpVyU0JAp1YDAGQrG0ghoIsyNL+0ahjpvczayD6shzpKWP0tvVkGsWjkT9xwxnSPuFo4IGH1908wVH/k8X4zI6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3CZDxORU7oV/ZHy73jmtUQj0Aj1QmYt/d9cd+dLzhs=;
 b=nrFPcJvttkvMNuFeZCPjkyT7EXrkEoAfCmhKYTsbNvDZKsSED402bXNY2La+7FntItxCFWCprkObnUpkRGdxqioLZxM1yppGqxRF3Jr8Ye+Zme7oyJEaeKhxs+WJMI/lMzCiSnraMCaeA5dhSVib5ePazusR+cv4Fek9q6rrciQzm7UEeklfLqDZqbHsnYCiQccjw59xYCSNV4PikCsbgt3GoJa17Ltt7Ur1qiVdJ9d76gVXasqHWv/P51aQ4dccY+YcgkekcXBP301fMuYBaLbil9++QypWVSWXxnrUHyw5/dLJZgXe/5kZBMp9k8tQIXaPstvLbBiOmyXXKnupbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3CZDxORU7oV/ZHy73jmtUQj0Aj1QmYt/d9cd+dLzhs=;
 b=2fD9/5MkO5krZY2qQMjflZAc0rSg0AYQ8w9z6pQptecX4i1dYXb5yIBAKZrqOjiyt5F2w/PM5JdlsqbtBgfRKPGGlnmYt6p9qOHGX88nRqswobqsFIsNTRbD0thNq7valjOIumICYZBM7vVU+LckYm9/6EX/rz8vaXtyAhgWGco=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 17:15:14 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Wed, 25 Aug 2021
 17:15:14 +0000
Date:   Wed, 25 Aug 2021 12:14:48 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 26/38] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <20210825171448.zaakoue7ilbmsrau@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-27-brijesh.singh@amd.com>
 <YSZfPFrzXv0dImsv@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZfPFrzXv0dImsv@zn.tnic>
X-ClientProxiedBy: SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN4PR0501CA0126.namprd05.prod.outlook.com (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend Transport; Wed, 25 Aug 2021 17:15:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d87d218-b8fb-479a-9847-08d967ebe6bb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4006B04DF20794E90517422B95C69@CH2PR12MB4006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV49ItrRU1vZGm3h1/v/+5W7Pyg9DQCbYYSjdfgfIN7RBq2+7UQ/aBiHNWW/PXgfXtBgOghnlLLwUh1hglWLOyrk7t2ohS9xGhSzaZRZknruJTvjbxo+4ysRyJ22BsYmMKhb0x9zdouhtluQjv3AVDyjOTVgYfvOBTnpq7Vq/aNtXDrradoNmo8D78WVJfMeTU09NSBTIhBlRXb7+uk+Y+/LL2rlKj2HsSiXio6SxiH5t5HVnwSiROd6IqaEzLGT9ftAYR8zjO1YXH0CHyC92BhPiT1iJhzwlm9Sc78sHRtNDKE8mxYY1NjSYGkkxVXlp6xfx4RxLMqoSkvDgcfynaE18l0lEbGUrv5hPof/Upwdzh9DjSrNX25hplT6Vh0qvVtAfihk+IFQZwjw6oWyQp0PkwPSAxhVLTmDAt1ry8LVUU3HDwCoMQk/DPeGmrtIUyD9OA59Xi2gUL/4RKFWfGgkUazsJhY6X4AzM/VE0x55KtLQY9gsBkWrT++OpeAawydLsuxMV4OKg9XZDq8IaekSI0zHni6ykzoi/fZbBo05WXazSSCrELA7leYP0IRLm4LO1F2sOkpTVH4wMHiefTUs80bI74Cqj9ARoBgiXIJ9bCn8VuD8gDQS7W19HdfJhlTfQ7JjOwWZphYx9SkhZ6w9H2CszbPO2sZzzFIZoIwpWUTPG1hNQoav50zhJcCg6LKvkP13ScACedy8acmXvMRRa3N0naRRLVhccqCaPYeGcj6FoBhD5NRLNGBcebMZqgYk5/7xFefrFbOdeSx4Pj72zF/wunlYyirpzdcoWPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(8676002)(956004)(4326008)(38350700002)(36756003)(44832011)(6916009)(2616005)(38100700002)(86362001)(83380400001)(478600001)(966005)(45080400002)(186003)(26005)(8936002)(52116002)(6666004)(66556008)(66476007)(1076003)(316002)(5660300002)(7416002)(6496006)(54906003)(6486002)(66946007)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZT38xm3cKitOjVYjbzIFYe3vVMAczoyUW6DAFz2UvgsT6gLTJwFJxF5Fllq?=
 =?us-ascii?Q?QpRLKRjf4zLji95STvG9gI6hdDw3Q1Q9D2aG8fPnkDlo526BA7fgYwAd7Y2D?=
 =?us-ascii?Q?UKHilGVHcN08G5Vz8vOQMR6efsIdtcocWINuJ0cZGDEx8IFDKb9PT7hxJaoi?=
 =?us-ascii?Q?71wXM59sT2A1pzN12Nf4as4lhRgML+D89IhDPuTKHXF/HIWRtxIiws2CwQxe?=
 =?us-ascii?Q?tGCGxrX6eh+pAHm3c2sJGqtWmUJRxqjV7bb8JrpdODC+pubeFQMxb6aC0d6O?=
 =?us-ascii?Q?tta3pX1glXIiaLNuCrtfl7jxbk5UL3/M6a5V9CGjAg4bSl7ls6Vp/OYNprn1?=
 =?us-ascii?Q?/SeGvxfBUDTs2eG9XyoYKK4KfiGTixldQvKnQCkkGXRhQbCUNLM0JIbCuDCM?=
 =?us-ascii?Q?KH8TZeAwKTCV52qPoebc5pEciOwTVfzcDLAhMbcuSXpWq5/UGbhrb6PwMPoK?=
 =?us-ascii?Q?V2FgVIL+L0nWYusBCWuwn9WVL+kSs7DfVP1NekolChLxIxEcUnTmA8PdzbXv?=
 =?us-ascii?Q?p5nhZ1l/9eumyG3e+/e1v55x9sG2YTdrUB5kKmz6o4qngbXsJyGLWyY1y0uK?=
 =?us-ascii?Q?r+EoB0jrkXyf3fbna0/0H/v+Iiu9X2WR3Y41mMav/zogi3a3aLtOsWtRzzze?=
 =?us-ascii?Q?m5clcrpmQLtEWJEl2MBOKKf2Ku9SROVo5D7qDy/2emGumCYVuOSRPCQEY3nA?=
 =?us-ascii?Q?qJ9HnrTnUOUEOkOUZPB8pzMtoZsceJg7JGJRnGvFcqsNeJKK+PlHcYvLnyap?=
 =?us-ascii?Q?8a5QXQuoqWaqGVuSV+wS6RDaphX4N9xzV3XiP9fXd4rE1KZOityWIdPuF9sC?=
 =?us-ascii?Q?vaYBE6sVlLM8LpNqFvbTxvMDoz3FC6/9VB84VeTxWkmpvpx7wQdEMTWeB3MI?=
 =?us-ascii?Q?tD9Fb3xlH5gWmlqbF7jUDGKbz2lZYxFdw9VpGVmxu+I5C6VfHb0O4/wn60WS?=
 =?us-ascii?Q?zKN7EpgcwC1esWn89r9YmtUq1aDr7Mjxn8R7Ui9NJyfTG6ey8a8y/zJQSea9?=
 =?us-ascii?Q?mhVUhOHIRu+RWhamYFlJv2NUbz34dYpXwWNgQChoL7ZAasTntQDYadB2eFMJ?=
 =?us-ascii?Q?DJaeM/TQOoPchltAQ1HuZiLu6sEtLmZbaZnEAqLF9Zhs8ZEEQnXV/rnTEPSr?=
 =?us-ascii?Q?E0tZmGUxA0l2amQQXwnEB6PRz8P5vvLLd/tBncO75NSW1WAFrN8oV1svnIEz?=
 =?us-ascii?Q?/2Sb/4m7A07fID95O2Jq9dPZ85ZFZXI1h2/gGwLhiQaE+j5WqUJXCSNzRT3l?=
 =?us-ascii?Q?ogugF6+X75mranSVJAVGxODXZaJ92skL3zb6sCgbm0ezICjo7Bv5DwqAZs8y?=
 =?us-ascii?Q?dh1WFJQmqz8jIqK4ed+ZC9jV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d87d218-b8fb-479a-9847-08d967ebe6bb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:15:13.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apfuaYi8jrc1gFy1i0aW1MOCfXXAw/7t9abMrAKLUAOKuNYg7ErthqMzUkPV76cYyO+YDCX6n+q+hu6Eg3R0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 05:18:20PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:21AM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > Future patches for SEV-SNP-validated CPUID will also require early
> > parsing of the EFI configuration. Move the related code into a set of
> > helpers that can be re-used for that purpose.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/boot/compressed/Makefile |   1 +
> >  arch/x86/boot/compressed/acpi.c   | 113 +++++--------------
> >  arch/x86/boot/compressed/efi.c    | 178 ++++++++++++++++++++++++++++++
> >  arch/x86/boot/compressed/misc.h   |  43 ++++++++
> >  4 files changed, 251 insertions(+), 84 deletions(-)
> >  create mode 100644 arch/x86/boot/compressed/efi.c
> 
> Ok, better, but this patch needs splitting. And I have a good idea how:
> in at least three patches:
> 
> 1. Add efi_get_system_table() and use it
> 2. Add efi_get_conf_table() and use it
> 3. Add efi_find_vendor_table() and use it
> 
> This will facilitate review immensely.

Ok, that makes sense.

> 
> Also, here's a diff ontop of what to do also, style-wise.
> 
> - change how you look for the preferred vendor table along with commenting what you do
> - shorten variable names so that you don't have so many line breaks.

Thanks for the suggestions, I'll incorporate those changes in the next spin as
well.

> 
> Thx.
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 3a3f997d7210..c22b21e94a95 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -20,27 +20,29 @@
>   */
>  struct mem_vector immovable_mem[MAX_NUMNODES*2];
>  
> -/*
> - * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
> - * ACPI_TABLE_GUID are found, take the former, which has more features.
> - */
>  static acpi_physical_address
> -__efi_get_rsdp_addr(unsigned long config_table_pa,
> -		    unsigned int config_table_len, bool efi_64)
> +__efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len, bool efi_64)
>  {
>  	acpi_physical_address rsdp_addr = 0;
> +
>  #ifdef CONFIG_EFI
>  	int ret;
>  
> -	ret = efi_find_vendor_table(config_table_pa, config_table_len,
> -				    ACPI_20_TABLE_GUID, efi_64,
> -				    (unsigned long *)&rsdp_addr);
> -	if (ret == -ENOENT)
> -		ret = efi_find_vendor_table(config_table_pa, config_table_len,
> -					    ACPI_TABLE_GUID, efi_64,
> -					    (unsigned long *)&rsdp_addr);
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
>  	if (ret)
>  		debug_putstr("Error getting RSDP address.\n");
> +
>  #endif
>  	return rsdp_addr;
>  }
> @@ -100,18 +102,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
>  static acpi_physical_address efi_get_rsdp_addr(void)
>  {
>  #ifdef CONFIG_EFI
> -	unsigned long config_table_pa = 0;
> -	unsigned int config_table_len;
> +	unsigned long cfg_tbl_pa = 0;
> +	unsigned int cfg_tbl_len;
>  	bool efi_64;
>  	int ret;
>  
> -	ret = efi_get_conf_table(boot_params, &config_table_pa,
> -				 &config_table_len, &efi_64);
> -	if (ret || !config_table_pa)
> +	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len, &efi_64);
> +	if (ret || !cfg_tbl_pa)
>  		error("EFI config table not found.");
>  
> -	return __efi_get_rsdp_addr(config_table_pa, config_table_len,
> -				   efi_64);
> +	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
>  #else
>  	return 0;
>  #endif
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 16ff5cb9a1fb..7ed31b943c04 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -12,14 +12,14 @@
>  #include <asm/efi.h>
>  
>  /* Get vendor table address/guid from EFI config table at the given index */
> -static int get_vendor_table(void *conf_table, unsigned int idx,
> +static int get_vendor_table(void *cfg_tbl, unsigned int idx,
>  			    unsigned long *vendor_table_pa,
>  			    efi_guid_t *vendor_table_guid,
>  			    bool efi_64)
>  {
>  	if (efi_64) {
>  		efi_config_table_64_t *table_entry =
> -			(efi_config_table_64_t *)conf_table + idx;
> +			(efi_config_table_64_t *)cfg_tbl + idx;
>  
>  		if (!IS_ENABLED(CONFIG_X86_64) &&
>  		    table_entry->table >> 32) {
> @@ -32,7 +32,7 @@ static int get_vendor_table(void *conf_table, unsigned int idx,
>  
>  	} else {
>  		efi_config_table_32_t *table_entry =
> -			(efi_config_table_32_t *)conf_table + idx;
> +			(efi_config_table_32_t *)cfg_tbl + idx;
>  
>  		*vendor_table_pa = table_entry->table;
>  		*vendor_table_guid = table_entry->guid;
> @@ -45,27 +45,25 @@ static int get_vendor_table(void *conf_table, unsigned int idx,
>   * Given EFI config table, search it for the physical address of the vendor
>   * table associated with GUID.
>   *
> - * @conf_table:        pointer to EFI configuration table
> - * @conf_table_len:    number of entries in EFI configuration table
> + * @cfg_tbl:        pointer to EFI configuration table
> + * @cfg_tbl_len:    number of entries in EFI configuration table
>   * @guid:              GUID of vendor table
>   * @efi_64:            true if using 64-bit EFI
>   * @vendor_table_pa:   location to store physical address of vendor table
>   *
>   * Returns 0 on success. On error, return params are left unchanged.
>   */
> -int
> -efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
> -		      efi_guid_t guid, bool efi_64,
> -		      unsigned long *vendor_table_pa)
> +int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
> +			  efi_guid_t guid, bool efi_64, unsigned long *vendor_table_pa)
>  {
>  	unsigned int i;
>  
> -	for (i = 0; i < conf_table_len; i++) {
> +	for (i = 0; i < cfg_tbl_len; i++) {
>  		unsigned long vendor_table_pa_tmp;
>  		efi_guid_t vendor_table_guid;
>  		int ret;
>  
> -		if (get_vendor_table((void *)conf_table_pa, i,
> +		if (get_vendor_table((void *)cfg_tbl_pa, i,
>  				     &vendor_table_pa_tmp,
>  				     &vendor_table_guid, efi_64))
>  			return -EINVAL;
> @@ -88,9 +86,8 @@ efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
>   *
>   * Returns 0 on success. On error, return params are left unchanged.
>   */
> -int
> -efi_get_system_table(struct boot_params *boot_params,
> -		     unsigned long *sys_table_pa, bool *is_efi_64)
> +int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_table_pa,
> +			 bool *is_efi_64)
>  {
>  	unsigned long sys_table;
>  	struct efi_info *ei;
> @@ -137,22 +134,19 @@ efi_get_system_table(struct boot_params *boot_params,
>   * address EFI configuration table.
>   *
>   * @boot_params:        pointer to boot_params
> - * @conf_table_pa:      location to store physical address of config table
> - * @conf_table_len:     location to store number of config table entries
> + * @cfg_tbl_pa:      location to store physical address of config table
> + * @cfg_tbl_len:     location to store number of config table entries
>   * @is_efi_64:          location to store whether using 64-bit EFI or not
>   *
>   * Returns 0 on success. On error, return params are left unchanged.
>   */
> -int
> -efi_get_conf_table(struct boot_params *boot_params,
> -		   unsigned long *conf_table_pa,
> -		   unsigned int *conf_table_len,
> -		   bool *is_efi_64)
> +int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
> +		       unsigned int *cfg_tbl_len, bool *is_efi_64)
>  {
>  	unsigned long sys_table_pa = 0;
>  	int ret;
>  
> -	if (!conf_table_pa || !conf_table_len || !is_efi_64)
> +	if (!cfg_tbl_pa || !cfg_tbl_len || !is_efi_64)
>  		return -EINVAL;
>  
>  	ret = efi_get_system_table(boot_params, &sys_table_pa, is_efi_64);
> @@ -164,14 +158,14 @@ efi_get_conf_table(struct boot_params *boot_params,
>  		efi_system_table_64_t *stbl =
>  			(efi_system_table_64_t *)sys_table_pa;
>  
> -		*conf_table_pa	= stbl->tables;
> -		*conf_table_len	= stbl->nr_tables;
> +		*cfg_tbl_pa	= stbl->tables;
> +		*cfg_tbl_len	= stbl->nr_tables;
>  	} else {
>  		efi_system_table_32_t *stbl =
>  			(efi_system_table_32_t *)sys_table_pa;
>  
> -		*conf_table_pa	= stbl->tables;
> -		*conf_table_len	= stbl->nr_tables;
> +		*cfg_tbl_pa	= stbl->tables;
> +		*cfg_tbl_len	= stbl->nr_tables;
>  	}
>  
>  	return 0;
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7Cb4091a3e85cd463b1cb608d967db81ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637655014764920013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rvxyc%2FAURXMBWX5lkUHQoM1a%2FlGt4ZtcfGCJZ1TjIQU%3D&amp;reserved=0
