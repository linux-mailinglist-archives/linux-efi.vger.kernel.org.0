Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41777A64E6
	for <lists+linux-efi@lfdr.de>; Tue, 19 Sep 2023 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjISN24 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Sep 2023 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjISN2z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Sep 2023 09:28:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E3F1
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 06:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmSu3Rc6RxhOf1B4ojOcgG7mmIYCUBIKWn0kZyo4yZUlup9r2aPArBox6/0SEf4sb2/opPgYDg3CrvwJXrq9J/CSBT6UAVcPnZRjNojfMbIDCSE0M8mf00/Rf6XmjQ59/7obSEGPFxT+WMcHxO68L42dbYjJzeRVl3M81JlEf8SKYtLkJ5nLH+5zijzPdYIYUeokDH6UPiqX08Yyh8WL5XT3wV/xPpj0rpXYTNuH4y2nigWp2T2kgK7okNQFWoEATZe7w0lPcnvBn3VEtahvDS7ISbcvIBI3UoGVokb5s3SIgxBxV+VqKssmirc64a2OmZgQtG5ZEm1LqubbjpapjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFs0/YxeFYc0Oo62HVVsmlNWsDctHpZ8Q7FpVjiTtZg=;
 b=IOt+Rk5JmL6z6DaXRFlXyodo5RNzDl9YKyMPvaZKt3QYecCFlRmKXvj84tEY5QLv8P16YVfrGKAWmuytT5ZqXRMBEmTHQ+/XUht2v+N+4eTyUxFeP2a30OWkYsylE1uye7w9MNqZqGdOQIhNLGPZPx5Y8/G4TK9U3HcyhYbgnJUvbHMfw2XRM/ucPgODbzuIrZ42oJEWT1CygGDrhhPm6pJjJNT3VMfZBwIV1s82N8FjMvApMEcSey6llok+FrwpdoJoqUU6Id28kEL5wuG1woapwYdBcZp8xsMKUFg/Ml4EYCnFODnbQMi/0wPQwnsxGAIm3zeXG9+pOZ3RmPfOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFs0/YxeFYc0Oo62HVVsmlNWsDctHpZ8Q7FpVjiTtZg=;
 b=z6qw6ehLQMOplr4UEHPWEa35w6YuuE7xiZOdKQGC1alPYjtOSGijeDQRFCtNu91aqwXFINSBeYSFMGZ/6kgM6XPkjU4FUcuBTN1sdPcMF7Ss3svtGWysG/nAnny/821JHFanhZyeRNhDdm6a/roUA3bpev0fJvcYjy6ngksasJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 19 Sep
 2023 13:28:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:28:46 +0000
Message-ID: <fd3f7247-093e-37ad-36d5-58c7e0d92a5f@amd.com>
Date:   Tue, 19 Sep 2023 08:28:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi/unaccepted: Use ACPI reclaim memory for unaccepted
 memory table
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
References: <20230816190557.3738-1-ardb@kernel.org>
 <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
 <20230918221054.nugkvobvfo6islsb@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230918221054.nugkvobvfo6islsb@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:806:f3::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adc0bf3-7223-4608-bac8-08dbb9145a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rQZ7PIBRk6HyQsTunzqGXJr1i8i3iQN2LAYuR0aTICDIsuzIJZyxAKrNEGh/TVwM+OD0GBNFEsPeS4S/osqKBgMpU269zsrXXvx1PSg/+75vQjgXgz8BhaqOq4TWOEp5YDHzizC1go96HLCZG51wTmf9zlOFOvIfes7t7Ga/1uCDG/VznNhalgw0wd/UcsY2YH0dG5GzeqIJD3wuas2O5bhdikSjGN+BDDNXovXCK9GwfKuCV8+1H0eVIGdhZPKgngRhonw1cyOmJlBVJv4bbaQauRM0M7mXiQT5YkRKUzu5fJ0WBmxRid2c8nMXk4CqQA+AAUv405uEwVIOyB20fqBWJcVE9btxtHe4j/LG5BSFOVKwUlpJViXEFJ3MmG3kYOqAU9AhHPvxerIaG6NKM61wEIR9l2Goazweu37agKioRLs6OI5+DCQUYv4xeUUR4JgZetIPnoYBY5XW3ANuYFyi9lgKHFUcmBKVxb1zQJM2McLzRlKgqMRjMzN/4oX5TsjSFngWqQBsT65GBek22ldMHrf/R8Vob17ngDlDhDIHwds+BSrDDSUkEYpoo8voUzF6pBHNB6yY1xcA3KrkWItnWtzGIOFPJZF3X9DPr9E6cxLOILiaACuMJz+y/WpY+t15cnRzVnMhgICyH6OdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(186009)(451199024)(1800799009)(83380400001)(38100700002)(36756003)(86362001)(31696002)(31686004)(41300700001)(6512007)(478600001)(6506007)(966005)(8676002)(2906002)(4326008)(5660300002)(8936002)(54906003)(53546011)(66476007)(66556008)(6486002)(316002)(66946007)(26005)(6916009)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEs0cGNJbjRnVm11UmgwSXZ2S1RKVEVQT3l0OUJlY2d6MHdoR0g2OVh0NFJw?=
 =?utf-8?B?NjdOUXlya1VhSTYxL1RWVkV5SWg0Y2FiWVBjQk04aVA0Z1MxeUcwM1A5SDZQ?=
 =?utf-8?B?TzA0N0M4TlIxalNFSWR1cXM3bUs3WFY2NjB2NjVaZk5RVGZPSllsVzFCeTl0?=
 =?utf-8?B?TzRKdnZETGI0ZGpsVCs3YVRTTnNpaXJBVlFMN1BiMjVZNDBPbXRHdStXbHg1?=
 =?utf-8?B?VmxUbEpNNzFFdkg2Z0MzN1lmUXNhVHNqeWg2UFo1NUtZdy9pQy8rbUpKVjlF?=
 =?utf-8?B?WE5TZmtBRHJFcmoxVytyOWhWS3FDV0lxZ2U2WnBOc2prVWhsTy85WEdiYU5r?=
 =?utf-8?B?UEwyR0FoWURTV1J1a0RuVGZKZTlFdThYSXlsME9lK3h3QisxN0VHR1pBWDBq?=
 =?utf-8?B?Y0M2MmpKaVVDYUtQQVlLREJsK2JNS0NwMGJPMGxCa3VjdGhweHg1NFd3MTh2?=
 =?utf-8?B?ZG1qRlNoVmFlNEZiWmtyL1RZYkR2WVhES1NHbkFWK1ZSaVVMQWFlRHBJVTZM?=
 =?utf-8?B?b0JnSkwwZncwekwzdm4rZUszS21PWmo2YWxjRlU0QTVSS2gwVEsxVjdoMmpp?=
 =?utf-8?B?KzVZK0FiMW9ZaWNvR1UrbXJWM0xXb2JJYkRWZlVuczJpcmpOelp6MDBWNWFM?=
 =?utf-8?B?WHFtdEl4NW5XV3VhM1kyekwxbnFGM0xUNVozbUhyYUgrNGRSM2RSeE9pQ3VS?=
 =?utf-8?B?TWIzS1FnYVd2L0txU01yN0xlbFBUQzNsc2hjbjAxdHFhc2ZCQUpFU0xsWDFR?=
 =?utf-8?B?VnAzcE5tR21DYTlEOWh0T3VPdFI5b2NGVWdPeTNUV1JsY2VJL3ZOUHFwRGFi?=
 =?utf-8?B?ZTdhb2ZtbjlzcUtRd0NwUjBlU2JhdUlTUkNTYS9vR2JZT256STRtWm9CZnRk?=
 =?utf-8?B?TVpRUkFVRjJ1Qy9oM3liOXFZdFJ1R3hqaDBweW4vVnFqV2ZXUldWNnZ2OW9G?=
 =?utf-8?B?Qlo0d0NlK09IcVIrMUlDYlAzRXh5R25QQ0JtL01FSmQxUEYrMnZkdVBwT3Rv?=
 =?utf-8?B?UjV6Y1lMWlFrR01mamoyVVFHY21XQWtrZ2xvVG9iTjIyWm5CV3NQSGp1YkRl?=
 =?utf-8?B?ZThEd3QzRHFPNStIcno2LzJDenhpWUpvZjQ5TjRxbmtpL0tXY201VEtXYm1y?=
 =?utf-8?B?ZXVxT0hIVGd1YkFXTFBUcGJCTXZYYnFMNUhKZko3RnJ2YlducFlnY0hxUlNz?=
 =?utf-8?B?Q0RRRE5pZFdZcUUyekxvajZZb0xNbWFVa2VwUFdBdldpeVMvVEFLazdyNldK?=
 =?utf-8?B?K0dQVkUzbDFFcFRxZTZhazMva0VqUTVzVU4yZEdVemR0L09kWDd5NGMvc3B6?=
 =?utf-8?B?QmRnVXF1eFkwN2ZhUDBqMmNTbWQya1lwTU9KRzZHS1prOUZjaGI4cWp3VUEv?=
 =?utf-8?B?NEZpSTRGNHhCUTFkK1paakRqMzZEdUpONWpBN1h3L083RGpGVmpIRkZnNzNs?=
 =?utf-8?B?UVMwNUhJRzQvbDdscm1wNVZ6T0M1OWtOd29XQytHUXZ2WXY1Z1grMFM5OFFV?=
 =?utf-8?B?NEVtdTN6YzV2azBUQ3VHZFA2cVJzbXh3YzhrcWxPTkJRcUxvK20rZ3lEcXRC?=
 =?utf-8?B?YUkzYVdubFF4OU4zb3lCNVF4TDJXZFhNWkg3UGRteUNsakhUbjlrZ2NtZjBK?=
 =?utf-8?B?YmdBeEN1K3AzeVBnbmwrc1JadnF3SEc2WTZPODJnK2RzMnN1OHU4YisxVlZz?=
 =?utf-8?B?WFdPVUhTOE1WV0lKTkExN2IyTVA2czNEYXlvUlQ4Qm5MOU9yYlZIb2U1U2M2?=
 =?utf-8?B?Si93eitWc1NLSTBKdW5hVThoZEtoTFRwNlpTcjF4VVFXekxzZHNQcWY3OElm?=
 =?utf-8?B?blZDa2xJNVl5WUI0WmNYWSt1MklROURTK1JUQXAyN3E5Y3d2ai9QRlBpODFr?=
 =?utf-8?B?ZEUwYVQ5bkxFWXl0WGxCNnFVTk9lOVA5ZlJKSHlHZS9zaUNaRjRMTUpMck1l?=
 =?utf-8?B?SjhDK1B3OEZVNFlBYm1WR0hLWEhUT21hY2lwN1dlNEFGWnNxODBhMFdDcndY?=
 =?utf-8?B?SExIbU5CSnptc3B5bkFJempjS092WUNMOVVqczF6TXkxTmlBUlpxaGpBcUtM?=
 =?utf-8?B?NTcyemxPNlRoR3pud0JkcmRmTmJtc2hRYmV2QmRjeEI2NDdOWU1oeUNGWlg2?=
 =?utf-8?Q?dn0VtR8iMWoEkvaZvyShhSt0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adc0bf3-7223-4608-bac8-08dbb9145a23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:28:46.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCaalLIWwXbYBX2ntGxbydqVU4t/fw3UM3Knj1TvYHpX9RvAcxF3F08Z0dlFpd4LIdXDCGk3C23G7/LRp/A5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/18/23 17:10, Kirill A . Shutemov wrote:
> On Mon, Sep 18, 2023 at 05:03:59PM -0500, Tom Lendacky wrote:
>> On 8/16/23 14:05, Ard Biesheuvel wrote:
>>> Kyril reports that crashkernels fail to work on confidential VMs that
>>> rely on the unaccepted memory table, and this appears to be caused by
>>> the fact that it is not considered part of the set of firmware tables
>>> that the crashkernel needs to map.
>>>
>>> This is an oversight, and a result of the use of the EFI_LOADER_DATA
>>> memory type for this table. The correct memory type to use for any
>>> firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
>>> EFI stub), even though the name suggests that is it specific to ACPI.
>>> ACPI reclaim means that the memory is used by the firmware to expose
>>> information to the operating system, but that the memory region has no
>>> special significance to the firmware itself, and the OS is free to
>>> reclaim the memory and use it as ordinary memory if it is not interested
>>> in the contents, or if it has already consumed them. In Linux, this
>>> memory is never reclaimed, but it is always covered by the kernel direct
>>> map and generally made accessible as ordinary memory.
>>>
>>> On x86, ACPI reclaim memory is translated into E820_ACPI, which the
>>> kexec logic already recognizes as memory that the crashkernel may need
>>> to to access, and so it will be mapped and accessible to the booting
>>> crash kernel.
>>>
>>> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>    drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>> index ca61f4733ea58693..9a655f30ba47db01 100644
>>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>> @@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>>>    	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
>>>    				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
>>> -	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
>>> +	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>>
>> I bisected an SNP guest crash when using the tip tree to this commit. When
>> the kernel switches over to the swapper_pg_dir in init_mem_mapping(), the
>> unaccepted table is no longer mapped. Here's a copy of the stack trace:
> 
> Could you try this patch:
>   https://lore.kernel.org/all/20230917170629.d35gnwb6o54bdrhl@box.shutemov.name

Yes, that fixes the issue for me.

Thanks,
Tom
> 
