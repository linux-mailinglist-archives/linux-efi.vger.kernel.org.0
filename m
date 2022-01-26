Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CCB49D4DC
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiAZWGw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 17:06:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232435AbiAZWGv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 17:06:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QM5wDL009872;
        Wed, 26 Jan 2022 22:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gCtkiHzTbqSrH2u9etoNqX7uZpL/Whb949Lu+ka6atU=;
 b=QeOgzOtJTEYSH10K7VyCVT1r7qJ0X0moELU4y5QcYjIzTZxaxa4yFD+pfxbHBRqhMvn7
 VSBNFpjq3bmLIyIIXV0YsBtdHb7Q1pj6xHxefF4aDAyINbDweduB57jZwh91SHWpbf/U
 FKviAGkgbdCGQ35e301xd02met3CTx4pFw08zB8DK10tpOH4CQl9IPTcGozuBQsL7nY6
 JD/uOtc/JSeRxCPR57lOvjy+rouWlmbGAdE5bjh4K+8CxARBaq7iAHgVzpslCiVETfw7
 f+Wkrbq1ZWIs2Ljc0xIyhAX0MckEaS97BnaDscYURQfds9pBybvbKK/rI7CwobMLMXhn hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3duc883t2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:06:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20QM6GHp011192;
        Wed, 26 Jan 2022 22:06:18 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3duc883t1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:06:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QM3qb4010794;
        Wed, 26 Jan 2022 22:06:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3dr9j9g9h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:06:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QM6Cx520709734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 22:06:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC6A1A404D;
        Wed, 26 Jan 2022 22:06:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7509FA4051;
        Wed, 26 Jan 2022 22:06:10 +0000 (GMT)
Received: from sig-9-65-92-33.ibm.com (unknown [9.65.92.33])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 22:06:10 +0000 (GMT)
Message-ID: <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Wed, 26 Jan 2022 17:06:09 -0500
In-Reply-To: <YfFTf6vIpNMIrwH0@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
         <YfFP6OHqBVNWKL2C@iki.fi> <YfFTf6vIpNMIrwH0@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: etmyN5YAXvGtQh0yQw-jIA-9NN3fVEju
X-Proofpoint-ORIG-GUID: lthRogrj7NlEDFdckfcoVisT7sVxmNnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260128
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jarkko,

> > Thank you. I'll pick these soon. Is there any objections?

No objections.
> 
> Mimi brought up that we need a MAINTAINERS update for this and also
> .platform.
> 
> We have these:
> 
> - KEYS/KEYRINGS
> - CERTIFICATE HANDLING
> 
> I would put them under KEYRINGS for now and would not consider further
> subdivision for the moment.

IMA has dependencies on the platform_certs/ and now on the new .machine
keyring.  Just adding "F: security/integrity/platform_certs/" to the
KEYS/KEYRINGS record, ignores that dependency.  The discussion wouldn't
even be on the linux-integrity mailing list.

Existing requirement:
- The keys on the .platform keyring are limited to verifying the kexec
image.

New requirements based on Eric Snowbergs' patch set:
- When IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled,
the MOK keys will not be loaded directly onto the .machine keyring or
indirectly onto the .secondary_trusted_keys keyring.

- Only when a new IMA Kconfig explicitly allows the keys on the
.machine keyrings, will the CA keys stored in MOK be loaded onto the
.machine keyring.

Unfortunately I don't think there is any choice, but to define a new
MAINTAINERS entry.  Perhaps something along the lines of:

KEYS/KEYRINGS_INTEGRITY
M:     Jarkko Sakkinen <jarkko@kernel.org>
M:     Mimi Zohar <zohar@linux.ibm.com>
L:      keyrings@vger.kernel.org
L:      linux-integrity@vger.kernel.org
F:      security/integrity/platform_certs

thanks,

Mimi

