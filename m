Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D193F51AE
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhHWUHO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 16:07:14 -0400
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:11648
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231377AbhHWUHO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 16:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neisTQDUnM1zw0DNcLwyDhBSlLofkrFqjhRGWMCCYKr4qPGHLcXahEV75ba+zdFMh3sWE9icroRnFODzmR4VoYQHBbPuCuYRnkBZVNBdDJPC5fgiRmvEhReXcgVKRzI75P8ndIFtBUJICIGJldJQEWMhWaZ1bKL0hPJkjM6OSQd3tziNysnqf5nHz9I417whZZChPmWSHH5vhOHSWMEWA7dGxoHqIK7bnwrxbd2V38YQK/y86Yq91wJcBwakg6ZyMRCNif8vS4sCE2eFeEUh2EPLx2g1B/Jz6GfXier/8WUkZqQ2xVBz7VlP+U+YaU4iy1YIhXK8GGzPLSXta5gRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnSDQfnv5bh2ByFRSCWa0CFTX0sH9AUpbUVGd+gB0/c=;
 b=WNO3oUbfBXuvFRn9C8ApYh8c3S2nDTrOxQ8N00c3x3jKgiHQtMZpMrXwPC02PvsD50Hk2qyn3J9Vb6J+0vCQI7QHNb77+tbzLmSYcnnHtoAJbUSvG+rw4a/Yf1qLDDk11Tc/v2w4cj7YZjBrkVrB1EfHjk089afCRCnzpe9gOhxZGhDVH49/Dtrj5HFh60N0mMzcUZ00YASQv3atvJAsyNjJXaxm3aPLsHkaMkoHYJiB0sYyE+lEVhYsliMiGQQ00QRA2kzZwYl0MWHXBZKLBWbkCHsK/oAfQnrGwqnTdXh6B0kO4No+N2NGZmP7OBjz0ecouvpGskC49+THZ4vlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnSDQfnv5bh2ByFRSCWa0CFTX0sH9AUpbUVGd+gB0/c=;
 b=0GwdmiWay3rE3eLB2aqFiFqdg4inPYm0eAch36n2PYKudXFK+FYWni3xmrKbqRC4vztWo+ixtYMHiB5QUeqb8iUx0AgiPU4na7qbvBWDAxhEDolDbjkxT0i/21PiVyYqaRc3GCf5Olz2tgGJeamVgwgonJnmUPrWgGeugMiJTt4=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 20:06:28 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 20:06:28 +0000
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
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] x86/sev: Remove do_early_exception() forward declarations
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-14-brijesh.singh@amd.com> <YSPcck0xAohlWHyd@zn.tnic>
 <815a054a-b0a2-e549-8d1c-086540521979@amd.com> <YSP66L7m4J6c5cNL@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <78b1ee40-0f4b-5c65-eab3-3f7452f60de1@amd.com>
Date:   Mon, 23 Aug 2021 15:06:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSP66L7m4J6c5cNL@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0097.namprd12.prod.outlook.com
 (2603:10b6:802:21::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 20:06:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13a2180a-8155-4da2-4652-08d966717e13
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45756D92ADEB591399B73728E5C49@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jp1Wkg0BaFlUHu2Sln2v7ohtsIXJ5Qaex79+MVI3Hmigt32GaRd1CPZ376wwCX396plOt68Jv/YnwWzd13SqOiKR8d2hONBTxDv4HH4udW7iz/RKSEun0NuY/jTfic3ADOxxImMjQJ6TY7LytaSvfng1wXPL6LI4SYai92Rfl8g82cQVKE3IBdzHWWxlbSkhG+Av1Me0K0ZA4h3BoBOjf6IbUX45sMW1mdNFwpxnWjgOB70CQh5MmYdpUn5osJCcKp0O6nNwTbxp5fLyB5KYnx4TGoj9Bduog0NM9xrnJPmMwvg65OJZ9miI5cVoHaOvVpKywJ2otBPojY8Uyn/lbD10xT+e37bC688gZOGOOHax8tdD1JO3Plxg7+ovxR34si5iSmbqIiaIp9KE8QzSk2MCNk3WdrWtsov+XGEsv2U0kyCUzC/u5XZ+9J4WJugkLpzzDluWkvgk4E4x2i1F0VRR5bc83IFEmpQn/+wK6OIKV5ETSSabGVhmr1PQ1gAALonz2ZLa5sPm8IYq4V9cTI2CWu0WVFup9SyriQTZZ4qGvDbzC48ttrPFTnpPp0LWCGj0drwVmE53RiYR8ei8idsFGNWS4bFgXXJdpjYJGHB6ReadX/B9GjpyFHFSr4+Ckpwj/WqL20LoesaS4owwv8hsz+civoFOoOGyMLyPIYU9khd9st72yfDgHHvxRozwg383MAgQwAMiOsjdhLRypPqKeiRdsFYFFJiUyrNaJxt5Gub3wvK3vbkd71Tv3/39gZ7/IvrYSqWYS/SDlgKq1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66556008)(66476007)(66946007)(6916009)(4326008)(31696002)(38350700002)(38100700002)(44832011)(54906003)(508600001)(7416002)(7406005)(36756003)(31686004)(8936002)(86362001)(2906002)(52116002)(53546011)(8676002)(26005)(4744005)(186003)(16576012)(316002)(956004)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9yWVpHb254dURHNnhYdWFmMi9FOHJpR2MzbCt0MWdISFduMnVwWU8wR1Fo?=
 =?utf-8?B?WXBVSy9rYjJ3MXdtd0lNRmhQZXVWZTFqTmtkUUlCRlJmaHRUa0I0bjhnUnEx?=
 =?utf-8?B?Mi8ralQ4R1plc08zOWFRSC8vTXl0Y1hiWUQ5SXQvOU9McTZDeGVvb2hHaDZW?=
 =?utf-8?B?MmhGV2hnUkFpdjl5T1dMenNoQUJ4SW1hZGJKTWlVdUgrVXRiNXpZZ2hUWkRY?=
 =?utf-8?B?N1ZjUW1oRVV5NW9FNlMvZ0JxN0VJNzIvODFEM1lXb3FZSkJYMlVlUERiZWhS?=
 =?utf-8?B?eGhpMjVwcTJlUm84TTI3dm5oTDR6OFBkeHFTOHBwcXVUc2lBd1prWHo4dWpQ?=
 =?utf-8?B?WGZPYmFCcjNJQUpkOUwzcE9KZmVoeTEzV0VwVzlHTnlnVmIwL0ZiWmFicVZk?=
 =?utf-8?B?ZWp6bHVkenMxbDE3RXJtOUdXalNpNk9hU3RwQ1NqeWdEc0hDd2JDODBXVWZq?=
 =?utf-8?B?dEhiczh4RFdVOE5xYW1MTDg5bWc3Z29jVXNacUd5azhBSEMrY1RwQVJnUktL?=
 =?utf-8?B?N3YvQ2dnTWdmTHNXcmYxMnorR2h6TEx3M2ZtN3ptMWVmQXRDNmRFdHZJT0VN?=
 =?utf-8?B?ZkoweFoxWDMzVmRmZlhET3BNTy9XbGZaWndKWjZjWmcvMGdCV25VU2hORzIz?=
 =?utf-8?B?bTV1bFlWVVp4T2tTYlRyaFFMNCt1cldLaHBFZ0JPQy9xVXdqcENnK2lTT2sv?=
 =?utf-8?B?RGZpOTVxM3Z5VXVWM0NXYmh4SVRsN3hqa0FqaFFjSm5tNU9Va3crTmNzeUFz?=
 =?utf-8?B?SUg4ZWU1SmxYWmFEcXdSTXRCbWlrVGR6SmM0UGVIYy90ZnhzczVMcDZMOFgx?=
 =?utf-8?B?cEhxMmUvUnVuQlY2SzRhN2loRHBxNkhCTk5WbmFnNkZ4bXdob2l2b3Rsa1NB?=
 =?utf-8?B?SWxrSmxCbU1Edkx2ZmVKaWF1RldyWXlxd0NnazJzRXFPZ1R1QVp1Tk9CMWVt?=
 =?utf-8?B?T2ZzdEJHdkFWbld4MUZGaDUycUFhcVFQREhKY3dkRjA4YUF5cUVWZHc5S1do?=
 =?utf-8?B?VXdzWGNwdzNQY0d1MkZ2RFc5cktzSTR3QlhkSnlWaXpVMTlvTHVYeDFGVG5l?=
 =?utf-8?B?UksxRVE3NXp4dkVNakEySTRQSUhEUXNXV2ptUlppeFlRc1VxaVdpTkFsQjFV?=
 =?utf-8?B?bVFMNWRLZC85QzZFV2hCZm9QTEZhclBsNlllbnBRVWZTR2Iva0dpazFoQ2lq?=
 =?utf-8?B?OUc4Zjl0bmJ5aHJnWHFYVnpWTUFTWHJ2M0xSTE9ITHRWb0NrYW5tcUpUUkh6?=
 =?utf-8?B?czk3MmpoRS9ObncvellHaS9DekdBemp2L0ltcUdaSWVuYlFKT2tyaCtkM1dJ?=
 =?utf-8?B?REVtM1U4SDVoNE5MK0ZsMU5XU2p3Ni9YdUdoM1pwY0xhbktwenE4cjZnTFpU?=
 =?utf-8?B?SWpDblRWLzZGWDhLRm9jaG5yY296U2t4RXhsbndIdzl6ZElXaTJLT01yYkJQ?=
 =?utf-8?B?WjgvYU5QdHFSalR2MnJsOUpBRUhONm81VnlBYlZTc0FBTVdHZTQyd2ozZDFZ?=
 =?utf-8?B?SFYxc0o2Z2l4UHNJUHdZNHVnSjBZS0FHejJoc1VjZHVmWjl0UndVZElZVE1S?=
 =?utf-8?B?anYwMWdjRGNWaU0vdW90cUJtU0lpTVhLejQwaDE1U1BpSmtJMkhkZzdLVk0v?=
 =?utf-8?B?L1ZqODltcTErWVNNdnJIbnJSTkNPNGtOZkxsSmwxTituNXJxSjFEeEY1VDY0?=
 =?utf-8?B?T3puSGd5dFVQZ2pNdFNSczFxU1NEVEVlaENOc3FqenFmalU3NGJBa28vb2lQ?=
 =?utf-8?Q?/JiCwwaW8zyknv5P8vahkyC3FtIfGp9F1re8NuT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a2180a-8155-4da2-4652-08d966717e13
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 20:06:28.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1BXnD7jD8Ybxn0hHcTB5PKyO1qQrsiCEKeio9edLyZ/TMCAnd/0AuaDL1DNeNmWKiH0RlUk6puS9YkpA2LJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/23/21 2:45 PM, Borislav Petkov wrote:
> On Mon, Aug 23, 2021 at 01:56:06PM -0500, Brijesh Singh wrote:
>> thanks, I will merge this in next version.
> 
> Thx.
> 
> One more thing I stumbled upon while staring at this, see below. Can you
> add it to your set or should I simply apply it now?
> 

I can include it in my series. thanks
