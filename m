Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438ACA774B
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2019 00:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfICWvY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Sep 2019 18:51:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727314AbfICWvY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Sep 2019 18:51:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83MkpiH011679
        for <linux-efi@vger.kernel.org>; Tue, 3 Sep 2019 18:51:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2usxudmd7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 03 Sep 2019 18:51:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Sep 2019 23:51:20 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 23:51:16 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83MpEso55705710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 22:51:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B797A405C;
        Tue,  3 Sep 2019 22:51:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43B53A405F;
        Tue,  3 Sep 2019 22:51:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.35])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 22:51:12 +0000 (GMT)
Subject: Re: [PATCH v3 3/4] x86/efi: move common keyring handler functions
 to new file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
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
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>
Date:   Tue, 03 Sep 2019 18:51:11 -0400
In-Reply-To: <87pnkisyiv.fsf@mpe.ellerman.id.au>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
         <1566825818-9731-4-git-send-email-nayna@linux.ibm.com>
         <87pnkisyiv.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090322-0028-0000-0000-000003974662
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090322-0029-0000-0000-0000245995A7
Message-Id: <1567551071.4937.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030228
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(Cc'ing Josh Boyer, David Howells)

On Mon, 2019-09-02 at 21:55 +1000, Michael Ellerman wrote:
> Nayna Jain <nayna@linux.ibm.com> writes:
> 
> > The handlers to add the keys to the .platform keyring and blacklisted
> > hashes to the .blacklist keyring is common for both the uefi and powerpc
> > mechanisms of loading the keys/hashes from the firmware.
> >
> > This patch moves the common code from load_uefi.c to keyring_handler.c
> >
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

> > ---
> >  security/integrity/Makefile                   |  3 +-
> >  .../platform_certs/keyring_handler.c          | 80 +++++++++++++++++++
> >  .../platform_certs/keyring_handler.h          | 32 ++++++++
> >  security/integrity/platform_certs/load_uefi.c | 67 +---------------
> >  4 files changed, 115 insertions(+), 67 deletions(-)
> >  create mode 100644 security/integrity/platform_certs/keyring_handler.c
> >  create mode 100644 security/integrity/platform_certs/keyring_handler.h
> 
> This has no acks from security folks, though I'm not really clear on who
> maintains those files.

I upstreamed David's, Josh's, and Nayna's patches, so that's probably
me.

> Do I take it because it's mostly just code movement people are OK with
> it going in via the powerpc tree?

Yes, the only reason for splitting load_uefi.c is for powerpc.  These
patches should be upstreamed together.  

Mimi

