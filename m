Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB27A559B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Sep 2023 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIRWEM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Sep 2023 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRWEL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Sep 2023 18:04:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5F8F
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 15:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRtEonGCplS1jQVoOv8+k0BNipfRja9tk0mS/C/MIfwX0oi5J0Fr3eXHB4ibARg25opVLW3B2406ESVgsq4WkDaCDFinHuohVeccmCSXLCwctH/86SklXjkkAYZD193CNQDO0lmk3xpojbkCEaTBxY2Svn4MBam6KnMK0oMUHtyvqdNhnO/S78PovDDVmycUG1OTZc8BSDBPzzuOahmkK3qQTFffKq4GUazt6K934DkUryl/LycdNjHUVj/ObeU6CuUE/eR2VYNjGwV9xPnL1eIpdm9QYWfr/kY24EAlPB0ZO1XcPQSf8ZfSgMQ1da/dtQKNSqLsPjjbUN4ClHWykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG6uITHP0YLLLG+u3gX27a+KLfsE2l6P12HP0TRSy+0=;
 b=Y2cNahXE5SXUVPnBukarEQ8U+ARMMSUCBbDXmTghUpxhpcpRWh20M866445r2xfwsxo7LcZ9CQl6HFMXoOtx51mASYZ6NFZ4ZRsjQps6zZcpt+uR2lmmkV7Y79q83zNyJ8vWNswiNkXMMI3zLeX2ce7JE8v/XU/jJAOrN3RWnTj/yeluUd+rrO5DazeYmcxnYD1MSNiqMlsVymVB5nwg47blevxnII8EH37MUhoiEh7Tkibp/cjvfPkx/vRdA5YSCQGsEPKGZYHsL8WI/BH6tGqOOq85bHuuwHTBO8Gx+LKhjeH6wV2BDzJVWVLV7isXg2zYgrwLLWGGSVv5gfDkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG6uITHP0YLLLG+u3gX27a+KLfsE2l6P12HP0TRSy+0=;
 b=Z22xl9L2iHq6L1bHulBaeFII8hpnLuLX4+/Kq/N7da/vQQFxMTyCnK3jS0NcB3RYwD8F9Skib9lswWwj6ubFL+19fi7Mlb769VR8mzq7tLiKIBIpOpQpYFqUg4R+5vutQQdP3v9b1SvaGIhadow1ZQT1uVX252HbI+SxG2L6a2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 22:04:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 22:04:02 +0000
Message-ID: <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
Date:   Mon, 18 Sep 2023 17:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi/unaccepted: Use ACPI reclaim memory for unaccepted
 memory table
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <20230816190557.3738-1-ardb@kernel.org>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230816190557.3738-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:805:66::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 09343ed2-14c4-4ddc-1990-08dbb8932aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0X1AzxWdccUcqixTkzWItFXUeeYh5PBhziS2BT97T5o+/M1srjUkq+YXcp4w6tD1DbNiGA2VFsh6Q4EpI2hoAPPggTVnAkBjNQglMHaJ3q1YE3/PcQ4rfDPxvR/8RzTkQRwkzl8UOi1DyI7GpF2o21FYwnebQdDfIz6Mdmfown8HHhqA0xDdx5OXkSR3cunL06w7KLvRM3ef49dExaqZ72BS1X3xVPrVBBuMU9USWwrT7tO3qrvgIAc3f4jAlyy6yNgP5KpkERCmEDhucNmrW7XNho8knCNBiL6lEWUEGSsUB3NFT45qCZyzcIP9KX3mV2kAwbaUTdmpUEex8w+yWv1BLV9MSzEG7aqJ3TErl/CTezbgbl9AHRWOrp4aI8J9/pY4FtqHPcUzcxDENAUtXO84CG72CmEqypAV1IppDAL/Wqr/uwWF9wB7lAexjwnDqSAAxk+HDnExHH60px3qY8YmlWZmLiX1hq0aoOF3nOGUlNU636hoKIrW/KBGUqBYLGt+81khlxLBeUd8BXqifoF885eS0M4FTeJ7Z/uJVQ3VnVp0YgSAGbpVgXVyLp0BoyUwsdcfy1T01aztUaw1L8DUYPYLsuA9N27IrYgzk1UjM4+I0x5YyaKWE3g2eG0up67FPAXygoRsLKw+nRtVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(1800799009)(451199024)(186009)(5660300002)(41300700001)(8676002)(8936002)(4326008)(54906003)(66476007)(66946007)(66556008)(31686004)(316002)(38100700002)(83380400001)(2906002)(478600001)(31696002)(26005)(86362001)(53546011)(6512007)(6506007)(6486002)(2616005)(6666004)(45080400002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2J6cGJnOTJ2T1RXaWE4Y1VGb1V1SVdoSFdaU1MzcGZ4aFYrTUgzS1NWRDN4?=
 =?utf-8?B?eE5qVUUzR0ZKbjBDQVhQT0NkTi9mNUxrSUowV2UvZlB6YWVLaWZodGJsMXpO?=
 =?utf-8?B?SkRsRmlNVkxVNlhMTWVDVmthN1N3aE1GVmh2aFhHSzRKbDI4djgzTnk5NTNW?=
 =?utf-8?B?MzBkY1ZDZlhtcC9tRDhXMnlURDJPUlU2cGZTZjhEajU1NmFMaVZQY29IWE9P?=
 =?utf-8?B?U0QwUm4zZHEyMURCZGVRWUxIQ0MxZHlVaG5idmJNTzJkK3FZeTZDZGN6S1Z4?=
 =?utf-8?B?RERzdHZXa3MyK1dXK0h6N3ZzL2J4MGRKODR3bTVvaTJXc0ExUXZlZUo0Ykpz?=
 =?utf-8?B?bURNWDdaKzB4SHdSNmZoTzdJa3VZaFZXOWtmM1dPa1BnT0JoRzRkRUs4R2JW?=
 =?utf-8?B?eVNUNjJaQXM3Rm9TS1ZaWmd0TXlFWmZKMUI0R1FVdjVsT0k5UCtoVzZTYVB5?=
 =?utf-8?B?TWpzL21zZTF4Zno0dnBpWGUzRzFKaERQQ2hJeTBIdmhqMTByT082eGlsWHpq?=
 =?utf-8?B?WjlEVGNMZVFmRzErNm5IOTJTNlFYekhqbGV5OXFXYVlIelYwZHJqOUIzU0dk?=
 =?utf-8?B?ZDNGUE51bDdtUW1LOEtJZFdkcFIybDVaM2lmT1ZpbHFNNE9BS3ZSVlFNR2pp?=
 =?utf-8?B?MHM5cythRGFuMnhxZlZTTnVsbEpsNUlOODZ4cm1mTU1ISnhWeWZ1RXVzUndo?=
 =?utf-8?B?VUVPbDgrU1VIUlRna2hRcmh3eXBoMEljVUx4NHcySUNkcFptOXQ3RGdsSDdh?=
 =?utf-8?B?QVY0Z1dIMDh2bitRZi9RV01aT3VLUEwyNVpnTEdSUDU1bHY5M3NiQ1pUbGV2?=
 =?utf-8?B?eElEZU9NdDNCQ3JlTUQxcTByMVdmUzBaVUF6YktMY1hJcWhndkpUaE5TU1Fi?=
 =?utf-8?B?N0ZBMFVDbGFWeHo1MU5RMTdrTS9WODhNT2lURUZsK0E2MG1QRG85bHAzVXBR?=
 =?utf-8?B?bjE0K0ZmakovdnlIaWU3cC90WVU0am1NaHBQUzZ1RTdjbHlkR1YyS1lLKzJl?=
 =?utf-8?B?TWxRbU1QSldWRFFLMjlnZ3pnSlUySXBDcjNJdGpST1lkakpmL1hweVBIbURa?=
 =?utf-8?B?T24wc0cwQjhxUHpVWnpVaEUzY3ZhV3RnYTlhV2dzRWRNd3JXdXNGWEN1Q0Y5?=
 =?utf-8?B?eUdZYkVYOUNxTnh3UlBabkNING5NbHVPcVFKZG9xZFpKdHY3cTRhcElsVkUw?=
 =?utf-8?B?a3JZTVRjZHRqYmtvekpkcmtQOS83QnFsZjFYSG1qMUtGdWpuajNMRFJ6dXRr?=
 =?utf-8?B?eURUU0lHUGl0aFJBTHFNaE1FYnhhTWQxSHFsQS9wdnljOXZKUXVlL00xeVhk?=
 =?utf-8?B?NXlsUjQrR2RQKytoMCtlNEh4eHFoN205d1dBM1RRNzBqRitQZ3VyZ09CcDZn?=
 =?utf-8?B?aHI4OVpDN0V2MTJHdW1kenZUQS8wUTRMV0lWeTlEdzR4KzFIYTB3dGtzRG9n?=
 =?utf-8?B?SlMrcnJnQmJQcGd6b0h2OEtKREc4bW91SGR4QUptdWJNcXowd0thTWN4Tkpv?=
 =?utf-8?B?dmJqZzhpNW5waktTUVBlWW1GZW5kZGp3VzJORUFMQnU5K01jOUMyN2Y2SzZl?=
 =?utf-8?B?ekQxQSt6SHRET3c0bGs4c1Q5azl5NFI3UWtYOTU2NjVuVzlCQ1U3RGZQUXA5?=
 =?utf-8?B?dUQwODl4djY0QUtGV0wrNEF6dGJrSk9KUkhUSko0Lzg3RzVzb05hbWFTYjNs?=
 =?utf-8?B?YVNIaTl5WllUOWxaVkk1S0hISXNVakhRcFh4M011STBRMVRIcmNHVHVSNkJs?=
 =?utf-8?B?dnk2SEdycUpRRGlsOTFZRHMrTFRkSk9sNkhmbDhubkNXV0pndVlrTExIMlU5?=
 =?utf-8?B?THUxbnJYVHF5dW0yVG5pTU1OQVFxTzFWZExraXhKODI5eVZYZFZRR2tzOFBQ?=
 =?utf-8?B?bFUxVis0MFFVNUxFRFBsZGozZ29IY2RUS0ZVSU1sWGxUMzFodXNFT2MwOG1q?=
 =?utf-8?B?T3lxbElUNnBrUWdkek1XTUpLcmxzSlZTb0hqSWZOd0RBd3dQNm56TEJFQ2tL?=
 =?utf-8?B?aERWclZRR2ZQVjByMjhzcEpFMldMT3hrTnArWVVzaVJTY0JTQ28vcmUzZllY?=
 =?utf-8?B?cDBWVzZ4YUZwNkJJSGM4RWJhL1pmV0RUN3FSOEptL1ZVQkJqQmtaRm14Qk5G?=
 =?utf-8?Q?IdTg7mNfjC7kBOjralbWc0dwg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09343ed2-14c4-4ddc-1990-08dbb8932aed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 22:04:02.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgTl3jfTPoxXF6lnXnv6T3b5E+yj8FKHR5rAXDbc0rnJNTVvf1EDQWy9ko5SViWQwGgV8aUU8sypPXK2ZU14nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/16/23 14:05, Ard Biesheuvel wrote:
> Kyril reports that crashkernels fail to work on confidential VMs that
> rely on the unaccepted memory table, and this appears to be caused by
> the fact that it is not considered part of the set of firmware tables
> that the crashkernel needs to map.
> 
> This is an oversight, and a result of the use of the EFI_LOADER_DATA
> memory type for this table. The correct memory type to use for any
> firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
> EFI stub), even though the name suggests that is it specific to ACPI.
> ACPI reclaim means that the memory is used by the firmware to expose
> information to the operating system, but that the memory region has no
> special significance to the firmware itself, and the OS is free to
> reclaim the memory and use it as ordinary memory if it is not interested
> in the contents, or if it has already consumed them. In Linux, this
> memory is never reclaimed, but it is always covered by the kernel direct
> map and generally made accessible as ordinary memory.
> 
> On x86, ACPI reclaim memory is translated into E820_ACPI, which the
> kexec logic already recognizes as memory that the crashkernel may need
> to to access, and so it will be mapped and accessible to the booting
> crash kernel.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> index ca61f4733ea58693..9a655f30ba47db01 100644
> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>   	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
>   				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
>   
> -	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,

I bisected an SNP guest crash when using the tip tree to this commit. When
the kernel switches over to the swapper_pg_dir in init_mem_mapping(), the
unaccepted table is no longer mapped. Here's a copy of the stack trace:

[    0.074233] *** DEBUG: accept_memory:36 - unaccepted=0xffff88807f77ef18
[    0.075805] BUG: unable to handle page fault for address: ffff88807f77ef1c
[    0.076541] #PF: supervisor read access in kernel mode
[    0.077089] #PF: error_code(0x0000) - not-present page
[    0.077631] PGD 8000004c01067 P4D 8000004c01067 PUD 800017fffe067 PMD 8000004c04067 PTE 0
[    0.078498] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    0.078967] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-sos-sev #12
[    0.079682] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[    0.080507] RIP: 0010:accept_memory+0x75/0x250
[    0.080984] Code: 74 4a 4c 89 e1 ba 24 00 00 00 48 c7 c6 68 9e 10 82 48 c7 c7 50 9e 53 82 e8 48 92 79 ff 4c 89 e7 e8 50 b5 6e ff ba 2c 00 00 00 <45> 8b 74 24 04 48 c7 c6 68 9e 10 82 48 c7 c7 3d 9e 53 82 e8 23 92
[    0.082969] RSP: 0000:ffffffff82803df8 EFLAGS: 00010046
[    0.083518] RAX: 0000000000000000 RBX: 000000017fffd000 RCX: 0000000000000000
[    0.084271] RDX: 000000000000002c RSI: ffffffff82803cc0 RDI: 00000000ffffffff
[    0.085029] RBP: 0000000000000000 R08: 00000000ffff7fff R09: 0000000000000001
[    0.085786] R10: 00000000ffff7fff R11: ffffffff8286f9e0 R12: ffff88807f77ef18
[    0.086537] R13: 000000017ffd2000 R14: 0000000000000000 R15: 000000017ffd2000
[    0.087293] FS:  0000000000000000(0000) GS:ffffffff83273000(0000) knlGS:0000000000000000
[    0.088154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.088764] CR2: ffff88807f77ef1c CR3: 000800000382e000 CR4: 00000000000000f0
[    0.089520] Call Trace:
[    0.089783]  <TASK>
[    0.090005]  ? __die+0x1f/0x70
[    0.090334]  ? page_fault_oops+0x81/0x150
[    0.090780]  ? kernelmode_fixup_or_oops+0x84/0x110
[    0.091287]  ? exc_page_fault+0xa8/0x150
[    0.091705]  ? asm_exc_page_fault+0x22/0x30
[    0.092161]  ? accept_memory+0x75/0x250
[    0.092564]  ? accept_memory+0x70/0x250
[    0.092971]  ? memblock_alloc_range_nid+0xf4/0x160
[    0.093479]  ? numa_register_memblks.constprop.0+0x286/0x3a0
[    0.094079]  ? __pfx_dummy_numa_init+0x10/0x10
[    0.094548]  ? numa_init+0x102/0x2a0
[    0.094929]  ? setup_arch+0xc58/0x1010
[    0.095326]  ? start_kernel+0x5e/0x5e0
[    0.095728]  ? x86_64_start_reservations+0x14/0x30
[    0.096235]  ? x86_64_start_kernel+0x79/0x80
[    0.096688]  ? secondary_startup_64_no_verify+0x16b/0x16b
[    0.097269]  </TASK>
[    0.097499] Modules linked in:
[    0.097826] CR2: ffff88807f77ef1c
[    0.098178] ---[ end trace 0000000000000000 ]---

Thanks,
Tom

>   			     sizeof(*unaccepted_table) + bitmap_size,
>   			     (void **)&unaccepted_table);
>   	if (status != EFI_SUCCESS) {
