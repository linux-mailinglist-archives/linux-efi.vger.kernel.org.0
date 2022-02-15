Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3104B7325
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 17:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbiBOPBg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 10:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiBOPBe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 10:01:34 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::721])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB0283;
        Tue, 15 Feb 2022 07:01:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkTUZOH6tWUH7zk4JOUDmZY6ZDfd71a844EpdSu4YGf+bbvBwjLZzDwd0/PZxjqRgsAUoRkRCIFRboP937ypFY0WyZfy422wSO5EzvDfagnK/0r1otB1OokJY2zeRCjCd3EguykyYKD1+BRaHQUs7vWEUNF8C8cWUxX9++ASj9bwoYnoSSJ4o8qctuPIGxExLRvi/FVEOdyoGTTcX/Wlnjbg4TmQcYUSb7VGBTZXp6qhCeUXc5e59S1+JkZEPGfP2p2XnZbvLT+uYYC8L/Z0Rpn5bdYxb5eLGrQghBq0fPKks8Qx4fw5RpW2Ps7bnpYqd6aMgYSd8Y+8AkQBFf0CDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaC6fjee2qozoeib4sQ6xWlEnDHNrmpbnJf91q6Ykk8=;
 b=JBIDFQjRA7vmlyM7gfPu6g0qMD38mvuf4GwZ+tN5P8Docch3AYakkWHPt1NTIQuA1ceU7k/2dJZj/4Cr4Y6TwtS0zBZ5zgy/yTxRbrof4TEtIZdZl2DooEhjCk6KwdPqGRrf3l3uAS5za1xzd0anV0orrtfdLRqc2OlJQ/JeTzaEJ1bNwzQFoWyXE/Q8pL17d44nOlGnrnXvykLVlOMQpq8w7mUgWoVGFR6Wv25U60kWPQUfUacV8g71Mv4j4FVQ5uFfoxpgpvyUgQHccMHtDEL304ukPfqkWLcmgWKxczNvAPXgxZ55e8zf8BdsAbQgf8AFgr5FH6ESM37eEtFFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaC6fjee2qozoeib4sQ6xWlEnDHNrmpbnJf91q6Ykk8=;
 b=vg1QqQs6J6aLEL1x6EDa6RcGbA21+aYEyb08PUrxUUZA0Y2ek8J5sD709vIzDxuUMtgh/9gbPxY9LsmKJwVfLzTyGSCAznX95OKSCMnhmP2wSIFqW/j/I5JpBqLFsltWR+oCDPXnxh+cAuGjGDEmsG9BMxbAjF+dg83/e0FYsHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by DU2PR07MB8149.eurprd07.prod.outlook.com (2603:10a6:10:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.13; Tue, 15 Feb
 2022 15:01:20 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::5162:f984:3822:5b7b]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::5162:f984:3822:5b7b%3]) with mapi id 15.20.4975.011; Tue, 15 Feb 2022
 15:01:20 +0000
Date:   Tue, 15 Feb 2022 16:01:15 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YgvAO1UbZcbcj5na@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com>
 <489b76f9-fbaf-dae0-c90d-c52ee0de92a4@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <489b76f9-fbaf-dae0-c90d-c52ee0de92a4@roeck-us.net>
X-ClientProxiedBy: HE1PR07CA0046.eurprd07.prod.outlook.com
 (2603:10a6:7:66::32) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a922f2e-6194-43d6-3148-08d9f094065a
X-MS-TrafficTypeDiagnostic: DU2PR07MB8149:EE_
X-Microsoft-Antispam-PRVS: <DU2PR07MB81495A1C8033951F5B81F640EF349@DU2PR07MB8149.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o81lRXfw+Z2gSeoHORbp1Kc5VQt8mdPaWpaZfsUq0zUxk8pgL6xZeEzf7wHhOSSm0Nz0yEClD9FxtahbyCqK7aKV1l9TudJbCwAgiJFBRMBm5gCnMs0gkFdcd4GoyFDuRARnORnmojwnEm65hbnHsQrHiWWsMinJ85UlJHVKZM08Zfp3I9dPZtzbmpAnswVE4W1VsorUHifp/kW7bbZC0Yi4BHxw1LOnY4TiWB0aphSBIwd5yk9OWmrm6K2E4y3H8LW/J/5VEOepSSI79gZYzineGhPt679ZEOO9DlxVRkqW/ic+IV5N2PM0EUhoh77mvq359IP3JORO6gl7Fn5C0bvKc5PsioX43sWfaRffMQeB+tTIuVKJ6f+Gu4RrjoP/y7s0EjJHsauxMutPmQsXGsiEFry9E4uypcK4QrGq3YguCBXgkItsUrZ+Gz7hQkSBee9+Y/wbsXPLmb8rqUlMY0cy3uKzOzOZnrQq7aJfcw+PLuuQ88s7oxf6HGv51lRGcPO0Ce5fKefeB4ToIuc4p0IrDOxmuFPDzY3zfghqgDCTIvrDpkeC4kVGE8NXu/VGLnMbIJAKxQW3HArOt7E+8NskB9lTFYntj+0kHxybEJcE7GzrLBEx02MMIpaSYj8xx94zAYp5m0fTLj+jSKyufQqtYo3HLQHFP7L4hjZREzuJkmhZ5UT8G1+pW4cPZfL3D5lHlWRrQw7o6Atg86EnEFz/Es/cp0A+u4RVO4KdMOrYa9/Oi7dWII9MG/Aoz7+7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(186003)(26005)(38100700002)(8936002)(44832011)(52116002)(7416002)(2906002)(82960400001)(9686003)(6512007)(38350700002)(8676002)(6666004)(66556008)(66946007)(316002)(66476007)(508600001)(6486002)(54906003)(6916009)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk8rdGNSMDRUZVhESFBOYWJ2bzhwVjNybndrQyttYldGZ1N2T2dNOHUwSUZx?=
 =?utf-8?B?TzhRdFdCaW1Xano3eTQ5ejJFaXdvQ3FuNDdFOXJ3TTJZZHV2ODJTUUdqZXlq?=
 =?utf-8?B?aGdSaXIzYTJGN3NOd1hhaUhPcFBvYTVjcnFSakVjcEVmQmoyR1hCUS84bWxt?=
 =?utf-8?B?RE56ZlJPeDZIRHUwOGJabHJPUE5vTWJ1ZVY5eGNpTnZ0L1ltTjJlWlBIYmMw?=
 =?utf-8?B?ejhCYUFURUZKWjZCL3c1Lzc3NzR6OGFXNVFFb2srQ1FtMi9wamg3RGxabGY2?=
 =?utf-8?B?d21WZk55L1dqbDJRdk4xakhjWWZlcmw1d0RhaStRSXU4YlQzc1BLSWhCbXp0?=
 =?utf-8?B?d0pCWDlZUExYNlcrS1JySFZ3b1R6M2tDbmErMDdZWUZid0NUQlpyYWIrMlhv?=
 =?utf-8?B?NTAyTkZ6QXgvRElSSGp5UUx2dGlqVGNKREJ2UGdEZDhpbjMxVmduV1dkenJ6?=
 =?utf-8?B?alVlNzRPUHNNcjhrMG8rVS9CZ1d3SGlzOXhzRCtKRjJJY1NWOHBjWkIwQmRW?=
 =?utf-8?B?b01tTDllWUtYUGN5UThoOW82Qi9qaWFhRzBCQ1NwVUhaRytWWEVuOE4zbW5C?=
 =?utf-8?B?SlIzL3BCeFRiU3hJTmtpdjVLUnZNVDZkNmpzdGVicGdMaGtwTVRvb2R1SjRU?=
 =?utf-8?B?aEhwTktkUjJmeVZQR0VqZlJLc3ptRERVeEEzT1k2ZmFKbVV2a2hmMm1PMGkz?=
 =?utf-8?B?NzhUY3NhemdjOVRTSGdHZVo2dWQ3aVEzNFFteUtNZmxRRmJ6TkRERlpCa3VC?=
 =?utf-8?B?R2xTbWY5TW9OUEluR2kvRXBUbTNreXFFVW5ORzdmcGNaWFQxc2pzRGhqcTd1?=
 =?utf-8?B?b3JWcHgwZDZzc2g2aitkNzRQSmxVWjhsdkxtRVpjZnlCVGhnWVRYTUhXd1gw?=
 =?utf-8?B?eGwyTzFXcGxaQXdvNUdiV01ERVJhS2R6eC9oa0ZIUC9FMmI2QkhDTVMvdjhx?=
 =?utf-8?B?MEtVV2l5Sko4bGRBYnBEaDVNc1paeC91cUJoSlM4YlBYOXZ1aE13a0pXeEsz?=
 =?utf-8?B?eWg5c0VPdWpFWVFoZHUvZm9sTnlUSTlTREpteDM3dHdIYlpWUUd1NlBlSytT?=
 =?utf-8?B?cXFweUxWclRWRUR1R3JEK0xLaHEza3dMU3ZXeG9uTTMyRWNjejRtZ25scWxh?=
 =?utf-8?B?bHhPTHpleWxJZkMxRGgvR1RRUmt5SUNEd2FtT0R0ZXVGL1I2MXVNQzRXdlND?=
 =?utf-8?B?SjdnaGs4d2dEblA2Mm1TYTY2Sytnd2Vrb0xxc3d4UWVITlQ4c0tyb1pZeCtE?=
 =?utf-8?B?SVh6WlRGUHNtSEgzcWVmQ1k5MlVsRG9xRVc3MzIwc3lHQVd0ZVBjcm1pYnlH?=
 =?utf-8?B?OHl3UllKYStnellSQUthY3FpMVZuZkVncXRXanpKL3dtTlZTTDdmb1B1Zmhr?=
 =?utf-8?B?YU1mbnRxRkYwM09PSEUxeGdYazB0ZHdYMmlYWVBLemFSb3J0SmRTU2o5aFRP?=
 =?utf-8?B?ZVZSTzRGMGZkbXFoSldESnhsZHpUOE41L3MzYXM2UXpBT3I4OVRZK1ZKdVlT?=
 =?utf-8?B?YlhOR1Bpb3c0MGVjSzBiNmpQVE5rQlBQNE9kQ2o0MnFiSjBWdHhQTXRxK3VG?=
 =?utf-8?B?elBOQXNXbmU2M042eDBnd3M4ZWNidlpxM1NkcHBLbDVQSVN5eHZORE44ZnBx?=
 =?utf-8?B?bHRSOGp1Q1lVSTF4RlZNdDhaY29Bc1pSZXloczVQMldJOVdwOTBIQm9lQlF3?=
 =?utf-8?B?VFdRRmt5eFp1M1BmU2J3dkdoZFI1VmYyRzhNK1FiL1QwcmVKWEd3L1ZFSWQ1?=
 =?utf-8?B?Ymo0eEVvMlJQL016UmpxQU5JUWhNa2NNVUpsTWdRaEZyeEtnNEdKNlRLbGNh?=
 =?utf-8?B?SDRpVEFsbWtDY0tQRk5MWkxUUHpVQWsxTEc4djR5SVEzMGU1THFiVnJHVnEw?=
 =?utf-8?B?TE5DM1JRUDVpbitVdWllMnN0S09vREpjajlPOU9MSTM2bmxvSEwyRExteWhY?=
 =?utf-8?B?VzZrYjB0MTFaRmM3NVVsZXFvR1dpblRzMENySmNNcWJWZzNyNmdFWk5zbnZ3?=
 =?utf-8?B?U212eERDbDc0b3JiNDdWelV5MkRDNDlrRUV6QzVKL3pFcXdHazh0cDRwWWRu?=
 =?utf-8?B?ZW1kamwwcTZ6Zk0wZFcvN1d6T2Z6ako3WC9mNUFuS3puYWJOYmwxay9QSGs5?=
 =?utf-8?B?ZGZVdE1nSHNVY3o4WDBENk5rSElsWnZqdXorcHpZSzdCU2RvaTVybjVmeFU2?=
 =?utf-8?B?Zm94ajhjekI2c1ZmdDQveGtYYkVqdmpNTEt2L1AxR0Q5TVcvZkY2aXBWQ3FY?=
 =?utf-8?B?QjhJUU91dG5BenkxOEZnZ1NZNlhBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a922f2e-6194-43d6-3148-08d9f094065a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:01:20.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLpxl+WnrXmEcch16zA4VSpSqvVbIZYruRxtYwRczZb6M0taMm1jEhC5gKVJxCiDGJd3xH4NvTJ1jfp91N8H+Up3zU1ePorzLKVLXmZboVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8149
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dnia Tue, Feb 15, 2022 at 06:30:26AM -0800, Guenter Roeck napisał(a):
>On 2/15/22 00:44, Alexander Sverdlin wrote:
>>Hello Mark, Ard,
>>
>>On 01/02/2022 14:58, Mark Rutland wrote:
>>>>You could argue that restart handlers were not created for that but they
>>>>suit this purpose ideally and it wouldn't make much sense (in my
>>>>opinion) to add yet another notifier chain that would run before reset
>>>>notifiers, for code that is not supposed to reset the whole system and
>>>>this is exacly what I would have to do if efi_reboot() is forced to be
>>>>called before all handlers.
>>>
>>>As above, I think that's just using the wrong interface, and the reboot
>>>notifier mechanism *already* exists, so I'm really confused here.
>>>
>>>Have I misunderstood what you're trying to achieve?
>>>
>>>Is there some problem with the reboot notifier mechanism that I am unaware of?
>>>e.g. do we bypass them in some case where you think they're needed?
>>>
>>>Are you simply unaware of reboot notifiers?
>>
>>Could you please check the simple case of pwrseq_emmc.c?
>>
>>While that's currently the only example of this kind upstream I can imagine
>>further use-cases, especially in storage area like above.
>>
>>Would you suggest it's illegal usage of register_restart_handler()?
>>Do we need to fix pwrseq_emmc.c by introducing new atomic notifier chain
>>which will be called before restart handlers, so that it works on
>>emergency_restart()?
>>
>
>Abuse isn't just about using an API for something it isn't originally intended
>for, abuse is also to intentionally _not_ use an API, as it is currently done
>by the EFI restart code for arm64. Also, keep in mind that the same argument
>(our restart handler _must_ be executed under all circumstances and does therefore
>not use the restart API) is likely going to be used again in the future. All
>it takes is for some other standard (or chip vendor, for that matter) to declare
>their restart handler mandatory if present.

Wait, but it is up to us to decide if we want to follow such standard or
not. If we want to have code that is more flexible, nobody can refuse us
to do so, right? None of the standards says that we can't support
restart handlers in case of EFI on ARM64, it was decided by kernel
developers, not some vendors. We can change that.

>Given that, I'd suggest to cut your losses and try to find another
>solution for your problem. That may be to introduce yet another API,
>one that is called before the EFI restart handling but that is always
>called, unlike reboot notifiers, or simply stick with out-of-tree code.

Sure I could create yet another API like you suggest but in practice it
would be a copy of existing API as i would have to work exactly the
same - would be called at the same time in the same situations. The only
thing that would be different would be separate chain.
But if we want to prevent registering some custom code to be run before
efi_reboot(), that new API would have to be rejected as well, for the
same reason. So what is the point?

Krzysztof
