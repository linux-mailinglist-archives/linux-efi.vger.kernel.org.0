Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D66F5D66
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjECR6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjECR6P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 13:58:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C93594;
        Wed,  3 May 2023 10:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgOxk6KBIYdK55W0qdRUA4ZJ6S4QDzQftss+WGV7sTzdH6Jw80ZAJSVjugm6SpnTeVmHc26GkwSTQ62DQzsxit145t7o/gLhTCXzbhMDp9p0SmU5Oap3bl3PACk3gqiplOCdtn0BqFXiHdvZCpIPPGlJ17rjExjvDBzJQpu+eIBmq/rrciqoGY3llQw0lZNzdu5KiLMDu+yJRij93Qk8uRvXanDDvcrmqicD2WjjywrsueCST9OiLLJlpXMOTGR7kH7pw+TuChsdhzOhOBGScQrzktwHgZ5iwALvHrDIXNW8miabWItGyD53efxa3GhXm8I+otTt6EA9Jgu0l/Qqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rcudooyjUGevVetGwehHCOy8YPIk0Oas0jCgrPvpmQ=;
 b=U78qLi6nzbwuT3h9iKXpxbDOOAISMkFV/TQCAtaHRHb/qhh4UHfqDWtmvWTR9npSEPrjMxZg9f2wmEA8D08dTciy3Qgw5sVHQxiBODLWiGQth/Zh/Or5kcB3HNOuBfzD/7LpOjzQM6Y1kYEB7UYKAJGycKQXMWDYUfu8Vi7l23Eb5yirJiUjsq4BGEMkI1RkcpjrgneNnzGuQqQVHebXJRSSJgnwaXBfspkRfGqjev207vmIAvSz6AkA0lh+OV5bE9xKm/xb6WKZKcwVzK8ILjekgn5xyOnqDuBjHfhv41AqEBDsF8uaiGqeJaky0MvSjoTOJIlge+g8EuZ4DJHgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rcudooyjUGevVetGwehHCOy8YPIk0Oas0jCgrPvpmQ=;
 b=bx5wYNXhC4LiH0OIoa/9u55DElwj2dOvnR8GdZahE5Ed7f9bwpgNVcjLNYXoLoP41IdArRue3A8hIncBSboO3tLLO738jgUVuoW6CUFnRldbc6c608uIL4I+mUZ5j6l302LESQ9s+k6PSfOccb044ou/7zopsn8B2kJxNRt/wiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 17:58:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 17:58:08 +0000
Message-ID: <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
Date:   Wed, 3 May 2023 12:58:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
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
In-Reply-To: <a6846282-95c8-274a-accc-ffa54205489c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:610:b2::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b45b3e-e9bf-467f-727a-08db4bfff3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkuQhEJTRJYnv3XHjoDcsFa2l6DLRjWICRLkCRirNWlKGSIvK00qvOfIHcTo3DOLnJbRbJOwv2rygGc72n76PFWClua+dcCZ0fGMgBgKhJJ9WWwhaKHPflgHmEaEcRXfEBbd2lZvWJN7GJwv5gQo4iEBWgys6Nfr9fQNhr1TbpgUfZ7c/M/p6sd9Z7+9tyKScyZUralI4zzO9d1fDDAyXlvwc3lY57+1kk897m2hBQFFaHCJyOJKZGCSmv0cCOZei9G+0dCU0ZmjCiXZ5jrTT/uFMlXvSiHmM/ocVb8WRr6y0k/7Q0f5k6wcFTSdFYhRilClqnr1nPvPKqCBAZ2/mhBkNDrCnX66S7Yc4YoYhY8DudwYsm0uDfUNCRvJlTLyWIxU1Up4qhoIhy37Ted+8wiMSezeq4pdE5wRbEVOLR0by5f0ipi0p5xFakHLK7Q21678T4wGimr1Nyh1FWdTP8tY0lEEOX/WZ/Swi3+stUaRicyUC/Dr//fVeGpM0/YdtvWx6IFBImNUcmybJz+agFRvKhiV7orYt+UF7ccDiytVWa7tc80c5xn76JokMD90xpjCD78FF9wFD/bdIuGBUOMvPHZv7byVOdKT0wCgQNlofUhBqyKFyv+THNYns6e2zJqJ6dvLB7tJgWip5M6lhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(6512007)(6506007)(8676002)(26005)(186003)(38100700002)(53546011)(83380400001)(41300700001)(8936002)(7416002)(5660300002)(36756003)(2616005)(31696002)(2906002)(478600001)(6666004)(54906003)(316002)(6486002)(66946007)(4326008)(66556008)(66476007)(86362001)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElRdE9kMXpTU0dueEY0clovNFRxMlZRcGNQbVhPa0k3dnhic1NJNXd4bWtU?=
 =?utf-8?B?ZHFwdWhpaEwrNkplTFgwZUhuMFdSUCs1VmJrTUp0S1Q5NWhtbXBFdjB1dkxp?=
 =?utf-8?B?WmdDWWpQSTBrcHFjU3B5TUdOY1BhWFJzaWhIbU1wRjRFZ1lXWFltY0ZwTmIy?=
 =?utf-8?B?aTZZdHpla1FHRS9oSFBUOFZjU3pGRjUxaUVxSkxKYnJiNDZScXVRNDltVlkz?=
 =?utf-8?B?R29CMm5oQnZMUmRNaVRLUVNZek1rZmI2YW9lV3J0TUhtV2hKWGRHR1lCTzlo?=
 =?utf-8?B?TUxaeTR6KzBPR0JCdXM2cjFIK1RVVTZwWGhTbHNNN29PN0xIaGdhS0dHV2lo?=
 =?utf-8?B?SDFqZGxPWExsUUlNWXJrbVo3K3BTM3Q4REZPL0t6QndZTlg0SlFuc2pnQTln?=
 =?utf-8?B?OHhhdGkweEdKK2FhNWJVWXRNUmU5VW5FVVd0SG0vc2lTYkNORGFJVVMyM3V5?=
 =?utf-8?B?NVFOQXIyZUVTM0RqK1Byb3BCenNpR1BHTkpTYUVaYVNtMjg1WEs4YlZlTnBh?=
 =?utf-8?B?cnRnMW5QLysxVlY3NGdMb2xod0JVZWZ0MnlkQWZ6T2FkRUFVYm40NUFheE5N?=
 =?utf-8?B?OGwwN3YvejVQeUJDZGpINWlCQkRHczRiWlQ3YklLK2gvRlBGQmhscmY2ais1?=
 =?utf-8?B?ano3N1pvbThvM2xuczRWb1MwOTFCZ3p6WnM3WFVuRmxyOHN6T1dLTVkvN0k5?=
 =?utf-8?B?YnAvcnQwUnVPdkFjVGZHbXJTUGt3bXA4RmdrbWJpbkdrcEJlUjZVS3BFL25R?=
 =?utf-8?B?SHlMUkk2MmFQajJnTW83TVcwVDNkT2Q2ODNnbVAwTU85ZE1xcnd0bStPRUtq?=
 =?utf-8?B?T1hTNFpqTnI5OU8rSERNRzc1NnpKSS9DcXZDclpwaXRiNGsya2JRN0c2c0Zn?=
 =?utf-8?B?RVB3S2tCSy9zc3lOeTZuZjcwb3RrdWZPaVN2MmhSa25seEtkdnFyM3ZjMWtL?=
 =?utf-8?B?NWxKV01ZUStXbUtxc0Zaakpla1lQTmZGclZtZkErNFg4b2M1UFpEZWFVTXBs?=
 =?utf-8?B?eWpUYUtYS05MbG1oOFhZaUJXMTNoVFB6RTdtVitKUXZOM01DNE9nNStPaC9q?=
 =?utf-8?B?ajJoa3JNWFdYVC9BRWdQSTNYQm9ERGd4OFpGNitFZ29aZGsvK2tRbG45UkxK?=
 =?utf-8?B?eitVUDQ2NGJaa1F0bmxFWlE0eldRbHR2ZjZUNmNhT3IwbTMxbWdvWEh0QXZQ?=
 =?utf-8?B?N2h5dFlTYkM2L2llR2t3cWUyczRIdmV3d3RqZlp3YVZGaTd5TlhjbEcvME5C?=
 =?utf-8?B?cnF6T09Ua2srWlgyamlFN3lyR3lha2N3L1VWT09oUGhGcWgxSncwWjcrRlhJ?=
 =?utf-8?B?OE5ZNFNJYU0rSnBRZGV5M0tRQk9zdjZWK2M0cU1FbitRaFExS0pBM2ovRlZB?=
 =?utf-8?B?ZU9zMUhqRUV2eXE5VWExSldiQVdkYWV4YzBsL2dKamdlZ0xNekdyR0FvRDlG?=
 =?utf-8?B?QS9IaWF6WHZjY0pIa1E3YS8xZjduTEtKZU1SMUtzQURseE8rekhSekIvcnU4?=
 =?utf-8?B?aHBzWU5iYWdQQ01Bd0hoZWNJdjQ4emwxNFRTekNOSDBRait2SmlWR3NETDdz?=
 =?utf-8?B?N01ocGJoTXdQdTZYZkxxanVaSHVDT1NrT29TdlBac1VmbytzbkZEaGpXSk5W?=
 =?utf-8?B?L09EajBHUFduR09oT2FxWFFzOXU3RUpSSG5oQWR4RVNPenZuakpmd2g1ZUhV?=
 =?utf-8?B?cE8wZlVBYXEvaHFxSGNMMWMwY1Q5MWRvS1gzWE1ERlZ4ZGxPSG5nRm9QTUpO?=
 =?utf-8?B?c1BaRjRkdWhJOGZCZTVjOG9RTnFEMVB4WTU5V1hiM1BzVTQ1SlZTRjZqaUp0?=
 =?utf-8?B?OE1KTUNuSWZ1cUlUeWpOZlVSc2FGUElYYnpKenRLNjBFTlNTOFVZRU96cEk1?=
 =?utf-8?B?T0gzTEV4M2U5THNtWWRYclkrZXdBVEtBOWhzdFBHa2NhTUozQ29BLzBsbXBu?=
 =?utf-8?B?eUhOUU9Ob0VRNXNMTnVUQlFLNm9EOVI1RVVQaVlDTkVFa2ZkbXoxdHJOdUxy?=
 =?utf-8?B?VWVrSkZKaGZPMUFMVkRvRGo3NUltSFBtVVZVYkd4QUhFKzM2VXFoTFAxT0Ir?=
 =?utf-8?B?T3V3MW5GZG1iTkZ3QjM4RG8wUnZQWG9PcmVOcTkveFY5TW5yMjEyaHpZQmpF?=
 =?utf-8?Q?HwmmvzCpgGF/K+GcyHRzrFAQW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b45b3e-e9bf-467f-727a-08db4bfff3b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 17:58:08.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubxLUOzVqVr7fI3XvaXT0r07trn2eMV3nWMeaXueY+3pKS6x/GtGUeV0qhW1wWW/m7cBfFcstN9WM3m50rvhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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

On 5/2/23 11:08, Tom Lendacky wrote:
> On 5/2/23 08:39, Ard Biesheuvel wrote:
>> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 4/24/23 11:57, Ard Biesheuvel wrote:
>>>> This series is conceptually a combination of Evgeny's series [0] and
>>>> mine [1], both of which attempt to make the early decompressor code more
>>>> amenable to executing in the EFI environment with stricter handling of
>>>> memory permissions.
>>>>
>>>> My series [1] implemented zboot for x86, by getting rid of the entire
>>>> x86 decompressor, and replacing it with existing EFI code that does the
>>>> same but in a generic way. The downside of this is that only EFI boot is
>>>> supported, making it unviable for distros, which need to support BIOS
>>>> boot and hybrid EFI boot modes that omit the EFI stub.
>>>>
>>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
>>>> it to execute in the EFI context as well as the bare metal context, and
>>>> this involves changes to the 1:1 mapping code and the page fault
>>>> handlers etc, none of which are really needed when doing EFI boot in the
>>>> first place.
>>>>
>>>> So this series attempts to occupy the middle ground here: it makes
>>>> minimal changes to the existing decompressor so some of it can be called
>>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
>>>> the kernel and boot it directly, without relying on the trampoline code,
>>>> page table code or page fault handling code. This allows us to get rid
>>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
>>>> invocations of the EFI firmware APIs to clear NX restrictions from
>>>> allocations that have been populated with executable code.
>>>>
>>>> The only code that is being reused is the decompression library itself,
>>>> along with the minimal ELF parsing that is required to copy the ELF
>>>> segments in place, and the relocation processing that fixes up absolute
>>>> symbol references to refer to the correct virtual addresses.
>>>>
>>>> Note that some of Evgeny's changes to clean up the PE/COFF header
>>>> generation will still be needed, but I've omitted those here for
>>>> brevity.
>>>
>>> I tried booting an SEV and an SEV-ES guest using this and both failed 
>>> to boot:
>>>
>>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
>>> z_stream
>>>
>>> I'll have to take a closer look as to why, but it might be a couple of
>>> days before I can get to it.
>>>
>>
>> Thanks Tom.
>>
>> The internal malloc() seems to be failing, which is often caused by
>> BSS clearing problems. Could you elaborate a little bit on the boot
>> environment you are using here?
> 
> I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
> host/hypervisor and guest kernel and the current OVMF tree built using
> OvmfPkgX64.dsc.
> 
> I was originally using the current merge window Linux, but moved to the
> release version just to . With the release version SEV and SEV-ES still 
> fail to
> boot, but SEV actually #GPs now. And some of the register contents look
> like encrypted data:
> 
> ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
> !!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID - 
> 00000000 !!!!
> ExceptionData - 0000000000000000
> RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
> RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
> RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
> RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
> R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
> R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
> R14  - 0000000001000000, R15 - 000000007E0A5198
> DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
> GS   - 0000000000000030, SS  - 0000000000000030
> CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
> CR4  - 0000000000000668, CR8 - 0000000000000000
> DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
> DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
> GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
> IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
> FXSAVE_STATE - 000000007FD96F80
> !!!! Find image based on IP(0x597E71C1) 
> /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
> RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!
> 
> So, yes, probably an area of memory that was zeroes when mapped
> unencrypted, but wasn't cleared after changing the mapping to
> encrypted.

Yes, looks like a bss clearing issue. If I add __section(".data") to 
free_mem_ptr and free_mem_end_ptr in arch/x86/boot/compressed/misc.c and 
to malloc_ptr and malloc_cnt in include/linux/decompress/mm.h, then I can 
boot an SEV guest.

However, an SEV-ES guest is triple faulting. This looks to be because 
we're still on the EFI CS of 0x38 after switching GDTs in 
arch/x86/kernel/head_64.S by calling startup_64_setup_env(). Before 
switching to the kernel CS, we take a #VC (from CPUID calls in sme_enable) 
and things blow up on the iretq. Moving the block headed by the comment 
"Now switch to __KERNEL_CS so IRET works reliably" to just after calling 
startup_64_setup_env() fixes it and an SEV-ES guest can boot.

This worked before because I believe we switched off the EFI CS as part of 
the kernel decompressor support and so this bug wasn't exposed. But this 
needs to be fixed regardless of this series.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
> 
