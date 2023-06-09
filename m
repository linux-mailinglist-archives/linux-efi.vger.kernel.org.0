Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC572900E
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjFIGhT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 02:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbjFIGhI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 02:37:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DE35B1;
        Thu,  8 Jun 2023 23:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLroed7YkXL8dM6uhnjOukWL5Od53c1gkcY9e6QgWqehhJteFlct51LsFayNDRFW/2d2iBCr1HWVEH6CjmbMq2hDad8B21cusk6vKyRecGPmj7NhJjZItFndFE2Y4gw5GWq/ABoHpPjlDshBIipDaboEA8i2iEr0iXYl41NpAuztbflMwzSlQpJvocD7psQAtTdXqc5hgJA3R2fEXvkM6ogTPAL1cz1m0Dp2nk3kwOQSzCoZ4vazN9DU84TlxnOcMlng2iDRQO3eAf+c6+UhvoCOUf8jIbP5AHpzORYgDjZ8SE+biCtWc/kvLnAd2yRkzAVxVWCKiEWAl0pzIxhEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaPDSZ3Ui6I5MHone5Z6i32zu9X3ee0lrTS/fT0MDxU=;
 b=YMgElj91MhgnnMNWnotXUHRX6FVC1UVLWwt4f0g6Xg49ljj2gvVB5yS/h747YqR1kUz4pj9vSevCzUfGkc2ZY/vcs6dWMYd51SbbrCyM4/Owki0Fdo72/5+UuZopitV7iQnAxmIbT1XX0WGg6HT+U9B5Gz8MzCiULv68ieScV68tzacoxEveb3ycj7mjqCzKwlNhWtm2oE/dzkagtnpuxX2L8ENi5mjAkIcKeppBFmVyfmJBPMSOCGeLYS2ZKG0wreD2lPtzYTgGuol2qd5Lnf64ZlYqHvDi7hthHFoiepb7nWWpv4exs5iOFazOHhXXj/ccOSe1rxz+RLzVYdp+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaPDSZ3Ui6I5MHone5Z6i32zu9X3ee0lrTS/fT0MDxU=;
 b=tqRP458mNAuRVfsymmxZ34xWJTkN+IsVDt02cPBDF5R8i6aWjMeyb94gIGQMIKxOAVxPDWjEg3+EK3rtQsUx/Yrb8h4L7tnU/u6XIXoFcsvDleCCBpZNsOMu/o7q6UViw1vYXQstjWBDAsF8rs6X8UQ2aBd1IbZyUgaTDmdWwiuOB+ioGYgo5LT69r3ooxBwUnOep05h26/j6V66uJ5tEpgw+Goooq8CqMxLIN7nEb8WBMyI2K9CkWpLkwgsd2NndZtC0EGZiodtYxE9dDEF6Ka8f/tx1mRubYFo94QSwrNMZiSsxVMRKkj03F+3TiSud3AR5VXFrU9nmalWVNnSaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7732.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 06:36:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 06:36:57 +0000
Message-ID: <2efa7342-360c-a643-ac1f-ae89835b443d@siemens.com>
Date:   Fri, 9 Jun 2023 08:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
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
 <e0c71d88-ec5d-a348-0a53-ec6cea298b60@siemens.com>
 <CAC_iWjJs7pw-iF-tRL6MpJ7O1PL0riJ7aD2DkpB0F9cDMaxuiw@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjJs7pw-iF-tRL6MpJ7O1PL0riJ7aD2DkpB0F9cDMaxuiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 256a2215-5d66-4d53-ba6f-08db68b3ec31
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tl2dA+p8pK4T2bXptdW78PQkMhH+Jt2wdtX6/rvzM6DnyxprrKfOCfFiTjHf8ppGaGmgM9ChHQWuX0SWi86PttkOFBZZBe99kIoXauGW6H/QJ/eUp8TQgS4eGBXrwdeHYcLZgRhfKEjQc5dSlVgDSSX53ldiyPjf09T+ksmk8QVX+K2RVzXSUm616PPvhPX5YtcxT9wj218LlmAF8+yiCO0d1aNCebUtAajd8Nu5hr2i7bjfZxm1aiq9mQEomccDBnT0167cYnR6mwTCT5o8TElnQa6d2jzv39ajogqtF3anlCFbF58KFk9SBC401T/gmlEZyVCm/A06fyQTXW3ONPRdKBbmz+BTLvOjO4epUIiyNWQtJTRqU3L1XOe00+8La8D+IUrfACOLguxo1bpgYnIN5I5RBzubMSIh6FziT31vUkL6G+neRMOFiRqSCu1XRR81FisUWAlSgN0kGVO/Bw/3zJ8HIDxZ9cp7f47YWTynfM8ycDDumv0Mf3vf11KWaqRmcnXF2L3vSDU+dLPJnaXMeilGU1Y6NUaCUXmSkWCTj1RclweVQOw3Y67lBpu2Ra3rfud9yrtWRW9f6puhxti4XXWLXn9b5YJQAtdgCpD9Kn0gCN3VX9/25G/Mb/uCoKwe33y2Ho+oN4Bd3oJ2ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36756003)(31696002)(86362001)(478600001)(4326008)(54906003)(6916009)(316002)(66946007)(966005)(66476007)(66556008)(107886003)(6486002)(6666004)(8936002)(8676002)(41300700001)(2906002)(5660300002)(7416002)(44832011)(82960400001)(38100700002)(2616005)(6512007)(26005)(6506007)(186003)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9TdHp3MWVsQStmdjFkTldvQW5wcENISWNacXBVbzJMZzloV1NTZjNjNzlx?=
 =?utf-8?B?MENFS00vVlZqSFBqOXY2SllzQytUbHI1WDdPS0ZaSmxmRmtSTk1HUzdtblY4?=
 =?utf-8?B?MHBOT1gyR0xhNFFxQ1dFWGxOT3JGL1lNWFZrV0J5SlhLQ0k0VjFGUVUvRXF3?=
 =?utf-8?B?Z3ZENmJiNml6TkF3cmRJTGx2Vk9CR1J3bU9paVFQOGRIdWhwME04OUVHTHNy?=
 =?utf-8?B?RVRnNGRjOXVzWE1NZXBic0tMNzFYdFFQVXBKYnlMd3BVWGVzeUROd3NEai9o?=
 =?utf-8?B?Q3pjR0l3NW9oRnpZUG0wZjlHb3AxSkxGLy9SSFFPREVCaytNZ0pxejlpTDE2?=
 =?utf-8?B?V0dnaXpLZlJKb0oyMzZsSWxUZTB5SzB3N0VCVWV6TEg4Mklxb3drL1d0S1B4?=
 =?utf-8?B?RVdwOTF0M296TXRwTCtTQmYyQXhpcFkwQkVzZjNrdGZqejF1ZGZKaGw0K0dB?=
 =?utf-8?B?UUJYSnhBUHJybVBGTVVMcDNCbEFEUG5PdUllQm03eTdaSGloL01TcGh3cTdB?=
 =?utf-8?B?b1hwZTF4Q0xQOWFUTGNNU0JzR3JGL0RpYzlWRWZWT01PSFAyZW1najNTYldW?=
 =?utf-8?B?bTZoWnpRZGVva2xxQW5GODdnU3NaODJYY3dRcm02ZVQ2SER5YTVGMWlSV1dV?=
 =?utf-8?B?U2ZSUDVFNXgyWXZ5Zk1XV3NoR05oSXlHVW9NRTdGOGFpSitpTU9JZER0Y3lv?=
 =?utf-8?B?MUkycE5LRUFJc25ab2hTelVTeHB3Y0R4RTF4ZjdkQkFwb1FjWEQzV1dxbGda?=
 =?utf-8?B?akErRG1EMGhKcmFXQ0tyT3FkUDV2R3hmZ2FQeGZCVXl4elpZdDAyWU96VkFz?=
 =?utf-8?B?Sk1mbThGeEt5UGRUbms5VHZEa0EyU2dQSUszeG9Fc0tSNFNSRWVISTZOQlNE?=
 =?utf-8?B?S1cyVDNETkFRODlEWTF1RnVYeEZUMHdITWVWZ2g1VW1pY0NRZXlrcmZLb3Zt?=
 =?utf-8?B?R3JHb1RRcGVkM2JZcjR5TWV3RklZZU5mK2wxaHo2VEN1cUdpM1dBZGtYVlJu?=
 =?utf-8?B?MEdiSk9zVVRzMGxuUkJMbExNZ2JxTjlzYUpaRWtPY0d5NDd3MDZtYWJSdDk5?=
 =?utf-8?B?TWowdDBJUFpPdzQ1ZEtMTHhVcW5jamV6QWprN0lFNjEzV1hucnovQXV6VUND?=
 =?utf-8?B?c0lmcXJKbVk4bnVOdm5WUC8wSEdRYXRMZENjWFUyRUFxMWZHV0FzVFNUaUtH?=
 =?utf-8?B?L1ptSzg2am84eVNjTCsvQ2N5akVOdk5UODR6OXVuWEVLN28rYlhsR0JaVXVF?=
 =?utf-8?B?a0FVLzNHdjB1TjFGZFM2QjBPTENBV2o3a0VWeEwwV25kbElVMWphL3dUU3ZD?=
 =?utf-8?B?V1RKOUY5SHlrVjBUbVVGUXpXWXoyU05wdFg0RDI3STRBQjE1bEZoUXlGc0hk?=
 =?utf-8?B?QkZ6ZTdmR2k2SVJJNVpJSnlwbEdqRU1YVDhsOG54R09IdlliS2U1aVV0UnVO?=
 =?utf-8?B?cDhxRldndlZQRkxLakdNU1NSYjM5V0FFTUVMb2VZcElNT3pYNkR4QklMT08y?=
 =?utf-8?B?K2NhNzNiRHVVZWE4K2kyTnF5VEoxcWdZQUx4VGw5aGZGZnZ0TlREQmJDYUVp?=
 =?utf-8?B?UzRnTDVLaktNNlllaEFIcUhkNytsVGFmemNSd3FHamNkd01hUUMyT0JubFNC?=
 =?utf-8?B?UmlPdEhPNzcvRnFLK2RxdmpZWkplVFo4RmRaU0tnRjRuZUdPY000R1ozWEhh?=
 =?utf-8?B?dzZONEk2Zk1JTVAzQmplS0hKY3V4WVpWUm9MUEVjSnM1VkNUQUIycnRtUjhT?=
 =?utf-8?B?RzViQTRpQUcvZHU1ZUlvdm0rcXB4R3o3ZHVNbDBsSnhZZVZjamZMcjNYUk45?=
 =?utf-8?B?aG0rWGllY0RMNVZtbkRpM3o5WEdSKzZWTThDN1ZQRmRMbk5HSXcxTndFd2Vj?=
 =?utf-8?B?NnIzRlU0V2dXa2YzYmx5SHlnM0ZQNndQcmlMYU9vNDhPZlVraDZZdjlHcUNt?=
 =?utf-8?B?a2F0ZVNjbHVDVlRtRHExbXlZWHFDcndVdEpUQkpROGxZRzB5ZDZRK04weVA5?=
 =?utf-8?B?OW5xczdHRjViakFuS0hBajA1TW9iamxrZ24zL3pnZTJxQzJNaVkyWkFlemxV?=
 =?utf-8?B?aWh1NFRpQ3M5eW5hVXk4Zm96MG4yMEdNL0pyVDFjckRpWVB0aXNDVjFVWHJC?=
 =?utf-8?B?UmhvT1hZWnZxejQrVHN0azh6NzRaa3dNQ1d1OEVRZytrNlh4SWpVY3FmNmxn?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256a2215-5d66-4d53-ba6f-08db68b3ec31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:36:57.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbbppItYQpjLxQilZbEVGbo6HKLnj5FB/Jyc07gxAaecv3q2UxkS3Nb7cvDXNSypHwnlsujAwGqYI5nsKtLBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7732
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

On 09.06.23 08:22, Ilias Apalodimas wrote:
> Hi Jan,
> 
> On Fri, 9 Jun 2023 at 09:16, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 08.06.23 15:52, Ard Biesheuvel wrote:
>>> On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Jan
>>>>
>>>>
>>>> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 07.06.23 20:17, Ilias Apalodimas wrote:
>>>>>> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>
>>>>>>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>>>>>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
>>>>>>>>>>>>> As you point out you will still have this dependency if you end up
>>>>>>>>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
>>>>>>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>>>>>>>>>>>> this either, but it's not unreasonable.
>>>>>>>>>>>>
>>>>>>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>>>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>>>>>>
>>>>>>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>>>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>>>>>>>>> you see any further issues.
>>>>>>>>>>>
>>>>>>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Ah, nice, will test ASAP!
>>>>>>>>>>
>>>>>>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>>>>>>> STMM. But the driver loaded, and I got this:
>>>>>>>>>
>>>>>>>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
>>>>>>>>
>>>>>>>> Can you provide a bit more info on how that was triggered btw? I would
>>>>>>>> be helpful to know
>>>>>>>>
>>>>>>>> - OP-TEE version
>>>>>>>
>>>>>>> Today's master, 145953d55.
>>>>>>>
>>>>>>>> - was it compiled as a module or built-in?
>>>>>>>
>>>>>>> Sorry, not sure anymore, switching back and forth right now. I think it
>>>>>>> was built-in.
>>>>>>>
>>>>>>>> - was the supplicant running?
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>
>>>>>> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
>>>>>> store the variables in a file in the ESP instead of the RPMB right?
>>>>>> Otherwise, I can't see how the device booted in the first place.
>>>>>
>>>>> U-Boot was not configured to perform secure booting in this case. It had
>>>>> RPMB support enabled, just didn't have to use it.
>>>>
>>>> In your initial mail you said you managed to build a firmware without
>>>> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
>>>> variable storage in an RPMB, the EFI subsystem will fail to start.
>>>>
>>>> In any case, I don't think the ooops you are seeing is not connected
>>>> to this patchset.  Looking at the kernel EFI stub we only set the
>>>> SetVariableRT if the RTPROP table is set accordingly by the firmware.
>>>> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
>>>> can't support it.  What you are doing is remount the efivarfs as rw
>>>> and then trying to set a variable, but the callback for it is  NULL.
>>>> I think you'll be able to replicate the same behavior on the kernel
>>>> without even inserting the new module.
>>
>> Might be true. I'll try to look into that again when the other dust settled.
>>
>>>
>>> I have dropped this series from efi/next for now, given that it
>>> obviously has problems in its current state.
>>>
>>> The risk of merging this now and fixing it later is that it may cause
>>> regressions for early adopters that rely on the behavior we are
>>> introducing here. Better to get this in shape first.
>>
>> On the one side, I'm sorry having ruined the merge, but my gut feeling
>> is as well that this really needs to be reworked to get rid of the
>> unfortunate tee-supplicant daemon. So far, we have to start the daemon
>> from initrd, write a systemd service to adopt that instance, and make
>> ftpm modular to remove it before terminating tee-supplicant (e.g. on
>> system shutdown) - Sumit's patch didn't help there.
>>
> 
> No worries, the whole functionality is intrusive, so I prefer going
> through some iterations until everyone is happy.  OTOH the
> 'supplicant' problem isn't going away soon.  We will try to move it to
> the kernel but that has some difficulties as well and it's going to
> take some time.  In any case, we've lived with the supplicant for
> quite some time and the ftpm module has a similar set of problems.
> IOW there are kernel modules that depend on it.
> From a functionality point of view nothing will change if the
> supplicant gets moved to kernel space.  It  will just make distros
> life easier and remove the supplicant dependency.  I've attached a
> patch that solves both the kernel panic and the fortunate side-effect
> is that you don't have to remount the efivarfs.  If people like it, I
> can send it as a fix
> 

Distro friendliness is the key aspect here. If we were just continuing
with the classic embedded customization hell, we could also continue to
live with all those vendor-specific ways of booting, validating,
encrypting etc. so that distros will widely stay away from embedded
boards. That's why you invested into the UEFI way of doing things, to
change that.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

