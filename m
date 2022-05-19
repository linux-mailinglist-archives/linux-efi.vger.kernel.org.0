Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1487152D621
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiESOdc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiESOdb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 10:33:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED042BA54F;
        Thu, 19 May 2022 07:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5EzFTI9jUcHfs0+vGtYLjboMkLGWygnMDs3rIW00ERTgcgnAxJoDEb/v7KuZCg+JnpC/yOIoG3X7zs4mYkAyUQ7Ut8B6hU0rqljXaiz9UXdMy+X9bWvDmNZsPORvGBZ3S1hcbA6mA4l03WZb02I8ziIDs3oS8eoS8wEc6NLsiRwj5T9jCh6Ni10FwuQgFB4+nGYWsjXlDROzNBZL33G4SYT7TgVm88BYHiAhfrMcU8a4W7XtIPHprDQT+fbEqXsRd8GN71tY1j90qxtHv8KM7Btr0NZ+Z6gB1+bsZDPvXnVXXJwzA5Ay2ucV81sfZjMpxpLlpHOHda3rRzVUJ/8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y4xv26s0lvvRrYJGpFGqruDvZsxqpigncY8/eXpMlo=;
 b=b2FAH56pYewytC8BF4mJdNTtz7c9ZQ1MrCr/kC7nk+msC6P3i+1e8lQ/Y5YYahwqSar7bdeCy4MVftsogPqTv0kvBDRAlPvCZ7ppI65Scjaimsf+arlnSqyINZgczl0oQgj3f8e9IpsDLf2nDnqh3tjr342e2KJo28cyjotP9cmglfmnVZiFO8WvN4PqDaMqfzdkLys5T/9SrfXFQ6c4TBpYu9VZSnZi23c+6kiVJwdD/AuGZ49ehDb2sfQLRmN238nVXc1WNiiHtQCjOsuv4rfCM1mBcd9Owl75DYy/Cd+5M1agHMqrDfajgSURDoZT79wQQmKqhlgLp2sH0y4xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y4xv26s0lvvRrYJGpFGqruDvZsxqpigncY8/eXpMlo=;
 b=GKYugmDfRkZVwnVAtAWrPa010WPfpCUiIykDjL6GFdoAsr4gKGWXFRrOH2k8sPLT6SFIWZFUDcZ1B8V3QfTPWfKFrDyBIHsGQohA7T8S98KZqAjmJEoh3oBq0YTRHBrg0chd2jAHbIPgUKiBg8FD78Ws0carapRIWCxamrei31E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by SJ1PR12MB6195.namprd12.prod.outlook.com
 (2603:10b6:a03:457::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 14:33:28 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 14:33:27 +0000
Message-ID: <8dfc48f9-80a2-fc3f-4d2a-08abae59548f@amd.com>
Date:   Thu, 19 May 2022 16:33:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCHv6 02/15] mm: Add support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
 <972b5335-98df-f7b2-4b4f-53695e684d8b@amd.com>
 <20220519115527.jqzrvsqk4o225m6d@black.fi.intel.com>
Content-Language: en-US
In-Reply-To: <20220519115527.jqzrvsqk4o225m6d@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:203:91::17) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1879905b-aaa5-4324-4526-08da39a489ae
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6195:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB619564C2215A51D03ADB6D449BD09@SJ1PR12MB6195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vIh26dYLkqUy18x59u2xfYedJxV79wzhjMK/IykfVd8x/8pDG83xVjznW2GWfLjohrcR74G1F+AFGmhV2st55qWLodh2IzzRtpW2gSPA5HoheDWjDG5tiD6Tv7holTiLKSDjtbbxLC89LyjLW0gobe97M9kl+eyEMHsXx/sdhNy1WdqVzV5anhjKqcA2Cz9SDH/fOrDoFFb+r38cx9tMFINsEYCfmQOmvdB+lnq4b1Cn7o8NTbwhEPUsHpGaXBbAF1UorCtJWurn6e0vDRsf5uOxxRPOfYiXEKBJ9WNQUD5/A5Ld3TvvpOg/M1rgvURXi/yLgqEb08lq5H+RwJImEpPE799lXtXV9r5Y1ZssJ0Ax5BEH+UjS44xLZFbjUWr5Yzn48ffxr8MOXGxC+GsSDCqxQJNQuazEt5MMF5u7L2e27Fht13ptu6T2QUd2mQ2Z2D2BIp5DfV3qCf/rWBSNHDvrRcvrazIDoALKHqZ0HrH81gRBVxcFEvRNxb1UBp+/yG3vCNtlGykKhmdicoS+RsVx+/d4CHWZQmt4QjBh0xnp+7aaQDPbqik/ZjOywvjzpZEaIck0bMTBrcn1KL7q0EQTpMRe7VrbqOJ9PM0cQKPrz1Q3LcxLHIhw9j9MRWTsTFrdtVcgZlUlmS1+ns3pzI3fx9FEsXb/LIuf+W4x7FeoBnyWFTwSxuTcpQWGWpsVW6TWpkgQaA+8xAd/2DtI7hidm4n8SyvH056W8rJP/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(31686004)(36756003)(7406005)(7416002)(54906003)(6916009)(4744005)(186003)(508600001)(86362001)(66476007)(8936002)(6486002)(31696002)(8676002)(2616005)(6506007)(6666004)(38100700002)(66556008)(316002)(4326008)(5660300002)(6512007)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjE5WmtRU21TZ215dmtlZXpLT20rMjVQNkFDSlVHQkRyck5WSjJSNm5meTJm?=
 =?utf-8?B?SlJ0ZWt0eGFyMHllUXkrTzhGNzhUaWI3Z3NDMDZrSkFTY3I0TktHbnJINnZM?=
 =?utf-8?B?ZHk3blA3Wlg2OE1KLzlCMmdRT09vVFJPa0R0VlhMOTlFOVBlcWFOdWJJSzV1?=
 =?utf-8?B?Y0hQRmJxWk50dWV2a01SekNBYkk5emt0ZWJGc2FycjF2VTFXQmlKV1N3QTRE?=
 =?utf-8?B?UFNuZTRyd0Jwa2JOL0kzZmZnQnd4alNTekR2WFVlTlY4SGdCTjBmd3kyVWJ1?=
 =?utf-8?B?UVlZTW5weldxN3YxT3V2NVlaT3l2eHdSN0VNZDd1SndZZmEzY3UwZklxY2Nl?=
 =?utf-8?B?Sm9EVTY2U3BqQWpIaW9HbC9weE5kekcyWFEvczJnM0tEN2sycnFVbENITnJk?=
 =?utf-8?B?NHJJL2RSYzJNNTVMbUxuVnJ1U25WT2dOYllDdVpHT1Jpb3QzOW14MGhuSFMw?=
 =?utf-8?B?WCswNzhwRUlKYk9EUkhzSFMxc2p1bkduVys1YjRlZ3ZOdDVWdzZraU1xYVhR?=
 =?utf-8?B?YlpXazdEbUMxb3IycC9XYzhTUjdrZm9udXpodjhObERjRmxYNFcyOFZXanIz?=
 =?utf-8?B?QnNjd3NldFJjUHptZnJDL0thMUNmbHpzMTZ5LzNoZUp5Y0VDUHM2dFFqdlFX?=
 =?utf-8?B?bnEyNXpjdFJWaWY1K1Z3U1hEN3ZHUjNIOTY5K0oxbEJ2cGd3dmlXcGJodVox?=
 =?utf-8?B?VnUzSGdHN3BueC9rK3NiamZuMkZhTXpQYk5WanZUb3hmWXlpUzBBcUdJM3lT?=
 =?utf-8?B?MEdWKzI2NStabkZBS1VrT05NRGs5bWN5aUpjd3NIRFpzeDBaS003eWduUDJk?=
 =?utf-8?B?VFhubXFWWkI1N3ZxcjN2T3hIWDFBMlZPZnlPOHorQjNCNDkzbkhNYzdjWndw?=
 =?utf-8?B?aEthbktEdiszbnU3Y3FCWWJYeSs5YnNYWU1MQnFrWnlXZjhPUHl4Y1NhRXdE?=
 =?utf-8?B?V3M4V0MyWXJETHNHZFgzV3o4L3AwZ2Y0UnR4YnIvVFc4MTdIMDRpY25zdW9p?=
 =?utf-8?B?MTNIUjRtcVlHZ1VtdmJBR1QvN2VVbWhUdWQxcGxBVWpYdFZwbDdGVnIxeU0w?=
 =?utf-8?B?SGxEUTlkWDJPYXJzeUJUS2JQeHJWME1KTmtwbnZBRWg2aFhCVzVPRW5DSlBQ?=
 =?utf-8?B?MjJBellJQnJUYW54S0Npbk9rbkF2bXpqWmlNSlZxSjNhQ1NnWDZLeHBtVTlF?=
 =?utf-8?B?VEpldG5YOFhxWXFMS1ExRTUzelIyMWMvMWxVeEhzM0k4b3JOSUxxb0x3dHRt?=
 =?utf-8?B?WDcyYmUzTUpTdjRTaGl1azdncTdBaDVLanduWG0xbzVhYkxQN2pKaWFKalhn?=
 =?utf-8?B?RHN0d0dWL1hWcHZqbGxXSFVnOEpYZy9WOTRVTEVudzBQVVBSb2UvRlVkSThK?=
 =?utf-8?B?WE9kNys4Qlp3eTQyMmhXK0ZTMGUxNGRqNUd4cDRNUzdpTURGdDZSQVBzTGdP?=
 =?utf-8?B?QW54WmQwMUNFSlZ3d2x4UGZKaDJaMlhPbjBrcnBieEpKczVWTGY1ZzVEaTha?=
 =?utf-8?B?L00xTmxrUnhoWVR5cC8xL0NHVVROZXVnYVJIdkxMOFZvQUJmY3dUUmpVcjVH?=
 =?utf-8?B?QWRCQXcvYVpxZ0VCY2RTbWduR1MyejA0RDFwY0h2UHNLUFdBamkwbWNxMUVS?=
 =?utf-8?B?MlloWUpCTndXVUhyaVZCT1ZaanoyaC9GZDJoUjhKTEpmUnVNalU3aUhaRUNW?=
 =?utf-8?B?ZmFKZnluUEIzTWltYmpPTk12SDJUeTJmT3VqTmo1SnFhVU1VZUtKQmIvam9I?=
 =?utf-8?B?bmZHMWlqTmRET09UbXFRWS8zM0QzckFiQk5Obk9POHIzTGs3VjVxRDRVWlpj?=
 =?utf-8?B?TTZHbm02WmJHQVhzOUg2MXNvTzJ2LzRwYXVYbUlqM1FrQ0tnRVd4aXlZQjgr?=
 =?utf-8?B?TGlpK25kbFlIUjVROUx0dUY0OW4zd3lZQitaUWh6NmZqRFFiQ3pWcE5JMlgy?=
 =?utf-8?B?TERXa0djRnhSM3lTZU5MV25USk1pdmZyL3czY2FYN1BvRFEyUDlNdkFGc1I1?=
 =?utf-8?B?bi9zSFpwWnNWZWNSbFZvcFg3dmV4WSt0N0hORUFsdllmY3Y3eFNTTzZxS1N3?=
 =?utf-8?B?L3VHa1Q4SEVxWmlUa3J6L29FZW5KY2xIQ2l1eXRPRlpJSldQb3JuS3ViQU91?=
 =?utf-8?B?Qm41YXRQMGNoLzdUSUloL2tsTktXVFErSm9pOU5SSHdqQ3pPVjZ0YnR6VXVG?=
 =?utf-8?B?YXR6T0paRS9ibGc4VUk1djhiUlVLa3R2MnJ0cXV2T1pwNmFDTUIzbHBvL3cv?=
 =?utf-8?B?SlhxcG9uVmcxR1pZVTVOS2tlMzJJSVVselp0MXNSQXRVL05ic3JHZCtWbjl2?=
 =?utf-8?B?cDYyeThFK0Y5OWJiSnI3WlR3WisvNnZPNkd0UzEwY2dOaFFUVE9PZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1879905b-aaa5-4324-4526-08da39a489ae
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:33:27.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKPrbw/12jVSJ8TMBvz1kVa5wChCBeyoFGUQGtqJUm/i9i3/nnk+1HGKYQ6WqKZjOjp9Nc334nqO3gg3P2K6+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> On Thu, May 19, 2022 at 12:43:15PM +0200, Gupta, Pankaj wrote:
>> If both Intel TDX and AMD SEV-SNP requires the memory to be accepted before
>> it can be used by the guest. In what other use cases (apart from memory
>> hotplug), the lazy memory acceptance will be useful?
> 
> It is nothing to do with hotplug.
> 
> Any memory has to be accepted before it can be used inside the TDX or
> SEV-SNP guest. It can happen upfront, before kernel gets control (like by
> firmware) or by kernel. The idea is to accept small portion of the memory
> upfront and leave the rest to the kernel. The reason why delaying
> acceptance make sense is boot time. We want the guest to start doing
> useful stuff as fast as possible.

o.k. That answers my question. Thank you!

Best regards,
Pankaj


