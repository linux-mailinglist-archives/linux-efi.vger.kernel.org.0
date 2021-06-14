Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178B03A70BB
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhFNUxJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 16:53:09 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:5792
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234686AbhFNUxJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 16:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2RY5IZBZCuTrHGcLGw8pXVyph0dLuMPhEi9qzz7IPEDz8zdb0hhzYpGoSgxyCsu63Z+o8dT4vImTSODKl+nvMhL3aE6262g7lQL2K7ncl+SY4EIh5bm/B0rwTDsWAN7eK92Oew+vgr0eojjeKXTxzNP6hsMqhNaaiwgR0EtU3GqObIzygCx+//DElC0Zo2a4PAH7lVIXqjHCXhdvcGf65F+POgLk5rzfaO0JBVWp4g/YIVi0lViYvt1EACrDaxp2+CkbKifbSXgdFDf6c2i0f5NlVIrJBIhebPXn2Ov4XLxFSDsYTg6r4Jjm/UCY2ByZuAvUMliJtyVKuqm6x0Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6DW7Iha13ipAJFn6fe+d6d79+XxozUihPyB1YGr02k=;
 b=EXNaCeVpGuXSvvu4v2xeRmarux6n+FiS02pnEsAQAnX1h1hdxGaeU7yG+JWx9BI0U206HCZmtp0S4Sb6nFi3Pa+Cn3iQM0qOBjcba6+2SqUMAAhosTuGVEwtLYsQAVXAvn2Z3KWKOSZONTe3shi0K1Ws/2zobxAavOoDNuro1tEoEVHTLIPEzji1BGOf1AdofAyNa4Dp3DwGON5Lj4J0Nt+5iX++BWAx2ILrktnJwK0D9viCHQVNYnzsN1Kq2/B1hCBWkUJ9w5yiMF4VJXeOYoalzNt79XkUiGK6YCNN19r1O0CnYFbutYGWf0ydaCViKfyn0hKF+QgwsGacSDRdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6DW7Iha13ipAJFn6fe+d6d79+XxozUihPyB1YGr02k=;
 b=NxE4Pb6zCOhl6evS6hAogPFZyfBQJO+NKTa42A5VL4y42SeB+oWmOkBl3mxV/cKfS7htq10SNGxR6HN0S5w+UEO+DZUy+M9KROOuGIkFMGnnMniLPV2NyyTcW4Hb8jSCve8vDb4cK/scJ2dzkL0jTGBZnc7FYm+ZUHtsstOu330=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Mon, 14 Jun 2021 20:51:03 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 20:51:03 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com> <YMEVedGOrYgI1Klc@work-vm>
 <aef906ea-764d-0bbc-49c6-b3ecfc192214@amd.com> <YMeQd6z1iwYyj6JK@work-vm>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e624f6a3-baab-d265-ca0a-e7d65ce4c6f5@amd.com>
Date:   Mon, 14 Jun 2021 15:50:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMeQd6z1iwYyj6JK@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN6PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:805:106::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.3 via Frontend Transport; Mon, 14 Jun 2021 20:50:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea910b8d-20f9-448b-390b-08d92f761e7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4547542D763AA9C32D46D535E5319@DM6PR12MB4547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjq1O0dSTYFaKbTOkfUCG8zMsPwimXB+Bhmrd0159IMI8tHiDoBayIGAe0F7rJrT9WQPe81KKNBfAKttcgTuYosxh4gz/+rv5mRNtyVQHV40pFxXs4mcpqfWymwoxPFw6xTT//ZP0mtySSfLV3N6hgebNw1QRLKXghjdtg/ZTMa27hCEdl860QOf5XqTk63F2sdctGI5+eVqMKACX0Y0/kTXn2t5sih9t3wgTl9N2VJ2q5cwfT4AsILDOkaQNernidVDvOyxhJKaZYbUwoivl+PPETjAEyaRxhR78aNZ6Wpd05m63e4FnUZi/tSGXUGDGgWSYfGGD2FB7LW/zh1mb5VFk4rsyvM3jBR9x2nyyO3aj2hp+eP70xV8OD/mMZ9cT18K0xFpbCQ7SnVlL2mSDGxcca+MSXrGJbv3sIGKbTaR8hbHzwC3GxnOiH+H+wPN+Oc6EKzmlFktoUhuB2djxazPD7hxCKbKxGk8gmg9d3Z3+OtPWYnvWpzrIMT5usA1yhw8M4uhJDIME3at7Wh0ldRB/MNCPGIf1XtLOFHTuOxpWv5xeJcbO3QCOXGj9AhN8msX/d2vuOotWlZnEn+dyDrNiNdlRWd652VUQK++N8CE8IzpXE/YyJjr4geQ39g/FF3vvb3bNy2dOHu4ideOEN1kI7WVV0M4Os8mkBvzL6AfMooydpBbGVR6Q+CNpjs4WMM4+JEJKhxVpP5ABQrDZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(186003)(16526019)(36756003)(6486002)(478600001)(31696002)(44832011)(4326008)(5660300002)(316002)(6506007)(66946007)(83380400001)(66476007)(66556008)(53546011)(6512007)(2906002)(86362001)(8936002)(38100700002)(31686004)(38350700002)(7416002)(2616005)(26005)(6916009)(956004)(54906003)(52116002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxwQ1Y2Tkw5bVB5T1ROZ1NwNE96V0plOUNOTS9kYklPN2dkNWNQS0t5bFBS?=
 =?utf-8?B?VGpNNFBsVEZvbUs2ci9OazVyZENiZ0xvT2J4bWRqbVMxcmFoSHpXb3lrby96?=
 =?utf-8?B?QVZkRHVzZUxSSGhMa1FrUzg1TnJkZlJnWGk0Z29aOVJKQXhxYlVmTVMzTmlp?=
 =?utf-8?B?SkxSMnNFcERlMmVUdEwrZkUwM0ZNU2xSTVNKbEFPQ0x3enV1SDlsUEg2Zlht?=
 =?utf-8?B?UmVxM1lHS29QUTNjUFg4RFVBeHZlV1BoRnNxVWR4bldnOS9JNU1rL3F3Yit0?=
 =?utf-8?B?YTFpTTNTQnY4WmJYcXZQSGVUbkhZcWQvc2E5cWMvNnhGZ1NacUFzcUhqem1s?=
 =?utf-8?B?L1dGOVMwd3FnVnM5bWJFY2xCbFo1dDVXTlg2UGMwdFFuWDgrWjYvM2NybDk3?=
 =?utf-8?B?ZjZSVmZmWVQ1RFZRdjYvNFJ5Z0x0K3d0Y29xWElucjM1Y3FXSVBBejRtdXdO?=
 =?utf-8?B?WUdNNVVaQnVtb1hmalFMeTh3RHRRUzJld1JlYWt1cXlFUmU5TVU2UHpZVmRE?=
 =?utf-8?B?aDZJN1ZKME52ZmdPREFBaDRXSTc0NHd1SVBsNXN2UEM3NVQ2NnhTanVGSk1x?=
 =?utf-8?B?M3lVQmV3T3d1dnB4N2dOc3ZRY1Yxc1p0di9KZGRhUWRwRTJjSFFCNlpwTThK?=
 =?utf-8?B?RFErN3R5ZW5Rbm9PQVo2ckRScXJrSEpTS0t0S0JPZ0xVQ2l5U3FvdHJKUm1V?=
 =?utf-8?B?M1BwVzVvQ3hhUGhvYW84Q09WQkV0U25Fb3lXOTFGczBEWTdwYitiZkhzelIw?=
 =?utf-8?B?b0sxVTd4UUxkdWJXZU1TbFFUQ0lSUmpSTk8vK0JtbmU1OCtwOGRueWp1QTUx?=
 =?utf-8?B?bHkvdXJQamhUTy84ZlFIQU1tYmxpTVVoc3JHMXRjQVZQdkNpZ2czeGVzSXBP?=
 =?utf-8?B?N2h2UjNibUVRZG1TRGV3OER4SkNqZksvQ3BDUmNRZGlNSjg5a3c1c3FweTll?=
 =?utf-8?B?WkVOQ1UyN2ZVYTVPek5lTXRlNWw2NmQzaFNOUDNtYk5MNmdvMkJUR0lac0xp?=
 =?utf-8?B?K3JWNitKRTZWQ3lRd3Fxd05XdGFyY2lLVXhTSHhYZ25SajFWQWFUd3dkeFRN?=
 =?utf-8?B?YzFzZVNHQnBNNGhENHFZSzA2TEtvYWk5UWtSeFlCU1dydzRBVnVWcm9HcVhM?=
 =?utf-8?B?YU9vVy9qbDdyem9KUEZQVi9INHhYenFJUW51Ni9KUG0rbXJROUtuemVWbDBW?=
 =?utf-8?B?dmovdzN4MnluUk5aODh2OVZHZ1JDSjN4TS9yeUNnb3ZQcWYyZTdqUDFGK1lu?=
 =?utf-8?B?QTg1R3hmQ2hYcHBiVk82WWIyb2xvOUtvNVlnTzZHRkNzRmZHQXhmUjh2QWFk?=
 =?utf-8?B?RjNqZk5PZ3pwakVwSnc3NEI0WFlROWRERVQ3YVdDczd1aUt1NE5sekNnNFEr?=
 =?utf-8?B?RkM4eEd6cEhnQTZjK01kaWlUSkRGeTZwRG9hclZuRnRMb1dYNml0enhsdGRQ?=
 =?utf-8?B?S3piSjBSUUhCa2xtOFhiYWVMeHFFSmhFekRjVm53TFc0bG9aQ0xzOWZoVm9W?=
 =?utf-8?B?U3ovZFRKZXdtS2g0Zzc2ME8wSUczajB0TWsyWisrWEZJOEtQNEVxSVMrdzdV?=
 =?utf-8?B?RTZ0Sy9MblFEQXQwT25MeG5wdEtkRE42TmFLTW9CQXF6aUpQNjIrL0FUQmha?=
 =?utf-8?B?Q0x6bnBCOXA3OVowWm9ja2tkTzNhQTZFRHhLVUdBdmg0NTQ1SGNlRjFmQmYw?=
 =?utf-8?B?bzMwdW1QT3g0WkJxeG0wUmgyK0hrV3Nod25kK3BXZmY2OE9TL0c0UU1DNmtn?=
 =?utf-8?Q?r6TbtjvymVJOQUXdkofpxRCbxI+pql0k34AjwFT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea910b8d-20f9-448b-390b-08d92f761e7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 20:51:02.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8+M9aHxWQV9DPoRTH5x6jUf3z2JPJOPnUM529vBlc6ugLn1ugpzXQ9mJXO9EcO9L3snbhGt8xBndysDgEFrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/14/21 12:23 PM, Dr. David Alan Gilbert wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>> I see that Tom answered few comments. I will cover others.
>>
>>
>> On 6/9/21 2:24 PM, Dr. David Alan Gilbert wrote:
>> + /*
>>>> +	 * The message sequence counter for the SNP guest request is a 64-bit value
>>>> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
>>>> +	 * it.
>>>> +	 */
>>>> +	if ((count + 1) >= INT_MAX)
>>>> +		return 0;
>>> Is that UINT_MAX?
>> Good catch. It should be UINT_MAX.
> OK, but I'm also confused by two things:
>   a) Why +1 given that Tom's reply says this gets incremented by 2 each
> time (once for the message, once for the reply)
>   b) Why >= ? I think here is count was INT_MAX-1 you'd skip to 0,
> skipping INT_MAX - is that what you want?

That's bug. I noticed it after you pointed the INT_MAX check and asked
question on why 2. I will fix in next iteration.


>>> +	/*
>>> +	 * The secret page contains the VM encryption key used for encrypting the
>>> +	 * messages between the guest and the PSP. The secrets page location is
>>> +	 * available either through the setup_data or EFI configuration table.
>>> +	 */
>>> +	if (hdr->cc_blob_address) {
>>> +		paddr = hdr->cc_blob_address;
>>> Can you trust the paddr the host has given you or do you need to do some
>>> form of validation?
>> The paddr is mapped encrypted. That means that data  in the paddr must
>> be encrypted either through the guest or PSP. After locating the paddr,
>> we perform a simply sanity check (32-bit magic string "AMDE"). See the
>> verify header check below. Unfortunately the secrets page itself does
>> not contain any magic key which we can use to ensure that
>> hdr->secret_paddr is actually pointing to the secrets pages but all of
>> these memory is accessed encrypted so its safe to access it. If VMM
>> lying to us that basically means guest will not be able to communicate
>> with the PSP and can't do the attestation etc.
> OK; that nails pretty much anything bad that can happen - I was just
> thinking if the host did something odd like give you an address in the
> middle of some other useful structure.
>
> Dave
>
>>> Dave
>>> +	} else if (efi_enabled(EFI_CONFIG_TABLES)) {
>>> +#ifdef CONFIG_EFI
>>> +		paddr = cc_blob_phys;
>>> +#else
>>> +		return -ENODEV;
>>> +#endif
>>> +	} else {
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	info = memremap(paddr, sizeof(*info), MEMREMAP_WB);
>>> +	if (!info)
>>> +		return -ENOMEM;
>>> +
>>> +	/* Verify the header that its a valid SEV_SNP CC header */
>>> +	if ((info->magic == CC_BLOB_SEV_HDR_MAGIC) &&
>>> +	    info->secrets_phys &&
>>> +	    (info->secrets_len == PAGE_SIZE)) {
>>> +		res->start = info->secrets_phys;
>>> +		res->end = info->secrets_phys + info->secrets_len;
>>> +		res->flags = IORESOURCE_MEM;
>>> +		snp_secrets_phys = info->secrets_phys;
>>> +		ret = 0;
>>> +	}
>>> +
>>> +	memunmap(info);
>>> +	return ret;
>>> +}
>>> +
