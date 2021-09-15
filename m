Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1040C48A
	for <lists+linux-efi@lfdr.de>; Wed, 15 Sep 2021 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhIOLsC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Sep 2021 07:48:02 -0400
Received: from mail-sn1anam02on2060.outbound.protection.outlook.com ([40.107.96.60]:45879
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237593AbhIOLsC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Sep 2021 07:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyOjGZedECRJI36RVz3fMX4CGneT1+uMvRDWBMye9FmWD3j4IAcMXkhQ+u7rIM7p2Xxc8SE04bWHeM/DB+99ItCVCGUdGkFtUiNGQcJMTzhfCZsgwsP8DHZyt1sxq6QcZD3xymThBFmvOLICDYXhnKPDaZ1jtgdSrbqrYyv3kSB+hL0kKfFhDC51DDEA71x3tQ6T55fbp13UiG7ufc5O2mzBHXYMHqupDunFlxuY0hraHFeRxXj4N9wltkvUHiJsxAM6MXnPWo6prp/1GCUwf612bLJKJl0gYZNy9joWYyar1X9byMDQjpV8F4bP1gkmjW22ijdfvR2wUifqtJP3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m2WnJNX03slbaWSrkxam1qa+Zp8IWSMOevG99AoRAB0=;
 b=eF4iJ75IV9atsMmFxPPmXmcEP7Uu17ZyRXucsUcSJqpt1YZtvNVrxPfHDVqxd7526jiUDLJM3CtgoNPapaTs4BErW0eW1XatXuVE8+gJ4cXLDrMQ9yYTN08q42j7fZjRCa4wWntHgqV82OmOkeVDrMgyDpEUQm4SATSeWDZnfcY+hNsWP7se10oKsXPhLxvrlPpQ4MUg9W0v1fpklgGESUXUH7vD5BUtciOGis2npO8KIRKY+svnxgz7zrXST24VNiNyyRf3JkQYrRv4TKN9ln/R0w4aQifataqTyYQ5B9ACoyS43BuT3O0ZUw3vnjxBcS9KToFVlWu3NGrhHLvOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2WnJNX03slbaWSrkxam1qa+Zp8IWSMOevG99AoRAB0=;
 b=MjBIMQc0M/TqfqtBSk8qtOBQqTxLh1WQiN0UHKr+UXFBuEbCiUIYQe1qoUieKxghl/V2yOzXchFCXtonpJgfFRv5CHK576FI8Gb+cae85qbyKucl8Jfodu3A79DkyioVLMqjmhy4OnHlKALOBLzmmLrripEtI3hhhC6JkXDzkH8=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 11:46:37 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 11:46:37 +0000
Subject: Re: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get
 extended report
To:     Borislav Petkov <bp@alien8.de>
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-39-brijesh.singh@amd.com> <YTj4kZCTudDauIn1@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0e15e6e4-38f6-75fd-1c8f-0dd5a81e54f4@amd.com>
Date:   Wed, 15 Sep 2021 06:46:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <YTj4kZCTudDauIn1@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:806:23::8) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA9PR13CA0063.namprd13.prod.outlook.com (2603:10b6:806:23::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Wed, 15 Sep 2021 11:46:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e539707-3755-4c5b-db44-08d9783e796a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27684F26DFC7F29CEC9571B0E5DB9@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcDdjgjls7SxbtSxL7CkNBISV3yn2iGCElg7yi1E7RQDDifR2/CfTB2aDHMdrf68Nzgj9X7fagb6tKMsm+vSWJH1pBKYvNmOIKSDWxVSIvqJEC3atP1T6807dWxObf12I3XD/wPt8uXsekB5SOoPmvwlmiipE/oT5Wzbbb/baChSrTigUlnBv2RtUVQwx0+6aVstIwRvrj5twW6EGqjJUxvrg/0YWnfwRegpxaRJsRe39Dwwf3POfM5vOXjWDVzB1ZnTDaKAWagPzn5VsPnxZIN/PJOeUFqwRQcft4pzVJxZP9XFiUdP5g8wpj6eymEBcQfWlKxE4RZV3DJ/L0AWvj/hqaMi4tnDRRpo/lYYpzh2FcxY9eK0PWCKcwdehHiIe4mYb2GUCw3Ehh8MPTRB+6u/dHnan+Kjybeo1m5O4dAMDs8RKU+5Pb4zvpAkz/dEVy0N23oN1FNCV6atEI1z3A9pgq3ipp25OmRqBqDoMUlwx9/WtR8D7DfgpN5kE8d8x3KoaAH1h1HdyTy9lbRZicBucPz3+DyW2O42L3X2lBlxJCdwp7Cpv73QYcFWB6uQ+nrmVtNfjfx9SKmjpwwnzcT0sn3cvYNeeqHjuhHG7fqCQHmmWkg+gOjhqkRFkLc3dsLpU5KUd5pLNlb0H5ueSk5CsYsqKMQqroCzXEAOEvhBQojKua5fgsHQ8oDWryuLPYI4UYigf1Q9mHDdBUOPjgapFBVIYzu6fF53rYkWkNOXsZ8QwlWQGs1T41dVAha1VqcQPGikeUBBm9cM3coACw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700002)(66556008)(66476007)(38350700002)(6506007)(53546011)(52116002)(2906002)(2616005)(5660300002)(31686004)(26005)(44832011)(956004)(31696002)(478600001)(6486002)(4326008)(83380400001)(186003)(66946007)(86362001)(54906003)(8936002)(316002)(6512007)(7406005)(8676002)(7416002)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hzSmR0VGcyTE9RTXdCSEVqMDk3NVZ0UGQxMGFJb1ZjcTJ0SXcvTDEyMnpu?=
 =?utf-8?B?R2hBcHRScjJ0OVpqZXdveDJ2R3hadkp2TE5TdmRRR1drU0JKUmdtNWlWNW1I?=
 =?utf-8?B?SFVib1F4NGJqaVB4SVYyMmlGVUR5NmQ0ajQySVNuZk14M3dsSjF3VUcxOFBD?=
 =?utf-8?B?Zm4rOGFDTTB6cWJMcTJJQWdmcnNiTFZrbHZRZjhqQ2xMd3p2cURYM1VNZnlL?=
 =?utf-8?B?d3BiclJWellXb2M4bDcrZFErVDZ1Y1FiUzdnRWRyTm5uNDZTTWlMcWhzVmZW?=
 =?utf-8?B?WDlNY2g4NWdobXROZ1pYV1ovZTNIVzQ3RFRpbEVqaEZLYUpJaDUyWEtmN01E?=
 =?utf-8?B?Uzl2NDBkQ1htQU9qZjduMWIvVTFJVCsvZVRQMHZyUDVyaE9KQW9SU0VKcVRE?=
 =?utf-8?B?U0ZheDNJNUJiTUYzY2RvVFpaK3BNY2F5d3QxZnZmVkZrOXRDV0EvQ1RURFNW?=
 =?utf-8?B?VXVUTzR0UXNoVW1JMjk1eHh4NW1nc2NTWEp6VmpJenBnUFNhOWhlWGpYZk81?=
 =?utf-8?B?TmtwbUNTUUcrT0lmMVVPMTFLVVlTTTBSNEkwSENsTzVvM1BtWjV2ODdDdTNx?=
 =?utf-8?B?eHNEOTFUblh6N09qZnVqL0ZSN3hvdG5ieGUrdVRXWllMVVI5eUtralFRNmVP?=
 =?utf-8?B?aGZ2Um1RTXduTFBJMjc5OWNnTWtUMk1pU0hjM3ZuUUkrMjVQc3FSUElkcGhR?=
 =?utf-8?B?RVF2N2p6Z1BMV0ZwMFdoTjZNcVNLZlZ3SEE0MFl5RkpGTXFBZWpQMG1Vcmkz?=
 =?utf-8?B?UlB4d3BXM0VqVmFhZVJ2OWdnYmRpbmxxSDhrVzAxY0pmdjlxZ3lPMEpnY1ZQ?=
 =?utf-8?B?czVGbVBpa1h4ZnN4Qis4dEN3aGFnbWZTRVJqR3ltSkJUUkJqeVoyaC9QdXdO?=
 =?utf-8?B?UG43SWppT3F6b0xlWjloUEpmL1VuSXQ5bXl1WWFkM2JHZUZzMVVOUkVjYkx0?=
 =?utf-8?B?UTJCZ2tFTUxjRmNWS01jUDlPQ3FSMHFnaXh1L2M1VHZyWkpuZE16ZWN5dnJv?=
 =?utf-8?B?ZFFFN1ErYTdoMHI3VCtKM0xxQS80Q0dvYkQrRjY4WjhPUHFFd1dnU0hacEtS?=
 =?utf-8?B?cFUxUEl6R2VvYUY5dWRPc013QWYxNkMrU29UcDRMYmNJMUg1Q2xnY0t4T0N5?=
 =?utf-8?B?Z2l1ck1JSVBSV3lud3NmVVQ3WXQvZURyQkdYYmwzaUpONlpwUkFFYThPdnU5?=
 =?utf-8?B?VTE1MzhlZzJNMXdkVGFnVUZiQzUyUjd1ektQb2dSb0lXUTh1alB5VnhpVU92?=
 =?utf-8?B?MVFNeXV6TFpJTXM3NkRJUlpkL3RPc0QzMFozRUR2YW96WnRGWVRlWllGTzdY?=
 =?utf-8?B?WGpyWnJ2UElKbVVwWHhUaE52VDdYVmpEU0YzajF4eUhBNFFidUt2cW1POGtl?=
 =?utf-8?B?TGo0dFlvakhMaGgxTzRZRk1MV29HMVExUEdmbFJFV2tUTkk4MWtqMm5aMVY3?=
 =?utf-8?B?endyMlV6VjYwSGlrVnhwQmd6ZWxGbW5KZURCVGI1ajdQSHFzZmc0L0R3Rk1K?=
 =?utf-8?B?eGJsa0R2Y0JqWlNIVlRPUTNzckgzR3F5MjFwMjNUdG4yVExhUlBoUlpKNDc1?=
 =?utf-8?B?NDZ1cFRSUGdHbEE4TlZIRFpCejZHNUVlODkzVTRaVjl3dGJnUnFCTmlPOUds?=
 =?utf-8?B?aWlBRHE3ZitKWUdmVW0yN21vYkJoeldFT1J5SHQ0aXI5VWo0ZEZzdEdOaWFC?=
 =?utf-8?B?blJjSHVlak9lMlhaV0crK3V3NDA0Mk5lZS9mYjFiTk5xdTQyTFczaGFTZlY3?=
 =?utf-8?Q?ruGFDNWfDeYe4xaaG+lYlGh9UhJe5axqx+rIyTX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e539707-3755-4c5b-db44-08d9783e796a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 11:46:37.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhEfhxZsXHYEzpARnutjTjo2eEy/u41VW2lhmuaX0faiu4iN0BIuyzCGp3BgR8AK/Pc5xrAZ4w5B90eU0G29hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,


On 9/8/21 12:53 PM, Borislav Petkov wrote:

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
> This one is really confusing. You assign ret in the if branch
> above but then you test ret outside too, just in case the
> snp_issue_guest_request() call above has failed.
>
> But then if that call has failed, you still go and do some cleanup work
> for invalid certs length...
>
> So that get_ext_report() function is doing too many things at once and
> is crying to be split.
I will try to see what I can come up with to make it easy to read.
>
> For example, the glue around snp_issue_guest_request() is already carved
> out in handle_guest_request(). Why aren't you calling that function here
> too?

The handle_guest_request() uses the VMGEXIT_GUEST_REQUEST which does not
require the memory for the certificate blobs etc. But based on your
earlier comment that we should let the driver use the VMGEXIT code
rather than enum will help in this case. I will be reworking
handle_guest_request() so that it can be used for both the cases (with
and without certificate).


> That'll keep the enc, request, dec payload game separate and then the
> rest of the logic can remain in get_ext_report()...
>
> ...
>
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
> Same comments here as for patch 37.
>
>> +
>>  	misc = &snp_dev->misc;
>>  	misc->minor = MISC_DYNAMIC_MINOR;
>>  	misc->name = DEVICE_NAME;
>
