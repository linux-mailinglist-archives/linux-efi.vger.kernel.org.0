Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297354040A4
	for <lists+linux-efi@lfdr.de>; Wed,  8 Sep 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhIHVpu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Sep 2021 17:45:50 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:63809
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234144AbhIHVpu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Sep 2021 17:45:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvLwoNCe3phO75fKiKKNVw4bR5RHg5XiRyyrfp2uGneALj3DHzrelGr0JDXem/U/t1KBpydoipmnVhgVsx/d2cK3OjZX3/GxkvxwhPInUZNETNgdWDZ0+9syKG0qenEjpx5z1OeW6bnUYNtOtdcT52k7DUWmooeYPcII9BMGrN2go2Go+LyEYCI7zi/Ogou4bg9mOTcCpmQeO/2eAi7kp7NHsj8WOnrVLFOsyLyijmE8/8yB6YVHNEvb3rG+NM0SK8tWNLro4xKxUfNfp8dvXJeUhg+bHj7pqIDO2LU9um/vl+7fn+d4uIKoQ61Ebo4LYtpZcVgR4WII67ZK+sGkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZnrZcta1bzW818yIsYwrAB1d94oKHUAY4c6L5O89duE=;
 b=Cq3G695j80TBRKVMF5NrF3f+mLbNYt21J8EAQGpCyVBVEjMIs/L7vrL8lcHI4eHX+/EK+DRiXC8/tHtNs2EYS04Am7UyNYsIb5fvIFTfRLfNQ+n4fi2Z43paRy3MWWZCTayftQy334Co4UHFTsO2SnUKptWERTnBcxZNe+uajN/Mt9/+C0N0VmxKvhMNoN9lXF8q7vH+udH8Xe1LboyYYejAISf8BAjir13TvdPiDXM0FRxLgxekQvQXY/nYb6oUckovRAoBb50F4H8WsS2xc/Oduixipx5k0CEPKzgT6BeckRtHCLfRsK8doAGxqPgUnTjUupoF8qF8l5c2IVrVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnrZcta1bzW818yIsYwrAB1d94oKHUAY4c6L5O89duE=;
 b=AEvecQlMlLqBdjI4M+Wbb/fpB7+QOHZndaKLCB7N5JrfVkDmIcpR2iWR03ZsVgwfIY8h2yHbb8WgtpfGScgWbtqG1BHdoy88pyfXkJhRz6Tq5MMUUcQjGGUyLRy4s51HdgMKFuR2kspw+xPrUZVg7jQr02AWu2t1WaVFgWbhiuQ=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 8 Sep
 2021 21:44:40 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 21:44:40 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 37/38] virt: sevguest: Add support to derive key
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-38-brijesh.singh@amd.com> <YTjB/KTBsqExqylc@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f2d29f4d-f020-0036-c2c8-2b4e993d3605@amd.com>
Date:   Wed, 8 Sep 2021 16:44:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YTjB/KTBsqExqylc@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15)
 To SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 21:44:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cce7ef9-2560-414a-f2c8-08d97311dc22
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43825081AF368F8CEC5CFC6AE5D49@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlsaIQOKo82/XfehscPOOEtBPxq514VLCbSQrFDs1JmIwqr4NPpNYISe6guHigfKhUM4T+XAVQeb5SzSwCvfmZe3Ci8t41HekVncR7CcGbknVzFdjaUnUmYGaBMaBy4QuqeyBCmNdyPd/gIYjblvYvDyo91LXdKuoPTrUqo/twAb0JtIkeNsqEzaE1aquv01BnvPupK7Un2o4VOAlVXD9JhWHE4/SJVmXePFp9dSEUPX+iClyyMkTOU/Qd+OgrVd6xnUXAmhhPkfg5gsmn994z6gNfahopNNtX63aXtJqN+5RcVLtf/0zlDr+6hDHSPrM042YjQGK+tHhT/bYpiiFxn2F1AzbnhvH0Tw/GdrcTPnjrrLGCJ77+NjPO85UMG7TLLj04mClp6bOK5ixkdDDSBtRVdOxgs6Li0k0wI7zqPoF4t2mtP4YydgxoPl/7rnD0+25ByUVewKpAwoahcb8YXpltvUTGI35QrGNNQ6T9D3XkdSDIvABw8HEImW8UzQHZ3dJ2yxmEYWduMaJCqCXJzWhNQXLm1XwHmdPuOvgmheZ9zOK1gnRUgoAyGD+wvaQK3pTQTk1lQ6d380KU7OXUzX88Yk4sk9F9nANdhwKtedb5jQnEY4Zj1r366DS5N+Os9SdYV4sxniwXdxSr8YTIkxjVzNjTlsmHXaPezBgsRU0VNXKSWa7aKFuq4iHazPTc2zw6bn8m2aPG1eVqehBd9ByQtBSGm98PMtBlf6e9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(83380400001)(86362001)(5660300002)(53546011)(8676002)(36756003)(66556008)(38350700002)(38100700002)(316002)(31696002)(66476007)(2616005)(6486002)(2906002)(7406005)(7416002)(186003)(44832011)(26005)(52116002)(31686004)(956004)(6916009)(16576012)(66946007)(54906003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNtUTdSUkNzVFEwYzZzTTgwOW9iSFJZb3J6aTJpRDZoT1hzRWw1YnRUblov?=
 =?utf-8?B?WWwwQmwxWnpueUQyVlhNaC9vUjJMc3IzbTdSaEVQdTdmYzRIV1NTWk5hWnVO?=
 =?utf-8?B?TVI0V1h4ejg1eGFwblU3d0hJeFZVZ0RRQUdHNC9DaFVnNlRDSEV6b2VZbi9B?=
 =?utf-8?B?b1VzQ0ludTIzdXo2WkZpMmNxVVE0NDByRXUyRlVmSUVVeHZoMEgzVkozVTJv?=
 =?utf-8?B?Tld3a3c2YmQ5eDJwUlM2eHhYNGo5VTBHSGFQUnlEdEwycW5BMUlKUzBNYWVU?=
 =?utf-8?B?ODA1aUVHU0xYNWV0MHEvYnRxQ0tkY3NYN1pqRWEybnRYc1ZSTmJWdXRkbTQw?=
 =?utf-8?B?VUN3VzZ3WmFKclZ6NHlRa21UbHpsY3NqWFJSTGtVZko2VDB0VitjMGk3eHlU?=
 =?utf-8?B?OFg0MTZGSFBlQVQ5WVYrUVNGSHVPU1J5Vk00Mm0xd2dONVBjT0pudDc2OU1y?=
 =?utf-8?B?SW1PM09IZDVHeCttYTNzeXhkVHl3NTZ1WFRxbXlCY0NZQ0NTelJVWkNXZmpM?=
 =?utf-8?B?a0VEYnVERFcxamo0ZzcyZjJpVTNPMGxld3NTVHpMU0doMCtCMFFQdGlhZFdy?=
 =?utf-8?B?OUJXcEliR1ZLSS9NdUpjcTljREJxM3F3czBSc1l1UWF6dE15WGpwZjZyUmh2?=
 =?utf-8?B?NnNoR0orM3RRaGk2bjNTaS8rcDl2VlZLblNQTHdXRnlhNDc5c3FPUEQ2RkF3?=
 =?utf-8?B?bUxBaHFKbS83akd2UHFCNWxiQmNUbFZWR1V0ODNBTytmYmdSMEU3YUNLdmg1?=
 =?utf-8?B?L0FhWG1mTTJ4YXY3bVZjeUFua0VwWVBXeks2dkV3UG1JeFJybmYzck0rRHlr?=
 =?utf-8?B?UjgzM1I4Um5FN0tyTkxsMjhtSHBDKytxQmQ0bm5ka24zOXN2eS8yZHVzL3Jw?=
 =?utf-8?B?bjdnei93Qml1SHg5T0RLSGlQeUxNR2pVcEhKQXFuUnFvN1NjNWhYVzA2NGcz?=
 =?utf-8?B?NS85ajZ6V0w1TGdYTzd6QjZhYm9rRmJ5dW1wOHQ5Q3BjSlBXWGw2ekJ2b3pQ?=
 =?utf-8?B?ZUlGOEJGSzlqOHBxalh1RGZiRFBIZ0dORHBMM0pIejUyeDN5K09GczBVK0tB?=
 =?utf-8?B?c3VDay9DZ0NXLzFIOEdneWt2S3NVNnY2ekNpRVVEWG9rTnZGYUhtVDFhYmJx?=
 =?utf-8?B?eWk0YmRmWEFMZ0hCanphWjg5TnNhRXVBcjNoeFVoaEM1SHVzdE14eGtvVVZS?=
 =?utf-8?B?WllZK1RvOWNrSUJYZ0MzUTVwbnFPZFc0MVRodnVINTVxcHN1QkowTWU0ZkF2?=
 =?utf-8?B?eUljTEtCL0l0a3Fzc0ZaNW8xdEhFZEJ0MGh3bFp4TmRnMko2QzIxc0V2VWt1?=
 =?utf-8?B?QTdOVzNpRE93T0ZSaDNiUkNyaGxkRzRCR29zTnhWRVZja3UyaFp6S3V1UEds?=
 =?utf-8?B?VWtoYXNXVHlkZDlVb1NnY1cxMndRelNRYlZlbnBSa2RwWE00VjcxVU4yeGta?=
 =?utf-8?B?Tk9HMm0ybEhUTE5kL2V2ZytQV3ZXWVBjK2VTRXV3b0xGMUNwZm44UXc4eU1N?=
 =?utf-8?B?Sndpa3hzTEc5a0gzSTlRUllvWWwya1BUY2R5MUJ6NGZVaFhYTU42dTdWRUFy?=
 =?utf-8?B?NEVSMkJUUmRsR3EzaFJpQW9JaFpFRDRpVm9zSUpSV3B6UlNjT2piTGh6R1ZN?=
 =?utf-8?B?TzF0bDJXOXNnSWwxUUtKY1VKMnJCNC9kZmNWcVovNTFGNjBzVHhZS1hBc0pJ?=
 =?utf-8?B?dC9jUGxwNlNHOXFKNzl2b0ZEakNsclMvUWZsc0ptMFhUeHNpVkg1YzJWUWRp?=
 =?utf-8?Q?nVotyPr5ELl1FA6g1QWjvE1ICzD+ukHX3l4B7g6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cce7ef9-2560-414a-f2c8-08d97311dc22
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 21:44:39.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7UQQANIi3yxVWRs77KkhAwKsOGGC0uiUGueNn6HyudlGt1BehxMcR+0c5+HXN5aaFITblbp77R5ybCz15tpCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/8/21 9:00 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:32AM -0500, Brijesh Singh wrote:
>> +2.2 SNP_GET_DERIVED_KEY
>> +-----------------------
>> +:Technology: sev-snp
>> +:Type: guest ioctl
>> +:Parameters (in): struct snp_derived_key_req
>> +:Returns (out): struct snp_derived_key_req on success, -negative on error
>> +
>> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
>> +The derived key can be used by the guest for any purpose, such as sealing keys
>> +or communicating with external entities.
>> +
>> +The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
>> +SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
>> +on the various fileds passed in the key derivation request.
>> +
>> +On success, the snp_derived_key_resp.data will contains the derived key
> 
> "will contain"

Noted.

>> +
>> +	/* Copy the request payload from the userspace */
> 
> "from userspace"

Noted.


>> +
>>   static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>>   {
>>   	struct snp_guest_dev *snp_dev = to_snp_dev(file);
>> @@ -320,6 +364,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>>   		ret = get_report(snp_dev, &input);
>>   		break;
>>   	}
>> +	case SNP_GET_DERIVED_KEY: {
>> +		ret = get_derived_key(snp_dev, &input);
>> +		break;
>> +	}
> 
> {} brackets are not needed.
> 
> What, however, is bothering me more in this function is that you call
> the respective ioctl function which might fail, you do not look at the
> return value and copy_to_user() unconditionally.
> 
> Looking at get_derived_key(), for example, if it returns after:
> 
>          if (!arg->req_data || !arg->resp_data)
>                  return -EINVAL;
> 
> you will be copying the same thing back to the user, you copied in
> earlier. That doesn't make any sense to me.

I will look into improving it to copy back to userspace only if there is 
firmware error.

thanks
