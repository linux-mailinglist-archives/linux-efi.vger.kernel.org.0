Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF0655D7C
	for <lists+linux-efi@lfdr.de>; Sun, 25 Dec 2022 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLYPbE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Dec 2022 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLYPbC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Dec 2022 10:31:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A67D5A;
        Sun, 25 Dec 2022 07:31:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFUW8Noth0C72YKzHAq7pq8a9GXAixRt9jZi/FQXJ5+C528fiH6azEJ+f8ImH6JaCl2xl0NRmFI/IRIU0n+HZnuXEVCXW8C6brszS3V9lahP/5XGguy+pJeIk7+ra1XHlSeYc60YCnGCsPsgz1SRbvrwsOwY2ohHlwk20/njJOgFsjfU5bXeN7qlI17TCEiW8uadv/l7BY9zEmCJ2uX0B/q3RBPENG6NElVftx7dFnUlmpZ9WECigVhRx9p7QG4h/h2poepS3pHfJpUfKX77T3YIEK8y1Mx2/k2jK9nQSp4yIY/KdmU9VXz5aXhL56J3JOw9mMZQGx8RjVf7anfC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qrNLnYirvmkU75qCA7l7fDXZwJrPJns2D5zc8tQfTg=;
 b=I4XuscPgN70F46sWw2puHbCxsFJPMQ4jTAovYvVJHcy9+pks5QXjRC9b+lNYQMVtlTUMYjwUxIUKDl9tnKwDrGK2UfBySJLiVlZ3fv4HIr3Zdoa5yk9FKO0Mit+rDbfYCIU2+jLnZCMIkminc5XWDkL7F/XsBrghPGMU0hP8bNx8QkmSKCShtahw2D7gzxWnjD+Gwxn3lUK5zJOm88sZpCT0uqBVnviveW+JtVDZ9JDIwjQIlT7hyLxy6urnoUNV2hYCBpn3MTwfuXAYErDPw3l9BMox+IrnHqsmAL9yYhaLiVdhaydb96j9fI/buAKsM6m+A9xcw7VDAMpqhXZKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qrNLnYirvmkU75qCA7l7fDXZwJrPJns2D5zc8tQfTg=;
 b=UaigjlymPkGXJP7AkBXICW8hTs6ScQUuMs5U118jkBuUM7V2gF8Sjhv90QMJqmjvg1YBXUEZclPbE4rZ6RF9SfIlWk6Q+Ic2KGUUb0vhyG8JSXjMGSSlpMhsanXdT9c0g4fXahPHlb42oH80+n+Uwdq6JpwP20H9++a8/rZ//ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Sun, 25 Dec
 2022 15:30:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5944.014; Sun, 25 Dec 2022
 15:30:52 +0000
Message-ID: <f9b40837-ee2b-76fb-0ec1-d7dfda4ffb7e@amd.com>
Date:   Sun, 25 Dec 2022 16:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Carlos Soriano Sanchez <csoriano@redhat.com>
References: <20221222183012.1046-1-mario.limonciello@amd.com>
 <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f57048-e15d-4f06-322b-08dae68d017c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lL4lT5DCdolIYQBv5zKWZT5CcIGDOz06W5TF5N0I44+Co96Egt9Wax4eCD/rjG5XugPtvy1516lDnhWqEvglAnU+j/XRpiZ65v6KDNXARNNANHFutUq+TD9DCeyHDbloxkU0+C5StCyev6BZ9+GrDXQBJfc9GYyEfeKyqn3IBuItZdNswKeJE+bgiDoSzgQxWsg5ISbHbI1HgJ4IG3yFZVm5hLyc+KEVt2cD9RHkadRxA//QVhH/hbzXQRh0Jqn8lg7AOJ0OznSOcfVbUFcj5dTNm2kB3soRACA5jZB4YJOpFGsFMoA8w7yzCdQ8cQK/HXbHt6Uvj54+sSK6kHJ86edFGofDi3RxM55nmldULbym+V5M47fn03Rz3/rmCu9bVZsZPl0PrJ2Ov078TsA/OebfyxvED0UDTo89A5SBAo9CCzdotWffPc71Cqnj/6HjXY1OTpSpLzZX9bkiEWH/6hlotJiNOauz0xTp2aplkMndEbgCVhqNjPmCZmMzAJljZt3wQIgEuIr9/Ei/VCaBLKoMdCaYHmUxDPAW0JclMBRb8DnkPbU5/LytsOA8H+06ku4z8EmRovg8QRHXNE/FDL6NiY5wzHwoVzfgQzT2wf3d58Om/S0dXRU9/IOEfXu2ufNhQJxImv3GF6U+KAPVO3myc9T8Cs2xX+jCFwtkWjyf0wqUHIjSPyz5qK40YSPOGcIksMtHQ7X3h+hxnvLSIJV0N9VjbhG33z411+K1ath36/ve2BETxdC+0CbflxQ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(316002)(2906002)(110136005)(36756003)(6486002)(478600001)(6506007)(31696002)(86362001)(2616005)(6666004)(6512007)(186003)(38100700002)(8936002)(83380400001)(31686004)(41300700001)(5660300002)(66946007)(66556008)(66476007)(4326008)(8676002)(3714002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpYMFQyNGswVzA5UG9mUEM0YmVaUnBsOElTTFpFZjJIcVl2UjhZYkFQQTZw?=
 =?utf-8?B?a1FTM0NDVVRCOVo1Y29IR01HaGRBUjNSYnpqY2d5ckJXeWRrQ0JVd25GTGxz?=
 =?utf-8?B?Nmlzd3BFSzU4SCtHUnJ4ZEc0MndJRUgyanNVZm4xMWVOZUFKUERLY0E5Wjdx?=
 =?utf-8?B?dm1SeWlCTXUvT0ZHNHVrRUZTUExiY0ZyVk0wWHBYRU1QUEkxYjF1ZUlUVFZy?=
 =?utf-8?B?REpBNEtJVWVDOWFRZUM3UzA0dGkwWFdZVXdBWUNyQmNhQjhPV3JUTzNGTmF6?=
 =?utf-8?B?RmVTdVIyRFg3bHluNzNyekIwWldsOVFwOWVFaURUOVVNM0twZXJkd2EzaU1J?=
 =?utf-8?B?MlZ5aUc0SVlGbTBEcHNnV3VnRWduYzR5Y2dZL3pwSjZTaGFiRmpWVzFlMHhD?=
 =?utf-8?B?RHQ5R1YrdE15T09paCtOaWlxcStLbDBVUk5SRDNwTjU1T1pLRFJCck5BeVpa?=
 =?utf-8?B?RTcyMXRDcTVrZHVTbjVrd29aSFdGd3BXbCs0M2NOOUFnU2VhUnBBU3hreWEx?=
 =?utf-8?B?Mk9HWFFwQWk3Y3JZQXlGcE5LSWJiZjJUNStweUM3L1V0dlVCaGhOaEI1OVlt?=
 =?utf-8?B?NC9CQ3IwSzZ1NlB6TUp4ZFd0SktiSUcxWVZKbko2bmZIcGFzNzdvTWpTOS9k?=
 =?utf-8?B?WmdDMWJBUW9QV004WW5TWHVhdzE2dk8yc1RQek1NZlNvTjJGL3BWOVNPZ25N?=
 =?utf-8?B?NDQxTWVUeHV0WU03UUU2MmMxK2Z0aDBIdktlY0hHRG1rR0tDZGo4dGJQMGJz?=
 =?utf-8?B?QXdQeVhoQTM2NERKZzdYb0tia29TRG9OZU1mZ05FYVR6SG12bm0vczg2Nk8w?=
 =?utf-8?B?ZCtzRGlpMHBGZUZobVRiSkd2ZVdDMUlDdGFXZkU1S1pEcHNmZTJKWjI4VE9X?=
 =?utf-8?B?YUlSS0NueTNGdm1tWkF3dGczNUhDa3FPcElub205eUZ0dEJ2aTN3NGhlejRk?=
 =?utf-8?B?MUUxcnJyUDBhZmYzSGkvVjFJZ25teU5BNysvQkI5cW1XRVpTWWt1d1VlVVpt?=
 =?utf-8?B?bWpZZ1Z0cUFxRDlBbVhqb2xHUmlwRWRTbEhxaTA1dU91Y3VMZWJZZ2VUVmhF?=
 =?utf-8?B?c0FjZVZocDJoWWVGZWRXQTgvUjZzQUpNMEUxVm8xR1lDUEVYa0Fla2srMTZU?=
 =?utf-8?B?V1NGTXNmK3RickQraWdBVWZRdGhBRlU4VFRCbnVyTEQ0amZoUy9lUzZUb2dF?=
 =?utf-8?B?ZDkwQnVUMVhGOG5jZFhpdkJ2ejgxL3B6RzFSNlh1YnVTUHpqdExEbmF6dWZZ?=
 =?utf-8?B?bzdmZ05zcSt6d3FLaVRITHVQbjA2VkcwZ2wyLzlUbkY5UWhxRzJxcjJwYjRh?=
 =?utf-8?B?TmVnZ1JPYXdUWis2VUpjUEdVMnhnblVYaHlnMWNPcTNNNWZCT0ppQml6SkRU?=
 =?utf-8?B?b3pDZktCalFpRVllMHJMWjg3eTBXRjhLUzEwRk1ZcityOVJSMkRDMDNTTHQy?=
 =?utf-8?B?UGVYQ3Q0elZNbVYvZzI0Q2NSQklGYXllMmVrOC9nUE1QTHBpeSsxYTJhSnFX?=
 =?utf-8?B?SVFuMDJjY1REV3E0dDlnRnc1Zm1KNksrb2gzMGxzK2hWakFVL3NqRlVVa0s2?=
 =?utf-8?B?Q2hOS3ZZekVHQnNhRStnaUF1TmhzWENTMkFJbUZLK0hwd2c2QTVOOXdkWDRz?=
 =?utf-8?B?bjdvQVJvLzc1M1NNU2lxZkQ2S2IyMlcyNTNHNm9RT1FVTXUzRFMrN1Rmbnov?=
 =?utf-8?B?dUdvdllxQkxwVzZUeHBFUlpxSG4wak10ZUxKbm9rRktWUDdGNFhYZytONXh6?=
 =?utf-8?B?T3VKb21WYWlNcFlwNmFlS1lHWENoUjQ0bHMzOEtjNEZLVG1ISjlLR1owVW9q?=
 =?utf-8?B?aUE5YXZJemo5MlNHZWNLNkRqWmFrVWVxc0UxR3poVTh0RUVVRUxIK0Z1aEw0?=
 =?utf-8?B?cUdCd3p6WEF0U3cyQks2WC9PQ0JYSmRsYzViRTdzTHd0V29hMUMyUjh1Snoy?=
 =?utf-8?B?ZVBRcUVETEt1RU1BK1pPRFkzb0Q4WHlDUUNBaSt4RW4xdzduMXNmRG9GeGli?=
 =?utf-8?B?RmxNRkFITFFhSzB5NmQ3Zlh4SjdESlJyMzNOV3ErbmNLNkhqZ1ZXODE2ek16?=
 =?utf-8?B?Y2FnQjNXVVRBOXhHWkZxT0dWNzlVL2NlMko5YlYxVVFnQlQ3SDVrc2h4Mkhy?=
 =?utf-8?B?OUpaTjBBVUEvNFgrdFN5Si8rNUEzOU9obGVTT0RjQ1p5MDJxN0J6d3I4anBr?=
 =?utf-8?Q?Q4gprLwAKB+rMb+zl/Ekh/gAvfXU8fslnZIjjacoP6A4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f57048-e15d-4f06-322b-08dae68d017c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 15:30:52.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT2hsPsq3yNjaNIoKHAaRIK4HQWeg/CT998LpsEDDDC1tGo/rv+MYuTNp3BsZuV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am 24.12.22 um 10:34 schrieb Thomas Zimmermann:
> Hi
>
> Am 22.12.22 um 19:30 schrieb Mario Limonciello:
>> One of the first thing that KMS drivers do during initialization is
>> destroy the system firmware framebuffer by means of
>> `drm_aperture_remove_conflicting_pci_framebuffers`
>>
>> This means that if for any reason the GPU failed to probe the user
>> will be stuck with at best a screen frozen at the last thing that
>> was shown before the KMS driver continued it's probe.
>>
>> The problem is most pronounced when new GPU support is introduced
>> because users will need to have a recent linux-firmware snapshot
>> on their system when they boot a kernel with matching support.
>>
>> However the problem is further exaggerated in the case of amdgpu because
>> it has migrated to "IP discovery" where amdgpu will attempt to load
>> on "ALL" AMD GPUs even if the driver is missing support for IP blocks
>> contained in that GPU.
>>
>> IP discovery requires some probing and isn't run until after the
>> framebuffer has been destroyed.
>>
>> This means a situation can occur where a user purchases a new GPU not
>> yet supported by a distribution and when booting the installer it will
>> "freeze" even if the distribution doesn't have the matching kernel 
>> support
>> for those IP blocks.
>>
>> The perfect example of this is Ubuntu 21.10 and the new dGPUs just
>> launched by AMD.  The installation media ships with kernel 5.19 (which
>> has IP discovery) but the amdgpu support for those IP blocks landed in
>> kernel 6.0. The matching linux-firmware was released after 21.10's 
>> launch.
>> The screen will freeze without nomodeset. Even if a user manages to 
>> install
>> and then upgrades to kernel 6.0 after install they'll still have the
>> problem of missing firmware, and the same experience.
>>
>> This is quite jarring for users, particularly if they don't know
>> that they have to use "nomodeset" to install.
>>
>> To help the situation, allow drivers to re-run the init process for the
>> firmware framebuffer during a failed probe. As this problem is most
>> pronounced with amdgpu, this is the only driver changed.
>>
>> But if this makes sense more generally for other KMS drivers, the call
>> can be added to the cleanup routine for those too.
>
> Just a quick drive-by comment: as Javier noted, at some point while 
> probing, your driver has changed the device' state and the system FB 
> will be gone. you cannot reestablish the sysfb after that.

I was about to note exactly that as well. This effort here is 
unfortunately pretty pointless.

>
> You are, however free to read device state at any time, as long as it 
> has no side effects.
>
> So why not just move the call to 
> drm_aperture_remove_conflicting_pci_framebuffers() to a later point 
> when you know that your driver supports the hardware? That's the 
> solution we always proposed to this kind of problem. It's safe and 
> won't require any changes to the aperture helpers.

if I'm not completely mistaken that's a little bit tricky. Currently 
it's not possible to read the discovery table before disabling the VGA 
and/or current framebuffer.

We might be able to do this, but it's probably not easy.

Regards,
Christian.


>
> Best regards
> Thomas
>
>>
>> Here is a sample of what happens with missing GPU firmware and this
>> series:
>>
>> [    5.950056] amdgpu 0000:63:00.0: vgaarb: deactivate vga console
>> [    5.950114] amdgpu 0000:63:00.0: enabling device (0006 -> 0007)
>> [    5.950883] [drm] initializing kernel modesetting (YELLOW_CARP 
>> 0x1002:0x1681 0x17AA:0x22F1 0xD2).
>> [    5.952954] [drm] register mmio base: 0xB0A00000
>> [    5.952958] [drm] register mmio size: 524288
>> [    5.954633] [drm] add ip block number 0 <nv_common>
>> [    5.954636] [drm] add ip block number 1 <gmc_v10_0>
>> [    5.954637] [drm] add ip block number 2 <navi10_ih>
>> [    5.954638] [drm] add ip block number 3 <psp>
>> [    5.954639] [drm] add ip block number 4 <smu>
>> [    5.954641] [drm] add ip block number 5 <dm>
>> [    5.954642] [drm] add ip block number 6 <gfx_v10_0>
>> [    5.954643] [drm] add ip block number 7 <sdma_v5_2>
>> [    5.954644] [drm] add ip block number 8 <vcn_v3_0>
>> [    5.954645] [drm] add ip block number 9 <jpeg_v3_0>
>> [    5.954663] amdgpu 0000:63:00.0: amdgpu: Fetched VBIOS from VFCT
>> [    5.954666] amdgpu: ATOM BIOS: 113-REMBRANDT-X37
>> [    5.954677] [drm] VCN(0) decode is enabled in VM mode
>> [    5.954678] [drm] VCN(0) encode is enabled in VM mode
>> [    5.954680] [drm] JPEG decode is enabled in VM mode
>> [    5.954681] amdgpu 0000:63:00.0: amdgpu: Trusted Memory Zone (TMZ) 
>> feature disabled as experimental (default)
>> [    5.954683] amdgpu 0000:63:00.0: amdgpu: PCIE atomic ops is not 
>> supported
>> [    5.954724] [drm] vm size is 262144 GB, 4 levels, block size is 
>> 9-bit, fragment size is 9-bit
>> [    5.954732] amdgpu 0000:63:00.0: amdgpu: VRAM: 512M 
>> 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
>> [    5.954735] amdgpu 0000:63:00.0: amdgpu: GART: 1024M 
>> 0x0000000000000000 - 0x000000003FFFFFFF
>> [    5.954738] amdgpu 0000:63:00.0: amdgpu: AGP: 267419648M 
>> 0x000000F800000000 - 0x0000FFFFFFFFFFFF
>> [    5.954747] [drm] Detected VRAM RAM=512M, BAR=512M
>> [    5.954750] [drm] RAM width 256bits LPDDR5
>> [    5.954834] [drm] amdgpu: 512M of VRAM memory ready
>> [    5.954838] [drm] amdgpu: 15680M of GTT memory ready.
>> [    5.954873] [drm] GART: num cpu pages 262144, num gpu pages 262144
>> [    5.955333] [drm] PCIE GART of 1024M enabled (table at 
>> 0x000000F41FC00000).
>> [    5.955502] amdgpu 0000:63:00.0: Direct firmware load for 
>> amdgpu/yellow_carp_toc.bin failed with error -2
>> [    5.955505] amdgpu 0000:63:00.0: amdgpu: fail to request/validate 
>> toc microcode
>> [    5.955510] [drm:psp_sw_init [amdgpu]] *ERROR* Failed to load psp 
>> firmware!
>> [    5.955725] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init 
>> of IP block <psp> failed -2
>> [    5.955952] amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_init failed
>> [    5.955954] amdgpu 0000:63:00.0: amdgpu: Fatal error during GPU init
>> [    5.955957] amdgpu 0000:63:00.0: amdgpu: amdgpu: finishing device.
>> [    5.971162] efifb: probing for efifb
>> [    5.971281] efifb: showing boot graphics
>> [    5.974803] efifb: framebuffer at 0x910000000, using 20252k, total 
>> 20250k
>> [    5.974805] efifb: mode is 2880x1800x32, linelength=11520, pages=1
>> [    5.974807] efifb: scrolling: redraw
>> [    5.974807] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>> [    5.974974] Console: switching to colour frame buffer device 180x56
>> [    5.978181] fb0: EFI VGA frame buffer device
>> [    5.978199] amdgpu: probe of 0000:63:00.0 failed with error -2
>> [    5.978285] [drm] amdgpu: ttm finalized
>>
>> Now if the user loads the firmware into the system they can re-load the
>> driver or re-attach using sysfs and it gracefully recovers.
>>
>> [  665.080480] [drm] Initialized amdgpu 3.49.0 20150101 for 
>> 0000:63:00.0 on minor 0
>> [  665.090075] fbcon: amdgpudrmfb (fb0) is primary device
>> [  665.090248] [drm] DSC precompute is not needed.
>>
>> Mario Limonciello (2):
>>    firmware: sysfb: Allow re-creating system framebuffer after init
>>    drm/amd: Re-create firmware framebuffer on failure to probe
>>
>>   drivers/firmware/efi/sysfb_efi.c        |  6 +++---
>>   drivers/firmware/sysfb.c                | 15 ++++++++++++++-
>>   drivers/firmware/sysfb_simplefb.c       |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
>>   include/linux/sysfb.h                   |  5 +++++
>>   5 files changed, 26 insertions(+), 6 deletions(-)
>>
>>
>> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
>

