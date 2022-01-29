Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B174A2E59
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jan 2022 12:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiA2Lst (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jan 2022 06:48:49 -0500
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com ([40.107.96.63]:43366
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237490AbiA2Lss (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 29 Jan 2022 06:48:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1mMGSJPRin4ATPFNO8tC24c5pJEKj8/nZ1zglHtu7KbJ5zMCLxfs49wHHxhP0d+JzozRCWDuAFxhEnrOpiDyJYKQibMrNtQ7vzGMRBfSr/82uBD9YlVJlrv/u0AMo6KZk/rsPVltugOqipGyMVipU/Qlm0CFLujYY4MKvjpTBw9JByedxhLGWo7oUCSggB0DjDlpNUO5nJG+TkA2eIPayVtbU7aGq3Z6wNVyWzqspgLJCPm2jrShHDPAfFtZEwVnMN7HD/2LIpzX2LwpND2wZigrXvLuA7Ae8vLM6GER8nogaaLW+lLdCsF9rNJV4NWO7rbNm0cq+QdBRLFESChNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU43uUqVo8BQh8M6lwMeKQIJ5bvOrNIWBqZDYrNlys8=;
 b=Oofoer7Ck0IyB8350lr0RmsFu1A3m+dAQNXz90kFR1+GfMKhIXl7vvfobnyPwkDB+tipNpEeNSr6n2nYD2grc6CU81vqCt0l1V/e5jybIXnt4WuWRRGK1gQ9MQsTp1KoiwHjBx8vpQI52K7mVjCPRAd8UPiVkN/4a5+J6C+IryLhVItW7puqrcLQVXdbHfT+csxu8KTnx/lHzlv0hqi5X+NvwaOtIMhDSkXh/fAYp2q8an3RFhLFcobRTtRHqGf/B+YHm4mk9FpAylwa1GhUVQPEzJnoY1ePdxnSA1dB0tFunDUnEuGcF0RQ5HJ5/vfh/Yei+Cm4Zw74I7TWFr327A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU43uUqVo8BQh8M6lwMeKQIJ5bvOrNIWBqZDYrNlys8=;
 b=fca1unyRPAO4fxvZIJ+yepPMc8FbJHdST1DRGKiZwd/A9OznyPXaBuRjN8AePi9wgO26ksx9A/45BCafkoJq1tsuzCw818j85qwTs2Whb7XxGm8DcSwuR9l/Tq5hROx57410B2XI7njHLtIpjjPbt98i6EuVVnVt3w2hHUA7G3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM5PR1201MB2537.namprd12.prod.outlook.com (2603:10b6:3:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 11:48:46 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%4]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 11:48:45 +0000
Message-ID: <fb90b0a5-a8cf-0c94-ebbe-a0d5343fe3b9@amd.com>
Date:   Sat, 29 Jan 2022 05:49:06 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 36/40] x86/sev: Provide support for SNP guest request
 NAEs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-37-brijesh.singh@amd.com> <YfLGcp8q5f+OW72p@zn.tnic>
 <87d4999a-14cc-5070-4f03-001dd5f1d2b1@amd.com> <YfUWgeonL4tfGf8P@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <YfUWgeonL4tfGf8P@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:f2::22) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c363bf-8878-45ff-c058-08d9e31d4e2a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2537:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2537ABAEC04814645F534FCFE5239@DM5PR1201MB2537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffyCtm/hPU/mgxxnMUTr9nQTR9cKW/2nGrtGY9Tf/ekthabGmxI3YazDLUe/X3NF31EtfbkxHzob0Na0RsrKk4zCDUkSzoZrJcr0nLUunGnCgHBQDULlROa3aBIvWdjY19NvdQXwV6vbbUUWv5DMW0/1qFNls7S/dD6ahIB1zHiteI28colFLfwcOAiJTXXUJIKVFnjIRHBFzbXTEkwz7zFRPZnndgCARQTeRlqOKuWtb3zBhTEqdfXYilS9cndaKlCmUqyizwM3nZMYwgPW1u814RA+e/+w2p7KkqQrDdXPoDIGdyhAfihz8vmyaAmeC9Iiu0NCTNOJorKx/EeVcd4rtgjRWrO8od688WIZLsbrKdcspUW7LC1p0c3Q3ZABcS5C1bS3FSsuJ7oUzVZchjMwpYVhJwdgFBFZiSO0fLWOX1YGcQhtRvbGKFthAjBX1RVyWanwM3n9PlHZqLoZ+Z9v83o7O5/kTMVZrov+Vnf5dEnf69lomO0yUdMe1h7Mf79HoJG86Ycp2zHwlMvNdpvMs+p0gajIzCNctxdUv6LLvMdrBOptpmBr+1RmMvG68cefreqlvN2Uoknt8k/yFEmXHGOlHW2kuvjmYNjFM9nJOwd1CYth+llCW25vh4p1nswZHFZTB4qikL9Sc9neToFnUBDqs7o816DbDKb3PepNtjK7vas9KZUf/5H+UhOcylyDdDWLLFr/BKF4dtf8vZECzi1GKPxltkYHsRjHFl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(5660300002)(44832011)(7416002)(7406005)(4326008)(66946007)(38100700002)(53546011)(8676002)(8936002)(6666004)(86362001)(2906002)(31696002)(6486002)(66556008)(2616005)(66476007)(83380400001)(26005)(6916009)(316002)(508600001)(54906003)(36756003)(186003)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJ1QkhZSHVtQjdueUxCM3BtckQxem4xTzlFY3RjRytlN2dRQmh5U01UTDcy?=
 =?utf-8?B?M1B3VEM2eXFIbkFtb0NtNFNMRm5yQnBBS3hMeDJtQ0NhN3ZDVTJQVHNwWGhU?=
 =?utf-8?B?c25OWEV2U242cm5TYzlCNy9kczBZd1Nrc2VyaU9uYk1YYzVhY1pmeGUrR3Ax?=
 =?utf-8?B?SEZGMktNL3dxUVdEUFRiakUwV1VaQi9EUW9aNUhHTjJoZCtQTWJvTldrWWZ0?=
 =?utf-8?B?U0g3NnQ4bWFxNXFCK1hFQ3BoTkVBdlhpUHNZOFpuY1NxRm05dEhxblFFc3ln?=
 =?utf-8?B?dU5GY2VHM242L3lwTGlIVlN6T1VESFNRTGRGbkViaFB3S3JNVklBMVN6QUdP?=
 =?utf-8?B?VkhFdDZkM0YvK1hyYXg0QlpxQTRuMEFDMElhSWxJRDBlVElIWXlCUEh0SXZq?=
 =?utf-8?B?N09EZnJjTTNCQVowd09DVWY0L2VBUmY2SWQwUk5WTjVobVo3TGZuUEg1K0JZ?=
 =?utf-8?B?UkZ3emd1U3IrQzZGQ2ZOd0EwT0RHR0orTkkzbUtZWkJXYU92NjBJby91cnZQ?=
 =?utf-8?B?QmFwK1gvZEEyN3BxWjVpdmRsbmxJeUhzWk9PQ29ESEl5VTFVQ05SbzFrNVZG?=
 =?utf-8?B?cFA4VDdPUm81MlY2VDNaOTFlQnhTN25Eb2F1U2xjaXBKTmkveElrTkc0TFd2?=
 =?utf-8?B?aWpBeWhMK2VkZitUN0YwV3NTemttcEs4MVFQY1hjVnF3MlhQalZHekh0b0dy?=
 =?utf-8?B?MnRSZkRQWVFMN2RqR3BJM2hxbGtjWEhvcURSK2lRWGpIbGtrc3hUb2E2b2Rk?=
 =?utf-8?B?eEw2a3FHZlBJZGl0TFE0TXBSRE9xdXJVNFV2MHhDRHlpUzMyR0tDTHBHa1NE?=
 =?utf-8?B?Q1VvZDJ0YU5qYTFLTlM4S01mUjZpQ05hQWNMZVRERDdwblBYcWJteXpQTXlk?=
 =?utf-8?B?NlNqdlJTcUJhd1dUNkNvakxYZ0Z3WmJDS1pHQVJpTlhhZGlhYjEyWkJ4eUpq?=
 =?utf-8?B?REJxT0lvS2hCV2toM21hYUFJVjA4VUN6R1oyRlY1Zk40OGx1cFlYMlZ5aDR3?=
 =?utf-8?B?ckN1UHRtaHhWRG9sdDY2U1k0WGd5WWdVZVdaOUdSS0l4aldIZ3h1WlNkRFh6?=
 =?utf-8?B?RGlqRDIrVjBwOVozWXF4aFJNOGcraVNJbjdFOFNxbWhKR0tRdlg2ZHVrVHA4?=
 =?utf-8?B?TEs5bFp0Z1hJM3AwVjh6MUk5bFVJWHkyblRmT3dLRGFWWFNTUkNNTDlsTWNm?=
 =?utf-8?B?UzRsMVBrRkpaMVhwQ3ZoeWR4MFZTZmdTQjlqYWswOUYwVCtyZXg4WGdNWmh4?=
 =?utf-8?B?U2dGaHBOaVVhME9YQ2xidEx1QW5DZHNnbnRoTXpxNHYrNk5HUUI3UUVlS3Aw?=
 =?utf-8?B?YkJodWlIUTVCaXF1NzNoZWRucUNjTStEWVRTaFN6K2ZPVmIxNUhrUllRRlV1?=
 =?utf-8?B?WEF4ODEzNjYxSEs0UzB1dFNkL3l1cEZibU4zajduZmxLVllqenNoRmpSaFZy?=
 =?utf-8?B?eEtZdWsvVWc0K0hpSml0QmZEdFJhMlZpNjdIRGg3OFU1RkE5dE1Fb2hZd3hQ?=
 =?utf-8?B?QzJqSXBaUDEyTERxSFlac2g5ekFsSTU2ZGpiMVNTaWh3SGtML1pRakFWUjFY?=
 =?utf-8?B?RzF3MTJLSUdTU2VNbTJNMWhKUk9vb2FMays2SmxDOFB2NDF4Rkc2MkZwSUlS?=
 =?utf-8?B?ZC9EQ29oRkxPWDdYeXNKMmhDcDdYY1VJYnZzYmpOTElqeHJtR0VUMzZBNm5X?=
 =?utf-8?B?UVFiNFEyU1c3NGIzZ3NUdFg5R1dydEkzL3pKWUlKem0xZ0w3UTVXbU4wRCtj?=
 =?utf-8?B?cUd4UnhxMnRMb0F0N3B2TllGSXcxWnMxUWRXeWNFc3hFZGRWdGJnSlpFK3RJ?=
 =?utf-8?B?cUpNaWRTVlMyMTZ3THMvQkJVbVExRk5pMXNnMW5HZ041Z1dZcGNGYWtHN094?=
 =?utf-8?B?THdpa1ZETDdzejZtbmZRWGkzeWJvNEorOUt1dE1ScGZuQ3pURyswTUl6U21E?=
 =?utf-8?B?c1ZNbk1CaSt5QXlqaUdvaVpWeTFlZ09pajRVS1VNeUNDK01FeXNBbHg1Ky9o?=
 =?utf-8?B?c1o4TnZNRm5QSzJOTjdvbklaTHYxVElZQ3I4N1U1L0VodnJ0OFlURloyZFlH?=
 =?utf-8?B?bmRncWRzbjA5VWlGTTJkMDdtWlJQa0JSTkFRaWhFdlhXVmJ3WjVYS1hqcDVH?=
 =?utf-8?B?cVFiZ09Xd2xFSnE2Ry92T3dDdHYvRkJkallNQ2ZnSTF4WVBvV0tidnlCVjc4?=
 =?utf-8?Q?vrcOqmUatzdLlp4zP6xqo5I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c363bf-8878-45ff-c058-08d9e31d4e2a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 11:48:45.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99jELdhg8I76TgIewNaOnhsoA+RRojuNzkjs57ZMOwa9aYScvMjK11GM4NBoiWl/18zrdzLXyIP5aEMBi9cgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2537
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 1/29/22 4:27 AM, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 11:02:13AM -0600, Brijesh Singh wrote:
>> I am okay with using SZ_4G but per the spec they don't spell that its 4G
>> size. It says bit 32 will should be set on error.
> What does the speck call it exactly? Is it "length"? Because that's what
> confused me: SNP_GUEST_REQ_INVALID_LEN - that's a length and length you
> don't usually specify with a bit position...

Here is the text from the spec:

----------

The hypervisor must validate that the guest has supplied enough pages to
hold the certificates that will be returned before performing the SNP
guest request. If there are not enough guest pages to hold the
certificate table and certificate data, the hypervisor will return the
required number of pages needed to hold the certificate table and
certificate data in the RBX register and set the SW_EXITINFO2 field to
0x0000000100000000.

---------

It does not spell it as invalid length. However, for *similar* failure,
the SEV-SNP spec spells out it as INVALID_LENGTH, so, I choose macro
name as INVALID_LENGTH.

thanks

