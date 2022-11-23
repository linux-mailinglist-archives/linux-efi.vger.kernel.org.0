Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844EA636147
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 15:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiKWOQ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 09:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiKWOQZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 09:16:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E52F036;
        Wed, 23 Nov 2022 06:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdMdVMBK50loA3jFmW927HUYzWRhmSAECuTRVOFIz4VHiCoCu6evofeTkW4uZ+IsNAQnP4LopAan9W+SAqa9Y+nP7zuXaVnnRTMwN+5MBIOJCRRreyUawFfEpnj1VYQsg5diHgggvabgdSTDDyEnSN4CCW1V1FYQDiyFLSDeh3+MgrbyPw6CsSI8uU+GLUjmDyewCOc5Lkurto7k6LqPl2TffIk8jHKJdctP5X78ZKFkb4RujUSGqztlhRAxJ/ACadVrjRsSkZMUGb2PMzqTYe0x2zOfEDAzGJB418FpmfsUt7p7oZuM9zBZ3huKnWH5g/aizTkH2VIVtsx37i/DQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQDu54eXMcgih/dzntdPscdNtZZIBCQPD3/EQomAXBE=;
 b=PxacP5b+UtXqO/179QO0laL0pcPGoqsOcMN60pdbn1V/OEThX9JbGI9d4Dt5/Z27CCA9o8RborFtAdoRJ1UF6xr/nGV4AB6YG2jL8IVa9zONc19hbSAfZi1VfIMLBZk4PiuXH6aOkQz0JA7s/gVB+BdSkytLXDxTEhkMEI/C/KPKhd15Rqop5NIJe0SMxolqYpugSa+Qo57syVeC6ESkarjpDMjZMXRxQ+xBkyqhDk+IzR7tIXUlNwpOiQegY2qVKktI6gusdL9pRONiMckixdbBUX35znrJ/Cam3Fj94j+WRVTfRXK/2I37bV+5qWh2FPEHGPlkLjhA0oguYrGELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQDu54eXMcgih/dzntdPscdNtZZIBCQPD3/EQomAXBE=;
 b=CUDI8RmEqDaoVnQIvWqa+L66P7Awp1xMjpNpQs3g1PPK61r8Sv6uSnGiBMoNc5/wHTUVDS/255ahfKxX7If79IGDttYNortV2kX0CljiGT2hKNlzbzJVu2plVUQAePPZAwUESPtfgxyoEA5PCHLScRtAil52kXNZqz80WWsPzjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 14:16:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d2d2:c91a:5927:104b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d2d2:c91a:5927:104b%5]) with mapi id 15.20.5857.019; Wed, 23 Nov 2022
 14:16:21 +0000
Message-ID: <66416f08-1daf-63c9-8ecc-47f4e2e09ba7@amd.com>
Date:   Wed, 23 Nov 2022 08:16:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com> <Y336yE4P3NjCGavN@zn.tnic>
 <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:805:f2::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aa7a99-0b05-4c90-9035-08dacd5d4be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ewj0yZrn5cEOeMBT2Nnwk1rk9B9wx1puNycJZiXo2ZBcicYXwDJq2roPAujKwJNO3DgVe3s32FLkyUS0PeDWevJcwBY+aQNex/5DtLgv2hdwaPWN80MC8z7/pFrG2eb2m1I2TLu3EDDO7J8QT/DhtnwwGZCMGhTSh6uHuGo/gq6BVZOADcFGhMAX4cJY9ZoHfK3ewIPEhHV35FscVd5eE+PbdqohL32cSO/v/hekbILIyhT9vqOjwvpsYgKW9Yd5ANTG0VBFDb2MrgcVM6O08sxm9XitCk0Nx//0XB4x7FdnXoBv+Ec8anZcyHnO8fCErzoF9KspBaHtCrIQf/bUcNDBiz79HZPFrRbmKx3XMyZrlff0/IEUGY4XK692iHbOqeA/2JXfvufpf9JXFSjSeAljR+0AQM7as1oZC7H0qxd3COqOytLDCVtDk1yQ9AYm1rI/H7XL1nbE2gGJfl6UaFj7ZbxV6WbaBz03amXBlSVzexcjqUHO/ph66QN7gCfSRSMTjZrYekz2liyXpx+SXZy2az1gmCebJUXzo37TGsihZibs1so1rbgHH2RwY2kUMPt6pk2FUs8iu/zO8pBGb5go0VSh6qSQysZFmC5N2ztp2pZpQia76L8Jme0XF6JDn4+pOftRvTEl5SMfRleS/u12dkjE5BiMaxAti0rpND2k2ioxEGYQjagHDThQjmZ6bmi3lf0rrMfO4n9kivMISw4rKTc/M6LUEjju/XqjiRXkaphzyT5NfDyfXWp3E85wgUGr0yDOWUv5jcLeTW65g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(36756003)(31686004)(31696002)(86362001)(2906002)(186003)(26005)(5660300002)(6512007)(83380400001)(53546011)(2616005)(38100700002)(66556008)(6486002)(966005)(54906003)(8676002)(41300700001)(8936002)(478600001)(66476007)(110136005)(6506007)(316002)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlka3pZUkpHaUwzTWx0SWQ3aE9aM25NSk9yU3JHMUh6b2gvRTJrMmsxbm5T?=
 =?utf-8?B?Ly9XYVFMaGF1UEY5RkQ4NkFHd2ZpZGp0ZzZOSHE1SzVOcWR2UzBweGVtYjBX?=
 =?utf-8?B?cVY0WjdCdE5ueFhxdHBnRjk2R293TjZrWkVTbVlJckt4VUNVZi93UGFiQzRn?=
 =?utf-8?B?Vk51d0RDZy9zUFlpbzBlalRzbnhEdjRaaVVaNW9yMDg1WEZKUWNnMXNIbnVt?=
 =?utf-8?B?ZE54TmhTZW14K291NmpGT1BoWmZHUUl4L3FKS2ZQdS9WYXYwdTlQM29VSnZ6?=
 =?utf-8?B?QjVoQkNzV28rY01xNHZib3Y4WXFTUnpSYll0K05LVjlZWitCeVZZS21sYW9O?=
 =?utf-8?B?TXcySzcvSnV5VndvK3h2YXBxRWgxVm1mdzVQMWNnZDhiNHJ5ak0vL3dYaEtV?=
 =?utf-8?B?a1hnckZPdkZoamk4WnVob2tMV1hocEJqYTl5bGVFS0pkbHBBZndNOW9WSEM5?=
 =?utf-8?B?czdjREMwZlU0OFBjeG1oRUtYVlNUcmNWR1B4TnFVWTZCVER1TkZVb2FUWnJ6?=
 =?utf-8?B?MjMyNDA4dnZqYzNjYzhqbmg1aXJiUnFHMytZNWpVSUpQSzZPYU5MQjJhZi9U?=
 =?utf-8?B?eG1iUW9NdWhPQjlNOHlwd0J2WXdLbUV1Q0xWSFZ3aTh2dkNkWTgrcTd3YjZH?=
 =?utf-8?B?U2ZGNUNtemdkajgvM0hGY1N2K2wyYmgramliYmY0b2lpaE05MkpmN3JTNGZM?=
 =?utf-8?B?VDQydnR3UkpGbENjR1dXa2d1NG5CMmovV1JEdU9iV1hDMkdMVkdVNzBOSzR3?=
 =?utf-8?B?MEt4M0lRaHF4OENjV0x4Q09wOFp6REw0RElTU1MrUExtU1ZXcW43M3pDYVpm?=
 =?utf-8?B?MEl1OTdMdzB6dTV3cGxqVEJhK1pqZWxBd3hrMDd3Q1VuM3hmSG9QZnBicVZl?=
 =?utf-8?B?Sm1Ma1FKWkZmM2pxZDVIMVpDd0ZrZ1VNWExuVXk5TzV4eXlOVUZHK1JLdzlI?=
 =?utf-8?B?MHNUa2ZiVm5IL081RDhkZmJqOU5JcURTb2xrdXNUa2pMeVlySzMxcEhNSkEy?=
 =?utf-8?B?ZFNuVkY0ZnVMNFEvUXVnTG9XV253aVBTY3JSeXVYcDdwdnV4WllGUUd3YVUv?=
 =?utf-8?B?Y09Jc3VKaS9KSjFpSzJsVzhDSEw2d2xrTTBJdlJDQ2FiVkduOGJCdlZ2cUph?=
 =?utf-8?B?R1NDNnIyWmRsdTZ3Y3dhYmdUNVN4MjdPd2trNUpWYXQ0eUVxVjdOT01pd05W?=
 =?utf-8?B?N3FtdmJqSXZrWlUyUjVKL3Y3alJXMHVxc2pyK3cwR2RPSVRNUWp4YitUdDhw?=
 =?utf-8?B?QmpnaW5aRGZtUW15OW1rdExKQkFFNG4vdFgyK0hOV2t1NTlibGRsbjE0NUZN?=
 =?utf-8?B?UUxwcG9qMThxaFVFVXlaM2dnaS9NR3lScXltMldnajhhQmtXcmt1UTdLZkND?=
 =?utf-8?B?OTYraTVSSHdKRGtWWCtkNC9KV0hXRTJVR25ON2F3TFhqNWIvd0h5dXZFcGt0?=
 =?utf-8?B?L1gxNjU5emg4eFR3OGo3ZGtsVEQvOGVYdE5pTnF4OXAvcHRPMGRrektwV1Fk?=
 =?utf-8?B?OEloYmc0ZTZrMDdkWEgzUnQzdHdacTZHMmlmbDVtdDQ5aklFU0x3bjZ4TWtQ?=
 =?utf-8?B?VGN4K09obVlNZDhpRkErQTlaQlVmdW44aHY5ckhjdUVMeFF6RHJzK01HL281?=
 =?utf-8?B?KzE1aW1xbVl3QXlNbnhXeXRQa0xoVVVUUGR0YWE4UWhxOEt5QXAyOTVnV210?=
 =?utf-8?B?OTlFWStoNXk2dXdGMHZBaG95OVNzQzd6VzE4U2tjMlFWT0MwMVB4eXY1RG9H?=
 =?utf-8?B?TUUrUC9yVk5BZ1phRkRCZ2d2VnRwVXdKVWNhK1NTRkZJZGNqblhsL1oxeVZF?=
 =?utf-8?B?QklzK3NabUFjQllHeWlhcUZUcVNTZXMxK0sxeGZhMWNhbEFLSlI0ODNkKytx?=
 =?utf-8?B?cStvY3hKN1BpRFpBRVhhSU9mRTY2ZEZCTTI0Z0lZWWhtdy8xSFRXVDNIRmhX?=
 =?utf-8?B?d2Q3SVpHRVcwQ1pVVTdwQ3ROL0NmNVZCN2R5ck1IeTdMNVNDSlkyZSszU05i?=
 =?utf-8?B?RThnTXRncmhlZVkxQlVsdlV2dnRuK1lDTU56Y3U1NFlSL3plSkZUYlhhU2RD?=
 =?utf-8?B?WEpsUmswT0s3eHZaa1Y2OUp2SEtZak9JajM3dm5XQU13QXRZbGFJRmhidEJs?=
 =?utf-8?Q?8Cl15KsJKGVwN9D3Jy2OeLzqd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aa7a99-0b05-4c90-9035-08dacd5d4be6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 14:16:21.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlRUEmLEDJrAtd64UqzMjxMH4VSxaVDO7jATugDx369yaF8Dm5KG31+x4ygHlbT1ic0y70v3wu/C/uwG+nR+Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/23/22 04:52, Ard Biesheuvel wrote:
> On Wed, 23 Nov 2022 at 11:49, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Tue, Nov 22, 2022 at 03:49:29PM -0600, Tom Lendacky wrote:
>>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>>> index cb5f0befee57..a0bfd31358ba 100644
>>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>>> @@ -23,7 +23,7 @@
>>>   const efi_system_table_t *efi_system_table;
>>>   const efi_dxe_services_table_t *efi_dxe_table;
>>> -u32 image_offset;
>>> +u32 image_offset __section(".data");
>>>   static efi_loaded_image_t *image = NULL;
>>>   static efi_status_t
>>>
>>> I assume it has to do with being in .data vs .bss and not being explicitly
>>> cleared with the encryption bit set. With the change to put image_offset in
>>> the .data section, it is read as zero, where as when it was in the .bss
>>> section it was reading "ciphertext".
>>
>> Hmm, two points about this:
>>
>> 1. Can we do
>>
>> u32 image_offset __bss_decrypted;
>>
>> here instead? We have this special section just for that fun and it
>> self-documents this way.
>>
> 
> The patch moves it from .data to .bss inadvertently, and I am not
> convinced Tom's analysis is entirely accurate: we may simply have
> garbage in image_offset if we access it before .bss gets cleared.

When running non-encrypted, I imagine all the memory is cleared to zero as 
part of Qemu allocating it. As soon as you put an SEV guest on top of 
that, host made zeroes will not appear as zeroes to the SEV guest, rather 
they will be decrypted and end up looking like ciphertext (hence the 
random values I kept seeing in image_offset). The SEV guest must 
explicitly clear it, which is why having it in .bss doesn't work for SEV.

Thanks,
Tom

> 
>> 2. Also, why does my SEV-ES guest boot just fine without that change?
>>
> 
> Indeed, so it needs to be in .data
> 
> 
>> [    0.000000] Linux version 6.1.0-rc6+ (root@ml) (gcc (Debian 11.3.0-1) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT_DYNAMIC Wed Nov 23 11:27:17 CET 2022
>> ...
>> [    0.336132] Memory Encryption Features active: AMD SEV SEV-ES
>>
>> Thx.
>>
>> --
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
