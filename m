Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD557621BAD
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiKHSRa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKHSR3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:17:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1CBB2;
        Tue,  8 Nov 2022 10:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdFhu6z0HOv/O8FKg8lsvkYPWXhR0ykCMkgCBop8JBcMjfnXwBihp5K5TA5K2z3ZfDgXvsRCM96m5qOjG+ISo9rt8Uu4izfdG5ilEzC7trNUlgoHsj4SYiMhF9wJe/uzIeFgeCtDxjpxS5mpu/4j32GppAcGbeGLDVWSsPUFhvbo8clNcIPq6p9IIDraucXgyBaSZWfQiltdJVGlb3bGr+jNYvL5T5ziHW9mXHqDSncPv74hBQY7UYRsr7NE/zNsvZuiA0EA0DznwCURYzcCwnlJFGq2mNgFQ3cvDfS+RjxFxqI24qe2TNwIosjaIA3df4nLY9k9dUSl2sZI9pZ/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rfX1ATfMN6lN38izjRey1GB5/xnIHpnirUdVo/2BKk=;
 b=dWwVS0FnVD+GCN3J7EEcHKqqYtY8cBTFxpq6TlSD9x5fP0eyemni6DBVyzFeZLR1IxO6xVwKBm1qzcVN0rTP+4fX2ErqWwrwHsHGY11b5ICJHa+N1h+A+Rqv+8Zldc4mCsJWAnATNV76ha1MqOwYpTyCH1U0adWFODlusiRE0AnESobsQfWgaX5GhlWT+jyiXpV1+Z7iBxbhzf0YSkkGA8amVudyZ17pjyWCk6dcqPqC8U54k0cBMITJlfDr5NpkatQStG1HclVvROawp+R+A36z0/JCsRzLIHUbMXb9uLj3LyW1hkl1sBz3kUzRYC+JPtbDx4MFelknX7dkhDPiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rfX1ATfMN6lN38izjRey1GB5/xnIHpnirUdVo/2BKk=;
 b=JW5hX2QdkUSO3kDMZrwa0jHKzjDi+IekfLOkPxsIZeMIjs7h6JzI//ZfV5RoCE0FIA+7AJvdV/8OC8qqCwaRFWHcquSRalODnzusJUGzxCNKWKXwOsV2XeX2Zjgf8GaQa0qyV+Lo4QaKYeK27n4mkPRjCEY1ULYtZMyz5q8GY8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 18:17:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 18:17:25 +0000
Message-ID: <fc262405-451e-3842-9b08-bc36614e810a@amd.com>
Date:   Tue, 8 Nov 2022 12:17:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 00/23] x86_64: Improvements at compressed kernel stage
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1666705333.git.baskov@ispras.ru>
 <e2beec0b-22d3-91bd-c57c-8c8ad2137406@amd.com>
 <d97fdff486959dbf841c92b3cb644740@ispras.ru>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <d97fdff486959dbf841c92b3cb644740@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: f56003a9-16fd-41ef-6ed2-08dac1b57cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7yoUbUsV0yqk/CP+MaPaNLF0lILUVzqiFg1mgx1DTDhED1N8LPgjTO3vUlZ55sieDL05mG4FK2+eA/bX8VQEt6DG3YXyWr99zHysd7oEWd/ddUGxi4mLfe4a4vWR5jcMr2Q/1XtW6HVEqUklgss/Nct7WpBAfAiV9wA3nkAMck/rIaXntbiPOk0px+8ocJSUAuS4E/vihjD6qk0X/+77BBm0VZd82W4EJFmpyP0DpLNRLERJIiTyP3SGGSigOt/VO/dUA26pFqbOsBQEbzt3isr0HKzPZWE8BQbHZ/zsXHrAcDFz572+dvO1FZPGBMqyT2w0/bIiOPjiAZWpeDtWcOtcyNinZhAZ5y3f2xYd+4znKDaaCiVsJnmuAraOEEL5jme3zJ1ml9Qs3Uj2wtPVFEgcCea91PQTjnkWJs71pk4qj5oQzSMq4QoIix3B5tIFrsZQQaPxvUq0850KFwxjKM2mgAJ2NnAlZ2NZzn3eNfujCui7okkpM8snPjsuWyuTfM8Z9cJyzzS/grgEo9Zs0dEc8EuIa8rfbX1KKFJVE76ZBsDuq+ZoUFoMp6XVc9goHK0cUDwhKI6bqK+xpSNfNhsCBndgIIrqBydGW1eVxFnEg8B+MmclqdfwoBUTBBfy8TePzjaT/PxE3mLChDByi1HojdzXr+P6lB0+h4Mvsd91FqrGQmcaZ5Vnqwrc7Hrk8adNsxGVkmjLG/sD7cfKFQBlJXeWqHmXr1naM1+6L8TLUCjuMLiZc1lEshEeeitprH81CWrh0SBFbAYBLtv3hxBYYYQhK38Zwk1M0ENKcQPafE3c71d2LdSAQNPNXzKiMlhT0iln3TgV54bwpohyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(66476007)(6916009)(66556008)(8936002)(4326008)(66946007)(8676002)(316002)(5660300002)(6486002)(2906002)(6506007)(38100700002)(7416002)(6666004)(54906003)(966005)(186003)(41300700001)(86362001)(83380400001)(53546011)(2616005)(478600001)(31696002)(6512007)(31686004)(45080400002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEVnVndKSDF6cHJsOUY0ZXRWcy9wVWY0OWN2SWZKNEc2aGdqV0pHUGovWXR3?=
 =?utf-8?B?aTJNTFk4RC8rdXd6Y1g1RTkxVVlrMURyMTlFQ05YL3RPRmRCVjRlRy82bjJy?=
 =?utf-8?B?bkwyb2dERFpYREw1ZUhabWM2WnpqNHc5ekdYMUJYTnk5VW9jVVlRRkNhZCtG?=
 =?utf-8?B?RUM5VDdrU3JUVTRlM3F0c3E1U2JocmcwR3QrbHp3QWRlL2NuOXFhNkRyVjNp?=
 =?utf-8?B?M2piUjRvWVo0ODBYeXUzZG4zL3hJYWtVV3Z2YXA4UW1uZ1EzVU84NHd0QnUr?=
 =?utf-8?B?ZmlOMmJWOHF6cjBkZkxKUEJCcUluQVBMNjE5TWUvUGhPdGlGdlJyYnFNL2h5?=
 =?utf-8?B?MDZVTmd0MDhSMml5S1pNWmo4VVVjdGhrYlY5OVhCY28yV2tBdm40T1FaMXNN?=
 =?utf-8?B?aFN5R2RwRm9yMStxcUt2VlJRYmxGaW5rMG5BWlowQkFZT1MrbkdSNUY5TDJa?=
 =?utf-8?B?SkU4YXM1Uk83SWRWSHRiNjBicTdMOU9yUDNLb2luS09VYkR5dk9TeThuZU5C?=
 =?utf-8?B?cy96U2xlUStrVmtQdTVwK012dldTWGFiUC9PdFVuNFYwR3VWWDI1b250WUJz?=
 =?utf-8?B?bzRJQ0J5aXJEalpOTVBZMDRZQkRmcU9EMm85NXl3QVlMSUpQZitaWDRBVER2?=
 =?utf-8?B?bGJhTVNXalZ3SUFrL1NVbFEyNmc4U3hWelJxN2xjNmgxZG1BNGtjY21hc3VK?=
 =?utf-8?B?SnQra2lPVVErT3Z2WDlrOXk1USt1SkgyOExraW5mZFhrcEIxSFBVanY2cUpF?=
 =?utf-8?B?VWZPMkYxTllDWHVyNVd0Y2pWZUNvT0NLaDg2em41eFlNUXE0b3F5QWhpdk12?=
 =?utf-8?B?NU5aamJmQXNPRUtRanZqekpWU2R6UFRnSi84MnpMNmtDOGp4bnZmYlYrWDBK?=
 =?utf-8?B?VndNZk9nSElaTHVERCtKSTA5aXFudkVaQ1JDWVBnQWE0NmhacHdNalZVRk8z?=
 =?utf-8?B?bEloR3lTcTJFbEZJSzNsc2NLWDJvSHZ6bW9BSjJ3LzlMUHBqS0Frc1FBbjRP?=
 =?utf-8?B?TlgxcEZLMVUvdlAxVWpoWmJybE9mUzFrUElxK1dLSU51RXpyZ0g0bG1WVkpk?=
 =?utf-8?B?U3I5QTBhTmY0WVFnSXFXSlRsMHJocVMwaE5USVJYdm15RWttaWxlWXVrVGE4?=
 =?utf-8?B?ajQrQmZUSWh1bHprV0RYdEFSUExSM3M4WU9Rbm91TTFVVUF2dlhQYXhNRmM1?=
 =?utf-8?B?L2pGUFJnbWdoVFBlWFhyUk5kZ1F4MTkxVU9MT1A5OFI1QUwzUUV6eVdNcFcx?=
 =?utf-8?B?cGMyMnNScldobFhqeE1ZelJJWSs5NzVocXJ2ZU9ta1djTlpBUmNNR0l6NTRM?=
 =?utf-8?B?NGYvMWZOM2lVY25pTFY3eksrMlEvSkdSM2x3LzZqN2tEMHc3aHBVYkNwa0lP?=
 =?utf-8?B?d3gxNkp3UGk1YTlQd1dQRkt4ZlpUU2xCTVVxM04wT2hkbVdNcW1zOWVHRi80?=
 =?utf-8?B?bDlQVWVrS1J3QmJJb3hqemVoRVlGOFFUL2pBZENsSWNRNnBhbnk3dUpoejAx?=
 =?utf-8?B?KzFaNmgzTFJsTk05VWpnTDVmTGg4d2ttU2FvbDE2WDhWanc1VXFGOG9wK3Yr?=
 =?utf-8?B?RDVaOEJia21sUUtxT1pDWWRkUy9vSzlsM1p4dkNFRS9oeDBTSFJTOUMwUFNL?=
 =?utf-8?B?VldSUFBiL3A2TUxUdDg0Tzh0aU5CS3N5bFl6b3dkd3o1VVNJTmR0SU5qU1Jl?=
 =?utf-8?B?bTByVkIwRUdXeVJuOTlxa1VFRzBYUkdCK2N6UGkzeVFnKytKZGhVNUxUNzI3?=
 =?utf-8?B?K082VTNjZnptSVJlTG93ck54VEdndGgzNkl5ZkJWREtWWUZGNFM3TDdqL096?=
 =?utf-8?B?S1ZEdUphOFJwY3d3T0h2WHRVZTgzRm43KzNCRi9uUjU4TTlOZVR2OFRIUHNP?=
 =?utf-8?B?L2FlZjdTY05DM1lkUEZHTjd4ZTN0R0RNWlhsQlZmTHU4aWpIcktBZUMzVkVj?=
 =?utf-8?B?MVBheEluL3k2K1RkSXFRQVFwdW5yV1FSaE1oRUc5TFgzem95SFVBbnlZRm1C?=
 =?utf-8?B?VFBQanYrZ1BNU3pFdVNvV3FaTE5SaysyNWtxN3lmSlo0dFY0aVByQ2FoODVB?=
 =?utf-8?B?ODJQMlN5ZFNZS2I0SThLUGZTeTNwYUNKbTY1T2pJQzFoY1pTclBaV2w0UW54?=
 =?utf-8?B?RHZVTXVqM2dCTkJmY2k1Z2NaeWtGL1FLL2pvSEVnQWllT3ROYmc4QnNyaFdn?=
 =?utf-8?Q?2+JsU2gLDQ4U6OHiY8sJ8o5xXiootXyeO5rue9ReAs0F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56003a9-16fd-41ef-6ed2-08dac1b57cad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 18:17:25.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38wS2tFHFrXTHCgkCbwEt1q328rsQxQq3KSBP8kCKqyNgqJEI9RXJB67a9KP5NzMkfX5gqzZ+bIL2MRJl1rZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/8/2022 01:01, Evgeniy Baskov wrote:
> On 2022-11-04 21:21, Limonciello, Mario wrote:
>> On 10/25/2022 09:12, Evgeniy Baskov wrote:
>>> ...
>>>
>>
>> Hi,
>>
>> I was talking to Peter Jones recently about what was still missing for
>> NX support in the kernel and he pointed me at this series.
>>
>> So I had a try with this series on top of:
>>
>> ee6050c8af96 ("Merge tag 'ata-6.1-rc4' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata")
>>
>> Unfortunately I can't boot the system with this series applied.
>> This is not on a system that enforces NX pre-boot (but that was my
>> goal after I could prove booting on something that doesn't).
>> I didn't apply Peter's patch 6 you referenced in your cover letter,
>> but I don't expect that's the reason for the failure.
>>
>> I get:
>>
>> "Failed to allocate space for tmp_cmdline"
>>
>>    -- System Halted
>>
>> This is early enough [1] that I don't have anything else output to a
>> serial log from the kernel.
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2Fd4013bc4d49f6da8178a340348369bb9920225c9%2Farch%2Fx86%2Fboot%2Fcompressed%2Fkaslr.c%23L268&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C9280e92e85bc4e2b52cd08dac15704a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638034876740462327%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oiCJUa8M3x%2FYCxVjJj98R7iU%2FzIj%2FQxdVOWbnqGWCNI%3D&amp;reserved=0
>>
>> Since this is only in the kaslr path, I tried to turn that off with
>> 'nokaslr' on the kernel command line.
>>
>> I then get a failure of:
>>
>> "Out of memory while allocating zstd_dctx"
>>
>>   -- System Halted
>>
>> This kernel was booted from the following path:
>> -> Insyde BIOS
>> --> shim (from Fedora 36 repository)
>> ---> GRUB (from Peter for Fedora 36 w/ some level NX support)
>> ----> kernel binary (self-built)
>>
>> The BIOS on this system doesn't validate NX, but also the shim binary
>> did not have the NX bit set in the PE header.
>>
>> Your cover letter referenced CONFIG_EFI_STUB_EXTRACT_DIRECT but I
>> didn't find this option in the series.  I also tried both with
>> CONFIG_EFI_DXE_MEM_ATTRIBUTES=y or unset, same result.
> 
> Hi,
> 
> Thanks for your feedback!
> 

Sure!

> CONFIG_EFI_STUB_EXTRACT_DIRECT option was removed in v2 of the series
> and direct extraction is unconditional now.
> 
> You are getting really weird errors, which unfortunately I am unable
> to reproduce yet. I've tried booting with fedora's grub and the series
> applied on top of ee6050c8af96, but it did boot successfully.

Well so I expect the unique difference is that I'm using Peter's GRUB 
that has some NX support landed.  He has binaries for it here:

https://blog.uncooperative.org/~pjones/nx/repo/

*Theoretically* a BIOS that enforces NX should be able to boot a shim with
the NX compat bit set which should be able to boot that GRUB supporting 
NX which should be able to boot this series.

> 
>  From the error messages it's some problem with malloc() implementation
> of compressed kernel code. I suspect that malloc_ptr inside .bss is not
> zeroed. This should not happen when booting via either non-UEFI
> interface, or via UEFI (when kernel is properly loaded as PE image).
> The problem, I think, arises when kernel is loaded as a blob, but EFI
> handover protocol is used to start its execution. This is what grub
> seems to be doing.
> 
> Can you please try booting with patches below applied on top?
> If this fixes the problem, I'll include these changes in v3.

Yup, spot on.  I can the kernel from Peter's NX enabled GRUB now with:
* 6.1-rc4
* Your existing 23 patch series
* this new patch

Thanks!!

Would you mind CC me when you submit v3?  As I have an interest in 
seeing NX support I'd like to continue to follow along on the series.

Anything in the series you don't change in any material way from v2 
please feel free to include:

Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Thanks,
> Evgeniy Baskov
> -- 
> diff --git a/arch/x86/boot/compressed/head_32.S 
> b/arch/x86/boot/compressed/head_32.S
> index 9871cc8466fb..69811d9ab4ce 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -152,6 +152,14 @@ SYM_FUNC_END(startup_32)
> 
>   #ifdef CONFIG_EFI_STUB
>   SYM_FUNC_START(efi32_stub_entry)
> +    /* Clear BSS */
> +    xorl    %eax, %eax
> +    leal    _bss@GOTOFF(%ebx), %edi
> +    leal    _ebss@GOTOFF(%ebx), %ecx
> +    subl    %edi, %ecx
> +    shrl    $2, %ecx
> +    rep    stosl
> +
>       add    $0x4, %esp
>       movl    8(%esp), %esi    /* save boot_params pointer */
>       call    efi_main
> diff --git a/arch/x86/boot/compressed/head_64.S 
> b/arch/x86/boot/compressed/head_64.S
> index 2bb0e6da08c0..384706d12354 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -553,8 +553,20 @@ SYM_CODE_END(startup_64)
>   #ifdef CONFIG_EFI_STUB
>       .org 0x390
>   SYM_FUNC_START(efi64_stub_entry)
> +    /* Preserve first parameter */
> +    movq    %rdi, %r10
> +
> +    /* Clear BSS */
> +    xorl    %eax, %eax
> +    leaq    _bss(%rip), %rdi
> +    leaq    _ebss(%rip), %rcx
> +    subq    %rdi, %rcx
> +    shrq    $3, %rcx
> +    rep    stosq
> +
>       and    $~0xf, %rsp            /* realign the stack */
>       movq    %rdx, %rbx            /* save boot_params pointer */
> +    movq    %r10, %rdi
>       call    efi_main
> 
>       cld
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
> b/drivers/firmware/efi/libstub/x86-stub.c
> index 95a69c37518e..1a2c52e77c6e 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -24,7 +24,7 @@
> 
>   const efi_system_table_t *efi_system_table;
>   extern u32 image_offset;
> -static efi_loaded_image_t *image = NULL;
> +static efi_loaded_image_t *image __section(".data");
> 
>   extern char _head[], _ehead[];
>   extern char _compressed[], _ecompressed[];

