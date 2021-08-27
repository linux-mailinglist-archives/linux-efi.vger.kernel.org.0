Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5E3FB95C
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhH3P4o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:56:44 -0400
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:29969
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237311AbhH3P4n (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KswrxqvEWMxA34fuczUprPdFXm1/cH3wac7kGuS8Wb0MjkvrL6yq1AbcmFu6a163zsqlOxnZd+mRhBi2+HZRvqO3+z2gronCVhrtOJmEWSexR2sW1lNnJPbElcjMZ7pq2WqwdhuiLCsvMV5GT8gWv/+RhCVQXMq5Vh0HrC1xKkrIFVlCQrKaGnFFz3DcWTocQm17Bw40f9web3ZiKodM2V4du0vjxfC6fEZXRKGZIPNvBgRsoCbQGms01viuxnxcDIWVA3eSb1GLK7vwmnpJBEqcwBxIvxP+8dPUApwzvPrqNE5v2Ri/xAnkQ2MKlmpP65KAUVs3J8qIHCc/Ke13pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rKyOj0RjpqKnNjgXovN95UeSSGk1Ln1XMOMuobkDT8=;
 b=XCVmRdkjdbcs9tyRg+qNdoRqBHHegqFD3XY5+BKDvd8efVg6r+XtxlOYKnUWS7Mkqt+WpFpvLY6FnCi5YtyFYz/o0KRd+v8etDk6MB46/mLnVGw9gqG+QALRwIxaStVoxHvGFdo787gcXVSSN2muA+jsMBMwBvB5AG0hvbDluFPHy2zZ30Ouldsn4Uxo2chFTrE8vD/WHxct5GW94NVWTKRmRm8PmvFIBjb6uT1b1UEJbCn76s3AtcwAdmu8KNT1cKhEYZA6/CenFfxUYiBqLzb7h7YwQ9xTx1/uWxmHYT15yzn55oGH02k7UR8zPNgZNRaTZoUCqjCrh1Q5bqwDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rKyOj0RjpqKnNjgXovN95UeSSGk1Ln1XMOMuobkDT8=;
 b=nh+5eTMN3bY50WiX6PKWK/CUIuOx4JU7YH0VnOIQUSLcADnc8NAEa5VpOG0x86asaOflUD2HU1zU8+dAwb5B7ek3EomY0yamhRe3tZy7Eh4ChxI0pOubB8ZFAZFyUdJUjSnlKfuUgkfLmvhBRu2jZE4hUb18WqHL2lA4wLa4WhY=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 15:55:46 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 15:55:46 +0000
Date:   Fri, 27 Aug 2021 08:38:31 -0500
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
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <20210827133831.xfdw7z55q6ixpgjg@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
 <YSZTubkROktMMSba@zn.tnic>
 <20210825151835.wzgabnl7rbrge3a2@amd.com>
 <YSZv632kJKPzpayk@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZv632kJKPzpayk@zn.tnic>
X-ClientProxiedBy: SA0PR11CA0131.namprd11.prod.outlook.com
 (2603:10b6:806:131::16) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA0PR11CA0131.namprd11.prod.outlook.com (2603:10b6:806:131::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Mon, 30 Aug 2021 15:55:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 138c378a-672a-4473-b11f-08d96bcea13e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42464EF96E409A2B9BDEEABA95CB9@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDgsK1tzmHMc17Lprnm1GLO3bPo3NOA3E78/voMrzU2UZwyLFQTv2Y3HUj37DoDqFHSIAz4WDm+kHP4BwQ2uzP9zJgoe5ZrQweLGvSGT1KEBZiJX2mNIuDyScCpuHcRh+7lkeDgWgKsdElp8VY7jiYvC0h12dBIUAdCb2+nEbAFy2L+1aZUrwAoiZfv2Wf2h8MxohypjtFo/L+0UZjceWIUCZ3HO/KIAjCGweVgOTuUI8e9RYpp6Yb0jY/Xn+1Xdii/6iY5w8lRi6vl/nEO8iPFiilDJRS3LzOSUE/DXrUwV9F0OURR80TqlaV6IZd98is3uZMdH1E3l60h3la2gT6pSeXBRIcvcw45Da2Du7ccccDrlb6Olqq4G1xVZVjpU+ncYOrzyr+ySH6fLtK4sVIqbChsHM34MMaRgYyvYBcdZOZTiwaRGiZGxfNr+ec+ID5uMOl3IB//PkvjWXZkOLLK90eMKJ9zKoJCQYgXzGXNTGLRRVjm6X2vshN/wehorDIM7hU1YVUx2J0+2dAtS/2c5KtYmplyOzPsvmGrpThzR5dFWlyoH0ckN0tFQjWEBNNfZ9mwOW/Nv5/quFfmwXqDnDULOC8iz6q+BiUDcYDqZpflxfv9I0Z32QvuBQnxJaXWSzkMYXnTSKEznBEzZ35KX1WOf8O9+0+q2548Jh5hG5K+6BzihT7nWKEEevGezHTwcXjux0OqPu7Kl9Lg45LDu7u8AM7MSjiBTZY3CxRAXsRMf+VCH7nFqcNU4zhAfUuvmy75d6lxJeRhtT77ZXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(186003)(26005)(6916009)(2906002)(52116002)(956004)(44832011)(6496006)(83380400001)(7406005)(4326008)(38100700002)(38350700002)(45080400002)(2616005)(86362001)(6666004)(5660300002)(6486002)(66476007)(478600001)(8676002)(36756003)(54906003)(66946007)(66556008)(1076003)(316002)(966005)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wLt2Wbs30WbhOtwdlUTdvBbuCqKWhkysZwK1pyUamx/MLi1LrzfDyrDN8tJ?=
 =?us-ascii?Q?4wk8lDd3sna1eBFTcEZ2F4VOy+EcIUwvPIIUoD9DqpWqFCIDEQa7JzfadfwV?=
 =?us-ascii?Q?8svh64LBI2i8myLwRLuqb4rBTMTY+wSTLTSDzHYeYAAUwnEBVQGDoP8j3qQ+?=
 =?us-ascii?Q?iME8HvE030TRjTdTcfTuqYcUjHVAo3/ylLiXL9ZGlA91xQt2A7p5S+Zmjhmz?=
 =?us-ascii?Q?PJQxkEoUEjL6RX/xuCu6RCQVg82tz346HVin/RwjN9gsJo6KYNKZTWtX5kDa?=
 =?us-ascii?Q?xS6Jjigpri4YPBl+ouO+FmuMr6YFyGvcnwTBJz0aftfiWY1K0Eovu4dWMhX2?=
 =?us-ascii?Q?LS7v/IAtIIQoD74ec8w3C1Xx/G+EmpRU8sRP798EPU7H20ku1NUOL/o28kdc?=
 =?us-ascii?Q?MFZIUN+sUepxTvqIOTmhPLSQrztskxZTV33NKz/XtVam4kWPyNNt1QkcpWa7?=
 =?us-ascii?Q?ElIOVJ4rbIjGeqUTDwpyCSyuwJoojO2oTNnAUHVgy0dPykFZeO8Gut6DMmeA?=
 =?us-ascii?Q?dV7PI8tdVfPpMFnZoKTkhBz9oZLmHLSsg3Hak2wP+RfPxg+l/NoZXkZot5oP?=
 =?us-ascii?Q?w4He3codYHNj5r+cBHZy3WDXAyEyvNZbjg0+xGYL2Zp04D9gxhRqR5PjEvaw?=
 =?us-ascii?Q?v10uFTdmkvLXmzXlPXzlHOl/a4xFWb9CiS+9tweMqdyEu07EZR5xkPPE9sdA?=
 =?us-ascii?Q?M+l/K2OgOxC/Sr9Sx3Au2w/2cTYgC0uwSziZTKvW0dVSmEDFrVi9ncJpUVcI?=
 =?us-ascii?Q?pwsQpDaivgurl35WNvvHmEUEAcfiAqLuy7gnNd6EoqOr957UH63GNGRI9sX6?=
 =?us-ascii?Q?uzW+T7LFoD9/Ct5HRcyqJNjzQb9iq14/WqvwZGZs9GMnrYNxhsnXhYhmd5+t?=
 =?us-ascii?Q?MXt2Gw7gqQ7B7t4yZ5UktM8BY0BBwgqa+x3pIInubsOAyOyeP1u2h+CYQtC3?=
 =?us-ascii?Q?xzMZWHyLqwcAuAmZH6BX6c2p7aKkLbc+JjixyFp+KVPLeHI9EFB26SRNAQP3?=
 =?us-ascii?Q?I4w2Lij4uuJ35Ii8p0XJ2K4dkhLv5ZHkNgvdR9TYpWVUrWX1UobSyjqK5xwN?=
 =?us-ascii?Q?7/kRJ+k0Cuqm3E/rcvszLXEQDDRXP6FKMHcXg6XXq8FrZzBt83nqGMl6FYXg?=
 =?us-ascii?Q?H8upeqOz8iYnm5C/fcC0U/GUQh7QSN64iFwEG1cgL1o910/vNVdRot6Z2gcH?=
 =?us-ascii?Q?zXySuE27y5p1tYkWrhCxl+7yF8OwU00u5UjSLaQYCbgHjFatOOYaMm3nbotJ?=
 =?us-ascii?Q?IiE8y3gXgmf/WeJkF9zkY0eDRfQKx2vkvYhBivwm/4FHQLQ7oSJB2whoJhSh?=
 =?us-ascii?Q?lAZ5k8c+zi10miatBPgUpwmS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138c378a-672a-4473-b11f-08d96bcea13e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:55:46.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B550rWyUNiEzffUjO6L8uI5bzjIAO2Dc8w3sYBE1CcgZetItsdmaJuMBS5Z6tTMIf0CxH7gjp2UgKkcVk1rtEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 06:29:31PM +0200, Borislav Petkov wrote:
> On Wed, Aug 25, 2021 at 10:18:35AM -0500, Michael Roth wrote:
> > On Wed, Aug 25, 2021 at 04:29:13PM +0200, Borislav Petkov wrote:
> > > On Fri, Aug 20, 2021 at 10:19:18AM -0500, Brijesh Singh wrote:
> > > > From: Michael Roth <michael.roth@amd.com>
> > > > 
> > > > As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
> > > > head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
> > > > to allow a call to set_bringup_idt_handler(), which would otherwise
> > > > have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
> > > > sufficient for that case, this will still cause issues if we attempt to
> 								^^^
> 
> I'm tired of repeating the same review comments with you guys:
> 
> Who's "we"?
> 
> Please use passive voice in your text: no "we" or "I", etc.
> Personal pronouns are ambiguous in text, especially with so many
> parties/companies/etc developing the kernel so let's avoid them please.

That had also been fixed in the commit message fixup that got clobbered, but
I still missed it in one of the comments as well so I'll be more careful of
this.

> 
> How about you pay more attention?

I've been periodically revising/rewording my comments since I saw you're
original comments to Brijesh a few versions back, but it's how I normally
talk when discussing code with people so it keeps managing to sneak back in.

I've added a git hook to check for this and found other instances that need
fixing as well, so hopefully with the help of technology I can get them all
sorted for the next spin.

> 
> > I didn't realize the the 32-bit path was something you were suggesting
> > to have added in this patch, but I'll take a look at that as well.
> 
> If you're going to remove the -no-stack-protector thing for that file,
> then pls remove it for both 32- and 64-bit. I.e., the revert what
> 103a4908ad4d did.

Got it, will do.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cdfceeb76d2a4481da83f08d967e57220%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637655057436180426%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=aAKQ%2B7mXBvL4oofk0y7CacaMMD8Ucg8YL5hB4nw7zgo%3D&amp;reserved=0
