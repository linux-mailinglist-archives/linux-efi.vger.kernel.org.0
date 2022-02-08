Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB4A4ADAF4
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377760AbiBHOOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 09:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiBHOOV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 09:14:21 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3EC03FECE;
        Tue,  8 Feb 2022 06:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3WqRiQ9pNdHWrVsFN6M566mup8JhJJrwmVxSP4Xu/k5VtHbK/WlbllK6S3kTTP8HSITlU8b0BvnR6ofxlcl6fIGs0iPvuaWUS8nDqi1utDwHd8tNlk6tlT9lJ+gevgtvknOVmz1q9cfEgtRuziWvLb7J8+escDxFMI6jcOHCWVX9wHpmyOy1eDLbcrvY8xtjT7m59i6nkCT+ijpwziXCSihpuIpa9pMVjf1ahw4ifh7a0x+8fy4JUEE6jJ91VlF+n+omiGXqcY91QpjHnEXibNoMK9n6xRwcoeXfz59xlwYmQoASIh73XMIjTC1jUX/zv4Qyi1T0usjxEF0YbUCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mHsQFbFR+sbg5u8t1MrbfIYwK9sc+L+ereItO0//y4=;
 b=hTNcLPXAq6J7q01IUBzdj0pPSE9ssufxf9jST3teBHSS/v8bQ/YXu2QUrAItysbXBSVquUm9VY03+ZcKZMHLVldR6YZlxLLZMAjd6N9Ztm0urZYrcLS12GRj5G4dyWwb8HVEQEU2HcMjBI7AXK5wYUYTABeb+HJjYwVg87ITl6SrfbsNDoQ0MD//dbEReV4cdZx6YP1SUx8A9cu63Wj1Qg9WBu7AH83p9/RXEJDvXqtc6clKEXTXCEOTYoEGIMUDR7wDante7Yqi8qvLHSnUUIC52hdruI35aDRZU3PnXhYCO38iaET9623wYBUy8Avfsy9uitoRIdS5I2sIwX0PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mHsQFbFR+sbg5u8t1MrbfIYwK9sc+L+ereItO0//y4=;
 b=twWm84XjnAe21DGmLpV2e2FUAUtGnj3Xp3eYGTBfyh4JAslGM+3U88mHO1mzdmj95ipxC/r0YW6rf4yuTH/EIm7FDCTKgBfolYqlt3IMucoU6s6KKIrzh2DE0kny3wQ2CgDwYJjB9wtagCnEDs4U4p1xmu1YQfLuEgtWVShYxCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM5PR12MB1929.namprd12.prod.outlook.com (2603:10b6:3:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 14:14:19 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:14:19 +0000
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
To:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com> <YgDduR0mrptX5arB@zn.tnic>
 <1cb4fdf5-7c1e-6c8f-1db6-8c976d6437c2@amd.com>
 <ae1644a3-bd2c-6966-4ae3-e26abd77b77b@linux.ibm.com>
 <20ba1ac2-83d1-6766-7821-c9c8184fb59b@amd.com>
 <cd3ef9dd-cfc5-ac8c-d524-d8d4416f5cad@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <cf9359c6-a514-937f-2b6b-5ae1225980f7@amd.com>
Date:   Tue, 8 Feb 2022 08:14:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <cd3ef9dd-cfc5-ac8c-d524-d8d4416f5cad@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:610:4f::15) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d2ac49-6fbb-4e9a-8992-08d9eb0d4bde
X-MS-TrafficTypeDiagnostic: DM5PR12MB1929:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB19298B3AD622CD84439EC459E52D9@DM5PR12MB1929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n17a7llH+9JTU/ar3/Qp9aQjabySdA1qRoMlpmWsCq5n8XFbHGWeD1lesnbVnyRwjggOqvLi7K1ysvrvAl4+mKvt27IrkL9SGAN9bv5HLTDrEV4Impy3OMN/nnJABBknNjk+IXt+9kIh52k8MyS8NHesAm2jGS0rtLq6YO5zTtNZnB1QHOD54pXkqlg3X50WA4+J6iLb5llWHFMA1Yd7gTDFlQ/VisaeqpYLe1eT3nP/s/fUfnqfgYfiM3yldiIVsf0Ky0jZ8adXgFU6PB/Nw7Ze7FR35C2DKXFq8LPs/Isl1WFxrnysuZMZjuCHdRkqYKg6UwkPgrGMxdHVeTXZVmBZrXSpvrvHCAdHpC7miG6BLRsoqDAEyAKsL1oLbKaMeYkrbei3kdOEVGkUInPY41AIxUrF0PlNEi5/9F5Z8b0tL/PD/Zu4fpSFjqZcmKIDexMl3b4TynU5weY7w2XWn7Z3sCjQTejTu0S7Oj6kFRx2CK5AlNp4RrZ08EI71IrnUoQJ197+Cnhr6VeuwnyzHzYJZsu4j7xR/u5qYuDuDGsH0QDGkvf6ofM3tEX+g5LunyA5nkUDsgol+bgKe5/pMDju9wPpRw8/6IcULV+HEihv4jAS6bvgxkzN1KAhJwdbxOGhscgg98b796/TRu8LFQ+Rn0qOWAIpdYeY1184yLl9wxYY2dMf1zC21DD+AWGYAZfmZealCS83DBpCPMRTkWUdb+P6Y23p4pL3W5u+OR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(36756003)(186003)(110136005)(6486002)(6666004)(54906003)(316002)(66946007)(7406005)(8676002)(31686004)(26005)(44832011)(7416002)(5660300002)(2616005)(4744005)(31696002)(86362001)(6512007)(38100700002)(8936002)(4326008)(508600001)(6506007)(66556008)(53546011)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFMwUDdOUmt5TU9xN2RGR0EzeU50WmVZNWFUdDN4TjlzQVQ0SU43WVo0VUJ5?=
 =?utf-8?B?WWluYzIwdWVscGViS1FJOEsyUC9RVTltUWtnenBvRHRiMWIya0RWMm9Hbm9B?=
 =?utf-8?B?cklGeFh5UFV6MlVyODArTlVxWW8zTlcxbWMxeXFueXdSL0s4aVR2UThzMWpK?=
 =?utf-8?B?UEthT1V4cERXenQzQjUxdFVSaGVnSzZUVlE0WU54NVdqWGFyZWFsWkcwdWc4?=
 =?utf-8?B?Y29SelNvNmFsMXNrWVlQYWVHelFPeWVkOC9hOEh2NTBsUi9XM2dHYmtiall2?=
 =?utf-8?B?eHFqdkVLNzJybzdIL0Z3QnU5MlIyODNEbGg1a29OM21JMVlUTWhZUitiS1hV?=
 =?utf-8?B?WTYvTlkrSmUwaURvbDQ3QlI1WE8xTkZBcHVMVitYcWtXNXNmNGR1N3JiOWM1?=
 =?utf-8?B?MWdub0FTMUpRQzJQek1NVlNJYTlqOEkyZmZ5VEFFbVZ3TjgyQXRQdUNuWkk3?=
 =?utf-8?B?bytLRzYvR2hwclcrelhiQ2tzanU0Z3JaWnR2RHBMRjNWMkE2Z085b1JDYkd6?=
 =?utf-8?B?RTVRT2tWbCtNaEJpZ1pVM1gyaDdRU1g3VG1PS2VGQVdKRExSdUU0UU02cVVY?=
 =?utf-8?B?RytSRTZMbG45VWY4Y29sL3p6Z2pvSVBQYmQ3Z0xvQXBOL0hqVXI3UkRuY1l6?=
 =?utf-8?B?Tm1ZQ3VPV3hSNnJ5WWhyd2ttMUUwT29La25OOG9icjRxTE5mNmRFQjEra2xT?=
 =?utf-8?B?VzBBc1ZmK05XNm80RUdTU0dXMWRFQkFPcWRjSFJIMlhkLzlXckZITm1WUkZU?=
 =?utf-8?B?Z3FUS0QzcSt6WlZWOUxFSnZPUUYzUnlVTkN1RG1FZElTazZUdXFmTEdhY3pE?=
 =?utf-8?B?aDRGV3IxL0V2VDNOMzlEeTl3SzM4eThrTTAyR01WblA1dXptSEV6R2szVTdQ?=
 =?utf-8?B?U1lKK0dBNWJ3bEVkTTRzMFcvcWdqSXp2SFRZOWRlUHF4N3huc3ZISzhFYlNB?=
 =?utf-8?B?dkM1QUduZHR1Wmk0UXpjUjhxMzRXUGY4RVh2am5pZk80bmhCNUpmbXBuUjhL?=
 =?utf-8?B?SE1iNDdmQ2wwenpjYm51OXpYYTR2bTNuQk9WR2I2Y054UXBMMDhGNWtJS1cx?=
 =?utf-8?B?MGpVRE1OeFN5QVJGQ3FWTzRTR2lGWnBJN1RpelVLanc2OUljeVp2TlhLc2c3?=
 =?utf-8?B?R0pqVmVwRXV1WG5zdFppSlhaVlMzMjhQemxpOVZBc3lVZGNIRDVHK2M0dy9k?=
 =?utf-8?B?QXorTjlEQmMrZFZ3dDBlU2VOUWhzM1ZIaTdqb3RIYy9WKzFyVGUzeDlqWEVQ?=
 =?utf-8?B?Nk1uL0crQjlIR2ZtNkJqRUsyMHB0cThhalpjUjRORjBSN1JybE5udUpiWU83?=
 =?utf-8?B?cWgwWlhwbUoweFRxVkxIcG13bXZLSEhxbGd5OUNBNFBmaldHNlZJS2Q0WW5V?=
 =?utf-8?B?Tzd1QU1hMHVaRGxLbWl1NEYwRjRBdlduU29vYW01OVlLS0JyS1V0NVZDY1gw?=
 =?utf-8?B?dmNYRzZKalh6a1ZRcVI2REhCWXArcEZsa2FQSEJtSFNSQnFONEM5SDl5ZGF3?=
 =?utf-8?B?RFEzM1VFaVdFb0gvcUpVdlRibCtUUkgybXFIRkR4QU01VmhYV0QwVUlrVWE0?=
 =?utf-8?B?RlY5R0Z0RGZqaEJMZlhkanMxM0hnODRVK1FwTzhSaklIbGdwRmgvazhZbWZJ?=
 =?utf-8?B?OG4wMzZMTWdtOWdaTFFxbndFRlQ5MUgzYndtRHkxdmRCaEFFSHd3OWp6S0RO?=
 =?utf-8?B?NlJlR3lhSFlSVDgzVWhTam14R3N0UXVEcE1kRThoL0pNaHBNQTBOZWJGYUNR?=
 =?utf-8?B?a2hORy84REVKcTZvdW5PZERDa1BBUnp3KzZIYWhuYUxHYnVML2k4UzQ3OTNx?=
 =?utf-8?B?dVFrdW1jbWxFNm1mdUFPUlkxdGdwOVpXN2FPRmFsQlpzMVM3bllmNXcrM0hP?=
 =?utf-8?B?WWwxZVBTeWtpblhHV0dqdGNXdnNUY1k5OVdCaUdPVVYxQ3g5cnNRSjR4ZEhQ?=
 =?utf-8?B?RGdYLzhkOXp2clR0NlJUOGlxR2d6QjF4c3JrYmluWmpJZmJhVDZvdEROWWhY?=
 =?utf-8?B?dkNXMEluWm9mTmlyRVROSWNteDU5U0lEeVdUVWNMQjlEWGx6NW50dHFKTDR3?=
 =?utf-8?B?RmJ1eVVEdldaQnl5SS9PRnViSGdPYzlMRkgxcG9xRkdPOWRqaWNGR1pUd3Vq?=
 =?utf-8?B?MkRwU01sZnBuZTkvVWlzZEVXUmhSZnJPV3VvclFHMU41WUk3SHU2MzE3eGt0?=
 =?utf-8?Q?CARJqh011gWaew7soFl5GuI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2ac49-6fbb-4e9a-8992-08d9eb0d4bde
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:14:19.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/rWm9hVVqoX0n0PWL60Oh1LVXxEO/Ywepsl1eqmEEkriCFjuU/+8i7Su2giQ9jKso3R22WJL/t9a8NoAaKSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/8/22 1:56 AM, Dov Murik wrote:
...

> 
> Just to be clear, I didn't mean necessarily "leak the key to the
> untrusted host" (even if a page is converted back from private to
> shared, it is encrypted, so host can't read its contents).  But even
> *inside* the guest, when dealing with sensitive data like keys, we
> should minimize the amount of copies that float around (I assume this is
> the reason for most of the uses of memzero_explicit() in the kernel).
> 

Yap, I agree with your point and will keep the memzero_explicit().

-Brijesh

