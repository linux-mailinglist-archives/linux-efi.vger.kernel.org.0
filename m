Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F65F3E2A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Oct 2022 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJDIWZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Oct 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJDIWX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Oct 2022 04:22:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9111BE9C;
        Tue,  4 Oct 2022 01:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXwvcpjo/NjIyMSMmu85wQoh0TLp6gu8j1yRhbJyGqoZZ0Wi0nzNBQv5ixcPO3HsweSnY7N2owI9hKFWnae3bcB3qHrK8FKPYLWaV7RdskYNDdxFctD+Yj0HBDQACYsxOH6XlJa9xD087e66e/8w5NW+uMmnByjm73q4PlaBCUjH0WhY/Nj2OYS1Ns5HvjxYrci3hny8ndKs8nqu4mOS5GAwr63VZA8lq9sDHW6Ze5dUhSrtTjg5hNjdLp3Bs/PMJqwLuDkacdDdWTsWmwytYr0UziQbX+nx6KDLu/dbnzoRWjjbc64dHprkYTaoaKCrvYO3UsXDp7ObhubHNIzpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXCEL2OOljVJd5th58mpGBa3qzLxxQW0isLk0zRsQpA=;
 b=j7sHQqyLGRHfHMMjRvpCz7atVWN66ydeyzqDAfUCNC+B46WxeHuYXwvjKXr9hwzjD63sfjvx/PxFfPBN4Xy9dFOKIvKerwlOdZ6cR/a9mUhw5KKyiActgirIbAezL2I+RQAz/hyrdErXgk0EmP7f8T1qxQBfykVBfbsDJ909a97e+2U8EM45zYWa0jBQec0hJVGk1dX7QpXoSzE9Rf74ogLWrraxr0VtKKkueKK/cI5M8FP8w/fzkXNbdPGiLLMc+9Dkrzc2LMXvBjNRxSUk/vQjo2SOll0JTAwEWMZCy6QRfFbF3vBneMM4LkCfkhNaTeYx3TAGXELuK4BYKixMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXCEL2OOljVJd5th58mpGBa3qzLxxQW0isLk0zRsQpA=;
 b=MAwJw9JzjUsQht4RVlnEK88GA91c1wppYpeocdHoVt9NlW3M9bACL4XFE2170oJ2H2wwTmqwlzAQT3Em7Q+vwq2KcqtfONHKUX5rxHWWSJO+FPSXBLlN/C8HHS3SNsuluvJzngZc3JQ+pRuGOOL0ii8vKdB8kRwMm3i5A2RIKkpQME4Rpm0Js4L+NE3a7WZbNLNNrvnDk9JltGbbFUi98Iy2xz3HGxP/3gtH0zFFoGIk7inpAIYfeaQKrwIQ9bppuYhWAHoCnGivW1fTOxRBUpK+MlDbQ69A+M3GJHi6gIvyNP7qFQ8a9nQk1PZs2+Uc7v0n7BsTI0QEnwcSYRwWKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Tue, 4 Oct
 2022 08:22:13 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 08:22:13 +0000
Message-ID: <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
Date:   Tue, 4 Oct 2022 10:22:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <YzeaKjmls1YI/3ox@itl-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::31) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DBBPR04MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: e0471394-7a2e-460a-9192-08daa5e18a1e
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEePcn+wdtoK0UYcVog9PB3sbwkkz6Epw650HHmmvKn9huBwRc2LBNz0c3ScDxzqL8u10OywxsjhssQk/vlOcNxVnA4eJ/Hxx6zz75Fq86Tq8Yu7/YqIsCNihVTlpttt1RZqmpo2KTV8sydbERwEB8/OKrliApqp2w1YsJy02vtIb3BScl8YjcFiRMwKcgzkFiQa1DRanxtsi+T02nruBdCE/12QcqwaPhWvD/83IlIN5MLnVDSOrzwzv4KzlUDUx2N0LBeKNhbMuLkDsyPu4IYBkCLtP5Acvq8kUMSLHJZRMLzvnViTgAoD8jUaXFyE/CyTdlI2OsMqqVURgiIzcwqGdJ0U/61SxjckFHuHnefEzcrg00LxMnRMxyWSVD7/xy5w/UtgAg77uNQVjrT/qLWw10RS4/p2pg8/if7fohoxDKHsRX4kC4NNH9uMWUSNvzd3BPv2dfzKyEHx+agBA2UGTKH/nE/x93pKP0KWPHYT8QOybjIm1PvvxtMdBnOPhL1XDjCwtA/ioM1Iu/DZ4rDXiioG5c3SD4TYqvHplraL5GtrvSxZZZKya2KrpaiXbIneZ6IQYK5kpzs9sUTpEyCS+pc0Mwt0v+ly2PCZF1S7SL2p6OhfGPMxsRCiLZIy08lp96J1maMPdOeNJqTbhlfC+gVcWnMlJS938yTJchzQVEn8k/yn2eEam4aALld4twVFImt99zMfsHFT+sLHIMSI35EGfQzRtKSmZuHBlo4TQPcvS9lCwVlDaKBhXcMthVJINBZcQmco8xen0hsx3LZfH/JioZa96uaH0Y8mwXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(186003)(38100700002)(31696002)(86362001)(31686004)(36756003)(26005)(2616005)(7416002)(2906002)(53546011)(6486002)(6512007)(6506007)(478600001)(6916009)(5660300002)(316002)(8676002)(41300700001)(8936002)(66946007)(66476007)(4326008)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjUzTkxXOUlMcUdtZzdtdHF3a3Y1eTdRR1RHeXRpQ1NWbXNZZXJyY2FmekMy?=
 =?utf-8?B?S2RSTW0rcnpINzRxR28zRE5LOXBFdG85cXdOaXRoUjl5RUVYYkJjNFZGM3hK?=
 =?utf-8?B?Tmp3QzZHYkRGdmMrUDlOUnBhaFFXVldGVE85cWhrZXdzb3RkZUhGWG5PU1RJ?=
 =?utf-8?B?clN5RUlyeElLVFJTYUd5S2ozamJlM3Y1MkZ0OEh2NlV5SzRIVjQ4UnJtV0lH?=
 =?utf-8?B?SDhYZFRPRUIrVW0wRFFFNVhNQ2NUVUJ1Tk1pSWt3RzlzazFqZ2h4MXVlajRU?=
 =?utf-8?B?NUxEd3hCMlRFeVFZNldBdVE3K25reXdqUzBFZzQ4eTRYWE9WUWV6R2E2WnB5?=
 =?utf-8?B?b3NoNlZsSUE4Nmh5S2tCNDZRVVIxWHlnanJ6WUVrak1hMEx6cERBRzU0NTZT?=
 =?utf-8?B?a0N0cWo2Y1FKaWNCRGlMbncraS9rTFNJS09FUWMyWE9xajA3ODk4aE9ibjl1?=
 =?utf-8?B?cndtbFhvemtMYVEwQlFPa29UOUQxSUZqcHVIUDRORjBLL1lzdGt1SCs4QStt?=
 =?utf-8?B?Y2RNejlQWXVFV0pjSmtWamNQc0VXM01tY2pzdHo5aGsxWnl1RFBseHVGVWRy?=
 =?utf-8?B?ZHBRbExDOTIyNExxeVZjZGUrVUh3Rkd2ZFUxMFdsa1YxTC80LzUzdUdSaEhs?=
 =?utf-8?B?TGY5YURrODNrZWJ1c0NNWEhhVVhzZmdkaEt6dnI5aHQwUWxQQXBDQnAxVFZy?=
 =?utf-8?B?Y0pMdWhFVVNEYlJONllRTGFpY0R5WWlpNTQyYmNzeTUrcWpiSm5PYms0QVlC?=
 =?utf-8?B?bHgxQUo4QmpNL1ZONUl0NHpaRzA0TjBFMCtpVkpVTlRZK3l3bURSNVVoNzhj?=
 =?utf-8?B?dittbmhxbHJsZnVPaGRGeVF3Sy9IZ0Q4WE5rZHdwMW5mSFNJQk1TYm53WXVy?=
 =?utf-8?B?MHRzVm9KWWEzYVZsSENJWWcrbitUSkFDQVhtYXA0WHZpZ3NHMjFnaG5RT1RP?=
 =?utf-8?B?d1k0bGxwTk5DbTlrVUNySS8vRkVvalQwdW5vdzZ0aE9RUHVvS0NoVmVOMmZz?=
 =?utf-8?B?UzVtYlB5T1ExM1NMSUZpNi9LUXpEQjR6OWxVL20vSkRna3U1SFBINnBwVm1L?=
 =?utf-8?B?V2kybXlLVi9pNTJRdkYvaFMydDE2dG5CR0VTTlVHblhpbjdqa2VRQmY3MHFk?=
 =?utf-8?B?QWlpblU1bE1sTkVBekZUM255K0doYlYvejN3M2ZSeEphbjlqYXE0VTVCZ3NI?=
 =?utf-8?B?THpublIzSW1uQmNZVXlvdUNZUW9scWFKeVp4NHNuVEgzYmpHdlE3VC9OZ2ts?=
 =?utf-8?B?d1doSDBtejNxZHg1ckdNUkhJekFUanZKRTltaFJqa1VLWUlVbCtwZy9QMTI4?=
 =?utf-8?B?OVQ2Z0ZNaFUyZkdjTjBiSGQ5T0xRM1AyVnhQUm9kLzZFdkhNSmhuK0xBL25a?=
 =?utf-8?B?Zkk0UEk4RDdIR1RKRUZLbFFGRHdSbjFlbmhBVkh6L3pHRlNmdnQrRy9ibEUv?=
 =?utf-8?B?dkhxTzBtQWxYYzc0SXVrbnJnRnZDRGx4OUlaZGw2cTdtWTZxWGZKOEhua2tt?=
 =?utf-8?B?VnEwSlNibzloQTRMVnJuYVVkUGtDdVkxSGhKaU1MWndaNjRvYmVDeEhmQXpr?=
 =?utf-8?B?bmhqa1Ztb013VjM0UjVkb1IvQ3k2QnVoTy9tSTErN0NkcXd3YnQwK3pwMTJJ?=
 =?utf-8?B?T3NZaWtSb1lRV1dCaGVtdVhNUlQyVVY2cG91U1dzWHc5eENJWHk3bi8wQ2xL?=
 =?utf-8?B?d2g2V1VoZXp4RUVMNVF5MC80aFJHZmlUUkNmdzVzclp6dkhIa0pXekYwZ0Fw?=
 =?utf-8?B?TTdQZUdFclFhblFZb3dVWFJQajR1bkhmMXlFbHhKZ0pQRjRlcDRLMFNOVytm?=
 =?utf-8?B?MzMrcDY0WmRVRjYvT3owRGlWZGZoMzFpNUdZM3JqUlpDUHNqSm5wa3daOHFk?=
 =?utf-8?B?NnhBNnJEdStIR1dOMy9CUGN1blJEakViL3JsVElCRnVkYVpSNFZNajVCWHBs?=
 =?utf-8?B?TTFIWC9ENFJlNHVBS3JaaE8xSG5zQ0tqVkFPeUpkS1U3d3pSaDN4dzBQaEla?=
 =?utf-8?B?UzhLNUhSQ1poL3lheEFNamF1K3NHVmszdnprU1IrQnRnaUtOc0Q4by9TTTZp?=
 =?utf-8?B?TGxlcmVwMEhOc25HOGZtZTIyZ01lZTNmRjI0ay9lVnp0bklVUVZ5bG1HSFhI?=
 =?utf-8?Q?cSV8KjNPpxbLKjy4eM80r3Mgx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0471394-7a2e-460a-9192-08daa5e18a1e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 08:22:13.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUay21qJ0+s9DOLP4PFCWY3lK7HuzTPKi0e64xdRlmo77t8C8EGJWuTITIGNB7r/wXN1lraVFNTVT4PU3zERtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 01.10.2022 02:30, Demi Marie Obenour wrote:
> On Fri, Sep 30, 2022 at 08:27:09PM +0200, Ard Biesheuvel wrote:
>> On Fri, 30 Sept 2022 at 19:12, Demi Marie Obenour wrote:
>>> On Fri, Sep 30, 2022 at 06:30:57PM +0200, Ard Biesheuvel wrote:
>>>> I know very little about Xen, but based on the context you provided in
>>>> this thread, I'd say that the best approach from the Xen side is to
>>>> convert all EfiBootServicesData regions that have configuration tables
>>>> pointing into them into EfiAcpiReclaimMemory.
>>>
>>> Should Xen convert the entire region, or should it try to reserve only
>>> the memory it needs?  The latter would require it to parse the
>>> configuration tables.  Is there a list of configuration tables that can
>>> legitimately be in EfiBootServicesData regions?
>>>
>>
>> Not really, no. So you would have to convert the entire region
>> /unless/ Xen knows the GUID, and therefore knows how to derive the
>> size of the table, allowing it to reserve memory more conservatively.
>> However, I doubt whether this is worth it: splitting entries implies
>> rewriting the memory map, which is a thing I'd rather avoid if I were
>> in your shoes.
> 
> I actually wonder if Xen needs to reserve *all* of EfiBootServicesData.
> The reason is that some (probably buggy) firmware may store ACPI tables
> there, and Xen does not have an ACPI implementation.

We already have the -mapbs option as a workaround in such situations.

>  From my
> perspective, a much safer approach would be to pass all of
> EfiBootServicesData memory directly to dom0, and have dom0 give Xen back
> what it doesn’t wind up using.  That allows dom0’s memory reservation
> code to work properly, which it currently does not.

As said already on a different thread: Giving memory to domains (incl
Dom0) isn't related to their original memory type (neither EFI's nor
E820's); the needed memory is taken from the general page allocator
(with one exception for initrd, to avoid unnecessary copying around of
data). Hence what you propose would end up as an (imo) awful hack in
Xen. I also don't see how this relates to "dom0’s memory reservation
code", but I'm sure you can clarify that for me.

Jan
