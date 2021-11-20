Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4F457A21
	for <lists+linux-efi@lfdr.de>; Sat, 20 Nov 2021 01:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKTAbg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 19:31:36 -0500
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:57808
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231761AbhKTAbb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 19 Nov 2021 19:31:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLB1S36lCkDWg5FTq7atGO7W6h0CoweG78H9kVzRWa0m//NC6XCSKCzMeWBsxerjmdsYpvrpX7+mVNizUBTAEPdV+8X/QTWYm8hz5bkepUJQY/MbVdyvFyQh7Ly6/hXu7ipEesIzGwA1TZWiyk9Fka2dHemYeVZmPqWjtuh7KVgsu9LxwoewsLcDVpbM8vCDO6WDbapeyxzGIZ67LjeqyM65R6bAVuBtIc73hUrXhaWHFAbjOrNw2fs4uqMlg9hAJd7YSmSeUczwFcj3V+VZPyuWG5I2EalaH9xv75te09st8aAkcsHIO4eqVceNZNpzwZyT0kus8L3axNlJVh9/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBFPaxQwPZacYqPCZ6MZ8QKMn7cDTYkDQxRb9+W+RN8=;
 b=GjZNMvmmZ8SOeDVC31xv1cYhdgbqy7nP/LJtCHaF4FordwRaIriDeyXWP+J8w2gEfpnlmuVaQX6FMLDX4Jhb3W+AN3iVUJRG/YOA1clLRP3ath9qU1pbz7R50OcGAIZLO4VcUabMGiKUurtxbzbuSMMK6n+xmBa6dbPsOJNPmpeGPZuM6O9+/fdvlFO/yr8sLEA3HJqNPpRIdxy3ixu8ElYWAdqfi+go+1H6WqTwjowoPkKflJ+J12XNwI1vJs+5VVU95FCsWQ+jIZKF2w9o9lWaq269Jcx27dquaHLyfcJfa+fQEbXxLTTJETsa8F6u15Ztq0NYwHE0GKHT+Oqy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBFPaxQwPZacYqPCZ6MZ8QKMn7cDTYkDQxRb9+W+RN8=;
 b=ioAn+4Uwuc1HXeA1Cv7DKjh0R4FPDP/aV9reZeRFhPUCm3hY7hd76dSxb6HwG3ag8BLIguB7vVZsfFKkw7yWo5LCGE8XIfFCxsIGjI83swGga3elEXJN4HFiOiIQ2V4T6wlVPryLTIF0EeFxjr3ElDo9HFc5aywVIYnn1ouDa2I=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Sat, 20 Nov
 2021 00:28:24 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4690.029; Sat, 20 Nov 2021
 00:28:24 +0000
Message-ID: <12208d99-ef91-953c-7511-34f7e2cbdceb@amd.com>
Date:   Fri, 19 Nov 2021 18:28:20 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
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
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-44-brijesh.singh@amd.com>
 <CAMkAt6q3D4h=01XhHcxXTEwbWLM9CnAaq+6vgNzxyqzt+X00UQ@mail.gmail.com>
 <ff3ceeb5-e120-fe07-2a0c-4cd51f552db8@amd.com>
 <CAMkAt6pAcM-+odnagFTiaY7PPGE1CfAt27x=tG=-4UU9c+dQXA@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <CAMkAt6pAcM-+odnagFTiaY7PPGE1CfAt27x=tG=-4UU9c+dQXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:806:24::26) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.0.0.5] (70.112.153.56) by SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend Transport; Sat, 20 Nov 2021 00:28:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7dd835d-b16f-4d10-6df8-08d9abbca9ff
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2367861E0C05351E4D0FE172E59D9@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VvViba58pqaIavZT8VV6HyAHNHTuiwv5981H4n401W+Un5Hpkl/KY5z+/FrLz7Dka9dUF+bWLgUWM/0HRi09iFjMpyQwFDMfm6DRX/QL0pe1HTgbXTanSxftR4F/Xr8+dzCnlZPUOcOU/p/I0XpU8t/FfKaWcHV5HrnMDhQq7OLzU+che6oRRmn5O4ZiqQS7oAjjpy5HPqK7dGsvytu3BJSU647J50khVrHX4cA6eMbkrlH1+FB9fAEkOOHHQRmd9R1P1G76VKyFwalZs4N5EC8GRCZitvw3SLyDRMNAruPSh6KurprWlgm1V27pLqDvVIc8CvaRtXsKWDxVCVqduoYkMxSpYHptgtm5gW3YkY4fRwdHeE7IAaYE9D7EyAlOd/csUF1AKMHIUzj2k9lGsbrqdtchtRcITqH/3zDkMkEo7rETHZG1w6GSFd7PZvhiCZ0ZuCpaWYLv8+i+b5k1AfpQvGZ0injtrxORDlVZSwmAdvsjFOwJHt4PmCjEUOdSJbq7sV+cXkn1pbKQY2xQQevg4qrIFhJVktA6mjMWEMtUCu90D9pt2N5aQ6ApOxSEzO1oWXZVShdefK6I2y3CnyjavbXdsWm8ZMpNjkX3TPSRoXOEnoyCsKGP1bvWG+NMyE6GBgLE3vgcsicYLNFLaT/wMuC4zmTQppEI5QtiI3NcF7SOd4AQHbfq0hpoTPP+rMh8qM5sKVJFkw9bTo43TGhpvIk27TudDVT9XCclwi6+yRBS1Va8XOry1PdBCMxps81ofFnMOv3/ooIXqjVoZlXLElgw7hWrw/t43cA2N4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(6486002)(26005)(53546011)(316002)(2616005)(54906003)(66556008)(31696002)(7406005)(5660300002)(86362001)(36756003)(6916009)(66946007)(7416002)(8676002)(4326008)(66476007)(83380400001)(508600001)(16576012)(186003)(31686004)(2906002)(38100700002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BZOEZXVWdOZG1iUDJVKzBOUTkyU0tobjJidUo3cFBqU1daay9MN0YxWXQr?=
 =?utf-8?B?cHl4aG1QTUxHWHhGMXB2aHRlZG5PVWs5R0l3V0Nrb0NKbHBNcnZDWkxIYUV1?=
 =?utf-8?B?RkFobythdDdNNExPK3hIT3dFMlFUeXVSQ0hHamZsWGpDYU1yY3dNWkFVeEU2?=
 =?utf-8?B?dlVxTVhBSFk5NDRlNUZ0NkxCcno2dFZKU0FuRUF4Wlp2cnFBYmc4UzBXQzh3?=
 =?utf-8?B?dFVTNmNOSXZWSG16eW8yVFp5VS96cmdEYUtwRS9GVFhwanlab24wYlRaejRZ?=
 =?utf-8?B?K2pNS2QwbEllNUd5M3h1ZTM3Y0gwRUNaeVQ5L3RDMmVaU1RUODRMSnZqaHpL?=
 =?utf-8?B?T2RVNXY1cTEwczd5d0N3bHJIaEcwSFY3Z01PSG55Q3dLeTlvcnF2VmdzdVha?=
 =?utf-8?B?S21rNGVBS3RKV3FLVFBEV24yM092OWIyOFk0dkoraUt6c3hPYjFjNWxLeWZo?=
 =?utf-8?B?c3VGd2NxZE5zdEdick4xVS9jeTlXSzBmNWsyV2FLWi85L1FlT1JnNkd4eWNv?=
 =?utf-8?B?TFF2MjBPTzZaZDdPUWZraGhhdUh5T1VCZS9PTmdGT3RZTEMyaCtQc1pQYVkv?=
 =?utf-8?B?NFhjMnoranVOUEhxbFhsRzMrN1FVSDJoaW5jUDI1SGcvTUU2VHRJMXBBeTBX?=
 =?utf-8?B?N2xNazNoZnI1alluTXNJTUtmbzMyeHVmNm9xU0ptR0VwL2YvRndkMlMzQUhR?=
 =?utf-8?B?MGkxNUVCK1Zzc011eUs3TkJzTTFoRUE1SU5CUTduT1MxK0Nkcms4Z0c0b2F4?=
 =?utf-8?B?VmhtRUk0UFRpMEc3UmdZcHlMcFJVbEVFNG5WNzlkeVZsNVBYZnN3TUw3Y2Nw?=
 =?utf-8?B?UUZXR0ZRZEtDdngvei8zTHc3QmJyenlIM0VYaVlYdC96Tjhqa1BSbGJicTJV?=
 =?utf-8?B?Vk10MFZiNFJrNWh4RVNrNmV4VGFJZTRQSlFpMG9FbjFlT0NoRHhCQ0pWSUZ5?=
 =?utf-8?B?NjRRZDB6OFRlVnVkVk1OYThmemZsdzZYaXZrR1ROcjdMcVpCMXNGNzhWdVNv?=
 =?utf-8?B?TkcxTWNTbU5Mbzk2ZFZQbi91b1ZmMTVIRnpWTlh1WG5kaEYrWCtVS2h4RVFU?=
 =?utf-8?B?aXJxRXBUTjF2VGRyVzVHMkpBK0pSMWVaZXBCOFQ1eFdUZ1NGZmh2alI1NjVr?=
 =?utf-8?B?MmFkV2dJZEJPQVZhRVR5Z1diNHdRTlBNbEljbmRCQ2dtMXNTM01MQUZZYW9W?=
 =?utf-8?B?UmdOdTdYbGZReU0zSk5WNGlYa3kyNUFiT0pMTGJlZlNVa0VzYXowWFk2Um43?=
 =?utf-8?B?WjlyQUJDSldoVFUxUkFqd1FzOTByY3hTS2pCeDZFL2szYyt6ZHJIK3BJQnUy?=
 =?utf-8?B?NXFPclBGY3FrUjFTWnY1a3lRY0NOSkRiMElaTW9YeDJESGZscit1WmFyM0Vt?=
 =?utf-8?B?akNMYTBic3QxUkNtREpncy9qYnFlMWNscWlNSEIxVjROV2pDY3BPdGlFUnky?=
 =?utf-8?B?TWpCRGhzR0FPUkZBYThVYVhqbDEzalVLb09UeHhmSHF2NGpTYTNJd2lKNHNR?=
 =?utf-8?B?RzlrYmp4ZEE4NmNpdlQwQVFiVk5manJSNWVQK2ZydXFMakFhTVI2RG01Tk81?=
 =?utf-8?B?MzY3YlF5S01XWG1kYUFlbkg0NlRMRWtVRUlncFV6anUxQnc5Q3Eyb0RiYTBG?=
 =?utf-8?B?MWdqSkF4Z0NkdVFPN2l6bnpHNG9ERnVZdHNYUzVKM2t3WUJvazFnZnVOSUMv?=
 =?utf-8?B?S0FWdFpsTmRUUFJzVGFNTTc1MFRSUnB1TUVjK1RuTHg4bUUyMnh1L2RVUHVN?=
 =?utf-8?B?OE1uMmd0ZVVIdTF4ekRQMzRaSzJMVThWdHA3ZlBlSzQ2bStIK2RtYmdLdFF3?=
 =?utf-8?B?VDJ1ayt6MGZhSFRZNlg3Y2k5Ly9VNmY3MDNmV0Yxb1BaR21Eemc4bDFOSEtx?=
 =?utf-8?B?dDM2V1pMM0tvLytoNFE1OU5pT3BQNUQ4R1hJNEtoSC8rTzNBdnZ0dVRmRGpF?=
 =?utf-8?B?MENKUEczVDRhWDZ5eG1rWXdIZXVkdDZIWDJqSHpzSmdSZXJzdHF4WUVaYnlF?=
 =?utf-8?B?d2RyM0NKclhYRURMOS9TNEZ3N3YrbzhpVk03cjltNzRwNWlWdUEreTgzR1Bq?=
 =?utf-8?B?VUdxRjdhWFZVYkdMemlSbW5DMndJbi8vWDgwbnZvclU0V2h4RmFxY2dTZFRi?=
 =?utf-8?B?ZjNGUkZXMzZRdUNaa2VTMHB1RHNIWm8vY3VhQWxPNE5Tc2c2V1pDVTUzbFdj?=
 =?utf-8?Q?VGugcuB9CzVnPkOKy6bq9E8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd835d-b16f-4d10-6df8-08d9abbca9ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 00:28:24.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4VPZXYsgt1BZ1zBzVhuRh/G+CsaYtHTOQL3+YPE0bBjQaTpbRcZoXPtqywW8JmQE/jf0fa+1BG6xXlFx8fO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 11/19/21 10:16 AM, Peter Gonda wrote:
> On Thu, Nov 18, 2021 at 10:32 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>>
>>
>> On 11/17/21 5:34 PM, Peter Gonda wrote:
>>
>>
>>>> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
>>>> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
>>>> +specified through the req_data and resp_data field respectively. If the ioctl fails
>>>> +to execute due to a firmware error, then fw_err code will be set.
>>> Should way say what it will be set to? Also Sean pointed out on CCP
>>> driver that 0 is strange to set the error to, its a uint so we cannot
>>> do -1 like we did there. What about all FFs?
>>>
>> Sure, all FF's works, I can document and use it.
>>
>>
>>>> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
>>>> +{
>>>> +       u64 count;
>>> I may be overly paranoid here but how about
>>> `lockdep_assert_held(&snp_cmd_mutex);` when writing or reading
>>> directly from this data?
>>>
>> Sure, I can do it.
>>
>> ...
>>
>>>> +
>>>> +       if (rc)
>>>> +               return rc;
>>>> +
>>>> +       rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
>>>> +       if (rc) {
>>>> +               /*
>>>> +                * The verify_and_dec_payload() will fail only if the hypervisor is
>>>> +                * actively modifiying the message header or corrupting the encrypted payload.
>>> modifiying
>>>> +                * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
>>>> +                * the key cannot be used for any communication.
>>>> +                */
>>> This looks great, thanks for changes Brijesh. Should we mention in
>>> comment here or at snp_disable_vmpck() the AES-GCM issues with
>>> continuing to use the key? Or will future updaters to this code
>>> understand already?
>>>
>> Sure, I can add comment about the AES-GCM.
>>
>> ...
>>
>>>> +
>>>> +/* See SNP spec SNP_GUEST_REQUEST section for the structure */
>>>> +enum msg_type {
>>>> +       SNP_MSG_TYPE_INVALID = 0,
>>>> +       SNP_MSG_CPUID_REQ,
>>>> +       SNP_MSG_CPUID_RSP,
>>>> +       SNP_MSG_KEY_REQ,
>>>> +       SNP_MSG_KEY_RSP,
>>>> +       SNP_MSG_REPORT_REQ,
>>>> +       SNP_MSG_REPORT_RSP,
>>>> +       SNP_MSG_EXPORT_REQ,
>>>> +       SNP_MSG_EXPORT_RSP,
>>>> +       SNP_MSG_IMPORT_REQ,
>>>> +       SNP_MSG_IMPORT_RSP,
>>>> +       SNP_MSG_ABSORB_REQ,
>>>> +       SNP_MSG_ABSORB_RSP,
>>>> +       SNP_MSG_VMRK_REQ,
>>>> +       SNP_MSG_VMRK_RSP,
>>> Did you want to include MSG_ABSORB_NOMA_REQ and MSG_ABSORB_NOMA_RESP here?
>>>
>> Yes, I can includes those for the completeness.
>>
>> ...
>>
>>>> +struct snp_report_req {
>>>> +       /* message version number (must be non-zero) */
>>>> +       __u8 msg_version;
>>>> +
>>>> +       /* user data that should be included in the report */
>>>> +       __u8 user_data[64];
>>> Are we missing the 'vmpl' field here? Does those default all requests
>>> to be signed with VMPL0? Users might want to change that, they could
>>> be using a paravisor.
>>>
>> Good question, so far I was thinking that guest kernel will provide its
>> vmpl level instead of accepted the vmpl level from the userspace. Do you
>> see a need for a userspace to provide this information ?
> That seems fine. I am just confused because we are just encrypting
> this struct as the payload for the PSP. Doesn't the message require a
> struct that looks like 'snp_report_req_user_data' below?
>
> snp_report_req{
>        /* message version number (must be non-zero) */
>        __u8 msg_version;
>
>       /* user data that should be included in the report */
>        struct snp_report_req_user_data;
> };
>
> struct snp_report_req_user_data {
>   u8 user_data[64];
>   u32 vmpl;
>   u32 reserved;
> };
>
The snp_guest_msg structure is zero'ed before building the hdr and
copying the user provided input, see enc_payload. The patch series was
focused on vmpl-0 only I didn't consider anything other than vmpl-. Let
me work to provide the option for userspace to provide the vmpl as an
input during the request so that we give the flexibility to userspace.


>>
>> thanks
