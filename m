Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920DE3D0506
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 01:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhGTWaN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 18:30:13 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:24257
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232014AbhGTW3o (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 18:29:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKP6net69+u+F2uecVxUFhJ3LG222guGTvunsbGpq7C7EuAhcPAOv1Ol0ph6FxE2ZfDM6euVVdPjtj+dXFQb+LlzdMVIusixaK6BsJD1n6watU9HSj3C7i05O1J9azCcszAWhUYjJpaJ42eUzb5DNHtj3+18CM5XJNSU9t5e7sN2dYOTtrUvYc+n4w2LMXQXajw++43y22Iuyv0Ok5OBC1qD1l1gFwFKxdNFeYtBelNIgV+vnYWg6SRTF3Xyw89ijDSJ0QIg1S0L/To1z05Bk9PkHprsWfGBxal2uurb0gJ8XNBZebsYpmYHlPcFHOkZqFmImrtOVVzQWkG6RDSwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9oJ19Tn4Ab3jpYZCXCjUOBMj3nYYJUJ/CXDsm5/ljc=;
 b=X+n3IYcO8sOf7/tQisgdr5hg9xYuQC4UmoQ43hTf3RscVQW+ffBO0SxMPsbymdqsUH+GlynNByyQd6De3957jlWS49Ntrg3FYwc5+7Y0MFQDNTrQDZfmrzdbeFQVeG4p8IBIqEvKFOtkBwQZFYDaCijXj2jdR0SultEW9EAqrWr5Rs9TkYbhvpomBHjP/QgRi4UHAtcZth+wYo7urpDhfjPPyx7edQPUQ4wSj9WW2lmjgG4dijmNCZ2kcjyW5PiAgjgVg5dcEGQuiebzTJ/qFx1ah13kPq7JwXZe80dqGo5iFAXwKG32vnW516ald6PVId4X9H+1yS+FTfoGtmuc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9oJ19Tn4Ab3jpYZCXCjUOBMj3nYYJUJ/CXDsm5/ljc=;
 b=U/9FA5QOiLl8UxMeJm+VVNoHP0ZhVeA4iL2j6BNL0KNvGYaVSROLlYuZsFW6mWGAgxoFG8sY4otzEwCwIitD4QoNaSY1DH+lmfcuA9BClPONHeTP7zKxULFSFmIiCq7qU1QMs5bxZcku0lwsAuumZSBXeC76g88QyDUR5CF08jU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 23:10:19 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 23:10:19 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 05/40] x86/sev: Add RMP entry lookup helpers
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-6-brijesh.singh@amd.com> <YPCAZaROOHNskGlO@google.com>
 <437a5230-64fc-64ab-9378-612c34e1b641@amd.com>
 <39be0f79-e8e4-fd4a-5c4a-47731c61740d@amd.com> <YPdI4JLrJJdPxy7e@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e9d4bf1e-83cf-5290-0613-bf46e359432f@amd.com>
Date:   Tue, 20 Jul 2021 18:10:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPdI4JLrJJdPxy7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN1PR12CA0099.namprd12.prod.outlook.com (2603:10b6:802:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 23:10:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02d9f9c-b176-4688-d4e1-08d94bd38af9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2717D8A4D95BD004C85CF14CE5E29@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oGGOXvaj8Y3/epKD7VQ3wWbV44L7QQ81kdDR/y9PUtZm3LOtSqz0Ubp8Luxi12ffpfPo2KZR998A+mmo+w7fUUmqk4gmYgD7owMRqUngC6ifAjsE0EyyL11Bh3al61ATVuCN7p9ZcQsrLAtm+t2Mj/frkw/JYocN9ZU2QsbmBda7Iyp+fFtARXHAPD1fsMrcDASxQAixiC/JzQd47dTw/s8kn2t6G1bJqmL1cjbTm3YfubgELRdtDUkc6zx8+IQ1UgRNy/2LXhKalIw0Ed7TM70qlI3yytSGFz9000PfPTSyD22dP3tg7R9B/H9u/tuYTZrUFX8/7eC9+RJdtrf/zYBmZk7hE9/543vlpE+iCqC2tRBZqaIJnZMZzYijobl3/AZIzfVgIGxt0LRzF00VW7P2qGy15+7eINv+FiKHwq++3mYC1v0KeHa+MAP+xq13oSTQJZhvwhWqSO7RUn38LudkbYa336IVA8xNhlIV7j6FbKwepFBkxXJDc37W6etXIFT5Gp1iyj7raFSAokWlkZi/97yMB/T2kWqRU6IbHBzpIEc4jv+rF6/dpRp6s3dazviFvUedGl5D7SNgvwflVhr7kiZRvp3UWz9KszvCzPYR/ulOjh1B7nt7wcdkYKSLTbTX132FfVEwMsXsHS0FRRuRRs9oec1leB3X3v0ZuxndPd1pSspeu8JIKyOU7urIwW4ZMEPO2HHdrmJXfgISTJ4CdWF6RUqM3v7ODd+4x+x2Q3JPSIlA2zlYs1HsJn6TexKLXerbH9UEqrOgbGbFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(7416002)(6916009)(83380400001)(38100700002)(38350700002)(36756003)(8676002)(186003)(44832011)(31696002)(956004)(6512007)(6486002)(6506007)(86362001)(478600001)(53546011)(26005)(7406005)(2906002)(4326008)(66476007)(6666004)(66556008)(8936002)(31686004)(66946007)(316002)(52116002)(2616005)(5660300002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEo2dlVEWURXMVgrcXB6cS9CaUdlOWJFczJoWER2MXJaSXM3bC9sakRia2k2?=
 =?utf-8?B?M3ltUVgxZUxyRU5FYTlsVHBzalZlMWVyTW96R0JUc2dHM3R5MXJVM1RuTHl4?=
 =?utf-8?B?WE5YOEJDTEJFc2EvVWdEV09XRGhwODJMR05wZlZ2UEFFb3cybXpMbU5IUHE1?=
 =?utf-8?B?dzBNeXpUNVZhRndhTGhsSjFuRUs5YjR5Z1pYQUJmVWpYTnByb004MDdlVHVa?=
 =?utf-8?B?Z1dUMGd4Y3k5RXN5VnE1VjFwRnR3WHJ0RUh4T3pDSmtVTFdocUM0bUtsSzBZ?=
 =?utf-8?B?Wk5GNTd0QnhXekszV01XRkk4YW1CaURXb292TEhmS2xlZi9ja09wR2ZhU1Rp?=
 =?utf-8?B?MVdKSFdIK2Y2L1dzZFUzeTJpNFJYZ005anN5TnEzUUthQzhMcDRvNzVCc1Y5?=
 =?utf-8?B?UFhCYzhDQkR1NWlFanp6UUdGWWdEMEFHMXBvTFNhNWFxaEdkMGVrRGtWMllm?=
 =?utf-8?B?RWh5WXJUWDRlQVU5VVFiUElOSXFZSjE0NW1wdDBrQWhFNk5UUkl1TWc5YVo5?=
 =?utf-8?B?VVNqUXl6NURFcXpaR0xndlRSMk9vcC81d1FhQWZuTU5kNnY0cnZkTlBvazR4?=
 =?utf-8?B?WndmVkltbHUvVG1pMDIxWUpMYkZwQjEwSmw2TWg2N3N1UW5KdTQ1c1EvVmtt?=
 =?utf-8?B?TWpsS3c3SndOR1FaczBJVTg1UU5nMWw5REJubUp4SVRUSEltdHBNQ21PMVNY?=
 =?utf-8?B?MS96RVF6d21vTWFob2ZNcFRNa2VCdnRXNk5NcEpma2FTbkVlbGRFcDVUbmVB?=
 =?utf-8?B?Qmg0WFV5UGVFTFNGemoyZGVQMW4zNEpYaldhODd6WGEyTGNJa2dEUlErdUc0?=
 =?utf-8?B?N2ZydnhmM05xSUpBUkN5UkVDVUVRUlR5VDV5azNJKzhOQ0JBbGVhbUU5SXgv?=
 =?utf-8?B?QVhWL3dhdUxjUisvOSt6Qzg3Ymlzdm9tRHVySFhyc3dVOGtUaEtlNE93NEo0?=
 =?utf-8?B?WVl5TkFtam81eGNOdzloRU5YandVTDN2Q3BpREw4NlpoV3VHNWR3dGx0bUNI?=
 =?utf-8?B?blRJbWN5emVlNHVpdU04bnNpU2VjZkRRWmxMTUJmV2QxakdZeTFBWEtlaXVK?=
 =?utf-8?B?Ym5HZW1zd0d6TExGOTNYd3J0MzNqU1luN3llMXBRdjh2RUkyS09uenduNFdv?=
 =?utf-8?B?QlE4cVg3WXhqcmpYUWpOK2ZwV2thc1BkMHc3MU5VT2k2NEdpUGNFaFF3d2la?=
 =?utf-8?B?WXQ3dTkxRkgrenJORXdtc1o3ZWw1M1k2cXNLOWhhQlJnNGY0cmlsTVp3RkI1?=
 =?utf-8?B?Y1hBYWZMemd2QWtrMzJWTWdIZEU4c0FUWnlVSm5xUDlNT0hobytnWGpPM1BO?=
 =?utf-8?B?dXZaMXhpVi9sQkxSbTJxS3ZaWjY1L0gwQ05PaW5sWmV5OUl1enFneEcycG12?=
 =?utf-8?B?dmFiOUxjQ09WTmxMc200dTZkeTNWNWxiTE9Ub1BPV1pjNDRGcGpMakd2N0hm?=
 =?utf-8?B?SXJWb0s0ZE05ekhpeEJDNlRqbk9MUmdNbGVZeEMxUU1Qa0I5dFg5Z0h4dTlW?=
 =?utf-8?B?QUZraENTckdnV1llR1dlUnZQU3dQbklTciszQkZVV3NaVzJVVDlUd3p0WEJ1?=
 =?utf-8?B?NEtyZEZObnhucEw5dU9NV0xHV1NvOWI4bnc0MytOdzJMcURVME9WaklEaUEx?=
 =?utf-8?B?SWt5bWlwNktadDNPcE93RUFuVDNZNHBQa0xPOGh6Ny9aOWhqdFlHKzB4bTI3?=
 =?utf-8?B?b2FPc05xMjRITWZaSm9PZDdxbjh3MXBXVXZYYUFQMUJrMDJaSTMzVWhlSE5C?=
 =?utf-8?Q?675M9Ieaqq/lawywc9xoO0A4ANtllZ6j537FLFA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02d9f9c-b176-4688-d4e1-08d94bd38af9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 23:10:19.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiWBjpY6JxWM4YLQVtayoQztWtEllf1/VGzqytiXPtLXMLrwGPDzs9NYrdDgfQIi9unrmGs80RSSHTjQohlhuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/20/21 5:06 PM, Sean Christopherson wrote:
> On Fri, Jul 16, 2021, Brijesh Singh wrote:
>> On 7/15/21 2:28 PM, Brijesh Singh wrote:
>>>> Looking at the future patches, dump_rmpentry() is the only power user,
>>>> e.g.  everything else mostly looks at "assigned" and "level" (and one
>>>> ratelimited warn on "validated" in snp_make_page_shared(), but I suspect
>>>> that particular check can and should be dropped).
>>> Yes, we need "assigned" and "level" and other entries are mainly for
>>> the debug purposes.
>>>
>> For the debug purposes, we would like to dump additional RMP entries. If
>> we go with your proposed function then how do we get those information
>> in the dump_rmpentry()?
> As suggested below, move dump_rmpentry() into sev.c so that it can use the
> microarchitectural version.  For debug, I'm pretty that's what we'll want anyways,
> e.g. dump the raw value along with the meaning of various bits.


Based on other feedbacks, I am not sure if we need to dump the RMP
entry;  In other feedback we agreed to unmap the pages from the direct
map while adding them in the RMP table, so, if anyone attempts to access
those pages they will now get the page-not-present instead of the RMP
violation.

thanks



