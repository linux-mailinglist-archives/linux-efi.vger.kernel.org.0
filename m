Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544E3F5058
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 20:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhHWS0K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 14:26:10 -0400
Received: from mail-bn1nam07on2042.outbound.protection.outlook.com ([40.107.212.42]:52964
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231402AbhHWS0J (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 14:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cryReSN61XoyHL6VBzaizNXeJ07sji3UMBYTLSmpkyZPpP39PV07usmtd/9q6LcjUJ10bFqydYhJ7nCrR+p7tM947a5SomFuVtrIjROUHtCKqqYzzGctY+Bx8i4ErlFDgzKohKm0Tb1P5PQ1vZJWxkD99JYqzF1RxvsEX1D9zjZSRt1q5VWd6XHWeD7c7W9Rx5e9w2itCjM5CxyroAea+R4ztwNkXkfiA/4n59ACO4IQsQhOdGTDm45kuEUmGws9kIvh3JjX9aAgJ7867FKxEp1HPK/EP/FL82MlMavXHY2C1Xva7+cJUQijrl2dNVgyApMXzM8bJCazMQbcWmJ/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKnkGHZW8513DCY1qGjnWL391s6H4Cl1ty1wKxkJ0TY=;
 b=OWAaWXIpScmAUCKAhroZIWYOAakU8PxGp89HQoLcg2NjPXYTAjhK3U391GLXxJ9Kq6mFEPpvYG6alb1dnGppf+UFvisaPnnYM0UD/PBoWZ39icdG+AGx3G5Lemq00FLJZ8T9br8ooq4QfHLh+YZMRXZL/k2alfef11/eHV7e1URXKUQBvioD3EmXPi8x5WWIM4wXr8vaj61fOtOVn4oXGSecJMfkX0y6C/znR6strw83Qc4oT5dlCkhkR2ObTYFY2wFni/NHDacP2yujMQIocZbwu2xYGcfTwiCu0QpjGL2b719OtW87az0SGkqPhsna1W1NLhQxt/vd2lOBgUnFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKnkGHZW8513DCY1qGjnWL391s6H4Cl1ty1wKxkJ0TY=;
 b=s7JcopJfcKw2CpWqrAknhO1iD3VthVZtQ7AH/JIEiYA+DD5X26qUrcc1XH4WDcGa6LkiiK0bdBBkqTjbpmBPbQhAzxtNVxramzHwNWQwzVSGZy0jp4G/GYkRiwJSqG1gWElFKAxxSh3uhM4vhopKEpsL/Sax016gROgZlN1rTmE=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Mon, 23 Aug
 2021 18:25:19 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:25:19 +0000
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
Subject: Re: [PATCH Part1 v5 07/38] x86/sev: Add support for hypervisor
 feature VMGEXIT
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-8-brijesh.singh@amd.com> <YSNutt/E0bm0kKsl@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <844774cc-4a6f-daa3-89cc-4d2dc6ca22a5@amd.com>
Date:   Mon, 23 Aug 2021 13:25:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSNutt/E0bm0kKsl@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:806:121::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0089.namprd04.prod.outlook.com (2603:10b6:806:121::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:25:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38bc2bd-f53c-44a1-cefe-08d966635c61
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687FC412F23F388BFE1F82BE5C49@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ChlVKvYCYBV8KtFG6qO7Zhsf2y5rvC2ceaHAMedB6TDX1sQ2/7OlBPgllyjdNHpX4qvFUHT64H9edrl1PNAdMmbDT0qWM1YXwMjsdOmezv7vjOJW6EVzQF42tgbKAAtTV8bNasBorCMOQEtZ9ZZs/ND5yuFUAL9KEgai5GHv8I4dqjF4KexzTf99+wgObApHGrXnqEyHKQLBw7uObBz3iVcFtR/FeppbWTAINcIAH9IWQOrULodWeUYO9N252eremyJGxnwTyLF1aRTe60IJpeXPqcFHxb5SLq8dk5NM2TPwBGI2Eqkp4Y0uXX01mKYcifzocIy6Sdtpcw9OsTUpmZOFuhVwvBqnvevjAtUvgS45s/YBjFQXcRyWAoCwAm1kxsA/fY7QNxqWnXb8D0vRkCloMCQmsAwWeUAJDnAyYymWmj2D3yG8IZVX2hmLNcbn0g9zffvkZ5tKlFTm/BI+thLd29gYqDT+l6kCTP1aRV6nXSGZSu8Bb1yAN8AQqNayajNCzOYm9pb+genmFg6P/wvFnQ5PLzUiETtjsV4JIHxlfudInRnZSsRKGPizdeAkEsQQ3r1r+ChSBYtcvtfzm8XFRSvdVfMzlwkKWNLnm+YyojywbH9BYog7Y9217sXsG3hhY1BAmsD7Xh0ON5nEjxjHzhSMSLsBIn5NlXAecf1SrZFvGY7LynapjWaheJHjbueopA9nq35hVh8gBc7RqSu242xm8Ls6El9G2GObSYNML0wS/4T9dUldWOHMXoQVeuo3ryd3rHe5tih/WFBSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(86362001)(36756003)(8676002)(478600001)(6916009)(38350700002)(31696002)(38100700002)(16576012)(31686004)(8936002)(83380400001)(956004)(6486002)(66556008)(66946007)(2616005)(52116002)(66476007)(2906002)(26005)(53546011)(44832011)(186003)(4326008)(5660300002)(54906003)(7416002)(316002)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlN2Y2htdExpUHpWMmJEdmplRWdmUkhKd2MzSi9TaHBKOVlqME91NHVsbnBs?=
 =?utf-8?B?V254YUVMd3J3Wjh0UjBVaDBqc255MDNLNy90a0l6Ni8wc2g4dDZsZ2RpUVBS?=
 =?utf-8?B?c21PMU00VFd2YStDc3JPSXlBT1o1b3B0SktRMSsyZTNtZUF5d1FncTBaWThk?=
 =?utf-8?B?M2ltV1JzNlp0Y0ZGQ2puUlc0dlR1c3dqQXg2dTRpd2s5T2RWVXJKeGRWME1G?=
 =?utf-8?B?azRjMWRPUE9qMjErRWZGUGJrVHAvQ1lKZXlZVXJsU0JXM1VtSmI3WGRCbGNr?=
 =?utf-8?B?dHZhRUZHQXZjR0VSZlYwTU80R0tUVUJjUkVvQTlJUHpmc1l4enNiYzBWWThH?=
 =?utf-8?B?OUFQMllwdVBqd3Nhdlc5VkZOclJVakRKOU8zaXdtczhjZ2hSMVNKYVFrMWNM?=
 =?utf-8?B?Zi82OUd0YnNhSklxd3FNVmlPSGI5bmNhcmk5a29HU3BWWnROaXFoajlwUTQ2?=
 =?utf-8?B?MFNnbXYzeUl6Qml1R1ZoRVpxOGx4NnNQbjlMNTNhWGVGL29KdHdsazBYWEsv?=
 =?utf-8?B?VHJZNy9KenBKMmgrKzFLb0RYVFV0bHhTQUJXYllYMnV6S09FSUsxRlFkZHlX?=
 =?utf-8?B?TFhRREVWQ3lDRW93MVBKVjFMeC9LYncreU8yQnV6YUdWYmpZeDVnMHgvSlBW?=
 =?utf-8?B?QStuaC90L0EyQnBHOHhhdjd2bWI0THFuZzhnNFdJUWVuRUluYmdua3ppRmtZ?=
 =?utf-8?B?Q3AvWDlIc2hSVzRxN0dmZ2ZYZDc2VFczN0d0eTdncXRESkRTVlFKVU5uVVlR?=
 =?utf-8?B?WWN5d2pKdkRVT29IS3NGVjYxbUdtWCtPamxIZjBPSXMwZkhJalNwZGx6Ri9x?=
 =?utf-8?B?cXNUUTNjcStwaVl2TE5ocE5lYVprM3hpU1FjNE5vcWJKVTBicUR1dXN2RGow?=
 =?utf-8?B?a3l6SlM4TlFVMzc4NXRLa3dDQTd3WWswdTVEd3pJNHNhdDBLTzJadVdUSVZ5?=
 =?utf-8?B?ZHJJWnZzcnhncWFTRlR5QjFMOU5sMmhvTHQzTFZ2Y1RlbUVaQ1VMWDR3aUd0?=
 =?utf-8?B?UXJPbDZCZkIzOFIycXdQR1djNDRkdEZlZGFxN0V6UHVneVBFKzZZSFFObk1F?=
 =?utf-8?B?T0hDRisxMjI5K3R6eDhhZUhjZzBhL2owTGJ3Ky9RTDdxbGdpQmN2VENDYnBm?=
 =?utf-8?B?QTVITno1Rm01N1BxRTVLUzVCTmErejBVT1NHcnUxR1IxTGRGTDBGazgxUzJa?=
 =?utf-8?B?emsydDRCV0ZoU1pRZU1XU2xuaWhIZEplQVBnWTlVMzdNSDVkZTVmbWZIeHkv?=
 =?utf-8?B?MjdEMFlTMGRHcEkzN2x6UDJNWWtGaS9QT3RrdlNRa1hMR1U5TXljSzU3Qm1G?=
 =?utf-8?B?bzRPaGI1TVpHd3A0OHZheGtpZllVQ3hRMk9RNGw2Mzl4NGRoaWxHTnlZb0ZX?=
 =?utf-8?B?bDRxR3gwNkdiZEwzL3BZWkNUUis3NHdDYW81aXBaTzFzSVo0b0NsYVBMRG13?=
 =?utf-8?B?S0FyRTlnam9GQlZ0NHc4NUtPK1ZBbGdLZ2N1OU9UT3FPTmhVY0dYMDVuLzVh?=
 =?utf-8?B?akZPVFgvRjF4U2ZLUEdEdStycEs2b2pBWmh6WThOR3o3cHBTaDJHM0x1RWVT?=
 =?utf-8?B?ZUlsRDlJV05JOFdRVGEzOHcvZzlnNUNhNHlORzAxdmZOMHpCeUNDd0tlcFJ5?=
 =?utf-8?B?T1h2a0hLMUMyb0ErMjhtanExaUI1L1F5cGIzbWJxWE9vKy9CdzFxREdxR1Ji?=
 =?utf-8?B?bDE4N3MrcmI1dmpUcG5CQlFMdUNpTDIwV2JPcU45dVg3WjJFdkhjT0VDeTJn?=
 =?utf-8?Q?LuVXr6C5TlkS+PHWBRur0yFw5xLEkWFJphB9Dxn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38bc2bd-f53c-44a1-cefe-08d966635c61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:25:19.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPRstGl/GVqeneSMEEZChkzDtHPgKrGoZOlbnReYzkuK1VrSLPHUmZumldKQ/KRMqBkckrofBnkeEpA7uovwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/23/21 4:47 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:02AM -0500, Brijesh Singh wrote:
>> Version 2 of GHCB specification introduced advertisement of a features
>> that are supported by the hypervisor. Add support to query the HV
>> features on boot.
>>
>> Version 2 of GHCB specification adds several new NAEs, most of them are
>> optional except the hypervisor feature. Now that hypervisor feature NAE
>> is implemented, so bump the GHCB maximum support protocol version.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/include/asm/mem_encrypt.h |  2 ++
>>   arch/x86/include/asm/sev-common.h  |  3 +++
>>   arch/x86/include/asm/sev.h         |  2 +-
>>   arch/x86/include/uapi/asm/svm.h    |  2 ++
>>   arch/x86/kernel/sev-shared.c       | 23 +++++++++++++++++++++++
>>   5 files changed, 31 insertions(+), 1 deletion(-)
> 
> I think you can simplify more.
> 
> The HV features are read twice - once in the decompressor stub and again
> in kernel proper - but I guess that's not such a big deal.
> 
> Also, sev_hv_features can be static.
> 
> Diff ontop:
> 

The sev_hv_features is also referred during the AP creation. By caching 
the value in sev-shared.c and exporting it to others, we wanted to 
minimize VMGEXITs during the AP creation.

If we go with your patch below, then we will need to cache the 
sev_hv_features in sev.c, so that it can be later used by the AP 
creation code (see patch#22).

thanks
