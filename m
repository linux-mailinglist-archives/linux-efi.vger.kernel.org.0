Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0470E45D349
	for <lists+linux-efi@lfdr.de>; Thu, 25 Nov 2021 03:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhKYCzG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Nov 2021 21:55:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhKYCxG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Nov 2021 21:53:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP0N6aF002895;
        Thu, 25 Nov 2021 02:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=x7BpjpC4BkEYA1QyGTEcevnGCoPkRtbkKIs3gNljZf4=;
 b=nXgNXxnlOdQLKWCL+fWGi4Pl2rg4RUf4fPnxpUCLdmrI6QFwBhKlDXnM7/PYXio0q1Jp
 3DRISq+xakyCtALQ7wmkPe+Y4xXPQqNwZTcVQMaeomWwKydQtKn8L3d1IlDfrNpCZ9F3
 fdN0QVlyCBltWgCy5ZC/0a/mZWrHlTDnrQFiuX5J31plf/S1v9hc9K+eYZ0soocqH85K
 AuYqdCN0zedNRsJGR6Yrm4euDg+Fbn+K1EYfG88u8kypzNRshznegXqNOZ7/dNSBeSKE
 NiSnrr1XniA6Br+U7DKuunkwc79ACIdTb1Oeo40hutE9B/4PgqBD+bQehsAXak6oEEOJ VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chyvxhyah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 02:49:29 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AP2eoCD028314;
        Thu, 25 Nov 2021 02:49:28 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chyvxhy9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 02:49:28 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AP2mWXf002901;
        Thu, 25 Nov 2021 02:49:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3cerna4xc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 02:49:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP2nNT827787596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 02:49:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 721FBA4057;
        Thu, 25 Nov 2021 02:49:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19546A4051;
        Thu, 25 Nov 2021 02:49:20 +0000 (GMT)
Received: from sig-9-65-94-172.ibm.com (unknown [9.65.94.172])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 02:49:19 +0000 (GMT)
Message-ID: <15a001964945969dd7fc2422f0ab1eecfa299211.camel@linux.ibm.com>
Subject: Re: [PATCH v8 03/17] integrity: Introduce a Linux keyring called
 machine
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
Date:   Wed, 24 Nov 2021 21:49:19 -0500
In-Reply-To: <20211124044124.998170-4-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V_3CuNHUmU9v5qMjEBj-uA1CplgcJnAB
X-Proofpoint-GUID: AohbSyEKSs0hFWJeNBr125MSw3tVV2TW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250011
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> +config INTEGRITY_MACHINE_KEYRING
> +       bool "Provide a keyring to which CA Machine Owner Keys may be added"
> +       depends on SECONDARY_TRUSTED_KEYRING
> +       depends on INTEGRITY_ASYMMETRIC_KEYS

Shouldn't this be "ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y"?   With this
change, is  "KEYS: Create static version of
public_key_verify_signature" trusted needed?

Mimi

> +       depends on SYSTEM_BLACKLIST_KEYRING
> +       depends on LOAD_UEFI_KEYS
> +       help
> +        If set, provide a keyring to which CA Machine Owner Keys (MOK) may
> +        be added. This keyring shall contain just CA MOK keys.  Unlike keys
> +        in the platform keyring, keys contained in the .machine keyring will
> +        be trusted within the kernel.
> +


