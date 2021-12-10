Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1194470BC0
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbhLJUWh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 15:22:37 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:9665
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242712AbhLJUWd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 15:22:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM+ZycDcauWgEMhmgzp4tA//W8U2YONQfRrFhNw+mIny1O+7hsHUTFFUU+e1PiPIx+sSIGX/sm2ct28Gf/6Sc7E1B6tFFQZPhBU9eCdaMzsf6625rtQ6y2miTvm6UhOd/zZhgBrHOYBcV1404x0PPVagsnXAAQvMxWtsiRosLkBEGB2/MlihmTB+vxHssvYwjvMCRR+5+zD/QJqH5TE+e51XpvYu2NGUg+Y25Yfk/xpWFqCx9Ghch/7jVwvuKtlCrPn6CdMBrLPbHqgwddCfndPbaaxnLb5cuFAJ0R3VyJvh9hXxxBn9IyqKukgihetpBS8NKRoPbR+Zyc1xE97MAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxm0NivbsQYJeV0vhWp5M5uJ5UJ1cjtRo9GeDEUUp+k=;
 b=cTyQr8o+s1Gxmg6JawA1aLMNYKKrTN1w5hLqFwsiyJh/H6V/SszRt5TAuhQNNf3Tcp3A+YBDp5rSwF7THxDlQG1ii5c7zbT299OBTysLE8ne99TDQ8+ivSQJ+TH20siO4UnU1E12GLQ9Y2NSzsUbHVysinQJDGGsRinCYpx1h7fg9NbhE37dJ971UrNAJ+RUApSQhjrIvlgSrif+Nq+dymDky4glj1kZAQ1BUJJ8RRTnhzfa9woBSCYriLTF6VIcmAKY4Qe734sYqj0IMA7cGQLJI/zAEMCaqxTMzAHzYD/a3EitNIpFGS/h1j0/bsq81hl7+4HV8yy+SH+2ytvr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxm0NivbsQYJeV0vhWp5M5uJ5UJ1cjtRo9GeDEUUp+k=;
 b=I79hejp+zcN4lHFMc45ZbqsbTJkV0aHxXACueBh0n7erWwzzEtxcICqAEo11RJz/t8EJewaHX5VY4xlbuts2cxWPxwDss7mDaQwrInU92RiFZTQdQyt2KyvEyoc16Aqbb3vK0ABVGzpIDDXGDwMHbuiXeiHwtMwTuGVHBz4VSRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 20:18:54 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 20:18:54 +0000
Message-ID: <ba485a09-9c35-4115-decc-1b9c25519358@amd.com>
Date:   Fri, 10 Dec 2021 14:18:49 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
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
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-28-brijesh.singh@amd.com>
 <1fdaca61-884a-ac13-fb33-a47db198f050@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <1fdaca61-884a-ac13-fb33-a47db198f050@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:806:6f::19) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.0.0.6] (70.112.153.56) by SA0PR12CA0014.namprd12.prod.outlook.com (2603:10b6:806:6f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Fri, 10 Dec 2021 20:18:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cb7890a-6dfd-408e-91da-08d9bc1a4962
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640CBE6B46A0E01B0C2787EE5719@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUW3qQwwm/KARPJRkLyGGMGE2YDvytp/WabWNWyxZyjmYjAcugwpBFvy34Xb+BUU6YcqwkGPSDBF2WWdshazgx2RoR+VczHLwwgfyaRHd5DZQMrKwMlOb61DpOXMHScctNU9rggMK4GmOvikpPpXB3k/UinhQJtc8+JBnvIFi9qcr1CEUljNvJhC2LJyu3vEojXP+x0td6NjHcJV3iArTdmvF8IrN3xB5UzjaiasNXoZbR6lJwK17scXvIJQUsV9GdAGYbA/X6RkPuR0kiW9VelLNuFKTpDJYQ4HVJiaR1XHZhxkU636ZD0Khd5pttoMLP2e3BP8sRWhJSpgSj6qcUJ6xDhFKiw7Ie9ZLvMR5+j9Z0yRDKc6+QXWvXrRRqTmdV7NlAjWJTxO7KLcPwouF0Hmk52oikaPC9ydFTmu+GZYVKl1L/yFeIxrkvEOCVjQtBgiHHz1ERvlELW3Vw7oAnnIG9IN34lHFsCTA4pDRyiG1rFmCpTa9Jqnw7w+me3upwfp1aYoE2aLqkzXiCjKGag9kh5gO1jW3bO20JJIsFEvNYaYvuYXR+k/kOVddGS4tLjjePRazOWCNddEyymimcfpljjQt16+NJx0gS4wFU2czX/ys2erWiH5MVwBaOpzJo/FuR8JgiNMEHk1ANwX2Ojkt0cHqhxVC26Qo/eP9rbSkq1OtA+FeoK3EpEhh8Qxb8c76CaV9HdvDxyOkLrLwOTphx01F9rZhCO/eIwBuSMDjoJaUG6VKfmPoFDSwUtTXxE4412OpJLy4Q/XLJd6zoBRDI7UsyRQGYNbh5zlnUjDgRG478USBceZrrn2/0YW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(5660300002)(54906003)(966005)(508600001)(4326008)(316002)(8676002)(6486002)(66946007)(16576012)(31686004)(66556008)(66476007)(26005)(7406005)(7416002)(31696002)(2616005)(53546011)(186003)(44832011)(38100700002)(956004)(2906002)(8936002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGF0MGRDQjFIRTJYeEFOSnB0dHRnc0QxNDlBZzZEbUQ5TzhaRDdDRllqVURs?=
 =?utf-8?B?YTdTV3V4T2I5bFd3a01uWk5hemJWV0xEWGlVODJHdy93ZWhSNjdZZFdBUlcw?=
 =?utf-8?B?K1NvYmRsWEFaS3R5OEVNZWVkZkE2T0F4UWMzMnlNMHl0Qzl6OVB2L3RNR1Fv?=
 =?utf-8?B?ZXVhaVBtaGh0RlhhTUFyMVgyNTg2ZU8rZjE1ck9LYTE0MFV6cFZjby9mVG0y?=
 =?utf-8?B?U0NWaHFWN2NyNk1aS3NsZUpvb3NNZ0sxT0lQek9aUElzblQycUI0ZmNneEM1?=
 =?utf-8?B?OHBJTEpVL2RuaUZPZ1UxQ1UwdzU1UVBweUpLZnAreFVWdDdrcTFuTFh0b3Y0?=
 =?utf-8?B?Q1U3UDJHRyt2eGIvdEZEWjZHOFEyUXFYaDJOOTFsZGtFWmpmTUc1M09TRGRW?=
 =?utf-8?B?R1EweDVOZTJCTkk3MzRWZEw0dWpHZG82eVNvaDErRmZRTlNBWXY5TkNxN2hV?=
 =?utf-8?B?RDdheUFIbXFkc3hwZ3lLeHpPN3VsbjFHK0pPNmFjajRXV3EwZVdodUpZNjla?=
 =?utf-8?B?dmc0cEw2UHpLaUdvNVNwdjRzK2ZmazhwU1JvVU10S2JTZUlnSFUybi9FYmdW?=
 =?utf-8?B?SU8wcVJpdlJEeXFHS2o3UlR5MmhMVmxMT2pUUzh0OUp5UGgwNkpJR2s3UkJY?=
 =?utf-8?B?bTdyaGRUUFh1WFd5blZtTVhQQjB0TEIwbWhGcWtpc0NJQzVlanZYbHNYL3dK?=
 =?utf-8?B?UEhSejZJN0FDa2dBZytRNXI3L0wvTFRmWDluOWsxMEJUbzR6WWgwbzFqWGtW?=
 =?utf-8?B?SWd5VWZCeHJseFRQTHF0SUU4YUlCYmljamcvUmNkRHNoNTFxeDgrd1ZycFNy?=
 =?utf-8?B?RVFJOXdBRzFvTnRCQURvZkpJUFMzNzBTQTI0NFl2VnV0R2JxN0owczkxVWVE?=
 =?utf-8?B?M0gwOThyTWc2c1ZmRUthdXErazRqTDJWbUZwa1hSOU82YmNpVkp3Mm4xb2hC?=
 =?utf-8?B?ckkwYjJucDF2Qkp6MDVjS0kzdWpDd1dLZmtpdERrUTBvZS9SWkZESkxBdVBj?=
 =?utf-8?B?TUhnSm03Y0VFV2ZTRVhJVEd3RVhQbGJBS3NDUWZROFVDZGJMUzQ3WFY0aDZw?=
 =?utf-8?B?Y2tNWGp6RHVEYk5UbjFWSW9pdlNUTXNyVmR2N0hYeStRblJYVE9BckE0ZUFM?=
 =?utf-8?B?bnBCMU4xRTk4cENKM3NWdGQyOG9XMlZnSll4WkowYmtxdmZQalU5ZlhlV1B2?=
 =?utf-8?B?T21DU04zeHJvWURPRVlvdlZ1YXVyU0dBTjlZMFBqWlFEUXNCd040bi9MODl4?=
 =?utf-8?B?MDVhVHVZVENOOUh2UTlZS0hCS0djL3NFQzh4R1ZPdzhzdE1qNyt1THJ6cGp4?=
 =?utf-8?B?YmtFMEpWc1AwbnluUDM4bGI2Mmlpb0RXRnhrbU12c1UwMnNxcW1ZUERjcGtm?=
 =?utf-8?B?RkNHYVF6NjZGaUdGS0dKWCtOWEdRaytiTkFINGRiZXE0NkgxSWR4ZW5WaFpE?=
 =?utf-8?B?V0o1aWkvbklJVjdEOWRGVCs3eWd5anAxc0p3K2dOaDlOZWNFNmpVaWk5UWhG?=
 =?utf-8?B?SlRxNGVWK1gwcTBBVmJydW44NjRzOEpaUk1yMk05K3JkQUdPRThJWEh3a2NI?=
 =?utf-8?B?NFhRZkFLc0NOaDVSelBCWWY4REtZK2dXMFIxWDZwRHJZVndPRU5lQ21FN0k5?=
 =?utf-8?B?VmhWelJPQUFrOUVDZ2JrczVzak9RQnhjUjU1MnRGYkNaRXB1SW8xQ0tIODVt?=
 =?utf-8?B?RmVpalk2NWowTkFKWGdtam5vZy9nYlRWOVZYTkt6Z21DUXgrdTdXOGtGVGc0?=
 =?utf-8?B?QTkrcStqV0F2emRMTGlsS3lJS0RIS3NlOCtrKzNaUFU2TVlDRVVDMXpVcXdJ?=
 =?utf-8?B?NkhvV2VQZWU1d2xmVGlmUkRQK1Zmbi9FVFVPZXBMNUlkYSs2VGRsM3Q1N1RL?=
 =?utf-8?B?RHdkN3pTdCtoR3IrOE8rZlUybWZtbDdNNk16UlBsZ0V3emp4TlVXMjRmRE5a?=
 =?utf-8?B?SjNLb2tUNmVGU0ZBeGQ5UVJBUlFua2VkdHh4ZWdzMFp1SytMbFErNjMyM29E?=
 =?utf-8?B?cWtrL0cxNFlsejZxZUpObDkraytOZmttUjZUemhwM25KM1U5bEV5cUNmTDlR?=
 =?utf-8?B?K1dBWXlsMVFaUzd6WUtUM0JCQTdPOERjT3l0RlRSMEZlQnBNenZXRktqVnVQ?=
 =?utf-8?B?QUdNN1Z3anVCK2RVcnpyWVRJdWZxN0hacmhOd1JXV2pCTjYzZU9HZmQ3NTFW?=
 =?utf-8?Q?WDV+Kf55J91LaHoAabpLSLs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb7890a-6dfd-408e-91da-08d9bc1a4962
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 20:18:53.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on0EKzXRKVOm4D1WhbCOoT2J2tQ7wDdRx9edMvMeloLR+m6Cy4zslqIhGB1yyUM6iogUQCXWnZxr1IZSASgOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 12/10/21 1:12 PM, Dave Hansen wrote:
> On 12/10/21 7:43 AM, Brijesh Singh wrote:
>> +/* AMD SEV Confidential computing blob structure */
>> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
>> +struct cc_blob_sev_info {
>> +	u32 magic;
>> +	u16 version;
>> +	u16 reserved;
>> +	u64 secrets_phys;
>> +	u32 secrets_len;
>> +	u64 cpuid_phys;
>> +	u32 cpuid_len;
>> +};
> This is an ABI structure rather than some purely kernel construct, right?


This is ABI between the guest BIOS and Guest OS. It is defined in the OVMF.

https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Guid/ConfidentialComputingSevSnpBlob.h

SEV-SNP FW spec does not have it documented; it's up to the guest BIOS
on how it wants to communicate the Secrets and CPUID page location to
guest OS.


> I searched through all of the specs to which you linked in the cover
> letter.  I looked for "blob", "guid", the magic and part of the GUID
> itself trying to find where this is defined to see if the struct is correct.
>
> I couldn't find anything.
>
> Where is the spec for this blob?  How large is it?  Did you mean to
> leave a 4-byte hole after secrets_len and before cpuid_phys?

Yes, the length is never going to be > 4GB.


