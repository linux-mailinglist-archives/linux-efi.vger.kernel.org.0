Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D34565FC
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 00:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhKRXDb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 18:03:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhKRXDb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 18:03:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIMfEoB030957;
        Thu, 18 Nov 2021 23:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DQnLDTzciCHghFIlOd+xNi8zoJSyz211x4H5X+3Z/bY=;
 b=oEBAJVNsIG4FEW/pLprfAxi52topAZ4iB2VUdVD2xDo2AYp88TS4fMMVfiVteANnpScQ
 Io5oAYrU8acL+BpVKqGghASSnaIqXHJ/Ko/s8otmEZNTOLSvxZQG10afCUa3ehLCYonT
 CEX7cML3cET7/LvE9XF7LEC1WL7iF1RQmlgUXeGpFaw18FPvfcuwDU5scW7m/XWd8tQm
 mIBl1kOg2qbyyQoeXFMClA/RoTsFRayT+FwZuqbRkrPMpttoCLEY9zmutjLAY5NYkK93
 j+2iy6bAdftJaYK8uAuyqXiIIevHSJBq5SV+ldMymhGuzKcpUsMsqAaTTJ5hlH1BLhkC iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdyufr8gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 23:00:03 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AIMiJdP008274;
        Thu, 18 Nov 2021 23:00:02 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdyufr8fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 23:00:02 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIMrngq022719;
        Thu, 18 Nov 2021 23:00:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3ca4mkrw85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 23:00:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIMxvW262259634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 22:59:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5158BA4065;
        Thu, 18 Nov 2021 22:59:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF7A9A4054;
        Thu, 18 Nov 2021 22:59:52 +0000 (GMT)
Received: from sig-9-65-86-194.ibm.com (unknown [9.65.86.194])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 22:59:52 +0000 (GMT)
Message-ID: <90223050186b384288e5d8f7aed8af5c8111d3e8.camel@linux.ibm.com>
Subject: Re: [PATCH v7 04/17] X.509: Parse Basic Constraints for CA
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
Date:   Thu, 18 Nov 2021 17:59:52 -0500
In-Reply-To: <20211116001545.2639333-5-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BrmCOSPI_JEOenTmJCdGmv7HgBg67WSA
X-Proofpoint-GUID: NErLt8s8iodGUEHssnsz8Zd8Y1lR8LQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180115
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> Parse the X.509 Basic Constraints.  The basic constraints extension
> identifies whether the subject of the certificate is a CA.
> 
> BasicConstraints ::= SEQUENCE {
>         cA                      BOOLEAN DEFAULT FALSE,
>         pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
> 
> If the CA is true, store it in a new public_key field call key_is_ca.
> This will be used in a follow on patch that requires knowing if the
> public key is a CA.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v7: Initial version
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
>  include/crypto/public_key.h               | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 6d003096b5bc..f4299b8a4926 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -571,6 +571,15 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_basicConstraints) {
> +		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
> +			return -EBADMSG;
> +		if (v[1] != vlen - 2)
> +			return -EBADMSG;
> +		if (v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
> +			ctx->cert->pub->key_is_ca = true;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index a9b2e600b7cc..61c66be80995 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -28,6 +28,7 @@ struct public_key {
>  	bool key_is_private;
>  	const char *id_type;
>  	const char *pkey_algo;
> +	bool key_is_ca;

David added "key_is_private" intentionally where he did.  Adding the
"key_is_ca" immediately afterwards doesn't change the struct size.

Mimi

>  };
>  
>  extern void public_key_free(struct public_key *key);


