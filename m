Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C14B83C1
	for <lists+linux-efi@lfdr.de>; Wed, 16 Feb 2022 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiBPJMY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Feb 2022 04:12:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiBPJMY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Feb 2022 04:12:24 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70114.outbound.protection.outlook.com [40.107.7.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A420A2DAA6;
        Wed, 16 Feb 2022 01:12:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJc9v7h1jugrbCnrm57agS4lFeo3tbGkvXzdbkZh5R6vDCkUzmupJi+HBuzrz4m2VNsinOfIUxgdDjAsa7QzsaTsVUnpBS97dBC/ab25Kg6wa/PUMqtH8ZC1Pfi6SkJHH+8lM681QFdrJYWKbW9AXUS0JVFKk1UFtkm5PnGu3jPlzexK6NGIZT76TYECFUcyLwl5Tef362gDkv3om4fIY4yeQu1xaWk7iO6Y1WbTgJJxrunRGIgOuZKu/BpIpTZCVcYf+puFJYlrH2G396FgiLfXjaPGcFDIGOpHRqWQLnevU7/TlpjyMSTiAXNsCl0BzYu8lEat9tZc39nleyWiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBBrIARNwROdZr29RMGq8yRCx2v19kWFIsPhN293FxE=;
 b=HNaKn2pAfgKWxg9PPC3rTeL2nDrUxeUmgVgafv+bXpUAezDSspUz8VXoO76wbOlBp5ENwLv8GwP/VJiR58LQe3A9/AQBwNDhf0i6ydw5dpyoktT/aVJDW3UMscYXu1LGG2M8Jj42q6UnVfvz2IknhKCc1S6Sf/hL0Zbw4S55Q6tCMf7HxmcSEd2oTFkaKpyUiAWU0Z2cUdvLiUQGcDzjpSBYJyLVkMkTvxVJ1cvseTqcMDXIpiKb8EzGvnxIs3x9IOKh/KQIOAAdKDnUcRXs02tAQI7u1xxGIzX9omnnLv4XqtxZzOIO/9lBNLAHFYftV4XDv+pgrrui7B9kSxdMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBBrIARNwROdZr29RMGq8yRCx2v19kWFIsPhN293FxE=;
 b=i/PTKZsV8VbDLOAqOurbO6/CDvknIiRgMG90ws+ho8fI6rkx73SLzu+/KcW2QhP9CnhK+8eLiATeWXMGbdxvW0pZOfM2eB5xRASW9MU7rPrkfGaAntNGTiHmaO1t6iUXSzT0hr30wEyoWas3rXDEYOkFuIusBCmAc8FsrSf3LO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB8104.eurprd07.prod.outlook.com (2603:10a6:20b:373::6)
 by AM8PR07MB7393.eurprd07.prod.outlook.com (2603:10a6:20b:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6; Wed, 16 Feb
 2022 09:12:08 +0000
Received: from AS8PR07MB8104.eurprd07.prod.outlook.com
 ([fe80::903c:34b9:dbbf:c1b1]) by AS8PR07MB8104.eurprd07.prod.outlook.com
 ([fe80::903c:34b9:dbbf:c1b1%6]) with mapi id 15.20.4995.006; Wed, 16 Feb 2022
 09:12:08 +0000
Date:   Wed, 16 Feb 2022 10:11:59 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <Ygy/30uTImHrKT6p@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com>
 <489b76f9-fbaf-dae0-c90d-c52ee0de92a4@roeck-us.net>
 <YgvAO1UbZcbcj5na@localhost.localdomain>
 <be9cc279-1d62-3d57-9347-6cfaffc00cb4@roeck-us.net>
 <CAMj1kXGQhKuwdATd=SrhBFXZkKMHiFWsrq7m+AY-hFLM3Ltcyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGQhKuwdATd=SrhBFXZkKMHiFWsrq7m+AY-hFLM3Ltcyg@mail.gmail.com>
X-ClientProxiedBy: HE1PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::14) To AS8PR07MB8104.eurprd07.prod.outlook.com
 (2603:10a6:20b:373::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15bf4e8a-3b89-40c4-4933-08d9f12c682f
X-MS-TrafficTypeDiagnostic: AM8PR07MB7393:EE_
X-Microsoft-Antispam-PRVS: <AM8PR07MB73938F4BB7574B864E91BE8BEF359@AM8PR07MB7393.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1Xf/z64gFZXb7Smufd57ZjYsj7UWep1n/szPYbiqxMmncC0Ws01Oiq/0U48RlFBElV/YVU8SEJgLq+ZcZjfkYEYqswuK5Qb3nCyxYVEjVy3UFFKZ+3GqcoElwdZf0MITnWWhEIpfZbnC95X72lAg/a0dQpKF2zqbCdU2ZlPybCbmzHdOp7/4SoMVhuAq2K4gVGIrNpiIr1Uj4pic2f+raLRm3UoKJ6zxgxOlfsTmS1UVz1g9AiAVe5K8lj4emkKuebVTfHZ99n5ZXs9u1Wv2NVLMWUkHS7lCM3UI+hykmTN9wsBCKAcDhyvMoplFHmVMK1FtnhgJueUcqKphRGaGrrBC9SHrl5svXHA4by1SxMKxTnd7AfVtxnWJwF9SobImAdmCg7aygZWPsy5CtU22ZdV5xW9XJMQ7AH0ontkgRBne8M03RPbxpDAYEmnm6LR3AJ7zgTH58LcZuU/M7wKz9Qz57VakksPz/sekPeO8rrxHk1sN2CJZQGA88r06A0NYCM7RZhf4/6+dd0JTU8dAKdkjBktkUjzDtuqH0R4ZIoq4y2zvcgY1qkdwx1IHKD/B9owI1SGf8yT8qh0iPzH1dKl1FllVS6guKPfojy669r81jYOkWhIPBnikqJ8dDBplceYwZXuDqE8WZBJNUDov/iDQYG60Arv7jp1fXL706J1X4ozaMaycSTfnw4GTCew8SkiaAcH0twck+iw0IA+2LcJAsWuC86mNZ2Xnii8c2mFKq+U/Dv5vHGCOVqA8xR0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8104.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(7416002)(44832011)(8936002)(508600001)(9686003)(52116002)(66476007)(66556008)(4326008)(6512007)(8676002)(2906002)(66946007)(186003)(5660300002)(83380400001)(6486002)(316002)(6506007)(6666004)(82960400001)(86362001)(54906003)(6916009)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hSVzdiek5kcGN0TG85WEluU0F4QVZtcFh6aGN6RXErMkZyeEQ1TVhYRG5S?=
 =?utf-8?B?S3VWRTdhNkNrbzdMbVB6RUtobzZPV3ZYaEZHd2RwZkY1QnVKRlF4RFpPQWZ4?=
 =?utf-8?B?SmNZRHRuVzYrYnRHV3hKV0poSTZKZkhlUlN5ZHluUm9HTk9TRzR1SVlHTFVD?=
 =?utf-8?B?bE5CQ3RBemdFTUcvM2lDRFdOWTdPU0kzODNMQ2crR1FCcmcvTTNnMEJCOFF2?=
 =?utf-8?B?ZW1JOFg1VDR1Q1c5NEg0Q3d0WTVlOXg5SWlqY1c2S2VGNXZyanhIQzBJQ2Nj?=
 =?utf-8?B?Zy9IM1hNVXplTTlzRG45NU5rYVBhQVZkakM4ejc2dERYNkVxK1A2am9uRUdr?=
 =?utf-8?B?akY0S0FQU2s5eVFPWkhjWStEWjBGdVdEeWQybHU4Q2VJVFFlRDZXL0lFVmhW?=
 =?utf-8?B?WjFGaHNmalRNVjB6cEtQNC9kejJtWm5KUlNPSk9NU3p0eHF6Q2JoV3daUnZW?=
 =?utf-8?B?MTN0ZGg0Z1NFalVER3VVUnF0aHViUVNZYzdBc2IrL0J2QUErRmtkVzVPTHRE?=
 =?utf-8?B?Q1pkQWQ0Rzg5djBXOC9HS29YMDg4WFM0akdUUmZ5NW01dGtuQ3lBSkN6RURq?=
 =?utf-8?B?OHRjVGs4d0J5cHFUVWlBTUZacXk0S29JYmg2ZHBWRVk3MWhWN2VvODhrVUgr?=
 =?utf-8?B?NCtYcEVKUFBBc3B1UVphQUtzeGptbnhMU2tTUGRzYkR1UFFaMUdkbzJuWXVr?=
 =?utf-8?B?c20zVWtGSHJqVDRud3I5d0l2YVNNcks2dWM0dU5qNk50UVErWExRVTRGTXRG?=
 =?utf-8?B?ZDFDMXNvcnR0djZpWm01dXBaWk54RHJUN0ZndGl3ZXFsOVUzR0RaY09EdTF2?=
 =?utf-8?B?R1NyVnBaZ0NENlN0c1Q4YlprUEtZT0dGUUJ3aVoyOFJQNU5MRU5UOFlNeTUr?=
 =?utf-8?B?dm9IWXhubzZCR1dQZXIzZHZBUElFVVVkUTREb01IVnNBWXg5SG0xckNzM3lO?=
 =?utf-8?B?S2s0YzVveHlnR2duU0VuQ0lQODlDNDRNY2dYclRzSHR6WmltY01QREdEMWVo?=
 =?utf-8?B?THRWdHlXeHJUbnZMaG5DbEx0cm4wNitmamhTcjZmMXZTU1p4OHNCeENaNkkv?=
 =?utf-8?B?bGFuRTdaRGNsRFpiZWFvK05TVGxSVEtCSzZTS0JkRnZiSlY2VTh6Yklhc3l1?=
 =?utf-8?B?Rit0dmNVTlRibXlWUythVGs0TFNLQVlEWlpCMy9VL3JkcitaMFRSTC9SbXcw?=
 =?utf-8?B?OEsxSWNTSDI5TjQrQVlYZDE3cVk5NzE3VFFONU11NmVpYjFDOEdpcS9UY1dZ?=
 =?utf-8?B?dWUvR3hoNFYxSlN6WjNvdWFJcWhQb0ZsaFNiVjJkOTJqK2d1UjZPc1NrNXUy?=
 =?utf-8?B?NG1MeUJsSmZ0eWNiSXlCREM1SHBpcW9JTnhGTkJMbnN2U1VMN1BnTk5mUTdJ?=
 =?utf-8?B?bUJXWVlmbUNXUW1DNi9XenIyUUdRZlp6eWsvS041UU4rODhWanl3UHhXSXlT?=
 =?utf-8?B?MDZ6TlJwODhWclFiQ1ZZZnE0TW9NalYzOEZ3VHNTMjlvekFCTUMxZm9iaDZ0?=
 =?utf-8?B?SG9hcE1uZ1BBSEtnK0ZHUHlJcldvRG9vYXk0RDBJWjB4cTk4aDJKWTZhM2F1?=
 =?utf-8?B?YVc5dVZ0V1dtK0xTZnpGaHJDYmFMSElFRFNPL05vK0hqQ3hBMUx5aW1Lb1lx?=
 =?utf-8?B?WE8rWWdYZk1vT3BjYWF5YW10MmcvKzdRd1NpOW1nVWYzZ2FPNkx2eVlGTmJ6?=
 =?utf-8?B?Sjc5Tm5WYXhpTWhZcmFGME5CWExpOGl6VUtyaGhhZTJYajF0THNFL2o5RGQy?=
 =?utf-8?B?dXhCUkNaV0FrUkIzdWtkWUtJTUtUWks5c2dFdHk3cTVVamVkVDl6d1ZHRDRn?=
 =?utf-8?B?eENQRkNLNDhjdG1uSUZsMkdKdUx4UnBaeGo3YSt5WCtnSzlRZ3lEVEpJYlZz?=
 =?utf-8?B?NTJPZ3I4S3E4SlVNQ2FnRlMxbXJGdTdWWmlPRVdnUnd0REc4T2lLcmx5TFlU?=
 =?utf-8?B?TzhiNlcxUzhwOFpFVzRxaU5WVlorM05KcHprdE4xa1NaNFRPbS9BSWNkMVJT?=
 =?utf-8?B?YmI4NUpLeTg2NzU4eTFMNWZyVGI0T2Z6Q3RiNmFLOTJaaGhXdTJLWjN2a1gy?=
 =?utf-8?B?bnBDL21yMjRING40emx3UHdUNnp3bllsdnVoQmVyWm5sVzJOVDhIRk1keGdB?=
 =?utf-8?B?Yzd0STY2U2RZbFJNN2VXYm55NGFUT25CSmRwdTZCc1IwL09WWjhPUGNreHY4?=
 =?utf-8?B?N1FYUnJiYWtJWEgyK1BzUENVMGllcEdxZURKUzJkWUxmZ2JpYURTbm1kTVNL?=
 =?utf-8?B?WHNpSzluSk90azdjQ1p6RTV2cldRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bf4e8a-3b89-40c4-4933-08d9f12c682f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB8104.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:12:08.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnPRu8Kz2Ll2M4pqjuDk1nTz7TaQEXDzfeXq0JesLrIH6B4K5DjKZj0+mDjoyMcZhYwXQWmZXn+R+1biYWO/pHHEMzBjh6DhOYxS0u/bn44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7393
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dnia Tue, Feb 15, 2022 at 06:03:30PM +0100, Ard Biesheuvel napisał(a):
>> > But if we want to prevent registering some custom code to be run before > efi_reboot(), that new API would have to be rejected as well, for the
>> > same reason. So what is the point?
>> >
>>
>> Ah, yes, you are right. The emmc example does reset the emmc, after all,
>> which one could use as argument that it "violates" the EFI mandate.
>> Sorry, I guess you'll be stuck with out-of-tree code (and, realistically,
>> so is everyone using emmc in an arm64 based system with an EFI restart
>> handler which does not implement emmc reset). Actually, turns out that
>> the emmc restart handling code is not reliable anyway, since for example
>> x86 doesn't use/support the restart handler call chain, and neither
>> do several other architectures.
>>
>
>Rich firmware like EFI and ACPI implies that the firmware knows how to
>manage the hardware.
>

In an ideal world, probably yes. When I move there, I will probably have
less concerns :)

>
>> Other options for you might be to disable EFI restart handling in your
>> system (assuming that is possible), or to implement the necessary code
>> as part of the EFI restart handler, ie outside Linux, again if that is
>> possible.
>>
>
>Either implement EFI reset properly, or not at all. Adding code to the
>OS that forces it to reason about whether or not EFI reset can be
>called safely simply means that the EFI implementation is broken and
>should probably be avoided entirely.

That is black-and-white thinking. There are shades of gray, too :)

Imagine this sitation - you have a SoC and the vendor delivers this SoC
together with support and code for that SoC. You use it to build some
platform around that SoC but that platform is much more complicated than
the basic one. It is custom and specific to your needs. The vendor
provided firmware, together with the EFI implementation can handle
reseting the SoC without problems but you also have some additional
parts in your platform you would like to handle. Why, in such a case, I
should not use the existing EFI implementation and just build on top of
that? Avoiding using it entirely does not seem reasonable to me. It
might also not be possible as you might not know all the details to
reimplement it.

On PC/Server world, that approach might be feasible - the vendor knows
the usecase for their product well enough to support all the cases. But
ARM64 is being often used for other, so called "embedded", usecases.
People working in "embedded" often have unique needs and I do understand
that mainline kernel cannot support all of them. But when supporting
them is easy and does not require some ugly hacks to be added, why not?

For years we were implementing ways to overcome limitations in
hardware and vendor software implementations. restart_handler mechanism
is quite pretty example of that, one which isn't really hacky, does not
introduce maintainabity problems if widely used. Why not support it on
ARM64 as well? Only because in ideal world it wouldn't be needed? :)

I understand it should not be needed in EFI world and there are
approaches that could be used instead of that one, but they all seem
like taking a sledgehammer to crack a nut.

Krzysztof
