Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE24CD880
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiCDQEx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 11:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiCDQEv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 11:04:51 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868C1AEEF1;
        Fri,  4 Mar 2022 08:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjRVYbfNoBYgYAq4WdatKjoF3ff0wIKSBDp2/M3DD1bN+IJhyaArhX8XhdvkuSsODt89TpZ6CcxjJfwxa5MjcCXvRMRi6d6uN1JBCEHdzmItd2jX9mImeLPBEOxdrYjgfu44RJNh4wU881xgUGCH5ulOk730oGvPNtV+P3dHDqxbzcEPgLgqSciEMIQsV3A04LNg7KFR+NpB0URdTrdt4WE56YHGcPHzwRhYhVjXRYPJocRt47YEWmNar/ZV2sDcGIdrO+FCpzCaLIVaei9sDn2P6DJ8aDHhJ1jxAT22atjhfVLLMJ8C8coaWzQ9fRrULbw3YsfIRzph/jSJmkr5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pda2RsavOPzP0lYnhthpUbqIVnlRaGfUdtE9C+7+jek=;
 b=CEZWtoce4yTL+CZQQ4LadxLKndQ2Y2tfXhvu6YT0gINCM9wHqh77aHYE2dktkFO1WTr2FtSTMo/j+n66YqQUVzkYo21dRErYMpt+DaHe2Gul1UApXcCDuTEvQ9snRQkY3+bi9Yiai7p6lHusZQ1iJkRzOsG60kCzkq7GTokjQL2FBncqB/fp/e4hGSm8s/o4ebo/FinbGJjcMiiz95rxLf9ux9+kAtAQwbm8MKBOVn2R0ZbediNLNJ1pQuBAzpVRglZrSMCUlgL/9/5qwPn2tzNl+k0MW3y3ivlXwCyoQd3D0ycB1F72E42v/+/WcGmLbdMnkP3o4he0dprY4LSvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pda2RsavOPzP0lYnhthpUbqIVnlRaGfUdtE9C+7+jek=;
 b=4vdj487xEg3mqRAqb1sW07ml14fDCCHgNDKsGEu3BIxI1medxu+akvaFlxJTTyaBKfHE7K+F+nGllJtfgs7PM2cUGeFyjajrFUXsPnzdbNaIsAcUWz3Y3y6P/+/agHfbzhvSVV9EKxgINOOsnFsiceeS7tS1+BgiD2zLvs1TirI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 16:04:01 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de%7]) with mapi id 15.20.5038.015; Fri, 4 Mar 2022
 16:04:01 +0000
Message-ID: <0241967f-b2e6-7db4-7e54-be665e12ebb6@amd.com>
Date:   Fri, 4 Mar 2022 10:03:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 44/45] virt: sevguest: Add support to get extended
 report
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-45-brijesh.singh@amd.com>
 <YiDegxDviQ81VH0H@nazgul.tnic> <7c562d34-27cd-6e63-a0fb-35b13104d41f@amd.com>
 <YiIc7aliqChnWThP@nazgul.tnic> <c3918fcc-3132-23d0-b256-29afdda2d6d9@amd.com>
 <YiI1+Qk2KaWt+uPu@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <YiI1+Qk2KaWt+uPu@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:610:e5::24) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16845fe-6902-4717-ee3f-08d9fdf898d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4481C0E1C49C7A5180981873E5059@DM6PR12MB4481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lp+NcaWZL5dG63T2XwO6atY6Ep+ta4al7cfVo3B5Jp0y1HZPJNx3tw7KcN9VfW2MSQkNx4WTbXDqDJ8Rh5EsuTYUR5Wvpc7ujpb5H2nEzceXGlMzq1ycuf7L94iXCa+Qe3/UAmsaHrcfyVW7X++Af2ZAIIT0+a6ILIAId4+mODX7oU0ecxsJwcvGcgXTCwxGcFSCjwnypbVcXguV/CT6hg7fDYhRVuholsu/soQjqIaJ7JjaR4QQ6d828soszQB2ocRiGhtp+ZLuXlwCK5FoF59lTiUi4mqGxfsHOJADfEuubIa6suxTX7WWDfY8l2TkRt9JrBv9zSn21L8MBXgI2NULiSjwm2ZasNdNwzxuRXF5EacpeKpT5+mzved9nYShPO7VhCqlsxY05D+9pX3EzzOhjKZNAeDaN0Tsv3dkFpbI3CBh1oNeZv0UX1WbbxL1WJBgSDy+d+T59QK12xcqeKTGxWuQXZI+ft/xHcq2CQOv5+VIt0ulG6yDQI4SO/18yKy390uvbg/sZG3WWueD+pf+IgVzSBnog4D4Fi00AmQ0ru3fnUn2xkpP9LvBwuRmqQDdEOd6zqnaR3KDXARWswtiqvbvD/RnXXKVw7WyON65HYpTC9esV7NIBHdJaXn1dCDFbkseSXG8zWhYb8AgY55gUyNlL6ddz31PULp9EZ7/y5uluPehTtmgI5brfFt6EyoAJRZFJLRfTJPtQLXw7vU5RSANNdF6HauvI44v1+BuVuXEzxaYhpTeBM2V/ETi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(5660300002)(7416002)(7406005)(8936002)(508600001)(54906003)(6486002)(6916009)(6512007)(53546011)(6506007)(38100700002)(4744005)(86362001)(4326008)(66556008)(8676002)(2616005)(66476007)(31696002)(66946007)(6666004)(316002)(31686004)(2906002)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRoYSt0VmQrbXprOVF0MzdZQ0NxdnZEVXJxbUlVS0E1Vmo2WWN3QUNoL3Jy?=
 =?utf-8?B?eXVvVjNyY2p5OEJMV3dZMTArWTF0SndRU3pablZTWStWeE4zVXhTREFCSXJZ?=
 =?utf-8?B?RnVmSjB6UmszNllRYzQvNkRXS2MrSFNXdmJ1V1Z0L0FpOWg1NFR0UWdrQnNR?=
 =?utf-8?B?UG1OLzBBQ0Rkd1kxMVptR3VNakpUZW9QOWlncWh5WmVWWDZobGVvZC96ZHhk?=
 =?utf-8?B?K2RkQUFzU2ZFaGYxcUF1N0F3dHh5c05EblplS01zZFArOG4yWFNZeUZrcnEr?=
 =?utf-8?B?R0VpMVo1WkVuZHUvSFM1VUcrbEtkNkhKQndoYU82YjhFN0E5dkZ5bkkydVkw?=
 =?utf-8?B?aDZRNm1IUEw3R2xUM2wvOTlEK1VHbEFIQ3RjbkdOUVFSTmpSM3k0WXE4MjQ3?=
 =?utf-8?B?VXRUY3hhY2lEYXVFQkRhaFFhb0t4ZnkybEJsakY5YTlUNEJsZUdJeTAyMnd6?=
 =?utf-8?B?TzFwaURnZmNmNThiL2J0WTVtYVpsMk9rV0JJRmg3K2kxMUhYcTcvaXpIeVBN?=
 =?utf-8?B?TXNIVjI1OXNiUUtrQUlRYlRPR2lpWFp3dFFkOXVCek5XWUVUWEFkSFJTa3Bj?=
 =?utf-8?B?WTFNN3l0OUxDc3M5blhzVzQxaStMRXZ1SHZJeDd3QWRHR1dMYnljd05tVlVH?=
 =?utf-8?B?RCtYVzZmMFJFemVHRE4vd1QvdEtjWkEyRUE5djVhcGRVT3ViTzJOV3dlYUsx?=
 =?utf-8?B?NkNYRWJyZnJiNVYrNlIxMGV1RW9Pa2dhL09tR2pMTWdsbzFkRVJDWVZzQk9D?=
 =?utf-8?B?d1RkbFNzTmp1ZUNHZUh5OCt3SVBZNUNDWCtwQWQ2U0Y2Y1JzVUlRVnpJSDg3?=
 =?utf-8?B?YnRoUGtEeHdITzB4ZnB1Y1dXRDBPN2I1bTZzUDB0WkVxdnBlV29tbVdKbWFM?=
 =?utf-8?B?b3ZBd0p3ajVCTGJhMmk5dmdQZUhFNS9wTkRTbGdBQU9hWG5Rd3JqSXBTRExY?=
 =?utf-8?B?RmJpQkZDa1YwcFF3TFpHV0dxWkdUY2dRUWgxbkYrZm40RFM4UjV6SmlGak40?=
 =?utf-8?B?OHN2b1dUUjlTMGlSa2djUGFxanhsSndyWnFlakJJUklBS0p6cjlDdlNNbTFF?=
 =?utf-8?B?dm85b2FZMlIrNGphZmhGa3hYOE1jOHdscnUxUjRnV2FhbTlyd0RTVTg4Y0Rw?=
 =?utf-8?B?c0oxaDk0SnJRYWJLd3lHaEZUVlJCaVFESGNERDF6UmZ4UmRCVitxUFlNbHB2?=
 =?utf-8?B?RnlNdGt0LzlWTk1pWi80SVRrMHM3ZGtrckNiUXdXbS9kWWxmT0w1d1paZ0cx?=
 =?utf-8?B?Tm5LSkZ4dXhIb09hbFI2NDNBeHFtSVBsREdsRVgyT0F2bXRGYUl6bHpEL2x0?=
 =?utf-8?B?alZJYUJtVWl3ekdBcDdHTU4zdzM5RFAvL2F3ajBmcjdmWXhYNTZHTG14aTlB?=
 =?utf-8?B?alYrbXcraGlxczVQcU9lVmFlRFowYzV5cEpVN0pNTjJMSDVyaXU5VGh4MGpV?=
 =?utf-8?B?R3E4OU1pbXROUk5QM3hsRjVHSnBoaytvZ2hJb2hLZTd5dzNrK2RwVXhYdEVz?=
 =?utf-8?B?TjB2cGpGV29ONDVFMXdNTWhmNEQ0Z3VRaXBHSnhjRkh6VW1mTGlZSFgyYktn?=
 =?utf-8?B?dXdqdXVqY1NxUVd0SXhZZ3FMdUNCMzNYc3pMdDd1S3pqa01WNGMzYWNHY3I4?=
 =?utf-8?B?MTNRUUtzMTR2bGR2WHdqcDFNRlcxa2c1cU1ZOVFlMEs3UktDMmVjeWNFWnNL?=
 =?utf-8?B?Q0ZTK3hRSCtOZ2k0RmdYQUpsUVkzQk5lUHlKRnc2dVVkNzhsMlF3VWF1d1dC?=
 =?utf-8?B?TUY0TGVVa2NQYmVGQTBrNldRWUFWV2hkVDdvaXhXcUowZ05kK2Q0em1GTVZi?=
 =?utf-8?B?cjROdkwwcVI5RHJKTUhIOEV5REFjem1qV0tiVDdzcWFOWmVZZGV3M1NhQjU3?=
 =?utf-8?B?a1hhRGNIdjlaTHdlTTBMd1lRbGpKZ3BDN0ZheS9QTGowSGZ4SVVDT3I2aUo4?=
 =?utf-8?B?NHVKSVNrcHZhaXRxeEx6NmRPUmo4aWZwV2hOd2Rha0Z0UXlpMktQR3laV1lW?=
 =?utf-8?B?ZThqYytBVHVYQkZDQkJrRzR3Zm5iWDQvSjBvN21haC9RNGJBNWpQUUtGQ09j?=
 =?utf-8?B?SmQvdjc2MXZFSlRyU1ZkWGtseFZCTnZkdmlxUWdJR2UybDR1Wlo1bHlYTHZl?=
 =?utf-8?B?UnZiWkxkQWFKSmpLOWowc1V6ekdpbng2OHdsUUZiT0pKbXBKWE1EY1R3bnFa?=
 =?utf-8?Q?gepwxMCVVZnDLa11bpAVExE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16845fe-6902-4717-ee3f-08d9fdf898d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:04:00.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGgwAGY3JtCF0cgRBIBrWptBQwA5FAFBsi9sW1qcPpKLXiSBJCgv1selONGS2R/TIr6M2U0pw2xOP7yG3BSnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 3/4/22 9:53 AM, Borislav Petkov wrote:
> On Fri, Mar 04, 2022 at 09:39:16AM -0600, Brijesh Singh wrote:
>> Depending on which ioctl user want to use for querying the attestation
>> report, she need to look at the SNP/GHCB specification for more details.
>> The blob contains header that application need to parse to get to the
>> actual certificate. The header is defined in the spec. From kernel
>> driver point-of-view, all these are opaque data.
> ... and the ioctl text needs to point to the spec so that the user knows
> where to find everything needed. Or how do you expect people to know how
> to use those ioctls?

I did added a text in Documentation/virt/coco/sevguest.rst (section 2.3)
that user need to look the GHCB spec for further detail.

