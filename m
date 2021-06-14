Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E03A6F27
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhFNTgO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 15:36:14 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:41056
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233816AbhFNTgN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 15:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DONaE1VZWbFh+8y1omSxl/092VaRzULn+lStjE8q1Vrk/HMzoSWE2S+Mf2hTw2FAZB29xF0RC24Njg+fXI7OVP/OVcZ/MlbYCgxr/JRzrJ9ec34IDL1BARrIvbpWrGaUxQvNjGv7aPxiSVOCNE+WhaU8ipC39c0at8WTW8VyqmMKblLAOUMFO3cOYTs07x9ch1AP0NoZn2I6KoXyHQvKmxd9bOY7QWNnM+WRI4/yYsBIQmRyBz+57WzmX7m2KTlI1xQJ7ID+nSHO58TjrkCnoPD+CMG4Fs4di6Lf/VnR14HjmhiEObQwwBPHJa+sm1Dftmv/lF/JpC+stiYf1vvzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqclddGsaGM8Guc+wmmkKai8E97EdF9Z5nn+QbKSBQE=;
 b=Bc76fzX+kfoeKv+roZ80VXkBdnzlCl4cLpwWQAnAxqqABGC6Bf5bGW7PIo1bKhr7MHrQB9WBRUqjSN/TT7WhOsoAuuOxGgb+B7p5bhlSKZvnrkt5nQOik5pWV0hONYif8AXC9kQqbdEJHl7jH1QXsQRJ68j5TRAHH+xGBK7CN6pPXy9GdIqZtPEI8GfDE45XnCogFKkRxr8JObVCs6YHxDxsNrUQKPcLOJgPq03X/qTDvPqD7UDDqgRPt/z2gzJp9dcVg3VwWSI/OywLIiMuQBXhBOPIrYx6HER/fmcWCVcRQLFtvpjvVr8o8cgRMWJBNmq768pxOpmGrcHJa2U5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqclddGsaGM8Guc+wmmkKai8E97EdF9Z5nn+QbKSBQE=;
 b=iqmLVH9nEewH4S5UBdRUI+w/rmEtLVvJ4F4FYagv2ONTk6Lh+oqP+p7JlFRHRzFyTUAkMLlVCDH9ul/oTFQ+5U+wqn18leA+34S5iRJahiZeUuGU0dgvC7mYWcIQvDQ32Tnkes8jm2OKEYW2i7jncxoMT9nONmv1kBTJXqtL6mc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Mon, 14 Jun 2021 19:34:07 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4219.025; Mon, 14 Jun
 2021 19:34:07 +0000
Subject: Re: [PATCH Part1 RFC v3 16/22] KVM: SVM: Create a separate mapping
 for the SEV-ES save area
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-17-brijesh.singh@amd.com> <YMc2R4JRZ3yFffy/@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f6ad5b50-f462-35e1-3be4-e7113feee3a9@amd.com>
Date:   Mon, 14 Jun 2021 14:34:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YMc2R4JRZ3yFffy/@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR11CA0131.namprd11.prod.outlook.com
 (2603:10b6:806:131::16) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA0PR11CA0131.namprd11.prod.outlook.com (2603:10b6:806:131::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 19:34:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b334eb1e-6e40-4c22-f276-08d92f6b5fef
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449DF079AC9F5AE53F4F123EC319@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7IaklWShoqTFaie/R3VpxIaIk1bpWZ6JprJdtDM1m9Ddz2HfJa5qvzyilFeFt+Aa+TibDT3IaZHrN165eiiBcNte/1T1l3vVI7H0OCLmhtWBipDKQYOeZsRtuv7hG5qxY/1DKcQFls78XukKp+U+A4Hlu14L3X366Y9mtJ5WNvdjy/MoWKKNpsct1geH9wXqf8RcNULPdKUaIHmLXnj3PU22rcbVJp/jBluh+5Zm05Rt/rC1LhJYsQfxlF0Yy+mEtqszirXhveSCQZoxa36vpJtsrg2YRPmRQKyyRvN0eWFfoS7wuxY49I3xMd0Vnlwulh16wlvWGShhMhcacZo+ci5Cjh8DHmcqrOydrGq/ZJDgRSwpXWZxh3IfIVNnnBQnMHcMMOrGzmo8O9ekIEDmNVfwf3iFf1Z5Pk1hjCA4Bo8n2CaVN/kyKTtLPqxW/AxLK9B+cxxA/r3Sspi4rXrcac5PWH/irNUwAhJWyJZpcy/J+n7rqGsWVFfJNlkEVica+bMDZ2lHkGYB+aaZcQn9EIlwBu2UF3LttosDIwEbh8phbiSBhNZ/vaMbcyrua4zDmcHHjmFlBxU85QEnqEzwJXq8bsjQx0fGTvFcm3UtNyJ1IKw9gyHW9xb5GlVyqOdy6y6XtmRsYMGFNB2T+bRg7gzh73hSXPxBZbGpVdCZL9kUyqbll4uzSlr8NV57OAm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(478600001)(316002)(6512007)(26005)(66476007)(53546011)(6506007)(86362001)(110136005)(66556008)(66946007)(6486002)(2906002)(31696002)(6636002)(2616005)(38100700002)(8676002)(956004)(16526019)(186003)(83380400001)(31686004)(36756003)(4326008)(8936002)(5660300002)(7416002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGV0ejFlcW0veFBoeEZBRDJFVW93R2VRSXNxdk13cnpHL3Fod1FFZjJTRjk2?=
 =?utf-8?B?S3lIMEVVekZuTVhmSWM5ekN0c3NhSGROUFQySWNseUloVDA1eHdmUGk2ODJo?=
 =?utf-8?B?dTRrczVDWUQyOXAvWDRuKytZZk5pK0ZlSGlyZXYvOWVqWHRFUm1CdWxKMEd2?=
 =?utf-8?B?VHNuUmJNbitlK2J3UUd3bXBFYjBGV0RPM2Ntb1ZUUDh5Nzlnc0lCWldVYk9u?=
 =?utf-8?B?SDhkOTdnSjA2S0tXN0VKelpEdGh1amtUYWdCcFpTUnhYWnNxOTV3ZzhjZlBO?=
 =?utf-8?B?UGptVFByZFJka0pBUHJ3VFlzNFFuOXAzRVZzUmt4dHRyOXFLZVVleDd4Qmpk?=
 =?utf-8?B?SE8wbzA0anlRamtxSlBxR0ttUjVtMjk2aEplWHc4SUFJSXZNUXFRSkh3MWdH?=
 =?utf-8?B?UnhTS3NINmdqZk1nUEpvTlJyMnZNa0FWMnUyRncveVNjUjVmbURqK21NSlJ1?=
 =?utf-8?B?Y0ZsYUZ4UURkTzd4YnFiVGVZeGkzOG5zNE9nTk81Z3BZb1FyclMwK0NpUk1M?=
 =?utf-8?B?S1JRUzdzenoxajFkM0M2UzRnakE0ajlhU3BudEt6Y0wyczUzdXZiS29CYUx3?=
 =?utf-8?B?dFhyUkw2MkgwZ3ZvcXVjMzZCYjNFclpaRXk2d200a1JaS0xhVUp2S3lMVndK?=
 =?utf-8?B?OVgzeUM0TGI4dVZmVWs1N2NlUWNnL1RNTGZMRDdta2tPWHFFWnF2aVlHR3dU?=
 =?utf-8?B?MXQ3eVNrRDd5OVBzd2ZibzExU1crZTJDb3BUdGlMLzc5bC93bGZlY0dTZ3lK?=
 =?utf-8?B?Y3lnTTBNWXJ6dlhqWXdoT0RBNmFjbkQvTkI2R2I2eHUzNEw2NGszVnVNZmNo?=
 =?utf-8?B?azBqdlF3MFUwdmpyL3pTYTEva2VNOEJoNWxNNnN3MDErME05cEUyNGIzSWJR?=
 =?utf-8?B?ZHRaa3JkVno5NEphSjUrVkkzQTJqbkRsUEZadDJaSEhaWVJiUm5DN3BhVFFi?=
 =?utf-8?B?WUR4OC9ZbDgwS25qdElHQWpvOC91M3lWVFVzaE9rZ1BzR3ZWY1pEMUlaL2VQ?=
 =?utf-8?B?ZE4yOGd0RXJLcTZYeFFiZXVzbjBSWnA3MzVFZXJqaWVTWWlxZ0hnNk5FSnB4?=
 =?utf-8?B?ZzJXeWVJd01mZGRBVUlsM2hwS3dJUFZhYzdSMjBUeFc1bFFtNWkvTGJIdDQz?=
 =?utf-8?B?SE8xek05S2JyNzgzdW1Ob2IrREE1dkRSSDJ6SEFLNk9vMjdaOEc1UDlMM01X?=
 =?utf-8?B?TWVXVXNXYWpRSzZwdFlLT09VT1Erbmt2TnpUMWl1NTVGSVJPdU50N2JsUkpt?=
 =?utf-8?B?ZjI0K1BIY0pteUFBbXJsMmlSNG95akJTZTdTR1V4bzc3OWd4d1o5bEREVkZp?=
 =?utf-8?B?cEJVUCtIWTFZcWtZSnNhNmZpdEdSc1Vaem43TnJLaWZSZ3RtcFJna3YySGNR?=
 =?utf-8?B?SG1oeklKR2wySXBMRUUwbCtMditMUUxtSWZaS2VKaDlTbkZiVWU0WFVsVnVM?=
 =?utf-8?B?N3lLdkRBcm1sSGlQN0xRcnBPK1J3U3pZSC9QeEhpb2pBeVRpOWFodkJZUW1a?=
 =?utf-8?B?K0JERzRkZUJJRDF0SXB4cEtxSjY2VEpBcFFkaU9MYmNGKys4elNlK0cvNUl1?=
 =?utf-8?B?R1ZMWitYZkI2YzRZTkxjNFppd1hkU2Q4VXUvblpqS2FXeE15NzRNUXArUGNL?=
 =?utf-8?B?VFNhTWg4QlAwTy9aVm9YQkJORUhpbVJvRUhNd3JNVVJyTU11UXNEdFBTNXlC?=
 =?utf-8?B?WWJRVkxFWHduZnFTRE1HUkVOb29BdXdRZktXUW5uZE53ZjAwM1RqNW1hQkNw?=
 =?utf-8?Q?mT3PnwL7pZAsfpPODbCxbek/zpuoDDEuPKR6Xgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b334eb1e-6e40-4c22-f276-08d92f6b5fef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 19:34:06.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toFIyaUiAz/X6jSV/Buk/qmHvWcc9x7U+kSzKI0tuLKTh93sN863b3bWnecrtE2HXPbJPLZvwaB/2WTZtyJV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/21 5:58 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:10AM -0500, Brijesh Singh wrote:
>> +/* Save area definition for SEV-ES and SEV-SNP guests */
>> +struct sev_es_save_area {
> 
> Can we agree on a convention here to denote SEV-ES and later
> variants VS earlier ones so that you don't have "SEV-ES" in the name
> sev_es_save_area but to mean that this applies to SNP and future stuff
> too?

I was just following the APM, which lists it as the "State Save Area for
SEV-ES."

> 
> What about SEV-only guests? I'm assuming those use the old variant.

Correct.

> 
> Which would mean you can call this
> 
> struct prot_guest_save_area
> 
> or so, so that it doesn't have "sev" in the name and so that there's no
> confusion...

I guess we can call it just prot_save_area or protected_save_area or even
encrypted_save_area (no need for guest, since guest is implied, e.g. we
don't call the normal save area guest_save_area).

> 
> Ditto for the size defines.
> 
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 5bc887e9a986..d93a1c368b61 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -542,12 +542,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>  
>>  static int sev_es_sync_vmsa(struct vcpu_svm *svm)
> 
> Not SEV-ES only anymore, so I guess sev_snp_sync_vmca() or so.
> 
>> -	struct vmcb_save_area *save = &svm->vmcb->save;
>> +	struct sev_es_save_area *save = svm->vmsa;
>>  
>>  	/* Check some debug related fields before encrypting the VMSA */
>> -	if (svm->vcpu.guest_debug || (save->dr7 & ~DR7_FIXED_1))
>> +	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
>> +	 * the traditional VMSA that is part of the VMCB. Copy the
>> +	 * traditional VMSA as it has been built so far (in prep
>> +	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
> 
> Ditto - nomenclature.

Yup, that can be made more generic.

> 
>> +	 */
>> +	memcpy(save, &svm->vmcb->save, sizeof(svm->vmcb->save));
>> +
>>  	/* Sync registgers */
> 		^^^^^^^^^^
> 
> typo. Might as well fix while at it.

Will do.

Thanks,
Tom

> 
