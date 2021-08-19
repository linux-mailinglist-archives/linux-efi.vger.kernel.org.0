Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8493F1CF2
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhHSPia (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 11:38:30 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:39179
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239440AbhHSPi3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 11:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf691S27Q1RWUB91BvLLRbcgR7Anar3cCtoC5UhYjSEerjSYfIZ42JfSUDe0qNRaqY1DunX/FBfH5P4vz3AEpTqBdk+FmSpbrUsm+3knzhFkO14fkFqgpBx16woRjAtGmDmhe5niAkhdUJqhOZWHiXdNOWgl6fQPZLAeGfbxuI9Fa6FZxi9jXyFjYVYF3qMUimHeoBplkOX6gkhwETIQx4Uptbtc0Sa+1qjVZyg03R0Ln3rZR82KCJk/7v6r3uq40czuC3pRWvOhQ5eY0ehE5ya3IWBD69sSDSXPahpi44806GcBSyosv1ChPGE+bpKB+aSmb8RhuR8k2LbVqHdPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVnWd0Ygy302pT9qbQIuVtjYM8ROPF9SAXqB8qm/NaQ=;
 b=QPBBKGyecIn0YU4lgfiPJm2+tVtWy9/oB/hQ+0HK1JFXihutSv88pQEAEdRB+8h0XO8Ocam8FvFohE2YrKkpD2Mk72lYKPbVyLWmKUQUfl9EfRDkgiCs0nalbOosdCoev1uaXL7ucYGE9eM3tNvG8xuGt93Eg9Sjq6oT5Ux5VoQOMsTXJAL1j/e05w4rQS5Ay0ZXFpJZQipMonY4siznJJAKSBNDlP8LcSzlZGM54BOaHd2KZPKphzej5jKLd+ZPWYbK1HgLK4ERqQrCCOPaMCrCVhppUhvIr7YMasvVGekLQaGjO9iHQ1tcxrQ9jUw+M0sfrgw7XAUCJ9+uLjep6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVnWd0Ygy302pT9qbQIuVtjYM8ROPF9SAXqB8qm/NaQ=;
 b=C1e9PTmx3WIRSChkOppUvHzzMsD8IFCo0GEnzaO085dP6CmcFN5AAdYyl8g3+vZ+pGO44US8RL10Ew+KXQWIAiYQ8OiGQNWJZm2S+fCQlaULZFH67UqczPFwrkKMZ+rg5ZFbGybVV41NTtNLV/kN+k0aM1m8Y6zSJu70q0XN17I=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 15:37:50 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 15:37:50 +0000
Date:   Thu, 19 Aug 2021 10:37:41 -0500
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
Subject: Re: [PATCH Part1 RFC v4 22/36] x86/sev: move MSR-based VMGEXITs for
 CPUID to helper
Message-ID: <20210819153741.h6yloeihz5vl6hvu@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-23-brijesh.singh@amd.com>
 <YR4oP+PDnmJbvfKR@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR4oP+PDnmJbvfKR@zn.tnic>
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Thu, 19 Aug 2021 15:37:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 544da971-01dc-4393-f114-08d963274d5c
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB50044C4DD51BFC21A1F285B995C09@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Dj60pRYMHXAcJ7zPoVDlCtITVcia4FXLz+HznzSR39Pi0Y5T+4X4qo+zVg/5ND0KHb1M42x4KffvqREVw9286t+0gcFvDdm58dys+G5YWHzoNLMkhKNrICpdj/6qW98KZdztg7unsomNYaE/caZo4M0rAXtbIqrL8oSHg4AVsAj5wVumtBkMGPqat4/NoSfmFMkO5hOEVU6oht2WYD9dlD6l+pr+FMWIPRMgbBDQ0BH8rXrQ0TcgNORHatahh+Aga5grK0XW2qJuLaSOqCZYmmGfnYVgzQ/Bq+QekVqQkBR1ctGVvBmjhgEemp6eK6ALnQeaKZ0EGPJ+6lHxrWZJIhGZx9OMRYuzDhqUgKRJnmlGvwZhECaXrlpGKsBBiaOn6b83fJrvSYAm+URzM8M25MoHVHEC7VCempoToG1yQWwpCvO/TtaHYPoKt6LcVPnGBSFps+jAs9wzA/CY0LlI/2wN46AEilQfIg/Z5udZDwjq53hirWiyzKv3j3MQOQkTLNM22oi1+Y7oMta6ky+/Pd6TCeaec1gvE4ici4TTL8SbEfXcLFy6W7DTmDjpPza/HT3Wya+Au+JR3rDsgyphkbzVK3uxJGsBmwEkPBhuolylTIJBgkrdJ38pYLjuyA6ZkBcnOqps6m7PfZG+oSruW58HZcu8s7xzZXrBiNjPfgZyRidpAKHQUBmCoeAZk8VHQgSoRbxiozhkB1dMtfyS7Zqx/WgqZSBa/0Q+UqpHEbEoU4SAmTyWwjqrfu8xRoHgTtoOIbAOf9k8ug8xbt7te/Xo4j3gc+HXj2zY2K+RhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(66556008)(6916009)(6666004)(6486002)(6496006)(45080400002)(66476007)(86362001)(38350700002)(956004)(5660300002)(186003)(66946007)(36756003)(26005)(38100700002)(2906002)(44832011)(316002)(7406005)(478600001)(83380400001)(54906003)(52116002)(2616005)(7416002)(8676002)(966005)(4326008)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mQSs5ufpPbr+a8+dvRbhIsPDUeuil3QDwONeqV5kHR19cO12+vqt0evSuWk?=
 =?us-ascii?Q?qrmNtw2C4SHK8LraQkz89/7JojQSx6bRTNhXvJwaTBHfrwqWRhYeYPTilu1p?=
 =?us-ascii?Q?wg3EaMh0ReaV1T4bPt45kpOQHdCWlX89OtjlKr0/I8w0RRxWi1hn2zGmDYpX?=
 =?us-ascii?Q?dn+J63X+GZa8qKVKhVccnOhOEkg+HBMpwln3PalIabF20OyAYs0r3CxEqX6w?=
 =?us-ascii?Q?tBUNKzqLV5QOdW6gtmjsdZ7dkDwdYRsza3gwAx6RXZeXVhyAb8YTWshRNQBb?=
 =?us-ascii?Q?ogwFsjO59TcROCA35E43rB8d/F+m9umPUgIrm8iExRCHayBHWuJmgwfAxlEq?=
 =?us-ascii?Q?qQeq16T+VHw7PNmzrZMCudQnMMrZjtZljP9rv/9CV/moDCvPpqdPrJM6w/e4?=
 =?us-ascii?Q?ws7oiXzqSWRIKOxkQqXnOA5lSd+HhFTqV2ULvrCdrW9IS3L/+pxDrGJfCIDk?=
 =?us-ascii?Q?b6zIYsv1Ydm3f7x2TYxw57+nJ40K37iALeMNGQwuu237TimWJ/zEsLNoXEjB?=
 =?us-ascii?Q?8k/lIfHh9mndCi7Ej5cy1/0wi/A/h8WNr5whI0JeVKn1a7BTqJt+Fmta2z2m?=
 =?us-ascii?Q?eOg17A3bAtsQzUqqEVwX2JEmINdZSiGJvQQJlxw+HWgMO+jRcgrIlZK/fPZo?=
 =?us-ascii?Q?6bPgfi0GB1jXWaHmT6Pgvh00dtX4FctBD0Zd228LRxSEIaOHfSb7Ya43pbrQ?=
 =?us-ascii?Q?snv4+fFwWmIEbYDRwLeHJ9L0TAAHhWF9PNY1jieoKRwCq/Q+AzE5nz6LuWTN?=
 =?us-ascii?Q?xVPDHFa+JnvWe4SvtR/vul+IECJ4YzqxH5a6QZQbUxqzgjyC63XDw4eGafA0?=
 =?us-ascii?Q?d+Uwg8OwMn0Atqy/UJslBoDVKnr7E0WbrvdP4MVdMQWYQ7qLRJD8W4Mo9H1b?=
 =?us-ascii?Q?WMLYP6Ufv4ToLG14mfbsbT6003ufA29MUz4N0ddJAHYgXclHrSfh1ISFtDqg?=
 =?us-ascii?Q?HDzXFaHlSFm3RD61CVi546T0QHI/Dp0DphL3F9PJdmHWsYfyokOuIEIGalif?=
 =?us-ascii?Q?kxPfWZC8QXtNRbm8x4yrVW+/LqcN40490sSdNTR6rGzsC/tdL6vHs8O5c71g?=
 =?us-ascii?Q?BeGGIMxEA+9D/Y56WxUWOGwFR+D7Wa7lUwWpA3Q6YW5A90VVLFApHfwlYlXj?=
 =?us-ascii?Q?ovMxScURAan3U/EmgxDwnu1mgB9lqHa6Z+Tsn0PlnBugM3pVfmo74MVSj8rm?=
 =?us-ascii?Q?6SoHhsTbgNue0qEEnFAsomRIldokrxUrtqJ/DdZwOWQ5RkecBddhv/SaSPn6?=
 =?us-ascii?Q?JvSYZK7hloUDY3erC38Q0dcAFbJCUnb2R2FUy/NqOVZXX7Jq97OAxzNUw9/w?=
 =?us-ascii?Q?umICeDBIhsonvPBsi4TTEHDs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544da971-01dc-4393-f114-08d963274d5c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 15:37:50.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmK4ivdZajmRDDf0sG+Gu7nw+pVj23pSZxGUMPz+zsUohWvrAjPUGUfp91iySFCBQa+UypJr0w3OMJQSzFOkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:45:35AM +0200, Borislav Petkov wrote:
> Finally drop this bouncing npmccallum at RH email address from the Cc
> list.
> 
> On Wed, Jul 07, 2021 at 01:14:52PM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > This code will also be used later for SEV-SNP-validated CPUID code in
> > some cases, so move it to a common helper.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > index be4025f14b4f..4884de256a49 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -184,6 +184,58 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
> >  	return ret;
> >  }
> >  
> > +static int sev_es_cpuid_msr_proto(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> 
> Since it is not only SEV-ES, then it should be prefixed with "sev_" like
> we do for the other such functions. I guess simply
> 
> 	sev_cpuid()
> 
> ?

That makes sense, but I think it helps in making sense of the security
aspects of the code to know that sev_cpuid() would be fetching cpuid
information from the hypervisor. "msr_proto" is meant to be an indicator
that it will be using the GHCB MSR protocol to do it, but maybe just
"_hyp" is enough to get the idea across? I use the convention elsewhere
in the series as well.

So sev_cpuid_hyp() maybe?

> 
> > +				  u32 *ecx, u32 *edx)
> > +{
> > +	u64 val;
> > +
> > +	if (eax) {
> 
> What's the protection for? Is it ever going to be called with NULL ptrs
> for the regs? That's not the case in this patchset at least...

In "enable SEV-SNP-validated CPUID in #VC handler", it does:

  sev_snp_cpuid() -> sev_snp_cpuid_hyp(),

which will call this with NULL e{a,b,c,d}x arguments in some cases. There
are enough call-sites in sev_snp_cpuid() that it seemed worthwhile to
add the guards so we wouldn't need to declare dummy variables for arguments.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C567fab11117b4072171508d962f6043a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637649631103094962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fg87GYa5RX5ea54IwYLzwXupt6VVyLM%2BkyMnGB3S0wQ%3D&amp;reserved=0
