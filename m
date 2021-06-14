Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3823A70EF
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhFNVDz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 17:03:55 -0400
Received: from mail-mw2nam08on2068.outbound.protection.outlook.com ([40.107.101.68]:13217
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229771AbhFNVDy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 17:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVtm/adDq5ZpHsChZGBMlc6uGr9bmiLHq2JTeeIAvscpNN6qieMpuzPUHnoE8WQQDoFfmoscgxji/u3JmDG8vUyMOKsSjsa2oFzy3LCGb9rV31cdQj9oRYu3EIDjLVMhQMdvSGL2P+dLbPGaeIaPCiQe9nCg047lNG56mKnT8XAGFQ2/ch81iqBWghDzJaGnngm8S7YBFaEqCyfv5iyu2qD6bc6ryS0SFKrErBhfHKv2qyzqr4VrxXEU51ZTdtceAszVt2r14qu4z4+F07B9TDH6Ez+nrBnw+/xmlH8iysOPMzmwt/R9d92zV4X3/kBKd8CHo88CHnBiVqMnJkOvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmzb8Yy/2HFwCspGuSzCPNWyPDpA1XuRm+yAslKolyM=;
 b=TwkOdrxJuLUo1DjeqaoYnYvQL+jprJOeDOqwRuSq7OtWEYU/ZM/xdRk1ytXevsijUEWwXY25+MHTw70VsOTXw/wnvpM+tAJlgElB6ROrZvtR7X5oeSqkYWBv8z24MqomtZCKmsUr+XgQHePD4aWUbPgd8P1jr1glw7pSqTeJ9nk9T9JV1Smf2d/gk+aH7W0Mt07xlkwwkdMQ4do7Rq1A+QKWNDVG98CKRcRsBfY4XVOFzNt8/9pcuUQBlIULsv+J6z0B+nvoUtGn8Mwycz+MDszimlubNbvuqj+V+iRwC7SmXY4l3M5wJSBvvp98/d4HvxMxG8CZpL27l8h3cvzjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmzb8Yy/2HFwCspGuSzCPNWyPDpA1XuRm+yAslKolyM=;
 b=fgD9Qg4FhDZ7wH7gglvEi4+TkDSjK2rFXRK1TFYr7WZ233Mb8JgsCglhxgYHzmtaS5JK8i0KM7/cfO16+H/xzlK3oNUrQZm4Zi5UJxOCf0ViPAu76DruiP0PYnbTd4f1MGL04P5S2dnBZk105METFQqrmRbx878wU1ANNr9OSmU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3036.namprd12.prod.outlook.com (2603:10b6:5:119::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Mon, 14 Jun 2021 21:01:49 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 21:01:49 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com> <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com> <YMen5wVqR31D/Q4z@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com>
Date:   Mon, 14 Jun 2021 16:01:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMen5wVqR31D/Q4z@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN7PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:806:126::27) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0202.namprd04.prod.outlook.com (2603:10b6:806:126::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 21:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e8e62fe-b0c7-4279-060b-08d92f77a071
X-MS-TrafficTypeDiagnostic: DM6PR12MB3036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3036E8A0A1FD0748703CF26AE5319@DM6PR12MB3036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5/YcQtIcA6Jc1uQ9ogS6/VrplXIG0Tgj9gtVha9x2is3YOd0zv0VKIP58RHyL3+6cMMwe66N3mrh7AhN6hZ2OdEfr9KY680rfQcKQQ4GHfA/dFtIovjCT+Bd5FVxqNaPaktVfDku4NEAEl7ZADC3FOcWvYSjnzNU5CkXFJn5ffOvDzflU8ZDr/RwaOdD5amb8MUGtvlu9Yv7q78kCZb2tS9ELCm89S4/dGjmzfWI9YGImdcnFX9S0zjxxptoVMp/QkJYWtkl2EAdjQ4SfCXUBSqhQ1+zPE3NMxSHMJGFxHBIXg6m8TfnIsYtMorbXW9CsOoasBZcTPfm69Je22nF9wKbXcJlCnqiHebm81WvZRtoLcEEmH5klXfGUAFtjBzQwrs0V8SKY6Yz8mWukssvEjboAHRdcIOS0iEjcGQJsqcTw1a+JcPb+lupYvUachNYEVa3InZ8uSmMj6flqqAU6BAke6IiZYktl7WPMAdDMD7cMJUDtBjzlD7L+NadNo8k6jxj0xTT5iEgitRZgzUF47YhfozJA77uABEIpg1nO5KsqvTUPtIlVXhsILBwimZh3UrGQPdK0B6t9+PK/ByO/Rt5XnA427xPE+guy9QtyPXVsxj3QzjsUpjF2lFa1FN5usTWS4sZB3EzQQoQ5sR7Na5JYUsfBusoMXjjGfONLgTSDr5CUwH6ZYmSLiOJ5tHzGUIPrkys1bzmoGodD6PDAvq9UHEXk7ZC0PocN7KvwAAKhZi8pgayEAmvS6EfgHJDvFZadj9SmvW8Czo5WEfkS0DSPxnn2+ccz9I8OFXJ/AfIekKReHQtvxs5Yh+j4xLj5f+3SUKb2/QEqq10z6IDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(316002)(4326008)(8676002)(86362001)(66556008)(8936002)(66476007)(83380400001)(66946007)(7416002)(53546011)(54906003)(6916009)(2906002)(26005)(956004)(6506007)(186003)(6486002)(16526019)(6512007)(31696002)(36756003)(966005)(2616005)(38350700002)(38100700002)(44832011)(5660300002)(31686004)(52116002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJraE9HMjRqREtxaUthWGJ2NDQ4Z3dVV1V5Mi9EVFA2Y1BrODZ5eWtqSjBs?=
 =?utf-8?B?ZSsra0h5K0I5eTZzVmROT1Bodi9NcDk1RlJHdDVOS0Vid2pLQ005RS9zcEhj?=
 =?utf-8?B?Q29HL1lNa2dFd1hEeVdEbFd0YzFsMmdHNEIwSHVNcjd5VlVtV1hXYjNmMk9G?=
 =?utf-8?B?WjZlSlJweGxlRkVoaFM0WE40YVlzRUFMcUtKK0FsbWJ3UGFEb3lha2U2K2Zj?=
 =?utf-8?B?b2J2d1JITFk5U3FYYWxmZTRRVzhDM2MvVGp6NjE2eENnTi8vb0VCZ1hVcytw?=
 =?utf-8?B?MzYxQUlVYjhKUnVoWXJKQ1NmZklFWkJyZWc2VGVLV3dwbjU3a1BkZmZqOSt0?=
 =?utf-8?B?Q2o2S2thYk9GeU5wL3hYTW1MakR3U21OalB6MVFqR0U4TTZ3bFhucmg1eCt2?=
 =?utf-8?B?QXo5M2trZmwxRUJpSFdRNk9ReFVhYTJxU2h0aHBTWGw0WUgrSGtYTnJOZ0RI?=
 =?utf-8?B?WHhRSEo1T2NIbVBibjJNcnVNQzA2eXBZVVhIaDBVajFyYkUrM1BpRi9IeXdO?=
 =?utf-8?B?b2RQK0hIYkpIc1habGlObUNYRXZiVEtFSFlNSURzSEdZT015N1NPdUNIbFp3?=
 =?utf-8?B?Z0pxazF1N29heitma1V6enRlV3ZMNk9nYVJ2K0tOTEx6M0YzLzFWZnk1NGdp?=
 =?utf-8?B?N3VzNldyZ0RNSzZnNGF4VlQwbWw0eUtFMFdCaytnbSs3Zk00eHVzVjdhZGlp?=
 =?utf-8?B?RXZqckJsTXhpMHFTUDYvU0xuVG9xS25qNkNub3RTNUpMUWsxdGdReE5OVTRO?=
 =?utf-8?B?a1MwS0V5cnZiSGxwN1FxVWxOQ0YxNW9takRyVHFZRjFYaytaRExQUjlFTEsy?=
 =?utf-8?B?R0M5T3J6Yk9EaVpJRTFlL3d3VXNXRkQ1LzBYRThYVHBsK3pLZUh2Q3ZFZlFM?=
 =?utf-8?B?cWpkUDMvaGZUTGI3d1BNMGFaanRmRlREakU3RmMxSVJvbEwwTmFzTlNqb0Rs?=
 =?utf-8?B?bWl1MmI5Rm5xVUZQN3Y3TnBza1ZtMFBXV0d1djd5emFtbFVJRktNSG45dW1n?=
 =?utf-8?B?aDFuczg4U1RMWUNIeHlRbUV3WnZzK3VmNlpUSHMxdWpZRTlkTVVuSFkxdjk0?=
 =?utf-8?B?UndxSXZPc01TYkFxOUx5RThjRWdManI2NncySEpWU29DNGpOOUJGVWNoN2d0?=
 =?utf-8?B?SXl6OWlOK2t1ZlRzNE43VmdiQy9VNEErMWhOVDBtK055N1A3cEF2TmN6dk1D?=
 =?utf-8?B?WFFKb3JDbmRhY2ZvNUgrWlFib3p2MmV2U3JoanBrZXM0bGxNaWtJaWxodWdo?=
 =?utf-8?B?MnIycGVnTnQ4VmtwUUtTZGNrVENYTlZZeUF2YyttVjhYa3IxMzBjQlJ0MVhk?=
 =?utf-8?B?WW02RW1yZUtReFZoVzFaWDRQcDhFaCtrb1JrWkhBU29laHRaN1BiTkhpQ3Fp?=
 =?utf-8?B?RU9VNW93RjBvaVl3K01IYk5mbzFJaklGb2ljWk8rOHlDOUNGRFpzN1JkZk5v?=
 =?utf-8?B?bHByWTBGTDFWWTFNRC9iZUQ1Ykc1dlllemY3aFo1NTNJU2RFcmNuaUNyOHZI?=
 =?utf-8?B?MkpvclJ0YU1FS21mLzdLcVpWQjdIV054M3RQcURBYStEMVkxd0pwaUhPNTJx?=
 =?utf-8?B?ZWJyWW9oM0luS0hkU0lET1ZpSm9vVEV3YmdlWnpFNzl4TFFoR0hJM3owZVZJ?=
 =?utf-8?B?WWk1K1dJUmlJNGFHQ1RmRktSNGpkMCtVQWlHT1dOTVdyYytzS01icnR6RUxk?=
 =?utf-8?B?dnN1ODZQVi9zdXQ5ZUFqNFNVcmJJRUFLZm5hN0dVRk9laWhuQWg2Ung1cEsv?=
 =?utf-8?Q?7IzUKxKTfm7hTfbmbWFW8ukpLwGHLl2dseINYuK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8e62fe-b0c7-4279-060b-08d92f77a071
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 21:01:49.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY18DLhFMF1aiydMspUvqX0BUg8OVfutkZhSkiIPv6uN1vt2/w6pSHKAoAhhElp7WqNEaQ2On/VO9Q4zsYv4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/14/21 2:03 PM, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 07:45:11AM -0500, Brijesh Singh wrote:
>> IMO, there is no need to add a warning. This case should happen if its
>> either a hypervisor bug or hypervisor does not follow the GHCB
>> specification. I followed the SEV-ES vmgexit handling  and it does not
>> warn if the hypervisor returns a wrong response code. We simply
>> terminate the guest.
> This brings my regular user-friendliness question: will the guest user
> know what happened or will the guest simply disappear/freeze without any
> hint as to what has happened so that a post-mortem analysis would turn
> out hard to decipher?

When a guest requests to terminate then guest user (aka VMM) will be
notified through the hypervisor that guest has requested the
termination. KVM defines a fixed set of reason code that is passed to
the guest user, see
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/kvm.h#L237.
In this particular case guest user probably get the KVM_EXIT_SHUTDOWN --
i.e guest asked to be terminated. If user wants to see the actual GHCB
reason code then they must look into the KVM log.

Now that we have to defined a Linux specific reason set, we could
potentially define a new error code "Invalid response code" and return
that instead of generic termination error in this particular case. So
that when user looks at KVM log they see the "invalid response code"
instead of the generic GHCB error.

If we go with that approach then I think it makes sense to cover it for
SEV-ES guests too.


>> I did thought about reusing the VMGEXIT defined macro
>> SNP_PAGE_STATE_{PRIVATE, SHARED} but I was not sure if you will be okay
>> with that.
> Yeah, I think that makes stuff simpler. Unless there's something
> speaking against it which we both are not thinking of right now.
>
>> Additionally now both the function name and macro name will
>> include the "SNP". The call will look like this:
>>
>> snp_prep_memory(paddr, SNP_PAGE_STATE_PRIVATE)
> Yap, looks ok to me.
>
> Thx.
>
