Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA65E6599
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiIVObX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiIVObU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 10:31:20 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC88F3F80;
        Thu, 22 Sep 2022 07:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt5QyHTzYVXe4m1IAaj9y0SUOGbdxKyBP/wFfhMMp6b46sXuDhvvipON/CWJXLw9mnVXlssL0nhksQorgrIoDeCNeBJ0VWRvTF6mlKk2N1NttvJJSDMRn/Fw++5xSTD3zt9CFcBnFvMzaCR7rg7+7dzVfwwrbglFk6stcL28ns4dJv2H27voki/ufOYfewPZm7uWW386pjZ5oKgUBWXAbKVzYo/9LAEUCM1uoHKbY8I2NxhhsOLMZTpI+W44QfGwfP8pNJJ3aRGx5WWkrD6aW3h+ap60XOZFvRJ47U8y2DcmniU3D03sOLysubAQ59VlAHlMeu5VR8FB7/LKxaiABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESZz7ql9Qw6mAXz9znaWhUcp4oNiuvMOS83VKJba+rY=;
 b=mFlnUHu4Plg3jlPChT5R7qlF8omlMPtO27W5cqbzqYMKUo5T6HGtOHdahIIKd4Mz+2mGgRLp6ZN08txljsgPen0Qg2asNt/WjsztvE7ZUfxqHlg053XCS4T6kpRSprU6heoJbnTmJYNOq+TiE1/YjP408F85K/Q4qEuvETQD5tJgyIvCensZSI/DJwr4r4aNZ3qMEHKN/LcRdjFcTW1CFqQFUhEpxRcYRfLpfOr5RWjaFPjOBEC3ihUJlT94WoL+NoNcSZPfAoz0csN1LKW30yCjMyBIawIpWhtC0yLRuFAbTQzK1U/c/as97cpSRNMlbPoyVKjcXO7xOE8yadewUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESZz7ql9Qw6mAXz9znaWhUcp4oNiuvMOS83VKJba+rY=;
 b=hUTW4KN0nnE8mFcl/9LdiaA4Hs2ekVl20QsDTEC1SEgy7HDlWAvqCTcNooQ0oHbOQoemjSPC8FfhgxSuxTY072bl15xtPlSikjWN/bTXxbv1tn64LpzJt7G/dfnWPczOIXuy1AzDaJlcwPGXFFN5wGD1TQC9KbcN1XZqJ0QrOIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Thu, 22 Sep
 2022 14:31:16 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 14:31:16 +0000
Message-ID: <f72f7325-adc6-89d5-7cbc-647442308233@amd.com>
Date:   Thu, 22 Sep 2022 09:31:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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
References: <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net>
 <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
 <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
 <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
 <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
 <YxpCaQARczhZQmq2@linux.ibm.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YxpCaQARczhZQmq2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:806:d0::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5864a4ec-a94b-4eda-15e3-08da9ca71b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKxAsqRKmFJQ0hEUTQw3lNz0hi2W1Tq3hnrtD6K+1hQWD3PT6uRyRWpK6dc2MQ5hnEScKvoNBdsgRz2X8HDkAaXQrHTD4WL0vC2XJ6euDmPKZ4UDjPxTnBwQ/kuAMIqE23zzuw7jZ9C9kJKBbvUnux6YfIlRHVG2fjfi/azOpPBwaZmGgZ51oYQEokbKmxh5nZsQ2v6dJwkbNlQGohes48p+XdFaVqj2O2OUNPStZiliixYGSZkFAaaMWAerm8nzVlGn63FIaf9ooQwUizWrXTovEH137fiK0IbxSHTLg1qGrDGJBbpMaLCznnTz82NudfGjKpQhXd5g3QEhRDo1tityJz7a2/9pYr9bCXS9oyaAef/XREQReJj6jR8PUbF3Rs3EFsx6VcAZczDtG+KXwrHwt/KJXwxqSym5ZJ/SeqGmKbEyZzb5OIfZoMUmySVGioQnsj/1Ke3TqdHBYWId/Ill8gahBoFBABqUT9grFS65q8lMGKBz8gtthN61t/wsXI+tQ5WBNJpi0QDcJ/udIO/EUM0FupqbRAPboi5tzYE44PtC6wf2kk7Zsgag816b/UcgnYTs+64VrjGzJrAX3RRZ2eX4SzgIPgCcXHlCyrcYwXgX59E6xBGVGQ7hXSq2u8C/tNNA/8cxS9sK7RbngU/HBEFKISaMyVLHRYKFpfoDNvH495lM9auS1gdt+alrIaEGFD80UI1oieWgOVkKXuQqyzUD0DOg+tXFED5pO4Krl4LZhHw7qpSsgcEQ+PfA0acP0mKextdJ3/46I1jfbVVeMIp4SQn1Bln6XSBGtXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(86362001)(41300700001)(66556008)(5660300002)(54906003)(38100700002)(31696002)(8676002)(316002)(110136005)(7406005)(8936002)(66476007)(36756003)(4326008)(2906002)(66946007)(7416002)(6512007)(26005)(53546011)(6666004)(6506007)(2616005)(31686004)(83380400001)(6486002)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szhzc2I1MmdiZi9Rd29GaHRqRDI0K2xTMzNQV1MxODFLTWVub1ZWVTFSdnFY?=
 =?utf-8?B?TmdtemEycjlqMmhhcXJDa3UwWEYwWEFONmM2c3lWb1F2OVVPWnlpYXZFTXhV?=
 =?utf-8?B?NjhXcnQySStHSGFrQmF6QmZQOGRrcENBY3pRL0VYV1h6VzAxSkhUVlFDek1s?=
 =?utf-8?B?UHZuNm9QNlhVSTMzcVl6QjM4bG0rTzlvZUdHSlFtamkydzgyV1kvSmpmWDVC?=
 =?utf-8?B?TVBjZks2SGtlWEFWUko5N3R4Vm5pNklRNGdpd1BwcGRucS9Qd2w1blY0MW95?=
 =?utf-8?B?VGdCYS9qYmMzTDdSRFhQWVp2bDJVSkpiNmRjTkUxeS9WZnFaSVUyMWFkb1Q5?=
 =?utf-8?B?cXk5K09PSDR1N0pldGVyUUZYRS9FbHdOS3RwL0JKaW1yMnJocDR5ZFBIbjlF?=
 =?utf-8?B?dVNzQmpDdkM1dVBPeENnRlNDTm9UR2pLNk9jeWYzYXNBMVZURlZMckpxR2RP?=
 =?utf-8?B?dHE2Vy80b1lwU0RGNDlva2ZKdThtZnVnNnNaaUlDNk43SVdya0ROTW8xNzZW?=
 =?utf-8?B?OFo5Uk1pMmVzaERZN05HZ3AvcWhyTlJKc1IwQlJoeERoUUhUY0s0QTBacXNO?=
 =?utf-8?B?bVNIa2tqQ0R6YVJnaExhS29qMjhsZkJXNDNpeFVRaVdCRnAxb2FNMmtub2JG?=
 =?utf-8?B?dlpiNis3cXhLQSsvaEN6eDVjU05MVVVXL0pLbGxodG1vYlY0SUtGUTBaNStF?=
 =?utf-8?B?cVQ3WDRPempLWVpPTXNobEM3RndJR2x3NThrT3VFVVNnbG83dC9DUTVZZHY1?=
 =?utf-8?B?VXFjT1Z3dmhZU2hGMFRhb1ptN0k3YUhJRE9Jc0crWGpISmR4dDRxMGV0ZjMy?=
 =?utf-8?B?S2dMQytOYzlNUys1MWtuTHk0M0M5OFEzZE4xWU5BRnFDQnZHdnA0SHAzRnRa?=
 =?utf-8?B?aUhxL3dsVHgwSzFCZDUxN0JnNUp2U3J0bFRsV2pOQU5SakIzaldldE9NbDNC?=
 =?utf-8?B?UG5KeTZYYlNQWGRTWWwya2luOU5rV2NrbDAwZnJzT2NoOGNhTDI4Ynl4L1VC?=
 =?utf-8?B?VUs2K29HK1VBek85alpkRXEwZ1RvVHVvYjJ3KysyNndkV0dEMGtsd2hlamht?=
 =?utf-8?B?SVhGWEtudWZuSXJWbkc4dVNSeTdBczFrK2l5MzdhVTc4ZHNQNjlqN2x2TUVQ?=
 =?utf-8?B?N0dpT2dXTDhHVHBiTytVUERObXhQQ3QxeTEwQk5jeFBoOWdZOUZhM0s2UGVt?=
 =?utf-8?B?bDk3OTB0V0RhbUpJRTAxWVN2T0VQYVR3V0tLSHBqeldNa0lUUVpaczc2ZUIv?=
 =?utf-8?B?Tk5TTUVSZVZqM2d0OERybnNnbTRKZ21wK1lSbVJZSTl1eEZwbE1nNUVzbU55?=
 =?utf-8?B?UnZqR2FKQW1PRWVjTHRYbG1reHMxNVYrOVdBU2lhL2pMQ0FPQldqdWh6ZE9R?=
 =?utf-8?B?Q3VMVDRxZUt3d2xBUnBhUDlnazA1a240aFBlZ3pNT21aYTlyanVzNS9Ganpk?=
 =?utf-8?B?SVJaL0VtRjQxV0ovUTNTb0hzQW8rODl0cjZZdnAyRUVLL203QUlVcUZUYllP?=
 =?utf-8?B?azVGSG1XR2FUWVg4Z3EveE1BZVBrVjM4dzVmaVpsVDA0bkF4aENSRWdoNWkr?=
 =?utf-8?B?M0xiQjFiZkpLc2NYOTNTUmVnZVJpV2J3dGthcHdZSzFUS0o3SzF6Zm1OQlVX?=
 =?utf-8?B?cG5FbzhLRU1PeUtSaGxzUDhnczErMDQ1LzByL0phdlNrNzRKZDFmSDZPd05v?=
 =?utf-8?B?YisySHRsaUpEQTllV2dYb2hqTFVMS0ZjRTRHam9uclY5NS94RFV0ZW5DdUFE?=
 =?utf-8?B?d1pQSWNWcGlmRElKT0RtLytBNzc1cmVrWVNORHpwa2xsWVp0ZzZxSUo3OEZv?=
 =?utf-8?B?RXdpZElTQmplMmVqd3dyRVorOFdCeUc4VVN1VEtYNVNoak12b09YdlE2WWpG?=
 =?utf-8?B?MnVMcXpwc1BhdmwxZWlZOWdPYmZ5RU9xblpocUt6MFNiMUw5Qk9hV09QN2V4?=
 =?utf-8?B?TzZrdzlGNkdiRU1rZ3htdVZqSjJQQWRrRW0xK3BQYTQ1VitJRUlOeHV2ZnBV?=
 =?utf-8?B?bS9EQkNGRFVpRWNvbXFidTVLQXFCbElnL3hjNlYveUpub29oSlJOUmRhS2tv?=
 =?utf-8?B?c2pwM280N2F5RzVvS3RjcHkyY1RmUzA4eW9kZUVpK0RyTlhuWE1zN1liMnlo?=
 =?utf-8?Q?DrI+c/pwQtgkSa8AD+5i1LcrA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5864a4ec-a94b-4eda-15e3-08da9ca71b93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 14:31:16.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gH71Y7hMTqHifGHJMVppPsihNEBh3/lm+LYljJ2sTXpL/Jxfrnjk12mSCMrhg9sQ/QfFOZnWX88Hj5sjx6hEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/8/22 14:28, Mike Rapoport wrote:
> On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
>>>
>>> Looks like the first access to the memory map fails, although I think
>>> it's not in INIT_LIST_HEAD() but rather in init_page_count().
>>>
>>> I'd start with making sure that page_alloc::memmap_alloc() actually returns
>>> accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
>>> will poisoned in this function, so my guess is it'd crash there.
>>>
>>
>> That's a wonderful hint, thank you! I did not run this test
>> CONFIG_DEBUG_VM set, but you think it's possible it could still be
>> here?
> 
> It depends on how you configured your kernel. Say, defconfig does not set
> it.
> 

I also hit the issue at 256GB. My config is using CONFIG_SPARSEMEM_VMEMMAP 
and fails in memmap_init_range() when attempting to add the first PFN. It 
looks like the underlying page that is backing the vmemmap has not been 
accepted (I receive a #VC 0x404 => page not validated).

Kirill, is this a path that you've looked at? It would appear that 
somewhere in the vmemmap_populate_hugepages() path, some memory acceptance 
needs to be done for the pages that are used to back vmemmap. I'm not very 
familiar with this code, so I'm not sure why everything works for a guest 
with 255GB of memory, but then fails for a guest with 256GB of memory.

Thanks,
Tom
