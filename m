Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EF63613C
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 15:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiKWONY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 09:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiKWONX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 09:13:23 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B6215A34;
        Wed, 23 Nov 2022 06:13:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtaP91A4gh+NlBOvWM+PLXr9866XRl9rDQ+j+g9J8QI68Ibn0d9m9SU2pawncCol9B2/p5QK5IHB2HLH6j9LFnmpcRgTSStQFC4YZXO224PHVh4KCibjAcsuAbPw53qoa9JXi4hleEFTZCMf4f/k/YWgg8iggQruQ+Oheq0kB3v3CCPfB3ZQBKiszgjnbePH8YbJ2s51zwYRN2fj+Xh/7xklClaWYSaZn8Sfl6KkciocxaTEv1QRBc2UqqgNEAN8Pyt8XPx++Vkg2mpirHBSbRfCcIci6J3X+fyQleXJXtEBp0c9XE+URhPpY+W+p4k7ATVu9HahtlA72oRG6rrHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGEliKDls+0+kMfwRBqgjtjc5MOzlEKarMg6yQgPjF0=;
 b=NOcHiiv0lLgD+sT/J17V6bx2PKVxgN12BB2lEgOhnDxtH9S8JlwKvbs3Pr/0JaOD1y2hWfkzqP2hrJ/Mypl+uJDSXD2ATATVhGdpP/6IrAm2N4vTPlVsS+/kqNS8mYlVmX4E4+8S5GyYNXXPTTGr+3hqcf2NzAjXaMh2hz4CH2v/olHYW8D0qvSXDVsgWsKE0aM642dVfKWzjJMVRjDWtNKsXsdSZh06OG90mp5pVGeytpWrsgOJ85mVjf9TU06OaBQr5AlRhVCQup4VqhtakdWWlihOHuQi9Jnrz3fmYF4/2LboCxob9jnokWHHbHtUm4zRw7eYzV32Ge/NyWXjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGEliKDls+0+kMfwRBqgjtjc5MOzlEKarMg6yQgPjF0=;
 b=uUakFAnFUQx4JBMhs3VeHrrtWpwTOwNMZrye539CtVh5J2/dBRNGVaIURorlcAHjx6BVCmYBvrbkhu2ucP/tX6lnSIu0axAjHrjNmor3qrq3qubt2dFRLG7kOxpN0XoxtB/H9yEWrat2MIg8LXemMLYOFtdy+o9q3Ue0S7UNSA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 14:13:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d2d2:c91a:5927:104b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d2d2:c91a:5927:104b%5]) with mapi id 15.20.5857.019; Wed, 23 Nov 2022
 14:13:20 +0000
Message-ID: <e4f252e0-4d31-dec5-a43c-1057766c3213@amd.com>
Date:   Wed, 23 Nov 2022 08:13:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com> <Y336yE4P3NjCGavN@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Y336yE4P3NjCGavN@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:8:2a::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ce134a-b6df-46f3-cd7a-08dacd5cdf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZyNTx/LFdHkGpnz9UJ5/mod45Ocv285WR4C+0OSB58xfB72HKheIw/MLXgTD22jFUjF+2BX3nCUti20PsZKWWUjIQA3h4djZJ4O21W4AN5HYc06nk3QaO0pluJ5eqIrreo7pOdYBWeh+Bjqi2z9dsQjOJ83Ne2NbkPr1LTbfU1Makm3lTXvfFhJRdqlHV0IqOyvvmGOlyAiEu75WOWGcjpF1Chd4qnHuz6cKZAL/BCQN50MuZPJQ8r+ws1aKdfZ9FKg5jqA7iD25MB/etPJcZS7e458QvJAPPQBLSBkoE90k/prS5H/a0iRqoTzpr6Vuakba0pfm2RWmJB97czlY+laISLJn2UhUDw6Q08hQSpE4IqPQoF0PW1hQrh+l1W/lS9vHCL8ZoGOhWXxHM82aUPkQdyFoffMYQIju457CtG5Q9nDMwwO4FSJ7rvEdnYl6CKPt4Z4BCigMumOOZzpNfdW+wmmYWF93kEgx1nQN3CnwbqdO0dbSZojs4N4YaSwlYFswswcJgOQ5cckUEQc1UdhUIq8B0Hs0kfbdG0HNtmmByudf2uQ7tfli6kUrYpC6P7lEv4e3qzpqptfT2kUJPDobUPc8Y2JhKutiTvVD6y6dmE5We1Uvhq/f4IjlnR5gVCLAjzpSd+lL7vqVUEHr/zTuuAFy+jvDXG8Rub+W9cgHOmhtIUenuQ4EFNDD33nuxZVJ01MhFe1RI8NtRJWqtozBw2buPbe2oFv+ui5xXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(31696002)(66556008)(86362001)(36756003)(2616005)(41300700001)(66946007)(53546011)(5660300002)(186003)(66476007)(8676002)(8936002)(26005)(478600001)(316002)(6512007)(54906003)(6916009)(6486002)(38100700002)(6506007)(4326008)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTZWLzB5Q2o1SWRzSXlZTENmY0V0NUhVWmp6V3BUZFF2VlhYTG81NU5iK1V1?=
 =?utf-8?B?THFwaE9LYnNpZjdZc3hSaGszN1kzN29HSWtOZWVJQ3l1SFdJZk9kTE5SaTdn?=
 =?utf-8?B?MWxvbE53a2hxVHNRR2JWUDhXb0ZGWGpnaVgvcmp3NUhsVnpiUS90RWFKN3Ju?=
 =?utf-8?B?QW5RQ21KWVJsL0tRQ3oxNEdoSlJWQVpFM3V5N2VXVFZKVXowUDdJK3BPYkRj?=
 =?utf-8?B?MmdseHh5bkxyd05xdmc1NVZXaG4vT1lLUCtPaUxNUlRzVllDSS9EQ3dYZnoy?=
 =?utf-8?B?UUVMZEZ1Z3hLVzY1SGVHRFAxMCtmVXg5TFpwQW9HdCtTSmI1bElvckpWdEVH?=
 =?utf-8?B?elovWExtLzZ2Z0N1a1lSZUR5c2ZuYkFxNDMwbzJHN09kMFRSY2o1c1Z4ZDdX?=
 =?utf-8?B?R3UxTGhwc2NNRlZnUW80NzJXL0Uwa2xrRFg0N0dHMmhKMSs4MVczOVpTSlc0?=
 =?utf-8?B?RnhsWnJ2N1Q4UzFtbkN1S0c2Z2pXLysxMldSSFNLVUY4TU9qS2FGQjdiM25w?=
 =?utf-8?B?dk51ellCR3VMNDN2bmZyMDd4KzgweTJsV0NVYU5QTVFiNEU1UTRXTTJ5ZDM3?=
 =?utf-8?B?SUlXczZaeTdNb0J3OGRvVE1jUmpBZzJRZHppWVBYMEtpeG8rNlB4cmhacm5I?=
 =?utf-8?B?ZzJlZ3NraThndVhWTG9GNWhKUVhCSXVVTnQxMFZlb29zdXQ0UmkwVm92K2Na?=
 =?utf-8?B?R0I1MlZKYTVnRkV5dk8vU3NjT09mNUJPZEliY0xhYVAvMk05bWpyYVNOYTRh?=
 =?utf-8?B?TGt0Q3RFbUlPcmdGcCs3SkpLZlNEUGduQUZCOUZNVkhiY2JmQ20zbm5LZC92?=
 =?utf-8?B?clZMNkJyRFZnRFNKWEk3QXdFWFlnZ0xQeS90elA3WjF0TGl6S25Na05GM25r?=
 =?utf-8?B?b0pWb1pCajM3Zk05aWl6a3Q2UEtxOUJtK2llTFBVbWhyM3JHeFp0NWk3UHVm?=
 =?utf-8?B?QU02bFZucFhiVXFOTmJYamczNVk4bVF4VksySmJzTytaR1l4TEhDQVRKZjdY?=
 =?utf-8?B?QnlPa1RoaTNoM0podEYyMjlCVEkwUEdudUdjWGhwQWx2YThCNXc2dGJnVkQ3?=
 =?utf-8?B?clBMcWVtZ1hwVmRtb3dKY2FtOXJLemtFUFo2YzU2L2dSMWIyZ28yUTY2Umpx?=
 =?utf-8?B?MFB6STg2T1Z2eVA2M0hES3ptdWw3by9lVkNya1hUdmIycVR4cGpleTVPNitE?=
 =?utf-8?B?OWJ2Wjhnb0NpQTk1aGNWMGJYQ1BBZjhzZUNndlRlUThnZm1OSlQyNXU4Z1BM?=
 =?utf-8?B?MjlKeUJYNEZlanRwNjJhNlB6aU5ZdFFQOWVld2VKNTFuZU5iT0RkS0F2Wk5x?=
 =?utf-8?B?LzNnenBSQTJjc2Fvb3lLNFgwUmZVUHI0QUczMk5tRmhKdEVzQWY1aUFnY05E?=
 =?utf-8?B?RkxwTDRHTzI1dEZ4YXlMMkRQSWdiS1dZSG5mN1JWLzBFcUhyOVEvQUFJd2dj?=
 =?utf-8?B?cDFrRkhWcXNOZ09GYndoUkNnSElYanB5VnZsU0FUUjZHaXU0T2I5dDNmbjVn?=
 =?utf-8?B?TzBqbXVXUTRzNTU1YlBsR2Nsd3pJWjhSOG1lU3E5TWhkN0NEQldKQ01HYmRP?=
 =?utf-8?B?MnFmUTlmNVBnRFJnTjRUcU85cFRPanpGN3hJK2RkaTYwMTJzYlBxUUlEZmdr?=
 =?utf-8?B?Rms2VExlaHNMWHpjMWpIZUxZckJFRnl1dTlWVU5kb2NVa3Z1RmNvSGJUR01I?=
 =?utf-8?B?cjBGb0E4bzFXYW9QdGhSZGwycEVsa0EwWGhRb2Fwa3FHR1pZRmhycTlLenRs?=
 =?utf-8?B?NGlieEdzMHpOdlM1NmF5eS9EdlJ5TmZnU21pb0xIR0tkbHIyQy9jSm5JVmxS?=
 =?utf-8?B?dm9VeFRDaWJ3RTIxQVN5MVlqaHdIbU5rK3ViYUpOUXNEN0g2QXh2UXdwYklu?=
 =?utf-8?B?ZER6YngwazJocUhmU1VncVFNTjVlWGlUd2hmMG1DSU44OFFUUzNYWjBEYWhN?=
 =?utf-8?B?bkZma01VenE0aUFHWEdvUXBJajFqM1p3TU8zRlZDS0NFb0ZiYUlkR2tJUVZG?=
 =?utf-8?B?U05iYkpvWW9XUUdaQUlZZzFNVXpLYTlFQnFSNzlJUkhhVUNNV2FHQTVtZDFy?=
 =?utf-8?B?aVhJQU55WWZjejI1dlFpblBKdGtMdlBFN29PWG5vdEpadExYVEpJQ2drQzRl?=
 =?utf-8?Q?R8hlRkpWM0J9hl8S3Qg0m1+Sz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ce134a-b6df-46f3-cd7a-08dacd5cdf9c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 14:13:20.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0SoLhw0rSYm0bLql6OJ4MV5obBC1tRuHA1NluGTTpjpUWShpi15EYs575/j0XRYqTfrE3bTh+DN0yDovc3r7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/23/22 04:49, Borislav Petkov wrote:
> On Tue, Nov 22, 2022 at 03:49:29PM -0600, Tom Lendacky wrote:
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index cb5f0befee57..a0bfd31358ba 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -23,7 +23,7 @@
>>   const efi_system_table_t *efi_system_table;
>>   const efi_dxe_services_table_t *efi_dxe_table;
>> -u32 image_offset;
>> +u32 image_offset __section(".data");
>>   static efi_loaded_image_t *image = NULL;
>>   static efi_status_t
>>
>> I assume it has to do with being in .data vs .bss and not being explicitly
>> cleared with the encryption bit set. With the change to put image_offset in
>> the .data section, it is read as zero, where as when it was in the .bss
>> section it was reading "ciphertext".
> 
> Hmm, two points about this:
> 
> 1. Can we do
> 
> u32 image_offset __bss_decrypted;
> 
> here instead? We have this special section just for that fun and it
> self-documents this way.

Yes, but __bss_decrypted is for the main kernel, not the decompression kernel.

The original value was in the .data section of the assembler (before the 
patch moved it), which gets initialized when loaded. Having it in the .bss 
section where you hope that memory was zeroed before hand is the issue.

> 
> 2. Also, why does my SEV-ES guest boot just fine without that change?
> 
> [    0.000000] Linux version 6.1.0-rc6+ (root@ml) (gcc (Debian 11.3.0-1) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT_DYNAMIC Wed Nov 23 11:27:17 CET 2022
> ...
> [    0.336132] Memory Encryption Features active: AMD SEV SEV-ES

Are you booting directly using the -kernel option on Qemu or going through 
the bootloader. It was only when using Grub that the problem appeared for me.

Thanks,
Tom

> 
> Thx.
> 
