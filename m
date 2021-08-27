Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F63FB96F
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhH3P5K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:57:10 -0400
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:53152
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237775AbhH3P5E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY6RGHVMcq3ftUOk8nFVlJhK+ECuTCQ9p8kCKUab0ginhq7mKIMDGUU450MIgqNXY3pzCuXoG9PtWO/97iDYBim5tAGRFaoCAiACQmGKOQjPYApsI4vKeLidEmvFRvkYhuiQK9OMAXlyn4uEQEAzQoHieU52NWFV/MSR1dgwtaIO4KxENp+zxrPy8k9c0QRzgW5QxJLwsEzfSH+NrbzBQiLca/TBca59Nlkx1E6VLwBag7YQouNZ3FPc/nI64DRK0QJIcIWnXqoXhWRi761NR9whniMNeGM5EvTiTm4s8l6v3WmilivOD8zRZ0hsmplVr+770RlCCCpmfKUswi+nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=445VgKUzq44VdPVExLhS5fRsA8lnRJRzq6sjX59WkX4=;
 b=HBfEnKq2CxO/fb1uZC+SVdasimMoi6YmWIFY+CMw1KdpsqPjKuqEiQTVj2/xG5AeRGhi9eaQHtWaEkOGtbBjxybBQ6O4FYW8WrW6UpYyXaVGbfft4212cqmmR0qpQdjYG+7EGZz+DaNFHddOL3ZZFy419hFOncWQ1Mfc7uNywSZ6zrhyfYX8R88o0nffDcgUoVfNbtUK+Zt8hov1l/Wu+q+OrMJt5JEMIbQduk4Y+r5JVi6ncH8jSQKJ7mmj/ElqJq6mQ+QnVHK8o5NAy1yH3z4QfkozcbxwF5x3qbPipSuiO2mzSAfk6s5l/vCN6NOAyRG4OIE7Tf2XF7RDvz+Ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=445VgKUzq44VdPVExLhS5fRsA8lnRJRzq6sjX59WkX4=;
 b=dIg7/d50wGAobFd3G36czkOnfcqIXMpUWsO0pedrvvYRAeV8SUzoX3uC5ITds882OdIpzrSuevntAf7A6Qu8FcTaUAskx1OoAd5UkuXRAW1KmpWnxYaQdec1Wx2dzTovo5w8xYiSnQwJFiunNQtrEF+QA5aXlSwDFB3BfAhQHUE=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 15:56:09 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 15:56:09 +0000
Date:   Fri, 27 Aug 2021 13:48:06 -0500
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
Subject: Re: [PATCH Part1 v5 29/38] x86/boot: add a pointer to Confidential
 Computing blob in bootparams
Message-ID: <20210827184806.wzkixqnc3premyg3@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-30-brijesh.singh@amd.com>
 <YSjt4YDQR8vDeOdI@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSjt4YDQR8vDeOdI@zn.tnic>
X-ClientProxiedBy: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:805:66::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 15:56:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab1bba71-4c7c-41fe-048f-08d96bceae9d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4246FC2D20E62B444407AC6E95CB9@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l++S4SPFcwZlCXxyaCKFnHw7DF9Iq3bUQtiwmsavDHhcNhMxw/F/EfHsVWUNAIZR1E7mke5ZEL+1RTQ1Y/0GPXlFY3PenMVhXJRj1/J8w1CKSAiFUnV98jwiex4LG8Qti2fqiveUSCj5kWfGoPcBbGOdh+78B8koMY59j9AQNjmptt4JAL7uR8E+ZMjThzwoZLHXI/JFSDWhTH7ATGN6weGzqlqoi6DdaAwTIP0JZQ2SI4zVhvaWg6WzZEj1Vnv8ojukMjVyyLewkmj6voLC0Chq3EJEwNDFeSTjXnajicu0EsjbSCy3/Qw/Cucn39XVPZDsh3VU9/oQxXESAd47rJG/iRahh/FBoxfKrEOXoO4OU8ABPn9xa1PZVPrsnMcSfePArNdoFHg/+K+7KYzB4KIrD6nfMIxoLN7gWVOBJGopYrvEf4XTGgsG0o4IzzN21Eff1RaANRdWUl3P8dWApiusd9eVe5eknKc4DkO6/PWMV7lXIyi6WiKqenM7Mcwxlm9fzAdANEnClQQaNxOUZXlhLzhdfyHsnDRUxFOgzbqJvxcXiuiR8aaSx2E7CuZMbsvdgkMVnXaYVgnKbL9hAbIWfaz2xKHXKG5G0CaGeXl84vyBvpxa7ELi15CpWvxz0UtDYfl7BKkswTcIMkhg5iuoMu8pN+m/gQvnTkOyzn7VpBnOIU0/UIUVP430G7/9JVduhjQBkvCYdeZcw9RdV6jARlpZT19cS2o96K22c0RWltuTtW39payrJ1FmtN2TCA0sVpGxNk/xv7lJaVQv9QKzREUYPhuyLQOfqrRCoQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(186003)(26005)(6916009)(2906002)(52116002)(956004)(44832011)(6496006)(83380400001)(7406005)(4326008)(38100700002)(38350700002)(45080400002)(2616005)(86362001)(5660300002)(6486002)(66476007)(478600001)(8676002)(36756003)(54906003)(66946007)(66556008)(1076003)(316002)(966005)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7eZ+MfXrFTUXXHsS3aIY+1tGUoO6ypt8Q6KTuFtd/5C3SzJAde8CpJrNzdy?=
 =?us-ascii?Q?cy43n/6A0wQnFUNNNSBUZzYOMx8NptfwsUO21cx/IQ+C6yUuH/yYNPNagxcG?=
 =?us-ascii?Q?9KiyAVGSaj0ZI270eQYXwtI3SAi3PJos7gliYil3wDJYZzo1zv82Qi6HB3Q8?=
 =?us-ascii?Q?64xu1b49pmc0rP+6ntHkOSR0RPP7aW37B33mC7/mmy2bwUfIvdZxH5mOic6Y?=
 =?us-ascii?Q?3Bn9k6mogfydl5bM3mV2DNGAiK8L/p2AzRUq3XZ7u7Mr4jV1+KUfmYqKHGaE?=
 =?us-ascii?Q?YH59vnx0lbSJcxG/E1Ypb9at0XUPP+OclkKf5FZMobBdmQZfhAmExn/dSMrB?=
 =?us-ascii?Q?pr025z9hPIxjLrTE3LMUj0v8n4l9IXVUWx7Tue/51h/Mdx9Pt0lh/KPSOdeT?=
 =?us-ascii?Q?CD69X+QsQbJCDBbiJA+Y6h/lXWUfDmtsZam+JSZ+ZjCAQZUrfh3C26fh6Gm+?=
 =?us-ascii?Q?tvr/Ns2CS+f5JxLL0DDv6Bw7Ge/miZ0NVO6YPNKAm9gxj1PJATIktMys18mg?=
 =?us-ascii?Q?PMaFSLnbpSgF77e6agBpjgpW2MjNGgJDHnMKtXrB81ETlExT71iWaJEArf4m?=
 =?us-ascii?Q?VbBIzodMh4vWePYBRgaXR6aW9kV4L20EGPNNCNlxrBFX+SvZop4VeyLPix62?=
 =?us-ascii?Q?Jqsot8bfuax3w9hosaqNAo2lCwNEuq6vlFpBi13LpO1XeoFAc2O/SgJfkCuO?=
 =?us-ascii?Q?z/VQN9u98bMSzjA5rRXsCoJkwiYwqEv0wyXZ/5GM5r9Q8rFyiuSNHz5hrtXv?=
 =?us-ascii?Q?JbErV3v4ahGCAjCW5x98aguCKPP4Te3EgQEyvzPRQH0z5lBhp5BJtxTTpFPC?=
 =?us-ascii?Q?AL1DQrzLQRNqhn391apohQZm7Nv4C74sLPOYETZrZeSu+WU0t6X1Ot+Ans1A?=
 =?us-ascii?Q?cdfyXoRQEi1jAqnyEX8Q3zHUUGY1Z7FbgxjN5MQ9qiSP/6iB3lG/EFDyVsG7?=
 =?us-ascii?Q?NcJ87QKASWVRZNj8BlCz2iXBHZLOM/Ue4M+Fc9emep2KS7NJf8N4XSERW+xQ?=
 =?us-ascii?Q?sF+LlcmpNkA+ONWhuZoHHravRYbXa3BBa5LgO2nTkNav63lNFCDEemJcojVG?=
 =?us-ascii?Q?2O+iTBP7A62C0tvbtK+UXiuYVeLPpOP9yoFf9f/Km/lfGmXOoemH6oH9H73l?=
 =?us-ascii?Q?jZ5jfT/B+QbHvAo3pM3sWMcGXYrSiYa+XwMZrmD4XC+9UlRZhpX/KKAlbMpL?=
 =?us-ascii?Q?cAwkO1G6uHAeEOu3YCTU3bL6s9Bv4vC2uEqjj8VN8H2a8Cd7mRLJMQ7PMfus?=
 =?us-ascii?Q?ACg2wklTtLgSRunLAwFthjNAqTHSpbnxHf+W1g7AWFhC/I4z0AwkwSYvunna?=
 =?us-ascii?Q?4IgsRkvGYg1bMhS+o/M48i7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1bba71-4c7c-41fe-048f-08d96bceae9d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:56:09.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVVwm3UfG7DUAfU62YT8Nu++cDOYQ6FCQwle+AI9sR5KT2izZ09U+KFAtgdSxB6l7iINVnc9UZPI8QKaQDpKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 03:51:29PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:24AM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > The previously defined Confidential Computing blob is provided to the
> > kernel via a setup_data structure or EFI config table entry. Currently
> > these are both checked for by boot/compressed kernel to access the
> > CPUID table address within it for use with SEV-SNP CPUID enforcement.
> > 
> > To also enable SEV-SNP CPUID enforcement for the run-time kernel,
> > similar early access to the CPUID table is needed early on while it's
> > still using the identity-mapped page table set up by boot/compressed,
> > where global pointers need to be accessed via fixup_pointer().
> > 
> > This is much of an issue for accessing setup_data, and the EFI config
> > table helper code currently used in boot/compressed *could* be used in
> > this case as well since they both rely on identity-mapping. However, it
> > has some reliance on EFI helpers/string constants that would need to be
> > accessed via fixup_pointer(), and fixing it up while making it
> > shareable between boot/compressed and run-time kernel is fragile and
> > introduces a good bit of uglyness.
> > 
> > Instead, this patch adds a boot_params->cc_blob_address pointer that
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
> > boot/compressed can initialize so that the run-time kernel can access
> > the prelocated CC blob that way instead.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/include/asm/bootparam_utils.h | 1 +
> >  arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> > index 981fe923a59f..53e9b0620d96 100644
> > --- a/arch/x86/include/asm/bootparam_utils.h
> > +++ b/arch/x86/include/asm/bootparam_utils.h
> > @@ -74,6 +74,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
> >  			BOOT_PARAM_PRESERVE(hdr),
> >  			BOOT_PARAM_PRESERVE(e820_table),
> >  			BOOT_PARAM_PRESERVE(eddbuf),
> > +			BOOT_PARAM_PRESERVE(cc_blob_address),
> >  		};
> >  
> >  		memset(&scratch, 0, sizeof(scratch));
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index 1ac5acca72ce..bea5cdcdf532 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -188,7 +188,8 @@ struct boot_params {
> >  	__u32 ext_ramdisk_image;			/* 0x0c0 */
> >  	__u32 ext_ramdisk_size;				/* 0x0c4 */
> >  	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
> > -	__u8  _pad4[116];				/* 0x0cc */
> > +	__u8  _pad4[112];				/* 0x0cc */
> > +	__u32 cc_blob_address;				/* 0x13c */
> 
> So I know I've heard grub being mentioned in conjunction with this: if
> you are ever going to pass this through the boot loader, then you'd need
> to update Documentation/x86/zero-page.rst too to state that this field
> can be written by the boot loader too.

Right, I think we had discussed this back in v3 or so. But for grub, or
other bootloaders, the idea would be for them to use pass the CC blob
via a struct setup_data corresponding to SETUP_CC_BLOB, introduced in:

  x86/boot: Add Confidential Computing type to setup_data

the boot_params field is only used internally to allow boot/compressed
to hand the CC blob over to kernel proper without kernel proper needing
to rescan for EFI blob (and thus needing all the efi config parsing
stuff).

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C83df94e2e42a415a515308d96961b2e8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637656690614876025%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=aL8JhC82mQ59sYNfk645%2Bxv%2FrgfU95jTxBJIr8uRRZs%3D&amp;reserved=0
