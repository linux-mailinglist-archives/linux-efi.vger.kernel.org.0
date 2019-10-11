Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62381D40C3
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfJKNOP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 09:14:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728151AbfJKNOO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 09:14:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9BDBJId098990
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:14:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vjtdd050d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:14:13 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 11 Oct 2019 14:14:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Oct 2019 14:14:06 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9BDE4P757999396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 13:14:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B3F442042;
        Fri, 11 Oct 2019 13:14:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE844203F;
        Fri, 11 Oct 2019 13:14:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Oct 2019 13:14:02 +0000 (GMT)
Subject: Re: [PATCH v7 5/8] ima: make process_buffer_measurement() generic
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Date:   Fri, 11 Oct 2019 09:14:01 -0400
In-Reply-To: <1570497267-13672-6-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
         <1570497267-13672-6-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101113-4275-0000-0000-000003713179
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101113-4276-0000-0000-000038843CBB
Message-Id: <1570799641.5250.75.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910110124
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Cc'ing Prakhar Srivastava]

On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
> An additional measurement record is needed to indicate the blacklisted
> binary. The record will measure the blacklisted binary hash.
> 
> This patch makes the function process_buffer_measurement() generic to be
> called by the blacklisting function. It modifies the function to handle
> more than just the KEXEC_CMDLINE.

The purpose of this patch is to make process_buffer_measurement() more
generic.  The patch description should simply say,
process_buffer_measurement() is limited to measuring the kexec boot
command line.  This patch makes process_buffer_measurement() more
generic, allowing it to measure other types of buffer data (eg.
blacklisted binary hashes).

Mimi

> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h      |  3 +++
>  security/integrity/ima/ima_main.c | 29 ++++++++++++++---------------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3689081aaf38..ed86c1f70d7f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -217,6 +217,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
>  			   struct ima_template_desc *template_desc);
> +void process_buffer_measurement(const void *buf, int size,
> +				const char *eventname, int pcr,
> +				struct ima_template_desc *template_desc);
>  void ima_audit_measurement(struct integrity_iint_cache *iint,
>  			   const unsigned char *filename);
>  int ima_alloc_init_template(struct ima_event_data *event_data,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 60027c643ecd..77115e884496 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -626,14 +626,14 @@ int ima_load_data(enum kernel_load_data_id id)
>   * @buf: pointer to the buffer that needs to be added to the log.
>   * @size: size of buffer(in bytes).
>   * @eventname: event name to be used for the buffer entry.
> - * @cred: a pointer to a credentials structure for user validation.
> - * @secid: the secid of the task to be validated.
> + * @pcr: pcr to extend the measurement
> + * @template_desc: template description
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
> -static void process_buffer_measurement(const void *buf, int size,
> -				       const char *eventname,
> -				       const struct cred *cred, u32 secid)
> +void process_buffer_measurement(const void *buf, int size,
> +				const char *eventname, int pcr,
> +				struct ima_template_desc *template_desc)
>  {
>  	int ret = 0;
>  	struct ima_template_entry *entry = NULL;
> @@ -642,19 +642,11 @@ static void process_buffer_measurement(const void *buf, int size,
>  					    .filename = eventname,
>  					    .buf = buf,
>  					    .buf_len = size};
> -	struct ima_template_desc *template_desc = NULL;
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
>  	} hash = {};
>  	int violation = 0;
> -	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> -	int action = 0;
> -
> -	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> -				&template_desc);
> -	if (!(action & IMA_MEASURE))
> -		return;
>  
>  	iint.ima_hash = &hash.hdr;
>  	iint.ima_hash->algo = ima_hash_algo;
> @@ -686,12 +678,19 @@ static void process_buffer_measurement(const void *buf, int size,
>   */
>  void ima_kexec_cmdline(const void *buf, int size)
>  {
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	struct ima_template_desc *template_desc = NULL;
> +	int action;
>  	u32 secid;
>  
>  	if (buf && size != 0) {
>  		security_task_getsecid(current, &secid);
> -		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0,
> +					KEXEC_CMDLINE, &pcr, &template_desc);
> +		if (!(action & IMA_MEASURE))
> +			return;
> +		process_buffer_measurement(buf, size, "kexec-cmdline", pcr,
> +					   template_desc);
>  	}
>  }
>  

