Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB24547D8
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 14:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhKQN5g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 08:57:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhKQN5f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 08:57:35 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHDh9Ob036821;
        Wed, 17 Nov 2021 13:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MbdbUAhohobNQmB/n9zvUgpKF+v4RomjHCWKlDZmeM4=;
 b=Xh1oVeHmYYYGi+iSasfbGvvjP+d9mshQnavLEciyxCea1HbzOiXmBPinpl1CXbk7p1j0
 NScOYhXwySPCDj/s+zAG9l1qnpXjnCEX0rWXWpbxT9aIrt+GOQgaV2smc6UsjoeOHxAw
 Cbx0dziZdpM3L9nOtmVFwDvfaN9zXEXU2XUYxoeucJbMD7vtKfQzDP7XDE7Qu7v6yKbP
 lFRAEMnAxNowtrbtOeurm4YCrzGR3BYc7S7uibqRNqI/hIh0x12CARMMrqD8NeNntqV4
 ElPlt02SxqAXNBRCG6PqoaaQFhGrmcO+imIRWapqZ+SMHYZsZ2z234liVgPWRNAv6yzA xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd2var54e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:53:45 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHDjEW8005125;
        Wed, 17 Nov 2021 13:53:45 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd2var53u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:53:44 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHDnE9Z025036;
        Wed, 17 Nov 2021 13:53:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3ca50a11y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:53:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHDrdBU4129456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 13:53:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59200A4060;
        Wed, 17 Nov 2021 13:53:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0006A405F;
        Wed, 17 Nov 2021 13:53:36 +0000 (GMT)
Received: from sig-9-65-64-222.ibm.com (unknown [9.65.64.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 13:53:36 +0000 (GMT)
Message-ID: <76c2c8bf1717e51c2d859994bf3cf1e89c21f80d.camel@linux.ibm.com>
Subject: Re: [PATCH v7 03/17] KEYS: Create static version of
 public_key_verify_signature
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
Date:   Wed, 17 Nov 2021 08:53:36 -0500
In-Reply-To: <b9cdbbe6004eac0a7b2881bf6cf03f29f07dcf79.camel@linux.ibm.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-4-eric.snowberg@oracle.com>
         <b9cdbbe6004eac0a7b2881bf6cf03f29f07dcf79.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: adctxB_MjUBIvqM9cPO6YsQ7jsJRxfu-
X-Proofpoint-GUID: jYHMc8QSePx889VnPOilFRxPKlEIrpK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_04,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170069
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2021-11-17 at 08:32 -0500, Mimi Zohar wrote:
> On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> > The kernel test robot reports undefined reference to
> > public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
> > not defined. Create a static version in this case and return -EINVAL.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> 
> Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

Perhaps this patch wouldn't be needed if 

+config INTEGRITY_MACHINE_KEYRING
+       bool "Provide a keyring to which CA Machine Owner Keys may be
added"
+       depends on SECONDARY_TRUSTED_KEYRING
+       depends on INTEGRITY_ASYMMETRIC_KEYS

depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y

+       depends on SYSTEM_BLACKLIST_KEYRING
+       depends on LOAD_UEFI_KEYS

Mimi

