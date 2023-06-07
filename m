Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47C726563
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 18:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjFGQE0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjFGQEZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 12:04:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A281BD0;
        Wed,  7 Jun 2023 09:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTItc/aIgt3Rry9eZLPKzBLMmQdhHNSd8LTGYURpgtyCERhCkm3z6apkJ3YudWshn4GlAIwq8ATpLbZY7XQGWFKVxfv2P+iy+yHjEiHFWB4AWwzyKKn5zUeutjR4KJA3VXlSfgwA8WwTqrD9gn1fM3l+mstK1InNsCQugX/PXwkdmrAQ1kxqHflj0qR2sZtGL1LxryUz4q+4C1L13wCGdLCwAbYanR1S25cQEroNl+OIYgi71CcBpkOuAFJdmHVsPLQIskBN4Sv6sD1YlPXtSlX4SWYn2q2OQo3oG5kVuMXhQ2hVfD+uC05ZckkA2uvCxT8mPSpUDPcx5YOWwaF/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC/jjeTOavOGgcqWeNVxaHD96z4PISG4fuSfWqT/uL4=;
 b=N9FxSiqB1n3czVMfVJbamY0yTTPITV995lMcVbv6jczD5vwmT5LJiYP8FGFVszE/kgKXg18jemtg8SbgCRNm/vv0mfk0yqocVPqkJEfkNLTq0uWwl3MWFNka6sqrM41E/sawpVJZeHHE09Z9FAAh+D/W+mHgPa1/X7ac1QBNtgvFBt2iQu5Iu4d+K+NSpwK3uWLPBs20Qov3UGEOClEbxY0MgN+k9aAyzOVBr/aPC3Ze/mKFRqJo7Zq5UHyQuQL+hmaU22/jkzHa0pTACUPYfMHkJynjSHVQwXB4Nwj3bWj6ha90QFQ2uvWcrmH5urq6R9gAggptvncg+BtnD9nu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC/jjeTOavOGgcqWeNVxaHD96z4PISG4fuSfWqT/uL4=;
 b=byYTLCa4ROjy8X5pdJRdKci2k4UPaA+3uThbikjeDkbE3zcc7Z1Re5LEJrnY900IG7I7wkL+zKHbgfnWdS5ydxp7StwKlU8NJPpFdC+fC2PC/rNkCzE7q4sd39LIcQE2AN/ZrgQIXrj9X8vTvPBo7PySL0uqA/iissCUnpTGmKzb025Q41fwVoRryccHxukjYJtCcfL/+undEH6UeJQR4/O0Y0SLZoRCFSS7UIjaIA/bGZEWVApNek2StPHky5+kCL0EDn5PR5Db2Bl31zMG2upuq9anFK0haD6bGvuErg4oIe2SXHEt6KGPDCkycBLEJ4C1/41MHSfKwV6qU5I7ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:04:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:04:20 +0000
Message-ID: <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com>
Date:   Wed, 7 Jun 2023 18:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com>
 <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca8af85-cd47-4214-493d-08db6770daa1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YhYYClrrMrudUKTBcs2TVRxwI69mz85LSuYXJ8RpqS58v5Qn8wkDDaiM/68LYGATMhiVz7tcVieOSIY2zIf1NVVNNYutPxzlbokdlgsC+tOK9Oyn5GcMNKGEj2cDPS+1IH2lFpf7wt260aHbzC7dVCXMRjLSZPhA+v9gsq8RZYWafo1JtgPlTBZ965NZLNEL5Q9F6mUuuti01PO34JzQDgLx8hFwsIbJNZQFHhE5BI4Wlr2cTquFfmiUqnHTIl6qIsVNXTuzPZCYjd9Ayx3Fb6ygNOsKTFm1Ylg5G3UkBxoT7S2b+iwukLtETYzB9vWP8p8ktEBROziA0YQtP5PCxCNyr15TXDt7j6fm7VznwCt+oxoaxthHUtE5Wpte9DxGGyC5AsId6aeUkPH6E9ORt8FMFsbEXjkneXAVIeY3L0a/GrHpt39TqSF+aaYHhdlDY3YSOdRBuJlBnq8/tyRy5ExpdUtUFwqbxkHoGGMLJTA49zqAo4Anqc9HmSJdwsyb+5sNpdFbP7G3NGbtKVRtJUnjfrEc4V/W9yalaXXEfX88wvSeJwolOWFIumVFoxhOae1tyqcNbDUNzZfThztdgwkrstSaMgkSMVg5A1A1GrTD5oER5VBp/q+yDZtCL4gwnuhYIc1cIhZJ6oDMQYgaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(8676002)(4326008)(66556008)(6916009)(66476007)(7416002)(8936002)(66946007)(316002)(5660300002)(31686004)(41300700001)(54906003)(44832011)(66899021)(45080400002)(2906002)(478600001)(26005)(82960400001)(38100700002)(31696002)(6512007)(86362001)(6506007)(53546011)(186003)(36756003)(107886003)(6486002)(966005)(2616005)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWlRa3pOSytpQ01VaHVIVGNrbXlPYlBWVXE0L21qaisvZW5hTWhEMjhGZnpE?=
 =?utf-8?B?NFl6Yk1WaGIwd1VST3VibW5jdGpKMnpBSXlXdGh1Tk1kSElTRTZKSTRxSjVV?=
 =?utf-8?B?TVlPREkvcjVQK1cvZ0hXbWRFcjRSWnR0L2F1dWxqUG9JalFnSkR5NEJNSEsv?=
 =?utf-8?B?ZVhmWmFGOGcwdjBWcXphWGRFOVEwVFUrVGczSzRKRklWSWlzTDFQUFArVkx5?=
 =?utf-8?B?OG1OWTJQTlBxM3BLeEw1clNPUUxWNEVMb3NhNUN0NkxlUklZaW1xYjgxOXJP?=
 =?utf-8?B?V1JRZk92L1BvQmJFUVc5UjlYVWRGeU9kQjB6YkpQR2h4ZnNFSlZPVnBCYUYr?=
 =?utf-8?B?ektXWEQyalpRV2RsNEc0TUhhRmxqak1ydnJaV3RQUXFBZjZPNUVEcmpuWFNh?=
 =?utf-8?B?Q0pHTGVxcnlpanlLSnExZ2hCWmo5cytlWThZYlVIc05kRHpnTUo0SXVqTE9Y?=
 =?utf-8?B?bEdCNFF6RUV4bEtwN1NueVF3Sy9vRXFlNWlqd1NKZXhNZ3hNZllGVEJia1cv?=
 =?utf-8?B?SHdmQUsrYmt4S0l2Y3prdkxKOUtETldaWFVQZlpOanMrZFFVWDIva1BDQmtm?=
 =?utf-8?B?Ungybnp1Zm42Y0loRVBxVWtjLzE2RkhRTWt2ZVVVNkFpVjRuOHpuWkgyMmUw?=
 =?utf-8?B?VFd3NGZEclozN1FBNFptcVBFTDlRMDhQU3loMFdSazdTYWM3VTU5azcxY29Y?=
 =?utf-8?B?V0FpWHVmUTgyYUxKZklndUdSdXpSamE3TDRlOXZBUnJXTlNzbmFQajhLSUJJ?=
 =?utf-8?B?NW5MaitPTFhGWGpSamJtamdFbUpCR1JzYTdkY0xUekFwRjYvWERWR3h4b1ho?=
 =?utf-8?B?dXJ3czRqVTY4czBzVEpSRGZFMXlpZnd6TzAvRmZxRmwyL3dmT05hMzYyQnlr?=
 =?utf-8?B?NjR5eloveG8vVllCZzlOWXJnNzl3cXV2L1J5YzNNTDNLNWlETStsVEd6UUp1?=
 =?utf-8?B?MEJhbC9EM3prNVJlZHhwVGx5SzFGUFAxc2dvTEQ3Nnc2WHRiODdXUFV2cDht?=
 =?utf-8?B?Y1ZVeHlONUdkb1YxTVBTZHhQS0IzNzdBd1dzc0ludGcxUVFEQ2VWQU9hc3Yx?=
 =?utf-8?B?QVJyVjVZc0VOc1dHdTNPZTdOcXBSM1ZGSXREbDZyRWI3dXMyVkNndStaWlNj?=
 =?utf-8?B?azdXRGZ6blMxdVk0a2d0Uk5iVTFNc1FlaDQ1MSt1MStFNUdOWStTUFBwcVlq?=
 =?utf-8?B?N3l5R2ZNWnp1YkNWZUpLV2dveHl5cjlXSmgyNC9nMHFvMFllL3A3V2pva0h3?=
 =?utf-8?B?NmhhL3RMQUpUaDBBM1REZEpSeHM5V1JoeVFlY2pVREFCSXh6bVNkNC9OVTBH?=
 =?utf-8?B?SU1OYWc1M0F4MDRmM1E5bm41bktvelpVWExnUWxNbE5CSk52bzZIK2Y4clZP?=
 =?utf-8?B?YnI5MjFOcEU4QWF6QWFlL25GMFdZdHNlZ25pQmZqeVVmVXZmQmVhdzljOEsz?=
 =?utf-8?B?c2x4MEgvVXVoZFZTTEF1ejNVbks0SkhzWkpyaVFiNGJnWjZoVnhHcEgvaThJ?=
 =?utf-8?B?YjNBdVZWeCtFUzUyUHhSUmpRNGRxcFFvUDVtYkMrdm0yNlNYVnA5NC9iNUoz?=
 =?utf-8?B?cFllRHdUZlNlSnNxZmtzaWExUlRaanFocHRwbXZBemQvQm9Kc1lLS2VibURo?=
 =?utf-8?B?RzJrNEY2a0RWSUhWbzl3SDhvOURJNExlTU5PNjRudmhkbWJHSkxFNTFQVDdn?=
 =?utf-8?B?QlhHNVhSLzByV3lKUUJucjN6YUV1Mmx4cEpvK280RHFRTmNISnlkY1V5L0ph?=
 =?utf-8?B?S0h5MlpYSzRzMTRHc21QeVhUdDM1b2NoOW52blJreDl2T2luakZvUExSSzAz?=
 =?utf-8?B?Nm9NYVlPYjZyalpubEZoTVpsR3hlbkdIeHFiV0FWYTJNQS9uQ2hVOG8wa3My?=
 =?utf-8?B?NDZSbzZsWXBEb3BlUmRVcU9pQWt1aTVlWStGaEpUL2c3WTYzRXMwU1RENnAr?=
 =?utf-8?B?aSswMEdHdGxnMzcreUtkc0NQaGFZdkE4a1JyT2FnT3UrTENRNGVqY2MrZmNq?=
 =?utf-8?B?YTRCTHZBQm1sL25YZjZoM1RqUDR5N0dZLy9JbHczS2NUK3NTeGZ5OTl6NXdV?=
 =?utf-8?B?WkRhY0YxQWZjUFI2YnpFTDlsQlNQRnlpS1JZUDFVQ3VFdjFBTnRBM3ZtN0Jx?=
 =?utf-8?B?NnZqeWkyU0RTbVFBZG9RWXYvMm8xdjMyZlhZUFZKY3ZGOGczaTdHU0Iwb0Vu?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca8af85-cd47-4214-493d-08db6770daa1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:04:20.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzw7dtGujrlRQf8VKjuL/+DDMf5k+XTSsBc9u04YyI9t99xkvY5dqz3QQ4RTArA5jrFx+vrYRuwGGj5egWyFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6013
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

On 07.06.23 17:18, Sumit Garg wrote:
> On Wed, 7 Jun 2023 at 18:10, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.06.23 10:25, Ilias Apalodimas wrote:
>>> Hi Sumit,
>>>
>>> On Wed, 7 Jun 2023 at 10:25, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>
>>>> Hi Ilias,
>>>>
>>>> On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>>>
>>>>>>> ...
>>>>>>>>>
>>>>>>>>> I think we have a probe ordering issue with this driver:
>>>>>>>>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
>>>>>>>>> with the default efivar ops still registered. And that means
>>>>>>>>> efivar_supports_writes() will return false, and the fs declares itself
>>>>>>>>> as readonly. I've seen systemd mounting it r/o initialling, and you need
>>>>>>>>> to remount the fs to enable writability.
>>>>>>>>>
>>>>>>>>> Is there anything that could be done to re-order things reliably, probe
>>>>>>>>> the tee bus earlier etc.?
>>>>>>>>
>>>>>>>> This driver has a dependency on user-space daemon: tee-supplicant to
>>>>>>>> be running for RPMB access. So once you start that daemon the
>>>>>>>> corresponding device will be enumerated on the TEE bus and this driver
>>>>>>>> probe will be invoked. So I would suggest you to load this daemon very
>>>>>>>> early in the boot process or better to make it a part of initramfs.
>>>>>>>>
>>>>>>>
>>>>>>> That is not the point, really.
>>>>>>>
>>>>>>> If this dependency exists, the code should be aware of that, and made
>>>>>>> to work correctly in spite of it. Requiring a module to be part of
>>>>>>> initramfs is not a reasonable fix.
>>>>>>
>>>>>> In fact, I've tested a non-modularized build as well, just to exclude
>>>>>> that issue. The daemon dependency is more likely the problem here.
>>>>>>
>>>>>>>
>>>>>>> IIUC, this also means that the efivar ops are updated while there is
>>>>>>> already a client. This seems less than ideal as well
>>>>>
>>>>> As Sumit pointed out, the 'device' won't be available from OP-TEE
>>>>> until the supplicant is up and running and as a result, the module
>>>>> _probe() function won't run.  Unfortunately, this isn't something we
>>>>> can avoid since the supplicant is responsible for the RPMB writes.
>>>>> The only thing I can think of is moving parts of the supplicant to the
>>>>> kernel and wiring up the RPC calls for reading/writing data to the
>>>>> eMMC subsystem.  There was another discussion here [0] requesting the
>>>>> same thing for different reasons. But unless I am missing something
>>>>> this won't solve the problem completely either.  You still have a
>>>>> timing dependency of "when did the RT callbacks change" -- "when was
>>>>> my efivarfs mounted".
>>>>
>>>> With the RPMB writes wired through the kernel [1], the only dependency
>>>> left is when do you load the tee-stmm-efi driver to have real EFI
>>>> runtime variables support. IMO, tee-stmm-efi driver should be built-in
>>>> to support systems without initramfs. The distro installers may choose
>>>> to bundle it in initramfs. Do you still see a timing dependency with
>>>> this approach?
>>>
>>> No I don't, this will work reliably without the need to remount the efivarfs.
>>> As you point out you will still have this dependency if you end up
>>> building them as modules and you manage to mount the efivarfs before
>>> those get inserted.  Does anyone see a reasonable workaround?
>>> Deceiving the kernel and making the bootloader set the RT property bit
>>> to force the filesystem being mounted as rw is a nasty hack that we
>>> should avoid.  Maybe adding a kernel command line parameter that says
>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>> this either, but it's not unreasonable.
>>
>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>> basically this issue mapped on reboot/shutdown, I would really love to
>> see the unhandy tee-supplicant daemon to be overcome.
> 
> I have seen this error before and it has been on my todo list. So I
> have tried to fix it here [1]. Feel free to test it and let me know if
> you see any further issues.
> 
> [1] https://lkml.org/lkml/2023/6/7/927
> 

Ah, nice, will test ASAP!

Meanwhile more food: I managed to build a firmware that was missing 
STMM. But the driver loaded, and I got this:

root@iot2050-debian:~# efi-updatevar -f PK.auth PK
[  243.407097] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  243.415959] Mem abort info:
[  243.418801]   ESR = 0x86000004
[  243.422099]   EC = 0x21: IABT (current EL), IL = 32 bits
[  243.427529]   SET = 0, FnV = 0
[  243.430755]   EA = 0, S1PTW = 0
[  243.433931] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008b74e000
[  243.440438] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  243.447274] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[  243.452835] Modules linked in: ctr ccm mt7601u mac80211 cfg80211 rfkill libarc4 cp210x usbserial pci_endpoint_test ti_k3_r5_remoteproc optee_rng rng_core ti_cal ti_am335x_adc videobuf2_dma_contig kfifo_buf v4l2_fwnode videobuf2_memops videobuf2_v4l2 videobuf2_common irq_pruss_intc at24 fuse ip_tables x_tables ipv6 tpm_ftpm_tee icssg_prueth pru_rproc icss_iep ptp pps_core ti_am335x_tscadc pruss
[  243.487733] CPU: 0 PID: 875 Comm: efi-updatevar Not tainted 5.10.162-cip24 #1
[  243.494851] Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.07-rc3-00018-g0afdaac6505 07/01/2023
[  243.505180] pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
[  243.511179] pc : 0x0
[  243.513366] lr : efivar_entry_set_get_size+0xd4/0x1e0
[  243.518404] sp : ffff8000127a3d00
[  243.521708] x29: ffff8000127a3d00 x28: 0000000000000f87 
[  243.527012] x27: ffff000005bae400 x26: ffff800011254000 
[  243.532315] x25: ffff000005baf000 x24: ffff800011254aa0 
[  243.537618] x23: ffff8000127a3dab x22: ffff8000111d0268 
[  243.542921] x21: ffff8000127a3db0 x20: 0000000000000000 
[  243.548224] x19: ffff000005bae000 x18: 0000000000000000 
[  243.553527] x17: 0000000000000000 x16: 0000000000000000 
[  243.558829] x15: 0000aaab0876f264 x14: 35cd6a1025d11a20 
[  243.564132] x13: ac6f8dda3945638d x12: fb482642e3487f2d 
[  243.569435] x11: 0000000000000003 x10: ffff00000b792a80 
[  243.574738] x9 : a098e2bf989ff097 x8 : 0000000000000010 
[  243.580041] x7 : ffff800010e35c00 x6 : 4ddcbe2ecfc8fc79 
[  243.585345] x5 : 0000000000000000 x4 : ffff000005baf000 
[  243.590647] x3 : 0000000000000f87 x2 : 0000000000000027 
[  243.595950] x1 : ffff000005bae400 x0 : ffff000005bae000 
[  243.601254] Call trace:
[  243.603695]  0x0
[  243.605531]  efivarfs_file_write+0xa4/0x170
[  243.609709]  vfs_write+0xf0/0x2a4
[  243.613016]  ksys_write+0x68/0xf4
[  243.616323]  __arm64_sys_write+0x1c/0x2c
[  243.620241]  el0_svc_common.constprop.0+0x78/0x1c4
[  243.625022]  do_el0_svc+0x24/0x8c
[  243.628331]  el0_svc+0x14/0x20
[  243.631378]  el0_sync_handler+0xb0/0xb4
[  243.635206]  el0_sync+0x180/0x1c0
[  243.638523] Code: bad PC value
[  243.641573] ---[ end trace 369e4632cb003adc ]---

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

