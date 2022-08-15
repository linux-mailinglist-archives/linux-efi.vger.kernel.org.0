Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62929595208
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 07:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiHPF3U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 01:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiHPF3C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 01:29:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC32ED5D;
        Mon, 15 Aug 2022 15:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIQKRwbSnBYj5biZ4gj/FhOnlyVNczVLFKiL/4YEVcEVyBH/BCjEp7msCz784/nr9V+WkRigo39i4cigkYoWfx7zZMjZ+Ue6CkQPawEz0NDa+04eRttvUNeFrnyKw1cY6EuGYCPu769mNrYNZ24d78wupNoWC/8eTwvEO9g6gtQD+HNlG6AoVi4qs+sqZlZUGDES5E119M0O+TbhRzgMfI6FRKAkh2qNLLXB8muxVIQAgfRuT1B/YR725fZdCBCpGY+CdodLpRWlpwqR9lR43f6LyFPgswpdWyHyMsG9USX373dLq1yFf82SBquPgAwsI3QmeMVq+nqJ2PEc+25lKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJLz8swzKBEfv2hhBxl8KidCJGMyzlvyMsEkVwO45AU=;
 b=I9+wjI3WWo3k0HNns9DKdlxaCIAWhBnuBIZC+/GbVGxtamdChbEPA/QC9kHweHpBrU6dWtZFtid1QTtk4YQjxzHl9Dv+IGQEi6xVVXwqaQRcnFcTYrRMWwcUAwj51TgBc6Y6OL821B1uN5huTJB4++uYoVR0GrrZDd5XFCxdit7ia2EPGTShAw8PI5cpj1bjYzVmzo+OJhicPicwJcZCG3HR2i6AQ59o+cbY1Uj6tDjr9aI84V6+frMbO4ToVoVTa6b4IkUHr0PvzQ9KAFP3LHpc50Ug6QL9uA7cSfiJEcg5f/tluqv70Y5N+Ur7PwD9LHcfR3Lslw16ECIk8tKumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJLz8swzKBEfv2hhBxl8KidCJGMyzlvyMsEkVwO45AU=;
 b=y6RSvX9PwSPG+tR/ph5fj/Awp/t2TgYXtvluXMRt0NThHo2zsnCrIp5pDK+m+XnMfR+gea1vaS0GEO5Zjt8zU8tfQWAZc11DRUBenYLMk+3WkD/Mjw66gnOlgyt3DnMWV8DpHUVL29p/pIWMN2NHBCTNeBBA7CTwJoPPOgXgtWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR12MB1675.namprd12.prod.outlook.com (2603:10b6:4:5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Mon, 15 Aug 2022 22:02:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%6]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 22:02:29 +0000
Message-ID: <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
Date:   Mon, 15 Aug 2022 17:02:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net>
 <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76036e7-acf5-4f8a-b48c-08da7f09d8b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12c8J9uHi8sT+0kD1j0sx2xDH2TKSo7gmvRYCYue51mSP82XfGgCg2GjQp5zkyj52Oi4hE/z9SbMmPAhMzz759TKlXAsNRxXEk6aLuHdXGOEALxClaE+MiPm88A9HxA6cykzQ0uGoMI7FK7qqRc5rgWwztkrDSZEEFjbMmKtU/CydcclHJ4yexylc9OMi/jF/Zz/L6Xd9dUlr1pg5pYURxii26aFOKtadXdSwR7qeY6wJICNnmbJjRR6YMLUijGiuQrb0f3hVZKR7vbLLc03UMh6ONOQPNnwrlhw6wYcJoQsabPJdSwBKuA8SH7BwP3FES/GEgss5gRZh+N1Wxm8J0sgj2R2Nn3PhXINLuVBN0IQOkh+pn+aYuUjfTZX5nUhSyh+HLsGhzw+zEa7u7rw4r5Eh1arkGWviwwZzADok72sybNHxvd3XlawxMrDWJVPJDrqz9ppKde6xCaDhBA418duXbH2rOEcuJeYEeS3r4fyK26ahjEFNQlYFhfUfGZpgFNjJnrubzyly1N2DbqK2FJdh0T282cLVyZwdD3NpXEMnrxihz4vF21rHswRuZz71dPnJbia6c4OzZMN6XUWw8mCd55+32gAQTg7qM7rgBauPTF8cG7hrSVpGqi/1UNfdFgHjrSjLExMCp4xaTncPDY638DrUaSwXYc4cMvRufCaMddx6vV6MfmQie1SWY4TZ2cp1cA+maSzB9fyZH2xfTPnaz6FtsnVGEXsk/zYDJrroL/zqTXeZ6WP11yigce2/IXLpfkyh/ph1cpe+WWF3Kh16StWYONVXiXqGt4zVW+yySXMkDPooVORPm5b1l6Murh/Cqsa4NaEttTy184NXl6TbTQsC0Oz10hR09MJaL32ovIgEWNpkNVfIeeiTADwPVrrrI+WDuL0h70ZYrroRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(6506007)(53546011)(38100700002)(6666004)(41300700001)(7406005)(5660300002)(7416002)(31686004)(2906002)(36756003)(66476007)(66946007)(478600001)(6486002)(966005)(31696002)(66556008)(86362001)(4326008)(8676002)(54906003)(316002)(8936002)(110136005)(2616005)(186003)(83380400001)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVFejVQVmRRMng3TGwyY0JvZWZ0YmJqODd3bXRQenI0WVZqWGNMcGNHRjFG?=
 =?utf-8?B?aHpWVW9pd0F4VGVHYVRQU21BSG96OTZUNklVRTI4TWVtcUpUTmtLZHdxZE4z?=
 =?utf-8?B?N1V6Z1RLd0JERlhhbnFKVHVqSnFTQVNNaXlBdGc1QndkZVduSHBCR01OTXhr?=
 =?utf-8?B?Wlk1OWFqcnQ2MFQ0TjYxZ1o2RHV2ejVjM2tzTXM1QlBQRU5vQzJsUFNlNXNj?=
 =?utf-8?B?TGJrNlkvbEx6NVU4alhPNjFvV3luMGZPMUxrcldzdXZXSG9INlVVdXdXdlBL?=
 =?utf-8?B?Vllpd0YyS0czd3lCUjlNVElRUmhZaTJoRkRpUVN4MjJPSEZ1QWhOeU5ubjRH?=
 =?utf-8?B?NnM1bUdYZlF1UG1JZTk4MXBPeXpRR0VlVWdpa2wrNERtTkN1bFFjOE1TeFVK?=
 =?utf-8?B?T1RXN2prcTErTjFjN0NIYXJhb2dMT0dOeGJmZHd2Vld6RkZ3NWpMTEtxVGF3?=
 =?utf-8?B?L0VPZldwOXkyNk9HODFFYWhaQ1FaUGlmSTF1WEp2MkF1dGZGbEtmeHRtSmlL?=
 =?utf-8?B?c3hiMmt0VWphS1ZoRyt3N0YxM0NocGk4eDh3c2FvaE5JaFhicGF4em5BS2Fq?=
 =?utf-8?B?bDBvcjA0bnZMRnJPTE10cDcydVg0UC9HRlM1S0ZyM2crbStqcU5LcmgrL3NL?=
 =?utf-8?B?bUx2dlg3L2Z6akU5dkdBeEJ3Yjk4WWlCS1FxRk1SQ1VaNG53V3Fjd010dVFy?=
 =?utf-8?B?T0ZBM0lxNk5wL3lBbS9kRXRnQUpwdmdZUmxqcXdUY0dlTlY1YnVqaisrbDQ3?=
 =?utf-8?B?ejVEczVWN0xLV1Y5ZS9jak1SdkFyTVdxcXRuMVpKQmd4N3BqNk9LZyt5N2F1?=
 =?utf-8?B?SFI0aUNGaEhYN0QvdXcxcGxWWDlMY3QzajVVdFNZS0R5ckNNenJXSVNieGdk?=
 =?utf-8?B?OUpOMS9oeEY3VEppdWdXUFpqcTBrbWVKUk1Bak96THBnKytPUXprclBvYzhD?=
 =?utf-8?B?TGNtcHFjZDRtcE52NktnUXY1S2hySnhuZXdxclliUzFsTXJpOVl2UmsvMW9Y?=
 =?utf-8?B?Skp2amh1RXR5MWdBdjZGeWRmK3Mwd2R0amlDYTR1V0xoUzBGRkoxaENKVDg2?=
 =?utf-8?B?T3VUSTUvSHhRZnBkSE02WEtQRENjMlEyZFFLLzR2TG5yTHVvYThCR1p0WjJ0?=
 =?utf-8?B?L0JWd0NEcnJOUWRERlZleWRZcHo2UkQ0OFJMZlNyK3M0Zm1XdnUrVzBiVWlp?=
 =?utf-8?B?RlZkelRwcWJxL0paOERSWjhGT1ljWUhjTUFleUN6TU8xeTBtWnYyTVFOK0Uz?=
 =?utf-8?B?MGxSckY1eFZUTGJxMUlOMGgvcUdYcWFwR24wNXhNQUFSdDZQdFBUTU0wVHUy?=
 =?utf-8?B?OU14YVI0S3VIMmd1REZISWtIWUtYcW9oY3JJU3Q1SzY3Uk90azliUGFKRDhM?=
 =?utf-8?B?VHpFcU5acFNVNFprK3dZallWS1pWN1RscTRmQStEVHJTN1F4UlkxNU13dWQ3?=
 =?utf-8?B?bGtISTBEZHBZL3NObUV5UVRoNjlxYi9XVG00SUcvR0FrOEZjZGQyTzJrV0lI?=
 =?utf-8?B?NUdHL0x1QnRBbHhxaFJodUswNEFCMldjRVBYdXNnR01jVklwZnI4RUx3MXFY?=
 =?utf-8?B?bTBLbGowYWlHQ0NzdkZuRGI1cU44VFBHbjdORDRmMWFOVTk0OGlGOFgyRW5T?=
 =?utf-8?B?OGd2d29FRjJYNXJhcFVndENReHdkNE5MZGFCOEJDWGtYTUpZSUd1Zko0dHg4?=
 =?utf-8?B?cGVRb2h4YlVTWUlXU1FmVHROMFdtNGtUN3JjRFVWU2oySytBdTVKZDJqaDJa?=
 =?utf-8?B?YmpmaElZRHlPZkhkNXUxeCtDcml5QlZ3N0NOcFRzczJxcW5QUFh0bisrWWMy?=
 =?utf-8?B?cUowWXlmamc0RGFrNzNLTG1Ham80R3BabXdIREdEYVdqNzhBTDl5RGJwZml5?=
 =?utf-8?B?WUFKWlZRVHZxMk4ra0w2cnk0bVZ4WDZRcHFhQlVpNFZLYnlXRGpYWm83UXE0?=
 =?utf-8?B?KzFsTnUwV1ZOZU1GaVRQSGNGc29DQkxxZnVSdXVXSDJCK3JYb29WYWM4eWhJ?=
 =?utf-8?B?ekd4RHJkczlDYWR3Mm1kbExHM3ZhQUxhTnN6cTFBK016K3NZU2w3bEV4SWM2?=
 =?utf-8?B?ZmM5VUVKYUpwYUxNUlpuSlQrM2JWT0NLR1g4VjBIWDg1QWJwRHFqdTlCeEJ0?=
 =?utf-8?Q?2L4VNfMdnmz59NROGXNmGqZXN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76036e7-acf5-4f8a-b48c-08da7f09d8b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 22:02:29.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsMbehYSZ0NRLRBJ5kwEiYuE1w8T8vPlv0vi63shzAfO7+PilYEP3AJ0iX49acozOAo+kulj/odiMdEGvy+esQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/15/22 16:08, Dionna Amalie Glaze wrote:
>>
>>
>> The unpredictable performance of the application early in boot may be
>> unacceptable and unavoidable. It might take a long time but it could
>> eventually generate bug reports about "unpredictable performance early
>> in boot" that will be hard to track down unless accept_memory is observed
>> using perf at the right time. Even when that does happen, there will need
>> to be an option to turn it off if the unpredictable performance cannot
>> be tolerated. Second, any benchmarking done early in boot is likely to
>> be disrupted making the series a potential bisection magnet that masks a
>> performance bug elsewhere in the merge window.
> 
> I'm doing some boot performance tests now before I run some workload
> memory acceptance latency tests.
> Note that this testing is on AMD SEV-SNP, so this patch series on top
> of the AMD guest patches v12, plus a
> patch Brijesh Singh wrote to define __accept_memory for SEV-SNP
> https://github.com/AMDESE/linux/commit/ecae2582666d50ce1e633975d703d2f904183ece

Note that there is a bug in Brijesh's version of the patch and it will 
almost exclusively use the MSR protocol. Please try the version of the 
patch that I recently sent up based on the current unaccepted memory tree 
from Kirill.

https://lore.kernel.org/lkml/cover.1660579062.git.thomas.lendacky@amd.com/

Thanks,
Tom

> 
> I was getting pretty consistent boot times, only going up slightly as
> the memory size increased, but at 256GB, the VM crashes because it
> touches some unaccepted memory without first accepting it. 255GB boots
> fine.
> 
> The stack track is in mm/page_alloc.c. I've done a little
> investigation, but I can't account for why there's a hard cutoff of
> correctness at 256GB
> 
> [    0.065563] RIP: 0010:memmap_init_range+0x108/0x173
> [    0.066309] Code: 77 16 f6 42 10 02 74 10 48 03 42 08 48 c1 e8 0c
> 48 89 c3 e9 3a ff ff ff 48 89 df 48 c1 e7 06 48 03 3d d9 a2 66 ff 48
> 8d 47 08 <c7> 47 34 01 00 00 00 48 c7 47 38 00 00 00 00 c7 47 30 ff ff
> ff ff
> [    0.069108] RSP: 0000:ffffffffad603dc8 EFLAGS: 00010082 ORIG_RAX:
> 0000000000000404
> [    0.070193] RAX: ffffdba740000048 RBX: 0000000000000001 RCX: 0000000000000000
> [    0.071170] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffdba740000040
> [    0.072224] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000000
> [    0.073283] R10: 0000000000000001 R11: ffffffffad645c60 R12: 0000000000000000
> [    0.074304] R13: 00000000000000a0 R14: 0000000000000000 R15: 0000000000000000
> [    0.075285] FS:  0000000000000000(0000) GS:ffffffffadd6c000(0000)
> knlGS:0000000000000000
> [    0.076365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.077194] CR2: ffffdba740000074 CR3: 0008001ee3a0c000 CR4: 00000000000606b0
> [    0.078209] Call Trace:
> [    0.078524]  <TASK>
> [    0.078887]  ? free_area_init+0x5c1/0x66c
> [    0.079417]  ? zone_sizes_init+0x52/0x6c
> [    0.079934]  ? setup_arch+0xa55/0xb6d
> [    0.080417]  ? start_kernel+0x64/0x65a
> [    0.080897]  ? secondary_startup_64_no_verify+0xd6/0xdb
> [    0.081620]  </TASK>
> 
>>
>> --
>> Mel Gorman
>> SUSE Labs
> 
> 
> 
