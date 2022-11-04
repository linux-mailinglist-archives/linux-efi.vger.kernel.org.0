Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A558619FB3
	for <lists+linux-efi@lfdr.de>; Fri,  4 Nov 2022 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiKDSWf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Nov 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiKDSWI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Nov 2022 14:22:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B269DF8;
        Fri,  4 Nov 2022 11:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQY8dkwRr63etvTAvDQuH/KZEb9JQMv2wnDdQl5k6dRCktR9c45xT4c2WTq5zhDpRGkwd2HklY/K9P/jaMsnVGhHbjWQkYHMaOM2x8In8nsrCACkUeT3lmrrb9iajc93b6jmS0lQGGjt9Qm7t50eYkLFTi/tefUgfYiD0pTmkQr6VNZEAgLYqQ8vBuk5W22nsan80GGAE3mD5Zyw2MCFirj8xi7ABuqGU2GVW7GwBvFeG3T+d/8R9H7b3iOVRtpPHsJmNLgpsbPqK/h+DzOq2aw6mcOaJKeTK7g70FEtcSnNX2v4DKpg26iOcJxqJExUXlX17Ad82/T20z+ExDe8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4+7RqpdNFhSD1ODBPfgDJ8k8MJp1vIXYW1ZvB+X7As=;
 b=QqVqZ5fohRgsWXbMGDFEQad0tgqGj01xg/lG9Za2lHMTsld1n/LiXgKqhoyDItoAZs6Sllss8TmVSwUTmCsrBk9TIkpG/6cegni4MlPizQdu+Vs299nKBOk+hP9uu/6bg9t3EUcP3W+27ap6Ph1OJSOynBuyvjA//NNu6PAIBhVWPWznq+PSbLCnJhRU2FA/tPDqT1y2W+glyqeLCBOLl9vWVwMl2pur0mYGtm7eqF/X48JGBh8lbKUGc4bT8XNUKsRsib7N6wLTZJAArtwyUot9dkJfebsKmqmy6AL7H6YTx8jZspc93BjdmESr0Z2fKgbCTzvxIzMnCTzz2OcS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4+7RqpdNFhSD1ODBPfgDJ8k8MJp1vIXYW1ZvB+X7As=;
 b=LRQHqT+71VqQ90zqF4/N5DIzsIuK7AokFM1Br0AGBAZVk+NCSM0j4Xl4C6r13htldKP1UFaJPcfPltUmNIx3obOia3SHlOCBA+ctkW8nWMKoDx5iuFGcOdHQLYW3LNk8KL38kDjWl0jJ5pdhVuTG78VhaLKANKZjD+zE0TSqcys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 18:21:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Fri, 4 Nov 2022
 18:21:32 +0000
Message-ID: <e2beec0b-22d3-91bd-c57c-8c8ad2137406@amd.com>
Date:   Fri, 4 Nov 2022 13:21:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 00/23] x86_64: Improvements at compressed kernel stage
To:     Evgeniy Baskov <baskov@ispras.ru>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1666705333.git.baskov@ispras.ru>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:806:a7::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 86954d0a-377e-41c6-f9e6-08dabe91667d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXhUj7lkbRPiE1nfrBrLYx2UcDnQ4hqmWB8UEJb6mkzCcAiVpbuR+7FBmp5LlUUzXx2e2+7mW/fMqhVqbZdmIUIGT9hTIyaeD9YNWUs0Py60WGiepulavJDa/PtvjuhquosdpAvEvvBdkhXcxAXStF85hAMXDs1l4g0sMLJ+/T+uEnO/UoxERZXfme5aYrLQ3kkV/MvDf9EWtnItmY1SkLktFteGAeN1tcbtx3jIfYE/CMmWEpedWcbFRjQnHJgO8oxN+dED1aSKiALIrtv5Zfdunyx1UWsFCV0Y3/rYHzGqFTgwzvK13vqTu1YheF+cfrr61TVwMsFP6D5wKoauSWn9V6HquBskPhw/27/jf+c70JphjUkciopa8hJSxep+y7zQvTxfRqGkzg1JfTKupHuVKLNO2XQHexhFdP8P0zh5E1P6/u73ngOMyABxYGtQ6ajL5c70ItfdEwHQGm5UzmJwlz4dqA8GtbnIFRWXD8RPmrTe0/cuTY/nfcB63gi9bGPL9q7fWvUynLBcNn0TQJkeGj3NBsmYwb8Pnp8i5P+lCzLgmhf4zvDCDA+U1WRQNBThM885rLvJKlcK5Ns3Eo5XbfDno7apmT/g2PjTtkyZmFlzInXdm+4Yzd8uQ6SuJRmAk6GmZdXC+2vjPYFUgFDzXOFFXKpdnqCVb2XhmU8gvj2hyQOiNJq7SCb09g982+8tryNk248BYayqyRQyVLW9quQq1/HkO76RHO5cNbMfGlxdjJNBXhTaZVb09zJyJmOcqvQKZEabCT9cqFv1tDkwyLmu+x+y5odBjZLbjypbbLA2Kq4ESCcUGWVgToOK54Lwq6qtp7xVcbvgVsdTFfNr0mIlV4sfN5cZAwTmQVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(5660300002)(36756003)(31686004)(41300700001)(86362001)(7416002)(2906002)(38100700002)(31696002)(83380400001)(316002)(26005)(6512007)(66946007)(186003)(2616005)(478600001)(110136005)(45080400002)(54906003)(53546011)(966005)(6486002)(8936002)(66556008)(8676002)(66476007)(6506007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1Zpb3Z2YjExSk5pOWE1K2lKRWxaMnRMS2ZQa2N1dmtKeFltOFF2ejdRcHBq?=
 =?utf-8?B?Wnc5VFZ5ZXlBYlBmUDdHZ3hIZENVaS9YOEorMlI4VXorcEJPNmtrYTMrM2ZK?=
 =?utf-8?B?eUluek5FV1R5OWhrNVVUQ2FyUWpVanhJT05CTVpvV1pRS21iUWxKOGJnWTBK?=
 =?utf-8?B?THZ3YkxKMmJlWjB3WWZ0dnFKajFGNStSZlN6SDJsdHJjTGdqMVpHVG5wR28x?=
 =?utf-8?B?YlJQbmQ3Wm9SMjMwYkpxS3lIemtkdFNqcHJINGhxU1F2TXQvVytxRmV1RGZh?=
 =?utf-8?B?QzVzdDkrRnVySzZ2Z1grbnYyVjBycHk0SXlZSW96dCtySUtyRmJORnBBdWF0?=
 =?utf-8?B?L05JQ3JyYjMvN2d5RUlESFBVSVJ0TnVaaWZ1dlFTVmJRUnk1QW5YdkI5WkhO?=
 =?utf-8?B?NEhaTDFvdFFUeE1Qc1BndFpyYTRUWVNUYkxOTk9zOGJLU3ZHa0YvQU9vdzFY?=
 =?utf-8?B?VXR6RFNUdUZrZ3BYOW9BMGR1cmtUNzdCU1pDUzlRdHpFbHRYZEZBa1FmdVZ5?=
 =?utf-8?B?MytkL0crcWcvenBVRFNVbSttVDh5UnphZGkvdVJJLzFGZnFHWjFGRTRXemVZ?=
 =?utf-8?B?bmVJdVEzZTFxWmhuOUxtSlFiNFMwTk9hdDRFY0xDdVRvMm9pZ1A5MnBYZzE4?=
 =?utf-8?B?UWxLMGlmV2c4bTZwN1E3NGQvcTd0WE5SY2l5RnBKeUhVRjlsdjBhVDlFQzRn?=
 =?utf-8?B?MW8rWGR4ME9WK1NNOHYwQ0hweHB2Rk9VSnJKU3pIelYyME8wZk96dW1ZSE1M?=
 =?utf-8?B?NTI1R3l2aXRJQlRvbmMrdCs0UnVhUkx0ZjBqODA3dFY5ayt4dUp3bHdMSWVr?=
 =?utf-8?B?V0dhSnE1enJtQUJGTUh2RExqZWZCSXlybURlY1FLRUNSWU94eDFUVWJRQXdR?=
 =?utf-8?B?ZHFCQXRJKzBFcHFJcEJJcGlTMFpZeE4vQmJBd0svMExyNnd5R09nS2lyWHRH?=
 =?utf-8?B?T2NiY2k3ZktFUEltYWVoUWlLWUMrcExXcHZQdWtvYjJTaVdZZUJFQ3NlOVI0?=
 =?utf-8?B?UHBEV0diOUY5RkVBeHRucnZNRnBsamtuTFhtQnhMdGVYQkpGbUN4b3ArOW56?=
 =?utf-8?B?UXdHYTNmb1BtZmFxbVRCU0Jick9PdnZmeTZ0bjFFOTNKdVJ1UHpQczVLYkFr?=
 =?utf-8?B?OEMzTiswZk4yRFpGZ0Y0S3g1M0VHay9JVGdEWEdIK1dEZGM2S1F5TnJNNXpI?=
 =?utf-8?B?R1htY1pqRUdnTlI4aHl2ZU5pRWJiQUdYdTdIR25IMEhZMHBJclVWL3haeE01?=
 =?utf-8?B?Tjc5R2UwMGJTVDFDR0w1V2JGTDl1ZDJVZ0MxT3dNb082T3c3RXViMndqVkF2?=
 =?utf-8?B?bk0zcmdTbDBwSWo2QjRtNWpPSzQ0UWdXVnRiYnF3RDhCZ2VhWVhRMTVMUGZp?=
 =?utf-8?B?WUNkeWpiZGJtL0hZcEplY2U3WmFEUTdQbHloU2FORC8ydEwxMnI0anNqUjM3?=
 =?utf-8?B?ZTRoWXBBYnJQaVBkV2tZZ2ZSTllCSFl3dzZQMG1lc3ZCVExSSUdCa1g4Sm85?=
 =?utf-8?B?Z3FQMGJJb1FJb2pSWmxGYkNONmFzc09rZFltUjJ3bXM2OEtaeXJScW14WHVO?=
 =?utf-8?B?aUIrUVBObHN3RlE0YTd5NUR2VUtaMUExVm14Uk9VWER4RW9TaWxvTWlpTUgr?=
 =?utf-8?B?MGxtbGtTMXp4ODNLL0JtZEphV0Y5RHlRQTBNL2FaUUd0NjFERnFjaXN2MGY1?=
 =?utf-8?B?SkwyRythQzNIMkI0dStjR01TTFpud295SDUzZlZjbDVlODFIVzBYMkV2TUQ3?=
 =?utf-8?B?cHdjSHhIUUFjRFNhL2Z2NUFXbjZ3S01vUGRSZk1mODlMVC82Y1V6MXRFK2Jn?=
 =?utf-8?B?TmZlWEsvbERJb2VnRGRzOVZ4MkRjQjdGUktFUjJROGV2Q2NHOFUwSXFsYm9S?=
 =?utf-8?B?Qm1VTUs0ck1GaG9LT0FBdjUya0V0ajQwayt2blhZN2VCdkt4bU1NN3o5TGsx?=
 =?utf-8?B?cDVYY3B2Zy9RemlBRmxWTjZNeW54Zk9Wblp2aytsNjhzeE94ay9oV0hLbGFz?=
 =?utf-8?B?MWpXeHNiY0lZV0tldjU5ZFJyRmhPZHdhK1JPc21vbE9wWmNqTWxtbUQ4eHVw?=
 =?utf-8?B?aG5KOCtQSW5mcW1uaE9BcVNmQTNtTXVLbE5sbWpWaTlYL2xYUzRpcGlNUHVh?=
 =?utf-8?Q?9tDwFmca14jeSNiE6XRF8YCeD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86954d0a-377e-41c6-f9e6-08dabe91667d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:21:32.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u0BG2U3NrsjMEGgO7E9nKOf9mhDeEm3Calbp/tgorsH5cWKuw5+iJrZGKGyqrJCjqg1k8kRSdFkyhfGaXFaMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/25/2022 09:12, Evgeniy Baskov wrote:
> This patchset is aimed
> * to improve UEFI compatibility of compressed kernel code for x86_64
> * to setup proper memory access attributes for code and rodata sections
> * to implement W^X protection policy throughout the whole execution
>    of compressed kernel for EFISTUB code path.
> 
> Kernel is made to be more compatible with PE image specification [3],
> allowing it to be successfully loaded by stricter PE loader
> implementations like the one from [2]. There is at least one
> known implementation that uses that loader in production [4].
> There are also ongoing efforts to upstream these changes.
> 
> Also the patchset adds EFI_MEMORY_ATTTRIBUTE_PROTOCOL, included into
> EFI specification since version 2.10, as a better alternative to
> using DXE services for memory protection attributes manipulation,
> since it is defined by the UEFI specification itself and not UEFI PI
> specification. This protocol is not widely available so the code
> using DXE services is kept in place as a fallback in case specific
> implementation does not support the new protocol.
> One of EFI implementations that already support
> EFI_MEMORY_ATTTRIBUTE_PROTOCOL is Microsoft Project Mu [5].
>   
> Kernel image generation tool (tools/build.c) is refactored as a part
> of changes that makes PE image more compatible.
>     
> The patchset implements memory protection for compressed kernel
> code while executing both inside EFI boot services and outside of
> them. For EFISTUB code path W^X protection policy is maintained
> throughout the whole execution of compressed kernel. The latter
> is achieved by extracting the kernel directly from EFI environment
> and jumping to it's head immediately after exiting EFI boot services.
> As a side effect of this change one page table rebuild and a copy of
> the kernel image is removed.
> 
> Direct extraction can be toggled using CONFIG_EFI_STUB_EXTRACT_DIRECT.
> Memory protection inside EFI environment is controlled by the
> CONFIG_DXE_MEM_ATTRIBUTES option, although with these patches this
> option also control the use EFI_MEMORY_ATTTRIBUTE_PROTOCOL and memory
> protection attributes of PE sections and not only DXE services as the
> name might suggest.
> 
> Changes in v2:
>   * Fix spelling.
>   * Rebase code to current master.
>   * Split huge patches into smaller ones.
>   * Remove unneeded forward declarations.
>   * Make direct extraction unconditional.
>     * Also make it work for x86_32.
>     * Reduce lower limit of KASLR to 64M.
>   * Make callback interface more logically consistent.
>   * Actually declare callbacks structure before using it.
>   * Mention effect on x86_32 in commit message of
>     "x86/build: Remove RWX sections and align on 4KB".
>   * Clarify commit message of
>     "x86/boot: Increase boot page table size".
>   * Remove "startup32_" prefix on startup32_enable_nx_if_supported.
>   * Move linker generated sections outside of function scope.
>   * Drop some unintended changes.
>   * Drop generating 2 reloc entries.
>     (as I've misread the documentation and there's no need for this change.)
>   * Set has_nx from enable_nx_if_supported correctly.
>   * Move ELF header check to build time.
>   * Set WP at the same time as PG in trampoline code,
>     as it is more logically consistent.
>   * Put x86-specific EFISTUB definitions in x86-stub.h header.
>   * Catch presence of ELF segments violating W^X during build.
>   * Move PE definitions from build.c to a new header file.
>   * Fix generation of PE '.compat' section.
> 
> I decided to keep protection of compressed kernel blob and '.rodata'
> separate from '.text' for now, since it does not really have a lot
> of overhead.
> 
> Otherwise, all comments on v1 seems to be addressed. Please also apply
> Peter's patch [6] on top of this series.
> 
> Patch "x86/boot: Support 4KB pages for identity mapping" needs review
> from x86/mm team.
> 
> [1] https://lkml.org/lkml/2022/8/1/1314
> [2] https://github.com/acidanthera/audk/tree/secure_pe
> [3] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
> [4] https://www.ispras.ru/en/technologies/asperitas/
> [5] https://github.com/microsoft/mu_tiano_platforms
> [6] https://lkml.org/lkml/2022/10/18/1178
> 
> Evgeniy Baskov (23):
>    x86/boot: Align vmlinuz sections on page size
>    x86/build: Remove RWX sections and align on 4KB
>    x86/boot: Set cr0 to known state in trampoline
>    x86/boot: Increase boot page table size
>    x86/boot: Support 4KB pages for identity mapping
>    x86/boot: Setup memory protection for bzImage code
>    x86/build: Check W^X of vmlinux during build
>    x86/boot: Map memory explicitly
>    x86/boot: Remove mapping from page fault handler
>    efi/libstub: Move helper function to related file
>    x86/boot: Make console interface more abstract
>    x86/boot: Make kernel_add_identity_map() a pointer
>    x86/boot: Split trampoline and pt init code
>    x86/boot: Add EFI kernel extraction interface
>    efi/x86: Support extracting kernel from libstub
>    x86/boot: Reduce lower limit of physical KASLR
>    x86/boot: Reduce size of the DOS stub
>    tools/include: Add simplified version of pe.h
>    x86/build: Cleanup tools/build.c
>    x86/build: Make generated PE more spec compliant
>    efi/x86: Explicitly set sections memory attributes
>    efi/libstub: Add memory attribute protocol definitions
>    efi/libstub: Use memory attribute protocol
> 
>   arch/x86/boot/Makefile                        |   2 +-
>   arch/x86/boot/compressed/Makefile             |   8 +-
>   arch/x86/boot/compressed/acpi.c               |  21 +-
>   arch/x86/boot/compressed/efi.c                |  19 +-
>   arch/x86/boot/compressed/head_32.S            |  44 +-
>   arch/x86/boot/compressed/head_64.S            |  76 ++-
>   arch/x86/boot/compressed/ident_map_64.c       | 122 ++--
>   arch/x86/boot/compressed/kaslr.c              |   8 +-
>   arch/x86/boot/compressed/misc.c               | 279 ++++-----
>   arch/x86/boot/compressed/misc.h               |  23 +-
>   arch/x86/boot/compressed/pgtable.h            |  20 -
>   arch/x86/boot/compressed/pgtable_64.c         |  75 ++-
>   arch/x86/boot/compressed/putstr.c             | 130 ++++
>   arch/x86/boot/compressed/sev.c                |   6 +-
>   arch/x86/boot/compressed/vmlinux.lds.S        |   6 +
>   arch/x86/boot/header.S                        | 110 +---
>   arch/x86/boot/tools/build.c                   | 573 +++++++++++-------
>   arch/x86/include/asm/boot.h                   |  26 +-
>   arch/x86/include/asm/efi.h                    |   7 +
>   arch/x86/include/asm/init.h                   |   1 +
>   arch/x86/include/asm/shared/extract.h         |  27 +
>   arch/x86/include/asm/shared/pgtable.h         |  29 +
>   arch/x86/kernel/vmlinux.lds.S                 |  15 +-
>   arch/x86/mm/ident_map.c                       | 185 +++++-
>   drivers/firmware/efi/Kconfig                  |   2 +
>   drivers/firmware/efi/libstub/Makefile         |   2 +-
>   drivers/firmware/efi/libstub/efistub.h        |  26 +
>   drivers/firmware/efi/libstub/mem.c            | 190 ++++++
>   .../firmware/efi/libstub/x86-extract-direct.c | 204 +++++++
>   drivers/firmware/efi/libstub/x86-stub.c       | 231 ++-----
>   drivers/firmware/efi/libstub/x86-stub.h       |  11 +
>   include/linux/efi.h                           |   1 +
>   tools/include/linux/pe.h                      | 150 +++++
>   33 files changed, 1848 insertions(+), 781 deletions(-)
>   delete mode 100644 arch/x86/boot/compressed/pgtable.h
>   create mode 100644 arch/x86/boot/compressed/putstr.c
>   create mode 100644 arch/x86/include/asm/shared/extract.h
>   create mode 100644 arch/x86/include/asm/shared/pgtable.h
>   create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
>   create mode 100644 drivers/firmware/efi/libstub/x86-stub.h
>   create mode 100644 tools/include/linux/pe.h
> 

Hi,

I was talking to Peter Jones recently about what was still missing for 
NX support in the kernel and he pointed me at this series.

So I had a try with this series on top of:

ee6050c8af96 ("Merge tag 'ata-6.1-rc4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata")

Unfortunately I can't boot the system with this series applied.
This is not on a system that enforces NX pre-boot (but that was my goal 
after I could prove booting on something that doesn't).
I didn't apply Peter's patch 6 you referenced in your cover letter, but 
I don't expect that's the reason for the failure.

I get:

"Failed to allocate space for tmp_cmdline"

    -- System Halted

This is early enough [1] that I don't have anything else output to a 
serial log from the kernel.

https://github.com/torvalds/linux/blob/d4013bc4d49f6da8178a340348369bb9920225c9/arch/x86/boot/compressed/kaslr.c#L268

Since this is only in the kaslr path, I tried to turn that off with 
'nokaslr' on the kernel command line.

I then get a failure of:

"Out of memory while allocating zstd_dctx"

   -- System Halted

This kernel was booted from the following path:
-> Insyde BIOS
--> shim (from Fedora 36 repository)
---> GRUB (from Peter for Fedora 36 w/ some level NX support)
----> kernel binary (self-built)

The BIOS on this system doesn't validate NX, but also the shim binary 
did not have the NX bit set in the PE header.

Your cover letter referenced CONFIG_EFI_STUB_EXTRACT_DIRECT but I didn't 
find this option in the series.  I also tried both with 
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y or unset, same result.



