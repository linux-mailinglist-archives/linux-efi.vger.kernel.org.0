Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F114BF78E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Feb 2022 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiBVMBC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Feb 2022 07:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiBVMA6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Feb 2022 07:00:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1D0156C6D;
        Tue, 22 Feb 2022 04:00:13 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MAaL07003288;
        Tue, 22 Feb 2022 11:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SiYwENJC/gIJ7Y94osoR/8mrrQzBm6PzKC5luPMTQtU=;
 b=sbLPJFNUP11Po5l+lDjRWeueOwaPj5XXk0zmu+1RVXwEx+fNDRhNZ/4h99j/4ExjceA7
 mxdZJY8Q6h4HBQJ6WTJPKgDVEXsgwFUMtNCRp7jqUBHlXz8wMJnlldzi1/4obJWz14Yr
 uim5DjEnNzu5BFC0lZzUDV2qBp+L2mtxO4sFisYD6i7Sx6SQG4/JIlK5CJKZLmsj9+e4
 b6cjcZ5YPv5jblAniFYrUhwvfEYvYRy0c1/nIIDnUmxgZ8QifT9t3Z3TepFgrijq5OwP
 BrW8TiK1vFmFOKEGoiMyRGnjujNo8LxbW1SLt9s9Uc2Nxi4i0qnWd17ltph1dqaG9X1T Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ecup9whh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:59:33 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MBvg1N026580;
        Tue, 22 Feb 2022 11:59:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ecup9whgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:59:32 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MBvNYx020871;
        Tue, 22 Feb 2022 11:59:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtj2ecr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:59:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MBxRg346268898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 11:59:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAD9352057;
        Tue, 22 Feb 2022 11:59:27 +0000 (GMT)
Received: from sig-9-65-81-84.ibm.com (unknown [9.65.81.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E16DA52050;
        Tue, 22 Feb 2022 11:59:25 +0000 (GMT)
Message-ID: <8e9e4bc3bbd831a606f264ec3f4dfcafdeebece6.camel@linux.ibm.com>
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Tue, 22 Feb 2022 06:59:25 -0500
In-Reply-To: <YhKP12KEmyqyS8rj@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
         <YfFP6OHqBVNWKL2C@iki.fi> <YfFTf6vIpNMIrwH0@iki.fi>
         <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
         <YhKP12KEmyqyS8rj@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dhqBLlaAdn5juSbAq-4pp0ftpGNi1tNp
X-Proofpoint-ORIG-GUID: pR5XcqCgSAzEp3fIyEqgY2CFfGEAR1Fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_02,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2022-02-20 at 20:00 +0100, Jarkko Sakkinen wrote:
> On Wed, Jan 26, 2022 at 05:06:09PM -0500, Mimi Zohar wrote:

> > > 
> > > Mimi brought up that we need a MAINTAINERS update for this and also
> > > .platform.
> > > 
> > > We have these:
> > > 
> > > - KEYS/KEYRINGS
> > > - CERTIFICATE HANDLING
> > > 
> > > I would put them under KEYRINGS for now and would not consider further
> > > subdivision for the moment.
> > 
> > IMA has dependencies on the platform_certs/ and now on the new .machine
> > keyring.  Just adding "F: security/integrity/platform_certs/" to the
> > KEYS/KEYRINGS record, ignores that dependency.  The discussion wouldn't
> > even be on the linux-integrity mailing list.
> > 
> > Existing requirement:
> > - The keys on the .platform keyring are limited to verifying the kexec
> > image.
> > 
> > New requirements based on Eric Snowbergs' patch set:
> > - When IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled,
> > the MOK keys will not be loaded directly onto the .machine keyring or
> > indirectly onto the .secondary_trusted_keys keyring.
> > 
> > - Only when a new IMA Kconfig explicitly allows the keys on the
> > .machine keyrings, will the CA keys stored in MOK be loaded onto the
> > .machine keyring.
> > 
> > Unfortunately I don't think there is any choice, but to define a new
> > MAINTAINERS entry.  Perhaps something along the lines of:
> > 
> > KEYS/KEYRINGS_INTEGRITY
> > M:     Jarkko Sakkinen <jarkko@kernel.org>
> > M:     Mimi Zohar <zohar@linux.ibm.com>
> > L:      keyrings@vger.kernel.org
> > L:      linux-integrity@vger.kernel.org
> > F:      security/integrity/platform_certs
> > 
> 
> This would work for me.

Thanks, Jarkko.  Are you planning on upstreaming this change, as you
previously said, or would you prefer I do it?

thanks,

Mimi

