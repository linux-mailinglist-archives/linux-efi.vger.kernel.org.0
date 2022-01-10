Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AA48A116
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 21:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiAJUqh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 15:46:37 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:37569
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242206AbiAJUqg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Jan 2022 15:46:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpiVwW5E862HJHrVYJ/Iz/7TK19VkQria/qW8yT0HjzN9eBeBaKDhEPppv04BXiAmZS9EtAdDyy2jmeuiH+UvPBSuKRwKyicwgZWZWNbMxtFCBU1SrpGhbYaf6VAl89KlvMCXclpWJc322CdXs+j9hvQhWKgkfx/VkW/uTi2ZKgvqb92F6xEB7d2wxihtm3LM5IMbLG/1TOWtxyeR8qFMmq4L4IPZIMmVSmUdRXRhNU6lW9z7MGNfqIUSkZWupvS/3nu0rYNZt88wnJ5glNProy67GrCh+GCSTipQWsygSCSwfNSUozOOz7YjYAZQWxM84jn5L3zihxdCA63Yw4EWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3wSmiZy6UrSJdUTRIpQJhZlBT0LMLY2TXMV7P7SYdM=;
 b=Vnm6sKlPT+Wei8eO80VGEGI35p+cpWLHmD3gWIDK6/0DeZp/hVxj8mH8NWToiWigkP5Wko41m8q36ycrOestmyx4HjB7764sCPnOMjDVqVYoC1IJvoz1JsVsyOMRmvYyFPtFxAo1LnjSeKcbmHLGmtdk/33KSkcZvi3f8gIAm+WeoEEj5RbSuA79+jGZrrQz0SMvKXHHP90t15dzBQjkxGEk/QOI/5w5/4gD0Ed2daz2Txx3nr0Bh05oyj63Et63aU3qLCUk2pTnE6UVdA9KMNH7y0dZgANagkSnCwANFegqYbCFx+gpFhbOrpOFxhvOx+/YzmbhCdTmvmQX67ZCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3wSmiZy6UrSJdUTRIpQJhZlBT0LMLY2TXMV7P7SYdM=;
 b=RSjXRpuwsr8tDlyygVqLIERMt56sPiY6c+Yb3r8a9tc+HE/Fdl90HU5lz9zV+5rU7ZyOkrc5siHl7DWBUYgDqTvCdk728C+3Lyy10p7L/88KTu8ILwxM7yvQI/SEGHM4xRPR1061skj4u1NuLVMui4cbnoe1qCCWJbc60fyo7l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 20:46:33 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 20:46:33 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME features
 earlier in boot
To:     Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>
References: <YbjYZtXlbRdUznUO@dt> <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt> <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com> <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic> <20211215201734.glq5gsle6crj25sf@amd.com>
 <YbpSX4/WGsXpX6n0@zn.tnic> <20211215212257.r4xisg2tyiwdeleh@amd.com>
 <YdNKIOg+9LAaDDF6@dt> <5913c603-2505-7865-4f8e-2cbceba8bd12@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <1148bed5-29dc-04b2-591b-c7ef2d2664c7@amd.com>
Date:   Mon, 10 Jan 2022 14:46:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5913c603-2505-7865-4f8e-2cbceba8bd12@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0380.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b7a56d-6e20-4fa4-830a-08d9d47a4985
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25109DBAA503DD0EDE68CC5FE5509@SN1PR12MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtyWPiWZhyQyhhvFSyOsgAstFPynDQi+rJ5qoWgm43kTMvF9EJUmEVBZYBbjhHqAIIoaQCoTScy54QcqSiW7uU8dqp+b3nqbSlF8HxlpjdHkXJ0xDmbi3o5yr/mspAPHsKF5mOpbhdItMAIY2JcG9yH4oE3DlOcNuGPI5I7TThKkYzbuht9wsTaouCKBjtVrOKQLcTi3iCTKQAQ9PI+2ZgjuclYSct4NAIiQWKQmGhLQH08y9iw9W5A4ESElaAp31rGBcSu92FQ4T3GGcGffNsRKyuTWDbPDlA4WAcXcQwyY7anB6MRN6BE5G/34+uZqENzK0VoH1zNoYBDqvEvPz8x2wMUi0hOxD4Bim2RnEyOSPPzvlIw+HAOSXAL/5q/TtEhw0a5zn6kcOnx7pYu23qbv38ElnqEROFQOd53NNwIWRzRGoTkIbQTAeBVpldqRdPjTgRljlc70aKyjulgV+1VJhomkxEfbGOsxU6P51xXgiHrWsqAIm5vZrRENI3UooJHLKjt3goqbOAwhvPqUNfvlJn097xFQ2GxIpYAaXNtqB19kxH6nc+3ii1QhiNm4jl+mIi0hpNGBl+G6MRUEvvVSDYKIkzxCxZJk/TzZCvtIkPZm5BcH4yzzHP8Mwe7xpRzzOpu9+jR2SUvGc8+cm/3woQza9ABegx4OEExCZ6QgG+FX0EJRjVVdst07NQ2M19MHmg3IFpXc1bsai7umSs17VCl+jNW+WXxOQRCdixQR9LsLQZ+JJd63ApnKOdXz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(2906002)(7406005)(66556008)(66946007)(66476007)(31686004)(6636002)(6666004)(6506007)(4001150100001)(7416002)(5660300002)(186003)(53546011)(38100700002)(54906003)(110136005)(316002)(6512007)(26005)(4326008)(86362001)(508600001)(44832011)(8936002)(31696002)(83380400001)(2616005)(8676002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpvZkZacVdaMkdyZGV5VlBmTlhCVVFqMTJwbUJETVF6WlNMZWRIcG1sbDNQ?=
 =?utf-8?B?ZGpybU1Tai80Tk1TNEJDWmJXTW5ORStZMkxodmZFZGdaNktQUUhLOHlOMGJE?=
 =?utf-8?B?RHp0NHk5bXVXbVNQNXNQbjhqV3BjYTVGMzVmZ0dNNFBHZXZqTzdYdFVzaTdz?=
 =?utf-8?B?S3BHSHRzWkxaNEpHbHprTUxLdWs2UDJIWkNsN2pBRGE3b1lVZE1LRzFUY2tF?=
 =?utf-8?B?REY3cGxuTWRpSDNxOGZWcHhlNkJ4T05zQ0pQUVF5SFhUdlZWQkkxZnZlZm5T?=
 =?utf-8?B?UmUzbkhnbEJGZmwyc3B0ZDJ4UlYwUGlYeVdpMVdJUVBIT3MzWkJSQldXbjFn?=
 =?utf-8?B?RWdUd2NzK2ROUWlaUHRtc0JTNWdabUlCcndhQUlZbGREWHdJZTR3K2JEZVRM?=
 =?utf-8?B?NmdTaG5tU1pzM1lYa1ZsMWNSbjU4WFVQbEtKSzRiTjlzV0c0SnhBd0k0ZGxZ?=
 =?utf-8?B?bk9RbG9qUlBXR3VSSzltc0VDdzlDaVpxRjNaVnkrNkhHZkFydVgrN3dFZmEw?=
 =?utf-8?B?ejRYVVlWSGc1bmt3NEhWTU9kZ1dKYTZNWUo5bm1QeW9rci93cG02aisvL0Rl?=
 =?utf-8?B?WDM1MmJwMXM0L25BWStlOVRrRVp0bVFuMGREN21YVVg2UUV2eXRkZ0FMemYx?=
 =?utf-8?B?V2dWVzU4ZG5LaUNjQ0FmT3FUR1hyL2ZxS0lNOEl1TnEvZEk5ZFpQL3lFSFpO?=
 =?utf-8?B?T0VwV1RZdU96elc4aUxhN2Y3OCtjRmN6TGhxMHRxWEtxSUx2VHRCSXJOWHRz?=
 =?utf-8?B?cVRWaWdZSEc2NXJ6VjVnVThqYnhmQ3R3RzZ3SWFsbzA0cW80ZklYd1ZzQ1NH?=
 =?utf-8?B?dXRCekFWcGZJcU4rZmtBWFpoS09nMUxPOE41VXJYd3luQTZoTFE5U3E0QUU1?=
 =?utf-8?B?Kyt5djhzYStmS1FMZUJyVGRPUFBNckRRRmgyV01NaEZRSEtrWnVpTSs3bUFv?=
 =?utf-8?B?V0JnSVlpMElzRWpKclcvK0lhcDZsWUVoTUhGenNURngwQnl4T3NocVc4cUNy?=
 =?utf-8?B?UlkzdU9lNFl3V1QydFArdXZVK1RKUFlHemZnbTBuMTR5dHZsemtrR2JzYmRa?=
 =?utf-8?B?OGkwLzRudzB2VSt1RVlVOFJqUWdRS1I0TFZZM08vQm5kTUp4cVRsSVJjUzkv?=
 =?utf-8?B?T3VVdHBGVHpEdnBQN2NLYm15TGFGUVExcU1sUHVHaFU2QTJCbHhBS2E1SGMy?=
 =?utf-8?B?N1p6TEwxbWRLelMwdHlJVDZ1eXNMcythRHkzMXlOUEF2T0F2Rm5Vb3UyWi9E?=
 =?utf-8?B?Y2E0WDlXdHhOVG1rWmFiazdCcWRCYnVPZkdlaVhoMTZUVXhjSEljcDAvbDZk?=
 =?utf-8?B?SjMrNld1bEcwbWVncUwzZkVWMmhqOVY3blVtcGxtSjNQSDJzWitldkNIc3Qz?=
 =?utf-8?B?SmxXOXBNaXI0TFJmN2lJVjk4TnJWWTh4WENtTmM1UlMvaUdsTTNRaGxLNjIz?=
 =?utf-8?B?cVVnbXR4aThwdnVwV0lBeUg1ZGR6ZGpEbUZkZDFuV0xHNy91WkVjRGd4dW5H?=
 =?utf-8?B?bTE2UGY4NlV4czQySWZjNnNrVVdsZS9ROWhmWVVYSk1Fc01XZG12QTc3VGV0?=
 =?utf-8?B?OGl2b2dkOHp6WmVBUGJpWEpmenhUQUNQQUtSdm53eURrS0RTYzhHQ3hWN3Z2?=
 =?utf-8?B?cVJzOXNkWXZySFNoYjZZWW15Umt1dGxzSC8zU1VZMnlDdWtDVDVEdzUwSlZD?=
 =?utf-8?B?Z29wTkRxemhvOE5sNmg5N0Q1eFo5cDJUSlpSTlFpdTh0Sm9pdHRJeFZMYXVQ?=
 =?utf-8?B?Q3RWZUNKTjYyUzF1QlBUS2FJc0V5dWs3dWxiT0sreFo1cFM4aFA0QXhCa0Nz?=
 =?utf-8?B?Z1ExT21BVWFTR0UvbG9JaHZQcGxEdTNyWk5FeHpSUFJOTG0zT0I3OFBOUlVl?=
 =?utf-8?B?M0p4VGkrcHdBbzF6ZjlYVlNFanZ1LzQvd0FXYWtrMkZZWXZQbzdmSU9DcFFN?=
 =?utf-8?B?SGR5dnZRWUhZNFdnS1RPL285eUxPMU1OMHllNXdlM1lEeXFzOGtnbUExanJD?=
 =?utf-8?B?anFkeEhuaFFSNXlWbFFMRDZKVVJUL0ZkWUtzRktIdWIvZ2UyK2lGMXlTYXQ1?=
 =?utf-8?B?MStmTnkvbGpES3RVd2RtVFFEb3hCanp6SjBiaGdhaEpyanMwVXJ5RFhzL2dD?=
 =?utf-8?B?a1F1RFdFVWdUOFMrcVpKZ3AvcVI2RGpoVFBiZUN4aENzb3M5cHp6K3hpT3k3?=
 =?utf-8?Q?b022HXUKdNzzPfd1pucPToQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b7a56d-6e20-4fa4-830a-08d9d47a4985
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:46:33.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkaCiTq6NgxLgB+YUDiCwtf9FPPMl3R0X3ksIlsmGIJh7AOc5sbc/2+YzocoWOnRkxVJ4l8e72oemOZpzIX0hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Venu,

On 1/5/22 1:34 PM, Brijesh Singh wrote:
> 
> 
> On 1/3/22 1:10 PM, Venu Busireddy wrote:
>> On 2021-12-15 15:22:57 -0600, Michael Roth wrote:
>>> On Wed, Dec 15, 2021 at 09:38:55PM +0100, Borislav Petkov wrote:
>>>>
>>>> But it is hard to discuss anything without patches so we can continue
>>>> the topic with concrete patches. But this unification is not
>>>> super-pressing so it can go ontop of the SNP pile.
>>>
>>> Yah, it's all theoretical at this point. Didn't mean to derail things
>>> though. I mainly brought it up to suggest that Venu's original 
>>> approach of
>>> returning the encryption bit via a pointer argument might make it 
>>> easier to
>>> expand it for other purposes in the future, and that naming it for that
>>> future purpose might encourage future developers to focus their efforts
>>> there instead of potentially re-introducing duplicate code.
>>>
>>> But either way it's simple enough to rework things when we actually
>>> cross that bridge. So totally fine with saving all of this as a future
>>> follow-up, or picking up either of Venu's patches for now if you'd still
>>> prefer.
>>
>> So, what is the consensus? Do you want me to submit a patch after the
>> SNP changes go upstream? Or, do you want to roll in one of the patches
>> that I posted earlier?
>>
> 
> Will incorporate your changes in v9. And will see what others say about it.
> 

Now that I am incorporating the feedback in my wip branch, at this time 
I am dropping your cleanup mainly because some of recommendation may 
require more rework down the line; you can submit your recommendation as 
cleanup after the patches are in. I hope this is okay with you.

thanks
