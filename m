Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9343FB9AF
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 18:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhH3QEe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 12:04:34 -0400
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:29280
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237779AbhH3QEe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 12:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyohNUP4Bj+b805NN/gAPLZRqHCNbq7alVgayB84qQAqVa8uV7mZD6K6Xo2kyZTr7L6l5RP7xPZDkvcEL2lTleMbi8hx3eia0Z4Z96lcDiORjNUmQtvrOqph+Fk4c64gKKpuU3NkzO2XR6WFTr+vDOJDqd6+ZBHWxQBhubMwKTie9cVJTZeq9JlZASd0b0xRIvNh/mc3LDim0LgslwDiMZAr3haV93PhSTdjYkOqYnFepKdGAtwTiPpnc8rJ/4qR/xG+9xOB8JTc9o07o2VsHWB7ZtFAFq0haExncw/wdll6MojpxxVYuUd1v0ZRtKwwqCABEUFIF8wFmx6cxaM0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpOVXtGGfwr8UUxkYGAH23IJ5ZS+YV8lvpZLg0Vl74Y=;
 b=cgZzOB7Ci5CCsrI3oYco8/wylBpKQpOfIycx883YUDXKti+HG4k5TCh6Awc68RfbcG6QKjDxxME8IODmLQHnIfRk4pPBiVH1wjNeNl/2fcvej4XlId9peR9ZlWPfWp+kO/S7uIjiZ5b4gqaIrFDYgE5P5xyGgLZSK9EhVUErS8Lo8hxEzuZPc7j8HjzzQWOlKSOIVCUECodS0RbzZFk6yntk+haLbgRAuhdmbHSwPH0mfD/7viDorMLrpA0jNPCi7jRL560YrpgPd6UhOyoyO1ylQlv4JhW/piOsipqp8VsZ3eSmehSbeEu3w/8q+ZDRm3khvtBIFhT2imxnpiutLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpOVXtGGfwr8UUxkYGAH23IJ5ZS+YV8lvpZLg0Vl74Y=;
 b=SZGCcvqhPWmFHB8wYWD2M4aR06s0yXRcdevBuq0D94Jlc6vV9aXNcIpD19Zr8oHU4zJItjF5CrSdKrGbjA13ZKCnS0QPgQ7hjLSa66iYo7IqULdJQnjqbavTDKvEXT+aM+IekId7Q046SHpN7evX+p/b9BImZ/dH8w71V5LfFZ0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 16:03:36 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 16:03:36 +0000
Date:   Mon, 30 Aug 2021 11:03:21 -0500
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
Message-ID: <20210830160321.iczlsyudnhbratwo@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
 <YSkCWVTd0ZEvphlx@zn.tnic>
 <20210827183240.f7zvo3ujkeohmlrt@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827183240.f7zvo3ujkeohmlrt@amd.com>
X-ClientProxiedBy: SA9PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:806:a7::9) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 16:03:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 581d7582-4846-4dd6-c56e-08d96bcfb994
X-MS-TrafficTypeDiagnostic: CH2PR12MB4056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4056C34759D96378DEB24F6595CB9@CH2PR12MB4056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJgOqtvSLRAJrJcrIGggMoMNGSyJnqj0k+ZEj/QVHUHhYTWNvitJqJbuwEshi2LxkB6B464ddQ6BedVxdEtxxhB55NlXUPFWLkNGMSUvcnIWM2t/fY7Ct4epwHje7oFmSnSuBtAGhp6XY5PLVqr3MxsKHG1xaQgPSOMu3MeOxvcjQ0O+U+4GTFWldU3KDTwBDX/XD5y1bw6SaTaFQtd9EBNh7AZ7dfOg7lHQxPAnzafIaTlQ6LDZG+gk6tS3eNwCjsTzQSM1dbePu9Arj0ydQBc9C34KNqsCCf7xSQYPkDOo+6RO9FRn/ngDeFKpAUWftL3UBSbrRCPTZa2FBFVUpND993ytUF9oPfQ7PgEUJbF1V/yIpUgqZ6fprs/V5TFjehd1m5k2HOzOoca4piEVbWYo2AExmVmbnHD4XlK5NXdz9K1juSTRdW0UNNeoHPEJKy4wkuePH80F9byIVIDHnPOnXwk3XuIxjVOYvP0ZTYygZPFvNHKG0Gdo9rtjGpSTYXJ+f0DxvFxFIejVkxxC+l0/7T/hxr9bVH59Uk7mUsz2ecryPgLCLmoYz7XiXotEgiU9nuFRl8R6I+qIoMlttgnLJyVgFVaUVnelxFrNQl85lmRXEAptend+qu6nwH4mjy4e8Mhh0EUKjMjJfKkIiduxWCjP2tjHprwfy4RVl7G+8A7ZIP+vV+O8lrpAH/ZA7dC0gduiOcWTXGryQeMxaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(7406005)(7416002)(2906002)(6666004)(6496006)(26005)(478600001)(956004)(15650500001)(5660300002)(66946007)(8936002)(52116002)(186003)(38350700002)(38100700002)(1076003)(316002)(66556008)(86362001)(2616005)(6916009)(44832011)(4326008)(3716004)(36756003)(83380400001)(54906003)(6486002)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TyovW8dWuD/qdpNTvOGr8stBEcxUg23jeVw+tGp5g2bulfmWDsq8GuXwtvT6?=
 =?us-ascii?Q?oA6G1iM1RtjBopi8vBCz1WZYF7g0F+gu6TRzp15fxXEhSgi7I8FpUvfsg1rU?=
 =?us-ascii?Q?rojAsWJbDG9fB5VClUF6nnS3fRtaysiKs9PpAbAIq6nTYoQTCwb6V+T68mm7?=
 =?us-ascii?Q?c7uGrysI6ykQqXn50nhVHR3cLTc1RXFnjZ1W+nnPRe0cyAbnYqffyuQ45e08?=
 =?us-ascii?Q?vCJ6gbrCge5VZHTjPftqljin8U5Cycspmh8wikWDANNXhLZo3ggBi/f3gjP1?=
 =?us-ascii?Q?IyNSt1TxUP+Yom8gy4F4E24EKOlfiqtA03yTlvlrAgiZ2waj4RATuIPQzlH3?=
 =?us-ascii?Q?JLk3MHO2/0E6qm5GcGg0oJUbCZiaFZ+GHK0iCYTcx6XS9vwZqjocsSIG+qwW?=
 =?us-ascii?Q?srNVnxOeAqZ3th6Nj3YPcABXkKc8hYyDt8z65tEwGlzpikzTergMswLOOSLo?=
 =?us-ascii?Q?Zma5fdpPi2In9uwWHVWtl8Z6MZ02FXCQsg1676Mk5h5dKcRY95j2xJbwpFcH?=
 =?us-ascii?Q?mEkGkPru1liVRD3CI2C19hbKZp7Ox1apWn+QjfhCXGuWC9lzhIzWm6Un69v+?=
 =?us-ascii?Q?ceJ8i/E1eG/mcyiUx4hy3FIXn6JwHRg4mCvueHVvSjbuxDcoEuP+yvSkpz5z?=
 =?us-ascii?Q?aBC0FvJxNB9cwyNW2/vG2e0FgEbGX/O+vX4GoMuPVGTWHO/Alp2lFMmZe+YU?=
 =?us-ascii?Q?BcewwzgQbte6ZyBzj91CQWt/W4D3hSBibvLoNJ8iAqpWpYDFzjot182Rxykn?=
 =?us-ascii?Q?OKpPspGLteOlI4sFn6H9/K9Tdn2byuI1sAvkmpI6TcbcNsjKPC9KxXjbO6Mp?=
 =?us-ascii?Q?jLT19OnBymwfeMnyhAyqjPgztecHiN1GHCBPvODiDcAg7bSZ1Rg+1OxaOoLJ?=
 =?us-ascii?Q?96n5KQgpHG78ctG0Xffuocd2M6mMblmdRkACpXoZNHQjTjOQ+c2SWOXrAVR+?=
 =?us-ascii?Q?RCvLVL59fXUH9sc3zvR9pm/DIsdJAHIORTLioz4dePPfdwt8xJcf4OLLSDK/?=
 =?us-ascii?Q?5J9W1ih3oX3yC52kCqmTpv8xIT3c3aVth+p5nuVK02NqvBVgcGED0pl/q44Q?=
 =?us-ascii?Q?6fYQHVGZYqJPGqh+y8Y/rC2YjAP1dRz4tzAnJNZbpvmmKKy/zgmmXDxxU1B+?=
 =?us-ascii?Q?spWJ/Duq+ggRYj/PxPDxDTgQqe1nLipCVdQRWiEtwZkYbXqKhL5numB54MD2?=
 =?us-ascii?Q?ECA/3BR/o4+OVTU9acvT3lI1luGkPfB/HAFoy7wBt28oLsgcguJodW0PjMal?=
 =?us-ascii?Q?AURfkCJ2qY1D81GhQ0tu7LM2nCC2pO5ynThuolq+tr0NO+caiYoJJlDz1Y32?=
 =?us-ascii?Q?3QJifrAyTjo7UMggV6Frc6kx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581d7582-4846-4dd6-c56e-08d96bcfb994
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 16:03:36.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiiD80tfyG3NAc8dMzjL7lBuw6lymdwo/SzXa1SZs3qsoy9+sOvValfoL9hYdMlBt56GMOTp9OG6HvPDD6i3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 01:32:40PM -0500, Michael Roth wrote:
> On Fri, Aug 27, 2021 at 05:18:49PM +0200, Borislav Petkov wrote:
> > On Fri, Aug 20, 2021 at 10:19:27AM -0500, Brijesh Singh wrote:
> > > From: Michael Roth <michael.roth@amd.com>
> > > 
> > > This adds support for utilizing the SEV-SNP-validated CPUID table in
> > 
> > s/This adds support for utilizing/Utilize/
> > 
> > Yap, it can really be that simple. :)
> > 
> > > the various #VC handler routines used throughout boot/run-time. Mostly
> > > this is handled by re-using the CPUID lookup code introduced earlier
> > > for the boot/compressed kernel, but at various stages of boot some work
> > > needs to be done to ensure the CPUID table is set up and remains
> > > accessible throughout. The following init routines are introduced to
> > > handle this:
> > 
> > Do not talk about what your patch does - that should hopefully be
> > visible in the diff itself. Rather, talk about *why* you're doing what
> > you're doing.
> 
> I'll get this cleaned up.
> 
> > 
> > > sev_snp_cpuid_init():
> > 
> > This one is not really introduced - it is already there.
> > 
> > <snip all the complex rest>
> > 
> > So this patch is making my head spin. It seems we're dancing a lot of
> > dance just to have our CPUID page present at all times. Which begs the
> > question: do we need it during the whole lifetime of the guest?
> > 
> > Regardless, I think this can be simplified by orders of
> > magnitude if we allocated statically 4K for that CPUID page in
> > arch/x86/boot/compressed/mem_encrypt.S, copied the supplied CPUID page
> > from the firmware to it and from now on, work with our own copy.
> 
> That makes sense. I was thinking it was safer to work with the FW page
> since it would be less susceptible to something like a buffer overflow
> modifying the CPUID table, but __ro_after_init seems like it would
> provide similar protections. And yes, would definitely be great to avoid
> the need for so many [re-]init routines.
> 
> > 
> > You probably would need to still remap it for kernel proper but it would
> > get rid of all that crazy in this patch here.
> > 
> > Hmmm?
> 
> If the memory is allocated in boot/compressed/mem_encrypt.S, wouldn't
> kernel proper still need to create a static buffer for its copy? And if
> not, wouldn't boot compressed still need a way to pass the PA of this
> buffer? That seems like it would need to be done via boot_params. It
> seems like it would also need to be marked as reserved as well since
> kernel proper could no longer rely on the EFI map to handle it.
> 
> I've been testing a similar approach based on your suggestion that seems
> to work out pretty well, but there's still some ugliness due to the
> fixup_pointer() stuff that's needed early during snp_cpuid_init() in
> kernel proper, which results in the need for 2 init routines there. Not
> sure if there's a better way to handle it, but it's a lot better than 4
> init routines at least, and with this there is no longer any need to
> store the address/size of the FW page:
> 
> in arch/x86/kernel/sev-shared.c:
> 
> /* Firmware-enforced limit on CPUID table entries */
> #define SNP_CPUID_COUNT_MAX 64
> 
> struct sev_snp_cpuid_info {
>         u32 count;
>         u32 __reserved1;
>         u64 __reserved2;
>         struct sev_snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
> } __packed;
> 
> static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
> static const struct snp_cpuid_info *cpuid_info __ro_after_init;
> static int sev_snp_cpuid_enabled __ro_after_init;
> 
> /*
>  * Initial set up of CPUID table when running identity-mapped.
>  */
> #ifdef __BOOT_COMPRESSED
> void sev_snp_cpuid_init(struct boot_params *bp)
> #else
> void __init sev_snp_cpuid_init(struct boot_params *bp, unsigned long physaddr)
> #endif
> {
>         const struct sev_snp_cpuid_info *cpuid_info_fw;
> 
>         cpuid_info_fw = snp_probe_cpuid_info(bp);
>         if (!cpuid_info_fw)
>                 return;
> 
> #ifdef __BOOT_COMPRESSED
>         cpuid_info2 = &cpuid_info_copy;
> #else
>         /* Kernel proper calls this while pointer fixups are still needed. */
>         cpuid_info2 = (const struct sev_snp_cpuid_info *)
>                        ((void *)&cpuid_info_copy - (void *)_text + physaddr);
> #endif
>         memcpy((struct sev_snp_cpuid_info *)cpuid_info2, cpuid_info_fw,
>                sizeof(*cpuid_info2));

These should be cpuid_info, not cpuid_info2.
