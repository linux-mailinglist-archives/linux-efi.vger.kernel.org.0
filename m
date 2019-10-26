Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF3E600B
	for <lists+linux-efi@lfdr.de>; Sun, 27 Oct 2019 01:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfJZXwS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Oct 2019 19:52:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbfJZXwS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Oct 2019 19:52:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9QNqGbN103290
        for <linux-efi@vger.kernel.org>; Sat, 26 Oct 2019 19:52:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vvg9pv7er-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 26 Oct 2019 19:52:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 27 Oct 2019 00:52:13 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Oct 2019 00:52:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9QNpXdj32964864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 23:51:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD47CA404D;
        Sat, 26 Oct 2019 23:52:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C60FA4040;
        Sat, 26 Oct 2019 23:52:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.187.251])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 26 Oct 2019 23:52:04 +0000 (GMT)
Subject: Re: [PATCH v9 2/8] powerpc/ima: add support to initialize ima
 policy rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Date:   Sat, 26 Oct 2019 19:52:03 -0400
In-Reply-To: <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
         <20191024034717.70552-3-nayna@linux.ibm.com>
         <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com>
         <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102623-0016-0000-0000-000002BDEF8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102623-0017-0000-0000-0000331F3CD7
Message-Id: <1572133923.4532.79.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910260247
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2019-10-25 at 12:02 -0500, Nayna Jain wrote:
> On 10/24/19 12:35 PM, Lakshmi Ramasubramanian wrote:
> > On 10/23/2019 8:47 PM, Nayna Jain wrote:
> >
> >> +/*
> >> + * The "secure_rules" are enabled only on "secureboot" enabled systems.
> >> + * These rules verify the file signatures against known good values.
> >> + * The "appraise_type=imasig|modsig" option allows the known good 
> >> signature
> >> + * to be stored as an xattr or as an appended signature.
> >> + *
> >> + * To avoid duplicate signature verification as much as possible, 
> >> the IMA
> >> + * policy rule for module appraisal is added only if 
> >> CONFIG_MODULE_SIG_FORCE
> >> + * is not enabled.
> >> + */
> >> +static const char *const secure_rules[] = {
> >> +    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
> >> +#ifndef CONFIG_MODULE_SIG_FORCE
> >> +    "appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> >> +#endif
> >> +    NULL
> >> +};
> >
> > Is there any way to not use conditional compilation in the above array 
> > definition? Maybe define different functions to get "secure_rules" for 
> > when CONFIG_MODULE_SIG_FORCE is defined and when it is not defined.
> 
> How will you decide which function to be called ?

You could call "is_module_sig_enforced()".

Mimi

