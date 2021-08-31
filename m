Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707BE3FCD60
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbhHaTDJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 15:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233044AbhHaTDJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 15:03:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VIYaE6190029;
        Tue, 31 Aug 2021 15:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c894NqkClO2S/cNfR5jPdB8yh+/5jNax9upoCT+PBbQ=;
 b=maFR5BtkNnzJCryaVNbCte8MjXzWL/1lb2OeRZPri+4FngapJRAJ0ZkUsMwQ2/zYzIRL
 X6vxo2wyE6kWe2ZaoFM3P5+Pd2/TRmHFOt15gcV/Xw47lY+l7VG/HNzTCnUXM3WEruBN
 czclQSaYE9KpmTHSqI3RARPelP1mM9s1SrOyXVBE+0G+RWXpFPMciHRSZwNz7F5uXbxq
 muy2LxKa+ZSuHUNzVHEDIiFcZiBLlxklGqT6h8DJq1GUTMb+g7x7qe2zE0S8NRW04fhr
 Q6nCtCfoXVXw0MVS4KFhaDCwtVGa8ZyoZikKjCzvSSIHe4l4LXQnm2dW+crTA0f+R/r9 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3asq6qwgjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 15:00:10 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17VIYxxO191041;
        Tue, 31 Aug 2021 15:00:09 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3asq6qwgh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 15:00:09 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VIql7K031975;
        Tue, 31 Aug 2021 19:00:07 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3aqcscmkat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 19:00:06 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VJ05NI32244022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 19:00:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2DAD78070;
        Tue, 31 Aug 2021 19:00:05 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C06057805F;
        Tue, 31 Aug 2021 18:59:57 +0000 (GMT)
Received: from [9.65.248.250] (unknown [9.65.248.250])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 18:59:57 +0000 (GMT)
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
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <a6841be9-a2ca-8d92-3346-af8513b528fc@linux.ibm.com>
Date:   Tue, 31 Aug 2021 21:59:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820151933.22401-38-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x-GQFDI75MOUCg3HtmboN4XhFESyQPY8
X-Proofpoint-GUID: 1fiQyo2AqLY-nsniE3tha4fQsm0yMPGD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_08:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310102
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,

On 20/08/2021 18:19, Brijesh Singh wrote:
> The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
> ask the firmware to provide a key derived from a root key. The derived
> key may be used by the guest for any purposes it choose, such as a
> sealing key or communicating with the external entities.
> 
> See SEV-SNP firmware spec for more information.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  | 18 ++++++++++
>  drivers/virt/coco/sevguest/sevguest.c | 48 +++++++++++++++++++++++++++
>  include/uapi/linux/sev-guest.h        | 24 ++++++++++++++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> index 52d5915037ef..25446670d816 100644
> --- a/Documentation/virt/coco/sevguest.rst
> +++ b/Documentation/virt/coco/sevguest.rst
> @@ -67,3 +67,21 @@ provided by the SEV-SNP firmware to query the attestation report.
>  On success, the snp_report_resp.data will contains the report. The report
>  format is described in the SEV-SNP specification. See the SEV-SNP specification
>  for further details.
> +
> +2.2 SNP_GET_DERIVED_KEY
> +-----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in): struct snp_derived_key_req
> +:Returns (out): struct snp_derived_key_req on success, -negative on error
> +
> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
> +The derived key can be used by the guest for any purpose, such as sealing keys
> +or communicating with external entities.
> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
> +SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
> +on the various fileds passed in the key derivation request.
> +
> +On success, the snp_derived_key_resp.data will contains the derived key
> +value.
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index d029a98ad088..621b1c5a9cfc 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -303,6 +303,50 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_reque
>  	return rc;
>  }
>  
> +static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_derived_key_resp *resp;
> +	struct snp_derived_key_req req;
> +	int rc, resp_len;
> +
> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from the userspace */
> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
> +
> +	/* Message version must be non-zero */
> +	if (!req.msg_version)
> +		return -EINVAL;
> +
> +	/*
> +	 * The intermediate response buffer is used while decrypting the
> +	 * response payload. Make sure that it has enough space to cover the
> +	 * authtag.
> +	 */
> +	resp_len = sizeof(resp->data) + crypto->a_len;
> +	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);

The length of resp->data is 64 bytes; I assume crypto->a_len is not a
lot more (and probably known in advance for AES GCM).  Maybe use a
buffer on the stack instead of allocating and freeing?


> +	if (!resp)
> +		return -ENOMEM;
> +
> +	/* Issue the command to get the attestation report */
> +	rc = handle_guest_request(snp_dev, req.msg_version, SNP_MSG_KEY_REQ,
> +				  &req.data, sizeof(req.data), resp->data, resp_len,
> +				  &arg->fw_err);
> +	if (rc)
> +		goto e_free;
> +
> +	/* Copy the response payload to userspace */
> +	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +		rc = -EFAULT;
> +
> +e_free:
> +	kfree(resp);

Since resp contains key material, I think you should explicit_memzero()
it before freeing, so the key bytes don't linger around in unused
memory.  I'm not sure if any copies are made inside the
handle_guest_request call above; maybe zero these as well.

-Dov


> +	return rc;
> +}
> +
>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>  {
>  	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -320,6 +364,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>  		ret = get_report(snp_dev, &input);
>  		break;
>  	}
> +	case SNP_GET_DERIVED_KEY: {
> +		ret = get_derived_key(snp_dev, &input);
> +		break;
> +	}
>  	default:
>  		break;
>  	}
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index e8cfd15133f3..621a9167df7a 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -36,9 +36,33 @@ struct snp_user_guest_request {
>  	__u64 fw_err;
>  };
>  
> +struct __snp_derived_key_req {
> +	__u32 root_key_select;
> +	__u32 rsvd;
> +	__u64 guest_field_select;
> +	__u32 vmpl;
> +	__u32 guest_svn;
> +	__u64 tcb_version;
> +};
> +
> +struct snp_derived_key_req {
> +	/* message version number (must be non-zero) */
> +	__u8 msg_version;
> +
> +	struct __snp_derived_key_req data;
> +};
> +
> +struct snp_derived_key_resp {
> +	/* response data, see SEV-SNP spec for the format */
> +	__u8 data[64];
> +};
> +
>  #define SNP_GUEST_REQ_IOC_TYPE	'S'
>  
>  /* Get SNP attestation report */
>  #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_user_guest_request)
>  
> +/* Get a derived key from the root */
> +#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
> +
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> 
