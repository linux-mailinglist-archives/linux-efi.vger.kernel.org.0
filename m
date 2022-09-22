Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B665E6D91
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIVVEE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiIVVEA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 17:04:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E310C7A0;
        Thu, 22 Sep 2022 14:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhmR0iUN8/6md+MOOhqzFEQqZE9vpvMxgnrZjnRAvCQ0egSwFIR1/lDt+zQ9eqDrJGR+dgLG6n4sEpMZdqHzFgLsDcImAQWhkQnU7HxRO5VdnO4DgTiKh3Xy/M+4Ew4imFnTddMx2kPmdxSdSl7kwKlKFwJrdE9ogx8oxJn68yjU3RS+AYGPdFOefK6Dzp11Ok9nstV17GHXcsKoxMdu7UK7G505Nr758diCTzzWhWcFaTJUau07ExFyYkm3vz/tbl52UhNEFfdblZTiqk2oHJZVWHc8f8Z6/RPG3rwkZLmKvsM79gq/jLnMtXCL/jJswVDmZzL+wFR8AXK1mmzXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKP3i6D4YwFPZrWzy0SUkq0uP27oCK+O8hfCyTLoNiA=;
 b=LtAfz2rNdW0G0guHQbSGpprq/T9CGk3O+PiPBesKGmbQdLX+BwrQ4+Sg4Y+yuloRbiZDTU7LkvvRY2W++Z2scpDS2ki1N9OKODhoxTtOmnTta/o2OYq9Ft5ptu8YMvUHKDf5NIZqqexdadJn2Kub4CeaA9qwztgDT37zSYxN7tNpUYzWIOaiI5EuLKKpJ07UO31hMeG0QNOyYqPwd7Dryc8qr2KtPAn0QhnCNuTfpBmUakWB/EFSuV8GuE0KWyQNS/M3h0uU6LZ+OhWo0TIrUpN6mq11zMVnQYNHtvis99kD9ic+855hxsvA3sM0XKjhGxIxz5Ecv3ZmJIIM7jG6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKP3i6D4YwFPZrWzy0SUkq0uP27oCK+O8hfCyTLoNiA=;
 b=uGQcalbbDk3iofCfnClc0oMwB7hRuOfydl0MuQ/W2tD+fnsS9ZhQYaCyQMEFAiQQMyGXnQFT3TUuqeDtYDDZV5tBUPZgmDAF2kvN3SCBBNToaIPg1kyE0MrLVFHlqAuDJU2LxhT6IcEVPcuZ/T+XpJCsDtUKhtNMV0MlIQkoGSQmcqvNoLZBCJWvBEcrCdXAUljuZXdX6+379F7zgaunNez5XwWwmSivnt+3KRhLO4BPUkZcQHidDiuqGxqnfi164IrdPW1YXhRRPIsbAV2ohtbb2We3+DrAK0YyQNu677skFqddMP+5ICChT9j9imUsUbrCeCMqXxwzwKm/nylOTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB7352.eurprd03.prod.outlook.com (2603:10a6:20b:2e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Thu, 22 Sep
 2022 21:03:56 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5654.014; Thu, 22 Sep 2022
 21:03:56 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 0/8] generic command line v4
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20210416040924.2882771-1-danielwa@cisco.com>
 <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com> <20220922205334.GV4320@zorba>
Message-ID: <dcff9b0f-82c8-5aa7-0fff-b749a05fcb20@seco.com>
Date:   Thu, 22 Sep 2022 17:03:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220922205334.GV4320@zorba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::7) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|AS8PR03MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfcf065-ba5d-48fb-722e-08da9cddf653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHj98PQ6kQvuC/gKcxQwP0cYsDAR5Io0gqfug/yeqexvKmB3TuhlZqoTmAZzwAsJzgslST3Z/SX42hGbLVFDVgy4LOifrtqwsVIy01YgtH1kZSmcY/qRYxBDTTwkfohTGyLwjRCOIVs8EQo1+p+0nE9y0QMst2kVZNr2rufdvK1HFb4cSr4OBsXsba3d+gZ+ArP+jherAVqKuyPWQOaQeRjo0Sz0hq45GsxKOCBSoZ66T0pSIvMChNjFoMb26y+5/WuGg/eptzzNHu1u35GmEUJfVse12eMt3Ninf3ayFKgHSgKu3SNI9hRe5/xdSLJM7pI8n0neM7AT9hUeV5xO/C7xGicx2Z+Vs2Vc3cmM3N6aWYvGVg4n96uWvbbcnMCE1YTytBi+Gr9LMnhdmA5fgHp30Zzgdx6Iojl4irr/UXAcRxIhAcvVJfGdwb3BYnCtAx118AmaAP+2p+SnN8PG3awJnqGQ5keKkkMwYefd43B8fqetYl337eNNkdl+7hgUhebTxb9XLvCpzkGXq8hhbJpbg7iFP2SNK/c/rpCZGjuJW1VB7d2rnI1qi3gXuT9CUYOD3fFj0NypzqKaQnXVCmWiEpFJhWAX6KKHVxMYOMWupJLj+0nASAKHw0qIIbkRAq0zeQ+fg3a9AE0kjAIDsnvTH7y2A59a1rJBvP7ycCjOZ1nd+N2hFs5Wt+BuZrt15b7WHs8lEvG91nG6tsz1at0/uH4EC4T0VCkrU8RZU4pbMRzfx+pJQesoa5p88VntMy3vMbxh8e8DFfKf2Dp0qPFfHIPYAcXWYJn9MlA52IlWKKIXVgQQmmEK2fnlHmufKFxlK0xFWRoxGc30/A+SnAEmBWc+Ug2XJrbojy3lCgf6RYFYO6Ec6GmTnRlD9hpg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(376002)(136003)(366004)(346002)(451199015)(6486002)(53546011)(966005)(478600001)(54906003)(6916009)(316002)(6506007)(66946007)(5660300002)(6512007)(4326008)(8936002)(7416002)(6666004)(8676002)(83380400001)(66476007)(4744005)(66556008)(86362001)(26005)(52116002)(36756003)(44832011)(38100700002)(31686004)(31696002)(186003)(2906002)(38350700002)(41300700001)(2616005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBzV3o0VW5rdjVOWlE0eHhLWHVuSnpkT0Y0b213WTlaZE9kMU45c3ZiZ0Rr?=
 =?utf-8?B?c1U2eVJsYVVGNThBaHJ0aWxUS1RkeGhrRFNXMVljZVhSRWs2SUhPRmtxd3FL?=
 =?utf-8?B?VFpPRHdMZkUyN1JnSkx4SGpTc0RtTXNPR2NINjI4ZittYWdFN2VpcmFteENY?=
 =?utf-8?B?SmpPYXgranhxcE90d29aNWRjZXpyLzZmbkVxQVUzeS81dnhqWklZbVlRUUVC?=
 =?utf-8?B?LzdOMUg4VlZSdjNuRHVhOWlLSUk1YWt4b2pFQi92eVlLdGQ5Wmc3N0VYcVRq?=
 =?utf-8?B?UGZSdGNQQXUyOFFpMUpULzl5RlNDak9HV0FZa0FVejNUMnEwbnVIcE1vaDlH?=
 =?utf-8?B?VXNPSVRvNjFTejAwRkJyaXhkZzMrN1JKb1VRZWx6a1MrVlAvZ3BYcGp5WU9O?=
 =?utf-8?B?SXBsaVFTMWJVeW03dWcyY2xQU3ZXdEJqVmU2emhDKzJLN0RaekI0UmNuVlc1?=
 =?utf-8?B?NWtDc2RvaWJmajFUWVFZa01rVCs3anppNmg0Wjl0Q0RuQlBUdVFicGJrY1Vt?=
 =?utf-8?B?RXl5MEt2dHNEVDRxQ0xCVHM4TCs5SkxLeGg5WHJUcVFvZ0RzUm1wWnNDTTUv?=
 =?utf-8?B?ankwV1dnRjIxN284NmpZdU0rRE52QTJFbmwwbkw3a25nc3pJdlIvQVliekdq?=
 =?utf-8?B?a0lJVzhvMFlaOXgvck03bVNjeVBkQmFGcXloN2x5VXhYdUxRMi9haEJ2SXZO?=
 =?utf-8?B?T3h2TnJ4dmk0dUJQRnJDYXhxejhLUkJPbEJIamNZbVlvalpwNUVzYzlCcGFK?=
 =?utf-8?B?djk3NlJBK3pPSVlkeFBWdmVIRCt2ZG9Pem5BTlE4YVIzdk9qV3Y4VVdRTXRj?=
 =?utf-8?B?U0RBUTFBNTNnU3RzdU1pYm1McDhUTlJDdzJvc2ZiejcyS0FxNTdMVFFLUC9U?=
 =?utf-8?B?SDlIUVdEK1ZZZ2NGOTlqZ1ROUjlxNnFsY0hYSzIwQnA1RTdybnZ6dUJUYUJ3?=
 =?utf-8?B?ZWY3T0ZSS3Q2NDZBY0cwL0RmTjdFcWVqVm81Z2toVlF1eVdlVUpFSE0rZmR6?=
 =?utf-8?B?VzVyTWpOOEhuQ09wek1QaXhDU3FpSVVoRGo5cmZVSW1PT3U0YkhFVFhuNlM0?=
 =?utf-8?B?UkpMTDlweFF3T0tqbVkvMmRWaDdqSVp4RElHQ2FabTZiTkxiSUFQUk0za2Nw?=
 =?utf-8?B?OTJuU2tLbUM0MnFZalFtNitCbHNmc2JTOVZnY2RTdUMyV2tFOC9IVEdwSkww?=
 =?utf-8?B?dkQzN3lyd1ZMWkVwU3FEZy80d1lNb2UzN0dDQVVmYmJ0K3dqQ3lLMjZrc3ph?=
 =?utf-8?B?Z1BVak0yZHZVWDBVak9KVUNaVGZDUkNrMU01SmVCZHhLT1dRSFJnTEIvcEFG?=
 =?utf-8?B?TllxUUVpZDZoSHBYeVVEYStSeEZydGtQTUY3MW40dGJ6S0g0aUtOS3BGY1ZD?=
 =?utf-8?B?N21HMDkyaHV0TlVmaEVkU0ZjVkRhVmR6YXFXMCtxdEEzakRQYnhyK0ZwUkt4?=
 =?utf-8?B?anlQbndSVlhqRWNnbWVFQnh2a3paeGorMTJZR2lTZ1ZLeGhiQnp4ek4waVNV?=
 =?utf-8?B?bU9jT1hPTzdNTXE0VGdkemRvb0hDNG04RVNhVHB0N0JLOEpHUDhGWERRUERh?=
 =?utf-8?B?STVXMFF3dkt0bEZXSUx0RjZyYjl4RDZqVjIzOTdlYXlXTGpmNFY3SUJVbWpO?=
 =?utf-8?B?VitvcWZpQjd3eXBxSktjeFpBVTBycThaNzFuUzhJTWs4dmJScmNJNklyajNH?=
 =?utf-8?B?V0dBQlBYZmk5TmxaeWd5MDQwaDlUYnF6aTJlY0dNdjRNb1l4Z3JrQ0t1UzZn?=
 =?utf-8?B?MUtIclVERzQ4RDlYait5c1BqVjJCbUh1WjMzelNkUHlmSHpQbm1IV2dzU1Vi?=
 =?utf-8?B?dWdiNXcyM01YcUt2RitSMDN6bDZ3M2ZBM0wrOXhGQ2htdXQwRWt4NTZUczZn?=
 =?utf-8?B?NElJMm1PL1FxcngwR0tMc1FVWFZzSVFCem9JNWptL3ZiMkpLZ2VSQTJrYW9Q?=
 =?utf-8?B?Ym1KRng3WVJFa2xVeC9JM1dsTlYvUk9PcWxaTUZsWitCaGJxaGp4emkyWEx5?=
 =?utf-8?B?RUI2ZlBNUFE4V3cvaGd2OFh0T3MrVHVUL2FkbkRyMVdLWFJqTGJHZWxKbUxm?=
 =?utf-8?B?bzJIaUJRNkphRm9QM1NCVVc0aDRiY2lBZVhKN3lJdEM1c0IyOXF0OTRYQXV2?=
 =?utf-8?B?SFFhUmZHM3dNMG9xaHlTQVltNERNbGdxSFRkVEFvQzBNdGZIY25TSWNRRDRo?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfcf065-ba5d-48fb-722e-08da9cddf653
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 21:03:56.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9IA0WlR9+G8gzfr8vmX1pGF3GoWOf0N789TFw8OdcLKDf6FdhSt9Y4VEylKTIhDHL6YnLaDmSVgz2zTLSjSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7352
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org




On 9/22/22 4:53 PM, Daniel Walker wrote:
> On Thu, Sep 22, 2022 at 04:45:01PM -0400, Sean Anderson wrote:
>> 
>> 
>> 
>> For an arm64 platform (after rebasing):
>> 
>> Tested-by: Sean Anderson <sean.anderson@seco.com>
> 
> Maybe I'll re-submit it.
> 
> Daniel
> 

There's still no way to extend the command line on ARM64, since the
existing method was removed in anticipation that your series would be
added. 

As recently as last month, someone's patch to add such support was
rejected for this reason [1].

--Sean

[1] https://lore.kernel.org/linux-arm-kernel/20220812084613.GA3107@willie-the-truck/
