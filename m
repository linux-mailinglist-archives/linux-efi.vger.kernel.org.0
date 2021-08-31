Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADD3FCE86
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhHaUYJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 16:24:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241090AbhHaUYI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 16:24:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VK907i151394;
        Tue, 31 Aug 2021 16:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ig7sVt9wfp6quoeY/muCeGzaKqcqMWXcgd0PrsiZb6w=;
 b=g0TARFiOrBmoQWj4hE7viys/Fyum/TPyqHzRu66rKnZJu7I8Jeya76WRiO9ceL8Fa2HT
 Zkqo0jArYFZP0KN9ny9S1H2FOsedDQaKFjAVDr6jhqAK2YTimtlxmB4F5macr9A90L30
 /7LKu/n2zRoYye7a6jgx4ZywlaPvfn9eRoDwL/rrjYYhXpSqbYn79pF4jLaSVDYdtWnw
 12tiQpDtPGguh5EjC3f70UY7iBwskPC4wvhocjFptsoMiqy5IMKRn873zrN9Sy9RdpdE
 0xWq3FXlMh2UY9/PFlDb2Ogd17pOHTq7fhjNFTFWmzXkRyK9z1nM9wW4WEl8u4bxU3pz Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3astk5s1xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 16:22:28 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17VK9XUU154067;
        Tue, 31 Aug 2021 16:22:27 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3astk5s1xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 16:22:27 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VKCfZi016728;
        Tue, 31 Aug 2021 20:22:25 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3aqcsdd8e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 20:22:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VKMOXt51904814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 20:22:24 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4198E78063;
        Tue, 31 Aug 2021 20:22:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE01A780D8;
        Tue, 31 Aug 2021 20:22:15 +0000 (GMT)
Received: from [9.65.248.250] (unknown [9.65.248.250])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 20:22:15 +0000 (GMT)
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
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <bd5b2d47-2f66-87d9-ce1e-dfe717741d22@linux.ibm.com>
Date:   Tue, 31 Aug 2021 23:22:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820151933.22401-39-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ULfOSV9PEPRbITNqCq9zYascDlVLWA6b
X-Proofpoint-ORIG-GUID: 11cFRGpYi2ZoT8RJDYNnY7ITk344_uEz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310109
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,

On 20/08/2021 18:19, Brijesh Singh wrote:
> Version 2 of GHCB specification defines NAE to get the extended guest
> request. It is similar to the SNP_GET_REPORT ioctl. The main difference
> is related to the additional data that be returned. The additional
> data returned is a certificate blob that can be used by the SNP guest
> user. 

It seems like the SNP_GET_EXT_REPORT ioctl does everything that the
SNP_GET_REPORT ioctl does, and more.  Why expose SNP_GET_REPORT to
userspace at all?


-Dov


> The certificate blob layout is defined in the GHCB specification.
> The driver simply treats the blob as a opaque data and copies it to
> userspace.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  |  22 +++++
>  drivers/virt/coco/sevguest/sevguest.c | 126 ++++++++++++++++++++++++++
>  include/uapi/linux/sev-guest.h        |  13 +++
>  3 files changed, 161 insertions(+)
> 

[...]
