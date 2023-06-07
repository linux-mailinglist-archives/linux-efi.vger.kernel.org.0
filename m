Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC0725FC6
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbjFGMlt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 08:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjFGMlo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 08:41:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7C2112;
        Wed,  7 Jun 2023 05:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d98aTMsHU0yV7YlZr/HwH4N1EjU+HSOayAVCu2Fom0XTHpOGYnw/qshHy8HaYAMQf7g+6pY5HOjvIX90f0bTauaUpvS5ZQzHyTaDF2Hq9SXx8uxoxNoeg7Qq3keTC3PlBpEQwEDtaCcxCJKdWCSGpv/6q86HxF1Spp306BBw2DSzcNEBJF/0kPaOJ3op32eFHsi59jrJlWsX7KiMifJu5hCmsO+QkftbDBI9ykRUroYbw8oUMDYsIGMCeKHgPmeo8tgd+AjChXb7bclsT55wTzI3oI6jUOWsTfVMdbG0sLTAIiqQkfwKwLm2BX9OkZlIqAgawInXP0VnDC1FQKYCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOQpbX9BTIloY14ViEZm9k8XbgW5ZjnOVSkphWyi7xU=;
 b=WUyXUKcVejPNMvTAPJgfDEnauy1CqgXrjy3QBpfXYGJ+mHY37pTsSbnLwgEt7OprsfukUOF+5jb2zif2Dna3yPaf95JVt8VsUjJSG8TxqIesOT3JM+swwhNdf/k+oBv6yYXHjHXd0hPaBlCLDMAvCVZb2OG+NKGG4BfKSuk1s1PGV9u1Am4X2bW5CuPqvSrKRIcmVQAKh+A0FCTn5SiBrmIg12p+Fis6Lxs4+glp+g6VQNKgDl3U2ZZfhuBTqMwCC+qMr8n/W1vAHgykxNMAGpdhMD5fVmSwmbIv7oy1qyliSG5QG3hN265MmOla/KnlCYEizUbgV2h3RbyMN6OQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOQpbX9BTIloY14ViEZm9k8XbgW5ZjnOVSkphWyi7xU=;
 b=pYcOqHAxE/0JBr0GuYbb97+MrU+2UIS51EQGRECEAztl6EjvXUm+A15SnHon2I6gZvaaQbtzSoBawMPDhdO/el47wIE9DVPqrCMcErad5GQuHR96pnSkTt4HqMACKQG6c0mJyZOdFoAClov3tuYC188JnRYLtXGaY7Jol8wyxhVDFtbXh83VkZSMhgRyrL6ixlm9PgEkqn9sFAtOhjkRY80+t7L5Bc20iI6x0vIUXBLCGuDOSybCzb+Oenk/uWnXgeaCnbnaCg1uNnYTipZcLXepz2l8utZqEUIBS9uM0ArmIB3keFTcmuGcYVjMbB/WPlnM5W13C7JUJLHp5OIq8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:40:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:40:32 +0000
Message-ID: <76da826f-b608-6add-5401-6de818b180e3@siemens.com>
Date:   Wed, 7 Jun 2023 14:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org>
 <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com>
 <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a69e276-54fe-4bff-f2c0-08db67546221
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZHPjG3tc8s0lzAp1A4cF29NVml/K8nHa4YEVYmFHOvf4ic+caCvQ2euyWx3Vz5X4pO3p9nVEliWE+nH62S4QP7shoPNaU6MvfIceK8pcBAqf7SxyPQTllHtbbZVTN6qpQ9tBQk1NbvqSdqQV+G4fJNmfM8g4nHGnbvQAwnz38w/sp2+DtVbYSgvzFyFrOOck8gepM8L4RqYKrzoly6TQ3FYc3XbakBiuZ5JkV7IJz0Jvj13MjKEhRLjPl0yre78c74+PbPi4QXNVdwkm920Iellm3pb31MukIWLFJYVTK+TO78NP8gNBXKrKhgdEDQwOgdGvszyQyjBwkN/bXmHNbvKV5aimf4qBHiAxWHFQSossL4JU0QKOO4ITD2jUYEy6/9KcVAGVf3x13c25IUo/gs7XdSihSujxWqrx+btUmQNf274WoVsRhUDQTnuc/+JaaFi0v3c3c8aC0tyDF1vv/NAvbISa/4rjZ302fJq20O1v2r8/sDRB4LzcSDKC49leBleE0fftudxXZflhMqrw0KWbui6lpNzUlY4qotNQcblXefzR0Ih6W6o4l5Iz1fkfh4tGxmE4xvQq9W5L8Iy9q7rmY14WUBtAOGKp79he/POiQlFwG856+vyB0uQfQNrW7U7WSdqF2fdmmXJMPlUyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(6512007)(107886003)(6506007)(26005)(53546011)(2616005)(966005)(83380400001)(31686004)(66899021)(186003)(66476007)(66556008)(66946007)(82960400001)(2906002)(6486002)(8936002)(5660300002)(7416002)(38100700002)(86362001)(44832011)(110136005)(36756003)(54906003)(8676002)(478600001)(31696002)(316002)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXZKQVlidHFpUGtIZVdZb3cwMDE1bW1yMHRqaGdBYmNVWjUyUkIxTDJjaGpL?=
 =?utf-8?B?N1Mwd2I3SENhdUxBME9PdExCTGdobTkxY2o2b2NuUzV4Sk9qWGlsQnBEUmdn?=
 =?utf-8?B?eWNWMmxQRmNZUEE5Rk1oSCt6ZFhRRTNURnY5aEs2V3AxdzgxZUdKbVZkY0Z4?=
 =?utf-8?B?dFN5bG5Mc1RnTkFhOGg2VkRhOERrQzQzL2Z2T1FmQml3UklGaGtDbHJTSTlV?=
 =?utf-8?B?WDhmSExRNnByL1NwMXhsaTcxNVNzcDhXd3gwUW1ZNzlOY1IxdXdTM3NLQXFz?=
 =?utf-8?B?QXZjMFI2T2FQSEhOMGhoWEhjb0hhaFFFeWNwZlhQSkpYN2QrVHNyTW5kb1dM?=
 =?utf-8?B?MTNjZjcya0ZvVmZKTnlzTTFiTkdIeiswM2RZK2xFZ1JUYTJlcDBNK2pPNk1j?=
 =?utf-8?B?WXNkM0c0dU82TkNuRXZaOEJyM2x1akxqdGt0VlUvRDEwWjRSdHFhMjRiQ1ZS?=
 =?utf-8?B?b2I0bEZpRGxPcDNPMER2d2FpWWlKdEQzV1d3WkJQUnlENE1meUxoVlZIdC9z?=
 =?utf-8?B?Y3IxNEc5bEV6c1ZUMlNieEFXaFluMjhXamp3NnM1ZVpWMmU5WW5PTkU5UXo0?=
 =?utf-8?B?aElrUzM5Y0hpMmVJRHJJVmRFRXJrMk14bmE2VU12bDE3RExHc2VscW1heUQ2?=
 =?utf-8?B?ekdmbFpMaDVnd2RPRDl6RGVlYmFSRWRocTVjYVI3ZkM0dUJwaFUxWHVwTUNw?=
 =?utf-8?B?Mnc4QzRRbmFXN3dzeU0za1V4dlA1cTlpRUx1a0E3eHZveUtVQkZQaWlxUldD?=
 =?utf-8?B?S3liTFo0ZVB2VjFyWXVGc2IxYk00ektyMlBZNEQ2blk2OXVRTS8vME9sSVB6?=
 =?utf-8?B?OG14UlU0UmNBelBGWVhiMlNUVG9xdmZiNkJlVDd2OWwwUERDUEdscS9veklC?=
 =?utf-8?B?aUdWeFo1NnVnZ1JZZi9mVytIUVdaWkJza3lwSTVHZXNqNXRnUGViejFFWlBT?=
 =?utf-8?B?VmYxQjg5MXdxVkxkZlZwaGlZTUt2MlNwK0NWUUhXZ3dkL2toV3Qvcm9hRnRM?=
 =?utf-8?B?Wi9iczJQaFdYRCt6WGREY2N2OS9CNGk5T0Vxa1Rsc3FBalB3L3FScmlaWURP?=
 =?utf-8?B?Z05yS0lXZ2dpSWtvalJxaGRMeEovRUtlWDNDWTVXN0NlUzhIU3l2WU5CMTRF?=
 =?utf-8?B?VTZmYXdNMmhLTjBLUWNJWCtHVld4S2RjS1RSaWpZMkVjN2pQbWVEVC9VOCtU?=
 =?utf-8?B?RUp0Zmo5ZTdmampLcG1pczM4cjQ0a3JLUHI1SHFTcGRySUhuSzMwOVdwZnhp?=
 =?utf-8?B?TlFiUWsxeTlTNGhIQjN4NHFZQ2VQdXJ5V2Rpd0Mza2lFejhlc2JNeXVvMGRs?=
 =?utf-8?B?OEVWVHVUN0h3MU5VUFAwSm5JNXR4YlF4cWtZUGJ5K1F4YzdFS1ZCTS9DMVpK?=
 =?utf-8?B?aUc0c21yY3pYSGhRclFWdHhqbm13eFNqOXF0amo5bzFxQW9HeXdQMXg2ZFNY?=
 =?utf-8?B?anFmekZoOS9hZ2RpSlQ0VDhWNldjN1hQd201dWRsSk9Wek5tUXNRSG9ET2dR?=
 =?utf-8?B?em5ST1FGYnhjaThSUkdLOXZuSVZPM256ekRZWFNmR3hyOGpZRm1la01HWmMv?=
 =?utf-8?B?b0EwMm5uUkNEY3dJYStFK09TVy9BaDBjbTRGVnVBZ0dsd2FJaUUvbVE3YUpK?=
 =?utf-8?B?Ynp5Q0hEc1cvZjFVcVJHWnp0bXlPR2h6YlBYTVk2Sllyank0NWVuaGpHQkRZ?=
 =?utf-8?B?SUc5c0tEN09FTGFYZFphd0JDNkNSRW8wenk1bUtSNk02d2N2WWhtLzYwbWlh?=
 =?utf-8?B?VTZBeHVMR1dRRmtLcUZjc1llN0NxN0Vnb2ZGR1U2MzVwV05zMDkveW5BV0JQ?=
 =?utf-8?B?czNvVmJMVDF0bDFZNXZSVWREMDhja2RUdDhjTUdodEtOSExtVEVnME9MMkdo?=
 =?utf-8?B?SHcvNHk5U3l1a3licDI0bGpLZ01XT3U5UzJiNmVYbUxRMHpUWmdFT3hsZEhK?=
 =?utf-8?B?YWZrRGt6d05kSWxBTk13V1VuY1FwRWRzOFh2bmtEeUVrM2lPa1ljL3dJSzBl?=
 =?utf-8?B?bUR5WG5hd1plcnE5UFdZbVBGNk5kMmhrVzFSdFI3Uy8xQTFMbUlJMy93Q2lP?=
 =?utf-8?B?WTdBb2dBd3RyYVpNNjBZcS9jUnViNHJ1bG5hNnlmbWZBMnA5Q2x6OWdsUFZ2?=
 =?utf-8?B?VHVkOWlCVjFiL0tiWEc4NDZWMnNZYUxMOEE0Sm5rYVdKL0RqR3cvMlRyS2s2?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a69e276-54fe-4bff-f2c0-08db67546221
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:40:32.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5TYrivQDdSa9UKXMHnMgFHtN+mu/0NE1WW6mm7VGLiklVyI0GuLb9o+eDhwgkEsuSJPBmyso6PF3cOXmUOn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7756
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07.06.23 10:25, Ilias Apalodimas wrote:
> Hi Sumit,
> 
> On Wed, 7 Jun 2023 at 10:25, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Hi Ilias,
>>
>> On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi Jan,
>>>
>>> [...]
>>>
>>>>>>>>
>>>>> ...
>>>>>>>
>>>>>>> I think we have a probe ordering issue with this driver:
>>>>>>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
>>>>>>> with the default efivar ops still registered. And that means
>>>>>>> efivar_supports_writes() will return false, and the fs declares itself
>>>>>>> as readonly. I've seen systemd mounting it r/o initialling, and you need
>>>>>>> to remount the fs to enable writability.
>>>>>>>
>>>>>>> Is there anything that could be done to re-order things reliably, probe
>>>>>>> the tee bus earlier etc.?
>>>>>>
>>>>>> This driver has a dependency on user-space daemon: tee-supplicant to
>>>>>> be running for RPMB access. So once you start that daemon the
>>>>>> corresponding device will be enumerated on the TEE bus and this driver
>>>>>> probe will be invoked. So I would suggest you to load this daemon very
>>>>>> early in the boot process or better to make it a part of initramfs.
>>>>>>
>>>>>
>>>>> That is not the point, really.
>>>>>
>>>>> If this dependency exists, the code should be aware of that, and made
>>>>> to work correctly in spite of it. Requiring a module to be part of
>>>>> initramfs is not a reasonable fix.
>>>>
>>>> In fact, I've tested a non-modularized build as well, just to exclude
>>>> that issue. The daemon dependency is more likely the problem here.
>>>>
>>>>>
>>>>> IIUC, this also means that the efivar ops are updated while there is
>>>>> already a client. This seems less than ideal as well
>>>
>>> As Sumit pointed out, the 'device' won't be available from OP-TEE
>>> until the supplicant is up and running and as a result, the module
>>> _probe() function won't run.  Unfortunately, this isn't something we
>>> can avoid since the supplicant is responsible for the RPMB writes.
>>> The only thing I can think of is moving parts of the supplicant to the
>>> kernel and wiring up the RPC calls for reading/writing data to the
>>> eMMC subsystem.  There was another discussion here [0] requesting the
>>> same thing for different reasons. But unless I am missing something
>>> this won't solve the problem completely either.  You still have a
>>> timing dependency of "when did the RT callbacks change" -- "when was
>>> my efivarfs mounted".
>>
>> With the RPMB writes wired through the kernel [1], the only dependency
>> left is when do you load the tee-stmm-efi driver to have real EFI
>> runtime variables support. IMO, tee-stmm-efi driver should be built-in
>> to support systems without initramfs. The distro installers may choose
>> to bundle it in initramfs. Do you still see a timing dependency with
>> this approach?
> 
> No I don't, this will work reliably without the need to remount the efivarfs.
> As you point out you will still have this dependency if you end up
> building them as modules and you manage to mount the efivarfs before
> those get inserted.  Does anyone see a reasonable workaround?
> Deceiving the kernel and making the bootloader set the RT property bit
> to force the filesystem being mounted as rw is a nasty hack that we
> should avoid.  Maybe adding a kernel command line parameter that says
> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> this either, but it's not unreasonable.

In the context of https://github.com/OP-TEE/optee_os/issues/6094,
basically this issue mapped on reboot/shutdown, I would really love to
see the unhandy tee-supplicant daemon to be overcome.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

