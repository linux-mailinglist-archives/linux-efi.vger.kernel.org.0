Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30773456185
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhKRRfs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 12:35:48 -0500
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:35264
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234124AbhKRRfp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Nov 2021 12:35:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN+3NPMIu7v1kDGHpBwhfooJh4m7vtiMKSNIWiK3UZZymJREuC1wajBo/KTmfY7yrhwYy25r94a/4yq9DOoi+sWLtS3XIoL1yWA/E7d6E+R2xBCo2qv+Uc/ypv/aHLOb6tusIYC90IzFLwn6UAb199t/qyTdrNchBqfefXlow7ujzolchWqDAWAO57fZ9rQDMrVOCVQ91gaer2fShfyUpe6IEyZsq/lDmfwsxd4MK71WQ5Rnmmuj/YoonizpqDIMF6e4aF4T5DzsT5cXj+rQMJf6Y7TLNG1b5TuH0i33LBi++Bi5LdLMQIyxiCUvajCup4vMT5JwHMBjj7+YZuYUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaeyhxjHwNCCVwSy87LK2vWampIejKdDy8EifGOvz8c=;
 b=P6djiX+z3l871ZqfneB3/Js1243u5iw8phQASWiB/BxExzwdxaqYJlVQS2olsdjqqKid+RJvFao7GprvCsPb7eCQEtzu1atT/2d06Igi4c8VwU2Z6NNeA+uMVLAyE52898Kry4inblffHUx2PmCAa65vDZ821ruJGod0JDbnEVWu/W2xXoo4viIvVTK1+RDIgEFscNnra5kWddBhGCS12fkTdV2K2utYBWifE6gKSazamEOzz1tairG21NdqTgOhW8Rno75hWBCUpw1vqYQ0grv1e196tuJlEWz+uUgniRidCANugdmMAwc3oBv+jG6aY0A8NOcTH4uD7hoOVckL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaeyhxjHwNCCVwSy87LK2vWampIejKdDy8EifGOvz8c=;
 b=QXwYhjdWijFnj+XkQaXNIjtN6sq6UNDu+RieK76p9FVNFXPDIIIh3Tq9WaFDEetuxDb/vYYdasA+IQneerRMiK9DTQtCJRYDJ2oGcqNO2qCx3tcSG8uPow6eJ9+TP+nR2lP5tLo2iHh2mUU19hmonTSli3OVqRhZx1Q8/HGliCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 17:32:43 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 17:32:43 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 43/45] virt: Add SEV-SNP guest driver
To:     Peter Gonda <pgonda@google.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-44-brijesh.singh@amd.com>
 <CAMkAt6q3D4h=01XhHcxXTEwbWLM9CnAaq+6vgNzxyqzt+X00UQ@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ff3ceeb5-e120-fe07-2a0c-4cd51f552db8@amd.com>
Date:   Thu, 18 Nov 2021 11:32:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAMkAt6q3D4h=01XhHcxXTEwbWLM9CnAaq+6vgNzxyqzt+X00UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 17:32:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf4b0ae-a272-49f9-41ff-08d9aab96d88
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4429861310A81E1183E91970E59B9@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTv2CcxAyNrnMMgjefg32YQyOi5rLC5ag4/UeEAqjFV7ZKePE9/onnq31QJDwnUrtqJtF/caRVx0Ml9TAP07upBpD/IggbdJ9sDdG5ICyUq46TReVvy9Flt4cqQReKrx6ZwNCeBV6uNOrCOcMY9QgCFZtoXHK5HKS/5BPgKE/8i3jNAjudSTG0TRl3htYimUBk8LNXTcJMAEtHEp5m2B7jbduFFqzSM4MXPBGVDAa/4bh9FkZM8WzRfsDRaaEzrM/2jI2SZKDpWFQMojCBDkgpL6zffR3CoDgX0ZeyF/dpdTLWuEYJniBBKiS36XWbRk9k2SBpQ5EB7HkP3h+8taUcleBAOSNVePvh/9ekiVcU0Iy+WBC0tjec0/ryGg0Z5PL9okSBPcfLOlzaVurYC27KU/dL9X+jL2SyWh9WqKt1T7SVVRh5qHKBFzX32POxkIKiLgjwN1eKc1gyR5W3AIMDrIdGHVO+1lEeZDpo2mz8LO99X1yB8dw+USkE+PCRI2Cs28Msq34J5z0rmLPsA6+yzgjDqZTGHNWM6hJrHO4tf2HeOxqLJsoNtSnT1blg2CSn79NrPOnXCbqpd4wLdbRj9AWoNfdXGeSBwwrJ+/rLaToF0YnEvFUY3nHYFNMeakO50tD2wuTlqKX+cAW4lWUKVb0Lk7lLEwvlheOvFRG0s98OLXjVQ4u0EfT28Nzmdf03jhz33f7UklUcXo0QMRf/H/agajcNzlvGKbJkIkuXn8jb5gUk9+MddrRGl9GmC3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(316002)(53546011)(31696002)(38100700002)(186003)(4326008)(8676002)(83380400001)(5660300002)(26005)(2906002)(44832011)(7416002)(6916009)(54906003)(36756003)(2616005)(508600001)(6486002)(956004)(16576012)(66476007)(66556008)(66946007)(31686004)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzNBOVRQQUpRYkZockhtUmdJOUVxSWJPV0FzMnd3Y0hpRVBvODN2Wkc2Z21C?=
 =?utf-8?B?N09pK2pzK21ma2w3TFlPY0FWbWtpdjFkMTBGVzBXeVRiTXd6S0ZITXJhK1RV?=
 =?utf-8?B?Y0hpSDV6eTIzYzdkb2NNY0lBUG5DSk9NUEtYaGcvOW5DOWhiQWpqTXNvWGk1?=
 =?utf-8?B?SDllRHlMVG5DMWtKdUJ1SE5neGcxRmxCRXhrMk9MWjRjamZ6WDlTeUhUVUQv?=
 =?utf-8?B?a2JyUWxtZ2FkYTc1YmJwdUMzdGdFcUYrOThkZ0g2bWdPdERJYUZyRDlUUjU1?=
 =?utf-8?B?ZFVjU1Y3cWM1RGYwMllMQVMxZFZtRkdWUlhocUM1dnNZQUhKRzNWMkhWL1Vm?=
 =?utf-8?B?TVlvdHNieEM5VjAyczNvRVFZSTJwMmx2VVplTHRvVWhNTzlVVzlmTkJGYU5Q?=
 =?utf-8?B?V1d4dnpnVkRhcnpGZ05DL0JCZS9HRUxoNnJoWnBpdjN5V01RQjhsdEdPdUc2?=
 =?utf-8?B?Nnl4aEFXTzRuVkd4bTZuUXhYYkZWQWFDb3lzOTU0SDZVb0gvV0hBT3NicXFF?=
 =?utf-8?B?WmpWenAyS0FHQXdMVGx2WW1BSUE3RG9BdW5BOTJpdmFrRGZPc1hMdjR6b1RZ?=
 =?utf-8?B?MXZXMUhIdUwxWVhXQzdlOHl0cXkxNDZ6U1Fnb1RLZVlyaXVTUElSZllBbGZv?=
 =?utf-8?B?ZEJsdlFaR2tPcTNXZnU2MmZQSGxYU2Rqem85bjJSbG1HOUlZamg4VHpkdDhm?=
 =?utf-8?B?eG5qbGxXdkk4OFNLUkVyRjNaeTBRWkF3emg4bUk1VlV0NVRVU1Qrc2hST3RQ?=
 =?utf-8?B?MjlZUkZ3cFp2Q3o4UkFyWGFvY2t5cDA2U3M3SlpuVktobTdraGpDNjJ2QnIz?=
 =?utf-8?B?NXZ3ellnWlF6VklpaytGQUZPRU9YTUZNcUJzM0RMdm5xaDFrOTNqTHlYMHJy?=
 =?utf-8?B?S25paTBWcWNiLytPZEFGQXhweDdQQXRDQXNQdTBROVlOdFRHWXlVdjlZWlZX?=
 =?utf-8?B?MzYwUHZyOVFBZlBLeE8xaE5hV0M1YVlHTlZlM05WZkRtdWxVNjRKM1NQNHpm?=
 =?utf-8?B?bVlFMmxyN01aZmVseVY2U0ZjcUdkNkFSWTFTQXpDVmoxaXMxOUhheURNZUsr?=
 =?utf-8?B?elBacmgxcHpsQzVoTDRSaFlqNjRLMXk0cjQ2MHViSk9NQ1ljM01nNWlyZ2s5?=
 =?utf-8?B?M0g2MGJNSFRvdWtJdExEbzlvMG9uUy9CVjJkN3BCelpUOU5HM3FaK01yTXNm?=
 =?utf-8?B?SFFuSFp2Mkc4QWpidDBSN2hINmxjZGorRHY5OHd2SEYvTHFja0dhOVFLbzJk?=
 =?utf-8?B?c2tjaENDZ0J6MUFyY0xsd3ZIVU9YOS9kWjluamhDY05KdUp0bXR6akcwMUdB?=
 =?utf-8?B?Z245VUNpNVd5ZjliSVZRT2NaUFVCSmo5WWJ4WmdJaE5EWnlpYllqRGMyNG4w?=
 =?utf-8?B?NXVYdWxudFVPdkJBbEVDZFV1TzdrV20weGdSSEVZN01ocFJWVnZwdzlkRlQv?=
 =?utf-8?B?Sm5lMW5McHkvTVRQZ2FZdUp4RnZONFBJMmpjNWkzZEdwMnQzZDFHd0RURGU0?=
 =?utf-8?B?aitkcjlYREkvL05rVEVzT0tSejB6ZHo0V2VESTltdHBOOUZSY1pLRWtvcXRz?=
 =?utf-8?B?WXllYnFWZW1hSXFpTlNuNjFrY3pQTHQ4ZTBlK3JqOGNTNlBkcTJjbGMzN0Nz?=
 =?utf-8?B?QkZnU1VJcnpSaG9waUtiV2JicXQ2Y2NJMDBFQkhhbnZHQWorTVlva0lhK2Mv?=
 =?utf-8?B?d0lJZTRaejBUMGhOQVNPbXNDWENGbUJsUnNDK3BHdmVuTGsvMk42cndQUXk4?=
 =?utf-8?B?Uk1pWStEY0sxdTJLZVRVRnlRU0FhTDA3cHY1eENndVI1RjNiM1R5SjhLNEF5?=
 =?utf-8?B?aDU3NzRlNCtqcmdDdS9NdFZpNHB3NklIQVdvbmZhdkdXWHVvK1pVckZUb2VL?=
 =?utf-8?B?YVl4WDVFZEpma3d4SXpnM0JkNXRwK3BlTEVOZEMxNkNBWUJvNVlERjN2dzk0?=
 =?utf-8?B?T1lMM0RjdEdhdWNCd01OV2pzOTlHdE1uOWlJeENIcXVZdWo4YzVQb1FjV3Ft?=
 =?utf-8?B?M2FZdmFnaXR6ZE1UaUlZL2piWThSR051N1VEYk44OUtxL2tPUmZ5MWt2ZGtI?=
 =?utf-8?B?K0wyK2lhbTZKWWhmT3Fkd3RucE9ibDBGM0kvMlBQby9aU3NUQ2VxSTlCem1Z?=
 =?utf-8?B?bk5DcU1reE1ObmppcUNIS1lISFF4cjJkckJ0UllaQW8vamxJNmlFeTE2Ung5?=
 =?utf-8?Q?rAqehaesVb9XFZQQ+880sHw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf4b0ae-a272-49f9-41ff-08d9aab96d88
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:32:43.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77aaLvYVowqIULEWc9KbRxpOs/dtWNxxejoD02ijFAqjJJ9RGVPEvimNoyZjnVIRIlRq/VVayalcNIWZYQIkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/17/21 5:34 PM, Peter Gonda wrote:


>> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
>> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
>> +specified through the req_data and resp_data field respectively. If the ioctl fails
>> +to execute due to a firmware error, then fw_err code will be set.
> 
> Should way say what it will be set to? Also Sean pointed out on CCP
> driver that 0 is strange to set the error to, its a uint so we cannot
> do -1 like we did there. What about all FFs?
> 

Sure, all FF's works, I can document and use it.


>> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
>> +{
>> +       u64 count;
> 
> I may be overly paranoid here but how about
> `lockdep_assert_held(&snp_cmd_mutex);` when writing or reading
> directly from this data?
> 

Sure, I can do it.

...

>> +
>> +       if (rc)
>> +               return rc;
>> +
>> +       rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
>> +       if (rc) {
>> +               /*
>> +                * The verify_and_dec_payload() will fail only if the hypervisor is
>> +                * actively modifiying the message header or corrupting the encrypted payload.
> modifiying
>> +                * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
>> +                * the key cannot be used for any communication.
>> +                */
> 
> This looks great, thanks for changes Brijesh. Should we mention in
> comment here or at snp_disable_vmpck() the AES-GCM issues with
> continuing to use the key? Or will future updaters to this code
> understand already?
> 

Sure, I can add comment about the AES-GCM.

...

>> +
>> +/* See SNP spec SNP_GUEST_REQUEST section for the structure */
>> +enum msg_type {
>> +       SNP_MSG_TYPE_INVALID = 0,
>> +       SNP_MSG_CPUID_REQ,
>> +       SNP_MSG_CPUID_RSP,
>> +       SNP_MSG_KEY_REQ,
>> +       SNP_MSG_KEY_RSP,
>> +       SNP_MSG_REPORT_REQ,
>> +       SNP_MSG_REPORT_RSP,
>> +       SNP_MSG_EXPORT_REQ,
>> +       SNP_MSG_EXPORT_RSP,
>> +       SNP_MSG_IMPORT_REQ,
>> +       SNP_MSG_IMPORT_RSP,
>> +       SNP_MSG_ABSORB_REQ,
>> +       SNP_MSG_ABSORB_RSP,
>> +       SNP_MSG_VMRK_REQ,
>> +       SNP_MSG_VMRK_RSP,
> 
> Did you want to include MSG_ABSORB_NOMA_REQ and MSG_ABSORB_NOMA_RESP here?
> 

Yes, I can includes those for the completeness.

...

>> +struct snp_report_req {
>> +       /* message version number (must be non-zero) */
>> +       __u8 msg_version;
>> +
>> +       /* user data that should be included in the report */
>> +       __u8 user_data[64];
> 
> Are we missing the 'vmpl' field here? Does those default all requests
> to be signed with VMPL0? Users might want to change that, they could
> be using a paravisor.
> 

Good question, so far I was thinking that guest kernel will provide its 
vmpl level instead of accepted the vmpl level from the userspace. Do you 
see a need for a userspace to provide this information ?


thanks
