Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132BD6F47F7
	for <lists+linux-efi@lfdr.de>; Tue,  2 May 2023 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjEBQIy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 May 2023 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjEBQIx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 May 2023 12:08:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DB30FD;
        Tue,  2 May 2023 09:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaWzS1XwC4/Y8jQW8nYgGWqPkjbaVQH/kIwLwifcZU8OnDcjS60PdeSG5kklpzkmH3iW57cAUqDSd5WngDGE9MrtO7g9DVLqoP/Xf4E4b0vvpGe4N8KoNue+hUniJY0cgaopCcGFDD6b1xIUVo/bVccUg0XjEJFx3KQcvK4cskxcxO4LpiQzh0ScvUW2oP12MhdSrjxjLm/fepkyq1CIdfQuSDgZ52TE3ApCZdcKxy6LaNnhAh/AElEFU3RaggwIh9cbhkRDaEAysbc9tCr6Gh/+CxyeyaD1j1XoEVr2byIL1qM/bmjHNSr9IOVcwwo0xqajM75M03YiF6L5AdwDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU19Ez/g3e59/p/nJFkp4Fs6vC3oos8UGOHlX8vUaHM=;
 b=lInnP74lKjfBdfAFaS+liP8VF/iz5uCTR8sj+HBEEJoN7dIlFgvukzduthUFlC1JmHgs1MMjRRQnQfn7I2deY4/ANovpZV4g6zhuuK0x12ART8zEYyWQYWJgbl4RJROJCVl8HjICe4kxeT8GMdFAJWtyz+XlAyYJvEKEpFBIOvOmDG6WuXt7QsKnqVB+1wWN/SFcaQ/rmaht9kaDuBsEo4a/GdWlzFZAHlzesgIzbLR2XkL/4lblaoMRe5mlzNC20FZWD4wfbuTvxozJLmUucdjQt+yXMRpkrPrqbuBwPkyHwbKcK7TH55tPKUqr090qdf/Ua5+1+yuCgmM/gmzvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU19Ez/g3e59/p/nJFkp4Fs6vC3oos8UGOHlX8vUaHM=;
 b=TnWmxf/vg/tRnhJROxOYOMvRpLGoXEbb3hyHIfbaDt3FvTuTMl6sIlGQbGpefbvdVeSNIJ3aG/oiLyZvk3rw662H2ftyA+dsFgz0AKfHLXGzwfdPQso80bHQPfzZeSwjMXM2cBPHGW+9D69/tl8eBKQp7Wy0GZjtelaWfd4ESsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 16:08:49 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 16:08:49 +0000
Message-ID: <a6846282-95c8-274a-accc-ffa54205489c@amd.com>
Date:   Tue, 2 May 2023 11:08:46 -0500
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:610:b3::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d2fac1-ccee-4e0d-1e75-08db4b278401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmeDhNwiMMF8DaS7fsnDX14BGLTsU2A1QYMTtYsiWN2TGdTxSK72n8HOhZ0o1u4gLrvCuK6qGLxG/zFnr48MW+aC72yM/Vj9lokfn2spQ/V6fBXkHeMeCS5/qftiNLWlMYevfgIgc9CN4ZCtdA1J4l31nr7JRzFwftAdzAp9wGpNJ+l/wBY8+HxfK1tYmAHoOEku5FUv8i/0PnNUxI4i7uAx6ZK4vbcu3+QZZrRxm+zmm4GFtJQdipRws4qhE+kp5ZPAe83MuEHeicA/uLp+jfNYZkzo1sZ5ZHwXGC4OlVvo9ZHyTk6z/uEMZpeSNVZ5MpuE+WR0QAxxl8og9fLsqsYYLF5iXN5OF8fVTY/4fupQXxD9mI9G3j2hhd/JmjrJPRbmEa7hUXhn1KJ21sAezujIPy2QiC2LEX/zongeKL2z+b6FAl/8dj1Zvj3QqppQxXH7IuMhDSMqqGkvsoiQbq8HfSDiNvxytIwcpmCs5+Ue6OiVhx2FOD3Mm1MIMdVjG4neNs74Oq370oPoQ0wwFkaChjLURat/AYtgc14WzShZ1AEQCgzu81XBnXPpqt5RYXsWNj7/sljRFvfuic15cnV/X6nBcJbYF5mF4Vvxwd+p7DEoHTldIzElEpBFr/bINoX5J8NAZaAL7KWjYpuLIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(5660300002)(86362001)(38100700002)(8936002)(8676002)(7416002)(4326008)(41300700001)(66476007)(66556008)(66946007)(316002)(31696002)(6916009)(2906002)(186003)(53546011)(6512007)(6506007)(26005)(6486002)(6666004)(83380400001)(36756003)(2616005)(31686004)(54906003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVHVVpPR0FYQXYxZ2pPZkhNYUhmcDhUNVJVY2VRMlR0bFVlOXZyRDJZSVl5?=
 =?utf-8?B?dFNRUGRBMGJ0cWV5TmlDVVdGdUw4Tm42OXNObS9rU04zSGVSWDQ5SVJCTjFS?=
 =?utf-8?B?M2tDMHBxVEJTcG50QTdxbmwvTENBSUVzTW9YRHBlaTdtclhTckljQmo2dXlJ?=
 =?utf-8?B?YkRjOHVmbjdCQWxXejh1NE4vSjlqTEV2dVZmN1dzeDRmbUppcG9vQ2ZNTklT?=
 =?utf-8?B?dms1NmhRelVLTnVCYWplQkpaZlJIMGpNdVhJaFp4bVczRkUvdlJ6TWkxdkdl?=
 =?utf-8?B?bG9lQ05kOS9EQnZFeEp1TkdpVlJ5UVczd0dPMFhmdG1RTURSSWk0OW9WUjdD?=
 =?utf-8?B?ODdPYjl3V3owdU9XMmVkT242VEJUT011US9sQzlhMElNVEpGbExOTER4VHZu?=
 =?utf-8?B?aVRzNDFEdVZBQ1k0dGVSbWtkTU44bGhpL0lueHFqeWFUOGNyVy9OQllNWDBN?=
 =?utf-8?B?YmV3UjNQenhFYkxQSFJFT3psWEFtR3YyVnVMVUlucERSZFJOMlRtcUhKU2pt?=
 =?utf-8?B?RDFpVjJMMHAwdzV0d0RFNkZvbEZsZkhWU3FxVzdvZjQ2ZlFMK1EwWmlRdml0?=
 =?utf-8?B?azZFS2tmcytoMUg1aDBhU0NoNGVSOHBBYlNEVTkyOExCOFUyK0cwNkhUREUy?=
 =?utf-8?B?SWVRSzd6VjdkKzJiMHQ1T2xlWVQ3U1AzdG5pcGoyRlNCUmhRWFNQOC9Qdkw0?=
 =?utf-8?B?REFjTVAzMCt6bFcvSTk5WWp6Y1FsaFp2ZUg3ZFlBVHJnSThsM3VzQVFWWENO?=
 =?utf-8?B?SGRYeW9lNFFrd0NrL2xnMHZHcVovQVZXMG53NURrODRBVkM1bHg1dkh4cUdZ?=
 =?utf-8?B?c1VHMTZxWlhUWXVMRS9rWU1pYUdDbVM3akZ2amxUUGNSTjhtS0traWtrVDd3?=
 =?utf-8?B?dnN4NmtpTHgwRjZES3ZxUXM2MFBFcUNnbnZVUGxJSiswSGg2TFJpd2I1NE9m?=
 =?utf-8?B?b0ZTelNBUDFQT0wwRjU0SzZyYU1Hb1BwaTk3ZG9VR0xhSmJVQXdQdDZJZUZy?=
 =?utf-8?B?U0FHd2dFMm14TGlaRDlFcVVHcGFkcUNtVFVFWFlQN2dXeUpoeHVhaWtRVGdF?=
 =?utf-8?B?UWZpS3JTV004ZmdUbUJiQmlyVnNzeEZOclQrVWpIZzVsVUtidTljTDVsQUdV?=
 =?utf-8?B?YjJydjdXY2RSY2d6VE0wMTRwS0d2Vkw4ZzlienVibGQ2UzVReTJ0RUU4R1Bp?=
 =?utf-8?B?QnFJOE9ia0lzSGJWenp1QkpQNDhyaC9GM1BpRDQzRU5Hb2dDS2RKYTNnZkdN?=
 =?utf-8?B?SDYzaHpkcU5TRHJZQjhvSnpydHlMVkZWOWRFWnN5VVAvL2JNZVcrQUxtQlNl?=
 =?utf-8?B?a3VDMTFYdmZzNC9iTm9HU3duQTQ3akNsOGZsVTlzbzdxNThkRVhvSTBOSWF5?=
 =?utf-8?B?alpyZ0c1KzFRMkRoT3NTTHV2b0tpaERDbDhNV1dpdVh0Y0tEYVp3TXA5TFNM?=
 =?utf-8?B?dzIzTUNaejZVMVA3QnA4aVkwVERoM21xdXZJS3JscGgwc1drUVBSendJbmVX?=
 =?utf-8?B?THc4SVRXOUtEUENGdHhjM0ZuMUcvV3cyTSthYnpmbnhaMXpvbG5VSG13RGI2?=
 =?utf-8?B?WFM2S3pjc0lPWVZKRUxuQ2NzcjRZQm5UTmxHUUJMUHhBblBGd0FEUXFVSDhT?=
 =?utf-8?B?N1IzOERQaU4zYVJTNWFUcDU0cUZLOSs4cDN0WFBwa1hRalVHWmdZNDY5Uk9E?=
 =?utf-8?B?bDJyQmFQOS9kVFVNREt3dzhoc0REbnU2dEFkUW5vS3VXWXU5d0V0enl1M1pV?=
 =?utf-8?B?eWhqOHh0S2ZYdGt6VjlCTFpCL1piSDhNOXhrSjFPT3V2RTRjREtMT0NybFFr?=
 =?utf-8?B?QnlBR3gyNVgwTllEVExIb0s4bWtaRlNrYnlzZTlFTER1ZVhVeWR1eFZjeFN6?=
 =?utf-8?B?SkdHWFVNNDFCQUNXQXJnbXpZOUF3Q0xVTzM1ZlNidVpJSGtHREZ5ZlhpdzJp?=
 =?utf-8?B?M0pRam5VSldmR1ZQblVlU2wwZGRla2syT0JxWW0zYjVybHlNK2RNbnBpTXZm?=
 =?utf-8?B?OUptQm5pTTJORFFYZXlLSWZISHIvdFlNdE1Mdm5hZVMwaUN2QkVFeW9ka2s4?=
 =?utf-8?B?S20reDNycHFSbDdTL3JKYzdiRGVZZjRPZ0dnOTZmNTNPNG5ZQ2hSMDE4Q3k3?=
 =?utf-8?Q?jyNwA1WC6XRYsx7sJXYx/+sM9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d2fac1-ccee-4e0d-1e75-08db4b278401
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:08:49.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJdYlt7ADhqRIO5WKm4AUSp/LAeKJbfRe6yTqd/cBoEPR4S1cr+/Wf6/ihaAOBERR6PQ4Ilo1Yn6N6EAqmVu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/2/23 08:39, Ard Biesheuvel wrote:
> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 4/24/23 11:57, Ard Biesheuvel wrote:
>>> This series is conceptually a combination of Evgeny's series [0] and
>>> mine [1], both of which attempt to make the early decompressor code more
>>> amenable to executing in the EFI environment with stricter handling of
>>> memory permissions.
>>>
>>> My series [1] implemented zboot for x86, by getting rid of the entire
>>> x86 decompressor, and replacing it with existing EFI code that does the
>>> same but in a generic way. The downside of this is that only EFI boot is
>>> supported, making it unviable for distros, which need to support BIOS
>>> boot and hybrid EFI boot modes that omit the EFI stub.
>>>
>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
>>> it to execute in the EFI context as well as the bare metal context, and
>>> this involves changes to the 1:1 mapping code and the page fault
>>> handlers etc, none of which are really needed when doing EFI boot in the
>>> first place.
>>>
>>> So this series attempts to occupy the middle ground here: it makes
>>> minimal changes to the existing decompressor so some of it can be called
>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
>>> the kernel and boot it directly, without relying on the trampoline code,
>>> page table code or page fault handling code. This allows us to get rid
>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
>>> invocations of the EFI firmware APIs to clear NX restrictions from
>>> allocations that have been populated with executable code.
>>>
>>> The only code that is being reused is the decompression library itself,
>>> along with the minimal ELF parsing that is required to copy the ELF
>>> segments in place, and the relocation processing that fixes up absolute
>>> symbol references to refer to the correct virtual addresses.
>>>
>>> Note that some of Evgeny's changes to clean up the PE/COFF header
>>> generation will still be needed, but I've omitted those here for
>>> brevity.
>>
>> I tried booting an SEV and an SEV-ES guest using this and both failed to boot:
>>
>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
>> z_stream
>>
>> I'll have to take a closer look as to why, but it might be a couple of
>> days before I can get to it.
>>
> 
> Thanks Tom.
> 
> The internal malloc() seems to be failing, which is often caused by
> BSS clearing problems. Could you elaborate a little bit on the boot
> environment you are using here?

I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
host/hypervisor and guest kernel and the current OVMF tree built using
OvmfPkgX64.dsc.

I was originally using the current merge window Linux, but moved to the
release version just to . With the release version SEV and SEV-ES still fail to
boot, but SEV actually #GPs now. And some of the register contents look
like encrypted data:

ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
!!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID - 00000000 !!!!
ExceptionData - 0000000000000000
RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
R14  - 0000000001000000, R15 - 000000007E0A5198
DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
GS   - 0000000000000030, SS  - 0000000000000030
CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
CR4  - 0000000000000668, CR8 - 0000000000000000
DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
FXSAVE_STATE - 000000007FD96F80
!!!! Find image based on IP(0x597E71C1) /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!

So, yes, probably an area of memory that was zeroes when mapped
unencrypted, but wasn't cleared after changing the mapping to
encrypted.

Thanks,
Tom


