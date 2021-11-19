Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3D4566E3
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhKSAXf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 19:23:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233540AbhKSAXe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 19:23:34 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AINTFiW017611;
        Fri, 19 Nov 2021 00:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eh4PUYsknswKArA0CdWkScND1gjHbP1UN9H27ZfSFU4=;
 b=pUFg+NRaEE+jNWHMJ4CWvKlJoM4TpCW1hXr35vRyhG1L15QNhoVL+2WADngMEnjrWtxl
 r15DLWomxxWzk6FnGVN5YgM4HJpJR8BfymLQppPk16a1A1rIW6cDot0yd9RN/Yppb+vY
 cX0SJnyWTVgESum/KP4YsboTk8UjHKdMtI/CyUpS2YYeEBaIO/ycHReuLwOt9KM7hZKf
 liZx4VdQW6H9fzN8pcnuP3z3/xZ1WICtZZTX0WOeTj/ivaf7blVT7aNKXFjV3Ct+x0UG
 4oBs0G6XmR7VI+sIm44E76AccxPIJlmdMsPRXuEleLoJg13xOBckgySnVcbiO7hehXwD BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ce0hxh6en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:20:15 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AINVtqU027939;
        Fri, 19 Nov 2021 00:20:14 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ce0hxh6e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:20:14 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ0HjHi024340;
        Fri, 19 Nov 2021 00:20:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3ca50as4vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:20:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ0KAwi63897868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 00:20:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9812A4064;
        Fri, 19 Nov 2021 00:20:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAC37A4054;
        Fri, 19 Nov 2021 00:20:06 +0000 (GMT)
Received: from sig-9-65-86-194.ibm.com (unknown [9.65.86.194])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 00:20:06 +0000 (GMT)
Message-ID: <f1007bba5daa81d6abdb89fffa6237b54d1ad496.camel@linux.ibm.com>
Subject: Re: [PATCH v7 11/17] KEYS: Introduce link restriction for machine
 keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 18 Nov 2021 19:20:06 -0500
In-Reply-To: <20211116001545.2639333-12-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-12-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qxPCgxSxQ4O1C4nsPuyTHvaAcViDnNcY
X-Proofpoint-ORIG-GUID: Rl2DH5ysERBusxyuBAZhk8KS7XCFwYla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180122
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> Introduce a new link restriction that includes the trusted builtin,
> secondary and machine keys. The restriction is based on the key to be
> added being vouched for by a key in any of these three keyrings.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v3: Initial version
> v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
> v5: Rename to machine keyring
> v6: Change subject name (suggested by Mimi)
>     Rename restrict_link_by_builtin_secondary_and_ca_trusted
>       to restrict_link_by_builtin_secondary_and_machine (suggested by
>       Mimi)
> v7: Unmodified from v6
> ---
>  certs/system_keyring.c        | 23 +++++++++++++++++++++++
>  include/keys/system_keyring.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index bc7e44fc82c2..71a00add9805 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  	machine_trusted_keys = keyring;
>  }
> +
> +/**

This begins the start of kernel doc. 

> + * restrict_link_by_builtin_secondary_and_machine

Missing are the parameter defintions.  Please refer to
Documentation/doc-guide/kernel-doc.rst for details.

Mimi

> + *
> + * Restrict the addition of keys into a keyring based on the key-to-be-added
> + * being vouched for by a key in either the built-in, the secondary, or
> + * the machine keyrings.
> + */
> +int restrict_link_by_builtin_secondary_and_machine(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key)
> +{
> +	if (machine_trusted_keys && type == &key_type_keyring &&
> +	    dest_keyring == secondary_trusted_keys &&
> +	    payload == &machine_trusted_keys->payload)
> +		/* Allow the machine keyring to be added to the secondary */
> +		return 0;
> +
> +	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
> +							      payload, restrict_key);
> +}
>  #endif
>  
>  /*
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 98c9b10cdc17..2419a735420f 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  #endif
>  
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +extern int restrict_link_by_builtin_secondary_and_machine(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key);
>  extern void __init set_machine_trusted_keys(struct key *keyring);
>  #else
> +#define restrict_link_by_builtin_secondary_and_machine restrict_link_by_builtin_trusted
>  static inline void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  }


