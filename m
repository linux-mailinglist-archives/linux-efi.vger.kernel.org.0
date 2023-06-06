Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54032723ABD
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjFFH47 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 03:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjFFH4q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 03:56:46 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2055.outbound.protection.outlook.com [40.107.13.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442BC2D6A;
        Tue,  6 Jun 2023 00:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4LCyb0Rksy/vABbVeQyDDJowcvCiagn+/PHACi8Nfupq4MAlM94T0+CeB2rKcF2uzxQwg/DxpFllcE0Z9o5RiLQViNEPoh+Np6MbvqVv5TJ+g0Sy6YwSK8A8kzNuRD2ymyfvWUaC5UudfJOUX7xaHsQHcdRU4t8hQpCmdeA96duCAdTg50W0Zt85XWrzinKXl6kBbh+qZhFGD4Eow6LYjCBwuqi1YtHUW2xeSKC2gZMfxMIKnB6gxGzk939SyzlcYHEl2DKbeK7RlMbtdqr/kPTtVxQ5HentPBnaBAlHrspPXpxaMvUwC1e/STSK2Yln259AvGXBqc7wDfKS6IkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vVkD6kq/htwV1ipAwbg42VLa7N98xj0MehkfbI8WT8=;
 b=bFU+8RoxGREvpeiqYWaWltV+L+p+CnU6YdR+wRoJyIV6Dwzjg6AyZOBuewxbDtCjBxV/02oWop+WrLHmqow3KHT+QCQTSa1bSZs5ACnd2+tEWnA4uiFyPPiXj0H/eduRA1QXcKf+sFgAIGOzlz2h/88snuNTLqeT8tcRn1OcLrli86sZYQW9Y5qJN329dojgrolsodpJHSV1iuEcR/WbvjJ1ARU0tzBH3rkZQtSR3brtxJ2kiRWdxyetniLj/rINyB9krW9Fhq4Nf6AjZqDXPMiGIo2WnCTYlrRCMCPcfil3rfkUh0IEWlgziPX0x/uFc+XL0dOwwUEwKCfBLiYxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vVkD6kq/htwV1ipAwbg42VLa7N98xj0MehkfbI8WT8=;
 b=h9baN0MrY2ki5Z+AdyC3iO2h5+hQI4QlIeoj5ARcmbHUKYEKce652gs/Me4B1VD6C88Sqa8v4rz2jp4F49Aj3G14s+5NLtAV5Rh76FHh526rSqlF3mQZyngJq8NIJ+UOehJwxJ70fLmOMfXzy2uhc2438OGpDkIbSoOlwvbvccZp6f42d1gQPXMOGkXjHb53iLCA2XJkNyOO66W1Krs2lCVGb+F7hWYd4m78aVxRqes/QfjrHl19I0uBRv+0xAWAut/OBgO3adLyApQDxvrD6rgevpQCBIdPzg9ehmTxcebCsH0GFMxShDLRD4iaJ6geJx8GbP2ZLzFTst/TN1G60A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5168.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:53:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:53:01 +0000
Message-ID: <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com>
Date:   Tue, 6 Jun 2023 09:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: f002abf9-dfb0-4c32-7b31-08db66630d58
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3rWzyrolB9xrE+FJPk2RoPRC9SS1ffi5i3wcoomYRWKwb/c+Qq7otR1JIvXKTNU/zQfYWynUaVy3133T0go+lNJe3waohQqCvDQ6u/YUnXn153GFgiTGumMhqPvg9uyeYH9s5vF6+EhzqCXo5FPp/Ze4eAUS1amnEd7CqA526e1Oo4tG7K96T6eu/o+UApIiB8tinbzvWZzEDwqZFO1rX9jaT1JVxgweYE00DP1FeB+q9/UJDgInyD2ce3uWK18phf0WTj1NkiStquca/1Q1nArmyLpjMQTj4PPErO2Qg6zh0eitHmFrcmpGhuMqiy43dQfcWcKOG8B3pO+QkQixav06JpLbh0QQcLpSSoZsuskaIZbAvUx2MzCdZsiZWYM3bJAfmKIa2QxNDsfk+mIa7U8yVRfRhbiMZ2UZvsi6zZqWzmQ1Uj89c/OrFQMhUXUCLV6S8jE0sHLVEu19mNRNx21JFETEDpZK8+6FgBpmm1K5/59O1cvVmRpfoNnR/s8FyAkYoiftP5FfnFHxby40JCgGuoxObn26DaYOe2Bq94aqNgS+IhskafQp35OneyKczUc7qeEGrQvfIK1wB3npIqW7KnGC7R3EUARnNI71KA1w+R1x4+WQzypGjpsASW4/2wEnKX/LhH12SkIoGybAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(66946007)(2906002)(478600001)(316002)(31686004)(8676002)(4326008)(41300700001)(8936002)(110136005)(54906003)(44832011)(66556008)(6666004)(5660300002)(7416002)(6486002)(66476007)(66899021)(53546011)(6506007)(26005)(6512007)(107886003)(186003)(38100700002)(2616005)(82960400001)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRXdng0cEc5QkJoVkxLYnVpc2Y0ZUVORkdVTklReDh0dE1VRmVmZFI1TVdL?=
 =?utf-8?B?M1NYS0FNSHpBVHdrQVdVeDljQ2hBcWJQOVVKQXdrK05yR3V6dVh6VjExbXdS?=
 =?utf-8?B?WXh0ZkF6RmFydUVKL1VQRzlQQjFxKytmQ2VCenZQbXNnOWx1VlhGUHBjL21x?=
 =?utf-8?B?bjVHTXFoMXVXY0VMZUZESjJJQS9CVDFKNlRKclQ2RzQ5UGZHemFCbTlHK2da?=
 =?utf-8?B?eEhZelBLb3lCWWQ3c1Q2aDVDNzZldkJZbjdmeU1ZK3h6ajlSOWJyNmlRNUV3?=
 =?utf-8?B?Vmdza3o2WVB6RmRkaHRkMkxLcjVwMEZIalBjdERkRm5TWDM3c29wZTJGRmx5?=
 =?utf-8?B?NzVRcTcrZnFXakN6aFZJa3BDa0hEOXlNYlBwOHRkMk0zenUwUkxvVWlXNXl2?=
 =?utf-8?B?S3k2UWxnWEc3ckw4eGhQMGJhc1MvQmdnenVYU1JrZGtpY3FHaS96MlJ3YkYy?=
 =?utf-8?B?NUVibU5LU1dvaTNWV0RQQmU2OVBSQm5kQmxraHN5U3dlbVpMUkZ6dER5eFp5?=
 =?utf-8?B?ZE1YcVpXcWthZ1d5bWZaMXBRVXprU0RxenZaRGxRVTZMajd5WEJGNW8zY1ZP?=
 =?utf-8?B?dERJZ2dsSHdSUFBINURKOVBtUDBMQUVLcjBpL0YrM09wOGcxYTNmOVBlVjYw?=
 =?utf-8?B?UkNOTTJZbVBvejlVNXVYL1ZTVU1jeWYwNVBOOThEaXVNOHE3TEdFTEplQ0d0?=
 =?utf-8?B?bkhTOXJZZ1QxbzNIeEdCcllsanUzQ2ZrSUJHZnVHcW5CYWpJTmxQa0ljcGtK?=
 =?utf-8?B?OG9WZ0U5dEgybHdvT2FxNjk1bm9DcFFaTmR4TWdML2VQbWJMQk1taWFkUjV5?=
 =?utf-8?B?SlFoaGpSVmhOR0dVOGxNZnFnZFF1NUF0T01HbWJaK3B2b1o0Yy9ZMlo4c0hZ?=
 =?utf-8?B?RVBYRHVLVFI4MW9udWxxa3BUK1FrcHY1RGxLeklZMTZMSXd0NXE3UllhaDlP?=
 =?utf-8?B?Vy84U04wZHdCQ2NJMytFWVNzRDU1UmVrblpVUUNaWU11UExhV3JOOFJPWURF?=
 =?utf-8?B?Q1lxKzIvdFJPaWd1azN5RUJlSXA1ayt6elY0MlBmSGhTakg0OTBrU0tZbEZH?=
 =?utf-8?B?Uit4U3NQSG9CakorTnQyWnRycDB1eXpXT1JJMll1OEZIdWIvVzNhcWFhZDNp?=
 =?utf-8?B?WnZoV3BVS290WEtibW5mTEZNWGY2UlJ3V0VBQ3p4SXBuYzFab1JkM2ViTFo1?=
 =?utf-8?B?SHNlUGRpeXd5bUY0a21NM3VrUTFaazVZVHhQalpxNUFjV0hzbGlZdFVpSWUx?=
 =?utf-8?B?Y1JzejVMUnBIM2FsM3BHYlVEQjdIaENtbkkrYnl0T2ZoSzlaYzV4TUs5a3cy?=
 =?utf-8?B?ekg5QTVYMUdkdzNHSXBSNmJxUnpocStJb1QrUnRHVk9OZFlYQTZRc2x4UEFu?=
 =?utf-8?B?QXorRW9mQzgrTVg5UTBIRHdMRWNGeE9Kc1pOMGJIWFVldDJ6cDNkUEVRNnp3?=
 =?utf-8?B?amtUTzF2bHBCUlhRMDMyQXZ5b1VidzdBM1RvS01LSkphQk85SFdXU21rajVG?=
 =?utf-8?B?UVdxN3hqOUxiSXJXcDRxK1lDTmZ5QkZzUVZLV3M5MzMzU1FHYVo1S3RlMG1Y?=
 =?utf-8?B?eURGelo1dTVKWExKc1ZoWjkreXRLRko1MDhFTEl4bnFDWHFPRE1nd1U3MFVE?=
 =?utf-8?B?eFJtZjNNUmE3cnB3YUJ2dWROdkdzNlZZNm1Mcmd3aFYzSThEbm5hUFYrY2NY?=
 =?utf-8?B?d2hoajk4UFoxTGk2SFRubGQxYW5lcDRhbjIxbldJLzRPdnVXMEV1bkVkbWpp?=
 =?utf-8?B?cXlkRXRCVHBDUkNkZ2JCZklPOWRoeUVWRFEzQk1NWEc0ZkR2YzU2WTl4dWZW?=
 =?utf-8?B?UFhsK0pWN0hXeS9sTTQ5QVdJZWlkVHg0eXQ0bTNWQmpyNkhEaDBsYytHOS9w?=
 =?utf-8?B?VjNNS3FMNDRXa1c3c014RDVKQ3JQR0NMTjEwdWhSS2lSMEd6Yjd3Z1ZXNytO?=
 =?utf-8?B?U1NLYkJlRDd0cU4zUFhpVlRJZ0k2MExDNkp3ZWJtb2d4Mnh1anRtVXp1MnJu?=
 =?utf-8?B?RXUrWjRjbXdDVWd1Q3lCeWpDSzIreEEzSzd5aDB5Y29lTVVhVEN3elgrYlpy?=
 =?utf-8?B?NTF4M1YvaHFTRWQ2RkhyNXdEQ3krSUJYcFhmWGdpcGJHMWo1Y2JmRlNyZ1lz?=
 =?utf-8?B?WnhQbVRmOVM5Zjk5WC81VCtkMVoyM3VYU3Zob29vQURkbFQ3V0hJQUo5QjYw?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f002abf9-dfb0-4c32-7b31-08db66630d58
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:53:01.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Hsz570VwKRKf0kMMyGpQj/qn0So8apj3sSMe3FyCsiMEBf02JpNdYdP9NoGTrWFqa5JiY4FjENHvQim5Le8Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5168
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

On 06.06.23 08:57, Ard Biesheuvel wrote:
> On Tue, 6 Jun 2023 at 08:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Hi Jan,
>>
>> On Tue, 6 Jun 2023 at 12:09, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 26.05.23 03:07, Masahisa Kojima wrote:
>>>> When the flash is not owned by the non-secure world, accessing the EFI
>>>> variables is straightforward and done via EFI Runtime Variable Services.
>>>> In this case, critical variables for system integrity and security
>>>> are normally stored in the dedicated secure storage and only accessible
>>>> from the secure world.
>>>>
>>>> On the other hand, the small embedded devices don't have the special
>>>> dedicated secure storage. The eMMC device with an RPMB partition is
>>>> becoming more common, we can use an RPMB partition to store the
>>>> EFI Variables.
>>>>
>>>> The eMMC device is typically owned by the non-secure world(linux in
>>>> this case). There is an existing solution utilizing eMMC RPMB partition
>>>> for EFI Variables, it is implemented by interacting with
>>>> TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
>>>> eMMC driver and tee-supplicant. The last piece is the tee-based
>>>> variable access driver to interact with TEE and StandaloneMM.
>>>>
>>>> So let's add the kernel functions needed.
>>>>
>>>> This feature is implemented as a kernel module.
>>>> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
>>>> so that this tee_stmm_efi module is probed after tee-supplicant starts,
>>>> since "SetVariable" EFI Runtime Variable Service requires to
>>>> interact with tee-supplicant.
>>>>
>>>> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>>>> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>>> ---
>>>>  drivers/firmware/efi/Kconfig                 |  15 +
>>>>  drivers/firmware/efi/Makefile                |   1 +
>>>>  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
>>>>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
>>>>  4 files changed, 890 insertions(+)
>>>>  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>>>>  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
>>>>
> ...
>>>
>>> I think we have a probe ordering issue with this driver:
>>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
>>> with the default efivar ops still registered. And that means
>>> efivar_supports_writes() will return false, and the fs declares itself
>>> as readonly. I've seen systemd mounting it r/o initialling, and you need
>>> to remount the fs to enable writability.
>>>
>>> Is there anything that could be done to re-order things reliably, probe
>>> the tee bus earlier etc.?
>>
>> This driver has a dependency on user-space daemon: tee-supplicant to
>> be running for RPMB access. So once you start that daemon the
>> corresponding device will be enumerated on the TEE bus and this driver
>> probe will be invoked. So I would suggest you to load this daemon very
>> early in the boot process or better to make it a part of initramfs.
>>
> 
> That is not the point, really.
> 
> If this dependency exists, the code should be aware of that, and made
> to work correctly in spite of it. Requiring a module to be part of
> initramfs is not a reasonable fix.

In fact, I've tested a non-modularized build as well, just to exclude
that issue. The daemon dependency is more likely the problem here.

> 
> IIUC, this also means that the efivar ops are updated while there is
> already a client. This seems less than ideal as well

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

