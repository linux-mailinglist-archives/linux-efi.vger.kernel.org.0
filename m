Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F94AAA7F
	for <lists+linux-efi@lfdr.de>; Sat,  5 Feb 2022 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380450AbiBERTY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Feb 2022 12:19:24 -0500
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:64001
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380693AbiBERTW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Feb 2022 12:19:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo/WFCWwl6Gs94xYazOQNAeGzUFCtFQPxyL2zSkATEbLPcUbKeIQqJi9amT5jAxG3EXRd8mE3zPoIiDSL4nSfHnIWutqJSMXtwUbT9IlukskS934AHpGWUuq5txruJCqc0pP51bH+uFCOGEh4ib9Dp4pSel2lhTnSbCwkjkwpg6HTL6xuqRYEgns34iHAbDhvM0SaRbyHbpmxbLfRsamNfnITpOPKwahUOKhde13KU6k5sF1Kh2tp5Mpe/4HelCKG5nLPTzucZ5bj/bKlajGy8ddJzhPDnoCL4AGJz4IhZGudK8oZANBaKZgA5U5R7iOJWsnA9zC+4AAch3iRoPjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib8mGBDk3dYClUBx8D99JCa1U5ieeU0rzHhuW7LhTwI=;
 b=VuJjQJW0Q9FTjbEmjvHKCb6E4dLeZEOqhnbJatQhn8RKUkYyhaKp/DGkR8P28sdY0lPWkKKshjCDBBfNdsyi6lvnE21jfMXq+HfuXVfU6d3efpvvrRtwSVdzzAXOAc8NbL27AkTNZFerR2F6eJ6lvGcur6tXqlbw5FPaz9m/nrfVdDfMXYzhANnLa990VM+GGcYegHvpNS5Xon1Dle6AATmsmQFfrwf9ieY6Q2rSnZw09shcx03PO9nXzpukkRTvH65CTOTmvNtrZU5KklgYul6PMI28yPyFXN94skzKaW6BRsnkYPuRpE7sdXESAddOX3Rn3VtxQm9lzOq4DOXz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib8mGBDk3dYClUBx8D99JCa1U5ieeU0rzHhuW7LhTwI=;
 b=xnacabQ3DuzldV4Mbg4aCOU8A0jFomSBuebod2RIQk/zkj7gHg2LZZ49H29YkCcgMMtudpTqyOqWH5f308zQcBxGtu2qWy0xwemvuBzTlyNzVfGv6aJedVf2Ne4rtgsMesKFIp2cydGzdlYpJYjiXXZ7b35EJZCLESMK06cgUbI=
Received: from DM5PR04CA0045.namprd04.prod.outlook.com (2603:10b6:3:12b::31)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sat, 5 Feb
 2022 17:19:18 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::ba) by DM5PR04CA0045.outlook.office365.com
 (2603:10b6:3:12b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 17:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 17:19:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 5 Feb
 2022 11:19:16 -0600
Date:   Sat, 5 Feb 2022 11:19:01 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        <brijesh.singh@amd.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 38/43] x86/sev: Use firmware-validated CPUID for
 SEV-SNP guests
Message-ID: <20220205171901.kt47bahdmh64b45x@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-39-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-39-brijesh.singh@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819445bb-bdde-42e7-9d12-08d9e8cba44a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4587:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4587647E42DC0C951D4ECCC7952A9@MW3PR12MB4587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVvr5j0xt5ACu/CJ6rAubNRxXiT96+bVlLDz7XRRVcfAZthulcZV1cQvBxxQdex63fXnaGAgSt18Ig+hFBGWBASBXH3ePXiVIUmf5qxo+fj0oTPZBdU+ciImgKEvnjHIsjQD6uK5VRVzjiORAIMvtoPjgyR+LT0ext5EtFna+D+b8sWrwHxnUnjsJ5PAo3vqeHX2vD2PnWJ0pAJsBJBY9OjJJgbRPNoKcge4dJMIWw1xrig1b1xI2ETJ0Ler5pVNUtbpFv/f/6u06Z6q76HBww8idRleIyGbfyRwSs8bRR6iSw3JCkYi/Pc+FHi6BTSeOAGjKOiiP7bDKRNWK7bi5Fw/GdZ5H4saQvuakM5t4QfQPAFD46owuiY7now5M3uWQpZT1IL1hq7a0ST1b9XknBgWkvAo0kW/uzfBqilxPji60Vw3BiLPZ0VrHG7iTKLlT4euhdwryYncp9g6aZHM8y6abAPENps6bqu98vxNqQiub412gg3mrdQVOvQwvAtGA2gWs8TZ7cJ5QiOrJT3nib6vKTbLEEYcDbrsEYA2/X0A9EOBeivo0n7dYHR006BSNwLsFAAMlAy3oPXG53Nwo1riYzRM8EQtdVT9odHKYr1TCejjpHFhZjd9IBmlQBqpGBSTFUqJltZIAlqkx9d9a9fWCGC76NgI4IOwCG/xJgyKf8+CPwrKpAKGttowixGqvmGco8VAABGWw5bCdaHR0pvLkJb/viUQXCZatSrHgzWKILUSkkv7fFAOIiz+JF3dHzWJcT/1f4+OpR8oKj5DKfnja3krm8I+m6dG4SHIacMjKGWeJI/2cuU04e7s1inl6jIi4epjfeRqfGonuqiywA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(316002)(966005)(6916009)(54906003)(36756003)(2906002)(8676002)(4326008)(15650500001)(5660300002)(7406005)(7416002)(6666004)(70206006)(70586007)(44832011)(8936002)(47076005)(83380400001)(1076003)(2616005)(336012)(356005)(426003)(36860700001)(40460700003)(81166007)(26005)(186003)(86362001)(16526019)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 17:19:18.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819445bb-bdde-42e7-9d12-08d9e8cba44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:59AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> SEV-SNP guests will be provided the location of special 'secrets' and
> 'CPUID' pages via the Confidential Computing blob. This blob is
> provided to the run-time kernel either through a bootparams field that
> was initialized by the boot/compressed kernel, or via a setup_data
> structure as defined by the Linux Boot Protocol.
> 
> Locate the Confidential Computing blob from these sources and, if found,
> use the provided CPUID page/table address to create a copy that the
> run-time kernel will use when servicing CPUID instructions via a #VC
> handler.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c | 37 -----------------
>  arch/x86/kernel/sev-shared.c   | 37 +++++++++++++++++
>  arch/x86/kernel/sev.c          | 75 ++++++++++++++++++++++++++++++++++
>  3 files changed, 112 insertions(+), 37 deletions(-)
> 
<snip>
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 5c72b21c7e7b..cb97200bfda7 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2034,6 +2034,8 @@ bool __init snp_init(struct boot_params *bp)
>  	if (!cc_info)
>  		return false;
>  
> +	snp_setup_cpuid_table(cc_info);
> +
>  	/*
>  	 * The CC blob will be used later to access the secrets page. Cache
>  	 * it here like the boot kernel does.
> @@ -2047,3 +2049,76 @@ void __init snp_abort(void)
>  {
>  	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>  }
> +
> +static void snp_dump_cpuid_table(void)
> +{
> +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> +	int i = 0;
> +
> +	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
> +		cpuid_info->count, cpuid_info->__reserved1, cpuid_info->__reserved2);
> +
> +	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
> +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +
> +		pr_info("index=%03d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
> +			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
> +			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
> +	}
> +}
> +
> +/*
> + * It is useful from an auditing/testing perspective to provide an easy way
> + * for the guest owner to know that the CPUID table has been initialized as
> + * expected, but that initialization happens too early in boot to print any
> + * sort of indicator, and there's not really any other good place to do it.
> + * So do it here. This is also a good place to flag unexpected usage of the
> + * CPUID table that does not violate the SNP specification, but may still
> + * be worth noting to the user.
> + */
> +static int __init snp_check_cpuid_table(void)
> +{
> +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> +	bool dump_table = false;
> +	int i;
> +
> +	if (!cpuid_info->count)
> +		return 0;
> +
> +	pr_info("Using SEV-SNP CPUID table, %d entries present.\n",
> +		cpuid_info->count);
> +
> +	if (cpuid_info->__reserved1 || cpuid_info->__reserved2) {
> +		pr_warn("Unexpected use of reserved fields in CPUID table header.\n");
> +		dump_table = true;
> +	}
> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +		struct snp_cpuid_fn zero_fn = {0};
> +
> +		/*
> +		 * Though allowed, an all-zero entry is not a valid leaf for linux
> +		 * guests, and likely the result of an incorrect entry count.
> +		 */
> +		if (!memcmp(fn, &zero_fn, sizeof(struct snp_cpuid_fn))) {
> +			pr_warn("CPUID table contains all-zero entry at index=%d\n", i);
> +			dump_table = true;
> +		}
> +
> +		if (fn->__reserved) {
> +			pr_warn("Unexpected use of reserved fields in CPUID table entry at index=%d\n",
> +				i);
> +			dump_table = true;
> +		}
> +	}
> +
> +	if (dump_table) {
> +		pr_warn("Dumping CPUID table:\n");
> +		snp_dump_cpuid_table();
> +	}
> +
> +	return 0;
> +}
> +
> +arch_initcall(snp_check_cpuid_table);

Just a quick note on this one. I know you'd recently suggested dropping
this check since it was redundant:

  https://lore.kernel.org/all/YfGUWLmg82G+l4jU@zn.tnic/

I've dropped the redundant checks from in this version, but with the
additional sanity checks you suggested adding, this function remained
relevant for v9 so we can provide user-readable warnings for "weird"
stuff in the table that doesn't necessarily violate the spec, but also
doesn't seem to make much sense:

  https://lore.kernel.org/all/YefzQuqrV8kdLr9z@zn.tnic/

But I also agree with your later response here, where sanity-checking
doesn't gain us much since ultimately what really matter is the
resulting values we provide in response to CPUID instructions, which
would be ultimately what gets used for guest owner's attestation flow:

  https://lore.kernel.org/all/YfR1GNb%2FyzKu4n5+@zn.tnic/

So I agree we should drop the sanity-check in this function since
there's no cases covered here that would actually effect the end
result of those CPUID instructions, nor do any of the checks here
violate the SNP spec...

...except possibly the checks that enforce that the Reserved fields
here are all 0, which we discussed here:

  https://lore.kernel.org/all/YeGhKll2fTcTr2wS@zn.tnic/

I followed up with our firmware team on this to confirm whether our
intended handling and the potential backward-compatibility issues
aligned with the intent of the SNP FW spec, and the guidance I got
on that is that those Reserved/MBZ constraints are meant to apply
to what a hypervisor places in the initial CPUID table input to
SNP_LAUNCH_UPDATE (or what the guest places in the MSG_CPUID_REQ
structure in the guest message version). They are not meant to
cover what the guest should expect to read for these Reserved fields
in the resulting CPUID table: the guest is supposed to ignore them
completely and not enforce any value.

I mentioned the concern you raised about out-of-spec hypervisors
using non-zero for Reserved fields, and potentially breaking future
guests that attempt to make use of them if they ever get re-purposed
for some other functionality, but their take on that is that such a
hypervisor is clearly out-of-spec, and would not be supported. Their
preference would be to update the spec for clarity on this if we
have any better suggested wording, rather than implementing anything
on the guest side that might effect backward-compatibility in the
future. Another possibility is enforcing 0 in the firmware itself.

So given their guidance on the Reserved fields, and your guidance
on not doing the other sanity-checks, my current plan to to drop
snp_check_cpuid_table() completely for v10, but if you have other
thoughts on that just let me know.

Thanks!

-Mike


> -- 
> 2.25.1
> 
