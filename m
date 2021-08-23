Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B823F50E7
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhHWS4G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 14:56:06 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:21793
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231716AbhHWS4D (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 14:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTLk4WkT0pHGHDHUH/QI1v+/GbqNSfZRsKAYPrXa0qvAVU/w55uS2XVLAHiSpvUfUW2T/1D58d1cAxVreKpYnWzHDBfN7xvHopFX7ZUCvof1RLjO0c/1OEuAINn37MA8k/9eYmHxW7tmR256cNuZ9rwLOKUi5YEFIUwvoDFlSweeabsxwMj1tWwZRjTesWYSi2/mJQkLllNO7EjvE2hR80AgQBJLYGGffHOkys9aHdSx5vomgNas8X5RQrGV2rzYRx9/R4mpJll79XpcdwD8DLOPJUPT5viOjUgun727MXJbpILZTwxUe2ZeqFEwgjZfal7ALDUtyIsto4IdVHqfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeYYfGGzP5kWzOAjsixcL8CVNVUXp6nugK+Nq9wm16Y=;
 b=FycxpV7jf76d7xX66oNT1hw5zly2y9NJLLk4x++XyEwRVT2gcaDDMGoes8C+71Efsw4cRHhasggcSDFmzTEkHj5fHZ0VJv4JVdraFlc/s8WAhdPEfLP/FICqSjRReXu6AMMymx05e7jny9MSDVpTqdbUv2aUl9QbCX1oupO5vFYMk3lmgWRoaBE/2gH2t5oiBsFwlpIRwN+/7AIMkKamcgP0oIZ79BeZ4DORdNti9jQtqAMVRqD21tMQSfT5SHh9bOt5XB1pOCwl3teBFs58dD1WPmdGlr20nR2tAuxqZftyBzKkz6hojrCFsIKlXVi/DlzE1NBqNVnwjgxak02iGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeYYfGGzP5kWzOAjsixcL8CVNVUXp6nugK+Nq9wm16Y=;
 b=17DAD8wTf/dwTCxO+gpNIufsHTHk9aCgOL3KNBBGjFMr7LGPjQzyCCfxfhjImsJtolPAY83PZ/g/5zZgV6AlbafObCZFLMUShuIRcealpY0d6FW4FmgT1C7TVEejXTtYPpJlehp9CMr03diOIg3uCHgZ2CXO1hf1s2zESn+M+bE=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:55:18 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:55:18 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 11/38] x86/compressed: Add helper for validating
 pages in the decompression stage
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-12-brijesh.singh@amd.com> <YSOt01Qk9KOsTVj/@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <daf3a060-ae3b-253b-4615-3fe00866f135@amd.com>
Date:   Mon, 23 Aug 2021 13:55:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSOt01Qk9KOsTVj/@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:806:f2::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0026.namprd04.prod.outlook.com (2603:10b6:806:f2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:55:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3103a4ba-af9b-4e69-cba0-08d966678d10
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384A5A2B4A73AF0B2A0298BE5C49@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKFALrpD9iy3U47T4gE+q7sbuBHj3XDdaV2wke0JGg4wejErL9cBI4v4o14d6YOa/HapYLxhJvuEE6rtPJNrdQDEa3vD6nbnddKgAA0ZzQzb7Jgnf5lV8RVUKMP0A8cakbpGsLH65AC+hTtJ3g0udubYTqO6Rk2qS/X8qKf7dYacNZdqDCt5SIFV257EYgKmEsr5wsVoC4GOO1j+xtPCf1TJacjdVoB5L6xi0XfOh+Dr3w5jQ8Lpoq3v5IqQgLRKqLi/ssY95IAO3b2no2PBt78xjFU8whqJPnDPOdgy85CzE3yFE2DQtDey6OEbCsB5/Mb1MCluiQYDqunvkHaA23/7GI05t4HzP1H97n6ax6MhTChRHO3OLJnGlKioFQ4dYjtO+GhPmqWlH78ks9muNiuMVYHLXNSQSbg4YX4HLBKGXZD3iSuZRB/PlohKcE9vsWhc8Aaytsu3pqjiVt2hOFtzHrKMHIpzRbLBz+RtOVsFv1W5umSpI3vCS+o/vhm8s0X2SjLRhMsteuSeLHX26u6J8ovHZmi1MZJYFuGABCsw1BOZLQntkiGEJaCkZ9pFdmaF+KWbdvksDvOSSb6aadwEteOHa5GnRJK89SyYGH1jV/cWLQLi7yAiIBVtrwFG+kM0wZUBtKhdFaRqyb/sYPAGwtIVt57WiNBb4jdhq+S3KSMAC0BJRp7IZv37HEXDCFbPpI8wh4a27tdVnqTpTmWz0pW23w57lnzXSr2d+kkr+igQ8V4huFR74n2MzoWogFGBW0dWWuhnLxHn0yU27w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(38350700002)(7416002)(8936002)(478600001)(16576012)(53546011)(54906003)(956004)(4744005)(38100700002)(7406005)(8676002)(52116002)(5660300002)(44832011)(316002)(31696002)(83380400001)(2616005)(66476007)(36756003)(66556008)(4326008)(26005)(31686004)(6486002)(186003)(2906002)(86362001)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdOWUVBSUFkSnAybGdqcG9US1hHdmViSnU3RXQ1UUJXWWFUcis0T3d6ajVk?=
 =?utf-8?B?Q1daakJHczlNRmkzVUZnZTlYUXpqWktaNzVya1hhc1ppN0haaU9UN1BsV1BL?=
 =?utf-8?B?RlkzcUNjcEhKU2o3K3NnVEp5UWdBcDJxcmoyem9IVWVDZ2tnY3NPL3dDQUpk?=
 =?utf-8?B?cUxyMndMQkVweDArN01YV3ZSZ3h3RnNSL3BxVENoNTFJN1pGQVplMWtTR2Ux?=
 =?utf-8?B?REJCbktPbHJiNWM3SmlMTG9DeVdzUWZCOWJTczlVQUswU0E5NklIZ0ZoZE91?=
 =?utf-8?B?MElyWWFrUlRVWG1nOFp5aGhKVFBBd1pZME9pRlJVRW4zRGUrYU9acno2VHB3?=
 =?utf-8?B?U0dvWDN1c1M4SGQ0WGM1cmw1UFhzSW1CUTdsdWUvOGpEYUJESjgyL3lxY21z?=
 =?utf-8?B?M1Z6NnVlTjVOa1k2V1FqNnVpMzdWa0szK3BYTENJMG1CYmlxY0ZQM2gyY2pl?=
 =?utf-8?B?L3BzOHUxc3paREVxVU1TZ0kvVmdEQkg2M0l0b2NtV1NCU1MvVkJyNHYxbWsr?=
 =?utf-8?B?bW56VEV5MDRaVmx2ZmFZL0p1dm4zTG1pY2ZNM3hHanhURThtQ2VCcXhzT2Mx?=
 =?utf-8?B?MVdkZVQyYzlwTnJ4TlB1S2JvcjhqTWc4bUVvMGsvVEVzVTF4MFV2MVhQSlJY?=
 =?utf-8?B?aUl0TEhzT2V3ZmJ6aG5Xa29aWHdrdGFpOWx3WXZsUENYblp1SjdpTXErMy9C?=
 =?utf-8?B?YWlKaVVaWGtYU1liR2xvL1o5dzBUZ2t2bmhwSW80eFFvMWVaZi80alp2U00y?=
 =?utf-8?B?MllIYUFFRmNlUXByR2FZVE4yVW9FdEdjbEM4c042U2grRlV5R3ZRQ1M5UFRY?=
 =?utf-8?B?LzQzZ1RianFYUHRwRkNaZHJZb0N5ekovOVNsakJmOWdNc3gybmFPdlR0cnhZ?=
 =?utf-8?B?bjBiek9FUmJNRnFDY3FrdFk3M2QveEwwOE5EUEFycElyc2ZSN21jb09odlRq?=
 =?utf-8?B?Zk5aSUZkVjEyd2owMVhadXdQSGFySUdVRUdxd3NGRVVISWF1TUZwZCtDazlk?=
 =?utf-8?B?L09oN1NybzRHZitMakdxTWJGT3VibHMwMXpEY0lxUUdXaGswNVpxUmdqK1h0?=
 =?utf-8?B?NDYxT3FWWlZVTXFyZHVEK2lpOWRnb1JvV1dzZVl0VkxSaEhkVXJhTEZ3NlY0?=
 =?utf-8?B?MThwb1E5VlNOV0wybGFoZStsY01qOXFETnFjdyszSG9yU01LQ0hwMjFjN0RT?=
 =?utf-8?B?NWJYQmVHUUU5SmJNNS9uaEYwWHdyWExDb3gxSVN6WGxVMkFEOXBlZWNLZDZ2?=
 =?utf-8?B?VUdueGpBYVpyQ3VmbDVwZG1WV2M4Q1JaUjFIc1pkWUhJZEZvWG92NjNnemFr?=
 =?utf-8?B?NlIwK1RNR3pyYllNd3NwSUJxQUk4ZlovRDUvM1gxWEpUblplclBUdlN2cHNj?=
 =?utf-8?B?bDI2NWQ1ZGo4VUl0L1c5MFR0STAwRElickl0dHAzbjBEV29rQVppMGxkU3A2?=
 =?utf-8?B?MWZocGZpV2JRR0MxM0YrMEs3V0VDWTFDYVhIVFMyZDA2MzYyNmgyV3dlYUt3?=
 =?utf-8?B?eVcwUmR5UEV4YVVtU2pZQWZFN2hTVWpZWWhEQzl0Rm9iWjJEQlltUmJJazd5?=
 =?utf-8?B?aWpheGF5dGxlaXJrcndZcVFpR2YvMEFRK0pEQWdVTFNBL2FUbWd2YUxFWC9z?=
 =?utf-8?B?N2pNMm51ZVlDY25OOHB6TDh5OW9PcnlRazZrZEJScHZkNGprZVhTck0zUklD?=
 =?utf-8?B?RmIraXRVU0d5dmU0RmVycHllb0ZBMWRrR2QzempIekJFeHFGUDJNbFp2cUxT?=
 =?utf-8?Q?tMXDchvBUyxmQkRGvlow9GZGvL+qG/5zJXR7caP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3103a4ba-af9b-4e69-cba0-08d966678d10
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:55:18.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPpTeG0oYR8C6mSUqKFbpAxiwVIXoM1aR4iymB/adVa5IFe5c05fzb7IF5Gi9bWTEjOuYyUY116OpUn8hZaHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/23/21 9:16 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:06AM -0500, Brijesh Singh wrote:
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index d426c30ae7b4..1cd8ce838af8 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -57,6 +57,26 @@
>>   #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
>>   #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
>>   
>> +/* SNP Page State Change */
> 
> Let's make it very clear here that those cmd numbers below are actually
> part of the protocol and not randomly chosen:
> 
> /*
>   * ...
>   *
>   * 0x014 – SNP Page State Change Request
>   *
>   * GHCBData[55:52] – Page operation:
>   *   0x0001 – Page assignment, Private
>   *   0x0002 – Page assignment, Shared
>   */
> 

Noted.

thanks
