Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6742726A11
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFGTqX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 15:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjFGTqO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 15:46:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE411FE0;
        Wed,  7 Jun 2023 12:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH8Wbj1i1J3Ucraxbx0npom7RoRWac72KH64GuaVTbvOwqyNc5+zDfHWQZ27Fad4e/aSI7qo5Qdi9R6E7j9HmhKsPwjn1L1CrQ7+iiLJ+U5Rt0s/WMFX8GhY6sqHuhK/fOtSvQTkO+n8CZFtQ6D+RLKqSBPPktYFVyRQAdeASjGdVENivFzO72bQeznwgTBMLrW2ECvtXAdtGklB5SGRT5FIf4tdI0lVQpwVUEVDJj9q3lwOrpnfAXCBzDaVpOpxqA789qHpUJW16Y1tnNbPya4za8NJP1eMxbXy8lP8wxLAGNdmNfRjwznVGooSGo0PybFBtQFqYw5nENvBO2i47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTIKjWMMJenQv1+yflxHeQj6JBnDSYUSIoaQKJowFik=;
 b=kWsAmyvBpBho0VvchMskLJLweyer9+3JmjJmCMx8TpVjCJyaUBC1+yG1HdBdF8KPYnRuMsWXrcdzgLhSzfUgkW+y3OBl/DvSKyEc018/QD/gr9qUl1eqHgh0W4mvPtIcW38QZPDk3XzuZZsgZb69jDmYyYfJvdPoUlXeQWtOPC/T8dfTHXXKF8OMi9lpBm4YSsjYyqr7i/9ICB6jRc3vpzS22Ebg3c6CQ8/cl3WVF+zSx5J9s0+EadHE0HXd7pX8Zt4q40MEMcnu5Oy3q8ED1Y+p6GkogutvRR4UWiR6aeAhDjchnjEAVjgpWwQmqSov3QF0nX10p96Q5+5dl2IAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTIKjWMMJenQv1+yflxHeQj6JBnDSYUSIoaQKJowFik=;
 b=siVjY7y4OYa6zBEBSiPaQF9hczvMblCmXl9/vu3hJwN+knothACVnQ+Jdt3XtAOILTLO8QL/cJKE4tHvlBiBs6nP7a/OT3ryt4xaAW16bGJPz9pvJMqj2aNMHMJ07mOZwJFqvqmEONm2VZDeqrpSpN0E6Y7uM1oPNrgo6DE52BwuBs0hsDCVbpibXqmgYd2RwWWs+Kj4FTUwJsO+fQp5880itcWYHE2o58BCqNqqu6KmCKeEWENoWW0QOlDIo8uECUeR7tjm9WDhASEEHayvzkBixnHmh/e3IlB7zYBr/pZl40HuZp1MslXDdOYMUtYTtX2ZkDUauKasVR7caPVJig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 19:46:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 19:46:07 +0000
Message-ID: <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com>
Date:   Wed, 7 Jun 2023 21:46:02 +0200
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
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com>
 <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfaaf9a-be70-4335-eeb0-08db678fd5d9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46qeqZtBufqv+N/hj02WYbPt94X0wk6M0Oi+CO6aifdHi7U/+GWJB1vpif+MRy6f6O0tYYFgr9W8/IYxdTf96OanZB106KQhyqt3oIVPQZOktrmSxNrEH6ImbJtGRgaigjjpeb5UEGAuCMnMTegi6YltFK/dhf/Ahf3+UDjtJNLFvUSpUfq0VPwXT5lr2jja4OAxMkCI1nknPTMZVmDBwMOLpNzTJQsiiP/OnLC/9fz5aaCpuHXDEEDA7bvau36iG1RjHwXE/W68fEP7KNn5xXaES0YbL05pKrg8SDPdKlJMYi5ojjqB2+fsjUyP37q22hybrZo+NomgTOmMtG0jCIvDpEUZX+1iF5qWyy1PB+rT9NEstlw3jTdmC+box97hBQdWFjjEPyRVHSYSS+Wgv72vFs9alPQeXNqsr4Sg4PmNieOc6ZEEwY26MWhBIUc684GW+7deqsyLe7P6ezuTItlFpLRO4Y3jArXoO4cc0Vm41S3O3Z5inCE6pU1J30eaWAYcJKbGDZfVfV3PQTVQiraNekNJHAZVyk1iJK/trD+rrwpt8mWAC7Y2AuNM9L77IJJy/DBggyZ9WpQetp4yCSxiyGXywDO7JDK+pNaTb6TiRGV7x5vUWuc++/UIYRu0WYqlq/gXnzqxaQUaTjh7ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(53546011)(6512007)(26005)(2616005)(6506007)(44832011)(316002)(4326008)(6916009)(66556008)(66476007)(31686004)(66946007)(966005)(6486002)(6666004)(107886003)(186003)(31696002)(478600001)(54906003)(36756003)(2906002)(82960400001)(5660300002)(8676002)(41300700001)(7416002)(86362001)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lKWXh1WHltelMvVVNxd25DQXdGU2tVRWV0L2xrdEtQMmhYYVEydDRmNkRT?=
 =?utf-8?B?NzRVUVhrZHh1S0JwY2NnSG1rTkluR0lYV1dzajRIalk3UmNQNGpleFFCZzNJ?=
 =?utf-8?B?cTJXeDUwNUtEY2pOSVFGaGpvQXZaZkU2amRwbHEyOERBem8xNVpuQ3R6ZVhT?=
 =?utf-8?B?bWdJN0djUzNKc3Fpazl0TWVLWXFnL3pBTzlJNHl6MW9BbERiQ0tTVHRidmdl?=
 =?utf-8?B?VTdUVnNLZ2F4WTZFQ0VkeWd1Z01VZE14T1RzSEpSeXAzanBVRHNkeW0xTm52?=
 =?utf-8?B?L2ZGczd1ZFJMbUZsS3lycWo0N3hlbkUwNzlKUEQ4Ym5sN0RkUHdNMmMwSENy?=
 =?utf-8?B?RTZVZmI1Q3ErMFQvb3JxZWUyMUFjNzI2SGkrdklxelRlOE15QzhoaVROMGZl?=
 =?utf-8?B?MTJEQmRZZWhzQ29PME5kclhOOEtVNVRkS0lkSDNabTE4SDJ1RE5VUHJ3ZjBz?=
 =?utf-8?B?QVhnR2k4RVhDUS9LckE3YkVOY1oxYisxcXNrS3ovTDNhT3V1OTJ2Y2pNdTJs?=
 =?utf-8?B?Q3NHYXYrWUhocGlsLzRvRysvbjJ6bUpscmJTTDNSdVJET2pkQ0d1aG0zaXZY?=
 =?utf-8?B?NkVnblN1TmIrSUFFelJKL3JuTzVQZlptUEVJQUxubkZpekkraW9rbGt4LzYr?=
 =?utf-8?B?OXZ6R1pJbHpLUHA1b25FYmh5K3hkZVBGaWFmWHBYM2FpVDg0Q1p2UnJOL0hM?=
 =?utf-8?B?dWM1MFltTStvL1I0TDFyZE10VTRxOUg4bXpYZWwwZTBQM1o3aUh5ek4yYlJX?=
 =?utf-8?B?SktDY0xvaVNqamhSNXBSNXhpbXRoTWJ6alJDS051bE5GU2hmKzBVS0toelBy?=
 =?utf-8?B?a3daZzJESHQyb3c3YzJSVWVGODFsT0krc1lYaGpraHNjUWNIT21tM1BDWW9z?=
 =?utf-8?B?Q2sySng2b2FTaXpxL1RPeXJHSEhlZ1c2RmNHb1kwUFlZbDlEdFJCaG1Wak1h?=
 =?utf-8?B?NTA4cDVVbVlTeXYxSFQ0WGM4ek12bnFHZjd2Z0hQSHo5NmJVc3B2SXBwaFdB?=
 =?utf-8?B?aWVVMzVlYVY5UWFWNktWMlRHeU5hZ0lkZlZ1ck9CdDcyM2MyTTFxRnA2T0VD?=
 =?utf-8?B?eVI5My85L1ZrcFdnZlkwSUQ0bmhUQ3dJVWMwOXVsNmlPbkUwN1NoaUhST1pw?=
 =?utf-8?B?c2pRU2xqR3MxNW1kSDZjTVVpMUxOT2V5TXpOcE0vaDY2N1FtaGw3U2ZBaUNV?=
 =?utf-8?B?L00yOUFTK1k5bFkzd25tdERmd3VyK3NueFZyZ3BJaUFSSHVUbnZQMVdIVXVu?=
 =?utf-8?B?SGhuUG5zSXl0dGFCbXdjZTRXUUp6U21UR0tER2QrYnNZczRwYkIyTWZSc1VO?=
 =?utf-8?B?MUliUHA0aGF4SXQyZHVkMmo3cmRYaS8vWEpYM1hUOHZTZGp5UTJ2VlJ3cDdk?=
 =?utf-8?B?Wm85ZEpLbGEwcHdUZlBNbDF0Q1RMN1E1NE9OVExocW0xa29Fbk8vcnkrd1ln?=
 =?utf-8?B?SHduSjkzOEVhK1gyZi9kRDBSblY1RVJCMUlabFZzbkx4b3R3OFBSVWcwMTlN?=
 =?utf-8?B?U1VnSXdYOXc0NEJFTXE2YkNJcEE1REczdmxVMCtTd2tRNFdjR0Y0N0crc3hL?=
 =?utf-8?B?YVdsY2Z2VFozQS95NHBYbHlLd0lDY1JLMTFWM0E0eWZNYk1VWURqVWRCdEtO?=
 =?utf-8?B?Skg2YXFhWGxKZXU0ZVpqcTZaMk13eTJ1ZTJxL1doemRRN0drMWx3OXlnWHV5?=
 =?utf-8?B?TG9jd0VyMitlcVN3R1Y5ZnJmSE5sZkFaOXRVamFtMnY3SnNFaTkydWFDeTla?=
 =?utf-8?B?c2w2QlFRaEZ2RzNPdDUveUZzZFIzdjVtd3dEOS80UTVsM214RVl1N0FaZFha?=
 =?utf-8?B?Wjd2VUVmWFBKKzlHRmVYN0lVaG9iKzBINjBPOWdGU2JsR3FXVnErSDFwS3hG?=
 =?utf-8?B?TkJQTVNLVjlRTy9HdFV4ZTI4Q3lMRjMvRURpS2krNzJzaFZpRUJYU2FwVDEz?=
 =?utf-8?B?eUFDZlhCOENUSjRBZldZdnZxTVZEMzZFQTRqU2h1c3B0TDYveERkZTJ1ZWR1?=
 =?utf-8?B?c0I1V1N4Wml3NkEzTUZFTHFIT2hwVnhFOWN1cEV0clUvL1Uwa2N3aXowWGZl?=
 =?utf-8?B?M2hBOGU4OWxMdFphTGhGUWo3V1A1S2hHNTNBZ29zL3I4YkRDZTc1aW9FcEtL?=
 =?utf-8?B?ZjhtbnQ0YVV4SUl3MmFTN2czNnFibCtRaHdxMmVKNjQzc0Y3VzR6TS8reSt5?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfaaf9a-be70-4335-eeb0-08db678fd5d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:46:07.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1AohzRNm/AlYdhm9GiKWzz7rco8ALIhijIk2ClCFaBIM+Ts02Aomevwa1zugYQ8h+/DKznFA7+nREFl35ARDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6933
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

On 07.06.23 20:17, Ilias Apalodimas wrote:
> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Jan,
>>>>
>>>> [...]
>>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
>>>>>>>> As you point out you will still have this dependency if you end up
>>>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>>>>>>> this either, but it's not unreasonable.
>>>>>>>
>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>
>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>>>> you see any further issues.
>>>>>>
>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>
>>>>>
>>>>> Ah, nice, will test ASAP!
>>>>>
>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>> STMM. But the driver loaded, and I got this:
>>>>
>>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
>>>
>>> Can you provide a bit more info on how that was triggered btw? I would
>>> be helpful to know
>>>
>>> - OP-TEE version
>>
>> Today's master, 145953d55.
>>
>>> - was it compiled as a module or built-in?
>>
>> Sorry, not sure anymore, switching back and forth right now. I think it
>> was built-in.
>>
>>> - was the supplicant running?
>>
>> Yes.
>>
> 
> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> store the variables in a file in the ESP instead of the RPMB right?
> Otherwise, I can't see how the device booted in the first place.

U-Boot was not configured to perform secure booting in this case. It had
RPMB support enabled, just didn't have to use it.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

