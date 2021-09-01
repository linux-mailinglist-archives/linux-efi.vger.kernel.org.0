Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041773FD2EF
	for <lists+linux-efi@lfdr.de>; Wed,  1 Sep 2021 07:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhIAFff (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Sep 2021 01:35:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233857AbhIAFfe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Sep 2021 01:35:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18153fgS134449;
        Wed, 1 Sep 2021 01:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=w/8qMkCsZDkfkQ3Aww/zSfJ2vYvHc6uHfqVFAXK6anI=;
 b=YSoa9ViR8owy6FYW5J04AucsFH18U+Dgb81Fh8nNvd64TQtXlWVd1NlkFwkv8Y6F8ike
 x1BdwGXgx+WuMneWlyUyXfPYOKLoFOfOEjG619BnT9um52Wl349EFSWmiSFNraDKjYCs
 kVy5yB/PFqxwvYaITAKNqKL9NGzD1D/OQd6DDueH1ULYkYxOpYG0F0InPgXI1H5mXqJK
 xbWRS+bXlU8i2IWHlz6qnKsCCO/HPTpvwPxNB6k5Gl60LYDw72iJF0U+Krip4ucoJ5i0
 2x25sSkBH+0bn2gXx0OnIXQmv3wEJ0OvkV4rR1Jgu1tF1yqbUXwaC9Gwea2iKYf4CUwW MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at1p0tdu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 01:33:26 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1815CVL3170574;
        Wed, 1 Sep 2021 01:33:25 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at1p0tdtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 01:33:25 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1815QhD0019602;
        Wed, 1 Sep 2021 05:33:23 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3aqcscxxsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 05:33:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1815XMaH37290252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 05:33:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9463D7806E;
        Wed,  1 Sep 2021 05:33:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E265478067;
        Wed,  1 Sep 2021 05:33:13 +0000 (GMT)
Received: from [9.65.248.250] (unknown [9.65.248.250])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Sep 2021 05:33:13 +0000 (GMT)
Subject: Re: [PATCH Part1 v5 37/38] virt: sevguest: Add support to derive key
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-38-brijesh.singh@amd.com>
 <a6841be9-a2ca-8d92-3346-af8513b528fc@linux.ibm.com>
 <fd9fadae-a493-1d8d-6777-e1c789a5113f@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <55df11df-bf30-171e-9774-e6a6d380802a@linux.ibm.com>
Date:   Wed, 1 Sep 2021 08:33:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fd9fadae-a493-1d8d-6777-e1c789a5113f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VtNtiwnrUaraj9V-sE0mBNx1ZR9ze6u5
X-Proofpoint-ORIG-GUID: h7LxjRRoKWqtuCZrvNqMelbALA8Fm4AA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_01:2021-08-31,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010027
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 01/09/2021 0:04, Brijesh Singh wrote:
> Hi Dov,
> 
> 
> On 8/31/21 1:59 PM, Dov Murik wrote:
>>> +
>>> +    /*
>>> +     * The intermediate response buffer is used while decrypting the
>>> +     * response payload. Make sure that it has enough space to cover
>>> the
>>> +     * authtag.
>>> +     */
>>> +    resp_len = sizeof(resp->data) + crypto->a_len;
>>> +    resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
>>
>> The length of resp->data is 64 bytes; I assume crypto->a_len is not a
>> lot more (and probably known in advance for AES GCM).  Maybe use a
>> buffer on the stack instead of allocating and freeing?
>>
> 
> The authtag size can be up to 16 bytes, so I guess I can allocate 80
> bytes on stack and avoid the kzalloc().
> 
>>
>>> +    if (!resp)
>>> +        return -ENOMEM;
>>> +
>>> +    /* Issue the command to get the attestation report */
>>> +    rc = handle_guest_request(snp_dev, req.msg_version,
>>> SNP_MSG_KEY_REQ,
>>> +                  &req.data, sizeof(req.data), resp->data, resp_len,
>>> +                  &arg->fw_err);
>>> +    if (rc)
>>> +        goto e_free;
>>> +
>>> +    /* Copy the response payload to userspace */
>>> +    if (copy_to_user((void __user *)arg->resp_data, resp,
>>> sizeof(*resp)))
>>> +        rc = -EFAULT;
>>> +
>>> +e_free:
>>> +    kfree(resp);
>>
>> Since resp contains key material, I think you should explicit_memzero()
>> it before freeing, so the key bytes don't linger around in unused
>> memory.  I'm not sure if any copies are made inside the
>> handle_guest_request call above; maybe zero these as well.
>>
> 
> I can do that, but I guess I am trying to find a reason for it. The resp
> buffer is encrypted page, so, the key is protected from the hypervisor
> access. Are you thinking about an attack within the VM guest OS ?
> 

Yes, that's the concern, specifically with sensitive buffers (keys).
You don't want many copies floating around in unused memory.

-Dov
