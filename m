Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009166F452A
	for <lists+linux-efi@lfdr.de>; Tue,  2 May 2023 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjEBNic (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 May 2023 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjEBNiI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 May 2023 09:38:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062F6EB2;
        Tue,  2 May 2023 06:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJXpbakFV4M+jQqqOaAJti+ut5g+kep6sAMPEf8p0VAEwO89PAN7gzrFOiZVN+aPu6NPHsxuLfrAnJpnygaAi5YACKeQshHXNeJJr3ykrRHFrWujWUfQoIQBfByK5/toRBkeGHDAXBUn6FaDNkdkxxUoBazFHiZH5eZycSZX9IXMqraLxtt1vz6Y/wC6fI4FlIahC2ymDEyhdQLSEUB2Sf4ZsDD98SAEYypoPYJB3XDaVCeZWJ70FWzqhrCIt/wiHbIscCn8kIcW/iJ23KizNOx1DCd5BpxbS8N9mWKFhFa2uqfJnLTqIH0FfS8n76+2DXnn7A9AWKOj1RVxxWCaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IS6///L7nhOx7hiWygU45Z1hpjnZGi2cAc41nvUb2A=;
 b=Xd04jETmcTzzOLNJZm7TZYMfkLA79udqGwF09tPfmjItjvGgYv9xVy1WxnKml4F2Yl/Li5YF62k7QQcGSuhaUOlWiFrSxcSe3wlQ+luf3faYsQO5E0tzVlO3HnMsQXTT9PMU2hq+4cyNkmcfAX/K/0wInDR0BESgJyweznIzX8N7nYkCVN4qrosOLD7tH3dOC4DmbRHjMLNYIhPQ3DtNGeArb7cFD1zquBwNDNiKiBqbAv3h5rV13pzfqonE5IhIE7/gO+983QZCJSxXtpEAo0tM3KIiU7ZUB5S7A+jObnDylLXl0efidTfHmNobCZITt5cI05mkLRjn1ORVqNsG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IS6///L7nhOx7hiWygU45Z1hpjnZGi2cAc41nvUb2A=;
 b=v9ZVdh87Uov3lDUiONUAgKYxw1GHXgk5p4jV3t2z3zMY376fzZnREWNmQhuDj2ELPLfMLniFIxGsR7ODXPPgscpSbdA5GC/YpLJepG5lEjdDv7wQUvAOUpyrWKe/SWsueUeY0A/6uiXsnjMAR7JdlNaxN5uWd0VK24He4gfjRQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:37:19 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:37:19 +0000
Message-ID: <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
Date:   Tue, 2 May 2023 08:37:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH0PR12MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c06cbbd-e25f-41bc-06ab-08db4b1259f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atz/mFCvNoLUnGFCFWPGhswsy5MuGvZUQbsswaK/de8DGSK80degqPVArCK3XjWCHLO9kic8anJ6RPPwLfPl1xYfsHUtEt9/b2QiADRTLOEBHpobcrOhzLQ6Owro//j4tZ7yQjEaKZ1EUH/C+/5XBxJHMdKnb3h4oyI1dSXZcBFhJyGIiyFn8oNAmzy390MGKnUB6nehQ+s8yBxbe8m/+u2ys8aK+vd9/Lr5htXDKH9F1ARm/zflZXrZE3nW/wnnX+lno4U3Bv28LZBEJyo1UXOEp2FpCRUjwvb6CgHV5Axo3CPO1s/YfHPgdwa5OBTEEhLfCRhScif56+jsFbiQgOEFv6KgX6kmF4Dhq/sw547FAPt4lC3vkQD8WwhAH11rA8ACcmM8LYd0BeHmqSb9AsMbGDl6SXEqZCi/MkPM1IYMetkwux11/K8ESJEuPt+nLpAVl/rBJPzrVT9cqDBTLHVfmt6MLRxlCrrslkmKMUv158O5ovmwSKRSSzBg0fD2Ri1ROExoAZKfqWSWjxvzfTda5CR5B487m/C8Iwb8+wFG/SVn15oKVNrV3znk2xPwuhj08zZi1GHI0VM53UcqOBGgbEVufSvOSBUMkwwtEDKCa6CVJvV93p8gd6lglPIzw9dxOlvFxv//uYdfv+KaB4/LD1pDK2wrYxUvos5J77G7PoeceYYtkpTvu7D4t6aw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(6666004)(6486002)(83380400001)(31696002)(6512007)(6506007)(26005)(53546011)(966005)(186003)(54906003)(2616005)(31686004)(36756003)(478600001)(4326008)(66476007)(66946007)(66556008)(316002)(38100700002)(8936002)(8676002)(5660300002)(41300700001)(86362001)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXRORGlOVmptaDhubTZkZzVYTW16a28wdkcwVEs4ZXhlRG45dktTMjF6ZFpr?=
 =?utf-8?B?Y0R6M0RxM0NjbEoreCsxWXJzbEp2T0FXOU45elhLaWdOL256VVkvNzdkeEVp?=
 =?utf-8?B?cStuRVJvUUY0U0h0QWdiQ3phMi9kT05Fa1d1RlpkdllZWmtvZ2RUSXV5UWU5?=
 =?utf-8?B?OTRzd0szekVsZEJTQWt5Tm1DaGZOZVJEdytYWjArQ2Rnd0Y5TDZKUUNhdGNl?=
 =?utf-8?B?ai8xZzBGelNMS1JnK3RpdEhuQ0tBOXM1S1ROOTJkTjRONDByeEhoaU1JRFFh?=
 =?utf-8?B?MURpOHZFM28wdHB0Y1BYQXNzaDBzSEFTSkQ1TUxJdEQvQW5aSkUxUjI0V29y?=
 =?utf-8?B?elJFaTdobUVJM2IvQmcyemNxd3drc1VZNkN1RTFaZUhieEFJN1RiK3N6T2NG?=
 =?utf-8?B?STZsTVF0ejFyZ3pveXc3dFpDQ3BKRHZKWmlVQ2tvaDhRTUxRM1h4SlNLNDBm?=
 =?utf-8?B?T2did2kxYnh6SHFjWVJuWTA0K2h2REcyUW9FVHRQVk56bWI0OFBLdldidEdw?=
 =?utf-8?B?K3k0T3B5VndiZThrZ0QrQU1ZaE05SFMweDEyaXp0MkEzOURrc3k4NGRKbkVz?=
 =?utf-8?B?TlJyU25xRm1VVEoxQnllaU1CU25ybHVkTVlyc1R2cmVSSittVTdURUpSaXJp?=
 =?utf-8?B?TGdybGRaU05kMlRoNHorTjJXaGt2d245YlhETjBZOXdGamNPcGZBRVVOQlQ0?=
 =?utf-8?B?VkI2M0xSSWYyZlF5TytXMkcyTVcwQjZvSE9uZzl3Vlg1dWpQMndONGlHdGFV?=
 =?utf-8?B?STZNSTlpNjkrMEMwcXFKSDNqMkptTnBpVTdtL09UTS9PZXNjbjZ4V2ZRWUUv?=
 =?utf-8?B?clRaQ3RHVk9qU0duSGxkSEVrL3VWdkV3aUkrSDRxK3VFOEREbUdhRHMxZVRP?=
 =?utf-8?B?REYraEdtQ0g1ZmxGR082T3RnL1dtNGVPL3Y2NjJoTC9nSlh3OGpja1lIdG9o?=
 =?utf-8?B?YVB5a2xmeXlqSEtsY2xuQ3AxWHY0eVNDVHEvUUJMWTRSY1ZIOGp4NGJra2R4?=
 =?utf-8?B?c2hQSThxaTByL24vRzFzcGhrdVU0K054SXBGMDhUSkVqNm9qbEZZT2hWNVZx?=
 =?utf-8?B?cGJ3REcybjZ3K0U4am1vWnVBUEdoWm40SFozdHJCN2EwdU9rZ0Mwck54Ullz?=
 =?utf-8?B?QlNMajMxU1N1cEMvaURjdisrdmptbm5TUG5WS3JwbEgwSjUvWkFDdHMrTHNY?=
 =?utf-8?B?VlBOWXlLcUZlaEcyRTZSeDYrTnp6UEVFbWpSbjFyTTViK3pVcU1pcWJORC9M?=
 =?utf-8?B?V3JxcVFLU1NtRUsyeFVUY0ZFNjdtbTBJZ2lLb3RnNXhtM1ZoSU5CNjdoRnM3?=
 =?utf-8?B?SFYveGJmcll3VGxDMFdLT3dYTm5ndCtXY0dUSDlIYUkyZ0V2YjlNZjNId2U4?=
 =?utf-8?B?eENvSjZVZS9DdjlsaDlVcnMzT1ZyVG0zTHAvRXFYRnMwMUZjV295ZTBDc1lr?=
 =?utf-8?B?ckE2S3RBVTRzN210RlExV1hNRGJZMndxNHlWRXhlU0RGLzVTNjI0NHBNeVRn?=
 =?utf-8?B?VThpb29oQUZZanZiTFZ6Q096SjRvU0MvU2pIOXpuWkxWclBWTjI2SU93dFB6?=
 =?utf-8?B?UFdnTTdaWmQydXdoY2ZaR3NsWEhkZ0t1N29ZaWtpc1JkcVF1b0xlaDJuQmhw?=
 =?utf-8?B?ZGp6N3dtWkV3R3ZiR1lTYVMrSVc3a3JKelFxbWxxemF3dnBzaytoOWJuaFZ2?=
 =?utf-8?B?S2hOT2VxYVZvVHpPVGFJcGhsTHFsQ0xJVHRBcU1qdmk1REVGeURQaDhhY1BJ?=
 =?utf-8?B?bVB5ekIxUGhEN2NCLzJ0TmxxeW1KNFRTb1NXbytkenJVdE5sVjhNckxacVlB?=
 =?utf-8?B?b3FwZUc5WW1lTlYxRGJyWm5ZZGgydDdmK0kwN3JXV2RYNmZVRTZVdUlCNG8x?=
 =?utf-8?B?ZXd6WVhzTVdjV3k0QTZGMEdWY08xM3JIL0Y1ZFZNQ3ZVV1VDNVFMYWpveUky?=
 =?utf-8?B?Yjd6ZC92WnlWUUUyeHR3eHZXbUlJd3h4UjV1dVhXL3VrdkdjbWlMV3k2dzFn?=
 =?utf-8?B?c0sybEUwdWQ3aXVkTzFsL2hMQW1nNHY3eGtmQThjdU1BbFFiVnRaUEo1eitm?=
 =?utf-8?B?WGNXcjBxTkY4aWtNUHZMaDFzbHVKcVNkU3FqcTR6SFJ4eWtXTnhBR3YzSW5z?=
 =?utf-8?Q?M6yclbo9TLE/yZGcpgkhzFMBA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c06cbbd-e25f-41bc-06ab-08db4b1259f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:37:19.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr8nWr9houjn9Eom5AN97my7O95nvJ+J0CiR79nG1BjhfX2ewj82ejwcd+seBn7NYhH/FDsu2dMUjqXDNhBYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/24/23 11:57, Ard Biesheuvel wrote:
> This series is conceptually a combination of Evgeny's series [0] and
> mine [1], both of which attempt to make the early decompressor code more
> amenable to executing in the EFI environment with stricter handling of
> memory permissions.
> 
> My series [1] implemented zboot for x86, by getting rid of the entire
> x86 decompressor, and replacing it with existing EFI code that does the
> same but in a generic way. The downside of this is that only EFI boot is
> supported, making it unviable for distros, which need to support BIOS
> boot and hybrid EFI boot modes that omit the EFI stub.
> 
> Evgeny's series [0] adapted the entire decompressor code flow to allow
> it to execute in the EFI context as well as the bare metal context, and
> this involves changes to the 1:1 mapping code and the page fault
> handlers etc, none of which are really needed when doing EFI boot in the
> first place.
> 
> So this series attempts to occupy the middle ground here: it makes
> minimal changes to the existing decompressor so some of it can be called
> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
> the kernel and boot it directly, without relying on the trampoline code,
> page table code or page fault handling code. This allows us to get rid
> of quite a bit of unsavory EFI stub code, and replace it with two clear
> invocations of the EFI firmware APIs to clear NX restrictions from
> allocations that have been populated with executable code.
> 
> The only code that is being reused is the decompression library itself,
> along with the minimal ELF parsing that is required to copy the ELF
> segments in place, and the relocation processing that fixes up absolute
> symbol references to refer to the correct virtual addresses.
> 
> Note that some of Evgeny's changes to clean up the PE/COFF header
> generation will still be needed, but I've omitted those here for
> brevity.

I tried booting an SEV and an SEV-ES guest using this and both failed to boot:

EFI stub: WARNING: Decompression failed: Out of memory while allocating 
z_stream

I'll have to take a closer look as to why, but it might be a couple of 
days before I can get to it.

Thanks,
Tom

> 
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> 
> [0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
> [1] https://lore.kernel.org/all/20230416120729.2470762-1-ardb@kernel.org/
> 
> Ard Biesheuvel (6):
>    x86: decompressor: Move global symbol references to C code
>    x86: decompressor: Factor out kernel decompression and relocation
>    x86: efistub: Obtain ACPI RSDP address while running in the stub
>    x86: efistub: Perform 4/5 level paging switch from the stub
>    x86: efistub: Prefer EFI memory attributes protocol over DXE services
>    x86: efistub: Avoid legacy decompressor when doing EFI boot
> 
>   arch/x86/boot/compressed/efi_mixed.S           |  55 ---
>   arch/x86/boot/compressed/head_32.S             |  24 --
>   arch/x86/boot/compressed/head_64.S             |  39 +--
>   arch/x86/boot/compressed/misc.c                |  44 ++-
>   arch/x86/include/asm/efi.h                     |   2 +
>   drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
>   drivers/firmware/efi/libstub/x86-stub.c        | 360 +++++++++++++-------
>   7 files changed, 279 insertions(+), 249 deletions(-)
> 
