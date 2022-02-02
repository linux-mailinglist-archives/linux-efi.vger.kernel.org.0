Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF174A7B1E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347896AbiBBWb2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 17:31:28 -0500
Received: from mail-bn1nam07on2074.outbound.protection.outlook.com ([40.107.212.74]:49568
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347893AbiBBWb1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 17:31:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAlJp/QbRTnAvrMW9DV5oQwrXG+l7IewrlcrHnN9DO6elhBOGCetWyKhXLSEqmYVli2ILevjaGUHRxjlBhuntNCc9EnOyuZXij18qaWpYg9GzbToH9LVSlIVapYJWPuqt2UAVt4GS4dMBzVUph1vguaf8xcOqeoIVoYxxhEfN7wOy5x8ewXYwpiBr2/hZ47Xn1GhB4HbrKiyYNygB6O0TpaG7loByApCbYKOJNCU/ASXiD+Sjz12CBHEozXVnbQiQrAqxLQsI6O0iA3Gecgb4yretalLheevWKuT582Wjm/2xudeE3o3+LgDdc5UkoaRjeBbGBdy2HIosaFkWyCtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L5tr4wqo+yxUwjp3z/jSrPTJVD8frvwDisOJk3qWo4=;
 b=f63Pa4Zbe28QxM0CFjfR5eeKA6yOyWenmBwlITJDWyo6QFHtrZr3GNFFZjCOyyzrkkWaFRzJwReMnVF6tRZIOfpDfQ+4JeSysJUoV+IDT1bKA8fE3pN1Wv5Mz0906x1smtm/K6p2H4xCnGQkGMJmdExG562XiN5b2W5qtkZ2GWDDQIW0dB/n88ZNR6LGfOgDsEEtu1wWN84t20r+cwMnLp+WDL06HFOjJF50kZgIQevIgigIBcPCuL+WdfufB4zTjtmKTcFVt6dOjjrkj8fM2um4q3jtLlRvS9b80Hd/gVWivJAS907ocRMjNznniRK59r1nGcJgNtwylTrJMJitwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L5tr4wqo+yxUwjp3z/jSrPTJVD8frvwDisOJk3qWo4=;
 b=fw8gEBDjoln64RhuQnDTKoh0wqXLhhphTEITrJ7j8v5MKpGl+pd3S2p/Cootpmudu4WBzMdzyVbazwPU2WRfPEZ6RgG01PVKI4+wza2Kuuo1aEHVYooRnoVrcM1YteUIXrJ0WnNkRgHjE+qu+FsYPRSSBDrpvmq9PW+Fkle2Gas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 22:31:22 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 22:31:22 +0000
Message-ID: <5a8ac0f6-74ee-b2a4-6871-2f928b5084cd@amd.com>
Date:   Wed, 2 Feb 2022 16:31:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Cc:     brijesh.singh@amd.com, the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
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
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com>
 <CAMkAt6p-kEJXJxHcqay+eoMnTDCGj7tZXVDYwrovB3VkXCbYRg@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <CAMkAt6p-kEJXJxHcqay+eoMnTDCGj7tZXVDYwrovB3VkXCbYRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0162.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e878da1-a3d3-499e-867d-08d9e69bbd87
X-MS-TrafficTypeDiagnostic: CH2PR12MB4294:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB429456105D1FF7F34C94F62FE5279@CH2PR12MB4294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dl14B8Li3eRBG77HQSMYdCF09kYK/0sPFTyzpR174oVVx2cPdkxYOfF1AxsJkAAKmWshF9WY3nPzoQAbvRhDoFHuHFG9GglAHmvfBkPXYeS/w1luvRkGOgnPxKDrGaCosy0u2hGexsNnAoS6Q2zfsMEOevklKexi6u1Sq36LoHZ2ZExn5NtWJwqjF1w0Qg0JRVSDnJYURetLLH+djDJ9tD4JlcAJvmKPdDlAIasnHzVH9DzGOAGRI/wwWMzCLPxpRTw+QryBDFpQEesB9YuGJ9zHyLYEE2zBCV7+vAhiHPJvjdrnji3ZpXtCPokiwNdmi1VxObLkSX6MT1orh9CnMh0pRL2xmlNybafRDO4MT9eeyxwqQhqEHodhJZ8h1FzIrOF+PsOYmPtDZbP2hyz5g3O9XZ37mpYrrlMlWm7/A+8+XFRGPIi+IFeuepL+ZYiSdMwhWYZ8ArC84Q6s/oMDvHSCKYyTSjsezWL5uVDlXRY1bakVv+RfaEOcWw1yVgeylp0v+OqbnQ/HKacNzBQ2SsNnvbvai9tjxUVoTdCDGip6ZYqAXa/Ni3AjxNaJGaXQa58zSrvJmyz37r7OLdp7fVdQR63uC+J+3zFXvzNXWtCMGV5AOJriQJBSpXypayVJCPwdVqJf5EWaFmCiuU1eyK+AqQN/AHE0nKJGB+hYI0UH4cWa8UvgBsRwPPqv+TqwvRghv0+EwD/23HKQ90Bdwq9f6e3eUOxs4HC3DTYB7nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(26005)(6506007)(6666004)(7416002)(54906003)(316002)(5660300002)(44832011)(186003)(6512007)(2616005)(53546011)(7406005)(508600001)(6486002)(31686004)(36756003)(8676002)(8936002)(66556008)(4326008)(38100700002)(66476007)(83380400001)(66946007)(86362001)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhSdWdFR1puZjBKeFIyTm56UVFyMFhQaWEyelJKaUtBT1FRWXhPblJRazdV?=
 =?utf-8?B?RHJLaXhZZXJld3FOa1JRSnpnenJJaVhZQ3pXVjFyOHRaU2pVUWVJbFJlTmRK?=
 =?utf-8?B?bFFMaVEycll3UUhtVFVnejlXNHlHa2IxNm84VWN6TVhVN0I1ZzdkZEsyK3Nv?=
 =?utf-8?B?YVlZNGs2NW90U0lUZUkzVy9YN2txenBVTVc3ejlLcC9zQ0w5dENrNGtPZHdu?=
 =?utf-8?B?dzBLSHMvOFlnUXY4ZVdSVC81UDNzYmUvbndkWXRITy8xdXQ5d0ZGZkdPRHRJ?=
 =?utf-8?B?T0YwTWxtWkNySUtJZlJUZ25wL2pyYktrZmYvUTd1cE1jUGRsUWtuTysrdGZu?=
 =?utf-8?B?dmZUQVQxWmNoam1JbFExa09BTzRCUTZzcXpEKzFvOXZkRDBxQlpuNDJLVlcv?=
 =?utf-8?B?VHZUMWVseGpUVXhqNVBNUTRkS051by9vNlNQK0UrS3BkOWxQUytVajdjcEd6?=
 =?utf-8?B?UWlaT3Zjby9KTkl5WTIzMlRCL0d0dUxrdjZ0dVl3MTZiZXAyY01PUG01TGpu?=
 =?utf-8?B?MDlZZlRDK1Zpa2RuTXRYYStNNGcwNG9oSlFPWXJ6cmxjUEdWenlCR3BkcmFO?=
 =?utf-8?B?NG55R0ZtY0N6Z1JWaUszNEcwTmd4VXU0Sm05YlBnQTBzRjhkL3ZraDNxRWU4?=
 =?utf-8?B?L2xNbE5OUUN2K1MzbG4zT0tJMG9mYzBxbE5YdkxvSzBkem1yMFpZYjZuK0J2?=
 =?utf-8?B?SThxeU5KZnY0cytPVThaR2p2aWZZbWorMUl2RkJzbGNXV3pVV0tEdkhtZ212?=
 =?utf-8?B?V213YmlWK05yaEhKcXhUREZDUG1HZkY3bVcyL3Y1Z1kwaTI2dHBmN1piWjla?=
 =?utf-8?B?dUd0ZnI1SWR5SGdDZ2pjei9KWmZwN0N0NFpWdVhsemN3MUtlQnNYNk9ndzlQ?=
 =?utf-8?B?dUg2cGtYcE81RkFyam94Q2NKdmFNeWYrZTYyRGdLaWloWVJ0YTMydGc4ZTNy?=
 =?utf-8?B?OWEyZXBIOGM5ajVmZkhtejIwVTFnRTFVa0ljbEpzanRWTU0zcCtNMGRKOGNI?=
 =?utf-8?B?ZGM5Z3RDZW52UU9OUFl4Um9SNGlGa1VqTi9oTERMV1hkWTJ4RXNYQ3dGaUky?=
 =?utf-8?B?T2Z2UjFpM21DVElxTFFWbUVGcVZWbU1keldYQldJd0l4M1ZRMjhOelVmRDVx?=
 =?utf-8?B?eno4MGtuNVB2VmE3OTNzVGN2K3NRZmxaRiszTVM2MUVnRFF1VkF3K3JZN21s?=
 =?utf-8?B?bzg4UzhYV0pSNzAyQTBuZlQ2M0piclh3VnRqaW42bGtNSWoxTngvQVBVM0l3?=
 =?utf-8?B?RUxldlhzMnA1T09tYngzVlBDVUw0T0M5NE40UjhSUUc3TGNzaDdNUTlMM2c2?=
 =?utf-8?B?NnlKQVZPdXpLelJ4c3RBK0dweFdPdENyS2tXUnhnTWZCS1dOOGFrRmwxUDN5?=
 =?utf-8?B?Smk2OUxuU0MyQ2ZKV0hGSUhKRkovdHZFbG5aTVlDd1NXUWY1cUVtTUtLNTFz?=
 =?utf-8?B?b25kOVl6ME8wQVMwb1E2ODFwd0pGc2ZUUS9qdEhzVyt6QWgzdnZFZ1hsRVV0?=
 =?utf-8?B?NVc5eEhzaG1uRVZPczE2dkRlbFVGNTlSYVhhcU5nRmh4QjZTbWx2Q3hOUWVp?=
 =?utf-8?B?QUhmcWZPbFJUUjhvTzd0K1VWaVpEUWtIcHNjdEJiN3FJMW9pWk9jMTJHa0xw?=
 =?utf-8?B?dW9sYnMrZGVtV2JrSG1FdjJqMVMxNHJJU003UTFEL2hCR0dlMFduemQybUZ1?=
 =?utf-8?B?WktsZTR0UDJoZm5QMGdFT2xZVFhpVjg0TDZENjJiUXg4eUFXV28rYWdwN0Jy?=
 =?utf-8?B?d1ZHNG44WDkxMlZra0RhdmNtaWdLQStRdUI3Y2kwSFFtaTlmK2Q5SThhS2Vt?=
 =?utf-8?B?bGF1cmdTYmNXQkthcWt6MDdkQmdSZUlUQ1IxVVU4NTR6Nkx2a0VXc0pjYnlw?=
 =?utf-8?B?MUJ6bk40a1l3Yk9pZjEvazVFeUdmbHFXZ3NaamNsT2RLL1ovdUlhcG1DL1V1?=
 =?utf-8?B?RnlDRXI5a0RSS3B0QkRwUUxqZDVhWG9rTnJDVXAyOFlzOTd4V29qemZNVzN1?=
 =?utf-8?B?TXMzYThLZ1hlMlZYQzlLT0VlVGlqYm1IcnhFVHlhd2p6TlBOc09QT3VCeWht?=
 =?utf-8?B?Rlk1YS83T1R3bUVoY0xRZlhtSlgzVDMvR1BCNEhpUW5XazVvSUpWYUhGSXg0?=
 =?utf-8?B?dVc3bUZpYWJ5RFY4djFiV1BnYnNlR3VlMVR6T0M5Z1NBakQybSt0Nk9qNUJV?=
 =?utf-8?Q?24zoLRMskRO7yeWaEDNSc0E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e878da1-a3d3-499e-867d-08d9e69bbd87
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 22:31:22.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUNufQTI5gWdmzPUzw371FsFdVLH80SfdYOjKEcoi89bT1tSWjgts23VPMrPkxMi6OmeoocAAol6+KzBlgJpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2/1/22 2:39 PM, Peter Gonda wrote:
> On Fri, Jan 28, 2022 at 10:19 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>> The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
>> ask the firmware to provide a key derived from a root key. The derived
>> key may be used by the guest for any purposes it chooses, such as a
>> sealing key or communicating with the external entities.
>>
>> See SEV-SNP firmware spec for more information.
>>
>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Reviewed-by: Peter Gonda <pgonda@google.com>
>
>> ---
>>  Documentation/virt/coco/sevguest.rst  | 17 ++++++++++
>>  drivers/virt/coco/sevguest/sevguest.c | 45 +++++++++++++++++++++++++++
>>  include/uapi/linux/sev-guest.h        | 17 ++++++++++
>>  3 files changed, 79 insertions(+)
>>
>> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
>> index 47ef3b0821d5..aafc9bce9aef 100644
>> --- a/Documentation/virt/coco/sevguest.rst
>> +++ b/Documentation/virt/coco/sevguest.rst
>> @@ -72,6 +72,23 @@ On success, the snp_report_resp.data will contains the report. The report
>>  contain the format described in the SEV-SNP specification. See the SEV-SNP
>>  specification for further details.
>>
>> +2.2 SNP_GET_DERIVED_KEY
>> +-----------------------
>> +:Technology: sev-snp
>> +:Type: guest ioctl
>> +:Parameters (in): struct snp_derived_key_req
>> +:Returns (out): struct snp_derived_key_resp on success, -negative on error
>> +
>> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
> derived from ...
>
>> +The derived key can be used by the guest for any purpose, such as sealing keys
>> +or communicating with external entities.
> Question: How would this be used to communicate with external
> entities? Reading Section 7.2 it seems like we could pick the VCEK and
> have no guest specific inputs and we'd get the same derived key as we
> would on another guest on the same platform with, is that correct?

That could work. This method is using the idea that the guests would derive identical keys removing the need for a complex key establishment protocol. 

However, it's probably better to approach this slightly differently. The derived key can be used to produce a persistent guest identity key that can be recovered across instances. That key can sign an key establishment exchange (e.g. an ephemeral ECDH key) for establishing trusted channels with remote parties.

Further, that identity key could be signed by a centralized CA. A way to approach that could be placing the fingerprint of the identity key into the REPORT_DATA parameter of the attestation request message. The attestation report will come back signed by the security processor and will contain the fingerprint. A CSR to the CA can be accompanied by the attestation report to prove the key came from the guest described in the attestation report. 

If the guest does not require keys or secrets to be persisted, or if the guest has other means for persisting keys or secrets, the derivation messages are not necessary. It's an optional security primitive for guests to use.

thanks

