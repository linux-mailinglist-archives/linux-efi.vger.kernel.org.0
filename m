Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A4472FBB
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhLMOtu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 09:49:50 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:13664
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230122AbhLMOtt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Dec 2021 09:49:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8xDitrvnzTwogIKREBEC1d4Ad5OQcsvjLcWMsMsf2doIuURJY7N4Ki6o65Soug/8JRkuhv2671sN730jLk+XgMkYvMLH8tM+RXCXe+5qIXwUhhRih1Ms9B/lLYv8aYM0Anfmxx0n5leO6+UxhCrhw150M6cYjyM7fnSW2CYf3YdM5CXJWFxN0YTaklnWNx5m94tpHjjiBsOV3g7zxUUcLLNbkHXqLBMrWFQd6WQgZSKFWoCbqPPPLDgY2sQGhEh4N5Tz+DCQ1IxvsUrcXk9hKtpLWc1QGoEdO93pL3duKaG9eWmoX2SqWxwF44gu/P9725O2LEwDH+9iCIWTCaRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl8wF20jOLbRpeY8mSXLE+CgszMsGURQOSlkW1YQbMs=;
 b=fprtHLNFhRVxZEq16Q2F8h55eY1QdDHa8B5bdKjvFCCyZM5sZvGoLl8uaqw1YNWarrLnsZSAfeUb8CpZLMSbc6zVq6iwdc7nlEGpgpqV4D5S1m3JdY+krchc5Ar7NYxaOXFOGNqwxapGVX9lJLqGAL/P2a0rXb9nZEhFd2ECt4shYbxF67TW1HUh8+U1/E6BAm2qT5ErXyDJTLc/gD97NyErREk0BBjF80fNz8T1WQwE4YhWcj66ir/NZhNZdNai2XapCxYiK9TgnUIrJoXW9dIwQCwfAzmgKmzKuYfEGHLn1nLHnJdxdYxcAhiB0yaNmrO0dQdoUvRaE3bfKj5q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl8wF20jOLbRpeY8mSXLE+CgszMsGURQOSlkW1YQbMs=;
 b=5bvYK19eqJTPok37O/ZhUbwHgQ+HAAF8WGEmbOhzru52uhkmNrQOhCZQjLKHS/SG2tPFeC5RaV6gmSa00vYenOzh65ji4DhcAAJHbAVzkl5YbBzJRV0aToIq0+HCxppEbunCdXiBvAqEymAEsBSapeoXc6wAHG0qX+r/ZRScfu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:49:46 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:49:46 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 27/40] x86/boot: Add Confidential Computing type to
 setup_data
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-28-brijesh.singh@amd.com>
 <1fdaca61-884a-ac13-fb33-a47db198f050@intel.com>
 <ba485a09-9c35-4115-decc-1b9c25519358@amd.com>
 <2a5cfbd0-865c-2a8b-b70b-f8f64aba5575@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f442ca7f-4530-1443-27eb-206d6ca0e7a4@amd.com>
Date:   Mon, 13 Dec 2021 08:49:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2a5cfbd0-865c-2a8b-b70b-f8f64aba5575@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:208:a8::28) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192afab3-ddd4-457f-4a41-08d9be47ce50
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46712FBD37216E642726CE81E5749@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFwjMqDJ2sK2VAryjfFqJCTiw5szCpXPZnBaaoPPK8kOeBlk9wUISyYFNEjmpA4+2fv6Kj9bptgnCgFVbDlCPVH9qNxDNx4BCQeE1QNZj2xQelsu1Map5TaIPIS8YEdL/QCgiZ/zehgaaJxEM9f4ARaQ7zTzj2WRqD4/aBXD1ZmPYfjFBEFID8thZWUkR/xL66ER4HXOmVZn+nE7P0/wF31i69jFJgzz3F3c0NDBWj1CqFTHkx36P7EJobZP0g5O+IUylXyZkl30VXWIjOwdpakb3DBxfl+RHlVd1ZPttuy+D21P78Ugn+WRAF79fLkInQJjsxnUftROld3RUi3+WoAjr404YDHZvA5DKXN5i7P4Zhn99MEcXK6XaizNCuJpryXx5MVzIp+dUE1KgFr4wLtpjPH1iLo5OpPf38C92S/eUSaxsxJHQRgNnMwb1JMPNVrtOiydHqQT4IGwbjcHu4q/LOs0U8uUm28ayxC3psvaKsCTMODcosex+C9oPV5J/ZsLSKaB2loWopRvZzdnTSsecvs+G2FTHYU5G/6p2po9iXpzdvShbjTb4rCv8wC3v/8TX9pSTQrv0CINIE+YlUzF5BiD/GsZW9kowg++3McB0ZL4W5RdtTP4AUD3l8zo0ETFV71G8uKr6LKeTCvVyezJmQDVRC23rZnIQ86n+SMLzYByGOINo0GRcuXdx8l1yCbXPFCamCY4vqDJNq6r4V0vC+PcgPELN7Krx6ldFE7x5Ujh/xKN02n3v4HxT461jcbNNORuXP6koOqstpi0YsKZhlw/CIpqx8fka/HwnQgdd0UoCcdLZwOYx/FkmRfLbqp4QhCmnYIjc+LYSZZUhS6UyLUeHASP3pBWpC4+TYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(36756003)(8936002)(8676002)(2616005)(7416002)(86362001)(45080400002)(7406005)(6666004)(38100700002)(2906002)(186003)(66476007)(6506007)(53546011)(54906003)(84970400001)(4326008)(66946007)(31686004)(31696002)(26005)(316002)(6486002)(44832011)(966005)(508600001)(5660300002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZRQ0I0L3dDeVkxdWFxY21kNUNlckpseWxWMzhaZG45bUsrZUZ0bzhlREFp?=
 =?utf-8?B?NloxbTdTeEpVdXN4N1I4U3BmR2JieTlHcjRVYVFrWWdHRmpYQ0tmcjhKRUFT?=
 =?utf-8?B?V210Y0xPU3NrMGZ2MjBGbGh3dUZjS3R4TGRheXB5RnM4RURnZ2hYazRNR3hR?=
 =?utf-8?B?b0V1ZGFEREFnOHJqcVpnamo4dGl5SjV4eWg0MHZuaEdYNWdnTFBGWm54RmpL?=
 =?utf-8?B?SHlPZnVmb2R4cFNsYU5TTzZjQzB2ZGs1RXRDaG5RaDlkOGsrSHFodngvTDdl?=
 =?utf-8?B?dkNtYUFKL3gxOEx0V3BHYUhXQ1FwK0MwZTNoa1kxQXczbnN2Y1ZhT1gyN3Zw?=
 =?utf-8?B?dTVaaTFPZ1N4YWlPSkV6OU9HMWRHbHBnRkRxOFA3eVc5cWxIVk1DZFkzTFND?=
 =?utf-8?B?MExaVUI3aVhqbnBoRXNHNnFYSWhsQncwWHBFZEw5eDZRWUtKSE5rdFNobFlp?=
 =?utf-8?B?WU9tcHdPUllQbmpObWs0cVY2R0tZMUg2M3RLSEp2UFRjVktSR3hSVFIrWlVi?=
 =?utf-8?B?elNSSmd3WnNhUTBCS0NSRTYvVmNFWWRqYXN4UDBQNUoxM0dZS3ZQR041TGVr?=
 =?utf-8?B?NWxzR2duZkhNdnB4Um9tYTRBejE1RWlXeFFGR3Y2aEd2bkt0eG9uVXF1cnY1?=
 =?utf-8?B?c0hKbDdNaUt5dmFldlgrQjFFcWpOUCt5b2dYUjB2WURma25Yc1lqdjlWR0Jn?=
 =?utf-8?B?NGgvSzB1TDY1S2t5bUNGbWdDU3pQeHJNRzlrL01nbTI3VWhaUWNwR1dvbjBK?=
 =?utf-8?B?UGtVZ0FNbG1VMEhBbEVhV3o4V1hPeWJxS3kveENkSElsbzNIa1N1UTU2bHJ4?=
 =?utf-8?B?bWFEV3pYODNtcndLaFJQT29meUYwVWZvbk9uN005WFI0c1JRMkN2c3k0emFr?=
 =?utf-8?B?RlU2bTlUalpJQ0t3SWlDdEtLRjlaenhwbVdMOVB1Smw0SDNqdG9XTTZvT0RP?=
 =?utf-8?B?VWwwOWJiQkF1c1NyR3p3UFQ4M2Q5R1YzRk85Q09BZkZCak5rYzVXZHJuUnU0?=
 =?utf-8?B?U2xKU2NhOVg2TUVzcGcxNWhrMmdxQ3hjdW9vdm55OVFrRmozYU1HZHlTRUxR?=
 =?utf-8?B?OHU2T0JNR0pZVXpOaFc1MkJQRCtab1BtdFhwZ2dscElhdk9Dcis4WWtzMkRO?=
 =?utf-8?B?V3pJYTBKU3VPMHJDTUZJdUVQNXJMT3NaTU9hVS9aMjd1LzU3eis2WnVZVnV5?=
 =?utf-8?B?bHh4L1ZUWHNZWG9NVHdCaWxXa1l6RzBCZGE4eVJIaW02YUMzelRoOG1CL2M3?=
 =?utf-8?B?OHJSSEUvV0Q3bkE2ODgvUmZJZ0JYT0hzU2xEb1FzNktNVDFSUEpFQ3ZnbHVo?=
 =?utf-8?B?amZKZ1FwaTBSOUtxZTF1ZUVPQlEvNmQ5ZW81ZWZOYTI3ZlNiOXRxTVZmQnRL?=
 =?utf-8?B?ZHRsZzVWa0JWYWc3aTJwU3AzTnhwa2Vua3hlRTJPZUtoV1Q5T05LUW9ZRk9u?=
 =?utf-8?B?WHB4U3VGeHpzMm9yQ1dONDZ6RGUweXdwK3J3Ymp1NTFVYUIvby9YTGZSTFNW?=
 =?utf-8?B?RDMyUTZhWmlJc1ZYWVBzUGhOZE5XV3pSSnVCUkR1anZLWUVtZkRianRybzIx?=
 =?utf-8?B?ZnI4aWhPZTA5MWNRaVBqRXdHNEdPS0FCNnBGQVdxMWJMMk51aU4rd0RYeXJx?=
 =?utf-8?B?Ky8xZXh0cmxiaEY0amhSeWtDaktIMUlTL0tpbkgrdVdBbXFFVEJXM2xYV20y?=
 =?utf-8?B?THdIZ0VsMGNaRlU1cUdwTGl1UU0yaGtTRUNtYzhmNDJMRk9ZSHk3OWtOeDIw?=
 =?utf-8?B?YlhvM3grN2E4Mzh1WVIza3hONTg4d0RuWFZmM09FTGp6ZGZzM2t6bHhtcHd1?=
 =?utf-8?B?SXlYYit2S1BVbWc3eXdlSXE3Z0tvQmVCTVZhQjFmK2xwM3owZGJBN0JhUkxG?=
 =?utf-8?B?RDB0RVhRcTVSMFJCTDBiSjBJUjlKdXh5VVp1S1cwc3ZSalZ5WWRDNEw2Y0hv?=
 =?utf-8?B?VGNaWWRSMEpUY0hQL3ZxVEtjS00xZTRaZGdBSlRpaExaclcxczVWWWFvY2d6?=
 =?utf-8?B?eGpsbmJrRElrSldMdnR3QUc4VXVoYUZ3UkFoNm9vclZzalZpT3lDVkJ4aVh5?=
 =?utf-8?B?aFpOZFhLSXpEdi9yZi94TjltUTk2V1RWZGJFTjhxbE5uU0tPbHR6cFpDaEtV?=
 =?utf-8?B?K2dISElSYkdESHVxbzlraXBDT0RsUDJSOVlQR0NVOWJRVkx3UEMwNDN4WElN?=
 =?utf-8?Q?NxUxgDQuVrOcwh1TG0iFzvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192afab3-ddd4-457f-4a41-08d9be47ce50
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:49:46.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60abzf4ZEdNS6cpWDQSVOQqcBCq3kwau2SUTVHm5mCAsHezYLAuT60Y+It33mZ1tafNHlrye+Ro85qSuJz5wHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/10/21 2:30 PM, Dave Hansen wrote:
> On 12/10/21 12:18 PM, Brijesh Singh wrote:
>> On 12/10/21 1:12 PM, Dave Hansen wrote:
>>> On 12/10/21 7:43 AM, Brijesh Singh wrote:
>>>> +/* AMD SEV Confidential computing blob structure */
>>>> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
>>>> +struct cc_blob_sev_info {
>>>> +	u32 magic;
>>>> +	u16 version;
>>>> +	u16 reserved;
>>>> +	u64 secrets_phys;
>>>> +	u32 secrets_len;
>>>> +	u64 cpuid_phys;
>>>> +	u32 cpuid_len;
>>>> +};
>>> This is an ABI structure rather than some purely kernel construct, right?
>>
>> This is ABI between the guest BIOS and Guest OS. It is defined in the OVMF.
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftianocore%2Fedk2%2Fblob%2Fmaster%2FOvmfPkg%2FInclude%2FGuid%2FConfidentialComputingSevSnpBlob.h&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C460f6abff7f04e065c9108d9bc1bfcf7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637747650681544593%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=GI1fAngRJ%2Bj4hcM91UutVXlS1F7kfk2xxtG6I%2BL%2FRYc%3D&amp;reserved=0
>>
>> SEV-SNP FW spec does not have it documented; it's up to the guest BIOS
>> on how it wants to communicate the Secrets and CPUID page location to
>> guest OS.
> 
> Well, no matter where it is defined, could we please make it a bit
> easier for folks to find it in the future?
> 

Noted, I will add a comment so that readers can find it easily. 
Additionally, I will create a doc and get it published on 
developer.amd.com/sev so that information is documented outside the 
source code files.

>>> I searched through all of the specs to which you linked in the cover
>>> letter.  I looked for "blob", "guid", the magic and part of the GUID
>>> itself trying to find where this is defined to see if the struct is correct.
>>>
>>> I couldn't find anything.
>>>
>>> Where is the spec for this blob?  How large is it?  Did you mean to
>>> leave a 4-byte hole after secrets_len and before cpuid_phys?
>> Yes, the length is never going to be > 4GB.
> 
> I was more concerned that this structure could change sizes if it were
> compiled on 32-bit versus 64-bit code.  For kernel ABIs, we try not to
> do that.
> 
> Is this somehow OK when talking to firmware?  Or can a 32-bit OS and
> 64-bit firmware never interact?
> 

For SNP, both the firmware and OS need to be 64-bit. IIRC, both the 
Linux and OVMF do not enable the memory encryption for the 32-bit.

thanks
