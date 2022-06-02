Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4068153B92D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiFBMv5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jun 2022 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFBMv4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jun 2022 08:51:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82621B6;
        Thu,  2 Jun 2022 05:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AovHMVWdeFHFplBbQg2BGK/p6hllEFq1NXzw+dLciWSGq4bH+EUgE0FRwiGA8nmcIbsnnTVc5RM/IdvRGUzgX3FenGZbSFO1BsLUb9P6/87rG9zpFH1CPuUN5wOJFQKMCpPvx080BRxdmQiNoBvIAq7XtAasil8qSjJFT50vG5K1cd+DCQ1jLAEFO4WvWoEUgQ0Ie33Po/Ka/5wZ6rdyBDcSWRKdRsuHpsf4Wjpk8Q35sSR/P0oXFP/I4umH+Ii8pUlVXLAwK8RtnCzo+t6KJo3ZUxqdF3xWyhe/2DOXWB+ObjKCnyiElZZC0k/1NO7yd7aeoBapAOuxkQlXP5xvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlDgL+3vM1ZemTOGu0CKLB+mv+Gf0hO0DHDcXgUEIpI=;
 b=WkAUpyXfokRFP6idWlRuqhrnBakeRQZrs4qLaBllS3sLEYVZpB9NtbEtXJT3G3Y129F5bT9XaGjI43vRLyyuTsoAaB98Aff7Tg14S+ertQEH5sbMsYrGNsFo9gu9AiN5t5fZ/C4B1RPXcKvb2A0cyK2bi/VBHDg5ogC4S24wix02VNTv6/wWDNKpHSiTSrndc24aFX6mvYMOhEVXsiDiHU+ER6ffMMKtePoiphcWNevyiwrANRVhZYW1rOxtIbV5+QyvgFSlKm3UqHSiXL+cJmODy43HjkY3J3ocEAySwztaycF8P0UNeXFSBeHzxVsPPxpvoMqRivKwYUsaBgf64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlDgL+3vM1ZemTOGu0CKLB+mv+Gf0hO0DHDcXgUEIpI=;
 b=nqb7C60oK8rpEPJCgR1YzzK1zbXNQ/yROh95JnmIe2CO33kDWxyTgp3/f/0zevfqAwY7YbKLuL8oRufHyDLs+2ckiuf5j5s1s47LyGwrH5a9kAlWwSimaZeHzUFl3jR0TYjRUSWUxHfDEF979DchzrAGnmPnda806HIXUJjUDcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BYAPR12MB3030.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Thu, 2 Jun
 2022 12:51:52 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5293.021; Thu, 2 Jun 2022
 12:51:50 +0000
Message-ID: <19ac7bbc-82f1-8350-8638-163303d682b1@amd.com>
Date:   Thu, 2 Jun 2022 14:51:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic>
 <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
 <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
 <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0053.eurprd06.prod.outlook.com
 (2603:10a6:206::18) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e98fb484-025b-46a5-1ae2-08da4496a8cb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3030:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30304A138B856B16517CA60F9BDE9@BYAPR12MB3030.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRZlyCR6F5yiwH6ZeRg7RekfNToYS+trnbKFQc0Qam4jSvThq02PpzNNlirIcUySkCRDoHTZ9Cd44cKh7cOuFYE9VRRoiK3st94eLZeTCLWCBDtu3BbIOo5v5gNLzrkLe9pvdGOy++HBRNborgzbNt8T/nDcoPmFHwNvh2C8lSdzHHegXgvrP+4rwclT20UOxFv3kh7wv+yHr37JgaDGmmQESDY98j74oQnNjqEK3yaRkKVYDJP1PVFaG+hd0y4x6h535NX9rwYLv87Gm9jr/02ST5AcylkNtnbN0u2dO/NUDZ2jo9he26ZZIrOS3F+L+Di18Ij+8+T/DqZQfNEJVE2tVY7C3pafFkOPTEmmDjNAt/MwAHosqThZq/rTCJv7wdVisMIk8AthRrajaZGuRko7gMl+Rntqc19KDDgMQlBVQsbYRwM3NwETWQETB0Tw2z3W1Hc7gWB/ntFXtvz9+HPzv9vsBvK3WlcNIkahrGimD/tbKK2Zj/H5CJOVyzLlrNX98OMJayU01He1UTETrXI29lpiZtdtq9rIyg78UGJzS0pyZeGJ7L6O/JZmt7KnTl6AYyWLpeYC1eEIS/vslQSpk1VJOhOQJu8W3e+dwXpxLX7W+Sno9JZyULaoCpfVWlapvz6PyH752NNaf71dAnzx5rhSV/hAuk28t3ElUw+RuZV9xOPU2zTI18nejGeKKE9J8C7qGIIWab+Ff4Q/xRG2ftlyyQ1zbdNAT4WvWs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(83380400001)(508600001)(66946007)(7416002)(5660300002)(66556008)(4326008)(66476007)(8676002)(6486002)(186003)(7406005)(8936002)(6512007)(38100700002)(86362001)(2616005)(6506007)(6666004)(2906002)(6916009)(54906003)(36756003)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBvaUZ4VnVNeW5tdEJNVVU2SXpQOStaZjdOSEM5RU9NMHRxV25pQmRscG9p?=
 =?utf-8?B?ZW5qaWNxbFZTSHNrM1VCbTlRa29IMWRmcHhQYXZiTUwxU0FnemZkVngwMXZE?=
 =?utf-8?B?cFQ0bEJNVHpCeXFnNVNRVkx0eVBKM3BCU1BhRWRDTnBOWnRyZVR4b3RIS3hS?=
 =?utf-8?B?MWJURElaMk05UWc3UERGd2dNenp4YkFXeXBUdU5uUm1DNVNNK0ErU3hrV2V5?=
 =?utf-8?B?MHRDZUE1OU1MWjZ4dHFaY0pxYW1ielpBMXJVREpmR3UyZ2FTQjZBOE11emkz?=
 =?utf-8?B?QUF5VUVPVWNJRkg2c0hPOEhXZURxMVB0VGdOQkRPZ2h4TmlOT0hpeGZQcU5m?=
 =?utf-8?B?R1lDT253OGtPY3JmUytqOEgzRVE0M1ZGRVo0Y1lXeGRHWitJLzhwOUF4LzhV?=
 =?utf-8?B?YzBidnNZS1dCeThpMEhsamprMms0V1BqbTdUdHdMdlR1YWl1MDRDekllUEs1?=
 =?utf-8?B?aVBHRUk5Ty9LZ0tFRjRFQTRSaXBnMndvS1dIaHIzS25YWm1tT0pRVHZ5R1Fx?=
 =?utf-8?B?clRrVXVTY1pOaGpsZmZaSFdGV0xRNWk0MHlhMW5HQTdFYlZQbVNpMTQ1R1Ux?=
 =?utf-8?B?ZkhXdjBNeDBTOGZzTmc4bVlWcElMYWREcUowNWlqRkhCV3JzeFRiN3J5V1h2?=
 =?utf-8?B?YU9JTTk2K0N3UW5XQ2NtZDV6SXZlKyt4dmlseWFWbi9xSVBRYlRUeXhkMW1B?=
 =?utf-8?B?ZWkwdzRWUmtIcStzWmxTTGNwbDN3TWlkVm5UNlp0T0xZam9iVnp2MEk5Tysv?=
 =?utf-8?B?UEF0NU9sM3JBTkhQVDNoblNWTTFodXZBblJEUmZCSFpnL2NEdnpxTWJWaTNJ?=
 =?utf-8?B?dzBPaUE5ZFBkeklJS09oOStTTW5kR3ZLSDNxOHBlQzRwZzg2MlFxdTd1QVBD?=
 =?utf-8?B?Rm5zWDIvOGFlNGoyTExGb21JK0xDV3RFM1NhZ29GU1IwS016eGVMNUhnOFlu?=
 =?utf-8?B?UUR3YndJb2pDTzFYNmxlZDhXT1lWSVgzaE9STjBuUFpZajBia2VRcWFManoz?=
 =?utf-8?B?cDlVaDdzZ1hkSmFhWmJONjJDaG5XR3EzYW5WWEJxTWdIRzk5MXpveE9LZzlX?=
 =?utf-8?B?RmVWWTNiNlI2a2pxMXNWa084QmlIQStQNVdYL1NOTXNodzV0NElBS3B1R2ZR?=
 =?utf-8?B?dGI5RlUvUTdYeW8yS2FuTFVINnprVmt5Ty80MEJuY3c3c2ExNzltWGJIOTNu?=
 =?utf-8?B?SU15ckVQQmJERXJwM3dId0tpWkVPcFNSd1RuNmt2OFZYRTRlV3NYZGJ0bEJq?=
 =?utf-8?B?bTllcDk5dlUrUXBNd09YN1JLakV3c1RycCtjRlBTdDc4eTFuK0hWc3AramtM?=
 =?utf-8?B?bGhpUytSaWxySzBYenB4OTFrUHhTMXNFd3J5VndqRGN5WVQrUGEyNEY4djRX?=
 =?utf-8?B?VlZrUjM0UVN2bkRHbmMxSmVEQkNPZkFuRmxXMnJMTHBHY253WHJzQldRc3c2?=
 =?utf-8?B?STFQQU1rQmZIaUlKdExvWEUvajdKRG44R09EMExaajRWdUtXK1luaXdVL2lH?=
 =?utf-8?B?TitOR3pTN0xjck0rVW9JZFlsMWdVVlFWWEJKM1RmQ2Z5UFVzS0g2b1JZUXJZ?=
 =?utf-8?B?anplWnF5ZlZJSFZ5ZnNlclNCL3F6MjcyektjUHl3dEhxYTQxU2JLaXJxQWhp?=
 =?utf-8?B?Y1JlTXlKYU0yeHlKU1BpdUZBZWVyL2JVVWlFTFd3NzFHZU10dHpyVHdEWkF0?=
 =?utf-8?B?L1RCSFJYcWx2eUVEK0pocGpsSVZhZjFQTXVRNFJhUzZxSDJqRVhyR1JBNWpv?=
 =?utf-8?B?djI2VS8wb09qelYzMW9jRFZnWDQvTHNRUWZ0RmxvWG9wR1ZVdkJDZ2Qzb1dt?=
 =?utf-8?B?M2ZnRGZ3MjBJK3hsVDlsYzB0TytFVUx3VU1ydlYxL1I0T1RvR3NJZVNUNVZz?=
 =?utf-8?B?Z1Ntb3JXcjhUemVwa05VRVNjVDJCMUVJVWlNSXFGWTF4T0w4bjlOT3NWODh0?=
 =?utf-8?B?azdpczgxbTdBTE80cDJNckhGMytJcmk0Z3BtcFR5TTREVy9pZFJUTk15cklG?=
 =?utf-8?B?MHR6dFZiRFJuV1d2RHNJSC9jY3J5dkFqak8xcENUNjJ2dzVYcjF2WlhLU2hI?=
 =?utf-8?B?V1Zjd2hSY2R1ZGVPdE9UODRIeXBOaXRyNTA5My9NdFBFQWt1RUMrWndSa3A4?=
 =?utf-8?B?aVAxSDRROVA1YUlqY3ZrKzNRMEYrSzgxRmxDT0djM2I0amFaeWFxdlI4a0ZL?=
 =?utf-8?B?bVEvdE1LU3lzRjNORm9oVUdLR3B3WExpbFRoeFRtSGJ1SFRNQ0hJaXhKNnhQ?=
 =?utf-8?B?RURCejJBNzFBK3B0TTdnV1dYSVh3b05VYzU2amRidXVneDNRa2MxRW9iTHlC?=
 =?utf-8?B?dnVCSVZSRFJhelRqbkJLT1ltODgxUVRJZTlCSS9WNDZlVjJsZlhFdzErOG1G?=
 =?utf-8?Q?Dk5zkSD7g4m58xIbivlhDxs7YHlb72kpfiGHav6x8QREi?=
X-MS-Exchange-AntiSpam-MessageData-1: 5ewzZEGnxtf5SQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98fb484-025b-46a5-1ae2-08da4496a8cb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 12:51:49.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPgaO5Jyqs+JIPs/VVDX18FD1DiA3RbX5UuCXTUFtJhzEfPgCg/8DUEbWN7wzT4fOSm8g7LiXORgpt3uTiVhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3030
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> The memory accounting in Linux is probably the issue. Both times I ran
> the test were from a freshly booted VM. The test parses the output of
> $(free -k) to determine the amount of free memory it should allocate
> and write/read from, with a given stride of pages to skip before
> touching the next page.
> 
> We grab the third column of numbers from the Mem output that looks like this
> 
>                 total        used        free      shared  buff/cache   available
> Mem:        65856604     4128688    48558952       11208    13168964    60942928
> Swap:        1953788      118124     1835664
> 
> So my workstation has 48558952 free bytes. We take that, give it to
> memtouch to allocate that much anonymous memory rounded down to the
> nearest MB with mmap and randomly read/write the buffer.
> 
> For an 8GB machine, the UEFI will have the initial 0-0xA000 memory and
> 0x10_0000 to 0xC00_0000 (beginning of mmio hole) prevalidated. The
> next 5GB is classified as the UEFI v2.9 memory type
> EFI_RESOURCE_MEMORY_UNACCEPTED, 0x1_4000_000 to 0x2_0000_0000.
> The Linux e820 map should see that range as unaccepted rather than
> EFI_CONVENTIONAL_MEMORY (i.e., EDK2's EFI_RESOURCE_SYSTEM_MEMORY), but
> I think it needs to be accounted as free conventional memory.

AFAIU the unaccepted memory also stays in buddy (first via slow path) 
and should be accounted automatically in free?

> 
> So when I see 2044MB free vs 7089MB free in my VMs, the two are
> roughly 5GB different.

Is it possible all memory got allocated with memblock? Maybe some 
variable tests to validate with '/proc/meminfo | grep UnacceptedMem' 
would give you more clue.

Thanks,
Pankaj
