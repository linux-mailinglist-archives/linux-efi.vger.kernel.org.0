Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2603E83BD
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhHJTbN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 15:31:13 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:30720
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231143AbhHJTbM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 15:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrBVr4Dfk7xdOaBcdMzTsucfUZEwjNar2FApXMbOki289lvbtSW7QLXWU/k1IXHQ0PMcJ/nv6xg5zvFXvqklOusoEhj48KMmiIazkej9unv55EZHAAikP0DDM/fxNQHEkFcd+xxxnBZJz/MvbIq10djTpWArY+COyjnMJfsFSsn7QXvlAWDCr1QyqJ9fuoPtJbqUJV0bEq6FzQeJa0vHRmYz1+d1AIr3Uw/COnjQV79hHFuL39XIz7Tj774asYHucejpukSjfNtnPpbi6IiNA9umGxibTeCXwvNKfGjXKE2ibMV+nKQMVgahMnkEqVJ37CXQ0AR7IvbhKtPqVPXpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/vwKdo7nCnvZ3Sigjv3Oe8WfrMUkLmaHShADKEGHNI=;
 b=Opr+AdQAqWXZORtI/Ynl7At41H+VXOLteFGA1PILK2VUQD1WKxg+cQPQPi+j71clIkZLU7H78Lo36pUyGTGy0P0kR9Fc2w7cJzrtYazb+sJZ0Bk5thlr13csDVP6YEuInH8Ub0iwJ5mV31sg3GjohTL5RfkHHYufet0C+FkU56iCFQrhP861lUg5s1KM1AUOqKeQmGZO2XRq+4rb80Hea1DudGdxMCFySBPHD+i4sw9nOQiFQS6iPf5q/amjPe5hqagRAuPOI4uxpNHDVZNy8ob0OtyeUhj/jX9VP0iq4ABXSytQ6xglMuqMXNz4fCrkDageSjwWRD0RtQXBlgrt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/vwKdo7nCnvZ3Sigjv3Oe8WfrMUkLmaHShADKEGHNI=;
 b=Mow5tRojVWp2Ey1cWPIRhlriW4A4uPq0PsMA3JAIPxytbgS59RdXoVeMT4VrWO788XlpF3NSsdlNeuQADmSHR8qv1uvIJ4NKSCpQKIYWYgKwK1BbJTTeEmJ2D90B6OKhhgWkVlySUMZ9uuFO7Gh7gZFsDMNqBuB+Hs1z6Kc/tHM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 19:30:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 19:30:48 +0000
Subject: Re: [PATCH Part1 RFC v4 05/36] x86/sev: Define the Linux specific
 guest termination reasons
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-6-brijesh.singh@amd.com> <YRJkDhcbUi9xQemM@zn.tnic>
 <955b4f50-5a7b-8c60-d31e-864bc29638f5@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <65c53556-94e1-b372-7fb1-64bb78c7ae15@amd.com>
Date:   Tue, 10 Aug 2021 14:30:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <955b4f50-5a7b-8c60-d31e-864bc29638f5@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:806:126::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN7PR04CA0187.namprd04.prod.outlook.com (2603:10b6:806:126::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Tue, 10 Aug 2021 19:30:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a5b3df5-c635-4cf4-b4bf-08d95c355adf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5215551D1B342E17626837AEECF79@DM4PR12MB5215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJDBEl1zdL6D0eKFCgs7IFWXtDaMHYAauz6YJItuMPJ5h8at/Ybkk35b47tF7NretVcDhA7NgJHsIRbX/MuiJdacSOO1RMNwpKq7PFCUlM1PEQjYlEFD04BY7Pcm8MAWABwL+7ll1okDYIJ+hzNC5ZkNak6vL8GGEtsmJB6M5WTJ5vRypi5+rC2DBbAX8Fr//b98j6uMFX7aeGS4BOqziNDpvJ5dTZXHLU4mWGWgfOGvNlp0AyUvVsRTeqgfzsOcXwq70Vc0eLu3XFqOwDnGnKx41yY79bsLgUTs8nMJOgmghow+0ypdAhjJTyfgyjJonZ1k4iW0FjgeLxQKGnHi4CiOUhgWE70Fg+NLFJ25qiamxBnNlMs/rX/ZUGpR9ZWb7sHAbgnw6RCth2hEjYGtN6VGuWAjvK+JRg+nIwmPO/Hq7i3SkEBPc2+6kiD+FTbfO+5eApONzZl3o/mhqYfFOpAtvmSHTWE5YIPTQ4JK8V5S/R001zq8rYX8qUsx7ex7MWyXV3dKimOUJJfQu4F8C7RNVKLpQslTltMUJl3DyaOsFm2L5qNXpWOTGLsvCuJuakFEoayfAhxAYco/elsfkWH+x5uobma3ZtWwDZqqntD1H1qywdPmgIdBe8m2gFD17Qx6igxfguypUtMrCYllEDWieqSQZGwGvfFOAO62vLF13/1taqUnQgjjGrszeTCu5p2P6A2aRZFilvG4yzZC3mLkP6VmkhC31R15ChDWXA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(31686004)(8676002)(956004)(6486002)(5660300002)(36756003)(7406005)(7416002)(53546011)(66556008)(110136005)(66476007)(66946007)(16576012)(4744005)(38100700002)(2906002)(54906003)(508600001)(86362001)(31696002)(316002)(8936002)(2616005)(83380400001)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NElpMDFvM0ZqYXVjVEhUWEN6RmpBUy8yMURQaWlyN3M3UzlhbGNvVk5GSHJl?=
 =?utf-8?B?TEdQYWFBa05nRWhiazBiKzlZQktZODU2VzdWNlhWTnBhMUZVQU54bWdXZlYw?=
 =?utf-8?B?TytFczZxaHNsRU9ZVFB4VVVrUWlISjBQRUFHS24wRk05ck1NOFFEWW9nN2Ur?=
 =?utf-8?B?SnM0eDFENVVKRDdxSDVablZIb2FyL3BBZ09vSjEzcXRnN3VzRG4wNFdhcEh6?=
 =?utf-8?B?WURZbURDZHd1WHEzODhrUEU3bjRzZ0kxY0dycUR6TS9qRkNRVDU5OUJxemRW?=
 =?utf-8?B?bytLRkVMYTRIUno1NEFGSFlHL2lYbFFmcTZQSVlHVmEyY21SajZaQWxmZFdm?=
 =?utf-8?B?Q3Q1Y1ZUODRUS3kvTThuN3R0c0dHeUxKOG9VZjJPVzg3R0IvSXNZSG8zVkRR?=
 =?utf-8?B?akU4MlZZdll5TG9kZUYxUStUZjhrT1VBM3FGclJhdDRuUTdsN1Q1aEt5QkhK?=
 =?utf-8?B?SXpTa0tJdHh5S0hNNE42NGdOL2pLVEE2OVR3NjI2d0RjQ2lXTWJsMXNjMFpp?=
 =?utf-8?B?aTBVR2EvUVFGMkR4Y294SzhHNWxXd2lVaS80RVQzQXljM1o1bzA0TTBZU2dW?=
 =?utf-8?B?T3hrNDduWlVRVVhXY3FMZlRod2NwU2J3YkltbGNSalVKZVh1bWQ3ZFFwMmNm?=
 =?utf-8?B?VUoreUYyejJCaTQvRTVObDNWbkxMdXYzWW9jVGh6RWFxak5nUkFyeVhJMUZU?=
 =?utf-8?B?N2tRNCtoYThoV0pobnA4U1V4UVFpbEJmTEtDZExubDNYbG5HVzVCbU1qeElN?=
 =?utf-8?B?WGNLclZndGlsTUhRaklHcDNWaFdicU8yVURERW1EQUw1eHdLVGo4MnhYU0o1?=
 =?utf-8?B?K2s0U3lRV3NpbUZ4SU9uTHBlWnc1YjB1MDh4TEpNM3ZIZ2krMHRTb2QwSHhN?=
 =?utf-8?B?NEFCWWZTUkhCU3E1MnE2UkN5WEgzSVhPY1JyMVJ3UVpzMkhaOFFhL2dDMlN0?=
 =?utf-8?B?OFNMY3VkcmJTcWZCbmVGTnYvMkpzSnRhSlMxb084VFRqQ3BuVCtpM1VNanF4?=
 =?utf-8?B?T2t4RGdSZExCNS8xZWx5VWIwMDJlQzlWemlRL0dvRmNJRDRnKzRmNFg2UnM2?=
 =?utf-8?B?T01yRkNzRmN5cVVEN3ROamEwb0wvUXBNZ040eE93ZmhaVGdYaThxRmNiNE5u?=
 =?utf-8?B?QysxSEo2WUFJbUt1dms5UDVIVXIxc2U5U1FpMHdIMUVwdnJWS2puV2MrOWMy?=
 =?utf-8?B?K2V0Z1BrUmtmMjVGczFNeUdhR1JIUjVBUHcyVkNZTkk2NDR4QzFIMktHOUxO?=
 =?utf-8?B?ZFBWRkNEZERjZU1XcnRYVWZQa1ltaGI1d0RvQ01Ta21DS0twU1lWbW5reEVi?=
 =?utf-8?B?VVp0S21SQ3RYSTFKcmtJTFFqVnMrd3pxSGttaXhRYTNlbk94OTBKd2RkUUFR?=
 =?utf-8?B?a2drVjlXRUdwSUxaRmJJTCtLMHo3VnNqOG1NQU1zL1FmUm4zR3NZKzQ2MDJP?=
 =?utf-8?B?czE1Yml1aUM1TEpSRy9JYThvMVhoYjhpMnFCNlo0T3BDR1dScHJ6cGY2SWFm?=
 =?utf-8?B?VHBDVFRDQnl4WHJuTUlyMVpJVVVEdnErOWx2RTZDTldvL2tDTmZBK3gzYVYx?=
 =?utf-8?B?OGFIelNudktvRjg3dXV6NWRHcHMwenFGdUpUSHNxSVFCaW04QnpXbVBqbmpu?=
 =?utf-8?B?SXNTcEhNNjNCeDk0UGZvcGtqT0p3SWFWSFNtaTV5dk5qeC9nWHhrTlBTQVc1?=
 =?utf-8?B?TFdVQ1NvaTEwTm1GelZsYU9MbXVXbkdYNVk5L1EvdUlNNFlTdFpXcG1qK1Z2?=
 =?utf-8?Q?bfO73/QHCvuF3lDPi3ZH5/C31aWsPTjfrC6yuSR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5b3df5-c635-4cf4-b4bf-08d95c355adf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 19:30:47.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BonaRp1Fh0b7MweUGFaHqjVf8cUTEOiXIbeGxmrdIPHOEvhj7hniwniSXYb3FWqi0mNx3xLrMS7BJQGXOjOhdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/10/21 9:59 AM, Brijesh Singh wrote:
> On 8/10/21 6:33 AM, Borislav Petkov wrote:
>> On Wed, Jul 07, 2021 at 01:14:35PM -0500, Brijesh Singh wrote:

>>> +#define SEV_TERM_SET_LINUX        1
>>
>> GHCB doc says:
>>
>> "This document defines and owns reason code set 0x0"
>>
>> Should it also say, reason code set 1 is allocated for Linux guest use?
>> I don't see why not...
>>  > Tom?
>>
> 
> If Tom is okay with it then maybe in next version of the GHCB doc can add
> this text.

IIRC, during the review of the first GHCB version there was discussion
about assigning reason sets outside of 0 within the spec and the overall
feeling was to not do that as part of the spec.

We can re-open that discussion for the next version of the GHCB document.

Thanks,
Tom
