Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E63E5ADD
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhHJNR1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 09:17:27 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:48498
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230410AbhHJNR0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 09:17:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRTX7agmi1puKDWNk47fqD7rniTapGPG3IuGLM0hJdvHA9IxC2ESUGF66XqF5+VaS2PmwW5Kykrjksb5NTNUm3I7ZPEf9yRge+aV+R4s8MWLj51+OdpvDyPaLnSH0VQtXmEEaxRapFIpRx/pDBqGz8/8mGFYLcptSpiF2/W7D8tVpV5+XH5waF2bKWds13exDFcwa7Dm5fyn9wq5Vpg/UXBUKKTvcRvKRaN6dMRSr6sYn9Gb1OmY6OyAFzqq6nyLIoBXFBF43P2xkrv+SUXYxZeL6s5CUMUrv5DQ6arA/ziSKwK+La5ZYUQwhKz72ODyJT0sFFrEJVbb2qNh2LfHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoObnJYWuhIz2Rtg+nPQ8Rt1X+mlIVTD5zmtno4fmbg=;
 b=hhHtfpzYcST0EurjyJ+hWZrP+u0fJnnO62ZlC/gUVNPh3Cx5V0OpoEl7qpGTNkKMQbjag65J6CoEpWafT9WJpuYrwHMwO/2nqJrLCQJFXMwfoeDQ1wFOiSpjvmsHBQmpeHT9IBqEny+rCU46lUDruKn+BA+S6HWeTipCpGfnEEOTvDf8SRy6E7034Z3RyNsTFuO0aLNGa5ZwLFFleuhhsgpvhlVwGVfowa1Rzl5XhyZM2eEvVE/0yJbfNJiPGUC2hwHgd1UDkcYa9VAE4YEi5DU4MbOnG+KFv0fpzhCBOXUoof9/ryydLdrrIYbCJx+OlNHYQBe8MvHgaaI46CNEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoObnJYWuhIz2Rtg+nPQ8Rt1X+mlIVTD5zmtno4fmbg=;
 b=tylB0Qs4zCafiDfStmK9rnu1bR5ZryXJ+dmIgOfEKAbsOEqsB5krwyPWnAMnhLUWXxHAEDV5RUCIylJ4CocvjnhoQ07scdZi7yaM9GSayTumxzss8nini4VkZo1lEWLbs4H+DiNM+mRvWkvJHE81DLGqhcH2ABZhJ7chz+ZPAOo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 13:17:02 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 13:17:02 +0000
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 02/36] x86/sev: Save the negotiated GHCB
 version
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-3-brijesh.singh@amd.com> <YRJOkQe0W9/HyjjQ@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c8bc1706-e2af-d6df-9225-ca70412cf6db@amd.com>
Date:   Tue, 10 Aug 2021 08:17:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRJOkQe0W9/HyjjQ@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:806:120::24) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0049.namprd04.prod.outlook.com (2603:10b6:806:120::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 13:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a94642d2-b63f-486b-9229-08d95c01241f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384F22F707454CF831A9C20E5F79@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ojChOpNVZ3P+GzHOhNU2ag5bGiM+z3lKP7KiF4rt6NEgBXKY367yobzMISfKBxsX0Yu91q8MI+Mga+OTB8O+XG0tChI6HFonEo9ENMjuhCs2WeDzUnHeO16w+6GfOEht8buo0HSnpuo5rYLnmxcDGSxUVghi0HRpU/UibQwvlyr4Onrprqmrky7pYkR+F6ISZODLZgD2+R29M5NXne7i2SXTJ1JWdyDcGhWTlaP3qIPH0E3QLX1pslFE+RLA9rIf41WTz8PORJdG/9x/jpmYYwFnfUhGwAnxkUychobvn1ycTwLCd5ZcAJDJASnNUinefcYCZ2MW6fsQ44GiAsc/slFy+k9mA9UQR0c+zWFBIdAIkyboNAQMV7N9fQJYbpx7EJoSzySv9NZR972N34oDzxd1/u+3piJFqnVc/CRvutWmTLIVg+PMRKTEyR3vRnBvmkuRfjKvp0aNHi0uKawvwZpV7lYkrjfhWdYW3Lc/Rurm5yRJgWIzGJItmxAiSaGSC/UA084UwsD219iGBgv+EXHPv9s7dQVjwcocjQBJTOoopVI+dlSGSB+/nUFxeELDIk6ukb5Rpuw111CZ2vYL8dYM6/S1qjPbqZzBBlTF+0NjCQV/q+PW7EXQ755PXVUPXkMsIBZFkFJ+op67dtAwEWvY8nDsvHpNC+i5PlwKep1KCRuIYPs+Q6WYrPncgk5YQvXycmy2Fp7L/2jbwiRMAHd2hNI0DqRgcukwDsacZn9PtLxy8w+6J1mgeJ2smsqrEM7hlyxN6l7ZB8isMHasg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(2616005)(26005)(38350700002)(38100700002)(186003)(956004)(4326008)(86362001)(6486002)(44832011)(31696002)(31686004)(53546011)(66556008)(5660300002)(83380400001)(52116002)(66476007)(316002)(66946007)(54906003)(16576012)(8676002)(7416002)(36756003)(8936002)(478600001)(6916009)(7406005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdscXd6bERmZ1dMNWpuK2NlNkc0MVNRMFNnVVNFREV3NEE1M3FTbmtubjgx?=
 =?utf-8?B?UXQyVTJlc1ArNXJoc3lYRkNTZWxjek5jcG9uSVdwT1MvNitycnpKVWowdG5U?=
 =?utf-8?B?cy9ENHk1aXp6NEFTWU8wMUNERXlRY0RLdnVleDVNM25KOFlzanVEZkVJc0dl?=
 =?utf-8?B?bmtHQ2c1bXpYb3hXK0JsZXNObk9IcFdmQm9aSnNwcFNDRm9zRytKNlUzVWJy?=
 =?utf-8?B?M3J2ekEvZ0dvMktjUXNScjZ3bWQyYVJYajRpUllNQ21nTm92MkxaN0xZV1pE?=
 =?utf-8?B?Q3N3UnZHRklUWTl4cGl2dGh1M0FNaGVUK1VKSThFVGZOYkdBejBod0JUNGI2?=
 =?utf-8?B?VkpvTzFvN3VJanl1VjI4eGpDNUo1UFFaTFZOeVR5SHFoejVtZzNnVjRXQVkz?=
 =?utf-8?B?RG1rYm53aHcxTkFuQit0MzA0eEdkaHBqR1JkVG9vdWpJRnU2QVZaUFRUZzJY?=
 =?utf-8?B?cGVtdnRUcWtJMkhKcFNkVmZyRVh0Z1JpK1RidkQ2OWVocGRzNVNvVjNTTWl3?=
 =?utf-8?B?ZXo0dEQxWFM1ZzNuMEVyOU1JSExBMTFtZkNzSnpDMVpJbFlvSmxaTGVhcUEy?=
 =?utf-8?B?MVVZWnB0RjByd1FucjZzVFNuK0xVaVJib25zWHVNVjVCVHo0eEJPbnpzRlZt?=
 =?utf-8?B?a1dJZm1zYStWbm1VanFldDF5cFRoRVNoNks2TGJPNDdMdVZIWGNnQVQyNFVB?=
 =?utf-8?B?QStuUUhDcHlIQkl5QnoyWWpnZ3FtMmpoaXBjZnRXb080T0lOWjJvMjBBMVdT?=
 =?utf-8?B?d2JkNGd3c2wxWDM5SzZnWUpTSW9JaVdTUkVLelBkaVAwbzZBanpteWw5aVVp?=
 =?utf-8?B?dkloQzl2QStTeUV1d3hQQ3ZIUEZ6RnErbTA2TjJQVktWZUxoMnp0Szl3a0tI?=
 =?utf-8?B?WUFiSm5KTEloNUlSYTlpT2Z5RlhybFJ6dGljcTVUR2RsNms4andNR0JxMjlK?=
 =?utf-8?B?V09yb1RIQTJXK2o0aUxITWxrdXhEaW1kZjR6NXRsWG5YazRnaC9pdFZxd3p6?=
 =?utf-8?B?NG91VjJGTktIOXRqVjVBaTlNbUxSNEJXM3lIR3RINDZxSWw3cnZIWmt5NHN3?=
 =?utf-8?B?SEwyRTFiNHJtZVYxNERCRGorZlp0ZjVTU21wc2l0V0VJc0ZOTlFhS2tyTGtp?=
 =?utf-8?B?bHJBcUc1dWlMbldsZEJRTGFZZWRBYVZIY0o4NzQwVUh5UDdXMFV3eVVDTzJI?=
 =?utf-8?B?TXNiZDN1OEQ5R1pqNEUrM0xWcnl0SC9qY0c5bW50WXptK3RLMFROWkN0cy9k?=
 =?utf-8?B?RVNnUUNqNFhTTm8zR0hFRWJYaFhrZnpkUEpSekdwbVBmbU80cWJUZ0NSbVZ4?=
 =?utf-8?B?WHA4dFg0ZUg2dXFFWWdNYk5WRUQxdTlTWVh3Q1A2eTIyd2cxY3Z5WHNLUjR6?=
 =?utf-8?B?aFF2aVQ2bkZTWUNLa25icVhxV3JPRE9KdlFiK0ZMTnpaZTJnZkR5ZDBvTUxs?=
 =?utf-8?B?UmRzRmtlSGNOOVZUZkZhNEdxTktIdndCanM0Ni9ic0pSaFRDZHNVS2p0NXl5?=
 =?utf-8?B?UlUwbW40RDJtc2JPekh4cVNYSXVYTWU3UTIvendiSndhYWlEbnlCZlJQQnVj?=
 =?utf-8?B?dGg4OXpySEo1VnVsM0lWMjNxYWZVbXdzbDQyNGJLZi90ODk1b2wrRTY5cG41?=
 =?utf-8?B?ZjJzM3luMjNiaDFZUytmMU1rS3hua2tVZFR1U1dqQTJTTWlRaTBQREdsRmhH?=
 =?utf-8?B?eEZGVDVYdWZEQVFNYi9iL0lxNWF5ZnFZKzF6YVpHOGJENlpIQ1pkWHBLcUgw?=
 =?utf-8?Q?S7p9fU75bzrK96SRNeRVYI9eBLIIJ1WT5+Sna5l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94642d2-b63f-486b-9229-08d95c01241f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 13:17:02.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZB6vKzmwOjZwya95evS4wCsdN4z/WRN/pNc/cFjL0Nl6rP7q8CZuPmixmp/89zGefW9tkUc/u/SaBt8PrAR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/10/21 5:01 AM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:32PM -0500, Brijesh Singh wrote:
>> The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
>> GHCB protocol version before establishing the GHCB. Cache the negotiated
>> GHCB version so that it can be used later.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/include/asm/sev.h   |  2 +-
>>   arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
>>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> Also, while looking at this, all those defines in sev-common.h were
> bothering me for a while now because they're an unreadable mess because
> I have to go look at the GHCB spec, decode the corresponding MSR
> protocol request and then go and piece together each request value by
> verifying the masks...
> 
> So I did the below which is, IMO, a lot more readable as you can follow
> it directly with the spec opened in parallel.
> 
> Thus, if you don't have a better idea, I'd ask you to please add this to
> your set and continue defining the new MSR protocol requests this way so
> that it can be readable.
> 

thanks Boris, I will include this in my series and rework the remaining 
patches to align with it.

-brijesh
