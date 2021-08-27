Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62D3F9EC1
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhH0S2P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 14:28:15 -0400
Received: from mail-bn1nam07on2085.outbound.protection.outlook.com ([40.107.212.85]:13246
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhH0S2O (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 14:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5x7MjjVOuwR4MaoF8yPt9OLVlA9c74DwnB0t2EFwa3cCMjbRYZnZzTzHdYXtLRCJY2iUKOM4lIXBLZC9x1tKdPpqJNAcOqBtEh5oK0QqhYtuWnOk6OnpeSZXobJjbEtCjNS5YF5SnUH9L430yT7nPnKRYxwVYnMDtHZTCLi2Dbfip5+L0VMNSdYqxRup0eBvBp2tDmNRxxEO0sA3ND1Srcuq5pGoNdPOA5Nb/vQfb10Nd2ndsYyRroLP5NSd0SMML0v3Dd6+Evlv8wMoQ5jnQAHPgHX7F/+ynnhl4LHwl+sk0fXxtgvQqcQaQMo5MqNHyeX0xgygQebo2xNfL9NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14wrOguzcJyMcWxCca9Sd5LXcV1BBnN4iBljxW8MYXc=;
 b=WNY/Tu7m1R0dPZSClSxZgUMfog/bUIfetchZNoQnSXurOnzlTvJfMxgHOBEgpF64C218Amb/7fRs8F2jZtJ4dUbE/dm2EW1fVQxoT8eFDUfFxhTYqGNIoP2bmFtsB+aQALV+c4gQdQfZOvBMHnDmnAW7SGzoJYX9vQmljhQJ1mUFO/kc3tbTMArMYY0bM4nVEM5YS4f/Tfqqx6KdfCjsvn7uBs3fNNu00T9jubb4RWT+6BVIcuFOYCvzcLUQmO6FfbOq5ZjqXM6GdJ6+KXvcIPWrRCbwf7RPLnRcYcFRGqUxq2spLSBla5VwZp3mgpBPtPg47sQG24qEU7SwO/b6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14wrOguzcJyMcWxCca9Sd5LXcV1BBnN4iBljxW8MYXc=;
 b=DWIrbUPKcqnb8XY1T6GmGYaL+i7tDwmnb8iuA7IVUMS14zwsfbnq3Gb8afF3oel4j+DABPOcb76uKfC5xntTnbnyxLUJNb0D6YRjUHEUc5GsznbB2rFTyKnm89s+rlMgjWWEnP673hKDXTRDQ0gaP9YsQupFt5cCvS8xZOC3Kas=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 18:27:18 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 18:27:18 +0000
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com> <YSkkaaXrg6+cnb9+@zn.tnic>
 <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com> <YSkrPXLqg38txCqp@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <caffa9dc-06ca-e1d4-e887-fed51c389790@amd.com>
Date:   Fri, 27 Aug 2021 13:27:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <YSkrPXLqg38txCqp@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:805:f2::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN6PR04CA0091.namprd04.prod.outlook.com (2603:10b6:805:f2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Fri, 27 Aug 2021 18:27:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e2d54c-6363-4003-658b-08d969884d1b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525CEC7F97A56D2ACC08FDFE5C89@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EasHWyGsqUJ7rfQKpbZkW+/w81E1dONPqaxLK28cYcOfSdQ23dHOjrVtl5KT+9UDJG9Tbv7GVUU36h8CoMfn3ROVBuesYRvZ606qZaPMrfKivImTBSdr72p3ZNjOSFfeGXWPWMgP4hDP2JfF/OSDQILrrgPAc5b7uTNzC8BQsuNbmrxGFc6WZK85l17BWsl3oS1unReMPp1Pt6X/8T/9A0GxSbXOKvqHGffgczFVebXEWPc5Usdpk5GXubOhIN38YAF4w7IwdEArN7NfJOb67ut3ESf5Dqtj3mU+cMxeCC/6sxi/JdjBZOYn42da3Pm9iaPRhv2yUAZwT1IkaAqOqE8TLDF8AGHnWvKamM2IYF1ANW9O7dCi/XQO8T3jIbrLLQrKiufPKRv1AhG2ntwS00ki4164w8bgmIVXPGFTwkAZM7sK3fqbhwWXQ/wn/9WQVKiMs/HUM1Sg//Dp2HhV6gnaL7fkcic0WZfb5/LUYoRuPHG/FxlBrwPiPKEifkltTnu8yIMDOgTCBCoRgwD2rKHyNZmVHeVnfoxjlXPclTyDn8FP5MqZET26UVmyi7L/jiOpHXwbCjIQCk3uVx3AeE8nMsR/P9wmHb58jMvCKd5rPP4mnKCWSAYWlXW9pC5CPx4w1ZEXw1fdrGSmUiGlUfmMRflOJMyb3V4Fy/CJLSIJnCOGa6ADIzq7btTLblOuotuy/+LzviEoLSAeh74OrYRvZz6w5WtbaU2CukpZqoIIiHri8V+nuCgGgn7jxQ8ad+C6QUDNksRtHc9wT0/xrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(956004)(36756003)(53546011)(38100700002)(31696002)(38350700002)(2616005)(4326008)(66476007)(478600001)(8936002)(6486002)(52116002)(44832011)(31686004)(7416002)(6916009)(8676002)(316002)(26005)(4744005)(186003)(86362001)(7406005)(2906002)(83380400001)(6506007)(54906003)(6512007)(5660300002)(66556008)(66946007)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnl1Z28zVkVzWGxzZ1ljQ0wxNTFxSWxkZzVXam9lazBDMGQ0MW5hblJHWWNW?=
 =?utf-8?B?VGVkeDJBTGhNWlJZR2V4RFU0RHRXK1BsSnVPbWtzNWRoYUxxQ2dPTFVhNWNN?=
 =?utf-8?B?WlQ1Nm04OU5HTHN0ckZTNENWRVJQc1lmMjAzL0dYWWZENVE0LzdqMnVTdEo3?=
 =?utf-8?B?U211Slh4SlRNS01vZWQ4VGJBci8vYXBRbndPZU1wa3FHdHJzeUdybEhVSU9t?=
 =?utf-8?B?M09hUjFlczZWaFhOYnlMYjgwU3Bka3hVUS9JZzNVQXBWb1NBSXVrMUFJTW5J?=
 =?utf-8?B?dW9wYytuRm8zclBQMElKTDVkUXlMMmNiV01YYTJtQ0xUSHB6N3V0N3pOSTVF?=
 =?utf-8?B?NlY4TkhhczB0V0JYSkNOWU1wZUh3NGZlMWpYeFFIRnZvditNQUI2MlFYcUZB?=
 =?utf-8?B?MEVINWE1YjNVZU9zd0tsK0ZOQm56Nll4ZUNBRloyNnRKRittb2g4OFRkRndB?=
 =?utf-8?B?YkQvL01NUE5JbHVmbjBDY0ZqWC9JRkJMZlZPU2FIQUY4OGV6UWI1YzdQRkdI?=
 =?utf-8?B?M1BXTW5pYk9KbXU5SGFkZ096MmZxYVBjV282bXRkY0lLWElyeFNlSzJ0aWpt?=
 =?utf-8?B?SEJ6T0FUR2QwZXFCTjJKNGE1dUlRVlNVbmh5bTR5WXJ2VkRiYmJIT2hCZmlh?=
 =?utf-8?B?WnByWEExOHJ0MVNBZ2pJYkk4eDBpaUc0YzVRSGlZVHBDM1owNmg3b1JYcmgr?=
 =?utf-8?B?Y05uOGg3aGVvUk1ZY1kvNURLMXFJSng4bzRJRVEwYTd6eEtrdGhSR245SmU5?=
 =?utf-8?B?RUlJbnF2cHRXWW5oTGtjUE5sdUhQVmpOZ2N1UjVYNDZoL2hGUm50QzRtRDJ6?=
 =?utf-8?B?K21BWXFUWHNiaUJNRmo1TEppQ00zUkNDU09uVFpicFh2bWFUL2NFM1F5dFMz?=
 =?utf-8?B?NWdIeDVsTHFMdldBVnkzQ0VPNHN4aEIxRmlTZm1GV2NhbE83Z2dwWTgrTEs5?=
 =?utf-8?B?Zm9LNWhsOFdhbWw1SnBVVGRuY2xKVjU2anVuaFFEZjZqNHRaM0JINTI3Wk9z?=
 =?utf-8?B?czlZS3hPaEoxRjhBS3Y2NDVkeHZSMGNqYWpXcW9OSnRXc2JING1sUXNCWDZi?=
 =?utf-8?B?U2NvOUdBQksybnM0ZXlSOEpmTDhlR3l1VVhiTXBaVkxBOGpESDFsbGVBNTlD?=
 =?utf-8?B?dzNtUkdqNXVyRmRkdWE1SG9rSzdzc2dtRUpQb1YzSXhocU1hRHoxUDhZN1Ro?=
 =?utf-8?B?dzdrWnVqRVJMQk5HK2FvQVdHbHNTUXNrMmMzOFV4L21uOG5TSXdOZCtTa3Jv?=
 =?utf-8?B?VTBQaDQxRHIvUVdDS3VITDVxWE9uR0FSVjJsb2N3aXFYRE1McXNuQkYrK3Bt?=
 =?utf-8?B?UmxDdThPUFk2MWZaZUxWcmVWMHlybjduWnkvaUpUT1d2ZkZoWE1HaWI0bER0?=
 =?utf-8?B?SXNHS0MxVkRJL1p1MERLNnVwaCtxbTN2WXRBVXhWenpHK04wa2tpT0haRUUy?=
 =?utf-8?B?WXlBOHZESDVpMFZ6N0hQU3F3SHQ0STRhYXVSaFBuVzBjMDV5NG1HelFjYTVJ?=
 =?utf-8?B?UDkrOHJ4L1B4VGROdVVnRVhlTFlpWlhidTJqVlBEdC9WWWQ3OUtYZHZFTENX?=
 =?utf-8?B?Tnl4ZTFrK080UjVPUGtJeTdmVHNnWER4TVV2bWtBTno2TzhQZWRCaTdLRnRW?=
 =?utf-8?B?dExuSS9YZTZKdFB1ZVpnOUtUMXJTeUpPSFVFU2hkUksreUM0Y3VUQllLcVpC?=
 =?utf-8?B?U00yNlh4Q05lL0lZZjRBaVhrd2ZySXVYeVZWeW4vMDJWR2k4RlFTZytMTXl3?=
 =?utf-8?Q?yF1lwNx59W1I4SF70N53tUWWRY3pSmZGcClRLpe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e2d54c-6363-4003-658b-08d969884d1b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 18:27:18.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSxueDp7QRpvlYilqk1IiGc8BESdWs4TvUNKBQzfqGtUkxA5tTPjOczqAPuYmYGCnqSio/oVKBe21CWHj5v7Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 8/27/21 1:13 PM, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 01:07:59PM -0500, Brijesh Singh wrote:
>> Okay, works for me. The main reason why I choose the enum was to not
>> expose the GHCB exit code to the driver
> Why does that matter?

Those definitions are present in <asm/xxx>. Somewhere I read said that
if possible a new drivers should avoid including the <asm/xxx>. This is
one of the motivation to create a new file to provide the selective
information.


> Lemme ask my question again:
>
> Is SNP available on something which is !x86, all of a sudden?

Nope


>
> Why would you want to compile that driver on anything but x86?
>
Nobody should compile it for !x86. If my read about including <asm/xx>
in driver is wrong then I do not see any need for creating new header
file. I can drop the header file inclusion in next update.

thanks

