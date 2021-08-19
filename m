Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75983F1C6D
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhHSPQO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 11:16:14 -0400
Received: from mail-bn8nam08on2047.outbound.protection.outlook.com ([40.107.100.47]:41184
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239535AbhHSPQM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 11:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRxLz9E93HDVO/a/bQJ+OoJ9Im78ugF1QGJTJ0t8+Gf6Q41WXaNFN66/sTOGn70rSjC4ffYfvj5NTcAYNgcZggMEml1IlOK2/dv7IZDgGtxbmQKYWzFyz7rruNi5q2UDSRGW7Z87XzZnI3Pp229ozC4qGaw8RzSZ1bM20OuQlMLDbTZ6PKQ7wjqU3D4NSiFD14vUidx37hZE339qjWI+jfkLZU8e0F9H7Mr3n+V7g4mjv9PPhKUdG9H/o8cr2VpyYVZZdUqvJ76k04IQXahQMRbZ9ZInkMwkc6dA6IKvCi6pWSemPDiyfR5K4DiFJINSVIi4NdoBUyv5oHcXWr9Gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Q4aZpTrTrSxMi8jm6gjI8LpAwyQhSTcVk0h0ryq+w=;
 b=IqyxNcOsjC+9VIkCFhUs/FAseWcd4nSlBEwCyBkQzHgSNPqDoyq+O9PIyyOhgcWcLJYEiBHMOgmMJuSsH1H2NWi4LCTMBOKRTzPuFIPgQYgYYzBC30Re8whJvYbICgTKmnEkG3+TGo7L4xtS6fNff1SZStUhOgpvk2JLF3EFMZC/uCk9MsLMvJZPOTALTSumB9FGGifkEiI6hq67zjpLtn97P5TPsCX7KaBVKy0rJsVYtywHK/eWVwtb5csr+b5RkbTSpcdv3eHjzsSxlDhLvMok2FHOk9gdXvCoV5yJ6rt3llRBm5+RWe3NKESPUJ6FvE6As0CII52ZAEzj6PnGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Q4aZpTrTrSxMi8jm6gjI8LpAwyQhSTcVk0h0ryq+w=;
 b=3PxQvRcWD4C1tH/y3H8KMzByXVqvwvcVwazfU2Q778aIdvpZ5eoxLMaP93Fn6g1w9dsJH+3eIbDNAzQHgTfAGSsbxy0/yup00UM7yCjAalpDzmUqG9k+ycayhCDcKAuGuip48TT1b+pv5ZXNt6KXP4bm5JlRRkPoXEtkBl+bD34=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 19 Aug
 2021 15:15:32 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 15:15:32 +0000
Date:   Thu, 19 Aug 2021 09:58:31 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 24/36] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <20210819145831.42uszc4lcsffebzu@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-25-brijesh.singh@amd.com>
 <YR42323cUxsbQo5h@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR42323cUxsbQo5h@zn.tnic>
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 15:15:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc90c317-a1c6-4eb4-abcc-08d963242ff0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB485977827F7A1280C5635C5995C09@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQM1is44vhxsAs0KpkyeyIBuOVMsVP5fl8mxDHCayIf32/kIlfoFBr8++uU+HE2Z1A1qZr0VbTKsOVa4aEwXtzt5rVZgIV5Ufchq6CwXyxMtaHxorBzwgPSQBnN0GZ89TJKkuzWrn1JukUone4Iq/ifj3DLnDuxtS5RK5W6Ipjki8Gz3VMsk0F2G5CCjRMtHiMrkHQ1KJKS6J1Fww5X3eL9Kpu22dW2H3u/gUgB+8x9AzTMt9oYYp/1tL2PsEdONMWLW4CevIa++c65yWVxLq+Qik+SR6qiT35CP1CJHYRGmpQ1PsuaU7A/33E5//zInZNY5bY0COsUEqNtIktVkOhGblkuOPQl/h/tlCkRh4UnWyaLYSgpNSk/Vjt/iQUEo6ZadUppjaTIsIfeSMADuyeMVyJnC82niZlu2FM23HwIeV670TowLOnUAO1SKOOl4EQZwgXh8wQntTtVEj5MPELtnVVRaQn1rBOhBxJuiWDb2b8NyL3UTVSBUqEap+n/HHCSmNQuNfQDw4+DByp71rhqTbTpHj/lZatYTwbgpKB5xIfwe2siYPZimR998zbnVOKXuDqLW6pNhJB3rFhEFC5d/FiOWaM4ELdQpT0QXCWA1mIySDy4KKufl13uQqz6vXwxZvPGQDN2f8uLCRDkAYpugk7XH8kUDeluy24f3WoOLWOJy4lH7uNuItMaqfydmxiaX3PAig9lGOLGVoyKSSVjvCpeFvTFIvmcHsXIFLFwUHxyul/DxZEI8JEPh1AA+t2yUNt9yeAmhcu0JltzUrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66946007)(52116002)(186003)(6496006)(66556008)(45080400002)(54906003)(2616005)(66476007)(38350700002)(316002)(4326008)(1076003)(5660300002)(8676002)(8936002)(83380400001)(38100700002)(966005)(6916009)(86362001)(6486002)(2906002)(36756003)(44832011)(7406005)(7416002)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4FR+zn1y4kYy+pxvFi5MseihUj8C6wgQo9FDe4CtOOAcpkRwHo3X9km9bJq?=
 =?us-ascii?Q?9GyMjKsjqIhOXPwhJoY2+Fncf/f62ifdDPxK8qArZALDxAlcjtz1iWP/34yV?=
 =?us-ascii?Q?mjyu7NwczYXt0yKEmsv+J+ik+CWoXSGjDkIeHqY3BFgWZuwQrF20FGFUQp2T?=
 =?us-ascii?Q?ppXViZ8mFB4AHETh2t/jNfJkKLaWDu0yPBryCrz1RLx/qUs+wJsXIzPh5uuj?=
 =?us-ascii?Q?CDTcfpfktEISlwvCCyYFSEWgmvR24creNHx+/h9S4AdpGVHuBD5UYlz93DX0?=
 =?us-ascii?Q?TdDknzLRgJfwUUTGfow3j/HbqVs8ArzywaDOmRhn6oOQ6C+/TwJd5LpVITcY?=
 =?us-ascii?Q?bjtm1c4gSo/7epiLo/lVQvA4Rq5Lnku1ZTNij12XwUpZ6TyNyjy1hYHxH1hL?=
 =?us-ascii?Q?8z/+IT3+LXhgx02EC2nvq7P/DA+cduCGCne4mAtiQYhgFRIhI114fKx57oxj?=
 =?us-ascii?Q?1x4uoJSVtQk27+tXjdQFRl39NWYun7Drlsc2mzdBzt0kDaaBWNvPn3Gs92+a?=
 =?us-ascii?Q?sHXKtJQt/z8hmNfygTDx4DU1zYs1ZB2PARhGFB6jAiyDLFF8ulGywGM3OhdF?=
 =?us-ascii?Q?WNzhTIbt6gn9QSCy5EbGoxAn9kTB733y73hDnhfUCXm0YxbmS5qA13IvqN4m?=
 =?us-ascii?Q?tHm/QAQvN5kPppJe2ofUviNP1tZus8/iVMsMHtrgAFkSxBW754ovmyC0zAhB?=
 =?us-ascii?Q?9FQ6x17rLppWWhwfo1/U8VDCuqBtW/kETRGiv+0b4SiKeksqh5aBqsQ2BokB?=
 =?us-ascii?Q?6Mdt7JwUdLbDRQkwwwVT5n9KQr0AXndvhq/hY9FJAUVmiw661PBlBsX13sRf?=
 =?us-ascii?Q?lKWy04P11n3QGq36sBlpQNJV+4PASiP0iPS4ZrvL8dm0XqzvMPt3Uzx+GznS?=
 =?us-ascii?Q?w0TXZ2PK7cV+8GQ/SWb0705XTDHPvIZND/Dh4sI8jUvLoSeNLu4O0CNy/XVg?=
 =?us-ascii?Q?HQDaIB3TI/ez4ES1QyBhkoV95OOavO5qw9Xb+yDruzJtZ6jUx6CfB7k/nzJa?=
 =?us-ascii?Q?NNj/JTgyfIvMgVa8YaL6or00CvDJK/mGzxTblHSCWX6FG/DNBHt5dsH+VhwS?=
 =?us-ascii?Q?QLuZGpqB/k5keEyXpdMW2jYX7NXizuqchGTUOicTk0y3sqB2DAi0S2EN+jAj?=
 =?us-ascii?Q?il+2fW6jsuKHwLtR+vxm9lV8jRf2ZmpwNvr4NXDua9Lm+CKuLM3q5j0GovW3?=
 =?us-ascii?Q?WDwCa8ssfA0DgIEwTkCUdkNCNo3yGwe9ql0doJS+7Z1Yr4g+xSbokXDcqvtw?=
 =?us-ascii?Q?s7AfcX3h/4CODhuyWhfLAyDac36QQFZ2ao8C0hzg/lSi1Vyi2aW4bo0MvM2E?=
 =?us-ascii?Q?e+j9klhawesqnbH2Lm321ddD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc90c317-a1c6-4eb4-abcc-08d963242ff0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 15:15:32.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIgTykC8Nf6W5bCgtpiHquY1iWnEq000Vlf9HJjcuiePzYAnATYqrtspcl9fYdNOgP+NYT1/MYureReyC0V77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 12:47:59PM +0200, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:54PM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > Future patches for SEV-SNP-validated CPUID will also require early
> > parsing of the EFI configuration. Move the related code into a set of
> > helpers that can be re-used for that purpose.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/boot/compressed/Makefile           |   1 +
> >  arch/x86/boot/compressed/acpi.c             | 124 +++++---------
> >  arch/x86/boot/compressed/efi-config-table.c | 180 ++++++++++++++++++++
> >  arch/x86/boot/compressed/misc.h             |  50 ++++++
> >  4 files changed, 272 insertions(+), 83 deletions(-)
> >  create mode 100644 arch/x86/boot/compressed/efi-config-table.c
> 

Hi Boris,

Thanks for reviewing. Just FYI, Brijesh is prepping v5 to post soon, and I
will work to get all your comments addressed as part of that, but there has
also been a change to the CPUID handling in the #VC handlers in case you
wanted to wait for that to land.

> arch/x86/boot/compressed/efi.c
> 
> should be good enough.
> 
> And in general, this patch is hard to review because it does a bunch of
> things at the same time. You should split it:
> 
> - the first patch sould carve out only the functionality into helpers
> without adding or changing the existing functionality.
> 
> - later ones should add the new functionality, in single logical steps.

Not sure what you mean here. All the interfaces introduced here are used
by acpi.c. There is another helper added later (efi_bp_find_vendor_table())
in "enable SEV-SNP-validated CPUID in #VC handler", since it's not used
here by acpi.c.

> 
> Some preliminary comments below as far as I can:
> 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 431bf7f846c3..b41aecfda49c 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -100,6 +100,7 @@ endif
> >  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> >  
> >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> > +vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi-config-table.o
> >  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
> >  
> >  $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
> > diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> > index 8bcbcee54aa1..e087dcaf43b3 100644
> > --- a/arch/x86/boot/compressed/acpi.c
> > +++ b/arch/x86/boot/compressed/acpi.c
> > @@ -24,42 +24,36 @@ struct mem_vector immovable_mem[MAX_NUMNODES*2];
> >   * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
> >   * ACPI_TABLE_GUID are found, take the former, which has more features.
> >   */
> > +#ifdef CONFIG_EFI
> > +static bool
> > +rsdp_find_fn(efi_guid_t guid, unsigned long vendor_table, bool efi_64,
> > +	     void *opaque)
> > +{
> > +	acpi_physical_address *rsdp_addr = opaque;
> > +
> > +	if (!(efi_guidcmp(guid, ACPI_TABLE_GUID))) {
> > +		*rsdp_addr = vendor_table;
> > +	} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
> > +		*rsdp_addr = vendor_table;
> > +		return false;
> 
> No "return false" in the ACPI_TABLE_GUID branch above? Maybe this has to
> do with the preference to ACPI_20_TABLE_GUID.

Right, current acpi.c keeps searching in case the preferred
ACPI_20_TABLE_GUID is found.

> 
> In any case, this looks silly. Please do the iteration simple
> and stupid without the function pointer and get rid of that
> efi_foreach_conf_entry() thing - this is not firmware.

There is the aforementioned efi_bp_find_vendor_table() that does the
simple iteration, but I wasn't sure how to build the "find one of these,
but this one is preferred" logic into it in a reasonable way.

I could just call it once for each of these GUIDs though. I was hesitant
to do so since it's less efficient than existing code, but if it's worth
it for the simplification then I'm all for it.

So I'll pull efi_bp_find_vendor_table() into this patch, rename to
efi_find_vendor_table(), and drop efi_foreach_conf_entry() in favor
of it.

> 
> > diff --git a/arch/x86/boot/compressed/efi-config-table.c b/arch/x86/boot/compressed/efi-config-table.c
> > new file mode 100644
> > index 000000000000..d1a34aa7cefd
> > --- /dev/null
> > +++ b/arch/x86/boot/compressed/efi-config-table.c
> 
> ...
> 
> > +/*
> 
> If you're going to add proper comments, make them kernel-doc. I.e., it
> should start with
> 
> /**
> 
> and then use
> 
> ./scripts/kernel-doc -none arch/x86/boot/compressed/efi-config-table.c
> 
> to check them all they're proper.

Nice, thanks for the tip.

> 
> 
> > + * Given boot_params, retrieve the physical address of EFI system table.
> > + *
> > + * @boot_params:        pointer to boot_params
> > + * @sys_table_pa:       location to store physical address of system table
> > + * @is_efi_64:          location to store whether using 64-bit EFI or not
> > + *
> > + * Returns 0 on success. On error, return params are left unchanged.
> > + */
> > +int
> > +efi_bp_get_system_table(struct boot_params *boot_params,
> 
> There's no need for the "_bp_" - just efi_get_system_table(). Ditto for
> the other naming.

There used to also be an efi_get_conf_table() that did the lookup given
a direct pointer to systab rather than going through bootparams, so I
needed some way to differentiate, but looks like I dropped that at some
point, so I'll rename these as suggested.

> 
> I'll review the rest properly after you've split it.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C5a35d1d920024a99451608d962febc38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637649668538296788%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ED6tez8A1ktSULe%2FhJTxeqPlp4LVb0Yt4i44P9gytAw%3D&amp;reserved=0
