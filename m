Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B8679EAA
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jan 2023 17:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjAXQa7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Jan 2023 11:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAXQa6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Jan 2023 11:30:58 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779CE11EA1;
        Tue, 24 Jan 2023 08:30:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfIh6JNpiUm0Puxa1OFBkpxr49M/+uX5wd6fDzyjApSO06Y47ua9ci2g3csuT8tb8ks9H4jNT5c+doN8vvNgcR+gZQA1WoJguviMPbPajXLw0615MDuKAkp+fXyAd6FrdgPG8jpoNEFVWacXWES8G1dawqrdA4JtYVBs6LS46SXoHr/Ag4fdWsUEM08Ug3I+ma82rwiumiKso1Gx58YJCXfQRMZsG19UeanMKBuFRddzY32QLRpOkRawf7HY0B+VVWaJO8TInNp+aWlM3PuyR7Ww35JoFItqOqOFJZZH26YYzc8LkAZN72zIb2+0t/vjVmVGF2dE17xtYxaymyn+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UgTGLBhEQVscQNBG4YCWvYiYDlgp001c0bxw//T5Y0=;
 b=K3S/DqbqDCDZ5MUEOTqQd46T2NqUcvrNcO2Aiuj0jIJIY6eBu9Y4V8SgEyPRj52AX/Nmj1AlXMSQKWOfzU8UgSfxMggQ3jTF8AOXv5doSmrHgxx5Mr9aPerQ1f5l4bxXesqBt55+AYCe4AleqCPTSwkgWq7Hv1e/se3J/o9Zy2NbnXmsnzEEZPTpG4SCNWXv4XKlTpFsBEwP38iZJ1QqSsOBwlif+fDvQMXfGYVbgnmcdHyOhm4YX1jwOa335ZVQ12x1Zmu0dh8DdG2TTGUHLNCjM36NfaJts+RN5jFI2jlcgptgigsMX9IcZfq4TG/2XOHDpRccoYc39LjDErqOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UgTGLBhEQVscQNBG4YCWvYiYDlgp001c0bxw//T5Y0=;
 b=iHsIiIZ3Os0ujjdYYltFsxpnBxGS2S+Bu3qE7XgI8BJmHbNb0eEA7i+f4ayy+7bNhihVRLLQXPW9BmzBIQ+T3p7LuHwyz4Vh3PCYu4IcgFSaOJjDi47XnQzpjlg6rIGFa8Uz2Cbxo+ghavZOd4vO0fyYR6J0Xy9sZSOtRxsBZjpFt+NfV2Mwv3+x+KsCxqKw6Uc3eSXJpGC107KyhUgBzwzjaiWgOH3zJxmi3dmK+FRu8fzHzWJ3Y6QJo0npMUiErSq0ujvv6c/XkD7iDmaabFpSLVLEb8i7T8bA/1AhZDTJKvyUSMbskkN46hEuuH3vBKLxOGhIf8XLvZeeyw68PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU2PR03MB9999.eurprd03.prod.outlook.com (2603:10a6:10:490::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:30:54 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166%2]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:30:54 +0000
Message-ID: <5cc63796-fd46-98d6-fd01-54a8281cf995@seco.com>
Date:   Tue, 24 Jan 2023 11:30:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/8] generic command line v5
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     xe-linux-external@cisco.com, linux-efi@vger.kernel.org
References: <20220929023301.3344694-1-danielwa@cisco.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU2PR03MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9b0c36-b9fc-4457-fae2-08dafe285d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Hxp6HmeF/ueRYPWUFjY/p9TAhlgUzb5DzMUFrynG7B7LDdgyEGSYlv8T2QY99/2/CARY6nFFBZC7ga32Q3+JNSovFqYjpuy7G9gG7Gogkr4ymt9ujES94QJCU5lbKdbiZzwOhHfN6xuwpHGaBulXMEV8gpfPLViiVNRONK+pzEUtvPe7g4aW3tVzSLa0mUNMYS/Jb+K95/XOS/F7AtFshDKK/Ad44QeJhtnQghNqiMGEwLNmDVmBk8SZsSgDRyJGm6CWYCTzg+UhbhqTHzffc3XT3rL5i2L2f7VBFrvbn45LALbseKEROqrxohgtFrdgzH6sxeJPaaDJXAjVfJD6vGiDTCBSFxZwx3KgPQ6WRL3wonAlIJ1xGj+usm9t17Sy69Xq38TfbTM8ZVBFOA0MpTA30AX1aZFI5IG55Q7gIFyIRoaHTrX4oIptMzNWoLX8mMx/HiDrprtIN8oLEQFK3HeF/iYhg5eyFf8s6JQD2zkPwNasACTZzGcJLNjKJSjiE6uc2LLR0LTBjg9ytGVrX0mnSzHVa6EvXf7+MYrUM4jSZZzobFYkIVWMa29jtR5RXCIqdRwOA5KdQ0ECqXFQR3tkKDJPThyCzWFZ1OWYCNRtv76aTFTcRtlqeU4nxI8My3EZytrGOWMjFFXUFhciirKNA5g/4lBGM5B0cwVlFV07AXVwQ7nesUI8c/DmFPgUAXvF6KxsRoFg44NFHjxlUlMa8AfrRMB/36ICZojGlT91Y2sLMBBlaJhRoacClr/co5VsfqltAqrJN1k+GwxgJuddR3RurkZIOAPlg8/3S0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199015)(31686004)(31696002)(316002)(110136005)(478600001)(52116002)(36756003)(86362001)(2616005)(38100700002)(921005)(38350700002)(83380400001)(26005)(186003)(53546011)(6512007)(5660300002)(2906002)(6666004)(44832011)(6486002)(6506007)(41300700001)(7416002)(66476007)(8936002)(8676002)(66946007)(66556008)(4326008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpTVEhNd1ZrK0xrdnJRWHdsMVM4M1A4MVhWYVk3VE9uVUNxNytMS2ZTSGJl?=
 =?utf-8?B?NjRXWEVsLytYMnYzK3dZQUhqZnZPTUhoZm54bFlzeGhWUjVWa0tPQmoyMDZ5?=
 =?utf-8?B?aG9xT004NnZkUjZFR1p6NzRmL1Q4UVFGTGZvSTZlN0NMUU9WR0t0ZXJ0amRG?=
 =?utf-8?B?K3NWKzdISmRXaDFHYTlvai8xWUlFOHlxREFibTNSSWE5THIrUGdpOGVxYlpJ?=
 =?utf-8?B?amtEY3RCaEhpNE5TdjFIelQ1YjBEaHBLTlJtTkJoZVI5aWJRelA4TkZtL2cz?=
 =?utf-8?B?b1lGQmhYNTF6eitHc2ZFalQ0YU1NV3Fpejc0OExQUms1N2RucWplUHVLOWg3?=
 =?utf-8?B?TnRnODYrN3hFMjQ0T1FlOU5OUkVhQjZFcDBlRG9ITXpTamZZT3BtY2Y0M0J3?=
 =?utf-8?B?S2Z0VGFxSEJ5NHVCSFZFZllXNHJmVTEvc1ZCN0hMZzdoZ3BQcFF2N0NqT0tt?=
 =?utf-8?B?N0VsOGFkclhGR3hLdDZCMjRJYzh5ZGpmaC9pRHpEajAzOEV0Q0RsRHhab2hB?=
 =?utf-8?B?cjk2Zm9nOEc5a3dwQ1llaE9JbU05ZWwyOVV6anBWUTcrY3RESGpxWkhhNDJp?=
 =?utf-8?B?NklWaVkzUldxbWxDVkFiZ3RoY3hpSThQUklnYzlYS00wUlB1WmVrbEpzcXg2?=
 =?utf-8?B?Y2lIYjF2NFRlWW1xWVQ4b082QmRqeVJIMXR4K1NGWHF6aGM2RjlqR2xHWFU3?=
 =?utf-8?B?WFpSL0x0WmtoZmQ4Q09xR1RGMzdzRDU3dTgxalRkVnFQZHNuaXhpdDc5RkpE?=
 =?utf-8?B?ZHBscmFzOFNtaFJsWWdOMFh5cWZSVURKdXpVNFFKbGQzczNGUlA4UWhPb1VB?=
 =?utf-8?B?RzRTNWVCTitpZzBOZktMa3l6a0wzTkNVejZVcUd2L0plTGZBdGNsNE9ubGxj?=
 =?utf-8?B?WktIY1A5UENtYThKL3BvUDFuYU1SVjRsSFUvV0xrcUk0ZG94VHBVeThCZmJt?=
 =?utf-8?B?aFNGK3lEWjc0NkhVc21FQUQ1UGk2Y3ltSnFyTzdDVmk0V3RCL1dLVTVWeVFE?=
 =?utf-8?B?clVkTk82VHV1eDVrMDJ2SWRodXpEZ1ZyT0hRaEpPS0lvMHYwU1Mxem5iZlpW?=
 =?utf-8?B?a0I2bGt1dG1lSkIwNFN2c1NPL2RJTC8zaUVTeFE0OGt2TVlBVmpodk9HSmxo?=
 =?utf-8?B?VFV4NlU0aWdvMmFsMG9DV3dGN1l1VGx4Tnc4blMxa1Z2WGt4UUM0dVUySVJ1?=
 =?utf-8?B?MjArNXFCbHJGejRPSE40N3FvOFk4T1poN25EcFdQbFB2bFVLdWFnWUVXazdO?=
 =?utf-8?B?dGxRWVRDSDBXN3BZWUhHVFpldVRPd29SZFFsZ3ZZaXYzOEdJcmdwdjJFMnFm?=
 =?utf-8?B?QVJzRVVVSG5TN2NwQkw3VG9YNTBkaFhBTWMwUi9HeTJMZFdHajkvc1pCdmd5?=
 =?utf-8?B?a3k4OVlleHpObWs0cHNqaWRaN0JZT05UaGNoZkk1d004azFuZUVvMjlLdVo1?=
 =?utf-8?B?akJCakRMc0E3TkMwVmNqcEFzUmorWDhMYWV4TEcvZjFheVlGdmRvaTEwNUxE?=
 =?utf-8?B?eDNNL1JHemdoKzRWWTVnZ0dnaFE2enRzZW5PQklOcFZlblhJWVFyV2xVK3pC?=
 =?utf-8?B?SW90WWZjVHRDQ0hwZXhLSENOUFNTNkxSY3JKVC93OXQyT09ubkVpWm9GYnpK?=
 =?utf-8?B?Ny9uMEplV05RQlk3b3VRMGExZGlwVTZERjJydXZBUFNUSzBoQy90QURQQjM3?=
 =?utf-8?B?NDhMUWlXd1R6KzZGcmIzREhiWW5YODZKTXNpeGQwWnBJTC9pTVRmY294MnQ3?=
 =?utf-8?B?UWtFNjdWZTZRZ0p2UHZzSis5eHFWQm9oRDc2TFZYVkhMdm5HbnQ5YmtzdW5h?=
 =?utf-8?B?TUpiQ1hOc091ZU45QnBOVkI3Si83OFZuU0pFem9CdFdRUVZ5cDM0M3p0QS9M?=
 =?utf-8?B?YkwxQW4xcjFKWXRhQ2xYOWNOOVBJeFZ5L2t2c2kzblJtTmVXQ1NrMHFScnNM?=
 =?utf-8?B?UUxaektWaTlGWHZsVk1zWW1LRDZ3NlJWSTdHT1RxbkRIMEtBZ1dmZkZ4Tmd4?=
 =?utf-8?B?QmNDb2ozRll3MU5WQ3Qyd1lWbXJSMGZLMzllTHdRcXRnWnR3TzRPWnZVUjZK?=
 =?utf-8?B?bU8rTXFacE5jNHQ1Z1hhM3JZZGM1SE1pNUhwWFdxa3dxVGQ5QUJUcDBzREk4?=
 =?utf-8?B?US9FczVYYW40Uk1jTXY3ZFEvbEpyLzQ5aitSU0FueTZ6SnBXN1ZQOFJMUTBO?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9b0c36-b9fc-4457-fae2-08dafe285d09
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:30:54.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xND+A2DB21t/vPRp6zi3b+cLTiMXbvUbW+dRhVMH0Lf0BLAqcYhuNQ2o1+fKgZsDYZpbH7KcsGmRnx46tAuxvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB9999
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/28/22 22:32, Daniel Walker wrote:
> v5 release changes. Generally a rebase from v4.
> 
> * Modified OF changes to move the ugly code into the cmdline.h
> 
> * Minor compliation update in arm64. Added ifndef __ASSEMBLY__ in
>   a few places.
> 
> * Worked around arm64 kaslr_early.c.
> 
> 	This code needs some additional review and consideration. 
> 	It appears this code is missing the opposite option to nokaslr
> 	which is kaslr.disabled=1/0 which would allow kaslr to be turn
> 	back on later in the command line. For example,
> 
> 	console=ttyS0 nokaslr root=/dev/ram0 nosmp kaslr.disabled=0 loglevel=7
> 	
> 	On arm64 in arch/arm64/kernel/idreg-override.c this is parsed correctly
> 	to turn on kaslr, but the kaslr_early.c is missing this logic.
> 	Doing this results in kaslr getting disabled with the following message,
> 
> 	KASLR disabled due to lack of seed
> 
> 	Even when there is a seed in the device tree.	
> 
> 	So change to the generic command line would leave built in command
> 	lines with nokaslr with no option to re-enable kaslr in in the bootloader
> 	arguments.
> 
> 
> Daniel Walker (8):
>   CMDLINE: add generic builtin command line
>   scripts: insert-sys-cert: add command line insert capability
>   scripts: insert-sys-cert: change name to insert-symbol
>   CMDLINE: mips: convert to generic builtin command line
>   drivers: firmware: efi: libstub: enable generic commandline
>   CMDLINE: x86: convert to generic builtin command line
>   of: replace command line handling
>   CMDLINE: arm64: convert to generic builtin command line
> 
>  arch/arm64/Kconfig                            |  33 +--
>  arch/arm64/include/asm/setup.h                |   4 +
>  arch/arm64/include/uapi/asm/setup.h           |   2 +
>  arch/arm64/kernel/idreg-override.c            |   9 +-
>  arch/arm64/kernel/pi/kaslr_early.c            |  14 +-
>  arch/mips/Kconfig                             |   4 +-
>  arch/mips/Kconfig.debug                       |  44 ----
>  arch/mips/configs/ar7_defconfig               |   9 +-
>  arch/mips/configs/bcm47xx_defconfig           |   8 +-
>  arch/mips/configs/bcm63xx_defconfig           |  15 +-
>  arch/mips/configs/bmips_be_defconfig          |  11 +-
>  arch/mips/configs/bmips_stb_defconfig         |   6 +-
>  arch/mips/configs/ci20_defconfig              |   9 +-
>  arch/mips/configs/cu1000-neo_defconfig        |  10 +-
>  arch/mips/configs/cu1830-neo_defconfig        |  10 +-
>  arch/mips/configs/generic_defconfig           |   6 +-
>  arch/mips/configs/gpr_defconfig               |  18 +-
>  arch/mips/configs/loongson3_defconfig         |  12 +-
>  arch/mips/include/asm/setup.h                 |   2 +
>  arch/mips/kernel/relocate.c                   |  17 +-
>  arch/mips/kernel/setup.c                      |  36 +--
>  arch/mips/pic32/pic32mzda/early_console.c     |   2 +-
>  arch/mips/pic32/pic32mzda/init.c              |   3 +-
>  arch/x86/Kconfig                              |  44 +---
>  arch/x86/kernel/setup.c                       |  18 +-
>  .../firmware/efi/libstub/efi-stub-helper.c    |  29 +++
>  drivers/firmware/efi/libstub/efi-stub.c       |   9 +
>  drivers/firmware/efi/libstub/efistub.h        |   1 +
>  drivers/firmware/efi/libstub/x86-stub.c       |  13 +-
>  drivers/of/fdt.c                              |  22 +-
>  include/linux/cmdline.h                       | 137 ++++++++++
>  init/Kconfig                                  |  78 ++++++
>  lib/Kconfig                                   |   4 +
>  lib/Makefile                                  |   3 +
>  lib/generic_cmdline.S                         |  53 ++++
>  lib/test_cmdline1.c                           | 139 ++++++++++
>  scripts/Makefile                              |   2 +-
>  .../{insert-sys-cert.c => insert-symbol.c}    | 243 ++++++++++++------
>  38 files changed, 724 insertions(+), 355 deletions(-)
>  create mode 100644 include/linux/cmdline.h
>  create mode 100644 lib/generic_cmdline.S
>  create mode 100644 lib/test_cmdline1.c
>  rename scripts/{insert-sys-cert.c => insert-symbol.c} (72%)
> 

For arm64:

Tested-by: Sean Anderson <sean.anderson@seco.com>

Thanks!
