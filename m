Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC056F5E80
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjECStb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECStG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 14:49:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B176B2;
        Wed,  3 May 2023 11:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtQXG52Dlil5yQhcujPlxu6s9kRYW6A+fzBZ/lx4DXAfzzA21gJ4Ks9bNgSKeDHpjYUZfNnWBngIhUoXOqBYADa0rBa/IFZxjtkMSnBgWVXMpXVN/Gf0jZYU4RZr6TLSMWoUAp5DbxQ78i3qyM6h58NWbrUQuVTBmRlEy/NVMC6qwR5a+ghycY4EOtfBGhvEb+eyN55dcqwnB3uvsgg1JtX+SXopzlWHQraJEUQXje95uQD/9s2Ij1vuv2Hqn3hjnFYLTzNbfBXDCJSmgjyM8yvVMQefUZRmxTa+BcMvDbIdxekSgSinlfwy8zzsQUH8xtEuXNlWBGYtxuF7dPxd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNyZGrBt9gFuTwCsoKOdWzlIJLC0tuMZ+ujH7vIalws=;
 b=IIBIlwqu2CXnHUmG2N8zaIpqLqq8P7stFZBB0ajJzN2OQIY/XamZS+SrgLCaWmAKVqSm+Ru9M4cuzK/7fgTZ42NfA8c+cHJ8EHfCZgyAK8S3p442UR7AD/qyk03k8ldW1FMUMz1DgZJ29yZxH221P6+eWxfs0qVCo1/d82aBavUA4uzdecZ5YlJY5Oohe8f0uSIpn1acxcho48oPQHuPLgLS0FPK24r6hdp/OHY+U7t05OXvAGrdfbby37JLwEnjvqg65ggFj/nW48j+DSMW+GLYPouVMLoMFFkKzuv1q0zcSrK650dcu5WygCm0XKaBaj5+qHQYLGXIuUInscLwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNyZGrBt9gFuTwCsoKOdWzlIJLC0tuMZ+ujH7vIalws=;
 b=cKpGDG+KYiTBcSDuVYz+JC9WiPOVBpf2F68EK0ZYIbv/DmDjauV+eXY7EKZggSNR1AQLXhcUiftOL2Bc0ItGDx/3HybNY6l+0HrSltRDYhij4X5p6i6a333bA4Mat8et1T4IJnulWVeViZA4MwlSBbg91oX66QQG5D/2ZvYtsKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:48:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:48:57 +0000
Message-ID: <d06086cf-3bb7-0ed1-b877-c94b5ef89fc2@amd.com>
Date:   Wed, 3 May 2023 13:48:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
 <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
 <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
 <a6846282-95c8-274a-accc-ffa54205489c@amd.com>
 <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
 <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:610:74::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: b914cb40-055f-459b-2d5c-08db4c070d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUpNBMwvAwaigy+w44x/h19soPij1NBHujVydk63FMb3HTDx0bG9tigL7zzB13yS7Uyb+jZ9/UvsJY5LESwj5tGwq6Z/VpMBPcWm2bO0ZYUnGHTFME4KNzCR43lAOJiFJz27Lbrp53+8f/GS5DeqYe57RuG0qL16JlICsyOrJwbEhCZe7eJg+htkrCWuCMDgFv/aI726r1FtuNbX3PuyEUBr7K5qfBOZJqSE26ZjFqDNtt3TDbaYcGnveyHSt6mqe8xTQHnRCpORyGzq2GSkglfa+AWqPQ0vAwZGa6B+b9qbcvGb7ZHMZprdaN1W4JKWixLZZpPOLPXn6W2MSEhuWGXM4WrULCVMioJtNXzGuUhE1VQhP33ZYgX7bRyD1MZV5lihKcmnnYouE4pD0YiS/BGofDphEUseVqm625r28RInZ8YWzN3UerFTyYhZSScB3yp2hH+YXo8E4EJw/eeajmye1hzsoRz79V9MLjMWidWPhKbu2+DM2p1GTB+mF1EX7oyKqyavLEwCjT0sG3sSup/S9np2RBkTW6jVGy/WV7J92OJzVANDqV8lG9qqhDCnUbGpSTLTzkXGB0MeDOKjsrL3BYi0JUAomZZu2tRaClGR5k3K3IQbm6JsAtKS2+Ciub7rkmP5t09FIhBErFSACw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(7416002)(8676002)(86362001)(36756003)(316002)(31696002)(6916009)(4326008)(478600001)(6486002)(6666004)(41300700001)(66476007)(66946007)(66556008)(5660300002)(8936002)(38100700002)(2906002)(83380400001)(31686004)(2616005)(26005)(6506007)(6512007)(54906003)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am12eXQrUFFXNUxnOVdKRXBCcHlON0Y3SmJwcnRnOUJQNWpXZkMweFl0ZjFB?=
 =?utf-8?B?MHl6NC9ZcGsyVlJWSllsK1FURHNyWkxtMDlvZ2lPYktYUlNxVE5vMG81aGl1?=
 =?utf-8?B?ZHFJMng1RTFJQ1RteGF2R2txK1FHdkpra3MvNnNjcS9vR01KS3Q4R3NTR2Yy?=
 =?utf-8?B?SXA4eWFQVytDR25kWlYzVkJwS3k5Wk9ySkdtdVN5SS9kVUtlRVQwMzhRRTM5?=
 =?utf-8?B?Nmh2NThHMDNiQzZ2WWVXVHQ5ZGJ5K0pnSGFrcXZhc25FQVhuUGRaenIxWHBu?=
 =?utf-8?B?NmdEalI0K1BTZzRXNHk4RGpTVTFGQ2NrbVpIcHQ3eXNNbVpvNlV1Q2tsZDUv?=
 =?utf-8?B?MGdRb0VPTDEvZ3VRSlAxcFJaSHJkL04wNVlpMmxyTlZheHExRk92dm8rSWd2?=
 =?utf-8?B?NkFsa3JobDFyZmkwMDdlV1pKRHNnRXBkY1grQm5rYVBLOTErblJSSlBveXU1?=
 =?utf-8?B?bjcxRTkxdnlKNDRTaTdkaGtIQUc4QzlJbmoxbWZyMnowanFWTVZFbzVGMGY0?=
 =?utf-8?B?c2ducmJyQ1NMTmNJcXdBZzJZejU4QzBLYVZNQ1ltS1R2OUZDUk9FM05zaTBL?=
 =?utf-8?B?cXdSL3orZjRlaUNJUXhUeXNydytBT3QyTWZKRlZaQkN0ZytJQjhkY29EUUc4?=
 =?utf-8?B?dXh2WEtPR1lTcXBjUndBNzV5NENwY0dCa3BJRkNoa0lYTndxOUFkR1ZKTy9B?=
 =?utf-8?B?N0dvMmdxWXJYdGFSVnpONGtxeUEyVTZzS2d6a3VzTlB5RnR4OTVjWXhURlJZ?=
 =?utf-8?B?NysxQ1oxNUxPcUlqRzB6MW16Z3NuM24vZlh5VVRISXFtanpJOGp6Q0FGbjhJ?=
 =?utf-8?B?bURVMnRjV0FSaitDRGNaOUNPc051QnpVeXcweXNWNWlhTkpQSEIwUzdZSEFs?=
 =?utf-8?B?NHdOZXNsV2s0VG9TM1pnaE11Q0lXTFdkaUtCSEQyY01HL2NpR0lFSzRtZHhW?=
 =?utf-8?B?cHNwaHNKaVdVdzJDektGc2QxbjdLdDkvS3FvR0loL3pCNzJBQ05JeWtVcEhj?=
 =?utf-8?B?K0psTW1BcEViRlRPdFAxTjVGNlpQU3pCV0Zrbzd0Rnl2di9aTjhGeWo1NHlJ?=
 =?utf-8?B?bVdiZ0dRZm5kTmYvRitQRjQ1VGVSWHZleXNnZFBBNU1IR21hUkxSb1RhOE9o?=
 =?utf-8?B?dmc2NzBSQTFKclJCTVBxL05tcVIxT2xzQ2tnNnpMSTR2Ly8zbVpEKzd5bTRN?=
 =?utf-8?B?WG9tdXJDSlpNMm5kNTBuTHpYSkhiYmdRdVhWbHNkQ3cxdjZYcXdhem1vVllp?=
 =?utf-8?B?bE5iUHM0SDFvaFVmTkF2ZHcxamw2MEtHamZCYlN5RU1XbisrR1l6eHNNanll?=
 =?utf-8?B?ajNiL3o5eHFMblNEb1h0UkFESXlrK01UNkYydXF0cWxrZ3d5REFGQ01QZmFo?=
 =?utf-8?B?VFhPRVNGUXZhS1Qwa1ZYNnN2YldIQmZSRndwbHo0WFlsazVwS2NDbk1KMVU3?=
 =?utf-8?B?aU9hNG1jUzk4VFhvZHVNR250WE95bSt2R0JiZFJKWkRVQk0xNG93ZHZ6WlBL?=
 =?utf-8?B?UVBDaG4zNC9DV3JOTmxac251SEZ1Qit5eHVyYWxmd0Fxd3pIV0N3YkJINWFs?=
 =?utf-8?B?MndhdWlLQmRDVHpZTmNEcTg0c3M0TEJSQnh6MUZ0QWswNlBHUnl5c0YwVlpK?=
 =?utf-8?B?WU5OVlF1YlRwYitZazBSaVdBRnpHNWhZOHgvMU5zMXg1a090TU5wT0ttc3dl?=
 =?utf-8?B?bjlDNWxISW5nTVBHY0lQRVdTM2Yra2c5UytCcXdqem1BQk1ZaHVmOFZBc0Zk?=
 =?utf-8?B?a1BUZGJoMTVRb2RScDJDVkRpaDQxSmh5TGxwcC9HZE00RXFrcXVUU2d2bEUy?=
 =?utf-8?B?TFhqS3d1c1N6QTNGSVJ0bHhGbkh2cXdOWmptc3BJOUI0R2NzQ1VSa2xZcDJr?=
 =?utf-8?B?bnFieTFnbG1JU0RsL3ZsQUxUaWl3cWcxWUU4eWl5MDUrQ2I1cW5sbms0V2J2?=
 =?utf-8?B?cXZTUU9ENmFiVzFSSHJHS3JxLzBtTHN5Z3V6cUppclVrMHczUmpoS2hHV2ky?=
 =?utf-8?B?KzlLTSsrRzFKUUt0MXV2dU9pYktzMzlna1poa1RLZERyVThNbVYra1JPLzBU?=
 =?utf-8?B?MnRqZngyYWwxakxaNzZXdlhnOFhDd2szeitOc3puZ2xFNEtKa1dQM3FIRDhv?=
 =?utf-8?Q?kdhoYJpKC/Ue/qVsKNq8bzzyl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b914cb40-055f-459b-2d5c-08db4c070d22
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:48:57.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXkXpf5lUmQJUEn20BxYmjMQQTcgWtsyDEoU6DZBKdhc0T4+TMusCpSVvPHa3Wj0ERWCsCRDD0dwwVkIJuxT0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/3/23 13:17, Ard Biesheuvel wrote:
> On Wed, 3 May 2023 at 19:58, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 5/2/23 11:08, Tom Lendacky wrote:
>>> On 5/2/23 08:39, Ard Biesheuvel wrote:
>>>> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>
>>>>> On 4/24/23 11:57, Ard Biesheuvel wrote:
>>>>>> This series is conceptually a combination of Evgeny's series [0] and
>>>>>> mine [1], both of which attempt to make the early decompressor code more
>>>>>> amenable to executing in the EFI environment with stricter handling of
>>>>>> memory permissions.
>>>>>>
>>>>>> My series [1] implemented zboot for x86, by getting rid of the entire
>>>>>> x86 decompressor, and replacing it with existing EFI code that does the
>>>>>> same but in a generic way. The downside of this is that only EFI boot is
>>>>>> supported, making it unviable for distros, which need to support BIOS
>>>>>> boot and hybrid EFI boot modes that omit the EFI stub.
>>>>>>
>>>>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
>>>>>> it to execute in the EFI context as well as the bare metal context, and
>>>>>> this involves changes to the 1:1 mapping code and the page fault
>>>>>> handlers etc, none of which are really needed when doing EFI boot in the
>>>>>> first place.
>>>>>>
>>>>>> So this series attempts to occupy the middle ground here: it makes
>>>>>> minimal changes to the existing decompressor so some of it can be called
>>>>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
>>>>>> the kernel and boot it directly, without relying on the trampoline code,
>>>>>> page table code or page fault handling code. This allows us to get rid
>>>>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
>>>>>> invocations of the EFI firmware APIs to clear NX restrictions from
>>>>>> allocations that have been populated with executable code.
>>>>>>
>>>>>> The only code that is being reused is the decompression library itself,
>>>>>> along with the minimal ELF parsing that is required to copy the ELF
>>>>>> segments in place, and the relocation processing that fixes up absolute
>>>>>> symbol references to refer to the correct virtual addresses.
>>>>>>
>>>>>> Note that some of Evgeny's changes to clean up the PE/COFF header
>>>>>> generation will still be needed, but I've omitted those here for
>>>>>> brevity.
>>>>>
>>>>> I tried booting an SEV and an SEV-ES guest using this and both failed
>>>>> to boot:
>>>>>
>>>>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
>>>>> z_stream
>>>>>
>>>>> I'll have to take a closer look as to why, but it might be a couple of
>>>>> days before I can get to it.
>>>>>
>>>>
>>>> Thanks Tom.
>>>>
>>>> The internal malloc() seems to be failing, which is often caused by
>>>> BSS clearing problems. Could you elaborate a little bit on the boot
>>>> environment you are using here?
>>>
>>> I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
>>> host/hypervisor and guest kernel and the current OVMF tree built using
>>> OvmfPkgX64.dsc.
>>>
>>> I was originally using the current merge window Linux, but moved to the
>>> release version just to . With the release version SEV and SEV-ES still
>>> fail to
>>> boot, but SEV actually #GPs now. And some of the register contents look
>>> like encrypted data:
>>>
>>> ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
>>> !!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID -
>>> 00000000 !!!!
>>> ExceptionData - 0000000000000000
>>> RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
>>> RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
>>> RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
>>> RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
>>> R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
>>> R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
>>> R14  - 0000000001000000, R15 - 000000007E0A5198
>>> DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
>>> GS   - 0000000000000030, SS  - 0000000000000030
>>> CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
>>> CR4  - 0000000000000668, CR8 - 0000000000000000
>>> DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
>>> DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
>>> GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
>>> IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
>>> FXSAVE_STATE - 000000007FD96F80
>>> !!!! Find image based on IP(0x597E71C1)
>>> /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
>>> RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!
>>>
>>> So, yes, probably an area of memory that was zeroes when mapped
>>> unencrypted, but wasn't cleared after changing the mapping to
>>> encrypted.
>>
>> Yes, looks like a bss clearing issue. If I add __section(".data") to
>> free_mem_ptr and free_mem_end_ptr in arch/x86/boot/compressed/misc.c and
>> to malloc_ptr and malloc_cnt in include/linux/decompress/mm.h, then I can
>> boot an SEV guest.
>>
>> However, an SEV-ES guest is triple faulting. This looks to be because
>> we're still on the EFI CS of 0x38 after switching GDTs in
>> arch/x86/kernel/head_64.S by calling startup_64_setup_env(). Before
>> switching to the kernel CS, we take a #VC (from CPUID calls in sme_enable)
>> and things blow up on the iretq. Moving the block headed by the comment
>> "Now switch to __KERNEL_CS so IRET works reliably" to just after calling
>> startup_64_setup_env() fixes it and an SEV-ES guest can boot.
>>
>> This worked before because I believe we switched off the EFI CS as part of
>> the kernel decompressor support and so this bug wasn't exposed. But this
>> needs to be fixed regardless of this series.
>>
> 
> Very interesting. I was under the assumption that everything that goes
> on in sev_enable() in the decompressor would be rather indispensable
> to boot in SEV mode (which I only spotted today) so I am quite
> surprised that things just appear to work. (There is some 32-bit SEV
> code in the decompressor as well that obviously never gets called when
> booting in long mode, but I hadn't quite grasped how much other SEV
> code there actually is)

The sev_enable() function for SEV and SEV-ES is more for ensuring a proper 
environment (ensuring the proper CPUID bits are present for the guest, 
checking the GHCB protocol level, properly preparing pagetables, etc.). 
Since we're still in EFI and using the EFI #VC handler and pagetables, we 
don't require some of that stuff, but some of the it would need to be 
performed at some point (I wasn't trying to be a malicious hypervisor).

I haven't tested SEV-SNP yet because the hypervisor support is not 
upstream, yet, and I haven't applied your series to an SNP hypervisor 
tree, yet. There is a lot of support in sev_enable() for SNP that may 
likely cause a problem compared to SEV and SEV-ES.

SEV-SNP has a lot more checking and validation going on and it ensures it 
gets the confidential computing blob from EFI into the boot parameters. 
I'm not sure when I'll be able to test SNP, since I'm off next week and 
trying to wrap up a bunch of stuff before I leave.

Thanks,
Tom

