Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9744A9C92
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbiBDP7w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 10:59:52 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:64896
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243078AbiBDP7w (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 10:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdjqhFZQhvKVjghMkAcRfY49gV9fjg934r1d1Sov87I/lIDR4xIGg5w3e9lpETKWfNAMosmCYHPPCPavjwz61QqwBlzl3A6Wc9/Z4SVyixt6Jol0BdBVSCUamdwJIAPJLhfpWKIljjXUxYerIGsSe2g5uYrFzKUIpFzSifbV1yeH7dHkEWYYUZg+I17mRwTg4XxQgP8VBp4b6ck6TDGQ0AUOATWcxcjPyf3TZrQuvtBFrX8RshFKdQle2W8V6R+zlIzzlB7rZXxfo0MYw9Jz+E5oixMEwEltxJ7nLUCzy9y30anjDCBfr103HWo7fFb0B1mbY2IK63fY2F4/tkVqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhcsWRklXaxwxq0pxu5eSd/aj0V8feOqVm/Xf9v+N4Q=;
 b=NjxcZ/303lxulg6LXZWCEm3DKilnzVeb+0Vy7eslUPtAWrLaUuNzTYCJG6t769yY+hnaAVw2Zsq/bTFf12dqeTve8+sL2ONQqzfcTpoWhQCbpydHrLsQO5DKuE+SAL9UJkGj55Bj0a8NOyrydpcf8SSGUCdHDKIl4hw/dDkJawzjaDwyy2HVvgCL9+ejLQm+18+7ReUzvpcaqLn1OE51/FaburkmqK3bqx788hpIbZMZ4XS16NNFkDCFzyUM45p+iOJnBWJfFXNvlVF+32tbftYh7huAZfBAk/u5sIwkVCraMrgXC9RBJ8v1SE8DLPkwi+C3gSlCqhmK1MaINHpZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhcsWRklXaxwxq0pxu5eSd/aj0V8feOqVm/Xf9v+N4Q=;
 b=FI+y8frsZEsFAFYmBm+zuCH31PjGOzDjyT3eE6h42lyAY6k97LY3hWOyZovjv7AOEKU1fj/CEw3pVtHIgv9H7nR9rc7dYNnGuhDrcETOwxyum7FPbSm27SAIQog3El9s4L8X9qy5yinAoo+c8kkKCmd40o0x1Ililia+YsczR8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 15:59:49 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13%7]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 15:59:49 +0000
Message-ID: <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
Date:   Fri, 4 Feb 2022 09:59:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Content-Language: en-US
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e20ead-b041-476e-a16b-08d9e7f75f25
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3708C075414FBA725069A2DEEC299@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeQhA1gHR04Kbdp8dwtlaDjAMOjRj8lWjSzxYhppNJvWt07YYAZ3elQKJf1IGOZ5PZodYxtZCNEyfdM0XYEaMZwqJdH7SWwdcd/wcb41nyVbfr3KbApAv1LaK3S1QmlzVdL63m/GMBM2FcY/QCjPkuc4+I+oH4KBNNvMiTAU4pO3esELItSjP2flgigSa3lOCymXMVxx0jyOF1u8as2lcFRGl0DnUL+yr5S5mlr//PyReQ7L9O/HlcTmAYiDCcAj/WJNDJhs9eiezxLhptMBHmDvNbelgWjOwpqcpOMGKD+aCxdPosda7jQZmcitXB23LRM+BvS90Loty16cKkdPeX2tBgrmhOh/HCQtoQZyDGX2AyECE4IIaqTjuH0DLtFQ6npVrzMZNWA90qEMfGgky3NfkosNMXTYl2pOH85pB88xchAT4MT9Ry19is5yWtUs8E4Sp6QmJn1rxj9i054Q7llTHOjosJV0Rbuz43iPZMipnci0Y+GwzM8QkJ8ho7CRoSQrWja27AMsv+666mUUytF6lB7r8IQW8I4LTwcFwXS4+Uq8N0KITJjKupAjBb3shxXv2Lzb/1XZQIQYS5YDRJlGpkgIHjE7Lh6wbU4uRp/7vu5RDN7OBUDYcbINLJyTFs4gwaXzC9fAsvK2o5amlKtVM7Rp8APkfmtVZAz9lRFD4ADNYmW6AzbfJ3OlidhLGQKEWCmdkF7MNMxSMzQ20Q4ractFyVnS9Ij07gRW13YJ+Djb/nMtXwhT8miKWy6ZTHD3uMTk6ZYjomml9J5LZ+n40JZcDaIcjQSiZvaj4Q3EsSWJZWGaeps7hdxUQKGUp/J2TZQkB363FRbdNKVThg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(7416002)(31696002)(66946007)(2906002)(6636002)(6666004)(36756003)(966005)(6486002)(508600001)(31686004)(38100700002)(26005)(186003)(110136005)(6512007)(53546011)(6506007)(86362001)(2616005)(316002)(8936002)(8676002)(4326008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9GcTZrTi9aUUgwcDNSQUVDMExtWWt5ZHBTNkhHeEl4ZjU5M3dVcDNua3RX?=
 =?utf-8?B?YmUyRmVrZGZWbkIzVnFpRHludmNNVmNPZTNubWR6RGNRVWxwTDFZdFMvM2ky?=
 =?utf-8?B?cGhSNWlkVW5SRmVsbElLcmxSNTJsRTdRWDA1SmRSTkp0dXNVNlJWTDRXaVFl?=
 =?utf-8?B?OWpsUEVLaDg1WGxlbExZQ2hGY0podkJtMlpVdjdNRnIzSHRRQjIxcE4reGVU?=
 =?utf-8?B?OFkwT3YvRFVTTTJmTkwrTFRCNTQzRU56OW5vcUY1eEVFcWNJclpFSmZKbUxl?=
 =?utf-8?B?RC8vRFFPQXl1RjFHSEdGR2Vmb3cvR1dFaWVxZ1d6ekRZTEtlOVZiRVExL2h0?=
 =?utf-8?B?UTM0NDJ2eVhwbmJoZlFlSy92NWQ4VnIxK0VCYWNXTmt2SVZPeW9pUEdRVDVD?=
 =?utf-8?B?VmFTcnN4U3FUMXJVSjZ6MFJCbXA4YmE1ckpXdzVwYXlkOGR3Q1VnRmZWS0c1?=
 =?utf-8?B?L3JzQ3Z6Qk9NanEzSURkdll0Q0s1S1djejFXR0xpMkRld0Q3dUFvbVpUSnJh?=
 =?utf-8?B?eEl6bDkvRzV1d091NWU4QnlKMTBtYVJVeGNkRW9EY3NneEZEb0FkK3dTSE13?=
 =?utf-8?B?dGFTblpUb0NVWm9vNjhSdkhnVXhVT1Q4ZkJQS1hGUGVhcThiWGVNYTFTUTFK?=
 =?utf-8?B?WHlSUHlzWldnVTVKd0VGUWI0bHExdTR3U2YxUG9DTWZ2eTh4WTBrSlJZTFFo?=
 =?utf-8?B?b0xaMkZqLzV3NzdjVGVteDdNd1ZEeFNxMm1tNXN3YkZJUEQ0a2NJazhhelk3?=
 =?utf-8?B?L1dvckV1ZjZhWW4zUDJOVDU5T2ozOWU2Z255cW1BbW42eVNrUUlLaG5oWWRP?=
 =?utf-8?B?WG9PREZtd0VCbFhEdFdPcEpXbG1SZ05sQTZQNlFCclV1UE1FMVB2ejYrYUh3?=
 =?utf-8?B?eTZKeG1rcVpkejFWYVl5cFk4UmZ1dllrTkVuVzc3YUk3bzZSZTdLTGhKeklm?=
 =?utf-8?B?OXpUNVMzaDdYWFlhQ3lBaFNFYi85M1gzSzZYY3E3bnBuQTBLcVJha1kycWpa?=
 =?utf-8?B?eFdNelkwRFV1VS93U1lNSW56WmV3MkNabktRSkg2UUhtY1B1MVBCVGRMbFIw?=
 =?utf-8?B?YnpKaytUU0w4dTZuSDJGV2xicERmM0VrMEFWcS9VZkpBNHRHeDQ5RkFFb3Vy?=
 =?utf-8?B?djdNZllad0wwcHVyeTlUVlgyVm9hZVMwQWlqOUFCSUNzYlEralYzYmdsUk1r?=
 =?utf-8?B?bW9QRUk5ZWhxRmdkWmY0Y1ZUSHRGVmd3S256Kzl4dmdxaDFJR0d2emxYQ2JV?=
 =?utf-8?B?V2VwZDRZaTZHeWdJRXB4QmMyM3R6U2VyVjBNL1Z4Zm01STVicEs4ejkrNGtY?=
 =?utf-8?B?UFlvc3RlZFVpL2lRUUJ1MWtnYVZmVXVTdWh2Z2ZhOEpoU0ZxZzFvQU84UmEw?=
 =?utf-8?B?aDVlU2dCMXM2UUszK2JEQzJteG9kUG9hRlZ5MnhIWC9ZdXZ5TDREWm5qK0M3?=
 =?utf-8?B?NktOaUZTZkFXWUhXcThrb0xJVHZsN0xCSHY4OG83T3JEV3huSXFEZXhvN3M3?=
 =?utf-8?B?R0xFeWhOczJIcnZscUk0Vk1NaS9McWlvcDRwNFJNbmM5RHFlNEtUV2NCL051?=
 =?utf-8?B?TlJEOFovZ2d1U3VsQTVHWG4veURZdFNXUzlReThhQ0ZqeTlGV0NobUNtL3Bx?=
 =?utf-8?B?RW1TTXBmMXlIVWpiT29idUl6QzNvRVZkcTlCOGpKZE00MXpqdUdiUUY3NGc3?=
 =?utf-8?B?aWFOanFqZkRZUEtlMmhRWnEvVkIrNkdlcmFpOHZFcHoxVldRREFqb0Y3YzFk?=
 =?utf-8?B?Ylh3K21HbElueUsvd2lTTElRRUxSU1cxR1ZDUjd4UlpFT0xVZy9XUWhRbkgw?=
 =?utf-8?B?NHlKNFMxQlRjMUxrekFBNEFBekJjdWJObStQekhic09TdUN6N0hSbFEwNEFI?=
 =?utf-8?B?YUFPOHMwb2JMbHZydC9sTmpmdXdjVU8xMjlRUktoUXlpb29VcThjWlJMMzFB?=
 =?utf-8?B?R2dEbWxRUVpHcFZoUWFxbjVqSlRuUXNlT2ptZHVQRGYvbi8zT2h2ZUFMTjZW?=
 =?utf-8?B?cWhlVjhTUXhCd2ZaYnZaRTBEWFJ1RGpBRzNVZEE0LzJUVUVhZzZuazlVeEV0?=
 =?utf-8?B?ZnhDM0MzRnpBYy9WbjlUa2Zmc3RrMjhDYkNkcS9lMktNVUpjcXVkZlhCZzZh?=
 =?utf-8?B?eG9aOEd4MEUzaUdjZTcvV0NINUcyeWdhbGFLZDF2WE5BUGhWb0lnZnk2c2lL?=
 =?utf-8?Q?Mg2BfGWpnYIOPmacf3K/w6w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e20ead-b041-476e-a16b-08d9e7f75f25
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 15:59:49.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLwjjlnCPto7JMdh7O6pns+6DRl/YixKceyFcW+FchMBhi/kOixdgXyfrczk6Vwb0elQPgF23wy9pzDECh1uuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/22 07:21, Martin Fernandez wrote:
> On 2/4/22, Limonciello, Mario <mario.limonciello@amd.com> wrote:
>> On 2/3/2022 10:43, Martin Fernandez wrote:
>>> +static ssize_t crypto_capable_show(struct device *dev,
>>> +				   struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct pglist_data *pgdat = NODE_DATA(dev->id);
>>> +
>>> +	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
>>
>> As there is interest in seeing these capabilities from userspace, it
>> seems like a logical time to also expose a `crypto_active` attribute.
> 
> I planned to do something similar to this, but to show (or actually
> hide if inactive) tme in cpuinfo, just as Borislav Petkov suggested a
> few versions back.
> 
> https://lore.kernel.org/linux-efi/YXrnkxgdjWbcPlJA@zn.tnic/
> 
>> Then userspace can make a judgement call if the system supports crypto
>> memory (`crypto_capable`) and then also whether or not it's been turned
>> on (`crypto_active`).
>>
>> `crypto_active` could be detected with some existing support in the
>> kernel of `mem_encrypt_active()`.  This will then work for a variety of
>> architectures too that offer `mem_encrypt_active()`.
> 
> I need a hand with this, I grepped for mem_encrypt_active and nothing
> showed up...

The mem_encrypt_active() function has been replaced by 
cc_platform_has(CC_ATTR_MEM_ENCRYPT).

> 
>> As it stands today the only reliable way to tell from userspace (at
>> least for AMD's x86 implementation) is by grepping the system log for
>> the line "AMD Memory Encryption Features active".
> 
> Isn't enough to grep for sme/sev in cpuinfo?

No, it's not enough. Cpuinfo shows a processors capabilities and not 
necessarily whether that capability is being used.

Thanks,
Tom
