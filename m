Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B265C414
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjACQhG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Jan 2023 11:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjACQhF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Jan 2023 11:37:05 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B4E0F0;
        Tue,  3 Jan 2023 08:37:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci10SfEuMeQfuyeFthaYpp8W2TM2rQdOEKCxqg67y29ct1FqzxufoF36QwWiJTYyCPsrHfgh2KSeu4WqpNFma+L32W6Yn5IzS9WIpTR4FHnfBnYpdEjaR/q8cad0tTCtAx1roAIq50j6Nr2gFUPaFkQnSmOqzLYhDRzJAm+8WddsgWbulBVKLymcacukdBqDubSNXQtRuyPaF5RqNHNLfnIvKRoraT0M+9P+tAfVGj/GE0EYNWLqsPcViIQNRPH4A64CPaqEh1TqNGpJyMfBoEZth4Y+GRA82juYPQhqkLPP7iYWILbZMUZrOVOHiWvc3T1YS4BhsZ9iKJMaglEOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXLY8oa0LIwouXw1AeFKOtJvTpE2qkSNEHPRtBACGlY=;
 b=mORyVO8vqhQYBDf3zBVNOvIRM6b+VUwSYMADtY2Rveo0aj7lwGF2RuRnxhDRzQotmWKk5q3p6fu76ExZlYLyUysSdN6/DdSw3kFTuvMl/ZhU3jiDavX3Np7T4rFnGF93D7nkxzJfONhGrawi129RS2T6bXBnJRfhEOsZTtqflIQiZWmH+nfx048P7XKh45ilJYHPp+itegn4q1QESi7hPHgl4wzzd1WrvSOolR3rcqc+w57mLiseKSbBvU0JW8yKKNA7rR06borxchJhbHiU8CeQKmMINInaEtJoSh3S8vvMzpTJKTwdjv0g6c+XIIhhfodSLfCFvzYxLPrmZWLqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXLY8oa0LIwouXw1AeFKOtJvTpE2qkSNEHPRtBACGlY=;
 b=D5OY0rY8DPJA1BS9CSl28zs8wpJWI012YWxk8TnEHO4a6RzMgmhNibNb1pyrYagNsOKVzf71fAFSSjwXiyvhutWpt8MC1RTfJSZpLv2ADcgQ4SGxS2buzna1HGSTaTY67n7GM4kxv40gAcgtN9ap0lKEeLQll9/tfcWw30bJzZIg3q1Z8Ec2CG9xjOn08Hh5LKvO1hHiRFAZTRDCOjjETXdqzEmSEUPIKucGXNFoIjXMENtirbxKYb21/Li9m+/aJ7KF5Zwm0DAU97WvknJXeMUZobnHjeVYu2k58C8czR/YYynCCGyX7vo2OsNUrUzharswcgGoCC5kGTfb0tqbZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:37:02 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:37:02 +0000
Message-ID: <7608579c-6ee5-f576-aa06-a763c3b6108a@nvidia.com>
Date:   Tue, 3 Jan 2023 10:36:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
To:     Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20221227040925.1619833-1-sdonthineni@nvidia.com>
 <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
 <Y7NY+ba2USk7hEAx@mail.local>
 <CAMj1kXHAYvGdGJN0rfEL2y1jRP8P5YotKMmCmx0h07vJP=YfBA@mail.gmail.com>
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <CAMj1kXHAYvGdGJN0rfEL2y1jRP8P5YotKMmCmx0h07vJP=YfBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::9) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: 53647136-82c3-4bb4-d559-08daeda8bdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA2yhxNdRktpnmVWrE0YQe2uhXtgbMQaFlSg32eZdTzZpV0xzdywNXz3zOo32+cpSQjHEV1Uyyg5LLIpezv/GcNQIccCEx3UltfbMCuCKiereksTSREfuj2j0gS6N5iIMjGRl9GWy2dlExFnbEmgkkl2laJfWPxSlHDZC96L/8/iYgygCGpqD305h4Hz3Dm+cfJlrTL6O/8luwEO7SM368kyp6xCoQkc7VjX008dK3jdudcP/vrP8H4QnZgPx95/2R9qZo4EMORZQX0bOftK9ocRDqWNDfn0gj/Psv9Ot3cVCIjB0bmLyRqj2JrVHTScqRU+D31se+uY7lQlNQB0GVLIh8r7D8WmJvFxrWkDviJ8S3LfC95fefugAEmcC38XlVBDEFtPHj0tBI4bx3jy6xNR1Qwy5B+mHFHSJ1BtuuxZxulqt5RTJzIwapoxqqD2WPYNDjEedGKkCYnY6sCAY0dQxFwLN2bXFqYMVw4+TQWUMDKhrAMXxj4JeZ22BQQ+I6EtaFVrwvt1UECh6bLRbwDj1YVhuahlSG547OyjsY+RR38wF5t81inqCtU2N8RiT2qJuOCWhH+P8Tv2UyR9NCLZ7Rbc21m6L8qhGk1PYVmGE1Qo5UMNDIsC2kzxCyvJJllWgy8vpCvBm1ix1Lxm6e4SNZZxymJWAs9N7eoA8oQaXVb48hj40uFe+CdxODXrfNzIcKQeQ3ICvKIB7wRg0hkEG+WtbJHK/XTq8IvR+Im76bHFJG4odvWHhNEoNlVWj/JnOujtSI2t+qC0cWWsUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(4326008)(8676002)(2616005)(66946007)(66476007)(36756003)(66556008)(41300700001)(316002)(86362001)(2906002)(31696002)(5660300002)(38100700002)(110136005)(83380400001)(8936002)(6506007)(53546011)(478600001)(6666004)(186003)(6512007)(6486002)(26005)(31686004)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9IOS9CcHhrKy81K2xTSHlydWNHYXllbkpjWkhSZDhHT3hyMmtNMGlzcnFX?=
 =?utf-8?B?emtnTE5RQjZSaXczdCtoTHlvOFNFQ0xGOU1LWGxKdCtZSEZSd0IzQ2x5OWpt?=
 =?utf-8?B?dlpmWjZtTEpzSjdKdFdTSHdxaDNScTZhaG5ncHlBb20wQ3VLT00rYXQzZXBX?=
 =?utf-8?B?RFZXa3VPaVl0NzVRUHZHVUdMNEFoODNzSGFhQXZjRmZ3M0Fndkg0aithY2ZT?=
 =?utf-8?B?clQ3L2RjVXhPU29DUkRCeHlvaFp4eXdlQnpaenUrTDZER0toQ0EzU1ZaRitK?=
 =?utf-8?B?TXd3SU1VZndxSWVhNlI3Um9uWmUySWh6MTFzZUxRUThPRCtaOG51TU14M2sv?=
 =?utf-8?B?bFhtU1E4TkZZUERHcC8xaWJ0NGVKYUdNMVYrUiswM2FPZXJuUjJOWmo1emoy?=
 =?utf-8?B?WVBDTG5XTFdzTEQ2bnVsREJXUW1xN1JuRTZXd3pJWEFLaWlpR0ExV2I0ZVNo?=
 =?utf-8?B?d2NGODlxcEdOWnR2WSszL0dqTkNhaEJkS3R5ZUVWUzl6NzNHK2ExV2tMbFQw?=
 =?utf-8?B?Tm0yTnZmUnkzaE5LbVFSNkVCODRwZHJqVkFXS3p0dzltVktPaUdLUVZwODY2?=
 =?utf-8?B?aXBMc1YxOWNKWUNSK0VLZnNtVHJ2aFdOUE9Odzc0cmEvamFGOUZpaWY1VWxF?=
 =?utf-8?B?QnVtQVZUaGQ1bDFySWxZb2ZQTyt4VXFWMTdTVGRhL3FPeDdQRm5uMG4yNmJn?=
 =?utf-8?B?T2N5NmE3cjFJRksrRHhvWmNIbWtjNG5MU1hLWnN0YjZaRFZEREJGR29wbFFI?=
 =?utf-8?B?QXpSMC9rVFZJcnY2bVNlUkRxRFVodXFKNXJnMTljK1F6TnVPVGhnNDFKQnVj?=
 =?utf-8?B?ZWpQckxsTis4dVZuaEFkRWZheVRubURmVE9mOEx0RzhRWFhQNWs1SnhPdlB0?=
 =?utf-8?B?OHlZcHE2cGRWVzNPeU9Wd1NQVFdFSlJMTGNvZEZxME95MnVCL3ZqYkpyUmZs?=
 =?utf-8?B?U2lVczYyN2RJMllMRWE3QlJFSS9PQ05nVVc1NFNzMUdNZ21maVVYQW5DQmxG?=
 =?utf-8?B?ajJVc0hCWmFMNjl6dXJETldMa3NUNUF2emlyRzQ0WEg3UXZCa01ndXVTTlpU?=
 =?utf-8?B?MWlUT0RVRUVBQ3FDZlFPUU9WNm82RUwyNWtkd2hySlh0N1hxaWpBejEzNjRo?=
 =?utf-8?B?YmU3S3pyQkZpcStFcSt4ZzIyVkpxWmQ0dnJxSzlXN2U4ZEp5MGVQZG9yZ0Zq?=
 =?utf-8?B?aDZSdFdTbnhoK0g2RnVOTGg2Rm1lNm5tZWhWUXA0dnd1WUFyYTJDYjhkRFJL?=
 =?utf-8?B?V2kvcEE5TmtVNzJKL0orVXp1QlhtYW9vdERUQkRRa1NHT0h5dmJCN2J1eFQy?=
 =?utf-8?B?cFNHa3g1TTh5OU5OdGZkQkxyaGxjSWRBby9LZk5mdnJZZGZoYVpGZTVqTDlj?=
 =?utf-8?B?S3l3djFIQ0p1SGh4THA0OXFpVDRRSWswbmJwSlRmQko4VVdJV2toWVA1RTZG?=
 =?utf-8?B?Nkp4VWVabkl3UE5uZGRnVk9WOGM3SzlHUHJRamE0Q3IwYld4NkNxSnA0c0Vj?=
 =?utf-8?B?bXh1eS9vOXByYUtEb3pkQU40MHZrd0NETXNJcVlyU2hydTZnUXdjemZId1Ft?=
 =?utf-8?B?UThkZm8rSTNVN0NldEl1RllSYk1SajB5N2FSd3RTRFBrREhrUDFna3lOQWwx?=
 =?utf-8?B?Zkt5NG9EMzJLenRkeWllbU93UkNFcDUyKzFKQXdubE12QzZhWXQ0Ky9KcVdu?=
 =?utf-8?B?dzRuNDNQWTdWTGsvTlRGaFVUMkNQMzZzd2U3QkRVS2ZWcXRCMHcrOGRkZGV3?=
 =?utf-8?B?RUI2eGhjdkcxMVNXRXM3ZnRoTElmUTNQQUVFdWpwbVB2djNTRk9WQi91OEta?=
 =?utf-8?B?TTMyck1UZzBrU0l1L3BKczFWYXVtTGh4UCthL1ZRQkptWFF3WXRleCtzWlVw?=
 =?utf-8?B?aHJDemllckNMdFV6QXBma1pwcWhpakJDL0szcmhVMW1OeVN3OGk2emdEN3A2?=
 =?utf-8?B?OU1yWmx3OTJqckJ3QTFmYkdROFMrQlZjaTVZZUtRUFRqOUdFeFI1UjA2dnNt?=
 =?utf-8?B?R1JkZ0xaR2hDR29GbHBIazF3Qjc1RllOWWJVcXVPTHpPemY3akRmOUY3R1oz?=
 =?utf-8?B?STNGVjVQd052Mk0rai9DamxRM044N1MzQm5QcTZvVXNiZFlsMDdMbWV1NXF0?=
 =?utf-8?B?UGlYY29ucUhZZzdnUFh0ZXY2VTNQQkh2RzVDZkxHdUFWVGhEaDRUSE9VL0Rl?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53647136-82c3-4bb4-d559-08daeda8bdb5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 16:37:02.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPGAS3bzUveq9UyiHswxQq/t2MPl81FSlZYymXJ1N4U+IXxnkiqos/SilMvz64vxAdB0f6d3yd/jMDCNG/tdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard Biesheuvel,

On 1/3/23 03:18, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 2 Jan 2023 at 23:21, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
>>
>> On 02/01/2023 11:47:11+0100, Ard Biesheuvel wrote:
>>> On Tue, 27 Dec 2022 at 05:09, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>
>>>> The current implementation of rtc-efi is expecting all the 4
>>>> time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
>>>> firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
>>>> specific implementations can choose to enable selective time
>>>> services based on the RTC device capabilities.
>>>>
>>>> This patch does the following changes to provide GET/SET RTC
>>>> services on platforms that do not support the WAKEUP feature.
>>>>
>>>> 1) Relax time services cap check when creating a platform device.
>>>> 2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
>>>> 3) Conditional alarm entries in '/proc/driver/rtc'.
>>>>
>>>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>>>
>>> Queued as a fix in efi/urgent, thanks.
>>
>> This rather seems like an rtc heavy patch and the subject line is
>> misleading. This should be rtc: efi:
>> Also, I'm pretty sure this doesn't qualify as an urgent fix.
>>
> 
> I'm happy to drop it from my tree, but please add a cc:stable so it
> gets backported to v6.1 at least. Otherwise, EFI compliant systems
> that implement get/set_time but not get/set_wakeup_time have no RTC at
> all on any LTS kernel until a year from now, and this was never the
> intent when we introduced the EFI_RT_PROPERTIES_TABLE.

Thanks for considering the fix for stable releases, I'll post v3 patch
with tag 'CC: <stable@vger.kernel.org> # v6.0+'
