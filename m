Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD373FCEF8
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhHaVOE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 17:14:04 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:49505
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232930AbhHaVOD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 17:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOEELCKOIl6V0MR4F4vxBZsWnuH+Olf+zuc0JmhtYjPkm+qjPhBSlxWPVh4g/lHvmghecJ/hC8On7uX7VcGzOCIIxAjs3Hamjkg9HdA01236ISwMSxuaIrVF7aqfMiBwQtPVzDkN9wuMIUFCfnllriZ+uXcR8q2fIXqKY0pGSfDoREwxVAME4xXDHbAxToRTzMBgneQzLWV4LICZvUVm+5sIX0RBgeu4w2JwZDsCTx6DvlIsEwopNoFGeDFB5huSbuMXjFMurX+1pyUJVoYb6fp5OvXStSeKoFeAndmiKr+iW0Qs8Vp4IYg1mT//HQZ+2jh7FojtgiAw8HrawCfPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU8hJBDX4WOthZeN8f2Dh8svQETomHdVbUb7J/gTrvw=;
 b=WWRjs6y0JxPWIFsG2EsOr7/Wxl/kmhUPLqcRSogNoHVDPBdB6NOJ/tSb7+MnPXOW1+v/nSdwCxUGqP8u5DFZWjIdxPHedd3wSoajxTZ3IWvmYaT9uwRDnAig1VsMkKKXm/mQiUNsW3ffC1CEzvFNXHLl9fqG++pJPhPoND/3t2MtfHmQeCx45dRO1ylbP2zWY/Fj+VkQzDrecyOK3oIk0C42yNDUxFWohxZXtuROsiIWHiwURyROIcBwCv0SsDkVPy24sQ2jSHQHPaoDCtydYVob4KfDKOspst2nUojaYsLmpdcTOkojbDZ+IDlbBHN74sV9s8Q+vQ0cwDYzP7xkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU8hJBDX4WOthZeN8f2Dh8svQETomHdVbUb7J/gTrvw=;
 b=jrEwGdRQkTWvwDY9D+69ap0A8Rv0GAEEhzVWJEWOvsCfNvfXC53zWu6VumYLQILlmY1JFVuCRQvDS68Q5x7K0aNDLO58fjD+su87FX1UBWfLezsQHD7wKij9Z2CxTkQs5A/H3vdJA4RQhuCW63UhxNh7W/lCdnaJSJP7TMmRHdc=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 21:13:06 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:13:06 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
To:     Dov Murik <dovmurik@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com>
 <f68b77aa-3420-bb6a-712e-bf029bc727d6@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a82bb036-bb55-a1b7-f293-bcc584a77fad@amd.com>
Date:   Tue, 31 Aug 2021 16:13:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <f68b77aa-3420-bb6a-712e-bf029bc727d6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0186.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::11) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 21:13:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316dee23-02a9-4296-fe3c-08d96cc4200d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43657A8DB1215597BBD4EEB5E5CC9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NTQj340VZlwC6EXw6ziqAaGafTF1fd+oJoGbHkc1iRA/JM2E2mBE03u7/8vbQ7rt/umLEX/gDofcfkl3AJhmiWZLDRCeUXXSmO64ZiWADLyGk9LA3rqjoRNbqTvQDsT3rySYLW+0FDJ9hZy17jPxjlJ5oeOO1/rByyeC+7aZyIvqGw9eLzqrB+7t4LP1fyC7Dttd324sHoTlbK9FwBEtua/18ogXdClrwq7wWTlyBE0Uyn4i2LMDrGFHl0TUVj+vuMdBOlHXPXr7Jnm2towfjETpaMF6SBrhgfufwtTLRYXXuPfLg88fC6zOZjy4uZjqOmKM4ciB6dTSOxbYgQMWAcjbMBVgSBsYtxHBe83NaQZKSTW0fzgqjJjR/bB+4ky57UP8A/+Hc2zW9OSYn3tQYeUgxyV4wRfUS35jzIwrq304Nmdm5dXtGDqdwBXh3stQ4oVD2ehPPVyR1YUsbziVb1/EOfiKxhe+oEKQQO1hxNwcSgggyoOiqvZkZ+/8vNUm7HZ5kQG93ZGbuL3g/H4NbjLMS2+963hKPYGXZKmAUn4/ee2ITVFq7OFO4ffAmgaaBfyAQThuKwVTCy0Wfu/C938ej37RN1Ok6CeuLH6MjDoBc/YDjtkJ33jTprI8DKmxdvBhnfEkZAhBUBKcEcG7W6h92119O+LFPo1YosLVVDtcRZtxB8z9kA/OWYrwBP2pBgZxnWl9GVhHBAP9r0f6VS1/KkrpmFexPOQZIL7Fhsk3yauQ/7F4AjDlcQ0nQNU/Z/O/yM/tM1y/GWtauf+gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(7416002)(38350700002)(16576012)(478600001)(36756003)(38100700002)(54906003)(8676002)(86362001)(7406005)(186003)(316002)(5660300002)(31696002)(2906002)(53546011)(6486002)(956004)(4326008)(4744005)(2616005)(66476007)(26005)(66556008)(31686004)(66946007)(44832011)(52116002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdkQkFmRlhBV1FiWmIybnFsSm5DaVc0OFlsRXBxM1doR2NsdU5nWWVsUCt3?=
 =?utf-8?B?Q1FNeENaNlprR01uYnVDcDViNlFpNmY1NFJCc0I5ZU5oTTJNb0lhQ2VKd1Ju?=
 =?utf-8?B?dTNUYVRSVnRFcVNmTDFnK1hnN0k4cjljeWVPMGEzcjdyTExBakpYQUY3SDE4?=
 =?utf-8?B?aGEybTJJakp1cGVtb2N0VFJhY2lYZWtWNVNOZDdDRHI3WTJsWHRsQUNMY1Zh?=
 =?utf-8?B?WXRKYzJaSHFmTVZWeVpwdGUyRGtrdDFlUzhUejlZZjBua3AvWExCQXVzd0Yv?=
 =?utf-8?B?NVBHdThMZVF6a0hwK2FmaERYNWtuM2lHYkhuV0J0KzFxaXZNMjlRYkdSUXBH?=
 =?utf-8?B?d2VkN1crWTY3TG5WMTE3N21xL2JHWjhzS2VNT3FJRXpDU1hJMzBhTFdxbFNZ?=
 =?utf-8?B?Q0gvcFhkd2YxQzFRUDZQclUvMUU0SmZxbFFNbzFVVjBZTFNzekxEMjNJZXNP?=
 =?utf-8?B?dHNxK0NoYjJGU3Z0aTl5YTNGWmYrYVZrVjcyL25KQVFHRzhhSTNNRXpYbU5J?=
 =?utf-8?B?dHFJOTlvWmNSMDZJc0JNWHgySituQ1k4c0FKQUlmeWdKc3JTTmtkYlhST3VH?=
 =?utf-8?B?NytUbW5HTEhvdWhxTGJPbkxGdkx4UVpIbVZRK3MzWkszTUJ0ZXR3ZWo2S3dV?=
 =?utf-8?B?TE5nUVRrS0YxYmJHeDBxWHMwYy9nWXcrOHh0c0VGMFVVYzltRjlQUXhOcDNT?=
 =?utf-8?B?azFsdG5OeHZRenp2bzR1UHNCSTNNcDBBYTBhU3dQdDJ5RzdnYStZL2FMdVVK?=
 =?utf-8?B?cWVobFdVNTRHbzhzd0laVFJrSXJBVUY1RmJpZnk2QTlaMlE5UXV1V215UVlC?=
 =?utf-8?B?RnQ0WDJySERWN0pvaUl4WE42WnpzWS84eUlka3VnNlVVdDhXMXk2N0lzZlY5?=
 =?utf-8?B?U0h0MCt3ckFQeWNJQ3VrdDJOWmt1a2c4dkx4RDhvRjhGWlNpZjBOY3JFRUFq?=
 =?utf-8?B?d2tCRDdEL1lJRmJXYnczWjQ4cFlzUWk0eFN4WTBYaW1OZGNQdzlUMXIvM2Zo?=
 =?utf-8?B?SkpLcXExTzZKeUlRU0lBZVVoZ3R2VG55TW8xdUVUUU95WHJVRy9jekNEK25F?=
 =?utf-8?B?ZWVnZHBkc0dXandFV2F1SFNBeDl3RFV2OXFnekR6dEQ3M1l3cHl2dDhzU29i?=
 =?utf-8?B?QXJuWm0rRjdZMC9PVk5LL3cvSFcyMHlGaytSM0hsWWRlYml1bllzVWhBazU3?=
 =?utf-8?B?anc1dGpWWVRKMmd1TGFnK0VHcHFWbUppSXc0U2xTSU5zUm8vUHY1WFh3YXRG?=
 =?utf-8?B?cTRyd0JXcFVmRlR1b1FIdlQ1dDlRNlFMZUxEaTNZdjRvSGtHa2pGK1RxbERy?=
 =?utf-8?B?cVFpa29ydlVxM1hGNk1QaW13OG1LaTZSTE5mUXo4dDRqTVBKaWZkRHFnSStF?=
 =?utf-8?B?SDd6aTEra1FEWlJjR2lLcG9qWU1ORFZiNndlR2prRHVGSDlhWjdyUHBTU1Rz?=
 =?utf-8?B?REkzSDBWajluTmVFNE1IQklLUkw1T29zS1A5c0o2VEdZOXpGQ1kwTkVHS1pn?=
 =?utf-8?B?WXl0YlcvYkZKcTNnTzNOWkxqZ0hPQmhTNjVYSVBFdUI1WHFaejNIaE1GQzJI?=
 =?utf-8?B?bXFMMmxmMjJNMUl4QzFsVmpkQTVsM3h5aEFyWHBLN1RHNk9KaWFPMVkrTS9S?=
 =?utf-8?B?MkNNRGtjQ2RTS3RPWDdaSDYxVlRoZUxhOUM0aU9oS3dKeGo0SWFCV0gzZEJZ?=
 =?utf-8?B?Y3p1TEY2L2lNZW1uTkVNZ2FFUmttbUc0S1NaL0NnY2x2K1dxb3k1Q0NyODZY?=
 =?utf-8?Q?z5mtAK7mm3sXO0opKYwytPL2gcbg3i8m9k4ozxE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316dee23-02a9-4296-fe3c-08d96cc4200d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:13:05.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cubsy44gkl6hhfLMRecooOxYFJNnhMXxY2fydaK4+5PxYEY7KV4wCoBGJQZc0e9qRXeLevuuN6Ct48qz3yrppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/31/21 3:46 PM, Dov Murik wrote:

>> +
>> +	return count + 1;
> 
> As Borislav noted, you can remove the "if (!count) return 1" because in
> that case (count==0) the "return count+1" will return exactly 1.

Yep, I am working to simplify it based on the Boris feedback. I will 
incorporate the feedback in v6. thanks

