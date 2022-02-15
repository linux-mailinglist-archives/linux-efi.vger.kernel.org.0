Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BADE4B6664
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 09:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiBOIor (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 03:44:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiBOIor (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 03:44:47 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10104.outbound.protection.outlook.com [40.107.1.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E873111F88;
        Tue, 15 Feb 2022 00:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ550JTRRzEJ/f90qp83mKXh/xKD1PKTVRbh/J0t7JMiNPp6F0I2VjiJDgRqRbtsfL+sKlYCx9iUObEoGbKvPc5UEOWNG0tGsPdD9LMz7aHB0fItUZugWpw2LzUGEgZ2VNALi/8CMYVp8GDA3fJNTkh4ETXFf+1zccpOCcxG2BvutJGCGzFDKMQf/S3vP7lkOIX1PGNUp704M8JwpEObHOVGr4camRwNgyLCjTAVod66mgVly7aPgwyG7n9gXyK/1ecx+A5eLPjtJdUcSeOeFQ0rK2PtLdOLCyNM0WVioNQztgWyInI4qIWghVQgztYac/oTQM7oZ5wsbypCzKXESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DovCm5tHlhDNCqO4hGenehRjlV9uHE6wIoBww334beA=;
 b=YIlHWU5JAzJnL8VrWEaNEr0XdV/1YKxM+y32gBfn/GANslEgeLM3JxppCI4lIbgtlX1SXl7NSEyvpv85E6fQ6A+U/AeMRijDa79xSpzzgGWNIY88nP6n605sFNagOZe3pEq8MCyHIrXiQFCZIc9NzRg9NkbVCLTfyGhVTHrFGNdKjc7tuqKTbH3NqMEpmqTXmqu2hRiyduqGBlHYkJ1bpu2CqavImdAB2Qv8R/OwIPfUzAbeo+x/rcrok7gqdfPl8Fb6nRmMGI1pg+V4KKwrZgpfC5aMqQmc8Gm0nj5SQb9ptODXFSFkr9cCCiph2qswjKyC9IPABIR2polZ8rgrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DovCm5tHlhDNCqO4hGenehRjlV9uHE6wIoBww334beA=;
 b=SDThPj8dUJ5idvfjQwAs0eJHyyLMpts3iSbb9f1YD77NOtu/UlxunSiWNQawJrIiVvClOxAW0B2Rljjq4Vayte6HNjFVFxHZfH6Tp5144Y5SoRCAIBdYOWXQcSVycxPHdalq/oQzyMcdJU0JJXhg/CPO/ZR5YJjXEpvmwfol3YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM6PR07MB5091.eurprd07.prod.outlook.com (2603:10a6:20b:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 08:44:34 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c27:bca0:d64:d78b]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c27:bca0:d64:d78b%6]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 08:44:34 +0000
Message-ID: <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com>
Date:   Tue, 15 Feb 2022 09:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        linux-efi@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N> <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51193084-7d62-4821-1091-08d9f05f63fa
X-MS-TrafficTypeDiagnostic: AM6PR07MB5091:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB50915ACD5B6EA2E7BFACB87B88349@AM6PR07MB5091.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /prz7hYWBK+gr8Oiisi3uzybVQzoDH/z+EMo3pNN8eZNP8LBddyU4UqjG7jJjpmFshrU7DA7VylIh2rjIxviCG+2SJnuftA2E7p3fA0EWA00ouJBD7WkfIz+Ep88SBLIT4aDQgke3N8Z6GsYtkIIMBRDjRiVvrqJxUF2qAuGOENLr8G0pQ+SY7R8ZjTGrHmzDxuRzuLwGYJHE7Aub22yBQX9T4smMpQufGtdftFdmnDIwOpFfUt33QBD0c5J9UARoQFBWj+J0KtiggeWkX5l1J1zjsYH0hJu2QrM5Ho8vcDm1atVG4xWsEgfef+hJghSJnb0+5YXSGJpk7maSbMYVcpfVGcpUFfs5jzm/CourcZlUcO2TVchBjNLvfQgeIBGMWzI/NlAe4Oc9VCSpR7lzDQTVfNC6dG7AN/ywuK9sE2ebs+AcfDqYAjrKEo7Xr713oxU/bigFtHwClkGA/ksKJDktn8+0nlmXTwED61L+a9fBG6ViSzVsfSnSP0Z+Z1rWK1u+55k7L2uyt++bnN9tQWn0fSxJq4oGne7afUncutMu54u4Klc4NSjV1S9dQXh2s4g3Yl8KO1lcIrYrn9hpPh2JlvUp9cdsFoN85eVFDF1C3uqFrdnqoIQnZNHZmwIUH77lul8egk6UKnBVhH7lHd14Vph1n+RwB25OcOPf8D4O3nenJtm2KETrV7Cvk5ZMRAZD6oL5x9z5IrADtYhmRMAAJ0bM1VLYYCtoDzy6gSlde5FFI2/yx6Y5pr0jNOsmmb2TDwZZoIs6jEicpEIsZB71CwL4TO5fjGgsAmSBsurzi+bwC7GKTc6GRWUrdvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(36756003)(6512007)(6666004)(6506007)(6486002)(31686004)(53546011)(52116002)(38100700002)(38350700002)(31696002)(508600001)(5660300002)(110136005)(54906003)(2616005)(44832011)(7416002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(186003)(8676002)(26005)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUh3cXFvaUxFSlRFR0FnOUpGRnpXVXM5dlMxNFpFN0w2azY1SDh4RTFVZnZY?=
 =?utf-8?B?UGlRT2VXdEJzaloxazB3VjJtcnplZ2hyNU9oUGhVMGVZdEc0M3o5WXhVdWt3?=
 =?utf-8?B?NnhKTXhqeHpKcFBISWxHS0xoMTRGM0tESHZ4MElQM29aQTFJK2Vxam5oN3F4?=
 =?utf-8?B?TE5MNWlnQ1RlcWtoY2RBNVZzN05pd3Znd0YxOHdnOWtURVhBTExpU3VsUEFq?=
 =?utf-8?B?OUt5cnBMaUdoR2lHVFVERjE0N1ZzU3dMeUdnNWkzRWNjQ1IxZkVjTlR3aElQ?=
 =?utf-8?B?Y3p5cEMxZGdUMjIrOVFTN1BmM1RmMDNwUWppSFpwdFViUVV3bzd6Q2tnNWo1?=
 =?utf-8?B?cUs2eUNuS0JDck9zTkZkMGlYNC9BK2xtOGx6djNzOHdYMXRMTDJrN0ZVZ3Zq?=
 =?utf-8?B?dnNzUTNVeXU2MGhLR2VYMVU5OVBCbDR6M1N5aHgwL09GTmhxRUJBeGRjQ2RN?=
 =?utf-8?B?b1RNOFNOYXJWd0FxY0JadUNGN3FoaXVpa2FSTURqQ3h6eUV2SU1HODB1N05H?=
 =?utf-8?B?T2doL1BOZTZWTDB5ZVBZdW9KbXBNeEVoZUF3ZzlvZEIzN2JOTjJqTFMrZXB2?=
 =?utf-8?B?VTRRdmZIOTkvS3NKbERPNnVqbVh5dXJOY1FibGovV0t6bnlIb3V4clZWWWh0?=
 =?utf-8?B?cGV6c0NHakpRdlI5Q2pXSlp1UkZlSFZrZllPS3dUK1NjbW5pVUREbTJmTEdo?=
 =?utf-8?B?cUFkOVFLa1dEbHBFbjdjeS9IcXRtS3FRTU5rb0t1L1dIbnNiTkt0TW5IQUJt?=
 =?utf-8?B?cS9ZWFZkTU00RUt4SUM3QnNKR0QyVHJxMG1uSVV3WWo1RUcrbEh4bGhScW92?=
 =?utf-8?B?Q28yVU9ieUNaNSt4dUhYWXhIR2tlVGZPUG5icklCcHVQMXhDdEV4bFRPRlRx?=
 =?utf-8?B?YStIN3ZTL2ovRTdnenpBNThFbFNWY2xtbmFCRjBuR0tWYS9UeDhJVGEwb05n?=
 =?utf-8?B?ell6SVI4NmpCdHc0QnFBL0Q5OU1zdEFGL3hwMzc0dXNId0s4Vjgxbk41bjNP?=
 =?utf-8?B?UVhWbFZyYXVqU1BPTm9MN1MzeGFlc1RIMDlzVEJaSWs1aEluaEE4NDZsbWN3?=
 =?utf-8?B?S0QyWTJCc2pjUHk1M1M4bnV3Q2YwRGhaQVZYajBrMThGdklNYXhpUlh2UjZ6?=
 =?utf-8?B?QXFHZGt1dHh0c1RieG45VFNGU05VQStQSkEvV21yWTJCQlhCdVF4VTBKS1BV?=
 =?utf-8?B?Qzg2Vy9wdG83RWtyWGJycnNEcTF6ZHkwT2c0YWY5bEs1Y21kSFAvM1R5UC9H?=
 =?utf-8?B?eGEwNDNkZEtzeXhuY0FhcmJBeTAxYmpBUEErVXRmemRmSEhONnNpUG5jUW41?=
 =?utf-8?B?Rk1PNGVpTmdVRFJHTGJUdml6NXVLdVVjUzFHeW1VWGFZQ0pSNzFNbHJteElT?=
 =?utf-8?B?OWRkVnlxOE92aDRzSWNxV2NNWmtxSGR1bnVTM3hQNUt6d3hXRHZHY3E1YlJC?=
 =?utf-8?B?aG5yY1pkbHRnSnFaK0x6eFhSN3lTQVlSbXRhdlBMd090bkM1SGNUbmVaSkE2?=
 =?utf-8?B?V1grRWZnbXJqWjNXNUZaYnNCdTlHSkhGZms4dWJHMlhoeTNQeVowRWxFNW0y?=
 =?utf-8?B?T2I4MmRFN0RRTXRrNFBRVjRjSFA0cStIVEljM3phTDhSVDNkY21oMUVpbmZG?=
 =?utf-8?B?Y3lhYmR0bTBtRm9ZUG1HOHBZTG1EdGV0K0FrYVhEbjZXd1c5OFh4QUpHcUZE?=
 =?utf-8?B?VW5RWUJKQmFUZVUwVURYd0dvcm1UdEdQRXR1dVgvTUkvc1RxblRIMTlDVjEz?=
 =?utf-8?B?dTE5a3pkb2x6ckI0cTg1ZWhYbi8xRmgxcUFjelBkTmFrWUQrQ3J3aHZpTXVl?=
 =?utf-8?B?UlZwS0pVSEI2T0tPSXNJUGhydW4xMG5TSEYwTXA2blZiemFOOHgvTHMxZ2hW?=
 =?utf-8?B?Zk1qTi91M1E2andnM3kyYkY1N3JSbG5FQTVYeGduOHVTL1l3bGkwdTl2VWx2?=
 =?utf-8?B?SXdPc3hNaEEraWFPTG5BQ1cxUlZRSEZ1U24wZlVycnBJRytXTVhLMnRkb0Nn?=
 =?utf-8?B?cUtxR1ZZV0RxUGdwb015d2pvejV4NXhydjAxSkIxZ0ZxSFlBaWVNUGFDVVhG?=
 =?utf-8?B?ZDVpMVU2Y3RzSmc4dXVIT2IrQ01oY085ZTAxQnVvZEtFaGJ5STF0YW40czlV?=
 =?utf-8?B?Q3U0WE1YclhDZ2RRc1ZuNC92SlNLUkNjUTZ6WHEwSWNXMXQ3TE1MbXBtMkEx?=
 =?utf-8?B?MHNUeXZCenJmNnBxdHR0dDh4OWNKa2JvalV6Mmk5aitjcUt1cUpCdVN1bUdu?=
 =?utf-8?B?alUwN1lXTG03RGxiZ2g3Rmk1WjhBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51193084-7d62-4821-1091-08d9f05f63fa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:44:34.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB8MA2YWjLx12YKaKFFf981o9Ilb9p5QPdAOW0ejLou3AvvqL+L4+KNxeXFheDU4iFxp+yQOb8TF/jGdOL2vmc2mngwcR6xfEz3pN2a7Zxg=
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

Hello Mark, Ard,

On 01/02/2022 14:58, Mark Rutland wrote:
>> You could argue that restart handlers were not created for that but they
>> suit this purpose ideally and it wouldn't make much sense (in my
>> opinion) to add yet another notifier chain that would run before reset
>> notifiers, for code that is not supposed to reset the whole system and
>> this is exacly what I would have to do if efi_reboot() is forced to be
>> called before all handlers.
> 
> As above, I think that's just using the wrong interface, and the reboot
> notifier mechanism *already* exists, so I'm really confused here.
> 
> Have I misunderstood what you're trying to achieve?
> 
> Is there some problem with the reboot notifier mechanism that I am unaware of?
> e.g. do we bypass them in some case where you think they're needed?
> 
> Are you simply unaware of reboot notifiers?

Could you please check the simple case of pwrseq_emmc.c?

While that's currently the only example of this kind upstream I can imagine
further use-cases, especially in storage area like above.

Would you suggest it's illegal usage of register_restart_handler()?
Do we need to fix pwrseq_emmc.c by introducing new atomic notifier chain
which will be called before restart handlers, so that it works on
emergency_restart()?

-- 
Best regards,
Alexander Sverdlin.
