Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3462065526F
	for <lists+linux-efi@lfdr.de>; Fri, 23 Dec 2022 16:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLWPvN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Dec 2022 10:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLWPvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Dec 2022 10:51:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92476645B;
        Fri, 23 Dec 2022 07:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cquOyDq73HAU46GbCvpjD0/mEjE5VCxanzUr+yHKmJwfRLwVG2SBTR1SE7UJBcFLw1xDm0hAWsvDztFuksYsgsdYzA3MSijIrxw9N7vQLDsQOOULJP405Bk8QE7ltQfkYqKBMZVusTTxuabOUGgxh9XGDWVMkhCBcDuMftnMVEr5/EJjZOWhrbz/V6E7SQV/G1WzgKB5ybIgD+D7PzUcepmHJkMqyqkWVH+K7c2W+H2we2SPwAX+qI+PKLYYqT6ZpJ00hAIdMgFmzAngAxB8BZcEFFgtqbFHKb9UZO1on2h5wJGr8/ea67o7WRUxA0lkE/GsxI26f2Vpoa/2EW/rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgbZC9s4vhQ/JVcpGBh901xqUAdYEDy/cKgLK8j9N8o=;
 b=Zch9OtidAz0OhsLCZCGLW6v5WIzP1KhAL+fgdFfIwPgNGMBio1LARkb+oIv2CcdkgF1Hs/C00Gb/XiL++3LXO57rqjEqnxulO52UO6TgeFCdtOJLjA2iWl+0zPF82EXmBbsXlbZEDGQ0DUDJQt4/PXfrK/WcOqVXgNIobe/bK0HjGcjXoO4hko9dbB0VxCU2ItZeC5k1z6zsj5sCjNHNdRwR4rRPPZp9i50ojvrC5LKvRJ/4JULGq6IulADXhTPFepMKEO6jyq+p/h0fvZxlqPhjqy8Xcdpi9hr/RpYtwy2ovqmN424NO1i70/jmk4Wey4q8dBgVDzo3T78ViBk+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgbZC9s4vhQ/JVcpGBh901xqUAdYEDy/cKgLK8j9N8o=;
 b=ddy4jXIbuI8XdZBE7Eo24t8h0cTL8X8C1XR+OVUy6EX6WDygbwThjADDpNasEdLEqXMeekoDZwFf5R9GkljJVJRHlAzu1nC4eWSHKly7ADDH7Pv4KlmFZVvG5A2wwrTwBm0ZwliuDsXjLbwdKAweJiRytXzCR8skcZyLbG8qxFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 15:51:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 15:51:07 +0000
Message-ID: <4d4b9767-0c76-7531-2411-1c8baeeac94e@amd.com>
Date:   Fri, 23 Dec 2022 09:51:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-efi@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Carlos Soriano Sanchez <csoriano@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, christian.koenig@amd.com,
        linux-kernel@vger.kernel.org
References: <20221222183012.1046-1-mario.limonciello@amd.com>
 <a8a6a28a-2d24-8a85-d87a-1289b9eb26a7@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a8a6a28a-2d24-8a85-d87a-1289b9eb26a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:806:28::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5dd366-847f-4cd1-e170-08dae4fd8148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OcqD2IQFrO6ZmlVXcjVF8ndzNwhb1sD4fj1nfzspNS2suPKFff9PLC/AGyxQGc3+tm0CHa86xqBZDlYh5BbWUqrswFQhDmk4JlsN968C2/WLONhk54uZUJVAW+15GfyhVg1VxvSXsq6cK6vYLmrJC6YPiLVZrrD4c/iW4hSF6iWs9l73RJIGHasKINpR0LJmQCSuuViXqC0pf/bRxiG/6/6HH8unRq33dJyoJ2YdvFicuK9vJExXVd34/BvD3JOaXAPugFHk/KoWYs4lNqaAt91DRmcQHb4teQQ3kPkHJIAoMfr1HP3WQPddlRiW0l3Q3JT6ymJq4bOAHchs6XpnpIRc6w9nc40fQHMn/QQ6+PBJ4dw5gqOvw/Kj3+s3c/8L15auRs/Y0luki9LtWCbeUylgR/GxN0QDKMzNtC08944XWZefmBamjChVxhKa+9+tj+htgmWZHQ+5AHmviE0Nvtvn6NS01QQbK7UiulAR7qjuptoiDoaPepz4SzFJR9Y3U6KbRXA4YgDLPRiNp9hE3vi8CV8FG6pr5dGEqOwysL1DsMt5OxR7ny6XsCsApS0Fdis25d/Lt98/i/Hf1yMd51j13gFN3n7CkG3CS5glggufqF3CNWRRwvKEuMa9Th54QcgeI5eBgkvkXLmBlI7oEl6advH3gApN7oU5IpAZpddDC3S94wFTJfj1jYWsjIgHvxj+CKewxDJV47cn/IX1kJSf4/cOOSMXnwGCKT4Css=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(41300700001)(44832011)(2906002)(5660300002)(8936002)(31696002)(86362001)(38100700002)(36756003)(83380400001)(6486002)(110136005)(54906003)(186003)(316002)(6512007)(478600001)(31686004)(66556008)(53546011)(6506007)(8676002)(4326008)(66946007)(66476007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhXb0tkbElRZlpLdVk5MFA1LzFHN28wZWQ3L3BlcnozaE9FUTQzRWNKS25K?=
 =?utf-8?B?ZGdGcDdsS1R5bnRJMDZpOERzMFNzaFM5YUhGRUFza3pKVnBaL0RkNm9HRDhH?=
 =?utf-8?B?eW9EeWtndHhiODQ3ZElVK21uV2hZL2g0elU0K3hUY0tLQ3BlWE9MWWtxZjZs?=
 =?utf-8?B?dkxRM0NDQnhCckgrcVJuRU9KdThvcVZ5ekZ0L3dPcDN6djdma2NGbG0vTU5i?=
 =?utf-8?B?dHQ4VTZmUFlYSlRabkltQ0J5TUMzUFBKWDFIMHJtbkFEd2NnekUxZlhObkcw?=
 =?utf-8?B?VHMybkJwTERpRUpEbXVCbDRTR3JhZGNYRENDcnFpQVIvV1JnYjMwcGVMNStQ?=
 =?utf-8?B?OWlmK1NheDU1NHl2RFRZOTM1MTUvUnRVTVlnTmFORGFLSGNnWWNyY3AxN3g2?=
 =?utf-8?B?blU2RWJuQ095MGRsZU1pRUlHdDRhb1IxMkFsbnprZWkyczhEdjJRRS9rTDky?=
 =?utf-8?B?d21mQkdJNkQySDU5TTlHT0I5c25meTB5OWdyNDZSVm9KUVZqN2RmbUNyQ21B?=
 =?utf-8?B?WlFtblR5SFlwRUlxdU1zQmJhNTFVbVpOa1ozKzFlKzI1VTUzL1o2ZWNRV1lQ?=
 =?utf-8?B?QXMwek9MU1pybWdsWnBObmViMEFPaFgxNDNORHh6byt2QmYvQUpWajEzdlJS?=
 =?utf-8?B?R0pza043ZEk0U1VZWURpRW5rbkRxTlk1NFZ6SU1XS0F6VVRMb2RJdnlzMTZX?=
 =?utf-8?B?ZHRkbVNPQmxjZkp0SktXNy9OQ2dMWWFWd0pQdE84dXhvY3I2eGFjZUQvTzFW?=
 =?utf-8?B?UDFySmh4cjIvNUw4ZnpON0o3a05sWWNKRmtGQ1BtZCtKeTFUTkFUaFBOQnQ2?=
 =?utf-8?B?R1BiR1FmbjdianZLblhJajZQQ055UHBHaUJCeGxTVmFiemRHYm1TREhsb25p?=
 =?utf-8?B?enhaYnNqaG1jZEJHODdmZ3dOdEtxQklXUlZvVldNTUdKTlNPNTcxTDB4WVd6?=
 =?utf-8?B?UlkzYnFWYVdnWHhMem1qU0VqNndTN2VoUzkvc2VRYzArZGFjakU1R3YwVHVY?=
 =?utf-8?B?a1FKV3lpQ3o4YWd3aVBhNmd4M1Ava2J0Y2JyVGVrVlFXMUZ4MS9TTDIxcEU0?=
 =?utf-8?B?QWtBV3VzVVZjcGRwajZCcDZaQk1EU3pwc1l3dC80cDBJUXVLSGljT1JwYzBt?=
 =?utf-8?B?cjU1QXhhYmw4Y2Y3N3pSMTc0TFNtRFhGVkVEUXhPZVNaNHNTTHhLK3pxNnRn?=
 =?utf-8?B?M1M0bVUrM1ZWcXNsMTgxS3VuR3NtUkFsLzRCbTN5dzdIMlZ0ZWw5RUtZMnU0?=
 =?utf-8?B?N3VNWUJJNko4MHltOE84VkNZQmdPMm9NVU1LdkJiTUZBdzVENy9HODhLSjR4?=
 =?utf-8?B?WkQvZXRGRVhWUDNZSGhvcjVPTzAwYVM2U21FYmhUSEdWRFV4TVZPQXl5bS9w?=
 =?utf-8?B?clNzdURDd2c0cElwczB3TU9PRzQvdFJNeXJhUzR0SENoWnpQdWZLQWFVdUw5?=
 =?utf-8?B?QW9KbHFzb0VlL1l4MnBWRUc3NnVNR2lrUFB4UjRyRVNtK2xmcmkreHRVc3Ew?=
 =?utf-8?B?KzdPUGdrM0Z3OWVTMURVMHRWS1NlSXV2Q1V2K3g2dmtWTHpIdDBaY1IwdDE4?=
 =?utf-8?B?M0g1SU55dE1XeDQraC9Pb1hGL3V0KzlHWXY2N0M3WTFLUjBmSS9kYmJWZkt5?=
 =?utf-8?B?dDdTMTd1OC82NWxjUUY3WmlKUU1KQmZHWU8rR1h3akFiUG9GK3dHV2Qwb2dF?=
 =?utf-8?B?UXBuUk1GQzNuQUpLTTBwVEVLT1p2SHJNZHBwZ251MW4yZ1J4SEdGYlZTdjRE?=
 =?utf-8?B?ZDlFbXNFRDFBMmVsTnZFVkZzVUZUOFEvZ05YRnZ5ay94MmJzbzkrSXNISk5H?=
 =?utf-8?B?aUhMVEp6UlRMeHplUnpKYTk0WGFQaHFRNGJYU1IrOTJUUmJ2Y1VFWitESGZz?=
 =?utf-8?B?MkNEYWFmWjAvckVleTdMQ2pubTg1NFpKK0dvS3kzQXJOT20wRjRyT0tYaWFK?=
 =?utf-8?B?SkhtSkNrYnI4Y3BMbjRKQnJnTVowZkJNclZvd09PSHlFVFNpYng0eVBnTDVM?=
 =?utf-8?B?bWFNU202MTlwb3FlaDUwUDVmaFgvZm5rOEtnUGJUMHJkYWUwUWlnTUNnQU1x?=
 =?utf-8?B?aGJYdHUzYldVRVZVU09mMGI1MlcybzUreElyUDZqK0pIVGtlYkQ3NUh1cW82?=
 =?utf-8?B?U0hINkdLOXMyYWIxdFowWCtBN3E4dkxnS2VPZVlkM1hPQXpjUUVoQTl2U3hH?=
 =?utf-8?Q?4sXVIE0tX0RrIAgzPguAf+Px3TYj7zirC4a8G4YVVkJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5dd366-847f-4cd1-e170-08dae4fd8148
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 15:51:07.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz58bGX3VMl6aHsH47RsW2aB5G9l/1uYlZ0h+/5Sst7ZqrysPm8ZIZJCo9Igd5LcXZxbsAFbrfyWJe2EAWaIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/22/22 13:41, Javier Martinez Canillas wrote:
> [adding Thomas Zimmermann to CC list]
> 
> Hello Mario,
> 
> Interesting case.
> 
> On 12/22/22 19:30, Mario Limonciello wrote:
>> One of the first thing that KMS drivers do during initialization is
>> destroy the system firmware framebuffer by means of
>> `drm_aperture_remove_conflicting_pci_framebuffers`
>>
> 
> The reason why that's done at the very beginning is that there are no
> guarantees that the firmware-provided framebuffer would keep working
> after the real display controller driver re-initializes the IP block.
> 
>> This means that if for any reason the GPU failed to probe the user
>> will be stuck with at best a screen frozen at the last thing that
>> was shown before the KMS driver continued it's probe.
>>
>> The problem is most pronounced when new GPU support is introduced
>> because users will need to have a recent linux-firmware snapshot
>> on their system when they boot a kernel with matching support.
>>
> 
> Right. That's a problem indeed but as mentioned there's a gap between
> the firmware-provided framebuffer is removed and the real driver sets
> up its framebuffer.
>   
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
>> "freeze" even if the distribution doesn't have the matching kernel support
>> for those IP blocks.
>>
>> The perfect example of this is Ubuntu 21.10 and the new dGPUs just
>> launched by AMD.  The installation media ships with kernel 5.19 (which
>> has IP discovery) but the amdgpu support for those IP blocks landed in
>> kernel 6.0. The matching linux-firmware was released after 21.10's launch.
>> The screen will freeze without nomodeset. Even if a user manages to install
>> and then upgrades to kernel 6.0 after install they'll still have the
>> problem of missing firmware, and the same experience.

s/21.10/22.10/

>>
>> This is quite jarring for users, particularly if they don't know
>> that they have to use "nomodeset" to install.
>>
> 
> I'm not familiar with AMD GPUs, but could be possible that this discovery
> and firmware loading step be done at the beginning before the firmware FB
> is removed ? That way the FB removal will not happen unless that succeeds.

Possible?  I think so, but maybe Alex can comment on this after the 
holidays as he's more familiar.

It would mean splitting and introducing an entirely new phase to driver 
initialization.  The information about the discovery table comes from VRAM.

amdgpu_driver_load_kms -> amdgpu_device_init -> amdgpu_device_ip_early_init

Basically that code specific would have to call earlier and then there 
would need to be a separate set of code for all the IP blocks to *just* 
collect what firmware they need.

>   
>> To help the situation, allow drivers to re-run the init process for the
>> firmware framebuffer during a failed probe. As this problem is most
>> pronounced with amdgpu, this is the only driver changed.
>>
>> But if this makes sense more generally for other KMS drivers, the call
>> can be added to the cleanup routine for those too.
>>
> 
> The problem I see is that depending on how far the driver's probe function
> went, there may not be possible to re-run the init process. Since firmware
> provided framebuffer may already been destroyed or the IP block just be in
> a half initialized state.
> 
> I'm not against this series if it solves the issue in practice for amdgpu,
> but don't think is a general solution and would like to know Thomas' opinion
> on this before as well

Running on this idea I'm pretty sure that request_firmware returns 
-ENOENT in this case. So another proposal for when to trigger this flow 
would be to only do it on -ENOENT.  We could then also change 
amdgpu_discovery.c to return -ENOENT when an IP block isn't supported 
instead of the current -EINVAL.

Or we could instead co-opt -ENOTSUPP and remap all the cases that we 
explicitly want the system framebuffer to re-initialize to that.
