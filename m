Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212263A6694
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhFNMbj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 08:31:39 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:19809
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233712AbhFNMbh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 08:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6OoLP0oz1+mjzgjG1zGuklQ4RlKiikGqZSm2vN8jgIa6MmkxljyQjkOj60rTELW/Ms7PwFau/6breAqTw/yOKeyU7/MXvUpqVKWxaB4rVy80hxNF9HSQ5G+eU8K+X4f7lCxfoiYV/qlHD/Vc42s2LwzhYEEkuskZUlfscXpy+Km9Z/Fg25+3vqUF8Wk7VuwiNxh6bt+VHZXnVmEtz2fHg9CXiJ9/QA3iQxmIO0Rp8y+Qxlw26uDSJycxAKaJErElHr28mullQNFJs2fBAhW/eI41HCdy/OvaoVdLHuSEckwkDndkLFpOkmS9vT908vIGtbvuN81hlFq5h2RaGlEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ITKVtAVJat7w9d/EUTqv8QQ3YIPJEsPRc29+Q/on4w=;
 b=NXQNqqMC1qYwe48MSZW7K6AxlxvStajCGA8DJ+xjuXp8JtR08mbY2TZkqLOsYMlSKPi6kSFY/YIiEajPLg5UOF5MsgG8FnXzYj2J1cSCrBAxoWqVCKEvFtvVK33hHRY5Dwhhz+2hl8bCWh51LdIzXJux+VxVl4R8PkpuQCk8EU0zVPSHbIelFtcI7224Ds7pOjsAMt01hBpaI/qSsuamea7MTakdRvbbaW2fB/4Sw7q0wAGMkmid0/TTnhBjMaVdychy6NHEnBvVMt7fXDEkN72KwtcPia479AMdnRDPCs7+f8z4dKjJ4yR7Q3xoHeGwknqpNaUPD3JByu7hP7YEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ITKVtAVJat7w9d/EUTqv8QQ3YIPJEsPRc29+Q/on4w=;
 b=KQIov5/yACEDxQWnpn2Gjltybt9m82bScGSYRx0S2+SBU4YjTdj7lOA8R4+Vwuk6sX7L2xmqs0DWQICJRVioRfXToPAh2YGw2h4Kuo+TdzUUvAdsbtrzJtvrPXEeSyAJZK8yxhY4R1IteUapz466LeO39lYnY6cRD2+gee9z9Lo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3130.namprd12.prod.outlook.com (2603:10b6:5:11b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Mon, 14 Jun 2021 12:29:31 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 12:29:31 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 10/22] x86/sev: Register GHCB memory when
 SEV-SNP is active
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-11-brijesh.singh@amd.com> <YMGn3/9t5QhS+1rp@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <b692eb08-9af2-37e0-37b3-7d42f2e46b08@amd.com>
Date:   Mon, 14 Jun 2021 07:29:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMGn3/9t5QhS+1rp@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN7PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:806:121::13) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0068.namprd04.prod.outlook.com (2603:10b6:806:121::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 12:29:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8647e28-2924-432a-b33c-08d92f300f78
X-MS-TrafficTypeDiagnostic: DM6PR12MB3130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3130C51EEF7DCB632F707F53E5319@DM6PR12MB3130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roCNC1wCHfx8m3pK6Rr/ZIyii68tCj+VZhUrmfmNQ6Q0aDeAU0uX4Xn0H7W4MgXqgQl2EOYoQDx3eeKW9hfuMAR0D+t+Fz6ykXLUGgZCCBQ7hfLkKkDFwHIoWlEwPLdoMOHgtSOPVieNyMp7X9JMH3xj9WMoBAHA4KqR2u4jY1jDGTxYA45dM1Sj80b+ehtYmf3ek8IlyQohTtAtAPa7UoKg9HktIXt9VYSZh4HmAy7ojuSepp7HILlKJOpRUR40qaU6uBH8KfS3t5iKan62DCgrx6DCMSBkaNHoMyPX0OkZ0Bpq38GusfvenV4iE/JyZEQeMsZq5DeJsLepNHDJhOqMmXZGXiiNx9aNJewBl+Vcp+T1P75AYSc3EhSxf1rmQ/6lty4BgK5q+EO4bA0Ei8KRBqXEV5B6lSCVxml0+z+fCVa8TYIaSTQ4OixiSH+NpDF96TT/srI7n9Y53IXt55FXm+WhVzYKIe6quaJ0agzZ9GN20Wue/QdMbcYRlpvXNsKUKvtugUXmj7e/ovZqG58RbHmKdOrPlqV5x1hbsWrRwnaEii/34IUZGj15anhPzBYWYVaMfdOT5tSUWRM5xSsyHeGCG0yJq02ZDryaQngHfmz8OoBird1LDcfhEC5R8VSW7hB7EVc4N6PZfjIkKlraK+NAYuLFalBMpLjR6RAVu6sGCEUhdGTFfAznM08CEI0LavhUqyaqOJzdeDq4OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(54906003)(44832011)(478600001)(6512007)(53546011)(6486002)(2616005)(6506007)(26005)(956004)(66556008)(66476007)(66946007)(31686004)(186003)(16526019)(52116002)(36756003)(31696002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(316002)(2906002)(7416002)(8676002)(4326008)(6916009)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qms4b3dtSWRyQzBhVTJxelcxRXowaE9kMlB4eUE1SitHLzd4enhaR3h4Ym5D?=
 =?utf-8?B?KzQxVHFXM2cxWTJwZ0VPb0UxQytuZkdyTWhkOWRMaXFXNGEwYVIvNjUyT3M5?=
 =?utf-8?B?bXh1WUhKQXdUSmJkeitLTmtFL2FRMHlOWEdVMlZuUmIxVmd6d0NmQUhsbjN4?=
 =?utf-8?B?MjNoM3dQVWM4ek9YK0hHM0c3Y1JMVzFPNmFPcnJIellDUTZ5SWxUZndUb29X?=
 =?utf-8?B?R2ZzY2x1QW81ZnhaR2FBcjdNL1FGMWFSQWw2Z3J3MC9GUEIyUHRRY2lTNzNi?=
 =?utf-8?B?OUJ2cGx2RlVoUnpxUkRFRjMrTlgxQk1vMzhvQStBZXVMRXcrNXZnRVdlL1dn?=
 =?utf-8?B?anpVa3U4dWx2RWhPSFR0d0VWRTRBM0xaSmNjMlJPdW9UUVdtcjJHeG1RKzhZ?=
 =?utf-8?B?R2FzVVZmQ09NTjlwQ2lUNUk4U2FEeE00cjhpcE5KQVNtZ2c5U2xvNWZ2Q0pW?=
 =?utf-8?B?NEVvbUpzbkhtYlZybzE5bEpqdlE1bGxHVUx6b2J4RDVHbS9nUTZiY3l6dXRs?=
 =?utf-8?B?eFV5ejVvUTl1UjF0NDlZY05WU2ZFUnhQMENIY25OTFI2ZFJualVWdS9pc3l2?=
 =?utf-8?B?R01WcE1Rd3NGdlpEUVdwbkttd1E5QWovQmdlbkNYbTc3dW5QcWcrRVlpcTVC?=
 =?utf-8?B?eWVQazlRSVNxcWdxVkVyUWxRWGtWaUt1aTFlbCt6NFBPV2pKU3psZ29LSlU4?=
 =?utf-8?B?aXQvYTFrcTYyU1J5anhzcEdZT0VMN2tGUmNIOXc5alFyWkJMcDBpalVTMUpE?=
 =?utf-8?B?cm5NdzBFNGlvY2Y4TXlqOXBCZVliNUg2dkNuZk5mbFZhSXhXbHA5Q0wxK3dV?=
 =?utf-8?B?clcyaXVQWFZ5VUVtMjBXSERiektIMGVUVmEyUm03aGlhSFFqZko4cURmOVZY?=
 =?utf-8?B?VVBQRlFpanR3VHpaUmx1aGw4QzNQZFNQaTZHOWhVY1ROTHNJamFjZFYxOE92?=
 =?utf-8?B?OHk1cUhDU053VnhYZElKcTY0T2o2YytpQTJnRlBFejZCWFg5THlRcVpqYWFL?=
 =?utf-8?B?NVZYTTFPVnhIZU5rR2IyWTA1ZlZ5bXdlNVMrSmJvOFAvUGNaNDRNZ3FuUk0w?=
 =?utf-8?B?emFxWDFieHAwdE92NTZPdzVPRytGMVc2M2xZeEpGUDNZeGtlQ0RycS9nRFlt?=
 =?utf-8?B?S25hNWpJdnZRQ0c1dTVscUJhRTVGazFSTkNIVDlRVmNneWtML3NQSnJjSjdM?=
 =?utf-8?B?ZHFUSnZVK2x0eUtHTENWQkZPT1pINnp6UWpiZnIwS0lYV1dKWEZNN1UyYUJv?=
 =?utf-8?B?UFppRk1XUXNvcTQ3Z1NyS0VEbW54UlVDYzYxNTNjSUR1TWhLQmZLd01rRjhi?=
 =?utf-8?B?a0MzdEdIMlozSXFRUlJvcXZvcVIydTlrN29XeC8xb2RESGFmUHE1dkJuSXBr?=
 =?utf-8?B?T1RXUjhkblNlUjJqbnI2WnNqQkRNNTYyT1JvaUZSN25KelYva0p5aTF2VFV5?=
 =?utf-8?B?WXQ2SFl2NzFXbVhHb0hPa3haU25hQnBLQ3hIOG1Camd5YWZtbE9GV2Y2aEYy?=
 =?utf-8?B?TDRjUCs1VlZvbTNURThwTzNQc2tobkJlSmoxckVFU0tkb2hHV3JXOHlyTXp2?=
 =?utf-8?B?dVdWdUxESUVhTUZ0b0JZTzkyaXJ1dUVzR3M1SDhJMEg2ZXJxRElWam4vSE51?=
 =?utf-8?B?c0IvWmZXNVM5OU5aQjBSVU10RmlMUUVaTVhJaklHSWMyb2Y1Y0Jsb2ZycWJG?=
 =?utf-8?B?TXBzdHY3UmxkaTAxejB1NVFJRmtzK0orQm1rRWVDOVhpeTVaZTN1WnB2NW5S?=
 =?utf-8?Q?WD30woVdLl3iurdV25+l03Oj9kraFZjW2Abdm6g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8647e28-2924-432a-b33c-08d92f300f78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 12:29:31.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5DnZytbSu4SgsM+p3rLY7W8TM9+lqb7nuTqf1fhw9kuLjqfpoSMUooKWM3h3jrwnyB6IwhA7KQkKZcKM33MBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3130
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/10/21 12:49 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:04AM -0500, Brijesh Singh wrote:
>> +++ b/arch/x86/kernel/sev-internal.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Forward declarations for sev-shared.c
>> + *
>> + * Author: Brijesh Singh <brijesh.singh@amd.com>
>> + */
>> +
>> +#ifndef _ARCH_X86_KERNEL_SEV_INTERNAL_H
> 	__X86_SEV_INTERNAL_H__

Noted. Thanks

- Brijesh

