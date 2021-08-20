Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260BC3F2551
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 05:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhHTDaS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 23:30:18 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:9312
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238210AbhHTDaR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 23:30:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKzkWn7e21bYs7sznyKHYKJiEmQerUUFv2+s3rwuiOhIwXDP+p851C3Yhv7xbRLLWZ/vAjjhtvlY1UyXFO2EWbg4l2ODgbovSy6jHCgtZoAunFukj4se7O1eXOnWvfFRT30bOFpwPidTGc3rjhzRxjR/KsELJ8eSs/z3ooAAoKh5kOsPQ4euh/by9/jWQ9Oeksbea88anYvnok1PrcPkuio08AprBzi3c18AZli2E+8neovpRftlcp1g66I3PF/zIjMcp0LqdvkfUEXDYQC34JsAvIZbisVxNFnHKP2JG8Avj/9tfnbWEB24q72c8c23jpbyXYxW8WT6749uHBVuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXUPqze+r+yg/gdTEKBolBIBQCuJcQGrjS4gBt9oHBw=;
 b=c2EZSz18hKkSu96xwdtVh6nZEQYO1l40Vcf6VSSo9ZWxbXkT/y5eboeEx2jGIkVut9K6PnYiu7WRvIPNidraThQ+EjaiTv34bbSyU+lPNaZoy6zxQ8zJjwDxbyhdCaOVK7GySHu3iiUdrX/Z+uqpYdboWHm6w2EaPzI/MpzBFqCVPaSF5Kno9GcPkshwd4Uq37Q2teMPkuwjycS1sM7RQjd2q52zaQE6A9a5R32Jbn9PN9vSvwv41M0v/v7GwoczQeEMxa2187PjMA+zU4nwDonKmFHdFyRbTwt+hgpAo4LFTtw1m3JTXskKlt7IaE3TXDakhcedP6GeXhnQWFAglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXUPqze+r+yg/gdTEKBolBIBQCuJcQGrjS4gBt9oHBw=;
 b=Ena1QRYMb8Jfl70HoNr0udUaAGCZ+m9duEkCTwiUpoWxqFKmX6l+tXOrfZW147M601xJLSwwWP7BXyB51cNahBwz8yGPgDIynvsNC2Okj8NHrTzDVNv5ZHuYoi8XcEWCpAEwnJps3uITuM1FOq4APAZnx19tuDl3ojyHeD9Ty5A=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4005.namprd12.prod.outlook.com (2603:10b6:610:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 03:29:38 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 03:29:38 +0000
Date:   Thu, 19 Aug 2021 22:29:08 -0500
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
Message-ID: <20210820032908.vqnptvjqnp7xxa6i@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-23-brijesh.singh@amd.com>
 <YR4oP+PDnmJbvfKR@zn.tnic>
 <20210819153741.h6yloeihz5vl6hvu@amd.com>
 <YR6K+BzCB9Tokw85@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR6K+BzCB9Tokw85@zn.tnic>
X-ClientProxiedBy: SN7PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:806:f2::21) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN7PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:f2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 03:29:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f45aa21-4942-47c4-cf5e-08d9638abcfa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4005F031409829FD4165592A95C19@CH2PR12MB4005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ9bAn8nniJgZcMM5XaZrH16TKMcYcqKCrhx1I2g9godVrW3EuGoQ+BqZFJAuLfIMDntdLCXCTJAWStUN1pxRbU3vPafuD9mQwr7GQyRJAbCauY+tdFSntQcoGXZW2aboPzgmA6NBoOLiPjS5N7VQL8UvxvqgzbuVZvXonnW+/SgSqNy/eqvwilWCbMpVyPRtAQGT5FCEfmROuVWDpG5LFNvfUyFFG0EYI1KkJkkRy6cclfTG6epnzVBt1/O9rDz22CF8KV5HQztyw2fr29XjUwqC//uQr0DBNU/pKT+FIeMF2WgR+esh+HoGfkCtQsMyInDN/mwVeIMRu/owHHG5+9yzOGbWCF8mFZ7vOpBnqoYH7b5KNVQlAmD1XP6E2jGj6M8qchrOybc6tMOpe1mHt3jquiuYNz6bvpavStjBydpfFeU71Ua+ZKtysdaGpVMyYF9eSV5tteTUtSUrIVjWmTyzjfRIC8cpfwbc+Wp/yoftGgTWbaU6NQEzfy4G1NfwvDE+L35eEaQQ2G7kM3pY6wYFy0OGIaKpyGD5mzpLBuxwiaH0/RlmqwDMUHOLOgo+UsnNH7ZIm2cZftDLVRMSHP3AK4VphDK3x8dswLvgoPlDQM4vJn7wQq9PfCP+zW5bTlHzSJ7Wf52FoLJxYTFoNfKH2CuAi9mNRG5Q+plAJWqkwTzPLGdqEI0iNju7ffQ2ydKpYOyxqjVg+sSPyJrP0+FuxHdLYA+7M1lhQNV25WXSluErveaqJAcltcio+VZMSAVGaE/zLJCPljC1ngcJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(4326008)(54906003)(83380400001)(5660300002)(966005)(36756003)(45080400002)(186003)(66476007)(52116002)(1076003)(6486002)(6496006)(66946007)(478600001)(6666004)(66556008)(26005)(7406005)(8936002)(6916009)(7416002)(8676002)(2616005)(956004)(38350700002)(44832011)(38100700002)(2906002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiJszZvVpN9M72CUZsLRBlNJ9pkYpUeWZ9BhzyGi7hAQ/+9/x/8iqYp48H7S?=
 =?us-ascii?Q?oZxEVj6WhK9beFKKxZYMzpNO+dnx9HygVjUZI31YPcOjkhVIzwwZSfk6ZS/Z?=
 =?us-ascii?Q?QUxg20J5lsX8K1nE8rMykXsbaAACMm0/T9HiTrZTR/5w5CaoAfrK7TYHxEw8?=
 =?us-ascii?Q?Y8MHZIZoTjJbYRfcs2Y4djAv8/efeP3EtfVPe3peAQteAKtYfyx4eLie3h/o?=
 =?us-ascii?Q?PKpYNJ3JOcPBJJxG61gJJgoTR0Y4jM1KLp1lTW3XXCYCcSjfYmcFVOpAn4wX?=
 =?us-ascii?Q?FrT4VFmRNuyltVfH3W+9FVFPMybsVU54Z9KuTkA/PS1hs/aFOEg2iecm6PEM?=
 =?us-ascii?Q?ISIg+YLjZGd+YgCUF9Ek7Y+UML9L5xEUq56AU8WhTsf7NalM6SrP2tuq55FS?=
 =?us-ascii?Q?zSjFjzu3HqbilgHZ7TuBgJGZg6EMqitu9TD32BW1+5YRYxNfAJ8Q+IZtgak3?=
 =?us-ascii?Q?m3U5YIGrDld+L4yb0i6oIiikAAub6drVgySr7MtDLMzPkdVtnb01BDwYkf2G?=
 =?us-ascii?Q?EUhkhTiORKSk1TVcGAK27KpJDYcdMPBERjuONaZ+SSvNLJvBjehNL8/MQv3c?=
 =?us-ascii?Q?5CACuIwifodLzugik6LOxoy55FPVAKmd8MQ0qRbvHYlAGH7aBQJx0MoWaXFZ?=
 =?us-ascii?Q?4fPNNg75pEyLH1xsKjl6W+AVcj41mze+bKGPFTl8ggZSYZ9EACJBNmcp9Zxz?=
 =?us-ascii?Q?Vbxeso+wQ3+WsckvBRmIBANd58ni5FaJ+EZEJ1rfSTWJfgdfB7xPi1q6l/JR?=
 =?us-ascii?Q?5lX7V7kRqnO8zvfY3qadalHRfnX9AzbwFFl7w7wL8zyXiH0uxaic7LrRJQIz?=
 =?us-ascii?Q?24fB/CQjHSiVGO0xPcs1K640GU07eruqu5aKx1sE0OPkMEHHqv2zPQ/BLTR/?=
 =?us-ascii?Q?bESUvx2Wf6yV6Og3Ux9yFCtueoth50LnXzUFeHZ+gCn3xj0N3wLM4MgyciPD?=
 =?us-ascii?Q?GH84y22rywlCgXdfYJNlyXw7fYEqvwQ640lNk7ojWJdbRBtNmvObgbVYmmkZ?=
 =?us-ascii?Q?XnKVLbjOpLvo6xyTAC7Ruv2hKzcYTnBcV0Fe6wgcIu4uKicDWia0OS6Emuex?=
 =?us-ascii?Q?F+XNDGb+H+t7e9Xyv1QEK+5NxqqgMHg15C/egFb07lqSEw/6QvGt/lwSlAn9?=
 =?us-ascii?Q?DYmLTeUIVhouQtsjT6fXkeb68WNvuc72iFfcPfcul4TdqRoDsP3HxOOfushh?=
 =?us-ascii?Q?7smwqtx5OU9oLWe3rI2GpX3UzsDgLPyhxtaE7OMRb9SB60+LerBhOdPehTDZ?=
 =?us-ascii?Q?+VAum/8Ep9kRRdNeuUN8L3SBrENPxV8lcroFzZu3hfhwI7HHh4nh6jL444Ia?=
 =?us-ascii?Q?7JoAwBxKvMDXabZ8iufkyy7h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f45aa21-4942-47c4-cf5e-08d9638abcfa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 03:29:37.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZ1JOVSa3Dzhx38JBWPw8lzWncJuwBbXwJleOXaaha5vmNHbgInbbAtKM+SQr++ZnyWhIGG8Sjo3P4JEyR9JsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4005
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 06:46:48PM +0200, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 10:37:41AM -0500, Michael Roth wrote:
> > That makes sense, but I think it helps in making sense of the security
> > aspects of the code to know that sev_cpuid() would be fetching cpuid
> > information from the hypervisor.
> 
> Why is it important for the callers to know where do we fetch the CPUID
> info from?

The select cases where we still fetch CPUID values from hypervisor in
SNP need careful consideration, so for the purposes of auditing the code
for security, or just noticing things in patches, I think it's important
to make it clear what is the "normal" SNP case (not trusting hypervisor
CPUID values) and what are exceptional cases (getting select values from
hypervisor). If something got added in the future, I think something
like:

  +sev_cpuid_hv(0x8000001f, ...)

would be more likely to raise eyebrows and get more scrutiny than:

  +sev_cpuid(0x8000001f, ...)

where it might get lost in the noise or mistaken as similar to
sev_snp_cpuid().

Maybe a bit contrived, and probably not a big deal in practice, but
conveying the source it in the naming does seem at least seem slightly
better than not doing so.

> 
> > "msr_proto" is meant to be an indicator that it will be using the GHCB
> > MSR protocol to do it, but maybe just "_hyp" is enough to get the idea
> > across? I use the convention elsewhere in the series as well.
> >
> > So sev_cpuid_hyp() maybe?
> 
> sev_cpuid_hv() pls. We abbreviate the hypervisor as HV usually.

Ah yes, much nicer. I've gone with this for v5 and adopted the
convention in the rest of the code.

> 
> > In "enable SEV-SNP-validated CPUID in #VC handler", it does:
> >
> >   sev_snp_cpuid() -> sev_snp_cpuid_hyp(),
> >
> > which will call this with NULL e{a,b,c,d}x arguments in some cases. There
> > are enough call-sites in sev_snp_cpuid() that it seemed worthwhile to
> > add the guards so we wouldn't need to declare dummy variables for arguments.
> 
> Yah, saw that in the later patches.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C6e23d0d9be7a4125d70008d96330de54%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637649883863838712%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HaRdEA0P4%2FGzmTXYyVYhGCnDaQHR8rbJqf%2B0xTBPSt0%3D&amp;reserved=0
