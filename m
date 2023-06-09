Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC13728FB8
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbjFIGQx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 02:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbjFIGQv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 02:16:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0951271D;
        Thu,  8 Jun 2023 23:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXrnCPyxhjsg6QCHw4CxodfR9xuO2XxYOxCnO3MD5uNmVVWkMlgMKeXtR7wX3DmJBY8AMeY/1a1h8/4tC4Sg+zvu6MRvZmgO8/fmMrRkl6+qsWhXmONqfHTD8dsOz1dpZIXzEsUoiUv9kC2iHZUHM9qPW1ZRCyr5dRboOD7uWHviZSZWyzjtSSj6jLrrM8nqZjZygwVLAXui5VL+AYCSjbTlOuZWDwgBHpHTMU3o3er68w9PduEGAaWTFyhETYwz2jXLRJ/EW81sMrdqwGa5uGM4g7uyYq9t5AXN2TK984I5pPsVvoEPYIq8JSh8+goyEVu81iW1KFTaklaNIXB3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu5kWVu0m71eAaMKCew9N9NIcU5qnLXhkupy375q7W0=;
 b=NFoUpTlmO5ZWvMPbrn7GQr+tNGObWXFjMh//WEq7amiGIMYCOg4pVYdKB3ZcNy5YzqRb6ATZjesMQ5qR82RJt5LEPmCKdLgZFnfQAPM8j0AImXv/AGartynQ+oJRUrOsvweGBluvtBXlI/8u/Y8u/sDLQCgxXdCvkphxX/44U8AX1Q6fqBgpHMV1k0IukKLl8C5VPs1m2lIl9z5DD5cJC0QpwVOgmpOzfvBNtD0bFwrvRwxFiu5Wc/tKCOo0eCcEaPJUUQTF5N4m4dMhkWPKfA/PIJJ/28gHzFDH6rrzGJAS3+1yt0P0+xThrUefyljXCnAlp2HFHPM5eWVEhQDM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu5kWVu0m71eAaMKCew9N9NIcU5qnLXhkupy375q7W0=;
 b=ciSjqnXHlkaeWyUXfAwNq39jBPZyJ7gXaA+1VX3s1/aV5jt7jMhMWWp46JZ/pzHb3Mu0GfwNcmo07R8Pzv/SJgqGPNeU64WaLwJxyzKehkChFakQD5vSr4HzzaOsqCtXejo/ksjni43TMZOX30ZZ/TbB5XkBiichjb8P4XEusR4EGaVateXiPiPfNURpt12L8NzRs3N2LrUxjQkK+BXAEKlm13K8vyuCK3a9tq2izkPBFKr+gA0fBQYXQ9zQka98kzpI4dhyfvlMc12aMSb44MhT0zvIKtjdtvbvodPvRuMgQqDznTmkZvR8D9gDbPXeazpKzt4skPVM5bbyLcCIMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7456.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 06:16:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 06:16:46 +0000
Message-ID: <e0c71d88-ec5d-a348-0a53-ec6cea298b60@siemens.com>
Date:   Fri, 9 Jun 2023 08:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
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
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com>
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
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 077a2c87-b50a-4b26-df80-08db68b11a58
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCzX8Dp+bO3hncRIreMY0lupMSFeKQufwgjzpvo5V63ISSoEpr1D2YgmAr5SYPuzzC2+EDakvN9BR2pHp6fkyipoOdemvyP01OG5eGw23/exAP4JNguh34J05U+lbSBrQXWvTocdXtZ2RkuR7IpQffqzDdfwUDkfRY1qDrG/sP8Yvf2wmTsdAeZvWx3loXFWryUXbxKWdKQfPeg4TdJV6jkWPjIzFY51OrPc53rqDInqIW/9LswUH7XE3UgCg7dfXUzJgU4bITMv93cWjhYkU++B+rzHhtt4UKtV6/eksiNKwqhuLVbAaKn2aCLMMz7N3I7kQCqu/rafF5wpqvb+8Dnm7TRJs1vtCSV4OrIQDgc/IUVg2sibz0TqyLVYKXxxlDYqNiGc70SlUmzhj+PFTtjo9l6zDJxFVvfTxFFUbrTFWai4a+OGsl6GRIX1afh4wDXgWPGv/fSpSwvVLS8Vm7kSVukUijw9M2gzef6qMDxuZAddKdzp1b47npbeeQLukHD7Mi+yjrYaHvUIn92o4UcSSuF6tsxlHSw0AOg9AWb/vbdJAqlRdiVEuvM8fXRH/zTMUADhnZV+Bcapz0Ovw9ZF24oLWa+lVXkfkyD37NmgSMRlB4WUVNCLKBNNc7LldySoBCMvZj1lfieYxveYug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(66556008)(8936002)(8676002)(7416002)(44832011)(5660300002)(83380400001)(6512007)(6506007)(26005)(53546011)(107886003)(86362001)(2616005)(31696002)(186003)(82960400001)(38100700002)(478600001)(110136005)(966005)(6486002)(6666004)(54906003)(316002)(36756003)(4326008)(41300700001)(66946007)(66476007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dit1aUVaUE52aVEzbEc1cFhMMTBVVTJWeFF4Zm1NUG00VUFUQmdMcFR5ZHI1?=
 =?utf-8?B?VU1FMDVjbVVJWjR5em1oVHUveWZsS0R5MVhMOWtUTE92eGhnUmp1eU1HWVhN?=
 =?utf-8?B?R1hkTVVUOFdGS1FsSHdRWlo2SnYyc2FicGtPTG1JVGR1VFptQStNclgzSi9B?=
 =?utf-8?B?T0hqZHc4N09KVm5nQjkvN2dZcG1MOUlPQndEVTdhdjBkRG52WXY1SWM0Wjhn?=
 =?utf-8?B?MzMxUllTaCtWWC9xc1h2S1FlQWRYditJUmd2Q3h1NGhUWEdPTjVVa0N1Q0JR?=
 =?utf-8?B?UERvcGZxVHpNbTVXMnZ2c1dFMVphSTR2bkowU2tsdWhZczZxTThwTVdjUEth?=
 =?utf-8?B?RFg2UTFTZURZcmt3Ny9keVpoUnJoKytzdG1LMGdsOFg3dzhaVGdRbkhOcXhF?=
 =?utf-8?B?ZHpqdUZJQlRGamlMaFdIcUFWa21QWEtDR3hZbWxwaEQvanQ1SjVySXRrQTcy?=
 =?utf-8?B?cUZWTFRkQUQ3bUUzZE5mOUNINGRUd3d0Q3pZRWJ5dXZUb3lrYVlFbHhqakZJ?=
 =?utf-8?B?d0EyRGFISVEwUEhaeFkrcnJBNmszZldjQ2RuSGxVazZaZTFmaEN4QXVKaXdp?=
 =?utf-8?B?TUwwMW1ZUTEvRUplcnpPYk42ZDhPYzZLM1dRazl2TWRhY0c2aWo1Y2dtY1Q5?=
 =?utf-8?B?SVFLbndPaFY4QXg2cWpwSU0vc0FPRFJmTC9RQ1hxWlF5SnQzM1RXcm9TbGRS?=
 =?utf-8?B?QjVBeGlUTmJVaTNGRnlZUytoeE9oajZObWM3MlhCb1FOZXgrbW9XSVZ0ZkRT?=
 =?utf-8?B?YVVuaTYxZkRtUlRJd1lhT2piL1J1MktLWU5NU2ZrTkJYdFN6UUJVcFkxKzRU?=
 =?utf-8?B?Y0tWTllKZDNaSm5KT1U3SUpScCtBQVJ6b29ETVFqK3kvNUFLTWRGZm02QW5O?=
 =?utf-8?B?NHBpWGs2Sk1sZ09hbnZDUEdOMnFDQU12dE1CVlBJbHpaM3ZNVzNvTHZ1U09M?=
 =?utf-8?B?WGhvcEtHbXFtckNxeExOUzlwMGVlWGNFanFKWVNqU2E0YmdDZmYyT1U1M2lv?=
 =?utf-8?B?MHJhcmlOdDB1RmxzdFVZeExjSUNYdzRTWVcyVDRZWENyQTVJSnczcDl0TmNG?=
 =?utf-8?B?QmN4UEh0T282djZBRGVueW1MQ3lpVm9VN3RnSU9uM2JWaDh3MTRCaDd1blZV?=
 =?utf-8?B?Q2xGSGx4VUlFbHNXSlRPYlZOOUNXSGFMaXlTeDlyaXBEVXZFR21UajN3Z0Ew?=
 =?utf-8?B?WFVnOUtsSFJXbXVtVDQ0OEZLSHVZc2ZweGJDaU90V0U1Ry9HaDdUM2FyRTBY?=
 =?utf-8?B?SjhKTTJNZ3hJMXNHZkxlT1JacHJ2NElTWEFsYVBmbzVhVzFZamQwdXBxTXpR?=
 =?utf-8?B?LzlheDBXV2pnMlpJZ3ZPTSt6SXdZY256WElaQVlZQ2pWOXZpVnlDbC9PclJu?=
 =?utf-8?B?aUJnRU04OFlQVG5XMGxFcFpxSFRTSEtrUHlJSklSNVB3dXZLMk9NUGw5Qmw1?=
 =?utf-8?B?SGtjVVdyVDY4Y3BML1d3U2xsNVQ5SE9seFEyUHB1eGptZThWM1lRZko0TUFq?=
 =?utf-8?B?ZjhoTlNLdm9HTGU0aytOdzlmUVJPWTZiZWtlUGRlL2crYVlhdVJkYjJnWVBB?=
 =?utf-8?B?c0h5SldyNm9DMndDQVBvYStsOXNMeXZsT0MvVk1iYUVuSjNrUzRsSnQrakZQ?=
 =?utf-8?B?ZGZ6UUd2N1pxeFlEWENVMDZsdWMwZXNsaWV3UDJzakJmTFpZYVBXYkplUjdx?=
 =?utf-8?B?VTFGTWQrdW5Zd2FsWUN6N0Jabm1SWldkU002V3dEd3FSMEV4UEs4MDlTU2Rz?=
 =?utf-8?B?SWI2ODZYUDlBYlBPckpwZ1ltSGlTZDJsYzRqbFA1THRtMVpKQzhTQXVzc2J4?=
 =?utf-8?B?SnEyVktzUVZiVlVEUWJKbFA5ak9UdzNPRGc2UHhiQTRJcTlTQlkveVpUeHQx?=
 =?utf-8?B?amN4Tk1OWjgyWWRpcWJ1U3Bzcms4YTFNQncyZVMweFpIWGsxSjV1Zi9EUVpn?=
 =?utf-8?B?K3hkSElndnlNU0xFTVJ5Yyt3TkkvWjNGNjMvbEY4RTduRzNQRElVV3VvcTIw?=
 =?utf-8?B?aHpHUWNPWG5kYnc4WnpFaDEvRWtjNEhFY2IzRFY1cG5vZ01WeTVNQzlPSHNV?=
 =?utf-8?B?bzNQZFhmQnhOTXdVSzBPMzFlYkQ3OEt4SHYzMC8yRHZLWWZta0V1VGUxK2R1?=
 =?utf-8?Q?8Z6jEAEA1WiHG794KVXPtCi0n?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077a2c87-b50a-4b26-df80-08db68b11a58
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:16:46.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMLETqft0XpVGfPs2XQyW5SzXR3058jvkfJOl3YWF4s3scHrDeSY25Hue89TOP/RO72fqXN1TA8D4n27g9x0kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7456
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

On 08.06.23 15:52, Ard Biesheuvel wrote:
> On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jan
>>
>>
>> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 07.06.23 20:17, Ilias Apalodimas wrote:
>>>> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>>>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> [...]
>>>>>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
>>>>>>>>>>> As you point out you will still have this dependency if you end up
>>>>>>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
>>>>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>>>>>>>>>> this either, but it's not unreasonable.
>>>>>>>>>>
>>>>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>>>>
>>>>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>>>>>>> you see any further issues.
>>>>>>>>>
>>>>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ah, nice, will test ASAP!
>>>>>>>>
>>>>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>>>>> STMM. But the driver loaded, and I got this:
>>>>>>>
>>>>>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
>>>>>>
>>>>>> Can you provide a bit more info on how that was triggered btw? I would
>>>>>> be helpful to know
>>>>>>
>>>>>> - OP-TEE version
>>>>>
>>>>> Today's master, 145953d55.
>>>>>
>>>>>> - was it compiled as a module or built-in?
>>>>>
>>>>> Sorry, not sure anymore, switching back and forth right now. I think it
>>>>> was built-in.
>>>>>
>>>>>> - was the supplicant running?
>>>>>
>>>>> Yes.
>>>>>
>>>>
>>>> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
>>>> store the variables in a file in the ESP instead of the RPMB right?
>>>> Otherwise, I can't see how the device booted in the first place.
>>>
>>> U-Boot was not configured to perform secure booting in this case. It had
>>> RPMB support enabled, just didn't have to use it.
>>
>> In your initial mail you said you managed to build a firmware without
>> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
>> variable storage in an RPMB, the EFI subsystem will fail to start.
>>
>> In any case, I don't think the ooops you are seeing is not connected
>> to this patchset.  Looking at the kernel EFI stub we only set the
>> SetVariableRT if the RTPROP table is set accordingly by the firmware.
>> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
>> can't support it.  What you are doing is remount the efivarfs as rw
>> and then trying to set a variable, but the callback for it is  NULL.
>> I think you'll be able to replicate the same behavior on the kernel
>> without even inserting the new module.

Might be true. I'll try to look into that again when the other dust settled.

> 
> I have dropped this series from efi/next for now, given that it
> obviously has problems in its current state.
> 
> The risk of merging this now and fixing it later is that it may cause
> regressions for early adopters that rely on the behavior we are
> introducing here. Better to get this in shape first.

On the one side, I'm sorry having ruined the merge, but my gut feeling
is as well that this really needs to be reworked to get rid of the
unfortunate tee-supplicant daemon. So far, we have to start the daemon
from initrd, write a systemd service to adopt that instance, and make
ftpm modular to remove it before terminating tee-supplicant (e.g. on
system shutdown) - Sumit's patch didn't help there.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

