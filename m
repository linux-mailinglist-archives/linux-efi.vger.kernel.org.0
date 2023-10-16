Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF97CA3E4
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJPJSC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 05:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJPJSA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 05:18:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E195;
        Mon, 16 Oct 2023 02:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpSmm+o9axp2EzDRmh9LunF+YwqUCOQ/ePAYTVOPH7qpqtrzb1wqAD6ULfG3Y2ARtOKDYwwSaoCdsEVkOL0klTlWtXEybRRlwMOQlrpTtmnTbvCOcBhJsAp5QsNwrkocqW72Tm4t9tQMdoFVjukO12Pey/VraiamoQ371Ilpqv9gPwEZxZBklIY1yzfvCaW+hw+AE0BVdHQQBnVhdAs1wCBqEvYnpoe+onLZr1TTA+i4F/XJKL5iOYAM4KDc+tGWUp/lDmYb9PbVdhX9z8Ye+KPhwoqbyyl21mR7OP1bozVI8sd57EVPmVP6+LE8SJxd+PJdy8Ow5e/dcKfMdDZr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y3WGGqKuLB3XRWr2NKus7bt6g8HHfm+Wy3cY4Rch5Q=;
 b=SoM1ds/HysOv/yRjU2J+mEHnxtaZN/XXbbf6mKJ2t4+k7S+JeBM68/1HyxIi0LxkwurhtfTm6Ij/L0hjA9Q35DSWkw780aYl97amcn6dbZoN2LdSJAZj+XBib6SxRUjnnRMFHxSbwq0SRy/hOCBw0rChxSF01JRfILhj9n/oBRKiyiCyOQ/8usSNv1MYwKjU88JPisxC1XbsPOZmBKyGlYPpauA6MhB501ZqgV09TpBnNoJl0eMyYtMn0XdTKhZz7S/+kRWlm5fnJVnDNBb4IBXJSTYExeGJw92p3Vun7YoPTxts87rk+7XfZS/KYYZCGcKzaGJgtJEKl4xh3/JnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y3WGGqKuLB3XRWr2NKus7bt6g8HHfm+Wy3cY4Rch5Q=;
 b=0NBnCUwaxKZWfhb3ZA5Fd8LH2FM60irFW7ii3gisj0alrzfHVxuK9gU71aWx4pGI5dDSzHFAY/eOm4HTSxif4Iaz6e56wiT9LW0jaxrMzfTHPjQSz8VEtfGp0nGzn+8aBec6NgCnfiN5NeXw6/kIsdc94qCStjk8+Fo5b+iJ9Fyb84pKqD209SML1YuzBUUskIZOltj//rT2NfAbCghkqW5o8R4yK3Wnopv3v46Du3pV/hFWhC8r/j7c4cUontc960S3NJTJw0/jTLPEgwyUCxIyqRbuqeAsXxJU2Wp4vvI0cQezQtZ1+lTTxIUx2XytZz77bjYA/39FQTCp9XanCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU0PR04MB9227.eurprd04.prod.outlook.com (2603:10a6:10:352::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 09:17:55 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 09:17:54 +0000
Message-ID: <1a92dd91-fbdd-49ba-bfab-66f5e3864aa5@suse.com>
Date:   Mon, 16 Oct 2023 12:17:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        philip.cox@canonical.com, aarcange@redhat.com, peterx@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
References: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU0PR04MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: d51b7585-9d71-4eb2-e765-08dbce28c7a4
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ciAJz7sF8Y9cScLt2wk/S67PG3XN+Wd5M3FNbpt+PvUy5l2UTkNoN7vX3TXDECPoshp/QrpbmQdy9ANqilCfgJY22GYvfX7Nx15ZYFSEorJHSQ8fDQoylBo1KbVaXOD6moDRVjurpeARJqSd8mTiWjyrjQToVMslopSC0KJM51uVtqQhLDK7iDxfVZmOKxOC+QUX8ziVXoN6QOIFyE6uKER9QB1+ibv2DLPiZMTHeDJa8edf8SYlRL2Og94fvFYGFjAkQbuhjYcz/x1yECuMk8DaxG+o3wO2AFnkPCcArnU9c/riaJQOYGACB/7d+BSI52H8xco4OISBbjKquFaQ76WOXZQN7LJ70IAcyajse6hFYIBDrmyV4Ku5k8CBIn764qkn3XQACEAjBpabBUG0+pqNuCFVCthos35zNWK0Zqn4EM17dBJWB3y00siZJaLPNrEhwWy5qfbqxFbGAmC7aJj26Q7hgcMRQpYlNWdBj/Fvw60v/rcKtnrRGAAskEW0fSeOtr0BX1mqawcbl9MYOIk/PteD4JsLQoxyXf+FfzKoIyDgFMnRWgA/ps3Jwf8je6zWjQnCfpPHkoGtxpma2LvM8lmmUrk9LiV3bto0zLKkJQoUsfWUY0QnJDMWNGkvGUzclOjyu7eRIFzsyquwRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(2906002)(7406005)(7416002)(41300700001)(86362001)(6486002)(478600001)(31696002)(66476007)(66556008)(36756003)(54906003)(66946007)(6512007)(6666004)(6506007)(316002)(8676002)(8936002)(2616005)(31686004)(83380400001)(4326008)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRPTWhqeFlMR2sxZ2J0K0ZpeE1MREtpTmpzWFIxcjJNMngySG9kYmlGYk9w?=
 =?utf-8?B?SDM1bHZ5SURIU0ZqLzNiMk00NTc5MlRIeVc3VmtSSXBQWDc1VFZWZVlUTFhJ?=
 =?utf-8?B?OXl6TnNPODhrTGFhcVhyd3dhME5EeHA0d2lhR1FGbjdCWDkxRzMrb1Z1Ym9L?=
 =?utf-8?B?ZVdReXVidTVOV0o2SHR6bkZ3WkVKUHFVR2tuMGYrSkZ5RDV6MWNYbWo4ZXhR?=
 =?utf-8?B?SkhNdUladlJIMW5MOGdFY2ZZcWRxd05YdzRnOXFBZnQ0cXh1NHlIeUpSVEZ6?=
 =?utf-8?B?TFRTVlBrcnhCbS93UUE1L2M5bEZJRndoRHp5Um1Rd0ZXbTBWcm9mUUkwTGxs?=
 =?utf-8?B?OXVQbHUySzQrcXg3dUpKRVNNelZRbE5GTkk4bWtqVlQvOEI1VU1iMEtLUi9s?=
 =?utf-8?B?bzRnS1FSb2x3Z1RYbG4rZnk5V2NnSENIbllJTDBDbWhMdi9BSllSKzN4OWUr?=
 =?utf-8?B?eGVvN1RNODlWckJ4VnNIMmZFMlRIeHlLWkQxZmJ0RTV6RmNNWDcyT3RsOWNu?=
 =?utf-8?B?MU1oMzN5aE9hazhFbFBheHpaNXNZSVVKU3R0SUtucHFCS21jZDVEaFhXTFN1?=
 =?utf-8?B?UGtYSmptcWp0dllneDMvYURqSkVjOXVKMjNBaStpUlBkSGJkK2MxdHg2ZUVX?=
 =?utf-8?B?MW02NEFjNDBrOFNyL0gwYXMwdkNXU0R6NVlCU1lrN3dKOHFFTGFJY1JmTDla?=
 =?utf-8?B?Q1RUS3ZqV05mMk11a0dqVGp2ZzhaRm85SmJZWDMwMlBSeCsrTll3MFJoMEJO?=
 =?utf-8?B?LzQxdmxMai9xcTg1cjlEQzA1NWNTanNTdzdVbXJ1OFVZaGJyQ3h2eTJwcmty?=
 =?utf-8?B?QzBKWlo3UXE3Y2N6T1Y0OGROSlkzQWp4UWh5dmlublJpQTl4SHcwVkN0bFhs?=
 =?utf-8?B?R2hWb1lhOHczRUI1RGcybDEvZXE4RGVnbEVtUVFEdHNJbmJrUUpaUUM2dkh0?=
 =?utf-8?B?ODRqeG9UMnhJa0NIWW1JaFZ3QXlSam9uUWpvbHNWdk9uV0REZjRLWGdzS25B?=
 =?utf-8?B?R0lKTStKUlpKNkhYTTRlN1VFK3AwaiszRExDZVY2ekZtek81U1d0dGdac3lX?=
 =?utf-8?B?QkJRTTFvbnduZEVDZW1td0xSbDdxL0diTUcrZ3FsOHhodm91TzNpV3JDYitt?=
 =?utf-8?B?ajdjZndDUkpLQlZTeWVPM0Z2QnZMMklYSkJlWVcySmNuOWgrbUZ5Y3BIRGxQ?=
 =?utf-8?B?ZG0vMnNETytyUmpkekkvN25ZU0hNU2F0cDhyNTdxY0F3UzJhTEdEekhWQXY1?=
 =?utf-8?B?aXY5RDBHQlE5L2s1bTVFMXc1N09FZXdBZFBuMFBBUmpLemZWa3RYbUN0T2g0?=
 =?utf-8?B?TkpvM2xadHlMenhWM3NqZWQ4NGxYKytTM0dNUkJIV3VqNHRscDh4WERDUGx1?=
 =?utf-8?B?b2pPOStxZWU1a2tmRGdsTjlSbm5nR0ZubEthRjRYbmNiblIwc0lHbmc4VCtz?=
 =?utf-8?B?TnpwY29KY054Rlh3Z08vY0pDUko2ZHE1K24wcG1DRGZVUjF5NkNheStsbkxR?=
 =?utf-8?B?cGlMdFNUN1F0ekNEYTJpMWVOcGo5MmhhNUJrV0l6SlBhcjVLbzgzczd3bWhy?=
 =?utf-8?B?emViMXc2a2pMeE5Ra3VpbFdWaTdTVnpYQnI2emxyM1N4eWZwV2laT2tDUWhG?=
 =?utf-8?B?M0N6UW45dU9xaWVjNklxVWJSSnBHemdZMW02b1ExUTh3dmFPS3hBQXNYSktr?=
 =?utf-8?B?b3JyYURXV2Y4MnBUb3JtVGlCb1VjUkc1UUkweUQxbWlKTVJXL3l0c0Y4Zmhz?=
 =?utf-8?B?RU41UVZXYnV5YXQ0MUIxcWVZTnpWV0dnR3p0NHRGZGkvR0phOWNkVFMrZkwx?=
 =?utf-8?B?YWlpTmtRb292c2g1dHFOdTJtUnUyenBxcU1lV0YzejRRN0Y5RmlybTJZYjhW?=
 =?utf-8?B?VnBRZ2dqd3ZRT1A0SWtxdC9xTVM2K0VjMG1yYnZiS3dZNW9iU0RuR0hJVEl5?=
 =?utf-8?B?YnRNYUQ4ZXYrS0VKejdBTUZYSWNhcUJhYmNOTVRtK3UzcCsrNkRFamIvc1pB?=
 =?utf-8?B?OTVDUmJQZ3FHdDlYcDZQdG1MS3dGQXY0RjJmVW9MVitTc2pLQkc5eWlCVTJp?=
 =?utf-8?B?L2F6WGFFZ08yVGlTdlhrQlkzWStXOGVaUFp5cDRYbTRtcGdtUEFVNzU4d2l2?=
 =?utf-8?B?OGg0bVEzeGFrV0lPdVA1S1ZuazBEZDcvN2FDbWpKNUxTdVB1OUFVZVNHQ2Q0?=
 =?utf-8?Q?tq7PAXX4cNhA23GaKX+nr/mmsxaViOvzTs9ArPSgg3ak?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51b7585-9d71-4eb2-e765-08dbce28c7a4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 09:17:54.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaxDOgSfbfR4QZkv12XyxSaz3qeuauxj7B9in3vBUqqEJ5u071ZTCjcEVRXLz0pllJEIeg7Zhw8haRGotBleLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9227
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 14.10.23 г. 23:40 ч., Kirill A. Shutemov wrote:
> Michael reported soft lockups on a system that has unaccepted memory.
> This occurs when a user attempts to allocate and accept memory on
> multiple CPUs simultaneously.
> 
> The root cause of the issue is that memory acceptance is serialized with
> a spinlock, allowing only one CPU to accept memory at a time. The other
> CPUs spin and wait for their turn, leading to starvation and soft lockup
> reports.
> 
> To address this, the code has been modified to release the spinlock
> while accepting memory. This allows for parallel memory acceptance on
> multiple CPUs.
> 
> A newly introduced "accepting_list" keeps track of which memory is
> currently being accepted. This is necessary to prevent parallel
> acceptance of the same memory block. If a collision occurs, the lock is
> released and the process is retried.
> 
> Such collisions should rarely occur. The main path for memory acceptance
> is the page allocator, which accepts memory in MAX_ORDER chunks. As long
> as MAX_ORDER is equal to or larger than the unit_size, collisions will
> never occur because the caller fully owns the memory block being
> accepted.
> 
> Aside from the page allocator, only memblock and deferered_free_range()
> accept memory, but this only happens during boot.
> 
> The code has been tested with unit_size == 128MiB to trigger collisions
> and validate the retry codepath.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Michael Roth <michael.roth@amd.com
> Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
> Cc: <stable@kernel.org>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
