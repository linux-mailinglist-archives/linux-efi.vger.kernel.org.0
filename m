Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8F44D893
	for <lists+linux-efi@lfdr.de>; Thu, 11 Nov 2021 15:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhKKOwo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Nov 2021 09:52:44 -0500
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:12129
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232778AbhKKOwn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Nov 2021 09:52:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axbErWHua4hrJna7OURbKaTwbn7Rh9MZbAsJz8PMjhN7hRUflv56bFbOb7fQNCIxdEMrpFDRauaoslO8RVlNifrV5tWCKvBrHh6ibmQg4dfKFJlquPaN6QiorXBkkZ5xRPCQqQBHRaaRW6g/r91dXZ1R2YKRUtyYOoP0Io6NXgPFZ6NZTcjSAexpkK4MVQqmqfvxM7qJf9mUHKC/iLxyZxle7+G/UYUZwK1fIYMBDb1OLQ7dJv/GiK/lF3B4QyE4SPCbQC9VRU8N9cf/mlButAkqmY8p0D87XutkwqcRFY7qwh7f6ET0+uBlI9NBgfHrRCBEiLIdwd3BXOusYx6/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKYF/HiE7ROYXWglBH4Ddq9HaWPScfrVI5KDDHiSdCg=;
 b=DK47c6DWPfe7p63FdAWnOAik8YXDosrpjOJHuRsj0S1yc3L+MazZBcysDPXWcmBkbd0wzO/pTXvAsD568RTSgCUOQHe1hmGA0UhQUaRd+1MeoxEpCZx8SSmrE58/fH8djM9ARI7f8l56MpWLpLOO7KRKW+GSrRC4aQpNhpbImiZ+pE1AYiGIq2q3305Op+XnYIfpYHjs3mMKJVKufNaWZaaN1Y0CEf/74PGe9XU6ZtVqO246OfSqzG7d1OQo6w1pPfb2vp58S8+MS+t8eABecv+X5Xe96PCLYEFC4IMAo1fL2OyL371kWmULMCwNNP85rw4d5E6Uxtfs5a/ec8St7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKYF/HiE7ROYXWglBH4Ddq9HaWPScfrVI5KDDHiSdCg=;
 b=0JFgpg9HMQhmKjAVY8r1nDPZ2yEypEIpkvXLhso+c/ExWNf+pn7Nf1vUzxkCJ+OfDS8ueIFVubwwefeerIVnB8q5EYPOWy6fHZatYAWrqmj5SO2WCIQo/hC0ZTml9Yc4W5HPza/CKoLrHvOwVVXmDWInIof1f8kRK0CnPTXLIco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 11 Nov
 2021 14:49:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%9]) with mapi id 15.20.4690.020; Thu, 11 Nov 2021
 14:49:53 +0000
Subject: Re: [PATCH v6 19/42] x86/mm: Add support to validate memory when
 changing C-bit
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-20-brijesh.singh@amd.com> <YYrNL7U07SxeUQ3E@zn.tnic>
 <4ea63467-3869-b6f5-e154-d70d1033135b@amd.com> <YYwS74PbHfNuAGQ7@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <50283b5a-3876-db91-da99-b95a4e8e0fb5@amd.com>
Date:   Thu, 11 Nov 2021 08:49:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YYwS74PbHfNuAGQ7@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:20::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Thu, 11 Nov 2021 14:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117235bf-97a4-4e9c-08d5-08d9a52284f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5550D7E1CE15CEC4B6681D27EC949@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpVcT8y/Qwfo9QS+pI40hioI6/pXQ/eV6a2wHPloLTcdOSY7M5g4CfymTUDmns96x0RbubnCgCv7l0DjYvzN6hBU27dqEV5bLzOVAP1AjbemuF66ZTW/OhE3YyrbCpdyufhqfX7YNNYOTJ+PJ2jRSb90n/1i2FiQcLjZ4/sbHFVB1Qg9SY1mRmpXptXEPro0HBEfpwibBSNeSEcXa5LlHBLzG5MfxhTPlpDTsHC3YWxxKvK/lTLC7f6qwaviC0LfiKJuYHtPupPU66TwK3YhlKJgWDiW5wYS5Dfu6JC9RfIzXBU/4DFeTp9Mcc7c3KgbBdI6DRNMB6v3KVxu8GPmznkcco9M251aZlWS+AZ343HgwXy23oLTRKhLA/yzoBUZ2M93KVfsCxqn5yApLgK1KYh1JYj8qU5QTRMInoayolg1LOhFSTRFbgWrh4pSfJwq8DJDtu7lYm1Y465arb4bELwCLy0olCzG0VoeoMu+cpvnCuGXK8GFDigaq8bMJtywxXb2vh1oL/9wouU5lZN3EhZtT2AA743fJ/lYqivlGxtXRJzdVDSBPcUee9w0mpDAGgouK6jeOP86QAKZg73KaRdloE+UY+NK4VIDQSW25HjZEDfWID6XXZ9ATSmEEzAAu2FF2GNx2qONEqc0R3AJEj+Y4UecvX3ExKXHkIh/E3Uh2kSl5+yZ/KbjqGpGfwtxOSktT/QcJCOjQ/OwCXg/4gWBlb0eYa//Qt93EaNwamNxwObfKreZMKh62johtLiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(2616005)(66946007)(53546011)(4326008)(8676002)(7416002)(36756003)(54906003)(6486002)(6506007)(956004)(508600001)(110136005)(66556008)(26005)(66476007)(31686004)(6512007)(186003)(31696002)(316002)(38100700002)(8936002)(83380400001)(86362001)(7406005)(15650500001)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEEzUmZhcHFkTzVDc1prdUxKWHpvd3VyZ0k2U0tjUGpMdmZTM0tzdXZhNkNF?=
 =?utf-8?B?SjU3YVpLN0RLcnFSMkVRTGFYRm5MQ09MVll3SDh2Wk9qZkZHRkNOb1RPaXpK?=
 =?utf-8?B?L2FyT3ZPNDNBZTREWndYTDh1ZktwU3ZSVnc2ZVIrR0xtRTNHR0hieU1lQXIv?=
 =?utf-8?B?dmV0Y0ZHakdLTmpzWm5WZkJNVXhtSEpmME4rZUdGYzlnZHdGLzlydUdyR3J1?=
 =?utf-8?B?OWJ3VEdHN2J4ZGRRQlJhWlAvODV5VmVMOWdSekk1a2d6ZW0xdkNuV3ZhV0NV?=
 =?utf-8?B?WThrYTViM1hIYU44OUlsNndvV2g3VWVGTzlpWE9NVXhWMkVhQVZwVFNNcHQv?=
 =?utf-8?B?Z1dWUE1KMWZjZ2lJQVdQNTl0QjJGc2g0K3NIYy9NSHZNODdXNVovbmN0bndO?=
 =?utf-8?B?Q0ZOT1RoSFJLbkE5ZDFvaGc0RUcybWVXR3Z6VldxREw4U08ybHRtQm4rWFA0?=
 =?utf-8?B?bCs1TWtMNDdSQWVpSFNBMGdKVzhoek5PU3FTU2dySnFxVzc4NlB2cnh5Rmpn?=
 =?utf-8?B?eGliMGFwY0VVY3k0b3pIYzNlZ081ZEoza3p6dlNHeEtLTTVmSmRQbVUxSmpH?=
 =?utf-8?B?SDRxYyswT1IvOUR0eGhlQVU5MGpuT21vcFNkNDRLNHhUd3pCUTBtMURXSWcv?=
 =?utf-8?B?dlZUU2F1TnBMVEZWb2xLb3U1VVZHNE5rbnZMRkp0bXIwdnM4YWVKKzBuZVlJ?=
 =?utf-8?B?cEpTVm80czVOMCtpTXJxMEFDMUxuTWJXR29pK2VMVFlTMklPMnJkWGlVVk80?=
 =?utf-8?B?bDNUeHdzdkpiUlI2TGdJaDNqVlQ4TGd2ekh3azBCSjN1U2I3SU93eG9RQ3o1?=
 =?utf-8?B?TVFHTk94Snk1MFQ2RDZzZ0dkRkFTMS9xWGlLZ25RZExvNUFyTWUyd0JsZU1T?=
 =?utf-8?B?WC80eFY5Y2pNbnVDdGRmc3JKSmZwYkYyY0NhdXl0cks3L1p5NUtadUo1bExa?=
 =?utf-8?B?RWxDZmpQcUxrcU1oK2VPSyt4UjRjTk1HcDlzRFJ3VVM0Z21rY0hWRkZOL1Nv?=
 =?utf-8?B?amVOc0FrZXgvQ3R0OVVlM2h0K3Erd2ppV0tTZE5zVGZyNGNQUlk2UzJQdHNz?=
 =?utf-8?B?WU1heDIyQTl1bU1nRURqM3dKT3g3bkZ0eTVGY2FHQm80YUtNcFYxTEdhTnl0?=
 =?utf-8?B?NkZMQmsvdTVXTXZjemQvNjExcis0bEV5QUdDSmRYb2w3TWlaY0tCRE5mRWhl?=
 =?utf-8?B?VStlMUpqTHlJNE53WG1ON2Z4T3R6SW45OVJqbmhrdWpoQmVuaUMrMDhrNUVl?=
 =?utf-8?B?QzQwc2JhejhBNEdEbWV6VE1qU3F0bUFGR1dzSkNSUmc4c1R1MzB4Rldhamg3?=
 =?utf-8?B?eC9RUWZJUVA5WlFpWEFDTzVzekhKbEh5TkUyeUV6aEpNVnhoQXVnd1B2dVU4?=
 =?utf-8?B?L3BvYXhYQ2ZFeitMRHBVSjFXZ081NnRvTEk0ZkF3dUZwTEtBelFvRjU1VUxZ?=
 =?utf-8?B?VzFJTDgyWFN3cjZQZmEwRXFranZ4ZnZaN0R3dU1MZlovaTZQTW9yRzNPZzVE?=
 =?utf-8?B?c1hqZmlVZm0xNjdLcVM2c3hNUSs0Zlc4M3FoTElBbDh4TExna2szR2FUQmRo?=
 =?utf-8?B?RVVYdm1MS05iZFA0Z1BBd2hGbkVnUktxbEhCR2pOaElXZC9ZN28vNkxtQW5P?=
 =?utf-8?B?eCtuM1oycytNSzJ2WDJxUU1VV3pSTlFlT1FVcFF5YVRoMTc1Ti9PQjEyS2Vo?=
 =?utf-8?B?V2o1TENmUXhUaEZrZXB3RWJmZDNmaHJLOGp1Z08wSVNBRUlVek54RVZueTdo?=
 =?utf-8?B?QTI1WHVvU3ppODdYZThFdk1ZZ1hXVFMvdlkxUjE0eHU2d0dlRS90NU1LTjVH?=
 =?utf-8?B?eUlTUk9BOXoxeDFSZGlIRGVYTy9qbVhaNkIrdUJCdTREa1M5RDFqbk5aWms5?=
 =?utf-8?B?VWEvd2VOUXJiZVdiKzJETWNENmtCSkNDT2Fkd0tnaFp6aENIVU1HT1NuRFl5?=
 =?utf-8?B?UXJwWGI3ajgvYm9VUVozTklkV2RXQllMY2xud282NForNnVjM2huSkhNR253?=
 =?utf-8?B?Q3FuSTRVSVhiMHNwUk15V0NZZjlTczBtZTdLZER2dXZzOHhUWnVyYkdEaHVv?=
 =?utf-8?B?enplWmwxTnF3dXd6Q3IzZHM1c2daNWZLRjRJdUtUSWhKWjVJRmVvcXZkR0pM?=
 =?utf-8?B?NHF2UTVuRkwzbldQQy8vekpodngzbE1ZYVBaandCcGdPWDM1Z082V3EwR1NN?=
 =?utf-8?Q?hJsAmjUlBM+p0kZfKE9m/qo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117235bf-97a4-4e9c-08d5-08d9a52284f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 14:49:53.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp193cLKrNMa5GmWA1UAZjfLMQC6cbvvsRWDHCzxP8ny1YjiyTtrU4l+O7DihNgzCQ5Ols0pqWlZQ+n+QTG3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/10/21 12:43 PM, Borislav Petkov wrote:
> On Wed, Nov 10, 2021 at 08:21:21AM -0600, Brijesh Singh wrote:
>> I am assuming you mean add some compile time check to ensure that desc will
>> fit in the shared buffer ?
> 
> No:
> 
> struct ghcb {
> 
> 	...
> 
>          u8 shared_buffer[2032];
> 
> so that memcpy needs to do:
> 
> 	memcpy(ghcb->shared_buffer, desc, min_t(int, 2032, sizeof(*desc)));
> 
> with that 2032 behind a proper define, ofc.

2032 => sizeof(ghcb->shared_buffer) ?

The idea is that a full snp_psc_desc structure is meant to fit completely 
in the shared_buffer area. So if there are no compile time checks, then 
the code on the HV side will need to ensure that the input doesn't cause 
the HV to access the structure outside of the shared_buffer area - which, 
IIRC, it does (think protect against a malicious guest), so the min_t() on 
the memcpy should be safe on the guest side.

But given the snp_psc_desc is sized/meant to fit completely in the 
shared_buffer, a compile time check would be a good idea, too, right?

Thanks,
Tom

> 
>> I can drop the overlap comment to avoid the confusion, as you pointed it
>> more of the future thing. Basically overlap is the below condition
>>
>> set_memory_private(gfn=0, page_size=2m)
>> set_memory_private(gfn=10, page_size=4k)
>>
>> The RMPUPDATE instruction will detect overlap on the second call and return
>> an error to the guest. After we add the support to track the page validation
>> state (either in bitmap or page flag), the second call will not be issued
>> and thus avoid an overlap errors. For now, we use the page_size=4k for all
>> the page state changes from the kernel.
> 
> Yah, sounds like the comment is not needed now. You could put this in
> the commit message, though.
> 
> Thx.
> 
