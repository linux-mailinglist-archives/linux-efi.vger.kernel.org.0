Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A96F5E8F
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjECSwD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjECSvn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 14:51:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049883FC;
        Wed,  3 May 2023 11:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSO58dfcvY4SSq/T1y1jNr7yKRrhrjFZ0sM8rfThnxI2lw00RGmBLS7a7Nstbx//HIzYGPJbjTypWNSX+4nNhAjSNki62zoglSbfFjfgjZ+dWeTY8gzK37dNn4JrQUWmursKKk1QG5kpeCzYXp1t0n3aK/1BKwt+PK/W5pa2GK3twyfx1UdSaHvLQLzS4NbF4AjzHhdsPX3t+gxfb/DWJYeQ2aDlAAQ8Dyh7cyZJaTvxjC/0XPCMIthTCTsD9VWuLMYskvBptV2UuYsvjb5t2DO1CH6a/WHJnEA8Umf69r/lBqzqBDKGDi77aXSQkZvAYsFbrDumsDB4q7csKOSEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSDTE+G0SfmfDtSt1T15ATN9Wb+c7qIm8CZyCLM/dhI=;
 b=eqV/Y0094qnAB3eBl+RAU/zwq5C8oe9YeRIbWSwGaHvCdfTdvgfAVcChoPQ/ndZqN03A7+AZui9VE6FU71M0NAn3wkryHtrFCt82U7j9UDDPcI0vKv4qmuZkPhyuwJhth+OvwmECgXqMVfb9QpLikvzzNBHyFHZ0zNECrIZ40bvMGCy9UWeXBhAKAfTQPZM92YiOnBlVzwfh/nfp2+N0LeD1S9Z/45Gc5jnnqLdp60spdYjjQZbJjdw9rj8udxfsTrERVhI6+lfyheXVE2qG7b/W+NFOmn+riNuAX/jgknGobEkbT+a2ydCx97Z4b5a4Ckw6LL5P3r0nO7R1Q2Fjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSDTE+G0SfmfDtSt1T15ATN9Wb+c7qIm8CZyCLM/dhI=;
 b=ejVKtnkD2TliiPBQPYiDy5t6ETge7get2UWRB6lvlQDlcdSG8nUION3ikoD/4IW+mIn8j7CzkzLlgwOMlp/NVOLChhlePT9D3Aordow6+ZsRWR1xasrq6JHafhDMcrWYCL1PsnseXoW+h9WXyRXxU61sJdOTXbAf+Z0YiwV7BhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 18:51:15 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:51:15 +0000
Message-ID: <e358dac2-b599-6892-2287-44a10406cdb0@amd.com>
Date:   Wed, 3 May 2023 13:51:12 -0500
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
 <CAMj1kXFaZi3ARU-8U30dNw0LwCc7Vw7Tybe_vYSpW_-_GOAFKA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXFaZi3ARU-8U30dNw0LwCc7Vw7Tybe_vYSpW_-_GOAFKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::9) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 794af9f2-db4c-4d0d-ea4b-08db4c075f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32PypuhxKLnPJwcd/jZiKecYBLk/pdjx3vL7GQw5FCsRWxFwKjbVwgLNE26Aj7wkKtzT0wWJfZ95EsPP91OJrPwmWKHtCCJLRQd4yf/UiBhmPMms8SE3G5RT6jcg/aJYpzEaE5yB3lp2SbYuJbsvZ+HePq3cXRlLstq5qFHj97iOSv4JntYyKytSqeJM0E4H+J2ld62KB+TNAj1sobxsdWhERU0+hxJJvop2jFkj6ibPmiNV/vzXWpzMWkGumgOehIG9BwsN6J/iFvq/gUMkpN/i3MOmQb16ii4b3d/T704Zt59BwV5BwIQ7+64enYSh5yJdIMaAv9O/bR+LxarW8M768YFqveU6S6wpX2tvKa68okAsCS0yAASuGYL1ZHBX9iq5UozWfgsyreI57gdgggQKbP8qMigrnC8sL4SRRWOXbNijjempxjYW4vfGCMeEz6mI3OfMyKvop/hAaceuDlGw5DozuhVsDvXjsaQiOR2F5YiawUV6AIC1k2Tf89mn39pZzElqwRh8+FXQktsdVMuzBhVcqvAN9OcIbED8eKy06oTb2uIrm+6/23aS/QbgS3a9DhzRMUSic34/I40EHu6jP8DsCLR2KrVCeT/mkRSvSZE5ouemvZaoy/eoF/6YeRrZNUFAnUspw6/RePv1Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(7416002)(2906002)(36756003)(83380400001)(41300700001)(86362001)(316002)(5660300002)(8676002)(8936002)(2616005)(31696002)(38100700002)(6486002)(6666004)(26005)(6512007)(186003)(6506007)(4326008)(54906003)(66556008)(31686004)(66476007)(53546011)(6916009)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXIzSjVobS9ZSUtYNWtYdkVDMnp0N3B1WENWbTZ3MjMxS0tqTXR5Ly9YQzNK?=
 =?utf-8?B?b0FPMURqN045YUN6aVYxZEdBVVFPRU0zT0ppRjZRKy9nWHk4QzZDNUtQQTMv?=
 =?utf-8?B?bHRnRWpvOVhjcVJKVlIzVm5wVWY3bGFhMm1lWW40dUZ1N2hjbkxMK3g1bGhu?=
 =?utf-8?B?SVdZVGlyc0hkUUpxWFY1cXN3VC9CejFtOU5ZUTI2d1RwYXJxT3lYckFjZEdD?=
 =?utf-8?B?eEVZVEFFWWN3aXVQeVFnQmNRMmRYOThWb3NweEVHZ01BRFBEbmVXMTFGcmJB?=
 =?utf-8?B?TERiY3laNmZCUE44QTNzS0xla0VIZWJHVXBOMld2dFdWdVYrMWY5QnIzVkRX?=
 =?utf-8?B?eFpLZ2cwV28vSmZadU1POHNWMkxXZjIzeElaN0RQQ0hmdkVBWWp0ZnNYcEJX?=
 =?utf-8?B?elBCWWFPY1hINy9rWVRja3V5NHRzMHljM3VzdVVyL3A2SVM5WkYvZGVaMTJZ?=
 =?utf-8?B?TW1vWlp1OVhCQUFmbW80YzI1VlFsczR5cytjdnRGVUtPK2k0T2J2SjlKMGt2?=
 =?utf-8?B?OVA5V09ydi8xTWh3QVdYU1JocEZmaytNQktHS005dDhka1RlVUROKzlFdmZD?=
 =?utf-8?B?dU1DREZGcFJVK0tPd0V6a2oxV29TdzlWT1gvMzhwT0EycW9nbkZTNjlkUGZy?=
 =?utf-8?B?WnMwNFk5Zk5oRytZQVpTVTZySlFMUlBuS2tDdDJqY3paK1V1NmVteXVMK1lD?=
 =?utf-8?B?ajdqRkhUU0N1VzlxZjNQQ1FuUHpzdUM4RjIrOGhNWkNGWXp1SzZIMGZzcnd4?=
 =?utf-8?B?NjZuMnRWdzBRWHN4QUJxZzNnd0pUQXlqL0dzdDVxSit6NVhqUDNJb1M0azJl?=
 =?utf-8?B?Sk41N2xCM0RDMDZkK1NMOWx1NU45clJ6dUdGY2FOSE81ejVrUDZ4MUFldFhq?=
 =?utf-8?B?Si91bm5jWldjL2FhZFQ3ZEFSbklqaTJEYVN5YW9XN2ptUG0yVnliTFVtRkxO?=
 =?utf-8?B?WUkxOUU5TnppWUZ3SkFpWWhWMVRhVUp1WDREOVdCd2JTYUlMQ3NzUTNCQ1pL?=
 =?utf-8?B?WGovN3M3Z2NrQUlIekx5UmRiSzNRRnpmMEZuUE9lcU10ZjBodUlweGdOVnJp?=
 =?utf-8?B?WE9KZ2VMYUkrMUhSVW9wbGFUTE02MEp2NXNZUERlQTRFOVorUDh6a0lnYTNY?=
 =?utf-8?B?VFRIZTAxbWtZampsbFFXbVJ3WFRuTHRsblY3UWhnYjcya2tuWFlxMVJjTHVm?=
 =?utf-8?B?ZjdoQVBWUjFzYXQ4eTFKbTFMMlpjNDJadUxyUERZZ1hybm93WEwwNVpOdlht?=
 =?utf-8?B?bEFsQUlDRkV4OUdtT0xtWnM5c1FISWFrSHVseVNhd3FucFZYOXhrV25PVUFM?=
 =?utf-8?B?bFZ1QVhHa3ovbkoxdnVoM013Z0tIZFJIVExQQ3diZ3VHUUVFaEphTG5qU0Iw?=
 =?utf-8?B?MVlHVHN4SlFjL3lSSFQzdUhPMlZoM2J6ZWVQellSbzk5TnJhdWhaT3BlK1Iz?=
 =?utf-8?B?bkJwY1pCZ1d5VFkwOTNzZGN3SHhuRkl4MHRaY2FvbzRzOUQ2aDJmcklKTklq?=
 =?utf-8?B?MUhSTlJQaFRYRjR6QTFPbEdvV3ZnWFFhOHBhZUZMRnYxVVVnYk0rUkpNSEVn?=
 =?utf-8?B?Ym5Wc1BXUFBlSEltTnR2ZUEwV3hvL0VLZjVxYUNtSjFPWjNzTjUrdnd6blJt?=
 =?utf-8?B?Z0NoM0ZhZmhiR081cStDbUorUmdFVUFabEhRa241djhOdjByeXN3VXVSYzB4?=
 =?utf-8?B?bHdDdWlwT2FHbmhKR0NabjFUSWQvcGJ5bUoxQXk5elpaTXRDZGhlbWZOekhP?=
 =?utf-8?B?OE9aVytNWmQzUHRtai94QkRyOFZ0MmRLUHp0YS9GUUsxVGhtUWVXQ3JzYzU5?=
 =?utf-8?B?NzZtaG5uMFpYL2M2Sm1jblJ0YUV0QXJ1eldlK1VHeW5LdURMUGg3bjVKa1lJ?=
 =?utf-8?B?VDRkQzRkMEIvaVI4cHFOWjRCRk15OUFXaUlhMWJvT0lzY0Q5QWFib3ZEemtS?=
 =?utf-8?B?ME1zeHFCRGJjeTQvMXQ2cHdSSmw1bWFrZW9lVjhlWEU3NDI4SnFnY1hXTkpm?=
 =?utf-8?B?WFdJY1ZsbmUzR1kzRVhkeTQ5TEpmMTNoZlBNcTVYWjZLc0l1Sm9qVk1sRUJ2?=
 =?utf-8?B?SXlhV3JJRDRHcityQjJ1a3U5amhBU3R6VlRKUytXZkNJSkFBT3k5eHVEU2FQ?=
 =?utf-8?Q?mB0xa9pwwm5zZNeYIk9nuDSlu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794af9f2-db4c-4d0d-ea4b-08db4c075f8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:51:15.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8GLI/Z+CR8zcubTIycZoMXpDTPDCKmAlIe0jfKjMZCwkYu5xGLaiHXGUHNy02+7AEniWq4kYjsvovlVbkrcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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

On 5/3/23 12:44, Ard Biesheuvel wrote:
> On Tue, 2 May 2023 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 5/2/23 08:39, Ard Biesheuvel wrote:
>>> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 4/24/23 11:57, Ard Biesheuvel wrote:
>>>>> This series is conceptually a combination of Evgeny's series [0] and
>>>>> mine [1], both of which attempt to make the early decompressor code more
>>>>> amenable to executing in the EFI environment with stricter handling of
>>>>> memory permissions.
>>>>>
>>>>> My series [1] implemented zboot for x86, by getting rid of the entire
>>>>> x86 decompressor, and replacing it with existing EFI code that does the
>>>>> same but in a generic way. The downside of this is that only EFI boot is
>>>>> supported, making it unviable for distros, which need to support BIOS
>>>>> boot and hybrid EFI boot modes that omit the EFI stub.
>>>>>
>>>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
>>>>> it to execute in the EFI context as well as the bare metal context, and
>>>>> this involves changes to the 1:1 mapping code and the page fault
>>>>> handlers etc, none of which are really needed when doing EFI boot in the
>>>>> first place.
>>>>>
>>>>> So this series attempts to occupy the middle ground here: it makes
>>>>> minimal changes to the existing decompressor so some of it can be called
>>>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
>>>>> the kernel and boot it directly, without relying on the trampoline code,
>>>>> page table code or page fault handling code. This allows us to get rid
>>>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
>>>>> invocations of the EFI firmware APIs to clear NX restrictions from
>>>>> allocations that have been populated with executable code.
>>>>>
>>>>> The only code that is being reused is the decompression library itself,
>>>>> along with the minimal ELF parsing that is required to copy the ELF
>>>>> segments in place, and the relocation processing that fixes up absolute
>>>>> symbol references to refer to the correct virtual addresses.
>>>>>
>>>>> Note that some of Evgeny's changes to clean up the PE/COFF header
>>>>> generation will still be needed, but I've omitted those here for
>>>>> brevity.
>>>>
>>>> I tried booting an SEV and an SEV-ES guest using this and both failed to boot:
>>>>
>>>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
>>>> z_stream
>>>>
>>>> I'll have to take a closer look as to why, but it might be a couple of
>>>> days before I can get to it.
>>>>
>>>
>>> Thanks Tom.
>>>
>>> The internal malloc() seems to be failing, which is often caused by
>>> BSS clearing problems. Could you elaborate a little bit on the boot
>>> environment you are using here?
>>
>> I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
>> host/hypervisor and guest kernel and the current OVMF tree built using
>> OvmfPkgX64.dsc.
>>
>> I was originally using the current merge window Linux, but moved to the
>> release version just to . With the release version SEV and SEV-ES still fail to
>> boot, but SEV actually #GPs now. And some of the register contents look
>> like encrypted data:
>>
>> ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
>> !!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID - 00000000 !!!!
>> ExceptionData - 0000000000000000
>> RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
>> RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
>> RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
>> RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
>> R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
>> R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
>> R14  - 0000000001000000, R15 - 000000007E0A5198
>> DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
>> GS   - 0000000000000030, SS  - 0000000000000030
>> CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
>> CR4  - 0000000000000668, CR8 - 0000000000000000
>> DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
>> DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
>> GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
>> IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
>> FXSAVE_STATE - 000000007FD96F80
>> !!!! Find image based on IP(0x597E71C1) /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
>> RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!
>>
>> So, yes, probably an area of memory that was zeroes when mapped
>> unencrypted, but wasn't cleared after changing the mapping to
>> encrypted.
>>
> 
> Thanks.
> 
> It seems I was a bit naive and underestimated the amount of SEV
> related processing that goes on in the decompressor after the EFI stub
> has handed over. I will have to take some time and go through this,
> and decide whether there is a way we can share this code with the EFI
> stub without introducing yet another permutation that requires testing
> and maintenance.
> 
> Any suggestions on how to test this stuff is appreciated - does QEMU
> emulate any of this? Does consumer-level AMD hardware implement the
> pieces I'd need to run a SEV host with SNP support etc?

Unfortunately Qemu doesn't emulate any of this and SEV support, 
specifically the SEV firmware, isn't available on consumer-level parts, so 
you would need an EPYC part to do SEV.

Thanks,
Tom

