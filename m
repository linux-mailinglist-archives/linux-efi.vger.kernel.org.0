Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2BC40C49E
	for <lists+linux-efi@lfdr.de>; Wed, 15 Sep 2021 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhIOLy5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Sep 2021 07:54:57 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:62336
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232586AbhIOLy5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Sep 2021 07:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqjoAgStsvO1NhUQ3f0huYwkpn8pBn8wSvnGm4zBaaw4Kctrd5dHic3cq2aw3W1WyfP7XcOZMx99xqf0y3UQqa8mXzhZN/KmLaZh7eBLRncxSfYq11JLnfLeHc58o72NUEdpy06SwJS3qZ0DyL7/3A0SFjHEKc3+HIOp/ANz1AJAbh9bSfhFB22X9FghqYtgBNURtek2BjdfQcuivAXA/ZQd2OjsNl8ECxXArgAElu0kBKer61tjD5XFjWDOFRK40ODFTdlJFbEYVkzgiK02baUiR6ZpZXtz6gGjhgYp5yvolZE3j/ZOOdlGz7Jq4aaF/SL0j+LHG3VenLEUeBPeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YH9YebynyetsooHvXEeYrlZWnNfY0BNkH5C/OE90x3E=;
 b=VmON9lDuXjWItAXBfrvBUjtok6L5WX4xMKdE2ubwN4vY0qaN0IqtySFaK5tlk3VHdhaIvFEiHbI3xfgoKmkKfIEOZX3iHNuT1LjavlH+Esl/q4Lx7h6nF8F1+VmA9fv79M2N/alvLaVTuiMnHgWw8xn4paPb6iLdTi88Jb/LIGJBoSWdZe5Ty01REPVI1zvJpSG4cfKTpTp9sQTcWHfcet2aVVgtwj8nMOqahaZhiMF6SshojbedIthJQR2251fibsscnwI5tpue0AjjlOVcmhh9E0kyAZ3d/vF6xyPc9jj92XAA+BGB4LZ9Yx8qJddBxMWzwGj1uAU9tINxz05r6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH9YebynyetsooHvXEeYrlZWnNfY0BNkH5C/OE90x3E=;
 b=hwe070VGQpZNur7HBJmF2hBbpvEqzXTL2hguXx9ifhFla0UB1AIqtFaf4JtbbmXuUQkIe2XOhCmpZM41+Y0LBLfolqRmkl9yBWgjFjfsOUZL1P08ZU7IWy/0Drf+6d+xgLME6mrT/dhsmWsxfhHpX3VvAjiuVt6JxPni7OIwxRs=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 15 Sep
 2021 11:53:35 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 11:53:35 +0000
Subject: Re: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get
 extended report
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-39-brijesh.singh@amd.com> <YUHEnTDKEiSySY4a@work-vm>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <b53843a0-32bf-4d2c-59c3-238991f09979@amd.com>
Date:   Wed, 15 Sep 2021 06:53:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <YUHEnTDKEiSySY4a@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:806:28::10) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA9PR13CA0155.namprd13.prod.outlook.com (2603:10b6:806:28::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Wed, 15 Sep 2021 11:53:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb10582e-9018-443c-cbb4-08d9783f72bf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2448F0544C514B76630096F3E5DB9@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mydAAuo5EVrIzfapJu4oaGoQiv9YkQidHi0G0COJttQQnk23O2eRenE5HDx+J9o/vXC8ggmfdXeIHRmBCFefuJGU37QkVuz1u9+Ccg8UNaomTFLdfY/XCLK9s9Jvu8onDFfF2BqwXBKXgHMwr8vVpoCjwpcc3zlUS/TkL4ZJFU2bdq6ciONrxHwTDw5XVs/jVTIyuaqXwpec8llzVnJg0K3hVEqmE/W9RmTKT+91rdAuq+Emeo/gepAyealbiBaF1GARzOY6dKHlD/Wt/+QFngMrmnQn7cN1Z5zguDQkfoAUBBeueu4cR3phAWGF6iAsfIAK82KLVQpoAODskgaw7JdzCV3PYPGzyGtgUgfjkDOx2FPXAthNttdHVafVi79n1wtJbqK5z1m0sDge6zwIsjnAhKVtF+/eB4Ti3ZEY/YVosC/UO1+//zKVWMpTNsGB8NseuUY1ASeD4XAwLspkLvqntsjbWBAAo2TdoI5jwUmBnL9ZwxEo5Dwq5cwliJmZgUaYUWJGNqzFUIBqy5wnZAf/fk4Me3hFO9XvyiabPVs3pT03tIo6nrxrw49TfB/uLz+1sI+eUebxZOwt2zvfEYlCCs+wY8Sb+l1qQSGJ63rh9tWNF5HpKrAEhuQJyiwLjKe6RdpYZ0sWqTh/hrqNt0Od689cpklmaVApKq/3jupkskElhftOEce4p5G9buAjkcd5/6/WIfHlolmoAwVBES9RKOgJ36tvSvLmIvrMmg7Cucf0Dv4MZytCPpu44wGl0A1DE8fp1Kzu/n2P8spnYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(4326008)(7416002)(186003)(478600001)(8676002)(83380400001)(54906003)(6916009)(956004)(7406005)(6506007)(31686004)(44832011)(2616005)(66946007)(53546011)(316002)(66476007)(38100700002)(6512007)(2906002)(5660300002)(38350700002)(26005)(36756003)(66556008)(52116002)(8936002)(6486002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdzUkpPcTBLTWkycEU1bWZvQ3J6TUVaZTUvbHd1ODFiQjlkVEg1UkJtY1Nn?=
 =?utf-8?B?Z214YzlUa0xWam1yVmVOVEZhZXM2Rk9EQytFbnltbGJGRlpWa3hoMW9tU1d5?=
 =?utf-8?B?R2lldlpJZlRYNTlrcjV6NkxjeUMyZzBha25hNHV5WGZCSHFYaE5BNDk3cHNF?=
 =?utf-8?B?RFVrNEwwSktOL0lrZnI1SmJKeUwwdnd6VVpyS2pZc0taamlBUzI3YlF5S0Nk?=
 =?utf-8?B?dGgvMFFGRlNXTXkxSm5lb09NUjlMRW9JWWVSSVRCQXI0Unc2eklZWmtydUlQ?=
 =?utf-8?B?d0Y4RW9sT2g3dlZ6MFBMWmU3Q2tZaW9ST09jcE02Y3RaZmw5K1F4c3VvcCtI?=
 =?utf-8?B?bTZCZSt6WlJtQWJ6Uk1MdmhoNWJ6c3JpV1RaQVJVNk50RGp1NHlxN3ZrZmVY?=
 =?utf-8?B?MnE1b0IxbDlJbm5RWkNIek9rUEIyNDFHLzVqSHdNdEt2TFl5Y1BjQXkrRUlw?=
 =?utf-8?B?c2xiSzQyd0Y5bk1JRjVoM3Vac1cybktCM2RaZmpHaTBDMUhQZlhyMTFCR0xx?=
 =?utf-8?B?S01JL242dGwyZkU2elYrdHJPbkNUZUJlY1dmUHEvWi8rR3phcmF3L3RKRkZN?=
 =?utf-8?B?cDFKUHd0UDhCZTQ5ekFPY2h1dklDaGxWUmQ2bDJLa0s1WHdTWDhWdlJPUG1s?=
 =?utf-8?B?WHF0YU5NdWxGeGRXbEhvdWg3TENLbmhoNWJkM0t0cENCOEpZV3BxU0NKeXc0?=
 =?utf-8?B?UCtWaCs2SDR2dmlhNXlORHhwVnBEMm1VUnFQRHlFWVZkVTVjSmgxSDNhQXVY?=
 =?utf-8?B?N0RON2FiSHpkQ3dzSjBrZDVPTmdzZllFK3JtUW1jNUJMZkNrdks4N084bzFR?=
 =?utf-8?B?Wkh4ZUs5Mk01SGs2RnVNTW1sY0dGMDB0d2NoT0FDVExxMVFxNkcxY2JKVVp1?=
 =?utf-8?B?TG5tb2thblh0TDlQNWFpdXkwUUFhRmFJcjhNNzBUZHVEZ3p0c3o4elZiV0cw?=
 =?utf-8?B?SEVSbndMdlJvaXkvdWRaR25IaXBndE9lV2RWeDVqVGYyTXlTbXNXdmk0d3VW?=
 =?utf-8?B?Q1JjeUFwUHBMYzFmcXIwVk1jOUdBeUw2dHlwQ1B1Z1Z4T2tlSnIvUEs3cFkv?=
 =?utf-8?B?ck13OHhCTEQ3TXY2TGg5Z3ZLQmMvVGdYa29rc0RWekRoTzJicTVTY29yd2dm?=
 =?utf-8?B?aEVUTHVDK1NIZ3QxQ3dvNFRHUUk2NTBqSFloRmZNUTBqUCtFLzIvbXQ5N1ZD?=
 =?utf-8?B?Nm9Gb0JXblZxdXVsWW5lQjAzMGthTnY5elFVb0hFbHJiVXFPZ0diRDE0Ui83?=
 =?utf-8?B?eVJuVDY5bnpsaitoL2xPbUNoZ2VWYzVTejEzRlFGOWhtQnZDT29JWElOTWxB?=
 =?utf-8?B?OUdHNFZkV3lSenVLUW5jeDlrMm1JSHhHeE4xTHVpVGVTWTFjYVJlZGNGSUhW?=
 =?utf-8?B?d0dJSjM0ZXUzNnJQTVZ5Z2dGbkUvNytZcG0xZTVUb09aejNuNjlvSEY0aVVq?=
 =?utf-8?B?YzlRNE9HZzNpKy9aTE1aNjR5alVmc2tSbm5TZ09FNGJZUStEV2lwVXZENUM5?=
 =?utf-8?B?TklnYnN0SnBVOTY1RVBCWFdxSWZUWWVHRWNpOGpEajdBMEppdmh3aGVoZTRk?=
 =?utf-8?B?OUlUWG40MVcxaGI4QmdPbk9LS2trVkZNTVJFc09SaTlXZmtxcW1hL1FKdlMy?=
 =?utf-8?B?SjVMaFRxd3lweXV6OXNwVTMvMzNmS2hLSjVYR1dnN3VsVzY5UktlKzR3VzVS?=
 =?utf-8?B?OE9HRC9kRXhuOEx3bVJ5RWU4ZGpJZWRGN3BEakI1ZjVyc1c3ZmhySkVkMlVI?=
 =?utf-8?Q?pw24rjsKaJWgQV7zwsrVoY4tAiOTIcBW/1xYTVn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb10582e-9018-443c-cbb4-08d9783f72bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 11:53:35.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWJp03Fqn/rrYsu/sWRwDWcGaQcO3/D6g3zHaLK3aE0ItGl8hE4bM3Lz2jOMzYEI4c0W0YDkmw2wbrCXwJbHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 9/15/21 5:02 AM, Dr. David Alan Gilbert wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>> Version 2 of GHCB specification defines NAE to get the extended guest
>> request. It is similar to the SNP_GET_REPORT ioctl. The main difference
> ^^^^^^^^^ is that 'report' not request?
>
>> is related to the additional data that be returned. The additional
>> data returned is a certificate blob that can be used by the SNP guest
>> user. The certificate blob layout is defined in the GHCB specification.
>> The driver simply treats the blob as a opaque data and copies it to
>> userspace.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> I'm confused by snp_dev->certs_data - who writes to that, and when?
> I see it's allocated as shared by the probe function but then passed in
> input data in get_ext_report - but get_ext_report memset's it.
> What happens if two threads were to try and get an extended report at
> the same time?
The certs are system wide and is programmed by the Hypervisor during the
platform provisioning.The hypervisor copies the cert blob in the guest
memory while responding to the extended guest message request vmgexit.
The call to the guest message request function is serialized. i.e there
is a mutex_lock() before the get_ext_report().

> Dave
>
>
>> ---
>>  Documentation/virt/coco/sevguest.rst  |  22 +++++
>>  drivers/virt/coco/sevguest/sevguest.c | 126 ++++++++++++++++++++++++++
>>  include/uapi/linux/sev-guest.h        |  13 +++
>>  3 files changed, 161 insertions(+)
>>
>> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
>> index 25446670d816..7acb8696fca4 100644
>> --- a/Documentation/virt/coco/sevguest.rst
>> +++ b/Documentation/virt/coco/sevguest.rst
>> @@ -85,3 +85,25 @@ on the various fileds passed in the key derivation request.
>>  
>>  On success, the snp_derived_key_resp.data will contains the derived key
>>  value.
>> +
>> +2.2 SNP_GET_EXT_REPORT
>> +----------------------
>> +:Technology: sev-snp
>> +:Type: guest ioctl
>> +:Parameters (in/out): struct snp_ext_report_req
>> +:Returns (out): struct snp_report_resp on success, -negative on error
>> +
>> +The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
>> +related to the additional certificate data that is returned with the report.
>> +The certificate data returned is being provided by the hypervisor through the
>> +SNP_SET_EXT_CONFIG.
>> +
>> +The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
>> +firmware to get the attestation report.
>> +
>> +On success, the snp_ext_report_resp.data will contains the attestation report
>> +and snp_ext_report_req.certs_address will contains the certificate blob. If the
>> +length of the blob is lesser than expected then snp_ext_report_req.certs_len will
>> +be updated with the expected value.
>> +
>> +See GHCB specification for further detail on how to parse the certificate blob.
>> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
>> index 621b1c5a9cfc..d978eb432c4c 100644
>> --- a/drivers/virt/coco/sevguest/sevguest.c
>> +++ b/drivers/virt/coco/sevguest/sevguest.c
>> @@ -39,6 +39,7 @@ struct snp_guest_dev {
>>  	struct device *dev;
>>  	struct miscdevice misc;
>>  
>> +	void *certs_data;
>>  	struct snp_guest_crypto *crypto;
>>  	struct snp_guest_msg *request, *response;
>>  };
>> @@ -347,6 +348,117 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_
>>  	return rc;
>>  }
>>  
>> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
>> +{
>> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
>> +	struct snp_guest_request_data input = {};
>> +	struct snp_ext_report_req req;
>> +	int ret, npages = 0, resp_len;
>> +	struct snp_report_resp *resp;
>> +	struct snp_report_req *rreq;
>> +	unsigned long fw_err = 0;
>> +
>> +	if (!arg->req_data || !arg->resp_data)
>> +		return -EINVAL;
>> +
>> +	/* Copy the request payload from the userspace */
>> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
>> +		return -EFAULT;
>> +
>> +	rreq = &req.data;
>> +
>> +	/* Message version must be non-zero */
>> +	if (!rreq->msg_version)
>> +		return -EINVAL;
>> +
>> +	if (req.certs_len) {
>> +		if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
>> +		    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (req.certs_address && req.certs_len) {
>> +		if (!access_ok(req.certs_address, req.certs_len))
>> +			return -EFAULT;
>> +
>> +		/*
>> +		 * Initialize the intermediate buffer with all zero's. This buffer
>> +		 * is used in the guest request message to get the certs blob from
>> +		 * the host. If host does not supply any certs in it, then we copy
>> +		 * zeros to indicate that certificate data was not provided.
>> +		 */
>> +		memset(snp_dev->certs_data, 0, req.certs_len);
>> +
>> +		input.data_gpa = __pa(snp_dev->certs_data);
>> +		npages = req.certs_len >> PAGE_SHIFT;
>> +	}
>> +
>> +	/*
>> +	 * The intermediate response buffer is used while decrypting the
>> +	 * response payload. Make sure that it has enough space to cover the
>> +	 * authtag.
>> +	 */
>> +	resp_len = sizeof(resp->data) + crypto->a_len;
>> +	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
>> +	if (!resp)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(resp, (void __user *)arg->resp_data, sizeof(*resp))) {
>> +		ret = -EFAULT;
>> +		goto e_free;
>> +	}
>> +
>> +	/* Encrypt the userspace provided payload */
>> +	ret = enc_payload(snp_dev, rreq->msg_version, SNP_MSG_REPORT_REQ,
>> +			  &rreq->user_data, sizeof(rreq->user_data));
>> +	if (ret)
>> +		goto e_free;
>> +
>> +	/* Call firmware to process the request */
>> +	input.req_gpa = __pa(snp_dev->request);
>> +	input.resp_gpa = __pa(snp_dev->response);
>> +	input.data_npages = npages;
>> +	memset(snp_dev->response, 0, sizeof(*snp_dev->response));
>> +	ret = snp_issue_guest_request(EXT_GUEST_REQUEST, &input, &fw_err);
>> +
>> +	/* Popogate any firmware error to the userspace */
>> +	arg->fw_err = fw_err;
>> +
>> +	/* If certs length is invalid then copy the returned length */
>> +	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
>> +		req.certs_len = input.data_npages << PAGE_SHIFT;
>> +
>> +		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
>> +			ret = -EFAULT;
>> +
>> +		goto e_free;
>> +	}
>> +
>> +	if (ret)
>> +		goto e_free;
>> +
>> +	/* Decrypt the response payload */
>> +	ret = verify_and_dec_payload(snp_dev, resp->data, resp_len);
>> +	if (ret)
>> +		goto e_free;
>> +
>> +	/* Copy the certificate data blob to userspace */
>> +	if (req.certs_address &&
>> +	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
>> +			 req.certs_len)) {
>> +		ret = -EFAULT;
>> +		goto e_free;
>> +	}
>> +
>> +	/* Copy the response payload to userspace */
>> +	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
>> +		ret = -EFAULT;
>> +
>> +e_free:
>> +	kfree(resp);
>> +	return ret;
>> +}
>> +
>>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>>  {
>>  	struct snp_guest_dev *snp_dev = to_snp_dev(file);
>> @@ -368,6 +480,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>>  		ret = get_derived_key(snp_dev, &input);
>>  		break;
>>  	}
>> +	case SNP_GET_EXT_REPORT: {
>> +		ret = get_ext_report(snp_dev, &input);
>> +		break;
>> +	}
>>  	default:
>>  		break;
>>  	}
>> @@ -453,6 +569,12 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>>  		goto e_free_req;
>>  	}
>>  
>> +	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
>> +	if (IS_ERR(snp_dev->certs_data)) {
>> +		ret = PTR_ERR(snp_dev->certs_data);
>> +		goto e_free_resp;
>> +	}
>> +
>>  	misc = &snp_dev->misc;
>>  	misc->minor = MISC_DYNAMIC_MINOR;
>>  	misc->name = DEVICE_NAME;
>> @@ -460,6 +582,9 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>>  
>>  	return misc_register(misc);
>>  
>> +e_free_resp:
>> +	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
>> +
>>  e_free_req:
>>  	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>>  
>> @@ -475,6 +600,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
>>  
>>  	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>>  	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
>> +	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
>>  	deinit_crypto(snp_dev->crypto);
>>  	misc_deregister(&snp_dev->misc);
>>  
>> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
>> index 621a9167df7a..23659215fcfb 100644
>> --- a/include/uapi/linux/sev-guest.h
>> +++ b/include/uapi/linux/sev-guest.h
>> @@ -57,6 +57,16 @@ struct snp_derived_key_resp {
>>  	__u8 data[64];
>>  };
>>  
>> +struct snp_ext_report_req {
>> +	struct snp_report_req data;
>> +
>> +	/* where to copy the certificate blob */
>> +	__u64 certs_address;
>> +
>> +	/* length of the certificate blob */
>> +	__u32 certs_len;
>> +};
>> +
>>  #define SNP_GUEST_REQ_IOC_TYPE	'S'
>>  
>>  /* Get SNP attestation report */
>> @@ -65,4 +75,7 @@ struct snp_derived_key_resp {
>>  /* Get a derived key from the root */
>>  #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
>>  
>> +/* Get SNP extended report as defined in the GHCB specification version 2. */
>> +#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_user_guest_request)
>> +
>>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
>> -- 
>> 2.17.1
>>
>>
