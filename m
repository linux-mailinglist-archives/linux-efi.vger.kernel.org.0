Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1D3FD5A8
	for <lists+linux-efi@lfdr.de>; Wed,  1 Sep 2021 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbhIAIeV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Sep 2021 04:34:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243562AbhIAIeO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Sep 2021 04:34:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18184TuB074153;
        Wed, 1 Sep 2021 04:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wTyTfHd7TSM/j7teZCQHStIyAgYflYh980W3yUujmzg=;
 b=SVINeSCnKJpQrAlY+H4xBh8erXH2sN7GVXnodgx9IzfdrpxNYhlGq6fghQ4ZTj5LHsRr
 Ik7lAq5lLx/HL5BOtshhXth9mmxANfSm3dEwofBrp6BQngzAIXPwUuwTRtThk7u0j2US
 ba+9lJzgZFKqP83zI1zZfoQ63KDMvsQCVLG7CGlXFZMpeEKUSGKBjOnGOrUBHf6rUX1E
 fdWijevJljsT6qOT4vdnPGFzXqqFkvm9wjcqez7jVG0Cjc6WpsYVmnoTSCJ4x+dxKlJT
 NEQUtFjJj/ytvh4MiggMAhRT5E3yy7nBMgf+qnQ3DZ9Q7ZGocoiI1IaqqBz3Rns6x7zm mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3at3gdux57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 04:32:19 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18184U8F074175;
        Wed, 1 Sep 2021 04:32:18 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3at3gdux4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 04:32:18 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1818GlCb002939;
        Wed, 1 Sep 2021 08:32:17 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3aqcsca136-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 08:32:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1818WGew21102968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 08:32:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82B55C6057;
        Wed,  1 Sep 2021 08:32:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 525B0C6061;
        Wed,  1 Sep 2021 08:32:10 +0000 (GMT)
Received: from [9.148.12.157] (unknown [9.148.12.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Sep 2021 08:32:10 +0000 (GMT)
Subject: Re: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get
 extended report
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
 <20210820151933.22401-39-brijesh.singh@amd.com>
 <bd5b2d47-2f66-87d9-ce1e-dfe717741d22@linux.ibm.com>
 <e7e35408-9336-2b89-6028-c201b406f5f3@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <a49bafa9-e00c-7dec-ec07-08f4dfd6400f@linux.ibm.com>
Date:   Wed, 1 Sep 2021 11:32:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e7e35408-9336-2b89-6028-c201b406f5f3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5JSPlWLptOL7Dhu_Di7WHkrO4hX69CiQ
X-Proofpoint-GUID: 7QaYGXi0QrcH-JVSb44dmDj7gh7m4Utd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_02:2021-08-31,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=986 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010045
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 01/09/2021 0:11, Brijesh Singh wrote:
> 
> 
> On 8/31/21 3:22 PM, Dov Murik wrote:
>> Hi Brijesh,
>>
>> On 20/08/2021 18:19, Brijesh Singh wrote:
>>> Version 2 of GHCB specification defines NAE to get the extended guest
>>> request. It is similar to the SNP_GET_REPORT ioctl. The main difference
>>> is related to the additional data that be returned. The additional
>>> data returned is a certificate blob that can be used by the SNP guest
>>> user.
>>
>> It seems like the SNP_GET_EXT_REPORT ioctl does everything that the
>> SNP_GET_REPORT ioctl does, and more.  Why expose SNP_GET_REPORT to
>> userspace at all?
>>
>>
> 
> Since both of these options are provided by the GHCB protocol so I
> exposed it. Its possible that some applications may not care about the
> extended certificate blob. And in those case, if the hypervisor is
> programmed with the extended certificate blob and caller does not supply
> the enough number of pages to copy the blob then command should fail.
> This will enforce a new requirement on that guest application to
> allocate an extra memory. e.g:
> 
> 1. Hypervisor is programmed with a system wide certificate blob using
> the SNP_SET_EXT_CONFIG ioctl().
> 
> 2. Guest wants to get the report but does not care about the certificate
> blob.
> 
> 3. Guest issues a extended guest report with the npages = 0. The command
> will fail with invalid length and number of pages will be returned in
> the response.
> 
> 4. Guest will not need to allocate memory to hold the certificate and
> reissue the command.
> 
> The #4 is unnecessary for a guest which does not want to get. In this
> case, a guest can simply call the attestation report without asking for
> certificate blob. Please see the GHCB spec for more details.
> 

OK.  Originally I thought that by passing certs_address=NULL and
certs_len=0 the user program can say "I don't want this extra data"; but
now I understand that this will return an error (invalid length) with
number of pages needed.

-Dov
