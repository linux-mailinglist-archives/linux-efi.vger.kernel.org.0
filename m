Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83274A7318
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 15:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbiBBO3b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 09:29:31 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:12321
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231839AbiBBO3b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 09:29:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMy1xje+aYNvj+ACRbj0i7F5KOaFWvMVk2qd5U/kdjmZQ1grO63jv9QjNeyK79jF3Y4p27KcXeErxhyA7RI0qZRLQ23NU4PleovQzHxHYOnEhPiRfYZicqXWiNHkqQfDmGSCTcJ6QOgkCDAuwz6ILUlWMUz/2KwF1sPQHluy5FHnmK+43JPeNSSb5KMnxg8X1yxys5WMwwdaXZuDXvi9X0yJbuq64tVJcp8bBgHzKPFTD+ywD0HdMAP47OU4sg28lbk/kxL0MMoCkJdfeMAf8c1sWS4mJqr8Gw83QkqEOVTLPhXLoz2h5nZ/ZZVMH2WoRdiktXaLj0VTVdY6hVe9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83Y6/dQMtYl9R++ehd+j0F5hazIe9dfRfSyEn4pWNVs=;
 b=UYRINGMMMYRsHgCfFkwDKPx5Jy7bwNuljK2CgplMesiTkFHpx4WV8BhkdpywVW/fuDBExZVpbSdehDYL5eFcnO4YRDqHq0Xxj8MBzON7B7zGWe4vz/I2KQmnUVNyibddWHAOPu0jDkYRH+/aSwCSH56vP9klvwl6ZXU8bbD11b9W1XqcU8bK0jQDFDyOEGkzmqYpGNvWilm9i4xOs/8CVx+BL5rXZ7FYxKTfJFc5E0dD7tCnS02WcO8BO9OMA+kmOSINuQhCi8Go+jRvDhvDblryZZVZAFP/wE00gv5i+cXJIftq2AVRGwOvPIt1gSzY9elOyHeXklLngB4Y4e1IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83Y6/dQMtYl9R++ehd+j0F5hazIe9dfRfSyEn4pWNVs=;
 b=JIUKszsi3HONHh3ROxZvTNJKt8oIZRy0NwPIOzm5lbPWnJ1psVHlap9YQ5BMP2X+fDeErMnf50lgSvdQInl5clW8vcDvwX2UL9YbbBBICliJmNyGnSjvf2Wv87OY3wVQTygC00YMB3S2FwMO4d0vIVOxP7eod39E0o+ncvxleHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 14:29:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 14:29:28 +0000
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
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 15/43] x86/sev: Register GHCB memory when SEV-SNP is
 active
To:     Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-16-brijesh.singh@amd.com> <YfpeSErxB9KHOd7m@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0b1835df-8529-df63-31c2-945e93118a96@amd.com>
Date:   Wed, 2 Feb 2022 08:29:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YfpeSErxB9KHOd7m@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:610:11a::21) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45732e02-5fa8-4aa4-a7af-08d9e6586b91
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5360E380448022C3A5AEE124E5279@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXxVIt39keHl83b0UeE5xx1IORXxQI2o8vdeHvLG/lGw2NAcQFAKAZz+pJr1IdCpGVLpxc8onRyLzZdy06OBBMcyUm2p3sOxyKEcl24foo7v0KKYfkUxC6qkp+0ZHEHneUegmN5VTTu6Yu3tXpPizueNTadtqLK5VDA2xvZPbyWzW6hPN28riq5i5JBB+aWA8TYgWM8ZcHKZytJywd2AXDxK3PbA1NttKkVHqP3dnIBPkma6C3b14a30gnQ6zDOcKBABvyWEDl5623jpWOulF4HwAJJKLb1192Sl55Se89RujDrn0UsIgQXaZJc8eDlAwn8KlXajCUagYUI77UwrhHT59eXijToWO8DwKuUb5NgO0AGdN3V00kvnNPPxcgj7nS9UOqUgXAlchFD/WtuJB1NAfiHWfQdtQn/VVN1LYVmJ0r3vSu/+AfAo/4A/3Qt20UB+Zm+u/ymZNq3SfE+S3d6mo7PeDH+fgKhbmBHQYCOUHXaaCfyJmxzoo3IegFvAXaDG/vAzISLbciN2cGRDc3cLDCqkaW3P5UCV8XuVdIzOzNojk4NQAzsC9wu76a6o7GJWTfenEaJy0SZxd1vPoYQiJyMmK/rkZ2HA3szn7hfpuwttm+kDcjuHkz/gWr3bqlASjLfXkJ7/CjK45alkoB1ldeyLa25Pz/0Za+joK64SZ4+gzHMYKDhG7y8PweZM3arS9lEFUDOh59loAiuYgqDevYOgwyp4KFgmyYl4+gFsCqiWRQVLSaVEsKJrMlwR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(38100700002)(44832011)(5660300002)(7416002)(7406005)(8936002)(8676002)(66476007)(66556008)(66946007)(4326008)(31696002)(316002)(26005)(2616005)(186003)(6486002)(508600001)(6666004)(6512007)(53546011)(2906002)(6506007)(558084003)(31686004)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VvbDZOay92MUorbzVEaGFnTG5ISkQweTk1eTVrcUNoeFkrOVJWSmRod3Nj?=
 =?utf-8?B?bjA1QVFPZXhQa0lSU2ZnT1ZLWUpSY0VkT0ZyblJHZXB3bndTSWZ0UnE3b3B3?=
 =?utf-8?B?RFA5U0FkYkwzOUpzT0I5d042dVdrR0prY3Z6M0FkMk9MdTNUSS9UWUxVQUZ4?=
 =?utf-8?B?aW50aGRFQkFUREZLYnNDUTg5d3B2SXhHOWMxR012d0R6VndaY0RUckhIbFNx?=
 =?utf-8?B?ZCtoaHM3bDhZbk1QbjhMQjZyZFp2aEpScWlYcllSTDlSTTU1TkFvVnBSWnU5?=
 =?utf-8?B?cG9hNzM0NnB5T0dab2ZhRVJidjZzQnhmTjBwdmJwS3N1MWZaMXkwcTlIVzdy?=
 =?utf-8?B?c2lhSUI1TUxhazNCTzBCRzA3eEdxT2xPbG1aMmhnSi95Z2doN1FXOEVnMmxM?=
 =?utf-8?B?Z1g0OXIvM1dnRVp4Nm9oR1RBVDZVSUhmQk9BdUdNOXJaZFFpY3B1Znl6NnYz?=
 =?utf-8?B?TnFMazMzeW1CSW02cDNFY1piV01ITW9kZFI2QzAxYTY3aDhUS2NKZlY0Zi9m?=
 =?utf-8?B?RW0xSnVZcUhKOUk2Zk9QNDg5aDBwMVBiVmhzcTRKd2hNRHJMR3F0UUdCcDFS?=
 =?utf-8?B?anBQYWhIN1lkdm8zZFNmeG5EWmtmSjZka1JPQ3IzUURyZ2g4d2FNT21zMTd0?=
 =?utf-8?B?bE0zbEM1cnkrYmhKV1dKSHRxOHBQSENNakQwZERJeksyaTJDK0cxYTlscHJv?=
 =?utf-8?B?cXFXd0VDL3V0NXVwUnNiZVlUZ3MwY1cxOExVaWkxUkFCYkdFdlF6bkFrV0hZ?=
 =?utf-8?B?RnVMTnVaNW9ITVFCUEJKdFRyVTBYV1YvQmVZazNUUjVqbU5tWWRVQVdTRnBG?=
 =?utf-8?B?YkVVMHVtbEhldG50allZL0ZTU0J6V1FwdDJmMFhkWUhkdzlEQ1g2bms0K24y?=
 =?utf-8?B?QUNuclQvbHQ1RnBETS9VNFdtaWRleTBwZGhxeEk0SXRYWTV4TUtjdGtzcEdP?=
 =?utf-8?B?SmlVQmVkMzFvVmxobkw0Z3JwZnhVbTVRZmx1VGNLWWhHM2JyZ0UvVG5Gekth?=
 =?utf-8?B?eTd4cGtpWVQxMU9Hd2UvSHlQQVlFVTREbnBQQUQ1VlU0SzV2c29Uck9NMXpu?=
 =?utf-8?B?ZTZsT1hRdXhSUkUyZGVFRmo3SHNzbllvWCtFVHNxOFFBNUFtMjBrUGRNNmM4?=
 =?utf-8?B?TmVzaTAvd1gvK1d4bHlucnNFcW1tYTE3aUVXb2tEMTRoSVVUY1NLREFnTzRR?=
 =?utf-8?B?U1Vlc1drM2s3U05rRnVZNHJkUXdBd2xqb3BrQnN4bi9xY1UvcFE2Um1JMDFN?=
 =?utf-8?B?cDRPTEpiQ1Fubnc5dHdoS0FPZDZnVTNSUzlBLzdMRHNZRjFQM3Iva01oV3Zq?=
 =?utf-8?B?dXN0OFByMW44d0NOQUV2TE1kWUhrbmlUVzl6UHQzdDVjM2hwNGdHTnducUox?=
 =?utf-8?B?S2xFYnd5WG8xUmJpK1o0Rno3dTY1eEtEdk9jcGlJZkUwVHlhbmlieTEreE1h?=
 =?utf-8?B?T3kreGVZTGIyRFVUays2RW0zNlN1RWdsK1RUYVVESm9pZCtiNmQ4R0ZWVnRD?=
 =?utf-8?B?ZkxaV0xjS29RYVI2VmRzY050bnd2OVlpYkphRWVUQ1BsY3YyQnlXRHkrS2dC?=
 =?utf-8?B?WDhHOHNPZnVVM09lN2JDV2p3M24vYjE0YXZOSGx3djYwWTJWWEZSalNySVhK?=
 =?utf-8?B?aDJDT1FjTkNyNlNoY1BnbndnT3Jkc2V0aWNyRit2VEVleUVHeWFYRUg0N1Ns?=
 =?utf-8?B?TlNLVWtKbVBNOVJ5czVBcyt3KzFaNkZ3NjRVOFowMCtPbXBmdUxZRmkvSkV6?=
 =?utf-8?B?WjYydWdkQTNVTXpMYkNMc3dNcmVZQnd5MDhodE16YmF1REZBKzdGUUNHVWE4?=
 =?utf-8?B?MlVTSzBxaCtPWm5WdFBoMHpJcEtYd3FoN0FKeU85ckNrUmsyZjFjeVVqK2Rv?=
 =?utf-8?B?cWdJb3Z1aWpsL0hYS3RlU01ydjMzUkZKTzRRSGUrZG5Xb0REU0puZDRyVDY4?=
 =?utf-8?B?ckpvcUR4RzVTejJ5K0hydVhEUXZjNEdJeWorOW5nNjl5NkwrTVQwclNlSGM1?=
 =?utf-8?B?Y1A3SHNVMUNQbTc5WW05Qk4xOXpqNk9WN2xHRUxxY3lZa09ZWTRsR0s2VWlr?=
 =?utf-8?B?cE5MOUc1d0FqM3lobCtycVNTWUlZKzFUcUNHNHpzQ21neWZ2VEczZ2ZuOHdy?=
 =?utf-8?B?RTBuRForSXEyRkRXcVdKeUt5VFJ5VzRwT29CbXAvYmZWZnJ4cGRUelAvRUZm?=
 =?utf-8?Q?jD9E6MgLLXXyN7uVD22E1pk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45732e02-5fa8-4aa4-a7af-08d9e6586b91
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:29:28.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9z585KmR+MPio28F+D/t0w+/uKqVbtEEm9Zrq9zehQi0NgVYS78NfdR86eWvnmcl/NMj6kOWaNMVLBpcYd9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/2/22 4:34 AM, Borislav Petkov wrote:
> That move doesn't look like it's needed anymore, does it?

Ah, yes, we no longer need it. I will be remove it in the next rev.

-Brijesh
