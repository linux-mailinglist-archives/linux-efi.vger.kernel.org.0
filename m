Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D927266E8
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjFGROg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFGROf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 13:14:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E8192;
        Wed,  7 Jun 2023 10:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG1TYsNyYJKFDm+FKP41Ig1GIh18TCFDYcIqzwxzFpRTNpVzdeQsw5/RR9h/fw5GZCyLbozoV5CWsmcAGZpMEmLUN/j+yvw1ruj5LtJnXyF7BwdoOoGTaOCx03xZpEytSavGj4DfbHamhG3wTLqloG5D4y0tGNm+xInX9CcymILlz0Nrxjl9wwzPJjSn4mUwRSGFqIImAtMC2l9bk7aPdGZw3Wn7Bw9wgr9kyoBmP5+MObxtJhFZhnBmEoi42997I71BbAQZgnVK7K0+y3LpjZSSM0psMDJiO1MUW4itXKc+2LT0UMIRg+kjIg6JfpZiUFE3GtaA3TdzVFu+2gJ8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwizh+0ZHSZc1pqwnxtdUtOpHtwHULwh5M2qCmXOQFk=;
 b=RGcaE26ZZRsJK97VtTqe4Jx6xUS1edHvpEoWi7tnrwHBZQunwp9rvCY8+dhLcNVBn9kfWDnPXeL5uQdNx0kmXYEpQjDwQapH2K63hQFBeICuQeaiaaLrwOFy46EfewxiYBLpSh9ZhP72doLNvfB/+nol5s0UNAXA+TCy391FgMLU7EDiRqAI1EzKtXmg/Vnjw8Rg4lVjXtZr1vjFqC0mzrRsW/ss4T20j+bjo07elph7WIHD7TTuXsWR0uhlKlAc6tOjqoyAO42DRRLG1b8Qu1aIxs8V1FT1mJ42f34cUBtjX4Of68FSLyS5N+127MkqKdhRFwa/MtZXa5vFDdV4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwizh+0ZHSZc1pqwnxtdUtOpHtwHULwh5M2qCmXOQFk=;
 b=csGg/IPB5TGThuAqLVltlBDTq9OfDO3HGFQIyURyjzqHAemA+lQBq53m2uWO5QT3qaziRCBZGTLTZD05Ve85RO/8/vM45GllMh8ovkyp3vLSRpbSTt7tLHIlCFdMmAdd9dQfzrUGBmWuFGg1qI6K3kpSEKkBeieM9V5c+XQTf8BJ+l1hr37IZpOcmddLrxZoFK9yTdRUwwe2wonrCT4Ip9GgyVXaNp4x3vdrwt8+pIQMJAFBkOr7rr0Dx5xxH3kH0E/3PWrQm0gb04X/pvP4BsmqOx/BfEZ21tibclpDwGEqaAx8nb0AZzNNv2U3+bgjhkurkZiFN7NJm2QRZMlEZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB3485.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:14:31 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d4a:d8d:d625:952c]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d4a:d8d:d625:952c%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:14:31 +0000
Message-ID: <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com>
Date:   Wed, 7 Jun 2023 19:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com>
 <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB3485:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d58ab4-a036-4f14-6243-08db677aa86c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQetXZ/XKeVgWZc0QhJY38XRvLNL7yDh1EyM+xCuDveAPhPbcX9ZAGtEwDqQcNfcx5/Mjrf2oBXdSIf39lNqvXrynfvwEEqEakmhyTGcyzuWsECFlgyPcYKn0fXi3i8/17p4c6nNdr7HbmbnIGJfQyCY3u/hJEt6STVpR9E2qPy+qHIRoOU8TNYl7UX5Rz5z0HJc2SfN/rdzMajpdKKvHRvThmxj2Y5+0lvfdnyCsLq4RJoqa9Jc590YSFn1oF/fFLTKnJHXAGSEJbZ2VJvvrI+qxHyKPaUt+IUOefSd0Io/eV8bm5wFk68hvJLF9OEUv5a6a/BmByDapvwdmGi2sL5osTLNxkU449Kqq5qBFs7rh/GcRV7j7h3gqPNdY8scYciu/diLdnN7rL9UIBELyvXeqVh0+BKvQsC+9SbBu+uUQDB7Qi4DNJpXXGmX962O6dV1f3jOMFKSHfsYP1RUwkOIfR/x0wPZIpVvGAA3pBFgTI8/P9Vj4G52N7z7TPRhFPXLg5MGmuEXyEjsf80nCFzlJyEKkeW6FxKf1rPILyMczesSkEHi559sT9Lq0IhEkOfIOieFP7eXelun6C600K2REumZn5lHpkLdpLWDckAoPe6Q23b8jKnVRMt331/Cwb1R/0NZ/x4QSCboB88HbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(107886003)(53546011)(6512007)(6506007)(38100700002)(41300700001)(2616005)(31686004)(186003)(6486002)(6666004)(26005)(966005)(478600001)(82960400001)(66556008)(66476007)(6916009)(66946007)(4326008)(316002)(7416002)(5660300002)(54906003)(8676002)(8936002)(44832011)(31696002)(2906002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS92akc3a0RobS95ejJlRlhwdGl1VDRsK21ONlFrMStkQTN0VmpGak9nNVZw?=
 =?utf-8?B?MS9EZkxYeTc4YWtNY1BzR1NDekpmSFpEV3UxVDh3dTJRRlFPUFFqV1lBNVlY?=
 =?utf-8?B?Tnl3R2phSlBINjhsZDZSN0pCZzdIL3Z1ZTgwNDBhdFJtamZpOEhsTU94Lzdz?=
 =?utf-8?B?T240Vm43NEtXV0Vwc2xSZVQxelB2Q3lJWm5tQmVXM00yRm9RNEx3YTNETjlz?=
 =?utf-8?B?enJyMjVKbjJFMHNjZ1pOQVFCVU9uSWNlWC9kZWpFNGorVEViakVKNEJuZlpT?=
 =?utf-8?B?YWNwSFBLMVg2NUNqZHpDZmpyNnp5L29Bc1lMdWZrMmVLL2VJenhseWtISFE5?=
 =?utf-8?B?M0NFK3l2U2JvaWVFdytaNlRoSzFJQ01rNzFQZysrLzR3elhZRXJrVnhRNndz?=
 =?utf-8?B?SS9rRHpkUEpleTVrVjdmYTFFRG8zb3ExR28xVTBsMEl4YlZ1NnBxQjF2aVlW?=
 =?utf-8?B?eFRhZ25ROEZRODk1dk1Ra0FQeis4cEJnN3NnUDl4N0RhdzlTck9ySmoxZVpw?=
 =?utf-8?B?Zk1aOFVteEhvTlZnUzJCOXZhUDFrQW9iUDF2UnF6aTRnTnJSRnVEMG1SaWNF?=
 =?utf-8?B?WEVwMXZ6SXFPdlVLc1Zsa0liZlpCay9zbFFocUZNRE1sVFNFejhObU5PMTNC?=
 =?utf-8?B?STFSR0I4b2NCZ2xGYk9qVmlnRmE3VXVLb0hXSFlRUlNna3QyTFo1bFBzM0pW?=
 =?utf-8?B?RkMwK1ZEczRSdHRTUTFFeGFDM1JWOWoxaGVoenRxTzdwSWpTYjFSa3hIUDkx?=
 =?utf-8?B?VFc0STBTbWFKN3Z4MDMrN2x4M1E4WjJlMmhXakQyTUd0UDE2enBhWVplQjdF?=
 =?utf-8?B?akVoV3Z6SlUxT0s2bE92bWt6Unc2OUlsWVlVcUUwN1c5N3R6ODNWZFJWeFUy?=
 =?utf-8?B?aEVoL0Z1RHhOY2Q0WjM1Uy9yOURLUjhZdm05TEEvcmVLYllMTUJ0L0doK3JQ?=
 =?utf-8?B?cXVkV1B4SmZYRS85c0FtQk9BWlZ5UzNJQkpReXJpUkdtWHB6QldvQTFlRTAw?=
 =?utf-8?B?S2JQQ3krRjVUdmtXL3NUbVZidExhaHN2S2tlUytXVUZKZElUL1d6aGtkS0Zw?=
 =?utf-8?B?ekdGbXUzcEJIQ0dTZGxCV1ZGcUo3bHlOR3BjKzJpdUhPRTNndHM2N2wzZ2hp?=
 =?utf-8?B?djBsMTQ5WG9CY2tVSjZVbU5QQkJIOGNlSnQ4NXZlOWdDZ1VkbGZjRnlESWJw?=
 =?utf-8?B?enIzSGw0SHozUUh6MFZOLzlaSVR2NHpiNFdYT3hjSXFFRGIzbE8veGV2MFJJ?=
 =?utf-8?B?Z0FmeHFCQ1Zma1hLUVJVbW5qNXdtajMyQ1U5aTVLcWdleHh3WDhsS3E5cHZK?=
 =?utf-8?B?NDlnODRQVEJYaXJpa2tlVkxZaDFHTEVzQ1NMbVo5aFIxQWYrVEFNa3FVYTdB?=
 =?utf-8?B?c2l2UkNHZ1ZkKzJTWXR4OUxEUm9XOXFGMWFMRkoxY3JUSWZ0TDFqQmptWFk1?=
 =?utf-8?B?cFB4djVka2Zmc1RRT3NBbEQybzdyeDIrYXZZeExRQ0wvQWc1R1QwblM2eWdV?=
 =?utf-8?B?QUpPTDVyeDhaajlCc0hQWlU3YVdtU0VHTGFOaWI5cUlVMTV0MHQrNUlxcDA5?=
 =?utf-8?B?YU9ic3MrRWhjR041Z2o0YlpzWFhOYkZrMXdKYVZmaFBRd1MzbmlFMkltWm9j?=
 =?utf-8?B?WHMxVU9xZElMdXVhRFFPSDNyVnltSkVObFM5OWo3VUNqU1Z3SHAyUWw2bUpW?=
 =?utf-8?B?ZkZaYllUN0I4TGU5QktJMDd0T2MwMzFFVzJhRHd0YU0yUFUzcS8wdEJnck9F?=
 =?utf-8?B?MGZRU2ZRcnR4VVkyeWMwWGxnOTJNUFQvRldUbzg2MGIrUUVTUE83Qk1yeVY1?=
 =?utf-8?B?aDNGbEdVMVdEUlFKNnBOdWpzdmo5a3pTZmtOZ2M5VEI2VTkxQjVua3ZZejRk?=
 =?utf-8?B?SERoVm9zZ0lmV0NBZWlhbk9HVzlzbEkwUFdhZ0pqU2J6N3RpdTlkZHpYaWo0?=
 =?utf-8?B?T0NzVEVmNDJRSEJSYzVSN3JvVC81SUdYdmo2ZzRCcHRsRXRBS28xQVR3b1o2?=
 =?utf-8?B?S1NHZWhzLzV3R2kvbm0vU05OMTdzVUhOK1F3VU9nL0FzaWthQ2RqaGtyWjhn?=
 =?utf-8?B?ZGFlcEtEdm44M2cvbHBvT0lybk56V2lmZGxtTy8rMUd4T2VaSzdzaUNHcld3?=
 =?utf-8?B?c3BsU2QreFhESGhyMUtNV044Y3hyU29SNVNkWGdzN2R4SG1HWXV0YlA4UkNz?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d58ab4-a036-4f14-6243-08db677aa86c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:31.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je/KTWAJjJM3JwES65FeEPqbN7Q3sCSwjGJ/LTLYSXqDV7HrgZc71YYONI4SYfnEc+I58QxjFgRqqZNHpQOrtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3485
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

On 07.06.23 18:59, Ilias Apalodimas wrote:
> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jan,
>>
>> [...]
>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
>>>>>> As you point out you will still have this dependency if you end up
>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>>>>> this either, but it's not unreasonable.
>>>>>
>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>
>>>> I have seen this error before and it has been on my todo list. So I
>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>> you see any further issues.
>>>>
>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>
>>>
>>> Ah, nice, will test ASAP!
>>>
>>> Meanwhile more food: I managed to build a firmware that was missing
>>> STMM. But the driver loaded, and I got this:
>>
>> Thanks for the testing. I'll try to reproduce it locally and get back to you
> 
> Can you provide a bit more info on how that was triggered btw? I would
> be helpful to know
> 
> - OP-TEE version

Today's master, 145953d55.

> - was it compiled as a module or built-in?

Sorry, not sure anymore, switching back and forth right now. I think it
was built-in.

> - was the supplicant running?

Yes.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

