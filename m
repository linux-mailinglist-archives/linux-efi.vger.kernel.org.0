Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7552C3CBEDA
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jul 2021 00:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhGPWEB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 18:04:01 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:20449
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229951AbhGPWEB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 18:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmZHYnHFNX+YWrH0MhHm9iSJjN4CFGcoYoUh0mRYiQHc8Jy7FAZuKBfwWG6ZUi5XzvXswxAQ/HnNORPiTc7C4J+sJGd5jr6Ok3CJpuM7NRze9boOGkQKEcFIYLQp+7QVViogAi+QytPwm+pbam7zcLbTJga4Fo6p+T6npqZ7rwn/KNZjeSjqC6ohhUWAYBjLDUyZmR/2sltDq1/lVhcbOvqZrTBhnHyt0HCjrqzDqs6wuLK6NJiSUZXz8AP5Hyh/HYryNnboYNZ2x+2nPZMYEvt3vfKbquMw5PqTnVOpEgcfrDybHdb0Hwhqrs9XtNATEtmOW53rKgKk88BvSl9LBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JArB3kYX6+/4aLRePWrwsuacDOq+Mrw8o6OA6xgBHd4=;
 b=n93qIM/3vl6zeFQVgWF56sBVx+fCxsMj1EPyUj3sn3fHOVTEa8pUG5OgVCShDAy+B5W/a7h9addxOo2CJCe/mPe4NUWQAAOEWYpElAyAd/lh+czLZ47R3OqwRovGXExbOMuckxYzy77UR8QnDYHWkdcWhZKvfjGzw3yZwaotOC6HcAu+Ww7uHWqmkbKzVDtV4Vhfyz1JLQcnJdwlLBJPNIX+eFBbNi3j72fHmHZlxR4GXsg8xT78Om9Hv4qMjYTUwL4PKRh9gz8sJjTkKEP7Q/YGKolEtfMseJ4qjnVH73Yqh1Y7qOWTw3LWg23AQGuS7yO2rg8B5T2yxDMFtGKwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JArB3kYX6+/4aLRePWrwsuacDOq+Mrw8o6OA6xgBHd4=;
 b=P0Rc6ukB6AIgtqXQm6mlgIVcex1u/Ph/f9CmD1l42KfyAiElW6LIB4VAcTAeUQQ/94pYCm7o7Q8ukxteefL4Bde86R4rtEOhtwfKgRJbCSNjHvKDCzXal75J7IUEqyjScXLvw2CWinxJo2wGRCiZ5OpM3D/WpOqXh1UGAeC4x9M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 22:01:02 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 22:01:02 +0000
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
Subject: Re: [PATCH Part2 RFC v4 24/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_UPDATE command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-25-brijesh.singh@amd.com> <YPHlt4VCm6b2MZMs@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a574de6d-f810-004f-dad2-33e3f389482b@amd.com>
Date:   Fri, 16 Jul 2021 17:00:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHlt4VCm6b2MZMs@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:21::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend Transport; Fri, 16 Jul 2021 22:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8eac03-0f54-4ccc-b16f-08d948a533d0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25112F554A7B4D7349733FB8E5119@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l/brAPsLdfmQi/kIYBFzgqgwGRu4bezC6koVXpfW3//SLRa0fSwE0zDH41G8g/51qGbmm3yvowBdwYZhEbGc9KLwyFCtvj33iqbpPON4TXVDFoXxWBrppTw1RFOM+RquOlVSRUgm72+N63kBY8LhS4+8SliUrbERWxliFkMm1NHvPqEPhtnp1C5Anq8xJLct6J8GCO/jHMcCA7NqDkoTMl24voSob+ePhdhUVHab37qOzZWJApJh5gY0Fc/CTEEyDCWecLvuSfZsXQRWhLGDw/fmdTZ0PGZhjE1hVnissRbvs9Fo3mlUst8wls0/DFrDQ0p5YVHMI0rmg0c+zRC03g5MS/SMJnCjuCFrCQXroYfM0bRUbCHqGjvear14wjsy9iiHCggNMgLUEL00bbF0bwdp8poYL24MzOoBsatT5ZEyIZtHiAVQijZQDgKDQC3x+GnYJ0VTzDqz9263bmMZh+3akxz9BwpW3LtpjXW5icWPPhxe4qoUhBrkqOGi73v28/Yr1HrT6GmGWhH9QhCUt8k/gSqZrUbXHK+LHeaD18vBtFo0mNFUgmRrUm1QxGUuMks/PJ9eJFeJUM7J7iVqGsERvMMVhFUDgeUYT0dvmqqOcStq8lzM+d8KHBwSyEnEkftkJYFIq8BCniB0608iqCcmtEWIZxJG3b7QELe5rXiht5YgqbaCCR8Uq5+oSlbPL9xtpFYs/EDcSpr0hSgWhq6rUAYcqBp73rEF47hAd7ej7byWJeyiggYax1c8/VJf+WlFRtgkZ2x3I/DC1aoEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(53546011)(956004)(52116002)(2616005)(478600001)(31696002)(5660300002)(6506007)(7416002)(7406005)(66476007)(66556008)(8936002)(44832011)(8676002)(2906002)(26005)(316002)(186003)(6486002)(6916009)(4326008)(83380400001)(86362001)(38100700002)(38350700002)(6512007)(31686004)(66946007)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllER1dLUnN2ZkMwWFpta3VXVlZTbXNoUTBpODNFVXJoYkdTQ3F0RVFHMXRX?=
 =?utf-8?B?dlBJaFRLeU1oZ3ozZFRjRURKcU5UV1l4cldwaDF3ZEVZbU90RytwM2hENUFW?=
 =?utf-8?B?WG92UWx5UkdJTWZDUCtuMzhZck12VUVmUnhPSGdNdjFQTjd5bU8vcXFwWWtU?=
 =?utf-8?B?bC9CVDJvMWJaRzRSOExtT0FQMG9OWDcxck05VHVvQmlqeURUMVpOZ1NPckhY?=
 =?utf-8?B?TWVTTWZOc0crM0pDOXAwN2JGTUE1TUlqcDRYOGNkZHZoWC80NWJHamovc1NL?=
 =?utf-8?B?L1VJMEZ2c25HVWV4VHJ3aDc2MEhhclI1VSsyRHV3OE9LWk9HQXpHUU10eW1o?=
 =?utf-8?B?VitxMXZaN1REdDhPN04rRWp5bjFTa1JSY2NtUmpWL1M3SHp5VHVjUm1Ydm1h?=
 =?utf-8?B?N1VRa1dZYmI1STlwVkVNVTFpUHZHTVdzV3cydEVMVWQzbWtXNkFydjVUM3Vp?=
 =?utf-8?B?cDVTWldqUDNHUTQ4clJDbGhJeWhHWXVzaTVrcG5RMlZseUVMdmM2R04waXRV?=
 =?utf-8?B?YUNhTkRiMCtYWjVpR1diTlA0bUI0RjJLR1R1MENwTDNjQ0lneUNTQzQ2OFJn?=
 =?utf-8?B?VUMreHlUUXdPWFpOa0R2SEJpcC9tTHN2MmJWeGI2UDhYMDl1OTdqWTI3QnQr?=
 =?utf-8?B?YU40QUlnMFZkbTJBTzZoZ2lWaVZmZGN4S0pkUUdSbUMzQUJkMzdDam9TZEFj?=
 =?utf-8?B?VWpDKzVPL3lud3ZZZ0RpOHl3Nk9ndWFxeDlwMmZ2cDUwMnNTMVIwRWdXaEVR?=
 =?utf-8?B?WXVUUDYvTTlaM2dnMWp4bnJjc21jNjM2QTd4cldQUC9vQVo3QWY3VkxjeVFr?=
 =?utf-8?B?bXROMTFLM2FhTTNhR09CNGI2aG9pMWNZYXVaZkJVb3Vxd3MxQnVSOU1oYjEv?=
 =?utf-8?B?QklUSWF1MVFycjd4Z0Fnb0dKajNDa1F5M21ySFNuaW4rMysxVjE5SWpxeXdU?=
 =?utf-8?B?ZDFSLytTY3hQWWNIQmF1M2o2VnJTeWJpYlpkRG0rTE1YNzlTZjBYRDlsVFJz?=
 =?utf-8?B?ekxKMFl0VHBuei9QWkJ1VDBSMk9wWStrMTVYR0xHK2t3RXBMRXlGNDkwNlhR?=
 =?utf-8?B?U2RRK2RJT2tVanJqMTErYjZ2MnFnT3pVT01ycGp1RXBBRVdVZTFvenVMTGhH?=
 =?utf-8?B?SWZvTWh6MlFSUFZPOGhacExoUm9wejU4N2E5R2krQ3dPV0NpQThQTjllbEp0?=
 =?utf-8?B?Uk45cGkyS2RFRzBUSHA2eUxYMDNNV21IMTNnMjgxZG5ydFpHZXVnR294K0Uz?=
 =?utf-8?B?OEVWRlluYXRFM1BLelRWUWJUUDc2VmorenlDUTc2V2NWd0Z2S1podE9PRGUy?=
 =?utf-8?B?d0x0ZXhIRG5IVmdRaEc3ZXFQZ1hHc1h4YjZ4QXgvSUJIeHB6N3JEVFZlT2c5?=
 =?utf-8?B?YkRjOUNQVm5oREZHK0RmSTZiRGFET2NBNUY1bXM5cUtqdnd0RUMwYVp2L2ht?=
 =?utf-8?B?YTI4djZyd2ZzQ3JiVEhIU2VaMW5rZEN4VUtaeU05NTNHWEhkdW5XakhKT1Vr?=
 =?utf-8?B?eU1VdWpjbG5VMzFmRy84SGZsODQ1L0E0TjJ6aUR2OFpGTTR4QXVxMDluTDVz?=
 =?utf-8?B?cnFQM01NZlNYZWNNRUkxZjh5UFJKZm9MaTlPTXBqdUFDRWNsTnpnWnJEVG00?=
 =?utf-8?B?MEExSjU0eENIMFd6UktLTXZET25sZHhobWpueExKcXhxVGNFTkx3QzdXV2NZ?=
 =?utf-8?B?cVA0ZnBtb3ZDSk8zcWFSb0tud1hzOUEzUVRVQTlUaGVsY1J4RC83L3hOWGZt?=
 =?utf-8?Q?Ph8eO6S1a2RKrjfLHyDB6ECq/cd51iW/Xdt63xm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8eac03-0f54-4ccc-b16f-08d948a533d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 22:01:02.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXHOh3/Bmw3n3sHzWI4Ty3xsxzgs+60JKHTB16Lits4yUpFesLfc2y1+7wl7jy/33aNNcZ43dghe2Mz3y5WUCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 3:01 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> +static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>> +{
>> +	unsigned long npages, vaddr, vaddr_end, i, next_vaddr;
>> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +	struct sev_data_snp_launch_update data = {};
>> +	struct kvm_sev_snp_launch_update params;
>> +	int *error = &argp->error;
>> +	struct kvm_vcpu *vcpu;
>> +	struct page **inpages;
>> +	struct rmpupdate e;
>> +	int ret;
>> +
>> +	if (!sev_snp_guest(kvm))
>> +		return -ENOTTY;
>> +
>> +	if (!sev->snp_context)
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
>> +		return -EFAULT;
>> +
>> +	data.gctx_paddr = __psp_pa(sev->snp_context);
>> +
>> +	/* Lock the user memory. */
>> +	inpages = sev_pin_memory(kvm, params.uaddr, params.len, &npages, 1);
> params.uaddr needs to be checked for validity, e.g. proper alignment.
> sev_pin_memory() does some checks, but not all checks.
>
Noted


>> +	if (!inpages)
>> +		return -ENOMEM;
>> +
>> +	vcpu = kvm_get_vcpu(kvm, 0);
>> +	vaddr = params.uaddr;
>> +	vaddr_end = vaddr + params.len;
>> +
>> +	for (i = 0; vaddr < vaddr_end; vaddr = next_vaddr, i++) {
>> +		unsigned long psize, pmask;
>> +		int level = PG_LEVEL_4K;
>> +		gpa_t gpa;
>> +
>> +		if (!hva_to_gpa(kvm, vaddr, &gpa)) {
> I'm having a bit of deja vu...  This flow needs to hold kvm->srcu to do a memslot
> lookup.
>
> That said, IMO having KVM do the hva->gpa is not a great ABI.  The memslots are
> completely arbitrary (from a certain point of view) and have no impact on the
> validity of the memory pinning or PSP command.  E.g. a memslot update while this
> code is in-flight would be all kinds of weird.
>
> In other words, make userspace provide both the hva (because it's sadly needed
> to pin memory) as well as the target gpa.  That prevents KVM from having to deal
> with memslot lookups and also means that userspace can issue the command before
> configuring the memslots (though I've no idea if that's actually feasible for
> any userspace VMM).

The operation happen during the guest creation time so I was not sure if
memslot will be updated while we are executing this command. But I guess
its possible that a VMM may run different thread which may update
memslot while another thread calls the encryption. I'll let userspace
provide both the HVA and GPA as you recommended.


>> +			ret = -EINVAL;
>> +			goto e_unpin;
>> +		}
>> +
>> +		psize = page_level_size(level);
>> +		pmask = page_level_mask(level);
> Is there any hope of this path supporting 2mb/1gb pages in the not-too-distant
> future?  If not, then I vote to do away with the indirection and just hardcode
> 4kg sizes in the flow.  I.e. if this works on 4kb chunks, make that obvious.

No plans to do 1g/2mb in this path. I will make that obvious by
hardcoding it.


>> +		gpa = gpa & pmask;
>> +
>> +		/* Transition the page state to pre-guest */
>> +		memset(&e, 0, sizeof(e));
>> +		e.assigned = 1;
>> +		e.gpa = gpa;
>> +		e.asid = sev_get_asid(kvm);
>> +		e.immutable = true;
>> +		e.pagesize = X86_TO_RMP_PG_LEVEL(level);
>> +		ret = rmpupdate(inpages[i], &e);
> What happens if userspace pulls a stupid and assigns the same page to multiple
> SNP guests?  Does RMPUPDATE fail?  Can one RMPUPDATE overwrite another?

The RMPUPDATE is available to the hv and it can call anytime with
whatever it want. The important thing is the RMPUPDATE + PVALIDATE
combination is what locks the page. In this case, PSP firmware updates
the RMP table and also validates the page.

If someone else attempts to issue another RMPUPDATE then Validated bit
will be cleared and page is no longer used as a private. Access to
unvalidated page will cause #VC.


>
>> +		if (ret) {
>> +			ret = -EFAULT;
>> +			goto e_unpin;
>> +		}
>> +
>> +		data.address = __sme_page_pa(inpages[i]);
>> +		data.page_size = e.pagesize;
>> +		data.page_type = params.page_type;
>> +		data.vmpl3_perms = params.vmpl3_perms;
>> +		data.vmpl2_perms = params.vmpl2_perms;
>> +		data.vmpl1_perms = params.vmpl1_perms;
>> +		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE, &data, error);
>> +		if (ret) {
>> +			snp_page_reclaim(inpages[i], e.pagesize);
>> +			goto e_unpin;
>> +		}
>> +
>> +		next_vaddr = (vaddr & pmask) + psize;
>> +	}
>> +
>> +e_unpin:
>> +	/* Content of memory is updated, mark pages dirty */
>> +	memset(&e, 0, sizeof(e));
>> +	for (i = 0; i < npages; i++) {
>> +		set_page_dirty_lock(inpages[i]);
>> +		mark_page_accessed(inpages[i]);
>> +
>> +		/*
>> +		 * If its an error, then update RMP entry to change page ownership
>> +		 * to the hypervisor.
>> +		 */
>> +		if (ret)
>> +			rmpupdate(inpages[i], &e);
> This feels wrong since it's purging _all_ RMP entries, not just those that were
> successfully modified.  And maybe add a RMP "reset" helper, e.g. why is zeroing
> the RMP entry the correct behavior?

By default all the pages are hypervior owned (i.e zero). If the
LAUNCH_UPDATE was successful then page should have transition from the
hypervisor owned to guest valid. By zero'ing it are reverting it back to
hypevisor owned.

I agree that I optimize it to clear the modified entries only and leave
everything else as a default.

thanks

>> +	}
>> +
>> +	/* Unlock the user pages */
>> +	sev_unpin_memory(kvm, inpages, npages);
>> +
>> +	return ret;
>> +}
>> +
