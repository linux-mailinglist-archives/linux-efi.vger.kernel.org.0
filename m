Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5E3F506B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhHWSfh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 14:35:37 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:65376
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229883AbhHWSfh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 14:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTYg4jXHRKkuzWFFzE/GnCXhYqHDdN8ORZhMTp2ZJ0bWUdTUVNkX+szsUgtj7nPlTqw4C5FNvkm5FyTrxWniFKoweJUqaqAo2yl7wha0RoJ7leiLSRtDSJRsmDPAdvaJCcK8itDjPBPZdvGwzsB8OFGiduKbAe7VBMDa2Dp+ye8t+wCedF3J4etdIBHnAlfMMfBIpvT4u/mDtgw9E38L4Eo16UYP9C96VyQguTex0JoSU+o9CAGq01V3L8FrYuSa2Q+wsU42WRwZLY1leR6bNmeNd+zonhQiJofDdXIA41cKZrQCS3nlIZmOisexTmXjKv0OQ4O7Nm7l8VL60qOv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRiV8vEkSGXwRbuEj+SNMRB1u2uguCBnuAL0Vs33Clc=;
 b=d2Y0aTdRueGwa2DPRthwXDB8L7mRWAaCnblmz/7jEMHwDhvgXb6LaxM7rVsQixsXCCMEtRKHBT12P0CRr0gsL3BrMdVvIxJa7sT6zx/zKxMoDFe3J2gNyM68RhqWfYTyOMe+uP8D9d34q6ltEzYlsRDwh/0JM0wVP+KPlkSk1CbUETgc/GwBr+4YQv39o2VtWjtrcGrkyJ79tZNd5cIHYARwHBymlc6O5qRBqe0oV6ZmegX16gScrod/bWFWllAqHhs92EpWaf6oS5aVfyZVkQyisraNpA9/dIcQsrhjmYw6LW8AtPhzvlNH443C9313/oiZuc0ozV9PI/lNWIkxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRiV8vEkSGXwRbuEj+SNMRB1u2uguCBnuAL0Vs33Clc=;
 b=D1sGChAY7sH/RgKQLZzpftlE2QeIzXzjKTe8Sfnie7ns3H80J5JIihrOXUzHentahiz8kkdFvESi+3QgsBv9EHc2v+QtH++/dJprzkUVhSDysBchkRWUH+M7xOXX+n91LLkMUmb6/WS3Zo8Ud15P3alaEBEn0eEweoCzrN3/8iM=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:34:52 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:34:52 +0000
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
Subject: Re: [PATCH Part1 v5 07/38] x86/sev: Add support for hypervisor
 feature VMGEXIT
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-8-brijesh.singh@amd.com> <YSNutt/E0bm0kKsl@zn.tnic>
 <844774cc-4a6f-daa3-89cc-4d2dc6ca22a5@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <634e4d5f-1b44-e715-0232-351d0ab57405@amd.com>
Date:   Mon, 23 Aug 2021 13:34:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <844774cc-4a6f-daa3-89cc-4d2dc6ca22a5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:34:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a1f72d-d3ba-4e76-a352-08d96664b1e3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44317C802A5097B6A1DA7E61E5C49@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIBQLhjFh/H/8ZbWkcDOaf2a4CcKlPAMT2uHjRv1AVoNC+MHERJOBTwUm2zPhmeggIeiCQrx/q0Cc3/ompU+W8cswZV/fXlSkJ2iZIddZn7twlrLPotsxzgdZCiY1H7yc9i3ce/Fupy5QQSpr3w4GSa6W1SFrkg/mQ7aZj+s48D1G1Z3jDLLfC1b5QYPbUgbe7XU+RcQze3DErbvu0ieAWbRjJwZM24wo3dCtWXELjKyyCgsbzlvxQ9TJyY+yiNHyKdrCF5OFEEWJiFXpo+Fs1zdXaVO1J313853+2PDbpZsnK5XjTFsoQzdKCTtR8hrDyccwEl02co4R9XU8oMZsjYm1vOU1xAis1B/e4fvQrXiHS/VUH3oJKUAOwyJO9rT/n5vCmqKtp0HYjkYJ7GpErkqBiZKx4sjDWuslL5EEr5ghgsL8Dy+pBegNuw0tiGkOP2jU0OM7x6DYn5ILGDSIQ0kSt8YxXEpUD0uQcUt30zyIqInVUFzT8z58psa3HgIEwfC4yRPrceh9lHDjUUn8Ed7N2+McXiQUF/a/USUWSEJK+nXaNXG4bbPf4ExLZOl4n3g2FrEWnHolwWbahVd9pzX+R066nFOBSTsR/omnj6Vo68ybDcI9CUop4z7rj9BAP11UMIU1de4USzVOJUBJRXM9bB1HldJIYx/xiWI1+nydg09b3j3+LnkVbHbYtjqlyiGPo6DFWHTW08zYv//aOPC2OW8TqjN1YXQhbmJiFFNqpqhMkp955uelxiOMk6fcgX5phCcPPo+YrNyG9Idlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(7416002)(7406005)(6916009)(26005)(31696002)(478600001)(52116002)(4326008)(86362001)(5660300002)(31686004)(54906003)(38100700002)(36756003)(8676002)(6486002)(956004)(2616005)(44832011)(8936002)(53546011)(16576012)(316002)(186003)(38350700002)(66946007)(66556008)(66476007)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BlYnJxWjZQbCtEMURTNTRBQngzVEhLYWxIQzBTamRnWFJQSnFPeDIwNDVV?=
 =?utf-8?B?Vy8vVkdLY0VlR09BV2VIdVlPZzlkT2t6L0hRMlZDbklab09wemgwckhYeFhQ?=
 =?utf-8?B?blV6eTNmMVhGQVNCY0Jxc2QrUUFaM2V1YkE5ZUNpelZpdUhtMkhrMTVJYlhN?=
 =?utf-8?B?dktjRnRSOFFNWHdmWElrQWgwbVlRWFdnMS9rMXhQVjlvQWpOYWIxMWt3QTRj?=
 =?utf-8?B?VUFUb3ZTWFZHaDd4cFBuSkRFWHFENmFjelJUQmZ6TE9SYUZML09BVTVEZFov?=
 =?utf-8?B?NUxvdUEvaGhUMng0aktXMk5yQ2ljYlFBOXhpUTU2OEtYRW1rdFI2Wk54NGg0?=
 =?utf-8?B?S3hBSFcwUVRjbUI0ZmNRR1NoOW9KaENnL1haS2NMRm5IMm1mZVVxSEt4N0FB?=
 =?utf-8?B?aHY4RXJFSSs5d212VHZSQVJURGYvaGtIbU5LUm5Zd2hWOWJ0OHFiWFZUT3di?=
 =?utf-8?B?Qk16Rm5zYkpDM2dPWDNLaVYvSUpOTmJreFdwbVF3UG1ZeW9MM2syY3NHSmlT?=
 =?utf-8?B?VDR6eG9WMWgraHljT0RWTDg0RkVRRVNpZG94M0dkMTF3c3RMTmtWb0UvbFZL?=
 =?utf-8?B?cDBlYVNCTTRuNzJ0b0VXUjI4Q3dKY1phdVl3SFE1Zll4QVRVR1hwWWtyZWsw?=
 =?utf-8?B?Uy9MQ1lmM21rMVhtRG5rQU9rTUxid3Qrd1pZSTRyQkJPSHhFOCtxcllmT2c3?=
 =?utf-8?B?VUtyanpjdGREbURnaVlTZldPUHp1Sy9kaThSdmFpTmNieW1FVkN6SWx5N0pR?=
 =?utf-8?B?RXVTVVhkRE1EcW5FS2lkQ1NJZlBQRU8xelBTTGdYRUtTRTlWZ21aS3ZpdnpI?=
 =?utf-8?B?ZHQrTGtwbkNEV2RqVGFHdUxIdTVJaVVFdjdNeVJHdm1xUnFueXduSSthdUQv?=
 =?utf-8?B?WFVpS3lOS2VROURBcGlaMTEwSGZQS1dSZXJZeXgwckZRVWJoYXdSdi9KUm5t?=
 =?utf-8?B?Y2M0dTNiZG1Sa3F4b1VHZGt3T2pJSDJRUjNlTGw2QmVsZWRZd1JERUV1MVY0?=
 =?utf-8?B?aUxZcTl4N3hBejRUdkM0OS9FRUpxT1MrMEJzNHdHcXdQcFRKNkhJYUhRMkxi?=
 =?utf-8?B?K09nRVVNZDBCWERTYjZ5UnE4N3d2TTU5MTVMQjNKUURGYnUyTG1HYitqUGN3?=
 =?utf-8?B?MlhEdnN5dWNMYUt4WjJYMmxWTlU1VXpkbG1HRTNNaVkrbUl3NTZ3WUlaV3pj?=
 =?utf-8?B?WitIUmIranYxRml3blV5NS9mYXdxTVpTQjF6djVYcVBXclJoMXZIbVUzUXVW?=
 =?utf-8?B?OUpaNFhMNjluL2xNWGthL1RENXhseUJabE5seGtJUU5vZ09WcU1zZmJKalpF?=
 =?utf-8?B?dHBDNVBJTDJrc1huZjBxZkZHWXF0MmdycG00NTFSM04vdUtaeWtHWlhvY2RN?=
 =?utf-8?B?b25sUEdFWUk1WE5NeHYxRWJZdWxpSzhCWW9EM2tNMGJtY0F6VXorZHlRK0Jr?=
 =?utf-8?B?ZkNBMVJ4NUFINEZ0Nk1JUjZJd0pEcDQ5SGYxQUg5WnVhQkF1NUE4d05TMkxV?=
 =?utf-8?B?Q1Mzd2ZOcytvcGh3VTh3aWkwL01yRVZoUm5hQjNyL3VHMFJpUlV0eWtJaGNi?=
 =?utf-8?B?Rkl6NmRMN3dRM2N5Skg1d0ZIOENPQVJPaVI4Zm03Wkc1WGVFSlJVK1gyc2JY?=
 =?utf-8?B?cy9wRlVsV1VvZFhsRWh2NXRLbmhHWDJldys1TjA0RkkrQWpJZWdkVWh6eHNv?=
 =?utf-8?B?NU5tZ0JIQTlibEpPMEE1M2xyT1B2T2YxWmE4QkZaVXU3ZWw5enJzWDVlT0Ra?=
 =?utf-8?Q?nbVgPrB/A71JvwhrTgk3ooQAyqgzhnbWePpkXv7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a1f72d-d3ba-4e76-a352-08d96664b1e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:34:51.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHD0+oQbPg7qJEgvus2Ts7hhrAd45Ez4Q3IoD4RzldFDw7ODtypQkX7wVu8nNcMpJmyf4PIt8OpPNzqbq+IPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/23/21 1:25 PM, Brijesh Singh wrote:
> 
> 
> On 8/23/21 4:47 AM, Borislav Petkov wrote:
>> On Fri, Aug 20, 2021 at 10:19:02AM -0500, Brijesh Singh wrote:
>>> Version 2 of GHCB specification introduced advertisement of a features
>>> that are supported by the hypervisor. Add support to query the HV
>>> features on boot.
>>>
>>> Version 2 of GHCB specification adds several new NAEs, most of them are
>>> optional except the hypervisor feature. Now that hypervisor feature NAE
>>> is implemented, so bump the GHCB maximum support protocol version.
>>>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>   arch/x86/include/asm/mem_encrypt.h |  2 ++
>>>   arch/x86/include/asm/sev-common.h  |  3 +++
>>>   arch/x86/include/asm/sev.h         |  2 +-
>>>   arch/x86/include/uapi/asm/svm.h    |  2 ++
>>>   arch/x86/kernel/sev-shared.c       | 23 +++++++++++++++++++++++
>>>   5 files changed, 31 insertions(+), 1 deletion(-)
>>
>> I think you can simplify more.
>>
>> The HV features are read twice - once in the decompressor stub and again
>> in kernel proper - but I guess that's not such a big deal.
>>
>> Also, sev_hv_features can be static.
>>
>> Diff ontop:
>>
> 
> The sev_hv_features is also referred during the AP creation. By caching 
> the value in sev-shared.c and exporting it to others, we wanted to 
> minimize VMGEXITs during the AP creation.
> 
> If we go with your patch below, then we will need to cache the 
> sev_hv_features in sev.c, so that it can be later used by the AP 
> creation code (see patch#22).
> 

Let me take it back, I didn't realize that sev.c includes the 
sev-shared.c. So your patch will work fine. sorry about the noise.


