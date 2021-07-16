Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D99B3CBEAA
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 23:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhGPVpt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 17:45:49 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:6145
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235173AbhGPVps (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 17:45:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdwwWCc1BGgpbjsDfXjM5dkiUOQMfJsu+tCA82H6jT/SwDB0unn0lulbVMAWXEOu/Q73KnhbaRAivWI+BvOZkZE/CE3UYxZ2xXTxRegButxo9uswRWn7+0FD8l+CzDqiPP9FcQbI2LVMNFskgJ+/N/u7eDRl/8VaZ5kPS7LY6p+1R1uRnjWUFtPqFhRgzhQTyf7XOpxEumUQy5zI3DQ63byiKz6symO+cvQtCvtsctMkGWiJl6NyoziUenYiwo2eaHlLwEfWJgxb1Xh6lwVPHI9eeLVPVc6laeO5+6R8ypdzd4vH/EkXS2RB5CZvMd+dETBWUtTCoWN3GprSSLJQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/0EJasqOxqiPiqWIR9VmbbtsO1/XhFdhI3J4XyUb5w=;
 b=PCclTGUARiEdHQimS6bc0J1Lg4nwj1qbAqJu86w7hR5JJ8x155t6kW5sJj5zzHYy1YJdh5Pj0C39apHD6YenQlaO6znMKU/4dbYK0xV6P8X2A+huRfN+ctQzYVAzTk3KcpBQmUh0vi31sRbFcc9J2Mp+1772nG40wUnD+XVTAVCnR08r3pBlLlFckwV1q5RKtu8BQMIDkv0oiEqSh5TWou9kxgXaMCzeBEhB4zzSXRbjhuGEpbAGaH0QDB8Y4UsvQDaTM+3eGgR0k+jq5R+cjHEakFoLAAn3cyEGWi5qqMkoxSL94+js+zReUTJQR2n41Pc1IQ0cVzNE1U6TQyFi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/0EJasqOxqiPiqWIR9VmbbtsO1/XhFdhI3J4XyUb5w=;
 b=qoiglKRTp6h98qwc5CjnUinob44yQZjpQxMydOx+CTWnYytDVgHvcmr/sxFG50Yo5yspqAKkJLbE5C25BZN9kGMmdo60Sqvs8jpU8e9UAREqGFMoQrf2dTrw9KXlZlW8AWRXpafV3xG63fgveiiorJcXIPk0zOqLM1q/QKC6tM8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 21:42:50 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 21:42:50 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 23/40] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_START
 command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-24-brijesh.singh@amd.com> <YPHhVZLyb795z/88@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <470a3af6-31d2-643d-987b-3d49023ca8bc@amd.com>
Date:   Fri, 16 Jul 2021 16:42:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHhVZLyb795z/88@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Fri, 16 Jul 2021 21:42:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453af8ff-8161-4856-9ebc-08d948a2a869
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2829E984E94C5383CF8CF0E4E5119@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUEiTqKcYnN+KvsPK5y91qALJ1jP6WAlI28qPjgGl3rEPg3CGAantdcVaNoG2AKOE3UHKXnfsBR3FCv6VEjB7n0UyMpfdnINN2/c+i2MixHRG3ZaRVtIRTLMqFx0U1IqHxVov+WOsJvlB7JdXVlKra7FL8TFxowouhqX8OLQSOt6ayFS9DftVTegZotN3ypsC1L2+0aFtD7d9ac44XOBDZbzYZzjLnI6LzK5tPOrS1JZ1O78okHhjqkveLFVfJi7wvzvV72+nuLktoqRBXPsdyDI+SkOIWIycGh1cSbB+j7pAVwWPiYdNiKkwL489rSQE2rsNDYKLzOT0gDH9Xe/NOty/gwC+qS+XX/cdNcN9KckVnBkoRcHjJM0ozSxf4eRnMYlE3UIyxuXAicOYX/3au0eSmYs5IbGe/OpZI2eKt9OgOOxCuJPTGdieQsrpE681Y/rLVd32qxllqSdVe5OhEM76pgE8Kav3jqRLmcatlA+CyGDimikihZK0Ca2oiuo4hOVZfL3qlK0hPMc2smeezIgskGvswS4eobUr9cq3lxvJNKIR2lgonzwxDUZNrclSzHLk3UuaZEmWo/7tPTL0CDvrRRRh4KCqKQGHWL+FgUryDY0OH+V6ucHW8MPPLUn9Icgj8F51bB7kuzFxZUCS8TAAiuFsW8CgWvFmqQjdc6P5xV4Ylq9furWyIOjG+O8a/hezlyxAUkU+v78ZP8a03LnjKwtwHLtCkdnym/AnJwn3wzhZURNl6fxq247+/mdJa8WE+ddaPXlDH/FrohDOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8676002)(66946007)(316002)(83380400001)(26005)(53546011)(44832011)(66476007)(7406005)(38100700002)(38350700002)(66556008)(31686004)(52116002)(6916009)(7416002)(6506007)(4326008)(508600001)(6666004)(31696002)(2906002)(5660300002)(2616005)(54906003)(956004)(8936002)(6486002)(36756003)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnExQnk4Ty81d2prb0NQWkpKakMwY3dtMmVLY1hkKzkvRkZJMEdqUEhJU1hT?=
 =?utf-8?B?ZGIrRkNrMU5NS1h0cXJXZDd4eU9RQ1ZUMURqbXJlMzlaWURPQnZJZ1p6SUxK?=
 =?utf-8?B?c055WVF6TWl6QlVLLytGRHYwbjVzQTFsMk01d3M3V3g5alpiMkJLc0JtVFh1?=
 =?utf-8?B?RHdIZlZ6SVhxYVpzSUNid0gwckhISHhvcUUrc1djRE5QM0t0eUVKaEF2RURR?=
 =?utf-8?B?Tkg1TTNhNWtoQitoaVhjQ0hIZGRmUFVWSkdlNjMzeVh1b3VwTFczRnllS1A1?=
 =?utf-8?B?M1h6eGs5cm5JeW5zVUdmd0xqME41QkppbTB4emRIaGdqUU9tK3UwNzBLNTNO?=
 =?utf-8?B?NFEzRTRqa1d5Qys3SUJnSC9NNTNLYnZ0NDdrR2l4S1lMUDNGT0VXYkFlN29T?=
 =?utf-8?B?S3BqSmQveUlXVEpab01VS2NqclpsWVpDeE90b2ZOMmNjRmtSdmwyeDB5TTJF?=
 =?utf-8?B?WWlOOHBiSng5RXJzQzBBczRjWEhxSTE4a3RBdUdXLzNJdU5EZzU5MGV6QkVO?=
 =?utf-8?B?QjVHd3RNTlk2WkxXMnQ4blZCb1VDSnRoSDRTbWM4SnFORnp6eWVhMU95c3N5?=
 =?utf-8?B?VXFFOWJyWm9jdXR0LzgxSzJhS1FuOG5UbkZ0djV2d2JkaWU3cmRnNjJJRWRu?=
 =?utf-8?B?a0F5ZzhxcGNSN3JkK2JVMmF5MVpUa1NVaDlwQ0lVRHBrd1d2YUpqa1V0UG5Y?=
 =?utf-8?B?ak9md1lnR2JHODFzTzV0K2dPZU02NmgraUk5SVNNakJaVWFEQldibHZNQlY4?=
 =?utf-8?B?NUpxRjJRQzZ4RHd5VkNYZEtIWENubWsrOEh0SGdDM3Z5enBSZldsSVFHVWVx?=
 =?utf-8?B?bHRiQmswclhuUUx6U3RnMi9iQk1UNUtRSzVuRStQTW1YdVI2ck5vK1FMUGdx?=
 =?utf-8?B?ck1BRS8ybW01SlV4aVlwYlNobEVidWZJWkZRWWlmQXZYclNIaGw1ZzNYOEdQ?=
 =?utf-8?B?UUxrTSs2Y0tldWVseTlrRkdSeXpwUkVQUW9vVVJxWWMyUnA3L2JMcGc3S3F6?=
 =?utf-8?B?WEJqUGFQSWZGdDkxL084czJKaExMN0F0ZFVzc2JhcGErekRPcVZXQ05vUkFK?=
 =?utf-8?B?NGRXWXBuQW5neG9MOEJYTGtMMlFNUFFwMU9ReSttZDgrSjNyVHdBT2tjTTl3?=
 =?utf-8?B?WDhTdHBha3lOZjcrdVhlcHdkUWVDTS9NdkxFam9pSTZjU3RWVzNuSHBWSENh?=
 =?utf-8?B?R1puYlgzL3JJZGJtK0tzbjU3NUFSTEhyZ0ZrYzJwL3FsS0RqZSswbU91eXph?=
 =?utf-8?B?ZHJhdmt2bjdKUG4zVDlFMVNybUFoYmFwUVM4bWhSVG5jTjZtalRRTTZFSFVK?=
 =?utf-8?B?V1kxVDE4R0hFajYrYnRxeFp4MWJLTnBEUlFwUmtQTVgvWmY4WUh2Mi8wSDNE?=
 =?utf-8?B?ODV6c2o5ekEzM0kwQmZtS2FLYUpCdmJWY1BMc0E4VlVJZDJ4Zm1UYkdWcHhL?=
 =?utf-8?B?WHhJSThONW1hd0hzblFoQ01zMXZpcEdNUE1HZ21VWTNWMWZKdnhLN2d6ekxr?=
 =?utf-8?B?b1J5d001eTFEUjRVdW9NYWhXeEpIK2EzQ0JTU2Z4UTFmbGlXcWpqbWFNTU9U?=
 =?utf-8?B?SHpzNk5zMkRRZGRhUkRHRm9KUDYvczJoL3NRdFdSSXowR3J1cmZmRkxnRjly?=
 =?utf-8?B?L0lQUlRsOW9zYjdVUXhzVFBqc1k0cUVwbytxSEgxQ1ZRNFFXRVhHZ0VoaFlW?=
 =?utf-8?B?Mi8xNGI0dUgxQ2Nxd1ZhVzdOQ3Y3TGNydE9VbktqS1d2U2ZJZ2gxRWE3T1hm?=
 =?utf-8?Q?FJPstioB6xNMak6AGgNSnnv0SzvDvtJBcnuQx2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453af8ff-8161-4856-9ebc-08d948a2a869
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 21:42:50.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLlI/0S+fmKtGSxHrjzQzbS2K+dxdGB8gJpwKmeKQouuTdw0/bIm43+CYvDqTkc9SABpq3WdS6UAtQ6o0hToSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 2:43 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> @@ -1527,6 +1530,100 @@ static int sev_receive_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>  	return sev_issue_cmd(kvm, SEV_CMD_RECEIVE_FINISH, &data, &argp->error);
>>  }
>>  
>> +static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
>> +{
>> +	struct sev_data_snp_gctx_create data = {};
>> +	void *context;
>> +	int rc;
>> +
>> +	/* Allocate memory for context page */
> Eh, I'd drop this comment.  It's quite obvious that a page is being allocated
> and that it's being assigned to the context.
>
>> +	context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
>> +	if (!context)
>> +		return NULL;
>> +
>> +	data.gctx_paddr = __psp_pa(context);
>> +	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
>> +	if (rc) {
>> +		snp_free_firmware_page(context);
>> +		return NULL;
>> +	}
>> +
>> +	return context;
>> +}
>> +
>> +static int snp_bind_asid(struct kvm *kvm, int *error)
>> +{
>> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +	struct sev_data_snp_activate data = {};
>> +	int asid = sev_get_asid(kvm);
>> +	int ret, retry_count = 0;
>> +
>> +	/* Activate ASID on the given context */
>> +	data.gctx_paddr = __psp_pa(sev->snp_context);
>> +	data.asid   = asid;
>> +again:
>> +	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_ACTIVATE, &data, error);
>> +
>> +	/* Check if the DF_FLUSH is required, and try again */
> Please provide more info on why this may be necessary.  I can see from the code
> that it does a flush and retries, but I have no idea why a flush would be required
> in the first place, e.g. why can't KVM guarantee that everything is in the proper
> state before attempting to bind an ASID?


Ah good question, we already have function to recycle the ASIDs. The
recycle happen during the ASID allocation. While recycling it issues the
SEV/ES DF_FLUSH command. That function need to be enhanced to use the
SNP specific DF_FLUSH command when ASID's are getting reused. I wish we
had one DF_FLUSH which internally takes care of both the cases. Thinking
loud, maybe firmware team decided to add a new one because what if
someone is not using the SEV and SEV-ES or some fw does not support
legacy SEV commands. I will fix it and remove the DF_FLUSH from the
launch_start.


>
>> +	if (ret && (*error == SEV_RET_DFFLUSH_REQUIRED) && (!retry_count)) {
>> +		/* Guard DEACTIVATE against WBINVD/DF_FLUSH used in ASID recycling */
>> +		down_read(&sev_deactivate_lock);
>> +		wbinvd_on_all_cpus();
>> +		ret = snp_guest_df_flush(error);
>> +		up_read(&sev_deactivate_lock);
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* only one retry */
> Again, please explain why.  Is this arbitrary?  Is retrying more than once
> guaranteed to be useless?
>
>> +		retry_count = 1;
>> +
>> +		goto again;
>> +	}
>> +
>> +	return ret;
>> +}
> ...
>
>>  void sev_vm_destroy(struct kvm *kvm)
>>  {
>>  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> @@ -1847,7 +1969,15 @@ void sev_vm_destroy(struct kvm *kvm)
>>  
>>  	mutex_unlock(&kvm->lock);
>>  
>> -	sev_unbind_asid(kvm, sev->handle);
>> +	if (sev_snp_guest(kvm)) {
>> +		if (snp_decommission_context(kvm)) {
>> +			pr_err("Failed to free SNP guest context, leaking asid!\n");
> I agree with Peter that this likely warrants a WARN.  If a WARN isn't justified,
> e.g. this can happen without a KVM/CPU bug, then there absolutely needs to be a
> massive comment explaining why we have code that result in memory leaks.


Ack.

>
>> +			return;
>> +		}
>> +	} else {
>> +		sev_unbind_asid(kvm, sev->handle);
>> +	}
>> +
>>  	sev_asid_free(sev);
>>  }
>>  
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index b9ea99f8579e..bc5582b44356 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -67,6 +67,7 @@ struct kvm_sev_info {
>>  	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
>>  	struct kvm *enc_context_owner; /* Owner of copied encryption context */
>>  	struct misc_cg *misc_cg; /* For misc cgroup accounting */
>> +	void *snp_context;      /* SNP guest context page */
>>  };
>>  
>>  struct kvm_svm {
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 989a64aa1ae5..dbd05179d8fa 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1680,6 +1680,7 @@ enum sev_cmd_id {
>>  
>>  	/* SNP specific commands */
>>  	KVM_SEV_SNP_INIT = 256,
>> +	KVM_SEV_SNP_LAUNCH_START,
>>  
>>  	KVM_SEV_NR_MAX,
>>  };
>> @@ -1781,6 +1782,14 @@ struct kvm_snp_init {
>>  	__u64 flags;
>>  };
>>  
>> +struct kvm_sev_snp_launch_start {
>> +	__u64 policy;
>> +	__u64 ma_uaddr;
>> +	__u8 ma_en;
>> +	__u8 imi_en;
>> +	__u8 gosvw[16];
> Hmm, I'd prefer to pad this out to be 8-byte sized.

Noted.


>> +};
>> +
>>  #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
>>  #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
>>  #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
>> -- 
>> 2.17.1
>>
