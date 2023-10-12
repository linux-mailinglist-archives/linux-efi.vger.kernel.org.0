Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDE7C6B80
	for <lists+linux-efi@lfdr.de>; Thu, 12 Oct 2023 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbjJLKv0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 06:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjJLKvZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 06:51:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B6C4;
        Thu, 12 Oct 2023 03:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW5C38dbrA+BryWHVDG+mQbDz/m6LFn4gsEWxzw582ywcu4AeysKlMoUrEcQRWcdPcNnhx3CLhVcP/AzO42soGRFIPrqekttvCLc9E2Fe8GEHh9HuSNFpQwdAxjgzlUN2qt25WSjxal420mj/zHAEmm/swb0FylYHwkgABSh7FvuijJwAxTua9hLIIMh8LyXvwLwFnr3FWqOHd3ZULXeDdoFR4PCThSeocWL62ldEa7lKo3kEzHtv6jn7qJA1sAiG+feRFto36Buf51TkAvTQdXzFTgXv8xvH+w4u3PtJRf/svHF+f3cTGbX6qQN0LEf9N/9wavMtXcjmVAUBrbjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8peStivPPtj/rmCp1G7yfN3+i67W/C61T4t9+pIcvE=;
 b=I5Z0t935q+482BAZ++CHrh2NdGbn5HMs7SeOgnnKhGt7pMr5lEcHii8NbI9/1gBbCoWu8aFhkzLMn+7uIZqN42MzA/vqWFWRUMtT7m1TYaRk6oD9I4BZn/OkQFmwjabSveLJ7ZrrUv35ao11lhDVW9tANXUl7EW1U/6/eCEubS4iSHP2w/U7w3qce8bzSGhmrCPzEXQ+rtzhuWNrjmwUgfRWSqjCazyCO+vLIwNEbiK4QKTd0RVyGZ84wNfPA+xm3gBADnwf4UcmTKLNfWNvFHQ35yjei66Io9Xy0pJOmUeEyfHWsrAffaAS8ajXKryIGfzFAtddpZVxrW5DRLwOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8peStivPPtj/rmCp1G7yfN3+i67W/C61T4t9+pIcvE=;
 b=lLy6FHIuZEG1CYJZsZwktdP0u47SXxYNMt2vCcOCMhKlrQRduti8/oUnb6Ew8g2evW2xG/ULw4ukAi8r2+x+MAQzdbm5OiB1mCrO2NL3H5qSTbduHeWpzMJyRmRGVRIURrCkE4L/F6ZKlxxtAxRKxYcRithxJ0LQwaKMp26Adhsz00TMxHEK3K1KLA/xITzIddw04Dds4MRe/b251woKumxzt84bBP16SkV2QzOIgyN29atCqKzmJo75lpVYjFJ5SyKAGT6X7vK6MXlT5k7ErI6GZ+b96Kfb223q2/xI7JEBE3v+6rxrMqA1T0H91H/k83FSN0Ks4xDn/cNwyqVjZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 10:51:18 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 10:51:18 +0000
Message-ID: <8e36be57-58a6-404e-8828-6c777b8d2196@suse.com>
Date:   Thu, 12 Oct 2023 13:51:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
Content-Language: en-US
To:     kirill.shutemov@linux.intel.com
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231011192528.262425-1-nik.borisov@suse.com>
 <20231012101456.goamenepqlte65jv@box.shutemov.name>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231012101456.goamenepqlte65jv@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0098.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::27) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffb013a-3a74-47f7-1521-08dbcb1129e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gmns7ynK4dlsHohlCqmczZQU1EmH7ABdKMCbU4dtDpGJ3vdNBiSXKUiQYyJ7nZ8E/wSoAFC4i2M9rKMjYf0pIHN6pqa7Aie5bSL7B/TtGDq9AHOR/iPEAg+3SovLaHSiPWIodIJJ0OyuUkFib/vY20xp6AiNI1o+VtCmmB1AIXOwZROo2ZlNgiJct+rJ1GPezj4gSbI/2Fas5/iDj3ZsYd60XJsqN6SPNgUvDVD3Uh16QdPf5DhGnewZ3w89mSyn13u22Yp4xJ7IK7OtJgnF7LRbJTz4ySPBMmJpAUa8OuiEy01xbfJvvFSBCEcNjVTN82qWcPMQ+ntkYyjHoAuUajhwGD+ZQdKmHGnKL1x1eC0h7Pf4ZK+J6tgp0IDpw/SpjoBvwJ2tH7kQXxOCMudopKXDRW/mOcCvhtNcUo673cOET/sdb/zLfJHxR8X7EJyb32hMePSUZ5OXSCTQoH1iieoCanrfP0uS/np15skiDyzLpV7oP0A7X6aONOvTFnmMwXSserb3JAysJAHDQDDYVYHG1uSbC4R55JOgYQWrQaOvLELkOf70kfhpziifyj5QqzKplCzBBYAxfeBOxHY67b3J+S68ntf00cl74LUBhqdOPp/BEggDETZvYNw5O580VCti5ooG6t4s+VI9Ga9sAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2906002)(86362001)(36756003)(31696002)(316002)(38100700002)(6916009)(2616005)(66946007)(66476007)(66556008)(41300700001)(6666004)(31686004)(6486002)(6512007)(6506007)(478600001)(83380400001)(5660300002)(8936002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStFNklqTFV1bk45NTl1V05CMGx6UWpqSG00Z1h2cFFsYVhnZWQxa1ZMZUhE?=
 =?utf-8?B?YnkzVk9EWjdoV1V6TG1PdjhuQm5CUVJIa1hCNEowN2NhdHh5aHBBNkJoMjJU?=
 =?utf-8?B?bTk1YXpxNStGSGZnR1Vjc2RVbnEwNE9kTWN4MHFaVUJHdzZnU2M2TzJtZHVu?=
 =?utf-8?B?ckltQnVUaGF3NXgrU0YvVXlrdFhVa0dTcndpaGZtbVd3M3RHTHQ4cXdhZDFB?=
 =?utf-8?B?NDhlL3d4ZXBZZDZYcWIrcEZtaFpxNjlibEVzdHpVTlNNS0VrY2h4dnhHRDcr?=
 =?utf-8?B?emVNMHJYL2F2SThLa0VFU1BnQzltQ082bmdyTkNWRUs1V3lWOG1EVER3WFVO?=
 =?utf-8?B?V2tmQ2V4UUcydW1aMVZlME9YTk9odnNFanVhUStaSWdlTmRlZm9YeEtmRVAv?=
 =?utf-8?B?WVVaZ24wM3J6Sm8vWEwxQ2QrbktSVXp5eTRNQy80MEFTak1uUFY2ZlVHRDhx?=
 =?utf-8?B?Y081QWRIbnRJTW5VMzFINkJEblhiK1hLTW5GdDA0bUpTS2R5R0FiVnd2S3hn?=
 =?utf-8?B?YkxqOTFFTktmYmRkQXo4YWdabng1YkhmTmQzY2YxTnhhMklPOGdTWFBCRGFD?=
 =?utf-8?B?WXdOcEpvTWM0YTlZWnR1aWhSNVBtRTc3Q3ZWbnFiU1pqWnFsQWlxV3ZXN0ky?=
 =?utf-8?B?RGNhQ2JVcWRZMTQwL1hqVFlnQ2ZjMkNsbGhJdWRPNEVubFM5cll1b1VlNi9N?=
 =?utf-8?B?Y0tGSW9pU3F5MnRvRUdTRGZBVU51Vnl4RURzQ004Uk5iaXoxQjN1Y3lQemNZ?=
 =?utf-8?B?L254azBvZ0cwRnVycHZncjUvV0s2ZHh5Y0pUTVpMcUtvcllxWDNLZXNwYmpJ?=
 =?utf-8?B?cDdjb3l2emdSV0tuYVJJRkgySXlrdGdaL3VOVGVPd0UyZGhZbnFPVW83am1r?=
 =?utf-8?B?aEI2R0I2b1VBZHFqY3d3bGsrMXN4UzQwUnQrUWNGT3k2QUdQckx2VGtkMWsr?=
 =?utf-8?B?ZUNDMEd3dHV6Y2dHUTZxMS9oOWZ0N3JPNU9tTnE2c0VJRUFLM0ZBZzJDc2pq?=
 =?utf-8?B?YjlHTFNtVFRyWXB5V2hhVkc1TWxKK0IvTXZqdzhUSWthak44c2Q0Z1d1YUlC?=
 =?utf-8?B?Y1VVVElrK09FMEpYM1E1cEJXUUZYTVFDbDJ0T3doczUzN29MY1NPUGhMb3Bh?=
 =?utf-8?B?T3F1Ky9XRElCTTlQS0MvaCtRbTdiV2pQcjEveDcvMXRrK3RFNjlHeWxPaFVV?=
 =?utf-8?B?eUFYb0NIZS9FTTdIR1dHNGM1K3ltUEhTak5sTmZqaFkwTmcvUnNER28wTDZT?=
 =?utf-8?B?OW1oTVMzRDBWcTR4cUQ2am5lQjFMVW1DYlNJT0lxYkQzcm1ZdTB0MEZLVXpj?=
 =?utf-8?B?UE9hdGVSYk5walpuS3ByTlQ3dUt5eHc1VXl2RXdKRWpUT2htUW9hM1hIczA2?=
 =?utf-8?B?UkV0TnF6ZWN6emNhci9mTEpJZG4wRkNhZjd5TmZwQWtldHZCV2p0NXhKOXFy?=
 =?utf-8?B?dEpiWGhGQTdDZ3RRV2JsUkRkSjNoOHlOck9HZzM0dnRxVnA1WU1MUHVLR1pu?=
 =?utf-8?B?Q1dOTDJ3Z1k2aCtRbCt6ZHhTdUx6c1N3bWtXT3RoWlg2K3FqZkMwdmNudXdQ?=
 =?utf-8?B?VmVvOXcwL1dVU0k1dEcvZ2cxOFJmelRDTklDQTdvTmhITXB6RWMyZ2Y2U3Ez?=
 =?utf-8?B?cjZXMjN1WHRadFh5N3Z0MHNXOE1vTVJjOWNCbDA1U1EyVHpnVGpaQm96TDRk?=
 =?utf-8?B?b2RyNXRHZStxbDJaMEM2Yjdnb1JJY2tadHZuYm0veXBocngybUpvNkhqOUwz?=
 =?utf-8?B?bUppa2o3NGlRem81M1BZcm9HaWhOS0ZST2NPK1dqSjhuR0hFeXA1bHdRYllh?=
 =?utf-8?B?YkFrZi9DOERuaGJXdmtJcWdoL3c3ZlNpSjl5Y0xvT0V2dkI0amZhUHY2VE15?=
 =?utf-8?B?c3NaSm5VTGZiZHoyT3pTSTVEdENieFR2azlwZXlXVTFVOEkvTWsrc1hnVWZn?=
 =?utf-8?B?cTB4QTkyNjlHSjNhM3dVdEZzdkdGVzFyVDZ5YkdtbU1jZ2R6dVJyYk80SURH?=
 =?utf-8?B?cVd2elpSdGdCMmtnT2orNEE1b3d1Q3JzMktPY0RDdVZnSzNnajRKNFdxV2tX?=
 =?utf-8?B?bWVFc2FFZHhvSHpYbVRRMFRGbjc5bW5CTzhhVEptV0dLSGp5b3VZRVNVcUhY?=
 =?utf-8?B?S1QzUlgrd2FIRnpwODU0YzNZektjTHVNYkhLaHR1OGhlQTNUc2xwbUpMOTVY?=
 =?utf-8?Q?Op3zfgI0eew36ChQeQaUeB/IPb9HY3CZF24s0hEJyZHZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffb013a-3a74-47f7-1521-08dbcb1129e7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 10:51:18.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcGX/8muq8IlSkpfHXgxJccaSklaqVyXQ8/MUDhq60melZMtrW+oOp8ufnufWxpx86ahi1W1+IvdbV+wyvzu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12.10.23 г. 13:14 ч., kirill.shutemov@linux.intel.com wrote:
> On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
>> setup_e820() is executed after UEFI's ExitBootService has been called.
>> This causes the firmware to throw an exception because Console IO
>> protocol handler is supposed to work only during boot service
>> environment. As per UEFI 2.9, section 12.1:
>>
>>   "This protocol isused to handle input and output of text-based
>>   information intended for the system user during the operation of code
>>   in the boot services environment."
>>
>> Running a TDX guest with TDVF with unaccepted memory disabled results in
>> the following output:
> 
> Oh. My bad.
> 
> But there's other codepath that does the same. If setup_e820() fails with
> EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot()
> failed\n".
> 
> I wouldner if it is feasible to hook up earlyprintk console into
> efi_printk() machinery for after ExitBootService() case? Silent boot
> failure is not the best UX.
> 


In my testing I was able to transpose setup_e820 and efi 
exit_boot_service by calling exit_boot_func before setup_e820 which 
ensures the various memory variables are populated. Is there any 
specific reason why ExitBootServices is called before setting up the 
e820 table? AFAIU this is an arbitrary choice?
