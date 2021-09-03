Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3084C3FFBAB
	for <lists+linux-efi@lfdr.de>; Fri,  3 Sep 2021 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbhICIRs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Sep 2021 04:17:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348208AbhICIRr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Sep 2021 04:17:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18388u2k120999;
        Fri, 3 Sep 2021 04:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LeBFR5NxS59Up7fXyEdw+xXLB76JpsgZixl/tUzPLRA=;
 b=qegV+v9YgCr0H7ILmPi0n6AmFrk8Qi54Lw0ltVSn0osPDcmxBCYMA8Bpi/cRwiMql+yU
 w7KVrCynhQIePfvw4tWvFeegpay7VQlQLQ0n7J/d7mTXJo5UJsRHDcNEPMWIuHow6IOt
 hLq/1mUhRsD7QCWEjFQxlGsk3pTsoV6GR0F/yhgHJZLLN9uUZ400ito0cJ/XJy711O+k
 p0cLPFRXM0CKhCUumISYMCuAu7nA/u0UzSZ8fYyl2G5IPgEywz608PHXpeFuj84OyO90
 RFxVykOfSNdjJEFH4WOtRqJLVobNOT5c+qmh5xs9609FH34rVyQ8APghEcycBhTXWzdK Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aufcdgxsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:15:39 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 183891fA121397;
        Fri, 3 Sep 2021 04:15:38 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aufcdgxry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:15:38 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18388p1B002414;
        Fri, 3 Sep 2021 08:15:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3au6pjgy58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 08:15:37 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1838FaQ133948086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 08:15:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 462D7C6063;
        Fri,  3 Sep 2021 08:15:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 657F6C6062;
        Fri,  3 Sep 2021 08:15:28 +0000 (GMT)
Received: from [9.65.84.185] (unknown [9.65.84.185])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 08:15:28 +0000 (GMT)
Subject: Re: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request
 platform device
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@alien8.de>
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-36-brijesh.singh@amd.com> <YTD+go747TIU6k9g@zn.tnic>
 <5428d654-a24d-7d8b-489c-b666d72043c1@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <287db163-aaac-4cc1-522f-380f97197b3d@linux.ibm.com>
Date:   Fri, 3 Sep 2021 11:15:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5428d654-a24d-7d8b-489c-b666d72043c1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dwanS7qPhIIegVkAiJ4GNPDy_wPCRRKN
X-Proofpoint-GUID: EFCovUVGi0-Gh9ye25R_ko_qCm0WJHiI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030048
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/09/2021 22:58, Brijesh Singh wrote:
> 
> 
> On 9/2/21 11:40 AM, Borislav Petkov wrote:

[...]

>>
>>> +static u64 find_secrets_paddr(void)
>>> +{
>>> +    u64 pa_data = boot_params.cc_blob_address;
>>> +    struct cc_blob_sev_info info;
>>> +    void *map;
>>> +
>>> +    /*
>>> +     * The CC blob contains the address of the secrets page, check
>>> if the
>>> +     * blob is present.
>>> +     */
>>> +    if (!pa_data)
>>> +        return 0;
>>> +
>>> +    map = early_memremap(pa_data, sizeof(info));
>>> +    memcpy(&info, map, sizeof(info));
>>> +    early_memunmap(map, sizeof(info));
>>> +
>>> +    /* Verify that secrets page address is passed */
>>
>> That's hardly verifying something - if anything, it should say
>>
>>     /* smoke-test the secrets page passed */
>>
> Noted.
> 
>>> +    if (info.secrets_phys && info.secrets_len == PAGE_SIZE)
>>> +        return info.secrets_phys;
>>
>> ... which begs the question: how do we verify the HV is not passing some
>> garbage instead of an actual secrets page?
>>
> 
> Unfortunately, the secrets page does not contain a magic header or uuid
> which a guest can read to verify that the page is actually populated by
> the PSP. 

In the SNP FW ABI document section 8.14.2.5 there's a Table 61 titled
Secrets Page Format, which states that the first field in that page is a
u32 VERSION field which should equal 2h.

While not as strict as GUID header, this can help detect early that the
content of the SNP secrets page is invalid.

-Dov

> But since the page is encrypted before the launch so this page
> is always accessed encrypted. If hypervisor is tricking us then all that
> means is guest OS will get a wrong key and will not be able to
> communicate with the PSP to get the attestation reports etc.
> 
> 
>> I guess it is that:
>>
>> "SNP_LAUNCH_UPDATE can insert two special pages into the guest’s
>> memory: the secrets page and the CPUID page. The secrets page contains
>> encryption keys used by the guest to interact with the firmware. Because
>> the secrets page is encrypted with the guest’s memory encryption
>> key, the hypervisor cannot read the keys. The CPUID page contains
>> hypervisor provided CPUID function values that it passes to the guest.
>> The firmware validates these values to ensure the hypervisor is not
>> providing out-of-range values."
>>
>>  From "4.5 Launching a Guest" in the SNP FW ABI spec.
>>
>> I think that explanation above is very important wrt to explaining the
>> big picture how this all works with those pages injected into the guest
>> so I guess somewhere around here a comment should say
>>
> 
> I will add more explanation.
> 
>> "See section 4.5 Launching a Guest in the SNP FW ABI spec for details
>> about those special pages."
>>
>> or so.
>>
