Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B505E6D4C
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 22:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiIVUpP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIVUpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 16:45:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E56E21E8;
        Thu, 22 Sep 2022 13:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXT1Xz9E21wXZFZ2JRhtq02E7zaOvKx+rBDq17ghCrrZ7kBy+4WOxJhbkTCFQbZHfwNLVmp+OayJOeQ49HYo4hoZf8vMAUe89/VaabPSX/QlRVCRnq43QzXgm9TTakjnB5Wzyd1dFVSV1o2Bj9oP3QAlE55Cmp9ayrBk/gASIwntCoRKQ8ProcnB7xA5G0q1pDy9wC/g6q6kPve6W0qbLrbrLge4KE6UhRykxREGtWpKTlhpfgCj9SHHobAwVTD/KCPKOWPeUqUQGvqBxbtu0Tuv75wuLBCZ0rBeJPxwktPETBi32Zw3Tk1TE39Ew8Su39Cba2267SxNCvaIhhBaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRNzI2qxAKvnz1aInNFTua4KkPPOYUAf3B9CPlrs030=;
 b=moGRFVeHydJBbAUWgKZQ72xTkZDTH3gpOMnJ4sf20E7BiI7erfXn/sghqE0rNGeQPB5a6uTCzo5RcLKKJBOAV6jDJei8SqV+vjCj2HLrZsYqRTSX+6jjdt1DReaBEm+xXM5h9729h+jndyZktM4AZkmkRsre4H41d1VULQfQ5ppMQmkZJjVXOPXOiy1eWnf86oFsqV1EGnI1R3kHNSXeeHM7m+uduRB3ZUycgNRzcZ74UO/bVQo7te1kf0Eu4fuh5khq3t63u2E8wS1X0g4L43EFIcC6YoMFOg0MjREaWXT+eHVRgkIpjYRU1P+zIivqBIgzjLbcUVcx5CTp5OFiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRNzI2qxAKvnz1aInNFTua4KkPPOYUAf3B9CPlrs030=;
 b=idymt9cBMEDm4qKxWU0svAh+bo1HjSU38TL3wMQUgrPXUxLbVXkF5xYxubQgnH7DntUMoOCjOPe6scfy6uA+vnr0GxVJqnFgZziOlKIfJZqhLDcW2YoQAAVj5sAikdxGebQqDD51zJZ1VDD4xo+PbyqB2ssF/hYgonTCGMg2Ee0B7AtqOz04IdOBxHuIhsKjJnJrfkDsV4NWdoqD70EQstrCii38TBRazIA1P6TsO0xvCJ8aWD+ZIyGUCwF8LG3iwxLiaqSr5DERGieZjFDvmC6V8a2Z7bZaqdfag/1X3sGnQf/1o1rkHpgUIxL+lJrWVQ6+kLpK5jIL4zM46jIpiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM9PR03MB7489.eurprd03.prod.outlook.com (2603:10a6:20b:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 20:45:07 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5654.014; Thu, 22 Sep 2022
 20:45:07 +0000
Subject: Re: [PATCH 0/8] generic command line v4
To:     Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     linux-efi@vger.kernel.org
References: <20210416040924.2882771-1-danielwa@cisco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
Date:   Thu, 22 Sep 2022 16:45:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210416040924.2882771-1-danielwa@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::12) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|AM9PR03MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e73d97-7860-47c6-a4a0-08da9cdb5552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGOXnGsukXz2qL1nIrEuMqcttbS7kpXyxM18YpPNKBAtqofbOo4s3tzxleD1yVKBlRlhTX9KntLU8MDPEQ73sGoAMqaV8CaX3/U/Kpkq/GiO1ZTgLJLzL4BJM5+kp+WRr2drx3XPocf4O8mDIRisFaNb6D7nvoLgTbYQ46cGV0f4tzDdLPKcqZw29dj4Zcx8eQfB4rkIq16xEQzMq1i5K5YTeL2lduwNaeVvxzdm6OOpfjwdLl5I+wKNu3DcqQnwHc0QT20Bq+gr6fyDyyvRXKuJ9sH1tOAQ146Hb8oQYoSt5lmri93Lc/PbWmSSX26Yt3qCi8NJBHr8eLfwPiroahinN3St+yJLTSQZ1vMofAR0CJAXx/QUMqbqVN+m6owa9bFb7DeNdEQ2jks8Osy1b1SFG3EbCsARqmKSLy7Px7ahQOdi9ME9lSlWQqnMIKHo1HI6puDp8c0vn5MnSvk41NlL9HrMzJoycLAsDUIV+lzMXtDwsPYqb69KJE0hHt3XlryFaeZue+MGs+1q2kM4EUc0ZK5b2bBiriGIMPAqphzdkjVCcDusV094C7rS+pCBRU9PY4G16Usdv+kvJ0gtIEsok+mRGqquyj/nku6IFQ/1H4BQJAVn8xweIk+U2Y4mMLAswV69yFtbTRCCowf8OOOSEz7YtaOUrDG9kJIDFkfIbBFPUK365ZKcLYlmsdMyJ8MBVBNjqcmMrzvH31tDDaRNP+qjr9OnGAMgxh9YVvxLj0rRtx+y8/yDGsJPlWDZ6ForucwQEQosoyoSYf37EKF7XyVgV/1qQWTIHLz7HMp3Hb6N5rhm4xle6sGHWP6EjIsgeINOlMIuplkwqNr2dykYXbP36GtPekBRyIEwNvmUuUFWXnKY3BydpWqANmh1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39850400004)(346002)(376002)(136003)(396003)(451199015)(5660300002)(38100700002)(38350700002)(921005)(316002)(478600001)(86362001)(44832011)(36756003)(31696002)(2906002)(110136005)(66946007)(6486002)(4326008)(66556008)(66476007)(186003)(7416002)(6512007)(26005)(8676002)(2616005)(6506007)(53546011)(52116002)(41300700001)(6666004)(8936002)(31686004)(83380400001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU0rVzh1MGFkdlJCTndOVnBwQTdERWpXWGF4YXVtQm5TbGJweHVxa3I3UU00?=
 =?utf-8?B?Y04vN29KQVhkVG9zR2hjdUN0NTNhOFZjUWp2dmV5UDhSUGZJRHNwRmxtWHpW?=
 =?utf-8?B?cWZPQ25HckFxUk1PK0JGN214WHRjOGtvYzNUR2x4MjV2dVplaml3Q1RBdExX?=
 =?utf-8?B?UjNPcDd5dDVkT0JtbDlGWncva0w1ZTkwcTIvOG41NTZqdHJtdjIvL0V2WFRx?=
 =?utf-8?B?NXczVzFWOWR2VURMN0hkWmFuUng2TGVzUGlaSXFjVC9LM0hDalh2ZmlXL0V1?=
 =?utf-8?B?aFV1UVJpZWNmRjkwVlBONEdnaElPLzNEcDVnQSt4dVdRbVBUTlhydGNWNHlK?=
 =?utf-8?B?M1ZGZDhFTisrei8wdVgvVCtoZTcwSGZGaUNwRDBzTjc1L2JXRXN0ZjN6emht?=
 =?utf-8?B?bVNpT0J2NDRuS1VxK283aHJmMlo2UGtvVzFBREo1VVU4OTNsS2tMbk5BMHBP?=
 =?utf-8?B?cTFtVjNzTUlkb0hiMnY4a0dUOVlOeURzU2JIN0x5TWQxYy9jaS9JNERFYVAy?=
 =?utf-8?B?Vy8rM3dLaS83SUZzaUxzY0E2Q3FFWmlKcnhnR2RtT28wdFRQcEdhYWgyWWVY?=
 =?utf-8?B?R01Ed0wyRDFjd0lSWE8ybnVDV3FTekFidkhhMTFqaUx2QzhqdjEvWmJzTHFw?=
 =?utf-8?B?VjhGSnk5Yit1YzA2T25xTm16VzJ4SFlCT2hsaTdCRU5hTUJtcDI0NkM0SWVN?=
 =?utf-8?B?WlNEc3lVdEZweDhVcE9CbDhSZUpnbjQ2RjhZdTYrQVJQM2V0UW12cnhxRFJT?=
 =?utf-8?B?aHRZQVZrcG1xK09QdjhsSTBUeWs0dnR0OTZqQnF2bG1JVStjZDBxcEV2My9T?=
 =?utf-8?B?N2VJb2ZtN1dlb1lYcDNNNkVNbGFCeXh5VHBIRHNRaHRGenllSUc1Mk9MUnZZ?=
 =?utf-8?B?R2kwZ1hRUk5mWFd6S1pKcTVrZS9OeFRFemluYmhpZThHTndOZW50dkU0aE14?=
 =?utf-8?B?Mis0d3NKVDZkdU9pM3c2ZGpBVUtITTI3MXoxLzNvcTRVSk9zamNCK3hEZmRK?=
 =?utf-8?B?THNHVW5TU1J2VE5oOFJtQ3poK0d3Q1NGYUpzeDU4b3dtdC9TdXp5b3BoakNF?=
 =?utf-8?B?NkFFNWEvM0FNeVNMZFhWazRVNGMyYmJmckJIQmhHRmh2cGRzRWdnMjgyc1BW?=
 =?utf-8?B?SVZzOHBlWGd3MXo4SkFOR21iZHdTNjZOODYxcUNGVHU1VkdubmFhNW9IVnNo?=
 =?utf-8?B?TUJNazdZcTF6ZWdyWjRCdlk5K3R2UXpRR28xRktWTnZPbmd6Q3BDMjd4ZDBM?=
 =?utf-8?B?ZWt6WTd1T2YwNXc3bVhUL2tTQXZwQVlKLzluOXZXVWRWRjViL1I5blFVb25O?=
 =?utf-8?B?Q0g4SWoxWTFGWWYrTU4yUFJud1hZeFlvQVhlMkxUVTBNNHRUZkwyallCbks5?=
 =?utf-8?B?alFjT1lHMlpPUkZYbWZRNGx3Nk1iYWlUMFd5TmtQeUpoQ3pGUnRPdUx2eS9j?=
 =?utf-8?B?T3ZSRjRHY1o1M0E0OEtoeGFHNStwdVY3VThvaitoUGVkODc0aXNDSVdTU1F1?=
 =?utf-8?B?TmgzOHAwYTg2SmExUDg5Z0dIQVpmV3NWRzd2ekZVdEhNTCtFeUIveHF2bzhJ?=
 =?utf-8?B?V2MwM0VtS0dCWENza0o0eDBGS3NGMVdlYnBDaElXZm5lSldkWWxxL2xpL3R1?=
 =?utf-8?B?MEQ4bWhBalZWd05BNENtSUVRRGJGTDlXOHBMWmRyakRqSkpVdHEvSS84L2JK?=
 =?utf-8?B?a0t0M0JsRGRrYlVqbHQxMnM2ZmlzMXBWQ1MwaU9uZXdSSzJkOXBicExKWHMx?=
 =?utf-8?B?MFVNYXd1U3dyYmExaXhDMnd3RjVhRGViVDdMSFNQa1k0S1paMFV0NHd2RkVs?=
 =?utf-8?B?dm1TdmVyTGtQTHFiSmxOTXorcUZtRldtQjgraUs1alZYYUEwczNYbDZaUkN5?=
 =?utf-8?B?SVpZanNoTHl2Z1M5alhOSFQ2bnYyQnRtQllCdm05YTU2bjJpaFVRditlQ00x?=
 =?utf-8?B?MFFOb2RyMDk5UTVyRUdCUzN4SmJobW5XbWppaExHdUlIVUY1UkpxdDlndWNP?=
 =?utf-8?B?RXFwVkZGMDZmUmN2eFMwTUozUHB0Q1FjRE1JeWEwZld2ZWNldXZTWDA1OSsv?=
 =?utf-8?B?Y3ozRDNqUzZoQ0x0enE3UWM5M3grb082NnBCOHpNZVJwQ2o2WGNQWXR1RVd4?=
 =?utf-8?B?U0gxU3E1RnNhMlJ6TzRXS1EvajFjRGthdnVQY3FjVGtaQWdia0I4RldEaGRP?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e73d97-7860-47c6-a4a0-08da9cdb5552
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 20:45:07.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwG5PW2KJTygBs9VaQOnjkW+lnZQ1Mo17MCVS6VJCx6HzxoY7oHwNL7fhrTShyqQBSwCgjyUK9go3r5sMH+nyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7489
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 4/16/21 12:09 AM, Daniel Walker wrote:
> 
> v4 release changes
> 
> * Updated insert-sys-cert tool to change command line symbols after
>   compilation.
> 
> 	This tool is used to release binary kernels internally to companies
> 	and then later insert certificates for each product by consumers of
> 	the binary kernel. Cisco uses this tool for this purpose.
> 
> 	Cisco has a similar need for the command line to be modified on a
> 	binary released kernels similar to how certificates are setup.
> 
> * Added global symbols to hold append and prepend values.
> 
> 	These changes follow the system certificate code to allow the
> 	insert-sys-cert tool to be used.
> 
> * Added a test case to confirm functionality.
> 
> 	Seemed sensible to add this to make sure everything is working.
> 
> * Dropped powerpc changes
> 
> 	Christophe Leroy has reservations about the features for powerpc. I
> 	don't think his reservations are founded, and these changes should
> 	fully work on powerpc. However, I dropped these changes so Christophe
> 	can have more time to get comfortable with the changes.
> 
> 
> Enjoy!
> 
> 
> Daniel Walker (8):
>   CMDLINE: add generic builtin command line
>   scripts: insert-sys-cert: add command line insert capability
>   scripts: insert-sys-cert: change name to insert-symbol
>   CMDLINE: mips: convert to generic builtin command line
>   drivers: firmware: efi: libstub: enable generic commandline
>   CMDLINE: x86: convert to generic builtin command line
>   of: allow sending a NULL value to early_init_dt_scan_chosen
>   CMDLINE: arm64: convert to generic builtin command line
> 
>  arch/arm64/Kconfig                            |  33 +--
>  arch/arm64/include/asm/setup.h                |   2 +
>  arch/arm64/kernel/idreg-override.c            |   9 +-
>  arch/mips/Kconfig                             |   4 +-
>  arch/mips/Kconfig.debug                       |  44 ----
>  arch/mips/configs/ar7_defconfig               |   9 +-
>  arch/mips/configs/bcm47xx_defconfig           |   8 +-
>  arch/mips/configs/bcm63xx_defconfig           |  15 +-
>  arch/mips/configs/bmips_be_defconfig          |  11 +-
>  arch/mips/configs/bmips_stb_defconfig         |  11 +-
>  arch/mips/configs/capcella_defconfig          |  11 +-
>  arch/mips/configs/ci20_defconfig              |  10 +-
>  arch/mips/configs/cu1000-neo_defconfig        |  10 +-
>  arch/mips/configs/cu1830-neo_defconfig        |  10 +-
>  arch/mips/configs/e55_defconfig               |   4 +-
>  arch/mips/configs/generic_defconfig           |   6 +-
>  arch/mips/configs/gpr_defconfig               |  18 +-
>  arch/mips/configs/loongson3_defconfig         |  13 +-
>  arch/mips/configs/mpc30x_defconfig            |   7 +-
>  arch/mips/configs/tb0219_defconfig            |   7 +-
>  arch/mips/configs/tb0226_defconfig            |   7 +-
>  arch/mips/configs/tb0287_defconfig            |   7 +-
>  arch/mips/configs/workpad_defconfig           |  11 +-
>  arch/mips/include/asm/setup.h                 |   2 +
>  arch/mips/kernel/relocate.c                   |  17 +-
>  arch/mips/kernel/setup.c                      |  36 +--
>  arch/mips/pic32/pic32mzda/early_console.c     |   2 +-
>  arch/mips/pic32/pic32mzda/init.c              |   3 +-
>  arch/x86/Kconfig                              |  44 +---
>  arch/x86/kernel/setup.c                       |  18 +-
>  .../firmware/efi/libstub/efi-stub-helper.c    |  29 +++
>  drivers/firmware/efi/libstub/efi-stub.c       |   9 +
>  drivers/firmware/efi/libstub/efistub.h        |   1 +
>  drivers/firmware/efi/libstub/x86-stub.c       |  13 +-
>  drivers/of/fdt.c                              |  44 ++--
>  include/linux/cmdline.h                       | 103 ++++++++
>  init/Kconfig                                  |  78 ++++++
>  lib/Kconfig                                   |   4 +
>  lib/Makefile                                  |   3 +
>  lib/generic_cmdline.S                         |  53 ++++
>  lib/test_cmdline1.c                           | 139 ++++++++++
>  scripts/Makefile                              |   2 +-
>  .../{insert-sys-cert.c => insert-symbol.c}    | 243 ++++++++++++------
>  43 files changed, 716 insertions(+), 394 deletions(-)
>  create mode 100644 include/linux/cmdline.h
>  create mode 100644 lib/generic_cmdline.S
>  create mode 100644 lib/test_cmdline1.c
>  rename scripts/{insert-sys-cert.c => insert-symbol.c} (72%)
> 

For an arm64 platform (after rebasing):

Tested-by: Sean Anderson <sean.anderson@seco.com>
