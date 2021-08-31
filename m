Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF53FCEEA
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhHaVFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 17:05:13 -0400
Received: from mail-dm3nam07on2045.outbound.protection.outlook.com ([40.107.95.45]:7768
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233319AbhHaVFM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 17:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksvM4hsHFj4dhA05NVNOCIZa30fpPrj+tBFQbGZdqxNR79ugeArXgzdkdnzE/cfm5e/j3Txjh3NRNdi3kKMcaC2syePWvTh4phOqJVpRy9pHnrDvsqC+WfMJgyZ3V26eHofQioGWlUNC6IMBfkmCKT8f72uAlmYW/O6/iDLFpw+H2nhOla/Q9pKQtWhroyibo4hKtNdfS40QyvF6aHSCGUWppyt8ouCi2DectkeclU0gcxu/gILW55bbXKV9xcJeF+6O+k0DBz0tDdUAU/2Sicj2WdpHUaCt6dK4CNGa/jv8a6o5Pyn+/oJMRn+JsvalJjkHMWgUzuXicVBBliDt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jGmHyKVwerkxJOFgNb1LNGyrKwd3KdmWIKIczauP8M=;
 b=HAcKFvz3TgJDZ6rSMnsKPhjgB7+lv2hJqIzcHcql2/pAUpPjy/lwRuOHM7b3IQVLZGT0ikgcXiK68xfcFutx7Pr4WNtSK2vbVo4H/NYqGkXUHXOMMj2KsktV7u5jagMIseZzuSWGZwvsRhZjk1iW0tf9PR2ftjqfUiMJzvek6kXXCa6c5+uKRK6zSdmJiOQR+PcJpTk/4b09hlBVUsr3uEAnE4lUvaXAiQIhz8QUtRfMxdQcATXbFYwHtJntf/jTrYOxX9KgUZRnktESh8hXH3Pli+GCSUdI56rw+ys3W0UXmvmeLYk0qxmPEsFnpP5qMeXX1yf0zFAzZiWmb6aoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jGmHyKVwerkxJOFgNb1LNGyrKwd3KdmWIKIczauP8M=;
 b=2/fCSM0V1U7g+Jl2q9PS34Gve82+u8c73IZj6qbbN0QFGfYcPbhfiTGAac3t1n6IjPMJo6aSWPoUwj7CgoDuFJE9BZlYTfu+cXi8s8FghS+YF/4NmfYVFj8YJToJBHjxQnRD9B22gCWlcVRG7EAEg+S9M+7NAq+Y0TzosDgP7jY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 21:04:14 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:04:14 +0000
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
Subject: Re: [PATCH Part1 v5 37/38] virt: sevguest: Add support to derive key
To:     Dov Murik <dovmurik@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-38-brijesh.singh@amd.com>
 <a6841be9-a2ca-8d92-3346-af8513b528fc@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <fd9fadae-a493-1d8d-6777-e1c789a5113f@amd.com>
Date:   Tue, 31 Aug 2021 16:04:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a6841be9-a2ca-8d92-3346-af8513b528fc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0151.namprd05.prod.outlook.com
 (2603:10b6:803:2c::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0151.namprd05.prod.outlook.com (2603:10b6:803:2c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Tue, 31 Aug 2021 21:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c0af22-60be-4603-abae-08d96cc2e345
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592535A13E2711ED28EAB15E5CC9@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeHG26F/YTmqdsPhduIEPD3G9Xp/FQyoxKe5F4h/3rJJ652c022LTzJMeo0cHjrOakZ+QcAtAgs8GmTuJfuf04KfK1F5/oxzxlXOLbLnMZCsTdM04tu17HG6b1VLh0G+8dDVTlsrYGSwLrrXdqgVaOHliHrEOs1aYbV574IexUfYvzNNE+248TQl2dZexnmW3xBFaFt9yRR0v6khFX3gkOs06Rc+CNBj7tOwa4Nqu6DRmWxsJg2c3mUQoQlpleawNr7X6VNPbwbi7xkXmqrd8G75ILXEEk3gP4h/M7HSGwBHgebKaBaQ0ElXoDVuSznQxYZtVERVRAbHh0h/A/0qxJ+RLgX6ICQsfLYRV4PuVb/updTJ0jAjMJp6nB3QPMhpl6cchk0a0/W7qO84HFNb3Ae6swYj707sKmiWbO2wPlCUDjdyA0tD5/z2EQPWgEujp/7hHOZb9URcIlPYpEnqqmZ/Qzf24giNUvNje2nrePOelba4zzlFan/174Ek6ntF2r59xwNDZWMy9vEtgqgS4fjJ86ZoJgQhuRk5DhxJrrb7Eybp86ZrekdbADgimXyI1y5BOlBmvB5jWuA4L9z7tLLu0TG9YeBjVvc8fwXXjXAQoMRy1UkMEiOOVIAaTlSorX9KmwzyWg5pMt+/SAEdULxTFumS2xcqvoOmkbYi8lys9nKxGXeZqUf2ENCIzot99nM8aqwEOsmQsVZBcUJvLLAD1hTZx84nrFDnS6SqI41MA2q0tiQmX/8sHFhzm+MRsu0s3AFSFgi/sXAZjHXrfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(44832011)(52116002)(26005)(66556008)(8676002)(38350700002)(5660300002)(53546011)(66476007)(66946007)(31696002)(4326008)(2906002)(36756003)(7406005)(6486002)(31686004)(2616005)(478600001)(16576012)(8936002)(54906003)(86362001)(7416002)(83380400001)(956004)(38100700002)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FuQmNhVGhQbUx1NGNKRkxoajVqSktxS0ZiZnFjbWdFZDhnNldrc3BQMTRG?=
 =?utf-8?B?SmhCa3ZnZXlyQjdORzZNSGF6UnVFbVRUN0RZQzFYaDl4RXhLV3RDS3ZOQUNB?=
 =?utf-8?B?YzY4NFZGcHBnR1hxSGRqQ2praXRBd1RLM2YwZlBqY21aUmEvcnUwRVM4RGwy?=
 =?utf-8?B?ZHpudXdpVEttMzBicmV1UExtNW1meWlFVGViemRVYWpndVVMYWRoTlMvYmdz?=
 =?utf-8?B?ckdENGJSeDV2ZHRScFNIZTBDclhWSGVWb1cxUy8wTS93d3JVTytWR2dqOVBL?=
 =?utf-8?B?cGxVWTlvYm96akxnVmdwWjJ2SGFYUGZnSno0UmlDOG8yVkN6WWdsanRad2pM?=
 =?utf-8?B?bU5hT3hyYmNkYkUvOVova1hOWC9RalhxTFNNNjB6aDVxbm5MSitqNElJZlZH?=
 =?utf-8?B?OGx0U1U5WWJCR1c3bXVlSEoyVExsVjJPQzY2c0s5UDRPQ1BVb0Vua1dVeGlt?=
 =?utf-8?B?M0ZabVdMRjViR3hDUjZPMVE3aENlOFZRLzMzREhPbktTbHVvRkVCSHM5cmIx?=
 =?utf-8?B?SXNuVFA0cVI5cWNIeEp6M3NUaU9DNjE4cDBydW5NV25OMGtXK2s2RFZNU0hm?=
 =?utf-8?B?OSsrcXhKdFYzWjRzWEJWcS9DdUxpNFlmKysweHdKNUhRUklsUzl4OFRBbklB?=
 =?utf-8?B?bkVnenl5ZS9ka1VOSWRwSUJnb0ZjeUc3ZWd6R3ZOQjRyalE5V24xWnBBa1lV?=
 =?utf-8?B?ZVo5OW4yWHVjRWFJSFNBcjh6bXVzeEVKTkFkZ3E5LzVpbXFNc2ZBYXByeU5H?=
 =?utf-8?B?ZmJ1eDVaRXZWUWg3enNHNGNUVUZka0thSGEwY21PQUtFVm11TTA0N1ZYV1pN?=
 =?utf-8?B?dXBWTXNtYmN4MXE5Uld4T0pXbTRibUM4anE5cUpiaE9BYXhLNU1LSHRpYTcr?=
 =?utf-8?B?aEwxN0lVajFWNlBDeldOWlY4WnQvQjdCd1J4MVBmZEloR1lQVncxeDlVajVz?=
 =?utf-8?B?U1ZKaW13VjVDTjhWNEVVSzAxK3JpNWNKeTlZN0dhYTV0cVFUcE1sUUprbFlW?=
 =?utf-8?B?dHdiR2cwSmVQQytEVzFwbDk1azg5TmltT2x5U3IxcFByWDFUSjZEbi9EMndZ?=
 =?utf-8?B?Szl6OTFnMmRCNm1zYkJpQlE5NE02TnEwNStlb215amhHWHF5WmVmbGlMNHBw?=
 =?utf-8?B?Q3VjWmY5YXVkRS9hYTU5YTlobjBRTlFIRkowS2dyWjRLaTFoWVpkZmNJeC85?=
 =?utf-8?B?R3l3Rkx5QlhRNlVndmVEdW9FRExDdUE4dC9RU1B2SG1RM2ZGQmY1dVRXa0ZO?=
 =?utf-8?B?SE0zcmFNQjZpUjFMekFaSnVWdk9HYkVHcVF3eTRnQk9JRVp3STZBcTBnbE9V?=
 =?utf-8?B?TkdNT2FISTJtZHk2OEFpUmZJVjZaVUZEM28zbE9MRXc2d1JHLzZUdDRYUHJ5?=
 =?utf-8?B?ZVV4a3lCbHB3cloveXNCbStqOFBvMVNkdEVVQkRWaFhlUnZaRk41SXJQNlNT?=
 =?utf-8?B?UkdESnhrQ1RlMmg3c29hUnBiS1BQUWtjMVVzSzVuU0g4a2xjQTF2YVI2OTQ1?=
 =?utf-8?B?UzF5Y2NSTWtHQ3RIblQ4SWxwWk1GL1hmaFJXcHJTOWdWYjNsZlJHa3J4TUcv?=
 =?utf-8?B?b2NTY1RSK0pGK0cxK2NITDAveXZMeElkQmFPaDZHRkNZSXAxS1p4UGs5MCtp?=
 =?utf-8?B?dW9vNHF1dmtqL2FCOUdXa2FRSUtnNEJNQTE5MkhCa2FJUDRQWjQzbzMxNU5S?=
 =?utf-8?B?WmZDZHNIajcyRlFzYTFyazVpRlJhaHZmaTlOd2JxVWZPY0R4TzEyLzJTWWUr?=
 =?utf-8?Q?ZKVkw2y8AQWlGD7IEKzscC4eLexA1QH5rYtLzCj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c0af22-60be-4603-abae-08d96cc2e345
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:04:14.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K8P9ywndkV1kmnqadWU3nys18TZXKCgPZKedn/I5Rf66+972MglhxLt9K+ImHxXh7E+JeVUrEmKj0EbONWOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,


On 8/31/21 1:59 PM, Dov Murik wrote:
>> +
>> +	/*
>> +	 * The intermediate response buffer is used while decrypting the
>> +	 * response payload. Make sure that it has enough space to cover the
>> +	 * authtag.
>> +	 */
>> +	resp_len = sizeof(resp->data) + crypto->a_len;
>> +	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
> 
> The length of resp->data is 64 bytes; I assume crypto->a_len is not a
> lot more (and probably known in advance for AES GCM).  Maybe use a
> buffer on the stack instead of allocating and freeing?
> 

The authtag size can be up to 16 bytes, so I guess I can allocate 80 
bytes on stack and avoid the kzalloc().

> 
>> +	if (!resp)
>> +		return -ENOMEM;
>> +
>> +	/* Issue the command to get the attestation report */
>> +	rc = handle_guest_request(snp_dev, req.msg_version, SNP_MSG_KEY_REQ,
>> +				  &req.data, sizeof(req.data), resp->data, resp_len,
>> +				  &arg->fw_err);
>> +	if (rc)
>> +		goto e_free;
>> +
>> +	/* Copy the response payload to userspace */
>> +	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
>> +		rc = -EFAULT;
>> +
>> +e_free:
>> +	kfree(resp);
> 
> Since resp contains key material, I think you should explicit_memzero()
> it before freeing, so the key bytes don't linger around in unused
> memory.  I'm not sure if any copies are made inside the
> handle_guest_request call above; maybe zero these as well.
> 

I can do that, but I guess I am trying to find a reason for it. The resp 
buffer is encrypted page, so, the key is protected from the hypervisor 
access. Are you thinking about an attack within the VM guest OS ?

-Brijesh
