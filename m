Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA7C92FC
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfJBUoP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 16:44:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728225AbfJBUoP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 16:44:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92Kfd9x018106
        for <linux-efi@vger.kernel.org>; Wed, 2 Oct 2019 16:44:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vd1783frd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2019 16:44:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 2 Oct 2019 21:44:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 21:44:06 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x92Ki5FD63176838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 20:44:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6E57AE045;
        Wed,  2 Oct 2019 20:44:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED43CAE051;
        Wed,  2 Oct 2019 20:44:02 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Oct 2019 20:44:02 +0000 (GMT)
Subject: Re: [PATCH v6 7/9] ima: check against blacklisted hashes for files
 with modsig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        devicetree@vger.kernel.org
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
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Wed, 02 Oct 2019 16:44:01 -0400
In-Reply-To: <1569594360-7141-8-git-send-email-nayna@linux.ibm.com>
References: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com>
         <1569594360-7141-8-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100220-0028-0000-0000-000003A57027
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100220-0029-0000-0000-0000246774F9
Message-Id: <1570049041.4421.40.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020164
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2019-09-27 at 10:25 -0400, Nayna Jain wrote:
> Asymmetric private keys are used to sign multiple files. The kernel
> currently support checking against the blacklisted keys. However, if the
> public key is blacklisted, any file signed by the blacklisted key will
> automatically fail signature verification. We might not want to blacklist
> all the files signed by a particular key, but just a single file. 
> Blacklisting the public key is not fine enough granularity.
> 
> This patch adds support for blacklisting binaries with appended signatures,
> based on the IMA policy.  Defined is a new policy option
> "appraise_flag=check_blacklist".
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  Documentation/ABI/testing/ima_policy  |  1 +
>  security/integrity/ima/ima.h          | 12 +++++++++
>  security/integrity/ima/ima_appraise.c | 35 +++++++++++++++++++++++++++
>  security/integrity/ima/ima_main.c     |  8 ++++--
>  security/integrity/ima/ima_policy.c   | 10 ++++++--
>  security/integrity/integrity.h        |  1 +
>  6 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 29ebe9afdac4..4c97afcc0f3c 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,6 +25,7 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> +				[appraise_flag=[check_blacklist]]
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 9bf509217e8e..2c034728b239 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -254,6 +254,9 @@ int ima_policy_show(struct seq_file *m, void *v);
>  #define IMA_APPRAISE_KEXEC	0x40
>  
>  #ifdef CONFIG_IMA_APPRAISE
> +int ima_blacklist_measurement(struct integrity_iint_cache *iint,
> +			      const struct modsig *modsig, int action,
> +			      int pcr, struct ima_template_desc *template_desc);
>  int ima_appraise_measurement(enum ima_hooks func,
>  			     struct integrity_iint_cache *iint,
>  			     struct file *file, const unsigned char *filename,
> @@ -269,6 +272,15 @@ int ima_read_xattr(struct dentry *dentry,
>  		   struct evm_ima_xattr_data **xattr_value);
>  
>  #else
> +static inline int ima_blacklist_measurement(struct integrity_iint_cache *iint,
> +					    const struct modsig *modsig,
> +					    int action, int pcr,
> +					    struct ima_template_desc
> +					    *template_desc)
> +{
> +	return 0;
> +}
> +
>  static inline int ima_appraise_measurement(enum ima_hooks func,
>  					   struct integrity_iint_cache *iint,
>  					   struct file *file,
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 136ae4e0ee92..a5a82e870e24 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -12,6 +12,7 @@
>  #include <linux/magic.h>
>  #include <linux/ima.h>
>  #include <linux/evm.h>
> +#include <keys/system_keyring.h>
>  
>  #include "ima.h"
>  
> @@ -303,6 +304,40 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
>  	return rc;
>  }
>  
> +/*
> + * ima_blacklist_measurement - checks if the file measurement is blacklisted
> + *
> + * Returns -EKEYREJECTED if the hash is blacklisted.
> + */


In the function comment, please mention that blacklisted binaries are
included in the IMA measurement list.

> +int ima_blacklist_measurement(struct integrity_iint_cache *iint,
> +			      const struct modsig *modsig, int action, int pcr,
> +			      struct ima_template_desc *template_desc)
> +{
> +	enum hash_algo hash_algo;
> +	const u8 *digest = NULL;
> +	u32 digestsize = 0;
> +	u32 secid;
> +	int rc = 0;
> +
> +	if (!(iint->flags & IMA_CHECK_BLACKLIST))
> +		return 0;
> +
> +	if (iint->flags & IMA_MODSIG_ALLOWED) {
> +		security_task_getsecid(current, &secid);
> +		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
> +
> +		rc = is_hash_blacklisted(digest, digestsize, "bin");
> +
> +		/* Returns -EKEYREJECTED on blacklisted hash found */

is_hash_blacklisted() returning -EKEYREJECTED makes sense if the key
is blacklisted, not so much for a binary.  It would make more sense to
define is_binary_blacklisted(), as a wrapper for
is_hash_blacklisted().


> +		if ((rc == -EKEYREJECTED) && (iint->flags & IMA_MEASURE))
> +			process_buffer_measurement(digest, digestsize,
> +						   "blacklisted-hash", pcr,
> +						   template_desc);

For appended signatures, the IMA policy measurement rule would
normally be "template=ima-modsig".  Shouldn't the "template_desc" for
blacklisted binaries be "template=ima-buf"?

> +	}
> +
> +	return rc;
> +}
> +
>  /*
>   * ima_appraise_measurement - appraise file measurement
>   *
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index ae0c1bdc4eaf..92c446045637 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -336,8 +336,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  				      template_desc);
>  	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
>  		inode_lock(inode);

The lock is needed for updating the extended attributes (in IMA fix
mode).  Please limit taking the lock to ima_appraise_measurement().

> -		rc = ima_appraise_measurement(func, iint, file, pathname,
> -					      xattr_value, xattr_len, modsig);
> +		rc = ima_blacklist_measurement(iint, modsig, action, pcr,
> +					       template_desc);

process_measurement() calls a number of functions: ima_collect_measurement(), ima_store_measurement(), ima_appraise_measurement() and ima_audit_measurement().  The action is contained within the name (eg. collect, store, appraise, audit).   "blacklist" implies the function is blacklisting a file hash, as opposed to checking whether the file hash is already black listed.  Changing the tense from "blacklist" to "blacklisted" would help.

Renaming the function to "ima_is_binary_blacklisted" would be even better.

Mimi

> +		if (rc != -EKEYREJECTED)
> +			rc = ima_appraise_measurement(func, iint, file,
> +						      pathname, xattr_value,
> +						      xattr_len, modsig);
>  		inode_unlock(inode);
>  		if (!rc)
>  			rc = mmap_violation_check(func, file, &pathbuf,
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 4badc4fcda98..ad3b3af69460 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -765,8 +765,8 @@ enum {
>  	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
>  	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
> -	Opt_appraise_type, Opt_permit_directio,
> -	Opt_pcr, Opt_template, Opt_err
> +	Opt_appraise_type, Opt_appraise_flag,
> +	Opt_permit_directio, Opt_pcr, Opt_template, Opt_err
>  };
>  
>  static const match_table_t policy_tokens = {
> @@ -798,6 +798,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_euid_lt, "euid<%s"},
>  	{Opt_fowner_lt, "fowner<%s"},
>  	{Opt_appraise_type, "appraise_type=%s"},
> +	{Opt_appraise_flag, "appraise_flag=%s"},
>  	{Opt_permit_directio, "permit_directio"},
>  	{Opt_pcr, "pcr=%s"},
>  	{Opt_template, "template=%s"},
> @@ -1172,6 +1173,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			else
>  				result = -EINVAL;
>  			break;
> +		case Opt_appraise_flag:
> +			ima_log_string(ab, "appraise_flag", args[0].from);
> +			if (strstr(args[0].from, "blacklist"))
> +				entry->flags |= IMA_CHECK_BLACKLIST;
> +			break;
>  		case Opt_permit_directio:
>  			entry->flags |= IMA_PERMIT_DIRECTIO;
>  			break;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index d9323d31a3a8..73fc286834d7 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -32,6 +32,7 @@
>  #define EVM_IMMUTABLE_DIGSIG	0x08000000
>  #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
>  #define IMA_MODSIG_ALLOWED	0x20000000
> +#define IMA_CHECK_BLACKLIST	0x40000000
>  
>  #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
>  				 IMA_HASH | IMA_APPRAISE_SUBMASK)

