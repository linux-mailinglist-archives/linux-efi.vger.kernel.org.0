Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C06707159
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEQSy4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 14:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQSyz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 14:54:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054883F0;
        Wed, 17 May 2023 11:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP46XUiWUdJQBF6ZK7QX3b7x5xDV+5J2+lUzNChTKylPMcVQp/X/nSf0BG4fAKwpj6aThngCmHZ/oA4+eNHN5cT7vgT/REoLmVC0rFC4uMQ5ctSzsY5FKFoZs5VkFwJNPt6Um7knpgnUY0RL/IMAzaBaO5PIGqN8aLN94ghcuT8q2DNL660SoIIzZV+n4yWCUxg73nKui4oZJRuJdyXE1g+Xx5+Zo/1GMT3xFt8TqVp0/mSkBaYbJnxNvy/rxwDOmUndMygZ1faZMJlQiYglPMYzommZnjuuQQAVYaIwqxzxvICUdg5gaohWCF0dnYIHZPusYPdNHgeL2qaKOF+e5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whlshW9V5E6ag5hUYphzvN4catomVpJ8vHBMZ+VT7HQ=;
 b=jUkKSQ7zWVXWwaUIybDqcisFPEdXGYAAaq7yADSpOZJJHmHxqZuFazcIbsxTIC/gCpGcJflVM3QCnRbXZz5hmYBHElNSnwY49tITa/elOh2B6PYjozRTG4LbXFse8HOJlXru8JAuGmpQnj3F/tKnRqE+OkNX1FEL6HuD8hzh0Y5vECsgjqGURFdgVZ2V10T+A3SjbuidwwjadgTWvNwnBGgcipqD6ahnj6ckNGMvIRSFVP4Lntee37gaeNBjuG4Iljy71T8ITPi2nYj9pzWf8K74zHGHoU9s1fsg7n14p432Fhjy6p7RwJi5V4kpA6+eBW/cpJ31zFX8pmNpm03H+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whlshW9V5E6ag5hUYphzvN4catomVpJ8vHBMZ+VT7HQ=;
 b=k6Fl+bnJKiDf7R7R0F4PZMOIDDhwCm6vDrU22PYGFa1mg8OciimoJpbLnXDxMUrTDyvSwN3zs7iSVbpMdM6WtRSDMYowBX8RVKfCNqHeTHcvaTkONthFtHU5SHRmyHsm93TLWeLQySzOj97W+qg9jEsCom+F1CbVItwpNcj98yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 18:54:49 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:54:49 +0000
Message-ID: <36b27e73-a292-17a3-ab7e-3028a7622677@amd.com>
Date:   Wed, 17 May 2023 13:54:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/20] x86: head_64: Switch to kernel CS before
 enabling memory encryption
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
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-16-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230508070330.582131-16-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 869ccbf8-bf40-4e06-cd43-08db570830b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOok7sUE8rP+lta2hGuQA/VdhdBOwHE+665q6zU4NYPfb8IwmnS5u/4El6WsOU6yxwEFDPqOkVoWdjCDVh57eMrtNvuk4B8k0Hb7YuLqrg0KyK3Qh+OZYix03cCF8896R0W+wBDAzIe4DulOfGTyccfYc6VdSTWet0pyj10Isai+7h3Ih3rn2zzwLK9zilx7jnbBqN2goyXFzi/ejlf0OTT283XEXx6tYLYCiosMFEsOsqHPhON9RNFLM6O6n3tTFf5IIewEZJnjumuRdIh6FoX+kmbk2/wotCbPMeNlTi985l0/zFcflnAOopxs/p3ChBqNwRJyQv8e9sIGf0z/Pgx5V+yu41N/JkDLnqMGJ8wt5Ut4R+6mVBbQkauHA29SK37IK4Gpb2JcVKHl/8PQeO1kRqibs2wfvFboMD7+Mf530E3OW+JG1AqX1OUTEOMl9LU1pXFnKAE0pK9QbHe09MIbabtZJBTxFF7UPKtPiqcNYkiB7Rw2FdLMb66t38PCWgi0n1/DkY0cFSXruvmQz2cMxW53y3p8C8nxszfWZbZgsr1yOsrIirl6bWoOr6fOzZ0WGd2kU2ZkSvZo7xlBB2K4fZAPF+6BLkWQABbssZuv7eQBCKcjUurdh12K/Y4KJu4UFrs7vPNihxlNMoM19RqsAjm5Vi1OxTrbNPMdDNNRxnw4S4pgpR+08DLfpicv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(478600001)(86362001)(6486002)(31696002)(6666004)(2616005)(316002)(66946007)(4326008)(66476007)(66556008)(36756003)(83380400001)(7416002)(5660300002)(31686004)(2906002)(38100700002)(41300700001)(8676002)(8936002)(6512007)(6506007)(26005)(53546011)(54906003)(186003)(411124005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdXUmhIOEZSdVJQRURIVlhWQTYzclBQY2FhZjFic0RoeXRDTEREdWFSWjFz?=
 =?utf-8?B?c1MyRm9WVW0zc1J3NTZ1UEFCRXBFTFRXRmtNTElPdlNPUEtTYTlhVUhMbm9x?=
 =?utf-8?B?MHlkaE9oa01zWVk3YmxhSktub3J1ZFB2L2EwVDNhdHFuVWg3bWRxT3MyWmk1?=
 =?utf-8?B?L1d1WkcvZk1uNSt5Z3FZNjBxck9IdFNTa1pRSS93RWNOQkJuTDVxZlBpdmdz?=
 =?utf-8?B?Nk9FbStjaG5mOUtWdjVYOG5Ddzk3RjRjRGpkVXU5aFQ2U3hwcmRYTzk1Qk1k?=
 =?utf-8?B?c2JYdkl4ZDBXK1dUT3gza3pqN09KRk95ZS9vYXl1U0ZiSUhzUlY3YVlCUksw?=
 =?utf-8?B?SDloR1FVSXBGVkZteFdRWlpmZkR5MUpaSCt5OGw0eUJWaG5WWFhGR0NVaUNU?=
 =?utf-8?B?dllzMm50czNwQVZnQ1Rvdm5UdHgyODBPOXJUYjdvK0wwTGs4UmxEZFFCSHR2?=
 =?utf-8?B?RFBNVGppSDdYSCtZZG9aS1pqUXdRK2pheUtyRElyTnVBSWRCRFduanFkbXlC?=
 =?utf-8?B?d01vQVRkb2lWaloyV3RYbVIxTlh6WHdMVk01VGhlNURES1dNMmJjbFlnaytx?=
 =?utf-8?B?VTVnSG44YmpPam5ndWhLV3orQTdUZlVBS2F4RncyV2dTQnM5MnNsSE5lenhJ?=
 =?utf-8?B?aGd6Z2hDckRVWEJ2QllOWElNQ3Q4dUttZWQ2WGxkNzZUamRieTAwRldOeEdR?=
 =?utf-8?B?aGFrVzlERzBwR2RVUlVJc0RnV0g3TTVpeVFyb0Nyb0h2U2FyaDAreFhKTmV3?=
 =?utf-8?B?eGtVcXRpRmtlVWZKeWhrc2hmenQ1VmEwR2ZnTmh0MXo3eGtCeGJOQkdwdkcx?=
 =?utf-8?B?Mzg4Sk9HREN6eHNYOEdOZktlbDFSYThHdEdYSnVLYXYrM0VvV29HUmpEU2hR?=
 =?utf-8?B?enVtSkRxU21oRWkyQUx6alJoSHI3OGxmYnpNeVRaWFdlTGE0RXl4U1BRMkRs?=
 =?utf-8?B?OXE3ZWE0aVc1MnNDVTB0U3VGY20xY1JTazZNTXE5U2NaUmlOY3doclVHS2Rs?=
 =?utf-8?B?OEVDYTFRNGdNT3h5SEVFTmlSZjJOSXo4Q1FJY1dzSHJia01GbU5TTmQ4SDhY?=
 =?utf-8?B?S1Nlb2RhSjZJTGZrNCtxZjU2ZnBMS2YybjNhUFphVXVpT2p2ak1nNWtXYXZK?=
 =?utf-8?B?RjVTMjlqNXZMcU5uK1NscmhqdjRIbkZjb1R2eXVucVhxQnBmRHpnU1lycm4r?=
 =?utf-8?B?Y3FzNWUzckcwaldnUmJ2a2JQRjhYcE13anFPODlWay9LdFZ6Vnd3aFpUZEc5?=
 =?utf-8?B?SFRJRzlWVkxta29iMG1veURKU1BSa1NRY1hHNGsrUWxSL1lVSk1SSSs2SjZi?=
 =?utf-8?B?VEhOS0lmYXRPM3NlaFQwWnlSVnRNL0FjTStVbnQ5dGRxbDRYTWhRZmttQnAy?=
 =?utf-8?B?VkFhTlpFT1RoUEVQenpMd05oeEdiWXQ5aTc4STlpWUJSRnowRER1Wko1NmdV?=
 =?utf-8?B?Ukh1UEY1TlNoNkIxZ25kNFcyZDVLZzg4UnpORzB5b2thb2NmTnhpRmg5VEh1?=
 =?utf-8?B?aStrNFRKblgwTncxOWZOak55bVRBZGxUVTdWaTVCQzU2SzRRNG5pdkNSSlFu?=
 =?utf-8?B?bklXNTJ2d25uZVdLbGdQWUhzYnNoMmFVL0FucmpJOFBNTHVFc2dadEYwMWxG?=
 =?utf-8?B?T1dWUm9Hck5uWDFSRlFzVGtHbGwzRUpSSnZObFdWSmFDbGk2RW91WnRpdzVu?=
 =?utf-8?B?Ky9BdFRQOWxZTnVKWmYvR0xwU1RqdjEySWxFdHdreFVJWFkxQjlNVXhpOW41?=
 =?utf-8?B?Uk1NSjUwU1NMQVhKMXdyTzZ3dHZCQ0NGR3hoamlZL21hRS91Yk5LRjQyWlRu?=
 =?utf-8?B?ajc1UmdjS2JKeWIyUkRDWlZ1SDBGSk9mdnFlZ0VSRTh6K1RtbmY5Qldtd0VI?=
 =?utf-8?B?S01KcmtoZUs3d3ZGbTY0aUpiNWJVeHorVTE1TmJGQzBpZEpPTVZldWVEeEx1?=
 =?utf-8?B?b3dod1RYbnJ2NWtKaHh1MnE2NGdwS2xEY1R0RWZNZnpCTi9taS9HWHgwOGIv?=
 =?utf-8?B?Mk55R3VyR3dHSnBLd2tOd2FhVVZhTTNzWFV3V3lMdzRZTmZUOXJxdTVUcTJP?=
 =?utf-8?B?akIzTk9IalYyYlphMmR3c08vbUVUNmV2c0FoWjZ5empSb29wMzV5UGpycnE3?=
 =?utf-8?Q?EByBNCE4sqC5UiAqttUhl4x8e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ccbf8-bf40-4e06-cd43-08db570830b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:54:49.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3hVWmaLL9ZqYpla0i+JGoKWP6mPE61mps4Ss2+qbWL0Z5VZL9l8dkOslgr6r/fiAPHXAB5Oh3rb3k+BehQqeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/8/23 02:03, Ard Biesheuvel wrote:
> The SME initialization triggers #VC exceptions due to the use of CPUID
> instructions, and returning from an exception restores the code segment
> that was active when the exception was taken.
> 
> This means we should ensure that we switch the code segment to one that
> is described in the GDT we just loaded before running the SME init code.
> 
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Ah, just saw this as I was going through my email backlog...  I submitted 
a separate patch just a little earlier today for this issue. I guess we'll 
let the maintainers decide how they want to handle it.

Thanks,
Tom

> ---
>   arch/x86/kernel/head_64.S | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 95b12fdae10e1dc9..a128ac62956ff7c4 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -76,6 +76,15 @@ SYM_CODE_START_NOALIGN(startup_64)
>   
>   	call	startup_64_setup_env
>   
> +	/* Now switch to __KERNEL_CS so IRET works reliably */
> +	pushq	$__KERNEL_CS
> +	leaq	.Lon_kernel_cs(%rip), %rax
> +	pushq	%rax
> +	lretq
> +
> +.Lon_kernel_cs:
> +	UNWIND_HINT_END_OF_STACK
> +
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   	/*
>   	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
> @@ -87,15 +96,6 @@ SYM_CODE_START_NOALIGN(startup_64)
>   	call	sme_enable
>   #endif
>   
> -	/* Now switch to __KERNEL_CS so IRET works reliably */
> -	pushq	$__KERNEL_CS
> -	leaq	.Lon_kernel_cs(%rip), %rax
> -	pushq	%rax
> -	lretq
> -
> -.Lon_kernel_cs:
> -	UNWIND_HINT_END_OF_STACK
> -
>   	/* Sanitize CPU configuration */
>   	call verify_cpu
>   
