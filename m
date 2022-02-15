Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774644B6661
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 09:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiBOIoh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 03:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiBOIog (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 03:44:36 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10114.outbound.protection.outlook.com [40.107.1.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6D111F8F;
        Tue, 15 Feb 2022 00:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCuqu1pOLCzMzpJxgYVlij+4K/U/ptD7OVvXxAbfia1i6vVnJUOa0w5jaug2fyvb8SC9t3K2mRgmTf2qMUCP+oHSco18fwbDw4+lR1aHZxzuJv6u0D5jvXKJ0MpgyGN7LDAPSIcnf55EPurQ4vOhGOJrZGZnK02tAl0fdkh2YFdwlrs6A8miW1eq+ZOepmANxsQoVSjq3ih2+ZPi+Sb1V85ZqgymHQIlZLxD/gWwPV+INoGtcPfE7FC+kiC4pBYDvOSXHkH4/0oOfEI1tCBCmDTJBf9iBHiUK5AdddDEi+TIl/3mDqpuunYOTHt6bZlezhMcXwaf1emV6cVRwDziuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJN8xTnF7vQABK4Mq5ieIx4DJqVzov7PNg0/kXW3Uok=;
 b=Q640a9quanF8PIHaTG3GyHxGzovVP6Y0luK5i2n9ZqGQip50LOYh5yfLLhK+Pmo+laOwihCnrKWKcIUPw2NXibqBlcvuiKep1b7l6ypmIvh6BmdtQaU8CCNLR1Ft/ygw/55/fDylh56fjkFEuWe3Xs+od1xtx8ZHWMSbFe+iSftWmC2GZXRXcmrUp2hqdJXsRp1C4LV3eImgwaQgqnRRyXqjnRZsDo/aR/jG8NKEA6nCosAK+ASw8jJWQNDJIZT7QGLuOMPjX2x5y3Q9kwEhmgZyTef3/FlrNQ+Fojfatv/3DKVRmzP/R0T0a/s2zMDJs5mfAmKRaTulmiOlwNQZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJN8xTnF7vQABK4Mq5ieIx4DJqVzov7PNg0/kXW3Uok=;
 b=idoWlprRgjOkyWfTbyNxlOE3KhrLZoMtADN17cssknRSVnmFHURlRAonwqHTeHo+zuZbJJRSINt8gwYP8FpP17J00nw3E1EX0tQwl+hZDKg9frJq4NTZ9ctD+O0l0F2ZIV8i6GARlnRtZyTUZ29+AJG5+czZbEDennYgEXeZ0SM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM6PR07MB5091.eurprd07.prod.outlook.com (2603:10a6:20b:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 08:44:23 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c27:bca0:d64:d78b]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c27:bca0:d64:d78b%6]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 08:44:23 +0000
Message-ID: <ca5582ac-2a86-a867-7e57-5e3e103778f2@nokia.com>
Date:   Tue, 15 Feb 2022 09:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        linux-efi@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N> <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N> <Yfp7wZXLKPIYBxmp@localhost.localdomain>
 <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aced20ba-28b2-44ff-4ca7-08d9f05f5dc6
X-MS-TrafficTypeDiagnostic: AM6PR07MB5091:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB5091E267E091EE4A042282D488349@AM6PR07MB5091.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAcq5QhvnLhZv1Li0Z/0brwNROjvATMBlQk/GjXdD9QEEPPQ93lCK/02RDWE75EYqRur3w+rIsr5fEEdLPsczEbR+vDZD0wGEU2utRESqJzMFu1uRetS0lmrnkUtuH/tUOZWv07NiDhui1z50U/xXpQCNG3+ikkFqcC3TGFw4yU3Lryv+C3vjHkq0mJZ11Pt0TVExbUDIXxocopl49/MUWM8CGbaKPrdF0mvJqv1JPBUQjS5Lbt4yELlzhOKoapJndrJ+6S6xWbPn0fOhMx6E50WvlebTHmlIpjX3gfH9vIcZfhW57MfF2qtoL5o2YRdNnsnE20qxQR0mK3C6sJwCIzlz2YFTGgIDXMAkcTIjlfdM3Xli8+3NOuvj+vX37hdKFtLtx6xeJZQ2s41464rhVxhbHxz2gwB58IX8v2xQnKXayCUu+mTaAAJumkKK+00gLcs1sy2yJivna4MxUokupKxCN8B0kPI6OZlZpdDAUxL6ERmpYoD+K2NzGTCqasut1gmPUPr9lXEH8pydELORj01I9voKrZ/dq42BSVSMDwgwT+yvHGxUmQr6b7+tkynyGtTNk0uOUnMiKNRvkWgIlrM0eK4yV9btxtliI0lQvz+z2U2b4zXjnupmcQHq3o/JhRv/DR1EGX5EnCX9BRKhfoYBTmDsu3/AH3H5W2JUhS/UgM+09eCLzLOAZaygzd+pKR4Rj0Xicrcyp307eB0lD0ZQx323to8PKSTj+Z82JoEzEwLhsCeU7ymMd1EPzBpS61eKfBioPJzLACEatH+cXBmMcgZsdbtNIrIWSfUpkTsCrJb1ikNrABhP5sbFxe8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(36756003)(6512007)(6666004)(6506007)(6486002)(31686004)(53546011)(52116002)(38100700002)(38350700002)(31696002)(508600001)(5660300002)(110136005)(54906003)(2616005)(44832011)(7416002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(186003)(83380400001)(8676002)(26005)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJvaDV6NVZBOEo3YkdqTDlSUjhOdXQyRTZLK1A5bHJrVFdhelVvMmR4RGMy?=
 =?utf-8?B?aHIzbkZGN2RGRllGRDBlVW5jbnZTamFZK0t4Z0ViL29ZTVFoeTlrN2JTU2hC?=
 =?utf-8?B?RkRxZ2h6aWsvME9TRmVXU1B2WDVhVm9wdVEwTE92V3dJeTNlMHRtY1JRczZq?=
 =?utf-8?B?V0lTNnVzSjZZbnNhUEVxV25Pemk2ZTdlOVZldmsxdjZadWg3WWpyQVJHTlRH?=
 =?utf-8?B?VHdXczNheXBBcmZaNlRNRTVqNTVKZ05WOTVjd1ZPZmx6SGJKTGZlUUh2c2pr?=
 =?utf-8?B?b2k5WllCY0U4anI2ckc4QnRlekNxekMxbjh4NmdpM0x4QlFmMTBXMFRqekNK?=
 =?utf-8?B?enZ5MER4Z1d1WUsxRHhWSG92TGZ3SXk5VmxFaFVHSGRiL1NraUV3TWhOdHBM?=
 =?utf-8?B?RFMyTW1qMVB0N3ZKaUdYK3EwaEdGdFZBMWhTOGN6N1lZdWE4M01kNVRGRGRw?=
 =?utf-8?B?SmxxT3kvNk4ySWJhajdqQUlENUhnc1BzTE5kRWtQZUNad0YzWlJYUC9pcUFx?=
 =?utf-8?B?OE0rMHJmdEJST2FtTW0ycUJiNkw1ZW9pZ0lYbVlPNzJHS1BmTHJIUURiNjZO?=
 =?utf-8?B?K1U2enIvUWxzK0JPNFl6TFVSWkozWmVPWkYxYXI3emhRc3lkdWc1eXNSYm8r?=
 =?utf-8?B?SWFFUFRtK0R2WmMrUldsOUZVS3NFbVd1WStYRDVqQXU2V0RaaExWQ1g1TktU?=
 =?utf-8?B?SzRDOTdjblRvRWlRNmpiWmttV1hNUHdZV1h6WUJ1bTdGd1BqbTBkR2dsRW9I?=
 =?utf-8?B?dnZGYXBjUXBuM1IzNjAwaEl2eEsrckFPTmcyUERDN2RCM1FCSkdHYk40QUhJ?=
 =?utf-8?B?YlpoUUZBUGhRcnFBWW5ldEVZN3I4bFQ4bEMrQ2hzc0hnWkRkNGJwaHNOdGpJ?=
 =?utf-8?B?RUlIdGRrd21FN2xuUEl1Vm1CY2ZuT2JoR3pwTnA4bGo5MnpIMU9pZEZlRE1E?=
 =?utf-8?B?aTBHZC8wWkN2THh5VWp4cDJuSXA0SjRHRzZpemYrZkNxeVJYZ3B3QnRnMmhx?=
 =?utf-8?B?MnJxN3pGL3RBeEoycFFNdEFRc1Fld2FUejkzdXNObzVjT2l6S0M1M2hHZmw4?=
 =?utf-8?B?aEV5Rk1kbDF1WlpwTjRzYW9UY1VXbE1YbGtpNU9ORFYvUldsMytWRXBmeTFC?=
 =?utf-8?B?WXI2NDhqRlp4Um1DODdJN21kdlZHVFM3b2xVdDZqZnExaWhXNTVONXVzbzVU?=
 =?utf-8?B?ZGhoKzlkVnlqMmN3YlRBVUZHODgwN05IbFo1cFY2SWFVMlo3SjZqNWt6YzlQ?=
 =?utf-8?B?MlE1RzFWeEZ5WDZ4Y3A2Y0E1a05MSWM1NVd4aVlUYmQydlE5WkpJbStLMXdt?=
 =?utf-8?B?VzZNU3dQaUdxT2ViSjJoUVcyRHpzT282cDl6N25EUFY4M3pCcDB4QUI4K2hJ?=
 =?utf-8?B?Y2QvQkZra3k0U25lc2twQWgxRDllejVFalUwdkppR2NGTXIxN0VrTTUyaGNk?=
 =?utf-8?B?amtIdnJCeHNhbnlxa1h4N3BWRHJOTSt0cWFtNExRYjNQcTBpb1ZyRlk3eFRx?=
 =?utf-8?B?d0dBTk5KQUVVbzUzWW85L3NwaktWZ1BETVBRUlJDenVoNDRDc096Q0J3MU5S?=
 =?utf-8?B?VUNZTFhNbXZPQnQwSHJkN1dVMXE2K0drVjFzRzlCa0VxKzl5ZE5TS2JJUEho?=
 =?utf-8?B?aDF6MlNpc3dmU1d2WDdKRnJ1VWF4SUlhVzJoZXdEYlkyUy9TVlc2NHJZWkFl?=
 =?utf-8?B?ck96NEVTK2lsMDk0ZHRRQ1RrcjZEWURISy9obUdnV3dnT3FvZVFZYUxVTjhr?=
 =?utf-8?B?QmNoNzFPMTBtOTVFa0dCMDh4VGE3UU12SjJKZXNjejBmWkRXWENZQk9HSjFD?=
 =?utf-8?B?NkIxS2hwZU91TllmeVpSODFMV0gxeTZJMHpTNHozMjVaVC82R21KTEkzK2VT?=
 =?utf-8?B?MTloQ3BXMk5MQjBUWVlKNWVmVVdwWVBuU3hsU2lpZ2psWEZyUTQvRjd2M0JF?=
 =?utf-8?B?MFAxc2tNb1JJTnBCb3Q0L2NydkhYQUtrVDc2dzJqQXhzcTh2V2plTVQ0ME5F?=
 =?utf-8?B?T3Y3VGszT2p5enhsN3lBNUlzRnpJb05QMFFWcEhyK01BaldrUHpnMWFXOTMr?=
 =?utf-8?B?QmkxYmYrbGt3QnlqenhjSTIyT1RnQ3FzSUJvMW9pNUZzUFlsb1M4VWpaNWQ4?=
 =?utf-8?B?REFZQ1g4YzZTeDQ1WUFJM0NxR2xWK3Z1ZTkydkJyN1ZYTkR2YXlCMld3S3RI?=
 =?utf-8?B?c2FBTC9zYk5haDZnLzJZUVo3SlhaSCtBeHpaazdpYlNqV3Z0MHlqRlhKeXpv?=
 =?utf-8?B?dlhBTGJuQ0wxRzZ3T0VjVnlsdjh3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aced20ba-28b2-44ff-4ca7-08d9f05f5dc6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:44:23.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4QuFQgqS4+h8BemLvaSaXEBCBb+bfIWUxLI9+UPdAyL7NZaTcG3QJprdEFiyO9Z6XACzSb74mNTTv6QYgBZweOaWJJaFQp3YfCIoWg5RrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5091
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard, Mark,

On 02/02/2022 15:01, Ard Biesheuvel wrote:
>>>> In other words, I would like to be able to run a restart handler on EFI
>>>> based ARM64 systems, just like I can on other systems, just for its
>>>> "side effects", not to do the actual reboot. Current code disables this
>>>> possibility on an ARM64 EFI system.
>>>
>>> It sounds like two things are being conflated here:
>>>
>>> 1) A *notification* that a restart will subsequently occur.
>>> 2) A *request* to initiate a restart.
>>>
>>> IIUC (1) is supposed to be handled by the existing reboot notifier mechanism
>>> (see the reboot_notifier_list) which *is* invoked prior to the EFI reboot
>>> today.
>>>
>>> IMO, using restart handlers as notifiers is an abuse of the interface, and
>>> that's the fundamental problem.
>>>
>>> What am I missing?
>>
>> You are completly right. It is possible that I would like to be able to
>> *abuse* the restart handlers as notifier. You are right that we have a
>> reboot_notifier but it is not good enough for my usecase - it is only
>> called, well, on reboot. It is not called in case of emergency_restart()
>> so in case of a panic, this won't happen. It also is called much earlier
>> than restart handlers which also makes a difference in some cases. So I
>> see no other choice than to abuse the restart_handler mechanism for that.
>>
> 
> Why would such a platform implement ResetSystem() in the first place
> if it cannot be used?
> 
> So the right solution here is for the firmware to publish a
> EFI_RT_PROPERTIES_TABLE that describes ResetSystem() as unsupported,
> and Linux will happily disregard it and try something else.

Let me outline the use case once again:

we have cases where different SoCs are integrated into more complicated
FPGA based systems where FPGA controls the reset sequence of the whole
system. Those SoCs are of different ARCHs and only one of them currently
has EFI.

So the implementation is largely platform-independent and is implemented
in Linux.

Do you suggest that in EFI case we cannot implement a conditional
reset implementation (native EFI reset vs system-wide FPGA-controlled)
in Linux any longer (because register_restart_handler() doesn't work
for EFI based ARM64 system) and need to reimplement very special
solution in EFI? 

-- 
Best regards,
Alexander Sverdlin.
