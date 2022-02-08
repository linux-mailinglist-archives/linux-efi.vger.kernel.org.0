Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29C14ADC94
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiBHP0w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiBHP0v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 10:26:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D900C061576;
        Tue,  8 Feb 2022 07:26:51 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218FFDsa022286;
        Tue, 8 Feb 2022 15:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DeLDo9Re16ajpsw4sNAcqICogJBryuA+YZ39ylPMRn0=;
 b=VvjICS5ticvsYnz9yVG/BOMIHCYAl1tmOUv8uakWXcjPFUpfEnlARkzFYKS5lXr//KEL
 Za3XMflitZJQfhGAIs/g0VmAYd8+rgU8OxsV+QRJWtlATthYmxK5lxWYbfaZFYLaNmTm
 0kqm3+tDLmBqP0uaXagDwzIz9NMOOI7CzNIPbtBd+8Uv4k+Jx/fl0UBBRW3lcRauvwk/
 NnXUFXzW3aPDNmKp2Iq22WGC7NJ1WYhwUaN8+lVeOQ2dvx79vyDX2e9Ja6hhjDo1SYvL
 LcjUsDKM+R9b2HdFOd28vpla7X5GWzygW+a0IQ4YotTbS9stgi4q25H6NrB3yWlMpEYb Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3fm4y2xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:26:26 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218FFDjU022318;
        Tue, 8 Feb 2022 15:26:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3fm4y2wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:26:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218FIwtP012832;
        Tue, 8 Feb 2022 15:26:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv976n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:26:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218FQLC446399848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 15:26:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 525D74204B;
        Tue,  8 Feb 2022 15:26:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE35442042;
        Tue,  8 Feb 2022 15:26:18 +0000 (GMT)
Received: from sig-9-65-88-92.ibm.com (unknown [9.65.88.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 15:26:18 +0000 (GMT)
Message-ID: <00a106d904e6e495293af78cad78a353987da438.camel@linux.ibm.com>
Subject: Re: MAINTAINERS update suggestion (subject change)
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
Date:   Tue, 08 Feb 2022 10:26:18 -0500
In-Reply-To: <YgI32LAFgGSW6ugh@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
         <YfFP6OHqBVNWKL2C@iki.fi> <YfFTf6vIpNMIrwH0@iki.fi>
         <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
         <YgI32LAFgGSW6ugh@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: avYcCmWJ9SVCG6WQIpXEyRzC05jER9Eo
X-Proofpoint-GUID: qGU9TewXdQhykhXGaqWmyXgGhhpfn5GL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(Updated subject line)

On Tue, 2022-02-08 at 10:28 +0100, Jarkko Sakkinen wrote:
> On Wed, Jan 26, 2022 at 05:06:09PM -0500, Mimi Zohar wrote:

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
> 
> WFM. BTW, the patches are now in my tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> 
> I can add any tags requested. I'll mirror this at some point to linux-next.

Thanks,  Jarkko.

-- 
Mimi

