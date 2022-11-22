Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4C6348B0
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 21:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiKVUsp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 15:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiKVUsa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 15:48:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676EC6B3B2;
        Tue, 22 Nov 2022 12:48:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4M8fjhFYUpFD300F9uomjPhl0LxS3SEIFFecyH881K3fsYnWnl9YuXe9ztvnZbUZeQ45drqGN7Jt9cHeKsm3f00QuU9jFlXr8W13L0OA2MsVxKG6SigTJeFjE+a4jMQqEDfJS1fZtZnBbrbU6D6CsOCugL6nDD+SHPOSMu9Cx6pMvTPpyNBgfdVU9jwPHBo9qOfUXApIp9GSrwzdXi3hncK1YQv7UIvoSAhsKQZnaU1d2nBwgcfsOAE4wDX7Wr3XQRD/fT/d+CW0VwQC3hrYTL2H4qtzuDEoayVmTEd/Pg9T24QIlI0ZRAVDpsT+s5zlJJMUZUh8BapHOiPTSNnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrjWvhFeCBifuDySHpepxlB4fT8lax/zJL0vBGf297w=;
 b=HaBVwZ7e3SlEfhdulHaUD02nZiVBH8xsPnQc+zvYsg2LUufKhlyggdI9JtoqEA1wRcM6p60SQOkcCsA4YDDbcVi9l+ZpW0R2r/pw9oZQS3KleiCco2XjuCh1ege0yaTcA5Z7IILdGpU1pLWTc6sjvxndpugZQA/3LBnl2RqLa7wik811l8nlbQHVs6LrZSICOc9EslaLFuGdOHhYuBGk07T7tAdL6afbGaYgyKsHnocp8OLJv5Ez5+QdGImI5fNWzHg+nOOoqZ24Ic4+0wBP/ZU7AH1Nb+ieLfLbfAL+msh2m6vbiqB3nwRvWeV409doxHsc3wcO4/m78xTxc93RsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrjWvhFeCBifuDySHpepxlB4fT8lax/zJL0vBGf297w=;
 b=CXhNPn26BvEjM/uWEXj2kwUnPj/vrWGjr1Ry+AdlvKWFQJfULUI+n36w/gU0maugke40/nWXNeaOhuQEf+0pFbPYQwSEce1lnTPmGuuiPzXnzMUF6k2995UiKASWTgBYMcv90Q0D6qJeiSErcI1F31JV4zAAZup6LdCFcQHYrOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 20:48:11 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 20:48:11 +0000
Message-ID: <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
Date:   Tue, 22 Nov 2022 14:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
References: <20221122161017.2426828-1-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:2d::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 416c5672-91de-4a01-d547-08dacccade79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XoyBgmKHlta1AYnJqgMWrr/s8nIuMBTGVp41310ZoWP6BdVnj7zzmt2D+1wuPecIbiaZah3sOCkw3hR4QQpiQfKOZY05HJPyPHoLFeI0NSTUTk+qrActsM3CIEY3ycHmnyOaxeEOPJPYOEBEzE/wa6v/J25vn+v7GEKRO6dZ8Trmp6VIrSj8p2/JCegkbV6DxGXou0OgV/6ZVCJyGdAlLZ82vgVHqdNR520BleoqUCQnZLQJPBHJZHKqFG9qDi/tnVgxbx2LjKpBdUaFncnF7YyOquaQrTJqQTaRBqDbu8sW5TroS8H78/KdweMi7dBoeJ5N7O4FijYld/bgigmWt7Xn2CcQAYqYBWl+TRwi9Fd7zTgqggudm5cIjihKOEhj88Z9KonkP5DCXQe17y4XIDmu+RIhJJzSleRNtu9sW3ofEkJwiPvGivhVNGVMY9XhcaCKiMzMOK62aIGzq0FmONmu8NH3QkIuy0bHhef3fG8ly2Uv/pwOOw2TXdifRkDL7ja9SyLl5cFk5jRBlzYJZkCcUZ+V5l2lIp+Qp7RJxn5wS/1EDjIuRRbAt66XRalD10bGSMNRwBTtD7z7HHhyAmMDAg77QoyZHZDnlMPPJedgzlbqtnYfUHMETwfoeQOVIMznMbAe09UhbcMh5Ems/9nl2H0HkYCuk2EBClJDhP22dWpSFSqKXBYOBSv47eQeltaQN6mRUHzIEHJekzZcayBNJ7EjSj1FeCU+ZlwFp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(36756003)(31686004)(8936002)(2906002)(41300700001)(5660300002)(66476007)(66946007)(86362001)(8676002)(4326008)(83380400001)(66556008)(31696002)(316002)(54906003)(53546011)(6512007)(26005)(6506007)(478600001)(186003)(2616005)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXdLY09ac2c4UGUwQVg0U0tRcTdQdE5nWHYxOW9WYTFvT1NyWGRRdm5id0dD?=
 =?utf-8?B?T2k2MEF3aTEwUExFemNJUklLVVRMKzllZTdTZG0zeWpaYXVZSmhhYnY0S3FJ?=
 =?utf-8?B?dXhTSWZkTExDeEFjTXBKc0ZsYlord3phM1FOU0xUUHorbzl4SVROMzJLeisr?=
 =?utf-8?B?WjV5aURhT3J6VVBLZUtBeTJWd1gyVitwUnpZVEw2a1BBbFhENW1OV2lJb1ll?=
 =?utf-8?B?WW1KalB2Tmpkcys3eEJocC9ZYzRXamhzZnlvYXBvbFBnbGJkZHBxNjRtT2tT?=
 =?utf-8?B?K3oxeFREVjNuQWVRMFRuMzJCSTVES2hNRHowYzh4c1E4TG51bVJkdjhHWVlt?=
 =?utf-8?B?NkhCR25Tc1h4WXU0WkJQWm5XOHplQXhtWU8yd2ZWVldSbWRDV05qbWJoRTVB?=
 =?utf-8?B?ZzhWU2dWdVB5ZWQxSEpYaFdLQTlSNWVhNzkvbHoxNFozRFNuaUVaREtRVnZt?=
 =?utf-8?B?dlZFRVdkQTRzU0ZIcUw1RU1saUJsWVluVVQ1SVlxd3ZjMEtoR05UMkc4clYx?=
 =?utf-8?B?cnVXTzdGN0ZvcGNsR0VLNmwwWE1yN1lWWFlBWWUvZ25iWWlwSmtKMFhhbEMr?=
 =?utf-8?B?UVdlY1o4WGxXMDMyMkF5WmNNRVNUZnd4cmVzZ2dheE15cjNibmFYYjJLRDU1?=
 =?utf-8?B?TDF6Qm44VE9nT3UvaXBLcVYvc1FlYUlyK25xZWxZVEFSdlA4T2JrUktCM0xL?=
 =?utf-8?B?V21FS09yUlk5eWFNNDY3dWZSVng1VTQxem0zV2FYbEhDMnRZYkNRWXR2cElr?=
 =?utf-8?B?OWcyRUNsM1lvc2pqUzAySHoydVBvTFlHTjVFNlpJamFFcHJkV3FSN3VPelps?=
 =?utf-8?B?dGY5dEE2d1YyeEZLemdOYTR1T3hDcWZpV1N2Sk9SRG9oa2crMldLcWlUbE9S?=
 =?utf-8?B?VCtXS2VSOFo2L1FQWmNucmVRb3BYSi9PMEh6bkhrSDFVNXFHekQwa0h6OTlP?=
 =?utf-8?B?c0pVSFlpQUxhSlRlaklCTjk3NUFnMVFrdm9WcmtGdWpoQ0puaDZYczg3c1pw?=
 =?utf-8?B?dFF5cjlWOTF1MVdnVlFVRFl2NVVmMGdMOEhXN1ZrN1BPV3MvL2prNmVBek4w?=
 =?utf-8?B?YTVWUE4vTTZPcEZrcmEvMXhVN0ZHL2JnL3dsT2pYSXhHUktpZGhOOTcwREE0?=
 =?utf-8?B?SHdERllYV1dVNGQ1RkttWXJheUxaYkpaNjg1dUVRVGxuUklyZ2tDSEtYbmZR?=
 =?utf-8?B?UTBHWDUvNlp1QnB4R3pvR0VHNWYzazNpVWhmK0JMKzN4cjV1c0J0eWhmOVpM?=
 =?utf-8?B?YU5Bd3dxRmZpb2N2bGJ1L1ZmdW1GN0dnUmxUcHNWNmtWeWVVcTROTDc5aHc5?=
 =?utf-8?B?cFUxSzRIc3BJVDNEaUZJS2hvb3hrUkphWExZSVl1U3dDZ2drbWFKWEJPOGZS?=
 =?utf-8?B?N2VGeFUvT0JhU0xJS0o0QUpRR1Z2eTlvcUc4WTY0SUZnY2FkbjZiTGExNXBJ?=
 =?utf-8?B?R2ZUK3N5T2EySFcxOXQzTE5WdSt5cTJCQmEzNDVCd1VONG9oV3JOaGNTaWxw?=
 =?utf-8?B?U2Z2SGVqS0xHNXdEeEF0Y1pUQ2kvUktpRzY1WUQwaXhpT2JHd2FTeXlxeDlB?=
 =?utf-8?B?SW9WTE8zdnJyNXFRVldYeEVmV1crbC9vcmIvVDh1d1QvRCttSUNKbWlKc0lD?=
 =?utf-8?B?OENWcEtVQlNWSjdtOVI1QVdUQ05YalRSWkNSUk9KZXQzcDRkRVVmcExSdUh2?=
 =?utf-8?B?WFlmUUsyeFh4N3dTbHZmd01oYklKdXkxR3RyYllFZU9mVUpNYUJVL1RkQ0Rw?=
 =?utf-8?B?cTFkMUo4MmhFaFNPZWZqL0srQWp5cFJ6OXk1azNNOEd0SXhJRG5TTmh1ZFFv?=
 =?utf-8?B?bXVvSG4za0M4dEV5c2pEcnVzbVJtUDF6WUlobVVWVUtTY3poU1dXeFF6ZFJx?=
 =?utf-8?B?aUpHQnc0OFhEMlhiYU9JSDI0YUJOL2hPckdTQnZ4emJLTGtKM1E3Y2dqWld2?=
 =?utf-8?B?VkhVM1lOc3lSWHhSWTlZTG5nWDZIMm41RFhsWmdCWS9KK09OYVVnOEpBMGsz?=
 =?utf-8?B?WGZFSW9ZalBMV2pHY1pEeFNGWWtOMkYwTElleVhZSlFnMU9Bd3pEUU5JK1FZ?=
 =?utf-8?B?eGt6RjU0NFhJSDFLWlRZZ0liNVE5TGpRV2ZZT1krRlhOK25Na2VscEFnSFJw?=
 =?utf-8?Q?vW8JeZQfYvWKyEFH9aUoSLLme?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416c5672-91de-4a01-d547-08dacccade79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 20:48:11.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tkZpk8AN9x5TOATje5Tl4a/fMfJoBEtvytAjs3mg3kye4J3TNdDcn/8LK79gGak8cgq7yt6CIhAiRu138mtgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/22/22 10:10, Ard Biesheuvel wrote:
> After doing some cleanup work on the EFI code in head_64.S, the mixed
> mode code in particular, I noticed that the memory encryption pieces
> could use some attention as well, so I cleaned that up too.
> 
> Changes since v2:
> - add some clarifying comments to the EFI mixed mode changes
> - include patch to make the EFI handover protocol optional that was sent
>    out separately before
> - rebase onto tip/master
> 
> Changes since v1:
> - at Boris's request, split the patches into smaller ones that are
>    easier to review
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michael Roth <michael.roth@amd.com>

This causes an SEV guest to blow up on boot in the early boot code. It
looks like the stack pointer is not valid and it triple faults on a pushq
instruction (pushq $__KERNEL_CS in arch/x86/boot/compressed/head_64.S of
startup_64).

Here is the Qemu register dump:
RAX=00000000029cc260 RBX=ffffffffdd98c000 RCX=0000000000000010 RDX=0000000000000002
RSI=000000003dec1000 RDI=0000000000000000 RBP=ffffffffdb000000 RSP=ffffffffde36e000
R8 =000000003dec1410 R9 =000000003dec13fc R10=000000000000006c R11=0000000000000000
R12=0000000000000000 R13=0000000000000001 R14=0000000000000004 R15=000000003eacdf44
RIP=0000000002000263 RFL=00200002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 00000000 00000000
CS =0038 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0000 0000000000000000 00000000 00000000
DS =0000 0000000000000000 00000000 00000000
FS =0000 0000000000000000 00000000 00000000
GS =0000 0000000000000000 00000000 00000000
LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
GDT=     00000000029cc270 0000002f
IDT=     000000003f55e018 00000fff
CR0=80010033 CR2=ffffffffde36dff8 CR3=000000003fc01000 CR4=00000668
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000d00

Thanks,
Tom

> 
> Ard Biesheuvel (17):
>    x86/compressed: efi-mixed: rename efi_thunk_64.S to efi-mixed.S
>    x86/compressed: efi-mixed: move 32-bit entrypoint code into .text
>      section
>    x86/compressed: efi-mixed: move bootargs parsing out of 32-bit startup
>      code
>    x86/compressed: efi-mixed: move efi32_pe_entry into .text section
>    x86/compressed: efi-mixed: move efi32_entry out of head_64.S
>    x86/compressed: efi-mixed: move efi32_pe_entry() out of head_64.S
>    x86/compressed: efi: merge multiple definitions of image_offset into
>      one
>    x86/compressed: efi-mixed: simplify IDT/GDT preserve/restore
>    x86/compressed: avoid touching ECX in startup32_set_idt_entry()
>    x86/compressed: pull global variable ref up into startup32_load_idt()
>    x86/compressed: move startup32_load_idt() into .text section
>    x86/compressed: move startup32_load_idt() out of head_64.S
>    x86/compressed: move startup32_check_sev_cbit() into .text
>    x86/compressed: move startup32_check_sev_cbit() out of head_64.S
>    x86/compressed: adhere to calling convention in
>      get_sev_encryption_bit()
>    x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
>    efi: x86: Make the deprecated EFI handover protocol optional
> 
>   arch/x86/Kconfig                        |  17 +
>   arch/x86/boot/compressed/Makefile       |   8 +-
>   arch/x86/boot/compressed/efi_mixed.S    | 351 ++++++++++++++++++++
>   arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
>   arch/x86/boot/compressed/head_32.S      |   4 -
>   arch/x86/boot/compressed/head_64.S      | 303 +----------------
>   arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
>   arch/x86/boot/header.S                  |   2 +-
>   arch/x86/boot/tools/build.c             |   2 +
>   drivers/firmware/efi/libstub/x86-stub.c |   2 +-
>   10 files changed, 533 insertions(+), 503 deletions(-)
>   create mode 100644 arch/x86/boot/compressed/efi_mixed.S
>   delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S
> 
