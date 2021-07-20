Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2C3D05E0
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 01:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhGTXMn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 19:12:43 -0400
Received: from mail-dm6nam08on2088.outbound.protection.outlook.com ([40.107.102.88]:44033
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230383AbhGTXMl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 19:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWxDjh4Iw71yKXfGq79L0FCdVGIOAmWFLy9AB5h6TjjlJNEWt7GaoDlm9JHFZzCJOzlNHxXWvoc82kP0NPUuG8DuACQtefUuSk+LGpPaqiqdr9DqEQaOJ/Yya8cuB8F9/lWYTUMXlBnThDxwLRoahmon/kOjZHvsCUT1Ly6mj9TLVK9rmAOsuph7Ar2W3FfVEKFDL9REqStm+fN7v8d6WLLYmrMB5kXlNsJYkSpYU7J7GyGzAlC9AEHXjXcB1mXivkNRb5OBidFOlbuU8LdBDvgl7+Bw0hTTj1Ia3JKSHS4hz7WMfUuhRLwRhzuvxhyQ89ECTiVDbSMipnIQJPK6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqi6hA6GlWZwmb6PE6UCZHsbIuCwg84vAs6NM+hJDtY=;
 b=BbVe7pD8nMdwqon5JyY4XonA50WfWad52cYD48TO5DGY6rPTpTPn7uGRPkFLvjBW8hTUHGc6sm/xEWvvacF1Jd7havsSkoMtR3OvhkH6dlSUHMTW61pqVh+tM+Jpz6scgcPr0cZz9oH/knqjZA6kusOtHXksm+mTburVkFLYNog0Amou1twJFpDXZSkGHnfGqHISb6Hr8xNpUuv/GjPHH9bk0lf9mGaWNwQ1SGa3pw5kxXYLQtNj/9jZzYlGFDB5HE1bE4ytcMm4rAl/rip3voHdf0f5EfgSGq2cjGnu7/1YjjNTaxEHicpGhCbpsfR1H00sRXXrcLmxwHlcKLAFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqi6hA6GlWZwmb6PE6UCZHsbIuCwg84vAs6NM+hJDtY=;
 b=T4JgpmwepzFZwxAieQLGdB77nOcB4yhAsbK0mGzrypAYFoiaze4Dm1QdWFZ706ZKTvO9bLmUoiga70XQuiwiyFnz+EEBAZOJkjuCgnMmnvQTIxDPG3QOPLWRuEWrRLfYFxWg6lmpu7yA1xOe6ZE3kYIq2QQqBXYtUcbeMDfTgXg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 23:53:16 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 23:53:16 +0000
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
Subject: Re: [PATCH Part2 RFC v4 37/40] KVM: SVM: Add support to handle the
 RMP nested page fault
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-38-brijesh.singh@amd.com> <YPYUe8hAz5/c7IW9@google.com>
 <bff43050-aed7-011c-89e5-9899bd1df414@amd.com> <YPdOxrIA6o3uymq2@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <03f42d61-fa32-38d0-7e14-17ee6f1d7dad@amd.com>
Date:   Tue, 20 Jul 2021 18:53:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPdOxrIA6o3uymq2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0401CA0017.namprd04.prod.outlook.com
 (2603:10b6:803:21::27) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0401CA0017.namprd04.prod.outlook.com (2603:10b6:803:21::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 23:53:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d48b269-5d7b-4081-d29c-08d94bd98b02
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB442920155B664A09A39B14CAE5E29@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkeSHZke28T/JiMe8jL9jrAV30wag/2p7EmP9gNQrAe4eSpmJoNCupAG2sNcTcEMTO8W6okg8dOeLFrjIdiH4ly1DA8EEX8//KzQXdntMmJH4blGQw8yK94M1Rso+cNWw1BSXk1TgCoRLDf9DMqC/M08wYTbNXRafWMvdDGhb5oqvKXSmGnLYc+i3LOJlEadM/Kbg8BKYRZoMZRJ1WZderLlPR/nJ1avNkgRV1CMfRDpqE1cPJjd6npOsnUN6iaT44bwCj/jk7scqUcis/Tn31LuOHAjgkzD4YYQMCUdlATvjFxby4CX4zUMv0yzz7t7lbQlCM2GW8od+4lAY5wb0W7nhCwYw6VMnB+4FW/r2UKa+kQe5gHMLSbjDbAh/xddDKuYYRBY14fjD2MLu6DjyvuMLCDMzN+H65WL/AyhAaSzJ7EYzwZpqtfsDWiiSX0smCsvAr7IuPrn387VPMvqPHpl8Ks+jbmdK1Ld2n/L65dc3mybYRwqBR1pW3nB1I5WvJjt2Kf9zgl8hdBCeG8Mk2Pqb3yWfPWh1CnPkXm9iuue8kKfV/mzy0pB2Ic6Mv2S6x9y2Fu6vy5kbl78Sxzpi2T4J7LkGVOOEXf51A3vBls4vApjWNT4j+L8g8PcbPZUmDWtCR6W5nYiChg5Fg7d4VLmCp5tQTWD+FzRMVGAViGhrBIyEfuNeqMe+zINZLnunTj4dQ3OQvbQr2ml8wjjpVZ77zEPt04ZUfivdXsPLBmf/y9gcN8dO37YepWqTQRmg244eFcQRyxFrKh9R07hyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(376002)(136003)(396003)(31686004)(31696002)(6486002)(5660300002)(316002)(86362001)(478600001)(6512007)(36756003)(83380400001)(52116002)(53546011)(956004)(8676002)(44832011)(7406005)(6506007)(8936002)(2906002)(2616005)(54906003)(6916009)(4326008)(66556008)(66476007)(38100700002)(7416002)(186003)(26005)(38350700002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnVmcTBOUlFwRkdMWG1iTGdSOGtXS1Z0T0dqMVNFaVZQWjdPSlluQlJkbDBa?=
 =?utf-8?B?eExyQWZTTTVPNmNVOU9IUXBMcU5uU2FuK2NscllTMEN5V2o3TWRRYjJEWnpV?=
 =?utf-8?B?bGxSTThNQU9Tc0FPcld2dzMxL2pDRXdvbTNKVzlsS2FEVFEva1dPQ0djV2g0?=
 =?utf-8?B?MTZ6TGYwdzd5RXFxNFFqTUFEY2RoNHpTL0pYNmtLaG8wMGw5UnNUVDM0Rmpn?=
 =?utf-8?B?aTE5cjNBNzRjTEQ0Q1A2eGt3RXRqdG4wYjZYWUFhUzJsbkRJbEtGWEhUdkow?=
 =?utf-8?B?Y2N5WmE5QkdnT1RFbnlrVUQrS2Y4WVRiUlovRjRQTXlpWk1CQ3NmdWFjV1Zt?=
 =?utf-8?B?dUdiWVFWNjRjbUJ6bnN1U2VwWmp1VG9FaVpkN0M4Z0ExSitNaHZETTZkWllk?=
 =?utf-8?B?bUl3WXNseHZpVUdVdzRiMXQ3VXJOZkF1UitRQzRRV2dwb0lBalhnNndoRXFm?=
 =?utf-8?B?UUFiK1hJbkxhVndla2kzVmJQWXQ0Z1pudUF3bGJLV1I3Z0NZc2NqM3NYQ0RP?=
 =?utf-8?B?MTUzYWI2Yk10Zk1FaTNLeFNGcTh5V216L1hOR2tadDJZM05vVE9mem9iZXdu?=
 =?utf-8?B?S1dWWE5RRk8vUzlBNXRNUWdCMXh3RjNiM0c1c2dMWTA3NkVoYU1PeVlwR1F5?=
 =?utf-8?B?L296VlN2RWliV29PWUN6N3NCMVpIVWlacS9SaU8yRTBaRUVYN2RhQnR1Y2RT?=
 =?utf-8?B?NThPblc2dEZDSU4rOWJFWXZqN1pqYkpxSkRrcysrNlpFb3BuNTFNcjd6WS9j?=
 =?utf-8?B?V1JSZmZtODFjb0tkLzhPa2JXUEZjWmVvUDRlQ0o1Z3JTa1AvdzZ1N1c1enhh?=
 =?utf-8?B?SHNRcTE3NDk3Sk1TTWZzOUU4dEFtSkIrdHZWOGdpOHFhejlBT1VwYjhoUU5h?=
 =?utf-8?B?K21YUEkxZVVZcE1RTmdLaUlJaE05dkRia2tsYkRtU1RqMEw0UzVnNTFpRnVR?=
 =?utf-8?B?enVDLy9VZFh4bDhhWnJkUlhrZzg5N0N3Z1Q2bU9HdjE1YnZ5TnQyZDB5SXJi?=
 =?utf-8?B?UG13b1FhTTk1alpIOWZBWmt1SHF5TXBUYmJYbE9sTmsrUitIZjFoeCtGZDg3?=
 =?utf-8?B?cEdsNFdnUmVHdy9yWkZ1QS8vT0lmRUg4cnJYV1ZIbytmYmt2UmVCY3ZTNU52?=
 =?utf-8?B?QlNGdzBYVUZvT0xWVEtOUDdPVXdlQ292UlMrOTlsSEZKeGdXV3A3RGZxbVZk?=
 =?utf-8?B?V21XSWdQMm1YVmJDS3dsRjh1SFdDWWw1eGkzSTdCZ2hDemp2Q05kenVSeEcy?=
 =?utf-8?B?Z1lsaVZUem1EUEc0VlNpUm4yYWhGZVFla0o0emdzekdBcE9jRDJqRGVDRkUr?=
 =?utf-8?B?OHo5VzU2U2lPVmhQVVVmcSt4eiswRGw1VXBrV3hmcWdaZmZaVllZTnUwUXdr?=
 =?utf-8?B?U1gzUGpvK21FaDZ5M1JqVXViRi84ckF3WnQ4OXlGUGxYWjZRTTFEVjE5cmtn?=
 =?utf-8?B?SitObk0zVjdlWWdQN2kyNVdlc1JGQkpNc2RFVFc4YTVRWWNTTkxEbVBOcEQv?=
 =?utf-8?B?UE85MDdJeU1Cb3RES1ZsT3cyVG8zY3RGMUZhT3E2L2N0Q2xwY0JsNmFmTE5i?=
 =?utf-8?B?QlNZUFJDOWdmMzVveG9uc2ttTEhublhLTFRITk1aS01YanVyVXU3YjhxOXhN?=
 =?utf-8?B?cU9tUnd4R0k5WFJpTjhIVXJKamZhZ3BjeG9rTUJ5eURtWldreXRTWXhwaDdD?=
 =?utf-8?B?SVpYaG9wU0JmRVp5NUtlYUVmbVlab2xLSkRMeUQxU3cxWVNOUGJNeFRNSGU2?=
 =?utf-8?Q?HxE/bqraLur73U6/qXsInEuFkA2gnTgJDspekSc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48b269-5d7b-4081-d29c-08d94bd98b02
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 23:53:16.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0yeGJrey17HwB8FpCVX9TOMejUmuyN/cDASnqqN2yqXS3lHx0k6jMkEJGSB+wfX4c9FGFJwi2IIKqeZ3145uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/20/21 5:31 PM, Sean Christopherson wrote:
...
>> This is a good question, the GHCB spec does not enforce that a guest *must*
>> use page state. If the page state changes is not done by the guest then it
>> will cause #NPF and its up to the hypervisor to decide on what it wants to
>> do.
> Drat.  Is there any hope of pushing through a GHCB change to require the guest
> to use PSC?

Well, I am not sure if we can push it through GHCB. Other hypervisor
also need to agree to it. We need to define them some architectural way
for hypervisor to detect the violation and notify guest about it.


>>> It would simplify KVM (albeit not much of a simplificiation) and would also
>>> make debugging easier since transitions would require an explicit guest
>>> request and guest bugs would result in errors instead of random
>>> corruption/weirdness.
>> I am good with enforcing this from the KVM. But the question is, what fault
>> we should inject in the guest when KVM detects that guest has issued the
>> page state change.
> Injecting a fault, at least from KVM, isn't an option since there's no architectural
> behavior we can leverage.  E.g. a guest that isn't enlightened enough to properly
> use PSC isn't going to do anything useful with a #MC or #VC.
>
> Sadly, as is I think our only options are to either automatically convert RMP
> entries as need, or to punt the exit to userspace.  Maybe we could do both, e.g.
> have a module param to control the behavior?  The problem with punting to userspace
> is that KVM would also need a way for userspace to fix the issue, otherwise we're
> just taking longer to kill the guest :-/
>
I think we should automatically convert the RMP entries at time, its
possible that non Linux guest may access the page without going through
the PSC.

thanks

