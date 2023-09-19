Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F47A6791
	for <lists+linux-efi@lfdr.de>; Tue, 19 Sep 2023 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjISPIS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Sep 2023 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjISPIR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Sep 2023 11:08:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C430A94
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 08:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFN2eVMdtUTW+yv35cubaqojCoREYZc2VY7hd5JLL4mAh7oBkINoNg3v5fQVwUL83P59cKQJXhLRLXKnjv6H52EgS0SmxBDEz4fQ+BR5cvzR1yXn3V85SIckqzAJA67isOC36FgF7lPs+yM0dCOCjDDjnHBvfuAz7oEhEkr4whXgX75kPufUbGYGo0QYKCC47iSiGGGT0/TwQVRK48EoNg6dCKKCzP77elqiyoja/0vMivm2+gJgEO5vjWR2+dZfJkNeHp+lPNvWnuXJAu+wq3DCdiczL8vXcw0pQ6L6+m83wNVsEgAxnmLy6c/hhk58M4Gj/hgsgnmhgy+96uqtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa5tj2s1bZMTJ74XsHuctjuHG+5qcBxWPDsqGW/eO5I=;
 b=CQCW2X1W9TQ2Kuupv6tuNvN4XEdZaMi7kcjv4g6T3Va2f+9ycWYMWRS1CLhb3EsPRdKYVi2GJxXCVH7F+iFwrwGIZu38rQCpZVNea0dUv43y4DGyefPGtEPdbgLDQIzNI5RR1jM8cwmLAUg+q0kDhys4lStgQnZ/WRVSUKu0UPQIq46KLAsIIcUQjzHl1yXB8uPLYIjQ2UdtZFXGyM4KKJo9xvygz7JtQPJlvN3ChnjGhBxEWwJ9pekpEaTc1UyrvpS3i4oEt0zW+rkVsmMEWilXyXmlUDnWVRGnCUEGCWCe34bYTaiiA29tPnMAk10buFfMmtyyfika7o/TVS+uBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa5tj2s1bZMTJ74XsHuctjuHG+5qcBxWPDsqGW/eO5I=;
 b=00BtacDv2bYg29hvTkH4bzaAgUsYubKrDlDfg1bx0i6Yj8fBDqR2dhHz6IZ7KGcSg7ysk/z5lfZiWll3dP+K8wRi8qDhLZYb8CBD0DR/Y7iIyIcEDCR9a2zxQqYfEhUYsnQJyP+Vyb1W4F20iZbjhPRpGoshxBvwqmTl78CYzkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 15:08:05 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:08:05 +0000
Message-ID: <c4837489-8cf0-c924-b56e-3171adbc10a4@amd.com>
Date:   Tue, 19 Sep 2023 10:08:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi/unaccepted: Use ACPI reclaim memory for unaccepted
 memory table
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <20230816190557.3738-1-ardb@kernel.org>
 <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
 <20230918221054.nugkvobvfo6islsb@box.shutemov.name>
 <fd3f7247-093e-37ad-36d5-58c7e0d92a5f@amd.com>
 <CAMj1kXH9LvNMKRjtefxL=jZLXiD1mc9WhB83s21y_GsfpJhOLw@mail.gmail.com>
 <CAMj1kXHOCexDit0GGmFdeaGDviVtkp5eE=KwObdCua7TOs4kJA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXHOCexDit0GGmFdeaGDviVtkp5eE=KwObdCua7TOs4kJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:4:ad::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: c9773f55-4e38-4660-e0c5-08dbb92239ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czH9CyfFbJsg9ny/Z8FhFxXZPkSaudgo28ARpqCexPhdgWjqoIGessY93y2Wmc5nmm5K0NMzvSz0omXVLYOJBtEirJzQ8/HQd1/+EhfcECjobGf2fXiaLJeClVPN8wn+6sNsp9LUgLXBClB5hmDgKwwd6MuMeTozb5yi6sk/qA9PiK+cOFyDDc9s6mgbZXsinCEw+RhlrPzlHWJbhqfiXZ1wVEQpUs/dcUn23ucF8YRl4Yt8aYoOjM8jO+ps8Y5OBDAukUPnYGjxgfNKCAyDwz+dJr4xDAVH+ppBiRt/k0M1sksDazFVTVh4ka4OIRbhtiQk98whjDCMjlyGPdYmoNzsgdXPV29wuLKaXhbev0jD2l9Nh2WGVzLsUa7odp0buk0ygPTkPgzAYIFj3j7UuqGBY0G+x3wZTf/zHPBGAYnIFieXDcMk8oe68PDUYA2mO8ond4oRsgMaTnA2Ky+rg2T6SGXREzlWpL2vJQGvZTS31jCkpLtwzPD+Hz3DkFYivxvwnDOBd4HixbNSKqbTVgVQNM2LLPtLk9OtjpZMSko6YsDKalvAuO8f731Auzez0UAAIpxOQ8gGr+hQH+48nMTn4Zdje3gM9J3l5q3KLhyXimBong7q5lPBTFgdpxzQ273BG42xmqz5LlgegyRuzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6506007)(5660300002)(6512007)(83380400001)(2616005)(26005)(41300700001)(316002)(6916009)(54906003)(66946007)(66476007)(8936002)(4326008)(8676002)(2906002)(66556008)(53546011)(478600001)(6486002)(966005)(86362001)(38100700002)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJNVURtZ2F2dWlWZFFkNlZTQVJVcUpBTThXUlF3UFpENEJBZCsrLzdUdmdz?=
 =?utf-8?B?NFU4cVhOSDB6R1Y1dU1rbzd6UXJ0eU9oS0lvaVBkSlg1ek9DRnZBMUhPQXpL?=
 =?utf-8?B?VnhDakFnOHhqcmZJcVMxZzRIZy9BRmxnQ082OHZNNGg5dHpHUVl0Qmt5RktM?=
 =?utf-8?B?VWpSYzY3WW1qQnRTdU5iSlY2ZXNKb3dIOGVST3V4MEV1Q1BTNFVxUVdhYTE1?=
 =?utf-8?B?d0wrMDZtdUs3NjV5eEVJUURXNFFROHFBTWRUU2JtS01nTGRQd3hhTlkvaEJl?=
 =?utf-8?B?eVNDSW5rUXJYcTdQSjZXbWFwWDlWK3R2Zk9mdkRGemtwbzZLMDJZUW90OS9D?=
 =?utf-8?B?UTVnc3lLdzlZWkpxZVlVV3ROdXBzUmpUVTUxVWovdUxTaW9GYnFwTUxYcXo4?=
 =?utf-8?B?V3ErRHlkTFRuejFIKy9zMmdSNENETGl5Nys0bm9nUlFmdHBFUjh0Q1FnckVB?=
 =?utf-8?B?Z0RLQXMrVUd2NkNoRzByY01tWENuWHRjZTJ1STdCa2pBWkhLWlY3VU5zNkxu?=
 =?utf-8?B?bHFaVFdSdENWbkVVdlNyTG1XRmp0WGVGbHhtN1Q3bGFySjJtZjFuekJaWk5D?=
 =?utf-8?B?dUU0b3ZtUUNaYzV6ZWZGZ3BLdWk5d1EzYVpPYTd0NE9lU2xlS1dQaFdHSWtK?=
 =?utf-8?B?T0xhL1FBeTRrM3ZqdzRya2NleUQzYXN6a0NWWnIzeloxNjNrRXZiaVUzL2VU?=
 =?utf-8?B?UldwZnFaZzBTcHp0VVhHRHI4dDBmZFNKSDUzZW95ZHkzR0wzZmYrK2lBWWJz?=
 =?utf-8?B?dldCbTFoWDc4MjEyUzZobWJJbGU0bEQwemFrZFJtQ3IvbmVxd2hOb2NiZ1ZD?=
 =?utf-8?B?emVJVk50djNDR2NxbGdOUS9oc0xUKytIdDVxejRRTkJVUjRWNzFya2RISnB5?=
 =?utf-8?B?UHZsZm9ZbkFZRHgrdVc4UXkrZGRtQ2NSdERtTHlZOHpBZko4ZFFIc0JIOEh2?=
 =?utf-8?B?MU0vanRxVDYxdkpZM2NEdnJaaEtjbGU5NVBGT3BRaFVWeCtTenZBcUlpN0E4?=
 =?utf-8?B?VmMyNzlEWHJlUU5LaU5aUDc2NEpPS0ZrT2ZubjNvelR6b25mam5FMXJhUDRi?=
 =?utf-8?B?Nm9EZnY0enBtU3BzVWNaeFFySkIxU0Z5QUNjbStqUXpUY2RwSHpCNUlRcnhj?=
 =?utf-8?B?RjE4RGEvZGxDdGhRY3V5K0JHY0RxbkdQbXpEMDdIejFTc0x6TVpwK0NBQ1kw?=
 =?utf-8?B?T3NxaWxad0picVpqS0NPRzFhUW56dkZJUzUxdWZ1dERWZDRCcXVtQ1g2eE50?=
 =?utf-8?B?YTN6dkhtZDdDQm1KVWhRYzY1VXNvYTRtTFVrZ25vbEJFb2VDUEZJd3ZOd0xy?=
 =?utf-8?B?azlaV3ZtS1dZRWZSb09CQU1kN1p1Q0NOVGNMQ01YcjlWMnZHL1NYb3hXLzMz?=
 =?utf-8?B?QzFCUFZQcGRjSm1vQzVNeEVaSEUwYU1XNmdpYit6ZVlFcGhLRmVpZVg1R0Z3?=
 =?utf-8?B?Mk5uSU5KRkprcHlzbEl4OC9GWk5jSzZaK0o2aDNNSlFyaWNHWmE4QmEzeWdI?=
 =?utf-8?B?QVd5YUxHbjBKakpUeWVianV2L0pKSlk3bHhLSkZCZWxnMHpqK3ZwN1FuVlR1?=
 =?utf-8?B?MURzZ0FRZmtnaU1zRVo0a2l2ZGRyNWp0SkZ0MmQ4YXhvMTVQQ05pWUVUbmNt?=
 =?utf-8?B?dzFEOTdUVzNlUGVrblRhT3V3NDNFVjc0MWxPNEZBWnZoQVkzQ1lYcVArRzR0?=
 =?utf-8?B?VWpQei9pRURTNVYrZnN1RWFjakdta3lPNXBlQ0JQalNYTGlTRHVMN3dOZVNZ?=
 =?utf-8?B?WnB3TmxMV0V5SG0xOE5UbXhjV0w1dVJ5TmJZblIra0kzUkY4Z1l2eTA4WnVR?=
 =?utf-8?B?KzcvYWJHMnkvcndxU1AzcWEvRDQzWWE5a04wMFY3TlRFUDZEUmZGNmN5U3pJ?=
 =?utf-8?B?ak1KY0x0OUlQUnZ6UmtERWxQOFA2bEJ1NUxoUlFyRTVoN05qQVlKWmVyQkVX?=
 =?utf-8?B?a2I1bkhid3lZTHM1NU0rbE00VFMyazBrL3ArekJLMEJGQklITDJIY3JDcmNm?=
 =?utf-8?B?cTJxbFNkdkJ4RFN5OVNYN0xyd1FHRGhZNmpZMlJ6QktXWnlSKzFmeXZvcUM3?=
 =?utf-8?B?SUwyclp2RVV5ampmUHF1Q3M5d0RuWWtNVVUxRUpZeGdVRGlIMkxiYmI2ZGJV?=
 =?utf-8?Q?8S6S9EVne70i9UjrVOQ/hp0fz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9773f55-4e38-4660-e0c5-08dbb92239ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:08:05.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVwc1B6woABa80yrfRAYhdjRMN5I7FlNREAwrXLfE565JTvGcVfLg5eg+N5nIUQCOxcBCA634SQ5igRzBWvVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/19/23 10:04, Ard Biesheuvel wrote:
> On Tue, 19 Sept 2023 at 13:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Tue, 19 Sept 2023 at 15:28, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 9/18/23 17:10, Kirill A . Shutemov wrote:
>>>> On Mon, Sep 18, 2023 at 05:03:59PM -0500, Tom Lendacky wrote:
>>>>> On 8/16/23 14:05, Ard Biesheuvel wrote:
>>>>>> Kyril reports that crashkernels fail to work on confidential VMs that
>>>>>> rely on the unaccepted memory table, and this appears to be caused by
>>>>>> the fact that it is not considered part of the set of firmware tables
>>>>>> that the crashkernel needs to map.
>>>>>>
>>>>>> This is an oversight, and a result of the use of the EFI_LOADER_DATA
>>>>>> memory type for this table. The correct memory type to use for any
>>>>>> firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
>>>>>> EFI stub), even though the name suggests that is it specific to ACPI.
>>>>>> ACPI reclaim means that the memory is used by the firmware to expose
>>>>>> information to the operating system, but that the memory region has no
>>>>>> special significance to the firmware itself, and the OS is free to
>>>>>> reclaim the memory and use it as ordinary memory if it is not interested
>>>>>> in the contents, or if it has already consumed them. In Linux, this
>>>>>> memory is never reclaimed, but it is always covered by the kernel direct
>>>>>> map and generally made accessible as ordinary memory.
>>>>>>
>>>>>> On x86, ACPI reclaim memory is translated into E820_ACPI, which the
>>>>>> kexec logic already recognizes as memory that the crashkernel may need
>>>>>> to to access, and so it will be mapped and accessible to the booting
>>>>>> crash kernel.
>>>>>>
>>>>>> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>> ---
>>>>>>     drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>>>> index ca61f4733ea58693..9a655f30ba47db01 100644
>>>>>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>>>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>>>> @@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>>>>>>      bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
>>>>>>                                 EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
>>>>>> -   status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
>>>>>> +   status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>>>>>
>>>>> I bisected an SNP guest crash when using the tip tree to this commit. When
>>>>> the kernel switches over to the swapper_pg_dir in init_mem_mapping(), the
>>>>> unaccepted table is no longer mapped. Here's a copy of the stack trace:
>>>>
>>>> Could you try this patch:
>>>>    https://lore.kernel.org/all/20230917170629.d35gnwb6o54bdrhl@box.shutemov.name
>>>
>>> Yes, that fixes the issue for me.
>>>
>>
>> Thanks for confirming. I've queued it up already, I will send it out
>> later this week.
> 
> Tom,
> 
> Could you confirm whether or not this is related to loading a crashkernel?

This was experienced just booting an SNP guest, it was not related to 
loading a crashkernel.

Thanks,
Tom

