Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76F65B7B9
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jan 2023 23:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjABW5W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Jan 2023 17:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjABW5U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Jan 2023 17:57:20 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD9B7E9;
        Mon,  2 Jan 2023 14:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3DjT2ANJlAXE3wKwjq2DGpYFsCWw5cSEsRb1Z79aRQVm2HkMr4ik2rc44oKUBBp/Rm252QtRGRz4HnLnlRm7r8f3JhuTzw/vFW8hpIgkKLmJGRC8Cq74ms0wrZ7kBEVUin7y3owfLhQEfNND3ICWTsEKFSXr6nodWVt1aOw1mI6PZtmSKJvrk4NVKserC1SaSi9EgLovd6fQJHUi61YHNnURfKXwlwRqX6IU2oALE0rZ+0sEaazBfYhPVtRwDkygFnQqLh71hBSlsOIBFNP2lEmM0z2ibzyk3bUs9dgpSvtaqmtzY94WbMZjBj91IOKk+aRZx4p2+jvF44deFVB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6hC27wR3jAULzQRyL3zA/m5mvOPR8yB3WlpZbJW/uQ=;
 b=c/Gtw3xyV7tU0bUa8DY0NT9MggoTZh8ZB5x8p9LVwSx+Qe4Tf9ZCudpMyB1PU7ctCLkll0aVaqFP5EtH5r64r/NRRT8iATkU774wn/swLxo60U0ztEgyKRFWwZXI7QnySHooeIXlyMeKnl4PZ8L/9adzKbGuBGSCqSGkgov11rwEwbFTO29G7DsL7AZRLsCuKjwDyqPEba/flp1d5YZp1Z8wGW8CXNwkCwiJUFe6afMLDhIdhQbwAGOuKkLq0P64K8af5eoQ+KB/63iSjDYaH9Ws7UoWWGwuQ0idWaILGqYErTEi/YFm9wLOzeZkCVlZyNTYch7pmLxbyXLDs3vz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6hC27wR3jAULzQRyL3zA/m5mvOPR8yB3WlpZbJW/uQ=;
 b=B18Df8Ni0Y9arn5VOPFeeHScAFavMqJp4xQW63JRk+eW4akKaRTUyKv5pr+XaW/6NwFlfK0xfBIDX47a8vOl81zIXPh/q8I/QjFpciqJuSh4X4r5rFScLgfnm5SMeiB7RT7MBOnKDdjSxWyP41iL2g+kaLWMkqoypdlUvFeylnjdpqbV7i3cul5txSwXWut5tIIHHwpzsX0oZOVnWPW2df3t3rs7yzTGSkevgL6z0tXxhUXYmc4pN2QnBGrHY3TBGsv05eOu+NwtlHvTMo7f9GNR1I8GX8tfy/jnsC5jMpR8rV82Hx+DoWknvfvTHu4yyfihkMYFvYFY0qkt4hbuoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 22:57:14 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 22:57:13 +0000
Message-ID: <a7f6e0ae-3fbc-ccf7-6185-a425ad25e04f@nvidia.com>
Date:   Mon, 2 Jan 2023 16:57:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20221227040925.1619833-1-sdonthineni@nvidia.com>
 <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
 <Y7NY+ba2USk7hEAx@mail.local>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <Y7NY+ba2USk7hEAx@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: e092196a-a73a-407d-a436-08daed14b016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzQvjymIxpo9wASQpRfEe2ba5IwHm3G6Mi3IzLHYbEh5IM/AQY5rxVFBLh2VpLWMrpVJNLuvcmRrWit/tOyemvYx95Eve11zXu2fCs6QxUfab4JYWnge7ISXy64xhKWSTBfYnJeSvtnFx9LlfLQLsYKMrjFwk5Qc0qRk1BnvfkkEd56A4PqgwybxG3TW9JHxR8Jc7VmV5hJRvaWwJg19xQx0/EkdxXE6kFvemNJpASSuFnj/b/Yf+Z16xEQxH2m+3UlNhe6an2/OfsL383FsSD7AqSgdpjon12zhndsCfLcBnvZDlht4b85b6oGztnJ5y0c7GYp1i61hXoPPFLReUYVlqZasPDHTU6Osh3SjTkLqGczRU6g4mwoCMoBz6AbZi7VuE9GR6EDgarGUMGqr0ZfM6Zr9TEzkA9e8Pvpn8OdqZbLCy8xJcR3PqRL4lmtv3d2AUr2bVnB8Ifu02bY0tbImh1Qp0BwdEXVAAcaMYcT5yELH71Qz2empJxmEAOqeXyVDtLCW0HPGS9y8h09p37jS0acTUMEtK3hZCaCHMM10ERK5s8T6fk/KH0HShKrHDK0gFZluk5JJ8CNxLPwcG2K4sBZaiCgodaDqWtohK6owZ0Njpcnhx3DYq3DrXC5ikZw+iGZYCGMX8rmOBQ0FU3uhJNFGeHbBgcizBBcZpeKfNksM1VuVc/L65BZl0xQKg0wDp6ij8ABAmLa4Mg/s/t+8QtoFBycHbqAp5OqlDsMPXUt3nyB+HUFTBkWuvSNDlAkeQKnb11Fx+2OvNRmCmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(2616005)(83380400001)(6512007)(186003)(26005)(31696002)(86362001)(36756003)(38100700002)(2906002)(110136005)(316002)(5660300002)(8936002)(66556008)(8676002)(66476007)(4326008)(66946007)(31686004)(6666004)(53546011)(41300700001)(6506007)(478600001)(6486002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFJM1dORkxhM3dsb2Vvb2xEdGZwaDVVNmg5aTZPUmtITjBuSVI5R1pyaDlV?=
 =?utf-8?B?VE5hc3JLOFJiV1A3UmVrOFN0VVh6WkNnaEUvd3I3cUVpazFzcDM4dm9VM0Y5?=
 =?utf-8?B?VW1XTmVUcnhiM0NZL0ZOdXRWZUZtV3ZEYzZ2aXdrM0t1YkFkZlRpWjdGaXVl?=
 =?utf-8?B?TWhPNmVaRlFVQ1BRQ1F0L3RkV3puRVdXdURQMFlLRHIrK2U0MVM4UitlRnpI?=
 =?utf-8?B?VU54ZjBuK3dRRVh0UEo4bWlNcnoweHNWVFB5SkZqSG5HaHRwQ21jZitwVDBy?=
 =?utf-8?B?OHJFc2Q5cmZvVHBkVHljWmJRNWVidFM0OWtvK2cvdkRoaE9ta3JkM0dybitw?=
 =?utf-8?B?anlQNzlHdlRzSjBReTdZK0xvbWFZSkRqSmxGOGhMeW9PZy9DNm5sMTNZaVUv?=
 =?utf-8?B?dHdxWG81eFg3MU9lZ0hPU0hOR0NPd05CS2xnOWlndm5Id1hsZ3pHeGdLUU1h?=
 =?utf-8?B?eVMxbEtSYXA1MHUzQVd1bk5HMkpQaXFuWDlYQ0w1VjBQVlQrWit2anFhSUNj?=
 =?utf-8?B?R0xIYStEbi9BZ0dqQThnU1k2V3JEMWMvd3hVMk1nK2xsMFRPS1p4U1E2cDBs?=
 =?utf-8?B?MVQ0ZnpRUms2NnQ2T3hsVmZkQmZIQkdRdGFRSDNXRVpOS1NIMnp3d1hkNE00?=
 =?utf-8?B?K05nUnEzdTZhNEErejV0TklHTDRJRVZpbWtXaXI5d2djUWl2cDRjelF4L0NY?=
 =?utf-8?B?TGtORVpsa2hyaVBCaHhEbzd6eUg4di9VQ0VxWWIveC92cHdRSmE3b1hmUUJz?=
 =?utf-8?B?MXBKaHh2YWxSZ1N1dHFOL2hWOUk2Zko0aGpvSy9NelFmZDAvd2Vrd1FuSHcw?=
 =?utf-8?B?NU1xOXQ4RFdSaXRLaVZJQVRQdlkrOTRaVXZvYmM1TDJvdDJ6eEFURityWWNN?=
 =?utf-8?B?RGhISnZqU1ZZbVdoVExZa0d5dVlpOXZNdVM5WjViZnNPUkhHQzNEa21iS2F2?=
 =?utf-8?B?TGZOZXIyV0VGQ3lseTU2Y0FNZEpTSDEycjRpNUJqRUIyNHo2clpGN09CbG9y?=
 =?utf-8?B?elFIR0VGRUdLaHR0bmRvaVh5RmRhc1UycE5NbWhSSlRiM0xBdFdZZkFhbDIr?=
 =?utf-8?B?TkI5T25SVmFDMXFWU2VkNUN1bHNsa3MvMGFXVDE2cFRJYzc2UTlhbUovWHBV?=
 =?utf-8?B?SlROSTY0YzJxdkZ5d2dlSlV6TVo3eVVoRlVmRElhU3dydEJNa3NUN0s2c3Az?=
 =?utf-8?B?YVRxUkxoaHBEQk9EbW1uOW1rblBGU05SejBPa1NrZlBoeUZDUHQwRVl6MkxR?=
 =?utf-8?B?dFBNakk4THdERWZPNWd4KzNrUkR0UGpxYngrTWpTMTNxTXlERnlPbWVCMi9C?=
 =?utf-8?B?ZnZGM2pHbjVPcEZKR2V0Qm1SWGVUWXA1YVp5SFhRYmdtK3NIcC9CN2ZibFBo?=
 =?utf-8?B?dWQwSW05R081dUJldVVIOFdZd0NNNnpqa2VrRmFEeVViVXhQYlpOL2pyOHdX?=
 =?utf-8?B?WTJ1S1A1bkJrcXAybVlxRmFsK2hzQ2VyTk95dk1BeEdoaEJocWhWY01FTDlq?=
 =?utf-8?B?czZZR0dCTllSellJekRkT0pKeGFEZFRzMVRrRHRETnJjZE5GV0Zoa3NoY1Zu?=
 =?utf-8?B?dG1SdEIrMkM0UzNabVRDalE3b3hwQkRwZ1J3cDF0R3ptUnU5M0trVDQ4V2lw?=
 =?utf-8?B?cmQ0NVZDR1haZTlJaDVIenZWMTVFTE9DaTl0QjdsKzhuUXVIZTdKcEdHRitQ?=
 =?utf-8?B?NXFNR0NwbExRRHpIN2tJK3ltQWt1T2VzREtEYlgzMEY2dEUxOUNaMm5SanRF?=
 =?utf-8?B?ZnRhUGlVL210eGZOSXhHamYvVFRzS3gwbHRhL3FKR0FHNzBhUHNPc1dBcFdK?=
 =?utf-8?B?L08veVVNWG9GalY3ZjVwVS9QMllKNm16UXVNN3lZbXVia2ZLY2l4azlMVXRU?=
 =?utf-8?B?ZmpNTFZtdStmK0s4ZlpBU282d1l5WjZSRjVlaGs1dGZlblkwV0RLcjNHT21K?=
 =?utf-8?B?UWVQcUZNc1l0OXgyRFdhbmtRN3N0blhCMWF4dEdoL3o5MjFhbXRTODBnZ2pS?=
 =?utf-8?B?cWdkbVlvNjg4SFMxNGxuNnRpbENkN2h4Qnh0bXduOGJXMGZ2MnR3Rlc1Qm9G?=
 =?utf-8?B?Zkg3d1BpclZ5a3VVcnNsK2VrUnB1UlJNVjhUN2p3ZEI1ZnRQR0QwWGxPNnl1?=
 =?utf-8?B?dklsRnRteW9HKzhqM3M1dUp6WUZCUjVybG1PUkphdUEyMXFKM2RGYXVJdFJC?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e092196a-a73a-407d-a436-08daed14b016
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 22:57:13.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPSf7U70tSy+bPTJe2X0KYe7QvicS+WLtL8VzTTm+zRVcdOAu7PQXudZZTdrXHd5RAuU5EIA77nDpTTY8jeB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Alexandre Belloni,

On 1/2/23 16:21, Alexandre Belloni wrote:
> On 02/01/2023 11:47:11+0100, Ard Biesheuvel wrote:
>> On Tue, 27 Dec 2022 at 05:09, Shanker Donthineni<sdonthineni@nvidia.com>  wrote:
>>> The current implementation of rtc-efi is expecting all the 4
>>> time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
>>> firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
>>> specific implementations can choose to enable selective time
>>> services based on the RTC device capabilities.
>>>
>>> This patch does the following changes to provide GET/SET RTC
>>> services on platforms that do not support the WAKEUP feature.
>>>
>>> 1) Relax time services cap check when creating a platform device.
>>> 2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
>>> 3) Conditional alarm entries in '/proc/driver/rtc'.
>>>
>>> Signed-off-by: Shanker Donthineni<sdonthineni@nvidia.com>
>> Queued as a fix in efi/urgent, thanks.
> This rather seems like an rtc heavy patch and the subject line is
> misleading. This should be rtc: efi:
> Also, I'm pretty sure this doesn't qualify as an urgent fix.
> 

Thanks, I'll post v2 patch with your suggested subject.
