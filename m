Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED39728FC5
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFIGSp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFIGSl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 02:18:41 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D92119;
        Thu,  8 Jun 2023 23:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNAzJSrNZnTaGC58kOR8aU2qdnLmlUp6gsPhbrpPxqPNJv9bCFI9gmHAFiQZkzU0wqK/5u60B4+ZIDKUgJrhMtnh0AfvwOnUkYb8Kj7uOVQ9RHNdRjIb/cfq5m0NY5xTWa5yfudUxV/5fIaJkgeKocVLlLvtwIKvAdrc1zzYNWNDGJQEsbb+jTzdJngz+yf3WFYVrPuUwTM+nh9/7jnSk4UKr1gY75DUBbPgNRmc3PNuNOo6o/7u3gV3DdWVbLTQTNLp7zY8cs1ksR3qNYcqz9I5Le5SM5WHsD9eAUpGzhpNDc49ZZ2UEvGNsy5WZkpCY3BODfA3Dw69znN8gjV/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Dxv3MlJC2/xOHTZsehKp4hect5502q/c8yLrUy0ww=;
 b=MNx7qbHgk1prwW/huRQnd4JEh54bd0bRVVTjiVER+P3jxWNrMIqrwcifJVsdpPFRmpq+X89tDZ33tVMmXDUDSLbiN/7Nb95yfruY2aFLeffCi1rZIil6in+zdjrhFXo94dgtGXE0a4ksYLSvFylWQTMI3OjYLpUK/EJIGMxJqLihLAn64VOxBo1WzsIpX4N1sA5vxGyA4B/oaMyuzltxvKoFXna5LCeffCQlaLrU7dQnoWugRUKOQWU73SVoS8pHkXvk0iyTGatMvybEFsRTiKjmoF6uhU8hLkPgR+HXisKk38FWN9TKhuYrCAGz8eGMUcrpwAoeaEj+RJuHdVGbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Dxv3MlJC2/xOHTZsehKp4hect5502q/c8yLrUy0ww=;
 b=ncEzoWPyBLGZR3y3aHImuPnuhhqgYpW5Ohm/h9QsmJ8ujND/vRC105TVo5vT86+efBWxcx/6WSno/qElPhBSRNp5Hopo1ptU+IDraSXofFYOKmkGB0HJr7Vj/yBYcynRkl8t0U4ZyMUSZZAPXIf4Y0BK20PTeOooMGjsm8puujV1lnMY0MvdlVDbz++VkKW7lp2RoZDlypwxRn9w7yc2BkDw+HoHAGnz8YioCaARqjWhwQnYzF76UAf/VaLayMQsgjIWMWvPEF2F+w17Lrz1AUaN7dVXv6wTiLFvUXk1FnRfL+kqF43nJhayVesiA3I+P/jTQgw2iJiQWhymUZZPPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 06:18:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 06:18:36 +0000
Message-ID: <3eb9bf84-4cf0-6cfe-9ad3-f7eef7d775fb@siemens.com>
Date:   Fri, 9 Jun 2023 08:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
 <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com>
 <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com>
 <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com>
 <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com>
 <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
 <CAC_iWjJ0uw_p9=6C+U+q8BNQgnDBgbDpcu8s8c80oB25i9y77w@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjJ0uw_p9=6C+U+q8BNQgnDBgbDpcu8s8c80oB25i9y77w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 110b7d9b-b0b5-4db8-eded-08db68b15ba3
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GEcL2qzXIlfqjd1h5Xpadz2vwk0bOmY15fsvWRAJBRt3qUUqxIhU4twY+4ViEbBVR180gj1DvEaO3kQ8+G4xCxzvtykSQ6J+j9eslD0MTh+Jw/zyNcY9XDVF8PHxfEvaNp3DyJFzkSuaELKOOhZYHilx7H2RlqcBOpwxlrnR60jHQ/rqOrJIygj6n3FNOD9WN6LCqkHhys9BkTvHkzYC6DG5pd6iyiAZnsUs88z1tT+QSTMQfZtM3c1xqhIp/wPA35JY9d1otMN/xOySWAW3e3cv2CNDj0owONeEYlDRWXKEkZGFGk5nJTWjNMuyQFEUal49yjqGcSt4qYrvOzFuFfAU74TKR/NMa7+LKFyfu8JaWMIF8UdXQYOiHxOG23OHF+hhV/sfSdVV5bQnnBb6wU7pqs8gSYPfwroBEUiDc5QU8Ou3HoqhzzZuAxmsjjNy9wzekH4Ac4bX1SBaNOv8GPs340iAu+lT7rFgzhbPc5ka8JL4OkJ04jLp8kHj8sPEJWMytKT29zmJY2kxRs50dmt6AvUtC3SGhjQxxYW94LVX+MwiUu5fiXLDzG78WK2CulpLP3IdI3MZFLkixS1y8gtu5kT8asP1xmgTcvPiCyGY+aHWzHGC1N6ZdU/WCnERggfYaJzts5g0ZskuS2PSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(6512007)(107886003)(26005)(6506007)(966005)(53546011)(36756003)(83380400001)(31696002)(86362001)(186003)(82960400001)(38100700002)(2616005)(44832011)(41300700001)(110136005)(316002)(2906002)(30864003)(54906003)(4326008)(478600001)(66476007)(66946007)(8936002)(8676002)(31686004)(7416002)(66899021)(6486002)(5660300002)(66556008)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFsWUNCY0xYK2FmNi95emZXMHo4NFJONFJscTJXaC9EeGdkRXVEc2Y1MHN6?=
 =?utf-8?B?RXJXQW5HTSs3NG1pOTg2ZTNJek5mZ0V3N1lrQnFlNnl4dnhGOUZ5ZVhGS2dp?=
 =?utf-8?B?QldIM1VwUllRTmZON3pOOG9uV0JwZ0pwWnIxVDhOL1VNb2ZSU2dxR2gxU0sr?=
 =?utf-8?B?Q0RjU2tyWUx0UHQvWGFrUTROQUU2dmRUUE5ZbnBJL2tCOEdqUklwdlE2aFBL?=
 =?utf-8?B?cFd1QjhKSHZrVXN0ZXdmU2wrRFpOckVIRXNhQXVITDlRRytQSUFranFJSDZX?=
 =?utf-8?B?VkNnckpkaGtseU56blVCa04vdVZGb0J6emliTzJEczhvVFhSVUsvVzBxN01C?=
 =?utf-8?B?SEd0eTJkdTZKZXhiQ1c0R0w1eEE3MEllWHhndEx6MkYyTlkvVWxwY1g1ci9X?=
 =?utf-8?B?YzBQaHRybEZVZlVQMkpEcnVtTDlGZCsrTFI2UElJdERZOVNaSWlxcENyL3FP?=
 =?utf-8?B?cmFpUTJON1JRNzYvMEh0VnpHVjV3YkYwZ2I4UDkrWU93MmloNkJWTEUzaEor?=
 =?utf-8?B?SkRRQkNxWExSUnkyWWRhaS9Za0tVbkF1Y1JkWVZpMDJlektpSEI3WDMrSWsr?=
 =?utf-8?B?WSs2ZDByYlY4WWh2SENtSFhBdFVSaklJSzFZVFlOWGpwak9ONWE3eHJIQnBj?=
 =?utf-8?B?RldmZU5vV3JvYkFBeklJQ21vaFg3NktPd0tqbWgvNmgzZ2FHazhFOHREc3dI?=
 =?utf-8?B?TWQ3U01xbU1taEJoNTU2VDh4WW5NMUIyMS9DejJkcWlNVmxTcXlCQ2psek5k?=
 =?utf-8?B?UStMblFVbXdqSnFoZUpuR0pQand2UnhFbGxhVTJ3cFlLUXQ4ZFA5V21CaEhE?=
 =?utf-8?B?UEo4L3VsRXdxdnhveWd0WEhiQ2FzeVVyZWtLSTU2eWZCUVNEK0FDdC9zT003?=
 =?utf-8?B?T29ndFZpQ3VHVTVNNTRVZzZoTGJidnlmVnYwMS9WelpGeFBYbEpjc3Q1OGZn?=
 =?utf-8?B?T2xkcTFEeEkvT1lYbWRBc3E3cGtpQjlqWmdRaHU1T2dDaXRXZHJFWlJ1bVdn?=
 =?utf-8?B?ZHpDU0hkeStqTG9TYUU2ZGwwZWs1WDYreEtxWjNVQlRqRjJJYTFkdWJFSVR1?=
 =?utf-8?B?RTIrQnlWbW5RRXREbGFQamVUNlhzdTloRTA1NWdhK20yTy9GQzZpZ291UWdH?=
 =?utf-8?B?cWlqSWhkUFYzR2pibXhkS1NBOUk1ME9kOUJnTUdhZEJ0VDdKQkpWMTN4N2Vv?=
 =?utf-8?B?dVdSM1FxY0pLR0d5L0VpNkJNSXVvMkl2V3lzN0xTTVpHZHRJR2RGdUxCdzBv?=
 =?utf-8?B?OU5yaUpWY3paaVNaVHNZazVkdE5weTJxdmNoM2dOSENNeThpbC95SEdodjdV?=
 =?utf-8?B?bEhjbFdwZ2lpcUs2aURPNm5tWkJhM2tKOWNuaTR2UmVBZFhTdXFkNUprajVq?=
 =?utf-8?B?S1Badk9hMkV1a0F1N2VrdU9RTG1YMUx3T3VIb0pyVWl3NXc5TnhtcjdJL1BZ?=
 =?utf-8?B?ZGFUandWYk9HYzVyVUlsbTBFZ2pZNXZaeEZnMlI0MkZvUWg4NmlnY0k3VTd4?=
 =?utf-8?B?YmdTRjdER0l3S0gzclNEQVIvbzlvREp6aDRnNmlFbGRzT3hnTGFxM2tFUWdw?=
 =?utf-8?B?dTVpQU1NSzJVY2hsNHdqSXpJbTQxaDYyN3h5dzZBNUdUd1Zibk1vTVQzMFFm?=
 =?utf-8?B?aFJ6SE9zVSs3T2xTNjZRMnBwN2RGWFVGVHh0eXhhemFURnd4Wi9FY3A4ODI3?=
 =?utf-8?B?VkZaSktKSFlJQ2tpRzRjcVVpQ3FqSkZ2RC9iZUpWMnNUQTM4YkdUM1FRajZz?=
 =?utf-8?B?bFk0Qys5TkJFeUVuNHdkdEFNOHdaeFFTR0owUktXcFlDL2FBb0hCOUtORkRw?=
 =?utf-8?B?T0hiQW1NOVBsbUVWa3NPcStYQ0NBcDE0OExKeHNXWkQ2OGlHTzRMbTkzelky?=
 =?utf-8?B?L1k3L25FbHNNd25yRHU2L010c0Y2MjM4dWZWZk9meDRoMWhxSVJLaUVPemRC?=
 =?utf-8?B?NzNjT0ptU0k0OE9Jb3pYTXA1aVV0Y2MvWldhTGUvMGU0RHVkVnN2NFgzVGg1?=
 =?utf-8?B?RC9JMnlyTVRlOFp4bjFEQ2dZOTRKYXV0MytUclF5THlsWjlpcUxBZENrMjRo?=
 =?utf-8?B?bjJHRm9JQzgzRktISWZDQzFMSVpBMkw4ZGRhSnlwVzJtcHN3Um5FQ1FDMVhU?=
 =?utf-8?B?RFZjaEg2V1MwYWJRWnhWRklxa2Exak1kT0JkVUc3Nm5YUXJwbTNCQlVrY0ow?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110b7d9b-b0b5-4db8-eded-08db68b15ba3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:18:36.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttfAUhEqTWDzFfigCkZc5pb9zaEnQkHeBoTROfXZr97ocu3GO4xOxE7cI7EFh0iimAxbSAV54m7XsvDJ8tuuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6236
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

On 08.06.23 21:38, Ilias Apalodimas wrote:
> On Thu, 8 Jun 2023 at 16:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi Jan
>>>
>>>
>>> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 07.06.23 20:17, Ilias Apalodimas wrote:
>>>>> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>>>>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>>
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
>>>>>>>>>>>> As you point out you will still have this dependency if you end up
>>>>>>>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
>>>>>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>>>>>>>>>>> this either, but it's not unreasonable.
>>>>>>>>>>>
>>>>>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>>>>>
>>>>>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>>>>>>>> you see any further issues.
>>>>>>>>>>
>>>>>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ah, nice, will test ASAP!
>>>>>>>>>
>>>>>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>>>>>> STMM. But the driver loaded, and I got this:
>>>>>>>>
>>>>>>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
>>>>>>>
>>>>>>> Can you provide a bit more info on how that was triggered btw? I would
>>>>>>> be helpful to know
>>>>>>>
>>>>>>> - OP-TEE version
>>>>>>
>>>>>> Today's master, 145953d55.
>>>>>>
>>>>>>> - was it compiled as a module or built-in?
>>>>>>
>>>>>> Sorry, not sure anymore, switching back and forth right now. I think it
>>>>>> was built-in.
>>>>>>
>>>>>>> - was the supplicant running?
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>
>>>>> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
>>>>> store the variables in a file in the ESP instead of the RPMB right?
>>>>> Otherwise, I can't see how the device booted in the first place.
>>>>
>>>> U-Boot was not configured to perform secure booting in this case. It had
>>>> RPMB support enabled, just didn't have to use it.
>>>
>>> In your initial mail you said you managed to build a firmware without
>>> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
>>> variable storage in an RPMB, the EFI subsystem will fail to start.
>>>
>>> In any case, I don't think the ooops you are seeing is not connected
>>> to this patchset.  Looking at the kernel EFI stub we only set the
>>> SetVariableRT if the RTPROP table is set accordingly by the firmware.
>>> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
>>> can't support it.  What you are doing is remount the efivarfs as rw
>>> and then trying to set a variable, but the callback for it is  NULL.
>>> I think you'll be able to replicate the same behavior on the kernel
>>> without even inserting the new module.
>>>
>>
>> I have dropped this series from efi/next for now, given that it
>> obviously has problems in its current state.
>>
>> The risk of merging this now and fixing it later is that it may cause
>> regressions for early adopters that rely on the behavior we are
>> introducing here. Better to get this in shape first.
> 
> The ooops Jan was seeing is reproducible in the current code with
> $ sudo mount -o remount,rw /sys/firmware/efi/efivars
> $ sudo efi-updatevar -f PK.auth PK
> 
> So the only real problem we are discussing here is users having to
> remount the efivarfs once the module is inserted and the supplicant is
> running right?  We could do something along the lines of the patch
> below. That would solve both of the problems.
> 
> However, the patch changes the way efivarfs is mounted -- it's now
> always mounted as RW.  What I am worried about is userspace tools that
> rely on this.  I know fwupd uses it and looks for a RO mounted
> efivarfs on it's initial checking, but since userspace apps are
> already dealing with firmware that exposes SetVariableRT but always
> returns EFI_UNSUPPORTED this should be safe ?(famous last words)
> 
> Jan can you please apply this and see if it solves your problem?
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4cc8d0e7d0fd..37accd9e885c 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -206,6 +206,13 @@ static bool generic_ops_supported(void)
>         return true;
>  }
> 
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data)
> +{
> +       return EFI_UNSUPPORTED;
> +}
> +
>  static int generic_ops_register(void)
>  {
>         if (!generic_ops_supported())
> @@ -219,6 +226,9 @@ static int generic_ops_register(void)
>         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
>                 generic_ops.set_variable = efi.set_variable;
>                 generic_ops.set_variable_nonblocking =
> efi.set_variable_nonblocking;
> +       } else {
> +               generic_ops.set_variable = set_variable_int;
> +               generic_ops.set_variable_nonblocking = set_variable_int;
>         }
>         return efivars_register(&generic_efivars, &generic_ops);
>  }
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index e9dc7116daf1..c75eff3f409d 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
> 
>  bool efivar_supports_writes(void)
>  {
> -       return __efivars && __efivars->ops->set_variable;
> +       return __efivars && __efivars->ops->set_variable != set_variable_int;
>  }
>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..e40b5c4c5106 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
>         sb->s_d_op              = &efivarfs_d_ops;
>         sb->s_time_gran         = 1;
> 
> -       if (!efivar_supports_writes())
> -               sb->s_flags |= SB_RDONLY;
> -
>         inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>         if (!inode)
>                 return -ENOMEM;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 58d1c271d3b0..ec0ac6ef50a3 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops);
>  int efivars_unregister(struct efivars *efivars);
> 
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data);
> +
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
> 
> apalos@hades:~/work/linux-next>;
> apalos@hades:~/work/linux-next>git diff
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4cc8d0e7d0fd..37accd9e885c 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -206,6 +206,13 @@ static bool generic_ops_supported(void)
>         return true;
>  }
> 
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data)
> +{
> +       return EFI_UNSUPPORTED;
> +}
> +
>  static int generic_ops_register(void)
>  {
>         if (!generic_ops_supported())
> @@ -219,6 +226,9 @@ static int generic_ops_register(void)
>         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
>                 generic_ops.set_variable = efi.set_variable;
>                 generic_ops.set_variable_nonblocking =
> efi.set_variable_nonblocking;
> +       } else {
> +               generic_ops.set_variable = set_variable_int;
> +               generic_ops.set_variable_nonblocking = set_variable_int;
>         }
>         return efivars_register(&generic_efivars, &generic_ops);
>  }
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index e9dc7116daf1..c75eff3f409d 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
> 
>  bool efivar_supports_writes(void)
>  {
> -       return __efivars && __efivars->ops->set_variable;
> +       return __efivars && __efivars->ops->set_variable != set_variable_int;
>  }
>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..e40b5c4c5106 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
>         sb->s_d_op              = &efivarfs_d_ops;
>         sb->s_time_gran         = 1;
> 
> -       if (!efivar_supports_writes())
> -               sb->s_flags |= SB_RDONLY;
> -
>         inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>         if (!inode)
>                 return -ENOMEM;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 58d1c271d3b0..ec0ac6ef50a3 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops);
>  int efivars_unregister(struct efivars *efivars);
> 
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data);
> +
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
> 
> Thanks
> /Ilias

As just written in my other reply: The root cause is the dependency on
tee-supplicant daemon. That needs to be resolved, and then also r/w
mounting will just work.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

