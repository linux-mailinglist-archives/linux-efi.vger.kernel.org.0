Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46F4282C2
	for <lists+linux-efi@lfdr.de>; Sun, 10 Oct 2021 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhJJRyL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 10 Oct 2021 13:54:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231396AbhJJRyK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 10 Oct 2021 13:54:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19AGfxpt018676;
        Sun, 10 Oct 2021 13:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8fajRAyLezHmCj5tnyq6jjoYckaHOnt9JulikSV16CQ=;
 b=p4+ivKM1gAEjETiBx+Ee0HBzE8i3PqQg2hBYA97Vxj+ZAW9H7UQu5fs184XNnaPUZzlX
 J8BNWXxknJB0kmcB9gP5+kAqccFZcDMgLyaMW/Gv3Nc+tpBcNSxoQkYUQjKOd9A+AMNu
 XlF2Fok+DLqer9S64tnQKRVnetmxvE98H1HWpMFAGnuv/n/c+I9f+le2gaerQmXxAZ0O
 acP9+8MTwYDZA7XYfUn1vKwOKFAuE1AxzRaLEmbw26toZuVN3MCZ/VrPOwxHYy1dQk7Z
 qDIlto7o91RwLpI3X1Dupoe5pVnQAlXh+4nLD/UjBxIPEPn6/DfSYlYH/KvzL4YcqC+d Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bm3wvrqay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Oct 2021 13:51:30 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19AHpTbY009651;
        Sun, 10 Oct 2021 13:51:30 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bm3wvrqaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Oct 2021 13:51:29 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19AHmBCX013224;
        Sun, 10 Oct 2021 17:51:28 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3bkeq5ca5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Oct 2021 17:51:28 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19AHpQ2V36241806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Oct 2021 17:51:26 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5DFB136051;
        Sun, 10 Oct 2021 17:51:26 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEE1B13604F;
        Sun, 10 Oct 2021 17:51:18 +0000 (GMT)
Received: from [9.65.95.104] (unknown [9.65.95.104])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 10 Oct 2021 17:51:18 +0000 (GMT)
Subject: Re: [PATCH v6 40/42] virt: Add SEV-SNP guest driver
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-41-brijesh.singh@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <b79cfdfa-6482-70ab-3520-f76387fe4c27@linux.ibm.com>
Date:   Sun, 10 Oct 2021 20:51:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211008180453.462291-41-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YBeyMoQMMm3SJoHLC39vmKofxUAJszj-
X-Proofpoint-GUID: g_DMRlUvvUHE91j4L2Jc4IcxKCn7QVsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-10_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110100120
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,

On 08/10/2021 21:04, Brijesh Singh wrote:
> SEV-SNP specification provides the guest a mechanisum to communicate with
> the PSP without risk from a malicious hypervisor who wishes to read, alter,
> drop or replay the messages sent. The driver uses snp_issue_guest_request()
> to issue GHCB SNP_GUEST_REQUEST or SNP_EXT_GUEST_REQUEST NAE events to
> submit the request to PSP.
> 
> The PSP requires that all communication should be encrypted using key
> specified through the platform_data.
> 
> The userspace can use SNP_GET_REPORT ioctl() to query the guest
> attestation report.
> 
> See SEV-SNP spec section Guest Messages for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  |  77 ++++
>  drivers/virt/Kconfig                  |   3 +
>  drivers/virt/Makefile                 |   1 +
>  drivers/virt/coco/sevguest/Kconfig    |   9 +
>  drivers/virt/coco/sevguest/Makefile   |   2 +
>  drivers/virt/coco/sevguest/sevguest.c | 561 ++++++++++++++++++++++++++
>  drivers/virt/coco/sevguest/sevguest.h |  98 +++++
>  include/uapi/linux/sev-guest.h        |  44 ++
>  8 files changed, 795 insertions(+)
>  create mode 100644 Documentation/virt/coco/sevguest.rst
>  create mode 100644 drivers/virt/coco/sevguest/Kconfig
>  create mode 100644 drivers/virt/coco/sevguest/Makefile
>  create mode 100644 drivers/virt/coco/sevguest/sevguest.c
>  create mode 100644 drivers/virt/coco/sevguest/sevguest.h
>  create mode 100644 include/uapi/linux/sev-guest.h
> 

[...]


> +
> +static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
> +{
> +	u8 *key = NULL;
> +
> +	switch (id) {
> +	case 0:
> +		*seqno = &layout->os_area.msg_seqno_0;
> +		key = layout->vmpck0;
> +		break;
> +	case 1:
> +		*seqno = &layout->os_area.msg_seqno_1;
> +		key = layout->vmpck1;
> +		break;
> +	case 2:
> +		*seqno = &layout->os_area.msg_seqno_2;
> +		key = layout->vmpck2;
> +		break;
> +	case 3:
> +		*seqno = &layout->os_area.msg_seqno_3;
> +		key = layout->vmpck3;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return NULL;

This should be 'return key', right?

-Dov

> +}
> +
