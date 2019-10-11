Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB805D40E4
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 15:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfJKNSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 09:18:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728292AbfJKNSb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 09:18:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9BD8Ycv094753
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:18:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vjqj97kf0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:18:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 11 Oct 2019 14:18:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Oct 2019 14:18:22 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9BDIK0T35848280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 13:18:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4B0711C06E;
        Fri, 11 Oct 2019 13:18:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EEF711C05B;
        Fri, 11 Oct 2019 13:18:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Oct 2019 13:18:18 +0000 (GMT)
Subject: Re: [PATCH v7 6/8] certs: add wrapper function to check blacklisted
 binary hash
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
        "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 11 Oct 2019 09:18:17 -0400
In-Reply-To: <1570497267-13672-7-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
         <1570497267-13672-7-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101113-0028-0000-0000-000003A92DAB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101113-0029-0000-0000-0000246B3A28
Message-Id: <1570799897.5250.79.camel@linux.ibm.com>
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

On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
> The existing is_hash_blacklisted() function returns -EKEYREJECTED
> error code for both the blacklisted keys and binaries.
> 
> This patch adds a wrapper function is_binary_blacklisted() to check
> against binary hashes and returns -EPERM.    
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

This patch description describes what you're doing, not the
motivation.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  certs/blacklist.c             | 9 +++++++++
>  include/keys/system_keyring.h | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index ec00bf337eb6..6514f9ebc943 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -135,6 +135,15 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
>  }
>  EXPORT_SYMBOL_GPL(is_hash_blacklisted);
>  
> +int is_binary_blacklisted(const u8 *hash, size_t hash_len)
> +{
> +	if (is_hash_blacklisted(hash, hash_len, "bin") == -EKEYREJECTED)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(is_binary_blacklisted);
> +
>  /*
>   * Initialise the blacklist
>   */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index c1a96fdf598b..fb8b07daa9d1 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -35,12 +35,18 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  extern int mark_hash_blacklisted(const char *hash);
>  extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
>  			       const char *type);
> +extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
>  #else
>  static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
>  				      const char *type)
>  {
>  	return 0;
>  }
> +
> +static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_IMA_BLACKLIST_KEYRING

