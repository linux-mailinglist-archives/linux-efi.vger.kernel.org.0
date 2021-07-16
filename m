Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD73CBA13
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhGPPuf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 11:50:35 -0400
Received: from mail-dm3nam07on2052.outbound.protection.outlook.com ([40.107.95.52]:57664
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235850AbhGPPue (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 11:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI254wTSNOXRAgOfU/j3ryKXIpcwN3Vw34uGqlSh3T+JvzjqrhGTBpH3gZ1XWk7MxR6TZ5jva/cdK7uDT5mIc/Y5rIUYvVl2naOtKkN22P4uO8PUnxkQIZHR2rrAEfbSlIWhUr+szsHw/NMYWxSZfgjgqATy15BxTi4QJ1BFLcpBvSa8QAo8Avv5RhNzfMyr0D9eP0OhI0nyYKBrTdRePrxGyO0L7Y/ObA/JJmbbKFLd4lbZnV32yoRbkm7051I+r/D2mrUaw1h4/IlUSExgqo1WtPHUySqjwns44FpiahIc27n1K4zo5WVzDFezpDdHAzhRhrVT3kEasdxX6XBtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP7/N7/2llYthBOYGn71j+iNoJOrxoNDxrRxS3q4EAY=;
 b=SDs/xgc045teN85sFq2TuiUsngZqwld2YVFLMyQLvZfr7obO3aCJbxZOPwsJaUWwJSMnEhDhrdjnNfH74orK5kZXFbQgHo4mSNVvc3Ag2u9rcI0b3tiwlySy+Ak+CIKxppW4JMP5Ls5csnRo9cnm1sCp9x2t4H0t88IR6hKcYGDEwLo+Rfnn00zW1d3SlqmxKSksSzKNwKIJuW1eN7V043HIzEni/CkBJ3k35oPYp588hGbWYrIm3N6QA6K9wneQVhh+JOs2EVuk9rTQiBMuEsVVsvPfjSYut5HqJYlNoN7eJRRO6jgWmsycfriAQPPo4zkVYRXdQBHlpjy/SoKusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP7/N7/2llYthBOYGn71j+iNoJOrxoNDxrRxS3q4EAY=;
 b=sd9enG/pScuFx0x3R6jM4KH80w6HmF31O4Txun2o/q7DOTOdEPSbeUO5pezEFTVFYGZewUXyH2WsF3eEG/HPmYS4jilaSZcijRi6cUOjgY2OjoPh4mbHb1Ar3IulyCBJSgpk0ixqx41pO7KV1K8sBmJkt+y7ccE6QKVfznv3830=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 15:47:37 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 15:47:37 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 15/40] crypto: ccp: Handle the legacy TMR
 allocation when SNP is enabled
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-16-brijesh.singh@amd.com> <YPDJQ0uumar8j22y@google.com>
 <dfa4ccb5-f85e-6294-6a80-9e4aa6d93c1e@amd.com> <YPGnKfDvmgzHCwbI@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <770a9480-a18b-473e-ba50-c9978ce64317@amd.com>
Date:   Fri, 16 Jul 2021 10:47:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YPGnKfDvmgzHCwbI@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:806:a7::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 15:47:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b73d79-ce1b-4169-5d65-08d94871092b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44325A064FADFA817F4DE338E5119@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXb9RjJ8vNMCDTekNUHjO9IwBoq4RBm6PevevQYuJPuoYqVnBebN/EcSuZJ7lnNjNXK8DRr7bG6gj//E+//zMf+kDPFxRKEjPjfbWwwVjJ0RKTcdGfADC2uI8YllEQrVv8YNAkrbYogtl+r22Aa7/Q3kn+ovcVcnStBbgwuimgHzflX/2YSkyQMkplRCj86OeacbgMlpxbWquvgbRALIt9iLOIhwSHvmjdlVK0hvKfodZqTfThT8hCnR/Urp6ty9aHFHsPwbKInma5ntHWCUBZfbR/faoC5FP5uAX4p/K1aLzfJ55H3x23BMMg+OW7oLuiyiVAXaHvN1TKl/Fhzu0Fk4NvVwhBn26qky3dS0tRymvyzJZfyZA2tObmdt6taiWH6nvV+V4tSUJjT8aFmOlF1Zi7Sx3qazB9d/tfbhmTXJscks34hTXXSDp7eWFZteD7ZuNxJB6vQ0KSCBh4yM7Ko7tjcIo2+KZ8BaE+x+PmuM8cFiqWjaRJlIPsvKckx2Q9/K1+9XUmzbQcT6Ff/UtbTZJMqk29TAzEgR/0vqPuVUdjIXprIE+2n2S+m9Hjaz6N4QW45+Ak+WV0XOd/WDoVCH1yARpmydgPBL9Zq3E/k+gV2ja1GRIHKrubqTB0pXX3eW0/mq47ewhlWJDuaMjFOmu+zF1YSQ452iWU3k0hYCr6W6sNz0cKycg0iP2hsO8so7msBPWAIcNMVcQPj7SS9wgXEbBmLT5Z8dA6SILZLRTV7yyxZXWjrnd4rv5Sl4krInl5Uv0LBbC+kj+OdTug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4744005)(26005)(8936002)(8676002)(6486002)(86362001)(44832011)(38350700002)(4326008)(956004)(2906002)(6916009)(38100700002)(478600001)(2616005)(66946007)(83380400001)(31696002)(7416002)(66476007)(66556008)(5660300002)(186003)(6512007)(7406005)(52116002)(53546011)(54906003)(6666004)(6506007)(316002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGM2NHNYOGtaV0RtS2lSZ01VaXNlaUFFNElqS1BpMHhndmZERERWZDc4NmJW?=
 =?utf-8?B?NE9IajdESnk2b3I4VVRSVWhmc3lXcmp3WTlaMUZ6dG1WUDBZTmpYeFJxMWlC?=
 =?utf-8?B?SWpnSVBpV3Fta0JpT0t4S01wTlNHcTlPYjhKbzhFVHJqZGhrUXlnV3pkSUdH?=
 =?utf-8?B?TGtSd0hvcmJjc2d2bmlUdURGc0VtYmdWWWR2OEhGVnZiUDh3TnZJbFZnS3JV?=
 =?utf-8?B?QUxaUENmOEZXY3E0VHdoL0FmbURIcVROQlJuRXUwTUphWFNsa1hsb2JNejQ3?=
 =?utf-8?B?OHczZGpMTnhhTjZKMk5Fem1ZMmNvSFBjRCtZeU8rdUd5dEVvNDgrVk5HQmo4?=
 =?utf-8?B?L0JvVUZ3RS96WC9TUkY3Q3YxcmJRRjA3cjhXcHJUTCtldlZJNVFSaFJ0T3Y0?=
 =?utf-8?B?QmlqUTMrK2REZ0NxWmlJT0xCVStpTmliZ3I5dzI4VTB5ZHZlSjM2ckNkeVcv?=
 =?utf-8?B?dDIwQVV3QkpYeEVST2xEeEt4QVl4cmxLUGdPNS93L3lzWkZBTUI2eldyOVJn?=
 =?utf-8?B?VWplME0rclp0U3U4eEZJR04wYnNJcTlYSmNSbFVMaUNGQW1VNjFyaWJTNVBK?=
 =?utf-8?B?dUdOeG1jQktOZkNhTnpyeXRnenh2Ti8rQm52OHYza2s3VWhwTXRHcDZ6TmRF?=
 =?utf-8?B?bUNUZDBESUVod3Jnd1dVNTdTV2didzJuVmpWbFlQS1JDUU5KVDdxV1hVbHNS?=
 =?utf-8?B?ZElUQXM1WFMyek9QQXBFbnpxb1hqTHV0WGhPU2I4QXJXOXpLOE9hUmh2em0x?=
 =?utf-8?B?anA4M29yOFltQW9qWmZmSDh5blRRQ2lIRFc2MW1SMkRuYytvOVh1dnhiTmRQ?=
 =?utf-8?B?Sy8yajBsU1pPR0tMWHRaemg2b2xZbCsyK1l6L3o5TVRnQjB6dEpTV2RUTDZZ?=
 =?utf-8?B?SGNhNjhHbTRVSU9BV0pMYzYyQWNSVFBxVXhYRlh5cVdLOFFxMGxNNUl1WjJP?=
 =?utf-8?B?eU85STVzYmJCbVp2ZWZFeENRbXFoNit1VmRXZGpFWXVYU0dBaHEwUTlKYjFF?=
 =?utf-8?B?Mi9pNmlvNFdnVDAzbGxDcGtpZHhHdk9qTHlYN2wyL0tFY3lNamFVZ3NrcTJD?=
 =?utf-8?B?NmEwRmhhZVRsWFZaYlRJcTdWZlVvOHdTOGtMNnUxS3p5akVKR3VsUVFHUUVB?=
 =?utf-8?B?UlgwZHo4OGJ5eWtBcnJMWnlTcEVRN3Y2cjhFelEwbk9VeHlGVFNJUXBYcnRK?=
 =?utf-8?B?K1EzNm0rU3ZzSmZCRldoYm54akg3dE1DUmxjalNVQStXUWx6ajlGQ0cxNVI5?=
 =?utf-8?B?UW1ETDNITCtEUFZRbEl2eTFXZDRlQlZBd0hscDV3VHZ4eHpISXZxTzRUbktU?=
 =?utf-8?B?endiSmxxSU5DYXpvRjNBZzJ2UXlQK0hhUEZCR2cvLzJnNmNqT2hxRzV4dnV1?=
 =?utf-8?B?ekJ3S05JdCtqK2hCQ2k0enhpc0hYREwzY25OTDNaeXBjSGsrN3FPR1B6OUdw?=
 =?utf-8?B?eHdkR2VPQWlEMHdJQmQrcXFCQTBZc1MzMGhrMS91bG1iWHRBajhCOFVyeWxh?=
 =?utf-8?B?YmdOY3E0M0I1dnJaQTJDckx6SXVVQUZIL3ptek5wV1pLbkp2NGRFMEJRTDhm?=
 =?utf-8?B?bEh0bnVnSDNDZTVEMGYydU16WnkrZzAzclA0MmhDMU5PaXNzSzZRU3c2VUVp?=
 =?utf-8?B?eXZxdUkwbWtPTHYzbVh6Tk12aVZIMy9id1FBdnJKb1JMSnJBem5Lb0p0UzBW?=
 =?utf-8?B?OGpZOXVLYzlEdU5Cb3hUNHdlWk9SRW5qeTBUYmdkcVFzYkl3dGtBOXQrMTk3?=
 =?utf-8?Q?M1Zew6cqgG7GZ5a7x29S3MD4qi5Ca6KVrwr8ehF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b73d79-ce1b-4169-5d65-08d94871092b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:47:37.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X29tdInjWE2PL9q97eeK+1RfAvaN0ISO7TTb81nsnez5RT1l5TDM49/XIwlyC5Gq7GJ27qOiuANG4VWd0X9iIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 10:35 AM, Sean Christopherson wrote:
> It wasn't comment on the patch organization, rather that the code added in patch 14
> appears to have landed in the wrong location within the code.  The above diff shows
> that the TMR allocation is being moved around the SNP initialization code that was
> added in patch 14 (the immediately prior patch).  Presumably the required order
> doesn't magically change just because the TMR is now being allocated as a 2mb blob,
> so either the code movement is unnecessary churn or the original location was wrong.
> In either case, landing the SNP initialization code above the TMR allocation in
> patch 14 would eliminate the above code movement.

Got it, I'll rearrange things in the previous patch to avoid this hunk.

thanks


