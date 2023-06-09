Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E049729021
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFIGkL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 02:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFIGkK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 02:40:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BDD9E;
        Thu,  8 Jun 2023 23:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5G4rkDAok8kcfWSTHhh5GTb74d+NF8xJQsqs37J2/i+FtMmmg83NFTZj+StX5AgHPy2H7QGYTXuVaQZvQzeUqmgoTF/44fZ925axeXrgrGm6umEBEJXxvgCJyYvQH0ICMrso5jioaLiw2AsBd839YgsV49m7gFEj7eNp8GjQj9Xyl4TT/heosOc9fIYqaSeRpzp6KjNdMR4vMn0qXF7AwMOkX3Kt5pe4YV2ASx7gWvVs5dxbNe4DdiLGpRkv07tQ7a+0Y9UzxT++fGHCwQ6vWKkZPSM0kSHpPM8DSVLiZHfg9BYaL9p8HM2O0F3j3oDZkWnJISMuQhDViafDtXI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If0u87yQ5K2Iwbvl+lX21NS09uLaKq0sla1vkSY0eOk=;
 b=fJ30xyqkTZaNYep6aCchYPLvsldCqCM7skUFk0IUlthULb5LNHHH4MFnzaCjUxaHHHSeip/704PzbIdgvdPRIM89q4bZawV/CSBX3z95tSJroL3NRzZ+3LJBIKxWtNGeOOF8eCjFRIv3G2ht8/rDZ7omvn+9Eyx/YUjqVLAJix57PFCIA1J5CxyaQypg1cH8OiDLKBuFrqr0tFyNDRohA12pRmi8eQwuoatVUb80nOZQHwPfKwmlju9axqT59O8uqWQWZfM3qPvjRcsK+hfaaF0h7ysRAIQoS8cj9Vl/4xKzS1VW8b1l+Q5twhG6ihLgsgZ7rmrWoAdE+ugrV709bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If0u87yQ5K2Iwbvl+lX21NS09uLaKq0sla1vkSY0eOk=;
 b=hERktXJif8WA2XLj2pFH2KAf8pZMkrM4DMG142lxGP9RFzb5uuBK7fmuac4D/1WZeWKFeX9GOupmjV4WxRIT9zU4PZ+v7VNkg2Db002Ajvvkw3SFl8NTWOXBgcD6KLKzmntnes+7coVB84i8vxNT50iU4mVxm0a2QmjZlafRrnfr150BR/cpYsMOWwdxiArPqZY0NCoFv6gGow0W/vQPmiVBebtbnYU8uWN7bQqC/dS7YTaL2vEncBY2opQAokLHVnxu/BBak2QOX6HzaPkbzzBsoBz/oyu2ORfborkTHrlzapWF/bhCtp7WtVGxj+NvbOpmBGeD3x96sPYPAKw3yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7732.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 06:40:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 06:40:06 +0000
Message-ID: <da7d3871-3b2f-1172-62a8-70f6856e4968@siemens.com>
Date:   Fri, 9 Jun 2023 08:40:03 +0200
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
 <3eb9bf84-4cf0-6cfe-9ad3-f7eef7d775fb@siemens.com>
 <CAC_iWjLdmmQ4+BVt_mOP5Ht9jDHQqoVV+-ATR-nDrmG37raGjQ@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjLdmmQ4+BVt_mOP5Ht9jDHQqoVV+-ATR-nDrmG37raGjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 365c997c-e45d-420c-aac9-08db68b45c9a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqgeIOIZ2MNU3Fj4CJ8puCYCXQO+tgPU8soBJuJXAPxtzWmyrWWl9eHfgMshX1jFzgHEK4V0DQi/3Q9y4I9i+hHOvktWPh3UBJbBI/j5zn5WibAaK1Me94gAkrndwCm4e6hy1cJYm0PzCoB7wQyivV4BhBOT9Vt4ON8FZ0v0+MD+FiEcX7OhjIG1y1hU1DXpb8SHvIKnr834nHI/9etn1TqQlcLYPj2WJMQEghur9jYW9F+QZUHNK5VA5DAnVAX5BzsBzekrBmN58SZaPDRI8D553jMQ1qhuMmT2tQeqRQ6zd20z8GBQq7jHnDHHWVIZORZDWn2VGS5qO67gosxdtBDrBboeh5YKJHgzGTvUFAIKF0XOCF/yYpFlGefXjT5IT6QADo+/CtnZdwjjtpflXVP0yX+bQT2d8Lc4/082i3Dc7Enl2oNxpIMNBrJ+aHgfMYF/JVlLC+MGXKL2FBTHDl1KYIPfHRe8KO7NUoyNcnlR2cWKtxomtKr0EGEVzoUS4JxdsdBvrFRft50OoSmFN9Oo5PslaFUWxvGWORJvYVvtLcMmcKqu7IfDLk6zeeTb8Rh+LaGaDNRScDK/9nMxXbPZXakvzWWaGpBG0YkeR5c5PQiwDmt4v4RjrGFg7L+tObnBnx0+NvzXv2dd5ahGxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36756003)(31696002)(86362001)(478600001)(4326008)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6486002)(6666004)(8936002)(8676002)(41300700001)(2906002)(5660300002)(7416002)(44832011)(82960400001)(38100700002)(2616005)(6512007)(26005)(6506007)(186003)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE43RWJVNzhzM0t1V25PWEdCdjhTbm10RVlOQUVRV20wNkVlMGdDUUwrZnhl?=
 =?utf-8?B?Y0wzMWRsTVQ2L2MzMzZUWVhLRUZlS29RaStQNStPNFlGWkpuRVd6aUg0dFQw?=
 =?utf-8?B?aENmQkdzbERIdWpjUVVSL0owYUROZ1FvS0dobTZyMTRBNlYzSTBvSXJWR2ZH?=
 =?utf-8?B?VnJGNml3VkhiVVYyaE8yM1d3ZUN1NEljUzBtR3JZc1BtVXU1UG16YURvZUtu?=
 =?utf-8?B?S2tCbHFERzZWT0pXVHF0ZkJuNjl0T0NmbWxZWnpZelgveU9NK1JjeGR3NSs2?=
 =?utf-8?B?TWhrdm82ZkVVVi9oWmhUZmR0T2NDMjgzdW1aK3BWMnRhM01BMnlUbExSTmkw?=
 =?utf-8?B?Q21CVTloNTJBSFB4cXk0ai9BN3NQT2RpYlE2L2NiNjQ3cTBjNk1jZkRzb01P?=
 =?utf-8?B?c2dWRmo5bXlWbDd4UGxNWXhWcldlcXdQeEJ3UnhPS0M0dEx4b2NUMTlwc1NS?=
 =?utf-8?B?UU9xRVl1cDdWazJXb3ZRbXJyNUl5cDhPSEp4dXZ0ckQ3cit3U1ZBSzV6N3RK?=
 =?utf-8?B?K2x4QllCNDZzaHp3eEFhQzg1NXRQV0lLekFkQTM5MUxZU2psWnl5Wnkyd1Ro?=
 =?utf-8?B?Y29iM0ZWVi9Mbkt5eVg0bC9yMEU4KzA1WWluNXlJSXFXQVNJZjBha1hPQnpJ?=
 =?utf-8?B?dStuZTRjSm42cDgwRlZmbXBpbDVSLytYaVpBT3kyKy9OUUYwY1Nrd29MZGJP?=
 =?utf-8?B?UnlOd1VBY2gzeEJGRzdBVUJHM3I3ZndXRGhuN3RJVGcxUFJHME1CQXAveFo0?=
 =?utf-8?B?ZHBzUEg1cUJvc2xOY0JaaGNlaFUzMjNQN0dCUVJIVTRUU2wwN0tDcGEveHBa?=
 =?utf-8?B?US9nR2UrVlFSbGN1MHZ0QXZRRXAyTnM1NkVoY3ppQ1JwUVQzVWZWVzJpY3BL?=
 =?utf-8?B?ajdUcXRHbnNCNFRyK3Zya2s4TFZ3bDdJNkxlNlZFb3M5clozOU1iUlNGL1hB?=
 =?utf-8?B?SVFGajJPV0x5TWJQWkVHSnBjRFhoQjVxaWdNVWdBS0dBNmtmQUg2dU5IT2xy?=
 =?utf-8?B?ZGhXU0JCd3VYT0Z2Zjh6bkhwNW5WTmpXaDF2cU9xV0lCdUt5Mm4vbDhtR1pW?=
 =?utf-8?B?VExVMzJKM3huZWtzeHQ5WTJnWDl6N3Z1NmRreWNiYjRTWHhDdGhQSFBuUURm?=
 =?utf-8?B?KytmSk1uZUZndjg1OEtrZVVlT0pTdnk3U2o1RzIxUXVvZ1lQczVOVVBYbS8v?=
 =?utf-8?B?eGtHTVBHSjkxcEpvL0JKV0VCRjZlZWRyUlhqdWt2THUvL0ZNd0QrUFllTHg1?=
 =?utf-8?B?WitudVYxNG9BU0R5NkpaN3EzbzVrRm5USU5EMkpudkdtMVRXcVFwZmNpVVoy?=
 =?utf-8?B?eWRZWHRlWXR6aG5veUpOdCtxRlBFWHd2NXBCL2padHVVczVaWkZKam5paUNl?=
 =?utf-8?B?eUE4UENGZmhocW9ETFZYelByVTZmZi9lZFdZeTdYV01VbGZRUDZJbmg2a2oz?=
 =?utf-8?B?bUpSQjNWMnVUc3lJMTN5MktyVUxaRGJEMFVoVmNadFplcjJXdzdlVFBja0NS?=
 =?utf-8?B?Ym0rWVpoYVg5anNlcElMTDhYRmcvYUZVemw0eWwwOHJCOHN0b2lINityazI1?=
 =?utf-8?B?Zm1FS3dCZDRxVFJNcXBQdkw5cGl3ekdWeXBJVGMxSVdrMWxCMndVeENSSW52?=
 =?utf-8?B?a3ZDN091NzNyYkNma2poMzJRZ0tHVHovblJSMWl3bmZIazBrR0xwcWhKSDYy?=
 =?utf-8?B?bzFrM0xjTlFGZjIyMzVRaUcwRkFuS0RuS1E0Qkp3V01YUlNhakdxSkRhRmpB?=
 =?utf-8?B?RVFyM1dJbElXNmtjTCtNcDBxOFBOZnRocHRxcitPMDJoSlBPdlB3YktRR2Qr?=
 =?utf-8?B?VEk4K1lIMnA5U0ZEQ0w4ZTJoc1RUOGFqaUVZVHpmcGY2TlorZkRhTGxKdW9P?=
 =?utf-8?B?NjVna2NwNndSU2ZhdUJSSGQzUEV4TTFwbGlTakJHc2dYbHFFdGdqVkRheTgr?=
 =?utf-8?B?TDhLZDVoVG9qeElIVmlpUnVYVDBFM2ZacFJzSjlYVTV6UlVtOTQyNE5UQnh6?=
 =?utf-8?B?WS9qZjJFdTc0R0VMTGZmeWlhV0JqcGpmUUNnV1JlMjUrQ0tvTlMvdDVWTDNr?=
 =?utf-8?B?Q1luN2I2ZzdzWGRSK2drR1lsZkJNTngvb3hyVGttSVpNY1lCRjZydCtrNjB1?=
 =?utf-8?Q?A7q6wn35UpLaPxs2X0rAJIllu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365c997c-e45d-420c-aac9-08db68b45c9a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:40:06.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlzwlCfqS3W7DKR3vKE90MdQBhEt8M5oPcNfXlLn8X9TQkq1gXzWcZprbsb8/6N3rxTJNVaF6oRFWqpG2Dy/5A==
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

On 09.06.23 08:34, Ilias Apalodimas wrote:
> Hi Jan,
> 
> [...]
> 
>>> --- a/drivers/firmware/efi/vars.c
>>> +++ b/drivers/firmware/efi/vars.c
>>> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
>>>
>>>  bool efivar_supports_writes(void)
>>>  {
>>> -       return __efivars && __efivars->ops->set_variable;
>>> +       return __efivars && __efivars->ops->set_variable != set_variable_int;
>>>  }
>>>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
>>>
>>> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
>>> index e028fafa04f3..e40b5c4c5106 100644
>>> --- a/fs/efivarfs/super.c
>>> +++ b/fs/efivarfs/super.c
>>> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
>>> *sb, struct fs_context *fc)
>>>         sb->s_d_op              = &efivarfs_d_ops;
>>>         sb->s_time_gran         = 1;
>>>
>>> -       if (!efivar_supports_writes())
>>> -               sb->s_flags |= SB_RDONLY;
>>> -
>>>         inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>>>         if (!inode)
>>>                 return -ENOMEM;
>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>> index 58d1c271d3b0..ec0ac6ef50a3 100644
>>> --- a/include/linux/efi.h
>>> +++ b/include/linux/efi.h
>>> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
>>>                      const struct efivar_operations *ops);
>>>  int efivars_unregister(struct efivars *efivars);
>>>
>>> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
>>> +                             u32 attributes, unsigned long data_size,
>>> +                             void *data);
>>> +
>>>  void efivars_generic_ops_register(void);
>>>  void efivars_generic_ops_unregister(void);
>>>
>>> Thanks
>>> /Ilias
>>
>> As just written in my other reply: The root cause is the dependency on
>> tee-supplicant daemon. That needs to be resolved, and then also r/w
>> mounting will just work.
> 
> That's partially true.  If we solve the dependency your problem will
> go away only if everything gets compiled as built in.  But if you have
> them as modules there's still a chance you mount the efivarfs before
> installing all the modules.  In that case, you'll end up with the same
> problem no?

Obviously, this will need proper probing of the TA services in the
proper order so that the STMM driver is pulled in before efivarfs gets used.

> 
> That's why I think this patch (or a variation of it) is useful.  It
> solves the kernel panic you are seeing if you remount the efivarfs as
> RW and It unifies the way the kernel responds to userspace no matter
> what the firmware does with its setvariableRT service.

I'm not against fixes crashes, but the r/w issue is a different thing IMHO.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

