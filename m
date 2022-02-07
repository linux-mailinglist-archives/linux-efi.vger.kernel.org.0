Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791524AC60C
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiBGQhG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 11:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389593AbiBGQXn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 11:23:43 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CBCC0401CE;
        Mon,  7 Feb 2022 08:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8jMgFVifa0kLnOawb32rIA7mlg40HVuhdK4eIsBDfoheWGAwpiSIWxzFw3433Cok0AgLPabvLZvUXss5VeYUyBRmFQRPZyMC+ZdruCcOtase6q8sDIcJnmz8YKXYSDtdWQ6ECcqoXvOjwUn4Pq0iq0LiRpFBplb1We3SfjU6+SWsuFKYpUJUX1rSZyawgTSh5lo2r2a+mmYjlVIwEoC9RqLsogxFiFZJnlhJWDBoMEZnnuKstergW0pRWft10w7PSLFd6nfKM3eTRYNvfyCRcUrkdI+bBDXf+4YppzGzaUKiVDXaPxpFkcP0OvrKL0HcYypu6p1crw3pD0uFQpVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Bk4b4SeaNbBpY5MVEtVCTcNBaCeCf1RZEApjr7YkY=;
 b=HUwKtG5l4SYLCgIc3W7DD3BQLpmVpN9dm1n3r435j+M7fPJjv3TiqnAMYm8AeXbbgBArddQNh8amuhoJJC8BLY6WwlmNyQcBvBBCX2zbDST4MbHRzduB1lyNSnow/NGCeNcfqNpXi7yQqyBEUhSPe/l85pwy0/0ejAXAsKpDXH/Sijd45AN7qaOdHNiX0W10rXzOhHdoIYx67cK55rh7JO3XdNoHmEvDaBA9NWucqs294uFuhnsVgIlxsjD3Pe+9lHzz/lSk8a2ZU3nH9Q2YHYbeJeFY3kyagMSTqqEiZrNPznvQSwltvf6/4wN63yiJB3W8nNYPRCrY6oimGfcNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Bk4b4SeaNbBpY5MVEtVCTcNBaCeCf1RZEApjr7YkY=;
 b=2eYr1ArAqB0DbzigafK8JafoV8q2DlEKGWVdtGmMYEMSc7ZBmyWwFJjS+AyHe2ZVftyAJ9N2l688sCDtObMutdiU5aqFMcZtxtSvV4lK3M2bkFlcIf1ULBgyQx5dbSV9RezVhO+FGcQn6u+wTIKVRsXEFwU/1bbYPvZbAWRJsNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BN7PR12MB2787.namprd12.prod.outlook.com (2603:10b6:408:2b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 16:23:40 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 16:23:40 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
To:     Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com> <YgDduR0mrptX5arB@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <1cb4fdf5-7c1e-6c8f-1db6-8c976d6437c2@amd.com>
Date:   Mon, 7 Feb 2022 10:23:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YgDduR0mrptX5arB@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:208:23e::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e09c0cd2-67a9-408a-d273-08d9ea56336c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2787:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27870AA734401087FC1C3E0CE52C9@BN7PR12MB2787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0wOM+RLkUbmPQAq6nn80hH8YbRvE6VJ2KLkCw8o3eyF0eWClHeJC94BbqH5emgNLnE/1vFShfdlP23JZtf9kHILNAXuoCP1Sqdd55uzDD0OY7Zcet9jv00AKRTr/Qr+8XO7Q1CaxGRjQh3mAXnNXB4FAsbS6Pc5DAFF48fYCuEmOxxsU55jGh+W0Iah4k2KI0zCR8SQcMTA/wEI5u0GNCVMKMXfxUSE2dK65oKBQsVbohhihzFTuf34aY3SChUlJUzuMMx3Y12ILkiHboAZHOnLdulVU7RFpJjvEEl39ZAn6n6b0555HPWYCzE5UgnUTDUHiWmghxE5VbKkX2HsCubgu/RDakfWtaYfHmWevqfE0pnVF60EDODGa+285T7Dn3U8ZoYyt+JPpZi/B4eJm+wtMJZ+J/CMpmpgxTA2wsyQDaIZ33puUw2bEuihus3bIhUe1rfN0uBErXlbyU0f9hGMIXJfmjBF2jfq0Jwgr7O4yoxoWH5my+wjdPKMUYPEIVIM1a6TTxQbrIRcp/wmvEp7xyQbnJx/73VdCBRobCYHIufAl361Krx6D4eURBsZ8GJftDEIPrWb9lRjAEQ8XnF1YvmmGP9bEkQX5p9z+sIs51afcB5RG/uJGVvakiJdYqxX0mdVZOVVXvy9hL8B2XZXCMbQLCIi4PWIiDPi2Rmhsk3TIyO0RKZdisM+NkLuDwDXyuBVoxnTOiCiE6uh0gvjdgCYhMRwWXswQG+gHxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(36756003)(26005)(316002)(6506007)(66556008)(6486002)(53546011)(6666004)(54906003)(31696002)(6916009)(86362001)(558084003)(2906002)(508600001)(66476007)(66946007)(4326008)(8936002)(2616005)(6512007)(8676002)(31686004)(38100700002)(44832011)(5660300002)(7406005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUhVMmNUcFpWV0YyVTJsdjVoSCtSaE42ZWFIVzd1bHNYejF4Z2xqQUgydmdh?=
 =?utf-8?B?bU9mN3NKU01vN3d1SFBDalFnaU5HL2E4dnZhNmc0NWNsaHlhdjFHQklrZStv?=
 =?utf-8?B?dE5IR3lBanFwMVFKL1o0ZDFBbldPQ2c0cUFOUGZIQVZjdGZjRCtJbWdSK0Nn?=
 =?utf-8?B?R00zZGdjU3d4RnB4enFZSFYrd2xRcGl0TkpqSE4yOVZxM0V4MElnOGRUcldF?=
 =?utf-8?B?S1FrVDdCN252QmJQTElld3JXUVFrUlpjK2swRktTdi9wRUoyc2wrRWtXTkpD?=
 =?utf-8?B?UzlDNTU3U0ZhRzBxZlR2YjhvYVFHUjhHQjVKeWdYb1dybTdLYWNUL2JJUEtx?=
 =?utf-8?B?ZGgwMnRRTlg2L1d2ZXZUQ1hmS3V0Rm9aR2V2STNkTGpyWFpLbEppclg1bG1E?=
 =?utf-8?B?R2xXNEtzS2xGYVkwMGJZdWJ2bm1qVGZBRk9EOG5DY2FDTU4yckZJT0RQWVNJ?=
 =?utf-8?B?ajh5WWtFSXJVZnZmMlhPQW9qMUVmd2VnRmE2YnNHY2I4SjNMbmFERFQzTERz?=
 =?utf-8?B?NzZqc1ZFSTE0QlNNOVFHSWNRbVhIV2h1YWhwL011YzhkTURMalJtR1FLbnJM?=
 =?utf-8?B?b0NTRmFWNjNtVDFqN2MwNnNZK2dPWnlERTVidmxiU2dpRWNiMFlWeXVXUGFF?=
 =?utf-8?B?aHR4VklmMklkL0Z3SzBxTjVDWitieWdrMmNjV3RnWlo0dlFzc1RuaUt5M3hZ?=
 =?utf-8?B?dzVEQTIzUGJ6THNlSWRKdHlHeUtOL25nNzQ2K0loQ1Q0b2tjZ1djaWlXSUdD?=
 =?utf-8?B?SmlCN2YySGhaejR3VjM5cUZ2YnpHVVYxcXNwOEI5eFhneEZOOENNb3kwa0dM?=
 =?utf-8?B?NThXV3drT09XZzZvTGFiVGduck5DSk9MV2JQdnNjZktrOHBtaHc3Y2Nodity?=
 =?utf-8?B?azlYRys0eitTalY1SmlFMWtBT3dMaktFZGlLWkVEYmlaUnNxWGkzVnZ0TUJN?=
 =?utf-8?B?WXZkRWw0a2FLWW54ZDNMQ0VNaGJhMC9tbXBEWklVUHFxbHZCVEUySHhFMjZH?=
 =?utf-8?B?eVpOYnBGamhHU2ZWZGhDRHYzME90ZE00alhxcWRVMlJsMmhhUkgwUWljc2hp?=
 =?utf-8?B?Z3Y1NlgxYnVjQ0RrQWg3ZW1QdnpzT09qZ3cxaWZTSTdoY0Z6Zjc3NFhzODlm?=
 =?utf-8?B?ejhMaWtrbXN5Q3dyNTJVSXJOYUNKa0cxS0tlZGFGY2VubVlrekFtRGpZc1NX?=
 =?utf-8?B?TDR3YitUZ3hMamQweEIzQlFoWExpa2RnNnh4bUcrYlUvL3g1ZXNhRlBtYVZ6?=
 =?utf-8?B?WjR2Ym92c0s4T2dOS1pLMEhiRGo1NytDQVA5SUhEMVUrVFRKdFlWT0RnRDE1?=
 =?utf-8?B?ZVkzQ3Y0MHN0TWdvUnpVZUN0cm1SSXI2SUNGbjR6Ym5QUnVKcTFzSWRmZUlz?=
 =?utf-8?B?SEZ6enI3WGZuT3h2YVY0SHNaMi92c0hjeVEwS2MzMlptaUsyNWVEU3NPdC81?=
 =?utf-8?B?ZW9iZjRDclRJY2xPWEFncTlmdklPT0RDT1hBMmN3eGlNTHEveU1MRFdLVzN2?=
 =?utf-8?B?N29jWDAvQk5SYys4WWh1VWZ0K0pMS2ZTV0wrMVJoTTJFejlHS0kvNGU3UDNP?=
 =?utf-8?B?YnhnODVoTko2SU9UeTFxNmhtdVJYdmxUeHNLRm5CSXVxcFMxdkJQRksxeEx6?=
 =?utf-8?B?cXNMNWtBVXpwa0x4V3FYZHhGK2JrZWE5dGJtMk9LM0xVd0RBWXg2R08zcXND?=
 =?utf-8?B?TmNEV3FZSjdsNGpOU0dVSDdFa2J2RXlQZmpqN1NLNVJpcHJjeldHQXYwTE1E?=
 =?utf-8?B?UlR1eW9NQkh4NGVrTGtreW9LZ2RVcC9OU3RRaFMySXZvYmE2bGp6SENUanRB?=
 =?utf-8?B?K0l1dVAwSFArUUU0cFhCbHZ0czdLdXZPaEZuZGUvdkVUK2g2dVQ0TndYQVpz?=
 =?utf-8?B?dU1HTFkwRmZ6c2k0bmNrM25zYWtrdkluRVZBWUtMbksvbFM2U0xhVDNjV1Ez?=
 =?utf-8?B?VDhBZFpxTUVZanJab05JbWYxK0dyWUFHNUROUnp3anhrcWxjMTB5Rm9HcXdz?=
 =?utf-8?B?bEF1K0NhSHBwVzFtNDdBRzdhcXlndlNjcVB4eFgwWmJZdTMwdWFCaDlRRDlm?=
 =?utf-8?B?aSs1bHdDK1NuSEo2RkY2STVjQTh3VVJxVnVhd2hsSi9tZzVCcUZKdjdzRHQv?=
 =?utf-8?B?RmptMUJZN2E3UmJPN2EwRWhIa0thRXU5bks0dU5CWk52UVVFd0QwN1M3WjYz?=
 =?utf-8?Q?RLI1QwT9kozEQLlog0r5kH4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09c0cd2-67a9-408a-d273-08d9ea56336c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:23:40.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re2iV6TOled7fKAwlrp2b0qdb1MKkAHe0/XoE2yvg2NaahLKOUQKlXP7szs+yttksSjRwUGZtoPDoPU2LahMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/7/22 2:52 AM, Borislav Petkov wrote:
> Those are allocated on stack, why are you clearing them?

Yep, no need to explicitly clear it. I'll take it out in next rev.

thanks
