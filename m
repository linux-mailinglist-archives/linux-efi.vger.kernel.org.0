Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651913FB964
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhH3P4t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:56:49 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:56064
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237311AbhH3P4s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:56:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXgN77sM7ukPsjfb5UzuXZYP3POPp7jh/POG8L9ZoLDM9UQIsSdacS4kvxJflPA84sN2QC933a8mZdCs8kZj3WCnKNZFGjfifEbR3MjBUMm3ErZL8iKRLAWDNzF9vXBILqmnlQ88ydaGwMz7qV/ThpyVHPcGd1ocTbRPeuMvAn3El4HaBis7Zrql8pXVaQe3tmY5gsK/885tiXXHtL29SS04bS/a1ISTfUGAsmVHoZ1i2rQCy+nFPJ7NR26sKS0Fg+mf+3wR/bz5iP52MR8Od/t6IGMSgwvk2wHSR9+4Hqdq15AdivfAVU8+xdBNy8BKsmeQTFOsXUpTcR/QQyvWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW/hqJu0wTnqfMSGiejc791Yo0kfSHmTeZ28jOhYj/g=;
 b=F+Vq15LWZTMVCwxyIH4OWcd8Xfvk0Pot4XYrtE7B6HsdHEAlJGCQjw2MaWXOdqWK/D4XdE9gXxDF6T+/qK4oZdHONXqNXO5xFU9avVByrtN6a0VTYSQbn5rMhYqe1wEsE/KyYUj0ArFAkPvUAW6o4oQhIJndskbzgWTAlxOl0dTGJfDsEIzKczS9vi2w41UIuZk8mA4Utz40IWI2aWNn0j26H9wZaI4CvQYF2ri4EOSox6FVCCpYnr3E6DEsNVK598Hx1thvVdyrRFeQ6/X+DzgJmJr6SSi0aGMruu+OSOSkcWa2OhGoRhPd3rZGbRGmxh0XGiuydDt9WxWCa0uxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW/hqJu0wTnqfMSGiejc791Yo0kfSHmTeZ28jOhYj/g=;
 b=cGce/bNNutJEuvB1U3LkJS0c9ZdY05P4Z3iQ5zPwB/xlveXtsmte6idax20Vdjw6/TDwk6MbjeMrEDCtk+H0dMaxrwvwItS9bQG6aA/DTPOfPXV0K6j4Fzff31NzzIlOqR2SdrWZPmQoua9EWuYr/zWhj0w3GTnXb69ARTbtsk0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 15:55:51 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 15:55:51 +0000
Date:   Fri, 27 Aug 2021 13:32:40 -0500
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
Subject: Re: [PATCH Part1 v5 32/38] x86/sev: enable SEV-SNP-validated CPUID
 in #VC handlers
Message-ID: <20210827183240.f7zvo3ujkeohmlrt@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
 <YSkCWVTd0ZEvphlx@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSkCWVTd0ZEvphlx@zn.tnic>
X-ClientProxiedBy: SA0PR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:806:d1::18) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA0PR11CA0103.namprd11.prod.outlook.com (2603:10b6:806:d1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 15:55:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039f3be5-db48-4c08-4705-08d96bcea45c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4039075E5C8EF67A639B114C95CB9@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucpAIv3U4/qX1+x/mfKmpwL5bb3pakK53LFPGAu5jlBZRrJegv0D0sZAcHATpNi28gXbYfW87Te6Pp8JUD/4K7iyXYJLIxeJSFf+A9g+oiaYwBXpurUZd8Bn5YKbcdkxTeJQbMQlSSxuVEYgTUyJlQQOrganCP69u3pbGPCo7j5YWs6o4rTvYCCsmshwQ4kNfxv5t2LbHQmbe5AkYL60GHkBKPRV2dBMtplpeIlAMgqp1g3Q/z5L7uO6QQYHNsWdi08JIgK5/+Ix4YILPlS0WFeKvhhmYO6ROkc7apn3OlOTtqoIs2UugkvgBl8A5nUJYXc7kVR9ofzpjxoS3Nj6g/jY2J2YLp4mmZ4r/pV9678YlffL3I8JdAtPAEjf6bFRNa4bR6vIIwBQc/b30ENSAQ1DCOFDtS4S2adYHyFfmCdrD3iatyIKc4MsF1dtY6SNJLXjk8QTFKLsKJN/rL0BdJF24z3lFVYw5Qx5W1MoVFLk0z7pTe7hj3Hx47wzR0yn/Mgw8TTh8j9sMrG0FvVk1qzLyLygZqPzRvwYSXgiIxRWMB5TRZLyhcsV/iLYuAx9TqhslOeJzzK6e7CRyUWMBS/cBoe94yaJD/XwUbfd1ibLd60ht4mOHVk1iIG9pOYqM5LjFLSX8Hg2WYiBUY8kZZvZZcIzXOLs6lCz0snjpMWYLjaJBwqv/lhPXPE0nkP11xmHxOBjEPQa+M56EvPopM+HSzER6Us1cm4ItQWOEwDd8xoQly0WzWvjJ9NHcjfXEW2t7+0Ezy7gGd8nmpXhOhB1ZUcerw7jmEQ9+ch147c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38350700002)(2906002)(508600001)(86362001)(38100700002)(1076003)(66556008)(36756003)(186003)(956004)(6916009)(83380400001)(7406005)(7416002)(45080400002)(6666004)(52116002)(4326008)(15650500001)(6486002)(26005)(966005)(6496006)(54906003)(66946007)(316002)(2616005)(8936002)(44832011)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDU8haMAsAxwWuzXEOze5aaEYXWKgnJo8xZfDfVyg459xAHfipvRiX48U9pK?=
 =?us-ascii?Q?L4dlu4O/BhqVLTXA0Dm2Q8KVVJfb059omGye8OxxPD9bqXRhM5jZrWLHl/p8?=
 =?us-ascii?Q?tSwWkjUyUWoU5sTaqkEt8fpVvQnmW7JzCRoewRqq5xvGV+1MFjigKvxzN0t5?=
 =?us-ascii?Q?kxSNYf3STMsYf3bNzd14+vhN/ecleMhGEAoYbYVDxLatWgDla4oIe+kXQsPO?=
 =?us-ascii?Q?t/vwTVkhm0eCs3UY2eyBW5ZobWDm35KOQRRD0+xus5EpH3GmVSFIQnNYG8+m?=
 =?us-ascii?Q?GrolxJwUHxh0kCSPdrNxWhahvsUo82T1OWFHWQBvt8Zc+wTDjzj4y+Anmxzp?=
 =?us-ascii?Q?0WxaR+MYp+IlQEaUh2UGd1jdKK+rQI4ZVyl8FdD8G8y8UAHPkAqmu6S2lPTE?=
 =?us-ascii?Q?VsajGKZRVQlUym9s/50dj8ekdeG+iwBxY5BzKA8d1jyBwd8oyfodzwRPH3qG?=
 =?us-ascii?Q?vtB/de5SYjaRHHqAN8m9ExtL+CgZbWebH9erKV3c48zCAWeF+Mr5mEBJhhUZ?=
 =?us-ascii?Q?kMd4qFxFlknewcE4bpw4vIYNrz198wMx2gkyVvI7mjPbYFFbIeizQd+oDpzl?=
 =?us-ascii?Q?f53KM+2oofQOfFAt+Oq1LuSWLa5AZ/9qBdMDKkBpP302gVGpL5Qjq8B1Newa?=
 =?us-ascii?Q?f0XaWLz89A/TLoxq4EGgskDvaxHhUy7pSV2W4ON/DsasNrmZKaeqSG+E3AvH?=
 =?us-ascii?Q?maFYrKxQ+T5GUKZ6EclSTPEwQi5BCiYhfCl83KMTQKgVPf4NbOLp5Tmc3Avn?=
 =?us-ascii?Q?74efkNlEae546z3oh3xXUh7VsR1UtaHgENrDy3GRPh3DYi3lkdOeX0SeWL5R?=
 =?us-ascii?Q?D48wvkOsZfFkQe8apd+bLtn2flk5J7rNz+GYKJG0q3VtbbcrAgcZ8y9WsYzq?=
 =?us-ascii?Q?zFyASl3gbVftL1r2pfx5Vkt6mM7SDGlET0Nb7WRZMqbg99A16po6ICW/Sj3R?=
 =?us-ascii?Q?fb41fUokb10d2CZ6l0Si/FbqMoK2wrjR2nCNogY+FVUVjgCwLyjOSNPKe8oX?=
 =?us-ascii?Q?ezq1rbxCgw3JizR5QjH/g4txDW29DsmThTjTUQiARgr0yPwIB8pA8r+d/dMR?=
 =?us-ascii?Q?EFNk2YHyBa7oPfc4p2uAkcdGZBNXfSYf6kv/lyhj1cLg+EowNXX5zjFMj82v?=
 =?us-ascii?Q?oyGd15Smbp5sKuBYo2j4ynC1zACiz1eYBrf02qzsixGUUzFRcueKRXP4ajSO?=
 =?us-ascii?Q?oeCEd38ISmNTB05Dkn9Wh1eqRV64EItBQBPULQMtQ73sMZe4qIWo8jiJgwv8?=
 =?us-ascii?Q?UJfGzf2ucbxUuxp5j6FMPKPzZ4QT3WIHOJrFYDr4sNxpyphbPjvyIm70auZv?=
 =?us-ascii?Q?mGrtNExXOxox5i7LhFmcyP/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039f3be5-db48-4c08-4705-08d96bcea45c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:55:51.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO0+/kekY17av6x0Mx6pMDg0/FYoYZAn3NgzxDN8vB3mYAd/DCRcXBXiAayuB3IEe+kYYuVS1qxvCji2i0Wnmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 05:18:49PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:27AM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > This adds support for utilizing the SEV-SNP-validated CPUID table in
> 
> s/This adds support for utilizing/Utilize/
> 
> Yap, it can really be that simple. :)
> 
> > the various #VC handler routines used throughout boot/run-time. Mostly
> > this is handled by re-using the CPUID lookup code introduced earlier
> > for the boot/compressed kernel, but at various stages of boot some work
> > needs to be done to ensure the CPUID table is set up and remains
> > accessible throughout. The following init routines are introduced to
> > handle this:
> 
> Do not talk about what your patch does - that should hopefully be
> visible in the diff itself. Rather, talk about *why* you're doing what
> you're doing.

I'll get this cleaned up.

> 
> > sev_snp_cpuid_init():
> 
> This one is not really introduced - it is already there.
> 
> <snip all the complex rest>
> 
> So this patch is making my head spin. It seems we're dancing a lot of
> dance just to have our CPUID page present at all times. Which begs the
> question: do we need it during the whole lifetime of the guest?
> 
> Regardless, I think this can be simplified by orders of
> magnitude if we allocated statically 4K for that CPUID page in
> arch/x86/boot/compressed/mem_encrypt.S, copied the supplied CPUID page
> from the firmware to it and from now on, work with our own copy.

That makes sense. I was thinking it was safer to work with the FW page
since it would be less susceptible to something like a buffer overflow
modifying the CPUID table, but __ro_after_init seems like it would
provide similar protections. And yes, would definitely be great to avoid
the need for so many [re-]init routines.

> 
> You probably would need to still remap it for kernel proper but it would
> get rid of all that crazy in this patch here.
> 
> Hmmm?

If the memory is allocated in boot/compressed/mem_encrypt.S, wouldn't
kernel proper still need to create a static buffer for its copy? And if
not, wouldn't boot compressed still need a way to pass the PA of this
buffer? That seems like it would need to be done via boot_params. It
seems like it would also need to be marked as reserved as well since
kernel proper could no longer rely on the EFI map to handle it.

I've been testing a similar approach based on your suggestion that seems
to work out pretty well, but there's still some ugliness due to the
fixup_pointer() stuff that's needed early during snp_cpuid_init() in
kernel proper, which results in the need for 2 init routines there. Not
sure if there's a better way to handle it, but it's a lot better than 4
init routines at least, and with this there is no longer any need to
store the address/size of the FW page:

in arch/x86/kernel/sev-shared.c:

/* Firmware-enforced limit on CPUID table entries */
#define SNP_CPUID_COUNT_MAX 64

struct sev_snp_cpuid_info {
        u32 count;
        u32 __reserved1;
        u64 __reserved2;
        struct sev_snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
} __packed;

static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
static const struct snp_cpuid_info *cpuid_info __ro_after_init;
static int sev_snp_cpuid_enabled __ro_after_init;

/*
 * Initial set up of CPUID table when running identity-mapped.
 */
#ifdef __BOOT_COMPRESSED
void sev_snp_cpuid_init(struct boot_params *bp)
#else
void __init sev_snp_cpuid_init(struct boot_params *bp, unsigned long physaddr)
#endif
{
        const struct sev_snp_cpuid_info *cpuid_info_fw;

        cpuid_info_fw = snp_probe_cpuid_info(bp);
        if (!cpuid_info_fw)
                return;

#ifdef __BOOT_COMPRESSED
        cpuid_info2 = &cpuid_info_copy;
#else
        /* Kernel proper calls this while pointer fixups are still needed. */
        cpuid_info2 = (const struct sev_snp_cpuid_info *)
                       ((void *)&cpuid_info_copy - (void *)_text + physaddr);
#endif
        memcpy((struct sev_snp_cpuid_info *)cpuid_info2, cpuid_info_fw,
               sizeof(*cpuid_info2));

        sev_snp_cpuid_enabled = 1;
}

#ifndef __BOOT_COMPRESSED
/*
 * This is called after the switch to virtual kernel addresses. At this
 * point pointer fixups are no longer needed, and the virtual address of
 * the CPUID info buffer has changed, so re-initialize the pointer.
 */
void __init sev_snp_cpuid_init_virtual(void)
{
        /*
         * sev_snp_cpuid_init() already did the initial parsing of bootparams
         * and initial setup. If that didn't enable the feature then don't try
         * to enable it here.
         */
        if (!sev_snp_cpuid_active())
                return;

        /*
         * Either boot_params/EFI advertised the feature even though SNP isn't
         * enabled, or something else went wrong. Bail out.
         */
        if (!sev_feature_enabled(SEV_SNP))
                sev_es_terminate(1, GHCB_TERM_CPUID);

        cpuid_info = &cpuid_info_copy;
}
#endif

Then the rest of the code just accesses cpuid_info directly as it does now.

Would that be a reasonable approach for v6?

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C464de4ea70544dc32ba108d9696de67a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637656743008963071%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=wYK2a%2FuHgw0%2FQJsCVCIpoaJxdT0XASMYUfHvmDcowXg%3D&amp;reserved=0
