Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054594AD298
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 08:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiBHH5f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 02:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiBHH5e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 02:57:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB51C0401EF;
        Mon,  7 Feb 2022 23:57:32 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2185gFe8022851;
        Tue, 8 Feb 2022 07:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gtXrtw7v/3SXOtkad2MXOemabtU5jV15ZauhrTAWKX4=;
 b=ggv8EE4aJX/LIncKHPapugyLjX6O4nOxTSJMNOygzNpRzfSuy8PX1CGtNUK6ows24YHC
 ooOVjR4tbFgbJIFITa/vz6+vFP0GuqNiUDvRfwaPRKr4QzXidRHOQ1WWFp9lLudZd1p5
 crBBRYc+zDi3G6MqsTr/HCl90eN4EzXRIfESwYj6AfU+72Z46oNngFzMBXq9rO65W2kY
 zkcUmP76pHj7ifuzMjv1c8bIj5ExDLY0ql+rfYwqDo/EWDLUiKOX+aeh6yUedbQeOEDv
 e5Cl9PIbOej9lFoRxbUG3S6BJ6WOQMHpQnJfbE7sFJSq4m35QBPNd0hrT6MCUkULQ94n bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kqjms7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 07:57:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2186xLGF012181;
        Tue, 8 Feb 2022 07:57:02 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kqjmrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 07:57:02 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2187rsvV025229;
        Tue, 8 Feb 2022 07:57:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3e2f8n0w3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 07:57:01 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2187v09V15532352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 07:57:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12B0EBE04F;
        Tue,  8 Feb 2022 07:57:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD478BE059;
        Tue,  8 Feb 2022 07:56:52 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 07:56:52 +0000 (GMT)
Message-ID: <cd3ef9dd-cfc5-ac8c-d524-d8d4416f5cad@linux.ibm.com>
Date:   Tue, 8 Feb 2022 09:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
Content-Language: en-US
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Liam Merwick <liam.merwick@oracle.com>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com> <YgDduR0mrptX5arB@zn.tnic>
 <1cb4fdf5-7c1e-6c8f-1db6-8c976d6437c2@amd.com>
 <ae1644a3-bd2c-6966-4ae3-e26abd77b77b@linux.ibm.com>
 <20ba1ac2-83d1-6766-7821-c9c8184fb59b@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20ba1ac2-83d1-6766-7821-c9c8184fb59b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qvassD_Uu8uQX6f_dwT-iYnruSlWvah-
X-Proofpoint-ORIG-GUID: c-8-weD6JHfrfspuix_37e4dnbGaP-Xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_02,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 07/02/2022 22:08, Brijesh Singh wrote:
> 
> 
> On 2/7/22 1:09 PM, Dov Murik wrote:
>>
>>
>> On 07/02/2022 18:23, Brijesh Singh wrote:
>>>
>>>
>>> On 2/7/22 2:52 AM, Borislav Petkov wrote:
>>>> Those are allocated on stack, why are you clearing them?
>>>
>>> Yep, no need to explicitly clear it. I'll take it out in next rev.
>>>
>>
>> Wait, this is key material generated by PSP and passed to userspace.
>> Why leave copies of it floating around kernel memory?  I thought that's
>> the whole reason for these memzero_explicit() calls (maybe add a
>> comment?).
>>
> 
> 
> Ah, now I remember I added the memzero_explicit() to address your review
> feedback :) In that patch version, we were using the kmalloc() to store
> the response data; since then, we switched to stack. We will leak the
> key outside when the stack is converted private-> shared; I don't know
> if any of these are going to happen. I can add a comment and keep the
> memzero_explicit() call.
> 

Just to be clear, I didn't mean necessarily "leak the key to the
untrusted host" (even if a page is converted back from private to
shared, it is encrypted, so host can't read its contents).  But even
*inside* the guest, when dealing with sensitive data like keys, we
should minimize the amount of copies that float around (I assume this is
the reason for most of the uses of memzero_explicit() in the kernel).

-Dov



> Boris, let me know if you are okay with it?
> 
> 
>> As an example, in arch/x86/crypto/aesni-intel_glue.c there are two calls
>> to memzero_explicit(), both on stack variables; the only reason for
>> these calls (as I understand it) is to avoid some future possible leak
>> of this sensitive data (keys, cipher context, etc.).  I'm sure there are
>> other examples in the kernel code.
>>
