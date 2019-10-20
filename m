Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066F1DDBC6
	for <lists+linux-efi@lfdr.de>; Sun, 20 Oct 2019 02:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfJTA6z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Oct 2019 20:58:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfJTA6z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Oct 2019 20:58:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9K0utof072856
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 20:58:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vr7muqw3m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 20:58:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Oct 2019 01:58:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Oct 2019 01:58:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9K0wi1c21299402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Oct 2019 00:58:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02D6E4C044;
        Sun, 20 Oct 2019 00:58:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6B044C040;
        Sun, 20 Oct 2019 00:58:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.181.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Oct 2019 00:58:41 +0000 (GMT)
Subject: Re: [PATCH v8 7/8] ima: check against blacklisted hashes for files
 with modsig
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
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Sat, 19 Oct 2019 20:58:41 -0400
In-Reply-To: <1571508377-23603-8-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
         <1571508377-23603-8-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102000-0020-0000-0000-0000037B2A5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102000-0021-0000-0000-000021D15CCD
Message-Id: <1571533121.5250.329.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910200006
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2019-10-19 at 14:06 -0400, Nayna Jain wrote:

> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 29ebe9afdac4..4c97afcc0f3c 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,6 +25,7 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> +				[appraise_flag=[check_blacklist]]

Like the other options, only "[[appraise_flag=]]" should be defined
here.  The values should be defined in the "option:" section.

>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
> 

>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 136ae4e0ee92..7a002b08dde8 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c

> @@ -303,6 +304,36 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
>  	return rc;
>  }
>  
> +/*
> + * ima_blacklist_measurement - Checks whether the binary is blacklisted. If

Please update the function name to reflect the actual function name.

> + * yes, then adds the hash of the blacklisted binary to the measurement list.

Refer to Documentation/process/coding-style.rst section "8)
Commenting" on how to format function comments.  Don't start a
sentence with "If yes,".

> + *
> + * Returns -EPERM if the hash is blacklisted.
> + */
> +int ima_check_blacklist(struct integrity_iint_cache *iint,
> +			const struct modsig *modsig, int pcr)
> +{
> +	enum hash_algo hash_algo;

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 5380aca2b351..bfaae7a8443a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c

> @@ -1172,6 +1173,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			else
>  				result = -EINVAL;
>  			break;
> +		case Opt_appraise_flag:
> +			ima_log_string(ab, "appraise_flag", args[0].from);
> +			if (strstr(args[0].from, "blacklist"))
> +				entry->flags |= IMA_CHECK_BLACKLIST;
> +			break;

When adding a new policy rule option, ima_policy_show() needs to be
updated as well.

Mimi

>  		case Opt_permit_directio:
>  			entry->flags |= IMA_PERMIT_DIRECTIO;
>  			break;
> 

