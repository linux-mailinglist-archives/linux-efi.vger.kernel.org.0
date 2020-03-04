Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5124F17907C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 13:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbgCDMfU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 07:35:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729397AbgCDMfU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 07:35:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024CUIw3115447
        for <linux-efi@vger.kernel.org>; Wed, 4 Mar 2020 07:35:19 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhhy6m38j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 07:35:19 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 4 Mar 2020 12:35:17 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 12:35:13 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024CZBJP38928546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 12:35:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8565711C052;
        Wed,  4 Mar 2020 12:35:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C57811C054;
        Wed,  4 Mar 2020 12:35:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.200.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 12:35:10 +0000 (GMT)
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific
 policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 07:35:09 -0500
In-Reply-To: <1583307813.3907.4.camel@HansenPartnership.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
         <1583307813.3907.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030412-0016-0000-0000-000002ED176D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030412-0017-0000-0000-0000335064A5
Message-Id: <1583325309.6264.23.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_03:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=976 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040096
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2020-03-03 at 23:43 -0800, James Bottomley wrote:
> On Tue, 2020-03-03 at 21:33 -0500, Nayna Jain wrote:

> > diff --git a/security/integrity/ima/Kconfig
> > b/security/integrity/ima/Kconfig
> > index 3f3ee4e2eb0d..d17972aa413a 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> >  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> >  	depends on SYSTEM_TRUSTED_KEYRING
> >  	default y
> > +
> > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > +	bool
> > +	depends on IMA
> > +	depends on IMA_ARCH_POLICY
> > +	default n
> 
> You can't do this: a symbol designed to be selected can't depend on
> other symbols because Kconfig doesn't see the dependencies during
> select.  We even have a doc for this now:
> 
> Documentation/kbuild/Kconfig.select-break

The document is discussing a circular dependency, where C selects B.
 IMA_SECURE_AND_OR_TRUSTED_BOOT is not selecting anything, but is
being selected.  All of the Kconfig's are now dependent on
IMA_ARCH_POLICY being enabled before selecting
IMA_SECURE_AND_OR_TRUSTED_BOOT.

As Ard pointed out, both IMA and IMA_ARCH_POLICY are not needed, as
IMA_ARCH_POLICY is already dependent on IMA.

Mimi

