Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E93FCEF5
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhHaVMm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 17:12:42 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:15169
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234782AbhHaVMk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 17:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOracQyhX8I9YlRsDNLQryKoSRa1Jd6oGpBfMhzlzFr0OlPxl/seIL8AIWQ2cS7k7W9FaNOkS+IpzJ968dRiHQcIWukxD9XbHJbKM1dX3v2nezIjjPPKlqS2GDBRlNlOnWdLrwuh+7BmI0avVm3tf7uhZjT5hq/r2a01u+wUMur9vjNqzSYzyeUTI1tIE37PyIefguCm39fNQkEPoTBwu1GkOx0dIkNtUZDzznYi18ME4m5+5nOHZ+SgUwih7eBp5kwvtxWJjq/9C9GbbQ1jkamVqQvtHUwhRxNmeYXBonsWLRWp8HNfzhmTCqDEGiyYAHjaR0gz8YjkRViCjeYdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ucMlTK3mxHcBA6e3VTXyDfm1HeEB69jDiTSP9z/YXE8=;
 b=jD0WNl9mp6ZKjlkxQ7s/nfLLiMhPvJeSIxOHsVTaL7CLUlDVM/2eZQTBukn1xHccChkR76qRUWuTpUiJGSSREwTp7V8QDVHqxJB/O5uUY5VueC+ZR5xBslDgFX85uUq6xz7cEjv+KPeYRimlUafI3M5lxcgxPyJbb5hyn/wGNJS/s3X44nzPHvxTuHxkNau+1/d1GJEOSBB087DlvwNEgMDWbsCSZAJLtgsryjfE/uSOcRxcA6jaqgjgmE5JeOmA043SjpiObTO8RrKDGvu0IZgkU6c9fubuWAC1JQXZ12Uk2ivMpCF2nKRieAdnJM9mb2Q3UVj06AFbD26CV/XyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucMlTK3mxHcBA6e3VTXyDfm1HeEB69jDiTSP9z/YXE8=;
 b=k77AEaQuzuQ4CZZcwrs6hSbUxMe9kla9cKBp/k3XzpxoJJE6BfJWJFEnjPRZpf/o6WmN5YlE5UnFxfqVUyU7KtSbBKCzwZ8nWbvyoJGup8a7Vc/Lw5x6+eSkVt10EO9vYlS4sUuES87eyRPw5wm/qPgJ906Sz0F8ngeMi4h7nzo=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 21:11:41 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:11:41 +0000
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
Subject: Re: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get
 extended report
To:     Dov Murik <dovmurik@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-39-brijesh.singh@amd.com>
 <bd5b2d47-2f66-87d9-ce1e-dfe717741d22@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e7e35408-9336-2b89-6028-c201b406f5f3@amd.com>
Date:   Tue, 31 Aug 2021 16:11:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <bd5b2d47-2f66-87d9-ce1e-dfe717741d22@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0193.namprd11.prod.outlook.com (2603:10b6:806:1bc::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 31 Aug 2021 21:11:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e9580c0-9ab2-4b34-46ae-08d96cc3edb5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45122E27922C6E5936350141E5CC9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nlcvnfuy3NZY0wG8eCrWQBxkOZDUnMdXMRXIlZKJIJvLFiRE+sJnFzuP1uW4yzPLvHjY7xq5PwJhkl/SVyZ1Ha5T5GKp1y2CD8P/alzbs8q9sTTHUWEjW2phtd48RnEK84rUObU/8eTkG5vQDpry9zLjjDT28d/iO5v+c5ZEAjXq9YPmf+1Pvav1WR1M6On0q7GevgDXr6OPyPXlFLQcrRug/N3+OIxOV5wm6WhX4wcBhqt53u871Xkjd4dNnkV5m90bSjLxDTSnj6g0FzrhROLim1AISxV8WEA9EYsbvEKmTtpX2i8EXK4IHdbEU4+a1Escew6BG+JHEPU8rfDW4VRVNbU/pvnuDURDgczx0IaHo9VRMemkiiD5kf3RNMfpO1QnRxc/+4pncIq2WIlw3ItheED4l4tVj25EK90ZQZqn596YrWutHPccVJanpYZtqkZLzq33tB5q2g0i3s02qMm9+p+Qa+YnBOrAeSHFUbHT2H6sdW+IMpkVrIObU8sFSTVJr6TkjVHlitL0GhxM1WHr8q4KkCP2iGGeWvJNL+SwccTBdLQ/SJksnpqSoUFDljoKHSL1EOT4dIa1MLHXgAZiGcurwRskvfYPWno9vyIPx4mgXAmlm7Lg2jqRj9IPF6Heo10DgwZJhN7kT1hKxI1H+XuadNOC40mpbxidujRDJ4FllkgM6ylCR33UF+Az+iOZxvn2LpuSFwg309GVkAV08YPpwi1BJqK/rYtq7LqOGXmDNVOkzm8SLEGZbt8IWerqq4tVhkwLpGmknYtSHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(86362001)(83380400001)(31696002)(7416002)(44832011)(5660300002)(38100700002)(38350700002)(16576012)(316002)(8936002)(36756003)(2906002)(54906003)(52116002)(6486002)(8676002)(31686004)(478600001)(66476007)(66556008)(4326008)(66946007)(956004)(2616005)(186003)(53546011)(26005)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkRDaVRzbDVGck9nb0l4eVlYazJqQjVmWm1WNUNkdDBpbFJCNVNiQlllclN2?=
 =?utf-8?B?d1RsaVBkUkRocGcrZWtCQlM5NG9ETEw4RkJKYk93a3pDbTFoRlN1M01vL3Zt?=
 =?utf-8?B?NFpvYVVtR2RRQWNYbEtaU2xCdVdsYlJYYm8wR2dmNGlUVnlSZWttcnlGbU9U?=
 =?utf-8?B?c2NQNGpsOWhXQVowNHI1K3JjSzNDNnN6YU9vQmwwT3p3MktaSDE2ZVp4WjRQ?=
 =?utf-8?B?b2dIeFVzZ3RiTVAyanRsbkYxc0JPenN2M1E4ell6UW02THNZcUpoYkRoWTU0?=
 =?utf-8?B?YnBma3RBOU5lektrNVphcEozTTFqNFBxZ1ZFRGlSZ3JzV1I0eUszMlpvajJv?=
 =?utf-8?B?OG5hMWRmamFvVklXWlV5Wjl2RmRMajhjakVkTEliTHpGS0hRY1JMNEFKZXN0?=
 =?utf-8?B?RW9FdzN6eW5NSkw4T01USTQxbkNDR25SUHZMeVd0eVB3YjhEWGk2V2xUOFI4?=
 =?utf-8?B?M1ZPeHQxNU9MQzVzQzMwakVjc1ozRmFiQzQwWFp6Qy81SittV1BPTEM0c1BR?=
 =?utf-8?B?bkVZanF0WTMvK3N5b2hxdmppLzFEMURucTg2UVBzRXc5MmxGWXFzMzlUSnR1?=
 =?utf-8?B?Q3B6NTZrTXY0aktIU0w3M1IwVStyYWV2aEpEOE5QdHlIaUVvenFLMDF3Umx2?=
 =?utf-8?B?U2NtbUx5YmpoaXZyV2srcFlBbE1uVGE2N3R1OWpJSk4zajAzS2RUKzB3VTlq?=
 =?utf-8?B?ZmxEY3k4bG5XOWRDTzZZOU9kbThGOGhEVEVUOTNPM0pDT2piaFFsQVZNdEF5?=
 =?utf-8?B?WXZZTmo4eEp4Y0Z5TDREQmdvUUUxaTdLbCs3R01ITHQyaStNRmlvKzltU2x1?=
 =?utf-8?B?NE1TNDNSeVlJYzNhUmhIaHllTHNoODlGVTRHVEZCYkJFQjF3bGJGOWpsZlEx?=
 =?utf-8?B?SHhDZmY0djVnSnI3d0FFclcrTmZYdjV2ZjVRZXVUUm1oa1p3SXorVm9JUmdD?=
 =?utf-8?B?OU01cXpUNEV3TlovWjFMQm9SanRFTjA3R3FDTStkYjBxaUVZdldsVno4UVJk?=
 =?utf-8?B?QnJjUXdzdStSSDlHQWdMY2FIM3ZubFEvdHhsbGUvbEZHUktISkZON2QwMERl?=
 =?utf-8?B?MnJ5WVdjNmxGeUNRWGZmZEdyaGVHeVdWRTVDamlUbVZGZDF6MWt4azBQUDZZ?=
 =?utf-8?B?TlB4QmJuMkNsRllaUEJ4VHROS0RYbDhHQzdBRDVzalg0djVuOHRBMkhzS2M4?=
 =?utf-8?B?Y2Y2TmpyMVNrdWpOZjFzNDdrRDB0amtCQnV5NXlOSnRBOExtVnpQWFpEQmhl?=
 =?utf-8?B?N0VaWGZOazZaWUdrVVFvaDBxQVZYQzlsQ0c1TTVjc1RVZ0JDOWdteFFLVHcz?=
 =?utf-8?B?K29uY1J1NTB6dXAwVVllWEZtQ2tNOVM2UGM3NjFzdEg5a3Joc1Y0ZUw0bjN5?=
 =?utf-8?B?dDJEUEFicHRhSE1xYnFCdTIwUzMweWNETnR0MjZTZTRlRkhPYUNJYkxOTDRr?=
 =?utf-8?B?YTZYb1FsSG1nREtuT2JjZXRqNlIrNWFEbklXSXhobSs5aDZOVnE2WVdRdGJo?=
 =?utf-8?B?SDNwZDhwTDgzdm8wS0hCbldtRlVtNlVzQW9ZNld0M21LVUVYeXhZZytVVkl6?=
 =?utf-8?B?aHc2Y1JuZVR2S2NsY3ZobXFVc3hmZHF6NkU1WXp3dHBuQncwclRGZGhYaWdL?=
 =?utf-8?B?M1NQdXNjWWYzUmRSRmtkaFp4TzArcnEwcWFXbHZES1dRUTY2ck01RU1oNjNQ?=
 =?utf-8?B?ekhpNkw3TW1RNlRISzlacU5JcElMblFhM3ZKREo2UWpmdms1bHdDeEZDZXk4?=
 =?utf-8?Q?y8jUx9VrHTLKozyqud8KoOqLqtXzUbFT6J/cmDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9580c0-9ab2-4b34-46ae-08d96cc3edb5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:11:41.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gmZtJh4++qdfHW6V2q4ao11FoOG7etxb0UnOgoe86EGZBhO2pAqJNvKUeI0M7pwdyPsAMlCZ5FO876oFkHtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/31/21 3:22 PM, Dov Murik wrote:
> Hi Brijesh,
> 
> On 20/08/2021 18:19, Brijesh Singh wrote:
>> Version 2 of GHCB specification defines NAE to get the extended guest
>> request. It is similar to the SNP_GET_REPORT ioctl. The main difference
>> is related to the additional data that be returned. The additional
>> data returned is a certificate blob that can be used by the SNP guest
>> user.
> 
> It seems like the SNP_GET_EXT_REPORT ioctl does everything that the
> SNP_GET_REPORT ioctl does, and more.  Why expose SNP_GET_REPORT to
> userspace at all?
> 
> 

Since both of these options are provided by the GHCB protocol so I 
exposed it. Its possible that some applications may not care about the 
extended certificate blob. And in those case, if the hypervisor is 
programmed with the extended certificate blob and caller does not supply 
the enough number of pages to copy the blob then command should fail. 
This will enforce a new requirement on that guest application to 
allocate an extra memory. e.g:

1. Hypervisor is programmed with a system wide certificate blob using 
the SNP_SET_EXT_CONFIG ioctl().

2. Guest wants to get the report but does not care about the certificate 
blob.

3. Guest issues a extended guest report with the npages = 0. The command 
will fail with invalid length and number of pages will be returned in 
the response.

4. Guest will not need to allocate memory to hold the certificate and 
reissue the command.

The #4 is unnecessary for a guest which does not want to get. In this 
case, a guest can simply call the attestation report without asking for 
certificate blob. Please see the GHCB spec for more details.

thanks
