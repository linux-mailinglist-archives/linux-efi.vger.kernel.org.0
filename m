Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA815EAD0D
	for <lists+linux-efi@lfdr.de>; Mon, 26 Sep 2022 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiIZQtB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIZQsM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 12:48:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBAC24F07;
        Mon, 26 Sep 2022 08:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh3S401MLvn+Bg9iIq+504Jm0TaU0Whr/cG1dL/5//461c741hXe0C27cqEGO8Y/j1JZ7UdfHzurs/cMa7BdNQLF363ifpMhhiWtG9A8KLFNUjYcYcBk7BgEins1fjYKaRr8MEtHQWLXkavKWnLK1nxC/RMA1gq+IyA4cCyNGbEfZOj67qqf0slbJEUyMZIsdeN9DSaEGQw2Nq87II/G4Qr6GBvzyR6f+FwomD/gAyeXPtX2qclricfVsxlgRYjkudJBTn9qh7NkP9ksJ7cBtvJCvQ4q2qYVzdFSGLyeUy8DaDkEZ+2rBSgeeBAiQUq5Zr20h+yxEHjFrGaKeQcxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeLMbKsxLSQ8j5etohjB1FJyA5SjpR6pJq4vwExPi30=;
 b=jQpSmKgB95vPLBAaQWVQTAZbL+aFFZiHo+pPFKYeCz+yTNbWifl4LsdUQWA/wT7RgsUNZlliQvhGXGMCN9rsSL1PFszzMZb3hXD9TcnpwjuF6UV+J+vxzQM1z+GnUwmLktoE7CFVYT2zadPfDbF+nfDCjGS8zAatBjEmc1uH79pqjkOrUluUkuzapc/uyAFUrupUpRkVGI+ROKZE+hmdolpN91VXh0j7sZd3RGRIhPQgOPaYXBhrpQxYSKlPxU82IgYWbm15DvGID6vaaTyZPSj1YOGFS42OPTY2iCQMZPLZ8L1DAdmdfdEcKGoDBLk+EOp8i3H4dHUyb/hJY3alRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeLMbKsxLSQ8j5etohjB1FJyA5SjpR6pJq4vwExPi30=;
 b=0fC88AwwwE8J0bPJEcVJ/uFLTjlk3QOjUsv93bfmC+650OR3MnMWGo/o7NKh3AiydkUkxWl6ZqbgczvDQquceZrlyAT/LCyPDU9WvrhoRQ14KWA0Wh7DVN7RPJGFmeubLKl/jC8RUo7ju13mJAMup/spVVJoEshVgZJss6mDg7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 15:42:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 15:42:29 +0000
Message-ID: <6188f3ad-721a-cd00-2398-5ce3b0cd12d8@amd.com>
Date:   Mon, 26 Sep 2022 10:42:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
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
 <6a38e382-b9d6-98a1-d2ca-cd92fdfd8ecd@amd.com>
In-Reply-To: <6a38e382-b9d6-98a1-d2ca-cd92fdfd8ecd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 894e2416-8c4e-4f93-e393-08da9fd5b800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIpNY7uBynp0qARSuucBIUednUeLD3HR6dfR65hU2lETi9aafRtAl8jgOI5wmebOysmJGJ2mIw5g+vfYW7nziJt+uXpURYbZZaiFAzFi4guYJ+fI/qHSlmbyJSVCQKr6OVW7ypRDmJjApcQ29Xuu9J+7fLpPWJQNlEBk/E8zOxxWAcY+1ZJh68vevjLzOK2j9pZIdoP5PeKXbmUBLSNrjuICPRFcsVeKhq5V3hs5d4/IZzTOBlUa1pZdDcyxcmo1DD2crXRdss/CD4CO5MlDkv/ucJfnOKjdyrY052NO9y2Jdo3SBh0rI6nLSZ+NvOhsBPLp8Dwyn2EDDt3Ew0eLjKbl3g7+kAm0OJLQ/Z7O1lmnNwSVQczSb1gc5zith5jOLr5LDdIQ9O1ijETDLxl9ghZGQi3NcwN5FepaUe6vGRwzs6e3DfSubIOm26Xe+4s14qRaYYTA1etNQp5oiwg4dpXjO116HUzBdm8m9mw2kcSdAC09K2pAeESGZODt11cZ2Oh/Lw9Qn0PodhNtYiNT3XU/w0W3xPjFSH0LDmCqdAs387p14lNBrXy7S1eAM9JG1P+pLErQif6wkUaAkCMCEb3LUq9XPqTztVc/mspvXCbiC6GmJr2wBMdtkJavpYhlssrFiAyo4l0MrupVsR7bXBn9uxcNRILNCAR39gwx4tgOeRbj8ux4LXNZF1vSbAv95NkdcRpVwPD5uPo4TNlXIepqtwubCEreExoRv3P+gyvRPLuJZCfr9VAQg1zuDP2KMpfLdhwChOXFCSSAYATyKUncNOoFKPQrwY0h7vljEeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(38100700002)(86362001)(6486002)(31686004)(31696002)(478600001)(8936002)(83380400001)(110136005)(7406005)(7416002)(6666004)(53546011)(6506007)(316002)(5660300002)(26005)(6512007)(2906002)(54906003)(2616005)(8676002)(66556008)(66946007)(66476007)(4326008)(36756003)(41300700001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNNRkhoYmZIbm92Sm5jcXRmSWZUTHNhQ0RoRG1aK212SS9jVW9IKytCMVN0?=
 =?utf-8?B?cEJHY05rS3BieXp0U25KYjNBRzlROWZ3cUIycmRFeVprR3RsY29jbUY3Zmhq?=
 =?utf-8?B?SlR3UUlqcGo1UUFObnl2akYzSXF2TTRpbi80VFRXUHdaV255MVBPcHVwVTNx?=
 =?utf-8?B?MWNKVDZGOUJzdlZWUWhsZ3Z4c01YUU1vRHA0cWlSaklWdlNyS1Y1Y2JXVmJL?=
 =?utf-8?B?UkYxbkMrcEI2Z2NmUkMvMGkwR3IzNGxvN1lJRDVwVSt4K2syQmZ4dXl1eHVX?=
 =?utf-8?B?cS8wbFVIUmhGMGtEckNXbFVvMDAxUVdtTEJkbmd4ZmVaV3VvREZOemFybUVP?=
 =?utf-8?B?dlJjeG5sOXl4bjh0SlV5bVAvUGdxY0hzZXhRK0NWR0l2bzFQSVByU29WMnJq?=
 =?utf-8?B?b0VUUHNEU1RyOFZCRGwxc3FRRTVHSVFUZDRGcXlYcU5jQ25zK1o0WFRmQjMw?=
 =?utf-8?B?TjkrbXBUdHo0SURVay9qejNKY3J6a1ByZVhUVWg3NHpPbi8vN1VGaDVKbEto?=
 =?utf-8?B?RDJremt5VnNOMHlGUUZwQkJPMkJrZ1VZcXM1Y01xUjFVNWU1UHRPSW9GMUdn?=
 =?utf-8?B?WFlVZWh2SStaT2tDZ1EvUHk2SVJkZFdPT2VlWTBSN05MSC9uanh6dFdCOW5v?=
 =?utf-8?B?VWIrbUM5bHZHN2lNczNzdnlKdnBvVWY0YU9rUHQyamkxcW1QM3BTSlZYdEdk?=
 =?utf-8?B?TzI3NURUNXFKclNhOWJmbncxMWVrVk9kdmw3ck9FbnVDN0NPRHFSb2w4aDMx?=
 =?utf-8?B?L2szeVJwd2FCRWwrVWZOd2w3RHB1N3FIT2tYTFJ5NCtEbHg4YStEUjVvVk9W?=
 =?utf-8?B?ZDFCU1o0U2ZPMDJYamNPRlNpRVNpREdvbUhFZTRnL0pSODBEUmkxbkw5QmxQ?=
 =?utf-8?B?LzBsNVdRZ3FkZ2NZRk10UllmVkFJWk9mT0VnUFJQSVNXd0lBTVlvUkd4R2E1?=
 =?utf-8?B?TWZDZTZnK3lGOS9EZVN0L0g5UENWOU8wYi9pNHJSeUFqRHd3Si9Wd2VnOWts?=
 =?utf-8?B?UEVGU2VkQk82ZUViK2NtK0ZQamRxWWhhaXJoMkJod2dab2huNmYrc2F4d2Za?=
 =?utf-8?B?REc2Rlhhb3RQRVI1Smd4Wll0c01ITTFPL3RRaEtKajhkZlN5TkVkSG5kanB3?=
 =?utf-8?B?R1pFNEoxdW9ZK3dyRE5aejJtRGZ3ZUVJcS8yZUVsU2gxSU9uZ3c5L0Z2c1h1?=
 =?utf-8?B?NXBJUThvTUNsZlNMMmw1Vk9SWThDczdpNmo4bHRpZEtWSUtSL3BoMFh0b285?=
 =?utf-8?B?V0oya3p1VEhWS2pIeE1GWEdOc1hiNjVwNGZGN2xEeVZSMU1YSnNPbGdRSmk2?=
 =?utf-8?B?RHQ5U1dFaVNMZktBQlU1MXAyUUpzOHduTFk1bi92QkpDMjdhTGJvcW5jY3Rq?=
 =?utf-8?B?bGRTY0FvS3RPZys1VVdZeE9hUDcwUThBZ3R2WVg5QTNMR2Z1VGhEdU5jQXRZ?=
 =?utf-8?B?bVhYR2xzMGlXYWRqL1Frc1hrNmxzVCtCS3B4LzVYQkNqT2dObUpCa2s0NUxV?=
 =?utf-8?B?ZldKcDcxR2svdFltREZSRUZHZHRKTlpvNVpBWVVsRHJEaHlraDN1UGVVNGN5?=
 =?utf-8?B?c3h1YjB2Y1BzR3lyOGtlNmM5SWZzOTV3bjI3OExnczhoc1QrdFB0VENnUFdi?=
 =?utf-8?B?TlUzSUs3MWk0YmJvRzhxVG53NVhiVFMxd29ZWjFxYy9OSGZYWHRlQnIzTVB4?=
 =?utf-8?B?Y3VzYWtKQVZJcE1JSzFXVzE5WWt2RkVNV2V0OVU0NDJZUitKd0wzN0ZFRlA0?=
 =?utf-8?B?VWdUcUNNeUhoL2pSdzF3RndHb0owYnVxREJTY3VjRWJYaGxwbWt5cjJXSnRU?=
 =?utf-8?B?SXBobWRqclEvY2hvMEdZSk9mWU0xY2YxTG1jcURaN05kZ0FVMGNjdkY3bUQw?=
 =?utf-8?B?RDRjcStPeUc1TlNyN0RSc3FCM3o0UDRwWE9wcjVEYVphVnA3cW9VV0ZWTlFI?=
 =?utf-8?B?c05HU2RYSDNsaUpIejg4amxMRzc2djVpMTNpSFFpMG1qTW9KNVprdWphNFZl?=
 =?utf-8?B?QzMwdnM3ZjR6aHptK2YvUE9NS1psZlNBZVdvdlk0Mm1BTWdTNzA4SUhzUTc3?=
 =?utf-8?B?ZURrd05kVytMVXh1c1dFaGVHaHRPUjlyRndEbkJzc0JBbGU3bnlzN0dCK2ZX?=
 =?utf-8?Q?3dJJTY1jllamUBFB8+pS4TnRZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894e2416-8c4e-4f93-e393-08da9fd5b800
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:42:29.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFtXEel+SdQ6J4EtWaKXrgSahc3WEr84QEczZFKrZyV6LhICBUUVm3DM2Y72q2XaX2PqXO22G4oRDx9Z25Qj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/26/22 08:38, Tom Lendacky wrote:
> On 9/26/22 07:10, Kirill A. Shutemov wrote:
>> On Sat, Sep 24, 2022 at 04:03:02AM +0300, Kirill A. Shutemov wrote:
>>> On Thu, Sep 22, 2022 at 09:31:12AM -0500, Tom Lendacky wrote:
>>>> On 9/8/22 14:28, Mike Rapoport wrote:
>>>>> On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
>>>>>>>
>>>>>>> Looks like the first access to the memory map fails, although I think
>>>>>>> it's not in INIT_LIST_HEAD() but rather in init_page_count().
>>>>>>>
>>>>>>> I'd start with making sure that page_alloc::memmap_alloc() actually 
>>>>>>> returns
>>>>>>> accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the 
>>>>>>> memory map
>>>>>>> will poisoned in this function, so my guess is it'd crash there.
>>>>>>>
>>>>>>
>>>>>> That's a wonderful hint, thank you! I did not run this test
>>>>>> CONFIG_DEBUG_VM set, but you think it's possible it could still be
>>>>>> here?
>>>>>
>>>>> It depends on how you configured your kernel. Say, defconfig does not 
>>>>> set
>>>>> it.
>>>>>
>>>>
>>>> I also hit the issue at 256GB. My config is using 
>>>> CONFIG_SPARSEMEM_VMEMMAP
>>>> and fails in memmap_init_range() when attempting to add the first PFN. It
>>>> looks like the underlying page that is backing the vmemmap has not been
>>>> accepted (I receive a #VC 0x404 => page not validated).
>>>>
>>>> Kirill, is this a path that you've looked at? It would appear that 
>>>> somewhere
>>>> in the vmemmap_populate_hugepages() path, some memory acceptance needs 
>>>> to be
>>>> done for the pages that are used to back vmemmap. I'm not very 
>>>> familiar with
>>>> this code, so I'm not sure why everything works for a guest with 255GB of
>>>> memory, but then fails for a guest with 256GB of memory.
>>>
>>> Hm. I don't have machine that large at hands at the moment. And I have not
>>> looked at the codepath before.
>>>
>>> I will try to look into the issue.
>>
>> I'm not able to trigger the bug.
>>
>> With help of vm.overcommit_memory=1, I was managed boot TDX guest to shell
>> with 256G and 1T of guest memory just fine.
>>
>> Any chance it is SEV-SNP specific?
> 
> There's always a chance. I'll do some more tracing and see what I can find 
> to try and be certain.

Indeed, it was an issue in the SNP path, shifting the number of pages as 
an unsigned int by PAGE_SIZE and adding to an unsigned long. The value to 
be shifted was 0x100000 and resulted in 0. Changing the number of pages to 
an unsigned long fixed it.

There are a few places where that is being done, so I'll address those 
with some pre-patches as fixes.

Thanks for verifying it was working for you.

Tom

> 
>>
>> Or maybe there some difference in kernel config? Could you share yours?
> 
> Yes, I'll send that to you off-list.
> 
> Thanks,
> Tom
> 
>>
