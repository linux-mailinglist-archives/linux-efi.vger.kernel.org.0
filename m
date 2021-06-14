Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63903A6E30
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhFNS0h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 14:26:37 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:45921
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233511AbhFNS0f (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 14:26:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjkqx/l8Utc1/fq4OKpnbUftWEBhsPoUDJgb/EPXEQLq9u4SFgXbrSIBsAM5F/QHo9/Kd2Qow+celTqjo7fURqqu+DAZ4buNSKQOq+YBI4iu5HjfnLTYtoo+vNVxqHfUtzV4D2h9A5wp8vzxOF1CM4Cgnlhu2101E2iKUo1e2zZ/Cb4YVF/VSs93RIDi1yiJ4BkOjbCTCFXCW3+eEipvLip7gmf9Je5KgeVKP7jVwgIgHKqgxnsghq2OnDKJdjkSDTWB/pODcEc3FmUsy6HXPOZQCeMl9d7cZuqr9OmHe7jN38yg4q3JGLxGS7E00ZgQcpTNdw6yTuxbu0qKmvKMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvPKM1qsbDQTQY8gwZ4rVIMZMhtJnVHLVEOivSjd3HA=;
 b=bFwKmnt/zP9PwpQ07LRxymBPjgLfqUnDk4dsl/MJgm/UVOwQxKGgl+LsGA75mPdlJTb+U4oLZ10zugGIDyK8Z1Y0LyHb9EVhZnMPQDbLQCl/yp+fQ24OXud7ZxttU+5e2FSuLGxX5vSYBkbk2y/xtheEYcclBCKmpqcp6gjVb/tDkS+4W4HICN74ot5g4XxttZQkNZ6Itod8bLPsqMyPJX2INC8TnAkYFHlOxDm2+ZYEQdftuWmvu6AYw+k3c/BsfIO5MPq608BcB8nErEU2Nzyp/OHE6O9u4SF8UCqnI+3sbmsFKpbQ5sw+J7Rqh/9uPM0pwxjrwQO6VI3PDiFArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvPKM1qsbDQTQY8gwZ4rVIMZMhtJnVHLVEOivSjd3HA=;
 b=HClke3t9lr4OL5KpQr4+gCyLTdOA/6Etoru3uuNm9PHJHOIpzce3C5ksckXMI83XLsgGNtda9sH9p+qV9+47ciXyF4/U7nRFhqvzZ2S3p1+ZrOKJ1RtZVc78kW72ypUHQHNRtAQqclep6O3Fum23dxRZZyoI2Xv1h4FwvoHySBA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB4761.namprd12.prod.outlook.com (2603:10b6:5:75::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Mon, 14 Jun 2021 18:24:29 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 18:24:29 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com> <YMEVedGOrYgI1Klc@work-vm>
 <8a598020-7d89-b399-efb9-735b2a6da8a9@amd.com> <YMeOnO4PBnvxEQEv@work-vm>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ae1f211a-3606-1624-fa8a-8df404e87e9e@amd.com>
Date:   Mon, 14 Jun 2021 13:24:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMeOnO4PBnvxEQEv@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA0PR11CA0135.namprd11.prod.outlook.com
 (2603:10b6:806:131::20) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA0PR11CA0135.namprd11.prod.outlook.com (2603:10b6:806:131::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 18:24:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a704df-cff9-487d-260e-08d92f61a5e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4761BCE2B0C9A18231DFFC34E5319@DM6PR12MB4761.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Siw9ZZ8Tz05I4zvAgBH6UXvaiJlQy1X7mVMTAWBvULHYg80+FYv+9/nkiHwHnwqy5urpLWXK7lOJz0lP62zPZ/Fz14iyl+u9wyn82UQc5Wr0ygg10GfYfcTyz0Iq1LvPRJPNkuxp5Aq4Dl6bghGoUfwix0bTZGfC36+8Q2XxRC3zzH/DzbVhVEo80e+gOghDgnZG69nry0/GOmoaXfNfMIjVsTNzqkh7ZPqG5CJL7K3P4wMbA9Z+N37RcOHiO9bJYdXVnWCfQzLp9USIdoK/5d9KaVZ8pRuqmK4tP0bp7e+IcjSg/CRYmmdrhFWwzHlO540OFExpR4Fa7SXoJ+s4YZeyfZta6VVIrpRQDUwrjvFiJ9xUVWV3K7nQ+XxMSRxXPndHb7u/EXV9oe4E2PaJ6GFd1iSmoOh3FWfiroAssOft8XRwK2eSPbMjWGcjpSf23myHmm3ZJ/vtyqX+S/hiklh/JIVL1N09OfMLOh59AhlOJsSTyXvEG9KGrinvoA2kJpumV/M6Xh0946rVXjL6kn8V4DgIne5/qtueDn9904caxVQ5AcTGA6o1OktKwVi/QFq5GN8zYJeDKWv4Nt4Co5VnODRqTeBJVVQhpz7xbuw4oG4sZ+1VXOQ5PKsjVtyfmiW5kkF0Gpec2x9z6grY1gIzw+tIDlEbkOCf/umBdJ9xLoMRILjIY5msQ5SJOOpVPsMw5uosu76CcwmViARnBW3g5wseB3QD7rwC5SY5zQXXgiwD09JxxHLKYjmWfmFYGES27pNq3eJKvfR+TxjcMQkRf6JNMLEgSwddx2CzyGuIgh6PiA5r/3NEQV71EdhgfK4Y+BE5fS6F057xzrQ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(8936002)(66946007)(4326008)(31696002)(7416002)(31686004)(6636002)(44832011)(26005)(53546011)(66556008)(66476007)(16526019)(38350700002)(6506007)(186003)(52116002)(2616005)(36756003)(110136005)(316002)(83380400001)(2906002)(6512007)(86362001)(5660300002)(54906003)(478600001)(8676002)(38100700002)(956004)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVKdXY2TnZ2enQyT2h1WTBJY2xBNXpmWFF1NjFvRm9kaUhCRmdERHJOUUNi?=
 =?utf-8?B?TXJ6Q0tOdGFZakl1Q1NyNlJzNTRTaW5PeUh3QjB4MWdBSzJMSWFDOGhOaVQ2?=
 =?utf-8?B?eVVYQTNZYVRKaHJ2NTVMbzdNdUxwUk5UV1RRckphSG56aW4va011KzhLM0Fw?=
 =?utf-8?B?WjMyTzZDVUdoRmxvNHB0RjF0VW5yc3o3L2V5SStqTDYwb0JlY0xCNy8rUHhp?=
 =?utf-8?B?S3BYUENjVlJIbWdXUWxZWi9veklQbnZ1MnZIMXRINldjN05LWTlDekpIVlAv?=
 =?utf-8?B?eXc4WVJRdCtNMlpLU05yTW12dk5RV0dkR3ZlTFNLRlFqYkhFQWJ1RFpJOFF5?=
 =?utf-8?B?N0Fpd0lQMXJBSDdsWDRVN0VoY2wwdnJzOFkrUXZvRWE3bldSQ3Axbi9ZYkJP?=
 =?utf-8?B?d0d2RW44VitqQXFWOC8yeWFnRy9VTmJlTXRmOWwrVG5oaGlSTTdHdEpZWVJx?=
 =?utf-8?B?c0hTNDFTUEFWbG1aT2V5cG5GSXN2TjRPeExpb2szSFA2MlJUOUxXbzZQdkdq?=
 =?utf-8?B?QlZJU09YMDZYWmxBOGlIZFFyMEhWeVZyLzNQb0J3a1N1bG9NckRYQUc0R3ZJ?=
 =?utf-8?B?cWlQaXU1bFNEcFFLeldCT1dLR3I3alNlMHNSZjJoUHNOUC9SMUdWdDFNR1Zo?=
 =?utf-8?B?VU9TODh3UVNUSWQvTlpiMmVzeEtzS3BPVEd4RnRIVW9FSUcvMFFXZ3JLVkt4?=
 =?utf-8?B?WnFoUTUxMmU1M2Z3MTRZdVZQbUFLOEJTcEFqZTZmT3ZQaVRYeWN4ZHhhQmxH?=
 =?utf-8?B?aXEyZVdBdE41ajQ1TXZiV3NzRDNjWGhRd3NHRm5qZ3Vic3RHNWZhSjY4dmN0?=
 =?utf-8?B?WGozR0kxMnN1ZUJRQ3pSazZMRTY3cWg0K1dBcWk2Y01ZQ0ZpVTJGUCtBYVE0?=
 =?utf-8?B?d005YnAyYmd1Y1RSZXZMSDV0UU9XZngwWHJ3WkVOQUVNeVFvUUR1eUxmeHAy?=
 =?utf-8?B?azZRMTNLcnMyU2xmS3d0ejhDbXVFRFBYdnlHSmRaTk9KTURZeXRhK1NDTE03?=
 =?utf-8?B?RXhuYTZKS3FBNjM5S1JqY3A5N3BtRGhzV2l5WjR6ZG9MZURaMnBwSCtmZWFm?=
 =?utf-8?B?RVZwMlJDSGxlVTVDeVZhN0hkV2Y2eEY5SjdjWUJIc1MvVXdJMmIxanlTNXlm?=
 =?utf-8?B?VHV6Q0djaGcxZWEzZ3FVdE5aM2pDTVEwcEliZUI3bC9OVWZDWUVwclZMSndY?=
 =?utf-8?B?R0Q3Mm5MZ0JubVExRXFhMG1VeWx4OHN3dmlyRm9iQXVscENyb01lZnRoQm4r?=
 =?utf-8?B?R25Ha2ZoNi9SWEJud2dHWDZ1UU5yMlk2bnRjUmpxSXJkR3NoY2N2YUJMT1BS?=
 =?utf-8?B?TmhjVTR0Q0pZKytQVWlFd1E4U1AzeHYraUFYdFpmNmV0WWdiZ2Zuazg3cFpY?=
 =?utf-8?B?RmVNbkRQSkpvMGE4SkR6VGYzN01XTEY2c045YW5RRVo5ei95YmdUbWhwS25Q?=
 =?utf-8?B?Z0dVbEowU25BOW82R3FRRGlKNDYzOU9UVXZOaUZtMi9SNDNpN2txdm0yc1B4?=
 =?utf-8?B?SE5BeDNtWTF3ZlhjdERQWkVaUjVYa2ExZ2twTDZNbDhZUlh3VW9GTVF3bG50?=
 =?utf-8?B?TEUzYUZXbTdpbGxubkY3UkU1dmo5L1dlL1lvOTlscHdXR2xNV0dKd3JhZEEr?=
 =?utf-8?B?MzdIbmt1dDhydCs1Nk94K252aDRSNFFJZkNROERLMTJ6eTdzZnQ4bEE3RE5I?=
 =?utf-8?B?L3ovUnRvQm1kcHdRT3R3NXRYcERXaTBwT25NMDdBdXFVUkxVbzZFUnl0N2V4?=
 =?utf-8?Q?h+YjjuxEBTRX1NmgD+ZPEoJACRm3av9c30N8qPl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a704df-cff9-487d-260e-08d92f61a5e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 18:24:29.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4s8LGZ1cvRMMWSPMjt60jQ2luYQisG9scQWp+8pE+1nIePNkZz0oQt22wI+0h/M7YEA6wJJaqeAWhNwVvmwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4761
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/14/21 12:15 PM, Dr. David Alan Gilbert wrote:
> * Tom Lendacky (thomas.lendacky@amd.com) wrote:
>> On 6/9/21 2:24 PM, Dr. David Alan Gilbert wrote:
>>> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>>> Version 2 of GHCB specification provides NAEs that can be used by the SNP
>>>> guest to communicate with the PSP without risk from a malicious hypervisor
>>>> who wishes to read, alter, drop or replay the messages sent.
>>>>
>>>> The hypervisor uses the SNP_GUEST_REQUEST command interface provided by
>>>> the SEV-SNP firmware to forward the guest messages to the PSP.
>>>>
>>>> In order to communicate with the PSP, the guest need to locate the secrets
>>>> page inserted by the hypervisor during the SEV-SNP guest launch. The
>>>> secrets page contains the communication keys used to send and receive the
>>>> encrypted messages between the guest and the PSP.
>>>>
>>>> The secrets page is located either through the setup_data cc_blob_address
>>>> or EFI configuration table.
>>>>
>>>> Create a platform device that the SNP guest driver can bind to get the
>>>> platform resources. The SNP guest driver can provide userspace interface
>>>> to get the attestation report, key derivation etc.
>>>>
>>>> The helper snp_issue_guest_request() will be used by the drivers to
>>>> send the guest message request to the hypervisor. The guest message header
>>>> contains a message count. The message count is used in the IV. The
>>>> firmware increments the message count by 1, and expects that next message
>>>> will be using the incremented count.
>>>>
>>>> The helper snp_msg_seqno() will be used by driver to get and message
>>>> sequence counter, and it will be automatically incremented by the
>>>> snp_issue_guest_request(). The incremented value is be saved in the
>>>> secrets page so that the kexec'ed kernel knows from where to begin.
>>>>
>>>> See SEV-SNP and GHCB spec for more details.
>>>>
>>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>>> ---
>>>>  arch/x86/include/asm/sev.h      |  12 +++
>>>>  arch/x86/include/uapi/asm/svm.h |   2 +
>>>>  arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
>>>>  arch/x86/platform/efi/efi.c     |   2 +
>>>>  include/linux/efi.h             |   1 +
>>>>  include/linux/sev-guest.h       |  76 ++++++++++++++
>>>>  6 files changed, 269 insertions(+)
>>>>  create mode 100644 include/linux/sev-guest.h
>>>>
>>>> +u64 snp_msg_seqno(void)
>>>> +{
>>>> +	struct snp_secrets_page_layout *layout;
>>>> +	u64 count;
>>>> +
>>>> +	layout = snp_map_secrets_page();
>>>> +	if (layout == NULL)
>>>> +		return 0;
>>>> +
>>>> +	/* Read the current message sequence counter from secrets pages */
>>>> +	count = readl(&layout->os_area.msg_seqno_0);
>>> Why is this seqno_0 - is that because it's the count of talking to the
>>> PSP?
>> Yes, the sequence number is an ever increasing value that is used in
>> communicating with the PSP. The PSP maintains the next expected sequence
>> number and will reject messages which have a sequence number that is not
>> in sync with the PSP. The 0 refers to the VMPL level. Each VMPL level has
>> its own sequence number.
> Can you just clarify; is that the VMPL of the caller or the destination?
> What I'm partially asking here is whether it matters which VMPL the
> kernel is running at (which I'm assuming could well be non-0)


The caller's VMPL number. Each VMPL have different communicate keys,
please see the secrets page layout as described in the SEV-SNP firmware
spec 8.14.2.5[1].

As indicated in the cover letter, the guest and hypervisor patches are
targeted to for VMPL0 so we are using sequence number and key from the
vmpl0 only.

[1] https://www.amd.com/system/files/TechDocs/56860.pdf

>
>>>> +	iounmap(layout);
>>>> +
>>>> +	/*
>>>> +	 * The message sequence counter for the SNP guest request is a 64-bit value
>>>> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
>>>> +	 * it.
>>>> +	 */
>>>> +	if ((count + 1) >= INT_MAX)
>>>> +		return 0;
>>> Is that UINT_MAX?
>>>
>>>> +
>>>> +	return count + 1;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
>>>> +
>>>> +static void snp_gen_msg_seqno(void)
>>>> +{
>>>> +	struct snp_secrets_page_layout *layout;
>>>> +	u64 count;
>>>> +
>>>> +	layout = snp_map_secrets_page();
>>>> +	if (layout == NULL)
>>>> +		return;
>>>> +
>>>> +	/* Increment the sequence counter by 2 and save in secrets page. */
>>>> +	count = readl(&layout->os_area.msg_seqno_0);
>>>> +	count += 2;
>>> Why 2 not 1 ?
>> The return message by the PSP also increments the sequence number, hence
>> the increment by 2 instead of 1 for the next message to be submitted.
> OK
>
> Dave
>
>> I'll let Brijesh address the other questions.
>>
>> Thanks,
>> Tom
>>
