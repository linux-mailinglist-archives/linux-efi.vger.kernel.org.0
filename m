Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5220D5EA9A5
	for <lists+linux-efi@lfdr.de>; Mon, 26 Sep 2022 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiIZPHz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiIZPGk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 11:06:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411DF34C9;
        Mon, 26 Sep 2022 06:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8ARegjXYxErCLrRkfeSQliCf6gmREU7dJ4tsbZDAvYjxqgFkRO6ehDe8VT+ILxMF4a4vDXG8MFyZp7n/wIc+2ISt1q901fnF2u5AQ5did5IFTfGV1d/11fHdxjW9W7gSpNNvEVaMnOlk1B3V/6pNd4+UP50HPvbbAuNzJpROVqWCk66vxZnAXNSy7jY1jgy/51hvSegP2LqR0MSCS/vH2J+LyuSc6Nj/qDNaQzdelyv7641cTNNFL+YWXiNhd232tlXc8XeBXjl7PDREJOmaiYuElj/xeQ2e/LrGP6M6sU4NJetHRyt6eikJiF+1464v84aMmfcp/DAPx0eREWzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgRDHw19Hs1Y8xPbwSm+wkq6/O1jeGl+o+tkBkC06BE=;
 b=HXM1u0fcz+KaPyEZoU8t1jeqqgA3JqBAeWaouNGWWO411pJFiqLP9zf0foHo6D8yuVMp6L/jjgRvTJ8lG0JVOoMXAnym3FIAiuH5mTvdrslJNgJ5W7bkSSf8pGyTWkaodC4yZdn1fV8sk/F433fjHqcx2JZUxBj3saGi5fNE4URZKOhOPw/Bei1gYOnFpsAC3OzGPw7kW0XGgRcOYm6dnb61YaiwKcvWcVkGiz/izzuAt2FchI/HjAgVcilioU53EImhABPE7O9hItheh9tp2VVkC1aNPMkxu7I/l0KOJYDu7e+OGTh2WjBsXA9Rv60K4kSwZt3whZG6PF72DYOJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgRDHw19Hs1Y8xPbwSm+wkq6/O1jeGl+o+tkBkC06BE=;
 b=nYoVOXOt3aBatuWUfMmJ3zJoBlDJ+k5I+Ckj/1GzGroF6jdhpCLYDj0ojh34ktipBSdD1f9nqCBCz1TRAm6is0bSVty/zFlOOMej5IUS9E3+Ql942QMeZ71idYT3T8NeinFbJ/XJImFz7jF2lEdvXVU221Wc4K0s4FPQzdVSjcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Mon, 26 Sep
 2022 13:38:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 13:38:38 +0000
Message-ID: <6a38e382-b9d6-98a1-d2ca-cd92fdfd8ecd@amd.com>
Date:   Mon, 26 Sep 2022 08:38:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
 <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
 <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
 <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
 <YxpCaQARczhZQmq2@linux.ibm.com>
 <f72f7325-adc6-89d5-7cbc-647442308233@amd.com>
 <20220924010302.bwas4zbro37rrxai@box.shutemov.name>
 <20220926121027.xc2cgzuiafcssmea@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220926121027.xc2cgzuiafcssmea@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: f990654b-0e1a-4e54-33e9-08da9fc46b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ifcp5EYn70d4JGuMjT51lwgSgFgGb2RRtu4oCN1EjcR6vl9w4hlILHDhYLl05bGgmaIXaOEFVchXUXcxNjqU6eu9pH/xEacANWbRFG24ab5PnIGPUUilg6yT9sz0rxqUteV5GD9MuyviB5SNR4qmBYqyoDTiezsD85BMUQyjoSZtO8ooQP0j8pyDxeU+gtYhffRZWkwCdp0lGXyW3uwgQxozO8WwV5CKiU3zusfMYnJWlzPK5Z0Gu/kasWXk8pURu2BNSfQuGHXWq/0qLVI/YeqqMiWrOlqGni2qUAlc2N74MpA0FtUbO67X0NREZ8luuB4anuKWNHeWn2n9wgmAjx30+wO4GA7Ohui7yJlkK3RUYmKtPtaKvl91IXzsx6P5BNnw2yVhju8sfcih+eZ8ZCBp/YlN1CRrF2Zew4+EtdUWBNGO4Ra8BIRSqb/dJ+s7xxgKBRrJMnQUCCJbS42J31knc5OjAmjlo1FIczk9QQ1l60ayGEe+OafotnSZ0uSHyEf1i6joDywAHyc+xnuLxJenUCPg7s3w15Xzpy04BCCW8BdHAqdMCRDy5/hZ2n9cBcu/tvPwdDeioQilQ8Uengy8d1kuL6MjPuDFCPgbZE1eSEylOHXiwRqEUlTa5bbJ4hDCZUXaMDiDaWPg1GWDwkVu+SouOzzX/a6B6BFbiHOvD81A2LDq5QzMFTqdse6yufJwW/hGc3EjLAqAKNS7rJJBJMOm6vpTAZOjdyepHhIQo0PglJN6T1+dJhMcfO1J2dTVXFU4pOhRAaPoW944Z72fxxckco5lFUdUNlve+tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(110136005)(31686004)(478600001)(316002)(54906003)(8676002)(41300700001)(4326008)(66946007)(66476007)(66556008)(6486002)(8936002)(26005)(7406005)(7416002)(6512007)(6506007)(38100700002)(53546011)(186003)(2616005)(6666004)(2906002)(5660300002)(31696002)(36756003)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tyOXl0T2VTZXJRUGd4ZlZFWk9zVXFub1FmclhwRnVPQkp3MklRVzhubDhm?=
 =?utf-8?B?WnNlbkRHcm5QS0gvN2RvWVE1R2JaYzV6YWJOeGFzdlRiLzRpZnY2UUhNRnhk?=
 =?utf-8?B?ZEUrWXJ2VjU4Mmk0T0VrVGxVeUpNdzdKbTBhSHhMUDN2cUlMTjdzeTAycWdm?=
 =?utf-8?B?VXdIYWhmLzRPRk5NZklkWEc0bVV6eStRQS9iS2tuek5IMW9iNEh3S0VrNjNQ?=
 =?utf-8?B?NDBSb25QV2szMCtBRVY1K2lUS1RuRkM4QmN0Q2VIZlVQbUpPb0NnR2tvOGRu?=
 =?utf-8?B?dlZzVURKR1ZCa0VESVVXZDBtU0ZFRmdyR1ZkS2h2TFBDZWN0YnI1TG9SdzN6?=
 =?utf-8?B?aWxKc21NSnhvRW1SU3hsTTVpMCtRTTgrNlBFUjFtRlF1ZVExTGNJMHVoN2RN?=
 =?utf-8?B?VnZhUVBPbEtIZ3pXekpiSGxoYUZoQnoxVTZyQVFpcVh6THY2QVk3aXJ0M2Yr?=
 =?utf-8?B?a2NqbDJOeC9SckFIVTZFOExyeldUb0hVQit0TWxhNkRpdkVkK3BLdk9UVXcy?=
 =?utf-8?B?bitERk1NdzRYNkNGMGR4TzNuYnFSV1Y4UjFKb0FYblZOUks1ZzRZMks3KzdI?=
 =?utf-8?B?R3h0V2tVS3NlM01KS2k5UUd2M1NPV2ZMaVI0aCs4NWp2cHo1Ny9xWXQ2MDhv?=
 =?utf-8?B?c1dLMExxbkhHaGw2ZEQyQWxWeUJQT2MxV3BNaFI2UEYvdVpncGFITmZwY2wr?=
 =?utf-8?B?S0FqdDJLVCtCZFpZMGxpSDZCTzhLYVpxNXN1N210Sm40VlpNTnhsL0JWbWE2?=
 =?utf-8?B?aGttYW1QWVg4SzFrV0FCV09OaHdoVDNIWUd3UE1adVd0RnR4ME9vNXpORitx?=
 =?utf-8?B?SWxHMzhLSGQwZVVucDd3RHdiL0NiMEhLN2JlVm1CeGNyM0JhMWpWS2t5K2l6?=
 =?utf-8?B?R3k1dmlhYXdWS1hnbDZQby9nUUhJS0EyNTFEVDRkQkpoY0hmeXB0TWZRY2Zh?=
 =?utf-8?B?aExUc2d2ZldpaVhOUlFJUHNBQXRpNFFab2R3TzdsNEFoWUNxcENhTklRRUl2?=
 =?utf-8?B?Vk14WkRHN09wMDJOblZSR25NZ2k4V2F3RXR3RDEzRXRWWFVpbm04SWJKMzFS?=
 =?utf-8?B?Ykg1SjZQOG8yWVR5SytPUHFDQ3NGMmd6Q1VlM2drQ3lFZG5jRzhKanJ1eVJP?=
 =?utf-8?B?SExMbUtjblBVZEExU0krdW5tRW5YeC9Ia0J1TkNWUW5NU1dtSWpXcG80NUNp?=
 =?utf-8?B?ZnJreGZVUjZMMTBEMExCWXoxWHdwQ0c4a0s2KzBhMlAxNlpTbEhSM0h1TGxn?=
 =?utf-8?B?WG1Uc0F1UEx2VXZkbVByUWpKNjMyeWV5ZzFGOGNqQ2loa2JUMEV3VEJXSWor?=
 =?utf-8?B?WjY4ZlRpZHpVVUd4enhBTnRHRXphWW8vZ0xqb3ErQ3B1MUxJZ0tSMm15LzB1?=
 =?utf-8?B?WGs1WURVYTRyNzJubVFSMWxGZFRvdmtTczJ6MG5zMnVSMmdHTGtqaWM3bkVI?=
 =?utf-8?B?UUhhVTJNNUordWRSVGttbWE3bXl0VkJXZVJZd20xcllCZWZvbXNURjcwUk9N?=
 =?utf-8?B?SnlTSjQ4WHdjSjNBY1dGYkdLQXNOK2ZtSCs2L29jdnJhcFBHaHhyd0RqOTRV?=
 =?utf-8?B?d0R0QmVnVytaUkVUd2xTRWJJTFlrVGZPeS9sU3E5MVJvWVJlZitnaFUraHVQ?=
 =?utf-8?B?WkNBS0Y1UUpJL2IveS9qUkJjWlJiVHlOWVVScjZqSXlqaUIwRWdlNWtUMlZY?=
 =?utf-8?B?aURmMi9Ddm1zS2R0c3FlSmFWeStBSnA4cjlsRW4yYmsrSDhtZnpSa0EwMElt?=
 =?utf-8?B?WTJRdXRvRXlaVXpMdnVmaVYvdnJ0VFVkVmM1M3kwV25lR3ZkN0pqREQ2K2Jh?=
 =?utf-8?B?KytxV1lhQURkRXN4SHRXMkd5cjdMajByaFkyWGZyblhWN3hWVWp0OTF1c3N2?=
 =?utf-8?B?c2c1ZStKUVM4dE9wUUhGQmVlZWplWUtYMGcyODZqcUVoM1NZM0pHcTFPczBz?=
 =?utf-8?B?dkR1M3ZNN3JPZk56b0FnMHVhM1BuRWd4elpSb0d6dkxXM3V5bm1jRWllMlIy?=
 =?utf-8?B?UVIrOXBFaER5VFpaN1RQblMzMm1GTVdMOUxDZDRoMDhBSzN3cEVjUjlGN01L?=
 =?utf-8?B?WnRXMzZCakxyL3lJZTlyeTJRRUh4UE5DK29ya0dyNXFzeGZSTXlTQUl6LzJx?=
 =?utf-8?Q?ONtzV3LCj7iOHNZA5I3LPyQts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f990654b-0e1a-4e54-33e9-08da9fc46b04
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 13:38:38.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk/QmaeGWd5UMV0SPyq8pcb1JJKkJW0A/uUM8AFk95PRAowvvHFsXy2lfBelGzxKUYpQL1N8PRBOsdU6YaJklQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/26/22 07:10, Kirill A. Shutemov wrote:
> On Sat, Sep 24, 2022 at 04:03:02AM +0300, Kirill A. Shutemov wrote:
>> On Thu, Sep 22, 2022 at 09:31:12AM -0500, Tom Lendacky wrote:
>>> On 9/8/22 14:28, Mike Rapoport wrote:
>>>> On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
>>>>>>
>>>>>> Looks like the first access to the memory map fails, although I think
>>>>>> it's not in INIT_LIST_HEAD() but rather in init_page_count().
>>>>>>
>>>>>> I'd start with making sure that page_alloc::memmap_alloc() actually returns
>>>>>> accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
>>>>>> will poisoned in this function, so my guess is it'd crash there.
>>>>>>
>>>>>
>>>>> That's a wonderful hint, thank you! I did not run this test
>>>>> CONFIG_DEBUG_VM set, but you think it's possible it could still be
>>>>> here?
>>>>
>>>> It depends on how you configured your kernel. Say, defconfig does not set
>>>> it.
>>>>
>>>
>>> I also hit the issue at 256GB. My config is using CONFIG_SPARSEMEM_VMEMMAP
>>> and fails in memmap_init_range() when attempting to add the first PFN. It
>>> looks like the underlying page that is backing the vmemmap has not been
>>> accepted (I receive a #VC 0x404 => page not validated).
>>>
>>> Kirill, is this a path that you've looked at? It would appear that somewhere
>>> in the vmemmap_populate_hugepages() path, some memory acceptance needs to be
>>> done for the pages that are used to back vmemmap. I'm not very familiar with
>>> this code, so I'm not sure why everything works for a guest with 255GB of
>>> memory, but then fails for a guest with 256GB of memory.
>>
>> Hm. I don't have machine that large at hands at the moment. And I have not
>> looked at the codepath before.
>>
>> I will try to look into the issue.
> 
> I'm not able to trigger the bug.
> 
> With help of vm.overcommit_memory=1, I was managed boot TDX guest to shell
> with 256G and 1T of guest memory just fine.
> 
> Any chance it is SEV-SNP specific?

There's always a chance. I'll do some more tracing and see what I can find 
to try and be certain.

> 
> Or maybe there some difference in kernel config? Could you share yours?

Yes, I'll send that to you off-list.

Thanks,
Tom

> 
