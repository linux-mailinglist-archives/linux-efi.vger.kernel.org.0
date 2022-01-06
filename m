Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A405486A4B
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 20:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbiAFTGW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 14:06:22 -0500
Received: from mail-dm6nam08on2067.outbound.protection.outlook.com ([40.107.102.67]:13920
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243164AbiAFTGT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Jan 2022 14:06:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ayi+GOFFbrVsOrf+CIK9h8JjGg5KhyDm59JzjjAnN7NUVbqF8TX5qLc/5lkqbCfQ9exTig9D1M628bgm0BHXbdjrc+9HkKTw7/Ib0/7B0YmdxHSQjrR8kdrknb0Ed1+a+kw92Zpepdi5h04fABQhfkN8tKNoRMNGQUvu5XBkOFv08zllJfey7JrCUmuLsI4bEmywZw7ODkhFdokqVaEBQOwNTb8gRBOR0fDyXHnx0b4AKgDc1w3gWSWLpqIupsNlv7ZRKgpJjL2d1SUGVAghtfKJ7O9JHIi9bazRk7XYbtcz2uACma0PKDZRIBr+5ulurGlzDh/gwYDPfspTAZn7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QGms3cmUNrPLlWzLscxRS2YM0ZwWB3JdMk4Vgiv3x0=;
 b=ZjW06HgLGInZJZE7/qrJG33OXiaCSfq/I9XdPFmnUKNvNu1eaVyqBx2j3J+MsnXOwZXgviMWQ8E9owkY4ZW+KWAjKxXF5H+O7wXhn5VM9DLjl4MsREMbMY6kCMmd4HIcfU93oCzaQt7VmLkWrtsQ5VTaeAgcgMPrUGD0b9sn9B/QzWP95OMz4ee4TtZPAMxPeqQcnIIa/5Q34i7KArhvzVI/+hgGEWjvDJCl9edM8QBufeJ7WP0mahl/sw93EbhRn3DS7WUFeKW+fW298aT5dIDW6fZ/sDQ3EkyHNCzXpAm02pagUcBt+mLgE/Wy5s3ns/wryYlNnMJxPxEcjTLu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QGms3cmUNrPLlWzLscxRS2YM0ZwWB3JdMk4Vgiv3x0=;
 b=VOeu8qwhXrZvvCMgD8L66yD8UsifoxbYB0qxFtwhD0w2Xdj1d7qc9UHaS5ERYOyVfBp9Xh3JCFEklo6JzOUwWTi3cVUqZtTzz5IU5spXbLWtlVFY5mhBVBY0EedaiIBz1FlbZOnH6GyZWZAh5eAeFXBlfMM1lbU1WV7/mufkqRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 19:06:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 19:06:17 +0000
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
To:     Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com> <YdSKQKSTS83cRzGZ@dt>
 <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
 <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
 <444b6c78-c4d3-f49c-6579-bd28ae32ca3c@amd.com> <YdcpnHrRoJJFWWel@dt>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <bf226dc6-4aef-b7c2-342d-0167362272ea@amd.com>
Date:   Thu, 6 Jan 2022 13:06:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdcpnHrRoJJFWWel@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:610:11a::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a88149d-c968-464d-1ad4-08d9d1479dbb
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5549CDBB705408B846D70C6DEC4C9@DM6PR12MB5549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGF51/lZ3fvCP1+VexDAEpd0QBHcIdZZVjk5f/M4tG7tft/1KQMsJSI9vyUEzdGT9/2GocdSGv3Gjdh9wb3GV2w8LupwvKszO0ouhBglymrdPAAQqW+ZFalzrRQnSZJ3KO4UxhRS+Vq3pa8c9J0q06Li8Bxm4IQiprWzIuKewAAkN9lIjYk2S+yB96ofYq3u//Px841q3gguLjYVHmQcDXkrBh6MQG483c2VdRhveA6e6WmCP5Qf67oqO86FdiVnHlKLrQmq7dTYs8UNMU9LVL/M5+TgzFPztPdqhB92XNUMR8dzAlaHdqXijkcezXJSgPrs8XxOkr80oB+Qv9/bT75+4XRN/oFEi/D1VevwYDVhbb4gwQQSMA/UWB6AlOpUBP4f9xZosjER6OMnUGf6dewcDvVbxkzLX7O7oFY+kXv9/n+W5s1lhtnYY+ZbEgeLjLe9ycSBurKlpyy84nRzTOCLja28ZuL++4OnHX4+t6XzPKI1VXIMmXoW1b4UEFAPj7CzZfdCTG4dx9JcyHID3aOFiNZwUzBiSIES6e5nzbHcBblmzPOcgXs9+qjoTs7RkT4nhxhqZwKqNkuQo0Tis7Uv0nDXkcxaqXrUfD3eVk/iIMhwl6vq+6esdu+tgyh/WdVCvqp8uVmxVive4vxgGr175BtnnAV70ESe9j01hK2GnPzFOPvwagUBRa1jc0fqbibl2w5DQKDm/v3M4AkCe+iSzyyYquOKdbrYo7pCSd3IrtD8Apq5tpI8UNPtnZV/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6636002)(6666004)(66946007)(66476007)(66556008)(54906003)(8676002)(8936002)(2906002)(316002)(31696002)(2616005)(53546011)(110136005)(6506007)(26005)(5660300002)(7406005)(86362001)(7416002)(83380400001)(4326008)(508600001)(36756003)(31686004)(6512007)(6486002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU52M2VzWDBRdXJjVWlHdlVGTmlOR3FJb29MM29lODBJbXpFOHVka2ZwMi8x?=
 =?utf-8?B?dlJBaDBVYWdXK2crZTJ1c2FWMUM1OVE4M05NL2ptWk1lN3RyVnB6cStpWHFT?=
 =?utf-8?B?THVBbVVsWUh1TEVaWlJ6L3RxQnNxK2JuWWU5RnZ5VG5iWjU0dGliODE0NTBk?=
 =?utf-8?B?UmVGUDJVWmhvWXdvbGVuVU5wQ0pqVVhtU3VjYStGWG9ZZURuZVQ3c05XMUVH?=
 =?utf-8?B?TWJ3Z2hua0ZrZ2NpWFJlUng2SHFJa0t6Tm92eitEQm41ZXZvd0lnb0VkM1Fl?=
 =?utf-8?B?Vmg4eXJRZUptLzNZbFAxazBYQ1F5ZVdJM0Vmb3RsZXlNQ2IyVk1JVVFKanZq?=
 =?utf-8?B?ejJWdTZMY3ZaT2kzSk9BYWtHejBrWnhpZjJjMVQ4eUVRRG9pamV4ZHovZm1H?=
 =?utf-8?B?NS9RYlRXUkRidm4rL1NnTlVGMUo5Ti9JZmRKbXJqWmc1aDFSdGM2bG9mY2Fx?=
 =?utf-8?B?dnM4QUZLcmRUSXpHTzhlWHpzMHNuc1hRdFUxdTdUcGM1Uktib1RkVUJzeEQy?=
 =?utf-8?B?RUZCY3M4cytHN2x5c2ZqdUVkQlpPQkQ4b0N3ejFyN1VZMlhkSGZlZjRhZTEw?=
 =?utf-8?B?T1h4UkJ1YThoR2U2M3VCQ2dnbHJkWHNXRHBHWGdybGVpOUtFMjJZRU9UaEZK?=
 =?utf-8?B?UzJFQ3o3QzR0alNTd05yQ2kxMlZ6dyt0eXVrU3Bsdjk4R0VQUmEyZTI2bXlw?=
 =?utf-8?B?UTM0NVRxQVVUcGpJYkU0UkJWTFdiWGFoRGVGRGtRV1lLNXpyY1pPTEF1Y1Za?=
 =?utf-8?B?dDVTeXJnamlnY1gwL2JzMlVHTWFFaEE1alY0U0VmMzVraXlGTnF2OFIxeGtN?=
 =?utf-8?B?VDNlSUhUa3pFZ0lxODk2RVNXM01ZSXBmYWN6SWtidGg0ZnE1UmFoYlFpWlRo?=
 =?utf-8?B?Umc2Qmx0RzdZWXFBY3o0NXY5TkpJMnhOWEsreHN4dFc1M0hKM3FIMDVRMUh3?=
 =?utf-8?B?OG9haHUrY2N2b2lyNW1EdzFKcHgxK1hsanFWK0FTdDFNem5GclRkRTVHblNZ?=
 =?utf-8?B?WlAyYUd4d3p6d0xZMkp0cFE1TXFNb1cxL29XY0MxeCtwYXNuVWpIcTNuU1VB?=
 =?utf-8?B?a2U0QU1KNnlSZi81cXJzWW1OUE1SdUlBdEZrbjl1b1pLSHM0Z2ZybElzaVVY?=
 =?utf-8?B?VERDU0gzSGcrNThSbTJES09sdGlDVDVCR1lzRDEvdldXQm4yWDNPOFFVdWY3?=
 =?utf-8?B?eHgvTVRrOFhySEZzalkyT2lxMHc2RWE4MmxnU1oxN3oyU0RBd2JsdmFkSDV6?=
 =?utf-8?B?WVVyRmxRZWYxcFd5cU5MWnN4NzROckMrcGpqeFk5elNYMFFqVVdEaEJFWGI2?=
 =?utf-8?B?S2VidmNDamIwSHBMcmo1WDMwYVRhK09nUmpHY1graXR3RVVlSjVNdDZZa0ta?=
 =?utf-8?B?TkxWTGZ0eUJsZFYzSnlaaHBGc0IzajZtVFB5bFo2eW15bVlsMnRrb3NMckZQ?=
 =?utf-8?B?TzJ5R09HYlN1NzdhMGVvZjZJQXEwZGJKMHVPVjl1TUFhN1VTTThmTlhRbFI0?=
 =?utf-8?B?cG5CeWN4Q2VXMGdEUTBHOUtEaEQ4dnJMNlIwa0x6djVvNUhtK2xtQ3pEUU96?=
 =?utf-8?B?VFNyQ2RSdWdRNWtUQW5YWEl0VGpwVzIrTWpEVXF0eExkSGQ5ZmlTclRtd0Z6?=
 =?utf-8?B?VGxZTWRiV2VxL3FWZGFZc2c4NG5iY3lLOCtBQUxtTnhwTjI3MEl4VWs5ZFp1?=
 =?utf-8?B?ODF2cnV5Umcvdkk4VlpHajlWc1Raa1FrcGdacE9icm13Rlp1N1l1bU1SS09U?=
 =?utf-8?B?Nm9RQzBmRklEc2FUbTFZeFdnMVl1WE1IcVVHTnZZaUd5bStyM1RqWnNCZjdH?=
 =?utf-8?B?S093V2l1bk01NncrOFZzY25WUm10Y2FxdWFNaFBVWWRudjc0YjRmSWFjZ1hQ?=
 =?utf-8?B?Q3R6L0ZGSlc0T1drR01Hc2dLWG05eUoxSkt3dHdUNGczN3drRTFFRmRscml4?=
 =?utf-8?B?MjRnYW5rVDY3N1pFMnVQOC9udWEyTHppYTE3QU0yV1F2YUhDNTRWcEkxSDJB?=
 =?utf-8?B?N3gvS3NxYTl0aVdkS1ZYTDM5SWU1MS8vY2RrZWhGVHIwZVFzaWpwSjZOT1Iz?=
 =?utf-8?B?SHkwVnVGbGtNS1pNOE9zU3RsNS9NanRoSnBIR2hiMFBhS0lDK0E1RHUwV2lr?=
 =?utf-8?B?R3kyejlzNEJsRzFiYjZVSGVWNlFQdi8rZU5QakU1cjAzUlpiM0ZBZENOOWh2?=
 =?utf-8?Q?a7rv7SBes/SkpprR3GAOnz8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a88149d-c968-464d-1ad4-08d9d1479dbb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 19:06:17.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQd+F8wxG5aJ1Rs4hbd4bsaHUaD+rO04ASkGy4d2nMIiakbig+gEhdGQxT4MtfaBaQdsvAM3XkxjYkZtne34Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5549
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/6/22 11:40 AM, Venu Busireddy wrote:
> On 2022-01-05 15:39:22 -0600, Brijesh Singh wrote:
>>
>>
>> On 1/5/22 2:27 PM, Dave Hansen wrote:
>>> On 1/5/22 11:52, Brijesh Singh wrote:
>>>>>>            for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>>>>>> +            /*
>>>>>> +             * When SEV-SNP is active then transition the
>>>>>> page to shared in the RMP
>>>>>> +             * table so that it is consistent with the page
>>>>>> table attribute change.
>>>>>> +             */
>>>>>> +            early_snp_set_memory_shared(__pa(vaddr),
>>>>>> __pa(vaddr), PTRS_PER_PMD);
>>>>>
>>>>> Shouldn't the first argument be vaddr as below?
>>>>
>>>> Nope, sme_postprocess_startup() is called while we are fixing the
>>>> initial page table and running with identity mapping (so va == pa).
>>>
>>> I'm not sure I've ever seen a line of code that wanted a comment so badly.
>>
>> The early_snp_set_memory_shared() call the PVALIDATE instruction to clear
>> the validated bit from the BSS region. The PVALIDATE instruction needs a
>> virtual address, so we need to use the identity mapped virtual address so
>> that PVALIDATE can clear the validated bit. I will add more comments to
>> clarify it.
> 
> Looking forward to see your final comments explaining this. I can't
> still follow why, when PVALIDATE needs the virtual address, we are doing
> a __pa() on the vaddr.

It's because of the phase of booting that the kernel is in. At this point, 
the kernel is running in identity mapped mode (VA == PA). The 
__start_bss_decrypted address is a regular kernel address, e.g. for the 
kernel I'm on it is 0xffffffffa7600000. Since the PVALIDATE instruction 
requires a valid virtual address, the code needs to perform a __pa() 
against __start_bss_decrypted to get the identity mapped virtual address 
that is currently in place.

It is not until the .Ljump_to_C_code label in head_64.S that the 
addressing switches from identity mapped to kernel addresses.

Thanks,
Tom

> 
> Venu
> 
