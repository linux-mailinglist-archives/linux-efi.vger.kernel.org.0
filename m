Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C433FD0A6
	for <lists+linux-efi@lfdr.de>; Wed,  1 Sep 2021 03:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbhIABSI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 21:18:08 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:22525
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241207AbhIABSH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 21:18:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqABQwOT56ilksc1BhxYT44RxmWqtvuqg/b31fpOI81o+tRprPNk73L6gBMofiKpUE2bbJ0b+LloFFfIUrnzx586RRjhKEzYQb1gXJhDQxaXgps8OuSss001mYWRkSdErLS0CdlgfXbhNxf6+iPUc5cfOJ/V3Mg/uON6pVc5mPuBkckb68xyjHByElUgJCh6uldkvJLRjCmGf72aF6i+pOBE7VSrs92JmLYj7s4xi5dprgfVMLeMx79x3PqPF9R2BH+i7KdT1TiiNKc0KhPpuYOqpqPwKd2pktC57iCP/3VIiDURUj5rthv9GP/CHFgjQ0bRo/St6i4uc364E08OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yelLIWaMCkgIfaz4DqO6DMFkOWziwSNxaALSIEaMLY=;
 b=YntwTCVlDt1LuzKs8w4uRtj0aI6vQbD5Pd29E+e8sYRpU47cReakihlrZaU5WpASyxyq4oPu7BqC22tte74UYFHj4YqghRR0leAHhKoHwiBvR8ajdpdYZAst0krb83NuBzJjvCugMdH/FV4rS7+S3LCgWfrWxzUUintKz/O7S/2enjCX4K6cYrV/eCex/YnthHhVg4SjsZXWtEQv/54j7RlKnUaMI5Iufj7e3lc/u2j/T50eMyiAvVwXFihWBIlemNgpwXTnxnD9VwBP40jL7iTgXCWQjmpqGPMF65YNg5GYDBzAJU+bmkuCcAJ2V2h1zk+7zyJ26rqBdTqc1wMaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yelLIWaMCkgIfaz4DqO6DMFkOWziwSNxaALSIEaMLY=;
 b=coTwRjk/raNWdXUrFaIGJHfuj7bxChPWg1ZcsiS5cd6zf+CHHy5l/dPns0EModNyxzTZKOBq+EhY+hr0ESsZfbjKP6WX4nghR7wxBZEAfk+8XVvFp11W6xVyUxks+BjMnHQZbsVSoeLzxT5xgqZILNIPwjm4Tvk94e11tbf/SM4=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3959.namprd12.prod.outlook.com (2603:10b6:610:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 1 Sep
 2021 01:17:07 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f5af:373a:5a75:c353]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f5af:373a:5a75:c353%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 01:17:07 +0000
Date:   Tue, 31 Aug 2021 20:16:58 -0500
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
Message-ID: <20210901011658.s4hgmvbptgseqcm3@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
 <YSkCWVTd0ZEvphlx@zn.tnic>
 <20210827183240.f7zvo3ujkeohmlrt@amd.com>
 <YS5XVBNrASp7Zrig@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5XVBNrASp7Zrig@zn.tnic>
X-ClientProxiedBy: SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44)
 To CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.1) by SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 1 Sep 2021 01:17:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cefba45e-34cf-4c81-0dff-08d96ce636c5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39593FEA145F92F918A9081795CD9@CH2PR12MB3959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7TX3NCRV+ATbmgQaGqaaq9dXFxLUvt9u3o6/PQQ5V/9SErHr+sw9kUmxOgcMErJH/Cbc3++qiRyEfC6sJ6Q02XapSazQp1es8xLZqQ+f188Jm7F8Z7v4IafO29r7437ZmhEwYLpTluuaRcKi/BXZqN3T5uK27YivGnBsafO+aLobvGt19W43d+E8hEGqYw4gGRwAbohLfhoRVjMYavMFVe8nb9c/RQwswqSo4osIG24EwFJIPLo5cSZYMfubn3P8rhD+dGmRe1M2AlHf/e0gIfnTDUPHL+ffqQcqtXbxUhAhrgAmk6F3S+0nWbbv61EPZ5z1+fnC/0KoD8q+0DIQAWgrW9mTW3eT8MEhIdM6mWgcFudGxqnunaf1laAoOvDlqyGmpAZvff/APAGVZTrmhWr5lorPsShrlhQSZYjRS+OmYWi2wUVsrpTAZaGc6KnoHCT418MEfjx+DWz9PtNpM18K/M4rtppG7wlJkyK6pQaPRZE3yTLn6UMaAux5ynbFhEIkllT686PjcXx0OQ9GHjT7/Bz1XqczKWbLeH/vWcNi4Vvd5YBtUt6LLxVYm/fCUUEGpxzYtfsw8I0A8o1HjGDLeSJ306ZCgYZ6GYKClb3VJtBbTfZv1rjE77x/lSUPMoV8KQM6rWxQ+db/GE55hRfFoFAxfQVLQsoBIqHbmwt2NLnXJgQPwi0UhbE8zto1RNxxC/P+TxT0izdRrKQ+52bbBCOXT8jDaaL/pem8RLuvSfMFv5eezNb0s4hk0SNMFQ+xTbsS+raP0sLzMclxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(36756003)(66946007)(66476007)(54906003)(6496006)(44832011)(45080400002)(52116002)(8676002)(1076003)(4326008)(26005)(186003)(83380400001)(6666004)(478600001)(956004)(6486002)(86362001)(2616005)(38350700002)(2906002)(966005)(7416002)(7406005)(5660300002)(8936002)(38100700002)(66556008)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ekcKrei8q6JG5V9Q+w0zYk2jLj9ZHBVYI3E6glVzu5H87g7A6coir5XqqRu?=
 =?us-ascii?Q?1Xodn6T7SoBIfvLEKnyPx7HfA6sOndQl+j4+3uq8HH/cXJn/Ca8GdiHUMTAi?=
 =?us-ascii?Q?HXcviPwBxInoWHNKNU/vqqF2kaE538VBA30rCbyY6vrZFoH9l314nVMIkkf0?=
 =?us-ascii?Q?arfl4e6RCTNdlkeeA09XFZXBwC0pIaa8sMHxNoIloPoj4LSpdYjQ6iYkygQ3?=
 =?us-ascii?Q?1M8OPJ9VxtrlA+F1YVvv84rDZTA70zSZmYftQvcNYJjCkMsg53jw+J7qyMsU?=
 =?us-ascii?Q?uGqpvoYwkPH/KhEaYSRZ0XdUX2tX+XPauSRFOIJxva1DRFz8vg3gXpBBIfEo?=
 =?us-ascii?Q?i5kYetmDE4YyYyLFlUbE7TBBo6zAmsdqSWrqZrdOBTCqVDdfplEdYavDIcYe?=
 =?us-ascii?Q?5ZLSxdPRtPUFotFRYzaFKd3X+X75MXEM4E9dLMS5K7jAwbAf0yZYQ/aW5gSV?=
 =?us-ascii?Q?yvi568rZYz7amZGXfTO6FlNJEDQWeyhVtV2x6acctMWWbtEHBObK4HXPndrr?=
 =?us-ascii?Q?hN96570yeBGkUciytSrVC+S9DCjDU2sZlYNpv+q+tIB7+23helb50NVldcDW?=
 =?us-ascii?Q?6SsxrRf9kyzFc5Vs/HdyDt8ZiqTAk3egOR53uNU6gTlJdB9hSkPx7YrRTPjl?=
 =?us-ascii?Q?qMg71AJFYbl36f+5zuOVLIklDflYwbgBLXrGp8N39kZbw7xc+Q8uj2PHHMC6?=
 =?us-ascii?Q?3HFYtDl+3fPUNPBA+h+FhvjMAyQGV89DFLk1LBboVarMv9uHSQxJ4mgiRkHf?=
 =?us-ascii?Q?Dij0Zex9ZR/2KH+wQK01Zw8cGTBGUpJbI8Q5aHgdRJfU3ZTufJOIqvI6niLM?=
 =?us-ascii?Q?Cl1eUxVAmQtLbX2WKuxKsBEfP+34Jc0G9IZmd4Eh890T0HxWgdSiClafSHLM?=
 =?us-ascii?Q?/GEYjhghRK8erj05gaI/07Pr6nMCk7goD46vCnoOTfdIlhJqABLNP06fJW9u?=
 =?us-ascii?Q?cL0/zUPIqexBNHU/wewelsF9qLTsoIG3p6evwxR1hoMYT3yav4/LEsackP9k?=
 =?us-ascii?Q?iXm9QXL0kVWkB7nWVUW4UA3hVQPjvqYKeKlln9EMPqD7gPMXhyIHuLRCgqck?=
 =?us-ascii?Q?fxPR3qrSNGAeEZHRAQT6JvTdqjVr+LvBdWUmZnklY7Pmfz7/999jMyzJHUUA?=
 =?us-ascii?Q?VyFAbHLmOa7eo5hYmIdDT2vRezsgXy7ZewBy9PNjE9ThePlivrqJVhTXOWlF?=
 =?us-ascii?Q?5jK+A+Shzvcjo8rhd1nh+GKohHAESMsdpbMsVXO1dRAuDxhSMNrk9jMQAMgg?=
 =?us-ascii?Q?azsv+g9yUIsQ7pExkcVeC+tS+jUAwHYLKkeofU8Ad+fZ80unh65S/3S6/uyh?=
 =?us-ascii?Q?V+gXu0+DZZZaXei5mJg5HB8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefba45e-34cf-4c81-0dff-08d96ce636c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:17:06.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /98pKlYnxJxdyxazVQ0oysgGsstB19EgXyYso3eABL7e8exl/r4LEQHkeD62y3eTBdvLAf7kJujpa+gcZuOtTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3959
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 31, 2021 at 06:22:44PM +0200, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 01:32:40PM -0500, Michael Roth wrote:
> > If the memory is allocated in boot/compressed/mem_encrypt.S, wouldn't
> > kernel proper still need to create a static buffer for its copy?
> 
> Just like the other variables like sme_me_mask etc that file allocates
> at the bottom. Or do you have a better idea?

What did you think of the suggestion of defining it in sev-shared.c
as a static buffer/struct as __ro_after_init? It would be nice to
declare/reserve the memory in one place. Another benefit is it doesn't
need to be exported, and could just be local with all the other
snp_cpuid* helpers that access it in sev-shared.c

> 
> > Would that be a reasonable approach for v6?
> 
> I don't like the ifdeffery one bit, TBH. I guess you should split it
> and have a boot/compressed page and a kernel proper one and keep 'em
> separate. That should make everything nice and clean at the cost of 2*4K
> which is nothing nowadays.

I think I can address the ifdeffery by splitting the boot/proper routines
into separate self-contained routines (and maybe move them out into
boot/compressed/sev.c and kernel/sev.c, respectively), then having them
just initialize the table pointer and create the copy using a common setter
function, e.g.

  snp_cpuid_table_create(cc_blob, fixup_offset)

and for boot/compressed.c fixup_offset would just be passed in as 0.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7Cb4adf700d33e42ffe4be08d96c9b7fe6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637660237404006013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nVGIpG0WAcqcHZWXK1%2BQoaPBoeCLwtkqgs8Mfgz%2Fr04%3D&amp;reserved=0
